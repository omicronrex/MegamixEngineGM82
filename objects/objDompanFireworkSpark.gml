#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;
grav = 0;

contactDamage = 0;
image_speed = 0.15;

yspeed = -6;

delay = 0;
didit = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.timeStopped)
{
    if (yspeed < 0)
    {
        yspeed += 0.25;
    }

    if (yspeed == 0)
    {
        delay -= 1;
        if (delay <= 0)
        {
            visible = 0;
            i = instance_create(x, y + 2, objExplosion);
            with (i)
            {
                // event_perform(ev_create,0);
                sprite_index = sprDompanFirework;
                image_speed = 0.25;
                alarm[0] = ((1 / image_speed) * image_number) - 1;
                vspeed = 0.05;
            }
            delay = 8;
            didit += 1;
            if (didit == 1)
            {
                x -= 8;
                y += 8;
            }
            if (didit == 2)
            {
                x += 16;
                y += 8;
                with (obj100WattonVoid)
                {
                    fadephase = 2;
                }
            }
            if (didit == 3)
            {
                instance_destroy();
            }
        }
    }
}
