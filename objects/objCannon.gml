#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A shielded cannon thats only vulnerable while it's shooting
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 6;

category = "cannons, shielded";

facePlayerOnSpawn = true;

// Enemy specific code
phase = 0;
radius = 5 * 16;
shootTimer = 0;

xspeed = 0;
yspeed = 0;

imgSpd = 0.09;
imgIndex = 0;
image_speed = 0;
image_index = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    switch (phase)
    {
        case 0: // face mega man at the start
            if (instance_exists(target))
            {
                phase = 1;
            }
            break;
        case 1: // waiting for megaman
            if (instance_exists(target))
            {
                if (abs(target.x - x) <= radius)
                {
                    phase = 2;
                }
            }
            break;
        case 2: // open up and shoot twice
            if (shootTimer == 20 || shootTimer == 60)
            {
                calibrateDirection();
                ball = instance_create(x + sprite_width / 2,
                    y - sprite_height * 0.8,
                    objCannonBall); // sprite_width is negative when xscale is
                playSFX(sfxCannonShoot);
                imgIndex = 2;
                shootTimer += 1; // so it doesn't loop like a doof
            }
            if (imgIndex < 3)
            {
                imgIndex += imgSpd;
            }
            else
            {
                shootTimer += 1; // only counts up when the cannon is fully open and isn't recoiling
            }
            if (shootTimer >= 70)
            {
                phase = 3;
            }
            break;

        // close & wait a bit until being able to open again
        case 3:
            if (imgIndex > 0)
            {
                imgIndex -= imgSpd;
            }
            else
            {
                shootTimer += 1;
            }
            if (imgIndex < 0)
            {
                imgIndex = 0;
            }
            if (shootTimer >= 150)
            {
                phase = 0;
                shootTimer = 0;
            }
    }
}
else if (dead)
{
    phase = 0;
    shootTimer = 0;
    imgIndex = 0;
}

image_index = imgIndex div 1;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (round(image_index) == 0)
{
    other.guardCancel = 1;
}

if (image_xscale == -1)
{
    if (bboxGetXCenterObject(other.id) > bboxGetXCenter())
    {
        other.guardCancel = 1;
    }
}
else
{
    if (bboxGetXCenterObject(other.id) < bboxGetXCenter())
    {
        other.guardCancel = 1;
    }
}
