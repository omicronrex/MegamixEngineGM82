#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A crab from Venus's stage that shoots large bubbles. If they touch Mega Man, he'll get
// trapped inside and must break out as the bubble carries him along.

event_inherited();

healthpointsStart = 6;
healthpoints = healthpointsStart;
contactDamage = 3;

facePlayer = true;
category = "aquatic, semi bulky";

// image_index = 1;
imgSpd = 0.1;
animBack = false;
phase = 0;
moveTimer = 30;
bubble = noone;
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
        // Prepare Bubble
        case 0:
            moveTimer--;
            if (moveTimer > 0)
            {
                image_index += imgSpd;
                if (image_index == 2)
                {
                    image_index = 0;
                }
            }
            else
            {
                image_index += imgSpd;
                if (image_index == 4)
                {
                    phase = 1;
                    moveTimer = 60;
                }
            }
            break;
        case 1:
            moveTimer--;
            if (moveTimer == 30)
            {
                if (!instance_exists(bubble))
                {
                    i = instance_create(x, y, objFeeberBubble);
                    i.xspeed = 1 * image_xscale;
                    i.image_xscale = image_xscale;
                    i.parent = id;
                    bubble = i.id;
                    playSFX(sfxOil);
                }
            }
            if (moveTimer <= 0)
            {
                if (image_index > 2)
                {
                    image_index -= imgSpd;
                }
                else // if (image_index == 1)
                {
                    image_index = 0;
                    animTimer--;
                    if (animTimer == 0)
                    {
                        calibrateDirection();
                        image_index = 4;
                        animBack = false;
                        phase = 2;
                        moveTimer = 120;
                        animTimer = 10;
                    }
                }
            }
            break;
        case 2:
            moveTimer--;
            if (moveTimer > 0)
            {
                if (animBack == false)
                {
                    image_index += imgSpd;
                    if (image_index >= 7)
                    {
                        image_index = 6;
                        animBack = true;
                    }
                }
                else
                {
                    image_index -= imgSpd;
                    if (image_index < 4)
                    {
                        image_index = 5;
                        animBack = false;
                    }
                }
            }
            else
            {
                moveTimer = 30;
                image_index = 0;
                phase = 0;
            }
            break;
    }
}
else if (dead)
{
    healthpoints = healthpointsStart;
    image_index = 1;
    animBack = false;
    phase = 0;
    moveTimer = 30;
    animTimer = 10;
    animBack = false;
    bubble = noone;
}
