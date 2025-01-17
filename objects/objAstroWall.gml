#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
    Astral enemy projection. Enemy silhouettes
    seep through and periodically drop out.

    Set the creation code on only one of these per section.

    This object does not come with the white backing. You
    will have to tile that yourself. bgNESPalette comes
    with a nice set of greys.
*/

event_inherited();

//@cc xspeed at which silhouttes move
entityXSpeed = 1;

//@cc yspeed at which silhouttes move
entityYSpeed = 0;

//@cc interval between enemy drops
dropInterval = 160;

//@cc number of silhouettes per block. May be reduced automatically if entity sprites are too large.
spawnDensity = 1 / 11;

DEFAULT_SPAWN_LIST = makeArray(objMet, objYambow, objMechakkero, objFuraibon);

//@cc set this to be an array of entity objects
spawnList = DEFAULT_SPAWN_LIST;

//@cc number of frames between ripple animation advancing
rippleAnimationInterval = 4;

//@cc sprite to use for ripple
rippleAnimationSprite = sprAstroWallRipple;

timer = 0;
respawnRange = -1;
despawnRange = -1;
grav = 0;
blockCollision = false;
bubbleTimer = -1;
canHit = false;
contactDamage = 0;
isMaster = false;
master = noone;
firstFrame = true;
entityN = 0;
popList = makeArray("");
rippleN = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep() && isMaster)
{
    if (firstFrame)
    {
        // calculate number of enemies according to section size
        setSection(x, y, false);
        var sectionArea; sectionArea = (sectionRight - sectionLeft) * (sectionBottom - sectionTop);
        entityN = max(1, ceil(sectionArea * spawnDensity / 16 / 16));
        entityObject = allocateArray(entityN, noone);
        with (object_index)
        {
            master = other.id;
        }
        minDist = sqrt(sectionArea / entityN) * 0.5;
    }

    timer += 1;
    var popEntity; popEntity = false;
    if (timer > dropInterval)
    {
        timer = 0;
        popEntity = true;
        popN = 0;
        popList = makeArray("");
    }

    // update entities
    var i; for ( i = 0; i < entityN; i+=1)
    {
        if (entityObject[i] != noone)
        {
            // existing entity
            entityX[i] += entityXSpeed;
            entityY[i] += entityYSpeed;
            var popX; popX = entityX[i] + entityWidth[i] / 2;
            var popY; popY = entityY[i] + entityHeight[i] / 2;

            // pop out of wall candidate
            if (popEntity && insideView(popX, popY) && position_meeting(popX, popY, object_index))
            {
                popList[popN] = i; popN+=1
            }

            // leaving section?
            // I wonder how expensive this is...
            if (!(insideSection(entityX[i], entityY[i])
                || insideSection(entityX[i] + entityWidth[i], entityY[i])
                || insideSection(entityX[i], entityY[i] + entityHeight[i])
                || insideSection(entityX[i] + entityWidth[i], entityY[i] + entityHeight[i])
                || insideSection(entityX[i] + entityXSpeed * 8, entityY[i] + entityYSpeed * 8)))
            {
                // remove entity
                entityObject[i] = noone;
            }
        }
        else
        {
            // new entity
            entityObject[i] = chooseFromArray(spawnList);
            entitySprite[i] = object_get_sprite(entityObject[i]);
            entityWidth[i] = sprite_get_width(entitySprite[i]);
            entityHeight[i] = sprite_get_height(entitySprite[i]);

            // ensure enough room:
            minDist = max(minDist, point_distance(0, 0, entityWidth[i], entityHeight[i]));
            entityPop[i] = false;
            entityXScale[i] = choose(-1, 1);
            if (sign(entityXSpeed) != 0)
            {
                entityXScale[i] = sign(entityXSpeed);
            }

            var minDistReject; minDistReject = minDist;
            var success; success = false;
            repeat (64)
            {
                // place randomly
                entityX[i] = sectionLeft + random(sectionRight - sectionLeft);
                entityY[i] = sectionTop + random(sectionBottom - sectionTop);

                if (!firstFrame)
                {
                    // project outside of room
                    while (insideSection(entityX[i], entityY[i])
                        || insideSection(entityX[i] + entityWidth[i], entityY[i])
                        || insideSection(entityX[i], entityY[i] + entityHeight[i])
                        || insideSection(entityX[i] + entityWidth[i], entityY[i] + entityHeight[i]))
                    {
                        entityX[i] -= entityXSpeed;
                        entityY[i] -= entityYSpeed;
                    }
                }

                // rejection sample: shouldn't be too near other silhouettes
                var redo; redo = false;
                var j; for ( j = 0; j < entityN; j+=1)
                {
                    if (i != j && entityObject[j] != noone)
                    {
                        var dist; dist = point_distance(entityX[i], entityY[i], entityX[j], entityY[j]);
                        if (dist < minDistReject)
                        {
                            redo = true;
                            break;
                        }
                    }
                }
                if (!redo)
                {
                    success = true;
                    break;
                }

                // make next iteration slightly easier
                minDistReject = max(minDist / 2, 0.985 * minDistReject);
            }

            // last resort -=1 remove object completely
            if (!success)
            {
                entityObject[i] = noone;
            }
        }
    }

    // randomly select a valid candidate to pop out of wall
    if (popEntity && popN > 0)
    {
        var popIndex; popIndex = chooseFromArray(popList);
        entityPop[popIndex] = true;
        with (instance_create(entityX[popIndex] + sprite_get_xoffset(entitySprite[popIndex]),
            entityY[popIndex] + sprite_get_yoffset(entitySprite[popIndex]),
            entityObject[popIndex]))
        {
            image_xscale = other.entityXScale[popIndex];
            respawn = false;

            // ripple
            other.rippleTime[other.rippleN] = -1;
            other.rippleX[other.rippleN] = x;
            other.rippleY[other.rippleN] = y;
            other.rippleXScale[other.rippleN] = image_xscale;
            other.rippleN+=1;
        }
        entityObject[i] = noone;
        playSFX(sfxAstroWallBwoop);
    }

    // ripple timer
    var i; for ( i = 0; i < rippleN; i+=1)
    {
        rippleTime[i]+=1;
        if (rippleTime[i] >= rippleAnimationInterval * sprite_get_number(rippleAnimationSprite))
        {
            rippleN-=1 swap(rippleTime, i, rippleN); i-=1
        }
    }

    firstFrame = false;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// spawn
event_inherited();

// elect a master
if (spawned && master == noone)
{
    with (object_index)
    {
        master = noone;
        isMaster = (id == object_index.id);
    }
    if (isMaster)
    {
        with (object_index)
        {
            master = other.id;

            // if we have any creation code, copy it to the master
            if (entityXSpeed != 1 || entityYSpeed != 0 || dropInterval != 160
                || spawnDensity != 1 / 11 || spawnList != DEFAULT_SPAWN_LIST
                || rippleAnimationInterval != 4 || rippleAnimationSprite != rippleAnimationSprite)
            {
                master.entityXSpeed = entityXSpeed;
                master.entityYSpeed = entityYSpeed;
                master.dropInterval = dropInterval;
                master.spawnDensity = 1 / 7;
                master.spawnList = spawnList;
                master.rippleAnimationInterval = rippleAnimationInterval;
                master.rippleAnimationSprite = rippleAnimationSprite;
            }
        }

        firstFrame = true;
        timer = 0;
        rippleN = 0;
    }
}
if (!spawned)
{
    master = noone;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// draw silhouettes
if (master == noone)
{
    exit;
}

// silhouettes
var i; for (i = 0; i < master.entityN; i+=1)
{
    drawSpriteCropped(master.entitySprite[i], 0,
        master.entityX[i] - sprite_get_xoffset(master.entitySprite[i]),
        master.entityY[i] - sprite_get_yoffset(master.entitySprite[i]),
        bbox_left, bbox_top,
        bbox_right, bbox_bottom,
        master.entityXScale[i],
        1,
        c_black,
        0.4);
}

// ripples
var i; for (i = 0; i < master.rippleN; i+=1)
{
    drawSpriteCropped(master.rippleAnimationSprite, master.rippleTime[i] div master.rippleAnimationInterval,
        master.rippleX[i] - sprite_get_xoffset(master.rippleAnimationSprite),
        master.rippleY[i] - sprite_get_yoffset(master.rippleAnimationSprite),
        bbox_left, bbox_top,
        bbox_right, bbox_bottom,
        master.rippleXScale[i],
        1,
        c_black,
        0.4);
}
