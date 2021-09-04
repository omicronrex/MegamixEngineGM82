#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

canHit = false;
grav = 0;
blockCollision = 0;
bubbleTimer = -1;

isSolid = 2;
respawn = false;
alarmTurn = 16;
xspeed = 0;
ysp = 1;
dir = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (!global.frozen && !dead && !global.timeStopped)
{
    yspeed = ysp;
    alarmTurn -= 1;
    if (alarmTurn <= 0)
    {
        alarmTurn = 16;
        dir *= -1;
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index, image_index, floor(x), floor(y), 1, image_yscale, image_angle, image_blend, image_alpha);
