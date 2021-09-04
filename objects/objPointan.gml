#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// This cursor enemy will cycle through 3 patterns, once he finishes he will move to his inital position
// and start over.
event_inherited();
healthpointsStart = 3;
category = "floating";
contactDamage = 2;
grav = 0;
blockCollision = false;
despawnRange = 8;
facePlayerOnSpawn = false;

//@cc 0(default): square, 1: vertical line, 2: horizontal line.
initialPattern = 0;

pattern = 0;
vdir = 0;
nextX = 0;
nextY = 0;
prevX = 0;
prevY = 0;
phase = 0;
timer = 0;

windowDir = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    switch (phase)
    {
        case 0: // wait a bit before creating windows
            timer += 1;
            if (x == xstart && y == ystart)
                despawnRange = 8;
            if (timer > 30)
            {
                timer = 0;
                windowDir = -1;
                vdir = 1;
                if (instance_exists(target))
                {
                    if (target.x >= x)
                        windowDir = 1;
                    if (target.bbox_bottom < bbox_top + 16)
                        vdir = -1;
                }
                prevX = x;
                prevY = y;
                switch (pattern)
                {
                    case 0:
                        nextX = x - 32 * windowDir;
                        nextY = y + 32 * vdir;
                        break;
                    case 1:
                        nextX = x - 16 * windowDir;
                        nextY = y + 64 * vdir;
                        break;
                    case 2:
                        nextX = x - 64 * windowDir;
                        nextY = y + 16 * vdir;
                        break;
                }
                phase = 1;
                timer = 0;
                playSFX(sfxPointanSelect);
            }
            break;
        case 1: // Move to a certain point before creating windows
            despawnRange = -1;
            timer += 0.05;
            if (timer > 1)
                timer = 1;
            if (x != nextX && y != nextY)
            {
                x = lerp(prevX, nextX, timer);
                y = lerp(prevY, nextY, timer);
            }
            else
            {
                phase = 2;
                timer = 0;
            }
            break;
        case 2: // Make Windows
            if (timer == 0)
            {
                despawnRange = -1;
                var _y; _y = y - 16 * (vdir == 1);
                var _x; _x = x - 16 * (windowDir == -1);
                playSFX(sfxPointanMake);
                switch (pattern)
                {
                    case 0:
                        var i; i = instance_create(_x, _y, objPointanWindow);
                        i.type = 1;
                        i = instance_create(_x + 16 * windowDir, _y, objPointanWindow);
                        i.dir = windowDir;
                        i.delay = 30;
                        i = instance_create(_x + 16 * windowDir, _y - 16 * vdir, objPointanWindow);
                        i.type = 1;
                        i.delay = 60;
                        i = instance_create(_x, _y - 16 * vdir, objPointanWindow);
                        i.dir = windowDir;
                        i.delay = 90;
                        break;
                    case 1:
                        var j; for ( j = 0; j < 4; j+=1)
                        {
                            var i; i = instance_create(_x, _y - j * 16 * vdir, objPointanWindow);
                            i.delay = j * 30;
                            i.dir = windowDir;
                        }
                        break;
                    case 2:
                        var j; for ( j = 0; j < 4; j+=1)
                        {
                            var i; i = instance_create(_x + j * 16 * windowDir, _y, objPointanWindow);
                            i.delay = j * 30;
                            i.type = 1;
                        }
                        break;
                }
            }
            if (timer >= 0)
                timer += 1;
            if (timer >= 60 * 3.5)
            {
                pattern += 1;
                if (pattern > 2)
                {
                    pattern = 0;
                }
                if (pattern == initialPattern)
                {
                    timer = -0.01;
                    prevX = x;
                    prevY = y;
                }
                else
                {
                    phase = 0;
                    timer = 0;
                }
            }
            if (timer < 0)
            {
                timer -= 0.05;
                if (timer < -1)
                    timer = -1;
                x = lerp(prevX, xstart, abs(timer));
                y = lerp(prevY, ystart, abs(timer));
                if (x == xstart && y == ystart)
                {
                    phase = 0;
                    timer = 0;
                }
            }
            break;
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
    pattern = initialPattern;
    timer = 0;
}
phase = 0;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Draw the selection square
event_inherited();
if (!dead && phase == 1)
{
    var width; width = abs(prevX - x);
    var height; height = abs(prevY - y);
    var top; top = (prevY < y) * prevY + (prevY >= y) * y;
    var bottom; bottom = (prevY >= y) * prevY + (prevY < y) * y;
    var left; left = (prevX < x) * prevX + (prevX >= x) * x;
    var right; right = (prevX >= x) * prevX + (prevX < x) * x;
    draw_sprite(sprPointanSelectionSquare, 0, left, top);
    draw_sprite(sprPointanSelectionSquare, 2, left, bottom);
    draw_sprite(sprPointanSelectionSquare, 4, right, bottom);
    draw_sprite(sprPointanSelectionSquare, 6, right, top);

    var i; for ( i = 1; i < floor(width / 4); i += 1)
    {
        draw_sprite(sprPointanSelectionSquare, 7, left + i * 4, top);
        draw_sprite(sprPointanSelectionSquare, 3, left + i * 4, bottom);
    }
    var i; for ( i = 1; i < floor(height / 4); i += 1)
    {
        draw_sprite(sprPointanSelectionSquare, 1, left, top + i * 4);
        draw_sprite(sprPointanSelectionSquare, 5, right, top + i * 4);
    }
}
