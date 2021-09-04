#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

mainShot = 1;
bulletLimitCost = 1;

contactDamage = 1;

// constants
moveSpeed = 6;
moveTime = 14 / (moveSpeed / 4); // automatically adjusts move time to match the speed, so it goes the same distance

tail0Length = 24;
tail30Length = 21;
tail45Length = 16;

moveCounter = 8;

// variables
image_speed = 0;

penetrate = 1;
pierces = 2;

attackDelay = 10;

phase = 0;
timer = 0;
counter = 0;
startDir = 0;

launchX = x;
launchY = y;

imgIndex = 0;
imgSpd = 0.2;

directionPersist = 0; // mostly for fixing a glitch where the tail points left upon pausing no matter what

playSFX(sfxSparkChaser);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    switch (phase)
    {
        case 0: // move
            if (timer == 0) // setup
            {
                if (counter == 0) // initial setup and launch angle
                {
                    if (parent.image_xscale > 0)
                    {
                        direction = 0;
                    }
                    else
                    {
                        direction = 180;
                    }

                    startDir = direction;
                }

                launchX = x;
                launchY = y;
            }
            imgIndex += imgSpd;
            if (imgIndex >= 2)
            {
                imgIndex = 2; // main sprite isn't drawn when imgIndex isn't 0 or 1
            }
            if (timer >= moveTime)
            {
                timer = 0;
                imgIndex = 0;
                phase += 1;

                launchX = x + tail0Length * cos(degtorad(direction + 180));
                launchY = y + tail0Length * sin(degtorad(direction + 180));

                break;
            }
            timer += 1;
            speed = moveSpeed;
            break;
        case 1: // stop momentarilly
        // move tail
            if (sqrt(power(x - launchX, 2) + power(y - launchY, 2)) > moveSpeed) // <-- isn't short enough to disappear in one more frame (it's a rounding thing)
            {
                launchX += moveSpeed * cos(degtorad(direction));
                launchY += moveSpeed * sin(degtorad(direction));
            }
            else
            {
                launchX = x;
                launchY = y;
            }

            // animate
            imgIndex += imgSpd;
            if (imgIndex >= 2)
            {
                imgIndex = 0;
                phase = 0;

                if (counter >= moveCounter)
                {
                    instance_destroy();
                    break;
                }

                counter += 1;
                playSFX(sfxSparkChaser);

                // aim at target
                newDir = -1;

                if (instance_exists(target))
                {
                    newDir = point_direction(x, y, bboxGetXCenterObject(target), bboxGetYCenterObject(target));
                }

                // follow player when no enemies are around
                if (newDir == -1 && instance_exists(parent))
                {
                    newDir = point_direction(x, y, bboxGetXCenterObject(parent), bboxGetYCenterObject(parent) - 20);
                }

                if (newDir == -1) // if no targets or player, then go the angle we were going before
                {
                    newDir = direction;
                }
                else // save originally calculated direction
                {
                    direction = newDir;
                }

                // round to the nearest angle that's a multiple of 15
                if (newDir mod 15 * 15 > 15)
                {
                    newDir = newDir div 15 * 15 + 15;
                }
                else
                {
                    newDir = newDir div 15 * 15;
                }

                // if it's an angle that isn't used, than round
                if ((newDir + 15) mod 90 == 0 || (newDir - 15) mod 90 == 0)
                {
                    if (direction > newDir)
                    {
                        newDir += 15;
                    }
                    else
                    {
                        newDir -= 15;
                    }
                }

                // if it's a diagonal angle that's a multiple of 30, change it to its actual angle of arctan(1/2) aka 26.56505... as according to the sprites
                if (newDir mod 30 == 0 && newDir mod 90 != 0)
                {
                    if ((newDir + 30) mod 90 == 0)
                    {
                        newDir = newDir + 30 - radtodeg(arctan(1 / 2));
                    }
                    else
                    {
                        newDir = newDir - 30 + radtodeg(arctan(1 / 2));
                    }
                }

                direction = newDir;

                launchX = x;
                launchY = y;
            }
            speed = 0;
            break;
    }
}
else
{
    speed = 0;
}

image_index = imgIndex div 1;

if (!global.frozen)
{
    directionPersist = direction;
}
#define Other_17
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
canDamage = 0;
canHit = false;

