#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;

healthpointsStart = 99;
healthpoints = healthpointsStart;
contactDamage = 5;
blockCollision = false;
canHit = false;

grav = 0;

// Enemy specific code
xsp = 0;
ysp = 0;

actionTimer = 0;
shotsFired = 0;
canBounce = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    actionTimer += 1;
    image_index = floor(actionTimer / 5);

    if (actionTimer == 29)
    {
        if (xspeed == 0)
        {
            yspeed = choose(0, 1.5, 0.75);
            if (yspeed == 0)
            {
                xspeed = 3 * image_xscale;
            }
            else if (yspeed == 0.5)
            {
                xspeed = 2.25 * image_xscale;
            }
            else
            {
                xspeed = 1.5 * image_xscale;
            }
        }
        actionTimer = 15;
    }

    if (!place_meeting(x, y, objGiantMetCannon) && shotsFired < 4)
    {
        canBounce = true;
        blockCollision = true;
    }

    if (shotsFired >= 4)
    {
        blockCollision = false;
    }

    if (canBounce && xcoll != 0 && shotsFired < 4)
    {
        if (yspeed != 0)
        {
            xspeed = -xcoll;
        }
        else
        {
            yspeed = 1.5;
            xspeed = -1.5 * image_xscale;
        }
        shotsFired++;
    }
    if (canBounce && ycoll != 0 && shotsFired < 4)
    {
        if (xspeed != 0)
        {
            yspeed = -ycoll;
        }
        else
        {
            yspeed = -1.5;
            xspeed = -1.5 * image_xscale;
        }
        shotsFired++;
    }
}
