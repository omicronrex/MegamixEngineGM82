#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
healthpointsStart = 1;
healthpoints = healthpointsStart;
category = "cluster, flying";
blockCollision = 0;
grav = 0;

// not confirmed:
contactDamage = 3;
image_speed = 0;
image_index = 0;
sprite_index = sprYonbain;

// can be edited in creation code: 0 = orange, 1 = purple, 2 = blue
color = 0;
move_distance = 76; // how far to move each cycle
move_time = 90; // how long to take to move each cycle
wait_time = 45; // how long to pause between each cycle
max_alive = 4; // maximum number allowed to exist

// rate at which blink animation plays -=1 higher = slower
animDiv = 4;

// exponential tolerance (used for route planning, must be between 0 and 1.)
// 1: completely linear motion
// near 1: more linear path
// near 0: slows down near end
// 0: jumps directly to end
exp_tol = .08;

// vertical
vertical = false;

// phase:
// 0: blink
// 1: move
// 2: split (parent)
// 3: split (daughter)
// 4: pre-split eye close
phase = 0;
phaseTimer = 0;
split_dist = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    anim = 0;
    switch (phase)
    {
        case 0: // blink
            xspeed = 0;
            yspeed = 0;
            anim = phaseTimer div animDiv;
            if (anim > 2)
                anim = 6 - anim;
            anim = min(anim, 2);
            anim = max(0, anim);
            if (phaseTimer >= wait_time)
            {
                phase = 1;
                phaseTimer = 0;

                // determine move direction:
                if (instance_exists(target))
                {
                    var move_speed; move_speed = 0;
                    if (exp_tol >= 1)
                        move_speed = move_distance / move_time;
                    else if (exp_tol <= 0)
                        move_speed = move_distance;
                    else
                        move_speed = -move_distance * ln(exp_tol) / (move_time * (1 - exp_tol));

                    // spread away from other things of this sort:
                    var nearest; nearest = 1000;
                    var nearest_id; nearest_id = -1;
                    with (objYonbainHorizontal)
                        if (point_distance(x, y, other.x, other.y) > 0)
                        {
                            nearest = min(nearest, point_distance(x, y, other.x, other.y));
                            nearest_id = id;
                        }
                    var target_x; target_x = target.x;
                    var target_y; target_y = target.y;
                    if (nearest < 30)
                    {
                        target_x += 24 * sign(x - nearest_id.x);
                        target_y += 24 * sign(y - nearest_id.y);
                    }

                    // move to target
                    var dir; dir = degtorad(point_direction(x, y, target_x, target_y));
                    xspeed = cos(dir) * move_speed;
                    yspeed = -sin(dir) * move_speed;
                }
            }
            break;
        case 1: // move and slow down
            anim = 0;
            var decay; decay = 1;
            if (exp_tol <= 0)
                decay = 0;
            else if (exp_tol < 1)
            {
                decay = exp(ln(exp_tol) / move_time);
            }
            xspeed *= decay;
            yspeed *= decay;

            // advance to next phase
            if (phaseTimer >= move_time)
            {
                phaseTimer = 0;
                phase = 4;

                // skip split phase if too many already
                var aliveCount; aliveCount = 0;
                with (objYonbainHorizontal)
                    if (!dead)
                        aliveCount += 1 + (phase == 2 || phase == 4);
                if (aliveCount > max_alive)
                    phase = 0;
            }
            break;
        case 2: // split (parent)
            xspeed = 0;
            yspeed = 0;
            split_dist = phaseTimer / 2;
            if (split_dist >= 7)
            {
                phaseTimer = 0;
                phase = 3;
                xspeed = -1 * !vertical / 4;
                yspeed = -1 * vertical / 4;
                var split_jump_x; split_jump_x = split_dist * !vertical;
                var split_jump_y; split_jump_y = split_dist * vertical;
                split_dist = 0;
                anim = 2;
                image_index = anim + 7 * vertical;
                with (instance_create(x + split_jump_x, y + split_jump_y, object_index))
                {
                    color = other.color;
                    exp_tol = other.exp_tol;
                    move_distance = other.move_distance;
                    move_time = other.move_time;
                    max_alive = other.max_alive;
                    xspeed = -1 * other.xspeed;
                    yspeed = -1 * other.yspeed;
                    respawn = false;
                    phase = 3;
                    image_index = other.image_index;
                }
                x -= split_jump_x;
                y -= split_jump_y;
            }
            break;
        case 3: // split (daughter)
            anim = 5;
            var spd; spd = max(abs(xspeed), abs(yspeed));
            if (xspeed + yspeed > 0)
                anim = 6;
            if (phaseTimer * spd > 3)
                anim = max(0, 2 - (phaseTimer - (4 / spd)) div animDiv);
            if (phaseTimer / 4 >= 7)
            {
                anim = 0;
                xspeed = 0;
            }
            if (phaseTimer / 4 >= 14)
            {
                anim = 0;
                phase = 0;
                phaseTimer = 0;
            }
            break;
        case 4: // pre-split eye close
            xspeed = 0;
            anim = phaseTimer div animDiv;
            if (anim > 2)
            {
                anim = 0;
                phaseTimer = 0;
                phase = 2;
                playSFX(sfxYonbain);
            }
            break;
    }
    phaseTimer+=1;
    image_index = anim + 7 * vertical;
}
else if (dead)
{
    xspeed = 0;
    yspeed = 0;
    phaseTimer = 0;
    phase = 0;
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// changing sprite index / origin
xstart += 8;
ystart += 8;
x += 8;
y += 8;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
switch(color)
{
    case 1:
        sprite_index = sprYonbainPurple;
        break;
    case 2:
        sprite_index = sprYonbainBlue;
        break;
    default:
        sprite_index = sprYonbain;
        break;
}
