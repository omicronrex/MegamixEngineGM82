#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 2;

category = "cannons";

facePlayer = true;

animEndme = 0;
shootTimer = 0;
twinCooldown = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    animEndme += 1;
    if (!(animEndme mod 6))
    {
        image_index = (image_index == 0);
    }

    shootTimer += 1;
    if (shootTimer == 106)
    {
        i = instance_create(x + 12 * image_xscale, y - 4, objEnemyBullet);
        i.xspeed = 1.5 * image_xscale;
    }
    if (shootTimer >= 150)
    {
        shootTimer = 0;
    }

    if (!twinCooldown)
    {
        with (prtEntity)
        {
            if (!dead)
            {
                if (contactDamage)
                {
                    if (global.factionStance[faction, other.faction])
                    {
                        with (other)
                        {
                            if (collision_rectangle(x - 32, y - 32, x + 32, y, other, false, true))
                            {
                                i = instance_create(x + 8 * image_xscale, y - 16 + 1, objTwinCannonBullet);
                                i.xspeed = 4 * image_xscale;
                                twinCooldown = 44;
                                image_index = 2;
                                break;
                            }
                        }
                    }
                }
            }
        }
    }
    else
    {
        twinCooldown -= 1;
    }
}
else if (dead)
{
    shootTimer = -60;
    animEndme = 0;
    twinCooldown = 0;
    image_index = 0;
}
