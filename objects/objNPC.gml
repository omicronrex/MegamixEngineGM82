#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// for tweaking its physics, use the creation code variables of prtEntity

// option[0-4] = "string here" (sets the option you can choose, anywhere between 1 to 5)
// option_text[0-4] = "string here" (sets the text they will say after choosing this option)
// option_script_on_talk_start[0-4] (script to execute after their dialogue starts upon choosing this option)
// option_script_on_talk_end[0-4] (script to execute after their dialogue finishes upon choosing this option)
event_inherited();

respawnRange = -1;
despawnRange = -1;

contactDamage = 0;
canHit = false;

active = false;

//@cc sets the name in their dialogue box
name = 'Volt Man';

//@cc sets the color of the name in their dialogue box
name_color = c_white;

//@cc sets the text in their dialogue box
text = 'I have nothing to say.';

//@cc sets the sprite used for the mugshot in the dialogue box
mugshot_sprite = sprMugshots;

//@cc the starting frame of the mugshot animation
mugshot_start = 0;

//@cc the ending frame of the mugshot animation
mugshot_end = 0;

//@cc the speed of the mugshot animation
mugshot_speed = 0;

// options;
for (i = 0; i <= 4; i += 1)
{
    option[i] = "";
    option_text[i] = "";
    option_script_on_talk_start[i] = 0;
    option_script_on_talk_end[i] = 0;
    option_code_on_talk_start[i] = "";
    option_code_on_talk_end[i] = "";
}

// idle animation:

//@cc sets the sprite they use for their idle animation) (becomes the default of all of the other animations if the rest aren't set
idle_sprite = sprite_index;

//@cc the starting frame of their idle animation
idle_start = 0;

//@cc the ending frame of their idle animation
idle_end = sprite_get_number(idle_sprite) - idle_start;

//@cc the speed of the idle animation
idle_speed = 0.1;

// idle talking:

//@cc sets the sprite of their talking animation (default is the same as the idle animation)
talk_sprite = sprVoltThrowShield;

//@cc the starting frame of their talking animation
talk_start = 0;

//@cc the ending frame of their talking animation
talk_end = sprite_get_number(talk_sprite) - talk_start;

//@cc the speed of the talk animation
talk_speed = idle_speed;

// collision

//@cc sets the mask used for collision (default: knight man)
mask = maskNPC;
mask_index = mask;
standardPhysics = true;

//@cc distance ahead that mega man checks when pressing up to talk
talk_distance = 12;

// details:

//@cc constantly turns to face the player as the player moves around
face_player = false;

//@cc even if face_player is true, will not turn to face if player is closer than this
face_player_distance = 8;

//@cc if true, turns towards the player when talked to, and returns to previous direction when done [unless face_player is true]
face_player_on_talk = true;

//@cc script to execute when talked to
script_on_talk_start = 0;

//@cc script to execute when finished talking
script_on_talk_end = 0;

//@cc code to execute when talked to
code_on_talk_start = "";

//@cc code to execute when finished talking
code_on_talk_end = "";

// private:

_prev_direction = 1;
prev_index = 0; // Used for mugshots

option_chosen = -1;
option_spoken = false;

_im = 0;

