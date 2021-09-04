#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A big casttle composed of three eyes, the central eye has 12hp, and the other two 7hp.
// he will open his gate to throw platforms that the player must use to damage the higher eyes.
// His high eyes control cannons that aim at the player.
event_inherited();

// Entity setup
canHit = false;
canDamage = false;

// The castle is just the brain, these numbers mean nothing
contactDamage = 9999;
healthpointsStart = 9999;
healthpoints = 9999;

respawnRange = 0;
despawnRange = 0;
blockCollision = false;
grav = 0;
doesIntro = false;
noFlicker = true;

// Enemy specific code
leftTower = noone;
rightTower = noone;
center = noone;
shooter = noone;
flagYO = 0;
flagImage = 0;

// AI
phase = 0;
timer = -1;
masterTimer = -1;
platHeight = 0;
startTime = 0;

animFrame = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (phase == 0) // alive
    {
        if (masterTimer == -1)
        {
            event_user(0);
            masterTimer = startTime;
            center.anim = 0;
            center.timer = 0;
            center.phase = 0;
        }
        masterTimer += 1;

        if (masterTimer > 60 * 9)
        {
            masterTimer = 0;
            shooter = noone;
        }
        else
        {
            if (masterTimer == 60 * 5 - 10 || masterTimer == 60 * 8 - 10) // Shoot
            {
                if (shooter == noone && instance_exists(leftTower) && instance_exists(rightTower)) // Shooting
                    shooter = choose(leftTower, rightTower);
                else if (!instance_exists(leftTower) || !instance_exists(rightTower))
                {
                    if (instance_exists(leftTower))
                        shooter = leftTower;
                    else
                        shooter = rightTower;
                }
                else if (shooter != noone)
                {
                    if (shooter == leftTower)
                        shooter = rightTower;
                    else
                        shooter = leftTower;
                }
                with (shooter)
                {
                    event_user(0);
                }
            }
            else if ((instance_exists(center) && masterTimer == 120) || (!instance_exists(center) && (masterTimer == 120 || masterTimer == 360))) // throw platforms
            {
                timer = -2;
            }

            // Door animations
            if (instance_exists(center))
            {
                var prevAnimFrame; prevAnimFrame = floor(animFrame);
                if (masterTimer > 10 && masterTimer < 40)
                {
                    center.image_index = 8;
                }
                else if (masterTimer > 10)
                {
                    if (center.image_index == 8)
                    {
                        center.phase = 0;
                        center.timer = -1;
                    }
                }
                if (masterTimer > 60 && masterTimer <= 60 * 3.5)
                {
                    animFrame += 0.15;
                    if (floor(animFrame) > 4)
                    {
                        animFrame = 4;
                    }
                }
                else if (masterTimer > 60 * 3.5 && animFrame != 0)
                {
                    animFrame += 0.15;
                    if (floor(animFrame) > 7)
                    {
                        animFrame = 0;
                    }
                }
                if (floor(animFrame) != floor(prevAnimFrame))
                    playSFX(sfxDoor);
            }
        }
    }

    if (phase == 0 && !instance_exists(leftTower) && !instance_exists(rightTower) && !instance_exists(center)) // Die
    {
        phase = 1;
        timer = -1;
        flagYO = 0;
    }

    if (phase == 0)
    {
        if (timer == -2) // Start throwing platforms
        {
            platHeight = choose(0, 1);
            timer = 0;
        }
        if (timer > -1)
        {
            timer += 1;
        }
        if (timer > 60)
            timer = -1;
        var p; p = noone;
        if (timer == 1)
        {
            if (platHeight == 0)
            {
                p = instance_create(x + 64, bbox_bottom, objTricastlePlatform);
                p.spd = 2;
            }
            else
            {
                p = instance_create(x + 64, bbox_bottom - 16, objTricastlePlatform);
                p.spd = 2.25;
            }
        }
        else if (timer == 36)
        {
            if (!platHeight == 0)
            {
                p = instance_create(x + 64, bbox_bottom, objTricastlePlatform);
                p.spd = 2;
            }
            else
            {
                var p; p = instance_create(x + 64, bbox_bottom - 16, objTricastlePlatform);
                p.spd = 2.25;
            }
        }
        if (p != noone)
        {
            p.target = self.target;
            with (p)
                calibrateDirection();
        }
    }
    else if (phase == 1) /// Dying
    {
        if (timer == -1)
        {
            timer = 0;
            flagImage = 0;
        }
        timer += 1;
        flagImage += 0.1;
        if (flagImage > 3)
            flagImage = 0;
        flagYO -= 1;
        if (flagYO < -16)
            flagYO = -16;
        if (timer > 120)
        {
            phase = 2;
            healthpoints = 0;
            dead = true;
            image_speed = 0.05;
            hitTimer = 0;
            event_user(EV_DEATH);
            print("Dead ");
            timer = -1;
            image_index = 1;
        }
    }
}
else if (dead)
{
    leftTower = noone;
    rightTower = noone;
    center = noone;
    shooter = noone;
    if (deadTimer != 0 && phase == 2)
    {
        deadTimer -= 0.5;
    }
    masterTimer = -1;
    if (phase == 2)
    {
        visible = true;
        flagImage += 0.1;
        if (flagImage > 3)
            flagImage = 0;
    }
    if (image_index == 6)
        image_speed = 0;
    if (phase != 2 && phase != 1)
    {
        phase = 0;
        timer = -1;
        image_index = 0;
        image_speed = 0;
        visible = false;
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Make eyes
if (!instance_exists(center))
{
    center = instance_create(x + 76, y + 51, objTricastleEye);
    center.owner = id;
    center.healthpoints = 12;
    center.healthpointsStart = 12;
}
if (!instance_exists(leftTower))
{
    leftTower = instance_create(x + 28, y + 19, objTricastleEye);
    leftTower.owner = id;
    leftTower.hasCannon = true;
    leftTower.healthpoints = 7;
    leftTower.healthpointsStart = 7;
}
if (!instance_exists(rightTower))
{
    rightTower = instance_create(x + 124, y + 19, objTricastleEye);
    rightTower.owner = id;
    rightTower.hasCannon = true;
    rightTower.healthpoints = 7;
    rightTower.healthpointsStart = 7;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (phase == 1 || phase == 2)
{
    var yo; yo = 27;
    switch (image_index)
    {
        case 0:
            yo = 27;
            break;
        case 1:
            yo = 43;
            break;
        case 2:
            yo = 59;
            break;
        case 3:
            yo = 75;
            break;
        case 4:
            yo = 91;
            break;
        default:
            yo = 10000;
            break;
    }
    draw_sprite(sprTricastleFlag, floor(flagImage), bbox_left + (abs(bbox_left - bbox_right) / 2), flagYO + bbox_top + yo);
}
drawSelf();
if (phase == 0)
{
    if (instance_exists(center))
    {
        draw_sprite(sprTricastleDoor, floor(animFrame), x + 45, bbox_top + 69);
    }
}
