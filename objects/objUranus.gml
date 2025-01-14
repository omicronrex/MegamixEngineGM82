#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Using Uranus:
// Uranus' room needs to be built out of single blocks in order to work. Otherwise he'll pick up segments of the boss room and throw those rather than the pieces he's supposed to. The hitbox doesn't change with this, so you wouldn't
// be making the boss harder, it'd just look stupid.
// Additionally, Uranus will not work properly if his room isn't perfectly flat. Sorry. No funky cielings.
// See the devkit example for his placement in order to see that you can make perfectly pretty rooms for Uranus to wreck, it just needs to be flat!
event_inherited();

healthpointsStart = 28;
healthpoints = healthpointsStart;
xOff = 0;
contactDamage = 4;
customPose = true;
ground = false;
attackTimer = 0;
hasTriggeredFall = false;
introType = 0;
shakeTimer = 0;
attackTimerMax = 145;
phase = 0;
jumpY = -4.5;
setX = 0;
delay = 0;
hasFired = false;
shotsFired = 0;
myBlock = noone;
grav = 0.25;

// Health Bar
healthBarPrimaryColor[1] = 20;
healthBarSecondaryColor[1] = 34;

// Music
music = "Mega_Man_5GB.gbs";
musicType = "VGM";
musicTrackNumber = 6;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 1);
enemyDamageValue(objLaserTrident, 2);
enemyDamageValue(objWaterShield, 0);
enemyDamageValue(objTornadoBlow, 0);
enemyDamageValue(objThunderBeam, 1);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 2);
enemyDamageValue(objBreakDash, 5);

// MaGMML2
enemyDamageValue(objHornetChaser, 0);
enemyDamageValue(objJewelSatellite, 0);
enemyDamageValue(objGrabBuster, 0);
enemyDamageValue(objTripleBlade, 1);
enemyDamageValue(objWheelCutter, 2);
enemyDamageValue(objSlashClaw, 5);
enemyDamageValue(objSakugarne, 3);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 0);
enemyDamageValue(objGeminiLaser, 3);
enemyDamageValue(objSolarBlaze, 1);
enemyDamageValue(objTopSpin, 5);
enemyDamageValue(objThunderWool, 0);
enemyDamageValue(objPharaohShot, 1);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48HMML
enemyDamageValue(objFlameMixer, 2);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 0);
enemyDamageValue(objSearchSnake, 2);
enemyDamageValue(objTenguBlade, 2);
enemyDamageValue(objTenguDash, 5);
enemyDamageValue(objTenguDisk, 1);
enemyDamageValue(objSaltWater, 0);
enemyDamageValue(objConcreteShot, 1);
enemyDamageValue(objHomingSniper, 2);

// MaG24HMML
enemyDamageValue(objSuperArmBlockProjectile, 2);
enemyDamageValue(objSuperArmDebris, 2);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 4);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 4);
enemyDamageValue(objBrickWeapon, 1);
enemyDamageValue(objIceSlasher, 1);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// leave this. this is needed.

ixs = image_xscale;
image_xscale=1;
event_inherited();
image_xscale=ixs;

