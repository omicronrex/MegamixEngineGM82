#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
blockCollision = 0;
grav = 0;
stopOnFlash = false;
contactDamage = 5;
reflectable = 0;
cAngle = 0;
cDistance = 32;
addAngle = 4;
addDistance = 1;
despawnRange = 64;
image_speed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (!global.frozen)
{
    if (image_index < image_number - 1)
        image_index += 0.25;
    x = xstart + cos(degtorad(cAngle)) * cDistance;
    y = ystart + sin(degtorad(cAngle)) * cDistance;
    if (image_index >= image_number - 1)
    {
        cAngle += addAngle;
        if (cAngle >= 360)
            cAngle -= 360;
        cDistance += addDistance;
    }
}
