#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 3;

image_speed = 0.15;

penetrate = 1;
pierces = 2;

xspeed = 0;
grav = 0;

despawnRange = -1;

phase = 1;
resetSpriteChange = 0;

xx = -4;
ys = 0;

playSFX(sfxWire);
sfxloop = 0;
alarm[0] = 12;

wireLock = false;
parent.xspeed = 0;
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (instance_exists(parent))
{
    lockPoolRelease(wireLock);
}

audio_stop_sound(sfxWire);
alarm[0] = -1;
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSFX(sfxWire);
alarm[0] = 12;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    if (!instance_exists(parent))
    {
        instance_destroy();
        exit;
    }

    if (parent.isHit)
    {
        with (parent)
        {
            xspeed = image_xscale * -0.5;
        }
        instance_destroy();
        visible = 0;
        exit;
    }

    x = parent.x + xx * image_xscale;
    parent.xspeed = 0;
    gravDir = sign(parent.grav);

    if(phase==-1)
    {
        if(place_meeting(x,y,parent))
        {
            instance_destroy();
            exit;
        }
    }
    else if (phase == 1)
    {
        if (checkSolid(0, -1 * gravDir))
        {
            yspeed = 0;
            image_speed = 0;
            image_index = 0;
            phase = 2;
            parent.isShoot = 0;
            y -= 1;
        }

        if (y < view_yview + 8 && gravDir == 1)
        {
            yspeed = 4;
        }
        if (y > view_yview + view_hview - 8 && gravDir == -1)
        {
            yspeed = -4;
        }
        if( (yspeed>0 && bbox_top>view_yview+view_hview)
            || (yspeed < 0 && bbox_bottom<view_yview))
        {
            yspeed*=-1;
            y=yprevious;
            phase = -1;
        }

        if ((gravDir == 1 && y > parent.y + ys)
            || (gravDir == -1 && y < parent.y - ys))
        {
            instance_destroy();
            visible = 0;
        }
    }
    else
    {
        if (phase == 2)
        {
            with (parent)
            {
                other.parent.yspeed = -4 * gravDir;
                if (place_meeting(x, y - 4, other.id))
                {
                    other.parent.yspeed = 0;
                    other.phase = 3;
                    y = other.y + 9 * gravDir;
                    audio_stop_sound(sfxWire);
                    other.alarm[0] = -1;

                    // other.resetSpriteChange = canSpriteChange;
                    // canSpriteChange = 0;
                    ground = 0;

                    // playerHandleSprites('Normal');
                }
            }
        }

        if (phase >= 2)
        {
            if (global.keyJumpPressed[parent.playerID])
            {
                parent.yspeed = -1 * gravDir;
                instance_destroy();
            }
            else
            {
                with (parent)
                {
                    playerHandleShoot();
                    if (isShoot)
                    {
                        shootTimer -= 1;
                    }
                }
            }
        }
    }
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// update sprites for wire
if (instance_exists(parent))
{
    with (parent)
    {
        playerHandleSprites("Wire");
    }
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Set Mega Man's palette
weaponSetup("WIRE ADAPTOR", make_color_rgb(216, 40, 0), make_color_rgb(255, 255, 255), sprWeaponIconsWire);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Set special damage values
specialDamageValue("flying", 6);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var xOffset, yOffset, bulletObject, bulletLimit, weaponCost, action, willStop;

xOffset = -3; // x offset from center of player
yOffset = -8; // y offset from center of player
bulletObject = objWireAdapter;
bulletLimit = 0;
weaponCost = 2;
action = 1; // 0 - no frame; 1 - shoot; 2 - throw
willStop = 0; // If this is 1, the player will halt on shooting ala Metal Blade.

if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    if (!instance_exists(vehicle))
    {
        if (!instance_exists(bulletObject))
        {
            if (!climbing && ground
                && ((global.keyUp[playerID] && sign(grav) >= 0)
                || (global.keyDown[playerID] && sign(grav) < 0)))
            {
                i = fireWeapon(xOffset, yOffset, bulletObject, bulletLimit, weaponCost, action, willStop);
                if (instance_exists(i))
                {
                    i.yspeed = -4 * image_yscale;

                    i.wireLock = lockPoolLock(
                        localPlayerLock[PL_LOCK_MOVE],
                        localPlayerLock[PL_LOCK_JUMP],
                        localPlayerLock[PL_LOCK_GRAVITY],
                        localPlayerLock[PL_LOCK_CLIMB],
                        localPlayerLock[PL_LOCK_TURN],
                        localPlayerLock[PL_LOCK_SLIDE]);

                    i.ys = y - i.y;
                }
            }
        }
        else
        {
            // buster shot
            if (objWireAdapter.phase >= 2)
            {
                i = fireWeapon(16, 0, objBusterShot, 4, 0, 1, 0);
                if (i)
                {
                    i.xspeed = image_xscale * 5;
                }
            }
        }
    }
}

// Looking Up Animation
if (!isShoot)
{
    if ((global.keyUp[playerID] && gravDir >= 0)
        || (global.keyDown[playerID] && gravDir < 0))
    {
        spriteY = 7;
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
drawSelf();

if (phase == 3)
{
    exit;
}

if (!instance_exists(parent))
{
    instance_destroy();
    exit;
}

gravDir = parent.gravDir;
image_yscale = gravDir;

wirelength = (floor(((parent.y - 6 * parent.image_yscale) - y) / 4))
    * gravDir;
wireimg = 1;
if (image_xscale == -1)
{
    wireimg = 3;
}
if (phase == 2)
{
    wireimg = 4;
}

for (i = 0; i <= wirelength; i += 1)
{
    if (phase == 1)
    {
        wireimg += 1;
        if (wireimg == 4)
        {
            wireimg = 0;
        }
    }
    draw_sprite_ext(sprWireAdapterWire, wireimg, x,
        y + i * 4 * gravDir, 1, gravDir, image_angle,
        image_blend, image_alpha);
}
