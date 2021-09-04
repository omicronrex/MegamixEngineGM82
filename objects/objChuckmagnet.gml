#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// It occurs to me that this enemy is really similar to the Bullet Bill in how it moves,
// but I'm going to write this boy from scratch
event_inherited();
respawn = true;
healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;
blockCollision = 0;
grav = 0;
image_index = 0;
image_speed = 0;
xspeedCM = 0;
cosCounter = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    xspeed = xspeedCM;
    cosCounter += .06;
    yspeed = -(cos(cosCounter) * 0.8);
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (image_index > 0 && image_index < 5)
{
    other.guardCancel = 2;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (spawned)
{
    cosCounter = 0;
    if (x > view_xview[0] + view_wview[0] / 2)
    {
        xspeedCM = -1;
    }
    else
    {
        xspeedCM = 1;
    }
    image_speed = -8 / 120 * xspeedCM;
}
