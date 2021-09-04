#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
parent = noone;
loops = 0;
yend = -1;
timer = 0;
gravityDir = 1;
yspd = 0;
grv = 0;
noFlicker = true;
ystart = y;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen && !global.timeStopped)
{
    if (instance_exists(parent) && !parent.dead)
    {
        if (yend == -1 && parent.ground)
        {
            yend = parent.y - 16 * sign(grv);
        }
    }
    else
    {
        if (yend == -1)
        {
            yend = y;
            loops = -1;
        }
    }
    var gravityDir = sign(grv);
    timer += 1;
    yspd += grv;
    y += yspd;

    if (loops == -2)
        instance_destroy();
}
if (global.switchingSections)
    instance_destroy();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var dist = abs(ystart - y);
var gravityDir = sign(yspd);
var skipCount = 0;
var dy = (floor(y / 16) * 16) - 6 * gravityDir + 8 * (gravityDir == -1);
for (i = 0; i < min(3, floor(dist / 16)); i++)
{
    if (yend != -1 && sign(yend - (dy - ((gravityDir * i * 16) + gravityDir * 10))) == -sign(yspd))
    {
        skipCount += 1;
        continue;
    }

    var si = loops * 2;

    if (timer + gravityDir * 16 * i > 5)
    {
        si += 1;
    }

    draw_sprite(sprDarspiderWeb, si, x, dy - (gravityDir * 3 + gravityDir * i * 16));
}
if (skipCount == 3)
{
    loops = -2;
}
else if (skipCount == 1)
{
    if (loops == 0)
    {
        var i = instance_create(xstart, ystart + 28 * gravityDir, objDarspiderWeb);
        i.grv = grv;
        i.yend = yend;
        i.loops = 1;
        i.ystart = ystart;
    }
    loops = -1;
}
