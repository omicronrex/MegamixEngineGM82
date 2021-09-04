#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollison = false;
grav = 0;
x -= 6;
y -= 12;
xs[0] = 0;
ys[0] = 0;
timer = 0;
animTimer = 0;
img = 0;

for (var i = 0; i < 4; i++)
{
    xs[i] = 0;
    ys[i] = 0;
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    var spd = 0.15;

    if (timer < 20)
    {
        timer += 0.5;
    }
    else
    {
        timer += 1;
    }

    if (timer >= 20)
    {
        xs[0] += spd;
        ys[1] -= spd;
        xs[2] -= spd;
        ys[3] += spd;
    }

    if (timer == 20)
    {
        var i = instance_create(x + 6, y, objOctobulbJellyfish);
        i.dir = 0;
        i.spd = 2;
        i = instance_create(x + 8, y, objOctobulbJellyfish);
        i.dir = 180;
        i.spd = 2;
    }

    if (timer > 90)
    {
        instance_destroy();
    }

    animTimer += 0.1;
    if (animTimer > 1)
    {
        animTimer = 0;
        img += 1;
        if (img > 1)
        {
            img = 0;
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (timer < 60 || (timer >= 60 && !(timer mod 4)))
{
    for (var i = 0; i < 4; i++)
    {
        draw_sprite(sprOctobulbInk, img, x + xs[i], y + ys[i]);
    }
}
