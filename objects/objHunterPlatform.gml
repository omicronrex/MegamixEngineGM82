#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// creation code events: (optional)
// isRandom = false; // is the hunter platform's movement completely random, like it is in the Hunter boss fight. set to true to replicate the original boss.
// moveDir = image_yscale*-1; // in the room editor, set the yscale to -1 to have the hunter platform start by moving down.
// minY = -4; them minimum amount of blocks the hunter platform can move up in 8 pixel distances - set to 0 to have the minimum be where the hunter platform starts.
// maxY = 4; // see above, but for down
// startYSet = 0; // what number in the movement "sequence" does the hunter platform start at.
// timerMax = 32; // how long does the hunter platform wait before moving.

event_inherited();

canHit = false;
isSolid = 1;

phase = 1;
timerN = 64;
timerMax = 32;
isRandom = false;

moveDir = image_yscale * -1;
minY = -4;
maxY = 4;

startYSet = 0;
forceMove = false;
ySet = 0;
oldYSet = 0;

shiftVisible = 1;
blockCollision = 0;
grav = 0;
bubbleTimer = -1;

despawnRange = 64;
hasTriggered = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (!hasTriggered)
{
    ySet = startYSet;
    y = ystart + (ySet * 8);
    hasTriggered = true;
}
if (instance_exists(objMegaman))
{
    if (objMegaman.showReady)
        timerN = timerMax * 2;
}
if (!global.frozen && !dead && !global.timeStopped)
{
    timerN -= 1;
    if (timerN == 0 || forceMove)
    {
        timerN = timerMax;
        oldYSet = ySet;
        forceMove = false;
        if (isRandom)
            ySet = minY + irandom(abs(minY) + maxY);
        else
            ySet += moveDir;
        if (ySet > maxY)
        {
            moveDir = -1;
            ySet = maxY - 1;
        }
        if (ySet < minY)
        {
            moveDir = 1;
            ySet = minY + 1;
        }

        //New code, use shifting script
        var movey; movey = (ystart + (ySet * 8)) - y;
        shiftObject(0,movey,blockCollision);

        //Old code, manually shift entities
        /*
        with (prtEntity)
        {
            var i; for ( i = 0; i < abs((other.ySet - other.oldYSet)); i += 1)
            {
                if (place_meeting(x, y + sign(y - other.y), other) && blockCollision == 1)
                {
                    y += sign(other.ySet - other.oldYSet) * 8;
                    if (place_meeting(x, y, objSolid))
                        event_user(EV_DEATH);
                }
            }
        }
        with (objMegaman)
        {
            // if instance_place(x,y+sign(y - other.y),other) && blockCollision = 1
            // y += sign(other.ySet) * 8;
            var i; for ( i = 0; i < abs((other.ySet - other.oldYSet)); i += 1)
            {
                if (place_meeting(x, y + sign(y - other.y), other) && blockCollision == 1)
                {
                    y += sign(other.ySet - other.oldYSet) * 8;
                    if (place_meeting(x, y, objSolid))
                        event_user(EV_DEATH);
                }
            }
        }
        */
    }
}
else if (dead)
{
    ySet = startYSet;
    oldYSet = ySet;
    y = ystart + (ySet * 8);
    timerN = 64;
    blockCollision = 0;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index, image_index, round(x), round(y), image_xscale, 1, image_angle, image_blend, image_alpha);
