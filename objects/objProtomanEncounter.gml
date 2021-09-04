#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// performs two functions.
// 1: blows up terrain (use boss barriers), as in mega man 3.
// 2: drops items like Eddie (set itemDrop variable), as in mega man V gb.

event_inherited();

grav = 0;
blockCollision = 0;

facePlayerOnSpawn = true;

image_index = 1;

introType = 0;

animTimer = 0;
phase = 0;
startIntro = true;

// set this to something in creation code if desired
itemDrop = -1;
protoLock = false;

// @cc if true, protoman will go away instantly when he does his thing instead of waiting
instantLeave = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    with (objBossBarrier)
    {
        delay = 24;
    }

    if (startIntro)
    {
        protoLock = lockPoolLock(global.playerLock[PL_LOCK_MOVE],
                    global.playerLock[PL_LOCK_SLIDE],
                    global.playerLock[PL_LOCK_SHOOT],
                    global.playerLock[PL_LOCK_TURN],
                    global.playerLock[PL_LOCK_CHARGE],
                    global.playerLock[PL_LOCK_CLIMB],
                    global.playerLock[PL_LOCK_JUMP],
                    global.playerLock[PL_LOCK_PAUSE],
                    global.playerFrozen);

        with (objMegaman)
        {
            isSlide = false;
            slideLock = lockPoolRelease(slideLock);
            slideChargeLock = lockPoolRelease(slideChargeLock);
            mask_index = mskMegaman;
            xspeed = 0;
            yspeed = 0;
            if (x < other.x)
            {
                image_xscale = 1;
            }
            else
            {
                image_xscale = -1;
            }
            /*if (abs(other.maxFanOutDistance) > 0)
            {
                playerFanOut(20 * image_xscale, other.maxFanOutDistance);
            }*/
        }

        stopMusic();
        playSFX(sfxWhistle);
        visible = false;
        y = view_yview[0] + 8;
        startIntro = false;
    }
    if (phase == 2)
    {
        y -= 8;
        if (y < view_yview[0] - 16)
        {
            instance_destroy();
        }
    }
    else if (y < ystart) // descend
    {
        if !audio_is_playing(sfxWhistle)
        {
            y += 8;
            visible = true;
        }
    }
    else
    {
        y = ystart;

        if (phase == 0)
        {
            animTimer++;
            if animTimer == 1
            {
                playSFX(sfxTeleportIn);
            }
        }
        else
        {
            animTimer--;
        }

        image_index = 3 - (animTimer div 4 mod 2);

        if (animTimer > 16)
        {
            image_index = 0;
            if (animTimer > 150)
            {
                animTimer = 15;
                phase = 1;
            }

            // item dropping
            if (itemDrop != -1 && animTimer == 100)
            {
                with (instance_create(x, y, itemDrop))
                {
                    xspeed = other.image_xscale * 1.5;
                    yspeed = -3;
                }

                // there he goes
                if instantLeave
                {
                    animTimer = 151;
                }
            }
            // break blocks
            else if (itemDrop == -1 && animTimer == 75)
            {
                with (objBossBarrier)
                {
                    delay = 0;
                    event_user(0);
                    playSFX(sfxExplosion);
                }

                // there he goes 2
                if instantLeave
                {
                    animTimer = 151;
                }
            }
        }

        if (animTimer < 0)
        {
            image_index = 1;
            phase = 2;
            playSFX(sfxTeleportOut);

            resumeMusic();
            lockPoolRelease(protoLock);
        }
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 2;
