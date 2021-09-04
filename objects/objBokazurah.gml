#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// An enemy originating from Hornet Man's stage. It is invincible, but when it's
// shot, it will shoot out three shots that destroy objBokazurahPlatform if it touches them.

event_inherited();

respawn = true;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 5;

blockCollision = 0; // These enemies were embedded into walls in MM9 so yeah
grav = 0;

// Enemy specific code
shootTimer = -1;
animTimer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // Have regular animation if it's not doing the shooting routine
    if (shootTimer == -1)
    {
        animTimer += 1;
        if (animTimer == 20)
        {
            animTimer = 0;
            image_index = !image_index;
        }
    }
    else if (shootTimer >= 0)
    {
        shootTimer += 1;

        // actions! wow!
        if (shootTimer == 5 || shootTimer == 45 || shootTimer == 85)
        {
            image_index = 2;
        }
        else if (shootTimer == 10 || shootTimer == 50 || shootTimer == 90)
        {
            image_index = 3;
            playSFX(sfxCannonShoot);
            a = instance_create(x + 16 * image_xscale, y, objBokazurahBall);
            a.image_xscale = image_xscale; // shoot
        }
        else if (shootTimer == 15 || shootTimer == 55 || shootTimer == 95)
        {
            image_index = 0;
        }
        else if (shootTimer == 110)
        {
            shootTimer = -1;
            animTimer = 0;
        }
    }
}
else if (dead)
{
    // reset everything
    shootTimer = -1;
    animTimer = 0;
    image_index = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// start the shoot timer!!
if (shootTimer == -1)
{
    shootTimer = 0;
    image_index = 0;
}

// reflect bullets
other.guardCancel = 4;
