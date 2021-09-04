#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// The head of this enemy is a solid that players can stand on, he will shoot sound waves that boounce
// off walls,but only once. His body is destructible, but it will
// regenerate over time, how tall he is can be adjusted via creation code.

event_inherited();
healthpointsStart = 4;
healthpoints = healthpointsStart;
isSolid = 1;
facePlayer = true;
doesTransition = false;
category = "semi bulky";

faction=7;
behaviourType=3;

// Enemy specific code

//@cc how tall it can be
maxSize = 3;

//@cc Change colours: 0 (default) = purple, 1 = orange
col = 0;

size = 0;

//@cc Initial size, can't be higher than maxSize
spawnSize = -1;

hasWeight = false;
timer = 0;
shootTimer = 0;
animTimer = 0;
killOverride = false; // Allow tornado blow and company to trigger event_user(10)

y -= 1;
ystart = y;
prevY = y;
imgOffset = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Enemy AI
event_inherited();

if (entityCanStep())
{
    if(facePlayer)
        calibrateDirection(objMegaman);
    var phw = hasWeight;
    hasWeight = false;
    var ID = id;
    with (prtEntity)
    {
        if (!blockCollision || !ground || id == other.id || (faction != 3 && object_index != objMegaman))
            continue;

        if (ground && bbox_bottom > other.bbox_top - 2 && place_meeting(x, y + 2, other.id))
        {
            if (object_index == objMegaman || (category != "" && (string_pos("heavy", category) || string_pos("bulky", category))))
            {
                other.hasWeight = true;
            }
        }
    }
    if (hasWeight)
    {
        image_index = 2 + imgOffset;
        if (phw != hasWeight)
            timer = 0;
        timer += 1;
        if (timer > 64 && size > 0)
        {
            // pop
            var i = noone;
            var maxIndex = -99999;
            with (objBariIIIBody)
            {
                if (owner == other.id && index > maxIndex)
                {
                    maxIndex = index;
                    i = id;
                }
            }
            if (i != noone)
            {
                with (i)
                {
                    appear = false;
                }
            }
            playSFX(sfxBariIIIRegen);
        }
        if (timer > 64)
            timer = 0;
    }
    else
    {
        image_index = 0 + imgOffset;
        if (phw != hasWeight)
        {
            timer = 0;
        }
        if (!ground)
        {
            timer = 0;
        }
        if (ground && size < maxSize)
        {
            timer += 1;
            if (timer > 30)
            {
                timer = 0;

                // Push
                playSFX(sfxBariIIIRegen);
                var i = instance_create(x, bbox_bottom + 12 * size, objBariIIIBody);
                i.owner = id;
                i.col = col;
                var maxIndex = -99999;
                with (objBariIIIBody)
                {
                    if (owner == other.id && index > maxIndex)
                        maxIndex = index;
                }
                i.index = maxIndex + 1;
                size += 1;
                yspeed = 0;
            }
        }
        if (ground)
        {
            shootTimer += 1;
            var shT = 160;
            if (shootTimer >= shT - 10 && shootTimer <= shT)
            {
                // Shoot
                image_index = 1 + imgOffset;
                if (shootTimer == shT - 10)
                    event_user(0);
            }
            else if (shootTimer > shT)
            {
                image_index = 0 + imgOffset;
                shootTimer = 0;
            }
        }
    }
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
prevY = y;
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Shoot
for (var i = -1; i < 2; i += 2)
{
    var sw = instance_create(x + (14) * image_xscale, y-4, objBariIIISoundWave);
    sw.i = i;
    with (sw)
        event_user(0);
}
playSFX(sfxBariIIIShoot);
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (instance_exists(objBariIIIBody))
{
    with (objBariIIIBody)
    {
        if (owner == other.id)
        {
            instance_create(x, y - 6, objExplosion);
            event_user(EV_DEATH);
        }
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

/// On spawn
if (spawned)
{
    if (maxSize < 0)
        maxSize = 3;
    if (spawnSize < 0)
        spawnSize = maxSize;
    shootTimer = 0;
    timer = 0;
    var sz = min(maxSize, spawnSize);
    y -= sz * 12;
    if (instance_exists(objBariIIIBody))
    {
        with (objBariIIIBody)
        {
            if (owner == other.id)
            {
                instance_destroy();
            }
        }
    }
    size = 0;
    for (size = 0; size < sz; size++)
    {
        var i = instance_create(x, bbox_bottom + 1 + 12 + 12 * size, objBariIIIBody);
        i.owner = id;
        i.animFrame = 2;
        i.image_index = 2 + imgOffset;
        i.mask_index = mskBariIIIBody2;
        i.col = col;
        i.index = size;
        with (i)
            shiftObject(0, -1, true);
    }
}
else
{
    if (instance_exists(objBariIIIBody))
    {
        with (objBariIIIBody)
        {
            if (owner == other.id)
            {
                instance_destroy();
            }
        }
    }
}
imgOffset = col * 3;
