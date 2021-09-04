#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// The base of their pole vault is invulnerable to attack and shields them while they charge Mega Man.
// The pole vault can be destroyed once the Bubukan dismount.
event_inherited();

healthpointsStart = 4;
healthpoints = healthpointsStart;
contactDamage = 4;

facePlayerOnSpawn = true;

// enemy specific
phase = 0;
radius = 4.5 * 16;
landingWait = 10;
landingWaitTimer = landingWait;

runSpd = 2;
jumpSpd = 1.5;

imgSpd = 0.15;
runCycleBack = false;
imgIndex = 0;

//@cc 0 = blue; 1 = orange;
col = 0;

init = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{
    init = 0;
    switch (col)
    {
        case 0:
            sprite_index = sprBubukanOrange;
            break;
        case 1:
            sprite_index = sprBubukanRed;
            break;
    }
}

event_inherited();
if(xcoll!=0)
{
    xspeed=xcoll;
}


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
            if (!runCycleBack)
            {
                imgIndex += imgSpd;
                if (imgIndex >= 3)
                {
                    imgIndex = 2 - imgSpd;
                    runCycleBack = true;
                }
            }
            else
            {
                imgIndex -= imgSpd;
                if (imgIndex < 0)
                {
                    imgIndex = 1 + imgSpd;
                    runCycleBack = false;
                }
            }

            // detect mega man
            if (instance_exists(target))
            {
                if (abs(target.x - x) <= radius)
                {
                    phase = 2;
                    imgIndex = 3;
                    runCycleBack = false;
                    xspeed = 0;
                }
            }
            break;
        case 2: // pole vaulting
            imgIndex += imgSpd * 0.8;
            if (imgIndex >= 5)
            {
                phase = 3;
                xspeed = jumpSpd * image_xscale;
                yspeed = -6; // <-=1 jump speed
                ground = 0;
                pole = instance_create(x + sprite_width * 0.6, y, objBubukanPole); // sprite_width becomes negative if xscale is negative
                pole.image_xscale = image_xscale;
            }
            break;
        case 3: // flying through the air
            imgIndex += imgSpd;
            if (imgIndex >= 9)
            {
                imgIndex = 5 + (imgIndex - 9);
            }

            if (ground)
            {
                phase = 4;
                xspeed = 0;
                imgIndex = 10; // thought it looked better as a standing sprite
            }
            break;
        // waiting a moment after landing
        case 4: // note: in the original game it did its running animation in place during the pause after landing, but that's a little odd, so I didn't do it
            if (landingWaitTimer > 0)
            {
                landingWaitTimer -= 1;
            }
            else
            {
                phase = 5;
                calibrateDirection();
                xspeed = runSpd * image_xscale;
            }
            break;
        case 5: // running around
            if (!runCycleBack)
            {
                imgIndex += imgSpd;
                if (imgIndex >= image_number)
                {
                    imgIndex = image_number - 1 - imgSpd;
                    runCycleBack = true;
                }
            }
            else
            {
                imgIndex -= imgSpd;
                if (imgIndex < 9)
                {
                    imgIndex = 10 + imgSpd;
                    runCycleBack = false;
                }
            }
            break;
    }

    // turn around if a wall is run into
    if (xspeed == 0 && (phase == 1 || phase == 3 || phase == 5))
    {
        image_xscale = -image_xscale;
        if (phase == 1 || phase == 5)
        {
            xspeed = runSpd * image_xscale;
        }

        if (phase == 3)
        {
            xspeed = jumpSpd * image_xscale;
        }
    }
}
else if (dead)
{
    phase = 0;
    landingWaitTimer = landingWait;

    imgIndex = 0;
    runCycleBack = false;
}

image_index = imgIndex div 1;
