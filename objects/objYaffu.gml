#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 5;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "semi bulky";

facePlayerOnSpawn = true;

// enemy specific code
phase = 0;
pullDuration = 90;
pullDurationExtra = 40;
pullTimer = 0;
pullSpd = -1.1;
pullDir = 1;

turnSet = 1;
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
        // pull/push
        case 0:
            pullTimer += 1;
            currentPullSpd = 0;
            if (pullTimer < pullDuration)
            {
                currentPullSpd = pullSpd;
                imgIndex += imgSpd;
            }
            else if (pullTimer < pullDuration + pullDurationExtra)
            {
                currentPullSpd = pullSpd / 2;
                imgIndex += imgSpd * 0.4;
            }
            else
            {
                phase = 1;
                pullTimer = 0;
                if (pullDir > 0)
                {
                    imgIndex = 3;
                }
                else
                {
                    imgIndex = 10;
                }
                break;
            }
            if (pullDir > 0 && imgIndex >= 3)
            {
                imgIndex = 0;
            }
            else if (pullDir < 0 && imgIndex >= 10)
            {
                imgIndex = 7;
            }
            with (objMegaman)
            {
                playerBlow(other.currentPullSpd * other.pullDir * other.image_xscale);
            }
            break;

        // turn around
        case 1:
            imgIndex += imgSpd * 0.4;
            if (pullDir > 0 && imgIndex >= 7)
            {
                phase = 0;
                pullDir = -1;
                imgIndex = 7;
            }
            else if (imgIndex >= 14)
            {
                phase = 0;
                pullDir = 1;
                imgIndex = 0;
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
}

image_index = imgIndex div 1;
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
instance_create(bboxGetXCenter(),bboxGetYCenter(),objBigExplosion);
playSFX(sfxExplosion2);
