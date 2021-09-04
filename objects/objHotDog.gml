#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A big dog that fires a barrage of fire balls in an arc
event_inherited();

respawn = true;
healthpointsStart = 10;
healthpoints = healthpointsStart;
contactDamage = 4;
category = "fire, nature";

// Enemy specific code
shootTimer = 0;
image_speed = 0;
tailWag = 0;
endTimer = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (endTimer == -1)
{
    endTimer = choose(120, 100, 80);
}

if (entityCanStep()
    && introTimer <= 0)
{
    if (shootTimer == 0)
        image_index = 0;
    if (shootTimer == 15 || shootTimer == 15 + 10 || shootTimer == 15 + 10 + 10)
        image_index = 1;
    if (shootTimer == 17 || shootTimer == 17 + 10 || shootTimer == 17 + 10 + 10)
        image_index = 2;
    if (shootTimer == 20 || shootTimer == 20 + 10 || shootTimer == 20 + 10 + 10)
        image_index = 0;

    if (shootTimer == 65)
    {
        image_index = 3;
        endTimer = choose(120, 100, 80);
    }

    if (shootTimer > 65 && shootTimer == floor(shootTimer / 4) * 4)
    {
        fire = instance_create(x + 18 * image_xscale, y, objHotDogFire);
        fire.yspeed = 5;
        fire.xspeed = image_xscale * 4;
        fire.image_index = shootTimer;
    }

    // image_index += 0.1;
    shootTimer += 1;
    if (shootTimer >= endTimer)
        shootTimer = 0;

    tailWag += 1;

    if (tailWag > 45)
    {
        if (tailWag == floor(tailWag / 4) * 4)
        {
            if (sprite_index == sprHotDog)
                sprite_index = sprHotDogTail;
            else
                sprite_index = sprHotDog;
        }
    }
    if (tailWag >= 70)
    {
        sprite_index = sprHotDog;
        tailWag = 0;
    }
}
else if (!insideView())
{
    image_index = 0;

    // shootTimer = 0;
}
