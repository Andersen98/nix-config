# opt

Command-line --option parsing for Go

- long and short options: --help -h --number=7 -n 7 -n7
- long options can be abbreviated: --version --ver
- short options can be combined: -rf
- positional arguments can be interspersed: -a file file2 -b
- double dash forces positional arguments: --option -- --not --options

```
package main

import (
	"errors"
	"fmt"
	"git.sr.ht/~geb/opt"
	"os"
)

type Butty struct {
	Bread string
	Bacon, Egg bool
}

func main() {
	butty := Butty{"brown", true, false}
	o := opt.NewOptionSet()

	o.BoolFunc("bacon", func(b bool) error { butty.Bacon = b; return nil })

	o.Func("bread", func(s string) error {
		if s != "brown" && s != "white" {
			return errors.New("unknown bread type: " + s)
		}
		butty.Bread = s
		return nil
	})

	o.BoolFunc("egg", func(b bool) error { butty.Egg = b; return nil })
	o.Alias("egg", "e")

	o.FlagFunc("help", func() error {
		fmt.Println("Command to make butties.")
		os.Exit(0)
		panic("unreachable")
	})
	o.Alias("help", "h")

	err := o.Parse(true, os.Args[1:])

	fmt.Println(err)
	fmt.Println(butty)
	fmt.Println(o.Args())
	fmt.Println(o.Leftovers())
}
```

## Contact

You can ask a question or send a patch by composing an email to
[~geb/public-inbox@lists.sr.ht](https://lists.sr.ht/~geb/public-inbox).

## License

GPLv3 only, see [LICENSE](./LICENSE).

Copyright (c) 2022 John Gebbie
