#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// It's a monkey enemy that hangs from ceilings and jumps when Megaman gets close to him
event_inherited();

healthpointsStart = 8;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "nature, primate";

facePlayerOnSpawn = true;

// Enemy specific code
contactStart = contactDamage;

actionTimer = 0;
state = 0;
animTimer = 0;
swingCooldown = 0;
doneCritSwing = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if(xcoll!=0)
{
    xspeed=xcoll;
}

if (entityCanStep())
{
    grav = 0.25 * (state == 2);
    blockCollision = (state != 1);

    // general action timer
    actionTimer += 1;

    // initial jump up
    switch (state)
    {
        case 0: // waiting on ground + jumping up
            if (actionTimer == 30)
            {
                image_index = 3;
                yspeed = -6;
                animTimer = 0;
                y -= 2;
            }
            if (actionTimer > 30 && ycoll < 0)
            {
                state = 1;
                sprite_index = sprReturningMonkingSwing;
                image_speed = 0.125;
                image_index = 0;
                actionTimer = 0;
                state = 1;
                y += 8;
                yspeed = 0;
            }
            break;
        case 1: // swinging on ceiling
        // check if megaman is two blocks away
            if (instance_exists(target))
            {
                if (collision_rectangle(x - 32, y - view_hview, x + 32, y + view_hview, target, false, true) && swingCooldown == 0)
                {
                    sprite_index = sprReturningMonking;
                    image_speed = 0;
                    image_index = 3;
                    state = 2;
                }
            }

            // used for half health return to ceiling
            if (swingCooldown > 0)
            {
                swingCooldown -= 1;
            }
            break;
        case 2: // jumping around
            if (ground)
            {
                image_index = 2;
                calibrateDirection();
                yspeed = -5;
                xspeed = 2 * image_xscale;
            }

            if (healthpoints <= (healthpointsStart / 2) && !doneCritSwing)
            {
                actionTimer = 40;
                state = 0;
                image_index = 3;
                yspeed = -6;
                animTimer = 0;
                y -= 2;
                doneCritSwing = true;
                swingCooldown = 40;
                xspeed = 0;
            }
            break;
    }

    // anim timer for being on the ground
    if (state == 0)
    {
        animTimer += 1;
        if (animTimer == 5)
        {
            animTimer = 0;
            if (image_index == 1)
            {
                image_index = 0;
            }
            else if (image_index == 0)
            {
                image_index = 1;
            }
        }
    }
}
else if (dead)
{
    actionTimer = 0;
    image_index = 0;
    sprite_index = sprReturningMonking;
    image_speed = 0;
    state = 0;
    swingCooldown = 0;
    doneCritSwing = false;
}
