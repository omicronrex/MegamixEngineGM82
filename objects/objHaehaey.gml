#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "flying, nature";

grav = 0;
blockCollision = 0;

facePlayerOnSpawn = true;

// Enemy specific code
actionTimer = 0;
loopTimes = 0;

image_speed = 0.75;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    actionTimer += 1;
    if (actionTimer == 15 || actionTimer == 25 || actionTimer == 35)
    {
        i = instance_create(x, y + 9, objEnemyBullet);
        i.yspeed = 2;
    }
    else if (actionTimer == 100)
    {
        i = instance_create(x, y + 9, objEnemyBullet);
        i.yspeed = 2;
        actionTimer = -30;
    }

    if (insideView())
    {
        if (x < view_xview + 16 && loopTimes == 0)
        {
            loopTimes += 1;
            xspeed = -xspeed * 2;
            image_xscale = -image_xscale;
            x -= 4;
        }
        else if (x > view_xview + view_wview - 16 && loopTimes == 1)
        {
            loopTimes += 1;
            x += 4;
            xspeed = -xspeed / 2;
            image_xscale = -image_xscale;
        }
    }
}
else if (dead)
{
    actionTimer = 0;
    loopTimes = 0;

    xspeed = image_xscale * 2.5;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (spawned)
{
    xspeed = image_xscale * 2.5;
}
