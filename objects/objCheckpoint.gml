#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Place this exactly where you want Megaman to spawn
// the checkpoint will be triggered when this object just comes onto screen

image_speed = 0;

//@cc 0 = teleport land, 1 = teleport in, 2 = fall in, 3 = Jump in, 4 = stand there (set showDuringReady to true), 8 = Skull elevator
respawnAnimation = 0;

//@cc play the animation sequence while ready's being displayed
showDuringReady = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (instance_exists(objMegaman))
{
    if (insideView())
    {
        xx = x;
        yy = y;
        event_user(0);
        instance_destroy();
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.checkpoint = room;
global.checkpointX = xx;
global.checkpointY = yy;

global.respawnAnimation = respawnAnimation;
if (instance_exists(objMegaman))
{
    objMegaman.showDuringReady = showDuringReady;
}
