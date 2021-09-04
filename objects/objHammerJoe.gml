#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// An armored joe that doesn't need a shield.
// It Swings a heavy ball and uncovers his eye for a moment before throwing it at Megaman.
// Its vulnerable when its eye is uncovered.
event_inherited();

healthpointsStart = 8;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "joes";

facePlayer = true;

// Enemy specific code
shootTimer = 0;
shooting = false;
shootAmount = 0;

image_speed = 0.4;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // Shooting
    if (!shooting)
    {
        sprite_index = sprHammerjoeClosed;
        shootTimer += 1;
        if (shootTimer >= 33)
        {
            shooting = true;
            shootTimer = 0;
            sprite_index = sprHammerjoeOpen;
        }
    }
    else
    {
        shootTimer += 1;
        if (shootTimer == 33)
        {
            sprite_index = sprHammerjoeThrow;

            var i, box;
            if (image_xscale == 1)
            {
                box = bbox_right;
            }
            else
            {
                box = bbox_left;
            }
            i = instance_create(box, y, objHammerJoeHammer);
            i.xspeed = image_xscale * 3;
            i.image_xscale = image_xscale;
        }
        if (shootTimer == 75)
        {
            shootTimer = 0;
            shooting = false;
            sprite_index = sprHammerjoeClosed;
        }
    }
}
else if (dead)
{
    shootTimer = 0;
    shooting = false;
    shootAmount = 0;
    image_index = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (sprite_index == sprHammerjoeClosed)
{
    other.guardCancel = 1;
}
