#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

xspeed = 0;
yspeed = -2;

imgSpd = 0.3;
imgIndex = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.timeStopped)
{
    imgIndex += imgSpd;
    if (imgIndex >= 4)
    {
        instance_destroy();
    }

    x += xspeed;
    y += yspeed;
}

image_index = imgIndex div 1;
