#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "mets";

facePlayer = true;

// Enemy specific code
radius = 4 * 16; // Four blocks; the radius that MM needs to enter to trigger the shooting of the met
cooldownTimer = 0;
canShoot = true;
animTimer = 0;
isDancing = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (instance_exists(target))
    {
        if (distance_to_object(target) <= radius)
        {
            if (canShoot == true)
            {
                canShoot = false;
                if (cooldownTimer >= 0)
                {
                    image_index = 1;
                }
            }
        }
    }

    if (animTimer > 0)
    {
        animTimer -= 1;
    }
    if (animTimer == 12 || animTimer == 8 || animTimer == 4 || animTimer == 1)
    {
        image_index -= 1;
    }

    if (isDancing)
    {
        image_index += 0.25;
        if (image_index < 5)
        {
            image_index = 5;
        }
        if (image_index > 8)
        {
            image_index = 5;
        }
    }

    var shoot = 0;

    if (!canShoot)
    {
        cooldownTimer += 1;
        if (cooldownTimer == 1)
        {
            image_index = 1;
        }
        else if (cooldownTimer == 8)
        {
            image_index = 2;
        }
        else if (cooldownTimer == 12)
        {
            image_index = 3;
        }
        else if (cooldownTimer == 16)
        {
            image_index = 4;
        }
        else if (cooldownTimer == 20)
        {
            isDancing = true;
            shoot = 1;
        }
        else if (cooldownTimer == 60)
        {
            shoot = 1;
        }
        else if (cooldownTimer == 100)
        {
            isDancing = false;
            image_index = 4;
            animTimer = 16;
            shoot = 1;
            //playSFX(sfxEnemyShoot);
        }
        else if (cooldownTimer == 150)
        {
            canShoot = true;
            cooldownTimer = 0;
        }
    }

    if (shoot)
    {
        ID = instance_create(x + image_xscale * 8, spriteGetYCenter(), objEnemyBullet);
        ID.xspeed = 2 * image_xscale;
        //playSFX(sfxEnemyShoot);
    }
}
else if (dead)
{
    animTimer = 0;
    cooldownTimer = 0;
    canShoot = true;
    image_index = 0;
    image_speed = 0;
    isDancing = false;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (image_index == 0)
{
    other.guardCancel = 1;
}
