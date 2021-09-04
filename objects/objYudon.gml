#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// col = <number> (0 = red (default); 1 = game gear colouration;)
// missileCol = <number> (0 = green (default); 1 = purple; - note this also affects what colours "game gear colouration" uses.)

event_inherited();

healthpointsStart = 5;
healthpoints = healthpointsStart;
contactDamage = 8;

category = "bulky, shielded";

facePlayer = true;

// Enemy specific code
shooting = false;
animTimer = 0;

cooldownMax = 70;
cooldownTimer = cooldownMax;

animTimer = 8;
actionTimer = 0;
shooting = false;
closeBlastDoors = false;
doorOpenMax = 5;
img = 0;
imageOffset = 0;
missileArray[1] = 0;
missileArray[2] = 0;
e = 1;

col = 0;
missileCol = 0;

missile1 = 0;
missile2 = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// colour changing events. if game gear colouration is selected, the secondary colour matches the missile colour selected.
if (col > 0)
{
    image_index = (8 * (col + missileCol)) + imageOffset;
}
else
{
    image_index = imageOffset;
}

// i am a fraud and couldn't figure out a way to properly count how many missile in play. woe is me. i did it on the hippo somehow...
// but yudon cares about the number of missiles in play whereas the hippo cares about none.
if (missileArray[1] != 0)
    missile1 = 1;
else
    missile1 = 0;
if (missileArray[2] != 0)
    missile2 = 1;
else
    missile2 = 0;

event_inherited();

if (entityCanStep())
{
    // tickdown cooldown timer

    // check to see if missiles exist, if not remove them from the array.
    for (i = 1; i <= 2; i += 1)
    {
        if (missileArray[i])
        {
            if (!instance_exists(missileArray[i]))
            {
                missileArray[i] = 0;
            }
        }
    }

    // if there are less than 3 missiles, begin shooting code.
    if ((missile1 + missile2) < 2 && !shooting && imageOffset <= 1)
    {
        if (cooldownTimer > 0)
            cooldownTimer -= 1;
        if (cooldownTimer == 0)
        {
            shooting = true;
            imageOffset = 2;
        }
    }
    if (!shooting)
    {
        if (animTimer > 0)
            animTimer -= 1;
        if (animTimer == 0)
        {
            animTimer = 8;
            if (imageOffset == 0)
                imageOffset = 1;
            else
                imageOffset = 0;
        }
    }

    if (shooting)
    {
        actionTimer += 1;
        if (actionTimer == doorOpenMax * 2 && closeBlastDoors == false
            && imageOffset < 3)
        {
            imageOffset = 3;
            actionTimer = 0;
        }
        if (actionTimer == doorOpenMax && imageOffset >= 3 && imageOffset < 7
            && closeBlastDoors == false)
        {
            imageOffset += 1;
            actionTimer = 0;
        }

        if (actionTimer == doorOpenMax && imageOffset == 7
            && closeBlastDoors == false)
        {
            closeBlastDoors = true;
            actionTimer = 0;

            var storeMCol;
            storeMCol = missileCol;

            missileArray[e] = instance_create(x + 8 * image_xscale, y + 20,
                objYudonMissile);
            with (missileArray[e])
            {
                respawn = false;
                col = storeMCol;
            }
            e += 1;
        }
        if (actionTimer == doorOpenMax && closeBlastDoors == true
            && imageOffset > 3)
        {
            imageOffset -= 1;
            actionTimer = 0;
        }
        if (actionTimer == doorOpenMax && closeBlastDoors == true
            && imageOffset == 3)
        {
            imageOffset = 0;
            shooting = false;
            actionTimer = 0;
            closeBlastDoors = false;
            cooldownTimer = cooldownMax;
        }
    }

    // reset missile counter.
    if (e == 3)
        e = 1;
}
else if (dead)
{
    imageOffset = 0;
    animTimer = 8;
    shooting = false;
    actionTimer = 0;
    cooldownTimer = cooldownMax;
    img = 0;
    missile1 = 0;
    missile2 = 0;
    missileArray[1] = 0;
    missileArray[2] = 0;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
with (objYudonMissile)
{
    event_user(EV_DEATH);
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// yudon is invunerable in image 0, 1 and 2:
if (imageOffset < 3)
{
    other.guardCancel = 1;
}
else
{
    if (bboxGetYCenterObject(other.id) > y)
    {
        other.guardCancel = 1;
    }
}
