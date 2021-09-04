#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Add these to make your level bouncy
event_inherited();
image_speed = 0;

var i; for ( i = 0; i < global.playerCount; i += 1)
{
    global.BounceXVel[i] = 0;
    global.MeBounce[i] = noone;
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    // Animation
    if (image_index > 0 && image_index < image_number - (1 / 3))
    {
        image_index += (1 / 3);
    }
    else if (image_index >= image_number - (1 / 3))
    {
        image_index = 0;
    }

    // bounce mega man
    with (objMegaman)
    {
        if (!teleporting && !showReady)
        {
            with (other)
            {
                var meg; meg = other.id;
                var pid; pid = other.playerID;
                if (place_meeting(x, y - 1, meg) && meg.yspeed >= 0)
                {
                    meg.yspeed = -8.5;
                    playSFX(sfxSpring);
                    image_index = 1 / 3;
                    global.BounceXVel[pid] = (meg.x - (x + 8)) / 6;
                    global.MeBounce[pid] = id;
                }
                if (place_meeting(x, y + 3, meg) && meg.yspeed <= 0)
                {
                    meg.yspeed = 2;
                    playSFX(sfxSpring);
                    image_index = 1 / 3;
                    global.BounceXVel[pid] = (meg.x - (x + 8)) / 6;
                    global.MeBounce[pid] = id;
                }
                if (place_meeting(x + 2, y, meg) || place_meeting(x - 2, y, other))
                {
                    playSFX(sfxSpring);
                    image_index = 1 / 3;
                    global.BounceXVel[pid] = (meg.x - (x + 8)) / 4;
                    global.MeBounce[pid] = id;
                }

                if (global.BounceXVel[pid] != 0 && global.MeBounce[pid] == id)
                {
                    global.BounceXVel[pid] = global.BounceXVel[pid] / 1.1;
                    if (instance_exists(meg))
                    {
                        with (meg)
                        {
                            if (ground && abs(global.BounceXVel[pid]) < 0.2)
                            {
                                global.BounceXVel[pid] = 0;
                            }
                            shiftObject(global.BounceXVel[pid], 0, 1);
                        }
                    }
                }
            }
        }
    }
}
