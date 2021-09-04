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
image_speed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (xspeed == 0 && yspeed == 0) // If we set it every frame, besides being useless it won't be reflected by jewel satelite
    {
        xspeed = cos(degtorad(dir)) * 3 * xscale;
        yspeed = -sin(degtorad(dir)) * 3; // yspeed needs to be inverted to match the coordinate system
    }
}
