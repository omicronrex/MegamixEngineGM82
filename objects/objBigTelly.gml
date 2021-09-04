#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 4;
healthpoints = healthpointsStart;
contactDamage = 5;

category = "floating";

blockCollision = 0;
grav = 0;

// Enemy specific code
variation = -1; // automatically changes to 0 if you encounter it on foot, and to 1 if you encounter it on the sled

phase = 0;
timer = 0;
moveWait = 50;
riseAndFallWait = 25;
dropWait = 15;
dropCount = 0;
megaX = 0;

xSpd = 1.15;
ySpd = 1.1;

imgSpd = 0.2;
imgIndex = 0;
dir = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (variation == -1 && instance_exists(target))
    {
        variation = instance_exists(target.vehicle);
    }

    if (variation == 0)
    {
        // encountered when on the ground

        switch (phase)
        {
            // start movement towards mega man
            case 0:
                event_user(0); // face mega man
                xspeed = xSpd * dir;
                phase = 1;
                break;

            // wait to move down
            case 1:
                timer += 1;
                if (timer >= moveWait)
                {
                    phase = 2;
                    timer = 0;
                    yspeed = ySpd;
                }
                break;

            // descend
            case 2:
                timer += 1;
                if (timer >= riseAndFallWait)
                {
                    phase = 3;
                    timer = 0;
                    yspeed = 0;
                }
                break;

            // drop bombs
            case 3:
                timer += 1;
                if (timer >= dropWait)
                {
                    timer = 0;
                    instance_create(x, y + sprite_height / 2, objBigTellyBomb);
                    playSFX(sfxEnemyShoot);
                    dropCount += 1;
                }
                if (dropCount >= 8) // <-- number of bombs dropped here
                {
                    phase = 4;
                    dropCount = 0;
                    timer = 0;
                    yspeed = -ySpd;
                }
                break;

            // ascend
            case 4:
                timer += 1;
                if (timer >= riseAndFallWait)
                {
                    phase = 5;
                    timer = 0;
                    xspeed = 0;
                    yspeed = 0;
                }
                break;

            // wait for a bit, then decide what to do next. Note: this part is innacurate to the original behavior, but the original was indecipherable, so   :P
            case 5:
                timer += 1;
                if (timer >= 100) // <-- wait time after stopping here
                {
                    timer = 0;

                    prevDir = dir;
                    event_user(0); // face mega man

                    if (dir
                        != prevDir) // if turning around, then drop bombs again
                    {
                        phase = 1;
                        xspeed = xSpd * dir;
                    }
                    else // if not turning around, then keep going forward to off-screen
                    {
                        phase = 6;
                        xspeed = xSpd * dir;
                    }
                }

            // go off-screen
            case 6: // don't need to do anything here    :P
                break;
        }
    }
    else if (variation == 1)
    {
        // encountered when on the sled

        switch (phase)
        {
            // start facing mega man
            case 0:
                event_user(0); // face mega man
                xspeed = xSpd * dir;
                phase = 1;
                break;

            // fly over mega man
            case 1:
                if (instance_exists(target))
                {
                    if ((x <= target.x && dir == -1)
                        || (x >= target.x && dir == 1))
                    {
                        megaX = target.x - view_xview;
                        x = view_xview + megaX;
                        xspeed = 0;
                        phase = 2;
                    }
                }
                break;

            // wait for a tiny big before dropping bombs
            case 2:
                x = view_xview + megaX;
                timer += 1;
                if (timer >= 12) // <-- grace wait time here
                {
                    phase = 3;
                    timer = 0;
                }
                break;

            // drop bombs
            case 3:
                x = view_xview + megaX;
                timer += 1;
                if (timer >= dropWait * 0.6)
                {
                    timer = 0;
                    bomb = instance_create(x, y + sprite_height / 2,
                        objBigTellyBomb);
                    bomb.megaX = megaX;
                    playSFX(sfxEnemyShoot);
                    dropCount += 1;
                }
                if (dropCount >= 10) // <-- amount of bombs dropped here
                {
                    phase = 4;
                    timer = 0;
                    dropCount = 0;
                    megaX = 0;
                    xspeed = xSpd * dir;
                }
                break;

            // fly away
            case 4: // don't need to do anything here   :P
                break;
        }
    }

    // animation
    imgIndex += imgSpd * dir;
    if (imgIndex < 0)
    {
        imgIndex = 7.99;
    }

    if (imgIndex >= 8)
    {
        imgIndex = 0;
    }
}
else if (dead == true)
{
    variation = -1;
    phase = 0;
    timer = 0;
    dropCount = 0;
    megaX = 0;

    xspeed = 0;
    yspeed = 0;

    imgIndex = 0;
}

image_index = imgIndex div 1;
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=change direction
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (instance_exists(target))
{
    if (target.x < x)
    {
        dir = -1;
    }
    else
    {
        dir = 1;
    }
}
