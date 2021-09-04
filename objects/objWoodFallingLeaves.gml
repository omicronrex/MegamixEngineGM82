#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
contactDamage = 4;
yspeed = 1.5;
xspeed = 1.5;
image_speed = 0.125;
blockCollision = 0;
grav = 0;
stopOnFlash = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    image_speed = 0.125;
    x = round(x);
    if (x == xstart + 16)
    {
        xspeed = -1.5;
    }
    else if (x == xstart - 16)
    {
        xspeed = 1.5;
    }
}
else
{
    image_speed = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.object_index == objFlameMixer) || (other.object_index != objSolarBlaze)
{
    instance_create(x,y,objExplosion);
}
