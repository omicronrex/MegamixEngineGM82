#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Spider that crawls on ceilings and falls when megaman is close,
// if placed on the ground it will jump towards megaman inmediately.
// When its not on the ceiling it will randomly choose bewteen 2 and 1 jump

// Note:The rest of the code in darspider
sprite_index = sprDeispider;
mask_index = sprDeispider;
x += abs(sprite_get_xoffset(sprDarspider) - sprite_get_xoffset(sprDarspiderPreview));
y -= image_yscale * (abs(sprite_get_yoffset(sprDarspider) - sprite_get_yoffset(sprDarspiderPreview)));
var prevx = x;
var prevy = y;
event_inherited();
sprite_index = sprDeispider;
mask_index = sprDeispider;
x = prevx;
y = prevy;
xstart = x;
ystart = y;

// Setup
isDei = true;
ceilingSpeed = 0.65;
ceilingAnimSpeed = 0.1;
landAnimSpeed = 0.35;
healthpointsStart = 2;
healthpoints = 2;
