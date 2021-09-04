#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// An enemy originating from Ice Man's stage. Will quickly dash towards the player and occasionally shoot,
// and once shot, depending on where it is shot, different things will happen. If it is shot in the head, it will
// just die, but if it is shot in the body, the had will break off and chase Mega Man.

event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "grounded, cluster";

facePlayerOnSpawn = true;

// Enemy specific code
image_speed = 0.15;
split = 0;

timer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    image_speed = 0.15;
    timer += 1;
    if (timer >= 75)
    {
        playSFX(sfxEnemyShootClassic);
        i = instance_create(x, y - (sprite_height / 2), objEnemyBullet);
        i.sprite_index = sprCrazyRazyBullet;
        i.xspeed = 2.5 * image_xscale;
        timer = 0;
    }

    if (instance_exists(target))
    {
        if (abs(x - target.x) <= 2)
        {
            if (place_meeting(x, y, target))
            {
                split = 1;
                event_user(EV_DEATH);
            }
        }
    }

    xSpeedTurnaround();
    xspeed = 1.5 * image_xscale;
}
else
{
    image_speed = 0;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// "split" is set in user defined 11.
if (split && contactDamage > 0)
{
    playSFX(sfxClassicExplosion);
    i = instance_create(x, y, objCrazyRazySplit);
    i.respawn = false;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
split = 0;

// if the slot is low enough, set that it'll split.
if (bboxGetYCenterObject(other.id) >= bboxGetYCenter() && other.object_index != objBlackHoleBomb && other.object_index != objTornadoBlow && other.object_index != objSlashClaw)
{
    if (healthpoints - global.damage <= 0)
    {
        split = 1;
    }
}
else
{
    global.damage = healthpoints; // otherwise, instantly kill.
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

/// On spawn
timer = 0;
split = 0;
