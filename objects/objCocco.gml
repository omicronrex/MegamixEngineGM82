#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 6;
healthpoints = healthpointsStart;
contactDamage = 7;

category = "shielded, semi bulky, nature, bird";

facePlayer = true;

// Enemy specific code
shooting = false;
animTimer = 0;

cooldownMax = 70;
cooldownTimer = cooldownMax / 2;
animTimer = 3;
actionTimer = 0;
shooting = false;
img = 0;
eggArray[1] = 0;
eggArray[2] = 0;
eggArray[3] = 0;
e = 1;


// i couldn't figure out how to get arrays to co-operate with me, so i'm using an array, AND these variables to store whether or not there are eggs in existance.
// i am a fraud.
egg1 = 0;
egg2 = 0;
egg3 = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// i am a fraud and couldn't figure out a way to properly count how many eggs in play. woe is me.
if (eggArray[1] != 0)
    egg1 = 1;
else
    egg1 = 0;
if (eggArray[2] != 0)
    egg2 = 1;
else
    egg2 = 0;
if (eggArray[3] != 0)
    egg3 = 1;
else
    egg3 = 0;

event_inherited();

if (entityCanStep())
{
    // check to see if eggs exist, if not remove them from the array.
    for (i = 1; i <= 3; i += 1)
    {
        if (eggArray[i])
        {
            if (!instance_exists(eggArray[i]))
            {
                eggArray[i] = 0;
            }
        }
    }

    // if there are less than 3 eggs, begin shooting code.
    if ((egg1 + egg2 + egg3) < 3 && !shooting && image_index == 0)
    {
        shooting = true;
        animTimer = -1;
        image_index = 0;
    }
    else
    {
        if (animTimer > 0)
            animTimer -= 1;
        if (animTimer == 0)
        {
            animTimer = 8;
            if (image_index == 0)
                image_index = 1;
            else
                image_index = 0;
        }
    }

    if (shooting)
    {
        actionTimer += 1;
        if (actionTimer == 7)
        {
            image_index = 2;
            animTimer = -1;
        }
        if (actionTimer == 14)
        {
            animTimer = -1;
            eggArray[e] = instance_create(x + 8 * image_xscale, y, objCorocoro);
            image_index = 3;
            with (eggArray[e])
                respawn = false;
            e += 1;
        }
        if (actionTimer == 21)
            animTimer = 8;
        if (actionTimer == 50)
        {
            image_index = 0;
            animTimer = 5;
            shooting = false;
            actionTimer = 0;
            img = 0;
        }
    }

    // reset egg counter.
    if (e == 4)
        e = 1;
}
else if (dead)
{
    image_index = 0;
    animTimer = 5;
    shooting = false;
    actionTimer = 0;
    img = 0;
    egg1 = 0;
    egg2 = 0;
    egg3 = 0;
    eggArray[1] = 0;
    eggArray[2] = 0;
    eggArray[3] = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (bboxGetYCenterObject(other.id) > y - 2)
{
    other.guardCancel = 1;
}
