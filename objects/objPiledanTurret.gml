#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
category = "cannons";
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Active phase
var shootEnd = 120;
switch (subPhase)
{
    case 0:
        timer += 1;
        animFrame = 8;
        if (timer > shootEnd)
        {
            timer = 0;
        }
        if (timer == 20 || timer == 60)
        {
            var i = instance_create(x + 12 * image_xscale, y - 17 * image_yscale, objEnemyBullet);
            i.xspeed = image_xscale * 3;
            i.grav = 0;
            playSFX(sfxEnemyShootClassic);
        }
        else if (timer == 40 || timer == 80)
        {
            var i = instance_create(x + 12 * image_xscale, y - 27 * image_yscale, objEnemyBullet);
            i.xspeed = image_xscale * 3;
            i.grav = 0;
            i.blockCollision = 0;
            playSFX(sfxEnemyShootClassic);
        }
        if (timer == 40 || timer == 41 || timer == 80 || timer == 81)
            animFrame = 9;
        else if (timer == 20 || timer == 21 || timer == 60 || timer == 61)
            animFrame = 10;
        break;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// No
