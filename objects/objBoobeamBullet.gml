#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited(); // inherits the parent object's create event
contactDamage = 4; // sets the contact damage of the bullet to 4
stopOnFlash = false;
speed = 6; // sets the speed to 2
if (!instance_exists(target)) // checks if a target doesn't exist
{
    direction = 90;
}
else // if a target exists then it fires at it instead
{
    direction = point_direction(x, y, target.x, target.y); // sets the direction to the player
}
