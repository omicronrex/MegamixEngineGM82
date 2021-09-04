#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

/// Switch handlers are timers that go from 0 to 1, they are stored in a global array and can be used for
// triggering other objects remotely

//@cc what id to use to connect to other switches
myFlag = 0;

//@cc How many frames it takes to turn on, set to 1 for instant
flagOnLength = 30;

//@cc How many frames it takes to turn off, set to 1 for instant
flagOffLength = 30;

//@cc binary means there's no delay when turning the flag on/off. 0 = neither, 1 = instant on, 2 = instant off
binary = 0;

//@cc 0 = stays on/off, 1 = turns on, 2 = turns off
//@cc note: the object will need to keep setting active to the oposite setting of this otherwise it will immediately turn off
stayActive = 0;

//@cc
inverse = false;

active = false;
alarm[0] = 1;
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.flag[myFlag] = 0;
global.flagParent[myFlag] = id;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.timeStopped)
{
    if (active)
    {
        // On
        if (stayActive == 2)
        {
            active = false;
        }

        if (binary == 1)
        {
            global.flag[myFlag] = 1 - inverse;
        }
        else
        {
            if (!inverse)
            {
                if (global.flag[myFlag] < 1)
                {
                    global.flag[myFlag] += 1 / flagOnLength;
                }
                else
                {
                    global.flag[myFlag] = 1;
                }
            }
            else
            {
                if (global.flag[myFlag] > 0)
                {
                    global.flag[myFlag] -= 1 / flagOnLength;
                }
                else
                {
                    global.flag[myFlag] = 0;
                }
            }
        }
    }
    else
    {
        // Off
        if (stayActive == 1)
        {
            active = true;
        }

        if (binary == 2)
        {
            global.flag[myFlag] = inverse;
        }
        else
        {
            if (!inverse)
            {
                if (global.flag[myFlag] > 0)
                {
                    global.flag[myFlag] -= 1 / flagOffLength;
                }
                else
                {
                    global.flag[myFlag] = 0;
                }
            }
            else
            {
                if (global.flag[myFlag] < 1)
                {
                    global.flag[myFlag] += 1 / flagOffLength;
                }
                else
                {
                    global.flag[myFlag] = 1;
                }
            }
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sprite_index, (image_number - 1) * (1 - global.flag[myFlag]), x, y);
