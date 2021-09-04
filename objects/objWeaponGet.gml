#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// variables

controlsLocked = true;

selection = 0;

optionText[0] = "Return to Menu";
optionText[1] = "Try Again";

global.checkpoint = false;
global.livesRemaining = max(global.defaultLives, global.livesRemaining);

playMusic("Mega_Man_3.nsf", "VGM", 53, 0, 0, true, 1);

fadeInTimer = 120;
rewardTimer = 0;
spinSpeed = 10 / 40;
spinFrame = 0;
rewardN = 0;
currentReward = 0;
flashTimer = 0;
textTick = 6;
textTimer = 0;
finalFadeOut = false;
var i; for (i = 1; i < array_length_1d(global.levelReward); i+=1)
{
    reward[rewardN] = global.levelReward[i]; rewardN+=1
    setWeaponLocked(global.levelReward[i], false);
}

global.levelReward = makeArray(0);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// advance animation
weaponObject = reward[currentReward];
weapon = ds_map_get(global.weaponID,weaponObject);
rewardText = "YOU GOT " + global.weaponName[weapon] + ".";

if (finalFadeOut)
{
    // nothing
}
else if (fadeInTimer > 0)
{
    fadeInTimer-=1;
}
else
{
    rewardTimer+=1;
    if (rewardTimer > 120)
    {
        flashTimer+=1;
        spinSpeed = decreaseMagnitude(spinSpeed - 8 / 60, 0.01) + 8 / 60;
    }
    else
    {
        spinSpeed = decreaseMagnitude(spinSpeed - 12 / 60, 0.01) + 12 / 60;
    }
    if (flashTimer > 68)
    {
        flashTimer = 68;
        textTimer+=1;
        if (textTimer div textTick > string_length(rewardText) + 2)
        {
            controlsLocked = false;
        }
    }
}


/// controls

if (!controlsLocked)
{
    var selected; selected = false;
    var i; for (i = 0; i < global.playerCount; i+=1)
    {
        selected = selected || global.keyPausePressed[i];
    }

    // select an option
    if (selected)
    {
        if (currentReward == rewardN - 1)
        {
            // go home:
            returnFromLevel();
            controlsLocked = true;
            finalFadeOut = true;
            playSFX(sfxMenuSelect);
        }
        else
        {
            currentReward+=1;
            rewardTimer = 0;
            flashTimer = 0;
            textTimer = 0;
        }
    }
}

spinFrame += spinSpeed;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var i; for ( i = 0; i < global.playerCount; i+=1)
{
    var drawX; drawX = x + i * 24 - (global.playerCount - 1) * 12;
    var drawY; drawY = y - 16;
    var p; p = clamp(roundTo((fadeInTimer) / 45, 1 / 3), 0, 1);

    // determine weapon colours
    var cp, cs, ap, as; ap = 1; as = 1;
    var wpn; wpn = 0;
    if (flashTimer mod 10 < 5)
    {
        if (currentReward != 0)
        {
            wpn = ds_map_get(global.weaponID,reward[currentReward - 1]);
        }
    }
    else
    {
        wpn = ds_map_get(global.weaponID,reward[currentReward]);
    }

    if (global.weaponPrimaryColor[wpn] < 0)
    {
        ap = 0;
        cp = 0;
    }
    else
    {
        cp = global.weaponPrimaryColor[wpn];
    }

    if (global.weaponSecondaryColor[wpn] < 0)
    {
        as = 0;
        cs = 0;
    }
    else
    {
        cs = global.weaponSecondaryColor[wpn];
    }

    // draw player
    drawCostume(global.playerSprite[i], floor(spinFrame) mod 10, 11, drawX, drawY, 1, 1, c_white, cp, cs, c_black, 1, ap, as, 1);

    // fade darken
    drawCostume(global.playerSprite[i], floor(spinFrame) mod 10, 11, drawX, drawY, 1, 1, c_black, c_black, c_black, c_black, p, 0, 0, 0);
}

clearDrawState();

if (textTimer > 0)
{
    draw_text(view_wview[0] / 2 - string_width(rewardText) / 2, view_hview[0] - 32, stringSubstring(rewardText, 1, 1 + textTimer div textTick));
}
