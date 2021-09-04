#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = 1;
contactDamage = 3;
category = "flying";
grav = 0;
blockCollision = false;
facePlayerOnSpawn = true;

shootTimer = 0;
timer = 0;
animFrame = 0;
imageOffset = 0;
col = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (col > 1)
        col = 1;
    timer += 0.055;
    if (timer > 2 * pi)
    {
        timer = 0;
    }
    xspeed = 1 * image_xscale;
    yspeed = sin(timer) * 1.15;
    if (shootTimer < 60)
        shootTimer += 1;
    if (instance_exists(target) && shootTimer >= 60 && target.y > bbox_top - 8 && target.y < bbox_bottom + 8
        && sign(target.x - x) == sign(image_xscale))
    {
        var i; i = instance_create(x + 8 * image_xscale, y + 4 * image_yscale, objEnemyBullet);
        i.sprite_index = sprShotomBullet;
        i.mask_index = sprShotomBullet;
        i.xspeed = 3 * image_xscale;
        i.dieOnHit = true;
        i.contactDamage = 3;
        i.canHit = true;
        i.healthpoints = 1;
        i.healthpointsStart = 1;
        playSFX(sfxCannonShoot);
        imageOffset = 1;
        shootTimer = 0;
    }
    if (shootTimer > 5)
        imageOffset = 0;
    animFrame += 0.2;
    if (floor(animFrame) > 1)
        animFrame = 0;
    image_index = col * 4 + imageOffset * 2 + floor(animFrame);
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// spawn Event
if (spawned)
{
    shootTimer = 0;
    timer = 0;
    animFrame = 0;
    imageOffset = 0;
}
