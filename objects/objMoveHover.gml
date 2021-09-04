#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 100;
healthpoints = healthpointsStart;

image_speed = 0;
isSolid = 1;
grav = 0;
blockCollision = true;
returnTimer = 0;
moveTimer = 0;
moveDir = 0;
animTimer = 0;

// number of frames it takes to shift after being shot
shiftTime = 30;
shiftDist = 16;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    animTimer = (animTimer + 1) mod 15;
    image_index = animTimer div 5;
    xspeed = 0;
    image_xscale = 1;
    if (moveTimer > 0)
    {
        returnTimer = 0;
        xspeed = 2 * moveDir * moveTimer / shiftTime * shiftDist / shiftTime;
        moveTimer-=1;
        if (moveTimer >= shiftTime - 10)
        {
            animTimer = 0;
            image_xscale = moveDir;
            image_index = 3;
            with (prtEntity)
                if (ground && place_meeting(x, y + 1, other))
                    shiftObject(0, -4 * other.image_yscale, true);
        }
    }
    else
    {
        returnTimer+=1;
        if (returnTimer > 60 && abs(x - xstart) > 1)
        {
            xspeed = sign(xstart - x) * 0.4;
        }
    }
}
#define Other_19
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Do nothing

healthpoints = healthpointsStart;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var dir; dir = point_direction(x, y, other.x, other.y);


if (dir < 70 || dir > 290)
{
    moveDir = -1;
    moveTimer = shiftTime;
    playSFX(sfxEnemyHit);
}
else if (dir > 110 && dir < 250)
{
    moveDir = 1;
    moveTimer = shiftTime;
    playSFX(sfxEnemyHit);
}
else
{
    other.guardCancel = 2;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

returnTimer = 0;
moveTimer = 0;
moveDir = 0;
animTimer = 0;
