#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// This enemy shoots needles at megaman and rolls over the ground
event_inherited();

healthpointsStart = 6;
healthpoints = healthpointsStart;
contactDamage = 6;

category = "grounded, semi bulky";

facePlayerOnSpawn = true;

xs = 0;
animEndme = 0;
shootTimer = 0;
ground = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    xSpeedTurnaround();

    animEndme += 1;
    if (animEndme >= 6)
    {
        if (image_index == 3)
        {
            image_index = 4;
        }
        else if (image_index == 4)
        {
            image_index = 3;
        }
        animEndme = 0;
    }

    if (ground)
    {
        shootTimer += 1;
        if (shootTimer == 60 || shootTimer == 90 || shootTimer == 235)
        {
            image_index = 1;
            a = instance_create(x, y - 16 + 1, objEnemyBullet);
            a.sprite_index = sprHariHariNeedles;
            a.contactDamage = 2;
            a.image_index = 0;
            a.dir = 180;
            a.spd = 2.5;
            a = instance_create(x, y - 16 + 1, objEnemyBullet);
            a.sprite_index = sprHariHariNeedles;
            a.contactDamage = 2;
            a.image_index = 1;
            a.dir = 135;
            a.spd = 2.5;
            a = instance_create(x, y - 16 + 1, objEnemyBullet);
            a.sprite_index = sprHariHariNeedles;
            a.contactDamage = 2;
            a.image_index = 2;
            a.dir = 90;
            a.spd = 2.5;
            a = instance_create(x, y - 16 + 1, objEnemyBullet);
            a.sprite_index = sprHariHariNeedles;
            a.contactDamage = 2;
            a.image_index = 3;
            a.dir = 45;
            a.spd = 2.5;
            a = instance_create(x, y - 16 + 1, objEnemyBullet);
            a.sprite_index = sprHariHariNeedles;
            a.contactDamage = 2;
            a.image_index = 4;
            a.dir = 0;
            a.spd = 2.5;
        }
        if (shootTimer == 65 || shootTimer == 95 || shootTimer == 240)
        {
            image_index = 2;
        }
        if (shootTimer == 110 || shootTimer == 255)
        {
            image_index = 3;
            calibrateDirection();
            xs = 1.5;
        }
        if (shootTimer == 220)
        {
            xs = 0;
            image_index = 0;
        }
        if (shootTimer == 365)
        {
            xs = 0;
            image_index = 0;
            shootTimer = 45;
        }
    }

    if (!ground)
    {
        xspeed = 0;
    }
    else
    {
        xspeed = xs * image_xscale;
    }
}
else if (dead)
{
    xs = 0;
    shootTimer = 0;
    animEndme = 0;
    image_index = 0;
    calibrated = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (image_index == 3 || image_index == 4)
{
    other.guardCancel = 1;
}
