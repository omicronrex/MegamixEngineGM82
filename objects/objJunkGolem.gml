#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// They throw Junk Blocks at Mega Man.
event_inherited();

healthpointsStart = 6;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "semi bulky, rocky";

grav = 0;
blockCollision = 0;

facePlayer = true;

state = 0;
timer = 0;
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
    timer += 1;
    switch (state)
    {
        case 0: // Triggering falling
            if (timer > 40)
            {
                y = view_yview + 4;
                state = 1;
                timer = 0;
                grav = 0.25;
                ground = 0;
            }
            break;
        case 1: // Falling
            if (y >= ystart)
            {
                y = ystart;
                yspeed = 0;
                blockCollision = 1;
                ground = 1;
                state = 2;
                timer = 0;
            }
            break;
        case 2: // Throw TRAAAAAAASH
            if (timer == 64)
            {
                instance_create(x - 16, view_yview, objThrownJunk);
                state = 3;
            }
            break;
    }

    if (collision_rectangle(x, y - 16, x, y, objThrownJunk, false, true)
        && image_index == 0)
    {
        image_index = 1;
    }

    if (image_index == 2)
    {
        animTimer += 1;
        if (animTimer >= 12)
        {
            image_index = 0;
            animTimer = 0;
            timer = -45;
            state = 2;
        }
    }
}
else if (dead)
{
    grav = 0;
    blockCollision = 0;
    state = 0;
    timer = 0;
    animTimer = 0;
    image_index = 0;
}

contactDamage = 4 * visible;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (state == 0)
{
    other.guardCancel = 2;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (state != 0)
{
    event_inherited();
}
