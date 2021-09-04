#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/* NOTE: the depth is -5 so that it appears in front of things in the editor that it's meant to appear behind
in-game. I set the depth back to 0 here in the creation code. */

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "floating";

blockCollision = 0;
grav = 0;

// Enemy specific code

//@cc true = drop in enterance from a shoot (default); false = just appears like any other enemy
dropIn = true;

radius = 6 * 16;

phase = 0;
startY = 0;
spd = 1;
sinCounter = 0;
shootWait = 10;
shootWaitTimer = 0;

imgSpd = 0.2;
imgIndex = 0;

depth = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    switch (phase)
    {
        case 0: // begin stuff
            if (instance_exists(target))
            {
                calibrateDirection();

                // Elec'n falls down before continuing forward, but only if spawned from a spawner that would set respawn to false
                if (dropIn)
                {
                    startY = y;
                    visible = 0;

                    if (abs(target.x - x) <= radius)
                    {
                        phase = 1;
                        visible = 1;
                        grav = 0.25;
                    }
                }
                else
                {
                    phase = 2;
                }
            }
            break;
        case 1: // dropping in
            if (!dropIn || y - startY >= 48)
            {
                // <-=1 drop distance
                phase = 2;
                xspeed = spd * image_xscale;
                yspeed = 0;
                grav = 0;
            }
            break;
        case 2: // detect mega man to shoot (deliberately doesn't break to also execute the moving phase)
            if (instance_exists(target))
            {
                if ((image_xscale > 0 && x >= target.x) || (image_xscale < 0 && x <= target.x))
                {
                    phase = 3;
                    xspeed = 0;
                    yspeed = 0;
                    x = target.x; // just to align it properly so it definitely shoots directly above megaman
                }
            }
            break;
        case 3: // shooting
            if (shootWaitTimer == 0)
            {
                var a;
                for (a = 0; a <= 360; a += 45)
                {
                    spark = instance_create(x, y - sprite_height * 0.4, objElecnSpark);
                    spark.direction = a;
                }
                playSFX(sfxElecnShoot);
            }

            if (shootWaitTimer < shootWait)
            {
                shootWaitTimer += 1;
            }
            else
            {
                phase = 4;
                xspeed = spd * image_xscale;
            }
            break;
        case 4: // moving
            break;
    }

    if (phase == 4 || phase == 2)
    {
        sinCounter += 0.1;
        yspeed = -(cos(sinCounter) * 1);
    }

    // animation
    if (phase != 3)
    {
        imgIndex += imgSpd;
        if (imgIndex >= 3)
        {
            imgIndex = imgIndex mod 3;
        }
    }
    else
    {
        imgIndex = 3;
    }
}
else if (dead)
{
    phase = 0;
    first = true;
    shootWaitTimer = 0;
    sinCounter = 0;
    grav = 0;
}

image_index = imgIndex div 1;
