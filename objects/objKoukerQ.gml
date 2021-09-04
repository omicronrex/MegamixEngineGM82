#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "flying";

grav = 0;
blockCollision = 0;

facePlayerOnSpawn = true;

animTimer = 0;
isFalling = false;

shakeDir = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    animTimer += 1;

    // animation
    if (animTimer == 6)
    {
        if (image_index == 0)
        {
            animTimer = 0;
            image_index = 1;
        }
        else if (image_index == 1)
        {
            animTimer = 0;
            image_index = 0;
        }
        else if (image_index == 2)
        {
            image_index = 3;
        }
    }

    // small pause
    if (animTimer == 20 && !isFalling)
    {
        animTimer = 0;
        if (image_index == 3)
        {
            yspeed = .5;
            playSFX(sfxFallNoise);
            isFalling = true;
        }
    }

    // shaking
    if (animTimer mod 3 == 0 && image_index < 2)
    {
        y += shakeDir;
        shakeDir = -shakeDir;
    }

    // detect target
    if (collision_rectangle(x - 8, y - 512, x + 8, y + 512, target, false,
        true) && xspeed != 0)
    {
        image_index = 2;
        xspeed = 0;
    }

    if (isFalling)
    {
        grav = gravAccel;
    }
}
else if (dead)
{
    animTimer = 0;
    isFalling = false;
    image_index = 0;
    grav = 0;
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
    xspeed = image_xscale;
}
