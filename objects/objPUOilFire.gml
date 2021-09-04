#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;
grav = 0;
canHit = false;
bubbleTimer = -1;

contactDamage = 4;
image_speed = 0.3;
reflectable = 0;

destroyTimer = 300;

fire = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// wait 5 seconds (300 frames)
destroyTimer-=1
if (destroyTimer <= -1)
{
    instance_destroy();
}
