#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 1;

blockCollision = 1;
noCollision = 0;
grav = 0;

penetrate = 0;
pierces = 0;

spd = 4;
init = 1;

angle = 0;
ground = false;
bounceCount = 0;

savedYspeed = 0;

wallCooldown = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if(entityCanStep() && !noCollision)//Manually call generalCollision()
{
    if(!blockCollision)
    {
        x=xprevious;//Position is updated in the step event of prtEntity so we have to revert the change first
        y=yprevious;
    }
    else
    {
        blockCollision=0;
    }
    ground=false;

    generalCollision(1);
}

if (init == 1)
{
    // default angle
    if (image_xscale == 1)
    {
        angle = 0;
    }
    else
    {
        angle = 180;
    }

    // set speed
    xspeed = cos(degtorad(angle)) * spd;
    yspeed = -sin(degtorad(angle)) * spd;

    image_xscale = 1;

    while (checkSolid(0, 0,1,1))
    {
        x -= image_xscale;
    }

    init = 0;
}

if (!global.frozen)
{
    // Sprites
    if ((angle == 0) || (angle == 180))
    {
        sprite_index = sprGeminiLaser;
    }
    else
    {
        sprite_index = sprGeminiLaserReflect;
        image_angle = wrapAngle(angle - 135);
    }

    // disable collision after a while
    if ((bounceCount > 8) || (!canDamage))
    {
        noCollision = 1;
        exit;
    }

    // Collision with walls
    if (xcoll != 0)
    {
        bounceCount+=1;

        if (angle == 0) // Laser going right
        {
            angle = 135;
        }
        else if (angle == 180) // Laser going left
        {
            angle = 45;
        }
        else // If laser isn't horizontal...
        {
            angle = wrapAngle(angle - (90 * sign(yspeed) * sign(xcoll)));
        }

        // reset speed
        xspeed = cos(degtorad(angle)) * spd;
        yspeed = -sin(degtorad(angle)) * spd;
    }

    // Collision with floors/ceilings
    if (ycoll != 0)
    {
        bounceCount+=1;

        angle = wrapAngle(angle + (90 * sign(xspeed) * sign(ycoll)));

        // reset speed
        xspeed = cos(degtorad(angle)) * spd;
        yspeed = -sin(degtorad(angle)) * spd;
    }
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Set Mega Man's palette
weaponSetup("GEMINI LASER", make_color_rgb(60, 188, 252), make_color_rgb(252, 252, 252), sprWeaponIconsGeminiLaser);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Set special damage values
specialDamageValue("semi bulky", 3);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Weapon Firing

var xOffset, yOffset, bulletObject, bulletLimit, weaponCost, action, willStop;

xOffset = 16; // x offset from center of player
yOffset = 0; // y offset from center of player
bulletObject = objGeminiLaser;
bulletLimit = 3;
weaponCost = 2;
action = 1; // 0 - no frame; 1 - shoot; 2 - throw
willStop = 0; // If this is 1, the player will halt on shooting ala Metal Blade.

if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    i = fireWeapon(xOffset, yOffset, bulletObject, bulletLimit, weaponCost, action, willStop);

    // set starting speed
    if (instance_exists(i))
    {
        i.image_yscale = 1;

        if (!ground && (isShoot < 3))
        {
            xOffset -= 5;
        }

        yOffset += 4 * sign(image_yscale);
        if (climbing)
        {
            image_xscale = climbShootXscale;
            yOffset = 2 * sign(image_yscale);
        }
        else if (!ground)
        {
            yOffset = -1 * sign(image_yscale);
        }

        playSFX(sfxGeminiLaser);
        for (i = 1; i < 4; i += 1)
        {
            laser = instance_create(x + (xOffset * image_xscale) + (((i * sprite_get_width(sprGeminiLaser))) * image_xscale), y + yOffset, objGeminiLaser);
            laser.image_xscale = image_xscale;
            laser.bulletLimitCost = 0;

            if (instance_exists(vehicle))
                laser.y += vehicle.shootYOffset - yOffset;
        }
    }
}
