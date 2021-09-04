#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 5;

blockCollision = 0;
grav = 0;

reflectable = 0;

attackTimer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // Animation
    image_speed = 1 / 7;
    if (sprite_index == sprPharaohShotCharging) // After fully charging, change sprites
    {
        if (image_index > 9)
        {
            sprite_index = sprPharaohShotCharged;
        }
    }

    // Attack routine
    attackTimer++;

    // track player
    if (attackTimer < 120 && instance_exists(target))
    {
        x = target.x + target.image_xscale;
        y = target.y - 40;
    }

    // flicker to indicate stopping
    if (attackTimer >= 70 && attackTimer < 120 && attackTimer mod 2 == 0)
    {
        visible = !visible;
    }

    // fly down
    if (attackTimer == 120)
    {
        visible = true;
        yspeed = -5;
        grav = 0.25;
    }
}
