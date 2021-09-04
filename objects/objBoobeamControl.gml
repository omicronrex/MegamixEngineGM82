#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// place the controller where you want the item that drops to spawn
event_inherited();

if (!instance_exists(objBoobeam))
{
    instance_destroy(); // destroys itself if a Boobeam doesn't exist
}
doPlayerExplosion = false;
healthpointsStart = 28; // sets its starting health to 28
healthpoints = healthpointsStart; // sets the health of the controller to the starting health
canHit = false; // isn't hittable

sprite_index = sprNothing; // prevents visibility by making it a blank sprite
pose = sprNothing; // here to prevent errors
poseImgSpeed = 0; //^
contactDamage = 0; // no contact damage so you dont get hit by an invisible boss
grav = 0; // no gravity
introType = 2; // no intro
blockCollision = 0; // doesnt interact with blocks

// Health Bar
healthBarPrimaryColor[1] = 37;
healthBarSecondaryColor[1] = 40;

// Music
music = "Mega_Man_2.nsf";
musicType = "VGM";
musicTrackNumber = 17;

boobeamCount = 0; //This is set in the spawn event, don't touch it
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited(); // inherits the behavior of the boss parent object so that it gains the required functionality for the health bar
if (healthpoints <= 0)
{
    event_user(EV_DEATH);
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// duplicate of prtBoss's event_user(EV_DEATH) here to prevent explosions out of seemingly nowhere
objBoobeam.respawn = false;
with (objBoobeamBullet)
{
    instance_destroy();
}
event_inherited();
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (spawned)
{
    boobeamCount = instance_number(objBoobeam); // this can't be set in the create event due to objects not being deactivated yet
}
