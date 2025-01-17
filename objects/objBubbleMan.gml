#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
healthpointsStart = 28;
contactDamage = 4;

pose = sprBubblePose;
poseImgSpeed = 0.1;
facePlayer = true;

phase = 0;
dieToSpikes = 0; // Don't die to spikes.

grav = 0.25;
ground = false;
attackTimer = 0;

bubbles = 0;
bubbleLimit = choose(0, 1, 2); // Number of Bubble Lead shots to fire
targX = 0;
imgIndex = 0;
yCount = 0; // How far to swim up before shooting
yStart = 0; // Starting y position before swimming

shooting = false;
animBack = false;

child = noone;

// Health Bar
healthBarPrimaryColor[1] = 22;
healthBarSecondaryColor[1] = 40;

// Music
music = "Mega_Man_2.nsf";
musicType = "VGM";
musicTrackNumber = 17;

// Damage Table
enemyDamageValue(objBusterShot, 1);
enemyDamageValue(objBusterShotHalfCharged, 1);
enemyDamageValue(objBusterShotCharged, 3);

// MaGMML3
enemyDamageValue(objSparkChaser, 4);
enemyDamageValue(objLaserTrident, 2);

// Water Shield heals Bubble Man
enemyDamageValue(objTornadoBlow, 0);
enemyDamageValue(objThunderBeam, 4);
enemyDamageValue(objBreakDash, 1);
enemyDamageValue(objMagneticShockwave, 2);
enemyDamageValue(objIceWall, 1);

// MaGMML2
enemyDamageValue(objHornetChaser, 2);
enemyDamageValue(objJewelSatellite, 0);
enemyDamageValue(objGrabBuster, 1);
enemyDamageValue(objTripleBlade, 4);
enemyDamageValue(objSlashClaw, 2);
enemyDamageValue(objWheelCutter, 4);
enemyDamageValue(objSakugarne, 0);
enemyDamageValue(objSuperArrow, 2);
enemyDamageValue(objWireAdapter, 1);

// MaGMML1
enemyDamageValue(objMetalBlade, 4);
enemyDamageValue(objGeminiLaser, 1);
enemyDamageValue(objSolarBlaze, 0);
enemyDamageValue(objTopSpin, 0);
enemyDamageValue(objThunderWool, 4);
enemyDamageValue(objPharaohShot, 0);
enemyDamageValue(objBlackHoleBomb, 1);
enemyDamageValue(objMagicCard, 2);

// MaG48MML
enemyDamageValue(objFlameMixer, 0);
enemyDamageValue(objRainFlush, 1);
enemyDamageValue(objSparkShock, 4);
enemyDamageValue(objSearchSnake, 0);
enemyDamageValue(objTenguBlade, 0);
enemyDamageValue(objTenguDash, 1);
enemyDamageValue(objTenguDisk, 0);
enemyDamageValue(objSaltWater, 1);
enemyDamageValue(objConcreteShot, 2);
enemyDamageValue(objHomingSniper, 1);

// MaG48MML
enemyDamageValue(objSuperArmBlockProjectile, 1);
enemyDamageValue(objSuperArmDebris, 1);
enemyDamageValue(objChillShot, 1);
enemyDamageValue(objChillSpikeLanded, 1);

