#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// It leaps two times, then jumps high into the air.
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 2;

category = "cluster";

facePlayerOnSpawn = true;

// enemy specific
jumpCount = 0;

xspeed = 0;
yspeed = 0;

imgSpd = 0.4;
imgIndex = 0;
animBack = false;
image_speed = 0;
image_index = 0;
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
    if (ground)
    {
        jumpCount += 1;

        if (jumpCount == 1 || jumpCount == 2)
        {
            yspeed = -3.5;
        }

        if (jumpCount == 3)
        {
            jumpCount = 0;
            yspeed = -7;
            calibrateDirection(); // only faces the player on high jumps
        }
    }

    if (!animBack)
    {
        imgIndex += imgSpd;
        if (imgIndex >= 4)
        {
            animBack = true;
            imgIndex = 2 - imgIndex mod 4;
        }
    }
    else
    {
        imgIndex -= imgSpd;
        if (imgIndex < 0)
        {
            animBack = false;
            imgIndex = 1 - imgIndex; // minus because imgIndex would be negative, and we want to increase the value
        }
    }

    xspeed = 1.6 * image_xscale;
}
else if (dead)
{
    jumpCount = 0;
}

image_index = imgIndex div 1;
