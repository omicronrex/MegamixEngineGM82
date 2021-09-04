#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
grav = 0.25 * image_yscale;
facePlayerOnSpawn = false;
healthpointsStart = 6;
contactDamage = 4;
category = "cannons";

// Enemy specific code
// @cc - Change colours - 0 (default) = green, 1 = blue, 2 = yellow, 3 = red
col = 0;

angle = 0 + 8 * (image_xscale == -1);
newAngle = angle;
timer = 0;
phase = 0;
despawnRange = 4;
respawnRange = 1;
tx = -1;
ty = -1;
aimDist = 0;
xscaleStart = image_xscale;
animOffset = 0;
gravDir = 0;

old = false;
init = 1;

// Sprites
greenSprite = sprNewClassicalCannon;
blueSprite = sprNewClassicalCannonBlue;
yellowSprite = sprNewClassicalCannonYellow;
redSprite = sprNewClassicalCannonRed;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (gravDir == 0)
        gravDir = 1;
    if (instance_exists(target))
    {
        gravDir = target.image_yscale;
    }
    if (phase == 0) // aim
    {
        if (tx == -1 && ty == -1)
        {
            if (instance_exists(target))
            {
                tx = target.x;
                ty = target.y;
            }
            else
            {
                tx = 0;
                ty = 0;
            }
        }
        else
        {
            var dist; dist = abs(x - tx);
            if (dist > 16 * 7.5)
            {
                newAngle = 3;
            }
            else if (dist > 16 * 6)
            {
                newAngle = 2;
            }
            else if (dist > 16 * 4)
            {
                newAngle = 1;
            }
            else
            {
                newAngle = 0;
            }

            if (gravDir != image_yscale)
            {
                newAngle = 3 - newAngle;
            }
            switch (newAngle)
            {
                case 0:
                    aimDist = 16 * 3.65;
                    break;
                case 1:
                    aimDist = 16 * 5;
                    break;
                case 2:
                    aimDist = 16 * 6.5;
                    break;
                case 3:
                    aimDist = 16 * 9;
                    break;
            }

            if ((old && image_xscale == -1) || (tx < x && !old))
            {
                newAngle = (8 - newAngle);
            }
            phase = 1;

            timer = 0;
        }
    }
    else if (phase == 1) // Rotate
    {
        timer += 1;
        if (timer > 10)
        {
            if (angle < newAngle)
            {
                angle += 1;
            }
            else if (angle > newAngle)
            {
                angle -= 1;
            }
            timer = 0;
            if (newAngle == angle)
            {
                timer = -1;
            }
            image_xscale = 1 - 2 * (angle > 4);
        }
        if (timer < 0)
        {
            timer -= 1;
            if (timer < 30)
            {
                phase = 2;
            }
        }
    }
    else if (phase == 2) // Shoot
    {
        if (timer == 0)
        {
            playSFX(sfxCannonShoot);
            var i; i = instance_create(x, y, objEnemyBullet);
            i.explodeOnContact = true;
            i.contactDamage = 4;
            animOffset = 1;
            i.canHit = true;
            i.image_speed = 0;
            i.healthpoints = 1;
            i.healthpointsStart = 1;
            var animFrame; animFrame = angle;
            if (animFrame > 4)
                animFrame = abs(animFrame - 8);
            switch (animFrame)
            {
                case 0:
                    i.yspeed = -gravDir;
                    break;
                case 1:
                    i.yspeed = -gravDir * 2.5;
                    break;
                case 2:
                    i.yspeed = -gravDir * 3;
                    if (old)
                        i.yspeed = -gravDir * 3.75;
                    break;
                case 3:
                    i.yspeed = -gravDir * 6.5;
                    break;
            }
            i.grav = gravDir * 0.25;
            if (image_yscale != gravDir)
            {
                i.yspeed = -image_yscale * 2;
                abs(sin(degtorad(animFrame * 20)));
                i.xspeed = image_xscale * 2 * abs(cos(degtorad(animFrame * 20)));
            }

            if (old)
            {
                i.sprite_index = sprClassicalCannonBullet;
                i.mask_index = sprClassicalCannonBullet;
                if (col == 2)
                {
                    i.image_index = 1;
                }
            }
            else
            {
                i.sprite_index = sprNewClassicalCannonBullet;
                i.mask_index = sprNewClassicalCannonBullet;
                switch (col)
                {
                    // Blue Cannon, orange shots
                    case 1:
                        i.image_index = 2;
                        break;
                    // Red Cannon, yellow shots
                    case 3:
                        i.image_index = 1;
                        break;
                }
            }
            i.x = x + image_xscale * 16 * abs(cos(degtorad(angle * 20)));
            i.y = y - 9 * image_yscale - image_yscale * 16 * abs(sin(degtorad(angle * 20)));
            var _y; _y = y;
            if (sign(ty - y) == gravDir)
            {
                _y = ty;
            }
            if (gravDir == image_yscale)
            {
                i.xspeed = xSpeedAim(i.x, i.y, x + aimDist * image_xscale, _y, i.yspeed, i.grav, 5);
                if (abs(i.xspeed) < 3)
                    i.xspeed = 3 * image_xscale;
            }

            tx = -1;
            ty = -1;
        }
        if (timer > 5)
            animOffset = 0;
        var waitTime; waitTime = 120;
        if (old)
            waitTime = 80;
        if (timer > waitTime)
        {
            phase = 0;
        }
        timer += 1;
    }

    var animFrame; animFrame = angle;
    if (animFrame > 4)
        animFrame = abs(animFrame - 8);
    image_index = animOffset * 5 + animFrame;
}
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Change colours based on sprite
event_inherited();
if (init)
{
    switch (col)
    {
        case 1:
            sprite_index = blueSprite;
            break;
        case 2:
            sprite_index = yellowSprite;
            break;
        case 3:
            sprite_index = redSprite;
            break;
        default:
            sprite_index = greenSprite;
            break;
    }
    init = 0;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// spawn Event
event_inherited();
if (spawned)
{
    image_xscale = xscaleStart;
    angle = 4;
    if (old)
        angle = 3;
    newAngle = angle;
    timer = 100;
    if (old)
        timer -= 30;
    phase = 2;
    tx = -1;
    ty = -1;
    gravDir = 0;
    animOffset = 0;
}
