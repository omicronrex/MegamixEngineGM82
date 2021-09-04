#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;

contactDamage = 2;
despawnRange = -1;
image_speed = 0;
image_index = 0;

alarmDie = -2;
alarmHitSolid = 16;
xspeed = 0;
yspeed = 0;
reflectable = 0;

playSFX(sfxEnemyDrop);

parent = noone;
num = -1;
child = objFatool;
spawner = noone;
sprite = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.timeStopped)
{
    alarmHitSolid-=1;

    if (alarmDie >= 0)
    {
        alarmDie -= 1;
        if (alarmDie == 0)
        {
            instance_destroy();
        }
    }
    if (!place_meeting(x, y, objSolid) && !blockCollision && image_index == 0 && alarmHitSolid <= 0)
    {
        blockCollision = true;
    }

    if (ground || y >= maxY && maxY != -1)
    {
        event_user(2);
    }
}
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=createChild
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
grav = 0;
yspeed = 0;
var inst; inst = instance_create(x, y, child);
with (inst)
{
    parent = other.parent;
    image_xscale = other.image_xscale;
    image_yscale = other.image_yscale;
    respawn = false;
    introType = 2;
}
with (spawner)
{
    child = inst.id;
    spawnDelayMax = other.parent.attackTimerMax;
}
with (parent)
{
    childStore[other.num] = inst.id;
}
instance_destroy();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (sprite == 0)
    sprite = object_get_sprite(child);
sprite_index = sprite;

if (alarmHitSolid mod 3 == 0)
{
    drawSelf();
}
else if (alarmHitSolid mod 3 == 1)
{
    var flashcol; flashcol = c_white;
    d3d_set_fog(true, flashcol, 0, 0);
    drawSelf();
    d3d_set_fog(false, 0, 0, 0);
}
else
{
    var flashcol; flashcol = make_colour_rgb(255, 123, 255);
    d3d_set_fog(true, flashcol, 0, 0);
    drawSelf();
    d3d_set_fog(false, 0, 0, 0);
}
