#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// creation code
// allButtons = true; // if set to true, the melody response cannon will use every button in a random order.
// buttonsToPress = <number> ; // how many buttons the player has to press. if the previous variable is set to true, then this variable is ignored!
event_inherited();
respawn = true;
doesIntro = false;
healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 6;
blockCollision = 0;
grav = 0;
isTargetable = false;
facePlayerOnSpawn = false;

despawnRange = -1;

// Enemy specific code
image_speed = 0;
image_index = 0;
phase = 0;
attackTimer = 0;

allButtons = false;
buttonsToPress = 5;

// if this enemy is placed without buttons, it simply shoots
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    if (attackTimer > 0 || !instance_exists(objMelodyResponseButtonUp))
    {
        attackTimer--;
    }



    switch (attackTimer)
    {
        case -100:
            attackTimer = 64;
            break;
        case 0:
        case 64:
        case 40:
        case 24:
        case 8:
            image_index = 0;
            break;
        case 63:
            image_index = 1;
            break;
        case 56:
            image_index = 2;
            break;
        case 48:
            image_index = 1;
            break;
        case 32:
            playSFX(sfxEnemyShootClassic);
            image_index = 3;
            var inst = instance_create(x - 18, y - 8 * image_yscale, objMelodyResponseBullet);
            inst.xspeed = -6;
            inst.yspeed = 0;
            inst = instance_create(x - 14, y + 8 * image_yscale, objMelodyResponseBullet);
            inst.xspeed = -3;
            inst.yspeed = 3 * image_yscale;
            inst = instance_create(x, y + 16 * image_yscale, objMelodyResponseBullet);
            inst.xspeed = 0;
            inst.yspeed = 6 * image_yscale;
            inst = instance_create(x + 18, y - 8 * image_yscale, objMelodyResponseBullet);
            inst.xspeed = 6;
            inst.yspeed = 0;
            inst = instance_create(x + 14, y + 8 * image_yscale, objMelodyResponseBullet);
            inst.xspeed = 3;
            inst.yspeed = 3 * image_yscale;
            break;
        case 16:
            playSFX(sfxEnemyShootClassic);
            image_index = 4;
            var inst = instance_create(x - 16, y - 3 * image_yscale, objMelodyResponseBullet);
            inst.xspeed = -4;
            inst.yspeed = 2 * image_yscale;
            inst = instance_create(x - 10, y + 13 * image_yscale, objMelodyResponseBullet);
            inst.xspeed = -2;
            inst.yspeed = 4 * image_yscale;
            inst = instance_create(x + 16, y - 3 * image_yscale, objMelodyResponseBullet);
            inst.xspeed = 4;
            inst.yspeed = 2 * image_yscale;
            inst = instance_create(x + 10, y + 13 * image_yscale, objMelodyResponseBullet);
            inst.xspeed = 2;
            inst.yspeed = 4 * image_yscale;
            break;
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (instance_number(object_index) == 1)
{
    with (objMelodyResponseDoor)
    {
        animTimer = 1;
        playSFX(sfxMenuSelect);
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 3;
