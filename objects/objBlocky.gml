#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A bunch of blocks togheter, this enemy will dance and move forwards, if his vulnerable part is hit
// he will fall and the blocks will spread, if he's still alive he will regenerate.

event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 8;

category = "shielded";

//@cc
facePlayerOnSpawn = true;

// Enemy specific code
image_speed = 0.15; // Using this variable is not recommended, please avoid it

collapseTimer = 180;
collapsed = false;
catchTimes = 0;

//@cc set to false to disable turning
canTurn = true;

calibrated = 0;

//@cc 0 = blue; 1 = gray
col = 0;

init = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (init)
{
    init = 0;
    switch (col)
    {
        case 0:
            sprite_index = sprBlocky;
            break;
        case 1:
            sprite_index = sprBlockyGray;
            break;
        default:
            sprite_index = sprBlocky;
            break;
    }
}

if (entityCanStep())
{
    image_speed = 0.15;
    if (xcoll != 0)
    {
        image_xscale *= -1;
    }
    if (xspeed == 0 && !collapsed)
    {
        xspeed = 0.35 * image_xscale;
    }

    if (catchTimes >= 3 && collapsed)
    {
        collapsed = false;
        collapseTimer = 150;
        y -= 48;

        switch (col)
        {
            case 0:
                sprite_index = sprBlocky;
                break;
            case 1:
                sprite_index = sprBlockyGray;
                break;
            default:
                sprite_index = sprBlocky;
                break;
        }
        image_index = 0;
        image_speed = 0.15;
        calibrateDirection();
    }

    if (ground && (sprite_index == sprBlockySpray || sprite_index == sprBlockySprayGray))
    {
        image_index = 1;
        collapseTimer -= 1;
        if (collapseTimer == 30 || collapseTimer == 20 || collapseTimer == 10)
        {
            var ID; ID = instance_create(x, view_yview[0] + 224 - 16, objBlockySprayRise);
            ID.respawn = false;
            ID.despawnRange = 8;
            ID.canHit = false;
            switch (col)
            {
                case 0:
                    ID.sprite_index = sprBlockySpray;
                    break;
                case 1:
                    ID.sprite_index = sprBlockySprayGray;
                    break;
                default:
                    ID.sprite_index = sprBlockySpray;
                    break;
            }
        }
    }
}
else
{
    image_speed = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!(sprite_index == sprBlockySpray || sprite_index == sprBlockySprayGray) && (bboxGetYCenterObject(other.id) >= y + 16
    && bboxGetYCenterObject(other.id) <= y + 32))
{
    if (other.object_index != objSparkShock)
    {
        playSFX(sfxEnemyHit);
        if (healthpoints == 2)
        {
            i = instance_create(x, y + 16, objBlockySpray);
            with (i)
            {
                switch (other.col)
                {
                    case 0:
                        sprite_index = sprBlockySpray;
                        break;
                    case 1:
                        sprite_index = sprBlockySprayGray;
                        break;
                    default:
                        sprite_index = sprBlockySpray;
                        break;
                }
                image_index = 2;
                image_speed = 0;
            }
            i.xspeed = 1 * image_xscale;
            i.yspeed = -2;

            i = instance_create(x, y + 16, objBlockySpray);
            with (i)
            {
                switch (other.col)
                {
                    case 0:
                        sprite_index = sprBlockySpray;
                        break;
                    case 1:
                        sprite_index = sprBlockySprayGray;
                        break;
                    default:
                        sprite_index = sprBlockySpray;
                        break;
                }
                image_index = 2;
                image_speed = 0;
            }
            i.xspeed = 1.5 * image_xscale;
            i.yspeed = -4;

            i = instance_create(x, y + 16, objBlockySpray);
            with (i)
            {
                switch (other.col)
                {
                    case 0:
                        sprite_index = sprBlockySpray;
                        break;
                    case 1:
                        sprite_index = sprBlockySprayGray;
                        break;
                    default:
                        sprite_index = sprBlockySpray;
                        break;
                }
                image_index = 2;
                image_speed = 0;
            }
            i.xspeed = 2 * image_xscale;
            i.yspeed = -6;

            collapsed = true;
            switch (col)
            {
                case 0:
                    sprite_index = sprBlockySpray;
                    break;
                case 1:
                    sprite_index = sprBlockySprayGray;
                    break;
                default:
                    sprite_index = sprBlockySpray;
                    break;
            }
            y += 16;
            image_speed = 0;
            image_index = 0;
            xspeed = 0;
        }
    }
}
else
{
    global.damage = 0;
    other.guardCancel = 1;
    if (other.penetrate > 1)
        other.guardCancel = 2;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
switch (col)
{
    case 0:
        sprite_index = sprBlocky;
        break;
    case 1:
        sprite_index = sprBlockyGray;
        break;
    default:
        sprite_index = sprBlocky;
        break;
}
image_index = 0;
image_speed = 0.15;
collapseTimer = 180;
collapsed = false;
catchTimes = 0;
