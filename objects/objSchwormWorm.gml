#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

calibrateDirection();

respawn = false;

healthpointsStart = 5;
healthpoints = healthpointsStart;
contactDamage = 2;

// Enemy specific code
yspeed = 0;
image_speed = 0.15; // STOP USING THIS VARIABLE
image_index = 0;
timer = 0;

setTargetStep(); // this one isnt prtEnemyProjectile so, gotta do this here lol
if (instance_exists(target))
{
    dx = abs(x - target.x);
    dy = target.y - y;

    if (dy > -9 || dy < -18)
    {
        switch (round(dy / 16) * 16)
        {
            case 0:
                const = 20;
                break;
            case 16:
                const = 10;
                break;
            case 32:
                const = 7;
                break;
            case 48:
                const = 5.5;
                break;
            case 64:
                const = 4;
                break;
            case 80:
                const = 3.7;
                break;
            case 96:
                const = 3.5;
                break;
            case 112:
                const = 3.3;
                break;
            case 128:
                const = 3;
                break;
            case -16:
                const = -120;
                break;
            case -32:
                const = -13;
                break;
            case -48:
                const = -7;
                break;
            case -64:
                const = -5;
                break;
            default:
                const = 20;
                break;
        }
    }
    else
    {
        if (dy == -18 || dy == -17)
            const = 250;
        else if (dy == -16 || dy == -15)
            const = 120;
        else if (dy == -14 || dy == -13)
            const = 60;
        else if (dy == -12 || dy == -11)
            const = 40;
        else
            const = 30;
    }


    var ddY;
    if (dy == -18)
        ddY = -17; // To avoid dividing by 0
    else
        ddY = dy;

    xspeed = dx / ((1 + (ddY / 6)) * const) * image_xscale;
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    image_speed = 0.15;
    if (ground)
    {
        timer += 1;
        xspeed = 0;
        if (timer >= 128)
        {
            instance_create(bboxGetXCenter(), bboxGetYCenter(), objExplosion);
            instance_destroy();
        }
    }
}
else
{
    image_speed = 0;
}
