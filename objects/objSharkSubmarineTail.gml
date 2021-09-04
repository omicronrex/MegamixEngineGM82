#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

yLowOffset = 24;
canHit = true;

missileInterval = 40;

hatchIndex = 0; // The index of the hatch to open.
siloIndex = 0; // The index of the silo to hit.
missile1 = noone;
missile2 = noone;
missile3 = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep() && !killed && !stop)
{
    if (isFight)
    {
        attackTimer++;
        if (attackTimer == missileInterval * 0.25)
        {
            hatchIndex = 1; // Hatch partially open.
            siloIndex = 0; // Silo restocked.
        }
        if (attackTimer == missileInterval * 0.5) // Hatch fully open.
        {
            hatchIndex = 2;
        }
        if (attackTimer == missileInterval * 2) // Silo launches 1st missile.
        {
            siloIndex = 1;
            missile1 = instance_create(x + 7 * image_xscale, y - 9,
                objSharkSubmarineMissile);
            if (image_xscale < 0)
            {
                missile1.aiming = 4;
            }
            missile1.reDirTimer = 0;
        }
        if (attackTimer == missileInterval * 3) // Silo launches 2nd missile.
        {
            siloIndex = 2;
            missile2 = instance_create(x + 7 * image_xscale, y + 7 * image_yscale,
                objSharkSubmarineMissile);
            if (image_xscale < 0)
            {
                missile2.aiming = 4;
            }
            missile2.reDirTimer = 0;
        }
        if (attackTimer == missileInterval * 4) // Silo launches 3rd missile.
        {
            siloIndex = 3;
            missile3 = instance_create(x + 7 * image_xscale, y + 23 * image_yscale,
                objSharkSubmarineMissile);
            if (image_xscale < 0)
            {
                missile3.aiming = 4;
            }
            missile3.reDirTimer = 0;
        }
        if (attackTimer == missileInterval * 5.5) // Hatch partially closed.
        {
            hatchIndex = 1;
        }
        if (attackTimer == missileInterval * 5.75) // Hatch fully closed.
        {
            hatchIndex = 0;
        }

        // The hatch and silo repeat the pattern after all the missiles are gone.
        if (!instance_exists(missile1) && !instance_exists(missile2)
            && !instance_exists(missile3) && attackTimer >= missileInterval * 5.75)
        {
            attackTimer = 0;
        }
    }
}
else if (dead)
{
    hatchIndex = 2;
    siloIndex = 4;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (instance_exists(missile1))
{
    with (missile1)
    {
        instance_create(x, y, objExplosion);
        instance_destroy();
    }
}
if (instance_exists(missile2))
{
    with (missile2)
    {
        instance_create(x, y, objExplosion);
        instance_destroy();
    }
}
if (instance_exists(missile3))
{
    with (missile3)
    {
        instance_create(x, y, objExplosion);
        instance_destroy();
    }
}
event_inherited();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (hatchIndex != 2)
{
    other.guardCancel = 2;
    exit;
}

if (hatchIndex == 2 && collision_rectangle(x - 8 * image_xscale, y - 17, x + 16 * image_xscale, y + 32, other.id, false, true) == noone)
{
    other.guardCancel = 2;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (introTimer <= 0)
{
    if (!killed)
    {
        draw_sprite_ext(sprSharkSubmarineTailJet, jetIndex,
            x + 76 * image_xscale, round(y), image_xscale, image_yscale,
            image_angle, image_blend, image_alpha);
    }

    if (iFrames mod 4 < 2 || !iFrames)
    {
        draw_sprite_ext(sprSharkSubmarineSilo, siloIndex,
            x - 8 * image_xscale, round(y) - 17 * image_yscale,
            image_xscale, image_yscale, image_angle,
            image_blend, image_alpha);
    }
    else
    {
        draw_sprite_ext(sprSharkSubmarineSilo, siloIndex,
            x - 8 * image_xscale, round(y) - 17 * image_yscale,
            image_xscale, image_yscale, image_angle,
            c_black, image_alpha);
    }
    draw_sprite_ext(sprSharkSubmarineTailHatch, hatchIndex,
        x - 8 * image_xscale, round(y) - 17 * image_yscale, image_xscale,
        image_yscale, image_angle, image_blend, image_alpha);
}
else
{
    if (!killed)
    {
        draw_sprite_ext(sprSharkSubmarineTailJet, jetIndex,
            x + 76 * image_xscale, round(y), image_xscale, image_yscale,
            image_angle, c_black,
            1);
        draw_sprite_ext(sprSharkSubmarineTailJet, jetIndex,
            x + 76 * image_xscale, round(y), image_xscale, image_yscale,
            image_angle, image_blend,
            1 - ((floor(introTimer / (30 / 2)) * (30 / 2)) / 30) / 2);
    }
    draw_sprite_ext(sprSharkSubmarineTailHatch, hatchIndex,
        x - 8 * image_xscale, round(y) - 17 * image_yscale, image_xscale,
        image_yscale, image_angle, c_black,
        1);
    draw_sprite_ext(sprSharkSubmarineTailHatch, hatchIndex,
        x - 8 * image_xscale, round(y) - 17 * image_yscale, image_xscale,
        image_yscale, image_angle, image_blend,
        1 - ((floor(introTimer / (30 / 2)) * (30 / 2)) / 30) / 2);
}
