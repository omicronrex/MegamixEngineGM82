#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

sprite_index = sprHornetRoll;

respawnRange = -1;
despawnRange = -1;
isTargetable = false;

blockCollision = false;
grav = 0;
bubbleTimer = -1;

myPlatform = noone;

phase = 0; // 0: can shoot. 1: fully extended. 2: pause. 3: retract. 4: pause. 5: return
extendX = 128; // how long the platform is when fully extended
restX = 32; // how long the platform is at rest
speedExtendBegin = 4;
speedExtendEnd = 2;
speedRetractBegin = 4;
speedRetractEnd = 2;
speedRestore = 2;
timeRestExtend = 110;
timeRestRetract = 60;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    image_xscale = sign(image_xscale);
    if (image_xscale == 0)
        instance_destroy();
    else
    {
        switch (phase)
        {
            case 0: // rest
                break;
            case 1: // extend
                var p; p = abs((x - xstart) / (extendX - restX));
                p *= p; // quadratic scaling
                x += image_xscale * (speedExtendBegin * (1 - p) + p * speedExtendEnd);
                if (x * image_xscale >= xstart * image_xscale + (extendX - restX))
                {
                    x = xstart + (extendX - restX) * image_xscale;
                    phase = 2;
                    timer = 0;
                }
                break;
            case 2: // extended
                timer+=1;
                if (timer >= timeRestExtend)
                    phase = 3;
                break;
            case 3: // retract
                var p; p = abs((x - xstart + image_xscale * restX) / (extendX));
                p *= (1 - p); // quadratic scaling
                x -= image_xscale * (speedRetractBegin * (p) + (1 - p) * speedRetractEnd);
                if (x * image_xscale <= xstart * image_xscale - restX)
                {
                    x = xstart - image_xscale * restX;
                    phase = 4;
                    timer = 0;
                }
                break;
            case 4: // retracted
                timer+=1;
                if (timer >= timeRestRetract)
                    phase = 5;
                break;
            case 5: // restore
                x += image_xscale * speedRestore;
                if (x * image_xscale >= xstart * image_xscale)
                {
                    x = xstart;
                    phase = 0;
                }
                break;
        }

        image_index = (abs(xstart - x) div 4) mod 2;
        if (abs(x - xstart - image_xscale * (extendX - restX)) < 8)
            image_index = 2;
        if (abs(x - xstart - image_xscale * (extendX - restX)) < 4)
            image_index = 3;

        if (!instance_exists(myPlatform))
        {
            myPlatform = instance_create(x, y, objTopSolid);
        }
        myPlatform.x = min(x, xstart - image_xscale * restX);
        myPlatform.y = y;
        myPlatform.image_xscale = (abs(xstart - image_xscale * restX - x)) / 16;
        myPlatform.image_yscale = 0.5;

        if (myPlatform.image_xscale == 0)
        {
            myPlatform.x += image_xscale * 4;
        }
    }
}
else if (dead)
{
    phase = 0;
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen)
{
    image_xscale = sign(image_xscale);

    if (image_xscale == 0)
    {
        instance_destroy();
    }
    else
    {
        with (instance_place(x, y, objMegaman))
        {
            var collide; collide = false;

            if (other.image_xscale == 1)
            {
                collide = bbox_left <= other.x;
            }
            else
            {
                collide = bbox_right >= other.x;
            }

            if (collide)
            {
                var checkX; checkX = (other.x) - (max(abs(x - bbox_left), abs(x - bbox_right))) * other.image_xscale;
                if (!checkSolid(checkX - x, 0))
                {
                    x = checkX;
                }
            }
        }
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (phase == 0)
{
    phase = 1;
    playSFX(sfxHornetRoll);
}

other.guardCancel = 3;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// draw platform:
if (instance_exists(myPlatform))
{
    var platEndX; platEndX = myPlatform.x;
    if (image_xscale == -1)
        platEndX = myPlatform.x + 16 * myPlatform.image_xscale;
    var i; for ( i = 0; i <= floor(myPlatform.image_xscale); i+=1)
    {
        var draw_x; draw_x = platEndX + (i * image_xscale) * 16;
        draw_sprite_ext(sprHornetRollPlatform, i == 0, draw_x, y, image_xscale, 1, 0, c_white, 1);
    }
}

// draw ball
drawSelf();
