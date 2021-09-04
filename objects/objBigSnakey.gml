#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = true;

healthpointsStart = 10;
healthpoints = healthpointsStart;
contactDamage = 8;
category = "nature";

//@cc neck length
length = 3;

// Enemy specific code
shootCounter = 0;
shootTimer = 0;
blink = 0;
blinkTimer = 0;
endTimer = 60;
doesIntro = false;

bodySolid = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (shootTimer == 0)
    {
        image_index = 0;
    }
    if (shootTimer == endTimer)
    {
        image_index = 1;
        instance_create(x + 32 * image_xscale, y - 16 * image_yscale, objBigSnakeyFire);
        if (shootCounter < 2)
        {
            shootCounter += 1;
            shootTimer -= 20;
        }
    }

    // image_index += 0.1;
    shootTimer += 1;
    if (shootTimer >= endTimer * 1.5)
    {
        shootTimer = 0;
        shootCounter = 0;
    }
    blinkTimer += 1;
    if (blinkTimer >= 5)
    {
        if (blink < 1)
            blink += 1 / 30;
        else
            blink += 1;
        if (blink >= 4)
            blink = 0;
        blinkTimer = 0;
    }

    if (!instance_exists(bodySolid) && length > 0)
    {
        bodySolid = instance_create(x - 16, y, objSolid);
        bodySolid.image_xscale = 2;
        bodySolid.image_yscale = length;
        bodySolid.depth = 1000;
    }
}
else
{
    if (instance_exists(bodySolid))
    {
        with (bodySolid)
        {
            instance_destroy();
        }
    }
    if (!insideView())
    {
        image_index = 0;
        shootTimer = 0;
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// event_inherited();

if (iFrames == 1 || iFrames == 3)
{
    d3d_set_fog(true, c_white, 0, 0);
}

drawSelf();
if (floor(blink) > 0)
{
    draw_sprite_ext(sprite_index, 1 + floor(blink) - (floor(blink / 3) * 2),
        round(x), round(y), image_xscale, image_yscale, image_angle,
        image_blend, image_alpha);
}
if (length > 0)
{
    for (i = 1; i <= length; i += 1)
    {
        draw_background_part(tstSnakeman, 0, 32, 32, 16, round(x) - 16,
            round(y) + (i - 1) * 16);
    }
}

if (iFrames == 1 || iFrames == 3)
{
    d3d_set_fog(false, 0, 0, 0);
}
