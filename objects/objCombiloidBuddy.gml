#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// This enemy can be used without its companion as a stage gimmick.
// creation code (all optional)
// attackTimerMax = <number> // The delay being moving and firing.
// variant = <number> // 0 = both gun and maceball, 1 = gun only, 2 = maceball only.
event_inherited();

respawn = true;

healthpointsStart = 999;
healthpoints = healthpointsStart;
contactDamage = 4;
isTargetable = false;

blockCollision = 1;
grav = 0;

facePlayerOnSpawn = false;

// Enemy specific code
xMin = -9999;
xMax = -9999;
strMMX = -1;
strMMY = -1;
attackTimer = 0;


phase = 0;
child = noone;
partner = noone;

// creation code variables
variant = 0;
attackTimerMax = 64;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    attackTimer+=1;

    if (instance_exists(target))
    {
        strMMX = target.x;
        strMMY = target.y;
    }

    // setup enemy
    if (xMin == -9999)
    {
        if (instance_exists(partner))
        {
            phase = 3;
        }
        var i; for ( i = 0; i < view_wview * 4; i+=1)
        {
            if (!checkSolid(-(48 + i), -32 * image_yscale) || checkSolid(-i, 0))
            {
                xMin = xstart + xMin;
                break;
            }
            else
            {
                xMin = -i;
            }
        }
    }
    if (xMax == -9999)
    {
        var i; for ( i = 0; i < view_wview * 4; i+=1)
        {
            if (!checkSolid(48 + i, -32 * image_yscale) || checkSolid(i, 0))
            {
                xMax = xstart + xMax;
                break;
            }
            else
            {
                xMax = i;
            }
        }
    }
    x = clamp(x, xMin, xMax);

    // phases

    switch (phase)
    {
        case 0: // track mega man
            if (attackTimer > 0)
            {
                spd = 0 - ceil((x - strMMX) / 8);
                if (abs(spd) < 1)
                {
                    if (x < strMMX)
                        x += 1;
                    else if (x > strMMX)
                        x -= 1;
                }
                else
                {
                    xspeed = spd;
                }
            }
            if (attackTimer >= attackTimerMax)
            {
                spd = 0;
                xspeed = 0;
                if (variant == 0)
                {
                    phase = choose(1, 2);
                }
                else
                {
                    phase = clamp(variant, 1, 2);
                }
            }
            break;
        case 1:
        case 2: // create gun or mace
            xspeed = 0;
            if (!instance_exists(child))
            {
                var inst;
                if (phase == 1)
                {
                    inst = instance_create(x, y + 8 * image_yscale, objCombiloidGun);
                }
                else
                {
                    inst = instance_create(x, y + 8 * image_yscale, objCombiloidMace);
                }
                inst.parent = id;
                inst.image_yscale = image_yscale;
                child = inst.id;
            }
            attackTimer = -48;
            break;
        case 4: // come along partner!
            if (instance_exists(partner))
            {
                with (partner)
                {
                    phase = 0;
                }
            }
            else
            {
                phase = 0;
            }
            break;
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_create(x, y + 20, objBigExplosion);
instance_destroy();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 3;