instance_create(x, y, objExplosion);

event_user(EV_DEATH);

playSFX(sfxReflect);
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("SPARK CHASER", global.nesPalette[24], global.nesPalette[52], sprWeaponIconsSparkChaser);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue("flying", 3);
specialDamageValue("bird", 3);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    i = fireWeapon(20, 0, objSparkChaser, 4, 2, 1, 0);
    if (i) // set its starting angle.
    {
        i.direction = 180 * (image_xscale == -1);
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// draw tail

// don't have the tail point left upon pausing the game
persist = false;
if (global.frozen && direction == 0)
{
    direction = directionPersist;
    persist = true;
}

// if unfrozen, make sure the tail doesn't point to the left for the first frame
if (!global.frozen && direction != directionPersist)
{
    direction = directionPersist;
}

spriteAlt = false;
if (direction mod 90 == 0)
{
    // straight
    var i;
    for (i = 0; (i <= point_distance(x, y, launchX, launchY) && i < tail0Length); i++)
    {
        draw_sprite_ext(sprite_index, 2 + (spriteAlt == true), x + i * cos(degtorad(direction + 180)), y + i * sin(degtorad(direction)), 1, 1, direction, c_white, 1);
        spriteAlt = !spriteAlt;
    }
}
else if (direction mod 45 == 0)
{
    // 45 diagonal
    xFlip = -1 * (direction > 90 && direction < 270);
    if (xFlip == 0)
    {
        xFlip = 1;
    }
    yFlip = -1 * (direction > 180 && direction < 360);
    if (yFlip == 0)
    {
        yFlip = 1;
    }

    var i;
    for (i = 0; (i * 1.4142 <= point_distance(x, y, launchX, launchY) && i < tail45Length); i++)
    {
        draw_sprite_ext(sprite_index, 6 + (spriteAlt == true), x - i * xFlip, y + i * yFlip, 1, 1, direction - 45, c_white, 1);
        spriteAlt = !spriteAlt;
    }
}
else
{
    // arctan(1/2) aka 26.56505 diagonal'
    drawX = x;
    drawY = y;

    if (floor(direction mod 90) == 26)
    {
        // before the 45
        var i;
        for (i = 0; (i * 1.2361 <= point_distance(x, y, launchX, launchY) && i < tail30Length); i++)
        {
            // lol forget trying to figure out an elegant, math-y way to do this anymore, hard coding the angles will be much faster here
            switch ((direction div 90) * 90)
            {
                case 0:
                    drawX = x - i;
                    drawY = y + floor((i - 1) / 2);
                    break;
                case 90:
                    drawX = x + floor((i - 1) / 2);
                    drawY = y + i;
                    break;
                case 180:
                    drawX = x + i;
                    drawY = y - floor((i - 1) / 2);
                    break;
                case 270:
                    drawX = x - floor((i - 1) / 2);
                    drawY = y - i;
                    break;
            }

            draw_sprite_ext(sprite_index, 4 + (spriteAlt == false), drawX, drawY, 1, 1, (direction div 90) * 90, c_white, 1);
            spriteAlt = !spriteAlt;
        }
    }
    else
    {
        // after the 45
        var i;
        for (i = 0; (i * 1.2361 <= point_distance(x, y, launchX, launchY) && i < tail30Length); i++)
        {
            // lol forget trying to figure out an elegant, math-y way to do this anymore, hard coding the angles will be much faster here
            switch ((direction div 90) * 90)
            {
                case 0:
                    drawX = x - floor((i - 1) / 2);
                    drawY = y + i;
                    break;
                case 90:
                    drawX = x + i;
                    drawY = y + floor((i - 1) / 2);
                    break;
                case 180:
                    drawX = x + floor((i - 1) / 2);
                    drawY = y - i;
                    break;
                case 270:
                    drawX = x - i;
                    drawY = y - floor((i - 1) / 2);
                    break;
            }

            draw_sprite_ext(sprite_index, 4 + (spriteAlt == false), drawX, drawY, -1, 1, (direction div 90) * 90 - 90, c_white, 1);
            spriteAlt = !spriteAlt;
        }
    }
}

// draw main sprite
if (image_index < 2)
{
    draw_sprite(sprite_index, image_index, x, y);
}

// end tail direction fix
if (persist)
{
    direction = 0;
}
