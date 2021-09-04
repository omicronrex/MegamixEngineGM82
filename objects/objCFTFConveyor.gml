#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code:
// dir = 1/-1 (1 = right (default), -1 = left; optional)
// image_xscale = <number> - use editor for this! (the size of the conveyor belt, measured in blocks of 32x16 pixels; optional, default is 1
// spd = ; (how fast the conveyor belt pushes you)

event_inherited();

sprite_index = sprCompassConveyor;

canHit = false;

isSolid = 1;

blockCollision = 0;
grav = 0;

respawnRange = -1;
despawnRange = -1;

dir = 1;

spd = 1; // The speed the player moves at when standing on the conveyor belt

imgalarm = 0;
img = 0;

/*
if (!place_meeting(x - 4, y, object_index))
{
    while (place_meeting(x + 4, y, object_index))
    {
        with (instance_place(x + 4, y, object_index))
        {
            instance_destroy();
        }
        image_xscale += 1;
    }
}*/
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead)
{
    if (image_xscale - (floor(image_xscale)) > 0)
    {
        image_xscale = ceil(image_xscale);
    }
    imgalarm += 1;
    if (imgalarm >= 5)
    {
        imgalarm = 0;
        if (img == 2)
        {
            img = 0;
        }
        else
        {
            img += 1;
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var i;

for (i = 0; i < abs(image_xscale); i += 1)
{
    if (dir == 1)
    {
        draw_sprite(sprite_index, img, round(x + (i * 32)), round(y));
    }
    else
    {
        draw_sprite(sprite_index, image_number - img mod image_number,
            round(x + (i * 32)), round(y));
    }
}
