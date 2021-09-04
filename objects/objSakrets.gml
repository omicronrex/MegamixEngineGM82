#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// creation code (all optional)
// col = <number> (0 = green; 1 = blue)

event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "cannons";

grav = 0;

// creation code
col = 0;
range = 64; // in pixels, how far it crawls away from starting point

// enemy specific code
phase = 0;
shootTimer = 0;

imgIndex = 0;
animTimer = 0;
image_speed = 0;

prevYspeed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // prevYspeed setting isnt tied to any phase
    if (yspeed != 0)
    {
        prevYspeed = yspeed;
    }

    // timer increment
    shootTimer+=1;

    // behavior
    switch (phase)
    {
        case 0: // set speed for moving on the wall
            if (yspeed == 0)
            {
                yspeed = 1;
            }

            // turn around
            if ((y < ystart) || (y > ystart + range))
            {
                yspeed = -yspeed;
            }

            // wall collision (they never hit a wall in MM9 i think so this is made up behavior)
            if (ycoll != 0)
            {
                yspeed = -ycoll;
            }

            // Animation
            animTimer+=1;
            if (animTimer == 4)
            {
                imgIndex = !imgIndex;
                animTimer = 0;
            }

            // Stop and shoot after 2 seconds
            if (shootTimer == 120)
            {
                phase = 1;
                yspeed = 0;
                animTimer = 0;
                shootTimer = 0;
            }
            break;
        case 1: // animation, shoot
            if (shootTimer == 1)
            {
                imgIndex += 2; // time to put on my angry eyes
                a = instance_create(x + 6 * image_xscale, y, objSakretsBall);
                a.xspeed = 4.5 * image_xscale;
            }
            if (shootTimer == 15)
            {
                imgIndex -= 2;
            }
            if (shootTimer == 40)
            {
                shootTimer = 0;
                yspeed = prevYspeed;
                phase = 0;
            }
            break;
    }
}
else if (dead)
{
    phase = 0;
    shootTimer = 0;

    animTimer = 0;
    imgIndex = 0;

    prevYspeed = 0;
}

image_index = imgIndex + (col * 4);
