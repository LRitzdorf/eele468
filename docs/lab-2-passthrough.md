# Lab 2: Implementing an Audio Passthrough System

In my case, some extra configuration (in addition to the Platform Designer-based steps outlined in the course textbook) was necessary to produce a functioning passthrough system.

- The provided design constraints (`.sdc` file) were such that even a functional system would report timing violations.
  This was resolved by removing the offending (and unnecessary) timing constraints.
- My SoC system from the previous semester utilized a different HPS configuration (particularly with regard to IO pinmuxing settings).
  This required my custom U-Boot preloader to be recompiled.
- During initial testing, my Audio Mini board produced no signals on certain important pins, including MCLK, the output bit clock, and the output left/right clock.
  This eventually resolved itself after several power cycles, for reasons that remain unclear.
- Sometime over the last semester, a function used by the provided AD1939 driver was removed from the Linux kernel.
  This resulted in a compilation error from that driver, requiring investigation by myself and a code rewrite by Trevor Vannoy to properly integrate with the device tree.

Of these, I found the driver bug to be rather interesting, especially since the following investigation allowed me to learn more about interoperation between the Linux kernel and device trees.
On the other hand, my system's apparent hardware malfunction is somewhat worrying, mostly due to its having disappeared without any clear reason for a) doing so, or b) existing in the first place.
