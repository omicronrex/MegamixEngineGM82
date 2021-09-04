#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// col = <number> (0 = blue (default); 1 = gray)
// slowSpeed = speed that the Spine moves at when it doesn't see Mega Man.
// fastSpeed = speed that the Spine moves at when it sees Mega Man.

event_inherited();

respawn = true;

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 4;
respawnRange = 0;
despawnRange = 16;

facePlayerOnSpawn = true;

// Enemy specific code
col = 0; // 0 = blue; 1 = gray
init = 1;

bounceTimer = 0;
fastSpeed = 2;
slowSpeed = 0.25;
animSpeed = 0;
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
            sprite_index = sprSpringHead;
            break;
        case 1:
            sprite_index = sprSpringHeadGrey;
            break;
        default:
            sprite_index = sprSpringHead;
            break;
    }
}

event_inherited();

if (entityCanStep())
{
    if (bounceTimer > 0 || image_index != 0)
    {
        bounceTimer -= 1;
        animSpeed = 0.25;
        xspeed = 0;
    }
    else
    {
        if (checkFall(16 * image_xscale) || (xcoll != 0))
        {
            x -= image_xscale;
            image_xscale = -image_xscale;
            xspeed = -xspeed;
        }

        animSpeed = 0;
        image_index = 0;

        // set slow speed as default for frame
        xspeed = slowSpeed * image_xscale;

        // speed up if lined up with target
        if (instance_exists(target))
        {
            if (target.bbox_bottom + 1 > bbox_bottom
                && target.bbox_bottom - 1 < bbox_bottom)
            {
                xspeed = fastSpeed * image_xscale;
            }
        }
    }
    image_speed = animSpeed;
}
#define Collision_objMegaman
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (bounceTimer <= 0)
    {
        bounceTimer = 128;
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 1;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn
image_index = 0;
image_speed = 0;
bounceTimer = 0;
animSpeed = 0;
