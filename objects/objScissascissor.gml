#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// An enemy from Hornet Man's stage. Will start as two pieces of a scissor that attempt to combine by
// smashing into each other, and once combined, the full scissor will dash at Mega Man until it goes
// offscreen. It then loops back around the screen for another run at the player.

// This enemy is a bit strange, so it's placed a little weirdly. Despite it being shown in the editor
// as the whole scissor, when this object at its placed position is spawned, it will come already
// seperated, just to make things a bit more intuitive.

event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "floating";

blockCollision = 0;
grav = 0;

facePlayerOnSpawn = true;

splitWithSpawn = false;

// Enemy specific code
despawnRange = 16; // Needs to be higher because of its loop attack.
actionTimer = -1;
animTimer = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // Actual action once combined
    if (actionTimer > -1)
    {
        actionTimer += 1;

        // quick anim frame 1 for more polish
        if (actionTimer == 3)
        {
            image_index = 0;
        }

        if (actionTimer == 25)
        {
            xspeed = 5 * image_xscale;
        }

        // loop back around if offscreen
        if (actionTimer > 25 && image_speed == 0 && ((x - (sprite_width / 2) < view_xview[0] && image_xscale == -1) || (x - (sprite_width / 2) > view_xview[0] + view_wview[0] && image_xscale == 1)))
        {
            image_xscale = -image_xscale;
            xspeed = -xspeed;
            image_speed = 0.4;
        }
    }
}
else if (dead)
{
    splitWithSpawn = false;
    image_speed = 0;
    image_index = 0;
    actionTimer = -1;
    xspeed = 0;
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
    // Check for if it's spawned yet, if so, split into two parts
    // if !splitWithSpawn and insideView()
    //{
    a = instance_create(x, y - 32, objScissascissorPart);
    a.image_yscale = -1;
    a.parent = id;

    a = instance_create(x, y + 32, objScissascissorPart);
    a.image_yscale = 1;
    a.parent = id;

    splitWithSpawn = true;

    visible = false;
    contactDamage = 0;
    canHit = false;
    x += 32 * image_xscale;

    //}
}
