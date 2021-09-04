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

penetrate = 0;
pierces = 0;

xspeed = 0;
yspeed = 0;
grav = 0;

init = true;
xSpdConst = 5;
bounced = false;

stopSFX(sfxSlashClaw);
playSFX(sfxTenguBlade);
animTimer = 0;

image_speed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{
    // Destroys the disk if it spawns inside a wall.
    if (positionCollision(x, y))
    {
        instance_destroy();
    }
    init = false;
}

event_inherited();

if (!global.frozen)
{
    // Bounces off walls.
    if (xcoll != 0 && ycoll * image_yscale >= 0)
    {
        image_xscale *= -1;
        xspeed = xSpdConst * image_xscale;
        yspeed = 0;
        bounced = true;
    }

    // Starts curving up after bouncing once.
    if (bounced)
    {
        yspeed -= image_yscale * 0.375; // 0.25;
    }

    // Disappears after hitting the ceiling.
    if (ycoll * image_yscale < 0)
    {
        instance_destroy();
    }

    // Animation
    animTimer+=1;

    if (image_index < 2)
    {
        if (animTimer == 3)
        {
            image_index = 1;
        }

        if (animTimer == 6)
        {
            xspeed = xSpdConst * image_xscale;
            animTimer = 0;
            image_index = 2;
        }
    }
    else
    {
        if (animTimer mod 4 == 0)
        {
            image_index += 1;
            if (image_index > 5)
            {
                image_index = 2;
            }
        }
    }
}
