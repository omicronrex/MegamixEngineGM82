#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// An enemy that rolls back and forth, deflecting shots to the front with its buzzsaw.
// Killing it releases the buzzsaw, which charges straight forwards after a small delay.

event_inherited();

respawn = true;

healthpointsStart = 4;
healthpoints = healthpointsStart;

contactDamage = 4;
category = "grounded, semi bulky";

facePlayerOnSpawn = true;

imgSpd = 0.2;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    image_index += imgSpd;

    // Turn around if hitting a wall
    if (xcoll != 0)
    {
        image_xscale *= -1;
    }

    // Move when on ground
    if (ground)
    {
        xspeed = 1.2 * image_xscale;

        // Turn around if hitting an edge
        if (!positionCollision(x + 8 * image_xscale, bbox_bottom + 2))
        {
            image_xscale *= -1;
        }
    } // Stay still if not on ground
    else
    {
        xspeed = 0;
    }
}
else if (dead)
{
    image_index = 0;
    healthpoints = healthpointsStart;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if ((other.object_index != objTornadoBlow) && (other.object_index != objBlackHoleBomb))
{
    i = instance_create(x + 7 * image_xscale, y - (sprite_height / 2), objChainsoarWheel);
    i.yspeed = -4;
    if ((other.object_index == objSlashClaw) || (other.object_index == objBreakDash))
    {
        with (objSlashEffect)
        {
            sprite_index = sprChainsoarNoWheel;
        }
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (collision_rectangle(x + 10 * image_xscale, y, x + 12 * image_xscale, y - 18, other.id, false, false))
{
    other.guardCancel = 1;
}
