#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 6;

canHit = true;

blockCollision = 0;

col = 0;
explod = false;

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
image_index = col;
if (entityCanStep())
{
    if (checkSolid(0, 0, 1, 1))
        explod = true;
    if (explod == true)
    {
        event_user(EV_DEATH);
    }
}
else if (dead == true)
{
    calibrateDirection();
    xspeed = 0;
    yspeed = 0;
    image_index = 0;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dead=true;
var ID;
        ID = instance_create(spriteGetXCenter(), spriteGetYCenter(),
            objHarmfulExplosion);
        {
            ID.xscale = image_xscale;
        }
        instance_destroy();
        playSFX(sfxExplosion);
