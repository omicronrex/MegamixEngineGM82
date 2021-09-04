#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "cannons, flying";

grav = 0;
blockCollision = false;

facePlayer = true;

// Enemy specific code
phase = 0;
shootWait = 50;
shootTimer = 0;

sinCounter = 0;

imgSpd = 0.4;
imgIndex = 0;
image_speed = 0.1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    imgIndex += imgSpd;

    if (shootTimer > shootWait)
    {
        if (imgIndex >= 4)
        {
            imgIndex = 2 + imgIndex mod 4;
        }
    }
    else
    {
        if (imgIndex >= 2)
        {
            imgIndex = imgIndex mod 2;
        }
    }

    shootTimer += 1;
    if (shootTimer == shootWait)
    {
        i = instance_create(x + sprite_width * 0.5, y - 7, objCannopellerBall);
        i.image_xscale = image_xscale;
        i.xspeed = 3 * image_xscale;
        imgIndex = 2;
    }
    else if (shootTimer >= shootWait + 30)
    {
        shootTimer = 0;
        imgIndex = 0;
    }

    sinCounter += 0.03;
    yspeed = -(cos(sinCounter) * 0.7);
}
else if (dead)
{
    phase = 0;
    shootTimer = 0;
    xspeed = 0;
    yspeed = 0;
    sinCounter = 0;
}

image_index = imgIndex div 1;
