#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

/*
Flying searchlight enemy. When it catches you, it flips every single conveyer belt it
has access to, which is usually all of them, before flying off.
*/

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "flying";

animTimer = 0;

searchlight = true;
lightTimer = 0;

searchyImage = 0;
lightImage = 0;

phase = 0;

blockCollision = 0;
grav = 0;
init = 1;

image_speed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (init)
{
    init = 0;
}

if (entityCanStep())
{
    switch (phase)
    {
        case 0: // start flying forwards
            calibrateDirection();
            xspeed = 2 * image_xscale;
            phase = 1;
            playSFX(sfxSearchyLight);
            break;
        case 1: // if the player passes through Searchy's light, they've been caught
            if (collision_rectangle(x - 11, y + 11, x + 11, y + 51, target, false, false))
            {
                phase = 2;
            }
            else
            {
                // play Searchy's audio if it isn't playing
                if (!audio_is_playing(sfxSearchyLight))
                {
                    playSFX(sfxSearchyLight);
                }
            }
            break;
        case 2: // stop Searchy's audio and slow to a stop
            if (xspeed != 0)
            {
                xspeed -= 0.1 * image_xscale;
                if (audio_is_playing(sfxSearchyLight))
                {
                    stopSFX(sfxSearchyLight);
                }
            }
            break;
        case 3: // if any conveyer belts exist, flip them backwards
            if (instance_exists(objMM2Conveyor))
                with (objMM2Conveyor)
                    dir = -dir;
            phase = 4;
            break;
        case 4: // speed up and fly off screen
            if (xspeed != 3 || xspeed != -3)
            {
                xspeed += 0.1 * image_xscale;
            }
            break;
    }
}
else if (dead)
{
    animTimer = 0;
    searchyImage = 0;
    phase = 0;
    if (audio_is_playing(sfxSearchyLight))
    {
        stopSFX(sfxSearchyLight);
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (dead || beenOutsideView)
{
    exit;
}

// This code both draws Searchy and controls when it plays the flip sound

draw_sprite(sprSearchy, searchyImage, x, y);

switch (phase)
{
    case 0:
        break;
    case 1:
        lightTimer += 1;
        if (lightTimer >= 2)
        {
            if (lightImage == 1)
            {
                lightImage = 0;
            }
            else
            {
                lightImage = 1;
            }
            lightTimer = 0;
        }
        draw_sprite(sprSearchyLight, lightImage, x, y + 11);
        animTimer += 1;
        if (animTimer >= 6)
        {
            if (searchyImage == 3)
            {
                searchyImage = 0;
            }
            else
            {
                searchyImage += 1;
            }
            animTimer = 0;
        }
        break;
    case 2:
        if (xspeed == 0)
        {
            animTimer += 1;

            if (animTimer >= 3)
            {
                if (searchyImage == 4)
                {
                    searchyImage = 5;
                    phase = 3;
                }
                else
                {
                    searchyImage = 4;
                    playSFX(sfxSearchyFound);
                }
                animTimer = 0;
            }
        }
        else
        {
            animTimer += 1;

            if (animTimer >= 6)
            {
                if (searchyImage == 3)
                {
                    searchyImage = 0;
                }
                else
                {
                    searchyImage += 1;
                }
                animTimer = 0;
            }
        }
        break;
    case 3:
        break;
    case 4:
        animTimer += 1;
        if (animTimer >= 6)
        {
            if (searchyImage == 8)
            {
                searchyImage = 5;
            }
            else
            {
                searchyImage += 1;
            }
            animTimer = 0;
        }
        break;
}
