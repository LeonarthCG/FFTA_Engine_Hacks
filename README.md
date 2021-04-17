# FFTA_Engine_Hacks

This is a repository for all my Final Fantasy Tactics Advance engine hacks.
All of them are handled through Event Assembler.
I try to make everything as modular as possible, specific features can be turned on and off or customized.
The source for all of the ASM is included (and precompiled, too).

# Latest Changes

* Fixed items not giving the proper abilities when using 1bit abilities.
* Fixed support, reaction and combo/movement ability lists.
	* It will now properly display abilities, if they are mastered, if they are usable and their current AP and cost, if aplicable.
	* It also checks for the end of the race's ability list so it shouldn't display abilities that don't belong.
		* If you make a new ability list, please be sure to end it with 00 00 00 00 00 00 00 00 like vanilla does.
	* It will only show abilities from jobs the unit can change into, or that it at least knows one ability for.
* Added a default case for animations, if no animation is found the standing animation will be played.
	* This doesn't work for the new weapon and ability animations, it's meant for story animations.
* Fixed issues with the new item ability window when scrolling through items.
* Fixed the game going into an infinite loop when trying to check the unused jobs.
	* This might affect existing saves, if you see a unit's class being "-" try changing classes, then changing back into the one you want, that should fix it.
	* This should not happen with new saves, if it does, or it happens on a unit that's not on your clan, please let me know.
* Added a new option, genericSaveLevel, when defined the file level will be based on the first unit's level instead of Marche's. Default off.
* Actually removed ability learnt messages after missions. Maybe.

# Build Instructions

1) Download the project folder
2) Download [Event Assembler](http://feuniverse.us/t/event-assembler/1749), which includes the EA Formatting Suite, and extract it in the "Event Assembler" directory.
3) Download [ColorzCore](https://github.com/FireEmblemUniverse/ColorzCore/blob/master/ColorzCore/bin/Release/ColorzCore.exe), rename it to "Core.exe" and use it to replace the "Core.exe" in the "Event Assembler" folder.
4) Optionally, get [ups] (https://github.com/rameshvarun/ups/releases) and extract the "ups" folder to the root directory.
5) Place your US FFTA clean ROM in the root directory, it must be named "FFTA_clean.gba".
6) Modify "ROM Buildfile.event" to customize, enable or disable features as you wish.
	* If you are not using a clean ROM you will likely want to change the FreeSpace definition.
	* If you want to customize the features further, look for their respective installer in "Engine Hacks"
7) Run MAKE_HACK.cmd, which will run EA to generate "FFTA_hack.gba" using "ROM Buildfile.event"

# Feature Summmary

* JP ability purchase system.
* Final Fantasy Tactics-style unit death.
* Ironman mode (all maps act like Jagds in regards to unit death).
* Stealable shoes.
* Movement abilities.
* Movement confirmation.
* No stat variance (deterministic level-ups).
* Quick start (tutorial skip).
* Judge and law removal.
* Morphing Morphers morph (Morphs will change aspect when morphing).
* Manual unit sorting.
* Job and race customization, this is not optional as it's required for everything to work properly.
	* Unhardcoding of a bunch of stuff, from job abilities to which races can change jobs.
	* Includes the missing animations for the original playable jobs.
	* An animation template that allows for new animations to be inserted.
	* And many other new options for customizing the data.
* Many other options.