// Misc.
enemyDamageValue(objPowerStone, 1);
enemyDamageValue(objPlantBarrier, 0);
enemyDamageValue(objBrickWeapon, 1);
enemyDamageValue(objIceSlasher, 2);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (isIntro)
    {
        if (inWater)
        {
            sprite_index = sprBubblePose;
        }
        else
        {
            sprite_index = sprBubbleLandPose;
        }
    }
    if (isFight)
    {
        grav = 0;

        // Sprite handling - Underwater sprites
        if (inWater)
        {
            idleSprite = sprBubbleMan;
            swimSprite = sprBubbleSwim;

            //Destroy water jet if underwater
            if (instance_exists(child))
            {
                with (child)
                {
                    instance_destroy();
                }
                child = noone;
            }
        }
        else // Sprite handling - Land sprites
        {
            idleSprite = sprBubbleLand;
            swimSprite = sprBubbleFLUDD;

            if (sprite_index != idleSprite) && (!instance_exists(child))
            {
                child = instance_create(x, y, objBubbleManWaterSprout);
                child.parent = id;
            }
            else if (sprite_index == idleSprite)
            {
                with (child)
                {
                    instance_destroy();
                }
                child = noone;
            }
        }

        switch (phase)
        {
            // Shoot Bubble Lead
            case 0:
                sprite_index = idleSprite;

                attackTimer+=1;
                if (attackTimer < 15)
                {
                    imgIndex = 0;
                }

                // Fire bubbles
                if (bubbles < bubbleLimit)
                {
                    if (attackTimer >= 15)
                    {
                        imgIndex += 0.1;
                        if (imgIndex == 1)
                        {
                            var i; i = instance_create(x, bbox_top, objBubbleManLead);
                            i.xspeed = 1 * image_xscale;
                            i.yspeed = -2;
                            i.image_xscale = image_xscale;
                            i.parent = id;
                        }
                        else if (imgIndex == 2)
                        {
                            imgIndex = 0;
                            attackTimer = 0;
                            bubbles+=1;
                        }
                    }
                } // If Bubble Lead limit has been reached, begin next phase if target exists
                else
                {
                    if ((attackTimer == 20) || (bubbleLimit == 0))
                    {
                        if (instance_exists(target))
                        {
                            phase = 1;
                            yStart = y;
                            attackTimer = 0;
                            sprite_index = sprBubbleShoot;
                            targX = floor(target.x);
                            xspeed = 1 * image_xscale;
                            yspeed = -0.5;
                            bubbleLimit = choose(0, 1, 2);

                            // Fire a shot
                            var i; i = instance_create(x + 16 * image_xscale, y, objBubbleBullet);
                            i.image_xscale = image_xscale;
                            i.xspeed = 2 * image_xscale;
                            i.parent = id;

                            if (inWater)
                            {
                                i.sprite_index = sprBubbleManShot;
                            }
                            else
                            {
                                i.sprite_index = sprBubbleManShotLand;
                            }

                            // Fire one more Bubble Lead before swimming
                            var i; i = instance_create(x, bbox_top, objBubbleManLead);
                            i.xspeed = 1 * image_xscale;
                            i.yspeed = -2;
                            i.image_xscale = image_xscale;
                            i.parent = id;
                        } // Do nothing if player dies
                        else
                        {
                            attackTimer = 0;
                            bubbles = 0;
                        }
                    }
                }
                break;
            // Swim towards player
            case 1:
                imgIndex += 0.2;

                // Stop shooting if target X is reached
                if (floor(x) == targX)
                {
                    xspeed = 0;
                    sprite_index = swimSprite;
                } // Else, keep shooting
                else
                {
                    sprite_index = sprBubbleShoot;
                }

                // Fire bullets
                yCount += 0.5;
                if ((yCount == 16) && (sprite_index == sprBubbleShoot))
                {
                    var i; i = instance_create(x + 16 * image_xscale, y, objBubbleBullet);
                    i.image_xscale = image_xscale;
                    i.xspeed = 2 * image_xscale;
                    i.parent = id;

                    if (inWater)
                    {
                        i.sprite_index = sprBubbleManShot;
                        i.image_speed = 0.2;
                    }
                    yCount = 0;
                }

                // Start going down when hitting ceiling
                if ((y == view_yview) || (ycoll != 0) || (yStart - y == 96))
                {
                    yspeed = 0.7;
                    sprite_index = swimSprite;
                    phase = 2;
                    yCount = 0;
                }
                break;
            // Swim down
            case 2:
                if (!ground)
                {
                    imgIndex += 0.2;
                }
                else
                {
                    // Fire shot on landing
                    attackTimer+=1;
                    if (attackTimer == 1) && (bubbleLimit != 0)
                    {
                        var i; i = instance_create(x + 16 * image_xscale, y, objBubbleBullet);
                        i.image_xscale = image_xscale;
                        i.xspeed = 2 * image_xscale;
                        i.parent = id;

                        if (inWater)
                        {
                            i.sprite_index = sprBubbleManShot;
                            i.image_speed = 0.2;
                        }
                    }

                    // Wait until player lands before beginning again
                    sprite_index = idleSprite;
                    imgIndex = 0;
                    if (instance_exists(target))
                    {
                        if (target.ground)
                        {
                            attackTimer = 0;
                            phase = 0;
                            animBack = false;
                            bubbles = 0;
                        }
                    }
                }
                break;
        }
        image_index = imgIndex div 1;
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

with (objEnemyBullet)
{
    if (parent == other.id)
    {
        instance_destroy();
    }
}
with (objBubbleManLead)
{
    instance_destroy();
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.object_index == objWaterShield)
{
    iFrames = 0;
    with (other)
    {
        event_user(EV_DEATH);
    }
    other.guardCancel = 2;
    healthpoints += 4;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/* if (isFight)
{
    if (!inWater)
    {
        if (sprite_index != idleSprite)
        {
            //draw_sprite_ext(sprWaterPillar,image_index,x-4*image_xscale,y+64,1,-1,0,c_white,1);
            drawSelf();
        }
    }
}*/
event_inherited();
