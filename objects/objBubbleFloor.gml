#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

isSolid = 1;

respawnRange = -1;
despawnRange = -1;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

dir = .25;

doesTransition = false;

bounceForce = 0;

spriteFrame = 0;
spriteTimer = 0;
image_speed = 0;

yspeed_map = ds_map_create();
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    spriteTimer += .1;
    if (spriteTimer >= 1)
    {
        spriteTimer = 0;
        if (spriteFrame == 3)
            spriteFrame = 0;
        else
            spriteFrame += 1;
    }

    if (spriteFrame == 3)
        image_index = 1;
    else
        image_index = spriteFrame;

    yspeed = dir;
    if (y < ystart)
        dir = .25;
    if (y > ystart + 4)
        dir = -.25;

    with (objMegaman)
    {
        var ysp; ysp = other.yspeed * (other.yspeed*gravDir>0) + yspeed*(yspeed*gravDir>0);
        if (place_meeting(x, y + 2 * gravDir + ysp, other.id))
        {
            var bounciness, jumpPower;

            with (other)
                other.prevYspeed = ds_map_get(yspeed_map,other.id);

            var xscl; xscl = sign(other.image_xscale);
            var onBigBubble;
            if(xscl>0)
            {
                onBigBubble = x<other.bbox_left || ((floor(x-other.bbox_left) mod 32)< 16 && x<other.bbox_right);
            }
            else
            {
                onBigBubble = x>=other.bbox_right || ((floor(x-other.bbox_left) mod 32)>= 16 && x>=other.bbox_left);
            }

            if (!onBigBubble)
            {
                bounciness = .5;
                jumpPower = 1.0;
            }
            else
            {
                bounciness = .75;
                jumpPower = 3.0;
            }

            if (!is_undefined(prevYspeed) && abs(prevYspeed) > 1.75)
            {
                ground = 0;
                yspeed = (-prevYspeed * bounciness) - (global.keyJump[playerID] * jumpPower * gravDir);
                if(yspeed*sign(grav)>0)
                {
                    yspeed=0;
                }
            }
        }

        with (other)
            ds_map_set(yspeed_map,other.id,other.yspeed);
    }

    with (prtEntity)
    {
        var ysp; ysp = other.yspeed * (other.yspeed*sign(grav)>0) + yspeed*(yspeed*sign(grav)>0);
        if (object_index!=objMegaman&& place_meeting(x, y + 2*sign(grav)+ysp, other.id) && !dead && !object_is_ancestor(object_index,prtPlayerProjectile)&& object_index!= prtPlayerProjectile)
        {
            var bounciness;

            with (other)
                other.prevYspeed = ds_map_get(yspeed_map,other.id);

            var xscl; xscl = sign(other.image_xscale);
            var onBigBubble;
            if(xscl>0)
            {
                onBigBubble = x<other.bbox_left || ((floor(x-other.bbox_left) mod 32)< 16 && x<other.bbox_right);
            }
            else
            {
                onBigBubble = x>=other.bbox_right || ((floor(x-other.bbox_left) mod 32)>= 16 && x>=other.bbox_left);
            }

            if (!onBigBubble)
                bounciness = .5;
            else
                bounciness = .75;

            if (!is_undefined(prevYspeed)&&abs(prevYspeed) > 1.75)
            {
                ground = 0;
                yspeed = (-prevYspeed * bounciness);
                if(yspeed*grav>0)
                {
                    yspeed=0;
                }
            }
        }

        with (other)
            ds_map_set(yspeed_map,other.id,other.yspeed);
    }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var combineDir; combineDir = sign(image_xscale);
image_xscale=ceil(image_xscale);
if(!place_meeting(x-combineDir*16,y,object_index))
{
    var next; next = instance_place(x+combineDir*16,y,object_index);
    while(next!=noone && sign(next.image_xscale)==combineDir)
    {
        with(next)
        {
            instance_destroy();
        }
        next = instance_place(x+combineDir*16,y,object_index);
        while(next!=noone && sign(next.image_xscale)==combineDir)
        {
            with(next)
            {
                instance_destroy();
                next = instance_place(x+combineDir*16,y,object_index);
            }
        }
        image_xscale+=combineDir;
        next = instance_place(x+combineDir*16,y,object_index);
    }
}
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ds_map_destroy(yspeed_map);
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var drawDir; drawDir = sign(image_xscale);
var i; for(i =0;i<abs(image_xscale);i+=1)
{
    draw_sprite_ext(sprBubbleFloor, image_index, xstart+drawDir*i*32, ystart, drawDir, image_yscale, image_angle, image_blend, image_alpha);
}
