A Collection of connectors for 2020 Aluminum Extrusions.

This library tries to offer every kind of bracket, joint or endcap you might
need when working with aluminum extrusions.

It does not currently cover fancy things like fastening smooth rods to
extrusions, but basic t joints and various kinds of corner brackets are
available.

If you have some kind of need that this library does not supply but probably
should, I would love a PR or feature request.  Feel free to open an issue and
if you can create a PR!  I would be happy to have some collaboration.


How to use this library:
===

1. clone this repo into your openscad library path
   [OpenScad Wiki explains the library path](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries)
1. Import the relevant code and use it:
    use <2020_connectors/corner_bracket.scad>
    corner_bracket(1, 0, 1);
