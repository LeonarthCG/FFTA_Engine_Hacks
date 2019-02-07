# FFTA_Engine_Hacks

This is a repository for all my Final Fantasy Tactics Advance engine hacks.
All of them are handled through Event Assembler.
I try to make everything as modular as possible, specific features can be turned on and off or customized.
The source for all of the ASM is included (and precompiled, too).

# Build Instructions

1) Download the project folder
2) Download [Event Assembler](http://feuniverse.us/t/event-assembler/1749), which includes the EA Formatting Suite, and extract it in the "Event Assembler" directory.
3) Optionally, get [ups] (https://github.com/rameshvarun/ups/releases) and extract the "ups" folder to the root directory.
4) Place your US FFTA clean ROM in the root directory, it must be named "FFTA_clean.gba".
5.1) Modify "ROM Buildfile.event" to customize, enable or disable features as you wish.
5.2) If you are not using a clean ROM you will likely want to change the FreeSpace definition.
5.3) If you want to customize the features further, look for their respective installer in "Engine Hacks"
6) Run MAKE_HACK.cmd, which will run EA to generate "FFTA_hack.gba" using "ROM Buildfile.event"

# Feature summmary

* JP ability purchase system
* Final Fantasy Tactics-style unit death
* Ironman mode (all maps act like Jagds in regards to unit death)
* Stealable shoes
* Movement abilities
* Movement confirmation
* No stat variance (deterministic level-ups)
* Quick start (tutorial skip)
* Judge and law removal
* Morphing Morphers morph (Morphs will change aspect when morphing)
* Manual unit sorting
* Job and race customization, this is not optional as it's required for everything to work properly
	* Includes the missing animations for the original playable jobs
	* An animation template that allows for new animations to be inserted
	* And many other new options for customizing the data
* Many other options
