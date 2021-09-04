#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
respawn = false;
healthpointsStart = 1;
healthpoints = healthpointsStart;
stopOnFlash = false;

contactDamage = 6;
image_speed = 0;

xspeed = 0;
yspeed = 0;
ground = false;

canCollide = 32;

despawnRange = -1;

blockCollision = false;
parent = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (global.frozen == false)
{
    canCollide-=1;

    if (canCollide > 0 && checkSolid(x, y))
    {
        canCollide = 32;
    }

    if (canCollide <= 0 && !blockCollision)
    {
        blockCollision = true;
    }

    if (ground && canCollide <= 0)
    {
        var inst; inst = instance_create(x, y, objHarmfulExplosion);
        with (parent)
        {
            child = inst.id;
        }

        var i; for ( i = 0; i < 2; i += 1)
        {
            inst = instance_create(x, y - 8, objNewShotmanBullet);
            inst.grav = 0.25;
            inst.xspeed = -1.25 + (2.5 * i);
            inst.yspeed = -4;
            inst.contactDamage = 0;
            inst.sprite_index = sprPowerPistonDebry;
            if (i == 0)
            {
                inst.image_index = 0;
            }
            else
            {
                inst.image_index = 1;
            }
        }
        playSFX(sfxExplosion);
        instance_destroy();
    }

    if (y >= view_yview + view_hview)
    {
        instance_destroy();
    }
}
else
{
    image_speed = 0;
}
