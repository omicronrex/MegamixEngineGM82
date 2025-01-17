#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// drawing constants
optionXOrigin = 48;
optionYOrigin = 40;

optionXDist = 80;
optionYDist = 64;

stageTextXOffset = -32;
stageTextYOffset = 24;

// control variables
cursorX = 1;
cursorY = 1;

lockControls = false;

// drawing variables
cursorImgIndex = 0;
cursorImgSpd = 0.1;

staticImgIndex = 0;
staticImgSpd = 0.5;

// cutscene variables
phase = 0;
subPhase = 0;

timer = 0;
counter = 0;

bossX = 0;
bossY = 0;
bossXSpeed = 0;
bossYSpeed = 0;
bossGrav = gravAccel;
bossObject = noone;
bossObjectIntroFinished = false;
bossImageIndex = 0;
bossIntroName = ""; // automatically figures out string to display in the intro based on the stage name
bossIntroNameX = 0; /* text is centered but is drawn from left to right, so we need to know the left
                           position of the text when centered. This is automatically figured out */
bossXScale = 1;


bossIntroBorderRadius = 0;

flashOpacity = 0;

// menu selection variables
var i; for ( i = 0; i < 3; i+=1)
{
    var j; for ( j = 0; j < 4; j+=1)
    {
        stageRoom[i, j] = noone;
        stageIcon[i, j] = 10;
        stageName[i, j] = "";
        stageLock[i, j] = false;
        stageBeaten[i, j] = false;

        // for stage select intros
        stageBossJumpSprite[i, j] = noone;
        stageBossJumpIndex[i, j] = noone;
        stageBossIntroSprite[i, j] = noone;
        stageBossIntroSpeed[i, j] = noone;

        // use the boss object's own intro instead of the custom stage select one
        stageBossObject[i, j] = noone;
        stageBossObjectIntroType[i, j] = noone; // overwrites the intro type already set in the object
    }
}

// define stages
stageRoom[0, 0] = "lvlGutsMan"
stageIcon[0, 0] = 2;
stageName[0, 0] = " GUTS#    MAN";
stageBeaten[0, 0] = indexOf(global.elementsCollected, "guts") >= 0;
stageBossJumpSprite[0, 0] = sprGutsJump;
stageBossJumpIndex[0, 0] = 0;
stageBossIntroSprite[0, 0] = sprGutsIdle;
stageBossIntroSpeed[0, 0] = 0.1;

stageRoom[1, 0] = "lvlFlashMan"
stageIcon[1, 0] = 3;
stageName[1, 0] = " FLASH#    MAN";
stageBeaten[1, 0] = indexOf(global.elementsCollected, "flash") >= 0;
stageBossJumpSprite[1, 0] = sprFlashman;
stageBossJumpIndex[1, 0] = 6;
stageBossIntroSprite[1, 0] = sprFlashIntro;
stageBossIntroSpeed[1, 0] = 10 / 60;

stageRoom[2, 0] = "lvlGeminiMan";
stageIcon[2, 0] = 4;
stageName[2, 0] = " GEMINI#    MAN";
stageBeaten[2, 0] = indexOf(global.elementsCollected, "gemini") >= 0;
stageBossJumpSprite[2, 0] = sprGeminiJump;
stageBossJumpIndex[2, 0] = 0;
stageBossIntroSprite[2, 0] = sprGeminiIntro;
stageBossIntroSpeed[2, 0] = 16 / 60;

stageRoom[0, 1] = "lvlPharaohMan";
stageIcon[0, 1] = 5;
stageName[0, 1] = "PHARAOH#    MAN";
stageBeaten[0, 1] = indexOf(global.elementsCollected, "pharaoh") >= 0;
stageBossJumpSprite[0, 1] = sprPharaohJump;
stageBossJumpIndex[0, 1] = 0;
stageBossIntroSprite[0, 1] = sprPharaohPose;
stageBossIntroSpeed[0, 1] = 3 / 60;

