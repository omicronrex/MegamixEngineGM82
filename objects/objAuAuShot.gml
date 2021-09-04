#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = false;
contactDamage = 2;
grav = 0;
xspeed = 0;
yspeed = 0;

// specific code
shootTimer = 0;
shotCharge = 0;
parent = noone;

image_speed = 0;
image_index = 0;
imgIndex = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (instance_exists(parent))
{
    if (parent.iceTimer > 0 && iceTimer == 0)
    {
        entityIceFreeze(parent.iceTimer, false, false, true);
    }
}
event_inherited();

if (entityCanStep())
{
    // wait to shoot
    if (shotCharge < 3)
    {
        shootTimer += 1;

        if (shootTimer mod 3 == 0)
        {
            visible = !visible;
        }

        if (shootTimer >= 25) // <-- time between charge increases here
        {
            shotCharge += 1;
            shootTimer = 0;

            if (shotCharge < 3)
            {
                image_index = shotCharge;
            }
            else
            {
                visible = true;
            }
        }
    }

    // Shoot
    if (shotCharge == 3)
    {
        speed = 4; // <-- speed here

        if (instance_exists(target))
        {
            direction = point_direction(x, y, target.x, target.y);
        }

        directionMax = 25; // <-- projectile angle limits here
        if (image_xscale > 0)
        {
            if (direction > directionMax && direction <= 180)
            {
                direction = directionMax;
            }
            if (direction < 360 - directionMax && direction > 180)
            {
                direction = 360 - directionMax;
            }
        }
        else
        {
            if (direction > 180 + directionMax && direction < 360)
            {
                direction = 180 + directionMax;
            }
            if (direction < 180 - directionMax && directionMax >= 0)
            {
                direction = 180 - directionMax;
            }
        }

        playSFX(sfxEnemyShoot);

        shotCharge = 4;
    }
}
