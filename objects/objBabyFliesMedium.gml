#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Whatever this freaky thing from Venus is, it flies around and splits into two smaller
// variants when destroyed. This is the medium sized variant.

event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 2;

itemDrop = -1;
facePlayerOnSpawn = true;
grav = 0;

category = "flying, cluster";

image_speed = 0.2;
cosCounter = 0;
moveTimer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (moveTimer > 0)
    {
        x += 2 * image_xscale;
        moveTimer--;
    }

    xspeed = 0.5 * image_xscale;

    cosCounter += .025;
    yspeed = -(cos(cosCounter) * 0.7);

    if (xcoll != 0)
    {
        image_xscale *= -1;
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
    var i = instance_create(x + 1, y, objBabyFliesSmall);
    i.image_xscale = 1;
    i.moveTimer = 4;
    i.facePlayerOnSpawn = false;
    i.respawn = false;

    var i = instance_create(x - 1, y, objBabyFliesSmall);
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

//instance_destroy();
