#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
stopOnFlash = false;
healthpointsStart = 1;
healthpoints = healthpointsStart;
blockCollision = 0;
killOverride = false;
respawn = false;
contactDamage = 4;
grav = 0;
canHit = true;
despawnRange = 0;
speedSet = 1.5;

aiming = 0; // 0 = E, 1 = SE, 2 = S, 3 = SW, 4 = W, 5 = NW, 6 = N, 7 = NE.
indexOffset = 0; // For animation. image_index = aiming * 2 + indexOffset.
reDirTimer = 0;

playSFX(sfxMissileLaunch);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (reDirTimer mod 10 == 0)
    {
        if (indexOffset == 0)
        {
            indexOffset = 1;
        }
        else
        {
            indexOffset = 0;
        }
    }

    if (reDirTimer < 20)
    {
        reDirTimer+=1;
    }
    else
    {
        reDirTimer = 0;
        if (instance_exists(target))
        {
            //
            // -=1FIX THIS LATER-=1
            //
            testAngle = point_direction(x, y, target.x, target.y);
            if (testAngle <= 0)
            {
                testAngle += 360;
            }
            if (testAngle >= (360 - aiming * 45)
                && testAngle - (360 - aiming * 45) <= 180)
            {
                aiming-=1;
            }
            else
            {
                aiming+=1;
            }
        }
        else
        {
            if (aiming > 0 && aiming < 5)
            {
                aiming-=1;
            }
            else
            {
                aiming+=1;
            }
        }
        if (aiming < 0)
        {
            aiming = 7;
        }
        if (aiming > 7)
        {
            aiming = 0;
        }
    }

    if (aiming > 4) // North.
    {
        yspeed = -speedSet;
    }
    else if (aiming > 0 && aiming < 4) // South.
    {
        yspeed = speedSet;
    }
    else // Horizontal movement only.
    {
        yspeed = 0;
    }

    if (aiming < 2 || aiming == 7) // East.
    {
        xspeed = speedSet;
    }
    else if (aiming > 2 && aiming < 6) // West.
    {
        xspeed = -speedSet;
    }
    else // Vertical movement only.
    {
        xspeed = 0;
    }
    image_index = aiming * 2 + indexOffset;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_create(x, y, objExplosion);
event_inherited();
