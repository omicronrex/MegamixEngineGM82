#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;
isSolid = 1;

hasSwitch = false;

respawnRange = -1;
despawnRange = -1;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

spineKiller = true;
goingDown = -1; // -1 = Up; 1 = Down
myFlag = 0;

// List of Gabyoall-type enemies.
spinesToKill[0] = objGagabyoall;
spinesToKill[1] = objSprinklan;
spinesToKill[2] = objSpringHead;
spinesToKill[3] = objGaryoby;
spinesToKill[4] = objSpine;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!hasSwitch)
{
    with (objSwitchHandler)
    {
        if (myFlag == other.myFlag)
        {
            other.hasSwitch = true;
        }
    }
}

event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    if (hasSwitch)
    {
        if (global.flagParent[myFlag].active)
        {
            // Gabyoall-type killing time upon activation.
            if (spineKiller)
            {
                spineKiller = false;
                with (objElectricGabyoall)
                {
                    if (place_meeting(x, y - 1 * image_yscale, other) && !dead)
                    {
                        // Need to figure out how to make this not repeat when dead.
                        event_user(EV_DEATH);
                        playSFX(sfxEnemyHit);
                    }
                }
                with (objCyberGabyoall)
                {
                    if (place_meeting(x, y + sprite_height + 1 * image_yscale, other)
                        && !dead)
                    {
                        event_user(EV_DEATH);
                        playSFX(sfxEnemyHit);
                    }
                }
                var i; for ( i = 0; i < array_length_1d(spinesToKill); i+=1)
                {
                    with (spinesToKill[i])
                    {
                        if (place_meeting(x, bbox_bottom + 2, other) && !dead)
                        {
                            event_user(EV_DEATH);
                            playSFX(sfxEnemyHit);
                        }
                    }
                }
            }

            image_speed = 1 / 8 * global.flagParent[myFlag].elecDirec;
            yspeed = goingDown * global.flagParent[myFlag].elecDirec * 0.8;
            if (y + 64 < global.sectionTop)
            {
                y = global.sectionBottom;
            }
            if (y > global.sectionBottom)
            {
                y = global.sectionTop - 64;
            }
        }
        else
        {
            yspeed = 0;
            image_speed = 0;
            spineKiller = true;
        }
    }
    else
    {
        yspeed = 0;
        image_speed = 0;
        spineKiller = true;
    }
}
else if (dead)
{
    yspeed = 0;
    image_speed = 0;
    spineKiller = true;
}
