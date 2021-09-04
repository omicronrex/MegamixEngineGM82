#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A platform that constantly spawns pillars and falls if there aren't any below it.
// Creation code (all optional):
// autodeath = <boolean>. If true, the platform will grab the nearest enemy standing on it and
// blow up when it dies. Default true.

event_inherited();

grav = 0;
blockCollision = 0;
bubbleTimer = -1;
canHit = false;
isSolid = 1;

spd = 0.5;

bossID=noone;
enemyObject = objKabatoncue; //@cc the object index of the object over the platform, if its not kabatoncue
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // Snap downwards if a piece is missing
    if (!place_meeting(x, y + 8, objSolid)
        && !place_meeting(x, y + 8, objKabatoncuePlatformPiece))
    {
        shiftObject(0, 16, 1);
        var _yprev; _yprev = y;
        while (place_meeting(x, y, objSolid)
            || place_meeting(x, y, objKabatoncuePlatformPiece))
            y -= 1;
        var ym; ym = _yprev - y;
        y = _yprev;
        shiftObject(0, ym, 0);
    }

    // Crawl back up if it's lowered
    if (y > ystart && !instance_exists(objSectionSwitcher))
    {
        yspeed = -spd;

        if (!place_meeting(x, ystart + (height + 1) * 16,
            objKabatoncuePlatformPiece))
        {
            plat = instance_create(x, ystart + (height + 1) * 16,
                objKabatoncuePlatformPiece);
            plat.offset = 16;
        }
    }
    else
    {
        yspeed = 0;
    }

    // attach the miniboss
    if(bossID!=noone)
    {
        if(instance_exists(bossID) && !bossID.dead)
        {
            bossID.y += (bbox_top - 1) - bossID.bbox_bottom;
        }
        else{
            instance_create(x, y, objBigExplosion);
                instance_destroy();
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

height = 0;

while (!collision_rectangle(x - 4, y + 16, x + 4, y + 16 + (height * 16), objSolid, false, true) && height < 32)
{
    height += 1;
}
if (spawned)
{
    // set boss to find
    if (instance_exists(enemyObject))
    {
        bossID = instance_nearest(x, y, enemyObject);
    }
}

if (height > 0)
{
    for (i = 1; i <= height; i += 1)
    {
        instance_create(x, y + i * 16, objKabatoncuePlatformPiece);
    }
}
