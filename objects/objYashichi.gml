#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

hlth = 28;

grabable = 0;
heavy = 1;
respawnupondeath = 1;
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy();

playSFX(sfxYasichi);

var pid; pid = collectPlayer.playerID;

global.playerHealth[pid] = 28;
for (i = 0; i <= global.totalWeapons; i += 1)
{
    global.ammo[pid, i] = 28;
}
