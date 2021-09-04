#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "mets";

facePlayerOnSpawn = true;

// Enemy specific code
setup = false;

explosion = 256;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if(xcoll!=0)
{
    xspeed=xcoll;
}


if (entityCanStep())
{
    if (!respawn && xspeed != 0)
    {
        image_xscale = sign(xspeed);
    }

    if (xspeed == 0)
    {
        xspeed = 0.25 * image_xscale;
    }

    image_index += 0.125;

    // turn around on hitting a wall
    xSpeedTurnaround();

    if (!respawn)
    {
        explosion -= 1;
    }
    if (explosion <= 0)
    {
        instance_create(spriteGetXCenter(), spriteGetYCenter(),
            objExplosion);
        visible = false;
        dead = true;
    }

    if (ground)
    {
        yspeed = -choose(2.5, 3, 3.5);
    }
}
else if (dead)
{
    image_index = 0;
}