stageRoom[2, 1] = "lvlStoneMan";
stageIcon[2, 1] = 6;
stageName[2, 1] = " STONE#    MAN";
stageBeaten[2, 1] = indexOf(global.elementsCollected, "stone") >= 0;
stageBossJumpSprite[2, 1] = sprStoneMan;
stageBossJumpIndex[2, 1] = 5;
stageBossIntroSprite[2, 1] = sprStoneManIntro;
stageBossIntroSpeed[2, 1] = 0.3;

stageRoom[0, 2] = "lvlPlantMan";
stageIcon[0, 2] = 7;
stageName[0, 2] = " PLANT#    MAN";
stageBeaten[0, 2] = indexOf(global.elementsCollected, "plant") >= 0;
stageBossJumpSprite[0, 2] = sprPlantJump;
stageBossJumpIndex[0, 2] = 0;
stageBossIntroSprite[0, 2] = sprPlantIntro;
stageBossIntroSpeed[0, 2] = 10 / 60;

stageRoom[1, 2] = "lvlHoneyWoman";
stageIcon[1, 2] = 8;
stageName[1, 2] = " HONEY#  WOMAN";
stageBeaten[1, 2] = indexOf(global.elementsCollected, "honey") >= 0;
stageBossJumpSprite[1, 2] = sprHoneyWoman;
stageBossJumpIndex[1, 2] = 11;
stageBossIntroSprite[1, 2] = sprHoneyWomanIntro;
stageBossIntroSpeed[1, 2] = 0.11;

stageRoom[2, 2] = "lvlChillMan";
stageIcon[2, 2] = 9;
stageName[2, 2] = " CHILL#    MAN";
stageBeaten[2, 2] = indexOf(global.elementsCollected, "chill") >= 0;
stageBossJumpSprite[2, 2] = sprChillJump;
stageBossJumpIndex[2, 2] = 0;
stageBossIntroSprite[2, 2] = sprChillIntro;
stageBossIntroSpeed[2, 2] = 6 / 60;

// Set center stage after grabbing all other indexes
stageRoom[1, 1] = "rmCastleIntro";
stageLock[1, 1] = !(stageBeaten[0, 0] && stageBeaten[1, 0] && stageBeaten[2, 0]
    && stageBeaten[0, 1] && stageBeaten[2, 1] && stageBeaten[0, 2]
    && stageBeaten[1, 2] && stageBeaten[2, 2]);
stageIcon[1, 1] = 11 - stageLock[1, 1];

// menu selections
stageRoom[0, 3] = "rmTitleScreen";
stageName[0, 3] = "MENU";

stageRoom[1, 3] = "rmShop";
stageName[1, 3] = "SHOP";

// convenience feature
global.livesRemaining = max(global.defaultLives, global.livesRemaining);

