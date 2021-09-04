#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Initial spawn location

//@cc 0 = teleport land, 1 = teleport in, 2 = fall in, 3 = Jump in, 4 = stand there (set showDuringReady to true), 8 = Skull elevator
respawnAnimation = 0;

//@cc play the animation sequence while ready's being displayed
showDuringReady = false;


// since this object is the first in the resource tree,
// and is ubiquitous among levels, it must help bootstrap
// the external room loader
with (objExternalRoomSetup)
{
    event_perform(ev_create, 0);
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// since this object is the first in the resource tree,
// and is ubiquitous among levels, it must help bootstrap
// the external room loader
with (objExternalRoomSetup)
{
    event_perform(ev_other, ev_room_start);
}
