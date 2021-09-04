#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed = 0;

frozen = 0;
boss = 0; // boolean, is it a boss

faction = 3; // Used for entities colliding with each other

//@cc the amount of damage that must be dealt to the Entity before it dies.
healthpointsStart = 1;
healthpoints = healthpointsStart;

//@cc the amount of damage the Entity does to the player on collision.
contactDamage = 0;

canHit = true; //@cc Boolean. If false, the entity won't take damage.
canDamage = true; //@cc If false, the entity won't deal damage
isTargetable = true; //@cc If false this object will be ignored by the targeting system
spawnEnabled = true; //@cc if this is false, object will never spawn, but will remain dead instead.

// projectiles --
pierces = 2; // 0: destroyed when hits. 1: destroyed unless kills. 2: never destroyed
penetrate = 0; // 0: reflectable. 1: not reflectable, but no damage. 2: bypasses shields
attackDelay = 0;

category = "";

hitTimer = 0; // counts how long it has been since the last time it took damage
iFrames = 0;

ignoreBullet = 0; // special case for ignoring a bullet when reflecting it (thunder beam)
killOverride = true; // special case for special kill effects ala BHB or Tornado Blow
hitterID = 0; // the ID of the object that last hit this entity

// If this is false, the entity will permanently be destroyed if it is ever dead. If true, it will respawn any time it scrolls on-screen.
respawn = true;
dead = false;

/* @cc
    Governs behaviour during screen transitions.
    0: Not visible during transitions.
    1: Visible during transitions.
    2: visible and doesn't reset during transitions.
    3: visible and will not be deactivated outside of section.
*/
shiftVisible = 0;

//@cc If set to true, depth modulating will be disabled for this object.
noFlicker = false;

respawnRange = 4; //@cc distance beyond edge of view at which entity spawns if dead. Set to -1 to make infinite
despawnRange = 4; //@cc distance beyond edge of view at which entity despawns if alive. set to -1 to make infinite

// in order to respawn, this must be set to true. It is set to true when the spawn co-ordinates of the entity surpass both the despawn and respawn range.
beenOutsideView = false;

inWater = 0;
bubbleTimer = 0;

xspeed = 0;
yspeed = 0;
grav = 0.25;
ground = true;

// should the movement scripts block this object's movement at walls? If false, this object will be able to phase through walls.
blockCollision = true;
dieToSpikes = false;
sinkin = 1;
xcoll = 0;
ycoll = 0;

epIsOnPlat = 0;

itemDrop = 0; //This object will be spawned once the entity dies

stopOnFlash = true;
iceTimer = 0; // is iced (frozen cold), and how much remaining time to spend iced
canIce = true; //@cc is it possible to ice this object (usually doesn't matter if canHit is false)

invincible = false; // set this to true to make this enemy invincible no matter what
sparkleTimer = 0;

doesTransition = true; // carries mega man through transitions

// do other entities see this entity as a solid (i.e. a moving platform).
// 0: not solid. 1: fully solid. 2: top-solid.
isSolid = 0;

// if set to true, will only be solid to entities of faction that it is friendly towards.
// set it to 2 for the opposite
fnsolid = 0;

spawned = -1; // parameter for spawn event; -1 indicates never spawned
deadTimer = 0;

// the enemy object this entity currently sees as its primary target. Useful for programming any kind of enemy AI which responds to the player.
target = noone;

//@cc The strategy the enemy should use to pick which player to target
// 0: generic
// 1: always nearest
// 2: switch every few seconds
// 3: custom
// 4: pick once, never switch
behaviourType = 0;

//@cc
facePlayerOnSpawn = false;

//@cc
facePlayer = false;

