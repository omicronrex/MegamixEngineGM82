#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
isGround=false;
tileTop=0;
tileLeft=0;
tileWidth=16;
tileHeight=16;
tile=noone;
tileBG = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if(global.gameTimer mod 2)
    exit;

if(!global.frozen)
{
    if(global.telTelWeather!=2||!tile_exists(tile))
        instance_destroy();
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
d3d_set_fog(true, make_color_rgb(0, 120, 255), 0, 0);
draw_background_part(tileBG,tileLeft,tileTop,tileWidth,tileHeight,x,y);
d3d_set_fog(false, 0, 0, 0);

draw_set_blend_mode(bm_add);
draw_background_part(tileBG,tileLeft,tileTop,tileWidth,tileHeight,x,y);
draw_set_blend_mode(bm_normal);
if(isGround)
    draw_sprite_ext(sprRevealingTilesSnow,0,x,y,1,1,0,c_white,1);
