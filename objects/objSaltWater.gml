#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 2;

penetrate = 1;
pierces = 2;

grav = 0.25;
phase = 0;

blockCollision = 1;

imgs = 0;

if (sprite_index == sprSaltWater)
{
    attackDelay = 16;
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
    switch (phase)
    {
        // Salt Water shot
        case 0: // When landing on ground
            if (ground)
            {
                if (sprite_index == sprSaltWater)
                {
                    phase = 1;
                    playSFX(sfxSplash);
                    sprite_index = sprSaltWaterSplash1;
                    canDamage = 0;

                    // Create drops
                    var i; i = instance_create(x, y, objSaltWater);
                    i.sprite_index = sprSaltWaterDrop;
                    i.xspeed = 0.5 * image_xscale;
                    i.yspeed = -5 * image_yscale;
                    i.grav = grav;

                    var i; i = instance_create(x, y, objSaltWater);
                    i.sprite_index = sprSaltWaterDrop;
                    i.xspeed = 1.25 * image_xscale;
                    i.yspeed = -4.5 * image_yscale;
                    i.grav = grav;

                    var i; i = instance_create(x, y, objSaltWater);
                    i.sprite_index = sprSaltWaterDrop;
                    i.xspeed = 2 * image_xscale;
                    i.yspeed = -4 * image_yscale;
                    i.grav = grav;
                }
                else
                {
                    phase = 2;
                }
            } // When hitting a wall
            else if (xcoll != 0)
            {
                if (sprite_index == sprSaltWater)
                {
                    phase = 1;
                    playSFX(sfxSplash);
                    sprite_index = sprSaltWaterSplash2;
                    canDamage = 0;

                    // Create drops
                    var i; i = instance_create(x, y, objSaltWater);
                    i.sprite_index = sprSaltWaterDrop;
                    i.xspeed = -0.5 * image_xscale;
                    i.yspeed = -4 * image_yscale;
                    i.grav = grav;

                    var i; i = instance_create(x, y, objSaltWater);
                    i.sprite_index = sprSaltWaterDrop;
                    i.xspeed = -1.25 * image_xscale;
                    i.yspeed = -3.5 * image_yscale;
                    i.grav = grav;

                    var i; i = instance_create(x, y, objSaltWater);
                    i.sprite_index = sprSaltWaterDrop;
                    i.xspeed = -2 * image_xscale;
                    i.yspeed = -3 * image_yscale;
                    i.grav = grav;
                }
                else
                {
                    phase = 2;
                }
            }
            break;
        // Salt Water splash
        case 1:
            blockCollision = 0;
            xspeed = 0;
            yspeed = 0;
            grav = 0;
            image_speed = 0.1;
            imgs += image_speed;
            if (imgs == 3)
            {
                event_user(EV_DEATH);
            }
            break;
        // Salt Water drops
        case 2:
            xspeed = 0;
            yspeed = 0;
            grav = 0;
            image_speed = 0.25;
            imgs += image_speed;
            if (imgs == 4)
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
if (sprite_index == sprSaltWater)
{
    event_inherited();
    grav = 0;
}
else if (sprite_index == sprSaltWaterDrop)
{
    phase = 2;
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Set Mega Man's palette
weaponSetup("SALT WATER", make_color_rgb(0, 120, 248), make_color_rgb(248, 248, 248), sprWeaponIconsSaltWater);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Special Damage

specialDamageValue("bulky", 4);
specialDamageValue("semi bulky", 3);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    i = fireWeapon(25, -1, objSaltWater, 1, 1, 1, 2);
    if (instance_exists(i)) // Set starting speed
    {
        if ((global.keyUp[playerID] && gravDir == 1) || (global.keyDown[playerID] && gravDir == -1))
        {
            i.yspeed = -5 * image_yscale;
            i.xspeed = 2 * image_xscale;
        }
        else if ((global.keyDown[playerID] && gravDir == 1) || (global.keyUp[playerID] && gravDir == -1))
        {
            i.yspeed = -2 * image_yscale;
            i.xspeed = 2 * image_xscale;
        }
        else
        {
            i.yspeed = -3 * image_yscale; //-2
            i.xspeed = 2 * image_xscale;
        }
        i.grav = i.grav * image_yscale;
        playSFX(sfxBuster);
    }
}
