#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "cluster, flying, nature";

blockCollision = 0;
grav = 0;

facePlayer = true;

// Enemy specific code
image_speed = 0.15;

shootAngle = 10;

cooldownTimer = 0;
cooldownMax = 75;
resetCooldown = 115;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // move enemy towards mega man whilst countdown is off..
    if (instance_exists(target))
    {
        yspeed = 0;
        if (cooldownTimer < cooldownMax)
        {
            move_towards_point(target.x, target.y, 0.25);
        }
        else
        {
            speed = 0;
        }

        // shooting code:
        cooldownTimer += 1;
        if (cooldownTimer == resetCooldown)
        {
            cooldownTimer = 0;
        }

        if (cooldownTimer == cooldownMax)
        {
            // Shoot
            var getAngle;

            // If megaman exists, grab his angle, otherwise grab some random different angle.
            if (instance_exists(target))
            {
                getAngle = point_direction(x, y, target.x, target.y);
                direct = -1;
            }
            else
            {
                getAngle = point_direction(x, y, x + (45), 45);
                direct = -1;
            }

            var ID;
            ID = instance_create(x, spriteGetYCenter(), objMM5AimedBullet);
            ID.dir = getAngle + shootAngle;
            ID.xscale = direct;
            ID.sprite_index = sprButterdroidBullet;
            ID = instance_create(x, spriteGetYCenter(), objMM5AimedBullet);
            ID.dir = getAngle - shootAngle / 3;
            ID.xscale = direct;
            ID.sprite_index = sprButterdroidBullet;
            playSFX(sfxEnemyShootClassic);
        }
    }
}
else if (dead)
{
    image_index = 0;
    cooldownTimer = 0;
    speed = 0;
}
