No Battery-Backed Real Time Clock
=================================

A script to save the current time during shutdown/reboot and then restore it
upon power-up.  This can be useful for machines which lack a battery-backed
real time clock, so that we still ensure time never goes backwards.

It is strongly advised that you also run an NTP client to set the correct time
once the network is up.

## Packaging

For Debian and derivatives:

```
dpkg-buildpackage -uc -us
```

Then find the built package one level up in the directory hierarchy.
