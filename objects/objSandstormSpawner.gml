#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// 420th object
// Sandstorm Everyday

event_inherited();
canHit = false;

respawnRange = -1;
despawnRange = -1;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

// Enemy specific code
actionTimer = 0;

size = 32;
mySpeed = -2;
stormdelay = 14 * room_speed;


actionTimer = stormdelay;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    if (insideSection(x, y))
    {
        actionTimer += 1;
        if (actionTimer >= stormdelay)
        {
            if (dir == 1)
            {
                i = instance_create(global.sectionLeft - size * 16, y,
                    objSandstorm);
            }
            if (dir == -1)
            {
                i = instance_create(global.sectionRight, y, objSandstorm);
            }
            i.size = size;
            i.mySpeed = mySpeed;
            i.dir = dir;
            actionTimer = 0;

            playSFX(sfxCommandoSandstorm);
        }
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if(spawned)
{
    dir = sign(mySpeed);
    with(objMegaman)
    {
        sandstormed=0;
    }
    actionTimer = stormdelay;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// No
