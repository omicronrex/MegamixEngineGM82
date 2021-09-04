#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 9;
healthpoints = healthpointsStart;
contactDamage = 0;
doesIntro = false;
grav = 0;
isSolid = true;
facePlayerOnSpawn = true;
category = "cannons";

shootTimer = choose(60, 120, 180, 240);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    shootTimer--;
    if (shootTimer <= 0)
    {
        i = instance_create(x + 30 * image_xscale, y - 27, objTyhornBall);//35
        i.xspeed = 2 * image_xscale;
        i.yspeed = -2;
        playSFX(sfxCannonShoot);
        shootTimer = choose(60, 120, 180);
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.id == collision_rectangle(x - 1 * image_xscale, y - 47, x + 20 * image_xscale, y - 15, other.id, false, false))
{
    other.guardCancel = 0;
}
else
{
    other.guardCancel = 2;
}
