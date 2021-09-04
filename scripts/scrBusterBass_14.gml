var bulletLimit; bulletLimit = 4;
var weaponCost; weaponCost = 0;
var action; action = 1; // 0 - no frame; 1 - shoot; 2 - throw; 3 - upwards aim; 4 - upwards diagonal aim; 5 - downwards diagonal aim;
var xOffset; xOffset = 16;
var yOffset; yOffset = 0;
var willStop; willStop = 1; // If this is 1, the player will halt on shooting ala Metal Blade.

//setting the actual action here
if yDir == -1 && xDir == 0
{
    action = 3;
    xOffset = 5;
    yOffset = -11;
}
else if yDir == -1 && xDir != 0
{
    action = 4;
    xOffset = 13;
    yOffset = -6;
}
else if yDir
{
    action = 5;
    xOffset = 14;
    yOffset = 6;
}
if (!global.lockBuster)
{
    if (global.keyShoot[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
    {
        if shootTimer < 8
        {
            shootTimer+=1
            exit;
        }
        i = fireWeapon(xOffset, yOffset, objBusterShot, bulletLimit, weaponCost, action, willStop);
        isShoot = action;
        xspeed = 0;
        if shootTimer >= 14 //making sure it doesn't release the lock until it stops being held
        {
            shootTimer = 14;
        }
        if (i)
        {
            i.sprite_index = sprEnemyBullet;
            i.dir = 0;

            if (image_xscale < 0)
            {
                i.dir += 180;
            }

            if (yDir != 0)
            {
                i.dir -= (yDir * 90) * image_xscale;
                if (xDir != 0 || yDir == 1)
                {
                    i.dir += (yDir * 45) * image_xscale;
                }
            }
        }
    }
}
