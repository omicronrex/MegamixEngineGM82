#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A big fire breathing dragon that that moves in a wave.
// Note: his creation code variables for his movement have no unit, they're just proportional
event_inherited();
respawn = true;
introSprite = sprChangkeyDragonEyes;
healthpointsStart = 15;
healthpoints = healthpointsStart;
contactDamage = 3;
grav = 0;
doesIntro = false;
blockCollision = false;
facePlayerOnSpawn = true;
despawnRange = -1;
xspeed = 0;
yspeed = 0;

category = "fire, flying";

sprite_index = sprChangkeyDragonHead;
// Enemy-specific code

// Customizable Constants

//@cc how wide his movement looks
waveWidth = 28;

//@cc How low he reaches
waveHeight = 48;

//@cc the horizontal speed of the dragon
waveSpeed = 1.45;

//@cc Interval between shots
shootTime = 26;

introTimer = 60;
dir = image_xscale;
attackTimer = 60;

sineCounter = 0;
sineCounter2 = 0;
canFlip = true;
introDone = false;
changkeyNumber = 0;
canRegen = true;

shootTimer = 30;

animTimer = 10;
shootLimit = 0;
_hitTimer = 0;
lastXscale = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    introTimer-=1;
    if (introTimer == 0)
    {
        introDone = true;
        canHit = true;
    }
    if (introDone == true)
    {
        if (!instance_exists(objChangkeyDragonMask))
        {
            var mask; mask = instance_create(x, y, objChangkeyDragonMask);
            mask.contactDamage = contactDamage;
            mask.parent = id;
        }

        xspeed = waveSpeed * image_xscale;
        sineCounter += (pi * 2) / ((pi * 2) / (waveSpeed / waveWidth));
        sineCounter2 += 0.27;
        yspeed = (sin(sineCounter) * waveSpeed * (waveHeight / waveWidth));

        if (_hitTimer > 0)
        {
            _hitTimer -= 1;
        }

        if ((changkeyNumber != 6) && (canRegen == true))
        {
            var i;
            var oy1; oy1 = 5;
            var oy2; oy2 = 10;
            var oy3; oy3 = 0;
            for (i = 0; i < 6; i+=1)
            {
                var fire; fire = instance_create(x - 30 * image_xscale, y - 14, objChangkeyDragonTackleFire);
                switch (i)
                {
                    case 0:
                        fire.offsetX = 28;
                        fire.offsetY = 3;
                        break;
                    case 1:
                        fire.offsetX = 44;
                        fire.offsetY = 11;
                        break;
                    case 2:
                        fire.offsetX = 60;
                        fire.offsetY = 11;
                        break;
                    case 3:
                        fire.offsetX = 76;
                        fire.offsetY = 3;
                        break;
                    case 4:
                        fire.offsetX = 92;
                        fire.offsetY = -5;
                        break;
                    case 5:
                        fire.offsetX = 108;
                        fire.offsetY = -5;
                        break;
                }
                fire.parent = id;
                fire.index = i;
                var tail; tail = instance_create(x, y, objChangkeyDragonTailFire);
                tail.offsetX = 144;
                tail.offsetY = 8;
                tail.parent = id;

                changkeyNumber = 6;
                canRegen = false;
            }
        }

        if (image_index == 1)
        {
            animTimer-=1;
            if (animTimer == 0)
            {
                image_index = 0;
                animTimer = 14;
            }
        }

        // Turn around when going offscreen
        if ((x <= view_xview - 145) || (x >= view_xview + view_wview + 145))
        {
            shootTimer = shootTime - 5;
            shootLimit = 0;
            if ((canRegen == false) && (changkeyNumber != 6))
            {
                canRegen = true;
            }
            if (canFlip == true)
            {
                image_xscale *= -1;
                canFlip = false;
                if (image_xscale == -1)
                {
                    x -= 90;
                }
                else if (image_xscale == 1)
                {
                    x += 90;
                }
            }
        }
        else
        {
            canFlip = true;

            // Fire
            shootTimer-=1;
            if ((shootTimer <= 0) && (shootLimit < 3) && (instance_exists(objChangkeyDragonTackleFire)))
            {
                var shot; shot = instance_create(x, y, objChangkeyDragonFire);
                shot.xspeed = 3.5 * image_xscale;
                if (shootLimit mod 2)
                    shot.yspeed = 3;
                else
                    shot.yspeed = 4.5;
                playSFX(sfxChangkeyDragonBreath);
                image_index = 1;
                shootTimer = 60;
                shootLimit += 1;
            }
        }
    }
    lastXscale = image_xscale;
}
else if (dead)
{
    image_xscale = lastXscale;
    canFlip = false;
}
#define Other_19
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Got hit

