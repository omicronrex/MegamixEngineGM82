#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "grounded, nature";

facePlayerOnSpawn = true;

// enemy specific
imgSpd = 0.1;
imgIndex = 0;
waitTime = 35;
waitTimer = waitTime;

xSpd = 2.5;
ySpd = 3.6;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // face player when first coming on screen
    if (waitTimer == waitTime)
    {
        calibrateDirection();
    }

    if (waitTimer > 0)
    {
        // waiting to jump
        waitTimer -= 1;

        imgIndex += imgSpd;
        if (imgIndex >= 2)
        {
            imgIndex = imgIndex mod 1;
        }
    }
    else
    {
        // jumping
        if (waitTimer == 0)
        {
            // jumping animation
            if (imgIndex < 2)
            {
                imgIndex = 2;
            }

            if (imgIndex < 3)
            {
                // don't loop animation
                imgIndex += imgSpd * 2;
            }
            else
            {
                // start jump
                waitTimer = -1; // I reused waitTimer as a boolean  xP

                calibrateDirection();
                xspeed = xSpd * image_xscale;
                yspeed = -ySpd;
                ground = false; // It'll constantly catch on the ground when trying to jump if you don't do this
                imgIndex = 3;

                playSFX(sfxSpring);
            }
        }
        else if (ground && !place_meeting(x, y + sign(grav), objSpring))
        {
            // landing
            if (waitTimer == -1)
            {
                waitTimer = -2; // I reused it as a boolean again

                xspeed = 0;
                yspeed = 0;
                imgIndex = 3;
            }

            imgIndex -= imgSpd * 2; // landing animation is faster than jumping animation

            if (imgIndex <= 1)
            {
                waitTimer = waitTime;
                imgIndex = 0;
            }
        }
        else if (waitTimer == -1 && xspeed == 0)
        {
            // turn around if a wall is run into while jumping
            image_xscale = -image_xscale;
            xspeed = xSpd * image_xscale;
        }
    }
}
else if (dead)
{
    imgIndex = 0;
    waitTimer = waitTime;
    xspeed = 0;
    yspeed = 0;
}

if (imgIndex < 2)
{
    sprite_index = sprBatabattanIdle;
    image_index = imgIndex div 1;
}
else
{
    if (imgIndex div 1 == 2)
    {
        sprite_index = sprBatabattanJump1;
        image_index = 0;
    }

    if (imgIndex div 1 == 3)
    {
        sprite_index = sprBatabattanJump2;
        image_index = 0;
    }
}
