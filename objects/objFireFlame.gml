#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 4;
canHit = true;
stopOnFlash = false;
xspeed = 0;
despawnTimer = 150;
grav = 0;
blockCollision = 0;

image_speed = 0.2;
reflectable = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    despawnTimer -= 1;

    if (!instance_exists(objFireMan) || despawnTimer <= 1 || checkSolid(image_xscale, 0, 0, 1))
    {
        instance_destroy();
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if ((other.object_index == objIceWall) || (other.object_index == objWaterShield)
    || (other.object_index == objJewelSatellite))
{
    instance_create(sprite_width / 2, sprite_height / 2, objExplosion);
    event_user(EV_DEATH);
}
else
{
    other.guardCancel = 2;
}
