#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 2;
xspeed = image_xscale;
yspeed = -4;

blockCollision = false;

delayDetection = 2;

grav = 0.15;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (checkSolid(0, 0) && !blockCollision)
    {
        delayDetection = 2;
    }

    delayDetection--;

    if (delayDetection <= 0)
    {
        blockCollision = true;
    }

    if (checkSolid(xspeed, yspeed) && blockCollision)
    {
        instance_create(x, y, objExplosion);
        playSFX(sfxExplosion);
        instance_destroy();
    }
}
