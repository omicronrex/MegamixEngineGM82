#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

canHit = false;

image_speed = 0.3;

myFlag = 0;
grav = 0;
blockCollision = 0;

isSolid = 2;

xDir = -1;
xs = 0.75;
yDir = -1;
ys = 0.1;
init = 1;
startMode = 0;

alarmTurn = 0;
moveTarget = noone;
prevMoveTarget = noone;
reversePath = false;


respawnRange = -1;
despawnRange = -1;

//@cc 1: normal, 2: shoots bullets from the sides
variation = 1;

//@cc 0: random stuff, 1: guided movement, use objFootholderGuide and change the targetMode
//variable to change the way it chooses its targets
mode = 1;

//@cc speed for mode 1
mySpeed = 1;

//@cc target behavior for mode 1. 0:random if repeated, 1: always pick nearest target, 2: move in a sequence using the order
//variable in objFootholderGuide
targetMode = 2;

//@cc if targetMode is 2 and this is true, the footholder will follow the path in reverse once it reaches the end of the path
backtrack = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{

    init = 0;
    if(mode==1 && targetMode == 2)
    {
        var hasPath = false;
        with(objFootholderGuide)
        {
            if(myFlag==other.myFlag&&order!=-1)
            {
                hasPath=true;
                break;
            }
        }
        if(!hasPath)
        {
            targetMode=1;
        }
    }
    else
    {
        var hasGuides = false;
        with(objFootholderGuide)
        {
            if(myFlag==other.myFlag)
            {
                hasGuides=true;
                break;
            }
        }
        if(!hasGuides)
        {
            mode=0;
        }
        else
        {
            mode=1;
        }
    }
    if (mode == 0)
    {
        xspeed = xs * xDir;
        yspeed = ys * yDir;
    }
    startMode = mode;
}
event_inherited();

if (entityCanStep())
{
    if (mode == 0)
    {
        alarmTurn += 1;
        if (alarmTurn == 120)
        {
            if (variation == 2 && insideView())
            {
                playSFX(sfxEnemyShootClassic);
                i = instance_create(x, y, objEnemyBullet);
                i.xspeed = -3;
                i.sprite_index = sprMM1MetBullet;
                i = instance_create(x + sprite_width - 4, y, objEnemyBullet);
                i.xspeed = 3;
                i.sprite_index = sprMM1MetBullet;
            }

            alarmTurn = 0;
            xspeed *= -1;

            if (collision_rectangle(x, y - 48, x + 1, y + 48, objSolid, false, true)
                || (y <= view_yview + 48 && yspeed < 0)
                || (y >= view_yview + 224 - 48 && yspeed > 0))
            {
                yspeed = -yspeed;
            }
        }
    }
    else
    {
        if (variation == 2)
        {
            alarmTurn += 1;
            if (alarmTurn == 120)
            {
                if (insideView())
                {
                    playSFX(sfxEnemyShootClassic);
                    i = instance_create(x, y, objEnemyBullet);
                    i.xspeed = -3;
                    i.sprite_index = sprMM1MetBullet;
                    i = instance_create(x + sprite_width - 4, y, objEnemyBullet);
                    i.xspeed = 3;
                    i.sprite_index = sprMM1MetBullet;
                }
                alarmTurn = 0;
            }
        }
        if(moveTarget!=noone)
        {
            if (moveTowardPoint(moveTarget.x, moveTarget.y, mySpeed))
            {
                if (targetMode==2 ||(targetMode == 0 && prevMoveTarget == noone))
                    prevMoveTarget = moveTarget;
                moveTarget = noone;
            }
        }
        if (moveTarget == noone)
        {
            var total = 0;
            with (objFootholderGuide)
            {
                if (myFlag == other.myFlag)
                    total++;
            }
            if(targetMode == 2)
            {
                var nextTarget = noone;
                var prevEndTarget = noone;
                var startTarget = noone;
                var prevStartTarget = noone;
                var endTarget = noone;

                with(objFootholderGuide)
                {
                    if(order==-1||myFlag!=other.myFlag)
                        continue;
                    if(startTarget==noone||(startTarget!=noone&&startTarget.order>order))
                    {
                        startTarget = id;
                    }
                    else if(prevStartTarget==noone || (prevStartTarget!=noone&&prevStartTarget.order>order))
                    {
                        prevStartTarget = id;
                    }
                    if(endTarget==noone||(endTarget!=noone&&endTarget.order<order))
                    {
                        endTarget = id;
                    }
                    else if(prevEndTarget==noone||(prevEndTarget!=noone&&prevEndTarget.order<order))
                    {
                        prevEndTarget=id;
                    }
                    if(other.prevMoveTarget==id)
                        continue;

                    if(!other.reversePath)
                    {
                        if((nextTarget==noone||(nextTarget!=noone&&order<nextTarget.order)) && (other.prevMoveTarget==noone||(other.prevMoveTarget!=noone&&order>other.prevMoveTarget.order)))
                        {
                            nextTarget = id;
                        }
                    }
                    else
                    {
                        if((nextTarget==noone||(nextTarget!=noone&&order>nextTarget.order)) && (other.prevMoveTarget==noone||(other.prevMoveTarget!=noone&&id!=other.prevMoveTarget&&order<other.prevMoveTarget.order)))
                        {
                            nextTarget = id;
                        }
                    }
                }
                if(prevMoveTarget==endTarget)
                {
                    if(backtrack && !reversePath)
                    {
                        nextTarget = prevEndTarget;
                        reversePath = !reversePath;
                    }
                    else
                    {
                        nextTarget = startTarget;
                    }
                }

                if(prevMoveTarget == startTarget)
                {
                    if(reversePath)
                    {
                        nextTarget = startTarget;
                        reversePath = !reversePath;
                    }
                }
                moveTarget = nextTarget;

            }
            else
            {
                with (objFootholderGuide)
                {
                    if (myFlag == other.myFlag && !place_meeting(x, y, other.id))
                    {
                        var dist1 = 0, dist2 = 0;
                        if (other.moveTarget != noone)
                        {
                            dist1 = point_distance(x, y, other.x, other.y);
                            dist2 = point_distance(other.moveTarget.x, other.moveTarget.y, other.x, other.y);
                        }
                        if (other.moveTarget == noone || (other.moveTarget != noone && dist1 < dist2) || (other.targetMode == 0 && id == other.prevMoveTarget))
                        {
                            if (other.targetMode == 1 || (id != other.prevMoveTarget || total <= 1))
                            {
                                other.moveTarget = id;
                            }
                            else if (id == other.prevMoveTarget)
                            {
                                var randList;
                                var i = 0;
                                with (objFootholderGuide)
                                {
                                    if (id != other.id && myFlag == other.myFlag)
                                    {
                                        randList[i] = id;
                                        i++;
                                    }
                                }
                                other.moveTarget = randList[max(0, irandom(i - 1))];
                                other.prevMoveTarget = noone;
                                break;
                            }
                        }
                        else if (other.moveTarget != noone && ((dist1 == dist2)))
                        {
                            other.moveTarget = choose(other.moveTarget, id);
                        }
                    }
                }
            }
            if (moveTarget == noone)
            {
                mode = 0;
                alarmTurn = 0;
                xspeed = xs * xDir;
                yspeed = ys * yDir;
                exit;
            }
        }
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (spawned)
{
    x=xstart;
    y=ystart;
    alarmTurn = 0;
    xspeed = xs * xDir;
    yspeed = ys * yDir;
    reversePath=false;
    mode = startMode;
    moveTarget=noone;
    prevMoveTarget = noone;
}
