#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 6;

blockCollision = 0;
canHit = true;

facePlayerOnSpawn = true;

explod = false;
col = 0;

reflectable = 0;

yspeed = -6.5;

calibrateDirection();

// aim
if (instance_exists(target))
{
    xspeed = xSpeedAim(x, y, (floor(target.x / 16) * 16) + 8, target.y, yspeed, grav);
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (checkSolid(0, 0, 1, 1))
        explod = true;
    if (explod == true)
    {
        var ID;
        ID = instance_create(spriteGetXCenter(), spriteGetYCenter(),
            objRockExplosion);
        {
            ID.xscale = image_xscale;
        }
        instance_destroy();
        playSFX(sfxExplosion);
    }
}
else if (dead == true)
{
    xspeed = 0;
    yspeed = 0;
    image_index = 0;
}
