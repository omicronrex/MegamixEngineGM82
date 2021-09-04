#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 1;

penetrate = 0;
pierces = 1;

inWater = -1;

spd = 3;

endInitTimer = 0;
followPlayer = true;

range = 18;
mySpeed = 5;
mySpeed *= -parent.image_xscale;
direction += sign(mySpeed) * 10;

despawnRange = 64; // don't be despawned by scrolling offscreen

alarm[1] = 8;
dirphase = 1;
dirdir = 0.5;

num = instance_number(object_index);
if (num == 2)
{
    num = 4;
}
else if (num == 4)
{
    num = 2;
}
alarm[0] = (num - 1) * 36 + 1;

ID = 0;

delete = 0;

playSFX(sfxJewelSatellite);

xs = x;
ys = y;
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!delete)
{
    with (object_index)
    {
        delete = 1;
        instance_destroy();
    }
}
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed = 0.3;
alarm[0] = 4 * 36 + 1;
#define Alarm_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dirphase += 1;

if (dirphase == 2)
{
    alarm[1] = 1;
    dirdir = 0;
    exit;
}
if (dirphase == 3)
{
    alarm[1] = 8;
    dirdir = -0.5;
    exit;
}
if (dirphase == 4)
{
    alarm[1] = 1;
    dirdir = 0;
    exit;
}
if (dirphase == 5)
{
    alarm[1] = 8;
    dirdir = 0.5;
    dirphase = 1;
    exit;
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    if (endInitTimer < 10)
    {
        endInitTimer += 1;
    }

    // Sticking to the player until fired or destroyed in any way
    if (followPlayer)
    {
        if (instance_exists(parent))
        {
            xs = spriteGetXCenterObject(parent);
            ys = spriteGetYCenterObject(parent);
            if (!parent.ground)
            {
                ys -= parent.gravDir * 4;
            }

            image_yscale = parent.image_yscale;
        }
        else
        {
            instance_destroy();
        }
        if (global.keyShootPressed[playerID] && endInitTimer
            >= 8) // Do not shoot the weapon until the init state is over
        {
            var dir; // 1 = firing to the right, -1 = firing to the left
            if (instance_exists(parent))
            {
                dir = parent.image_xscale;
            }
            else
            {
                dir = 1;
            }

            followPlayer = false;
            xspeed = dir * spd;
        }
    }

    xs += xspeed;
    ys += yspeed;

    range += dirdir;
    rotationMovement(xs, ys, range, mySpeed);
}
#define Collision_prtEnemyProjectile
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (canDamage)
{
    if (!global.factionStance[faction, other.faction])
    {
        exit;
    }

    switch (other.reflectable)
    {
        case 0:
            exit;
            break;
        case -1:
            playSFX(sfxEnemyHit);
            with (other)
            {
                i = instance_create(bboxGetXCenter(), bboxGetYCenter(), objExplosion);
                event_user(EV_DEATH);
            }
            break;
        case 1:
            playSFX(sfxEnemyHit);
            with (other)
            {
                faction = other.faction;
                xspeed *= -1;
                yspeed *= -1;
                hspeed *= -1;
                vspeed *= -1;
                direction += 180;
                image_xscale *= -1;
                pierces = 0;
                grav = 0;
            }
            break;
    }
}
#define Other_7
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed = 0;
#define Other_17
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSFX(sfxReflect);

with (object_index)
{
    if (playerID != other.playerID)
    {
        continue;
    }

    canDamage = 0;
    canHit = false;
    followPlayer = 0;

    predir = direction;

    if (sign(xspeed) == -1)
    {
        direction = 45;
    }
    else
    {
        direction = 135;
    }

    motion_set(direction, 6);

    xspeed = hspeed;
    yspeed = vspeed;
    hspeed = 0;
    vspeed = 0;

    direction = predir;
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("JEWEL SATELLITE", make_color_rgb(67, 231, 216), make_color_rgb(252, 252, 252), sprWeaponIconsJewelSatellite);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue("cluster", 3);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    for (z = 0; z < 8; z += 1)
    {
        i = fireWeapon(0, 0, objJewelSatellite, 8, 4 * (z == 0), 0, 0);
        if (i)
        {
            i.direction = z * 90;
            if (z >= 4)
            {
                i.direction *= 45;
                i.visisble = 0;
            }
        }
        else
        {
            break;
        }
    }
}
#define Other_40
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
doIt = 1;

with (object_index)
{
    if (insideView())
    {
        other.doIt = 0;
    }
}

if (doIt)
{
    with (object_index)
    {
        if (playerID == other.playerID)
        {
            instance_destroy();
        }
    }
}
