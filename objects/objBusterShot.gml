#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited(); //needs to be called since parent needs to be defined for the switch statement to work

if object_index == objNormalBusterShot
{
    scrBusterDefault_Create();
}
else if instance_exists(parent)
{
    switch (global.characterSelected[parent.playerID])
    {
        //All 3 of these characters essentially have the same buster so only bass has a different one for now. I'll change Proto Man's soon actually.
        default:
        case "Mega Man":
        case "Proto Man":
        case "Roll":
        {
            scrBusterDefault_Create();
            break;
        }
        case "Bass":
        {
            scrBusterBass_Create();
            dir = 0;
            break;
        }
    }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//This is only needed for bass currently. But this can be added to for any character.
event_inherited();

if (!global.frozen && object_index != objNormalBusterShot && instance_exists(parent))
{
    switch (global.characterSelected[parent.playerID])
    {
        case "Bass":
        {
            scrBusterBass_Step();
            break;
        }
    }
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
switch (global.characterSelected[0])
{
    default:
    case "Mega Man":
    {
        weaponSetup("MEGA BUSTER", -1, -1, sprWeaponIconsMegaBuster);
        break;
    }
    case "Proto Man":
    {
        weaponSetup("PROTO BUSTER", -1, -1, sprWeaponIconsMegaBuster);
        break;
    }
    case "Bass":
    {
        weaponSetup("BASS BUSTER", -1, -1, sprWeaponIconsMegaBuster);
        break;
    }
    case "Roll":
    {
        weaponSetup("ROLL BUSTER", -1, -1, sprWeaponIconsMegaBuster);
        break;
    }
}
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if object_index == objNormalBusterShot //normal shots
    scrBusterDefault_14();
else
{
    switch (global.characterSelected[playerID])
    {
        default: //All characters besides Bass and Proto Man use the same event
        case "Mega Man":
        case "Roll":
        {
            scrBusterDefault_14();
            break;
        }
        case "Bass":
        {
            scrBusterBass_14();
            break;
        }
        case "Proto Man":
        {
            scrBusterProto_14();
        }
    }
}
