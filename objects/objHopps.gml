#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "nature";

facePlayer = false;
facePlayerOnSpawn = true;

image_speed = 0;

// Enemy specific code
liftOff = false;
xSOffset = 0;
radius = 96;
cooldownTimer = 0;
cooldownTimerMax1 = 56;
cooldownTimerMax2 = 24;
imageTimer = 0;
imageTimerMax = 5;
activated = false;
delay = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if(xcoll!=0)
{
    xspeed=xcoll;
}
if (entityCanStep())
{
    cooldownTimer += 1;

    // basic AI, if Mega Man is within range, activate Hopps.
    if (instance_exists(target))
    {
        if ((abs(target.x - x) <= radius && target.x < x && image_xscale == -1
            and image_index == 0 && !liftOff && !activated)
            or (abs(target.x - x) <= radius && target.x >= x && image_xscale == 1
            and image_index == 0 && !liftOff && !activated))
        {
            activated = true;
            image_index = 1;
            imageTimer = 0;
        }
    }
    if (imageTimer >= imageTimerMax && image_index == 1)
    {
        image_index += 1;
        imageTimer = 0;
    }
    if (activated && ground && imageTimer == imageTimerMax && image_index == 2)
    {
        delay = 5;
        imageTimer = 0;
        liftOff = true;
        image_index = 3;
        xspeed = 2 * image_xscale;
        yspeed = -5;
        activated = false;
        cooldownTimer = 0;
    }
    if (!ground)
        image_index = 3;
    if (ground && !liftOff && !activated)
        image_index = 0;
    if (delay > 0)
        delay -= 1;
    if (ground && delay == 0)
    {
        xspeed = 0;
        imageTimer += 1;
    }
    if (ground && liftOff && imageTimer < imageTimerMax)
        image_index = 1;
    if (ground && liftOff && imageTimer == imageTimerMax)
    {
        image_index = 0;
        imageTimer = 0;
        image_xscale = image_xscale * -1;
        liftOff = false;
    }
    if ((ground && cooldownTimer >= cooldownTimerMax1)
        || (!ground && cooldownTimer >= cooldownTimerMax2))
    {
        // If megaman exists, grab his angle, otherwise grab some random different angle.
        cooldownTimer = 0;
        if (instance_exists(target) && !ground)
            getAngle = point_direction(spriteGetXCenter(),
                spriteGetYCenter(), target.x, target.y);
        else if (image_xscale == 1)
            getAngle = 0;
        else if (image_xscale == -1)
            getAngle = 180;
        ID = instance_create(spriteGetXCenter() + image_xscale * 4,
            spriteGetYCenter() + 3, objMM5AimedBullet);
        {
            ID.dir = getAngle;
            ID.xscale = image_xscale;
            ID.moveAtSpeed = 2;
        }
        playSFX(sfxEnemyShootClassic);
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
image_index = 0;
imageTimer = 0;
liftOff = false;
cooldownTimer = 0;
imageTimer = 0;
activated = false;
delay = 0;
