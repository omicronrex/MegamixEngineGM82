#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):

event_inherited();

healthpointsStart = 16;
healthpoints = healthpointsStart;
contactDamage = 4; // Bombs
facePlayerOnSpawn = false;
category = "bulky, nature";

doesIntro = false;

grav = 0;
blockCollision = 0;
despawnRange = -1;
spawnRange = -1;

// Enemy specific code
shootTimer = 0;
parent = noone;
dir = 1;
getX = x;
getY = y;

image_xscale = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (instance_exists(parent))
{
    if (healthpoints > parent.healthpoints)
        healthpoints = parent.healthpoints;
    else
        parent.healthpoints = healthpoints;
}
if (entityCanStep())
{
    if (instance_exists(parent))
    {
        shootTimer = parent.shootTimer;
    }
    else
        shootTimer += 1;

    if (shootTimer == 50 || shootTimer == 160 + 50)
        image_index = 1;
    if (shootTimer == 60 || shootTimer == 160 + 60)
        image_index = 2;
    if (shootTimer == 160 + 89)
        image_index = 0;


    if (shootTimer == 90)
    {
        getX = x;
        getY = y;

        // image_index = 0;
        spd = 4;

        // setTargetStep();
        if (instance_exists(target))
        {
            var angle;
            angle = floor(point_direction(spriteGetXCenter(),
                spriteGetYCenter(), spriteGetXCenterObject(target),
                spriteGetYCenterObject(target)) / 45) * 45;

            xspeed = cos(degtorad(angle)) * spd;
            yspeed = -sin(degtorad(angle)) * spd;
            x += xspeed;
            y += yspeed;
        }
        else
        {
            xspeed = spd;
            yspeed = 0;
        }
    }
    if (shootTimer == 95 && dir != 0)
    {
        shootTimer = 91;
        if (instance_exists(parent))
            parent.shootTimer = 91;
    }

    if (x < view_xview + 16 || x > view_xview + view_wview - 16
        || y < view_yview + 16 || y > view_yview + view_hview - 16)
    {
        if (shootTimer <= 95)
            dir = 0;
    }

    if (dir == 0 && shootTimer == 110)
        dir = -1;

    // dir. hacky as FART
    x -= xspeed;
    y -= yspeed;

    x += xspeed * dir;
    y += yspeed * dir;

    if (shootTimer != 90 && dir == -1 && sign(getX - x) == sign(xspeed) && sign(getY - y) == sign(yspeed))
    {
        image_index = 0;
        xspeed = 0;
        yspeed = 0;
        x = getX;
        y = getY;
        dir = 1;
    }
}
else if (!insideView())
{
    if (instance_exists(parent))
    {
        image_xscale = parent.image_xscale;
    }
    image_index = 0;
    shootTimer = 0;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (parent != noone)
{
    with (parent)
    {
        healthpoints = 0;
        dead = true;
        event_user(EV_DEATH);
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (floor(image_index) != 2)
{
    other.guardCancel = 1;
}
