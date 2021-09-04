#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 2;

calibrateDirection();

// specific code
phase = 0;
burnTimer = 0;
ground = false;
parent = noone;

imgSpd = 0.2;
imgIndex = 0;

xspeed = 0;
yspeed = 0;

image_speed = 0;
image_index = 0;

reflectable = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (global.frozen == false && global.timeStopped == false)
{
    switch (phase)
    {
        // fall
        case 0:
            imgIndex += imgSpd;
            if (imgIndex >= 2)
            {
                imgIndex = imgIndex mod 2;
            }
            if (ground)
            {
                phase = 1;
                imgIndex = 2;
            }
            break;

        // burning on the ground
        case 1:
            imgIndex += imgSpd;
            if (burnTimer < 35)
            {
                // this makes the animation loop early, preventing the other if statement that deletes this
                burnTimer += 1;
                if (imgIndex >= 6)
                {
                    imgIndex = 3 + imgIndex mod 6;
                }
            }
            if (imgIndex >= 8)
            {
                instance_destroy();
            }
            break;
    }
}

image_index = imgIndex div 1;
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (instance_exists(parent))
    parent.moveV = true;
