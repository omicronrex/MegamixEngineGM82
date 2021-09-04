#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

deathTimer = 0;
deathTimerMax = 10;

drawingPlayer = 0;
parent = -1;

image_alpha = 0.4;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    deathTimer++;

    if (deathTimer == deathTimerMax)
    {
        instance_destroy();
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (drawingPlayer && instance_exists(parent))
{
    drawPlayer(parent.playerID, parent.costumeID, spriteX, spriteY, x, y, image_xscale, image_yscale);
}
else
{
    event_inherited();
}
