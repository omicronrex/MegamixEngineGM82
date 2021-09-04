#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// col = <number> (0 = red(default); 1 = orange; 2 = green; )

event_inherited();

category = "semi bulky";

objectThrown = objThrownBomb;

col = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue(objHornetChaser, 3);
specialDamageValue(objJewelSatellite, 3);
specialDamageValue(objGrabBuster, 3);
specialDamageValue(objTripleBlade, 3);
