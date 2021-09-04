#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//@cc if 0 beenOutsideView will be false if the object is not allowed to spawn
//@cc if 1 beenOutiseView will be true if the object is not allowed to spawn
despawnType = 0;

//@cc if different from -1 it will only affect entities with that faction
//@cc otherwise everything but players and player projectiles would be affected
faction = -1;

//@cc spawn if the player is closer than this distance on x. -1: doesn't matter. Measured from center.
playerXDistance = 80;

//@cc spawn if the player is closer than this distance on y. -1: doesn't matter. Measured from center.
playerYDistance = -1;

//@cc if this is non-empty, the above check will not take place and instead this
// code will be string_execute'd. It must set the local variable allowSpawn.
conditionCode = "";

//@cc if this script is set in creation code, all above conditions will be ignored
// and this script will run. The script should set allowSpawn.
conditionScript = scrNoEffect;

//@cc number of arguments
conditionScriptArgC = 0;

//@cc array containing arguments (will be cropped to `conditionScriptArgC`)
conditionScriptArgV = makeArray(0);

//@cc negate the spawn condition?
spawnConditionNegate = false;

// currently allowing spawn? (not for creation code)
allowSpawn = true;
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
allowSpawn = false;

if (conditionScript != scrNoEffect) // run script
{
    scriptExecuteNargs(conditionScript, conditionScriptArgV, conditionScriptArgC);
}
else if (string_length(conditionCode) > 0)
{
    stringExecutePartial(conditionCode);
}
else
{
    allowSpawn = true;

    if (instance_exists(objMegaman))
    {
        with (objMegaman)
        {
            if ((abs(x - bboxGetXCenterObject(other)) > other.playerXDistance) && other.playerXDistance > -1)
            {
                other.allowSpawn = false;
            }
            if ((abs(y - bboxGetYCenterObject(other)) > other.playerYDistance) && other.playerYDistance > -1)
            {
                other.allowSpawn = false;
            }
        }
    }
    else
    {
        allowSpawn = false;
    }
}

allowSpawn ^= spawnConditionNegate;

show_debug_message(string(allowSpawn));
