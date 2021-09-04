#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Handles controls for Android platforms.

if (os_type != os_android)
{
    instance_destroy();
    exit;
}

device_mouse_dbclick_enable(false);

js_center_x = 0;
js_center_y = 0;

js_null_radius_frac = 1 / 32;
js_drag_radius_frac = 1 / 23;

// simulated digital input -- values are -1, 0, or 1
js_h = 0;
js_v = 0;
js_jump = false;
js_jump_v_dampening = 0.92;

js_shoot_x = 0;
js_shoot_y = 0;
integrate_shot = 0;

// portion of screen belonging to joystick
dev_split_frac = 0.85;

pauseFrac = 0.1;
jump_frac = 0.25;
slide_frac = 0.7;

// remember if mouse pressed for UI.
cursorDown = false;
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var _width = view_wview[0];
var _height = view_hview[0];

var _js_null_radius = _height * js_null_radius_frac;
var _js_drag_radius = _height * js_drag_radius_frac;

// can simulate jump/drop by flicking upward
var simjump = false;
with (objMegaman)
{
    if (!climbing && !global.frozen)
        simjump = true;
}

// charges automatically when not held down
var simshot = false;
with (objMegaman)
{
    if (!global.frozen)
        simshot = true;
}

if (simshot)
    keyShoot[0] = true;

cursorDown = false;

for (var i = 0; i < 5; i++)
{
    if (device_mouse_check_button(i, mb_left))
    {
        var _x = device_mouse_x(i) - view_xview[0]
            ;
        var _y = device_mouse_y(i) - view_yview[0]
            ;
        var _pressed = device_mouse_check_button_pressed(i, mb_left);
        if (_x < _width * dev_split_frac)
        {
            cursorDown = true;

            // joystick
            if (_pressed)
            {
                js_center_x = _x;
                js_center_y = _y;
                js_h = 0;
                js_v = 0;
                js_jump = false;
            }
            else
            {
                // drag joystick
                var dx = _x - js_center_x;
                var dy = _y - js_center_y;
                js_center_x += sign(dx) * max(abs(dx) - _js_drag_radius, 0);
                js_center_y += sign(dy) * max(abs(dy) - _js_drag_radius, 0);
                if (simjump)
                    js_center_y = (js_jump_v_dampening) * js_center_y + (1 - js_jump_v_dampening) * _y;
            }

            // determine key input
            var dist = point_distance(js_center_x, js_center_y, _x, _y)
                ;
            if (dist < _js_null_radius)
            {
                js_h = 0;
                js_v = 0;
            }
            else
            {
                var angle = point_direction(js_center_x, js_center_y, _x, _y);
                global.keyUp[0] = (angle > 30 && angle < 150);
                global.keyDown[0] = (angle > 210 && angle < 330);
                global.keyLeft[0] = (angle > 120 && angle < 240);
                global.keyRight[0] = (angle < 60 || angle > 310);
            }

            global.keyUpPressed[0] = (global.keyUp[0] && js_v != -1);
            global.keyDownPressed[0] = (global.keyDown[0] && js_v != 1);
            global.keyLeftPressed[0] = (global.keyLeft[0] && js_h != -1);
            global.keyRightPressed[0] = (global.keyRight[0] && js_h != 1);

            js_v = global.keyDown[0] - global.keyUp[0];
            js_h = global.keyRight[0] - global.keyLeft[0];

            // simulated jump by up-flick
            if (simjump)
            {
                if (global.keyUp[0])
                {
                    if (!js_jump)
                        global.keyJumpPressed[0] = true;
                    js_jump = true;
                }
                else if (global.keyDown[0])
                {
                    js_jump = false;
                }


                global.keyJump[0] = js_jump;
            }
        }
        else
        {
            // shoot / slide / pause commands
            if (_pressed && simshot)
            {
                js_shoot_x = _x;
                js_shoot_y = _y;
                integrate_shot = 0;
            }
            if (_y < _height * pauseFrac)
            {
                global.keyPause[0] = true;
                global.keyPausePressed[0] = _pressed;
            }
            else if (_y < _height * jump_frac)
            {
                global.keyJump[0] = true;
                global.keyJumpPressed[0] |= _pressed;
            }
            else if (_y < _height * slide_frac)
            {
                global.keySlide[0] = true;
                global.keySlidePressed[0] = _pressed;
            }
            else
            {
                global.keyShoot[0] = true;
                global.keyShootPressed[0] = _pressed;
            }

            // simshooting
            if (simshot)
            {
                integrate_shot += min(0, point_distance(_x, _y, js_shoot_x, js_shoot_y) - 1.5);
                if (integrate_shot > 20)
                {
                    global.keyShootPressed[0] = true;
                    global.keyShoot[0] = true;
                    integrate_shot -= 20;
                }
            }

            js_shoot_x = _x;
            js_shoot_y = _y;
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!cursorDown)
    exit;

var _width = view_wview[0];
var _height = view_hview[0];

var _x = js_center_x + view_xview[0];
var _y = js_center_y + view_yview[0];

var _js_null_radius = _height * js_null_radius_frac;
var _js_drag_radius = _height * js_drag_radius_frac;

draw_set_color(c_white);
draw_set_alpha(0.4);

draw_circle(_x, _y, _js_drag_radius, false);
draw_circle(_x, _y, _js_null_radius, false);

draw_set_alpha(10);
