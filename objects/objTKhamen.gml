#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
doesIntro = false;

healthpointsStart = 15;
contactDamage = 0;
isSolid = true;

blockCollision = false;
grav = 0;

category = "bulky, rocky";

// Enemy specific variables
// @cc - Does T. Khamen explode on death or not?
explodeOnDeath = false;

imgIndex = 0;
imgSpd = 0.2;
moveTimer = 60;
phase = 0;
animBack = false;
animLoop = 0;
rock = noone; // T. Khamen's chest rock
lastDrop = 0;
myLock = 0;
dropTime = 4;
selectTime = 60;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    switch (phase)
    {
        case 0:
            if (instance_exists(target))
            {
                if (myLock == 0)
                {
                    myLock = lockPoolLock(global.playerLock[PL_LOCK_SHOOT],
                        global.playerLock[PL_LOCK_CLIMB],
                        global.playerLock[PL_LOCK_SLIDE],
                        global.playerLock[PL_LOCK_JUMP],
                        global.playerLock[PL_LOCK_TURN],
                        global.playerLock[PL_LOCK_MOVE]);
                    target.xspeed = 0;
                }
                if (target.ground)
                {
                    moveTimer-=1;
                    if (moveTimer <= 30)
                    {
                        imgIndex = 1;

                        if (moveTimer == 0)
                        {
                            phase = 1;
                            moveTimer = 30;
                            myLock = lockPoolRelease(myLock);
                        }
                    }
                }
            }
            break;
        case 1:
            if (!instance_exists(rock))
            {
                moveTimer-=1;

                // Shoot rocks
                if (moveTimer <= 0)
                {
                    if (animBack == false)
                    {
                        imgIndex += imgSpd;

                        if (imgIndex == 5)
                        {
                            if (animLoop == 0)
                            {
                                imgIndex = 3;
                                animBack = true;
                            }
                            else
                            {
                                imgIndex = 1;
                                var i; i = instance_create(x + 34 * image_xscale, y + 26, objTKhamenRock);
                                i.image_xscale = image_xscale;
                                i.parent = id;
                                rock = i.id;
                                moveTimer = 120;
                                animLoop = 0;
                            }
                        }
                    }
                    else
                    {
                        imgIndex -= imgSpd;

                        if (imgIndex < 2)
                        {
                            imgIndex = 3;
                            animBack = false;
                            animLoop = 1;
                        }
                    }
                }
            }

            // Drop rocks
            selectTime-=1;
            if (selectTime > 0)
            {
                dropTime-=1;

                if (dropTime == 0)
                {
                    if (instance_exists(objTKhamenRockDropper))
                    {
                        var gridX; gridX = floor(bbox_left / view_wview) * view_wview;
                        var gridY; gridY = floor(bbox_top / view_hview) * view_hview;
                        var i; i = 0;
                        var rockDrop;
                        rockDrop[0] = 0;

                        with (objTKhamenRockDropper)
                        {
                            var _x; _x = floor(x / view_wview) * view_wview;
                            var _y; _y = floor(y / view_hview) * view_hview;
                            if ((_x == gridX) && (_y == gridY))
                            {
                                rockDrop[i] = id;
                                i+=1;
                                active = false;
                            }
                        }
                        rn = irandom_range(0, i - 1);
                        if (rockDrop[rn] > 0)
                        {
                            lastDrop = rockDrop[rn];
                            lastDrop.active = true;
                        }
                    }
                    dropTime = 4;
                }
            }
            break;
    }
}
image_index = imgIndex div 1;
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

imgIndex = 5;

if (explodeOnDeath == false)
{
    //instance_create (x + 20 * image_xscale, y - 18, objBigExplosion);
    i = instance_create(x, y, objTKhamenDead);
    i.image_xscale = image_xscale;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (collision_rectangle(x + 20 * image_xscale, y - 23, x + 40 * image_xscale, y - 13, other.id, false, false))
{
    other.guardCancel = 0;
}
else
{
    other.guardCancel = 1;
}