// Store special damage values
specialDamageValues[0] = 0;
specialDamageValues[1] = 0;
specialDamageValuesTotal = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (dead) // Respawning
{
    if (!respawn)
    {
        instance_destroy();
        exit;
    }

    // reset to initial position
    y = ystart;
    x = xstart;

    if (!spawnEnabled || (respawnRange != -1
        && (bbox_right + respawnRange < view_xview[0]
        || bbox_left - respawnRange > view_xview[0] + view_wview[0]
        || bbox_bottom + respawnRange < view_yview[0]
        || bbox_top - respawnRange > view_yview[0] + view_hview[0])))
    {
        beenOutsideView = true;
    }

    // respawning when it's onscreen
    if (beenOutsideView && spawnEnabled)
    {
        if (respawnRange == -1
            || (bbox_right + respawnRange >= view_xview[0]
            && bbox_left - respawnRange <= view_xview[0] + view_wview[0]
            && bbox_bottom + respawnRange >= view_yview[0]
            && bbox_top - respawnRange <= view_yview[0] + view_hview[0]))
        {
            // check for water
            if (inWater != -1)
            {
                inWater = place_meeting(x, y, objWater);
            }
            dead = false;
            beenOutsideView = false;
            iFrames = 0;
            spawned = true;

            // check spawn condition object
            if (faction != 1 && faction != 2)
            {
                with (objSpawnCondition)
                {
                    if (faction != other.faction && faction > -1)
                    {
                        continue;
                    }

                    if (place_meeting(x, y, other))
                    {
                        event_user(0);

                        if (!allowSpawn)
                        {
                            other.beenOutsideView = sign(despawnType);
                            other.dead = true;
                            other.spawned = false;
                        }
                        break;
                    }
                }
            }

            if (spawned)
            {
                event_user(EV_SPAWN); // spawn event
            }
        }
    }
}
else
{
    // if entity has not yet triggered spawn event
    // but is alive anyway (e.g. if created inside section)
    // then it should spawn now.
    if (spawned == -1)
    {
        spawned = true;
        event_user(EV_SPAWN);
    }
}

if (!dead && !global.frozen)
{
    if (despawnRange != -1) // Despawning
    {
        if (bbox_right + despawnRange < view_xview
            || bbox_left - despawnRange > view_xview + view_wview
            || bbox_bottom + despawnRange < view_yview
            || bbox_top - despawnRange > view_yview + view_hview)
        {
            dead = true;
            spawned = false;

            event_user(EV_SPAWN); // despawn event
        }
    }
}

