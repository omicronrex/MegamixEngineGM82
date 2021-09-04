#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A strange enemy from Uranus, it jumps towards Mega Man, tosses its hands at him, and then
// runs after him. Also, it deflects shots just by blinking.

event_inherited();

healthpointsStart = 4;
healthpoints = healthpointsStart;
contactDamage = 3;

facePlayerOnSpawn = true;

imgSpd = 0.1;
animBack = false;

moveTimer = 60;
phase = 0;
hasBlinked = false;
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
        // Blinking
        case 0:
            facePlayer = true;
            moveTimer--;
            if (moveTimer <= 0)
            {
                if (hasBlinked == false)
                {
                    image_index += imgSpd;
                }
                if (image_index >= 3)
                {
                    animBack = true;
                    hasBlinked = true;
                }
                if (animBack == true)
                {
                    image_index -= imgSpd;
                    if (image_index == 0)
                    {
                        animBack = false;

                        // Is Mega Man near? Yes = throw hands. No = jump.
                        if (instance_exists(target))
                        {
                            if ((target.x > x - 80) && (image_xscale == -1) ||
                                (target.x < x + 80) && (image_xscale == 1))
                            {
                                phase = 2;
                                moveTimer = 30;
                                image_index = 5;
                                facePlayer = false;
                            }
                            else
                            {
                                phase = 1;
                                moveTimer = 20;
                                hasBlinked = false;
                                facePlayer = false;
                            }
                        }
                    }
                }
            }
            else
            {
                image_index = 0;
            }
            break;

        // Jumping
        case 1:
            moveTimer--;
            if (moveTimer == 10)
            {
                image_index = 4;
            }
            if (moveTimer <= 0)
            {
                image_index = 3;
                if (image_index == 3)
                {
                    y -= 3;
                    yspeed -= 4;
                    xspeed = 1 * image_xscale;
                    phase = 4;
                }
            }
            break;

        // Punching
        case 2:
            if ((floor(image_index) == 12) || (floor(image_index) == 17))
            {
                moveTimer--;
                if (moveTimer == 29)
                {
                    var i = instance_create(x + 8 * image_xscale, y - 7, objHandooHand);
                    i.xspeed = 2 * image_xscale;
                    i.image_xscale = image_xscale;
                }

                if (moveTimer == 0)
                {
                    image_index += 1;
                    moveTimer = 30;
                }
            }
            else
            {
                image_index += imgSpd;
            }
            if (image_index > 19)
            {
                image_index = 21;
                phase = 3;
            }
            break;

        // Charging
        case 3:
            if (ground)
            {
                xspeed = 1 * image_xscale;

                if (instance_exists(target))
                {
                    if ((image_xscale == -1) && (x < target.x - 16) ||
                        (image_xscale == 1) && (x > target.x + 16))
                    {
                        image_xscale *= -1;
                    }
                }
            }
            else
            {
                xspeed = 0;
            }

            // Animation
            if (!animBack)
            {
                image_index += 0.2;
                if (image_index >= 23)
                {
                    animBack = true;
                    image_index = 21;
                }
            }
            else
            {
                image_index -= 0.2;
                if (image_index <= 20)
                {
                    animBack = false;
                    image_index = 21;
                }
            }
            break;

        // Mid-air movement (see case 1)
        case 4:
            if (ground)
            {
                xspeed = 0;
                yspeed = 0;
                image_index = 4;
                moveTimer = 60;
                inAir = false;
                phase = 0;
                facePlayer = true;
            }
            break;
    }
}
else if (dead)
{
    healthpoints = healthpointsStart;
    phase = 0;
    image_index = 0;
    moveTimer = 60;
    hasBlinked = false;
    animBack = false;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if ((image_index > 0) && (image_index < 3))
{
    other.guardCancel = 1;
}
