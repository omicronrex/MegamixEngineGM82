#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;

image_speed = 0;
image_index = 0;

blockCollision = false;
grav = 0;

itemDrop = noone;

contactDamage = 3;

attached = noone;
respawn = false;
despawnRange = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if ((ycoll > 0 || ground) && blockCollision)
    {
        instance_create(x, y, objExplosion);
        playSFX(sfxEnemyShootClassic);
        var xspd, yspd;
        xspd[0] = -2.5;
        yspd[0] = 0;
        xspd[1] = 2.5;
        yspd[1] = 0;
        xspd[2] = 0;
        yspd[2] = 2.5;
        xspd[3] = 0;
        yspd[3] = -2.5;
        for (var i = 2 * (global.difficulty == DIFF_EASY); i < 4; i++)
        {
            with (instance_create(x, y - 4, objEnemyBullet))
            {
                xspeed = xspd[i];
                yspeed = yspd[i];
            }
        }
        instance_destroy();
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

with (attached)
{
    komaeSize = 0;
    waitTimer = 0;
    myKomae = noone;
    phase = 0;
}
