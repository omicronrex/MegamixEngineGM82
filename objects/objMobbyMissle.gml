#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;
grav = 0;

contactDamage = 4;

spd = 3;
yspeed = 0;
missleDir = 0;
animTimer = 0;
image_index = 2;
image_speed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (global.frozen == false && global.timeStopped == false)
{
    if (instance_exists(target))
    {
        var angle;
        angle = point_direction(spriteGetXCenter(), spriteGetYCenter(),
            spriteGetXCenterObject(target),
            spriteGetYCenterObject(target));
        yspeed = min(4, max(-4, -sin(degtorad(angle)) * spd));
    }
    else
        yspeed = 0;

    if (round(yspeed) >= 2)
        missleDir = 1;
    else if (round(yspeed) <= -2)
        missleDir = -1;
    else
        missleDir = 0;

    if (animTimer < 2)
        animTimer += 1;
    else
    {
        if (image_index == 3 + (missleDir * 2))
            image_index = 2 + (missleDir * 2);
        else
            image_index = 3 + (missleDir * 2);
        animTimer = 0;
    }
}
