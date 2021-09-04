#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// col = 0 = greenish, 1 = blue, 2 = red
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "cluster, floating";

grav = 0;
blockCollision = 0;

facePlayerOnSpawn = true;

// Enemy specific code
image_speed = 0.1;

calibrated = 0;
action = 0;
actionTimer = 0;

col = 0;
init = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{
    init = 0;
    switch (col)
    {
        case 0:
            sprite_index = sprTogehero;
            break;
        case 1:
            sprite_index = sprTogeheroBlue;
            break;
        case 2:
            sprite_index = sprTogeheroRed;
            break;
    }
}

event_inherited();

if (entityCanStep())
{
    if (action)
    {
        actionTimer += 1;
        if (actionTimer == 64)
        {
            action += 1;
            actionTimer = 0;
            yspeed *= -1;
        }
    }
}
else if (dead)
{
    action = 0;
    actionTimer = 0;
    image_index = 0;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// spawn event
event_inherited();

if (spawned)
{
    action = 1;
    actionTimer = 16;
    xspeed = 0.5 * image_xscale;
    yspeed = -0.5;
}