// all of uranus' events trigger when the game isn't frozen.
if (!global.frozen)
{
    // uranus can shake the screen even outside the fight (for his intro), so this is stored outside of the other events.
    if (shakeTimer > 0)
    {
        shakeTimer -= 1;
        screenShake(2, 1, 1);
        with (objMegaman)
        {
            if (ground) // shunt mega man off the floor to prevent sliding and break dash
                y -= 1.5 * (irandom(3) + 1);
        }
    }
    if (entityCanStep())
    {
        // uranus' custom intro
        if (startIntro)
        {
            calibrateDirection();
            y += view_yview - bbox_bottom;
            canFillHealthBar = false;
            image_index = 3;
            startIntro = false;
            isIntro = true;
            visible = true;
        }
        else if (isIntro)
        {
            // custom intro:
            if ((y <= view_yview + view_hview / 2) && grav == 0)
            {
                yspeed += gravAccel;
            }


            if (y >= ystart || blockCollision)
            {
                grav = gravStart;
                blockCollision = blockCollisionStart;

                image_speed = 0;
                attackTimer += 1;
                if (attackTimer == 15)
                {
                    image_index = 2;
                }

                if (attackTimer == 30)
                {
                    yspeed = jumpY;
                    image_index = 3;
                }
                if (attackTimer >= 40 && attackTimer < 240 && ycoll > 0)
                {
                    shakeTimer = 25;
                    playSFX(sfxBikkyLand);
                    image_index = 2;
                    attackTimer = 240;
                }

                if (attackTimer == 255)
                {
                    yspeed = jumpY * 1.25;
                    image_index = 3;
                }
                if (attackTimer >= 260 && ycoll > 0)
                {
                    shakeTimer = 25;
                    playSFX(sfxBikkyLand);
                    attackTimer = 0;
                    image_index = 0;
                    isIntro = false;
                    canFillHealthBar = true;
                    yspeed = 0;
                }
            }
        }
    }

    // since uranus' blocks have a x-offset to the left of the block rather than the middle, we store this in this variable here.
    if (image_xscale == -1)
        xOff = 0;
    else
        xOff = 1;

    // if urnaus lands for any reason, shake screen.
    if (image_index == 3 && ground && yspeed == 0) //&& ycoll > 0)
    {
        shakeTimer = 25;
        image_index = 0;
        playSFX(sfxBikkyLand);
    }
    if (isFight == true)
    {
        image_speed = 0;
        attackTimer += 1;

        // split floor of uranus into smaller pieces, so he can pick them up.
        with (instance_place((floor(x / 16) * 16) + 32 * image_xscale, (floor(y / 16) * 16) + 32, objSolid))
        {
            if (image_xscale > 1 || image_yscale > 1)
            {
                splitSolid();
            }
        }
        switch (phase)
        {
            case 0: // pick up block
                if (attackTimer < 25)
                    image_index = round(attackTimer / 6) mod 2;
                if (attackTimer == 25)
                {
                    image_index = 4;

                    // if uranus doesn't have a custom block, he destoys the objSolid and creates a custom block for him to pick up.
                    if (!place_meeting((floor(x / 16) * 16) + 32 * image_xscale, (floor(y / 16) * 16) + 32, objUranusBlock))
                        myBlock = instance_create((floor(x / 16) * 16) + 32 * image_xscale, (floor(y / 16) * 16) + 32, objUranusBlock);
                    else
                        myBlock = instance_place((floor(x / 16) * 16) + 32 * image_xscale, (floor(y / 16) * 16) + 32, objUranusBlock);
                }

                // these following events are uranus' throwing animation.
                if (attackTimer == 27)
                {
                    with (myBlock)
                    {
                        isSolid = false;
                        collisionDamage = 4;
                        x = ((other.x + 16 * other.image_xscale) + (16 * other.image_xscale)) - (other.xOff * 16);
                        y = other.y + 16;
                    }
                }
                if (attackTimer == 38)
                {
                    image_index = 5;
                    with (myBlock)
                    {
                        x = ((other.x + 16 * other.image_xscale) + (4 * other.image_xscale)) - (other.xOff * 16);
                        y = other.y - 24;
                    }
                }

                // throw block!
                if (attackTimer == 56)
                {
                    image_index = 6;
                    with (myBlock)
                    {
                        x = ((other.x + 16 * other.image_xscale) + (16 * other.image_xscale)) - (other.xOff * 16);
                        y = other.y;
                        xspeed = 4 * other.image_xscale;
                        thrown = true;
                        playSFX(sfxEnemyDrop);
                    }
                }

                // change phase
                if (attackTimer == 128)
                {
                    image_index = 2;
                    attackTimer = 0;
                    phase = 1;
                }
                break;
            case 1: // jump and respawn block
                if (attackTimer == 15)
                {
                    image_index = 3;
                    yspeed = jumpY;
                    setX = 32;
                }

                // since uranus' block is never destroyed, he simply moves it to where it used to be and makes it solid.
                if (attackTimer > 20 && ground)
                {
                    with (myBlock)
                    {
                        x = xstart;
                        y = ystart;
                        isSolid = true;
                        collisionDamage = 0;
                    }

                    // uranus no longer recongises the block until he picks it up again with the events above.
                    myBlock = noone;
                    attackTimer = 0;
                    phase = 2;
                }
                break;
            case 2: // jump across screen
                if (attackTimer == 50)
                    image_index = 2;
                if (attackTimer == 65)
                {
                    image_index = 3;

                    // the gravity is lowered in order to make xSpeedAim not cause Uranus to jump really fast across the screen.
                    yspeed = jumpY * 0.575;
                    grav = 0.125;
                }

                // we delay the jump by a single frame in order for xSpeedAim to work properly.
                if (attackTimer == 66)
                {
                    var i; for ( i = 32; i < 256; i += 1)
                    {
                        if (place_meeting(x + i * image_xscale, y, objSolid))
                            break;
                        else
                            setX += 1;
                    }
                    xspeed = xSpeedAim(x, y, x + setX * image_xscale, y + 16, yspeed, grav);
                    phase = 3;
                }
                break;
            case 3: // turn around bright eyes
                if (ground)
                {
                    xspeed = 0;
                    grav = 0.25;
                    attackTimer = 0;
                    image_xscale *= -1;
                    image_index = 2;
                    phase = 4;
                    shotsFired = 0;
                }
                break;
            case 4: // jump repeatedly
                if (attackTimer == 15)
                {
                    image_index = 3;
                    yspeed = jumpY * (1 + 0.25 * shotsFired);
                }
                if (ground && attackTimer >= 16)
                {
                    shotsFired += 1;
                    attackTimer = 0;
                    image_index = 2;
                }
                if (shotsFired == 2) // after two jumps create the falling rocks.
                    phase = 5;
                break;
            case 5: // falling rocks
                var inst; inst = instance_create(x + (7 * 16) * image_xscale, y, objUranusFallingRocks);
                with (inst) // this for loop sets the falling rocks to the opposite side of the screen
                {
                    var i; for ( i = 0; i < 256; i += 1)
                    {
                        if (place_meeting(x, y, objSolid))
                        {
                            while (place_meeting(x, y, objSolid))
                                x -= 1 * other.image_xscale;
                            break;
                        }
                        x += 1 * other.image_xscale;
                    }
                    var i; for ( i = 0; i < 224; i += 1) // this for loop sets the falling rocks to be at the top of the screen.
                    {
                        if (place_meeting(x, y, objSolid))
                        {
                            y -= 15;
                            break;
                        }
                        y -= 1;
                    }
                }

                // set default variables for falling rocks.
                inst.isSolid = true;
                inst.destroyTimer = -32; // this delay means there is a tell for the falling rocks.
                phase = 6;
                attackTimer = 0;
                break;
            case 6: // wait
                if (attackTimer == 60) // jump here to give the illusion of Uranus manipulating the falling rocks futher.
                    image_index = 2;
                if (attackTimer == 75)
                {
                    image_index = 3;
                    yspeed = jumpY;
                    grav = 0.25;
                }
                if (attackTimer >= 200) // reset pattern!
                {
                    attackTimer = 0;
                    image_index = 0;
                    phase = 0;
                }
                break;
        }
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (objUranusBlock)
{
    if (!isSolid)
        instance_destroy();
}
with (objUranusFallingRocks)
    instance_destroy();
with (objEnemyBullet)
    instance_destroy();
event_inherited();
