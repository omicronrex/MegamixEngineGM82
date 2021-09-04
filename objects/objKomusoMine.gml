#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

timerReset = 60;
countTimer = timerReset;
explode = false;
activated = false;
soundEffect = false;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    if (activated)
    {
        countTimer -= 2;
        if (countTimer mod 10 == 0 && !soundEffect && countTimer != timerReset)
        {
            playSFX(sfxCountBomb);
            soundEffect = true;
        }
        else
        {
            soundEffect = false;
        }

        if (countTimer == -10 && !explode)
        {
            explode = true;
            instance_create(spriteGetXCenter(), spriteGetYCenter(),
                objHarmfulExplosion);
            playSFX(sfxMM3Explode);
            dead = true;
        }

        image_index = (60 - countTimer) / 10;
    }
    else
    {
        with (objMegaman)
        {
            if (ground)
            {
                if (place_meeting(x, y + gravDir, other.id))
                {
                    other.activated = true;
                }
            }
        }
    }
}
else if (dead)
{
    countTimer = timerReset;
    explode = false;
    activated = false;
    soundEffect = false;
    image_index = 0;
}
