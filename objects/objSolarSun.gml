#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
grav = 0;
blockCollision = 0;
respawn = false;
stopOnFlash = false;

sunLevel = objSolarMan.sunLevel;
curSunLevel = 0;

switch (sunLevel)
{
    case 0:
        contactDamage = 4;
        break;
    case 1:
        contactDamage = 5;
        break;
    case 2:
        contactDamage = 6;
        break;
}

sunY = 0;
stopOnFlash = false;
weakSun = false; // Is the sun weakened?

image_speed = 0.2;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (instance_exists(objSolarMan))
{
    if (entityCanStep())
    {
        image_xscale = objSolarMan.image_xscale;

        switch (curSunLevel)
        {
            case 0:
                sprite_index = sprSolarSunSmall;
                y = objSolarMan.y - 13;
                break;
            case 1:
                if ((sprite_index == sprSolarSunSmall) || (sprite_index == sprSolarSunLarge))
                {
                    sprite_index = sprSolarSunMedium;
                    y = objSolarMan.y - 16;

                    // Stop SFX in progress
                    if (audio_is_playing(sfxSolarManSun))
                    {
                        audio_stop_sound(sfxSolarManSun);
                    }

                    // Replay SFX
                    playSFX(sfxSolarManSun);
                }
                break;
            case 2:
                if (sprite_index == sprSolarSunSmall)
                {
                    sprite_index = sprSolarSunMedium;

                    // Stop SFX in progress
                    if (audio_is_playing(sfxSolarManSun))
                    {
                        audio_stop_sound(sfxSolarManSun);
                    }

                    // Replay SFX
                    playSFX(sfxSolarManSun);
                }
                else if (sprite_index == sprSolarSunMedium)
                {
                    sprite_index = sprSolarSunLarge;
                    y = objSolarMan.y - 19;

                    // Stop SFX in progress
                    if (audio_is_playing(sfxSolarManSun))
                    {
                        audio_stop_sound(sfxSolarManSun);
                    }

                    // Replay SFX
                    playSFX(sfxSolarManSun);
                }
                break;
        }

        // Position self so that it matches Solar Man's position
        if (!objSolarMan.isIntro)
        {
            // Set depth of object
            if ((objSolarMan.image_index == 5) || (objSolarMan.image_index == 8))
            {
                depth = 0;
            }
            else
            {
                depth = -2;
            }

            // If standing idle/about to jump...
            if ((objSolarMan.image_index == 0) || (objSolarMan.image_index == 4))
            {
                // x = objSolarMan.x + 2 * image_xscale;
                x = objSolarMan.x;
                switch (curSunLevel)
                {
                    case 0:
                        y = objSolarMan.y - 13;
                        break;
                    case 1:
                        y = objSolarMan.y - 16;
                        break;
                    case 2:
                        y = objSolarMan.y - 19;
                        break;
                }
            } // If Solar Man is jumping or charging...
            else if ((objSolarMan.image_index == 5) || (objSolarMan.image_index == 8))
            {
                x = objSolarMan.x;
                switch (curSunLevel)
                {
                    case 0:
                        y = objSolarMan.y - 15;
                        break;
                    case 1:
                        y = objSolarMan.y - 18;
                        break;
                    case 2:
                        y = objSolarMan.y - 21;
                        break;
                }
            } // If Solar Man is leaning over...
            else if (objSolarMan.phase == 2)
            {
                with (objSolarMan)
                {
                    if (attackTimer == 20)
                    {
                        other.x = x + 12 * image_xscale;
                        other.y = y - 1;
                    }
                    else if ((attackTimer > 24) && (attackTimer < 100))
                    {
                        switch (other.curSunLevel)
                        {
                            case 0:
                                other.x = x + 21 * image_xscale;
                                break;
                            case 1:
                                other.x = x + 24 * image_xscale;
                                break;
                            case 2:
                                other.x = x + 27 * image_xscale;
                                break;
                        }
                        other.y = y + 4;
                    }
                }
            } // May be unnecessary? Keep just in case.
            else
            {
                x = objSolarMan.x;
                switch (curSunLevel)
                {
                    case 0:
                        y = objSolarMan.y - 13;
                        break;
                    case 1:
                        y = objSolarMan.y - 16;
                        break;
                    case 2:
                        y = objSolarMan.y - 19;
                        break;
                }
            }
        }
    }
} // Destroy if Solar Man is dead or doesn't exist
else
{
    instance_destroy();
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.object_index != objTornadoBlow)
{
    iFrames = 0;
    if (other.object_index != objWaterShield) && (other.object_index != objRainFlush)
    {
        curSunLevel++;
        if (curSunLevel >= sunLevel)
            weakSun = false;

        if (curSunLevel > 2)
        {
            curSunLevel = 2;
        }
    }
    else
    {
        if (objSolarMan.phase != 3)
        {
            curSunLevel--;
            weakSun = true;

            if (curSunLevel < 0)
            {
                curSunLevel = 0;
            }

            if (other.object_index == objWaterShield)
            {
                with (objWaterShield)
                {
                    instance_create(x, y, objBubblePopEffect);
                }
            }
        }
    }

    with (other)
    {
        guardCancel = 2;
        if (object_index != objRainFlush)
        {
            event_user(EV_DEATH);
        }
    }
}
