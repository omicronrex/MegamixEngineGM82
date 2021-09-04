#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// startup =  (the amount of frames it takes for the block to Launch)
// active =  (the amount of frames the block is active before exploding)
// spd =

event_inherited();
canHit = false;
canDamage=0;
isSolid = 1;
blockCollision = 0;
grav = 0;
bubbleTimer = -1;

activeTime = 0;
startupTime=30;

timer=0;

spd=2;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    timer+=1;
    if(timer>startupTime)
    {
        xspeed = spd;
        var pc; pc = floor(((timer-startupTime)/activeTime)*100);
        image_index = clamp(round(pc/16.66667),1,6)-1;
        if(timer>startupTime+activeTime)
        {
            event_user(EV_DEATH);
        }
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_create(bboxGetXCenter(),bboxGetYCenter(),objExplosion);
dead=true;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
timer=0;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ys = 0;

switch (timer)
{
    case 1:
    case 2:
        ys = -1;
        break;
    case 5:
    case 6:
        ys = 1;
        break;
    case 9:
    case 10:
        ys = -1;
        break;
    case 13:
    case 14:
        ys = 1;
        break;
    case 17:
    case 18:
        ys = -1;
        break;
    case 21:
    case 22:
        ys = 1;
        break;
    case 25:
    case 26:
        ys = -1;
        break;
    case 29:
    case 30:
        ys = 1;
        break;
}

y += ys;
event_inherited();
y -= ys;
