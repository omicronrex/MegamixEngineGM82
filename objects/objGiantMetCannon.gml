#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A Giant Met manning a giant cannon (egads, you don't say?!). It can fire either a large
// shot, or a homing missile from the back.

// Creation code (all optional):

event_inherited();
respawn = true;
doesIntro = false;
healthpointsStart = 16;
healthpoints = healthpointsStart;
contactDamage = 0;
blockCollision = 0;
grav = 0;
isSolid = true;

category = "mets, bulky, cannon";

// @cc - Determines if it can shoot homing missiles AND cannon shots.
randomMissiles = false;

// @cc - Use this to make it fire ONLY cannon shots (0) or homing missiles (1)
// THIS WILL NOT WORK IF randomMissiles IS SET TO TRUE
shotType = 0;

// Enemy specific code
image_speed = 0;
image_index = 0;
curYOffset = -24;
yOffsetMax = -24;
cFrame = 0;

// animation offsets
spriteOffset = 8;
bottomPart = y + 48;

phase = 1;
oldPhase = 1;

attackTimer = 0;
attackTimerMax = 246;

delayTimer = 0;
delayTimerMax = 32;

missile1 = noone;
missile2 = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    attackTimer++;

    // to stop the met cannon from crushing a player underneath them, we change its mask
    switch (curYOffset)
    {
        case -20:
            mask_index = mskGiantMetCannon;
            break;
        case -16:
            mask_index = mskGiantMetCannon2;
            break;
        case -8:
            mask_index = mskGiantMetCannon3;
            break;
    }

    switch (phase)
    {
        case 0: // move up
            if (curYOffset > yOffsetMax)
            {
                yspeed = 0;
                curYOffset -= 0.25;
                yspeed = -0.25;
            }
            if (curYOffset == yOffsetMax)
            {
                yspeed = 0;
                curYOffset = yOffsetMax;
                phase = 1;
            }
            break;
        case 1:
        case 3: // delay movement
            delayTimer++;
            if (delayTimer == delayTimerMax)
            {
                delayTimer = 0;
                phase++;
            }
            break;
        case 2: // move down
            if (curYOffset < 0)
            {
                curYOffset += 0.25;
                yspeed = 0.25;
            }
            if (curYOffset == 0)
            {
                yspeed = 0;
                curYOffset = 0;
                phase = 3;
            }
            break;
        case 4:
            phase = 0;
            break;
        case 5: // fire projectile
            {
                if (shotType == 0) //Fire Cannonball
                {
                    switch (attackTimer)
                    {
                        case 1: // animation setup
                            cFrame = 1;
                            break;
                        case 32:
                            cFrame = 3;
                            with (instance_create(x + 36 * image_xscale, y - 3, objGiantMetCannonShot))
                            {
                                image_xscale = other.image_xscale;
                            }
                            break;
                        case 38:
                            cFrame = 2;
                            break;
                        case 48:
                            cFrame = 0;
                            break;
                        case 64: // finish firing and return to previous phase.
                            attackTimer = 0;
                            phase = oldPhase;
                            break;
                    }
                }
                else //Fire Missiles
                {
                    switch (attackTimer)
                    {
                        case 1: // animation setup
                            cFrame = 1;
                            break;
                        case 32:
                            cFrame = 0;
                            if (!instance_exists(missile1))
                            {
                                with (instance_create(x - 27 * image_xscale, y - 20, objGunnerJoeMissile))
                                {
                                    other.missile1 = id;
                                    parent = other.id;
                                    despawnRange = -1;
                                    if (image_index == -1)
                                    {
                                        image_index = 1;
                                        direction = 135;
                                    }
                                    else
                                    {
                                        image_index = 3;
                                        direction = 45;
                                    }
                                    playSFX(sfxMissileLaunch);
                                }
                            }
                            if (!instance_exists(missile2))
                            {
                                with (instance_create(x - 27 * image_xscale, y - 20, objGunnerJoeMissile))
                                {
                                    other.missile2 = id;
                                    parent = other.id;
                                    despawnRange = -1;
                                    if (image_index == -1)
                                    {
                                        image_index = 0;
                                        direction = 180;
                                    }
                                    else
                                    {
                                        image_index = 4;
                                        direction = 0;
                                    }
                                    if (instance_exists(target))
                                    {
                                        direction = point_direction(x, y, target.x, target.y);
                                    }
                                    playSFX(sfxMissileLaunch);
                                }
                            }
                            break;
                        case 38: // finish firing and return to previous phase.
                            attackTimer = 0;
                            phase = oldPhase;
                            break;
                    }
                }
            }
    }

    if (attackTimer == attackTimerMax) // start fire projectile phase
    {
        yspeed = 0;
        attackTimer = 0;
        oldPhase = phase;
        phase = 5;
        if (randomMissiles)
        {
            shotType = choose(0,1);
        }
    }
}
else if (!insideView())
{
    image_index = 0;
    y = ystart;
    x = xstart;
    attackTimer = 0;
    delayTimer = 0;
    phase = 1;
    curYOffset = -24;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
with (missile1)
{
    instance_create(bboxGetXCenter(),bboxGetYCenter(),objExplosion);
    instance_destroy();
}
with (missile2)
{
    instance_create(bboxGetXCenter(),bboxGetYCenter(),objExplosion);
    instance_destroy();
}
with (objGiantMetCannonShot)
{
    instance_create(bboxGetXCenter(),bboxGetYCenter(),objExplosion);
    instance_destroy();
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!(bboxGetYCenterObject(other.id) < y - 20) || cFrame == 1 || cFrame == 3) //24
{
    other.guardCancel = 1;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// handles stuff differently than the Puny Regular Enemies....
if (introTimer > 0 && doesIntro)
{
    draw_sprite_ext(introSprite, 2 - (min(2, min(introTimer, 15) / 5)), x,
        y - max(introTimer - 10, 0) * image_yscale, image_xscale, image_yscale, 0, c_white, 1);
}
else
{
    // this debug message should be left in until
    // the spawn system stops breaking every week.

    if (spawned == -1)
    {
        show_debug_message(object_get_name(object_index) + " drawn without having ever spawned!");
    }
    if ((ceil(iFrames / 2) mod 4) || !iFrames)
    {
        if ((ceil(iFrames / 2) mod 2) || (iceTimer > 0))
        {
            var flashcol = c_white;
            if (iceTimer > 0)
            {
                flashcol = make_color_rgb(0, 120, 255);
            }

            d3d_set_fog(true, flashcol, 0, 0);

            for (var i = 0; i < ceil(abs(curYOffset) / 8); i++)
            {
                draw_sprite_ext(sprGiantMetCannonMiddle, i, round(x)+1, round(y) + spriteOffset + (i * 8), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
            }
            draw_sprite_ext(sprGiantMetCannonBottom, 0, round(x)+2, bottomPart, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
            draw_sprite_ext(sprGiantMetCannonTop, cFrame, round(x), round(y) + spriteOffset, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
            d3d_set_fog(false, 0, 0, 0);

            if (iceTimer > 0)
            {
                draw_set_blend_mode(bm_add);

                for (var i = 0; i < ceil(abs(curYOffset) / 8); i++)
                {
                    draw_sprite_ext(sprGiantMetCannonMiddle, i, round(x)+1, round(y) + spriteOffset + (i * 8), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
                }
                draw_sprite_ext(sprGiantMetCannonBottom, 0, round(x)+2, bottomPart, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
                draw_sprite_ext(sprGiantMetCannonTop, cFrame, round(x), round(y) + spriteOffset, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
                draw_set_blend_mode(bm_normal);
            }
        }
        else
        {
            for (var i = 0; i < ceil(abs(curYOffset) / 8); i++)
            {
                draw_sprite_ext(sprGiantMetCannonMiddle, i, round(x)+1, round(y) + spriteOffset + (i * 8), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
            }
            draw_sprite_ext(sprGiantMetCannonBottom, 0, round(x)+2, bottomPart, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
            draw_sprite_ext(sprGiantMetCannonTop, cFrame, round(x), round(y) + spriteOffset, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
        }
    }
}
