#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):

event_inherited();

healthpointsStart = 4;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "shield attackers";

grav = 0;

// Enemy specific code
phase = 1;

dir = image_xscale;

moveSprite = sprite_index;
turnSprite = sprMM4ShieldAttackerTurn;

moveSpeed = 2;
imgSpeed = 1 / 3;
turnSpeed = 0.2;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// set this so xcoll can be used
event_inherited();

if (entityCanStep())
{
    if (phase == 1)
    {
        if (xcoll != 0)
        {
            phase = 2;
            sprite_index = turnSprite;
            image_index = 0;
        }
        else
        {
            xspeed = moveSpeed * image_xscale;
            image_speed = imgSpeed;
        }
    }
    else
    {
        xspeed = 0;
        image_speed = turnSpeed;

        if (image_index >= image_number - 1)
        {
            image_index = 0;
            phase = 1;
            sprite_index = moveSprite;
            image_xscale *= -1;
        }
    }
}
else if (dead)
{
    image_index = 0;
    phase = 1;
    image_xscale = dir;
    sprite_index = moveSprite;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (phase == 1)
{
    if (sign(bboxGetXCenterObject(other.id) - bboxGetXCenter()) == image_xscale)
    {
        other.guardCancel = 1;
    }
}
