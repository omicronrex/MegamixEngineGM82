#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Randomly chooses between launching missiles or dropping spike balls

event_inherited();

respawn = true;

healthpointsStart = 14;
healthpoints = healthpointsStart;
contactDamage = 6;
category = "aquatic, bulky";
grav = 0;

// Enemy specific code
dir = image_xscale;
init = 1;

introSprite = sprMobbyIntro;
shootTimer = 0;
flipperIndex = 0;
flipDir = 1;
blink = false;
blinkTimer = 0;
yspeed = -0.1;

image_speed = 0.15;

attack = choose(0, 1);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep() && introTimer <= 0)
{
    if (!instance_exists(objMobbyBomb))
        shootTimer += 1;
    else
    {
        with (objMegaman)
        {
            playerBlow((1 / 2)*sign(-other.image_xscale));//1/4
        }
    }
    blinkTimer += 1;

    if (blinkTimer == 120)
        blink = true;

    if (blinkTimer == 130)
    {
        blink = false;
        blinkTimer = 0;
    }

    if (!instance_exists(objMobbyBomb))
        y += yspeed;
    if (y < ystart - 8)
        yspeed = abs(yspeed);
    if (y >= ystart)
        yspeed = -abs(yspeed);
    flipperIndex += flipDir * 0.1;
    if (flipperIndex <= 0.1)
        flipDir = 1;
    if (flipperIndex >= 3 - 0.1)
        flipDir = -1;

    if (shootTimer == floor(shootTimer / 60) * 60)
    {
        if (attack == 0)
        {
            myAttack = instance_create(x + 38 * image_xscale, y + 20,
                objMobbyMissle);
            myAttack.image_xscale = image_xscale;
            myAttack.xspeed = myAttack.spd * image_xscale;
        }
        else
        {
            for (i = 0; i <= 3; i += 1)
            {
                myAttack = instance_create(x - 8 * image_xscale, y - 32,
                    objMobbyBomb);
                myAttack.getX = x + (40 + (i * 40)) * image_xscale;
            }
            shootTimer += 1;
        }
        myAttack.image_xscale = image_xscale;
        if (attack == 0)
            attack = choose(0, 1);
        else
            attack = 0;
    }
}
else if (!insideView())
{
    calibrateDirection();
    image_index = 0;
    shootTimer = 0;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Glow white when hit
if (iFrames == 1) || (iFrames == 3)
{
    d3d_set_fog(true, c_white, 0, 0);
}

// Draw code
if (introTimer > 0 && doesIntro)
{
    event_inherited();
}
else
{
    // Draw air suction
    if (instance_exists(objMobbyBomb))
    {
        draw_sprite_ext(sprMobbyAir, image_index, round(x + 42 * image_xscale),
            round(y + 17), image_xscale, image_yscale, image_angle,
            image_blend, image_alpha);
    }

    // Draw self
    draw_sprite_ext(sprite_index, image_index mod 2, round(x), round(y),
        image_xscale, image_yscale, image_angle, image_blend, image_alpha);

    // Draw flipper
    draw_sprite_ext(sprite_index, floor(flipperIndex + 2), round(x), round(y),
        image_xscale, image_yscale, image_angle, image_blend, image_alpha);

    // Draw blinking
    if (blink)
    {
        draw_sprite_ext(sprite_index, 5, round(x), round(y), image_xscale,
            image_yscale, image_angle, image_blend, image_alpha);
    }
}

// End white when hit
if (iFrames == 1) || (iFrames == 3)
{
    d3d_set_fog(false, 0, 0, 0);
}
