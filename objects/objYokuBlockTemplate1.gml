#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// This is to use yoku blocks easily without having to do toooons of creation code.
// Just create objects that have each template block as a parent, and set sprite_index below event_inherited to be the sprite you
// want for them.

event_inherited();

startup = 0;
active = 120;
wait = 360;

if (sprite_index == sprYokuBlockTemplate1)
{
    sprite_index = sprYokuBlock;
}
