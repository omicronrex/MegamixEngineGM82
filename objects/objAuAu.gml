#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 5;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "aquatic, nature, semi bulky";

facePlayerOnSpawn = true;

// Enemy specific code
phase = 1;
cooldownMax = 70;
cooldownTimer = 0;
projectile = noone;

imgSpd = 0.08;
imgIndex = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// needs to activate even if frozen
if (phase == 2 && !instance_exists(projectile))
{
    projectile = noone;
    phase = 1;
    cooldownTimer = cooldownMax;
}

// Normal stuff
if (entityCanStep())
{
    if (instance_exists(target))
    {
        switch (phase)
        {
            // Waiting for megaman + fire cooldown
            case 1:
                imgIndex += imgSpd;
                if (imgIndex >= 2)
                {
                    imgIndex = imgIndex mod 2;
                }

                // If mega man is in front of him
                if (cooldownTimer == 0)
                {
                    calibrateDirection();
                    if (target.bbox_bottom - bbox_top >= 0 && target.bbox_top - bbox_bottom <= 0)
                    {
                        phase = 2;
                        imgIndex = 2;

                        projectile = instance_create(x + sprite_width * 0.33, bbox_top - 6, objAuAuShot);
                        projectile.image_xscale = image_xscale;
                        projectile.parent = id;
                    }
                }
                else if (cooldownTimer > 0)
                {
                    cooldownTimer -= 1;
                }
                break;

            // Charge up bullet
            case 2:
                imgIndex += imgSpd * 2;
                if (imgIndex >= 4)
                {
                    imgIndex = 2 + imgIndex mod 4;
                }
                if (projectile.shotCharge > 2)
                {
                    phase = 3;

                    // doesn't delete the projectile, just decouples it so it can do whatever without being deleted by the enemy
                    projectile = noone;
                    imgIndex = 4;
                }
                break;

            // Fire
            case 3:
                imgIndex += imgSpd * 0.75;
                if (imgIndex >= 5)
                {
                    phase = 1;
                    imgIndex = imgIndex mod 6;
                    cooldownTimer = cooldownMax;
                }
                break;
        }
    }
}
else if (dead)
{
    phase = 1;
    cooldownTimer = 0;
    imgIndex = 0;

    if (instance_exists(projectile))
    {
        with (projectile)
        {
            instance_destroy();
        }
    }

    projectile = noone;
}

image_index = imgIndex div 1;
