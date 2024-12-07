package opt

import (
	"errors"
	"strings"
)

type setter interface {
	Set(string) error
}

type funcSetter func(string) error

func (f funcSetter) Set(s string) error {
	return f(s)
}

type boolFuncSetter func(bool) error

func (f boolFuncSetter) Set(s string) error {
	for _, v := range []string{"1", "t", "true", "y", "yes", "on"} {
		if strings.EqualFold(s, v) {
			_ = f(true)
			return nil
		}
	}
	for _, v := range []string{"0", "f", "false", "n", "no", "off"} {
		if strings.EqualFold(s, v) {
			_ = f(false)
			return nil
		}
	}
	return errors.New("invalid boolean value: " + s)
}

type flagFuncSetter func() error

func (f flagFuncSetter) Set(s string) error {
	bf := func(b bool) error {
		if !b {
			return nil
		}
		return f()
	}
	return boolFuncSetter(bf).Set(s)
}


type option struct {
	Name   string
	Setter setter
}

type OptionSet struct {
	opts      []option
	args      []string // parsed positional arguments
	leftovers []string // remaining arguments after error
}

func NewOptionSet() *OptionSet { return &OptionSet{} }
func (o *OptionSet) Args() []string { return o.args }
func (o *OptionSet) Leftovers() []string { return o.leftovers }

func (o *OptionSet) lookup(name string, longOnly bool) (*option, bool) {
	var option *option
	for _, opt := range o.opts {
		opt := opt
		if longOnly && len([]rune(opt.Name)) < 2 {
			continue
		}
		if opt.Name == name {
			return &opt, false
		}
		if strings.HasPrefix(opt.Name, name) {
			if option != nil {
				return nil, true
			}
			option = &opt
		}
	}
	return option, false
}

func (o *OptionSet) add(name string, s setter) {
	if opt, _ := o.lookup(name, false); opt != nil {
		panic("option already defined: " + name)
	}
	o.opts = append(o.opts, option{name, s})
}

func (o *OptionSet) Func(name string, f func(string) error) {
	o.add(name, funcSetter(f))
}

func (o *OptionSet) BoolFunc(name string, f func(bool) error) {
	o.add(name, boolFuncSetter(f))
}

func (o *OptionSet) FlagFunc(name string, f func() error) {
	o.add(name, flagFuncSetter(f))
}

func (o *OptionSet) Alias(name string, aliases ...string) {
	opt, _ := o.lookup(name, false)
	if opt == nil {
		panic("option not defined: " + name)
	}
	for _, a := range aliases {
		o.opts = append(o.opts, option{a, opt.Setter})
	}
}

func (o *OptionSet) Parse(interspersed bool, arguments []string) error {
	for len(arguments) > 0 {
		a := arguments[0]

		switch {
		// Positional argument
		case a == "" || a == "-" || a[0] != '-':
			if interspersed {
				o.args = append(o.args, a)
				arguments = arguments[1:]
			} else {
				o.args = append(o.args, arguments...)
				arguments = nil
			}

		case a == "--":
			o.args = append(o.args, arguments[1:]...)
			arguments = nil

		// Long option
		case a[1] == '-':
			var err error
			opt, ambiguous := o.lookup(a[2:], true)
			if ambiguous {
				err = errors.New("ambiguous option abbreviation: " + a)
			} else if opt == nil {
				i := strings.Index(a, "=")
				if i == -1 {
					err = errors.New("unknown option: " + a)
				} else {
					opt, ambiguous = o.lookup(a[2:i], true)
					if ambiguous {
						err = errors.New("ambiguous option abbreviation: " + a[:i])
					} else if opt == nil {
						err = errors.New("unknown option: " + a[:i])
					} else {
						err = opt.Setter.Set(a[i+1:])
						arguments = arguments[1:]
					}
				}
			} else if f, ok := opt.Setter.(boolFuncSetter); ok {
				err = f(true)
				arguments = arguments[1:]
			} else if f, ok := opt.Setter.(flagFuncSetter); ok {
				err = f()
				arguments = arguments[1:]
			} else {
				f := opt.Setter.(funcSetter)
				if len(arguments) >= 2 {
					err = f(arguments[1])
					arguments = arguments[2:]
				} else {
					err = errors.New("option requires argument: " + a)
				}
			}
			if err != nil {
				o.leftovers = arguments
				return err
			}

		// Short option
		default:
			a = a[1:]
			var err error
			for i, r := range a {
				opt, _ := o.lookup(string(r), false)
				if opt == nil {
					o.leftovers = arguments
					return errors.New("unknown option: -" + string(r))
				}
				if f, ok := opt.Setter.(boolFuncSetter); ok {
					err = f(true)
					if err != nil {
						break
					}
				} else if f, ok := opt.Setter.(flagFuncSetter); ok {
					err = f()
					if err != nil {
						break
					}
				} else {
					f := opt.Setter.(funcSetter)
					if i+1 < len([]rune(a)) {
						err = f(string([]rune(a)[i+1:]))
						break
					} else {
						if len(arguments) < 2 {
							return errors.New("option requires argument: -" + string(r))
						}
						err = f(arguments[1])
						arguments = arguments[1:]
						break
					}
				}
			}
			arguments = arguments[1:]
			if err != nil {
				o.leftovers = arguments
				return err
			}
		}
	}

	return nil
}
