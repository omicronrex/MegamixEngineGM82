#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed = 0;

// contants
iconsXOffset = 52 + 12;
iconsYOffset = 24;
iconsXSpacing = 52;
iconsYSpacing = 34;

priceXOffset = iconsXOffset;
priceYOffset = iconsYOffset + 16;

nameXOffset = 0;
nameYOffset = 176;

descriptionXOffset = nameXOffset + 16;
descriptionYOffset = nameYOffset + 16;

boltIconXOffset = 30;
boltIconYOffset = 97;
boltCounterXOffset = boltIconXOffset + 18;
boltCounterYOffset = boltIconYOffset + 8;

playersXOffset = 224;
playersYOffset = 144;
playersXSpacing = 24;

menuWidth = 3;
menuHeight = 2;

quickScrollWait = 25; // how long until quick scroll activates
quickScrollStutter = 8; // how long the cursor pauses before moving again while quick scrolling

// variables
cursorX = 0;
cursorY = 0;
cursorImgIndex = 0;
cursorImgSpd = 0.2;

horizontalQuickScrollTimer = quickScrollWait;
verticalQuickScrollTimer = quickScrollWait;

displayBolts = global.bolts;
targetBolts = displayBolts;

lockControls = false;

// initialize arrays
for (i = 0; i < menuWidth; i+=1)
{
    for (j = 0; j < menuHeight; j+=1)
    {
        itemUnavailable[i, j] = 0; // 0 = available, 1 = sold out, 2 = hidden
        itemIcon[i, j] = noone;
        itemPrice[i, j] = noone;
        itemName[i, j] = noone;
        itemDescription[i, j] = noone;
        //itemPurchaseAction[i, j] = ""; // put arbitrary code here. Note that stringExecutePartial cannot handle a lot of GML functions.
    }
}

// setup shop contents
itemUnavailable[0, 0] = global.livesRemaining >= global.maxLives; // cannot buy lives if you have max
itemIcon[0, 0] = sprLife;
itemPrice[0, 0] = 20;
itemName[0, 0] = "Life";
itemDescription[0, 0] = "Gives you an extra try at beating a stage."
//itemPurchaseAction[0, 0] = "global.livesRemaining+=1; if (global.livesRemaining >= global.maxLives) { itemUnavailable[0, 0] = 1; }";

itemUnavailable[1, 0] = global.energySaver > 0;
itemIcon[1, 0] = sprEnergySaver;
itemPrice[1, 0] = 200;
itemName[1, 0] = "Energy Saver";
itemDescription[1, 0] = "Lowers the amount of weapon energy that's consumed when using weapons."
//itemPurchaseAction[1, 0] = "global.energySaver = true; itemUnavailable[1, 0] = 1;";

itemUnavailable[2, 0] = global.weaponLocked[ds_map_get(global.weaponID,objRushCycle)] == 0;
itemIcon[2, 0] = sprRushBikeShopIcon;
itemPrice[2, 0] = 100;
itemName[2, 0] = "Rush Bike";
itemDescription[2, 0] = "Turns rush into a motorcycle, allowing you to travel at high speeds!";
//itemPurchaseAction[2, 0] = "global.weaponLocked[global.weaponID[? objRushCycle]] = false; itemUnavailable[2, 0] = true;";

itemUnavailable[0, 1] = global.eTanks >= global.maxETanks;
itemIcon[0, 1] = sprETank;
itemPrice[0, 1] = 30;
itemName[0, 1] = "E-Tank";
itemDescription[0, 1] = "Completely refills your health upon use.";
//itemPurchaseAction[0, 1] = "global.eTanks+=1; if (global.eTanks >= global.maxETanks) { itemUnavailable[0, 1] = 1; }";

itemUnavailable[1, 1] = global.wTanks >= global.maxWTanks;
itemIcon[1, 1] = sprWTank;
itemPrice[1, 1] = 30;
itemName[1, 1] = "W-Tank";
itemDescription[1, 1] = "Completely refills the energy of all of your weapons upon use.";
//itemPurchaseAction[1, 1] = "global.wTanks+=1; if (global.wTanks >= global.maxWTanks) { itemUnavailable[1, 1] = 1; }";

itemUnavailable[2, 1] = global.mTanks >= global.maxMTanks;
itemIcon[2, 1] = sprMTank;
itemPrice[2, 1] = 50;
itemName[2, 1] = "M-Tank";
itemDescription[2, 1] = "Completely refills both your health and the energy for all of your weapons upon use."
//itemPurchaseAction[2, 1] = "global.mTanks+=1; if (global.mTanks >= global.maxMTanks) { itemUnavailable[2, 1] = 1; }";;


// hacky way to make sure the player palettes are set
for (i = 0; i < global.playerCount; i+=1)
{
    instance_create(0, 0, objMegaman);
}

