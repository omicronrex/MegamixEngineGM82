#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "flying, nature";
grav = 0;
imgIndex = 0;

blockCollision = 0;
facePlayerOnSpawn = true;

// Enemy specific code
countDown = 720;
imgSpd = 0.1;
moveSpeed = 0;
accel = 0.1;
phase = 0;
targX = x;
targY = y;
animBack = false;
moveTimer = 60;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // Animation
    if (animBack == false)
    {
        imgIndex += imgSpd;
        if (imgIndex >= 4)
        {
            imgIndex = 3;
            animBack = true;
        }
    }
    else if (animBack == true)
    {
        imgIndex -= imgSpd;
        if (imgIndex < 0)
        {
            imgIndex = 1;
            animBack = false;
        }
    }

    // Movement
    switch (phase)
    {
        case 0:
            if (moveSpeed == 0)
            {
                moveTimer-=1;
                if (moveTimer == 0)
                {
                    calibrateDirection();
                    if (instance_exists(target))
                    {
                        targX = target.x + 16 * image_xscale;
                        targY = target.y;
                    }
                    else
                    {
                        targX = x;
                        targY = y;
                    }
                    phase = 1;
                    imgSpd = 0.5;
                    moveSpeed = 3; // accel;
                }
            }
            break;
        case 1:
            move_towards_point(targX, targY, moveSpeed);
            if ((distance_to_point(targX, targY) < 60) && (moveSpeed > 0))
            {
                moveSpeed -= accel;
                imgSpd = 0.1;
            }
            else if (moveSpeed < 3)
            {
                moveSpeed += 0.5;
            }
            if (moveSpeed == 0)
            {
                phase = 0;
                moveTimer = 60;
                imgSpd = 0.1;
            }
            break;
    }

    // Self destruct after several seconds
    countDown-=1;
    if (countDown == 0)
    {
        dead = true;
        itemDrop = -1;
        i = instance_create(x, y, objHarmfulExplosion);
        i.contactDamage = 6;
        playSFX(sfxMM9Explosion);
    }
}
else if (dead)
{
    healthpoints = healthpointsStart;
    imgIndex = 0;
    phase = 0;
    countDown = 720;
    imgSpd = 0.1;
    moveSpeed = 0;
    targX = x;
    targY = y;
    moveTimer = 60;
    itemDrop = 0;
    animBack = false;
}
image_index = imgIndex div 1;
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if ((other.object_index != objTornadoBlow) && (other.object_index != objBlackHoleBomb))
{
    i = instance_create(x, y, objHarmfulExplosion);
    i.contactDamage = 6;
    playSFX(sfxMM9Explosion);

    if ((other.object_index == objSlashClaw) || (other.object_index == objBreakDash))
    {
        with (objSlashEffect)
        {
            image_alpha = 0;
        }
    }
}
