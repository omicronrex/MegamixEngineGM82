#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A lotto wheel enemy from Mars's stage that spins, tosses bombs, and jumps towards you.
// While spinning, it reflects non-piercing weapons.

event_inherited();

healthpointsStart = 6;
contactDamage = 6;
facePlayerOnSpawn = true;

category = "semi bulky";

phase = 0;
imgIndex = 0;
imgSpd = 0.2;
animBack = false;
moveTimer = 60;
spinTimer = 120;
jumps = 0;
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
        // spawn and Spin
        case 0:
        moveTimer-=1;
        if (moveTimer <= 0)
        {
            spinTimer-=1;

            if (spinTimer > 0)
            {
                if (animBack == false)
                {
                    imgIndex += imgSpd;
                    if (imgIndex >= 4)
                    {
                        imgIndex = 2;
                        animBack = true;
                        }
                    }
                    else
                    {
                        imgIndex -= imgSpd;
                        if (imgIndex < 1)
                        {
                            imgIndex = 2;
                            animBack = false;
                        }
                    }
                }
                else
                {
                    imgIndex = 0;
                    phase = 1;
                    moveTimer = 60;
                    spinTimer = 120;
                    animBack = false;
                }
            }
            break;
        // Toss bomb
        case 1:
            imgIndex += imgSpd;
            if (imgIndex == 1)
            {
                imgIndex = 4;
            }
            if (imgIndex == 4)
            {
                var i; i = instance_create(x + 8 * image_xscale, y - 4, objBikkyBombBall);
                i.yspeed = -4;
                i.image_xscale = image_xscale;
                playSFX(sfxEnemyDrop);
            }
            if (imgIndex >= 5)
            {
                imgIndex = 0;
                phase = 2;
            }
            break;
        // Jump
        case 2:
            moveTimer-=1;
            if (moveTimer <= 0)
            {
                if (jumps < 3)
                {
                    yspeed = -4;
                    xspeed = 1 * image_xscale;
                    phase = 3;
                    calibrateDirection();
                }
                else
                {
                    phase = 0;
                    jumps = 0;
                    calibrateDirection();
                }
            }
            break;
        // In Air
        case 3:
            if (!ground)
            {
                if (yspeed >= 0)
                {
                    if (imgIndex != 6)
                    {
                        imgIndex += imgSpd;
                        if (imgIndex == 1)
                        {
                            imgIndex = 5;
                        }
                    }
                }
            }
            else
            {
                phase = 4;
                imgIndex = 0;
                xspeed = 0;
                jumps+=1;
            }
            break;
        // Landing animation
        case 4:
            imgIndex += imgSpd;
            if (imgIndex == 1)
            {
                imgIndex = 5;
            }
            if (imgIndex == 6)
            {
                imgIndex = 0;
                phase = 2;
                moveTimer = 60;
            }
            break;
    }
}
else if (dead)
{
    healthpoints = healthpointsStart;
    phase = 0;
    imgIndex = 0;
    animBack = false;
    moveTimer = 60;
    spinTimer = 120;
    jumps = 0;
}
image_index = imgIndex div 1;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if ((image_index > 0) && (image_index < 4))
{
    other.guardCancel = 1;
}
