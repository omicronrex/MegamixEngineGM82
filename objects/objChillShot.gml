#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 1;

penetrate = 3;
penetrateNoDamage = true;
pierces = false;

blockCollision = 1;
grav = 0.2;

image_speed = 16 / 60;

firstFrame = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// if starting out in a wall, make sure to exit wall
if (firstFrame)
{
    firstFrame = false;
    n_tries = 48;
    checkX = true;
    r = 0;

    while (place_meeting(x - checkX * r * sign(xspeed), y - (!checkX) * r * sign(yspeed), objSolid) && n_tries > 0)
    {
        checkX = !checkX;
        if (checkX)
        {
            r += 1;
        }
        n_tries -= 1;
    }

    if (n_tries <= 0)
    {
        instance_destroy();
        exit;
    }

    x -= (checkX) * r * sign(xspeed);
    y -= (!checkX) * r * sign(yspeed);
}

if (!global.frozen)
{
    var canProceed = true;
    x += xcoll;
    y += ycoll;
    if ((xcoll != 0 || ycoll != 0) && !place_meeting(x, y, objSolid) && !place_meeting(x, y, objTopSolid))
    {
        canProceed = false;
        with (prtEntity)
        {
            var sld = 0;
            if (!isSolid || ((canDamage && contactDamage != 0) && canHit != 0))
                continue;
            if (!dead)
            {
                if (isSolid == 1)
                {
                    if (!fnsolid)
                    {
                        sld = 1;
                    }
                    else
                    {
                        sld = !global.factionStance[faction, other.faction];
                    }
                }
                else if (isSolid == 2)
                {
                    if ((!place_meeting(x, y, other.id))
                        || (!place_meeting(x, y + sign(other.grav), other.id)))
                    {
                        if (!fnsolid)
                        {
                            sld = 1;
                        }
                        else
                        {
                            sld = !global.factionStance[faction, other.faction];
                        }
                    }
                }

                if (sld)
                {
                    if (place_meeting(x, y, other))
                    {
                        canProceed = true;
                        break;
                    }
                }
            }
        }
    }
    if (canProceed)
    {
        x -= xcoll;
        y -= ycoll;
    }
    for (var i = 0; i < 3; i += 1)
    {
        if (!canProceed || (ycoll == 0 && xcoll == 0))
            break;

        // if hitting a wall/floor, turn into spike:

        if (ycoll != 0)
        {
            bulletLimitCost -= 1;
            instance_destroy();
            playSFX(sfxChillSpikeLand);
            with (instance_create(x, y, objChillSpikeLanded))
            {
                dir = (other.ycoll > 0);
            }
        }
        else if (xcoll != 0)
        {
            bulletLimitCost -= 1;
            instance_destroy();
            playSFX(sfxChillSpikeLand);
            with (instance_create(x, y, objChillSpikeLanded))
            {
                dir = 2 + (other.xcoll > 0);
            }
        }
    }
}
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.faction == faction)
{
    exit;
}

with (other)
{
    entityIceFreeze(180);
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("CHILL SPIKE", global.nesPalette[25], make_color_rgb(152, 248, 240), sprWeaponIconsChillShot);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT)
&& instance_number(objChillSpikeLanded) < 3)
{
    i = fireWeapon(25, -1, objChillShot, 3, 0.5, 1, 0);
    if (instance_exists(i)) // Set starting speed
    {
        i.yspeed = -2 * image_yscale;
        i.xspeed = 2 * image_xscale;
        i.grav = i.grav * image_yscale;
        playSFX(sfxChillShoot);
    }
}
