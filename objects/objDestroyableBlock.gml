#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 0;
bubbleTimer = -1;

killOverride = false;

isSolid = 1;
faction = 5;
fnsolid = 2;
dieToSpikes = false;

//@cc how to use
//@cc weakness = global.weaponID[? objWeaponObject];
//@cc or weakness = ds_map_find_value(global.weaponID, objWeaponObject)
//@cc To make it a reflect block, use "weakness = -1;"
weakness = 0;

timer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// increase anim timer
if (!global.frozen)
{
    timer += 1;

    iFrames = 0; // please dont cheat the reflect blocks ;-;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

instance_create(bboxGetXCenter() - 8, bboxGetYCenter() - 8, objExplosion);
instance_create(bboxGetXCenter() + 8, bboxGetYCenter() - 8, objExplosion);
instance_create(bboxGetXCenter() - 8, bboxGetYCenter() + 8, objExplosion);
instance_create(bboxGetXCenter() + 8, bboxGetYCenter() + 8, objExplosion);

instance_destroy();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

/*other.guardCancel = 4;

if (global.weapon[other.parent.playerID] == weakness)
{
    if (global.weapon[other.parent.playerID] == 0 || other.object_index != objNormalBusterShot)
    {
        other.guardCancel = 0;
    }
}*/

with (other)
{
    guardCancel = 4;

    if (object_is_ancestor(object_index,prtPlayerProjectile))
    {
        if (instance_exists(parent))
        {
            if (global.weapon[parent.playerID] == other.weakness && (global.weapon[parent.playerID] == 0 || !object_is_ancestor(object_index, objBusterShot)))
            {
                guardCancel = 0;
            }
        }
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (spawned)
{
    if (weakness == -1)
        isTargetable = false;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (sprite_index != sprDestroyableNormal
    && sprite_index != sprDestroyable1632
    && sprite_index != sprDestroyable3216)
{
    event_inherited();
}
else
{
    drawSelf();

    // resizing
    if (image_xscale < 1 && image_yscale == 1)
    {
        sprite_index = sprDestroyable1632;
        image_xscale = 1;
    }

    if (image_yscale < 1 && image_xscale == 1)
    {
        sprite_index = sprDestroyable3216;
        image_yscale = 1;
    }

    // set offset according to sprite
    var xoffset, yoffset;

    switch (sprite_index)
    {
        case sprDestroyableNormal:
            xoffset = 8;
            yoffset = 8;
            break;
        case sprDestroyable1632:
            xoffset = 0;
            yoffset = 8;
            break;
        case sprDestroyable3216:
            xoffset = 8;
            yoffset = 0;
            break;
    }

    // check for player color
    var wac; wac = -1;

    with (objMegaman)
    {
        if (global.weapon[playerID] == other.weakness)
        {
            wac = playerID;
            break;
        }
    }

    if (wac != -1)
    {
        var olc, prc, scc;
        olc = global.outlineCol[wac];
        prc = global.primaryCol[wac];
        scc = global.secondaryCol[wac];
        if (scc == c_white)
        {
            scc = make_color_rgb(255, 217, 162);
        }

        if (timer mod 48 < 6)
        {
            prc = scc;
            scc = c_white;
        }

        draw_sprite_ext(sprite_index, 1, x, y, 1, 1, 0, olc, 1);
        draw_sprite_ext(sprite_index, 2, x, y, 1, 1, 0, prc, 1);
        draw_sprite_ext(sprite_index, 3, x, y, 1, 1, 0, scc, 1);

        draw_sprite_ext(global.weaponIcon[weakness], 0, x + xoffset, y + yoffset, 1, 1, 0, image_blend, 1);
        draw_sprite_ext(global.weaponIcon[weakness], 1, x + xoffset, y + yoffset, 1, 1, 0, prc, 1);
        draw_sprite_ext(global.weaponIcon[weakness], 2, x + xoffset, y + yoffset, 1, 1, 0, scc, 1);
    }
    else
    {
        draw_sprite_ext(global.weaponIcon[weakness], 0, x + xoffset, y + yoffset, 1, 1, 0, c_white, 1);
    }
}
