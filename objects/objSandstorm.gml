#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

respawn = false;

respawnRange = -1;
despawnRange = -1;

blockCollision = 0;
grav = 0;

// Enemy specific code
size = 0;
mySpeed = 0;
dir = sign(mySpeed);

xs = x;
imgadd = 0;
img = 0;
imgTimer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{

    imgTimer += 1;
    if (imgTimer == 5)
    {
        img -= dir;
        if (img == -1)
        {
            img = 2;
        }
        if (img == 3)
        {
            img = 0;
        }
        imgTimer = 0;
    }

    x += mySpeed;
    xs = round(x / 16) * 16;

    with (target)
    {
        sandstormed = 0;
    }
    for (i = 0; i < 7; i += 1)
    {
        var meg; meg = collision_rectangle(xs + i * 16 * -dir, view_yview + i * 32,
            xs + i * 16 * -dir + (size * 16), view_yview + i * 32 + 32,
            objMegaman, false, false);
        if (meg != noone)
        {
            with (meg)
            {
                if (!climbing && !sandstormed)
                {
                    shiftObject(other.dir *abs(other.mySpeed*0.5), 0, 1);
                    sandstormed = 1;
                }
            }
        }
    }
    if (instance_exists(target))
    {
        if (dir == 1)
        {
            if (x > global.sectionRight)
            {
                instance_destroy();
            }
        }
        if (dir == -1)
        {
            if (x + (size * 16) + (16 * 7) < global.sectionLeft)
            {
                instance_destroy();
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
imgadd = 3;

for (z = 0; z < 7; z += 1)
{
    draw_sprite(sprSandstormLeft, image_index + img + imgadd, xs + z * -dir * 16 - 8, view_yview + z * 32);

    for (i = 0; i < size; i += 1)
    {
        draw_sprite(sprSandstorm, image_index + img + imgadd, xs + (i + z * -dir) * 16, view_yview + z * 32);
    }

    draw_sprite(sprSandstormRight, image_index + img + imgadd, xs + (z * -dir + size) * 16, view_yview + z * 32);

    if (imgadd == 0)
    {
        imgadd = 3;
    }
    else
    {
        imgadd = 0;
    }
}
