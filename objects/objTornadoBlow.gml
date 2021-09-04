#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 4;

image_speed = 0.2;

penetrate = 3;
pierces = 2;
attackDelay = 30;
killOverride = true;

yspeed = -1;
grav = -0.15;

despawnRange = -1;
hasDoneGrav = false;

init = 0;
location = 0;

playSFX(sfxTornadoBlow);
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// restore normal grav
if (location == 4)
{
    with (parent)
    {
        gravfactor = (gravfactor / (0.6));
    }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    if (!init)
    {
        x = view_xview;
        y = view_yview + view_hview * 0.5 + (view_hview * 0.5 * sign(image_yscale));

        grav *= image_yscale;
        yspeed *= image_yscale;
        visible = true;

        switch (location)
        {
            case 1: // far left
                x += 24;
                y += 16 * image_yscale;
                break;
            case 2: // middle left
                x += 80;
                y += 64 * image_yscale;
                break;
            case 3: // middle right
                x += 176;
                y -= 32 * image_yscale;
                break;
            case 4: // far right
                x += 224;
                y += 128 * image_yscale;
                break;
        }
        init = 1;
    }

    if (instance_exists(parent))
    {
        if (!hasDoneGrav && location == 4)
        {
            parent.gravfactor *= 0.6;
            hasDoneGrav = true;
        }

        if ((image_yscale > 0 && y < view_yview)
            || (image_yscale < 0 && y > view_yview + view_hview))
        {
            event_user(EV_DEATH);
        }
    }
}
#define Other_17
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Nothing
playSFX(sfxReflect);
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
        _i = instance_create(x, y, objTornadoEffect);

        var copy = instance_copy(false);
        _i.sprite_index = sprite_index;
        copy.sprite_index = sprite_index;
        copy.image_index = image_index;
        copy.image_xscale = image_xscale;
        copy.image_yscale = image_yscale;
        copy.mask_index = sprDot;
        _i.objectCopy = copy;

        instance_deactivate_object(copy);

        playSFX(sfxEnemyHit);
    }
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("TORNADO BLOW", make_color_rgb(0, 172, 26), make_color_rgb(248, 248, 248), sprWeaponIconsTornadoBlow);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue("fire", 6);
specialDamageValue("flying", 6);
specialDamageValue("floating", 6);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    for (var z = 1; z <= 4; z++)
    {
        i = fireWeapon(0, 0, objTornadoBlow, (z == 1), (7 * (z == 1)), 1, 0);
        if (instance_exists(i))
        {
            i.location = z;
        }
        else
        {
            break;
        }
    }
}
