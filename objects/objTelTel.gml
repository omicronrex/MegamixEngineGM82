#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A weather controlling robot. Depending on its phase and looks, it'll trigger specific weather effects.
event_inherited();

healthpointsStart = 999;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "floating";

blockCollision = 0;
grav = 0;

facePlayer = true;

despawnRange = 48;
respawnRange = 48;

// Enemy-specific variables
sinCounter = 0; // for wave movement

actionTimer = 0;
phase = 0;

image_speed = 0;

canIce = false;

// Tables for what triggers certain weather effects
snowSource[0] = objIceWall;
snowSource[1] = objChillShot;
snowSource[2] = objChillSpikeLanded;
snowSource[3] = objIceSlasher;

clearSource[0] = objSolarBlaze;
clearSource[1] = objPharaohShot;
clearSource[2] = objFlameMixer;
clearSource[3] = objMagneticShockwave;

// "magnetic shockwave is  a magnetic blast, known for frying computers, so it stands to reason it'd reset the tel tel."
// - ACESpark, June 29, 2018
// We are very scientific here at MaGMML3 Incorporated

// Create weather control
if (!instance_exists(objTelTelWeatherControl))
{
    instance_create(view_xview, view_yview, objTelTelWeatherControl);
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // Animation and actioning ROLLED INTO ONE????
    actionTimer+=1;

    switch (phase)
    {
        // Clear weather, not hit
        case 0:
            if (actionTimer == 6)
            {
                image_index += 1;
                if (image_index > 2)
                {
                    image_index = 0;
                }

                actionTimer = 0;
            }
            break;

        // Clear weather, hit
        case 1: // initial fold up
            if (actionTimer == 10)
            {
                image_index = 3;
            }

            if (actionTimer mod 6 == 0 && actionTimer > 10 && image_index < 8)
            {
                image_index += 1;
            }

            // spin around
            if (actionTimer mod 3 == 0 && image_index >= 8)
            {
                image_index += 1;
                if (image_index >= 16)
                {
                    image_index = 16;
                    actionTimer = -60;
                    phase = 2;
                }
            }
            break;

        // Clear weather, fall down
        case 2:
            if (actionTimer > 0)
            {
                grav = 0.25;
                if (actionTimer == 6)
                {
                    image_index += 1;
                    if (image_index > 18)
                    {
                        image_index = 16;
                    }

                    actionTimer = 0;
                }

                // Die if offscreen
                if (y > view_yview[0] + view_hview[0])
                {
                    instance_destroy();

                    // Tel Tel never respawns after this in the original game.
                }
            }
            break;

        // Rainy weather, not hit
        case 3:
            if (actionTimer == 6)
            {
                image_index += 1;
                if (image_index > 18)
                {
                    image_index = 16;
                }

                actionTimer = 0;
            }
            break;

        // Rainy weather, hit
        case 4:
            if (actionTimer mod 8 == 0)
            {
                if (image_index < 21)
                {
                    image_index += 1;
                }
                else
                {
                    // fall down like a loser
                    grav = 0.25;
                }
            }

            // Die if offscreen
            if (y > view_yview[0] + view_hview[0])
            {
                instance_destroy();

                // Tel Tel never respawns after this in the original game.
            }
            break;

        // Snowy weather, clear
        case 5: // Absolutely nothing
            break;

        // Snowy weather, hit
        case 6:
            if (actionTimer mod 6 == 0 && image_index > 0 && actionTimer > 0)
            {
                image_index -= 1;
                if (image_index == 17)
                {
                    image_index = 8;
                    actionTimer = -60;
                }
            }

            if (image_index == 0)
            {
                grav = 0.25;
            }

            // Die if offscreen
            if (y > view_yview[0] + view_hview[0])
            {
                instance_destroy();

                // Tel Tel never respawns after this in the original game.
            }
            break;
    }

    // Wave movement
    if (phase == 0 || phase == 3 || phase == 5)
    {
        sinCounter += .075;
        yspeed = -(sin(sinCounter) * 1.375);
    }
}
else if (dead)
{
    phase = 0;
    sinCounter = 0;
    image_index = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// Make sure he never dies.
healthpoints += global.damage;

// Don't change weather if the tel tel isn't in a base phase
if (phase != 0 && phase != 3 && phase != 5)
{
    exit;
}

// different reactions
switch (global.telTelWeather)
{
    // Clear weather
    case 0: // Anything can trigger rainy weather
        global.telTelWeather = 1;

        // start up animation
        with (objTelTelWeatherControl)
        {
            animTimer = 0;
        }

        // activate all tel tels onscreen
        with (objTelTel)
        {
            if (!dead)
            {
                image_index = 0;
                phase = 1;
                actionTimer = -20;

                yspeed = 0;
                sinCounter = 0;
                respawn = false;
            }
        }
        break;

    // Go to snow
    case 1: // Ice weapons trigger snowy weather
        var i; for ( i = 0; i < array_length_1d(snowSource); i+=1)
        {
            if (other.object_index == snowSource[i])
            {
                global.telTelWeather = 2;

                // start up animation
                with (objTelTelWeatherControl)
                {
                    animTimer = 0;
                    darkenAlpha = (3 / 4);
                    playSFX(sfxMenuSelect);
                    stopSFX(sfxTelTelRain);
                }

                with (objTelTel)
                {
                    if (!dead)
                    {
                        image_index = 18;
                        phase = 4;
                        actionTimer = 0;

                        yspeed = 0;
                        sinCounter = 0;
                        respawn = false;
                    }
                }
            }
        }
        break;

    // Go to clear
    case 2: // Fire weapons clear snowy weather
        var i; for ( i = 0; i < array_length_1d(clearSource); i+=1)
        {
            if (other.object_index == clearSource[i])
            {
                // activate all tel tels onscreen
                with (objTelTel)
                {
                    if (!dead)
                    {
                        image_index = 21;
                        phase = 6;
                        actionTimer = 0;

                        yspeed = 0;
                        sinCounter = 0;
                        respawn = false;
                    }
                }

                playSFX(sfxSearchyFound);

                global.telTelWeather = 0;
            }
        }
        break;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// if there's rain, there's rain!
if (place_meeting(x, y, objToadRain))
{
    global.telTelWeather = 1;
}

// Force phases depending on the weather
if (global.telTelWeather == 0)
{
    phase = 0;
    image_index = 0;
}
else if (global.telTelWeather == 1)
{
    phase = 3;
    image_index = 16;
}
else if (global.telTelWeather == 2)
{
    phase = 5;
    image_index = 21;
}
