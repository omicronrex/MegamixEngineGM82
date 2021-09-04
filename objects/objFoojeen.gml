#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 7;

category = "grounded, rocky";

facePlayerOnSpawn = true;

shootTimer = 0;

image_speed = 0.5;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // turn around on hitting a wall
    image_speed = 0.5;
    xSpeedTurnaround();
    if (xspeed == 0)
    {
        xspeed = 0.65 * image_xscale;
    }
    if (!ground)
    {
        xspeed = 0;
    }

    shootTimer += 1;
    if (shootTimer >= 90)
    {
        shootTimer = 0;
        for (i = 0; i < 3; i += 1)
        {
            a = instance_create(x + 4 * image_xscale, y - 32,
                objEnemyBullet);
            a.sprite_index = sprFoojeenTrash;
            a.image_index = 0;
            a.contactDamage = 3;
            a.dir = (i + 1) * 45;
            a.spd = 2.5;
        }
    }
    if (xspeed != 0)
        image_xscale = sign(xspeed);
}
else
{
    image_speed = 0;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn
event_inherited();
if (spawned)
{
    shootTimer = 0;
    image_index = 0;
}
