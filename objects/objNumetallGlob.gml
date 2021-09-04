#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
healthpointsStart = 1;
healthpoints = 1;
canDamage = 0;
canHit = true;
grav = 0;
blockCollision = false;
canIce = false;
stopOnFlash = false;
respawn = true;
noFlicker = true;
shiftVisible = 1;

// Enemy specific code
phase = 0;
animFrame = 0;
capture = noone;
timer = 0;
angle = 0;
spd = 2;
lifeTime = 60 * 5;
ox = 0;
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Remove ice physics
var globCount = 0;
with (objNumetallGlob)
{
    if (id != other.id && capture == other.capture)
        globCount += 1;
}
if (globCount == 0 && instance_exists(capture))
{
    if (instance_exists(capture.statusObject))
    {
        capture.statusObject.statusOnIce = false;
    }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dead = false;
event_inherited();
if (healthpoints == 0 || dead || (phase == 0 && global.switchingSections))
{
    instance_destroy();
    exit;
}
xspeed = spd * image_xscale * abs(cos(degtorad(angle)));
yspeed = -spd * sin(degtorad(angle));
if (!global.frozen || (global.switchingSections && phase == 1))
{
    animFrame += 0.1;
    if (floor(animFrame) > 1)
    {
        animFrame = 0;
    }

    if (phase == 0 && !global.switchingSections) // Bullet behaviour
    {
        var i = instance_place(x, y, objMegaman);
        if (i != noone)
        {
            phase = 1;
            capture = i;
        }
        ox = -6 + irandom(2) * 6;
    }
    else if (phase == 1)
    {
        despawnRange = -1;
        canHit = false;
        if (!global.switchingSections)
            timer += 1;
        if (timer > lifeTime)
        {
            instance_destroy();
            exit;
        }
        if (instance_exists(capture))
        {
            if (!instance_exists(capture.statusObject))
            {
                capture.statusObject = instance_create(capture.x, capture.y, objStatusEffect);
            }
            capture.statusObject.statusOnIce = true;
            x = capture.x + ox;
            y = capture.y + capture.image_yscale * 10 + capture.image_yscale * 4 * (ox == 0);
        }
        else
        {
            instance_destroy();
        }
    }
    image_index = floor(animFrame);
}
#define Other_19
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Nope
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_create(x, y, objExplosion);
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (timer < lifeTime - 60)
    event_inherited();
else if (timer mod 4)
    event_inherited();
