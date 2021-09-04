#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 12;
healthpoints = healthpointsStart;
contactDamage = 6;

category = "bulky";

facePlayerOnSpawn = true;

// Enemy specific code
animTimer = 0;
animFrame = 0;
animOffset = 0;
timer = 0;
phase = 0;
shootCount = 0;
phaseRepeatCount = 0;
prevPhase = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (instance_exists(target))
    {
        if (abs(target.x - x) > 8)
        {
            calibrateDirection();
        }
    }

    animFrame += 0.2;
    var didLoop = false;
    if (floor(animFrame) > 1)
    {
        animFrame = 0;
        didLoop = true;
    }

    switch (phase)
    {
        case 0: // Idle: choose an attack
            if (timer == 0 && prevPhase == 0)
                phaseRepeatCount = 0;
            timer += 1;
            animOffset = 0;
            if (timer > 60)
            {
                phase = irandom(1) + 1;
                if (phase == prevPhase && prevPhase != 0)
                {
                    phaseRepeatCount += 1;
                    if (phaseRepeatCount > 1)
                    {
                        phaseRepeatCount = 0;
                        if (phase == 1)
                            phase = 2;
                        else
                            phase = 1;
                    }
                }
                if (phase == 1)
                    animFrame = 0;
                prevPhase = phase;
                timer = 0;
                shootCount = 0;
            }
            break;
        case 1: // aim and shoot
            if (timer > 16)
            {
                if (animOffset != 4)
                {
                    animOffset = 4;
                    didLoop = false;
                    animFrame = 0;
                }
                if (didLoop)
                {
                    animFrame = 1;
                    var i = instance_create(x, y - 64, objEnemyBullet);
                    i.sprite_index = sprTotemPolenProjectile;
                    i.blockCollision = false;
                    i.grav = 0.25;
                    i.yspeed = -5;
                    i.contactDamage = 2;
                    animFrame = 1;
                    if (instance_exists(target))
                    {
                        i.xspeed = xSpeedAim(i.x, i.y, target.x, target.y, i.yspeed, i.grav, 2.65);
                    }
                    timer = 0;
                    shootCount += 1;
                    if (shootCount == 3)
                    {
                        phase = 0;
                    }
                }
            }
            else
            {
                timer += 1;
                animOffset = 0;
            }
            break;
        case 2: // Regular shot
            if (timer > 20)
            {
                var pao = floor(animOffset);
                animOffset += 0.2;
                if (floor(animOffset) > 3 && pao != floor(animOffset))
                {
                    animOffset = 3;
                    shootCount += 1;
                    timer = -1;
                    var i = instance_create(x + 8 * image_xscale, y - 4, objEnemyBullet);
                    i.xspeed = 3.5 * image_xscale;
                    i.contactDamage = 2;
                }
            }
            else if (timer >= 0)
            {
                timer += 1;
                animOffset = 0;
            }
            else if (timer < 0)
            {
                timer -= 1;
                animOffset -= 0.2;
                if (floor(animOffset) < 0)
                {
                    animOffset = 0;
                    timer = 0;
                    if (shootCount == 2)
                    {
                        phase = 0;
                    }
                }
            }
            break;
    }

    image_index = floor(animOffset) * 2 + floor(animFrame);
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
image_index = 0;
animTimer = 0;
animFrame = 0;
actionTimer = 0;
animOffset = 0;
phase = 0;
shootCount = 0;
phaseRepeatCount = 0;
prevPhase = 0;
