#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A rocket-powered Roader that charges at Mega Man and explodes on death.

event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
category = "grounded";

contactDamage = 3;

// @cc - use this to change how fast Cannon Roader charges at the player
chargeSpeed = 3;

// @cc - use this to change how long it takes Cannon Roader to charge at the player
moveTimer = 70;

imgSpd = 0.18;
charge = false;
itemDrop = -1;
facePlayerOnSpawn = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if ((ground) && (!charge))
    {
        /*if ((abs(target.x - x) > 48) || (target.x > x) && (image_xscale == -1)
            || (target.x < x) && (image_xscale == 1))*/

        // If Mega Man is far away, roll around
        xspeed = 1 * image_xscale;

        image_index += imgSpd;
        if (image_index >= 2)
        {
            image_index = 0;
        }

        if ((!positionCollision(x + 8 * image_xscale, bbox_bottom + 2))
            || (xcoll != 0))
        {
            image_xscale *= -1;
        }
        // Charge when Mega Man is close.
        if (instance_exists(target))
        {
            if (abs(target.x - x) <= 48)
            {
                charge = true;
            }
        }
    }
    if (charge == true)
    {
        xspeed = 0;
        moveTimer-=1;
        image_index += imgSpd;
        if (image_index >= 5)
        {
            image_index = 3;
        }

        // Charge forward after countdown
        if (moveTimer <= 0)
        {
            xspeed = chargeSpeed * image_xscale;

            if (xcoll != 0)
            {
                dead = true;
                instance_create(x, bboxGetYCenter(), objHarmfulExplosion);
                playSFX(sfxMM9Explosion);
            }
        }
    }
}
else if (dead)
{
    healthpoints = healthpointsStart;
    xspeed = 0;
    yspeed = 0;
    image_index = 0;
    moveTimer = 70;
    charge = false;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (dead)
{
    if ((other.object_index != objTornadoBlow) && (other.object_index != objBlackHoleBomb))
    {
        instance_create(x, bboxGetYCenter(), objHarmfulExplosion);
        playSFX(sfxMM9Explosion);

        if ((other.object_index == objSlashClaw) || (other.object_index == objBreakDash))
        {
            with (objSlashEffect)
            {
                image_alpha = 0;
            }
        }
    }
}
