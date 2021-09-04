#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// col = <number> (0 = red (default); 1 = yellow)

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
ogContactDamage = 3;
contactDamage = 0;

category = "aquatic, nature";

blockCollision = false;
grav = 0;
inWater = -1; // isn't effected by water

// Enemy specific code
col = 0;
init = 1;

phase = 0;
timer = 0;

imgIndex = 0;
imgSpd = 0.16;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{
    init = 0;
    if (col == 1)
    {
        sprite_index = sprGabgyoJumpYellow;
    }
}

if (phase != 1)
{
    visible = false;
    canHit = false;
    contactDamage = 0;
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
        // wait to jump
        case 0:
            if (instance_exists(target))
            {
                if (abs(target.x - x) < 32) // <-- detection range here
                {
                    phase = 1;

                    calibrateDirection();

                    visible = true;
                    canHit = true;
                    grav = gravAccel;
                    contactDamage = ogContactDamage;

                    playSFX(sfxSplash);

                    if (instance_exists(target))
                    {
                        yspeed = ySpeedAim(y, target.y, grav);
                        yspeed -= 0.8; // little extra height
                    }
                }
            }

            break;

        // jumping
        case 1:
            imgIndex += imgSpd;
            if (yspeed < 0)
            {
                if (imgIndex >= 2)
                {
                    imgIndex = imgIndex mod 2;
                }
            }
            else
            {
                if (imgIndex >= 4)
                {
                    imgIndex = 2 + imgIndex mod 4;
                }
            }
            if (y + yspeed >= ystart)
            {
                phase = 2;

                x = xstart;
                y = ystart;
                xspeed = 0;
                yspeed = 0;
                grav = 0;

                visible = false;
                imgIndex = 0;
            }

            break;

        // cooldown
        case 2:
            timer += 1;
            if (timer >= 90)
            {
                phase = 0;
                timer = 0;
            }

            break;
    }
}
else if (dead)
{
    if (phase == 1)
    {
        timer += 1;
        if (timer >= 96)
        {
            phase = 0;
            timer = 0;

            dead = false;
            beenOutsideView = false;
        }
    }

    grav = 0;
    imgIndex = 0;
}

image_index = imgIndex div 1;
