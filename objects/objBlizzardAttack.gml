#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

stopOnFlash = false;

blockCollision = 0;
grav = 0;

contactDamage = 3;
go = false;
dir = 0;
my_x = view_xview[0] + 128;
my_y = view_yview[0] + 112;
image_speed = 0;
alarm[0] = 5;
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (image_index == 0)
{
    image_index = 1;
    alarm[0] = 5;
}
else if (image_index == 1)
{
    image_index = 2;
    alarm[0] = 21;
}
else if (image_index == 2)
{
    image_index = 2.1;
    dir = point_direction(x, y, my_x, my_y);
    go = true;
    alarm[0] = 3;
}
else if (image_index == 1.1)
{
    image_index = 2.1;
    alarm[0] = 4;
}
else if (image_index == 2.1)
{
    image_index = 1.1;
    alarm[0] = 4;
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    xspeed = cos(degtorad(dir)) * 2 * go;
    yspeed = -sin(degtorad(dir)) * 2
        * go; // The vertical speed was, for some reason, inverted, which is why I used a minus. Don't ask me what actually caused this behaviour
}

if (instance_exists(objMegaman))
{
    my_x = objMegaman.x;
    my_y = objMegaman.y;
}
#define Other_40
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy();
