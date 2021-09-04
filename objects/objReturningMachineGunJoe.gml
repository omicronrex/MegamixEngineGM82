#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
contactDamage = 3;
healthpointsStart = 6;
facePlayerOnSpawn = true;
category = "joes,shielded";

// enemy specific code
phase = 0;
shotCount = 0;
timer = 0;
shieldDamageCount = 0;
shieldDPS = 5;
dpsTimer = 0;
isBouncy = false;
color = 0;
hasShield = true;
grav = 0.25 * image_yscale;

animFrame = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (dpsTimer > 0)
{
    dpsTimer -= 1;
    if (dpsTimer == 0)
        shieldDamageCount = 0;
}
if (entityCanStep())
{
    if (phase != 1 && floor(animFrame != 2) && (phase != 0 || (phase == 0 && timer < 90 && timer != -1)))
    {
        if (ground && yspeed == 0 && instance_exists(target) && abs(target.x - x) < 16)
        {
            yspeed = -5.5 * image_yscale;
        }
    }
    if (!ground && sign(yspeed) != image_yscale)
    {
        calibrateDirection();
    }
    if (phase == 0) // wait before shooting
    {
        if (timer >= 0)
            timer += 1;
        if (timer > 120 && ground)
        {
            timer = -1;
            yspeed = 0;
        }
        else if (timer == -1)
        {
            if (floor(animFrame) < 2)
            {
                animFrame += 0.15;
                if (floor(animFrame) >= 2)
                {
                    shotCount = 0;
                    phase = 1;
                    timer = 10;
                }
            }
        }
    }
    else if (phase == 1) // Shoot 6 bullets, waiting every three bullets
    {
        calibrateDirection();
        if (timer > 0)
            timer -= 1;
        if (timer == 0)
        {
            playSFX(sfxEnemyShootClassic);
            var i; i = instance_create(x + image_xscale * 16, y - image_yscale * 10, objEnemyBullet);
            i.sprite_index = sprReturningMachinegunJoeBullet;
            i.image_index = min(1, color);
            i.image_xscale = image_xscale;
            i.xspeed = 3 * image_xscale;
            timer = 10;
            shotCount += 1;
            if ((shotCount mod 3) == 0)
            {
                timer = 30;
            }
            if ((shotCount mod 6) == 0)
            {
                timer = -1;
            }
        }
        else if (timer == -1)
        {
            animFrame -= 0.15;
            if (floor(animFrame) <= 0)
            {
                animFrame = 0;
                timer = 0;
                phase = 2;
            }
        }
    }
    else if (phase == 2) // Cool down after 6 shots
    {
        timer += 1;
        if (timer > 60)
        {
            if (shotCount == 6)
            {
                if (floor(animFrame) < 2)
                {
                    animFrame += 0.15;
                    if (floor(animFrame) >= 2)
                    {
                        animFrame = 2;
                    }
                }
                if (floor(animFrame) == 2 && ground)
                {
                    phase = 1;
                    timer = 10;
                }
            }
            else
            {
                if (sign(ycoll) == image_yscale)
                {
                    phase = 0;
                    timer = 0;
                    shotCount = 0;
                }
                else if (ground)
                {
                    yspeed = -5.5 * image_yscale;
                }
            }
        }
    }
    else if (phase == 3)
    {
        animFrame = 3;
        timer += 1;
        if (timer > 24)
        {
            phase = 0;
            phase = 0;
            shotCount = 0;
            timer = 0;
            shieldDamageCount = 0;
            dpsTimer = 0;
            animFrame = 0;
        }
    }


    if (floor(animFrame) >= 3)
    {
        image_index = 12 + 13 * color;
    }
    else
    {
        image_index = 3 * (!ground) + floor(animFrame) + 13 * color + 6 * !hasShield;
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (floor(animFrame) > 0)
    exit;
if (!hasShield)
    exit;
var front; front = bbox_right;
if (image_xscale == -1)
    front = bbox_left;
if (collision_rectangle(x + 8 * image_xscale, bbox_top, front, bbox_bottom, other, true, true))
{
    other.guardCancel = 1;
    if (dpsTimer == 0)
        dpsTimer = 60;
    shieldDamageCount += 1;
    if (shieldDamageCount >= shieldDPS)
    {
        phase = 3;
        hasShield = false;
        var i; i = instance_create(x, y, objReturningMachinegunJoeShield);
        i.image_xscale = image_xscale;
        i.image_index = min(1, color);
        i.xspeed = -1 * image_xscale;
        i.yspeed = -4;
        timer = 0;
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
phase = 0;
shotCount = 0;
timer = 0;
shieldDamageCount = 0;
dpsTimer = 0;
hasShield = true;
grav = 0.25 * image_yscale;

animFrame = 0;
