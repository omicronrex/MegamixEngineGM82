#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// When on screen, it slowly flies ahead while lifting Mega Man off the ground. Hitting it
// stuns it, and it drops Mega Man until he hits the ground again.

event_inherited();

healthpointsStart = 8;
healthpoints = healthpointsStart;
contactDamage = 2;

category = "flying";

facePlayerOnSpawn = true;

// Enemy Specific code
phase = 0;
grav = 0;
imgSpd = 0.16;
moveTimer = 10; // Do not colide with solids
canMove = true; // Delay anti-grav countdown

blockCollision = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    switch (phase)
    {
        case 0:
            if (instance_exists(target))
            {
                if (target.ground == true)
                {
                    canMove = true;
                }
            }
            if (canMove == true)
            {
                moveTimer--;
            }
            if (moveTimer == 0)
            {
                phase = 1;
                canMove = false;

                // reset speed
                if (instance_exists(target))
                {
                    if (!target.ground)
                    {
                        target.yspeed = -(target.grav) * 2;
                    }
                }
            }
            break;
        case 1:
            xspeed = 0.5 * image_xscale;
            image_index += imgSpd;
            if (image_index >= 5)
            {
                image_index = 1;
            }

            // Anti-Gravity
            if (instance_exists(target))
            {
                with (target)
                {
                    yspeed -= 0.25;
                }

                if ((sign(target.ycoll) == -1) || (target.y <= view_yview[0] + 4))
                {
                    with (target)
                    {
                        yspeed += grav;
                    }
                    xspeed = 0;
                    phase = 0;
                    image_index = 0;
                    moveTimer = 10;
                }
            }
            break;
    }
}
else if (dead)
{
    phase = 0;
    xspeed = 0;
    image_index = 0;
    healthpoints = healthpointsStart;
    moveTimer = 10;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

with (target)
{
    yspeed += grav;
}
xspeed = 0;
phase = 0;
image_index = 0;
moveTimer = 10;
