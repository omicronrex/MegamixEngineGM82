#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// creation code (all optional)
// col = <number>

event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "cannons";

facePlayerOnSpawn = true;

// Enemy specific code
col = 0;
startFacingPlayer = true;

phase = 0;
shootWait = 160;
turnAroundWaitDiff = 40;
shootTimer = 0;

imgSpd = 0.1;
imgIndex = 0;

calibrateDirection();
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // shooting
    if (shootTimer == shootWait)
    {
        shot = instance_create(x + sprite_width * 0.4, y - 4, objEnemyBullet);
        shot.xspeed = 1.4 * image_xscale; // <-=1 bullet speed here
        shot.contactDamage = 3; // <-=1 bullet damage here

        switch (col)
        {
            case 0:
                shot.sprite_index = sprTadahouShotPurple;
                break;
            case 1:
                shot.sprite_index = sprTadahouShotBlue;
                break;
            case 2:
                shot.sprite_index = sprTadahouShotLightBlue;
                break;
        }

        playSFX(sfxEnemyShoot);

        imgIndex = 1;

        shootTimer += 1;
    }
    else if (shootTimer < shootWait)
    {
        shootTimer += 1;
    }

    // turn around stuff
    if (shootTimer == shootWait - turnAroundWaitDiff)
    {
        calibrateDirection();
    }

    // shoot animation
    if (shootTimer >= shootWait + 1)
    {
        imgIndex += imgSpd;
        if (imgIndex >= 2)
        {
            imgIndex = 0;
            shootTimer = 0;
        }
    }
    else
    {
        if (ycoll > 0)
        {
            imgIndex = 2;
        }
    }

    // land animation
    if (imgIndex >= 2)
    {
        imgIndex += imgSpd;
        if (imgIndex >= 3)
        {
            imgIndex = 0;
        }
    }
}
else if (dead)
{
    shootTimer = 0;
    imgIndex = 0;
}

image_index = imgIndex div 1;
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// creation code setup
switch (col)
{
    case 0:
        sprite_index = sprTadahouPurple;
        break;
    case 1:
        sprite_index = sprTadahouBlue;
        break;
    case 2:
        sprite_index = sprTadahouLightBlue;
        break;
}
