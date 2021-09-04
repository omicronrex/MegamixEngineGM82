#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;

contactDamage = 4;
image_speed = 0;
image_index = 0;

alarmDie = -2;
alarmHitSolid = 16;
xspeed = 0;
yspeed = 0;
reflectable = 0;

playSFX(sfxEnemyDrop);

parent = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.timeStopped)
{
    alarmHitSolid-=1;

    if (alarmDie >= 0)
    {
        alarmDie -= 1;
        if (alarmDie == 0)
        {
            instance_destroy();
        }
    }
    if (!place_meeting(x, y, objSolid) && !blockCollision && image_index == 0 && alarmHitSolid <= 0)
    {
        blockCollision = true;
    }

    if (ground || image_index > 0)
    {
        grav = 0;
        yspeed = 0;
        blockCollision = false;
        image_index += 0.05;
    }

    if (image_index >= 3)
    {
        instance_destroy();
    }
}
