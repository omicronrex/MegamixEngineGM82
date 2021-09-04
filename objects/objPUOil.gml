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

// MM walking check
with (objMegaman)
{
    if (ground && place_meeting(x, y + gravDir, other) && xspeed != 0
        && ((stepTimer >= stepFrames) || (isSlide)) && !(hitLock))
    {
        playSFX(sfxFireTotemFire);
        playerGetShocked(0, 0, true, 25); // make sure to change to MM1 stun when made
        stepTimer = 0;
    }
}

if (!fire)
{
    // manual exception, since these share an object.
    if (instance_place(x, y, objPicket))
    {
        a = instance_place(x, y, objPicket);
        if (a.sprite_index == sprTackleFire && a.yspeed > 0)
        {
            fire = true;
        }
    }

    // ITS LIT FAM :joy:
    for (var i = 0; i < array_length_1d(fireSource); i++)
    {
        if (place_meeting(x, y - 1, fireSource[i]))
        {
            fire = true;
        }
    }

    // check if anything else is on fire near it
    for (i = 0; i <= 1; i += 1)
    {
        if (place_meeting(x - 16, y - 1, oil[i]))
        {
            if instance_place(x - 16, y - 1, oil[i]).fire
            {
                fire = true;
            }
        }

        if (place_meeting(x + 16, y - 1, oil[i]))
        {
            if instance_place(x + 16, y - 1, oil[i]).fire
            {
                fire = true;
            }
        }
    }
}
else
{
    instance_create(x + 1, y, objPUOilFire);
    instance_destroy();
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*if (fire)
{
    exit;
}

fire = true;

var oil;
oil[0] = objOil;
oil[1] = objPUOil;

for (i = 0; i <= 1; i += 1)
{
    if (place_meeting(x + 16, y, oil[i]))
    {
        with (instance_place(x + 16, y, oil[i]))
        {
            if id != other.id && !fire
            {
                event_user(0);
            }
        }
    }
    if (place_meeting(x - 16, y, oil[i]))
    {
        with (instance_place(x - 16, y, oil[i]))
        {
            if id != other.id && !fire
            {
                event_user(0);
            }
        }
    }
}
