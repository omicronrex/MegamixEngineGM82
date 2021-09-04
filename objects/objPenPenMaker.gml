#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A big penguin that makes pen pen from its belly, hes only vulnerable in the eyes

event_inherited();

respawn = true;

category = "bird, bulky, nature";

healthpointsStart = 10;
healthpoints = healthpointsStart;
contactDamage = 4;
lockTransition = false;

// Enemy specific code
shootTimer = 0;
doesIntro = false;
penRate = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    image_index += 0.1;
    shootTimer += 1;
    if (shootTimer >= 60)
    {
        penRate += 1;
        if (penRate < 3)
        {
            shootTimer = choose(0, 30);
        }
        else
        {
            shootTimer = 0;
            penRate = 0;
        }
        i = instance_create(x, y + 32, objPenpen);
        i.image_xscale = image_xscale;
        i.respawn = false;
    }
}
else if (!insideView())
{
    image_index = 0;
    shootTimer = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.y >= y - 6) || (other.y <= y - 24)
{
    other.guardCancel = 2;
}
