# Lab 3: Implementing a Comb Filter System

Interestingly, while much of the material for this particular lab was provided via course templates, a substantial portion thereof either required fixes, or was unnecessary.
As such, I'd like to offer a few suggestions for future semesters:
- Suggest that students check the HDL Coder [Supported Third-Party Tools](https://mathworks.com/help/hdlcoder/gs/language-and-tool-version-support.html) page before beginning their projects, as HDL Coder simply refuses to work with certain recent versions of Quartus.
  The relevant entry on that page is for "Intel® Quartus® Prime Standard," even though we use the Lite version.
- Consider not using the `ip/` directory — based on my interactions with other students, it's confusing and doesn't provide any real workflow benefit.
  Instead, it's clearer and cleaner to simply add VHDL files to a Quartus project by referencing them in their existing locations.
- Please ensure that files and other resources provided to students are properly functional.
  This project included two prime examples of this: the Simulink filter model itself, and the associated verification script.
  The former required additional configuration in order to synthesize without timing violations, and the latter simply does not function due to its use of a nonexistent MATLAB function.

As for actual project material, the core content was relatively straightforward.
Creating a custom hardware module, placing it on the lightweight Avalon bus, and implementing a corresponding driver is relatively common practice at this point, though the product being a usable audio system does make this more interesting.
