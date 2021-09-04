#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Same as objNPC but in motion
// option[0-4] = "string here" (sets the option you can choose, anywhere between 1 to 5)
// option_text[0-4] = "string here" (sets the text they will say after choosing this option)

name = 'Knight Man';

event_inherited();

// behaviours
behaviour = "wander";
avoidsPits = true;

jumps_pits = true;
ignores_pits = false;
avoidsPits = true;

//@cc sets how fast they move around
move_speed = noone; // gets defaulted in step code on first frame

//@cc the speed they jump up with
jump_speed = -4.8;

// animation:
idle_sprite = sprNPCKnightmanIdle;
talk_sprite = idle_sprite;

//@cc sets the sprite that's used for their walking animation (default is the same as the idle animation)
walk_sprite = sprNPCKnightmanWalk;

//@cc sets the sprite that's use for their jumping animation (default is the same as the idle animation)
jump_sprite = sprNPCKnightmanJump;

//@cc the starting frame of their walking animation
walk_start = 0;

//@cc the ending frame of their walking animation
walk_end = sprite_get_number(walk_sprite) - walk_start;

//@cc the speed of the walk animation
walk_speed = idle_speed;

//@cc the only frame for their jump animation (can't have it animated)
jump_start = 0;

only_jumps = false;

// private:
mode = 0;
mode_timer = 0;
mode_timer_end = 0;
standardPhysics = false;
despawnRange = 700000;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

image_speed = 0;

var sec_left, sec_right;
sec_left = 0;
sec_right = room_width;

if (!global.frozen && !global.timeStopped && !dead)
{
    // select behaviour:
    mode_timer += 1;
    if (mode_timer > mode_timer_end && ground)
    {
        mode_timer = 0;
        if (behaviour == "restless")
        {
            if (mode == 0)
            {
                mode = 1;
            }
            else
            {
                mode = 0;
            }
            mode_timer_end = 15 + random(25) + random(170);
            if (mode == 0 && mode_timer_end > 100)
            {
                mode_timer_end = 100;
            }
            image_xscale = irandom(1) * 2 - 1;
        }
        else if (behaviour == "wander")
        {
            if (mode == 0)
            {
                mode = 1;
            }
            else
            {
                mode = 0;
            }
            if (mode == 0)
            {
                mode_timer_end = 100 + random(2000);
            }
            else
            {
                mode_timer_end = 100 + random(300);
            }
            image_xscale = irandom(1) * 2 - 1;
        }
        else if (behaviour == "patrol")
        {
            if (mode == 0)
            {
                mode = 1;
            }
            else
            {
                mode = 0;
            }
            if (mode == 0)
            {
                mode_timer_end = 20 + random(150);
            }
            else
            {
                mode_timer_end = 1000 + random(2000);
            }
            if (random(2) > 1.4)
            {
                image_xscale = irandom(1) * 2 - 1;
            }
        }
        else if (behaviour == "nostop")
        {
            mode = 1; // never stops; only turns around at obstacles
        }
    }

    switch (mode)
    {
        case 0: // idle:
            xspeed = 0;
            sprite_index = idle_sprite;
            animationLoop(idle_start, idle_end, idle_speed);
            if (face_player)
            {
                calibrateDirection();
            }
            break;
        case 1: // walk
            if (!only_jumps)
            {
                xspeed = image_xscale * move_speed;
                sprite_index = walk_sprite;
                animationLoop(walk_start, walk_end, walk_speed);
            }
            else
            {
                // hops around; in-between, stands still
                sprite_index = idle_sprite;
                animationLoop(idle_start, idle_end, idle_speed);
                if (!ground)
                {
                    xspeed = image_xscale * move_speed;
                }
                if (ground)
                {
                    xspeed = 0;
                }
            }
            if (!ground)
            {
                // jumping animation
                sprite_index = jump_sprite;
                image_index = jump_start;
            }
            if (ground && checkSolid(0, 2))
            {
                // note -- moving platforms and jumpthrough platforms not resolved.
                if (instance_exists(target))
                {
                    sec_left = global.sectionLeft;
                    sec_right = global.sectionRight;
                }

                // reason about terrain
                if ((x + xspeed * 7 <= sec_left)
                    || (x + xspeed * 7 >= sec_right))
                {
                    // about to go off edge of screen
                    xspeed = 0;
                    mode = 0;
                    if (ground)
                    {
                        image_xscale *= -1;
                    }
                }
                else if (checkSolid(xspeed * 18, 0))
                {
                    // see if it is possible to jump
                    // wall in front
                    doJump = false;
                    for (i = 0; i <= 48; i += 8)
                    {
                        if (!checkSolid(xspeed * 18, -i))
                        {
                            doJump = true;
                        }
                    }
                    if (doJump)
                    {
                        yspeed = -abs(jump_speed);
                    }
                    else
                    {
                        image_xscale *= -1;

                        // stop if we're close to stopping
                        if (abs(mode_timer_end - mode_timer) < 50)
                        {
                            mode_timer += 50;
                        }
                    }
                }
                else if (!checkSolid(sprite_width / 2.2, 24))
                {
                    // pitfall detected
                    if (jumps_pits)
                    {
                        if (!avoidsPits || ignores_pits
                            || checkSolid(56 * xspeed, 64)
                            || checkSolid(43 * xspeed, 36)
                            || checkSolid(32 * xspeed, 8))
                        {
                            // pit; jump over it
                            yspeed = -abs(jump_speed);
                        }
                        else // turn around at pit:
                        {
                            image_xscale *= -1;
                        }
                    }
                    else if (avoidsPits && !ignores_pits)
                    {
                        image_xscale *= -1;
                    }
                }
            }

            // hopping logic:
            if (ground && yspeed >= 0 && only_jumps && checkSolid(32 * xspeed, 8))
            {
                if (mode_timer mod 140 == 30)
                {
                    yspeed = -abs(jump_speed);
                }
            }
            break;
    }
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
if (idle_sprite != sprNPCKnightmanIdle)
{
    if (talk_sprite == sprNPCKnightmanIdle)
    {
        talk_sprite = idle_sprite;
    }
    if (walk_sprite == sprNPCKnightmanWalk)
    {
        walk_sprite = idle_sprite;
    }
    if (jump_sprite == sprNPCKnightmanJump)
    {
        jump_sprite = idle_sprite;
    }
}

if (move_speed == noone)
{
    if (behaviour == "wander")
    {
        move_speed = 0.4;
    }
    else
    {
        move_speed = 1.05;
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// end dialogue
event_inherited();

active = false;
image_xscale = _prev_direction;
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// start dialogue
event_inherited();

sprite_index = talk_sprite;
image_speed = talk_speed;
