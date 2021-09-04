#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 6;
blockCollision = true;
grav = 0;

// Enemy specific code
image_speed = 0.25;
imgSpd = 0.25;
calibrated = 0;
dir = 0;
_dir = dir;
sp = 1;
db = 0;

// Variables for snapToGround
_velX = 0;
_velY = 0;
_prevCollision = true;
_groundDir = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (imgSpd == -1)
    imgSpd = image_speed;
event_inherited();

if (entityCanStep())
{
    if (!calibrated)
    {
        x = xstart;
        y = ystart;
        xspeed = 0;
        yspeed = 0;
        calibrated = 1;
        _dir = dir;
        _velX = 0;
        _velY = 0;
        _prevCollision = true;
        _groundDir = -1;
        snapToGround(sp); // let the script push the object out of the ground(
    }

    image_speed = imgSpd;

    if (!snapToGround(sp))
    {
        event_user(EV_DEATH); // die if something goes wrong
    }
}
else
{
    image_speed = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// only tolerate objects that actually hit it
event_inherited();
global.damage = 0;
specialDamageValue(objBreakDash, 4);
specialDamageValue(objSakugarne, 4);
specialDamageValue(objBlackHoleBomb, 4);
isTargetable = false;
if (global.damage == 0)
{
    other.guardCancel = 3;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn/despawn
event_inherited();
if (dir == 0)
{
    dir = choose(-1, 1);
    _dir = dir;
}
if (spawned)
{
    calibrated = 0;
    image_index = 0;
}
