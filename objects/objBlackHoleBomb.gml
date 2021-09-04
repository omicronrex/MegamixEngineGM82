#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 3;

image_speed = 0.4;

penetrate = 3;
pierces = 2;
attackDelay = 20;
killOverride = true;

blownUp = false;
canHit = false;
canDamage = false;
destroyTimer = 0;

loopSFX(sfxBlackHoleBomb);
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// pls no endless sfx
event_inherited();

audio_stop_sound(sfxBlackHoleBombOpen);
audio_stop_sound(sfxBlackHoleBomb);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    if (instance_exists(parent))
    {
        if (!blownUp)
        {
            // using distance to point as a cooldown cuz im lazy lol
            if ((global.keyShootPressed[parent.playerID]) && distance_to_point(xstart, ystart) > 4)
            {
                sprite_index = sprBlackHoleBomb;
                mask_index = sprBlackHoleBombHitbox;
                audio_stop_sound(sfxBlackHoleBomb);
                loopSFX(sfxBlackHoleBombOpen);
                canHit = true;
                canDamage = true;
                xspeed = 0;
                yspeed = 0;
                blownUp = true;
            }
            else
            {
                var dir; dir = (global.keyDown[parent.playerID] - global.keyUp[parent.playerID]) * (sign(parent.image_yscale));
                if (dir != 0)
                {
                    if (yspeed * sign(yspeed) < 2)
                    {
                        yspeed += dir * 0.05;
                    }
                }
                else
                {
                    yspeed -= 0.05 * sign(yspeed);
                }
            }
        }
    }

    if (blownUp) // eventually pitter out
    {
        destroyTimer += 1;
        if (destroyTimer >= 240)
            instance_destroy();
    }
}
#define Collision_prtEnemyProjectile
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (canDamage)
{
    switch (other.reflectable)
    {
        case 0:
            exit;
            break;
        case -1:
            playSFX(sfxEnemyHit);
            with (other)
            {
                i = instance_create(bboxGetXCenter(), bboxGetYCenter(), objExplosion);
                event_user(EV_DEATH);
            }
            break;
        case 1:
            playSFX(sfxEnemyHit);
            event_user(EV_ATTACK);
            with (other)
            {
                event_user(EV_DEATH);
            }
            break;
    }
}
#define Other_17
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// unique ricochet animation
i = instance_create(x, y, objHarmfulExplosion);
i.contactDamage = 0;
playSFX(sfxExplosion2);
instance_destroy();
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (other)
{
    par = object_is_ancestor(object_index, prtMiniBoss) || (boss == 1);
    if (par || !canHit || !killOverride)
    {
        exit;
    }

    if (healthpoints - global.damage <= 0)
    {
        var _i;
        _i = instance_create(x, y, objBHBEffect);
        _i.sprite_index = sprite_index;
        _i.image_index = image_index;
        _i.image_xscale = image_xscale;
        _i.image_yscale = image_yscale;
        _i.targetX = other.x;
        _i.targetY = other.y;
        playSFX(sfxEnemyHit);
    }
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("BLACK HOLE BOMB", make_color_rgb(128, 0, 240), make_color_rgb(160, 132, 248), sprWeaponIconsBlackHoleBomb);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    i = fireWeapon(16, 0, objBlackHoleBomb, 1, 7, 1, 0);
    with (i)
    {
        xspeed = other.image_xscale * 1; // zoom
    }
}
