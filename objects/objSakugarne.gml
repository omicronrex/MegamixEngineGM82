#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 4;

penetrate = 3;
pierces = 2;

blockCollision = 1;
grav = gravAccel;

canDamage = false;

// Enemy specific
active = false;

bounce = 3;

riderPhysicsAllowed = false;
weaponsAllowed = true;
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (active)
{
    if (instance_exists(parent))
    {
        parent.vehicle = noone;
        physicsLock = lockPoolRelease(physicsLock);
    }
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
    if (!active) // Mount Sakugarne
    {
        with (parent)
        {
            if (!isSlide && !climbing)
            {
                with (other)
                {
                    if (position_meeting(x, y, other.id))
                    {
                        yspeed = 0;
                        active = true;
                        canDamage = true;
                        dontDieToScreenTransitions = true;
                        shiftVisible = 2;
                        despawnRange = -1;

                        physicsLock = lockPoolLock(
                            parent.localPlayerLock[PL_LOCK_SHOOT],
                            parent.localPlayerLock[PL_LOCK_CHARGE],
                            parent.localPlayerLock[PL_LOCK_SLIDE],
                            parent.localPlayerLock[PL_LOCK_CLIMB]);
                    }
                }
            }
        }
    }

    if (active) // Riding it
    {
        if (global.ammo[playerID, global.weapon[playerID]] > 0
            && instance_exists(parent))
        {
            image_xscale = parent.image_xscale;
            x = parent.x;
            y = parent.y + 10 * parent.image_yscale;

            // Take away ammo
            global.ammo[playerID, global.weapon[playerID]] = max(0,
                global.ammo[playerID, global.weapon[playerID]]
                - (0.015 / (global.energySaver + 1)));
        }
        else // Teleport away if out of ammo
        {
            i = instance_create(x, y + 16 - 8, objRushTeleport);
            i.upordown = 'up';
            i.parent = parent;

            instance_destroy();
            canHit = false;
            active = 0;
        }
    }

    if (active)
    {
        with (parent)
        {
            if (!ground)
            {
                dieToSpikes *= -1;
                if (checkSolid(0, 6 * gravDir))
                {
                    ground = 1;
                }
                dieToSpikes *= -1;
            }

            if (ground && ((yspeed >= 0 && sign(image_yscale) == 1) || (yspeed <= 0 && sign(image_yscale) == -1)))
            {
                with (other)
                {
                    event_user(8);

                    if (image_index == 0)
                    {
                        playSFX(sfxClamp);
                    }
                    else
                    {
                        playSFX(sfxLargeClamp);
                    }
                }

                ground = 0;
            }
        }
    }
    else
    {
        grav = 0.25 * sign(image_yscale);

        if (ground && yspeed >= 0)
        {
            yspeed = -(other.bounce) * sign(image_yscale);
            image_index = 0;
            playSFX(sfxClamp);
        }
    }
}

if (instance_exists(objSectionSwitcher) && active)
{
    x = objSectionSwitcher.x;
    y = objSectionSwitcher.y;
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// Update sprites of rider if they're on it
if (active)
{
    with (parent)
    {
        playerHandleSprites("Sakugarne" + string(other.image_index));
        vehicle = other.id;
    }
}
#define Collision_prtEnemyProjectile
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!active)
{
    exit;
}

event_user(8);

if (other.reflectable == 1)
{
    playSFX(sfxEnemyHit);
    with (other)
    {
        instance_create(bboxGetXCenter(), bboxGetYCenter(), objExplosion);
        instance_destroy();
    }
}
#define Other_17
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSFX(sfxReflect);

event_user(8);
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (active)
{
    with (parent)
    {
        if (yspeed * gravDir >= 0 && !global.timeStopped)
        {
            var spadd = 1;
            if (!playerIsLocked(PL_LOCK_JUMP))
            {
                spadd += global.keyJump[playerID];
            }

            yspeed = -(other.bounce * spadd) * gravDir;
            other.image_index = spadd - 1;
        }
    }
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("SAKUGARNE", -3, -3, sprWeaponIconsSakugarne);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue("rocky", 8);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT)
&& global.ammo[playerID, global.weapon[playerID]] > 0)
{
    i = fireWeapon(26, 0, objRushTeleport, 1, 0, 0, 0);
    with (i)
    {
        type = 'sakugarne';
        y = view_yview;
        if (image_yscale < 0)
        {
            y += view_hview;
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!active)
{
    drawPlayer(0, costumeID, floor(13 + image_index), 8, x, y - 8 * image_yscale, image_xscale, image_yscale);
}
