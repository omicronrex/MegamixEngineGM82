#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A big rolling boulder, it must be placed over [objSHBoulder](objSHBoulder.html), he will begin his pattern shaking the rocks,
// causing them to fall randomly(the first rock always falls over megaman).
// Whe it's rolling it will track solids
// Note: see objSHBoulder for more info
event_inherited();

// Creation code (all optional):
introSprite = sprStoneHead;
sprite_index = sprStoneHead;
healthpointsStart = 15;
healthpoints = healthpointsStart;
doesIntro = false;
contactDamage = 4;
rescursiveExplosion = false;
iFrames = 0;

category = "bulky, rocky";

// Enemy specific code

//@cc Rolling speed, if too fast he might miss the ground and just keep his momentum
SPEED = 3.7;

// Ground direction
_groundDir = 270;

//@cc Interval between drops
dropInterval = 16;

// Don't change any of these

prevDrop = -1;
repeatedCounter = 0;
_velX = 0;
_velY = 0;
_prevCollision = true;
grav = 0;
dropCount = 0;
dropMax = 11;
_dir = image_xscale;
init = 1;
cooldownTimer = 0;
phase = 0;
messedUp = false;

nextPosOffset = 0;
currentBoulder = noone;
moveCount = 0;

boulderStart = noone;
boulderEnd = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    if (init)
    {
        var i = instance_place(x, y, objSHBoulder);
        if (i != noone)
        {
            boulderStart = i.startRef;
            boulderEnd = i.endRef;
            var ref = boulderStart;
            var rn = irandom(ref.boulderCount - 1);
            for (var j = 0; j < rn; j++)
                ref = ref.nextBoulder;
            if (ref > 0)
            {
                x = ref.x;
                y = ref.y;
            }
            init = 0;
        }
        else
        {
            show_message("Stone head must spawn on objSHBoulder");
            instance_destroy();
        }
    }
    else
    {
        switch (phase)
        {
            case 0: // shake
                cooldownTimer += 1;
                image_index = 0;
                if (cooldownTimer == 60)
                {
                    screenShake(60, 2, 1);
                    playSFX(sfxMM9Quake);
                }
                if (cooldownTimer > 120)
                {
                    cooldownTimer = 0;
                    dropCount = 0;
                    phase = 1;
                }
                break;
            case 1: // Dropping boulders
                if (cooldownTimer < dropInterval)
                    cooldownTimer += 1;
                else
                {
                    cooldownTimer = 0;
                    dropCount += 1;
                    if (dropCount == 12)
                    {
                        dropCount = 0;
                        phase = -1;
                        image_index = 0;
                        repeatedCounter = 0;
                        prevDrop = -1;
                    }
                    else
                    {
                        var rng = irandom(boulderStart.boulderCount - 1);
                        var preventRepeating = false;
                        if (!(((dropCount - 3) mod 4) == 0) && (rng == prevDrop))
                            repeatedCounter += 1;
                        if (repeatedCounter > 1)
                        {
                            repeatedCounter = 0;
                            while (rng == prevDrop)
                            {
                                rng = irandom(boulderStart.boulderCount - 1);
                            }
                            preventRepeating = true;
                        }
                        prevDrop = rng;

                        var ref = boulderStart;
                        if (!(((dropCount - 1) mod 3) == 0) || preventRepeating)
                        {
                            for (var i = 0; i < rng; i++)
                            {
                                ref = ref.nextBoulder;
                            }
                        }
                        else
                        {
                            var j = 0;
                            while (ref != noone && ref.nextBoulder != noone)
                            {
                                if (instance_exists(target))
                                {
                                    if (target.x < ref.bbox_right && target.x > ref.bbox_left)
                                    {
                                        break;
                                    }
                                }
                                ref = ref.nextBoulder;
                                j += 1;
                            }
                            if (prevDrop == j)
                                repeatedCounter += 1;
                            prevDrop = j;
                        }
                        with (ref)
                            event_user(2);
                    }
                }
                break; // Apear
            case -1:
                image_index += 0.2;
                if (floor(image_index) == 2)
                {
                    image_speed = 0;
                    phase = 2;
                    cooldownTimer = 0;
                }
                break;
            case 2: // Falling
                grav = 0.25;
                if (ground)
                {
                    mAngle = 270;
                    prevCollision = true;
                    messedUp = false;
                    if (cooldownTimer == 0)
                    {
                        if (instance_exists(objMegaman))
                        {
                            with (objMegaman)
                                playerGetShocked(false, 0, true, 45);
                        }
                        playSFX(sfxMM9Quake);
                        screenShake(45, 2, 1);
                    }
                    cooldownTimer += 1;
                    if (cooldownTimer > 60)
                    {
                        phase = 3;
                        calibrateDirection();
                        _dir = image_xscale;
                        cooldownTimer = 0;
                        xspeed = SPEED * _dir;
                        _velX = xspeed;
                        _velY = 0;
                        _groundDir = 270;
                        _prevCollision = true;
                    }
                }
                break;
            case 3: // Rollin
                var b = instance_place(x, y, objSHBoulder);
                image_index += 0.2;
                if (floor(image_index) < 2)
                    image_index = 2;
                if (floor(image_index) > 5)
                    image_index = 2;
                if (b != noone && bbox_bottom <= b.bbox_bottom)
                {
                    x = b.x;
                    y = b.y;
                    xspeed = 0;
                    yspeed = 0;
                    if (image_index == 2)
                    {
                        phase = -5;
                        boulderStart = b.startRef;
                        boulderEnd = b.endRef;
                        currentBoulder = b;
                        image_speed = 0;
                    }
                    break;
                }
                snapToGround(SPEED, 1, 0); // Black magic
                break;
            case -5:
                cooldownTimer += 0.2;
                image_index = 2 - floor(cooldownTimer);
                if (image_index <= 0)
                {
                    image_speed = 0;
                    phase = 5;
                    cooldownTimer = 0;
                }
                break;
            case 5:
                image_index = 0;
                if (image_xscale == -1)
                {
                    nextPosOffset = irandom(boulderStart.boulderCount - 1);
                }
                else
                {
                    nextPosOffset = -irandom(boulderStart.boulderCount - 1);
                }
                phase = 6;
                cooldownTimer = 0;
                moveCount = 0;
                break;
            case 6: // Hide in leaving a trail, then switch back to phase 0;
                image_index = 0;
                cooldownTimer += 1;
                if (nextPosOffset > 0)
                {
                    if (cooldownTimer > 15)
                    {
                        cooldownTimer = 0;

                        if (moveCount < nextPosOffset)
                        {
                            var i = currentBoulder.nextBoulder;
                            if (i != noone && instance_exists(i))
                            {
                                x = i.x;
                                y = i.y;
                                with (i)
                                    event_user(3);
                                currentBoulder = i;
                            }
                            moveCount += 1;
                        }
                        else
                        {
                            phase = 0;
                            cooldownTimer = 0;
                            moveCount = 0;
                        }
                    }
                }
                else
                {
                    if (cooldownTimer > 15)
                    {
                        cooldownTimer = 0;

                        if (moveCount < abs(nextPosOffset))
                        {
                            var i = currentBoulder.prevBoulder;
                            if (i != noone && instance_exists(i))
                            {
                                x = i.x;
                                y = i.y;
                                with (i)
                                    event_user(3);
                                currentBoulder = i;
                            }
                            moveCount += 1;
                        }
                        else
                        {
                            phase = 0;
                            cooldownTimer = 0;
                            moveCount = 0;
                        }
                    }
                }
                break;
        }
    }
}
else if (!insideView())
{
    cooldownTimer = 0;
    init = 1;
    phase = 0;
    ground = false;
    prevCollision = true;
    messedUp = false;
    image_index = 0;
    image_speed = 0;
    velx = 0;
    vely = 0;
    prevVely = 0;
    prevVelx = 0;
    nextPosOffset = 0;
    currentBoulder = noone;
    moveCount = 0;
    dropCount = 0;
    boulderStart = noone;
    boulderEnd = noone;
    prevDrop = -1;
    repeatedCounter = 0;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// On Death
event_inherited();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (phase != 0 && phase != 1 && phase != 5 && phase != 6)
{
    event_inherited();
}
