#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/* Fires a laser after a set delay. Its direction can be changed by rotating the spawner
in the editor. You can also set the spawner to visible or set its sprite_index to a custom
sprite in its creation code, you can also set isSolid to 1 to make it a solid block.
Good for making diagonal lasers feel natural from where they spawn. */

/* Notes:
    - Quick Lasers tick their timers and fire reguardless of whether they are on-screen
        or off-screen. This is to prevent inconsistent timings.
    - Set rotateStartRange and rotateEndRange to the same value to make the laser endlessly
        spin in the saem direction
    - It rotates around the sprite origin of the laser spawner, so give this a custom
        sprite if you want to change that.
    - If you give the spawner a custom sprite with a different sprite offset than the
        default, it'll automatically shift itself so it's in the same position that it
        appears to be at in the editor */

event_inherited();
event_perform_object(prtRailPlatform,ev_create,0);
isSolid=0;

canHit = false;
contactDamage = 1;
xOffset = 0;
yOffset = 0;

blockCollision = false;
grav = 0;

respawnRange = -1;
despawnRange = -1;

//@cc if true it the spawner will detect rails
useRails = false;

//@cc sets wheater the laser can damage enemies or only the player, set to true for better performance
onlyDamagePlayer = true;

//@cc sets the sprite for the laser that's fired.
sprite = -1;

//@cc sets how fast the laser sprite animates
imageSpeed = -1;

//@cc How many frames until the laser fires.
delay = 30;

//@cc How fast the laser travels.
extendSpeed = 4;

//@cc 0 = damage, 1 = drain
variation = 1;

//@cc How much damage the laser does. (Does nothing unless variation is 0 (damage))
damage = 9999;

//@cc How many frames until the laser drains another life point. (Does nothing unless the variation is 1 (drain))
drainCooldown = 4;

//@cc How fast the laser rotates.
rotateSpeed = 0;

//@cc Which direction the laser starts rotating first.
rotateStartDir = 1;

//@cc The lowest part of the range the laser can rotate in.
rotateStartRange = 0;

//@cc The highest part of the range the laser can rotate in.
rotateEndRange = 0;

//@cc How fast the laser slows down / speeds back up upon reaching an edge of the rotate range.
rotateAccel = 0.2;

//@cc How long the laser waits after reaching an edge of the rotate range before moving again.
rotatePause = 0;

//@cc If the spawner plays the shooting sound when spawning the laser or not.
doSFX = true;

init = 1;

phase = 1;
timer = 0;

