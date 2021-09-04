#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
xspeed = 0;
contactDamage = 4;
blockCollision = 1;
ground = 0;
loopCount = 0;
image_speed = 0.235;
yspeed = -5;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    checkGround();
    if (loopCount > 2)
    {
        instance_destroy();
    }
    if (place_meeting(x, y + 1, objSolid) || ground)
        xspeed = 0;
}
#define Other_7
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (place_meeting(x, y + 1, objSolid) || ground)
{
    loopCount += 1;
}
