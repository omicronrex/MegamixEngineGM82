#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;

calibrateDirection();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

isSolid = 1;

// specific code
wasHit = false;
animate = true;

imgSpd = 0.05;
image_speed = imgSpd;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (animate)
    {
        image_speed = imgSpd;
    }
    else
    {
        image_speed = 0;
        image_index = 1;
    }
}

wasHit = false;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 1;
wasHit = true;
