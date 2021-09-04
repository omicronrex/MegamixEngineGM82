#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
contactDamage = 3;
blockCollision = false;
grav = 0;
healthpointsStart = 1;
healthpoints = 1;
canHit = true;

timer = 0;
h = 0;
k = 0;
a = 0;
dir = -1;
ix = 0;
xspeed = 0;
yspeed = 0;

homing = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    if (!homing)
    {
        y = a * ((x - h) * (x - h)) + k;
        if (image_index == 0 && y < k - 60)
        {
            homing = true;
            xspeed = 0;
            yspeed = 0;
        }
    }
    else
    {
        if (timer != -1 && timer < 20)
            timer += 1;
        else if (timer >= 20)
        {
            aimAtTarget(3);
            timer = -1;
        }
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
a = y - k;
var den; den = (x - h) * (x - h);
a = a / den;
xspeed = dir * abs(x - ix) / 60;
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
instance_create(x, y, objExplosion);
playSFX(sfxEnemyHit);
