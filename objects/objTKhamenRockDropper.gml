#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

canHit = false;
grav = 0;
blockCollision = false;

dropRock = false;
imgIndex = 0;
imgSpd = 0.2;
active = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (instance_exists(objTKhamen))
    {
        if (active == true)
        {
            if (objTKhamen.selectTime > 0)
            {
                imgIndex = 1;
            }
            else
            {
                if (dropRock == false)
                {
                    imgIndex += imgSpd;
                    if (imgIndex > 6)
                    {
                        dropRock = true;
                        var i = instance_create(x, y - 7, objTKhamenDropRock);
                        i.image_xscale = -image_xscale;
                    }
                }
                else
                {
                    imgIndex = 1;
                }
            }
        }
        else
        {
            imgIndex = 0;
            dropRock = false;
        }
    }
    else
    {
        active = false;
        imgIndex = 0;
    }
}
image_index = imgIndex div 1;
