#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Moving platforms that move in circles, usually used alongside [objLightningLord](objLightningLord.html)
event_inherited();
canHit = false;

isSolid = 2;

grav = 0;
blockCollision = 0;
bubbleTimer = -1;

image_speed = 0.2;

dir = image_xscale;

respawnRange = -1;
despawnRange = -1;

xs = x;

sprite_index = sprMM2CloudPlatform;

//creation code
sinc = 0; //@cc default sinCounter setting


sinCounter = sinc;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    sinCounter += .00875;
    xspeed = -(sin(sinCounter) * .475) * dir;
    yspeed = -(cos(sinCounter) * .475);

    image_xscale = sign(xspeed) + (sign(xspeed) == 0);
}
else if (dead)
{
    sinCounter = sinc;
}
