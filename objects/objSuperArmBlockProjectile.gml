#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

cachedXSpeed = 0;
cachedYSpeed = 0;
host = noone;

penetrate = 1;
contactDamage = 4;

noShatter = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (instance_exists(host))
{
    x = host.bbox_left;
    y = host.bbox_top;
    image_xscale = (host.bbox_right - host.bbox_left) / 16;
    image_yscale = (host.bbox_bottom - host.bbox_top) / 16;
    cachedXSpeed = host.xspeed;
    cachedYSpeed = host.yspeed;
    noShatter = !host.superArmDeathOnDrop;
    if (abs(cachedXSpeed) < 2)
    {
        cachedXSpeed = host.image_xscale * 2;
    }
}

var deathOnDrop = true;
if (checkSolid(cachedXSpeed, cachedYSpeed, true))
{
    with (host)
    {
        deathOnDrop = superArmDeathOnDrop;
        event_perform_object(objSuperArm, ev_other, ev_user1);
    }

    if (!deathOnDrop)
    {
        instance_destroy();
    }
}

if (deathOnDrop)
{
    if (!instance_exists(host))
    {
        event_user(0);
    }
    else if (!host.superArmThrown || host.dead)
    {
        event_user(0);
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// split into debris

if (noShatter)
{
    instance_destroy();
    exit;
}

playSFX(sfxSuperArm);

for (var ix = bbox_left; ix < bbox_right; ix += 16)
{
    for (var iy = bbox_top; iy < bbox_bottom; iy += 16)
    {
        with (instance_create(ix, iy, objSuperArmDebris))
        {
            xspeed = other.cachedXSpeed;
            yspeed = -2 * ((ix + iy) / 16 mod 2);
            parent = other.parent;
        }
    }
}

instance_destroy();
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var deathOnDrop = false;
with (host)
{
    deathOnDrop = superArmDeathOnDrop;
    event_perform_object(objSuperArm, ev_other, ev_user1);
}

if (deathOnDrop)
{
    event_user(0);
}
else
{
    instance_destroy();
}
