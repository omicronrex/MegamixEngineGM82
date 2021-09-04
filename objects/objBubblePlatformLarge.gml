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

y += sprite_get_yoffset(sprite_index);

yspeed = -0.5;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    if (timer >= popTime)
    {
        image_index = image_number - 2;
        yspeed = 0;

        timer += 1;
        if (timer > popTime + 15)
        {
            instance_destroy();
        }
    }
    else
    {
        img += imgSpeed;
        if (img >= image_number - 2)
        {
            img = 4;
        }
        image_index = floor(img);

        if (checkSolid(0, -1, 1, 1)
            || (place_meeting(x, y + 16, objWater)
            && !place_meeting(x, y, objWater)))
        {
            if (timer < popTime && y < ystart - 14 && !pop)
            {
                timer = popTime;
            }
        }

        if (place_meeting(x, y - 2, target) && !pop)
        {
            if (!place_meeting(x, y, target) && target.ground)
            {
                image_index = 9;
            }
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var ys; ys = y;
y = round(min(ystart, y));

event_inherited();

y = ys;
