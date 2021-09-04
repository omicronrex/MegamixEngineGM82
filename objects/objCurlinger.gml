#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "grounded";

facePlayerOnSpawn = true;

// Enemy specific code
dir = 0;

knocked = false;

maxXSpd = 1.5;
keptXSpd = 0;
acceleration = 0.02;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (xcoll != 0)
    {
        if (!knocked)
        {
            dir *= -1;
            image_xscale *= -1;
            playSFX(sfxCurlingerBounce);
        }
        else
        {
            dead = true;
            visible = 0;
            event_user(EV_DEATH);
            playSFX(sfxEnemyHit);
        }
    }

    if (!knocked)
    {
        keptXSpd = min(keptXSpd + acceleration, maxXSpd);
    }
    else
    {
        keptXSpd = 4.2; // speed when knocked away by slash claw or break dash
    }

    xspeed = keptXSpd * dir;
    image_speed = keptXSpd / 8;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!knocked && global.damage == 0)
{
    knocked = true;

    calibrateDirection();
    image_xscale *= -1;
    dir = image_xscale;

    playSFX(sfxEnemyHit);
    iFrames = 4;
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue(objSlashClaw, 0);
specialDamageValue(objBreakDash, 0);
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (spawned)
{
    dir = image_xscale;
    knocked = false;
    keptXSpd = 0;
    visible = 1;
}
