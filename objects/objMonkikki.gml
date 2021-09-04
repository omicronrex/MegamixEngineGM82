#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 4;
contactDamage = 4;

categories = "nature, primate";

jumpHeight = 48;

attackTimer = 60 * 3;

image_speed = 0;

landTimer = 0;
throwTimer = 0;
breatheTimer = 0;

grav = 0.2;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    var jumping; jumping = false;
    if (ground)
    {
        landTimer-=1;
    }
    throwTimer-=1;
    attackTimer-=1;
    breatheTimer+=1;
    if (ground && throwTimer > 0)
    {
        jumping = false;
    }
    if (instance_exists(target) && landTimer <= 0)
    {
        if (abs(x - target.x) <= 80)
        {
            jumping = true;
        }
    }

    if (!ground)
    {
        jumping = true;
    }

    if (jumping)
    {
        breatheTimer = 0;
        image_index = 4;
        landTimer = 3;
        if (throwTimer > 0)
        {
            image_index = 5;
        }
        if (ground)
        {
            yspeed = -sqrt(abs(2 * grav * 48));
        }
    }
    else
    {
        image_index = (breatheTimer div 8) mod 2;
        if (attackTimer < 15)
        {
            image_index = 2;
        }
        if (throwTimer > 0)
        {
            image_index = 3;
        }
    }

    if (attackTimer mod 15 == 3)
        calibrateDirection();

    // throw banana
    if (attackTimer < 0)
    {
        attackTimer = 60 * 2;
        throwTimer = 16;
        with (instance_create(x + 18 * image_xscale, y + 4, objEnemyBullet))
        {
            image_xscale = other.image_xscale;
            contactDamage = 2;
            canHit = true;
            sprite_index = sprBanana;
            target = other.target;
            if (instance_exists(other.target))
            {
                aimAtTarget(2.5);
            }
            else
            {
                xspeed = 1.8 * other.image_xscale;
                yspeed = 1.2;
            }
        }
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

attackTimer = 60 * 2;
throwTimer = 0;
landTimer = 0;
breatheTimer = 0;
