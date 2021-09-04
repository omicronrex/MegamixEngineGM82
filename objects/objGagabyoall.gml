#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// col = <number>. color. 0 = orange, 1 = blue, 2 = green

event_inherited();

facePlayerOnSpawn = false; // they don't in MM9

// Overriding MM1 Spine animation
image_speed = 0;
imgOffset = 0;

animTimer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

sprite_index = sprGagabyoall; // Override MM1 animation
image_speed = 0;

if (entityCanStep())
{
    if (!stopped)
    {
        // animation
        animTimer+=1;
        if (animTimer == 4)
        {
            animTimer = 0;
            imgOffset = !imgOffset;
        }
    }
}
else
{
    animTimer = 0;
}

image_index = imgOffset + (col * 2); // set color here
