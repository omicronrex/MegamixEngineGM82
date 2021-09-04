#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 2;

penetrate = 0;
pierces = 0;

blockCollision = 1;
grav = 0;

playSFX(sfxBuster);

calibrated = false;
phase = 0;
animTimer = 0;
spd = 3;

// Variables for snapToGround()
_groundDir = -1;
_dir = 1;
_velX = 0;
_velY = 0;
_prevCollision = 0;

gravDir = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
image_xscale = 1;
image_yscale = 1;
if (!global.frozen && canDamage)
{
    if (phase == 0) // Coming out
    {
        if (xcoll != 0)
        {
            xspeed = xcoll;
        }
        if (ycoll != 0)
        {
            yspeed = ycoll;
        }

        if (sign(grav) == 1)
        {
            _groundDir = 270;
            image_index = 0;
            gravDir = 1;
        }
        else
        {
            _groundDir = 90;
            image_index = 2;
            gravDir = -1;
        }

        if (xcoll != 0 || ycoll != 0)
        {
            phase = 1;
        }

        if (phase == 1)
        {
            grav = 0;
            yspeed = 0;
            xspeed = 0;

            // Make sure its aligned with a solid
            if (ycoll > 0)
            {
                shiftObject(0, 2, 1);
                grav = 0.25;
                _groundDir = 270;
                checkGround();
            }
            else if (ycoll < 0)
            {
                _groundDir = 90;
                shiftObject(0, -2, 1);
                grav = -0.25;
                checkGround();
            }
            else if (xcoll > 0)
            {
                _groundDir = 0;
                shiftObject(2, 0, 1);
            }
            else if (xcoll < 0)
            {
                _groundDir = 180;
                shiftObject(-2, 0, 1);
            }
        }
    }
    else if (phase == 1) // Attached to solids
    {
        //var gravDir; gravDir = sign(grav);
        //if (instance_exists(parent))
        //    gravDir = parent.gravDir;

        if (!snapToGround(spd, 4, 1))
        {
            event_user(EV_DEATH); // Die if the script fails
        }
        else if ((gravDir == 1 && _groundDir == 90) || (gravDir == -1 && _groundDir == 270)) // Also die if on a ceiling
        {
            event_user(EV_DEATH);
        }
        switch (_groundDir)
        {
            case 90:
            case 270:
                if (sign(_velX) == _dir)
                {
                    image_index = 0;
                }
                else
                {
                    image_index = 2;
                }
                break;
            case 180:
            case 0:
                if (sign(_velY) > 0)
                {
                    image_index = 4;
                }
                else
                {
                    image_index = 6;
                }
                break;
        }
    }

    image_index += (_dir == -1) * 8 + (animTimer div 5) mod 2;

    animTimer += 1;
    if (phase == 0)
    {
        if (animTimer >= 30)
            animTimer = 0;
    }
    else if (animTimer >= 10)
        animTimer = 0;
}
else if (!canDamage)
{
    blockCollision = false;
    grav = 0;
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Set Mega Man's palette
weaponSetup("SEARCH SNAKE", make_color_rgb(0, 184, 0), make_color_rgb(248, 248, 248), sprWeaponIconsSearchSnake);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Set special damage values
specialDamageValue("grounded", 3);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Fire weapon
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    i = fireWeapon(13, 0, objSearchSnake, 3, 0.5, 1, 0);
    if (i)
    {
        i.yspeed = -3 * image_yscale;
        i.xspeed = 1 * image_xscale;
        i._dir = image_xscale;
        if (gravDir == -1)
            i._dir *= -1;
        i.grav = 0.3 * image_yscale;
        if (i.grav > 0)
        {
            i._groundDir = 270;
        }
        else
        {
            i._groundDir = 90;
        }
    }
}
