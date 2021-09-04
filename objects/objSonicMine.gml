#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
contactDamage = 4;

stopOnFlash = false;
blockCollision = 1;
destroyTimer = 0;
respawn = false;

yspeed = -3;

// Sonic Mine's hitbox is different to its collision box, the hitboxes for the various frames is stored here.

radius[0] = 3;
radius[1] = 4;
radius[2] = 7;
radius[3] = 11;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    image_index += 0.35;

    with (collision_circle(x, y, radius[floor(image_index mod 4)], objMegaman, true, true))
    {
        if (!isHit && iFrames == 0)
        {
            playerGetHit(other.contactDamage);
        }
    }

    if (ground)
    {
        xspeed = 0;
        destroyTimer+=1;
    }

    if (destroyTimer >= 32)
    {
        instance_destroy();
    }
}
