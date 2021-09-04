#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
  Emits tackle fires which travel to another specified tackle fire spawner.
  Spawners are specified via tags.
*/

event_inherited();

//@cc looks prettier if this is true, but more accurate if false
shiftVisible = false;

//@cc what other tackle fire dispensers refer to this as
tag = "";

//@cc the tackle fire dispenser that the tackle fires emitted should go to
dstTag = "";

//@cc "full" means that tackle fires are within.
startFull = false;

//@cc time between fires in a volley
tackleFireInterval = 8;

//@cc time it takes for fires to reach destination
tackleFireFlightTime = 48;

//@cc time it takes for fires to launch after last fire arrives.
tackleFireWarmupTime = 60;

//@cc if this is set to true, timer will increment and can dispense even if off-screen
// (do not set the respawnRange / despawnRange
dispenseOffScreen = false;

destination = noone;

timer = 0;
spawnTimer = -1;

canHit = false;

//@nocc -=1 use dispenseOffScreen instead
respawnRange = -1;

//@nocc -=1 use dispenseOffScreen instead
despawnRange = -1;

blockCollision = false;
grav = 0;
bubbleTimer = -1;

isSolid = true;
tackleFireN = 0;
image_speed = 0;
nComplete = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

nComplete = 0;

if (entityCanStep())
{
    // fix sprite shading
    if (sprite_index == sprTackleFireDispenser || sprite_index == sprTackleFireDispenserY || sprite_index == sprTackleFireDispenserXY || sprite_index == sprTackleFireDispenserX)
    {
        sprite_index = sprTackleFireDispenser;
        if (inRange(modf(image_angle, 360), 45, 135))
        {
            sprite_index = sprTackleFireDispenserX;
        }
        if (inRange(modf(image_angle, 360), 135, 225))
        {
            sprite_index = sprTackleFireDispenserXY;
        }
        if (inRange(modf(image_angle, 360), 225, 315))
        {
            sprite_index = sprTackleFireDispenserY;
        }
    }

    // animation
    image_index = 0;
    if (timer < 30)
    {
        image_index = 1;
    }
    if (timer < 15)
    {
        image_index = 2;
    }
    if (spawnTimer == -1 && timer == -1)
    {
        image_index = 0;
    }

    // timers
    if (timer >= 0 && tackleFireN == 0 && (dispenseOffScreen || insideView()))
    {
        if ((timer) == 0)
        {
            // create tackle fires
            spawnTimer = 0;
            flightTimer = 0;
        }
        timer-=1
    }

    var srcX; srcX = x + 8 * cos(degtorad(image_angle));
    var srcY; srcY = y - 8 * sin(degtorad(image_angle)) - 8;

    if (spawnTimer >= 0)
    {
        flightTimer+=1;
        spawnTimer-=1
        if ((spawnTimer) == -1)
        {
            spawnTimer = tackleFireInterval;
            with (instance_create(srcX, srcY, objTackleFire))
            {
                other.tackleFire[other.tackleFireN] = id; other.tackleFireN+=1
                respawn = false;
                respawnRange = -1;
                despawnRange = -1;
                dummyLogic = true;
                healthpoints = 3;
                stopSFX(sfxTackleFireDispenser);
                playSFX(sfxTackleFireDispenser);
            }
        }


        // end volley
        if (tackleFireN >= 4)
        {
            spawnTimer = -1;
        }
    }
    else if (flightTimer > 0)
    {
        flightTimer+=1;
    }

    // lerp paths precomputation
    var dstX; dstX = srcX;
    var dstY; dstY = srcY;
    var dstAngle; dstAngle = 0;
    if (instance_exists(destination))
    {
        dstX = destination.x + 8 * cos(degtorad(destination.image_angle));
        dstY = destination.y - 8 * sin(degtorad(destination.image_angle)) - 8;
        dstAngle = destination.image_angle - 90;
    }
    var vecUx; vecUx = dstX - srcX;
    var vecUy; vecUy = dstY - srcY;
    var vecVx; vecVx = vecUy;
    var vecVy; vecVy = -vecUx;

    nComplete = 0;
    var k; for (k = 0; k < tackleFireN; k+=1)
    {
        var fire; fire = tackleFire[k];
        var t; t = (flightTimer - k * tackleFireInterval) / tackleFireFlightTime
            ;
        if (t > 1)
        {
            // kill fire when it reaches destination
            with (fire)
            {
                instance_destroy();
            }
        }

        if (!instance_exists(fire))
        {
            nComplete+=1;
            continue;
        }

        // calculate desired location in path by lerping 8 different paths
        // in u-v coordinates
        var dLU, dLV;

        // -=1first index-=1
        // 0: source curve
        // 1: dest curve
        // -=1second index-=1
        // 0: aligned
        // 1: left
        // 2: reverse
        // 3: right
        var argsin; argsin = 2.5;
        dLU[0, 0] = t;
        dLU[0, 1] = t;
        dLU[0, 2] = sin(2 * argsin * (t - 0.5)) * 0.5 / sin(argsin) + 0.5;
        dLU[0, 3] = t;

        dLU[1, 0] = t;
        dLU[1, 1] = t;
        dLU[1, 2] = sin(2 * argsin * (t - 0.5)) * 0.5 / sin(argsin) + 0.5;
        dLU[1, 3] = t;

        dLV[0, 0] = 0;
        dLV[0, 1] = t * (1 - t) * 4;
        dLV[0, 2] = 0;
        dLV[0, 3] = t * (t - 1) * 4;

        dLV[1, 0] = 0;
        dLV[1, 1] = t * (1 - t) * 4;
        dLV[1, 2] = 0;
        dLV[1, 3] = t * (t - 1) * 4;

        // determine portions of each;
        var pSrc, pDst, thSrc, thDst;
        thSrc = image_angle - 90 - point_direction(srcX, srcY, dstX, dstY);
        thSrc = modf(thSrc + 180, 360) - 180;
        thDst = dstAngle - point_direction(srcX, srcY, dstX, dstY);
        thDst = modf(thDst + 180, 360) - 180;
        pSrc[0] = linearFalloff(thSrc / 90);
        pSrc[1] = linearFalloff(thSrc / 90 - 1);
        pSrc[2] = linearFalloff(modf(thSrc, 360) / 90 - 2);
        pSrc[3] = linearFalloff(thSrc / 90 + 1);

        pDst[0] = linearFalloff(modf(thDst, 360) / 90 - 2);
        pDst[1] = linearFalloff(thDst / 90 - 1);
        pDst[2] = linearFalloff(thDst / 90);
        pDst[3] = linearFalloff(thDst / 90 + 1);

        var desU, desV; desU = 0; desV = 0;
        var i; for ( i = 0; i < 4; i+=1)
        {
            desU += pSrc[i] * dLU[0, i] * (1 - t);
            desU += pDst[i] * dLU[1, i] * t;

            desV += pSrc[i] * dLV[0, i] * (1 - t);
            desV += pDst[i] * dLV[1, i] * t;
        }

        var desX, desY;
        desX = desU * vecUx + desV * vecVx + srcX;
        desY = desU * vecUy + desV * vecVy + srcY;

        with (fire)
        {
            xspeed = desX - x;
            yspeed = desY - y;
        }
    }
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// all fires reached destination
if (entityCanStep())
{
    if (flightTimer > 100)
    {
        with (destination)
        {
            tackleFireN = 0;
            spawnTimer = -1;
            timer = tackleFireWarmupTime;
        }
        flightTimer = 0;
    }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// mildly intelligent default assign

var preferredDistance; preferredDistance = 64;

// fix yscale (idempotent)
if (image_yscale == -1)
{
    image_yscale = 1;
    image_angle += 180;
    y += 16 * sin(degtorad(image_angle));
    x -= 16 * cos(degtorad(image_angle));
    ystart = y;
    xstart = x;
}

if (tag == "")
{
    setSection(x, y, false);
    var myTag; myTag = "AUTO-ASSIGN-" + string(x) + "," + string(y) + "-SRC";
    var altTag; altTag = "AUTO-ASSIGN-" + string(x) + "," + string(y) + "-DST";
    var candidates; candidates = makeArray();
    var candidateScore; candidateScore = makeArray();
    var candidateN; candidateN = 0;
    with (object_index)
    {
        setSection(x, y, false);

        // fix yscale (idempotent)
        if (image_yscale == -1)
        {
            image_yscale = 1;
            image_angle += 180;
            y += 16 * sin(degtorad(image_angle));
            ystart = y;
            x -= 16 * cos(degtorad(image_angle));
            xstart = x;
        }
        if (id != other.id && sectionLeft == other.sectionLeft && sectionTop == other.sectionTop && tag == "")
        {
            candidates[candidateN] = id;
            var pd; pd = point_direction(x, y, other.x, other.y);
            var pdA; pdA = angle_difference(pd, image_angle - 90);
            var pdB; pdB = angle_difference(pd, other.image_angle - 90);
            var p; p = abs(cos(degtorad(pdA))) + abs(cos(degtorad(pdB))) + 0.3;
            var myScore; myScore = sqrt(sqr(x - other.x) + sqr(y - other.y)) * p * p;
            candidateScore[candidateN] = myScore;
            candidateN+=1;
        }
    }

    if (candidateN > 0)
    {
        var index; index = argMin(candidateScore);

        // pair these
        with (candidates[index])
        {
            tag = altTag;
            dstTag = myTag;
        }
        tag = myTag;
        dstTag = altTag;
        startFull = true;
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// spawn event

event_inherited();

if (startFull)
{
    timer = tackleFireWarmupTime;
}
else
{
    timer = -1;
}

spawnTimer = -1;
tackleFireN = 0;
flightTimer = 0;

destination = noone;
with (object_index)
{
    if (tag == other.dstTag)
    {
        other.destination = id;
    }
}
