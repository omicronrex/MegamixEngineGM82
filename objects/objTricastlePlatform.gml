#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
blockCollision = false;
grav = 0;
isSolid = 2;
contactDamage = 3;
canHit = false;
spd = 2;
image_index = 0;
image_speed = 0.2;
timer = 0;
xspeed = 0;
respawn = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
{
    timer += 1;
    if (image_index != 0 && timer > 27)
    {
        xspeed = spd * image_xscale;
    }
}
#define Other_7
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_index = 1;
#define Other_19
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Nothing
