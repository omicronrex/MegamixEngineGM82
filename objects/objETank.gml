#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

usePlayerColor = 1;
image_speed = 0.1;

grabable = 0;
heavy = 1;
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy();

var pid; pid = collectPlayer.playerID;

if (global.eTanks < global.maxETanks)
{
    global.eTanks += 1;
}
else
{
    if (global.playerHealth[pid] < 28)
    {
        global.frozen = true;
        with (objGlobalControl)
        {
            increaseHealth = 28;
            increasePID = pid;
        }
        loopSFX(sfxEnergyRestore);
    }
}

playSFX(sfxImportantItem);
