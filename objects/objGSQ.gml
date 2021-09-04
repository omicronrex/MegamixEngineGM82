#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A bulky trash-spitting robot. What does G.S.Q. even stand for? "Garbage Squashing Queen"? :thinking:

event_inherited();

healthpointsStart = 9;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "semi bulky, grounded";

facePlayerOnSpawn = true;

// Enemy specific code
moveTimer = 60;
canShoot = true;
imgSpd = 0.16;
phase = 0;
animTimer = 10;
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
        case 0: // Fire
            if ((image_index != 4) && (canShoot == true))
            {
                image_index += imgSpd;
            }
            if (image_index == 4)
            {
                animTimer--;
                if (animTimer <= 0)
                {
                    if (canShoot == true)
                    {
                        // Create block
                        i = instance_create(x + image_xscale * 8, y - 7, objGSQBlock);
                        i.image_xscale = image_xscale;
                        i.xspeed = 2 * image_xscale;
                        canShoot = false;
                    }
                    else
                    {
                        image_index = 3;
                        animTimer = 10;
                    }
                }
            }
            if (canShoot == false)
            {
                animTimer--;
                if (animTimer <= 0)
                {
                    image_index -= imgSpd;
                    if (image_index == 0)
                    {
                        moveTimer = 60;
                        phase = 1;
                    }
                }
            }
            break;
        case 1: // Idle
            moveTimer--;
            animTimer--;
            if (animTimer <= 0)
            {
                if (image_index == 0)
                {
                    image_index = 1;
                }
                else if (image_index == 1)
                {
                    image_index = 0;
                }
                animTimer = 8;
            }
            if ((moveTimer <= 0) && (image_index == 0))
            {
                canShoot = true;
                phase = 0;
            }
            break;
    }
}
else if (dead)
{
    moveTimer = 0;
    image_index = 0;
    phase = 0;
    canShoot = true;
    animTimer = 10;
}
