#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = true;

healthpointsStart = 999;
healthpoints = healthpointsStart;
contactDamage = 4;

isTargetable = false;

blockCollision = 0;
grav = 0;
image_speed = 0;
image_index = 5;
parent = noone;

facePlayerOnSpawn = true;

// Enemy specific code
attackTimer = 0;
attackTimerMax = 24;
shotsFired = -9999;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    attackTimer++;

    if (image_index >= 5 && image_index < 7 && attackTimer >= 8 && shotsFired < 7)
    {
        image_index++;
        attackTimer = 0;
    }
    else if (image_index == 7 && attackTimer >= 8 && shotsFired < 7)
    {
        image_index = 2;
        attackTimer = 0;
        shotsFired = -2;
    }

    if (shotsFired >= -2 && attackTimer == 8)
    {
        if (shotsFired < 0 || shotsFired > 5 && shotsFired < 7)
        {
            image_index--;
            attackTimer = 0;
        }
        else if (shotsFired >= 7)
        {
            if (image_index > 5)
            {
                image_index--;
            }
            else if (image_index < 5)
            {
                image_index = 7;
            }
            else
            {
                with (parent)
                {
                    phase = 4;
                }
                instance_destroy();
            }
            attackTimer = 0;
        }
        else if (shotsFired != 5)
        {
            playSFX(sfxEnemyShootClassic);
            var inst = instance_create(x, y, objCombiloidProjectile);
            switch (image_index)
            {
                case 0:
                    inst.image_xscale = -image_xscale;
                    inst.dir = -40 * image_yscale;
                    inst.x = x - 22 * image_xscale;
                    inst.y = y + 30 * image_yscale;
                    break;
                case 1:
                    inst.image_xscale = -image_xscale;
                    inst.dir = -67.5 * image_yscale;
                    inst.x = x - 18 * image_xscale;
                    inst.y = y + 35 * image_yscale;
                    break;
                case 2:
                    inst.image_xscale = image_xscale;
                    inst.dir = -90 * image_yscale;
                    inst.x = x;
                    inst.y = y + 40 * image_yscale;
                    break;
                case 3:
                    inst.image_xscale = image_xscale;
                    inst.dir = -67.5 * image_yscale;
                    inst.x = x + 18 * image_xscale;
                    inst.y = y + 35 * image_yscale;
                    break;
                case 4:
                    inst.image_xscale = image_xscale;
                    inst.dir = -40 * image_yscale;
                    inst.x = x + 22 * image_xscale;
                    inst.y = y + 30 * image_yscale;
                    break;
            }
            inst.depth = 0;
        }
        shotsFired++;
    }
    if (shotsFired >= 0 && attackTimer == 24)
    {
        if (shotsFired < 5)
        {
            image_index++;
        }
        attackTimer = 0;
    }

    if (!instance_exists(parent))
    {
        event_user(EV_DEATH);
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_create(x, y + 20, objBigExplosion);
instance_destroy();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 3;