event_inherited();
_hitTimer = 10;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

/// spawn
canHit = false;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (iFrames == 1 || iFrames == 3)
{
    d3d_set_fog(true, c_white, 0, 0);
}


if (introDone == true)
{
    var ox; ox = cos(sineCounter2 + 0.5);
    var oy; oy = sin(sineCounter2 + 0.5);
    if (image_index == 1)
    {
        ox = -1;
        oy = -2;
    }

    // Right Arm
    draw_sprite_ext(sprChangkeyDragonLimbs, 0, (x - 22 * image_xscale) + floor(image_xscale * ox), (y + 10) + floor(oy), image_xscale, image_yscale, image_angle,
        image_blend, image_alpha);

    // Right Leg

    ox = cos(sineCounter2 + 3);
    oy = sin(sineCounter2 + 3);
    if (image_index == 1)
    {
        ox = -1;
        oy = -2;
    }

    draw_sprite_ext(sprChangkeyDragonLimbs, 2, (x - 89 * image_xscale) + floor(image_xscale * ox), (y + 18) + floor(oy), image_xscale, image_yscale, image_angle,
        image_blend, image_alpha);

    // Body
    drawSelf();
    with (objChangkeyDragonTackleFire)
    {
        if (parent == other.id)
        {
            visible = true;
            event_perform(ev_draw, 0);
            visible = false;
        }
    }

    // Left Arm

    ox = cos(sineCounter2 + 5);
    oy = sin(sineCounter2 + 6);
    if (image_index == 1)
    {
        ox = -1;
        oy = -2;
    }

    draw_sprite_ext(sprChangkeyDragonLimbs, 1, (x - 42 * image_xscale) + floor(image_xscale * ox), (y + 6) + floor(oy), image_xscale, image_yscale, image_angle,
        image_blend, image_alpha);

    // Left Leg
    ox = cos(sineCounter2 + 7);
    oy = sin(sineCounter2 + 7);
    if (image_index == 1)
    {
        ox = -1;
        oy = -2;
    }

    draw_sprite_ext(sprChangkeyDragonLimbs, 3, (x - 110 * image_xscale) + floor(image_xscale * ox), (y + 20) + floor(oy), image_xscale, image_yscale, image_angle,
        image_blend, image_alpha);

    // Draw eyes
    if (!dead)
    {
        var frame; frame = 1;
        if (_hitTimer > 0)
            frame = 2;
        if (changkeyNumber <= 3)
            frame = 3;

        draw_sprite_ext(sprChangkeyDragonEyes, frame, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
    }
    else //if ((iFrames > 0) || (dead))
    {
        draw_sprite_ext(sprChangkeyDragonEyes, 2, x, y, image_xscale, image_yscale, image_angle,
            image_blend, image_alpha);
    }
}
else // Intro animation
{
    draw_sprite_ext(sprChangkeyDragonEyes, 0, round(x), round(y), image_xscale, image_yscale, image_angle,
        image_blend, image_alpha);
    draw_sprite_ext(sprite_index, -1, round(x), round(y), image_xscale,
        image_yscale, image_angle, image_blend,
        1 - ((floor(introTimer / (30 / 2)) * (30 / 2)) / 30));
    draw_sprite_ext(sprChangkeyDragonEyes, 1, round(x), round(y), image_xscale,
        image_yscale, image_angle, image_blend,
        1 - ((floor(introTimer / (30 / 2)) * (30 / 2)) / 30));
}

if (iFrames == 1 || iFrames == 3)
{
    d3d_set_fog(false, 0, 0, 0);
}
