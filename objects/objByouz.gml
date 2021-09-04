#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A springy boi that walks on ceilings and jumps up (down?) to stab Mega Man when above him.

event_inherited();

healthpointsStart = 4;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "grounded";

grav = -grav;
facePlayerOnSpawn = true;
mask_index = sprByouzMask;

phase = 0;
imgSpd = 0.2;
image_index = 1;
animBack = true;
moveTimer = 20;

// @cc - use this to change how fast Byouz moves
moveSpeed = 1;

// @cc - use this to change how low Byouz jumps
jumpSpeed = 5;
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
        // Waddle around
        case 0:
            if (ground)
            {
                xspeed = moveSpeed * image_xscale;

                if (!positionCollision(x + 8 * image_xscale, bbox_top - 2))
                {
                    image_xscale *= -1;
                }
            }
            else
            {
                xspeed = 0;
            }
            // Turn around when touching wall
            if (xcoll != 0)
            {
                image_xscale *= -1;
            }

            // Animation
            if (animBack == false)
            {
                image_index += imgSpd;
                if (image_index >= 3)
                {
                    animBack = true;
                    image_index = 1;
                }
            }
            else
            {
                image_index -= imgSpd;
                if (image_index < 0)
                {
                    animBack = false;
                    image_index = 1;
                }
            }

            moveTimer--;
            if (moveTimer <= 0)
            {
                if (instance_exists(target))
                {
                    if (floor(target.x) == x)
                    {
                        image_index = 1;
                        xspeed = 0;
                        phase = 1;
                        mask_index = sprByouz;
                        moveTimer = 10;
                    }
                }
            }
            break;
            // Jump
        case 1:
            moveTimer--;
            if (moveTimer == 5)
            {
                image_index = 3;
            }
            if (moveTimer <= 0)
            {
                image_index = 4;
                yspeed = jumpSpeed;
                phase = 2;
            }
            break;
        case 2:
            if (yspeed <= 0)
            {
                image_index = 5;
                if (ground)
                {
                    image_index = 1;
                    phase = 0;
                    mask_index = sprByouzMask;
                    moveTimer = 20;
                }
            }
            break;
    }
}
else if (dead)
{
    healthpoints = healthpointsStart;
    image_index = 1;
    animBack = true;
    phase = 0;
    yspeed = 0;
    moveTimer = 20;
}
