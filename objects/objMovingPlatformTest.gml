#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 0;

isSolid = 1;
blockCollision = 0;
grav = 0;
bubbleTimer = -1;

respawn = true;

mySpeed = 0.75;

type = 1;

ymem = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

xspeed = (keyboard_check(ord('D')) - keyboard_check(ord('A'))) * mySpeed;

if (type == 1)
{
    yspeed = (keyboard_check(ord('S')) - keyboard_check(ord('W'))) * mySpeed;
}
else
{
    if (checkSolid(0, 0))
    {
        if (yspeed > 0)
        {
            yspeed = -mySpeed;
        }
    }
}

mySpeed += (keyboard_check(ord('E')) - keyboard_check(ord('Q'))) * 0.05;

// if !instance_exists(objMegaman) {exit;}

// show_debug_message(string(y)+","+string(mySpeed)+","+string(place_meeting(x,y,objSolid))+","+string(objMegaman.y));
