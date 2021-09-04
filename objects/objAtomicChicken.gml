#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// This tough chicken will run forwards and jump over Megaman.

event_inherited();

healthpointsStart = 10;
healthpoints = healthpointsStart;
contactDamage = 4;

//@cc
category = "nature, bird, bulky";

//@cc
facePlayerOnSpawn = true;

// Enemy specific code
image_speed = 0.25;

alarmJump = 45;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if(xcoll!=0)
{
    xspeed=xcoll;
}


if (entityCanStep())
{
    if (yspeed != 0)
    {
        image_speed = 0;
        image_index = 0;
    }
    else
    {
        image_speed = 0.25;
    }

    if (xspeed == 0)
    {
        xspeed = 2 * image_xscale;
    }

    if (alarmJump && ground)
    {
        alarmJump -= 1;
        if (!alarmJump)
        {
            yspeed = -4;
            alarmJump = 60;
        }
    }
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue(objMagneticShockwave, 5);
specialDamageValue(objIceWall, 10);
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

/// On spawn
image_index = 0;
alarmJump = 45;
