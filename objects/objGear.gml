#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

/// Initially this gear will use godlike powers to go against physics
// this summons a pierobot that makes it fall.

healthpointsStart = 4;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "grounded";

grav = 0;

// Enemy specific code
image_speed = 0.25; // Using this variable is not recommended, please avoid it

activated = false;
alarmPop = 60;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    image_speed = 0.25;
    if (xcoll != 0)
    {
        xspeed = -xcoll;
    }

    alarmPop -= 1;
    if (alarmPop == 0)
    {
        i = instance_create(x, view_yview + 32, objPierobot);
        i.mygear = id;
    }
}
else
{
    image_speed = 0;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn
event_inherited();
alarmPop = 60;
activated = false;
grav = 0;
