#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// creation code (all optional)
// col = <number> (0 = green (default); 1 = orange; 2 = blue)

event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "grounded";

facePlayerOnSpawn = true;

// Enemy specific code
col = 0;

phase = 0;
timer = 0;
turnRange = 64;
trackStop = false;
spd = 1.5;

turn = false;

imgSpd = 0.2;
imgIndex = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (instance_exists(target))
    {
        switch (phase)
        {
            // drive around
            case 0:
                imgIndex += imgSpd;
                if (imgIndex >= 2)
                {
                    imgIndex = imgIndex mod 2;
                }
                turn = false;
                if (ground)
                {
                    if (xspeed == 0)
                    {
                        turn = true;

                        /* basically if turned around by a wall when going towards
                        mega man, make it so we don't turn around from being away
                        from mega man until we hit another wall */
                        if (!trackStop)
                        {
                            if (instance_exists(target))
                            {
                                if ((x > target.x && image_xscale < 0)
                                    || (x <= target.x && image_xscale > 0))
                                {
                                    trackStop = true;
                                }
                            }
                        }
                        else
                        {
                            trackStop = false;
                        }
                    }

                    if (!trackStop && instance_exists(target))
                    {
                        // mega man has to be relatively above or on the same level for it to turn
                        if (target.y < y + 8 && ((target.x < x - turnRange
                            && image_xscale > 0)
                            || (target.x > x + turnRange
                            && image_xscale < 0)))
                        {
                            turn = true;
                        }
                    }

                    if (turn)
                    {
                        phase = 1;
                        xspeed = 0;
                        imgIndex = 2;
                    }
                    else
                    {
                        xspeed = spd * image_xscale;
                    }
                }
                else
                {
                    xspeed = 0;
                }
                break;

            // turn around
            case 1:
                imgIndex += imgSpd * 0.65;
                if (imgIndex >= 5)
                {
                    phase = 0;
                    imgIndex = 0;
                    image_xscale = -image_xscale;
                    xspeed = spd * image_xscale;
                }
                break;
        }
    }
    image_index = imgIndex div 1;
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// creation code setup
switch (col)
{
    case 0:
        sprite_index = sprTwinRoaderGreen;
        break;
    case 1:
        sprite_index = sprTwinRoaderOrange;
        break;
    case 2:
        sprite_index = sprTwinRoaderBlue;
        break;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn
event_inherited();
phase = 0;
timer = 0;
imgIndex = 0;
if (spawned)
{
    xspeed = spd * image_xscale;
    turn = false;
}
