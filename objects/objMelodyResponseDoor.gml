#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// creation code - change this in the topmost door object
// BOTH OF THESE VARIABLES ARE IGNORED IF A MELODY RESPONSE CANNON IS IN EXISTANCE - But this does mean that yes, you can use this door and buttons by itself if you wish.
// allButtons = true; // if set to true, the melody response cannon will use every button in a random order.
// buttonsToPress = <number> ; // how many buttons the player has to press. if the previous variable is set to true, then this variable is ignored!
mySolid = noone;
alarm[0] = 1;

animTimer = 0;
destroyTimer = -1;
image_speed = 0;

// creation code variables
allButtons = false;
buttonsToPress = 5;
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
mySolid = instance_create(x, y, objSolidIndependent);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen)
{
    mySolid.image_yscale = image_yscale;

    if (animTimer > 0 && animTimer < 48)
    {
        animTimer++;
        image_index = ((animTimer / 2) mod 3) + 1;
    }

    if (animTimer == 48)
    {
        if (destroyTimer == -1)
        {
            image_index = 0;
            destroyTimer = 32;
        }
        if (destroyTimer > 0)
        {
            destroyTimer--;
        }
        if (destroyTimer == 0 && image_yscale > 1)
        {
            playSFX(sfxDoor);
            image_yscale--;
            destroyTimer = 8;
        }
        else if (destroyTimer == 0)
        {
            playSFX(sfxDoor);
            with (mySolid)
            {
                instance_destroy();
            }
            instance_destroy();
        }
    }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
while (place_meeting(x, y + 4, object_index))
{
    while (place_meeting(x, y + 4, object_index))
    {
        with (instance_place(x, y + 4, object_index))
        {
            instance_destroy();
        }
    }
    image_yscale += 1;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for (var i = 0; i < image_yscale; i++)
{
    draw_sprite(sprite_index, image_index, x, y + (16 * i));
}
