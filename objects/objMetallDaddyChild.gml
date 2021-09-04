#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;
stopOnFlash = false;

category = "mets";

facePlayerOnSpawn = false;
respawn = false;

// Enemy specific code
cooldownTimer = 0;

animTimer = 0;

canCollide = 32;

despawnRange = -1;

itemDrop = -1;

blockCollision = false;
parent = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

xs = xspeed;
if (!ground)
{
    xspeed = 0;
}

if (ground && image_index == 0)
{
    image_index = 1;
}

if (entityCanStep())
{
    xspeed = xs;

    canCollide-=1;

    if (canCollide > 0 && checkSolid(x, y))
    {
        canCollide = 32;
    }

    if (canCollide <= 0 && !blockCollision)
    {
        blockCollision = true;
    }

    if (animTimer == 0 && cooldownTimer <= 120 && image_index > 1)
    {
        animTimer = 6;
        if (image_index == 3)
        {
            image_index = 4;
        }
        else if (image_index == 4)
        {
            image_index = 3;
        }
        else
            image_index+=1;
    }
    else
    {
        animTimer -= 1;
    }

    cooldownTimer += 1;

    if (cooldownTimer == 60)
    {
        image_index = 3;
        animTimer = 6;
        xspeed = 1.5 * image_xscale;
    }

    if (blockCollision && checkSolid(xspeed, 0) || x < global.sectionLeft || x > global.sectionRight)
    {
        instance_create(bboxGetXCenter(), bboxGetYCenter(), objExplosion);
        instance_destroy();
    }
}
else if (dead)
{
    cooldownTimer = 0;
    canShoot = true;
    image_index = 0;
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
