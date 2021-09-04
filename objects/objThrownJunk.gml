#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 4;

thrown = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.timeStopped)
{
    if (!thrown)
    {
        butts = collision_rectangle(x, y, x + 32, y + 32, objJunkGolem, false, true);
        if (butts)
        {
            if (butts.visible && instance_exists(target))
            {
                butts.image_index = 2;
                thrown = true;
                if (instance_exists(target))
                {
                    move_towards_point(target.x, target.y, 5);
                } // TODO: make this modify xspeed/yspeed
                yspeed = 0;
            }
        }
    }

    if (!thrown)
    {
        grav = gravAccel;
        blockCollision = 0;
    }
    else
    {
        grav = 0;
        blockCollision = 1;

        if (checkSolid(0, 0))
        {
            i = instance_create(x + 16, y + 24, objJunkDebris);
            i.xspeed = -1;
            i.yspeed = -4;
            i = instance_create(x + 16, y + 24, objJunkDebris);
            i.xspeed = -.5;
            i.yspeed = -2;
            i = instance_create(x + 16, y + 24, objJunkDebris);
            i.xspeed = .5;
            i.yspeed = -2;
            i = instance_create(x + 16, y + 24, objJunkDebris);
            i.xspeed = 1;
            i.yspeed = -4;
            instance_destroy();
        }
    }
}
