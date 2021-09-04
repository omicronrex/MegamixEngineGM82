#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Use objCustomSpawner
// gravityFlip = true;   -  determine the direction of where this sits. if true, it starts on the cieling.)

event_inherited();

respawn = false;

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 0;

// Enemy specific code
alarmTime = 0;
canHit = false;

//@cc enemy to spawn
en = -1;

ex = -1;
ey = -1;

enx = x;
eny = y;

lines = 0;
dir = 1;

stopOnFlash = false;

spawntime = 56;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    alarmTime += 1;
    if (alarmTime == 1)
    {
        i = instance_create(ex, ey, en);
        with (i)
        {
            other.enx = bboxGetXCenter();
            other.eny = bboxGetYCenter();
            other.sprite_index = sprite_index;
            other.image_index = image_index;
            other.image_xscale = image_xscale;
            other.image_yscale = image_yscale;
            instance_destroy();
        }
    }

    if (alarmTime >= spawntime)
    {
        i = instance_create(ex, ey, en);
        i.respawn = 0;
        with (i)
        {
            if (despawnRange != -1)
            {
                despawnRange += sprite_height;
            }
        }

        obj = i.object_index;

        event_user(0);
        instance_destroy();
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
imgx = image_xscale;
image_xscale = 1;
imgy = image_yscale;
image_yscale = 1;

for (i = 0 + lines; i < sprite_height; i += 2)
{
    draw_sprite_part_ext(sprite_index, image_index, 0, i, sprite_width, 1,
        ex - sprite_xoffset * imgx + round((spawntime - alarmTime) / 4)
        * dir, ey - sprite_yoffset * imgy + i, imgx, imgy, image_blend,
        image_alpha);
}

if (!(alarmTime mod 4))
{
    dir = -dir;
}
lines = !lines;

image_xscale = imgx;
image_yscale = imgy;
