#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Pretty much everyone is familiar with autoscrolling as a concept. All you have to do is place
// one of these objects with the correct creation code in your section, and it'll scroll however you want.

event_inherited();

canHit = false;

grav = 0;
blockCollision = 0;
bubbleTimer = -1;

respawnRange = -1;
despawnRange = -1;

timer = 0;
phase = 1;
counter = 0;

sL = 0;
sR = 0;
sT = 0;
sB = 0;

// Customizeable variables

//@cc the direction of the autoscroll. "h" will make it go horizontally, "v" will make it go vertically. Default horizontal.
dir = "h";

//@cc the speed of the autoscroll, in pixels per frame. negative = left or up, positive = right or down
mySpeed = 0.5;

//@cc the amount of frames to wait in between entering the autoscroll section and the scrolling actually starting.
waitFrames = 64;

//@cc if set to true, the camera will be unlocked when it's done autoscrolling
unlockBounds = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    switch (phase)
    {
        case 1: // Start
            if (instance_exists(objMegaman) && insideSection(x, y))
            {
                with (objMegaman)
                {
                    if (!playerIsLocked(PL_LOCK_MOVE) && !teleporting && !showReady)
                    {
                        // take camera away from player >:c
                        viewPlayer = 0;

                        // increment phase + grab current section bounds
                        with (other)
                        {
                            phase += 1;

                            if (dir == "h")
                            {
                                sL = global.sectionLeft;
                                sR = global.sectionRight;
                                global.sectionLeft = view_xview;
                                global.sectionRight = view_xview + view_wview;
                            }
                            else if (dir == "v")
                            {
                                sT = global.sectionTop;
                                sB = global.sectionBottom;

                                global.sectionTop = view_yview;
                                global.sectionBottom = view_yview + view_hview;
                            }
                        }
                    }
                }
            }
            break;
        case 2: // wait
            timer += 1;
            if (timer >= waitFrames)
            {
                phase += 1;
                timer = 0;
            }
            break;
        case 3: // Move
        // stop moving if it's reached the end of the section
            if ((dir == "h" && ((global.sectionLeft <= sL && mySpeed < 0) || (global.sectionRight >= sR && mySpeed > 0)))
                || (dir == "v" && ((global.sectionTop <= sT && mySpeed < 0) || (global.sectionBottom >= sB && mySpeed > 0))))
            {
                phase += 1;
            } // otherwise, Alexa, change section bounds
            else
            {
                if (dir == "h")
                {
                    global.sectionLeft += mySpeed;
                    global.sectionRight += mySpeed;
                }
                else if (dir == "v")
                {
                    global.sectionTop += mySpeed;
                    global.sectionBottom += mySpeed;
                }
            }
            break;
        case 4: // unlock bounds once finished, if set to true
            if unlockBounds
            {
                if (dir == "h")
                {
                    global.sectionLeft = sL;
                    global.sectionRight = sR;
                }
                else if (dir == "v")
                {
                    global.sectionTop = sT;
                    global.sectionBottom = sB;
                }

                // give camera back to mega man
                if (instance_exists(objMegaman))
                {
                    with (objMegaman)
                    {
                        viewPlayer = 1;
                    }
                }
            }
            break;
    }
}
else if (dead)
{
    phase = 1;
    timer = 0;
    counter = 0;
    sL = 0;
    sR = 0;
    sT = 0;
    sB = 0;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// sorry nothing
