#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

image_speed = 0.25;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    isSolid = (sprite_index == sprPlantmanPlatformOpen) * 2;
}
else if (dead)
{
    sprite_index = sprPlantmanPlatformClosed;
    image_index = 0;
    isSolid = 0;
    canHit = true;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_index = sprPlantmanPlatformOpen;
isSolid = 2;
iFrames = 0;
canHit = false;

with (other)
{
    if (penetrate < 2 && pierces < 2)
    {
        event_user(EV_DEATH);
    }
}

other.guardCancel = 2;
