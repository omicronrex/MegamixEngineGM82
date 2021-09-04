#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
timer = 0;
phase = 0;

creditsPosition = view_hview * 1.1;

creditsText =
"MEGAMIX ENGINE




MAGMML HOSTS

Mick Galbani
ACESpark
snoruntpyro


ORIGINAL MEGA ENGINE

WreckingPrograms




PROGRAMMERS

ACESpark
an absolute loser
Beed28
Cruise Elroy
Duan'duliir
Fabian
GingerMochi
Mick Galbani
MiniMacro
MystSvin
PhazonMotherBrain
Renhoek
snoruntpyro
Spin Attaxx
ThatEntityGuy
The Stove Guy
WreckingPrograms
Zatsupachi


ORIGINAL MEGA MAN SPRITES

Capcom


NEW ART

ACESpark
Beed28
Cresh
E-Clare
Flashman85
gregarlink10
gone-sovereign
M-Jacq
MiniMacro
Pachy
Spin Attaxx
StOil
ThatEntityGuy



AUDIO

CosmicGem
MiniMacro



BETA TESTING

Art
CSketch
CWU-01P
Flashman85
gone-sovereign
ParmaJon



TILESET RIPPING + ORGANIZATION

GingerMochi
TimeLink



WEAPON OF THE WEEK

Beed28
CSketch
Fabian
snoruntpyro
Spin Attaxx
TimeLink
ThatEntityGuy




EXAMPLE GAME


MISCELLANEOUS PROGRAMMING

GingerMochi
snoruntpyro
ThatEntityGuy


EASY AND NORMAL MODE LEVELS

ACESpark
CSketch
CWU-01P
GingerMochi
snoruntpyro
Zatsupachi


HARD MODE LEVELS

GUTS MAN
MiniMacro

FLASH MAN
TimeLink

GEMINI MAN
M-Jacq, CSketch

PHARAOH MAN
snoruntpyro

STONE MAN
CWU-01P

PLANT MAN
Beed28, snoruntpyro

HONEY WOMAN
CWU-01P

CHILL MAN
CSketch

WILY 1 (DARK MAN 1)
Zatsupachi, CSketch

WILY 2 (MM4 WILY 1)
TimeLink

WILY 3 (MM9 WILY 3)
TimeLink

WILY 4 (MR. X 4)
snoruntpyro

WILY 5 (MM10 WILY 4)
CSketch



SPECIAL THANKS

Every team member honestly
WreckingPrograms

And you! (?)



Thank you for playing!
";
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
timer ++;

switch phase
{
    // rise up
    case 0:
        creditsPosition -= (.5 + (global.keyJump[0] * 2));

        if creditsPosition < -1275 // 1 minute
        {
            timer = 0;
            phase = 1;

            creditsText = "Thank you for playing!";
            creditsPosition = (view_hview/2) - 4;
        }

        if timer == 10
        {
            stopMusic();
            playMusic("Mega_Man_2.nsf", "VGM", 21, 0, 0, 0, 1);
        }
        break;
    case 1:
        // sparkles =w=
        if (timer mod 3 == 0)
        {
            with (instance_create(view_xview + irandom_range(0, view_wview), view_yview + irandom_range(0, view_hview), objSlideDust))
            {
                sprite_index = sprShine;
                image_xscale = choose(1, -1);
                direction = irandom(360);
                rotationMovement(xstart, ystart, irandom_range(5, 12), 0);
            }
        }

        // reset game if jump or pause button is pressed
        if ((global.keyJumpPressed[0] || global.keyPausePressed[0]) && (timer > 60))
        {
            game_restart();
        }
        break;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_halign(fa_center);
draw_set_valign(fa_top);

draw_text(view_xview + 128, creditsPosition, creditsText);
