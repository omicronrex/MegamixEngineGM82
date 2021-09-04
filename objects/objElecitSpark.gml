#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

canHit = false;
contactDamage = 6;

image_speed = 0.1;
spot = 2;
moveTimer = 120;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (spot != 1)
    {
        spot-=1;
        x -= 19;
    }
    else
    {
        spot = 3;
        x = x + 38;
    }

    moveTimer-=1;
    if (moveTimer == 0)
    {
        instance_destroy();
    }
}
else if (dead)
{
    instance_destroy();
}
