#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 3;

contactDamage = 3;

imgIndex = 0;

penetrate = 0;
pierces = 1;

playSFX(sfxBusterCharged);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    imgIndex += 0.5;
}

image_index = floor(imgIndex);
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!dead)
{
    draw_sprite_ext(sprite_index, round(image_index), round(x), round(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);

    if (round(image_index) == 2)
    {
        if (sprite_index == sprBusterShotChargedPlus)
        {
            spr = sprBusterShotChargedPlusColourMask;
        }
        else
        {
            spr = sprBusterShotChargedColourMask;
        }

        draw_sprite_ext(spr, 0, round(x), round(y), image_xscale, image_yscale, image_angle, global.secondaryCol[0], image_alpha);
        draw_sprite_ext(spr, 1, round(x), round(y), image_xscale, image_yscale, image_angle, global.primaryCol[0], image_alpha);
    }
}
