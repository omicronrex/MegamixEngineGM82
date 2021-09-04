#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// same creation code as yoku blocks

// Creation code (mandatory):
// startup = <number> (the amount of frames it takes for the Yoku Spike to first appear)
// active = <number> (the amount of frames the Yoku Spike is active before disappearing)
// wait = <number> (the amount of frames the Yoku Spike needs to reappear after disappearing
// All of these creation code variables are mendatory; not adding them to the creation code will give you an error

// Creation code (optional):
// sprite = <sprite name> (to set the yoku spike to have a custom graphic (you don't need to do this if you're creating objects that extend the yoku block templates though)
// neverDespawn = <boolean> (true = will reappear after disappearing for the first time (default); false = only appears once) (setting this to false will eliminate the need to set the wait variable)

event_inherited();

spike = true;

sprite_index = sprYokuSpike;
