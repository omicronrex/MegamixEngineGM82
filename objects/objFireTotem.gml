#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Fire Totem
// Creation code: size -> how tall the totem is

// Initialize
event_inherited();

blockCollision = false;
grav = 0;
contactDamage = 4;
healthpointsStart = 4;
healthpoints = 4;

category = "fire";

// @cc - size -> how tall Fire Totem is
size = 2;

// @cc - col -> Fire Totem color: 0 (default) = red, 1 = green;
col = 0;

sz = 0;
phase = 0;
timer = -1;
animFrameBase = 0;
animFrameMiddle = 0;
animFrameHead = 0;
animFrame = 0;
headSprite = sprFireTotemHead;
middleSprite = sprFireTotemMiddle;
shootCooldown = 0;
shotIndex = 0;

init = 1;
image_index = 0;
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Free the custom collision mask
if (!instance_exists(self))
{
    print("fire totem doesn't exists");
    exit;
}
if (mask != noone && mask_index == mask)
{
    var delete; delete = true;
    with (objFireTotem)
    {
        if (id != other && mask == other.mask)
        {
            delete = false;
            break;
        }
    }
    if (delete)
    {
        sprite_delete(mask);
        mask = noone;
    }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// AI
event_inherited();

if (entityCanStep())
{
    animFrameMiddle += 0.15;
    if (floor(animFrameMiddle) > 2)
        animFrameMiddle = 0;
    switch (phase)
    {
        case 0: // Hidden
            if (timer == -1)
            {
                image_index = 0;
                animFrameBase = 0;
                sz = 0;
                timer = 0;
                animFrameHead = -1;
            }
            else
            {
                animFrameBase += 0.15;
                if (animFrameBase > 3)
                    animFrameBase = 0;
                image_index = floor(animFrameBase);

                if (instance_exists(target))
                {
                    if (abs(target.x - x) < 16 * 6)
                    {
                        timer = -1;
                        phase = 1;
                        calibrateDirection();
                    }
                }
            }
            break;
        case 1: // Appear
            if (timer == -1)
            {
                animFrameBase = 4;
                animFrameHead = 0;
                image_index = 4;
                timer = 0.99;
            }
            else
            {
                animFrameBase += size / 8;
                if (floor(animFrameBase) > 7)
                    animFrameBase = 7;
                image_index = floor(animFrameBase);
                if (image_index >= 6)
                    timer += size / 8;
                if (timer > 1 && sz < size)
                {
                    sz += 1;
                    timer = 0;
                }
                else if (sz == size)
                {
                    phase = 3;
                    timer = -1;
                    sz = size;
                    animFrameBase = 7;
                }
            }
            break;
        case 2: // Disapear
            if (timer == -1)
            {
                animFrameBase = 7;
                animFrameHead = 0;
                image_index = 7;
                timer = 0;
            }
            else
            {
                timer += size / 8;

                if (sz == 0)
                {
                    animFrameBase -= size / 8;
                    if (floor(animFrameBase) < 0)
                        animFrameBase = 0;
                }

                image_index = floor(animFrameBase);
                if (timer > 1 && sz > 0)
                {
                    sz -= 1;
                    timer = 0;
                }

                if (sz == 0 && image_index == 0)
                {
                    phase = 0;
                    timer = -1;
                }
            }
            break;
        case 3: // wait and Shoot
            if (timer == -1)
            {
                timer = 0;
                animFrameHead = 1;
                animFrame = 1;
                shootCooldown = 0;
            }
            else
            {
                calibrateDirection();
                var timerEnd; timerEnd = 30 * 4;
                timer += 1;
                if (timer == 1)
                    shotIndex = irandom(3);
                animFrame += 0.15;
                if (floor(animFrame) > 6)
                    animFrame = 1;



                if (timer == timerEnd - 30 * 3 || timer == timerEnd - 30 * 2 || timer == timerEnd - 30 || timer == timerEnd)
                {
                    shootCooldown = 10;
                    shotIndex += 1;
                    if (shotIndex > 3)
                        shotIndex = 0;
                    event_user(0);
                }
                if (timer > 180)
                    timer = 0;
                var shooting; shooting = 0;
                if (shootCooldown > 0)
                {
                    shootCooldown -= 1;
                    shooting = 1;
                }

                animFrameHead = animFrame + shooting * 6;

                if (timer < timerEnd - 30 * 3 && timer > 10 && instance_exists(target) && abs(x - target.x >= 16 * 6))
                {
                    timer = -1;
                    phase = 2;
                }
            }
            break;
    }
}
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Make a new collision mask
event_inherited();
if (init)
{
    init = 0;
    if (size <= 0)
        size = 1;
    if (size > 16)
        size = 16;

    var surf;
    surf = surface_create(256, 224);
    surface_set_target(surf);
    draw_clear_alpha(c_black, 0);
    draw_set_color(c_red);
    draw_rectangle(0, 0, 16, 28 + size * 8, false);
    mask = sprite_create_from_surface(surf, 0, 0, 16, 28 + size * 8, false, false, 8, 27 + size * 8);
    sprite_collision_mask(mask, false, 0, 0, 0, 0, 0, 1, 255);
    mask_index = mask;

    surface_reset_target();
    surface_free(surf);

    //Change sprite colour
    switch (col)
    {
        case 1:
            headSprite = sprFireTotemHeadGreen;
            middleSprite = sprFireTotemMiddleGreen;
            sprite_index = sprFireTotemBaseGreen;
            break;
        default:
            headSprite = sprFireTotemHead;
            middleSprite = sprFireTotemMiddle;
            sprite_index = sprFireTotemBase;
            break;
    }
}
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Free the custom collision mask
if (!instance_exists(self))
{
    print("fire totem doesn't exists");
    exit;
}
if (mask != noone)
{
    sprite_delete(mask);
    mask = noone;
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Shoot
var i; i = instance_create(x, bbox_top + 4, objEnemyBullet);
i.blockCollision = 0;
i.yspeed = -3;
i.grav = 0.16;
if (col == 1)
{
    i.sprite_index = sprFireTotemFlameGreen;
}
else
{
    i.sprite_index = sprFireTotemFlame;
}
i.image_speed = 0.15;
i.x = x;
i.y = bbox_top;
playSFX(sfxFireTotemFire);
switch (shotIndex)
{
    case 0:
        i.xspeed = -1.6;
        break;
    case 1:
        i.xspeed = -0.8;
        break;
    case 2:
        i.xspeed = 0.8;
        break;
    case 3:
        i.xspeed = 1.6;
        break;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// EV_DEATH: death

dead = 1;
var dropY; dropY = (y -12 - 6) - sz*8;
var _ex; _ex = instance_create(bboxGetXCenter(), dropY, objExplosion);

if (itemDrop == objKey)
{
    _ex = instance_create(bboxGetXCenter() - 8, dropY - 8, objKey);
    _ex.yspeed = -4;
    _ex.homingTimer = 90;
    playSFX(sfxKeySpawn);
}
else
{
    _ex.myItem = itemDrop;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.bbox_top > y - 18 - sz * 8 && phase == 3)
{
    other.guardCancel = 1;
    if (other.penetrate >= 2)
    {
        global.damage = 0;
        other.guardCancel = 2;
    }
}
else if (phase != 3)
{
    global.damage = 0;
    if (other.bbox_top <= y - 18 - sz * 8)
        other.guardCancel = 2;
    else
        other.guardCancel = 1;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Reset
event_inherited();
sz = 0;
phase = 0;
timer = -1;
animFrameBase = 0;
animFrameMiddle = 0;
animFrameHead = 0;
animTimer = -1;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Draw

if (!dead)
{
    var i; i = 1;
    var color; color = image_blend;
    var yo; yo = 0;
    var img; img = image_index;
    if (floor(animFrameHead) > 7 || animFrameHead == 0)
    {
        yo = 1;
        if (phase == 3)
            image_index = 6;
    }
    if(sz==1)
        yo+=1;
    event_inherited();
    image_index = img;
    if ((ceil(iFrames / 2) mod 2) || (iceTimer > 0&&iceGraphicStyle==0))
    {
        color = c_white;
        if (iceTimer > 0&&iceGraphicStyle==0)
            color = make_color_rgb(0, 120, 255);
        d3d_set_fog(true, color, 0, 0);
    }
    for (i = 0; i < sz; i+=1)
        draw_sprite_ext(middleSprite, floor(animFrameMiddle), x, y - 12 + yo - i * 8, image_xscale, image_yscale, 0, color, image_alpha);

    if (image_index >= 6)
        draw_sprite_ext(headSprite, floor(animFrameHead), x, y - 12 + yo - ((i) * 8), image_xscale, image_yscale, 0, color, image_alpha);
    d3d_set_fog(false, 0, 0, 0);
    if (iceTimer > 0 && iceGraphicStyle==0)
    {
        draw_set_blend_mode(bm_add);
        for (i = 0; i < sz; i+=1)
            draw_sprite_ext(middleSprite, floor(animFrameMiddle), x, y - 12 + yo - i * 8, image_xscale, image_yscale, 0, c_white, image_alpha);

        if (image_index >= 6)
            draw_sprite_ext(headSprite, floor(animFrameHead), x, y - 12 + yo - ((i) * 8), image_xscale, image_yscale, 0, c_white, image_alpha);
        draw_set_blend_mode(bm_normal);
    }
}