startingRotateSpeed = 0;
currentRotateSpeed = 0;
rotateDir = 0;
startAngle = 0;
rotateStartRangeTurn = 0;
rotateEndRangeTurn = 0;
myLasers[0] = 0;
laserCount = 0;
image_angle = round(image_angle);
realAngle = image_angle;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if(useRails)
{
    event_perform_object(prtRailPlatform,ev_step,ev_step_normal);
}
if (!dead && !global.frozen && !global.timeStopped)
{
    if (!phase)
    {
        timer++;
        if (timer >= delay)
        {
            phase = 1;
            if (doSFX)
                playSFX(sfxQuickLaser);
            timer = 0;
        }
    }
    else if (phase == 1)
    {
        phase = 2;

        // spawn the actual laser
        var sx = x;
        var sy = y;

        // find the top left position of the laser spawner so we can spawn at it (basically remove the sprite x and y origin of the spawner)
        sx -= spriteXOffset * cos(degtorad(image_angle));
        sy += spriteXOffset * sin(degtorad(image_angle)); // -= cause the polar coordinate and cartesian coordinate systems of GMS are misaligned
        sx -= spriteYOffset * cos(degtorad(image_angle + 270));
        sy += spriteYOffset * sin(degtorad(image_angle + 270));


        if (visible)
        {
            // if spawning on the outside of the block
            sx += sprite_get_width(sprite_index) * cos(degtorad(image_angle));
            sy -= sprite_get_width(sprite_index) * sin(degtorad(image_angle));
        }

        height = sprite_get_height(sprQuickLaserDrain);
        if (sprite != -1)
        {
            height = sprite_get_height(sprite);
        }

        for (var i = 0; i < height; i++)
        {
            var laser = instance_create(sx, sy, objPreciseQuickLaser);
            laser.image_xscale = 1;
            laser.image_angle = image_angle;
            laser.mySpeed = extendSpeed;
            laser.variation = variation;
            laser.contactDamage = damage;
            laser.drainCooldown = drainCooldown;
            laser.onlyDamagePlayer = onlyDamagePlayer;
            laser.parent = id;
            laser.respawn=false;
            laser.despawnRange=-1;
            laser.respawnRange=-1;


            if (sprite != -1)
            {
                laser.sprite_index = sprite;
            }

            if (imageSpeed != -1)
            {
                laser.imgSpeed = imageSpeed;
            }

            laser.order = i;

            // laser.image_yscale = 1.25 / (height);// shrink the hitbox accordingly,but add some tolerancy because game maker's collision detection gets messed up
            // without it, values with lower tolerancy may work at fast speeds
            myLasers[i] = laser;
            laserCount += 1;

            // move down to the position of the next laser
            if (i < height - 1)
            {
                sx += cos(degtorad(image_angle - 90));
                sy -= sin(degtorad(image_angle - 90));
            }
        }
    }
}
event_user(1);
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{
    init = 0;
    if (variation == 0)
        contactDamage = damage;
    startAngle = image_angle;
    if (sprite_get_xoffset(sprite_index) != 0 || sprite_get_yoffset(sprite_index) != 0)
    {
        // find the top left position of the laser spawner so we can spawn at it (basically remove the sprite x and y origin of the spawner)
        xstart += sprite_get_xoffset(sprite_index) * cos(degtorad(image_angle));
        ystart -= sprite_get_xoffset(sprite_index) * sin(degtorad(image_angle)); // -= cause the polar coordinate and cartesian coordinate systems of GMS are misaligned
        xstart += sprite_get_yoffset(sprite_index) * cos(degtorad(image_angle + 270));
        ystart -= sprite_get_yoffset(sprite_index) * sin(degtorad(image_angle + 270));

        x = xstart;
        y = ystart;
    }

    if (rotateSpeed != 0 && rotateStartDir != 0)
    {
        rotateDir = rotateStartDir;
        if (rotateStartRange != rotateEndRange)
        {
            // restrict start and end ranges to 0 - 359
            rotateStartRange = loopDegrees(rotateStartRange);
            rotateEndRange = loopDegrees(rotateEndRange);

            // if this object's starting angle is outside the rotate range, then fix that
            if (!withinDegreeRange(rotateStartRange, true, rotateEndRange, true, image_angle))
            {
                _middle = (rotateStartRange + rotateEndRange) / 2;
                if (rotateEndRange < rotateStartRange)
                {
                    // start range + half the range distance + 180 to flip to the middle of the angles not in the range
                    _middle = loopDegrees(rotateStartRange + (((360 - rotateStartRange) + rotateEndRange) / 2) + 180);
                }

                if (withinDegreeRange(rotateStartRange, true, _middle, true, image_angle))
                {
                    // closer to start range
                    image_angle = rotateStartRange;
                }
                else
                {
                    // closer to end range
                    image_angle = rotateEndRange;
                }
            }

            // find when to start accelerating / decelerating to stop at the end range
            _time = (rotateSpeed - 0) / rotateAccel;

            _dist = ((0 + rotateSpeed) / 2) * _time;

            rotateStartRangeTurn = loopDegrees(rotateStartRange + _dist);
            rotateEndRangeTurn = loopDegrees(rotateEndRange - _dist);

            // if acceleration is too slow to get to max speed, then make the turn points right in the middle of the range so it still stops at the correct angles
            _middle = (rotateStartRange + rotateEndRange) / 2;
            if (rotateEndRange < rotateStartRange)
            {
                // start range + half the range distance
                _middle = loopDegrees(rotateStartRange + (((360 - rotateStartRange) + rotateEndRange) / 2));
            }

            if (!withinDegreeRange(rotateStartRange, true, _middle, false, rotateStartRangeTurn)
                || !withinDegreeRange(_middle, false, rotateEndRange, true, rotateEndRangeTurn))
            {
                rotateStartRangeTurn = _middle;
                rotateEndRangeTurn = _middle;
                show_debug_message("in middle");
            }

            // initial rotation speed
            if (image_angle == rotateStartRange || image_angle == rotateEndRange)
            {
                startingRotateSpeed = 0;
            }

            if (rotateStartRangeTurn != rotateEndRangeTurn)
            {
                if (withinDegreeRange(rotateStartRangeTurn, false, rotateEndRangeTurn, false, image_angle))
                {
                    startingRotateSpeed = rotateSpeed;
                }
            }

            _dist = 0;
            if (withinDegreeRange(rotateStartRange, false, rotateStartRangeTurn, true, image_angle))
            {
                _startPoint = rotateStartRange;
                _endPoint = image_angle;

                if (_endPoint < _startPoint)
                {
                    _endPoint += 360;
                }

                _dist = _endPoint - _startPoint;

                startingRotateSpeed = sqrt(2 * rotateAccel * _dist);
            }
            else if (withinDegreeRange(rotateEndRangeTurn, true, rotateEndRange, false, image_angle))
            {
                _startPoint = image_angle;
                _endPoint = rotateEndRange;

                if (_endPoint < _startPoint)
                {
                    _endPoint += 360;
                }

                _dist = _endPoint - _startPoint;

                if (rotateAccel != 0)
                    startingRotateSpeed = sqrt(2 * rotateAccel * _dist);
                else
                    startingRotateSpeed = rotateSpeed;
            }
        }
        else
        {
            if (rotateAccel == 0)
                startingRotateSpeed = rotateSpeed;
        }
    }
    else
    {
        startingRotateSpeed = 0;
    }
    spriteXOffset = sprite_get_xoffset(sprite_index);
    spriteYOffset = sprite_get_yoffset(sprite_index);
    realAngle = image_angle;
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_perform_object(prtRailPlatform,ev_other,ev_user0);
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!dead && !global.frozen && !global.timeStopped && phase == 2 && (rotateSpeed != 0 || useRails)) // Rotation
{
    if (timer > 0)
    {
        timer--;
    }
    else
    {
        // rotate spawner  // restrict to the 0 - 359 range
        realAngle = wrapAngle(realAngle + currentRotateSpeed * rotateDir);

        // non integer values mess up with collision detection
        image_angle = floor(realAngle);

        // slow down / speed up when nearing the end of the range
        if (rotateStartRange != rotateEndRange
            && ((rotateDir < 0 && !withinDegreeRange(rotateStartRangeTurn, false, rotateEndRange, true, realAngle))
            || (rotateDir > 0 && !withinDegreeRange(rotateStartRange, true, rotateEndRangeTurn, false, realAngle))))
        {
            currentRotateSpeed -= rotateAccel;
        }
        else if (currentRotateSpeed < rotateSpeed)
        {
            currentRotateSpeed = min(rotateSpeed, currentRotateSpeed + rotateAccel);
        }

        // stop at the end of the range
        if (rotateStartRange != rotateEndRange)
        {
            if (!withinDegreeRange(rotateStartRange, true, rotateEndRange, true, realAngle) || currentRotateSpeed < 0)
            {
                if (rotateDir < 0)
                {
                    realAngle = rotateStartRange;
                    rotateDir = 1;
                    timer = rotatePause;
                }
                else if (rotateDir > 0)
                {
                    realAngle = rotateEndRange;
                    rotateDir = -1;
                    timer = rotatePause;
                }

                image_angle = floor(realAngle);
                currentRotateSpeed = 0;
            }
        }

        // rotate + reposition the laser(s) to fit with the spawner
        var lx = x;
        var ly = y;

        // find the top left position of the laser spawner (basically remove the sprite x and y origin of the spawner)
        lx -= spriteXOffset * cos(degtorad(image_angle));
        ly += spriteXOffset * sin(degtorad(image_angle));
        lx -= spriteYOffset * cos(degtorad(image_angle + 270));
        ly += spriteYOffset * sin(degtorad(image_angle + 270));

        if (visible)
        {
            // if on the outside of the block
            lx += sprite_get_width(sprite_index) * cos(degtorad(image_angle));
            ly -= sprite_get_width(sprite_index) * sin(degtorad(image_angle));
        }

        // rotate
        for (var i = 0; i < laserCount; i++)
        {
            myLasers[i].image_angle = image_angle;
            myLasers[i].x = lx;
            myLasers[i].y = ly;

            // move down to the position of the next laser
            if (i < laserCount - 1)
            {
                lx += cos(degtorad(image_angle - 90));
                ly -= sin(degtorad(image_angle - 90));
            }
        }
    }
}
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (variation == 1)
{
    with (other)
    {
        if (object_index == objMegaman)
        {
            healthpoints = global.playerHealth[playerID];
            global.playerHealth[playerID] -= 1;
        }

        healthpoints -= 1;
        if (healthpoints <= 0)
        {
            event_user(EV_DEATH);
        }
        else
        {
            iFrames = other.drainCooldown;
            playSFX(sfxHit);
        }
    }

    global.damage = 0; // Overriding normal damage collision so there's no knockback
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// EV_SPAWN
if (spawned)
{
    grav = 0;
    dir = startDir;
    prevRail = noone;
    lastRail = noone;
    phase = 0;
    timer = 0;
    image_angle = startAngle;
    realAngle = image_angle;
    rotateDir = rotateStartDir;
    currentRotateSpeed = startingRotateSpeed;
    myLasers = -1;
    myLasers[0] = noone;
    laserCount = 0;

    // Only be solid if specified in creation code, no need to make it solid whenever its visible
    if (sprite_index != sprQuickLaserSpawner)
        visible = 1;

    // default death variation sprite
    if (variation == 0 && sprite == -1)
    {
        sprite = sprQuickLaser;
    }
}