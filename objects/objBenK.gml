#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 12;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "bulky, shielded";

facePlayerOnSpawn = true;

// Enemy specific code
phase = 0;
timer = 0;

imgSpd = 0.4;
imgIndex = 3;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    switch (phase)
    {
        // rotating spear
        case 1:
            imgIndex += imgSpd;
            if (imgIndex >= 6)
            {
                imgIndex = 4 + imgIndex mod 6;
            }

            timer += 1;

            if (timer == 60)
            {
                calibrateDirection(); // only turn a tiny bit before shooting
            }

            if (timer >= 90)
            {
                // <-- time spinning spear here
                phase = 2;
                imgIndex = 6;
                timer = 0;

                spear = instance_create(x + sprite_width * 0.65, y - 5, objBenKSpear);
                spear.image_xscale = image_xscale;
                spear.xspeed *= image_xscale;
            }

            break;

        // shoot spear
        case 2:
            if (imgIndex < 7)
            {
                imgIndex += imgSpd;
            }
            else
            {
                timer += 1;
                if (timer >= 30)
                {
                    phase = 3;
                    timer = 0;
                    imgIndex = 0;
                }
            }

            if (imgIndex >= 8)
            {
                imgIndex = 7;
            }

            break;

        // grab another spear
        case 3:
            if (imgIndex < 2)
            {
                imgIndex += imgSpd / 4;
            }
            else if (imgIndex < 3)
            {
                imgIndex += imgSpd / 2;
            }
            else
            {
                timer += 1;
                if (timer >= 30)
                {
                    phase = 1;
                    timer = 0;
                    imgIndex = 4;
                }
            }

            break;
    }
    image_index = imgIndex div 1;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (image_index == 4 || image_index == 5 && !global.timeStopped)
{
    if (image_xscale == -1)
    {
        if (bboxGetXCenterObject(other.id) < bboxGetXCenter())
        {
            other.guardCancel = 1;
        }
    }
    else
    {
        if (bboxGetXCenterObject(other.id) > bboxGetXCenter())
        {
            other.guardCancel = 1;
        }
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn
event_inherited();
phase = 1;
timer = 0;
xspeed = 0;
yspeed = 0;
imgIndex = 4;
