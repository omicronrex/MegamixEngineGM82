#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

grav = 0;
blockCollision = false;
bubbleTimer = -1;

// set defaults
standardPhysics = false;
face_player = false;
face_player_on_talk = false;

idle_speed = 0.33;

sinx = 0;
active = 0;

// Variables for the text

//@cc text to display as name
name = 'Infobox ' + string(room * 100);

//@cc color of the name text
name_color = global.nesPalette[34];

//@cc text to display as message
text = '- Contains no message -';

//@cc sets the sprite used for the mugshot in the dialogue box
mugshot_sprite = sprMugshots;

//@cc the starting frame of the mugshot animation
mugshot_start = 0;

//@cc the ending frame of the mugshot animation
mugshot_end = 0;

//@cc the speed of the mugshot animation
mugshot_speed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    sinx += 0.1;
    yspeed = -(cos(sinx) * 0.2);
    y += yspeed;
}
