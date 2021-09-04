#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

faction = 1;
shiftVisible = 2;

despawnRange = -1;

stopOnFlash = 0;

killOverride = false;

dieToSpikes = true;

// co-op variables:
playerID = 0;
costumeID = 0;
fanoutDistance = 0;

// Physics variables
grav = 0.25; // The player's gravity
gravfactor = 1;
gravWater = 0.38 * grav; // The player's gravity in water
gravDir = 1;

jumpSpeed = 4.75 + grav * 2; // Dunno why grav needs to be multiplied by 2, but MM jumps as high as in MM5 when doing so
jumpSpeedWater = 0.1;

// jumpSpeedWater = 4.85 + grav*2;

walkSpeed = 1.3; // walkSpeed = 1.296875;
oilWalk = 0.3;
maxVspeed = 7;

premask = mask_index;
stepSpeed = 1 / 7;
stepFrames = 7;

iceDec = 0.025; // The deceleration on ice when not holding any buttons
iceDecWalk = 0.05; // The deceleration on ice when moving in the opposite direction

slideSpeed = 2.5;
slideFrames = 26;

// climbSpeed = 1.296875; //Official value of MM3
climbSpeed = 1.3;
hitTime = 32; // The amount of frames you experience knockback after getting hit

if (global.sturdyHelmet)
{
    hitTime = 10;
}

// Variables

// Lock certain actions
playerLockLocalInit();
hitLock = false;
climbLock = false;
shootStandStillLock = false;
slideLock = false;
icedLock = false;
slideChargeLock = false;
teleportLock = false;
shockLock = false;

ground = true;
xDir = 0;
yDir = 0;

prevXScale = image_xscale;
isStep = false;
stepTimer = 0;
canMinJump = false;
climbShootXscale = 1;

isShoot = false;
shootTimer = 0;

isSlide = false;
slideTimer = 0;
firstSlideMask = mskMegamanSlide;
secondSlideMask = mskMegamanSlide2;

canHit = false;
isHit = false;

isShocked = false; // had to resort to this ~dracmeister
shockedTime = 0; // for how long?

isCharge = false;
chargeTimer = 0;
initChargeTimer = 0; // The timer for when to start charging after exiting the shooting animation

climbing = false;
climbSpriteTimer = 0;

quickWeaponScrollTimer = 25;

teleporting = false;
showDuringReady = false;
showReady = false;
readyTimer = 0;
teleportTimer = 0;
teleportImg = 0;

playLandSound = true; // Should we play the landing SFX when colliding with a floor? (Disabled on ladders, for example)
blinkTimer = 0; // Timer for MM's blinking animation when standing still
blinkTimerMax = 120;
blinkImage = 0; // 0 for no blinking, 1 for blinking
blinkDuration = 8; // The amount of frames the blinking lasts
drawWeaponIcon = false; // Whether or not we should draw the weapon icon above our head (used when using quick weapon switching)

deathByPit = false; // Did we die by falling in a bottomless pit?
dieToPit = true;
isSolid = 0;
statusObject = noone;
statusSliding = true;
plt = 0;
isFrozen = 0;
freezeTimer = 0;


// vehicle: the instance of a vehicle mega man
// is embarked in.
vehicle = noone;
deathTimer = -1;
playerPalette();

// Show the READY text
showReady = false; // this is set to true by objGlobalControl.
readyTimer = 0;


// Camera
viewPlayer = 1;

//Jump Counter
jumpCounter = 0;
jumpCounterMax = 1; //If you want multiple jumps then increase this

//Dash things
dashSlide = false; // Dash enabled?
dashJumped = false;
multiJumpDashCancel = true; //controls whether dash momentum is removed after multiple jumps.

//Contact Damage Multiplier
contactDamageMultiplier = 1; //you can increase this to multiply the amount of damage mega man takes from a certain object.

// Animation Initiation
spriteX = 0;
spriteY = 0;
animNameID = 0;
spriteLoopStart = 0;
spriteLoopEnd = 1;
spriteLoopSpeed = 1;
spriteLoopID = 0;
spriteLoopPoint = 0;
for (i = 0; i <= 99; i += 1)
{
    spriteIDX[i] = 0;
    spriteIDY[i] = 0;
}
animSpinOffset = 0;
animSpinTurn = 1;

paletteRefresh = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
switch (global.characterSelected[playerID])
{
    default: //you can define step code here that needs to be run on every frame for a specific character. Proto man is the only character that needs to be changed for this specifically, due to his shield so he uses a different script.
    case "Roll":
    case "Mega Man":
    case "Bass":
        playerStepEventDefault();
        break;
    case "Proto Man":
    {
        playerStepEventProto();
        break;
    }
}
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
switch (global.characterSelected[playerID])
{
    default: //costumeID needs to be set here or it won't display correctly.
        break;
    case "Mega Man":
        costumeID = 0;
        break;
    case "Proto Man":
        costumeID = 1;
        break;
    case "Bass":
        costumeID = 2;
        break;
    case "Roll":
        costumeID = 3;
        break;
}
if paletteRefresh == 0
{
    playerPalette(); // corrects palette
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playerEndStep();
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
#define Other_19
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playerGetHit(global.damage);
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.playerHealth[playerID] = 0;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.difficulty == DIFF_EASY)
{
    global.damage = max(1, global.damage div 2);
}
global.damage *= contactDamageMultiplier;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (spawned)
{
    switch (global.characterSelected[playerID])
    {
        default: //define any variables that need to be overwritten here for a specific character. Note that the costume ID variables are assumed to be in their default values
            break;
        case "Mega Man":
        {
            costumeID = 0;
            break;
        }
        case "Proto Man":
        {
            contactDamageMultiplier = 2; //Proto Man takes double damage like in MM10
            costumeID = 1;
            break;
        }
        case "Bass":
        {
            jumpCounterMax = 2; //Bass has double jumping
            dashSlide = true; //Bass can dash
            multiJumpDashCancel = true; //dash momentum no longer applies when a jump is done in midair with bass
            firstSlideMask = mskMegaman;//This also applies to dash masks
            secondSlideMask = mskMegaman;//same as above
            costumeID = 2;
            break;
        }
        case "Roll":
        {
            costumeID = 3;
            break;
        }
    }
    switch (global.characterSelected[0])
    {
        default: //Weapon Names and Icons. This is to prevent multiplayer from confusing the game
        case "Mega Man":
        {
            global.weaponName[0] = "MEGA BUSTER"
            global.weaponIcon[0] = sprWeaponIconsMegaBuster;
            break;
        }
        case "Proto Man":
        {
            global.weaponName[0] = "PROTO BUSTER"
            global.weaponIcon[0] = sprWeaponIconsMegaBuster;
            break;
        }
        case "Bass":
        {
            global.weaponName[0] = "BASS BUSTER"
            global.weaponIcon[0] = sprWeaponIconsBassBuster;
            break;
        }
        case "Roll":
        {
            global.weaponName[0] = "ROLL BUSTER"
            global.weaponIcon[0] = sprWeaponIconsMegaBuster;
            break;
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playerDraw();
