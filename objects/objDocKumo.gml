#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// image_yscale = 1 or -1 //(Use editor for this!!) // if -1, Doc Kumo will traverse the cieling rather than the floor, like his source game.

event_inherited();
respawn = true;
introSprite = sprDocKumoTeleport;
healthpointsStart = 20;
healthpoints = healthpointsStart;
contactDamage = 4;
blockCollision = 1;
grav = 0.15 * image_yscale;
facePlayerOnSpawn = true;

category = "grounded";

// Enemy specific code
image_speed = 0;
image_index = 0;
storeXScale = 0;
lightImg = 0;
phase = 0;
attackTimer = 0;
attackTimerMax = 8;
bullet[0] = noone;
bullet[1] = noone;
bullet[2] = noone;
animTimer = 0;
lightOffset[0] = -16;
lightOffset[1] = -14;
lightOffset[2] = -12;
lightOffset[3] = -19;
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
    if (storeXScale == 0)
    {
        if (instance_exists(target)) // since minibosses usually only face one direction, here we set the direction of Doc Kumo
            image_xscale = sign(x - target.x) * -1;
        storeXScale = image_xscale;
    }

    if (phase == 0 || phase == 4) // move about
    {
        xspeed = 0.5 * image_xscale;
        if (xcoll != 0 || !positionCollision(x + 8 * image_xscale, y + 21 * image_yscale))
        {
            image_xscale *= -1;
            x += image_xscale;
        }
    }

    attackTimer += 1;
    lightImg += 0.25;
    if (image_index != 3) // animation
    {
        animTimer += 1;
    }

    if (animTimer == 15 && image_index < 2)
    {
        animTimer = 0;
        image_index += 1;
    }
    else if (animTimer == 15)
    {
        animTimer = 0;
        image_index = 0;
    }

    if (attackTimer == attackTimerMax && phase == 0) // jump
    {
        phase = 1;
        xspeed = 0;
        animTimer = 0;
        image_index = 3;
        yspeed = -3 * image_yscale;
        grav = 0.15 * image_yscale;
    }

    if (phase == 1 && ((image_yscale == 1 && yspeed >= 0) || image_yscale == -1 && yspeed <= 0)) // fire bullets
    {
        attackTimer = 0; // stop Doc Kumo dead in the air.
        grav = 0;
        yspeed = 0;
        var rAng = irandom(180) * image_yscale; // all 3 bullets of Doc Kumo are randomly determined in direction.
        bullet[0] = instance_create(x, y, objBeeBladerProjectile);
        bullet[0].xspeed = cos(degtorad(rAng)) * 0.5;
        bullet[0].yspeed = -sin(degtorad(rAng)) * 0.5;
        bullet[0].sprite_index = sprDocKumoBone;
        var rAng = irandom(180) * image_yscale;
        bullet[1] = instance_create(x, y, objBeeBladerProjectile);
        bullet[1].xspeed = cos(degtorad(rAng)) * 0.5;
        bullet[1].yspeed = -sin(degtorad(rAng)) * 0.5;
        bullet[1].sprite_index = sprDocKumoBone;
        bullet[2] = instance_create(x, y, objBeeBladerProjectile);
        var rAng = irandom(180) * image_yscale;
        bullet[2].xspeed = cos(degtorad(rAng)) * 0.5;
        bullet[2].yspeed = -sin(degtorad(rAng)) * 0.5;
        bullet[2].sprite_index = sprDocKumoBone;
        playSFX(sfxEnemyShoot);
        phase = 2;
    }

    if (phase == 2 && attackTimer == attackTimerMax) // reset gravity
    {
        grav = 0.15 * image_yscale;
        phase = 3;
    }

    if (phase == 3 && ycoll != 0) // reset to walking phase
    {
        image_index = 0;
        animTimer = 0;
        phase = 4;
    }

    if (phase == 4 && !instance_exists(bullet[0]) && !instance_exists(bullet[1]) && !instance_exists(bullet[2])) // when all bullets are destroyed, restart pattern.
    {
        attackTimer = 0;
        phase = 0;
    }
}
else if (!insideView())
{
    image_index = 0;
    y = ystart;
    x = xstart;
    if (instance_exists(target))
    {
        image_xscale = sign(x - target.x) * -1;
    }
    animTimer = 0;
    attackTimer = 0;
    phase = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if ((image_yscale == 1 && !(bboxGetYCenterObject(other.id) < y - 12))
    ||
    (image_yscale == -1 && !(bboxGetYCenterObject(other.id) > y + 12)))
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
            draw_sprite_ext(sprDocKumoLight, lightImg, round(x), round(y + lightOffset[image_index] * image_yscale), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
            drawSelf();
            d3d_set_fog(false, 0, 0, 0);

            if (iceTimer > 0)
            {
                draw_set_blend_mode(bm_add);
                draw_sprite_ext(sprDocKumoLight, lightImg, round(x), round(y + lightOffset[image_index] * image_yscale), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
                drawSelf();
                draw_set_blend_mode(bm_normal);
            }
        }
        else
        {
            draw_sprite_ext(sprDocKumoLight, lightImg, round(x), round(y + lightOffset[image_index] * image_yscale), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
            drawSelf();
        }
    }
}
