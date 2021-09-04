#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
healthpointsStart = 1;
contactDamage = 2;
facePlayerOnSpawn = false;
blockCollision = false;

// Enemy specific code
animOffset = 0;
animFrame = 0;
col = 0;
timer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    var ang = point_direction(x, y, x - 5 * image_xscale, y - 8 * image_yscale);
    yspeed = -1.5;
    xspeed = -1.5 * image_xscale;
    animFrame += 0.2;
    if (floor(animFrame) > 1)
        animFrame = 0;
    if (floor(animOffset) < 1)
        animOffset += 0.1;

    timer += 1;
    if (timer > 30)
    {
        timer = 0;
        var i = instance_create(x + 5 * image_xscale, y + 8 * image_yscale, objEnemyBullet);
        playSFX(sfxEnemyShootClassic);
        var angle = point_direction(x, y, x + 5 * image_xscale, y + 8 * image_yscale);
        if (instance_exists(target) && sign(target.x - (x + 5 * image_xscale)) == image_xscale && sign(target.y - (y + 8 * image_yscale)) == image_yscale)
        {
            angle = point_direction(i.x, i.y, target.x, target.y);
        }
        i.dir = angle;
        i.spd = 3;
    }

    image_index = floor(animFrame) + floor(animOffset) * 2 + col * 4;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
animOffset = 0;
animFrame = 0;
timer = 0;
