#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

faction = 2;
stopOnFlash = 0;
killOverride = false;

canHit = false;
penetrate = 0;
pierces = 0;
contactDamage = 1;
respawn = false;
killOverride = false;

grav = 0;
dieToSpikes = 0;
blockCollision = 0;
bubbleTimer = -1;

fnsolid = 1;

bulletLimitCost = 1; // how much this contributes to the bullet limit. >1 used for charge shot

playerID = 0;
costumeID = 0;
parent = global.playerProjectileCreator; // don't mind this - this is handled in playerShoot.

if (instance_exists(parent))
{
    playerID = parent.playerID;
    costumeID = parent.costumeID;
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// update costume sprite
if (instance_exists(parent))
{
    costumeID = parent.costumeID;
}
#define Other_17
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
canDamage = 0;
canHit = false;

direction = 45 + 90 * (xspeed + hspeed > 0);

speed = 6;
xspeed = 0;
yspeed = 0;

playSFX(sfxReflect);
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dead = 1;
