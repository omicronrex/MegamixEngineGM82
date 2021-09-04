#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):

event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
realContactDamage = 3;

category = "joes";

facePlayer = true;

// Enemy specific code
contactDamage = realContactDamage;

shootTimer = 0;
shooting = false;

shootAmount = 0;

// randomize();
shootAmountMax = choose(5, 10);

collapse = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!dead && global.timeStopped)
{
    event_user(EV_DEATH);
    playSFX(sfxEnemyHit);
}

if (entityCanStep())
{
    if (!collapse)
    {
        facePlayer = true;

        if (!shooting)
        {
            shootTimer += 1;
            if (shootTimer >= 120)
            {
                shootTimer = 0;
                shooting = true;
                image_index = 1;

                // randomize();
                shootAmountMax = 1;
            }
        }
        else
        {
            shootTimer += 1;
            if (shootTimer == 15)
            {
                image_index = 2;
                var shootID;
                shootID = instance_create(x + image_xscale * 16,
                    spriteGetYCenter(), objJoeBone);
                shootID.image_xscale = image_xscale;

                shootAmount += 1;
            }
            else if (shootTimer == 30)
            {
                if (shootAmount >= shootAmountMax)
                {
                    image_index = 0;
                    shooting = false;
                    shootAmount = 0;
                }
                else
                {
                    image_index = 1;
                }
                shootTimer = 0;
            }
        }
    }
    else
    {
        facePlayer = false;

        shootTimer += 1;

        if (shootTimer == 8)
        {
            image_index = 4;
        }
        if (shootTimer == 96)
        {
            image_index = 5;
            contactDamage = realContactDamage;
        }
        if (shootTimer == 104)
        {
            image_index = 6;
        }
        if (shootTimer == 112)
        {
            image_index = 7;
        }
        if (shootTimer == 120)
        {
            image_index = 8;
        }
        if (shootTimer == 128)
        {
            image_index = 7;
        }
        if (shootTimer == 136)
        {
            image_index = 8;
        }
        if (shootTimer == 144)
        {
            image_index = 0;
            collapse = false;
            shootTimer = 0;
        }
    }
}
else if (dead)
{
    shootTimer = 0;
    shooting = false;
    shootAmount = 0;
    collapse = false;
    facePlayer = true;
    image_index = 0;
}

// 5-6-7-8-7-8
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!collapse && global.damage == 0)
{
    shootTimer = 0;
    collapse = true;
    other.guardCancel = 1;
    contactDamage = 0;
    image_index = 3;
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Set all weapons to do no damage
for (i = 0; i <= 4000; i += 1)
{
    specialDamageValue(i, 0);
}

// now set the weaknesses
specialDamageValue(objBusterShotCharged, 3);
specialDamageValue(objTornadoBlow, 1);
specialDamageValue(objLaserTrident, 2);
specialDamageValue(objSlashClaw, 2);
specialDamageValue(objWireAdapter, 2);
specialDamageValue(objSolarBlaze, 2);
