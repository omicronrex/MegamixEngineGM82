#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A colectable item that opens key barriers
event_inherited();

grabable = 0;

sinx = 0;

grav = 0;
blockCollision = 0;

homingTimer = 0;
isHoming = false;
respawnupondeath = true;

animTimer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    sinx += 0.1;
    if (homingTimer > 0)
    {
        homingTimer -= 1;
    }

    if (homingTimer > 60)
    {
        yspeed += 0.25;
    }
    else
    {
        if (!isHoming)
        {
            yspeed = -(cos(sinx) * 0.3);
        }
    }

    if (homingTimer == 40)
    {
        isHoming = true;
        yspeed = -5;
    }

    if (isHoming && instance_exists(collectPlayer))
    {
        if (yspeed < 0)
        {
            yspeed += 0.25;
        }
        mp_linear_step(collectPlayer.x, collectPlayer.y, 4.5, false);
    }

    animTimer += 1;
    switch (animTimer)
    {
        case 32:
        case 88:
            image_index = 1;
            break;
        case 40:
        case 96:
            image_index = 0;
            break;
        case 144:
            image_index = 2;
            break;
        case 150:
            image_index = 3;
            break;
        case 156:
            image_index = 4;
            break;
        case 162:
            image_index = 0;
            animTimer = 0;
            break;
    }
}
#define Collision_objMegaman
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyNumber < 7)
{
    instance_destroy();
    instance_create(bboxGetXCenter(), bboxGetYCenter(), objExplosion);
    global.keyNumber += 1;
    playSFX(sfxKeyGet);
}
