#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

isSolid = 1;

canHit = false;

num = -1;
pressed = false;
doIt = 0;

blockCollision = 0;
grav = 0;


respawnRange = -1;
despawnRange = -1;

image_index = 0;
image_speed = 0;



// entity specific variables
animationTimer = 0;
attackTimer = 0;
hasInit = false;
storageObjID = noone;

currentRotation = 0;
buttonNoPressed = 0;
buttonAmount = -1;
buttonPuzzle = -1;
randomList[0] = -1;
#define Alarm_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=shunt mega man off button if needed
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (collision_rectangle(x, y, x + 15, y + 15, objMegaman, false, false))
{
    if (other.sprite_index == sprMelodyResponseButton && gravDir == 1
        || (other.sprite_index == sprMelodyResponseButtonDown && gravDir == -1))
    {
        y += -8;
    }
    if (other.sprite_index == sprMelodyResponseButton && gravDir == -1
        || (other.sprite_index == sprMelodyResponseButtonDown && gravDir == 1))
    {
        y += +8;
    }
    if (other.sprite_index == sprMelodyResponseButtonLeft)
    {
        x += +8;
    }
    if (sprite_index == sprMelodyResponseButtonRight)
    {
        x += -8;
    }
}
#define Alarm_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=reset button state
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (object_index)
{
    hasInit = false;

    // pressed = false;
    buttonNoPressed = 0;
    currentRotation = 0;
    doIt = 0;
    if (attackTimer > 0)
        alarm[1] = 1;
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // give each button in existance its own number.
    var storeNum; storeNum = 0;

    with (objMelodyResponseButtonUp)
    {
        if (num == -1)
        {
            num = storeNum;
            storeNum+=1;
            buttonAmount = instance_number(objMelodyResponseButtonUp);
        }
    }

    // the first button in existance stores all variables needed to complete the puzzle.
    if (num == 0)
    {
        if (instance_exists(objMelodyResponseCannon))
        {
            with (instance_nearest(x, y, objMelodyResponseCannon))
            {
                if (allButtons)
                {
                    var useAllButtons; useAllButtons = true;
                    buttonsToPress = other.buttonAmount;
                }
                else
                {
                    var useAllButtons; useAllButtons = false;
                }
                other.buttonPuzzle = buttonsToPress;
            }
        }
        else
            with (instance_nearest(x, y, objMelodyResponseDoor)) // if not mini boss exists, grab variables from door.
            {
                if (allButtons)
                {
                    var useAllButtons; useAllButtons = true;
                    buttonsToPress = other.buttonAmount;
                }
                else
                {
                    var useAllButtons; useAllButtons = false;
                }
                other.buttonPuzzle = buttonsToPress;
            }

        var store0ID; store0ID = id;
        if (!hasInit) // initialize the puzzle
        {
            var e; for (e = 0; e < buttonPuzzle; e+=1) // setup list of variables
            {
                if (!useAllButtons)
                {
                    randomList[e] = irandom(buttonAmount - 1);
                }
                else
                {
                    randomList[e] = e;
                }
            }

            var i, j, k; // then randomise list
            for (i = 0; i < buttonPuzzle; i+=1)
            {
                j = irandom_range(i, buttonPuzzle - 1);
                if (i != j)
                {
                    k = randomList[i];
                    randomList[i] = randomList[j];
                    randomList[j] = k;
                }
            }
            hasInit = true;
        }

        if (instance_exists(objMelodyResponseCannon) || instance_exists(objMelodyResponseDoor)) // the buttons are only active whilst either a door or response cannon is in existance
        {
            attackTimer+=1;
        }

        if (attackTimer == 35 && currentRotation < buttonPuzzle) // flash buttons in sequence
        {
            var getListNumber; getListNumber = randomList[currentRotation];
            attackTimer = 0;
            playSFX(sfxGrabBuster);
            with (objMelodyResponseButtonUp)
            {
                if (num == getListNumber)
                {
                    animationTimer = 25;
                    pressed = false;
                    alarm[1] = 1;
                }
            }
            currentRotation+=1;
        }

        if (currentRotation == buttonPuzzle) // sequence complete, puzzle can now be attempted
        {
            with (objMelodyResponseButtonUp)
            {
                storageObjID = store0ID;
                hasInit = true;
            }
        }
    }

    // setup animation for buttons here
    if (animationTimer > 0)
    {
        image_index = (animationTimer / 4) mod 3;
        animationTimer-=1;
    }
    else
    {
        if (!pressed)
        {
            image_index = 0;
        }
    }

    if (image_index == 3) // setup collision masks depending on sprite state.
    {
        switch (sprite_index)
        {
            case sprMelodyResponseButton:
                mask_index = mskMelodyButton;
                break;
            case sprMelodyResponseButtonLeft:
                mask_index = mskMelodyButton2;
                break;
            case sprMelodyResponseButtonRight:
                mask_index = mskMelodyButton3;
                break;
            case sprMelodyResponseButtonDown:
                mask_index = mskMelodyButton4;
                break;
        }

        if (!collision_rectangle(x, y, x + 16, y + 16, objMegaman, false, false)) // if colliding with mega man, the buttons do not reset
        {
            pressed = false;
        }
    }
    else
    {
        mask_index = sprite_index;
    }

    if (instance_exists(storageObjID) && (instance_exists(objMelodyResponseCannon) || instance_exists(objMelodyResponseDoor))) // check for existance of various objects or else *CRASH*
    {
        // whilst all these are true, buttons can be pressed
        if (instance_exists(target) && storageObjID.currentRotation >= buttonPuzzle && storageObjID.attackTimer >= 36 && animationTimer == 0 && image_index == 0)
        {
            doIt = 0;
            with (objMegaman)
            {
                with (other) // depending on the sprite, determines what side the button can be pressed
                {
                    if ((sprite_index == sprMelodyResponseButton && other.gravDir == 1)
                        || (sprite_index == sprMelodyResponseButtonDown && other.gravDir == -1))
                    {
                        if (place_meeting(x, y - 1 * other.gravDir, other.id) && other.ground)
                        {
                            doIt = 1;
                        }
                    }
                    if ((sprite_index == sprMelodyResponseButtonDown && other.gravDir == 1)
                        || (sprite_index == sprMelodyResponseButton && other.gravDir == -1))
                    {
                        if (place_meeting(x, y + 2 * other.gravDir, other.id)) // && !other.target.ground
                        {
                            doIt = 1;
                        }
                    }
                    if (sprite_index == sprMelodyResponseButtonRight)
                    {
                        if (place_meeting(x - 1, y, other.id) && (other.xspeed > 0
                            || other.isSlide
                            || global.keyRight[other.playerID]))
                        {
                            doIt = 1;
                        }
                    }
                    if (sprite_index == sprMelodyResponseButtonLeft)
                    {
                        if (place_meeting(x + 1, y, other.id) && (other.xspeed < 0
                            || other.isSlide
                            || global.keyLeft[other.playerID]))
                        {
                            doIt = 1;
                        }
                    }
                }
            }
            if (doIt)
            {
                image_index = 3;
                var getNum; getNum = num;
                with (storageObjID)
                {
                    if (getNum != randomList[buttonNoPressed]) // if button pressed is wrong, play error sound and activate all melody response cannons
                    {
                        playSFX(sfxError);
                        attackTimer = -35;
                        alarm[2] = 1;
                        with (objMelodyResponseCannon)
                        {
                            attackTimer = 64;
                        }
                    }
                    else // otherwise add to variable stored
                    {
                        buttonNoPressed+=1;
                        if (buttonNoPressed == buttonPuzzle) // if entire sequence is entered, then defeat one melody response cannon
                        {
                            if (!instance_exists(objMelodyResponseCannon))
                            {
                                with (objMelodyResponseDoor) // or defeat the door if no cannons exist
                                {
                                    animTimer = 1;
                                    playSFX(sfxMenuSelect);
                                }
                            }
                            var mrc; mrc = instance_nearest(x, y, objMelodyResponseCannon);
                            with (mrc)
                            {
                                event_user(EV_DEATH);
                            }
                            alarm[2] = 1;
                            with (storageObjID)
                            {
                                attackTimer = -100;
                            }
                        }
                    }
                }
                if (!pressed) // one off variable to play button press sound
                {
                    playSFX(sfxCrashBombArm);
                    pressed = true;
                }
            }
        }
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 2;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// debug
/*
draw_set_colour(c_white);
draw_text(x,y,num);
draw_text(x+8,y,currentRotation);
*/
