#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code:
// dir = 1/-1 (1 = right (default), -1 = left; optional)
// size = 1/2/3/etc (the size of the conveyor belt, measured in blocks of 16x16 pixels; optional, default is 1)
// spd = ; (how fast the conveyor belt pushes you)

event_inherited();

sprite_index = sprMM5WheelConveyor;

spd = 0.5;
animFrames=3;
