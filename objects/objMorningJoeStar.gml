#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;
healthpointsStart = 999;
healthpoints = healthpointsStart;
contactDamage = 3;
blockCollision = 0;
canHit = true;
grav = 0;
despawnRange = -1;

reflectable = 0;

// Enemy specific code
newX = 0;
newY = 0;
parent = noone;
cFrame = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    cFrame += 0.125;

    switch (cFrame mod 4)
    {
        case 0:
            image_xscale = 1;
            image_yscale = 1;
            break;
        case 1:
            image_xscale = -1;
            image_yscale = 1;
            break;
        case 2:
            image_xscale = 1;
            image_yscale = -1;
            break;
        case 3:
            image_xscale = -1;
            image_yscale = -1;
            break;
    }

    if (instance_exists(parent))
    {
        if (!parent.dead)
        {
            if (x != newX)
            {
                x += (sign(x - newX) * -1) * 2;
            }
            if (y != newY)
            {
                y += (sign(y - newY) * -1) * 2;
            }
            if (healthpoints < 999)
            {
                healthpoints = 999;
            }
        }
        else
        {
            event_user(EV_DEATH);
        }
    }
    else
    {
        instance_destroy();
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
stopSFX(sfxEnemyHit);
instance_create(x, y, objExplosion);
