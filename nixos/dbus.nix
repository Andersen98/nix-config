{lib,...}:
{
  services.dbus.implementation = lib.mkForce "broker";
}
