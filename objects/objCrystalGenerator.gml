#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A gimmick from Crystal Man's stage. It spawns crystals every so often. They fall down. Heck yeah.

// Creation code (all optional):
// interval: time between spawned crystals, in frames. default 120 frames.

event_inherited();
canHit = false;

timer = 0;
variation = 0;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

interval = 120;

bullet = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.timeStopped && !dead)
{
    // increment timer
    timer += 1;
    if (timer >= interval) // spawn bullet
    {
        timer = 0;
        i = instance_create(x + 8, y + 8, objEnemyBullet);
        i.image_speed = 0.5;
        i.sprite_index = sprCrystal;
        i.grav = 0.25;
    }

    if (instance_exists(bullet)) // add gravity to the spawned bullet
    {
        bullet.yspeed += 0.24;
    }
}
visible = false;
