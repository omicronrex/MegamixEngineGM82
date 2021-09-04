#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
respawn = false;
healthpoints = 4;
healthpointsStart = 4;
canHit = true;
grav = 0;
contactDamage = 2;
blockCollision = false;

phase = 0;
dir = -1;
type = 0;
animFrame = 0;
timer = 0;
delay = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (phase == 0)
    {
        animFrame = min(2, animFrame + 0.2);
        image_index = floor(animFrame);
        timer += 1;
        if (timer > 30 + delay)
        {
            animFrame = 0;
            timer = 0;
            phase = 1;
        }
    }
    else
    {
        if (type == 0)
        {
            xspeed = 2.65 * dir;
        }
        else
        {
            yspeed = 2.35;
        }
        animFrame += 0.2;
        if (floor(animFrame) > 3)
            animFrame = 0;
        image_index = 3 + type * 4 + floor(animFrame);
    }
}
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
instance_destroy();
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
instance_create(bbox_left + (bbox_right - bbox_left) / 2, bbox_top + (bbox_bottom - bbox_top) / 2, objExplosion);
playSFX(sfxEnemyHit);
