#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed = 0;

// Path detection
path = 0;
dots = 0;
setup = 1;

xs = 0;
ys = 0;

xm = objWilyCastleStart.x;
ym = objWilyCastleStart.y;

linem[0] = -1;
linex[0] = -1;
liney[0] = -1;

// Cutscene control
alarm[0] = 1;

skipped = 0;
started = 0;
drawspath = 0;

counter = 0;

cutscene = -1;

// Levels
level[1] = getRoom("lvlMM5Dark1", "Levels/lvlMM5Dark1");
level[2] = getRoom("lvlMM4Wily1", "Levels/lvlMM4Wily1");
level[3] = getRoom("lvlMM9Wily3", "Levels/lvlMM9Wily3");
level[4] = getRoom("lvlMM6MrX4", "Levels/lvlMM6MrX4");
level[5] = getRoom("lvlMM10Wily4", "Levels/lvlMM10Wily4");

// Energy element grabbing setting stuff
global.castleStagesBeaten = (indexOf(global.elementsCollected, "wily1") >= 0)
    + (indexOf(global.elementsCollected, "wily2") >= 0)
    + (indexOf(global.elementsCollected, "wily3") >= 0)
    + (indexOf(global.elementsCollected, "wily4") >= 0)
    + (indexOf(global.elementsCollected, "wily5") >= 0);
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// failsafe
if (global.castleStagesBeaten >= 5)
{
    stopMusic();
    global.nextRoom = rmCredits;
}

cutscene += 1;

switch (cutscene)
{
    case 0: // Start
        alarm[0] = 420;
        break;
    case 1: // Dark
        image_index = 1;
        alarm[0] = 5;
        break;
    case 2: // First Flash
        background_color = c_white;
        alarm[0] = 10;
        break;
    case 3: // First Flash stop
        background_color = c_black;
        alarm[0] = 10;
        break;
    case 4: // Second Flash
        background_color = c_white;
        alarm[0] = 10;
        break;
    case 5: // Second Flash stop
        background_color = c_black;
        alarm[0] = 10;
        break;
    case 6: // Third Flash
        background_color = c_white;
        alarm[0] = 10;
        break;
    case 7: // Third Flash stop
        background_color = c_black;
        alarm[9] = 10;
        break;
}
#define Alarm_9
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Make dark / show dots
image_index = 1;
drawspath = 1;

alarm[10] = 96;
#define Alarm_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Progress Path
if (!started)
{
    loopSFX(sfxCastlePath);
    started = 1;
}

counter += 1;
if (counter >= path)
{
    audio_stop_sound(sfxCastlePath);
    alarm[11] = 100;
    alarm[10] = 0;
}
else
{
    alarm[10] = 4;
}
#define Alarm_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Go to level

goToLevel(level[global.castleStagesBeaten + 1]);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (setup)
{
    repeat (1)
    {
        var prexs = xs;
        var preys = ys;

        // Move
        xm += xs * 8;
        ym += ys * 8;

        // Decide what direction
        var i = collision_rectangle(xm + 1, ym + 1, xm + 6, ym + 6, objWilyCastleArrow, false, false);
        if (i)
        {
            direction = i.image_angle;
        }

        xs = ((direction == 0) - (direction == 180));
        ys = ((direction == 270) - (direction == 90));

        linem[path] = 0;

        var i = collision_rectangle(xm + 1, ym + 1, xm + 6, ym + 6, objWilyCastleDot, false, false);
        if (!i)
        {
            if (xs != 0)
            {
                if (prexs == xs)
                {
                    linem[path] = 1;
                }
                else if (preys != 0)
                {
                    linem[path] = 3 + (xs > 0) + (preys > 0) * 2;
                }
            }
            if (ys != 0)
            {
                if (preys == ys)
                {
                    linem[path] = 2;
                }
                else if (prexs != 0)
                {
                    linem[path] = 3 + (prexs < 0) + (ys < 0) * 2;
                }
            }
        }
        else
        {
            dots++;

            // sets start of path
            if (dots == global.castleStagesBeaten)
            {
                counter = path;
            }

            // sets end of path
            if (dots == global.castleStagesBeaten + 1)
            {
                setup = 0;
                i.image_speed = 0.1;
            }
        }

        if (linem[path])
        {
            linex[path] = xm;
            liney[path] = ym;
        }

        path++;

        if (!setup)
        {
            exit;
        }
    }

    // 1 -
    // 2 |
    // 3 -\
    // 4 /-
    // 5 -/
    // 6 \-
}
else
{
    // skipping it
    if (!skipped)
    {
        if (global.keyPause[0])
        {
            skipped = 1;
            for (i = 0; i <= 11; i += 1)
            {
                alarm[i] = -1;
            }
            audio_stop_all();
            background_color = c_black;

            alarm[11] = 1 + drawspath * 16;
            counter = path;
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
drawSelf();

if (drawspath)
{
    for (var i = 1; i < counter; i++)
    {
        if (linem[i])
        {
            draw_sprite(sprWilyCastlePath, linem[i] - 1, linex[i], liney[i]);
        }
    }

    with (objWilyCastleDot)
    {
        drawSelf();
    }
}