with (objMegaman)
{
    instance_destroy();
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen)
{
    // controls
    xDir = global.keyRightPressed[0] - global.keyLeftPressed[0];
    yDir = global.keyDownPressed[0] - global.keyUpPressed[0];

    cursorX += xDir;
    cursorY += yDir;

    if (cursorX < 0)
    {
        cursorX += menuWidth
    }

    if (cursorX >= menuWidth)
    {
        cursorX -= menuWidth;
    }

    if (cursorY < 0)
    {
        cursorY += menuHeight;
    }

    if (cursorY >= menuHeight)
    {
        cursorY -= menuHeight;
    }

    if (xDir != 0 || yDir != 0)
    {
        playSFX(sfxMenuMove);
    }

    // doing menu selections
    if (global.keyPausePressed[0])
    {
        if (global.bolts >= itemPrice[cursorX, cursorY] && itemUnavailable[cursorX, cursorY] == 0)
        { // buy the item
            if (cursorX == 0 && cursorY == 0)
            { // life
                global.livesRemaining+=1;
                if (global.livesRemaining >= global.maxLives)
                {
                    itemUnavailable[0, 0] = 1;
                }
            }
            else if (cursorX == 1 && cursorY == 0)
            { // energy saver
                global.energySaver = true;
                itemUnavailable[1, 0] = 1;
            }
            else if (cursorX == 2 && cursorY == 0)
            { // rush cycle
                global.weaponLocked[ds_map_get(global.weaponID,objRushCycle)] = false;
                itemUnavailable[2, 0] = true;
            }
            else if (cursorX == 0 && cursorY == 1)
            { // etank
                global.eTanks+=1;
                if (global.eTanks >= global.maxETanks)
                {
                    itemUnavailable[0, 1] = 1;
                }
            }
            else if (cursorX == 1 && cursorY == 1)
            { // wtank
                global.wTanks+=1;
                if (global.wTanks >= global.maxWTanks)
                {
                    itemUnavailable[1, 1] = 1;
                }
            }
            else if (cursorX == 2 && cursorY == 1)
            { // mtank
                global.mTanks+=1;
                if (global.mTanks >= global.maxMTanks)
                {
                    itemUnavailable[2, 1] = 1;
                }
            }

            //stringExecutePartial(itemPurchaseAction[cursorX, cursorY]);

            global.bolts -= itemPrice[cursorX, cursorY];
            targetBolts = global.bolts;
            playSFX(sfxMenuSelect);
        }
        else if (itemUnavailable[cursorX, cursorY] != 2)
        { // unable to buy the item
            playSFX(sfxError);
        }
    }

    // roll bolt counter
    if (displayBolts > targetBolts)
    {
        displayBolts-=1;
    }
    else if (displayBolts < targetBolts)
    { // lol I'm sure someone will do an item that costs negative bolts    :P
        displayBolts+=1;
    }

    // exit
    if (global.keyShootPressed[0])
    {
        lockControls = true;
        global.nextRoom = rmStageSelect;
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// bolt counter
draw_sprite(sprBoltBig, 0, view_xview[0] + boltIconXOffset, view_yview[0] + boltIconYOffset);
draw_set_valign(fa_top);
draw_text(view_xview[0] + boltCounterXOffset, view_yview[0] + boltCounterYOffset, string_pad(displayBolts, 4));

// shop info
for (i = 0; i < menuWidth; i+=1)
{
    for (j = 0; j < menuHeight; j+=1)
    {
        if (itemUnavailable[i, j] < 2)
        {
            // item icon
            if (itemIcon[i, j] != noone)
            {
                draw_sprite(itemIcon[i, j], 0, view_xview[0] + iconsXOffset + i * iconsXSpacing
                    , view_yview[0] + iconsYOffset + j * iconsYSpacing);
            }

            // name and description
            if (i == cursorX && j == cursorY)
            {
                draw_set_halign(fa_left);

                if (itemName[i, j] != noone)
                {
                    draw_text_ext(view_xview[0] + nameXOffset, view_yview[0] + nameYOffset, itemName[i, j], 8, view_wview[0] - nameXOffset);
                }

                if (itemDescription[i, j] != noone)
                {
                    draw_text_ext(view_xview[0] + descriptionXOffset, view_yview[0] + descriptionYOffset, itemDescription[i, j], 8, view_wview[0] - descriptionXOffset);
                }
            }
        }

        if (itemUnavailable[i, j] == 0 && itemPrice[i, j] != noone)
        {
            // price
            draw_set_halign(fa_center);
            draw_text(view_xview[0] + iconsXOffset + i * iconsXSpacing - sprite_get_xoffset(itemIcon[i, j]) + sprite_get_width(itemIcon[i, j]) / 2
                , view_yview[0] + iconsYOffset + j * iconsYSpacing - sprite_get_yoffset(itemIcon[i, j]) + sprite_get_height(itemIcon[i, j]) + 4, string(itemPrice[i, j]));
        }

        if (itemUnavailable[i, j] == 1)
        {
            // maxed out
            draw_set_halign(fa_center);
            draw_text(view_xview[0] + iconsXOffset + i * iconsXSpacing - sprite_get_xoffset(itemIcon[i, j]) + sprite_get_width(itemIcon[i, j]) / 2
                , view_yview[0] + iconsYOffset + j * iconsYSpacing - sprite_get_yoffset(itemIcon[i, j]) + sprite_get_height(itemIcon[i, j]) + 4, "MAX");
        }
    }
}

// menu cursor
draw_sprite(sprShopCursor, cursorImgIndex div 1, view_xview[0] + iconsXOffset + cursorX * iconsXSpacing, view_yview[0] + iconsYOffset + cursorY * iconsYSpacing + 1);
cursorImgIndex += cursorImgSpd;
if (cursorImgIndex >= sprite_get_number(sprShopCursor))
{
    cursorImgIndex = 0;
}

draw_set_halign(fa_left);

// players
var i; for ( i = 0; i < global.playerCount; i+=1)
{
    drawPlayer(i, i, 0, 0, view_xview[0] + playersXOffset - playersXSpacing * i, view_yview[0] + playersYOffset, -1, 1);
}

// exit notification
draw_sprite(sprButtonPrompts, 5, 144, 96);
draw_text(154, 96, ":EXIT");
