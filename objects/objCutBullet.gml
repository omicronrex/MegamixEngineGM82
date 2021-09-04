#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;
grav = 0;

stopOnFlash = false;

contactDamage = 2;

spd = 3;

phase = 1;

image_speed = (-1 / 4);

reflectable = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (phase == 1)
    {
        if (target)
        {
            var angle;
            angle = point_direction(spriteGetXCenter(), spriteGetYCenter(),
                spriteGetXCenterObject(target),
                spriteGetYCenterObject(target));

            xspeed = cos(degtorad(angle)) * spd;
            yspeed = -sin(degtorad(angle)) * spd;
        }
        else
        {
            xspeed = spd;
            yspeed = 0;
        }
        phase = 2;
    }
    else if (phase == 2)
    {
        if (x < view_xview + 8 || x > view_xview + view_wview - 8 || y < view_yview + 8 || y > view_yview + view_hview - 8)
        {
            phase = 3;
        }
    }
    else
    {
        if (instance_exists(objCutMan))
        {
            var angle;
            angle = point_direction(spriteGetXCenter(), spriteGetYCenter(),
                spriteGetXCenterObject(objCutMan),
                spriteGetYCenterObject(objCutMan));

            xspeed = cos(degtorad(angle)) * spd;
            yspeed = -sin(degtorad(angle)) * spd;
            if (place_meeting(x, y, objCutMan))
            {
                instance_destroy();
            }
        }
    }

    image_speed = (-1 + ((phase > 2) * 2)) / 4;

    // Play audio as long as Rolling Cutter can move
    if (!audio_is_playing(sfxRollingCutter))
    {
        playSFX(sfxRollingCutter);
    }
}
