#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Sliding penguins, usually created by penpen maker

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "cluster, nature, bird";

facePlayerOnSpawn = true;

// Enemy specific code
image_speed = 0.2;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    xspeed = image_xscale * 3;

    if (xcoll != 0)
    {
        dead = 1;
        visible = 0;
        instance_create(spriteGetXCenter(), spriteGetYCenter(), objExplosion);
    }
}
