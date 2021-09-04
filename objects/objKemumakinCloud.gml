#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// col = choose(random_range(0, 26), random_range(27, 39), random_range(41, 53));

col = 0;

imgSpd = 0.2;
imgIndex = 0;

timer = 0;

noFlicker = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen)
{
    imgIndex += imgSpd;
    if (imgIndex >= 5)
    {
        imgIndex = 3;
    }

    timer += 1;

    if (timer >= 120 && !(timer mod 3))
    {
        visible = !visible;
    }

    if (!insideSection(x, y) || timer >= 150)
    {
        instance_destroy();
    }
}

image_index = imgIndex div 1;

depth -= 0.001;
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
depth = -1; // prevent flickering with things behind this
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sprKemumakinCloud1, image_index, x, y);
draw_sprite_ext(sprKemumakinCloud2, image_index, x, y, 1, 1, 0,
    global.nesPalette[col], 1);
