#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// angle = 0/90/180/270

event_inherited();

itemDrop = -1;

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "floating";

blockCollision = 0;
grav = 0;

facePlayer = true;

// Enemy specific code
angle = 0;
blinkTimer = 0;

fric = 0.011;
spd = 0.67;

alarm[0] = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (object_index != objPetitDevilClone)
{
    if (entityCanStep())
    {
        if (angle == 0 || angle == 180)
        {
            // Move horizontally
            if (x > xstart)
                xspeed -= fric;
            else if (x < xstart)
                xspeed += fric;
        }
        else
        {
            // Move vertically
            if (y > ystart)
                yspeed -= fric;
            else if (y < ystart)
                yspeed += fric;
        }

        // Blinking
        blinkTimer += 1;
        switch (blinkTimer)
        {
            case 110:
                image_index = 1;
                break;
            case 113:
                image_index = 2;
                break;
            case 116:
                image_index = 1;
                break;
            case 119:
                image_index = 0;
                break;
            case 140:
                image_index = 1;
                break;
            case 143:
                image_index = 2;
                break;
            case 146:
                image_index = 1;
                break;
            case 149:
                image_index = 0;
                blinkTimer = 0;
                break;
        }
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (object_index == objPetitDevilGreen)
{
    refX = spriteGetXCenter();
    refY = spriteGetYCenter();

    with (instance_create(refX, refY, objPetitDevilClone))
    {
        angle = 60;
        moveDir = other.image_xscale;
        sprite_index = sprPetitDevilCloneGreen;
    }

    with (instance_create(refX, refY, objPetitDevilClone))
    {
        angle = 360 - 15;
        moveDir = other.image_xscale;
        sprite_index = sprPetitDevilCloneGreen;
    }

    with (instance_create(refX, refY, objPetitDevilClone))
    {
        angle = 360 - 50;
        moveDir = other.image_xscale;
        sprite_index = sprPetitDevilCloneGreen;
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

image_index = 0;

switch (angle)
{
    case 0:
        xspeed = spd;
        break;
    case 90:
        yspeed = -spd;
        break;
    case 180:
        xspeed = -spd;
        break;
    case 270:
        yspeed = spd;
        break;
}
