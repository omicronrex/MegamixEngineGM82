#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// This is a checkpoint that only activates when touched, as opposed to the normal
/// Checkpoint object which just activates as soon as it appears.
/// note: game maker tells you the x and y position of the tile your mouse is hovering over at the bottom of the screen
/// note: the tile whose X & Y are what you set mega man to spawn at will be at the bottom-right of where megaman spawns
/// stretch the object in the editor to cover the area you want to trigger the checkpoint

//@cc (the X position in pixels Mega Man should spawn at when using the checkpoint)
xx = x + 8;

//@cc (the Y position in pixels Mega Man should spawn at when using the checkpoint)
yy = y;

//@cc 0 = teleport land, 1 = teleport in, 2 = fall in, 3 = Jump in, 4 = stand there (set showDuringReady to true), 8 = Skull elevator
respawnAnimation = 0;

//@cc play the animation sequence while ready's being displayed
showDuringReady = false;
#define Collision_objMegaman
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_perform_object(objCheckpoint, ev_other, ev_user0);

instance_destroy();
