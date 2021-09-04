#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 1;

facePlayerOnSpawn = true;

// Enemy specific code
alarmJump = 60;

parent = -1;
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
    // alarmjump
    if (ground)
    {
        xspeed = 0;
        if (alarmJump > 0)
        {
            alarmJump -= 1;
        }
        if (alarmJump == 0 && ground)
        {
            y -= 4;
            calibrateDirection();
            xspeed = 2 * image_xscale;
            yspeed = -5;
            alarmJump = 60;
        }
    }

    if (ground)
    {
        image_index = 0;
    }
    else
    {
        image_index = 1;
    }
}
else
{
    image_index = 0;
    alarmJump = 45;
}
