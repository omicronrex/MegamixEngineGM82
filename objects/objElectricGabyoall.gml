#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// two indestructible electric Gabyoalls, one on the floor and one on the ceiling,
// that fire arcs of electricity between them

event_inherited();

// Default
healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

grav = -sign(image_yscale) * 0.25;
canIce = false;
isTargetable = false;

facePlayerOnSpawn = true;

respawnRange = -1; // so you can have really long ones in vertical sections that don't despawn
despawnRange = -1; // so you can have really long ones in vertical sections that don't despawn

// enemy specific
phase = -1;

//@cc height the electric gabyoall covers in tiles. Includes the tiles the electric gabyoall itself occupies.
// This can be used to have gabyoalls that have a range that goes through blocks
height = 0;

//@cc 0 = orange (default); 1 = red;
col = 0;

init = 1;

partner = noone;

//@cc Speed of the gabyoall (default 0.6))
spd = 0.6;

//@cc how long the gabyoall waits in between shooting electricity (default 100)
shootWait = 70;
shootWaitTimer = shootWait;
blinks = 2;
electricityList = noone;

imgSpd = 0.3;
imgIndex = 0;
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// destroy electricity
event_user(1);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// this still needs to be done even if it's frozen
if (entityCanStep() && phase > 0)
{
    if (partner == noone || !instance_exists(partner))
    {
        dead = true;
        event_user(1); // delete electricity
    }
}

//" set color phase" so the partner who has it set after creation code can set it too
if (phase == -1)
{
    switch (col)
    {
        case 0:
            sprite_index = sprElectricGabyoallOrange;
            break;
        case 1:
            sprite_index = sprElectricGabyoallRed;
            break;
        default:
            sprite_index = sprElectricGabyoallOrange;
            break;
    }

    phase = 0;
}

if (entityCanStep())
{
    // non-main partner doesn't do stuff with its own speed values
    if (respawn)
    {
        // control electricity
        if (electricityList != noone)
        {
            var i;
            for (i = 0; i < ds_list_size(electricityList); i += 1)
            {
                current = ds_list_find_value(electricityList, i);
                current.x = x;
            }
        }

        // if this is a non-main partner, then do no AI (except turn around). The main one will control this completely
        switch (phase)
        {
            // start up (only done by main controlling electric gabyoall
            case 0:
                if (height < 2)
                {
                    show_error("That height for objElectricGabyoall is too small!", true);
                }

                // start motion
                calibrateDirection();
                xspeed = spd * image_xscale;

                // checks, just in case
                if (instance_exists(partner))
                {
                    event_user(0); // delete partner
                }
                if (electricityList != noone)
                {
                    event_user(1); // delete electricity
                }

                // spawn partner
                partner = instance_create(x, y + height * 16 - 1, objElectricGabyoall);
                partner.respawn = false; // tells the parter to not be in charge of main the AI
                partner.image_yscale = -1;
                partner.spd = spd;
                partner.col = col;
                partner.grav = -sign(partner.image_yscale) * 0.25;
                partner.partner = id;
                phase = 1;
                break;

            // waiting to shoot
            case 1: // animation
                imgIndex += imgSpd;
                if (imgIndex >= 2)
                {
                    imgIndex = imgIndex mod 2;
                }
                if (shootWaitTimer > 0)
                {
                    shootWaitTimer -= 1;
                }
                else
                {
                    phase = 2;
                    imgIndex = 2;
                }
                break;

            // shoot
            case 2: // I reused shootWaitTimer, as a counter, boolean, AND another timer   :P
            // animation
                if (shootWaitTimer <= 0 && shootWaitTimer > -blinks)
                {
                    imgIndex += imgSpd * 0.75;
                    if (imgIndex >= 4)
                    {
                        imgIndex = imgIndex mod 4;
                        shootWaitTimer -= 1;
                    }
                }
                else
                {
                    imgIndex += imgSpd;
                    if (imgIndex >= 2)
                    {
                        imgIndex = imgIndex mod 2;
                    }
                }
                if (shootWaitTimer == -blinks)
                {
                    electricityList = ds_list_create();
                    var i;
                    for (i = 1; i < (height - 1); i += 1)
                    {
                        ds_list_add(electricityList, instance_create(x, y + i * 16, objElectricGabyoallCurrent));
                    }
                    shootWaitTimer -= 1;
                }
                if (shootWaitTimer <= -blinks)
                {
                    if (shootWaitTimer > -40 - blinks)
                    {
                        // <-=1 duration of shooting here
                        shootWaitTimer -= 1;
                    }
                    else
                    {
                        phase = 1;
                        event_user(1); // delete electricity
                        shootWaitTimer = shootWait;
                    }
                }
                break;
        }

        // control partner
        if (partner != noone && instance_exists(partner))
        {
            partner.image_index = image_index;
            partner.imgIndex = imgIndex;
            partner.x = x;
            partner.xspeed = xspeed;
        }
    }

    // turn around if a wall is hit, or there's no more ground
    if (xspeed == 0 || checkFall(image_xscale * 16)) //! positionCollision(x + sprite_width / 2 + xspeed, y - 1 * image_yscale))
    {
        image_xscale = -image_xscale;
        xspeed = spd * image_xscale;

        // to let the partner detect being stopped by hitting a wall
        if (!respawn)
        {
            partner.image_xscale = image_xscale;
            partner.xspeed = xspeed;
            partner.x = x;
        }
    }
}
else if (dead)
{
    phase = 0;
    if (respawn)
    {
        event_user(0); // delete partner and electricity
    }
    shootWaitTimer = shootWait;
    xspeed = 0;
    imgIndex = 0;
}

image_index = imgIndex div 1;
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_user(1);
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Delete electricity
event_user(1);

if (partner != noone && instance_exists(partner))
{
    with (partner)
    {
        instance_destroy();
    }

    partner = noone;
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Delete electricity
if (electricityList != noone)
{
    var i;
    for (i = 0; i < ds_list_size(electricityList); i += 1)
    {
        current = ds_list_find_value(electricityList, i);
        with (current)
        {
            instance_destroy();
        }
    }

    ds_list_destroy(electricityList);
    electricityList = noone;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 2;
//global.damage = 0;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (spawned)
{
    if (init)
    {
        init = 0;

        shootWaitTimer = shootWait;

        var i;
        p = 0;
        for (i = y + 8 * image_yscale; i <= global.sectionBottom; i += 16 * image_yscale)
        {
            p += 1;
            if (positionCollision(x, i + 16 * image_yscale))
            {
                height = p;
                break;
            }
        }

        if (i > room_height || i > global.sectionBottom)
        {
            show_message("objElectricGabyoall at position (" + string(x)
                + ", " + string(y)
                + ") was unable to automatically set its height. Try setting it in the creation code.");
            height = 16;
        }
    }
}
