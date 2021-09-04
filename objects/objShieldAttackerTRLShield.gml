#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
yspeed = 0;
xspeed = 0;
deathTimer = 0;
timer = 0;
col = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.timeStopped)
{
    x += xspeed;
    y += yspeed;
    timer += 1;
    yspeed += 0.25;
    deathTimer += 1;
    if (deathTimer >= 30)
    {
        instance_destroy();
        exit;
    }
}
else
{
    timer = 4;
}
if (!insideView())
{
    instance_destroy();
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if ((timer mod 4) == 0)
    drawSelf();
