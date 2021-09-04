#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

yLowOffset = 8;
canHit = false;

hatch1 = noone;

/* hatch1Index = 0;
hatch1IFrames = 0;
hatch1Health = 14 ;*/

hatch2 = noone;

/* hatch2Index = 0;
hatch2IFrames = 0;
hatch2Health = 14 ;*/
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// Creating hatches at the start of the fight.
if (!global.frozen)
{
    if (isIntro)
    {
        if (!instance_exists(hatch1))
        {
            hatch1 = instance_create(x + 18 * image_xscale, y + 49 * image_yscale,
                objSharkSubmarineBodyHatch);
            hatch1.bodyShark = id;
            hatch1.healthpointsStart = healthpoints / 2;
            hatch1.healthpoints = hatch1.healthpointsStart;
            hatch1.respawn = false;

            /* hatch1.xOffset = 18;
            hatch1.yOffset = 49 ;*/
        }
        if (!instance_exists(hatch2))
        {
            hatch2 = instance_create(x + 208 * image_xscale, y + 49 * image_yscale,
                objSharkSubmarineBodyHatch);
            hatch2.bodyShark = id;
            hatch2.healthpointsStart = healthpoints / 2;
            hatch2.healthpoints = hatch2.healthpointsStart;
            hatch2.respawn = false;

            /* hatch2.xOffset = 208;
            hatch2.yOffset = 49 ;*/
        }
    }
}

if (isFight && !killed) // Keeping track of health.
{
    healthpoints = 0;
    if (instance_exists(hatch1))
    {
        healthpoints += hatch1.healthpoints;
    }
    if (instance_exists(hatch2))
    {
        healthpoints += hatch2.healthpoints;
    }
}

// Attack pattern.
if (entityCanStep() && !killed && !stop)
{
    if (isFight)
    {
        if (healthpoints <= 0)
        {
            event_user(EV_DEATH);
        }

        attackTimer++;
        if (attackTimer >= 90) // Gives the signal to launch a dolphin.
        {
            attackTimer = 0;
            if (instance_exists(hatch1))
            {
                if (instance_exists(hatch2))
                {
                    if (irandom(1) == 0)
                    {
                        hatch1.timer = 0;
                    }
                    else
                    {
                        hatch2.timer = 0;
                    }
                }
                else
                {
                    hatch1.timer = 0;
                }
            }
            else
            {
                if (instance_exists(hatch2))
                {
                    hatch2.timer = 0;
                }
            }
        }
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (objSharkSubmarineDolphin)
{
    instance_create(x, y, objExplosion);
    instance_destroy();
}
event_inherited();
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
            x + 49 * image_xscale, round(y) - 45 * image_yscale, image_xscale,
            image_yscale, image_angle, image_blend, image_alpha);
        draw_sprite_ext(sprSharkSubmarineWingJet, jetIndex,
            x - 10 * image_xscale, round(y) + 61 * image_yscale, image_xscale,
            image_yscale, image_angle, image_blend, image_alpha);
        draw_sprite_ext(sprSharkSubmarineWingJet, jetIndex,
            x - 18 * image_xscale, round(y) + 45 * image_yscale, image_xscale,
            image_yscale, image_angle, image_blend, image_alpha);
        draw_sprite_ext(sprSharkSubmarineUpperJet, jetIndex,
            x + 77 * image_xscale, round(y) - 78 * image_yscale, image_xscale,
            image_yscale, image_angle, image_blend, image_alpha);
        draw_sprite_ext(sprSharkSubmarineUpperJet, jetIndex,
            x + 85 * image_xscale, round(y) - 101 * image_yscale, image_xscale,
            image_yscale, image_angle, image_blend, image_alpha);
    }
    if (isFight || killed)
    {
        if (!instance_exists(hatch1))
        {
            draw_sprite_ext(sprSharkSubmarineBodyHatch, 3,
                x + 18 * image_xscale, round(y) + 49 * image_yscale,
                image_xscale, image_yscale, image_angle, image_blend, image_alpha);
        }
        if (!instance_exists(hatch2))
        {
            draw_sprite_ext(sprSharkSubmarineBodyHatch, 3,
                x + 208 * image_xscale, round(y) + 49 * image_yscale,
                image_xscale, image_yscale, image_angle, image_blend, image_alpha);
        }
    }
    else if (!isFight)
    {
        if (!instance_exists(hatch1))
        {
            draw_sprite_ext(sprSharkSubmarineBodyHatch, 0,
                x + 18 * image_xscale, round(y) + 49 * image_yscale,
                image_xscale, image_yscale, image_angle, image_blend, image_alpha);
        }
        if (!instance_exists(hatch2))
        {
            draw_sprite_ext(sprSharkSubmarineBodyHatch, 0,
                x + 208 * image_xscale, round(y) + 49 * image_yscale,
                image_xscale, image_yscale, image_angle, image_blend, image_alpha);
        }
    }
}
else
{
    draw_sprite_ext(sprSharkSubmarineTailJet, jetIndex,
        x + 49 * image_xscale, round(y) - 45 * image_yscale, image_xscale,
        image_yscale, image_angle, image_blend,
        1 - ((floor(introTimer / (30 / 2)) * (30 / 2)) / 30) / 2);
    draw_sprite_ext(sprSharkSubmarineWingJet, jetIndex,
        x - 10 * image_xscale, round(y) + 61 * image_yscale, image_xscale,
        image_yscale, image_angle, image_blend,
        1 - ((floor(introTimer / (30 / 2)) * (30 / 2)) / 30) / 2);
    draw_sprite_ext(sprSharkSubmarineWingJet, jetIndex,
        x - 18 * image_xscale, round(y) + 45 * image_yscale, image_xscale,
        image_yscale, image_angle, image_blend,
        1 - ((floor(introTimer / (30 / 2)) * (30 / 2)) / 30) / 2);
    draw_sprite_ext(sprSharkSubmarineUpperJet, jetIndex,
        x + 77 * image_xscale, round(y) - 78 * image_yscale, image_xscale,
        image_yscale, image_angle, image_blend,
        1 - ((floor(introTimer / (30 / 2)) * (30 / 2)) / 30) / 2);
    draw_sprite_ext(sprSharkSubmarineUpperJet, jetIndex,
        x + 85 * image_xscale, round(y) - 101 * image_yscale, image_xscale,
        image_yscale, image_angle, image_blend,
        1 - ((floor(introTimer / (30 / 2)) * (30 / 2)) / 30) / 2);
}
