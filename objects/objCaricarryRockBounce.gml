#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// If you want to make the bullet stop at solids, make "stopAtSolid" true
event_inherited();

contactDamage = 4;
image_speed = 0;

dir = 0;
xspeed = 0;
yspeed = -3;

xscale = 1;

bounces = 0;
bouncesMax = 3;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (global.frozen == false && global.timeStopped == false)
{
    xspeed = image_xscale * 1.5;

    if (xspeed == 0) // Wall collision
    {
        instance_create(spriteGetXCenter(), spriteGetYCenter(),
            objExplosion);
        instance_destroy();
    }

    if (ground == true) // Floor collision
    {
        bounces += 1;
        if (bounces < 3)
        {
            yspeed = -3 / ((bounces + 1) / 2);
        }
        else
        {
            instance_create(spriteGetXCenter(), spriteGetYCenter(),
                objExplosion);
            instance_destroy();
        }
    }
}
