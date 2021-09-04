#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

canHit = false;
grav = 0;
bubbleTimer = -1;

isSolid = 1;

//@cc Initial delay
delay = 0;

//@cc How long the zap lasts
zapLength = 60;

//@cc How much it waits between zaps
waitLength = 60;

alarmAttack = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    alarmAttack += 1;
    if (alarmAttack >= (waitLength + zapLength))
    {
        i = instance_create(x + (16 * image_xscale), y, objEnemyBullet);
        i.sprite_index = sprElecThunder;
        i.alarmDie = zapLength;
        i.image_xscale = image_xscale;
        i.imageSpeed = 0.25;
        i.contactDamage = 4;
        i.reflectable = 0;

        if (insideView())
        {
            playSFX(sfxBlockZap);
        }

        alarmAttack = 0;
    }
}
else if (dead)
{
    alarmAttack = -delay;
}
