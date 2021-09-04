#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
contactDamage = 3;
healthpointsStart = 4;
healthpoints = healthpointsStart;
facePlayerOnSpawn = true;
category = "fire, nature, shielded";

// Enemy specific code
timer = 0;
anim = -1;
animFrame = 0;
animSpeed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Enemy AI
event_inherited();

// Simple animation based enemy, it shoots when it opens and starts over when it closes

if (entityCanStep())
{
    prevAnim = anim;
    if (anim == -1)
        anim = 0;
    if (anim == 0)
    {
        timer += 1;
        if (timer > 40)
        {
            timer = 0;
            anim = 1;
        }
    }
    else if (anim == 1)
    {
        timer += 1;
        if (timer > 40)
        {
            animFrame = 0;
            animSpeed = 0;
        }
        if (timer > 80)
        {
            anim = 2;
            timer = 0;
        }
    }
    else if (anim == 2)
    {
        timer += 1;
        if (timer > 96)
        {
            anim = 3;
            timer = 0;
        }
    }

    /// animation
    if (anim == 0) // blink
    {
        if (prevAnim != anim)
            animFrame = 0;
        animSpeed = 0.15;
    }
    else if (anim == 1) // blink faster
    {
        if (prevAnim != anim)
            animSpeed = 0.3;
    }
    else if (anim == 2) // open
    {
        animSpeed = 0;
        if (prevAnim != anim)
        {
            animFrame = 2;
            event_user(0); // Shoot
        }
    }
    else if (anim == 3) // close
    {
        animSpeed = 0.25;
    }

    animFrame += animSpeed;
    if ((anim == 1 || anim == 0) && floor(animFrame) > 1)
        animFrame = 0;

    image_index = floor(animFrame);
}
#define Other_7
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Start Over
anim = -1;
timer = 0;
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Shoot
var i = instance_create(x, y, objEnemyBullet);
with (i)
{
    sprite_index = sprSola0Beam;
    image_speed = 0.35;
    image_xscale = other.image_xscale;
    image_yscale = other.image_yscale;
    x = other.x;
    y = other.y - 21*image_yscale;;
    blockCollision = false;
    contactDamage = 3;
    xspeed = image_xscale * 4;
}
playSFX(sfxSola0Shoot);
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (anim != 2)
{
    other.guardCancel = 1;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
timer = 0;
anim = -1;
