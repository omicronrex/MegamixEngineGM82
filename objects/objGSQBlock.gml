#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;

itemDrop = -1;

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 4;

blockCollision = 0;
grav = 0;

explode = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep)
{
    if (collision_line(bbox_left, bboxGetYCenter(), bbox_right,
        bboxGetYCenter(), objSolid, false, false))
    {
        explode = true;
    }

    if (explode == true)
    {
        i = instance_create(x, y, objGSQDebris);
        i.xspeed = 2;
        i.yspeed = 2;
        i = instance_create(x, y, objGSQDebris);
        i.xspeed = -2;
        i.yspeed = 2;
        i = instance_create(x, y, objGSQDebris);
        i.xspeed = 2;
        i.yspeed = -2;
        i = instance_create(x, y, objGSQDebris);
        i.xspeed = -2;
        i.yspeed = -2;
        instance_destroy();
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if ((other.object_index == objTornadoBlow) || (other.object_index == objBlackHoleBomb)
    || (other.object_index == objBreakDash) || (other.object_index == objSlashClaw))
{
    explode = false;
}
else
{
    explode = true;
}
