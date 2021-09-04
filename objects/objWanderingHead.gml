#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 6;

facePlayerOnSpawn = true;
grav = 0;
category = "bird";
despawnRange=8;

// @cc - Determines how fast Wandering Head moves
moveSpeed = 2;

animTimer = 4;

xPrev = 0;
yPrev = 0;
xScaleStart = image_xscale;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if(xcoll!=0)
    {
        xspeed = xcoll;
    }
    if(ycoll!=0)
    {
        yspeed = ycoll;
    }
    if(image_index==0)
    {
        if (xcoll != 0)
        {
            image_index = 2;
            xPrev = xcoll;
            yPrev = yspeed;
            xspeed=xcoll;
        }
        if (ycoll != 0)
        {
            image_index = 1;
            xPrev = xspeed;
            yPrev = ycoll;
            yspeed=ycoll;
        }
    }

    if (image_index == 1)
    {
        xspeed = 0;
        yspeed = 0;
        animTimer-=1;
        if (animTimer == 0)
        {
            yspeed = -yPrev;
            xspeed = xPrev;
            if (sign(yPrev)<0)
            {
                image_index = 3;
            }
            else
            {
                image_index = 4;
            }
            animTimer = 4;
        }
    }
    else if (image_index == 2)
    {
        xspeed = 0;
        yspeed = 0;
        animTimer-=1;
        if (animTimer == 0)
        {
            xspeed = -xPrev;
            yspeed = yPrev;
            image_xscale *= -1;
            if (sign(xPrev)<0)
            {
                image_index = 4;
            }
            else
            {
                image_index = 3;
            }
            animTimer = 4;
        }
    }

    if ((image_index == 3) || (image_index == 4))
    {
        animTimer-=1;
        if (animTimer == 0)
        {
            image_index = 0;
            animTimer = 4;
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
if(spawned)
{
    image_xscale = xScaleStart;
    xspeed = moveSpeed * image_xscale;
    yspeed = -moveSpeed;
    xPrev = xspeed;
    yPrev = yspeed;
    image_index = 0;
    animTimer = 4;
    despawnRange=8+abs(moveSpeed);
}
