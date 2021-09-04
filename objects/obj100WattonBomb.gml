#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;

contactDamage = 4;
image_speed = 0.15;

yspeed = -4.5;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.timeStopped)
{
    if (yspeed > 7)
    {
        yspeed = 7;
    }

    if (yspeed >= 0)
    {
        depth = -1;
    }

    if (y >= ystart + 32)
    {
        if (irandom(8) == 0)
        {
            for (i = 0; i < 5; i += 1)
            {
                b = instance_create(x, y, objEnemyBullet);
                with (b)
                {
                    sprite_index = spr100WattonBombBullet;
                    image_speed = 0.2;
                    contactDamage = 2;
                    motion_set(180 + other.i * 45, 1.5);
                }
            }
            instance_destroy();
        }
    }
}
