#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "mets, flying";

despawnRange = 32;
respawnRange = 1;

blockCollision = 0;
grav = 0;

facePlayer = true;

// Enemy specific code
oldPhase = 0;
phase = 0;
shootTimer = 0;
actionTimer = 0;

mdir = "v";
hmdir = -1;

sinCounter = 0;

imgSpd = 0.4;
imgIndex = 0;

image_speed = 0.1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (instance_exists(target))
    {
        switch (phase)
        {
            case 0:
                if (oldPhase == 0)
                {
                    phase = 1;
                }
                else if (oldPhase == 2)
                {
                    phase = 3;
                }
                else if (oldPhase == 3)
                {
                    phase = 2;
                }
                break;

            // start
            case 1:
                actionTimer += 1;
                sinCounter += 0.03;
                if (mdir == 'v')
                {
                    yspeed = (cos(sinCounter) * 1);
                }
                else if (mdir == 'h')
                {
                    if (hmdir == 1)
                    {
                        xspeed = (cos(sinCounter) * 1);
                    }
                    else
                    {
                        xspeed = -(cos(sinCounter) * 1);
                    }
                }
                if (actionTimer >= 50)
                {
                    oldPhase = 2;
                    phase = 4;
                }
                break;
            case 2:
                actionTimer += 1;
                sinCounter += 0.03;
                if (mdir == 'v')
                {
                    yspeed = (cos(sinCounter) * 1);
                }
                else if (mdir == 'h')
                {
                    if (hmdir == 1)
                    {
                        xspeed = (cos(sinCounter) * 1);
                    }
                    else
                    {
                        xspeed = -(cos(sinCounter) * 1);
                    }
                }
                if (actionTimer >= 100)
                {
                    oldPhase = 2;
                    phase = 4;
                }
                break;
            case 3:
                actionTimer += 1;
                sinCounter += 0.03;
                if (mdir == 'v')
                {
                    yspeed = -(cos(sinCounter) * 1);
                }
                else if (mdir == 'h')
                {
                    if (hmdir == 1)
                    {
                        xspeed = -(cos(sinCounter) * 1);
                    }
                    else
                    {
                        xspeed = (cos(sinCounter) * 1);
                    }
                }
                if (actionTimer >= 100)
                {
                    oldPhase = 3;
                    phase = 4;
                }
                break;

            // shooting
            case 4:
                xspeed = 0;
                yspeed = 0;
                shootTimer += 1;
                if (shootTimer >= 10)
                    xspeed = 0;
                yspeed = -0;
                if (shootTimer == 20)
                {
                    xspeed = 0;
                    yspeed = 0;
                    var ID;
                    ID = instance_create(x + image_xscale * 8,
                        spriteGetYCenter() + 4, objMetoolBullet);
                    ID.dir = +45;
                    ID.xscale = image_xscale;
                    ID.sprite_index = sprEnemyBullet;
                    ID = instance_create(x + image_xscale * 8,
                        spriteGetYCenter() + 4, objMetoolBullet);
                    ID.dir = +0;
                    ID.xscale = image_xscale;
                    ID.sprite_index = sprEnemyBullet;
                    ID = instance_create(x + image_xscale * 8,
                        spriteGetYCenter() + 4, objMetoolBullet);
                    ID.dir = -45;
                    ID.xscale = image_xscale;
                    ID.sprite_index = sprEnemyBullet;

                    playSFX(sfxEnemyShootClassic);
                }
                if (shootTimer >= 40)
                    xspeed = 0;
                yspeed = 0;
                if (shootTimer >= 50)
                    xspeed = 0;
                yspeed = 0;
                if (shootTimer >= 60)
                {
                    actionTimer = 0;
                    shootTimer = 0;
                    sinCounter = -1.56;
                    xspeed = 0;
                    yspeed = 0;
                    phase = 0;
                }
                break;
        }
    }
}
else if (dead == true)
{
    phase = 0;
    oldPhase = 0;
    shootTimer = 0;
    actionTimer = 0;
    imgIndex = 0;
    xspeed = 0;
    yspeed = 0;
    sinCounter = 0;
}

if (shootTimer < 50)
    imgIndex += imgSpd;
else if (shootTimer >= 50)
    imgIndex -= imgSpd;

if (shootTimer >= 10)
{
    if (imgIndex >= 6)
    {
        imgIndex = 4;
    }
}
else if (imgIndex >= 2)
{
    imgIndex = imgIndex mod 2;
}

image_index = imgIndex div 1;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (image_index == 0 || image_index == 1)
{
    other.guardCancel = 1;
}
