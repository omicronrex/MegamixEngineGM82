#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

image_speed = 0;
canHit = false;
isSolid = 1;
animTimer = 0;

despawnRange = -1;
respawnRange = -1;

grav = 0;
blockCollision = false;
bubbleTimer = -1;
phase = 0; // 0: descending to ystart. 1: normal
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    var pressed; pressed = false;
    visible = true;
    with (prtEntity)
        if (blockCollision)
            if (ground && place_meeting(x, y + image_yscale, other))
                pressed = true;

    xspeed = 0;
    yspeed = 0;
    if (pressed && phase < 2)
    {
        // normal
        yspeed = -1.5;
        phase = 1;
    }
    if (phase == 0)
    {
        // descending from ceiling:
        yspeed = 3;
        if (y >= ystart - yspeed)
        {
            yspeed = ystart - y;
            phase = 1;
        }
    }
    if (phase == 2)
    {
        // retreat into ceiling
        yspeed = -3;
    }

    // visibility
    /* if (y < global.sectionTop + 8 && phase != 1)
    {
        visible = false;
        isSolid = false;
    }
    else
    {
        visible = true;
        isSolid = 2;
    } */

    var animTable; animTable = makeArray(1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 2, 3, 0);
    animTimer = (animTimer + 1) mod (array_length_1d(animTable) * 4);
    image_index = animTable[animTimer div 4];
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 2;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

animTimer = 0;
y = global.sectionTop;
phase = 0;
