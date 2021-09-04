#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;
grav = 0;

contactDamage = 2;

getX = 0;
xspeed = 0;
yspeed = -4;
missleDir = 0;
animTimer = 0;
image_speed = 0.1;
delay = 30;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (global.frozen == false && global.timeStopped == false)
{
    if (y < view_yview)
    {
        yspeed = 0;
        sprite_index = sprMobbyMiniMine;
        if (delay > 0)
        {
            visible = false;
            delay -= 1;
        }
        else
        {
            x = getX;
            yspeed = 1;
            visible = true;
        }
    }

    if (y > view_yview + view_hview)
        instance_destroy();
}
