#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Same as [objStrikeManSoccerBall](objStrikeManSoccerBall.html) but with a spike on top of it
event_inherited();

// Initialize Entity

contactDamage = 4;

// Object specific variables
descendSpeed = 4;
accelSpeed = -0.4;
ascendSpeed = -2;
accelTime = 1; // in frames
acc = 0.1;
descendGrav = 0.15;
holdTime = 15;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

/// Step
if (entityCanStep())
{
    var iD; iD = collision_rectangle(bbox_left + 7, bbox_top - 6, bbox_right - 7, bbox_top + 8, objMegaman, false, false);
    if (iD != noone && iD.iFrames == 0)
    {
        with (iD)
        {
            hitTimer = 0;
            playerGetHit(other.contactDamage);
        }
    }
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Initialize Entity

contactDamage = 4;

// Object specific variables
descendSpeed = 4;
accelSpeed = -0.4;
ascendSpeed = -2;
accelTime = 1; // in frames
acc = 0.1;
descendGrav = 0.15;
holdTime = 15;
