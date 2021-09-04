#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

hlth = 28;
is1Up = true;

respawnupondeath = 0;

timer = 0;
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSFX(sfxImportantItem);

event_inherited();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!dead)
{
    if (!global.frozen)
    {
        timer+=1;
    }

    if ((flashTimer mod 4) < 2)
    {
        if (object_index == objLife)
        {
            var _costume; _costume = 0;
            var _pid; _pid = floor((timer / 48) mod global.playerCount);
            with (objMegaman)
            {
                if (playerID == _pid)
                {
                    _pid = playerID;
                    _costume = costumeID;
                    break;
                }
            }

            drawPlayer(_pid, _costume, 16, 12, x + 8, y, image_xscale, image_yscale);
        }
    }
}
