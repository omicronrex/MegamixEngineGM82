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

parent = noone;
pierces = 0; // Die on contact with the player

// this guy does a bad job of aiming
if (instance_exists(target))
{
    if ((abs(target.y - y)) <= 24)
    {
        yspeed = 0;
    }
    else
    {
        if (target.y < y)
        {
            yspeed = -2;
        }
        else
        {
            yspeed = 2;
        }
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (parent != noone)
{
    with (parent)
    {
        shootTimer = 0;
        image_index = 4;
        assTimer = 0;
    }
}
