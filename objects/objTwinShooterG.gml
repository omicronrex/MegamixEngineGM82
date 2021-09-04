#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// image_xscale = 1 or -1 //(Use editor for this!!) determines starting direction of mini boss.

event_inherited();
respawn = true;
introSprite = sprTwinShooterGTeleport;
healthpointsStart = 20;
healthpoints = healthpointsStart;
contactDamage = 5;
blockCollision = 0;
grav = 0;
category = "cannons, floating";

image_speed = 0;

// Enemy specific code
init = true;
shotsFired = 0;
storeXScale = image_xscale;
setSide = 0;
yMax = 0;
phase = 0;
attackTimer = 0;
attackTimerMax = 8;
bullet = noone;

// creation code variables

// setting up movement pattern:
// first variable in an array position is which direction it moves
// second variable is which gun fires.
// 1 = down, -1 = up
// third variable is how far the boss moves on this phase.
pattern[0, 0] = 1;
pattern[0, 1] = 1;
pattern[0, 2] = 32;
pattern[1, 0] = 1;
pattern[1, 1] = 1;
pattern[1, 2] = 48;
pattern[2, 0] = -1;
pattern[2, 1] = -1;
pattern[2, 2] = 48;
pattern[3, 0] = 1;
pattern[3, 1] = -1;
pattern[3, 2] = 32;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep()
    && introTimer <= 0)
{
    if (init)
    {
        init = false;
        for (var i = 32; i < view_hview; i += 1)
        {
            if (place_meeting(x, y + i, objSolid) || y + i >= (view_yview + view_hview) - 32)
            {
                break;
            }
            else
            {
                yMax = i;
            }
        }
        var hasCol = false;
        for (var i = round(view_wview / 2); i < view_wview; i += 1)
        {
            if (!place_meeting(x + ((16 + i) * image_xscale), y, objSolid))
            {
                hasCol = true;
            }
            if (hasCol && place_meeting(x + ((16 + i) * image_xscale), y, objSolid) || image_xscale == 1 && x + i >= (view_xview + view_wview) - 16 || image_xscale == -1 && x + i <= view_xview + 16)
            {
                break;
            }
            else
            {
                setSide = i;
            }
        }
        mask_index = sprite_index;
    }
    if (storeXScale == 0)
        storeXScale = image_xscale;
    attackTimer++;
    switch (phase)
    {
        case 0:
            image_index = 3;
            if (attackTimer == attackTimerMax)
            {
                phase++;
                attackTimer = 0;
            }
            break;
        case 1:
            if (!instance_exists(objTwinShooterGLaser))
            {
                if (pattern[shotsFired, 1] == 1)
                {
                    image_index = 0 + (floor(attackTimer / 4) mod 2) * 2;
                }
                else
                {
                    image_index = 0 + (floor(attackTimer / 4) mod 2);
                }
                yspeed = 1 * pattern[shotsFired, 0];
                if (attackTimer >= pattern[shotsFired, 2])
                {
                    phase++;
                }
            }
            else
            {
                image_index = 0;
                attackTimer = 0;
            }
            break;
        case 2:
            yspeed = 0;
            var inst = instance_create(x + 8 * image_xscale, y + pattern[shotsFired, 1] * 16, objTwinShooterGLaser);
            inst.expand = image_xscale;
            inst.image_xscale = image_xscale;
            shotsFired++;
            if (shotsFired >= array_height_2d(pattern))
            {
                phase = 9;
                shotsFired = 0;
            }
            else
            {
                attackTimer = 0;
                phase = 1;
            }
            break;
        case 9:
            playSFX(sfxCentaurTeleport);
            phase = 10;
            canHit = false;
            attackTimer = 0;
            break;
        case 10:
            image_index = 4 + attackTimer mod 2;
            if (attackTimer >= 32)
            {
                phase = 11;
            }
            break;
        case 11:
            aimDir = 1;
            if (image_xscale == -1)
            {
                aimDir = -1;
            }
            if (image_xscale == 1)
            {
                aimDir = 1;
            }
            x = x + setSide * aimDir;
            image_xscale *= -1;
            attackTimer = 0;
            y = ystart;
            mask_index = sprite_index;
            canHit = true;
            phase = 0;
            break;
    }
}
else if (!insideView())
{
    image_index = 0;
    y = ystart;
    x = xstart;
    if (storeXScale != 0)
    {
        image_xscale = storeXScale;
    }

    // shootTimer = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (phase >= 10)
{
    other.guardCancel = 2;
}
else
{
    if (!(bboxGetYCenterObject(other.id) > y - 16) || !(bboxGetYCenterObject(other.id) < y + 16))
    {
        other.guardCancel = 1;
    }
}
