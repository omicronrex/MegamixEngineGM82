#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 4;
grav = 0;
blockCollision = 0;

xspeed = 0;
yspeed = 0;
expand = image_xscale;

playSFX(sfxQuickLaser);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (global.frozen == false && global.timeStopped == false)
{
    if (abs(image_xscale) < view_wview / 8)
    {
        image_xscale += expand;
    }
    else
    {
        xspeed = 8 * expand;
    }
}
