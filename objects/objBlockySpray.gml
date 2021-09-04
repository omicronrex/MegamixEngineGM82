#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 8;
image_speed = 0;
isTargetable = false;

yspeed = 0;
ground = false;
bounceTimes = 0;
iWantToDie = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if(xcoll!=0)
{
    xspeed=xcoll;
}

if (entityCanStep())
{
    if (xspeed == 0)
    {
        iWantToDie += 1;
    }

    if (ground)
    {
        if (iWantToDie > 10)
        {
            instance_create(bboxGetXCenter(), bboxGetYCenter(),
                objExplosion);
            instance_destroy();
            exit;
        }
        else
        {
            xspeed = 0;
            bounceTimes = 1;
            yspeed = -2;
            y -= 4;
            ground = false;
        }
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=other
*/
other.guardCancel = 3;
