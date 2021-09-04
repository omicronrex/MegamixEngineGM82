#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

setTargetStep();

blockCollision = 0;
grav = 0;
canHit = false;
contactDamage = 2;
imageSpeed = -1;
dir = -10000;
spd = 0;

explodeOnContact = 0;
dieOnHit = false;
explosionSFX = sfxMM9Explosion;
alarmDie = -2;

xspeed = 0;
yspeed = 0;

script = scrNoEffect;
code = "";
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (imageSpeed != -1)
        image_speed = imageSpeed;
    if (explodeOnContact)
    {
        x += xcoll;
        y += ycoll;
        if (checkSolid(0, 0))
        {
            if (!respawn)
                instance_destroy();
            else
                dead = true;
            var i = instance_create(x, y, objHarmfulExplosion);
            i.contactDamage = contactDamage;
            playSFX(explosionSFX);
        }
        x -= xcoll;
        y -= ycoll;
    }
    if (alarmDie >= 0)
    {
        alarmDie -= 1;
        if (alarmDie == 0)
        {
            instance_destroy();
        }
    }
    script_execute(script);
    if (code != "")
    {
        stringExecutePartial(code);
    }
    if (dir != -10000 && (xspeed == 0 && yspeed == 0))
    {
        xspeed = cos(degtorad(dir)) * spd;
        yspeed = -sin(degtorad(dir)) * spd;
    }
}
else
{
    if (imageSpeed != -1)
        image_speed = 0;
}
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (explodeOnContact)
{
    if (!respawn)
        instance_destroy();
    else
        dead = true;
    instance_create(x, y, objHarmfulExplosion);
    playSFX(sfxExplosion);
    stopSFX(sfxEnemyHit);
}
else if (dieOnHit)
{
    canHit = true;
    event_user(EV_DEATH);
    stopSFX(sfxEnemyHit);
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (canHit)
{
    instance_create(x, y, objExplosion);
    playSFX(sfxEnemyHit);
}
