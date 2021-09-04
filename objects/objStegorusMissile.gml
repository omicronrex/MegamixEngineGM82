#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;
healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;
blockCollision = 0;
canHit = true;
grav = 0;
despawnRange = 0;

// Enemy specific code
timer = 0;
newAngle = 0;
deathTimer = 60 * 5;
angle = 0;
spd = 1.35;
col = 0;
animFrame = 0;
canAim = false;
parent = noone;
timescale = 1;
canTurn = true;
aimTimer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (!canAim)
    {
        aimTimer += 1 * timescale;
        if (aimTimer >= 30)
            canAim = true;
    }
    if (instance_exists(target) && canAim) // Aiming
    {
        newAngle = point_direction(x, y, target.x, target.y);
        newAngle = wrapAngle(round(newAngle / 45) * 45);
    }
    timer += 1 * timescale;
    if (timer > 20 && canTurn)
    {
        timer = 0;
        if (angle != newAngle)
        {
            var rotDir; rotDir = 1;
            var pdist; pdist = 0;
            var delta; delta = 360 - angle;
            var nangl; nangl = (newAngle + delta) mod 360;
            if (nangl >= 180)
                rotDir = -1;
            angle = wrapAngle(angle + 45 * rotDir);
        }
    }
    xspeed = cos(degtorad(angle)) * spd * timescale;
    yspeed = -sin(degtorad(angle)) * spd * timescale;
    animFrame += 0.25 * timescale;
    if (floor(animFrame) > 1)
        animFrame = 0;
    image_index = col * 16 + floor(animFrame) * 8 + round(angle / 45);

    // Timeout
    deathTimer -= 1 * timescale;
    if (deathTimer <= 0)
        canTurn = false;
    var hasParent; hasParent = instance_exists(parent);
    if (!hasParent || (hasParent && parent.dead))
        event_user(EV_DEATH);
}
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
event_user(EV_DEATH);
#define Other_19
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
event_user(EV_DEATH);
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
stopSFX(sfxEnemyHit);
instance_create(x, y, objExplosion);
