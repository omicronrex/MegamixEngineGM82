#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthParent=noone;//The clones don't draw their healthBar and when one takes a hit
delay = 60;//every other boss with the same parent and the parent gets hit
isFight = true;
drawBoss = true;
startIntro = false;
isIntro = false;
visible = 1;
cloneId = 0;
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!instance_exists(healthParent))
{
        instance_destroy();
    exit;
}
if(healthParent.isHard)
{
    if (floor(healthParent.healthpoints) <= 0 || healthParent.healthpoints <= (healthParent.healthpointsStart - ((cloneId) * (floor(healthParent.healthpointsStart) / (maxClones))))) // destroy self
        instance_destroy();
}
else
{
    if(healthParent.healthpoints<healthParent.healthpointsStart/2)
        instance_destroy();

}

event_inherited();
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// No
