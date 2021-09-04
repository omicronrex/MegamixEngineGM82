#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
blockCollision = 0;
grav = 0;
canHit = true;
stopOnFlash = false;
contactDamage = 4;
var spd;
spd = 4;
xspeed = 4 * image_xscale;
playSFX(sfxBalladeShoot);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (!global.frozen)
{
    image_index += 0.25;
    if (checkSolid(16 * image_xscale, 0))
    {
        playSFX(sfxBalladeCrackerExplosion);
        instance_create(x, y, objHarmfulExplosion);
        instance_destroy();
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSFX(sfxBalladeCrackerExplosion);
instance_create(x, y, objHarmfulExplosion);
instance_destroy();
