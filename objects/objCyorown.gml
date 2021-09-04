#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// This crow will blink and then shoot at MM. If you're hit by the bullet, it will mock you.
event_inherited();

respawn = true;

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 4;
grav = 0;

category = "bird, nature";
facePlayerOnSpawn = true;

// Enemy-specific code
shootTimer = 99; // shoot on spawn

assTimer = -1;

image_speed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // shooting animation increment
    if (assTimer == -1)
    {
        shootTimer += 1;
    }

    // blink animation
    if (shootTimer == 10 || shootTimer == 50 || shootTimer == 60)
    {
        image_index = 1;
    }

    // un blink
    if (shootTimer == 15 || shootTimer == 55 || shootTimer == 65)
    {
        image_index = 0;
    }

    // Lean over and shoot
    if (shootTimer == 120)
    {
        image_index = 2;
    }

    if (shootTimer == 125)
    {
        image_index = 3;

        if instance_exists(target)
        {
            a = instance_create(x + 12 * image_xscale, y, objCyorownBullet);
            a.parent = id;

            // i don't know why cyorown does this. mm7 is STUPID
            if (abs(target.x - x) >= 128)
            {
                a.xspeed = 3.25 * image_xscale;
            }
            else if (abs(target.x - x) >= 96 && abs(target.x - x) < 128)
            {
                a.xspeed = 2.75 * image_xscale;
            }
            else
            {
                a.xspeed = 2.35 * image_xscale;
            }

            playSFX(sfxEnemyShoot);
        }
    }

    // Recoil back
    if (shootTimer == 165)
    {
        image_index = 2;
    }

    if (shootTimer == 167)
    {
        calibrateDirection();
        image_index = 0;
        shootTimer = 0;
    }

    // Laugh at player if they get hit by their bullet
    if (assTimer >= 0)
    {
        // this variable is initially set out of -1 via objCyorownBullet's event user 10
        assTimer+=1;

        if (assTimer == 30 || assTimer == 40)
        {
            image_index += 1;
        }

        // vibrate very quickly
        if (assTimer > 40 && assTimer <= 60)
        {
            if (image_index == 6)
            {
                image_index = 7;
            }
            else
            {
                image_index = 6;
            }
        }

        // crawl back up
        if (assTimer == 62)
        {
            image_index = 2;
        }

        if (assTimer == 64)
        {
            image_index = 8;
        }

        // laugh into the air, lean forwards, ass shake etc, this is just general image index incrementing...
        if (assTimer == 80 || assTimer == 85 || assTimer == 100
            || assTimer == 115 || assTimer == 120 || assTimer == 130
            || assTimer == 150 || assTimer == 155 || assTimer == 160
            || assTimer == 165 || assTimer == 170)
        {
            image_index += 1;
        }

        // shake the butt
        if (assTimer > 170 && assTimer mod 6 == 0)
        {
            if (image_index == 19)
            {
                image_index = 20;
            }
            else
            {
                image_index = 19;
            }
        }

        // reset
        if (assTimer == 220)
        {
            assTimer = -1;
            shootTimer = 0;
            image_index = 0;
        }

        // this is a very long animation for just getting hit by one bullet
    }
}
else if (dead)
{
    shootTimer = 99;
    assTimer = -1;
    image_index = 0;
}
