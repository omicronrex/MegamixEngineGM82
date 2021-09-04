#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// The Shield Attacker from Powered Up. It's slower and can have its shield knocked off with Charge Shots + other weapons.

event_inherited();

healthpointsStart = 4;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "shield attackers";

grav = 0;

// Enemy specific code
phase = 1;

dir = image_xscale;

moveSprite = sprite_index;
turnSprite = sprShieldGuardTurn;

moveSpeed = 1;
imgSpeed = 0.2;
turnSpeed = 0.05;
hasShield = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// set this so xcoll can be used
event_inherited();

if (entityCanStep())
{
    if (hasShield == false)
    {
        turnSprite = sprShieldGuardNoShieldTurn;
        moveSprite = sprShieldGuardNoShield;
    }

    //Keeping this in case stuff breaks
    /*if (phase == 1)
    {
        if (xcoll != 0)
        {
            phase = 2;
            sprite_index = turnSprite;
            image_index = 0;
        }
        else
        {
            xspeed = moveSpeed * image_xscale;
            image_speed = imgSpeed;
        }
    }
    else
    {
        xspeed = 0;
        image_speed = turnSpeed;

        if (image_index >= image_number - 1)
        {
            image_index = 0;
            phase = 1;
            sprite_index = moveSprite;
            image_xscale *= -1;
        }
    }*/
}
else if (dead)
{
    image_index = 0;
    phase = 1;
    image_xscale = dir;
    sprite_index = sprShieldGuard;
    turnSprite = sprShieldGuardTurn;
    moveSprite = sprShieldGuard;
    hasShield = true;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (phase == 1)
{
    if (hasShield == true)
    {
        if (sign(bboxGetXCenterObject(other.id) - bboxGetXCenter()) == image_xscale)
        {
            if ((other.object_index == objBusterShotCharged) || (other.object_index == objBreakDash))
            {
                sprite_index = sprShieldGuardNoShield;
                var i = instance_create(x, y, objShieldGuardShield);
                i.xspeed = -2 * image_xscale;
                i.yspeed = -4;
                i.image_xscale = image_xscale;
                hasShield = false;

                if (other.object_index == objBreakDash)
                {
                    with (objSlashEffect)
                    {
                        image_alpha = 0;
                    }
                }
                with (other)
                {
                    guardCancel = 1;
                    if ((penetrate < 2) && (pierces < 2))
                    {
                        event_user(EV_DEATH);
                    }
                }
            }
            else
            {
                other.guardCancel = 1;
            }
        }
    }
}
