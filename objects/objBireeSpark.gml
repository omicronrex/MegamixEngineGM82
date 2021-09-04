#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A flying enemy that drops sparks that, on impact with the ground, become waves that charge
// across surfaces.

event_inherited();

healthpointsStart = 3;
contactDamage = 4;

grav = 0;
facePlayerOnSpawn = true;

category = "flying";

shootTimer = 60;
imgIndex = 0;
imgSpd = 0.2;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    imgIndex += imgSpd;

    xspeed = 1 * image_xscale;

    shootTimer-=1;

    if (shootTimer <= 0)
    {
        var i; i = instance_create(x, y + 14, objBireeSparkShot);
        i.image_xscale = image_xscale;
        shootTimer = 180;
    }

    // Turn around
    if (xcoll != 0)
    {
        image_xscale *= -1;
    }
}
else if (dead)
{
    healthpoints = healthpointsStart;
    shootTimer = 60;
    imgIndex = 0;
}

image_index = imgIndex div 1;
