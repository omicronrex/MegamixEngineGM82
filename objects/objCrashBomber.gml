#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

grav = 0;

image_speed = 0;
stopOnFlash = false;

contactDamage = 4;

var spd;
spd = 6;
cooldownTimer = 32;

// dang Slight Difference In The Code From aimAtTarget....once again foiled
if (instance_exists(target))
{
    var angle;
    angle = point_direction(spriteGetXCenter(), spriteGetYCenter(),
        spriteGetXCenterObject(target),
        spriteGetYCenterObject(target));

    xspeed = cos(degtorad(angle)) * spd;
    yspeed = -sin(degtorad(angle)) * spd;
}
else
{
    xspeed = spd;
    yspeed = spd;
}

reflectable = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    if (xspeed != 0)
    {
        image_xscale = sign(xspeed);
    }

    if (ycoll != 0 && sprite_index != sprCrashBombArmed)
    {
        playSFX(sfxCrashBombArm);
        xspeed = 0;
        yspeed = 0;
        sprite_index = sprCrashBombArmed;
    }

    if (sprite_index == sprCrashBombArmed)
    {
        image_index += 0.125;
        cooldownTimer -= 1;
        if (cooldownTimer <= 0)
        {
            // visible = false;
            if (cooldownTimer mod 8 == 0)
            {
                playSFX(sfxEnemyHit);//playSFX(sfxCrashBomb);
                var i;
                d = choose(1, -1);
                t = irandom(45) * -d;
                for (i = 0; i < 4; i += 1)
                {
                    t += irandom_range(45, 90) * sign(d);
                    expl = instance_create(x, y, objHarmfulExplosion);
                    expl.stopOnFlash = false;
                    expl.sprite_index = sprCrashExplosion;
                    expl.contactDamage = 4;
                    with (expl)
                    {
                        direction = other.t;
                        rotationMovement(x, y, irandom_range(8, 20), 0);
                    }
                }
            }
        }
        if (cooldownTimer <= -64)
            instance_destroy();
    }
}
