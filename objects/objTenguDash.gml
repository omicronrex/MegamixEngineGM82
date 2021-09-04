#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Copied heavily from the Break Dash code.

event_inherited();

bulletLimitCost = 1;

contactDamage = 2;

penetrate = 2; // obviously we don't want to destroy the control for the dash
pierces = 2;
attackDelay = 8;
killOverride = true;

visible = 0;

shiftVisible = 3;
despawnRange = -1;

playSFX(sfxBreakDash); // needs its own sfx later

flashTimer = 0;
flashOffset = 0;

animTimer = 0;
animFrame = 0;

/* dashTimer = 35;
dashspeed = 2.5;

breakDashLock = false ;*/ // Dan Backslide would be proud of me.
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

with (parent)
{
    hitTimer = 0;
    iFrames = 0;
    slideSpeed = 2.5;
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.switchingSections)
{
    // check for parent
    if (!instance_exists(parent))
    {
        instance_destroy();
        exit;
    }

    // Check if Mega Man isn't sliding.
    if (!parent.isSlide)
    {
        instance_destroy();
        exit;
    }

    image_xscale = parent.image_xscale * 1.2;

    x = parent.x; // stay attached to MM
    y = parent.y;

    // real anim
    animTimer += 1;
    if (animTimer == 4)
    {
        animFrame = !animFrame;
        animTimer = 0;
    }

    with (parent)
    {
        playerHandleSprites("Tengu2");
        iFrames = -1;
    }
}
else if (global.switchingSections)
{
    // Check if Mega Man isn't sliding.
    if (!parent.isSlide)
    {
        instance_destroy();
        exit;
    }

    with (parent)
    {
        playerHandleSprites("Tengu2");
    }
}

visible = 0;
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.damage != 0)
{
    with (other)
    {
        par = object_get_parent(object_index);
        if (par == prtMiniBoss || par == prtBoss || !canHit)
        {
            exit;
        }
        if (healthpoints - global.damage <= 0)
        {
            var _i;
            _i = instance_create(x, y, objSlashEffect);
            _i.sprite_index = sprite_index;
            _i.image_index = image_index;
            _i.image_xscale = image_xscale;
            _i.image_yscale = image_yscale;
            _i.half = 'top';
            _i = instance_create(x, y, objSlashEffect);
            _i.sprite_index = sprite_index;
            _i.image_index = image_index;
            _i.image_xscale = image_xscale;
            _i.image_yscale = image_yscale;
            _i.half = 'bottom';
        }
    }
}
