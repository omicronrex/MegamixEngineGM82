#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = true;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;
category = "grounded, mets";

facePlayerOnSpawn = true;

// Enemy specific code
xspeed = 0;
yspeed = 0;
cSpeed = 1;
delay = 0;
headUp = false;
imageOffset = 0;
radius = 80;
shootTimer = -1;
turnTimer = 0;
boomCounter = 0;
image_speed = 0;
image_index = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    imageOffset += 0.10;
    if (imageOffset >= 3)
    {
        imageOffset = 0;
    }

    if (turnTimer == 0)
    {
        image_index = (4 * headUp) + (imageOffset);
    }
    else if (turnTimer > 7)
    {
        image_index = 8;
    }
    else
    {
        image_index = 9;
    }


    if (xcoll!=0 )
    {
        turnTimer = 14;
        image_index = 9;
        image_xscale = -image_xscale;
        boomCounter += 1;
    }

    if (shootTimer <= 0 && turnTimer == 0)
    {
        delay += 1;
        switch (delay)
        {
            case 0:
                xspeed = cSpeed * image_xscale;
                break;
            case 1:
                xspeed = ((cSpeed * 2) * image_xscale) * headUp;
                break;
            case 2:
                xspeed = cSpeed * image_xscale;
                break;
            case 3:
                delay = 0;
                break;
        }
    }

    if (instance_exists(target))
    {
        if (abs(target.x - x) <= radius && shootTimer == -1)
        {
            headUp = true;
            shootTimer = 60;
            cSpeed = 0;
            xspeed = 0;
            var ID;
            for (i = 0; i <= 2; i += 1)
            {
                ID = instance_create(x + image_xscale * 12,
                    spriteGetYCenter() + 8, objMM2MetBullet);
                ID.dir = 45 - (i * 45);
                ID.image_xscale = image_xscale;
                ID.sprite_index = sprEnemyBullet;
            }
            playSFX(sfxMetallTrain);
        }
    }

    if (shootTimer > 0)
    {
        shootTimer -= 1;
    }
    if (turnTimer > 0)
    {
        turnTimer -= 1;
    }
    if (yspeed != 0)
    {
        cSpeed = 0;
    }
    else
    {
        cSpeed = 1;
    }

    if (boomCounter >= 5)
    {
        instance_create(x, y + 8, objHarmfulExplosion);
        playSFX(sfxExplosion2);
        visible = false;
        dead = true;
    }

    // turn around on walls
    xSpeedTurnaround();
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!headUp)
{
    other.guardCancel = 1;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if(spawned)
{
    xspeed = 0;
    yspeed = 0;
    image_index = 0;
    headUp = false;
    shootTimer = -1;
    delay = 0;
    turnTimer = 0;
    boomCounter = 0;
}
