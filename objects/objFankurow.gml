#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A robot owl that pulls Mega Man towards it with its fan, before pushing him back with its wings.

event_inherited();

healthpointsStart = 5;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "semi bulky, bird, nature";

facePlayerOnSpawn = true;
facePlayer = true;

// enemy specific code
phase = 0;
moveTimer = 30;
pullDuration = 120;
pullTimer = 0;
pullSpd = -0.5;
pullDir = 1;

animBack = true;
imgSpd = 0.4;
imgIndex = 0;
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
        // Idle
        case 0:
            moveTimer-=1;
            if (moveTimer <= 0)
            {
                phase = 1;
            }
            break;
        // Pull
        case 1:
            if (pullTimer < pullDuration)
            {
                pullTimer+=1;
                pullDir = 1;

                imgIndex += imgSpd;
                if (imgIndex >= 4)
                {
                    imgIndex = 1;
                }
            }
            else
            {
                phase = 2;
                imgIndex = 5;
            }
            break;
        // Push
        case 2:
            if (pullTimer != 0)
            {
                pullTimer-=1;
                pullDir = -1;

                if (animBack == true)
                {
                    imgIndex -= imgSpd;
                    if (imgIndex < 4)
                    {
                        imgIndex = 5;
                        animBack = false;
                    }
                }
                else
                {
                    imgIndex += imgSpd;
                    if (imgIndex >= 7)
                    {
                        imgIndex = 5;
                        animBack = true;
                    }
                }
            }
            else
            {
                if (imgIndex < 7)
                {
                    imgIndex += imgSpd;
                }
                else
                {
                    imgIndex = 0;
                    phase = 0;
                    moveTimer = 30;
                    animBack = true;
                }
            }
            break;
    }


}
else if (dead)
{
    phase = 0;
    pullDir = 1;
    pullTimer = 0;
    imgIndex = 0;
    moveTimer = 30;
    animBack = true;
}











image_index = imgIndex div 1;
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if(entityCanStep())
{
    if (phase != 0)
    {
        with (objMegaman)
        {
            if(!teleporting && readyTimer==0)
                playerBlow(other.pullSpd * other.pullDir * other.image_xscale);
        }
    }
}
