#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// An enemy that rolls around and jumps at the player when they approach.
// Use objJumpRollerFlameField to let it shoot fire from its head when it touches it.

// Creation code (all optional):
// col = <number>. Color of the enemy. 0 = blue (default); 1 = orange; 2 = green

event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 2;
category = "fire";

facePlayerOnSpawn = true;

// Enemy specific code
image_speed = 0;

animTimer = 0;
wheelTimer = 0;

imgOffset = 0;
wheelVal = 0;

flameTimer = 20;
jumpCooldown = -1;

col = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    xSpeedTurnaround();

    // bounce up and down
    if (ground && jumpCooldown < 45)
    {
        animTimer+=1;
        wheelTimer+=1;

        // hey hey hey what a perfect place to put the fire code
        if (place_meeting(x, y, objJumpRollerFlameField))
        {
            flameTimer+=1;

            if (flameTimer == 30 || flameTimer == 40)
            {
                playSFX(sfxJumpRollerFlame);
                instance_create(x, y - 4, objJumpRollerFlame);

                if (flameTimer == 40)
                {
                    flameTimer = 0;
                }
            }
        }
    }

    // Weird code since the enemy hangs on these frames for slightly longer
    if (animTimer == 8 + ((imgOffset == 1 || imgOffset == 3) * 4))
    {
        imgOffset+=1;

        if (imgOffset > 3)
        {
            imgOffset = 0;
        }

        animTimer = 0; // reset
    }

    // Wheel rolling
    if (wheelTimer == 4)
    {
        wheelVal = !wheelVal;
        wheelTimer = 0;
    }

    // Jump when target is near
    if (instance_exists(target) && jumpCooldown == -1 && ground) // prerequisites
    {
        // actual check
        if (collision_rectangle(x - 32, view_yview, x + 32, view_yview + view_hview, target, false, true))
        {
            xspeed = 1.2 * image_xscale; // slow down buckaroo!
            yspeed = -4.75;
            ground = false;
            jumpCooldown = 100; // yea

            // set jump frame
            imgOffset = 8;
        }
    }

    // air handling
    if (!ground)
    {
        // reset stuff
        wheelVal = 0;

        animTimer = 0;
        wheelTimer = 0;

        flameTimer = 0;

        if (yspeed >= 0 && imgOffset == 8)
        {
            imgOffset = 9;
        }
    }

    // landing
    if (ground && imgOffset == 9)
    {
        jumpCooldown = 25; // hold it
        imgOffset = 1;
        xspeed = 0;
    }

    // handle jump cooldown
    if (jumpCooldown > -1)
    {
        jumpCooldown-=1;

        if (jumpCooldown == 10)
        {
            calibrateDirection();
            xspeed = 1.5 * image_xscale;
            imgOffset = 2;
        }
    }
}

image_index = (imgOffset + (wheelVal * 4)) + (col * 10);
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

animTimer = 0;
wheelTimer = 0;

imgOffset = 0;
wheelVal = 0;

flameTimer = 20;

xspeed = 1.5 * image_xscale;
jumpCooldown = -1;