showarrow = 0;
npcID = id;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead)
{
    // Idle animation / facing the player (only stationary npcs)
    if (object_get_name(object_index) != "objNPCMobile")
    {
        if (face_player)
        {
            xtarg = x;
            if (instance_exists(target))
            {
                xtarg = target.x;
            }
            if (abs(x - xtarg) > face_player_distance)
            {
                calibrateDirection();
            }
        }
    }

    with (target) // Initiate talking
    {
        if (!playerIsLocked(PL_LOCK_PAUSE))
        {
            if (place_meeting(x + (other.talk_distance * image_xscale), y, other))
            {
                with (other)
                {
                    var talkable = ground;

                    if (!standardPhysics)
                    {
                        talkable++;
                    }

                    if (talkable)
                    {
                        if (global.keyUpPressed[other.playerID] && !other.climbing)
                        {
                            spawnTextBoxSingleString(name, name_color, text);
                            addMugshot(mugshot_sprite, mugshot_start, mugshot_end, mugshot_speed);
                            var i = 0;
                            while (option[i] != "" && i <= 4)
                            {
                                addChoice(i, option[i]);
                                i += 1;
                            }
                            active = true;
                            option_spoken = false;
                            _prev_direction = image_xscale;

                            if (face_player_on_talk)
                            {
                                calibrateDirection();
                            }

                            event_user(1); // start dialogue
                            global.frozen = 1;
                        }
                    }
                    else
                    {
                        arrowDraw = false;
                    }
                }
            }
        }
    }
}
if (!active)
{
    sprite_index = idle_sprite;
    if (!global.frozen)
    {
        animationLoop(idle_start, idle_end, idle_speed);
    }
}
else
{
    sprite_index = talk_sprite;
    animationLoop(talk_start, talk_end, talk_speed);
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// creation code setup stuff
if (string_length(name) > 27)
{
    name = string_copy(name, 0, 27);
}

// make custom idle sprites the default sprites for unset sprites
if (idle_sprite != sprVoltIdle)
{
    if (talk_sprite == sprVoltThrowShield)
    {
        talk_sprite = idle_sprite;
    }

    // Changes the sprite so we don't see the NPC as Volt Man.
    if (sprite_index == sprVoltIdle)
    {
        sprite_index = idle_sprite;
    }

    // set the mask
    if (mask != maskNPC)
    {
        mask_index = mask;
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// end dialogue

if (option_chosen != -1 && !option_spoken && option_text[option_chosen] != "")
{
    spawnTextBoxSingleString(name, name_color, option_text[option_chosen]);
    addMugshot(mugshot_sprite, mugshot_start, mugshot_end, mugshot_speed);
    with (objDialogueBox)
    {
        alarm[0] = 0;
        boxOffset = 0;
        showtext = 1;
        alarm[1] = 14;
        itext = ds_list_find_value(text, 0);
        image_index = other.prev_index;
    }
    option_spoken = true;
    if (option_script_on_talk_start[option_chosen] != 0)
        script_execute(option_script_on_talk_start[option_chosen]);

    if (option_code_on_talk_start[option_chosen] != "")
        stringExecutePartial(option_code_on_talk_start[option_chosen]);

    active = true;
    global.frozen = 1;
    // exit;
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// start dialogue
// sprite_index = talk_sprite;
// image_speed = talk_speed;
active = true;

if (script_on_talk_start != 0)
{
    script_execute(script_on_talk_start);
}

if (code_on_talk_start != "")
{
    stringExecutePartial(code_on_talk_start);
}
global.frozen = true;
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var canExecute = false;
var executeLocked = false;
if (option_text[0] != "" && option_spoken == true && !global.frozen && !executeLocked && !active)
{
    executeLocked = true;
    canExecute = true;
}
active = 0;
global.frozen = 0;

// return to previous orientation, whether it was the same or not -- unless face_player is true
if (!face_player)
{
    image_xscale = _prev_direction;
}

if (script_on_talk_end != 0 && option_chosen == -1)
    script_execute(script_on_talk_end);
else if (option_chosen != -1 && option_spoken && option_script_on_talk_end[option_chosen] != 0 && canExecute)
{
    script_execute(option_script_on_talk_end[option_chosen]);
}

if (code_on_talk_end != "" && option_chosen == -1)
    stringExecutePartial(code_on_talk_end);
else if (option_chosen != -1 && option_spoken && option_code_on_talk_end[option_chosen] != "" && canExecute)
{
    stringExecutePartial(option_code_on_talk_end[option_chosen]);
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
with (target) // Initiate talking
{
    if (!playerIsLocked(PL_LOCK_PAUSE))
    {
        if (place_meeting(x + (other.talk_distance * image_xscale), y, other))
        {
            with (other)
            {
                draw_sprite(sprPressUp, 0, bboxGetXCenter(), bbox_top - 12);
            }
        }
    }
}
