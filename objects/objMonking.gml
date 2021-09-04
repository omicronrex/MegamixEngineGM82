#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=objMonking
*/
/// This enemy will fly up until it reaches a platform, after some time or if megaman gets close,
// it will jump on the platform and jump towards megaman
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "nature, primate";

blockCollision = 0;
grav = 0;

facePlayerOnSpawn = true;

// Enemy specific code
hasPopped = false;
onBlock = false;
animTimer = 0;
hangCountdown = 120;

jumpTimer = 0;

despawnRange = 48;

contactStart = contactDamage;
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
    // Appears
    if (!hasPopped && instance_exists(target) && collision_rectangle(x - 64, y - 224, x + 64, y + 224, target, false, true))
    {
        calibrateDirection();
        hasPopped = true;
        image_index = 0;
        yspeed = -3;
        canDamage = true;
        canHit = true;
    }
    else
    {
        if (!onBlock && checkSolid(0, -7) /* collision_rectangle(x, y - 8, x, y - 7, objSolid,false, true )*/ && hangCountdown == 120)
        {
            onBlock = true;
            yspeed = 0;
            sprite_index = sprMonkingSwing;
            image_speed = 0.1;
        }
    }

    // Swing on block
    if (onBlock)
    {
        if (hangCountdown)
        {
            hangCountdown -= 1;
        }
        if (hangCountdown <= 0)
        {
            calibrateDirection();
            animTimer = 0;
            sprite_index = sprMonking;
            image_speed = 0;
            image_index = 0;
            onBlock = false;
            grav = 0.25;
            xspeed = image_xscale;
            yspeed = -6;
        }
    }

    if (!blockCollision)
    {
        if (hangCountdown <= 0 && !onBlock && yspeed > 0)
        {
            blockCollision = 1;
        }
    }
    else
    {
        if (ground)
        {
            if (yspeed == 0)
            {
                xspeed = 0;
                image_index = 1;
            }


            if (sprite_index != sprMonking)
            {
                sprite_index = sprMonking;
                image_speed = 0;
            }


            jumpTimer += 1;
            if (jumpTimer >= 60)
            {
                calibrateDirection();
                jumpTimer = 0;
                yspeed = -4;
                xspeed = image_xscale;
            }
        }
        else
        {
            image_index = 0;
        }
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn
event_inherited();
hasPopped = false;
onBlock = false;
hangCountdown = 120;
blockCollision = false;
jumpTimer = 0;
animTimer = 0;
grav = 0;
image_index = 0;
sprite_index = sprMonking;
image_speed = 0;
canHit = false;
canDamage = false;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (hasPopped)
{
    event_inherited();
}
