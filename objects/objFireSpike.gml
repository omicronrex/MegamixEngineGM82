#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

canHit = false;
contactDamage = 4;

image_speed = 0;
image_index = 0;

despawnRange = -1;
respawnRange = -1;
animTimer = 0;
animPhase = 0;
blockCollision = false;
grav = 0;
bubbleTimer = -1;

// max distance from starting point to move
radius = 32;

// number of frames per tick
moveTime = 5;

// -1: moves left. 1: moves right
dir = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    animTimer+=1;
    if (animTimer >= moveTime)
    {
        animTimer = 0;
        animPhase = (animPhase + 1) mod 4;
        x += 8 * dir;
        if (place_meeting(x, y, objSolid) || abs(x - xstart) > radius)
        {
            x = xstart - floorTo(radius, 8) * dir;
            animPhase = 0;
        }
    }
    var animTable; animTable = makeArray(2, 1, 0, 1);
    image_index = animTable[animPhase];
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 2;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

animTimer = 0;
animPhase = 0;
image_index = 0;
