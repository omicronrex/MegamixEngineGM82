#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/* Fires a laser after a set delay. Its direction can be changed by rotating the spawner
in the editor. You can also set the spawner to visible or set its sprite_index to a custom
sprite in its creation code to make it become a solid block to act as a visible shooter
for the laser. Good for making diagonal lasers feel natural from where they spawn. */

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
xOffset = 0;
yOffset = 0;
canHit = false;
contactDamage = 0;

grav = 0;

respawnRange = -1;
despawnRange = -1;

//@cc if true it the spawner will detect rails
useRails = false;

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
rotateStartDir = 0;

//@cc The lowest part of the range the laser can rotate in.
rotateStartRange = 0;

//@cc The highest part of the range the laser can rotate in.
rotateEndRange = 0;

//@cc How fast the laser slows down / speeds back up upon reaching an edge of the rotate range.
rotateAccel = 0.2;

//@cc How long the laser waits after reaching an edge of the rotate range before moving again.
rotatePause = 20;

//@cc Whether the laser's individual pixels can be stopped separately or not. WARNING: VERY CPU INTENSIVE!! This WILL cause lag, and it WILL be your fault if your stage lags because of it!!!!
pixelPrecise = false;

//@cc If the spawner plays the shooting sound when spawning the laser or not.
doSFX = true;

init = 1;

phase = 1;
timer = 0;

startingRotateSpeed = 0;
currentRotateSpeed = 0;
rotateDir = 1;
startAngle = 0;
rotateStartRangeTurn = 0;
rotateEndRangeTurn = 0;