// save
saveLoadGame(true);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=other
*/
switch (phase)
{
    // controls
    default:
    case 0:
        if (!lockControls)
        {
            var xdir; xdir = 0;
            var ydir; ydir = 0;
            var pause; pause = 0;

            var i; for ( i = 0; i < global.playerCount; i += 1)
            {
                xdir += (global.keyRightPressed[i] - global.keyLeftPressed[i]);
                ydir += (global.keyDownPressed[i] - global.keyUpPressed[i]);
                pause += global.keyPausePressed[i];
            }

            // Move x and y-axis
            cursorY += ydir;
            cursorX += xdir;

            cursorY -= (array_length_2d(stageRoom, 0) * sign(cursorY)) * (cursorY < 0 || cursorY >= array_length_2d(stageRoom, 0));

            cursorX -= (cursorY == 3 && cursorX == 2);
            cursorX -= ((array_height_2d(stageRoom) - (cursorY == 3)) * sign(cursorX)) * (cursorX < 0 || cursorX >= (array_height_2d(stageRoom) - (cursorY == 3)));

            // upon changing position
            if (xdir != 0 || ydir != 0)
            {
                playSFX(sfxMenuMove);
                cursorImgIndex = 0; // make sure cursor appears in new location as soon as you change, or else it'll feel laggy
            }

            // selecting stage
            if (pause)
            {
                if (stageRoom[cursorX, cursorY] != noone && !stageLock[cursorX, cursorY])
                {
                    phase = 1;
                    lockControls = true;

                    stopMusic();
                    playSFX(sfxMenuSelect);
                }
                else
                {
                    playSFX(sfxError);
                }
            }
        }

        break;

    // white flash for a second when an option is picked
    case 1:
        if (timer >= 40)
        {
            flashOpacity = 0;

            if (stageBossObject[cursorX, cursorY] != noone || (stageBossJumpSprite[cursorX, cursorY] != noone
                && stageBossJumpIndex[cursorX, cursorY] != noone && stageBossIntroSprite[cursorX, cursorY] != noone
                && stageBossIntroSpeed[cursorX, cursorY] != noone))
            {
                if (!stageBeaten[cursorX, cursorY])
                {
                    // do boss intro
                    timer = 0;

                    if (stageBossJumpSprite[cursorX, cursorY] != noone && stageBossJumpIndex[cursorX, cursorY] != noone
                        && stageBossIntroSprite[cursorX, cursorY] != noone && stageBossIntroSpeed[cursorX, cursorY] != noone)
                    {
                        // custom stage select intro with variables
                        timer = 0;
                        phase = 2;

                        bossX = optionXOrigin + (optionXDist * cursorX);
                        bossY = optionYOrigin + (optionYDist * cursorY);
                        bossYSpeed = ySpeedAim(bossY, view_yview[0] + 32, bossGrav);
                        bossXSpeed = xSpeedAim(bossX, bossY, view_xview[0] + view_wview[0] / 2, view_yview[0] + view_hview[0] / 2 - 4, bossYSpeed, bossGrav);

                        bossXScale = 1;
                        if (bossX >= view_xview[0] + view_wview[0] / 2)
                        {
                            bossXScale = -1;
                        }
                    }
                    else
                    {
                        // stage intro with the boss object's intro
                        phase = 3;
                    }

                    bossIntroName = stageName[cursorX, cursorY];
                    bossIntroName = string_replace_all(bossIntroName, " ", ""); // get rid of the spaces that were just for aligning the stage select text
                    bossIntroName = string_replace_all(bossIntroName, "#", " "); // make newlines the spaces in the name

                    bossIntroNameX = view_xview[0] + view_wview[0] / 2 - (string_length(bossIntroName) * 8) / 2;

                    playMusic("Mega_Man_4.nsf", "VGM", 15, 0, 0, 0, 1);
                }
                else
                {
                    // already beaten level
                    var level; level = getRoom(stageRoom[cursorX, cursorY], "Levels/" + stageRoom[cursorX, cursorY])
                    goToLevel(level, true);
                }
            }
            else
            {
                // menu room
                global.nextRoom = getRoom(stageRoom[cursorX, cursorY]);
            }
        }
        else
        {
            // flashing
            timer+=1;
            flashOpacity = !(timer mod 6);
        }

        break;

    // stage intro using variables
    case 2:
        switch (subPhase)
        {
            // boss jumps to center + intro bg strip
            case 0: // fade bg out to white
                flashOpacity += (1 / 30);
                if (flashOpacity >= 1)
                {
                    flashOpacity = 1;

                    tile_layer_hide(1000000);

                    // show starfield
                    background_visible[1] = true;
                    background_visible[2] = true;
                    background_visible[3] = true;
                }

                var maxRadius; maxRadius = 42;
                bossIntroBorderRadius = min(bossIntroBorderRadius + 3, maxRadius);

                if (bossY >= view_yview[0] + view_hview[0] / 2 && bossYSpeed > 0)
                {
                    bossX = view_xview[0] + view_wview[0] / 2;
                    bossY = view_yview[0] + view_hview[0] / 2;
                    bossYSpeed = 0;
                }
                else
                {
                    bossX += bossXSpeed;
                    bossY += bossYSpeed;
                    bossYSpeed += bossGrav;
                }

                if (bossIntroBorderRadius == maxRadius && bossX == view_xview[0] + view_wview[0] / 2 && bossY == view_yview[0] + view_hview[0] / 2)
                {
                    subPhase+=1;
                }

                break;

            // boss intro animation + fade into star field + boss name
            case 1:
                timer+=1;

                // fade into starfield
                flashOpacity -= min(flashOpacity, (1 / 25));

                // boss animation
                if (timer >= 8)
                {
                    bossImageIndex = min(bossImageIndex + stageBossIntroSpeed[cursorX, cursorY], sprite_get_number(stageBossIntroSprite[cursorX, cursorY]) - 1);
                }

                // type text
                if (timer >= 80)
                {
                    if (counter < string_length(bossIntroName)) // after star field is fully in view
                    {
                        if (!(timer mod 12))
                        {
                            counter+=1; // counter is the amount of characters shown, which is used in the draw event

                            // only play typing sfx if typing a letter and not a space
                            if (string_copy(bossIntroName, counter, 1) != " ")
                            {
                                playSFX(sfxReflect);
                            }
                        }
                    }
                }

                // go to the stage
                if (timer >= 400)
                {
                    var level; level = getRoom(stageRoom[cursorX, cursorY], "Levels/" + stageRoom[cursorX, cursorY])
                    goToLevel(level, true);

                    // nothing is reset here since the object is going to get deleted upon room switch
                }

                break;
        }

        break;

    // stage intro using the boss object
    case 3:
        switch (subPhase)
        {
            // spawn boss object + intro bg strip
            case 0: // fade bg out to white
                flashOpacity += (1 / 30);
                if (flashOpacity >= 1)
                {
                    flashOpacity = 1;

                    tile_layer_hide(1000000);

                    // show starfield
                    background_visible[1] = true;
                    background_visible[2] = true;
                    background_visible[3] = true;
                }

                var maxRadius; maxRadius = 42;
                bossIntroBorderRadius = min(bossIntroBorderRadius + 3, maxRadius);

                // spawn boss object
                if (bossObject == noone && bossIntroBorderRadius == maxRadius)
                {
                    bossObject = instance_create(view_xview[0] + view_wview[0] / 2, view_yview[0] + view_hview[0] / 2 - 4, stageBossObject[cursorX, cursorY]);
                    bossObject.music = "";

                    // setup boss object
                    bossObject.active = true;
                    bossObject.drawBoss = true;
                    bossObject.startIntro = true;

                    if (stageBossObjectIntroType[cursorX, cursorY] != noone)
                    {
                        bossObject.introType = stageBossObjectIntroType[cursorX, cursorY];
                    }

                    global.aliveBosses = 1; // Used for multiple bosses being around.

                    with (prtBoss)
                    {
                        if (id != other.bossObject.id && (!dead || active))
                        {
                            global.aliveBosses += 1;
                        }
                    }

                    if (bossObject.healthIndex == -1)
                    {
                        bossObject.healthIndex = global.aliveBosses; // used to track healthbars
                    }

                    // create solids for the boss to stand on
                    for (i = view_xview[0]; i < view_xview[0] + view_wview[0]; i += 16)
                    {
                        instance_create(i, bossObject.bbox_bottom, objSolid);
                    }
                }

                if (flashOpacity >= 1 && bossObject != noone)
                {
                    subPhase+=1;
                }

                break;

            // boss intro animation + fade into star field + boss name
            case 1:
                timer+=1;

                // fade into starfield
                flashOpacity -= min(flashOpacity, (1 / 25));

                // type text
                if (timer >= 80)
                {
                    if (counter < string_length(bossIntroName)) // after star field is fully in view
                    {
                        if (!(timer mod 12))
                        {
                            counter+=1; // counter is the amount of characters shown, which is used in the draw event

                            // only play typing sfx if typing a letter and not a space
                            if (string_copy(bossIntroName, counter, 1) != " ")
                            {
                                playSFX(sfxReflect);
                            }
                        }
                    }
                }

                // go to the stage
                if (bossObjectIntroFinished && timer >= 400)
                {
                    var level; level = getRoom(stageRoom[cursorX, cursorY], "Levels/" + stageRoom[cursorX, cursorY])
                    goToLevel(level, true);

                    // nothing is reset here since the object is going to get deleted upon room switch
                }

                break;
        }

        break;
}

