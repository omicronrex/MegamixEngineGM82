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
contactDamage = 4;

category = "grounded";

contactStart = contactDamage;

blockCollision = 0;

facePlayerOnSpawn = true;

// Enemy specific code
image_speed = 0.15; // STOP USING THIS VARIABLE
bounceTimes = 0;

mygear = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    image_speed = 0.15;
    if (mygear)
    {
        if (place_meeting(x, y, mygear))
        {
            if (bounceTimes < 4)
            {
                bounceTimes += 1;
                yspeed = -3;
            }
            else
            {
                y = mygear.y - 16 + 1;
                yspeed = mygear.yspeed;
                mygear.activated = true;
                mygear.grav = 0.25;
                if (mygear.xspeed == 0 && mygear.ground)
                {
                    mygear.xspeed = image_xscale;
                }
            }
        }

        stop = 0;
        var gearActive; gearActive = false;
        if (instance_exists(mygear))
        {
            with (mygear)
                gearActive = entityCanStep();
        }
        if (!gearActive)
        {
            xspeed = 0;
        }
        if (!instance_exists(mygear))
        {
            stop = 1;
        }
        else if (mygear.dead)
        {
            stop = 1;
        }

        if (stop)
        {
            xspeed = 0;
            yspeed = -3;
            mygear = 0;
        }
        else
        {
            x = mygear.x;
        }
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
