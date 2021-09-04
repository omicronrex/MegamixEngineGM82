#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Whatever this freaky thing from Venus is, it flies around and splits into two smaller
// variants when destroyed. This is the primary and largest version.

event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 3;

itemDrop = -1;
facePlayerOnSpawn = true;
grav = 0;

category = "flying";

image_speed = 0.2;
cosCounter = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    xspeed = 0.5 * image_xscale;

    cosCounter += .025;
    yspeed = -(cos(cosCounter) * 0.7);

    if(instance_exists(target))
    {
        if ((xcoll != 0) || (target.x - 32 > x) && (image_xscale == -1) || (target.x + 32 < x) && (image_xscale == 1))
        {
            image_xscale *= -1;
        }
    }

    if ((ycoll == 1) && (yspeed > 0) || (ycoll == 1) && (yspeed < 0))
    {
        yspeed = yspeed / 2;
    }
}
else if (dead)
{
    healthpoints = healthpointsStart;
    cosCounter = 0;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if ((other.object_index != objTornadoBlow) && (other.object_index != objBlackHoleBomb))
{
    var i; i = instance_create(x + 1, y, objBabyFliesMedium);
    i.image_xscale = 1;
    i.moveTimer = 4;
    i.facePlayerOnSpawn = false;
    i.respawn = false;

    var i; i = instance_create(x - 1, y, objBabyFliesMedium);
    i.image_xscale = -1;
    i.moveTimer = 4;
    i.facePlayerOnSpawn = false;
    i.respawn = false;
}

if ((other.object_index == objSlashEffect) || (other.object_index == objBreakDash))
{
    with (objSlashEffect)
    {
        image_alpha = 0;
    }
}
