#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

itemDrop = -1;

doesIntro = true;
lockTransition = true;

rescursiveExplosion = true; // Use this to set whether or not an explosion chain follows death.
killOverride = false;
killed = false;

despawnRange = -1;

introSprite = sprHotDogTeleport;
introTimer = 288 + 15; // 288 is the height above, 15 is the extra frames for teleporting in.
_init = 1;
xplX = -100;
xplY = -100;

canIce = false; // Shouldn't be able to freeze minibosses
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (killed)
{
    healthpoints = 0;
    beenOutsideView = false;
}

event_inherited();
if (killed)
{
    healthpoints = 0;
    beenOutsideView = false;
}

if (introTimer > 0 && doesIntro)
{
    if (insideView())
    {
        if (introTimer > 10)
        {
            introTimer -= 8;
        }
        else
        {
            introTimer -= 1;
        }
    }
}

if (dead)
{
    _init = 1;
}
else if (_init == 1)
{
    _init = 0;
    if (lockTransition)
    {
        global.lockTransition = true;
    }
}
if (!global.frozen && dead && !instance_exists(objSectionSwitcher) && killed)
{
    xspeed = 0;
    yspeed = 0;

    if (rescursiveExplosion && respawn)
    {
        x = xplX;
        y = xplY;
        deadTimer += 1;

        // flickering
        if (deadTimer mod 2 == 0)
        {
            visible = !visible;
        }

        if (floor(deadTimer / 5) * 5 == deadTimer)
        {
            var xcenter = bbox_left + abs(bbox_left - bbox_right) / 2;
            var ycenter = bbox_top + abs(bbox_top - bbox_bottom) / 2;
            playSFX(sfxExplosion);

            // randomize();
            inst = instance_create(xcenter + irandom_range(-(sprite_width / 2),
                (sprite_width / 2)),
                ycenter + irandom_range(-(sprite_height / 2) + 16,
                (sprite_height / 2) - 16), objBigExplosion);
            with (inst)
            {
                image_speed = 1 / 3;
            }
        }
        if (deadTimer >= 60)
        {
            if (lockTransition)
            {
                var canUnlock = true;
                var i = 0;
                with (prtMiniBoss)
                {
                    if (!dead && lockTransition)
                    {
                        canUnlock = false;
                        break;
                    }
                }
                if (canUnlock)
                    global.lockTransition = false;
            }
            instance_destroy();
        }
    }
    else
    {
        x = xplX;
        y = xplY;
        deadTimer += 1;
        if (deadTimer >= 2 || !respawn)
        {
            var xcenter = bbox_left + abs(bbox_left - bbox_right) / 2;
            var ycenter = bbox_top + abs(bbox_top - bbox_bottom) / 2;
            playSFX(sfxExplosion);
            inst = instance_create(round(xcenter - sprite_xoffset + (sprite_width / 2)), round(ycenter - sprite_yoffset + (sprite_height / 2)),
                objBigExplosion);
            with (inst)
            {
                image_speed = 1 / 3;
            }
            if (lockTransition)
            {
                var canUnlock = true;
                var i = 0;
                with (prtMiniBoss)
                {
                    if (!dead && lockTransition)
                    {
                        canUnlock = false;
                        break;
                    }
                }
                if (canUnlock)
                    global.lockTransition = false;
            }
            instance_destroy();
        }
    }
} /* else if (!insideView() && deadTimer > 0 && !rescursiveExplosion)
{
    instance_destroy();
}*/
else if (!killed)
{
    deadTimer = 0;
    visible = true;
}

// Here's some, as Spin Attaxx called it, "code hoarding"
//" Die" (doesn't actually destroy the enemy though)
/* if (healthpoints <= 0)
{
    beenOutsideView = false;
    dead = true; // Enemies don't actually destroy themselves, they become invisible and all collision is neglected
    xspeed = 0;
    yspeed = 0;
}

// Respawning
if (respawn)
{
    if (beenOutsideView)
    {
        if (insideView())
        {
            visible = true;
            dead = false;
            healthpoints = healthpointsStart;
            beenOutsideView = false;
            preventDeath = false;
        }
    }
}
else if (dead) and !respawn
{
    instance_destroy(); // If we can't respawn, there's no point to still be able to execute any code. Destroying the instance saves memory and processing power
}

if (!insideView() && despawnRange != -1)
{
    beenOutsideView = true;

    x = xstart;
    y = ystart;
    healthpoints = 0;
    dead = true;
    visible = false;
    xspeed = 0;
    yspeed = 0;
    preventDeath = true;
}*/
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
xplX = x;
xplY = y;
killed = true;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
killed = false;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if(!spawned)
    exit;
if (introTimer > 0 && doesIntro)
{
    draw_sprite_ext(introSprite, 2 - (min(2, min(introTimer, 15) / 5)), x,
        y - max(introTimer - 10, 0), image_xscale, image_yscale, 0, c_white, 1);
}
else
{
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
            drawSelf();
            d3d_set_fog(false, 0, 0, 0);

            if (iceTimer > 0)
            {
                draw_set_blend_mode(bm_add);
                drawSelf();
                draw_set_blend_mode(bm_normal);
            }
        }
        else
        {
            drawSelf();
        }
    }
}
