#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

/// A fast quick laser, but without insta death, rotatable in editor
// Note: You just need to place one
blockCollision = 0;
grav = 0;
hacks = false;
preciseMask = mskWily4LaserPrecise;
nonPreciseMask = mskWily4Laser;

despawnRange = -1;
contactDamage = 4;

variation = 0; // cc 1: drain laser
image_speed = 0.25;
mySpeed = 32;

obstacleList[0] = objConcreteShot;
obstacleList[1] = objIceWall;
obstacleList[2] = objPlantBarrier;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var size = image_xscale;
var img = size;
var bit = 0;

while (img > 0)
{
    bit = min(sprite_get_width(sprite_index), img);
    var height = sprite_get_height(sprite_index);
    draw_sprite_general(sprite_index, image_index, 0, 0, bit, height, x + (size - img) * cos(degtorad(image_angle)), y - (size - img) * sin(degtorad(image_angle)), 1, 1, image_angle, c_white, c_white, c_white, c_white, image_alpha);
    img -= bit;
}
