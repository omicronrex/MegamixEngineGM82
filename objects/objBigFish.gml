#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// This enemy will be invisible at first, but will periodically pop up and rise from its original position. It will
// fall when it reaches the halfway point of the screen.

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 10;

contactStart = contactDamage;

blockCollision = 0;
grav = 0;

facePlayer = true;

// Enemy specific code
image_speed = 0.125;

//@cc
popDelay = 64;

//@cc
popDelayStart = popDelay;


dropDown = false;
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
    if (popDelay)
    {
        popDelay -= 1;
        if (!popDelay)
        {
            yspeed = -2;
        }
    }

    if (y < view_yview + 112)
    {
        grav = 0.25;
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
other.guardCancel = 1 + (other.penetrate == 2);
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn
popDelay = popDelayStart;
grav = 0;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (popDelay == 0)
{
    event_inherited();
    canHit = true;
    contactDamage = contactStart;
}
else
{
    canHit = false;
    contactDamage = 0;
}
