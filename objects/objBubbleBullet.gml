#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
contactDamage = 2;
blockCollision = 0;
grav = 0;
stopOnFlash = false;
image_speed = 0.2;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (place_meeting(x,y,objWater))//(inWater)
    {
        sprite_index = sprBubbleManShot;
    }
    else
    {
        sprite_index = sprBubbleManShotLand;
    }
}
