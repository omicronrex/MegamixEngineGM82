#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

respawnRange = -1;
despawnRange = -1;

shiftVisible = 1;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

fire = false;

// What lights oil on fire
fireSource[1] = objFireBlockFire;
fireSource[2] = objFirePillar;
fireSource[3] = objFireWave;
fireSource[4] = objTackleFire;
fireSource[5] = objHotDogFire;
fireSource[6] = objLightningLordLightning;
fireSource[7] = objApacheJoeProjectile;
fireSource[8] = objFireBoyShot;
fireSource[9] = objFireTellyShot;
fireSource[10] = objFireSpike;
fireSource[11] = objHeatMan;
fireSource[12] = objHeatManFire;
fireSource[13] = objMechaDragonFire;
fireSource[14] = objPharaohManShot;
fireSource[15] = objPharaohManShotBig;
fireSource[16] = objPharaohShot;
fireSource[17] = objSolarBlaze;
fireSource[18] = objNapalm;
fireSource[19] = objPopoHeliFire;
fireSource[20] = objChangkeyDragon;
fireSource[21] = objChangkeyDragonFire;
fireSource[22] = objSuzak;
fireSource[23] = objFenix;
fireSource[24] = objSFFire;
fireSource[25] = objFlameMixer;
fireSource[26] = objPUOilFire;

// oil
oil[0] = objOil;
oil[1] = objPUOilFire;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!dead && !global.frozen && !global.timeStopped)
{
    if (!fire)
    {
        // manual exceptions, since these share objects.
        if (instance_place(x, y, objPicket))
        {
            a = instance_place(x, y, objPicket);
            if (a.sprite_index == sprTackleFire && a.yspeed > 0)
            {
                fire = true;
            }
        }
        if (instance_place(x, y, objEnemyBullet))
        {
            a = instance_place(x, y, objEnemyBullet);
            if (a.sprite_index == sprFireTotemFlame && a.yspeed > 0)
            {
                fire = true;
            }
        }

        // ITS LIT FAM :joy:
        for (i = 0; i < array_length_1d(fireSource); i+=1)
        {
            if (place_meeting(x, y, fireSource[i]))
            {
                fire = true;
            }
        }

        // check if anything else is on fire near it
        for (i = 0; i <= 1; i += 1)
        {
            if (place_meeting(x - 16, y, oil[i]))
            {
                if instance_place(x - 16, y, oil[i]).fire
                {
                    fire = true;
                    image_index = instance_place(x - 16, y, oil[i]).image_index;
                }
            }

            if (place_meeting(x + 16, y, oil[i]))
            {
                if instance_place(x + 16, y, oil[i]).fire
                {
                    fire = true;
                    image_index = instance_place(x + 16, y, oil[i]).image_index;
                }
            }
        }
    }
    else
    {
        sprite_index = sprOilfire;
        image_index += 1 / 5;
        if (place_meeting(x, y, target) && target.canHit && target.iFrames == 0)
        {
            with (target)
            {
                global.playerHealth[playerID] = 0;
            }
        }
    }
}
else if (dead)
{
    fire = 0;
    sprite_index = sprOil;
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (fire)
{
    exit;
}

fire = true;
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (instance_exists(target))
{
    spl = instance_create(target.x, bbox_top + 4, objSplash);
    spl.sprite_index = sprOilSplash;
    spl.blockCollision = 0;
}
playSFX(sfxOil);
