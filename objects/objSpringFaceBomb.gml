#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = true;

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 3;

facePlayerOnSpawn = true;

// Enemy specific
xspeed = 0;
yspeed = 0;
ground = 1;
preGround = true;

phase = 0;
waitTimer = 0;
xs = 0;

animBack = false;
imgSpd = 0.35;
imgIndex = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if(xcoll!=0)
{
    xspeed=xcoll;
}

if (entityCanStep())
{
    if (!preGround && ground)
    {
        playSFX(sfxBikkyLand);
        xspeed = 0;
        if (phase == 2)
        {
            phase = 3;
            imgIndex = 1;
        }
    }

    switch (phase)
    {
        // wait
        case 0:
            if (ground && instance_exists(target))
            {
                waitTimer += 1;
                if (waitTimer >= 24) // <--wait time between jumps here
                {
                    waitTimer = 0;
                    phase = 1;
                    calibrateDirection();
                }
            }

            break;

        // spring animation before jumping
        case 1:
            if (!animBack)
            {
                imgIndex += imgSpd;
                if (imgIndex >= 3)
                {
                    imgIndex = 2 - imgIndex mod 3;
                    animBack = true;
                }
            }
            else
            {
                imgIndex -= imgSpd;
                if (imgIndex < 0)
                {
                    imgIndex = 4 + imgIndex;
                    waitTimer = 1; // used wait timer as a boolean    :P
                }

                if (waitTimer == 1 && imgIndex < 3)
                {
                    phase = 2;
                    yspeed = -3.4; // <-- jump speed here
                    animBack = false;
                    imgIndex = 0;
                    xspeed = 2 * image_xscale;
                }
            }

            break;

        // land
        case 3:
            if (!animBack)
            {
                imgIndex += imgSpd;
                if (imgIndex >= 3)
                {
                    imgIndex = 2 - imgIndex mod 3;
                    animBack = true;
                }
            }
            else
            {
                imgIndex -= imgSpd;
                if (imgIndex < 0)
                {
                    phase = 0;
                    imgIndex = 0;
                    animBack = false;
                }
            }
            break;
    }

    preGround = ground;
}
else if (dead)
{
    phase = 0;
    waitTimer = 0;
    animBack = false;
    imgIndex = 0;
    preGround = true;
}

image_index = imgIndex div 1;
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

a = instance_create(x, y - 8, objSpringFaceBombHead);
a.visible = true;
