#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

x = random_range(x - 20, x + 20);
y = random_range(y + 20, y - 20);

xspeed = random_range(-0.4, 0.4);
yspeed = 0.8;

imgSpd = 0.2;
imgIndex = 0;
animBack = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.timeStopped)
{
    if (!animBack)
    {
        imgIndex += imgSpd;
        if (imgIndex >= 3)
        {
            imgIndex = 2 - imgIndex mod 3;
            image_xscale = -image_xscale;
            animBack = true;
        }
    }
    else
    {
        imgIndex -= imgSpd;
        if (imgIndex < 0)
        {
            imgIndex = 1;
            animBack = false;
        }
    }

    x += xspeed;
    y += yspeed;
}

image_index = imgIndex div 1;
