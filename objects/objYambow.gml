#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "flying, nature";

blockCollision = 0;
grav = 0;

// Enemy specific code
state = 0;
actionTimer = 0;
bounceTimer = 0;

image_speed = 0.25;

col = 0; // 0 = red; 1 = blue;
init = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{
    init = 0;
    switch (col)
    {
        case 0:
            sprite_index = sprYambowRed;
            break;
        case 1:
            sprite_index = sprYambowBlue;
            break;
    }
}

event_inherited();

if (entityCanStep())
{
    if (instance_exists(target))
    {
        if (state == 1 || (state == 4 && actionTimer > 15))
        {
            yspeed += 0.5;
            yspeed = min(7, yspeed);
        }
        if (state == 2 || state == 5)
        {
            bounceTimer += 1;
            if (bounceTimer < 4)
            {
                y += 1.5;
            }
            else if (bounceTimer > 4 && bounceTimer < 9)
            {
                y -= 1.5;
            }
            else if (bounceTimer == 20)
            {
                state += 1;
                calibrateDirection();
                xspeed = 3.5 * image_xscale;
                bounceTimer = 0;
            }
        }

        if (collision_rectangle(x - 96, y - 224, x + 96, y + 224, target,
            false, true) && state == 0)
        {
            calibrateDirection();
            state = 1;
            yspeed = 1;
        }
        if (collision_rectangle(x - view_wview[0], y - 224, x + view_wview[0], y + 64, target,
            false, true) && state == 1)
        {
            state = 2;
            yspeed = 0;
        }
        if (state == 3 && ((image_xscale == 1 && x > target.x + 32)
            || (image_xscale == -1 && x < target.x - 32)))
        {
            xspeed = 0;
            calibrateDirection();
            state = 4;
        }
        if (state == 4)
        {
            actionTimer += 1;
            if (actionTimer == 15)
            {
                yspeed = 1;
            }
            if (collision_rectangle(x - view_wview[0], y - 224, x + view_wview[0], y, target,
                false, true))
            {
                state = 5;
                yspeed = 0;
            }
        }
    }
}
else if (dead)
{
    state = 0;
    bounceTimer = 0;
    actionTimer = 0;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (state)
{
    event_inherited();
}
