#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 3;

penetrate = 0;
pierces = 1;

grav = 0.25;
phase = 0;

blockCollision = 1;

// Object specific
isBlock = false;
destroyTimer = 0;

animTimer = 0;
image_speed = 0;

nextgrav = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    // only if its just a small puddle
    if (!isBlock)
    {
        // animate
        animTimer+=1;

        if (animTimer == 5)
        {
            image_index = !image_index;
            animTimer = 0;
        }

        // hit surfaces and become BIG boy
        if (xcoll != 0 || ycoll != 0 || ground)
        {
            playSFX(sfxConcreteShot2);
            xspeed = 0;
            yspeed = 0;
            grav = 0;

            destroyTimer = -10;

            image_index = 2;
            isBlock = true;
            canDamage = false;
        }
    } // now be a big boy.
    else if (isBlock)
    {
        destroyTimer+=1;

        // become a real block!
        if (destroyTimer == 0)
        {
            isSolid = 1;
            grav = nextgrav;
            image_index = 3;
        }

        // crack
        if (destroyTimer == 85)
        {
            image_index = 4;
        }

        // Cromble.
        if (destroyTimer == 110)
        {
            image_index = 5;
            isSolid = 0;
        }

        // actually die
        if (destroyTimer == 120)
        {
            event_user(10);
            instance_destroy();
        }

        // cromble if megaman is standing on it
        with (objMegaman)
        {
            if (ground)
            {
                if (place_meeting(x, y + gravDir, other))
                {
                    if (other.destroyTimer < 85)
                    {
                        other.destroyTimer = 85;
                        other.image_index = 4;
                    }
                }
            }
        }
    }
}
#define Other_17
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (canDamage && destroyTimer < 120)
{
    playSFX(sfxReflect);
    canDamage = false;

    isBlock = true;
    destroyTimer = 110;
    image_index = 5;
    isSolid = 0;

    xspeed = 0;
    yspeed = 0;
    grav = 0;
}
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (global.damage >= other.healthpoints)
{
    playSFX(sfxConcreteShot2);
    x = bboxGetXCenterObject(other);
    y = bboxGetYCenterObject(other);

    if (other.itemDrop == 0)
    {
        other.itemDrop = -1;
    }

    isBlock = true;

    grav = 0;
    nextgrav = 0.25;

    image_index = 2;
    destroyTimer = -10;

    xspeed = 0;
    yspeed = 0;
    canDamage = false;
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Set Mega Man's palette
weaponSetup("CONCRETE SHOT", make_color_rgb(111, 111, 111), make_color_rgb(184, 184, 184), sprWeaponIconsConcreteShot);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Special Damage

specialDamageValue("flying", 5);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    i = fireWeapon(25, -1, objConcreteShot, 3, 2, 1, 0);
    if (instance_exists(i)) // Set starting speed
    {
        i.xspeed = 3.5 * image_xscale;
        i.grav = i.grav * image_yscale;
        playSFX(sfxConcreteShot1);
    }
}
