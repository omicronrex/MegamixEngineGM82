#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation Code (optional)
// variation = <number> (0 = don't drop from foliage (default); 1 = drop from foliage)
// made not dropping from foliage the default since dropping from foliage won't be applicable in most settings

event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "flying, nature";

grav = 0;
blockCollision = false;

// Enemy specific code
variation = 0;
init = 1;

phase = 0;
revealed = false;
canHit = false;

spd = 0.4;

imgSpd = 1;
imgIndex = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{
    init = 0;
    if (variation == 1)
    {
        visible = false;
    }
}

event_inherited();

if (entityCanStep())
{
    if (instance_exists(target))
    {
        if (phase == 1)
        {
            facePlayer = false;
        }
        else
        {
            facePlayer = true;
        }

        switch (phase)
        {
            // pop out of foliage
            case 0:
                visible = false;
                canHit = false;
                if (variation == 0)
                {
                    // setup chasing player phase
                    phase = 2;

                    speed = spd;
                    direction = point_direction(x, y, target.x, target.y);

                    imgIndex = 2;
                    visible = true;
                    canHit = true;
                }
                else if (variation == 1)
                {
                    // pop out of foliage stuff
                    if (abs(x - target.x) < 96)
                    {
                        phase = 1;

                        yspeed = 2;

                        visible = true;
                        canHit = true;

                        playSFX(sfxHeliButonReveal);

                        var i;
                        for (i = 0; i < 4; i += 1)
                        {
                            instance_create(x, y, objHeliButonLeaf);
                        }
                    }
                }
                break;

            // slow down and stop
            case 1: // animation
                if (imgIndex < 2)
                {
                    imgIndex += imgSpd / 9;
                }
                else
                {
                    imgIndex += imgSpd;
                }
                if (imgIndex >= 4)
                {
                    imgIndex = 2 + imgIndex mod 4;
                }
                if (yspeed <= 0)
                {
                    phase = 2;

                    direction = point_direction(x, y, target.x, target.y);
                }
                yspeed -= 0.07;
                break;

            // chase megaman
            case 2:
                speed = spd;
                imgIndex += imgSpd / 4;
                if (imgIndex >= 4)
                {
                    imgIndex = 2 + imgIndex mod 4;
                }
                correctDirection(round(point_direction(bboxGetXCenter(),
                    bboxGetYCenter(), bboxGetXCenterObject(target),
                    bboxGetYCenterObject(target))), 2);

                // hover sfx
                if (!audio_is_playing(sfxHeliButonHover))
                {
                    loopSFX(sfxHeliButonHover);
                }
                break;
        }
    }
}
else
{
    speed = 0;
    audio_stop_sound(sfxHeliButonHover);

    if (dead)
    {
        phase = 0;
        revealed = false;

        xspeed = 0;
        yspeed = 0;
        direction = 0;

        imgIndex = 0;


        canHit = false;
    }
}

image_index = imgIndex div 1;

contactDamage = 3 * visible;