// Reset variables if it's dead
if (dead)
{
    // deal with resetting freezing
    if (iceTimer > 0)
    {
        iceTimer = 1;
        entityHandleIced();
    }
    iceTimer = 0;
    healthpoints = healthpointsStart; // reset health

    // reset position and speed
    if (deadTimer == 0)
    {
        x = xstart;
        y = ystart;
    }

    speed = 0;
    hspeed = 0;
    vspeed = 0;
    xspeed = 0;
    yspeed = 0;
}
else if (!global.frozen) // Basically everything prtEntity should usually be doing
{
    beenOutsideView = false;
    plt = 0;

    entityHandleIced(); // handle being frozen (e.g. chill spike)
    entityHandleWater();

    if (iFrames > 0)
    {
        iFrames -= 1;
    }
    hitTimer++;

    setTargetStep(); // Targeting other entities (megaman, other players in co-op, etc)

    // Collision and gravity scripts
    if (entityCanStep())
    {
        xprevious = x;
        yprevious = y;

        checkGround();
        gravityEffect();

        if (blockCollision)
        {
            generalCollision();
        }
        else
        {
            x += xspeed;
            y += yspeed;
        }

        entityPlatform();

        checkGround();

        if (iceTimer == 0 && facePlayer)
        {
            calibrateDirection();
        }

        // special invincible effect handling
        if (invincible == true)
        {
            sparkleTimer ++;
            if (!(sparkleTimer mod 6))
            {
                with (instance_create(bboxGetXCenter(), bboxGetYCenter(), objSlideDust))
                {
                    sprite_index = sprShine;
                    image_xscale = choose(1, -1);
                    direction = irandom(360);
                    rotationMovement(xstart, ystart, irandom_range(5, 12), 0);
                }
            }
        }
    }
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (dead)
{
    if (!respawn)
    {
        instance_destroy();
    }
}
else if (!global.frozen)
{
    // if entity has not yet triggered spawn event
    // but is alive anyway (e.g. if created inside section)
    // then it should spawn now.
    if (spawned == -1)
    {
        spawned = true;
        event_user(EV_SPAWN);
    }

    // entity-entity collision event.
    // For gms 1.4 compilation efficiency
    // reasons, this cannot go in a typical
    // collision event.

    if (contactDamage != 0 && canDamage)
    {
        if (place_meeting(x, y, prtEntity))
        {
            with (prtEntity)
            {
                if (!dead && iFrames == 0)
                {
                    if (canHit)
                    {
                        if (global.factionStance[other.faction, faction])
                        {
                            if (hitTimer >= other.attackDelay)
                            {
                                if (place_meeting(x, y, other))
                                {
                                    with (other)
                                    {
                                        entityEntityCollision();
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
#define Other_17
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// EV_REFLECTED: when being reflected
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// EV_ATTACK: object is hitting something
#define Other_19
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// EV_HURT: getting hit successfully

iFrames = 4;

playSFX(sfxEnemyHit);
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// EV_DEATH: death

dead = 1;

var _ex = instance_create(bboxGetXCenter(), bboxGetYCenter(), objExplosion);

if (itemDrop == objKey)
{
    _ex = instance_create(bboxGetXCenter() - 8, bboxGetYCenter() - 8, objKey);
    _ex.yspeed = -4;
    _ex.homingTimer = 90;
    playSFX(sfxKeySpawn);
}
else if(itemDrop == objEnergyElement)
{
    _ex = instance_create(bboxGetXCenter() - 8, bboxGetYCenter() - 8, objEnergyElement);
}
else
{
    _ex.myItem = itemDrop;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// EV_GUARD: reflect before getting hit
// You can use this event to create code for special interactions between an enemy and a player projectile

// This event is called when an enemy collides with a player projectile
// You can reflect the bullet by setting "other.guardCancel" to 1
// or you can outright cancel the collision event by setting "other.guardCancel" to 2.

// Note that this will have different effects with piercing weapons. Piercing weapons
// will ignore guardCancel 1, etc.. If you want piercing weapons to pass through but other
// weapons to use reflect animation, set "other.guardCancel" to 3.

// If you want to reflect the bullet no matter what (some weapons have unique reflecting
// animations if they're piercing ones to allow this) set "other.guardCancel" to 4.
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// EV_WEAPON_SETDAMAGE: Set damage for weapons and weaknesses for enemies
for (i = 0; i < specialDamageValuesTotal; i++)
{
    var indx = i * 2;
    if (specialDamageValues[indx] != -1)
    {
        specialDamageValue(specialDamageValues[indx], specialDamageValues[indx + 1]);
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// EV_SPAWN: spawn/despawn event
// use this for custom spawn event code.
// Note that this is not by triggered when the object is destroyed;
// thus, an object which spawns need not eventually despawn.
// it is triggered if the object dies, though.
// variable spawned is 1 if this is a proper spawn event, or 0 if the object is despawning.

if (spawned)
{
    setTargetStep();
    healthpoints = healthpointsStart;

    // face player
    if (facePlayerOnSpawn)
    {
        calibrateDirection();
    }
}

if (DEBUG_SPAWN)
{
    var text = " spawn ";
    if (!spawned)
        text = " despawn ";
    print(object_get_name(object_index) + text + " (" + string(x) + ", " + string(y) + ")");
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!dead)
{
    // this debug message should be left in until
    // the spawn system stops breaking every week.
    if (spawned == -1)
    {
        show_debug_message(object_get_name(object_index) + " drawn without having ever spawned!");
    }
    if ((ceil(iFrames / 2) mod 4) || !iFrames)
    {
        var iceBlinkTime = 42;
        if ((ceil(iFrames / 2) mod 2) || (iceTimer > 0 && (iceTimer > iceBlinkTime || (iceTimer <= iceBlinkTime && iceTimer mod 4 == 0))))
        {
            var flashcol = c_white;
            if (iceTimer > 0 && (iceTimer > iceBlinkTime || (iceTimer <= iceBlinkTime && iceTimer mod 4 == 0)))
            {
                switch (iceGraphicStyle)
                {
                    case 1:
                        flashcol = 0;
                        break;
                    default:
                        flashcol = make_color_rgb(0, 120, 255);
                        break;
                }
            }

            d3d_set_fog(true, flashcol, 0, 0);
            drawSelf();
            d3d_set_fog(false, 0, 0, 0);

            if (iceTimer > 0 && (iceTimer > iceBlinkTime || (iceTimer <= iceBlinkTime && iceTimer mod 4 == 0)))
            {
                draw_set_blend_mode(bm_add);
                drawSelf();
                draw_set_blend_mode(bm_normal);
            }
        }
        else
        {
            // Special effect when invincibile
            if (invincible == true)
            {
                d3d_set_fog(true, c_white, 0, 0);
                draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * 1.075 + (sin(sparkleTimer * 0.15) *.08 * sign(image_xscale)), image_yscale * 1.025 + (sin(sparkleTimer * 0.15) *.08 * sign(image_yscale)), image_angle, image_blend, image_alpha);
                d3d_set_fog(false, 0, 0, 0);
            }

            drawSelf();
        }
    }
}
