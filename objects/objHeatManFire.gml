#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = true;
grav = 0.25;

contactDamage = 4;
image_speed = 1 / 5;
stopOnFlash = false;

style = 0;
raiseTimer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    image_speed = 1 / 5;
    if (grav != 0)
        reflectable = true;
    else
        reflectable = false;
    if (checkSolid(0, 3) && style == 0)
    {
        xspeed = 0;
        blockCollision = false;
        grav = 0;

        raiseTimer++;
        if (raiseTimer == 1)
        {
            for (var i = 0; i < 4; i++)
            {
                spawnFire[i] = instance_create(x, y, object_index);
                with (spawnFire[i])
                {
                    style = 1;
                    grav = 0;
                    blockCollision = false;
                }
            }
        }
    }

    if (raiseTimer > 0)
    {
        raiseTimer++;
        var offset = raiseTimer;
        if (raiseTimer > 32)
            offset = 32;
        if (raiseTimer > 50)
            offset = 32 - (raiseTimer - 50);
        var die = false;
        if (offset < 0)
            die = true;
        for (var i = 0; i < 4; i++)
        {
            with (spawnFire[i])
            {
                style = 1;
                grav = 0;
                blockCollision = false;
                y = other.y - offset * i / 5;
                if (die)
                    instance_destroy();
            }
        }
        if (die)
            instance_destroy();
    }
}
else
{
    image_speed = 0;
}
