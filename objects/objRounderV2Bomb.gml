#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
respawn = false;
stopOnFlash = false;
healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;
canHit = false;
blockCollision = 0;
grav = 0.25;

// Enemy specific code
yspeed = 0;
xspeed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (global.difficulty == DIFF_HARD)
{
    if (place_meeting(x, y + yspeed, objSolid))
    {
        instance_create(x, y, objHarmfulExplosion);
        instance_destroy();
        playSFX(sfxMM3Explode);
    }
}
