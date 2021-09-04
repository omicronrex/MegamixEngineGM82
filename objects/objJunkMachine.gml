#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

shiftVisible = 0;
respawnRange = -1;
despawnRange = -1;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

phase = 0; // 0 = not powered up; 1 = powering up

// 2 = powered up and working; 3 = powering down

timer = 0;
imageCountDir = 1;
elecDirec = 1;

myFlag = 0;

// What activates the machine:
powerSource[1] = objThunderBeam;
powerSource[2] = objThunderWool;
powerSource[3] = objSparkShock;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!dead && !global.frozen && !global.timeStopped)
{
    var hasSwitch = false;
    if (!is_undefined(global.flagParent[myFlag]) && instance_exists(global.flagParent[myFlag]))
    {
        hasSwitch = true;
    }

    // Inactive.
    if (phase == 0)
    {
        image_index = 0;
        for (i = 0; i < array_length_1d(powerSource); i += 1)
        {
            if (place_meeting(x, y, powerSource[i]))
            {
                elecDirec = instance_place(x, y, powerSource[i]).image_xscale;
                playSFX(sfxElectricShot);
                phase = 1;
            }
        }
    }

    // Activating.
    if (phase == 1)
    {
        timer += 1;
        if (timer mod 3 == 0)
        {
            image_index += 1;
            if (image_index >= 3)
            {
                image_index = 1;
            }
        }
        if (timer >= 60)
        {
            phase = 2;
            timer = -1;
            image_index = 3;
            if (hasSwitch)
            {
                global.flagParent[myFlag].active = true;
                global.flag[myFlag] = 1;
                global.flagParent[myFlag].elecDirec = sign(elecDirec);
                global.flagParent[myFlag].stayActive = 0;
            }
        }
    }

    // Currently activated.
    if (phase == 2)
    {
        // In case another junk machine sharing the flag gets deactivated.
        if (hasSwitch && global.flagParent[myFlag].active == false)
        {
            global.flagParent[myFlag].active = true;
            global.flag[myFlag] = 1;
        }
        timer += 1;
        if (timer >= 5)
        {
            image_index += imageCountDir;
            if (image_index <= 3 || image_index >= 5)
            {
                imageCountDir = -imageCountDir;
            }
            timer = 0;
        }

        for (i = 0; i < array_length_1d(powerSource); i += 1)
        {
            if (place_meeting(x, y, powerSource[i]))
            {
                playSFX(sfxElectricShot);
                image_index = 0;
                phase = 3;
            }
        }
    }

    // Deactivating.
    if (phase == 3)
    {
        timer += 1;
        if (timer mod 3 == 0)
        {
            image_index += 1;
            if (image_index >= 3)
            {
                image_index = 1;
            }
        }
        if (timer >= 60)
        {
            phase = 0;
            timer = 0;
            image_index = 0;
            imageCountDir = 1;
            if (hasSwitch)
            {
                global.flagParent[myFlag].active = false;
                global.flag[myFlag] = 0;
            }
        }
    }
}
else if (dead)
{
    phase = 0;
    timer = 0;
    image_index = 0;
    imageCountDir = 1;
    if (!is_undefined(global.flagParent[myFlag]) && instance_exists(global.flagParent[myFlag]))
    {
        global.flagParent[myFlag].active = false;
        global.flag[myFlag] = 0;
    }
}
