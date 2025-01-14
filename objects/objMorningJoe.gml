#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 12;
healthpoints = healthpointsStart;
contactDamage = 5;

category = "joes";

facePlayer = true;

image_index = 1;
image_speed = 0;

// Enemy specific code
star[0] = noone;
star[1] = noone;
star[2] = noone;
star[3] = noone;
cAngle = 0;
cDistance = 16;
addAngle = 3;
attackTimer = -32;
animFrame = 0;
xOffset[0] = -2;
xOffset[1] = 0;
xOffset[2] = 2;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    attackTimer+=1;
    cAngle += addAngle * image_xscale;
    if (abs(cAngle) >= 360)
    {
        cAngle -= 360 * image_xscale;
    }
    if (attackTimer >= 0 && attackTimer < 118)
    {
        if (image_index == 1)
        {
            image_index = 2;
            var i; for ( i = 0; i < 4; i+=1)
            {
                star[i] = instance_create(x, y - 24, objMorningJoeStar);
                star[i].newX = x;
                star[i].newY = star[i].y;
                star[i].parent = id;
                star[i].cFrame = i;
            }
        }
        else
        {
            animFrame += 0.125;
            image_index = 2 + (animFrame mod 3);
            var i; for ( i = 0; i < 4; i+=1)
            {
                star[i].newX = xOffset[floor(animFrame mod 3)] * image_xscale + round(x + cos(degtorad(cAngle + i * 90)) * cDistance);
                star[i].newY = y - 24;
            }
        }
    }
    else if (attackTimer == 118)
    {
        image_index = 5;
        star[0].newX = x - 8 * image_xscale;
        star[0].newY = y - 24;
        star[1].newX = x - 6 * image_xscale;
        star[1].newY = y - 22;
        star[2].newX = x - 4 * image_xscale;
        star[2].newY = y - 20;
        star[3].newX = x - 2 * image_xscale;
        star[3].newY = y - 18;
    }
    else if (attackTimer == 124)
    {
        var i; for ( i = 0; i < 4; i+=1)
        {
            star[i].newX = x + 32 * image_xscale;
            star[i].newY = y;
        }
    }
    else if (attackTimer > 124 && attackTimer < 172)
    {
        if (attackTimer == 136)
        {
            star[1].newX = x + 56 * image_xscale;
            star[2].newX = x + 56 * image_xscale;
            star[3].newX = x + 56 * image_xscale;
        }
        if (attackTimer == 148)
        {
            star[2].newX = x + 80 * image_xscale;
            star[3].newX = x + 80 * image_xscale;
        }
        if (attackTimer == 160)
        {
            star[3].newX = x + 104 * image_xscale;
        }
    }
    else if (attackTimer >= 172 && attackTimer < 220)
    {
        if (attackTimer == 184)
        {
            star[3].newX = x + 32 * image_xscale;
        }
        if (attackTimer == 196)
        {
            star[2].newX = x + 32 * image_xscale;
        }
        if (attackTimer == 208)
        {
            star[1].newX = x + 32 * image_xscale;
        }
    }
    else if (attackTimer == 220)
    {
        image_index = 2;
        attackTimer = 0;
    }
    else
    {
        image_index = 1;
    }
}
else if (dead)
{
    attackTimer = -32;
    image_index = 1;
    animFrame = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (image_index == 0)
{
    other.guardCancel = 1;
}
