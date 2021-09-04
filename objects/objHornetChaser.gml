#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 2;

image_speed = 0.3;

penetrate = 0;
pierces = 1;

xspeed = 0;
yspeed = 0;
grav = 0;

speed = 2;
chase = 0;
pickup = 0;

alarmChase = 20;

playSFX(sfxHornetChaser);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    if (alarmChase)
    {
        alarmChase -= 1;
        if (!alarmChase)
        {
            chase = 1;
        }
    }

    if (!canDamage)
    {
        chase = 0;
        alarmChase = -1;
    }

    if (!pickup && instance_exists(parent)) // Collect pickups
    {
        if (place_meeting(x, y, prtPickup))
        {
            pickup = instance_place(x, y, prtPickup);
            if (pickup.grabable)
            {
                pickup.depth = depth - 1;
                with (object_index)
                {
                    if (id != other.id)
                    {
                        if (pickup == other.pickup)
                        {
                            other.pickup = 0;
                        }
                    }
                }
            }
            else
            {
                pickup = 0;
            }
        }
    }

    if (pickup) // Control collected pickup
    {
        if (instance_exists(pickup))
        {
            pickx = spriteGetXCenterObject(pickup) - pickup.x;
            picky = spriteGetYCenterObject(pickup) - pickup.y;
            pickup.x = x - pickx + 8 * image_xscale;
            pickup.xspeed = 0;
            pickup.y = y - picky + 6;
            pickup.yspeed = 0;
        }
        else
        {
            pickup = 0;
        }
    }

    if (chase)
    {
        var dis = view_wview;
        var chaseObj = target;

        if (pickup && instance_exists(parent))
        {
            chaseObj = parent;
        }
        else
        {
            dis = distance_to_object(chaseObj);

            with (prtPickup) // Find closest item
            {
                if (grabable && !place_meeting(x, y, other.object_index))
                {
                    if (insideView())
                    {
                        if (distance_to_object(other) < dis)
                        {
                            dis = distance_to_object(other);
                            chaseObj = id;
                        }
                    }
                }
            }
        }

        if (instance_exists(chaseObj)) // Round direction to target direction
        {
            correctDirection(round(point_direction(x, y,
                spriteGetXCenterObject(chaseObj),
                spriteGetYCenterObject(chaseObj))), 12);
        }

        image_xscale = 1 - (2 * (direction > 90 && direction <= 270));
    }
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("HORNET CHASER", make_color_rgb(231, 191, 60), make_color_rgb(252, 252, 252), sprWeaponIconsHornetChaser);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue("bulky", 1);
specialDamageValue("joes", 1);
specialDamageValue("shield attackers", 1);
specialDamageValue("floating", 3);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var xOffset, yOffset, bulletObject, bulletLimit, weaponCost, action, willStop;

xOffset = 14; // x offset from center of player
yOffset = -3; // y offset from center of player
bulletObject = objHornetChaser;
bulletLimit = 3;
weaponCost = 1.5;
action = 1; // 0 - no frame; 1 - shoot; 2 - throw
willStop = 0; // If this is 1, the player will halt on shooting ala Metal Blade.

if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    i = fireWeapon(xOffset, yOffset, bulletObject, bulletLimit, weaponCost, action, willStop);

    // set its starting angle.
    if (i)
    {
        i.direction = 30 + (120 * (image_xscale == -1 && image_yscale == 1)) + (300 * (image_yscale == -1)) - (120 * (image_xscale == -1 && image_yscale == -1));
    }
}