// animation
cursorImgIndex = (cursorImgIndex + cursorImgSpd) mod 2;
staticImgIndex = (staticImgIndex + staticImgSpd) mod 3;
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Check if the boss object has finished its intro + prevent healthbar filling
if (instance_exists(bossObject))
{
    if (!bossObject.isIntro && !bossObject.startIntro)
    {
        bossObject.canFillHealthBar = false;
        bossObjectIntroFinished = true;
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_halign(fa_left);
draw_set_valign(fa_top);

if (!background_visible[1])
{
    // draw selections
    var i; for ( i = 0; i < array_height_2d(stageRoom); i+=1)
    {
        var j; for ( j = 0; j < array_length_2d(stageRoom, i); j+=1)
        {
            var xs; xs = view_xview[0] + optionXOrigin + (optionXDist * (i + (j >= 3) * 0.5));
            var ys; ys = view_yview[0] + optionYOrigin + (optionYDist * j);

            if (j < 3) // draw mugshot
            {
                if (stageIcon[i, j] != noone)
                {
                    var img; img = stageIcon[i, j];
                    if (stageBeaten[i, j])
                    {
                        img = floor(12 + staticImgIndex);
                    }
                    draw_sprite(sprMugshots, img, xs - sprite_get_width(sprMugshots) / 2, ys - sprite_get_height(sprMugshots) / 2);
                }

                if (stageName[i, j] != "") // draw name
                {
                    draw_text(xs + stageTextXOffset, ys + stageTextYOffset, stageName[i, j]);
                }
            }
            else if (stageName[i, j] != "") // draw option
            {
                draw_text(xs - 16, ys - 16, stageName[i, j]);
            }

            if (cursorX == i && cursorY == j) // draw cursor
            {
                draw_sprite(sprStageSelectCursor, cursorImgIndex, xs, ys);
            }
        }
    }

    draw_set_halign(fa_middle);

    draw_text(view_xview + 128, view_yview + 4, "PRESS START");
}

// flash
draw_sprite_ext(sprDot, 0, view_xview[0], view_yview[0], view_wview[0], view_hview[0], 0, c_white, roundTo(flashOpacity, 1 / 8));

if (phase >= 2)
{
    // boss intro strip bg
    draw_sprite_ext(sprDot, 0, view_xview[0], view_yview[0] + view_hview[0] / 2 - bossIntroBorderRadius, view_wview[0], bossIntroBorderRadius * 2, 0, make_colour_rgb(120, 8, 0), 1);

    // boss intro strip border
    draw_sprite_part(sprMM8BossIntroBorder, 0, 0, 0, 256, min(10, bossIntroBorderRadius), view_xview[0], view_yview[0] + view_hview[0] / 2 - bossIntroBorderRadius);
    draw_sprite_part(sprMM8BossIntroBorder, 1, 0, max(0, 10 - bossIntroBorderRadius), 256, bossIntroBorderRadius, view_xview[0], view_yview[0] + view_hview[0] / 2 + (bossIntroBorderRadius - 10) * (bossIntroBorderRadius > 10));

    // boss sprite and text
    if (phase == 2 && subPhase == 0)
    {
        // jump
        draw_sprite_ext(stageBossJumpSprite[cursorX, cursorY], stageBossJumpIndex[cursorX, cursorY], bossX, bossY, bossXScale, 1, 0, c_white, 1);
    }

    if (subPhase == 1)
    {
        // intro
        if (phase == 2)
        {
            draw_sprite_ext(stageBossIntroSprite[cursorX, cursorY], bossImageIndex, bossX, bossY, bossXScale, 1, 0, c_white, 1);
        }

        // boss name
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_text(bossIntroNameX, view_xview[0] + view_hview[0] / 2 + 20, string_copy(bossIntroName, 0, counter));
    }
}
