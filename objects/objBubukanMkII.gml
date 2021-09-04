#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A modified version of Bubukan. Invincible until you approach it, where it will then spring past you
// and freak out on the ground, before springing back at you.
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 5;

facePlayerOnSpawn = true;

// enemy specific
phase = 0;
radius = 2.5 * 16;

landingWait = 45;
landingWaitTimer = landingWait;

runSpd = 1.75;
jumpSpd = 2;

runCycleBack = false;

animTimer = 0;
image_speed = 0;
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
        case 0: // start towards player
            if (instance_exists(target))
            {
                xspeed = runSpd * image_xscale;
                phase = 1;
            }
            break;
        case 1: // approaching the player
            animTimer+=1;

            if (animTimer == 7)
            {
                image_index+=1;
                if (image_index > 3)
                {
                    image_index = 0;
                }

                animTimer = 0;
            }

            // detect mega man
            if (instance_exists(target))
            {
                if (abs(target.x - x) <= radius)
                {
                    phase = 2;
                    image_index = 4;
                    animTimer = 0;
                    runCycleBack = false;
                    xspeed = 0;
                }
            }
            break;
        case 2: // pole vaulting
            animTimer+=1;

            if (animTimer >= 8)
            {
                phase = 3;
                xspeed = jumpSpd * image_xscale;
                yspeed = -5.5; // <-=1 jump speed
                ground = 0;

                image_index = 5;
                animTimer = 0;

                pole = instance_create(x, y + 8, objBubukanPole); // sprite_width becomes negative if xscale is negative
                pole.image_xscale = image_xscale;
                pole.sprite_index = sprBubukanMkIIFeet;
            }
            break;
        case 3: // flying through the air
            animTimer+=1;

            if (animTimer >= 10)
            {
                image_index+=1;
                animTimer = 0;

                if (image_index > 8)
                {
                    image_index = 5;
                }
            }

            if (ground)
            {
                phase = 4;
                xspeed = 0;
                image_index = 9; // tigger time
                animTimer = 0;
                calibrateDirection();
            }
            break;
        // waiting a moment after landing
        case 4: // insert FUNNY ace spark motion sickness joke here
            animTimer+=1;

            if (animTimer >= 5)
            {
                animTimer = 0;
                image_index+=1;

                if (image_index > 12)
                {
                    image_index = 9;
                }
            }

            if (landingWaitTimer > 0)
            {
                landingWaitTimer -= 1;
            }
            else
            {
                calibrateDirection();
                phase = 5;
                xspeed = jumpSpd * image_xscale;
                yspeed = -1.75;
                image_index = 13;
            }
            break;
        case 5: // running around
            if (landingWaitTimer > 0)
            {
                landingWaitTimer -= 1;
            }

            // wait on ground
            if (ground)
            {
                if (image_index == 13)
                {
                    landingWaitTimer = 10;
                    image_index = 9;
                    xspeed = 0;
                }

                if (landingWaitTimer == 0)
                {
                    xspeed = jumpSpd * image_xscale;
                    yspeed = -1.75;
                    image_index = 13;
                    ground = false;
                }
            }
            break;
    }

    // turn around if a wall is run into
    if (xspeed == 0 && (phase == 1 || phase == 3 || phase == 5) && image_index != 9)
    {
        image_xscale = -image_xscale;
        if (phase == 1)
        {
            xspeed = runSpd * image_xscale;
        }

        if (phase == 3 || phase == 5)
        {
            xspeed = jumpSpd * image_xscale;
        }
    }
}
else if (dead)
{
    phase = 0;
    landingWaitTimer = landingWait;

    image_index = 0;
    animTimer = 0;
    runCycleBack = false;
}
