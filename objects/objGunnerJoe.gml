#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Space: the final frontier. These are the voyages of the starship Gunner Joe.
// Its constant mission: to destroy Mega Man. To use homing missiles and diving attacks.
// To boldly go where no Joe has gone before!

event_inherited();

healthpointsStart = 5;
healthpoints = healthpointsStart;
contactDamage = 4;

grav = 0;
blockCollision = false;
facePlayerOnSpawn = true;

category = "flying, joes";

image_speed = 0.3;

// @cc - how close does Mega Man need to be before Gunner Joe swoops
radius = 64;
// @cc - how fast Gunner Joe moves horizontally
moveSpeed = 1;
// @cc - how fast Gunner Joe moves vetrivally
flySpeed = 1;

moveTimer = 120;
missile = noone;

phase = 0;
goHere = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    moveTimer-=1;
    if (instance_exists(target))
    {
        goHere = target.y;
    }

    switch (phase)
    {
        case 0:
            if (moveTimer == 60)
            {
                if (instance_exists(target))
                {
                    if (!instance_exists(missile))
                    {
                        var i; i = instance_create(x-4, y+10, objGunnerJoeMissile);
                        if (image_index == -1)
                        {
                            i.image_index = 5;
                        }
                        else
                        {
                            i.image_index = 7;
                        }
                        missile = i.id;
                        i.parent = id;
                        i.direction = point_direction(x, y, target.x, target.y);
                        playSFX(sfxMissileLaunch);
                    }
                }
            }
            if (moveTimer <= 60)
            {
                if (instance_exists(target))
                {
                    if (abs(target.x - x) <= radius)
                    {
                        phase = 1;
                        calibrateDirection();
                        xspeed = moveSpeed * image_xscale;
                        yspeed = flySpeed;
                    }
                }
            }
            if (moveTimer == 0)
                moveTimer = 120;
            break;

        case 1:
            // Swoop down
            if (goHere > y)
            {
                if (instance_exists(target))
                {
                    calibrateDirection();
                    if (floor(target.x) == x)
                        xspeed = 0;
                    else
                        xspeed = moveSpeed * image_xscale;
                }
                yspeed = flySpeed;
            }
            else
            {
                phase = 2;
                moveTimer = 15;
                yspeed = -flySpeed;
            }
            break;
        //Rise
        case 2:
            if (instance_exists(target))
            {
                if (floor(target.x) == x)
                    xspeed = 0;
                else
                    xspeed = moveSpeed * image_xscale;
            }

            if (moveTimer == 0)
            {
                calibrateDirection();
                moveTimer = 30;
            }
            if (y <= view_yview + sprite_height)
            {
                moveTimer = 120;
                xspeed = 0;
                yspeed = 0;
                phase = 0;
            }
            break;
    }
}
else if (dead)
{
    image_index = 0;
    healthpoints = healthpointsStart;
    xspeed = 0;
    yspeed = 0;
    phase = 0;
    goHere = 0;
    moveTimer = 120;
}
