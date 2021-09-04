#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code:
// popTime = <number>

event_inherited();

respawn = false;

blockCollision = 0;
grav = 0;
inWater = -1;
canHit = false;

isSolid = 2;

timer = 0;
pop = 0;
popTime = 60;

imgSpeed = 0.15;
img = 0;

yspeed = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && object_index == objBubblePlatformSmall)
{
    if (timer >= popTime)
    {
        image_index = image_number - 1;
        image_speed = 0;
        yspeed = 0;

        isSolid = 0;

        timer += 1;
        if (timer >= (popTime + 15))
        {
            dead = true;
        }
    }
    else
    {
        img += imgSpeed;
        if (img >= image_number - 1)
        {
            img = 0;
        }
        image_index = floor(img);

        if (pop || place_meeting(x, y - 1, target))
        {
            pop = true;
            timer += 1;
        }

        if (place_meeting(x, y - 1, objSolid)
            || (place_meeting(x, y + 16, objWater)
            && !place_meeting(x, y, objWater)))
        {
            timer = popTime;
        }
    }
}