myLasers = ds_list_create();
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ds_list_destroy(myLasers);
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
    switch (phase)
    {
        // wait
        case 0:
            timer++;
            if (timer >= delay)
            {
                timer = 0;
                phase++;

                if (doSFX)
                {
                    playSFX(sfxQuickLaser);
                }
            }
            break;

        // Shoot da lazor
        case 1: // spawn the actual laser
            sx = x;
            sy = y;

            // find the top left position of the laser spawner so we can spawn at it (basically remove the sprite x and y origin of the spawner)
            sx -= sprite_get_xoffset(sprite_index) * cos(degtorad(image_angle));
            sy += sprite_get_xoffset(sprite_index) * sin(degtorad(image_angle)); // -= cause the polar coordinate and cartesian coordinate systems of GMS are misaligned
            sx -= sprite_get_yoffset(sprite_index) * cos(degtorad(image_angle + 270));
            sy += sprite_get_yoffset(sprite_index) * sin(degtorad(image_angle + 270));
            if (visible)
            {
                // if spawning on the outside of the block
                sx += sprite_get_width(sprite_index) * cos(degtorad(image_angle));
                sy -= sprite_get_width(sprite_index) * sin(degtorad(image_angle));
            }
            if (!pixelPrecise)
            {
                laser = instance_create(sx, sy, objQuickLaser);
                laser.image_xscale = 0;
                laser.image_angle = image_angle;
                laser.mySpeed = extendSpeed;
                laser.variation = variation;
                laser.contactDamage = damage;
                laser.drainCooldown = drainCooldown;
                laser.faction = faction;

                if (sprite != -1)
                {
                    laser.sprite_index = sprite;
                }

                if (imageSpeed != -1)
                {
                    laser.image_speed = imageSpeed;
                }

                ds_list_add(myLasers, laser);
            }
            else
            {
                height = sprite_get_height(sprQuickLaserDrain);
                if (sprite != -1)
                {
                    height = sprite_get_height(sprite);
                }

                for (i = 0; i < height; i++)
                {
                    laser = instance_create(sx, sy, objQuickLaser);
                    laser.image_xscale = 0;
                    laser.image_angle = image_angle;
                    laser.mySpeed = extendSpeed;
                    laser.variation = variation;
                    laser.contactDamage = damage;
                    laser.drainCooldown = drainCooldown;

                    if (sprite != -1)
                    {
                        laser.sprite_index = sprite;
                    }

                    if (imageSpeed != -1)
                    {
                        laser.image_speed = imageSpeed;
                    }

                    laser.myPixel = i;
                    laser.image_yscale /= sprite_get_height(laser.sprite_index); // shrink the hitbox accordingly

                    ds_list_add(myLasers, laser);

                    // move down to the position of the next laser
                    if (i < height - 1)
                    {
                        sx += cos(degtorad(image_angle - 90));
                        sy -= sin(degtorad(image_angle - 90));
                    }
                }
            }
            phase++; // do nothing now
            break;

        // laser rotation
        case 2: // don't do rotation
            if (ds_list_size(myLasers) < 1 || (!useRails && (rotateSpeed == 0 || rotateDir == 0)))
            {
                break;
            }

            // rotate spawner
            if(timer>0)
            {
                --timer;
                if(!useRails)
                    break;
            }
            else
            {
                image_angle += currentRotateSpeed * rotateDir;
            }

            // restrict to the 0 - 359 range
            image_angle = loopDegrees(image_angle);

            // slow down / speed up when nearing the end of the range
            if (rotateStartRange != rotateEndRange
                && ((rotateDir < 0 && !withinDegreeRange(rotateStartRangeTurn, false, rotateEndRange, true, image_angle))
                || (rotateDir > 0 && !withinDegreeRange(rotateStartRange, true, rotateEndRangeTurn, false, image_angle))))
            {
                currentRotateSpeed -= rotateAccel;
            }
            else if (currentRotateSpeed < rotateSpeed)
            {
                currentRotateSpeed += rotateAccel;

                if (currentRotateSpeed > rotateSpeed)
                {
                    currentRotateSpeed = rotateSpeed;
                }
            }

            // stop at the end of the range
            if (rotateStartRange != rotateEndRange)
            {
                if (!withinDegreeRange(rotateStartRange, true, rotateEndRange, true, image_angle) || currentRotateSpeed < 0)
                {
                    if (rotateDir < 0)
                    {
                        image_angle = rotateStartRange;
                        rotateDir = 1;
                        timer = rotatePause;
                    }
                    else if (rotateDir > 0)
                    {
                        image_angle = rotateEndRange;
                        rotateDir = -1;
                        timer = rotatePause;
                    }

                    currentRotateSpeed = 0;
                }
            }

            // rotate + reposition the laser(s) to fit with the spawner
            lx = x;
            ly = y;

            // find the top left position of the laser spawner (basically remove the sprite x and y origin of the spawner)
            lx -= sprite_get_xoffset(sprite_index) * cos(degtorad(image_angle));
            ly += sprite_get_xoffset(sprite_index) * sin(degtorad(image_angle));
            lx -= sprite_get_yoffset(sprite_index) * cos(degtorad(image_angle + 270));
            ly += sprite_get_yoffset(sprite_index) * sin(degtorad(image_angle + 270));
            if (visible)
            {
                // if on the outside of the block
                lx += sprite_get_width(sprite_index) * cos(degtorad(image_angle));
                ly -= sprite_get_width(sprite_index) * sin(degtorad(image_angle));
            }

            // rotate
            for (i = 0; i < ds_list_size(myLasers); i++)
            {
                laser = ds_list_find_value(myLasers, i);
                laser.image_angle = image_angle;
                laser.x = lx;
                laser.y = ly;

                // move down to the position of the next laser
                if (i < ds_list_size(myLasers) - 1)
                {
                    lx += cos(degtorad(image_angle - 90));
                    ly -= sin(degtorad(image_angle - 90));
                }
            }
            break;
    }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
startAngle = image_angle;

/* if we have a custom sprite with a different sprite origin, shift our position so
we are in the same place we appeared in in the editor */
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

        // Vf = Vi + a * t
        // (Vf - Vi) / a = t
        _time = (rotateSpeed - 0) / rotateAccel;

        // d = ((Vi + Vf) / 2) * t
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

            // Vf^2 = Vi^2 + 2 * a * d
            // Vf = sqrt(2 * a * d)
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

            // Vf^2 = Vi^2 + 2 * a * d
            // Vf = sqrt(2 * a * d)
            startingRotateSpeed = sqrt(2 * rotateAccel * _dist);
        }
    }
}
else
{
    startingRotateSpeed = 0;
}
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ds_list_destroy(myLasers);
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_perform_object(prtRailPlatform,ev_other,ev_user0);
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// EV_SPAWN
event_inherited();

if (spawned)
{
    phase = 0;
    timer = 0;
    image_angle = startAngle;
    rotateDir = rotateStartDir;
    currentRotateSpeed = startingRotateSpeed;
    ds_list_clear(myLasers);

    // if being used as a visible spawn block, then be solid
    if (sprite_index != sprQuickLaserSpawner) // visible if we're given a custom sprite
    {
        visible = true;
    }

    isSolid = visible;

    // default death variation sprite
    if (variation == 0 && sprite == -1)
    {
        sprite = sprQuickLaser;
    }
}