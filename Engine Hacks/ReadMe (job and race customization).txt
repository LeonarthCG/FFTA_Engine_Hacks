First of all you are going to want to get Event Assembler:
https://github.com/FireEmblemUniverse/Event-Assembler

Hacking with EA is a bit different from traditional methods.
Instead of editing the ROM directly the idea is to keep all changes external, with just the files and a clean ROM the hack can be recreated.
This allows changes to be completely undone and version control through means like GitHub.
"Redone from scratch" is just not a thing with EA.
We call hacks that are done with this method "buildfiles".

That said, although not recommended, you can still just apply an EA project to your ROM and keep editing it the old-fashioned way.
If you do that I would recommend that you add message (MESSAGE yourtext currentoffset) lines so that EA can tell you where tables and similar where installed to.

Event Assembler can use definitions and labels, it manages your space for you, you never need to know where something has been inserted to.
It can automatically repoint, it can insert graphics and it can replace tools, or even call external tools.
For these reasons, even though EA was a tool designed for Fire Emblem hacking, I use EA for all my GBA projects, and even for projects for other platforms.
I even made a homebrew game with EA: https://github.com/LeonarthCG/Snek-GBA

This tutorial will be helpful to you if you want to learn about EA, even if it focuses on Fire Emblem hacking:
https://tutorial.feuniverse.us/
I specially recommend reading the Buildfile Basics section.

EA is a simple thing too, it doesn't have that many parts to it so if you learn them bit by bit it should be fine for anybody to use.

Anyway, in short, EA can:
Manage space for you.
Easily install packages, making for modular hacking.
Easily modify these packages, making for customization.
Call tools for you, making it able to hand different types of data.
"Undo" changes by just commenting them out, allowing for extremely helpful debugging.

Now, as for the features this hack has, they are listed in the thread.
Options can be found in options.txt ("comment out" means to make a line into a comment, use // for that).
The other file you should look for is data.txt and the xTable.event files.
Everything has comments and/or labels so it should be easy to mess with.
I know there's many things but most of them have explanations next to them, if there is any doubt please let me know.
