#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 4;

isTargetable = false;

grav = 0;
blockCollision = false;

moveSpeed = 1;

yDir = 1;

image_speed = 0;
phaseTimer = 0;

despawnRange = -1;
respawnRange = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

var clampTime; clampTime = 60 * 2.5;

if (entityCanStep())
{
    blockCollision = 0;
    grav = 0;
    phaseTimer+=1;
    if (!position_meeting(x + 8, y, objLadder))
    {
        grav = 0.25;
        phaseTimer = 0;
    }
    else if (phaseTimer <= 22)
    {
        // rest
        yspeed = 0;
        y = round(y);
    }
    else if (phaseTimer >= clampTime)
    {
        // clamp down
        yspeed = 0;
        var animTable; animTable = makeArray(1, 2, 3, 2, 3, 3, 3, 3, 3, 3, 2, 1, 0);
        image_index = animTable[(phaseTimer - clampTime) div 4];
        if (image_index == 0)
            phaseTimer = 0;
    }
    else
    {
        yspeed = yDir * abs(moveSpeed);

        // move up/down ladder
        var turnAround; turnAround = false;
        if (!position_meeting(x + 8, y + yDir * 16, objLadder))
            turnAround = true;
        if (y >= global.sectionBottom - 32 || y <= global.sectionTop + 16)
            turnAround = true;
        var i; i = instance_position(x + 8, y + yDir, objGenericStopper);
        if (i != noone && i.objectToStop == object_index)
            turnAround = true;
        if (turnAround)
        {
            yDir *= -1;
            yspeed *= -1;
        }
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.damage = 0;
other.guardCancel = 3;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (spawned)
{
    yDir = 1;
    phaseTimer = 0;
}
