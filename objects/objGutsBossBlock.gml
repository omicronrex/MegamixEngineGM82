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

phase = 0;
timer = 0;

reflectable = 0;
ignoreCollision = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (global.frozen == false && global.timeStopped == false)
{
    if (phase == 0)
    {
        if (!place_meeting(x, y - 2, objGutsMan))
            y += 4;
        else
            phase = 1;
    }
    else if (!ignoreCollision)
    {
        timer += 1;
        if (checkSolid(0, 0, 1, 1) && xspeed != 0 && yspeed != 0)
        {
            for (i = 0; i <= 1; i += 1) // X
                for (j = 0; j <= 1; j += 1) // Y
                {
                    rubble = instance_create(x - (8 * sign(xspeed)) + i * 16,
                        y - 8 + j * 16, objGutsBossBlockRubble);
                    if (i == 0)
                        rubble.yspeed = -2 + (j / 2);
                    rubble.xspeed = (4 - j) * sign(xspeed);
                }
            instance_destroy();
        }
    }


    if (timer == 30)
    {
        var spd;
        spd = 4;
        if (instance_exists(target))
        {
            var angle;
            angle = point_direction(spriteGetXCenter(), spriteGetYCenter(),
                spriteGetXCenterObject(target),
                spriteGetYCenterObject(target));

            xspeed = cos(degtorad(angle)) * spd;
            yspeed = -sin(degtorad(angle)) * spd;
        }
        else
        {
            xspeed = spd;
            yspeed = 0;
        }
    }
}

if (!ignoreCollision && (!insideView()) || (!instance_exists(objGutsMan)))
    instance_destroy();
