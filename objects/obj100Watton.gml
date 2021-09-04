#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 6;

category = "flying";

blockCollision = 0;
grav = 0;

facePlayerOnSpawn = true;

// Enemy specific code
calibrated = 0;

imgsp = 4;

action = 1;
actionTimer = imgsp;
img = 0;
animTimer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (action)
    {
        actionTimer += 1;
        if (action == 1 || action == 3)
        {
            if (actionTimer == imgsp * 10)
            {
                image_index += 4;
                action += 1;
                actionTimer = 0;
                i = instance_create(x, bbox_top - 4, objExplosion);
                with (i)
                {
                    sprite_index = spr100WattonSmoke;
                    event_perform(ev_create, 0);
                    motion_set(45 + (image_xscale == -1) * 90, 0.5);
                }
            }
        }
        else if (action == 2 || action == 4)
        {
            if (actionTimer == imgsp * 2)
            {
                image_index -= 4;
                action += 1;
                actionTimer = 0;
            }
        }
        else if (action == 5)
        {
            if (actionTimer == imgsp * 2)
            {
                image_index += 4;
                instance_create(x, y - 12, obj100WattonBomb);
                action += 1;
                actionTimer = 0;
                xspeed = 0;
            }
        }
        else if (action == 6)
        {
            if (actionTimer == imgsp * 2)
            {
                image_index -= 4;
                action = 1;
                actionTimer = 0;
                xspeed = image_xscale * 1;
            }
        }
        animTimer += 1;
        if (animTimer == imgsp)
        {
            image_index += 1;
            if (image_index == 4 || image_index == 8)
            {
                image_index -= 4;
            }
            animTimer = 0;
        }
    }
}
else if (dead)
{
    action = 1;
    actionTimer = imgsp;
    img = 0;
    animTimer = 0;
    image_index = 0;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!instance_exists(obj100WattonVoid))
{
    instance_create(x, y, obj100WattonVoid);
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (spawned)
{
    xspeed = image_xscale * 1;
}
