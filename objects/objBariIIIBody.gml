#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Bari III Body
event_inherited();
contactDamage = 3;
healthpointsStart = 2;
healthpoints = 2;
respawn = false;
despawnRange = 32;
isSolid = 1;
fnsolid = true;
facePlayer = false;
facePlayerOnSpawn = false;
dieToSpikes = false;
canIce = false;
itemDrop = -1;
col = 0;

// AI
owner = noone;
animFrame = 0;
appear = true;
canShift = true;
index = 0;
killOverride = false;


mask_index = mskBariIIIBody0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (appear)
    {
        if (floor(animFrame) < 2)
        {
            animFrame += 0.2;
            if (animFrame > 2)
                animFrame = 2;
        }
    }
    else
    {
        if (floor(animFrame >= 0))
        {
            animFrame -= 0.2;
            if (animFrame < 0)
            {
                animFrame = 0;
                event_user(0);
                exit;
            }
        }
    }
    var pindx; pindx = image_index;
    image_index = floor(animFrame);
    if (image_index == 0)
    {
        mask_index = mskBariIIIBody0;
    }
    else if (image_index == 1)
    {
        mask_index = mskBariIIIBody1;
    }
    else
    {
        mask_index = mskBariIIIBody2;
    }
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    var mIndx; mIndx = -999999;
    if (!instance_exists(owner))
    {
        exit;
    }
    with (objBariIIIBody)
    {
        if (owner.id == other.owner.id && index > mIndx)
            mIndx = index;
    }
    if (mIndx != index)
        exit;
    if (true) // Keep the parts toghether
    {
        var i; i = self.id;
        var minIndex; minIndex = 99999;
        with (objBariIIIBody)
        {
            if (owner.id == other.owner.id && index < minIndex)
                minIndex = index;
        }
        while (i != noone)
        {
            with (i)
            {
                if (index == minIndex)
                {
                    i = instance_place(x, y - 4, owner);
                    with (owner)
                    {
                        var xdist; xdist = other.x - x;
                        shiftObject(xdist, 0, false);
                        x = other.x;

                        if (i != noone)
                        {
                            var dist; dist = other.bbox_top - 1 - bbox_bottom;

                            // var xdist; xdist = other.x-x;
                            shiftObject(0, dist, false);
                            y = other.bbox_top - 1;
                            ground = true;
                            yspeed = 0;
                        }
                    }
                    i = noone;
                    break;
                }
                i = noone;
                if (i != noone)
                { }
                else
                {
                    var minId; minId = index;
                    i = noone;
                    with (objBariIIIBody)
                    {
                        if (owner.id == other.owner.id && index < minId)
                        {
                            minId = index;
                            i = id;
                            break;
                        }
                    }
                    pmi = mask_index;

                    if (i != noone)
                    {
                        with (i)
                        {
                            var xdist; xdist = other.x - x;
                            shiftObject(xdist, 0, false);
                            x = other.x;
                        }
                        mask_index = mskBariIIIBody2;
                        if (place_meeting(x, y - 2, i))
                        {
                            mask_index = pmi;
                            with (i)
                            {
                                var dist; dist = other.bbox_top - 1 - bbox_bottom;
                                shiftObject(0, dist, false);
                                y = other.bbox_top - 1;
                            }
                        }
                        mask_index = pmi;
                    }
                }
            }
        }
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!instance_exists(owner))
{
    exit;
}
owner.size -= 1;
owner.timer = 0;
owner.shootTimer = 0;
if (dead)
    exit;
if (image_index != 0)
    exit;
y += 4;
if (true) // Keep the parts toghether
{
    var i; i = self.id;
    var Other; Other = id;
    var minIndex; minIndex = 99999;
    with (objBariIIIBody)
    {
        if (owner == other.owner.id && index < minIndex)
            minIndex = index;
    }
    while (i != noone)
    {
        with (i)
        {
            if (index == minIndex)
            {
                i = instance_place(x, y - 4, owner);
                with (owner)
                {
                    var xdist; xdist = other.x - x;
                    shiftObject(xdist, 0, false);
                    x = other.x;
                    if (i != noone)
                    {
                        var dist; dist = other.bbox_top - 1 - bbox_bottom;
                        shiftObject(0, dist, false);
                        y = other.bbox_top - 1;
                        ground = true;
                        yspeed = 0;
                    }
                }
                i = noone;
                break;
            }
            i = noone;
            if (i != noone)
            { }
            else
            {
                var maxIndex; maxIndex = index;
                i = noone;
                with (objBariIIIBody)
                {
                    if (owner == other.owner && index < maxIndex)
                    {
                        i = id;
                        break;
                    }
                }
                with (i)
                {
                    var dist; dist = other.bbox_top - 1 - bbox_bottom;
                    var xdist; xdist = other.x - x;
                    shiftObject(xdist, dist, false);
                }
            }
        }
    }
}
owner = noone;
instance_destroy();
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dead = true;
instance_create(x, y, objExplosion);

if (instance_exists(owner))
{
    owner.snap = false;
}
event_user(0);
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if(spawned)
{
    switch (col)
    {
        case 1:
            sprite_index = sprBariIIIBodyOrange;
            break;
        default:
            sprite_index = sprBariIIIBody;
            break;
    }
}
else
{
    event_user(EV_DEATH);
}
