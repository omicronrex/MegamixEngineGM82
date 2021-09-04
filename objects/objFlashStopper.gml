#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 0;

canHit = false;

phase = 360;
global.timeStopped = true;
playSFX(sfxFlashStopper);

x = view_xview + 128;
y = view_yview + 112;
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

global.timeStopped = false;

with (prtEntity)
{
    if (!stopOnFlash)
        continue;
    if (global.factionStance[other.faction, faction])
    {
        if (frozen)
        {
            hspeed = pre_hsp;
            vspeed = pre_vsp;
            speed = pre_spe;
            image_speed = pre_isp;
            frozen = 0;
        }
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
    phase -= 1;
    if (phase <= 0)
    {
        playSFX(sfxMenuSelect);
        instance_destroy();
    }
}
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
x = view_xview[0] + 128;
y = view_yview[0] + 112;

if (!global.frozen)
{
    with (prtEntity)
    {
        if (!stopOnFlash)
            continue;
        if (global.factionStance[other.faction, faction])
        {
            if (!frozen)
            {
                // Start Freeze
                pre_hsp = hspeed;
                pre_vsp = vspeed;
                pre_spe = speed;
                pre_isp = image_speed;
                hspeed = 0;
                vspeed = 0;
                speed = 0;
                image_speed = 0;
                frozen = 1;
            }
            for (i = 0; i <= 10; i += 1)
            {
                if (object_get_parent(object_index) != prtBoss)
                {
                    if (alarm[i] > 0)
                    {
                        alarm[i] += 1;
                    }
                }
            }
        }
    }
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("FLASH STOPPER", make_color_rgb(216, 0, 204), make_color_rgb(252, 252, 252), sprWeaponIconsFlashStopper);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    if (!instance_exists(objFlashStopper))
    {
        fireWeapon(0, 0, objFlashStopper, 0, 7, 0, 0);
    }
    else // fire buster shots when flashstopper is active
    {
        i = fireWeapon(14, 0, objBusterShot, 4, 0, 1, 0);
        if (i)
        {
            i.xspeed = image_xscale * 5;
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (phase == 359 || phase == 358 || phase == 355 || phase == 354
    || phase == 351 || phase == 350)
{
    draw_sprite(sprFlashStopperScreen, 0, view_xview[0] + 128, view_yview[0] + 112);
}
