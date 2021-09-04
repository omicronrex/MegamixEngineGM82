#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// An enemy originating from Guts Man's stage. Will wait to drop its shield, and once it does, it will throw
// out a pseudo-random amount of arcing pickaxes. Note that the health of this enemy is purposefully
// inaccurate to original MM1 - this is to make it a little more tolerable to address complaints after MaGMML2.

event_inherited();

healthpointsStart = 5;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "joes, rocky";

// enemy should jump in from the side of the room when spawned, if possible?
jumpsIn = true;
jumpDistance = 48;

// Enemy specific code
timer = 0;
phase = 1;
bullet = 0;

shootAmountMax = 0;

facePlayer = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// jumping in spawn logic:
if (dead)
{
    if (!jumpsIn)
    {
        respawnRange = 4;
    }
    else
    {
        respawnRange = -jumpDistance;
        if (xstart + (bbox_left - x) + jumpDistance - 2 > view_xview[0] + view_wview[0]
            || xstart + (bbox_right - x) - jumpDistance + 2 < view_xview[0])
        {
            beenOutsideView = true;
        }
    }
}

event_inherited();

if (entityCanStep())
{
    if (abs(y - ystart) <= yspeed + grav) // land
    {
        blockCollision = true;
        xspeed = 0;
    }

    timer += 1;

    if (phase == 1) // wait a bit
    {
        if (timer >= 120) // start pickaxe flurry
        {
            timer = 0;
            phase = 2;
            image_index = 1;

            // randomize();
            bulletMax = choose(5, 10); // randomize amount of pickaxes
        }
    }
    else // Throw
    {
        if (timer == 15)
        {
            image_index = 2;
            var i; i = instance_create(x + image_xscale * 16, spriteGetYCenter(), objPicket);
            i.image_xscale = image_xscale; // shoot
            bullet += 1;
        }
        else if (timer == 30)
        {
            image_index = 1;
            timer = 0;
            if (bullet >= bulletMax) // reset after passing amount max
            {
                image_index = 0;
                phase = 1;
                bullet = 0;
            }
        }
    }
}
else if (dead)
{
    timer = 0;
    phase = 1;
    bullet = 0;
    image_index = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// if image_index == 0 (frame with shield being up), reflect the bullets
if (image_index == 0)
{
    other.guardCancel = 1;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// jump in from side

event_inherited();

if (spawned && jumpsIn && respawn)
{
    y -= 16;
    yspeed = -3;

    if (x < view_xview[0] + view_wview[0] / 2)
    {
        x = view_xview[0] - 8;
    }
    else
    {
        x = view_xview[0] + view_wview[0] + 8;
    }

    blockCollision = false;

    xspeed = xSpeedAim(x, y, xstart, ystart);
    if (shootAmountMax == 0)
    {
        shootAmountMax = choose(5, 10);
    }
}
