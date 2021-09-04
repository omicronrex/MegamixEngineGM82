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

isSolid = 2;
blockCollision = 1;
doesTransition = 0;

timer = 40;

inWall = false; // Did we collide with a wall?

y = round(y);

playSFX(sfxBuster);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    if (!inWall)
    {
        if (canDamage)
        {
            if (xcoll != 0) // Colliding with a wall
            {
                pierces = 0;
                inWall = true;
            }
            else // Speed up
            {
                if (timer)
                {
                    timer -= 1;
                }
                else
                {
                    if (abs(xspeed) < 4)
                    {
                        xspeed += 10 / 60 * image_xscale;
                    }
                }
            }

            if (xspeed != 0)
            {
                with (objMegaman)
                {
                    if (place_meeting(x, y + gravDir, other.id))
                    {
                        if (!place_meeting(x, y, other.id))
                        {
                            if (global.ammo[playerID, global.weapon[playerID]] > 0)
                            {
                                global.ammo[playerID, global.weapon[playerID]] -= (0.05 / (global.energySaver + 1));
                            }
                        }
                    }
                }
            }
        }
    }
    else
    {
        timer += 1;
        if (timer == 160)
        {
            event_user(EV_DEATH);
            instance_create(spriteGetXCenter(), spriteGetYCenter(), objExplosion);
        }
    }
}

image_single = inWall;
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("SUPER ARROW", -1, -1, sprWeaponIconsSuperArrow);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    fireWeapon(22, 0, objSuperArrow, 3, 2, 1, 0);
}
