#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// col = 0 = pink, 1 = red, 2 = orange, 3 = green
// slowSpeed = speed it will use when Mega Man is not lined up with it, in pixels per frame. 1 = default
// fastSpeed = speed it will use when Mega Man is lined up with it. 2 = default.

event_inherited();

respawn = true;

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 2;

facePlayerOnSpawn = true;

// Enemy specific code
enemyDamageValue(objThunderBeam, 1);
enemyDamageValue(objBreakDash, 3);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objMagicCard, 2);

image_speed = 0.2;
ground = 1;

init = 1;
calibrated = 0;

col = 0;

slowSpeed = 1;
fastSpeed = 2;

xDir = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Color setting
if (init)
{
    init = 0;
    switch (col)
    {
        case 0:
            sprite_index = sprGaryoby;
            break;
        case 1:
            sprite_index = sprGaryobyRed;
            break;
        case 2:
            sprite_index = sprGaryobyOrange;
            break;
        case 3:
            sprite_index = sprGaryobyGreen;
            break;
    }
}

event_inherited();

if (entityCanStep())
{
    // if it's colliding with a wall, reverse direction
    if (xcoll != 0)
    {
        // xspeed = -xcoll;
        xDir = -xcoll;
    }

    // Don't move in the air
    if (!ground)
    {
        xspeed = 0;
    }

    // Set speed based on player position
    if (instance_exists(target))
    {
        if (ground)
        {
            if (bbox_bottom == target.bbox_bottom)
            {
                xspeed = fastSpeed * sign(xDir);
            }
            else
            {
                xspeed = slowSpeed * sign(xDir);
            }
        }
    }
    else if (ground)
    {
        xspeed = slowSpeed * sign(xDir);
    }

    // Turn around on ledges
    if (checkFall(16 * xDir, false))
    {
        xDir *= -1;
    }
}
else if (dead)
{
    image_index = 0;
    ground = 1;
    xDir = 1;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.damage == 0)
    other.guardCancel = 3;
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.damage = 0;
event_inherited();
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (spawned)
{
    xspeed = image_xscale;
    image_xscale = 1;
}
