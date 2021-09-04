#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
/// A Quick Laser made out of 16 1 pixel wide lasers that can be stopped individually
// Important Note: more than two or three on screen could potentially lag the game


if(image_yscale!=1)
{
    image_yscale=1;
}
if(image_xscale!=1)
{
    image_xscale=1;
}

canHit = 0;
canIce = false;
blockCollision = 0;
bubbleTimer = -1;
facePlayerOnSpawn = false;
facePlayer = false;
grav = 0;
stopOnFlash = true;
contactDamage = 28;
faction = 4;
despawnRange = -1;


mySpeed = 4;
stopOnFlash = true;


onlyDamagePlayer = true; // set to true to not damage enemies and for better performance

spd = 0;
order = -1;
init = 1;
variation = 1;

angularSpeed = 0;

//@cc
imgSpeed = 0.1;
parent = noone;

obstacleList[0] = objConcreteShot;
obstacleList[1] = objIceWall;


preciseMask = mskPreciseDot;
nonPreciseMask = sprDot;

image_angle = floor(image_angle);
image_yscale = 1 / sprite_get_height(sprite_index);
image_xscale = 1;
var angle = image_angle - 90;
rx = x + cos(degtorad(angle)) * 8;
ry = y - sin(degtorad(angle)) * 8;
rdir = point_direction(rx, ry, x, y);
r = point_distance(x, y, rx, ry);
drainCooldown = 4;

hacks = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    image_index += imgSpeed;

    // Solidify objects

    with (prtEntity)
    {
        solid=false;
        if (!dead && object_index != objPreciseQuickLaserSpawner)
        {
            for (var i = array_length_1d(other.obstacleList) - 1; i >= 0; i--)
            {
                if (object_index == other.obstacleList[i])
                {
                    solid = 1;
                    break;
                }
            }
            if (solid)
                continue;
            if (isSolid != 1)
                continue;
            if (!fnsolid)
            {
                solid = 1;
            }
            else
            {
                solid = !global.factionStance[faction, other.faction];
                if (fnsolid == 2)
                {
                    solid = !solid;
                }
            }
        }
    }
    with (objSolid)
    {
        solid=(isSolid==true);
    }
    var ang = image_angle;
    image_angle = round(image_angle);
    if (hacks && image_angle >= 177 && image_angle <= 187) // These messed up with place_free so we handle them as 180(there are still some more but thats ok)
        image_angle = 180;
    else if(hacks&&image_angle>=265 && image_angle<=280)
        image_angle=270;
    if (image_angle == 0 || image_angle == 180 || image_angle == 270 || image_angle == 90) // Thse also messed up with place free, but in this case is faster to use a bounding box anyway
    {
        mask_index = nonPreciseMask;
        image_yscale = sprite_get_height(mask_index) / sprite_get_height(sprite_index); // no idea why this is necessary for the non precise mask, but it works somehow
    }
    else
    {
        mask_index = preciseMask;
        image_yscale = 1;
    }

    var tx=x+cos(degtorad(image_angle))*image_xscale;
    var ty=y-sin(degtorad(image_angle))*image_xscale;
    if(point_in_rectangle(floor(tx),floor(ty),global.sectionLeft,global.sectionTop,global.sectionRight,global.sectionBottom))
    {
        image_xscale += mySpeed;
    }
    if (floor(image_xscale)>0&&!place_free(floor(x), floor(y)))
    {
        image_xscale = floor(image_xscale);
        var moveAmmount = 8 + 8*(image_xscale>64) + 32*(image_xscale>128);
        image_xscale = max(0, image_xscale - moveAmmount);
        if(image_xscale==0)
            image_xscale=1;
        if(image_xscale>0)
        {
            while (image_xscale>0&&!place_free(floor(x), floor(y)) )
            {
                image_xscale = max(0, image_xscale - moveAmmount);
            }
            while (image_xscale>0&&place_free(floor(x), floor(y)))
            {
                image_xscale += 1;
            }
            if(image_xscale>0&&!place_free(floor(x),floor(y)))
                image_xscale -=1;
        }

    }
    image_angle = ang;
	with(all)
    {
        solid=0;
    }
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (onlyDamagePlayer)
{
    if(image_xscale>0)
    {
        var col;
        var rad=degtorad(image_angle);
        with (objMegaman)
        {
            //This is slower than per pixel collision checking for some reason col = collision_line(other.x,other.y,x+(other.image_xscale*cos(rad)),y-(other.image_xscale*sin(rad)),id,false,false);
            col = place_meeting(round(x),round(y),other);
            if (iFrames == 0 && canHit && col)
            {
                with (other)
                {
                    entityEntityCollision();
                }
            }
        }
    }
}
else
{
    if(image_xscale>0)
        event_inherited();
}
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (variation == 1)
{
    with (other)
    {
        if (object_index == objMegaman)
        {
            healthpoints = global.playerHealth[playerID];
            global.playerHealth[playerID] -= 1;
        }

        healthpoints -= 1;
        if (healthpoints <= 0)
        {
            event_user(EV_DEATH);
        }
        else
        {
            iFrames = other.drainCooldown;
            playSFX(sfxHit);
        }
    }

    global.damage = 0; // Overriding normal damage collision so there's no knockback
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if(image_xscale==0)
    exit;
if (sprite_get_width(sprite_index) == 1)
{
    draw_sprite_general(sprite_index, image_index, 0, order, 1, 1, x, y, image_xscale, 1, image_angle, c_white, c_white, c_white, c_white, 1);
}
else
{
    var size = image_xscale;
    var img = size;
    var bit = 0;

    while (img > 0)
    {
        bit = min(sprite_get_width(sprite_index), img);

        draw_sprite_general(sprite_index, image_index, 0, order, bit, 1, x + (size - img) * cos(degtorad(image_angle)),y - (size - img) * sin(degtorad(image_angle)), 1, 1, image_angle, c_white, c_white, c_white, c_white, image_alpha);

        img -= bit;
    }
}
