#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;
grav = 0;

isTargetable = false;

contactDamage = 8;

xspeed = 0;
yspeed = 0;
image_speed = 0;
loops = 0;
canHit = true;

// needs to reflect bullets
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
    var maxLoops; maxLoops = 3;
    if (loops == maxLoops && imgIndex >= 7)
    {
        xspeed = image_xscale * 1.75;
    }
    imgIndex += 0.2;

    if (imgIndex >= 9)
    {
        if (loops < maxLoops)
        {
            imgIndex = 5;
            loops += 1;
        }
    }
    if (xspeed != 0 && (imgIndex < 9 || imgIndex >= image_number))
    {
        imgIndex = 9;
    }
    image_index = floor(imgIndex);
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 3;
