#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Electric enemy, he will stay in place and will throw lightning bolts at the player.
// He uses a cloud to move, since he has no legs.
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "flying, semi bulky";

facePlayer = true;

animEndme = 0;
shootTimer = 0;

//@cc if true will find the nearest lightning lord cloud and attach to it
attachedToCloud = false;

myCloud = instance_nearest(x, y, objMM2CloudPlatform);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (attachedToCloud && instance_exists(myCloud))
{
    xstart = myCloud.x;
    ystart = myCloud.y;
}
event_inherited();

if (entityCanStep())
{
    // stick to clouds
    if (attachedToCloud && instance_exists(myCloud))
    {
        blockCollision = 0;

        x = myCloud.x;
        y = myCloud.y;
    }

    // animation
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

    // throw lightning
    shootTimer += 1;
    if (shootTimer == 150)
    {
        image_index = 2;
        i = instance_create(x, y - 22, objLightningLordLightning);
        i.image_xscale = image_xscale;
        i.xspeed = image_xscale;
    }
    if (shootTimer == 180)
    {
        image_index = 0;
        shootTimer = 0;
    }

    // Don't go back to cloud if frozen
    if (iceTimer)
    {
        attachedToCloud = false;
    }
}
else if (dead)
{
    shootTimer = 0;
    animEndme = 0;
    image_index = 0;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (spawned)
{
    if (attachedToCloud && instance_exists(myCloud))
    {
        var f; f = false;
        with (myCloud)
            f = insideView(x, y);
        if (f)
        {
            dead = true;
        }
    }
}
