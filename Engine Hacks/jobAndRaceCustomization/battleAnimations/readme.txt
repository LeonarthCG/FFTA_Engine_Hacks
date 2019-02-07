Using the template is, I think, pretty simple, and can be broken down into 4 steps:
First I recommend that you copy "template.event" and "template.png" into a folder.
Name this folder something you can recognize, or the ID you want to insert the animation into.

You might notice some of the sprites are repeated, that is intentional.
Sometimes it's the same pose but with a shadow.
However, sometimes it is the exact same pose.
This is because water animations use two versions of the same pose for stills, to make the effect of flowing water.

If you want to make a water animation be sure to use "watertemplate.png".
Water battle animations are separate from the regular ones, nothing ties them together.
In order to specify a job's water animation change the second "Unknown Values" under "Sprites/Unknown" in AIO.

Step 1 - Making the graphics -
Edit "template.png" or "watertemplate.png"
This file contains all spriters required. Please use a tool that can work with indexed graphics.
Once you have your graphics complete make sure to save them as 4bpp!

Step 2 - Shifting -
Drag your "template.png" (or "watertemplate.png") on top of "shifter.exe".
If everything goes well, a file named "template.bin" will be produced.
Place this file on the same location as your "template.event".
If the program crashes at this point it's highly likely that your image has been saved as 8bpp instead of 4bpp.

Step 3 - Setting up the template -
Open "template.event".
Find the line that says the following:
#define TEMPLATEID x //switch x for your desired battle animation ID value!
Switch x for your desired battle animation ID value.

Step 4 - Including -
Include your "template.event" into the buildfile.
I recommend you do so in "battleAnimationsInstaller.event".
To include something simply let EA know the relative path to it, for example:
#include "0x2B/template.event"

And that's it!
