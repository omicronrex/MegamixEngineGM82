#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;

contactDamage = 5;
category = "flying";
blockCollision = 0;
grav = 0;
facePlayerOnSpawn = true;

// Enemy specific
animTimer = 0;
hasBomb = true;

flyAwayTimer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // animation
    animTimer += 1;

    if (animTimer == 8)
    {
        animTimer = 0;
        if (image_index == 0)
        {
            image_index = 1;
            animTimer = 4;
        }
        else if (image_index == 1)
        {
            image_index = 0;
            animTimer = 4;
        }
        else if (image_index == 2)
        {
            image_index = 3;
        }
        else if (image_index == 3)
        {
            image_index = 4;
        }
        else if (image_index == 4)
        {
            image_index = 5;
        }
        else if (image_index == 5)
        {
            instance_create(x, y + (sprite_height / 2), objSkullBomb);
            hasBomb = false;
            image_index = 0;
        }
    }

    // find player
    if (collision_line(x, y - 512, x, y + 512, target, false, true)
        && hasBomb && image_index < 2)
    {
        image_index = 2;
        xspeed = 0;
    }

    // fly away once bomb is dropped
    if (!hasBomb)
    {
        flyAwayTimer += 1;
        if (flyAwayTimer >= 15)
        {
            xspeed = 2 * image_xscale;
        }
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

animTimer = 0;
hasBomb = true;
image_index = 0;

xspeed = 2 * image_xscale;
flyAwayTimer = 0;
