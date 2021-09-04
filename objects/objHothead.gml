#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// This enemy will take changkeys from his head and throws them at the player
event_inherited();

healthpointsStart = 10;
healthpoints = healthpointsStart;
contactDamage = 8;

category = "fire, semi bulky";

facePlayer = true;

animEndme = 0;
shootTimer = 0;
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

    if (animEndme >= 8)
    {
        if (image_index == 0)
        {
            image_index = 1;
        }
        else if (image_index == 1)
        {
            image_index = 0;
        }
        animEndme = 0;
    }

    shootTimer += 1;
    if (shootTimer == 102)
    {
        image_index = 2;
    }
    if (shootTimer == 106)
    {
        image_index = 3;
        a = instance_create(x, y - 22, objPicket);
        a.image_xscale = image_xscale;
        a.sprite_index = sprTackleFire;
        a.contactDamage = 3;
        a.yspeed = -4;
        a.target = target;
        with (a)
        {
            if (instance_exists(target))
                xspeed = xSpeedAim(x, y, target.x, target.y,yspeed,grav);
        }
    }
    if (shootTimer == 120)
    {
        image_index = 0;
        shootTimer = 50;
    }
}
else if (dead)
{
    shootTimer = 0;
    animEndme = 0;
    image_index = 0;
}
