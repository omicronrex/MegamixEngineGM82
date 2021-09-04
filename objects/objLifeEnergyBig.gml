#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

image_speed = 1 / 6;
hlth = 10;

respawnupondeath = 1;
is1Up = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (global.pickupGraphics)
{
    sprite_index = sprLifeEnergyBigMM1;
}
else
{
    sprite_index = sprLifeEnergyBig;
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy();

if (is1Up && global.livesEnabled)
{
    global.livesRemaining+=1;
    playSFX(sfxImportantItem);
}
else if (global.playerHealth[collectPlayer.playerID] < 28)
{
    global.frozen = true;
    with (objGlobalControl)
    {
        increaseHealth = other.hlth;
        increasePID = other.collectPlayer.playerID;
    }
    loopSFX(sfxEnergyRestore);
}
