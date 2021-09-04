#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// dir = 1/-1 (1 = ground (default); -1 = ceiling)

event_inherited();

respawn = true;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;
grav = 0;

facePlayerOnSpawn = true;

// respawnRange = -1;

// enemy specific code
// Now set the weaknesses
enemyDamageValue(objThunderBeam, 3);
enemyDamageValue(objBreakDash, 3);
enemyDamageValue(objIceWall, 3);
enemyDamageValue(objSakugarne, 3);
enemyDamageValue(objThunderWool, 3);
enemyDamageValue(objIceSlasher, 3);
dir = 1;
init = 1;

phase = 1;
boost = false;
cooldown = 0;

normalSpd = 0.5;
boostSpd = 2.2;

stopped = false;
alarmStop = -1;

blinkTimer = 0;
imgSpd = 0.4;
imgIndex = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Upside Down setup
if (init)
{
    init = 0;
    if (dir == -1)
    {
        image_yscale = -1;
        y += 16;
        ystart += 16;
    }
}

// Code
event_inherited();

if (entityCanStep())
{
    if (!stopped)
    {
        if (xspeed == 0 || !positionCollision(x + sprite_width / 4, y + sprite_height + 1 * image_yscale))
        {
            image_xscale *= -1;

            if (boost)
            {
                // end boost stuff
                boost = false;
                cooldown = 60; // <-=1 cooldown wait time here
                imgIndex = 0;
            }
            else
            {
                cooldown = 0;
            }
        }

        if (instance_exists(target))
        {
            switch (phase)
            {
                // Behavior
                case 1:
                    if (cooldown == 0)
                    {
                        if (!boost && collision_line(x - 512,
                            y + sprite_height - image_yscale, x + 512,
                            y + sprite_height, target, false, true))
                        {
                            boost = true;
                            imgIndex = 1;
                            playSFX(sfxEnemyBoost);
                        }
                        else if (boost && !collision_line(x - 512,
                            y + sprite_height - image_yscale, x + 512,
                            y + sprite_height, target, false, true))
                        {
                            // end boost stuff
                            boost = false;
                            cooldown = 60; // <-=1 cooldown wait time here
                            imgIndex = 0;
                        }
                    }
            }
        }

        if (cooldown != 0)
        {
            cooldown -= 1;
        }

        if (boost)
        {
            xspeed = boostSpd * image_xscale;
        }
        else
        {
            xspeed = normalSpd * image_xscale;
        }

        // animation
        blinkTimer += 1;
        if (blinkTimer >= 12)
        {
            if (sprite_index == sprCyberGabyoallLightEye)
            {
                sprite_index = sprCyberGabyoallDarkEye;
            }
            else
            {
                sprite_index = sprCyberGabyoallLightEye;
            }
            blinkTimer = 0;
        }

        if (boost)
        {
            imgIndex += imgSpd;
            if (imgIndex >= 4)
            {
                imgIndex = 2 + imgIndex mod 4;
            }
        }
    }
    else
    {
        xspeed = 0;
        boost = false;
        cooldown = 0;
        imgIndex = 0;
        alarmStop -= 1;
        if (!alarmStop)
        {
            stopped = false;
            xspeed = normalSpd * image_xscale;
        }
    }
}

image_index = imgIndex div 1;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.damage == 0)
{
    other.guardCancel = 3;
}

if (other.object_index == objBusterShotCharged)
{
    alarmStop = 120;
    stopped = true;
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Set all weapons to do no damage
global.damage = 0;
event_inherited();
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (spawned)
{
    xspeed = normalSpd * image_xscale;
    phase = 1;
    boost = false;
    cooldown = 0;
    imgIndex = 0;
    image_index = 0;
}
