// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    if ( !isdefined( level.func ) )
        level.func = [];

    level.func["setsaveddvar"] = ::setsaveddvar;
    level.func["useanimtree"] = ::useanimtree;
    level.func["setanim"] = ::setanim;
    level.func["setanimknob"] = ::setanimknob;
    level.func["setflaggedanimknob"] = ::setflaggedanimknob;
    level.func["setflaggedanimknobrestart"] = ::setflaggedanimknobrestart;
    level.func["setanimlimited"] = ::setanimlimited;
    level.func["setanimtime"] = ::setanimtime;
    level.func["getanimtime"] = ::getanimtime;
    level.func["getanimlength"] = ::getanimlength;
    level.func["clearanim"] = ::clearanim;
    level.func["kill"] = ::kill;
    level.func["magicgrenade"] = ::magicgrenade;
    set_early_level();
    maps\_utility::set_console_status();
    level.global_callbacks = [];
    level.global_callbacks["_autosave_stealthcheck"] = ::global_empty_callback;
    level.global_callbacks["_patrol_endon_spotted_flag"] = ::global_empty_callback;
    level.global_callbacks["_spawner_stealth_default"] = ::global_empty_callback;
    level.global_callbacks["_idle_call_idle_func"] = ::global_empty_callback;
    common_scripts\utility::flag_init( "_cloaked_stealth_enabled" );

    if ( !isdefined( level.visionthermaldefault ) )
        level.visionthermaldefault = "default";

    visionsetthermal( level.visionthermaldefault );
    visionsetpain( "near_death" );
    level.func["damagefeedback"] = maps\_damagefeedback::updatedamagefeedback;
    common_scripts\utility::array_thread( getentarray( "script_model_pickup_claymore", "classname" ), ::claymore_pickup_think_global );
    common_scripts\utility::array_thread( getentarray( "ammo_cache", "targetname" ), ::ammo_cache_think_global );
    maps\_utility::array_delete( getentarray( "trigger_multiple_softlanding", "classname" ) );

    if ( getdvar( "debug" ) == "" )
        setdvar( "debug", "0" );

    if ( getdvar( "fallback" ) == "" )
        setdvar( "fallback", "0" );

    if ( getdvar( "angles" ) == "" )
        setdvar( "angles", "0" );

    if ( getdvar( "noai" ) == "" )
        setdvar( "noai", "off" );

    if ( getdvar( "scr_RequiredMapAspectratio" ) == "" )
        setdvar( "scr_RequiredMapAspectratio", "1" );

    setdvar( "ac130_player_num", -1 );
    setdvar( "ui_remotemissile_playernum", 0 );
    setdvar( "ui_pmc_won", 0 );
    setdvar( "ui_actionSlot_1_forceActive", "off" );
    setdvar( "ui_actionSlot_2_forceActive", "off" );
    setdvar( "ui_actionSlot_3_forceActive", "off" );
    setdvar( "ui_actionSlot_4_forceActive", "off" );
    setdvar( "ui_dog_grenade", 0 );
    setdvar( "ui_securing", "" );
    setdvar( "ui_securing_progress", 0.0 );
    setdvar( "hud_showObjectives", 1 );
    setdvar( "hud_showIntel", 1 );
    setdvar( "minimap_sp", 0 );
    setdvar( "minimap_full_sp", 0 );

    if ( !isdefined( anim.notetracks ) )
    {
        anim.notetracks = [];
        animscripts\notetracks::registernotetracks();
    }

    common_scripts\utility::flag_init( "introscreen_complete" );
    maps\_utility::add_start( "no_game", ::start_nogame );
    add_no_game_starts();
    level._loadstarted = 1;
    level.first_frame = 1;
    level.level_specific_dof = 0;
    thread remove_level_first_frame();
    level.wait_any_func_array = [];
    level.run_func_after_wait_array = [];
    level.run_call_after_wait_array = [];
    level.run_noself_call_after_wait_array = [];
    level.do_wait_endons_array = [];
    level.abort_wait_any_func_array = [];

    if ( !isdefined( level.script ) )
        level.script = tolower( getdvar( "mapname" ) );

    precacheshader( "black" );
    precacheshader( "white" );
    precacheshader( "fullscreen_lit_bloodsplat_01" );

    if ( level.currentgen )
        precacheshader( "vfx_blood_screen_overlay" );

    level.ai_number = 0;

    if ( !isdefined( level.flag ) )
        common_scripts\utility::init_flags();
    else
    {
        var_0 = getarraykeys( level.flag );
        common_scripts\utility::array_levelthread( var_0, ::check_flag_for_stat_tracking );
    }

    init_level_players();

    if ( issplitscreen() )
        setsaveddvar( "cg_fovScale", "0.75" );
    else
        setsaveddvar( "cg_fovScale", "1" );

    level.radiation_totalpercent = 0;
    common_scripts\utility::flag_init( "missionfailed" );
    common_scripts\utility::flag_init( "auto_adjust_initialized" );
    common_scripts\utility::flag_init( "_radiation_poisoning" );
    common_scripts\utility::flag_init( "gameskill_selected" );
    common_scripts\utility::flag_init( "battlechatter_on_thread_waiting" );
    common_scripts\utility::flag_init( "start_is_set" );
    thread maps\_gameskill::aa_init_stats();
    thread player_death_detection();
    level.default_run_speed = 190;
    setsaveddvar( "g_speed", level.default_run_speed );

    if ( maps\_utility::is_specialop() )
        setsaveddvar( "sv_saveOnStartMap", 0 );
    else if ( isdefined( level.credits_active ) )
        setsaveddvar( "sv_saveOnStartMap", 0 );
    else
        setsaveddvar( "sv_saveOnStartMap", 1 );

    common_scripts\utility::create_lock( "mg42_drones" );
    common_scripts\utility::create_lock( "mg42_drones_target_trace" );
    level.dronestruct = [];

    foreach ( var_3, var_2 in level.struct )
    {
        if ( !isdefined( var_2.targetname ) )
            continue;

        if ( var_2.targetname == "delete_on_load" )
            level.struct[var_3] = undefined;
    }

    common_scripts\utility::struct_class_init();
    common_scripts\utility::flag_init( "player_flashed" );
    level.connectpathsfunction = ::connectpaths;
    level.disconnectpathsfunction = ::disconnectpaths;
    level.badplace_cylinder_func = ::badplace_cylinder;
    level.badplace_delete_func = ::badplace_delete;
    level.isaifunc = ::isai;
    level.createclientfontstring_func = maps\_hud_util::createclientfontstring;
    level.hudsetpoint_func = maps\_hud_util::setpoint;
    level.makeentitysentient_func = ::makeentitysentient;
    level.freeentitysentient_func = ::freeentitysentient;
    level.laseron_func = ::laseron;
    level.laseroff_func = ::laseroff;
    level.stat_track_kill_func = maps\_player_stats::register_kill;
    level.stat_track_damage_func = maps\_player_stats::register_shot_hit;
    level.dopickyautosavechecks = 1;
    level.autosave_threat_check_enabled = 1;
    level.getnodefunction = ::getnode;
    level.getnodearrayfunction = ::getnodearray;
    level.addaieventlistener_func = ::addaieventlistener;

    if ( !isdefined( level._notetrackfx ) )
        level._notetrackfx = [];

    if ( !animscripts\battlechatter::use_old_battlechatter() )
    {
        maps\_dds::dds_init();
        maps\_dds::dds_enable();
    }

    foreach ( var_5 in level.players )
    {
        var_5.maxhealth = level.player.health;
        var_5.shellshocked = 0;
        var_5.inwater = 0;
        var_5 thread watchweaponchange();
        var_5 thread maps\_dds::player_init();
    }

    level.last_mission_sound_time = -5000;
    level.hero_list = [];
    thread precache_script_models();

    for ( var_7 = 0; var_7 < level.players.size; var_7++ )
    {
        var_5 = level.players[var_7];
        var_5 thread maps\_utility::flashmonitor();
        var_5 thread maps\_utility::shock_ondeath();
        var_5 thread maps\_utility::never_saw_it_coming();
    }

    precachemodel( "fx" );
    precachemodel( "tag_origin" );
    precachemodel( "tag_ik_target" );
    precacheshellshock( "default" );
    precacheshellshock( "flashbang" );
    precacheshellshock( "dog_bite" );
    precacheshellshock( "dog_bite_hit_shield" );
    precacherumble( "damage_heavy" );
    precacherumble( "damage_light" );
    precacherumble( "grenade_rumble" );
    precacherumble( "artillery_rumble" );
    precacherumble( "slide_start" );
    precacherumble( "slide_loop" );
    precachestring( &"GAME_GET_TO_COVER" );
    precachestring( &"GAME_LAST_STAND_GET_BACK_UP" );
    precachestring( &"SCRIPT_GRENADE_DEATH" );
    precachestring( &"SCRIPT_GRENADE_SUICIDE_LINE1" );
    precachestring( &"SCRIPT_GRENADE_SUICIDE_LINE2" );
    precachestring( &"SCRIPT_EXPLODING_VEHICLE_DEATH" );
    precachestring( &"SCRIPT_EXPLODING_DESTRUCTIBLE_DEATH" );
    precachestring( &"SCRIPT_EXPLODING_BARREL_DEATH" );
    precacheshader( "hud_grenadeicon" );
    precacheshader( "hud_grenadepointer" );
    precacheshader( "hud_burningcaricon" );
    precacheshader( "death_juggernaut" );
    precacheshader( "hud_destructibledeathicon" );
    precacheshader( "hud_burningbarrelicon" );
    precacheshader( "waypoint_ammo" );
    precachestring( &"init_hud" );
    precachestring( &"close_hud" );
    precachelaser( "nvg_laser" );
    level._effect["deathfx_bloodpool_generic"] = loadfx( "vfx/weaponimpact/deathfx_bloodpool_generic" );
    animscripts\pain::initpainfx();
    animscripts\melee::melee_init();
    level.createfx_enabled = getdvar( "createfx" ) != "";
    slowmo_system_init();
    maps\_mgturret::main();
    common_scripts\_exploder::setupexploders();
    maps\_art::main();
    maps\_gameskill::setskill();
    maps\_anim::init();
    thread common_scripts\_fx::initfx();

    if ( level.createfx_enabled )
    {

    }

    maps\_global_fx_code::init();
    maps\_global_fx::main();
    default_footsteps();
    maps\_detonategrenades::init();
    maps\_lighting::light_init();
    maps\_lights::init2();
    maps\_names::setup_names();

    if ( isdefined( level.handle_starts_endons ) )
        thread [[ level.handle_starts_endons ]]();
    else
        thread handle_starts();

    if ( getdvar( "functional_test_starts" ) == "1" )
        thread functional_tester_load_next_start();

    if ( !isdefined( level.trigger_flags ) )
        common_scripts\utility::init_trigger_flags();

    level.killspawn_groups = [];
    soundscripts\_audio::aud_init();
    soundscripts\_snd::snd_init();
    maps\_trigger::init_script_triggers();
    setsaveddvar( "ufoHitsTriggers", "0" );
    maps\_hud::init();
    do_no_game_start();

    if ( getdvar( "g_connectpaths" ) == "2" )
        level waittill( "eternity" );

    maps\_autosave::main();
    thread maps\_sp_matchdata::init();

    if ( !isdefined( level.animsounds ) )
        thread init_animsounds();

    maps\_anim::init();

    if ( isdefined( level.audio_stringtable_mapname ) )
        soundscripts\_audio::set_stringtable_mapname( level.audio_stringtable_mapname );

    anim.usefacialanims = 0;

    if ( !isdefined( level.missionfailed ) )
        level.missionfailed = 0;

    if ( !maps\_utility::is_specialop() )
    {
        maps\_loadout::init_loadout();
        setsaveddvar( "ui_campaign", level.campaign );
    }

    common_scripts\_destructible::init();
    thread maps\_vehicle::init_vehicles();
    setobjectivetextcolors();
    common_scripts\_dynamic_world::init();
    thread maps\_autosave::beginningoflevelsave();
    thread maps\_introscreen::main();
    thread maps\_endmission::main();
    thread maps\_damagefeedback::init();
    maps\_friendlyfire::main();
    common_scripts\utility::array_levelthread( getentarray( "badplace", "targetname" ), ::badplace_think );
    common_scripts\utility::array_levelthread( getentarray( "delete_on_load", "targetname" ), maps\_utility::deleteent );
    common_scripts\utility::array_thread( getnodearray( "traverse", "targetname" ), ::traversethink );
    common_scripts\utility::array_thread( getentarray( "piano_key", "targetname" ), ::pianothink );
    common_scripts\utility::array_thread( getentarray( "piano_damage", "targetname" ), ::pianodamagethink );
    common_scripts\utility::array_thread( getentarray( "water", "targetname" ), ::waterthink );
    common_scripts\utility::array_thread( getentarray( "kill_all_players", "targetname" ), ::kill_all_players_trigger );
    common_scripts\utility::flag_init( "allow_ammo_pickups" );
    common_scripts\utility::flag_set( "allow_ammo_pickups" );
    common_scripts\utility::array_thread( getentarray( "ammo_pickup_grenade_launcher", "targetname" ), ::ammo_pickup, "grenade_launcher" );
    common_scripts\utility::array_thread( getentarray( "ammo_pickup_rpg", "targetname" ), ::ammo_pickup, "rpg" );
    common_scripts\utility::array_thread( getentarray( "ammo_pickup_c4", "targetname" ), ::ammo_pickup, "c4" );
    common_scripts\utility::array_thread( getentarray( "ammo_pickup_claymore", "targetname" ), ::ammo_pickup, "claymore" );
    common_scripts\utility::array_thread( getentarray( "ammo_pickup_556", "targetname" ), ::ammo_pickup, "556" );
    common_scripts\utility::array_thread( getentarray( "ammo_pickup_762", "targetname" ), ::ammo_pickup, "762" );
    common_scripts\utility::array_thread( getentarray( "ammo_pickup_45", "targetname" ), ::ammo_pickup, "45" );
    common_scripts\utility::array_thread( getentarray( "ammo_pickup_pistol", "targetname" ), ::ammo_pickup, "pistol" );
    thread maps\_intelligence::main();
    thread maps\_gameskill::playerhealthregeninit();

    for ( var_7 = 0; var_7 < level.players.size; var_7++ )
    {
        var_5 = level.players[var_7];

        if ( !( getdvarint( "disable_player_regen" ) == 1 ) )
            var_5 thread maps\_gameskill::playerhealthregen();

        var_5 thread playerdamagerumble();
    }

    thread maps\_player_death::main();
    thread massnodeinitfunctions();
    common_scripts\utility::flag_init( "spawning_friendlies" );
    common_scripts\utility::flag_init( "friendly_wave_spawn_enabled" );
    common_scripts\utility::flag_clear( "spawning_friendlies" );
    level.friendly_spawner["rifleguy"] = getentarray( "rifle_spawner", "script_noteworthy" );
    level.friendly_spawner["smgguy"] = getentarray( "smg_spawner", "script_noteworthy" );
    level.spawn_funcs = [];
    level.spawn_funcs["allies"] = [];
    level.spawn_funcs["axis"] = [];
    level.spawn_funcs["team3"] = [];
    level.spawn_funcs["neutral"] = [];
    thread maps\_spawner::goalvolumes();
    thread maps\_spawner::friendlychains();
    thread maps\_spawner::friendlychain_ondeath();
    common_scripts\utility::array_thread( getentarray( "friendly_spawn", "targetname" ), maps\_spawner::friendlyspawnwave );
    common_scripts\utility::array_thread( getentarray( "flood_and_secure", "targetname" ), maps\_spawner::flood_and_secure );
    common_scripts\utility::array_thread( getentarray( "window_poster", "targetname" ), ::window_destroy );

    if ( !isdefined( level.trigger_hint_string ) )
    {
        level.trigger_hint_string = [];
        level.trigger_hint_func = [];
    }

    level.shared_portable_turrets = [];
    level.spawn_groups = [];
    maps\_spawner::main();
    common_scripts\utility::array_thread( getentarray( "background_block", "targetname" ), ::background_block );
    thread load_friendlies();
    thread maps\_animatedmodels::main();
    thread weapon_ammo();

    foreach ( var_10, var_9 in level.missionsettings.levels )
    {
        if ( var_9.name == level.script )
        {
            setsaveddvar( "ui_currentLevelIndex", var_10 );
            break;
        }
    }

    if ( level.script == level.missionsettings.levels[0].name && !level.player getlocalplayerprofiledata( "hasEverPlayed_SP" ) )
        maps\_utility::delaythread( 0.1, ::update_gamer_profile );

    var_11 = level.player getplayersetting( "gameskill" );
    var_12 = level.difficultytype[int( var_11 )];
    setspmatchdata( "start_difficulty", var_12 );
    setspmatchdata( "final_difficulty", var_12 );
    level thread maps\_utility::start_monitor_escape_artist();

    // precache custom stuff
    maps\gfl\_utility::precache_all_viewmodels();
    maps\gfl\_utility::precache_all_characters();

    level notify( "load_finished" );
    run_post_function();
    level.player thread maps\_utility::logbreadcrumbdatasp();
}

update_gamer_profile()
{
    level.player setlocalplayerprofiledata( "hasEverPlayed_SP", 1 );
    updategamerprofile();
}

run_post_function()
{
    if ( isdefined( level.post_load_funcs ) )
    {
        foreach ( var_1 in level.post_load_funcs )
            [[ var_1 ]]();
    }
}

set_early_level()
{
    level.early_level = [];
    level.early_level["seoul"] = 1;
    level.early_level["recovery"] = 1;
    level.early_level["lagos"] = 1;
    level.early_level["fusion"] = 1;
}

weapon_ammo()
{
    var_0 = getentarray();

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        if ( isdefined( var_0[var_1].classname ) && getsubstr( var_0[var_1].classname, 0, 7 ) == "weapon_" )
        {
            var_2 = var_0[var_1];
            var_3 = getsubstr( var_2.classname, 7 );

            if ( isdefined( var_2.script_ammo_max ) )
            {
                var_4 = weaponclipsize( var_3 );
                var_5 = weaponmaxammo( var_3 );
                var_2 itemweaponsetammo( var_4, var_5, var_4, 0 );
                var_6 = weaponaltweaponname( var_3 );

                if ( var_6 != "none" )
                {
                    var_7 = weaponclipsize( var_6 );
                    var_8 = weaponmaxammo( var_6 );
                    var_2 itemweaponsetammo( var_7, var_8, var_7, 1 );
                }

                continue;
            }

            var_9 = 0;
            var_4 = undefined;
            var_10 = undefined;
            var_11 = 0;
            var_12 = undefined;
            var_13 = undefined;

            if ( isdefined( var_2.script_ammo_clip ) )
            {
                var_4 = var_2.script_ammo_clip;
                var_9 = 1;
            }

            if ( isdefined( var_2.script_ammo_extra ) )
            {
                var_10 = var_2.script_ammo_extra;
                var_9 = 1;
            }

            if ( isdefined( var_2.script_ammo_alt_clip ) )
            {
                var_12 = var_2.script_ammo_alt_clip;
                var_11 = 1;
            }

            if ( isdefined( var_2.script_ammo_alt_extra ) )
            {
                var_13 = var_2.script_ammo_alt_extra;
                var_11 = 1;
            }

            if ( var_9 )
            {
                if ( !isdefined( var_4 ) )
                {

                }

                if ( !isdefined( var_10 ) )
                {

                }

                var_2 itemweaponsetammo( var_4, var_10 );
            }

            if ( var_11 )
            {
                if ( !isdefined( var_12 ) )
                {

                }

                if ( !isdefined( var_13 ) )
                {

                }

                var_2 itemweaponsetammo( var_12, var_13, 0, 1 );
            }
        }
    }
}

exploder_load( var_0 )
{
    level endon( "killexplodertridgers" + var_0.script_exploder );
    var_0 waittill( "trigger" );

    if ( isdefined( var_0.script_chance ) && randomfloat( 1 ) > var_0.script_chance )
    {
        if ( !var_0 maps\_utility::script_delay() )
            wait 4;

        level thread exploder_load( var_0 );
        return;
    }

    if ( !var_0 maps\_utility::script_delay() && isdefined( var_0.script_exploder_delay ) )
        wait(var_0.script_exploder_delay);

    common_scripts\_exploder::exploder( var_0.script_exploder );
    level notify( "killexplodertridgers" + var_0.script_exploder );
}

badplace_think( var_0 )
{
    if ( !isdefined( level.badplaces ) )
        level.badplaces = 0;

    level.badplaces++;
    badplace_cylinder( "badplace" + level.badplaces, -1, var_0.origin, var_0.radius, 1024 );
}

playerdamagerumble()
{
    for (;;)
    {
        self waittill( "damage", var_0 );

        if ( isdefined( self.specialdamage ) )
            continue;

        self playrumbleonentity( "damage_heavy" );
    }
}

map_is_early_in_the_game()
{
    if ( isdefined( level.early_level[level.script] ) )
        return level.early_level[level.script];
    else
        return 0;
}

traversethink()
{
    var_0 = getent( self.target, "targetname" );
    self.traverse_height = var_0.origin[2];
    self.traverse_height_delta = var_0.origin[2] - self.origin[2];
    var_0 delete();
}

pianodamagethink()
{
    var_0 = self getorigin();
    var_1[0] = "large";
    var_1[1] = "small";

    for (;;)
    {
        self waittill( "trigger" );
        thread common_scripts\utility::play_sound_in_space( "bullet_" + common_scripts\utility::random( var_1 ) + "_piano", var_0 );
    }
}

pianothink()
{
    var_0 = self getorigin();
    var_1 = "piano_" + self.script_noteworthy;
    self sethintstring( &"SCRIPT_PLATFORM_PIANO" );

    for (;;)
    {
        self waittill( "trigger" );
        thread common_scripts\utility::play_sound_in_space( var_1, var_0 );
    }
}

waterthink()
{
    var_0 = getent( self.target, "targetname" );
    var_1 = var_0.origin[2];
    var_0 = undefined;
    level.depth_allow_prone = 8;
    level.depth_allow_crouch = 33;
    level.depth_allow_stand = 50;
    var_2 = 0;

    for (;;)
    {
        wait 0.05;

        if ( !level.player.inwater && var_2 )
        {
            var_2 = 0;
            level.player allowprone( 1 );
            level.player allowcrouch( 1 );
            level.player allowstand( 1 );
            thread waterthink_rampspeed( level.default_run_speed );
        }

        self waittill( "trigger" );
        level.player.inwater = 1;
        var_2 = 1;

        while ( level.player istouching( self ) )
        {
            level.player.inwater = 1;
            var_3 = level.player getorigin();
            var_4 = var_3[2] - var_1;

            if ( var_4 > 0 )
                break;

            var_5 = int( level.default_run_speed - abs( var_4 * 5 ) );

            if ( var_5 < 50 )
                var_5 = 50;

            thread waterthink_rampspeed( var_5 );

            if ( abs( var_4 ) > level.depth_allow_crouch )
                level.player allowcrouch( 0 );
            else
                level.player allowcrouch( 1 );

            if ( abs( var_4 ) > level.depth_allow_prone )
                level.player allowprone( 0 );
            else
                level.player allowprone( 1 );

            wait 0.5;
        }

        level.player.inwater = 0;
        wait 0.05;
    }
}

waterthink_rampspeed( var_0 )
{
    level notify( "ramping_water_movement_speed" );
    level endon( "ramping_water_movement_speed" );
    var_1 = 0.5;
    var_2 = int( var_1 * 20 );
    var_3 = getdvarint( "g_speed" );
    var_4 = 0;

    if ( var_0 < var_3 )
        var_4 = 1;

    var_5 = int( abs( var_3 - var_0 ) );
    var_6 = int( var_5 / var_2 );

    for ( var_7 = 0; var_7 < var_2; var_7++ )
    {
        var_3 = getdvarint( "g_speed" );

        if ( var_4 )
            setsaveddvar( "g_speed", var_3 - var_6 );
        else
            setsaveddvar( "g_speed", var_3 + var_6 );

        wait 0.05;
    }

    setsaveddvar( "g_speed", var_0 );
}

massnodeinitfunctions()
{
    var_0 = getallnodes();
    thread maps\_mgturret::auto_mgturretlink( var_0 );
    thread maps\_mgturret::saw_mgturretlink( var_0 );
    thread maps\_colors::init_color_grouping( var_0 );
}

indicate_start( var_0 )
{
    var_1 = newhudelem();
    var_1.alignx = "left";
    var_1.aligny = "middle";
    var_1.x = 10;
    var_1.y = 400;
    var_1 settext( var_0 );
    var_1.alpha = 0;
    var_1.fontscale = 3;
    wait 1;
    var_1 fadeovertime( 1 );
    var_1.alpha = 1;
    wait 5;
    var_1 fadeovertime( 1 );
    var_1.alpha = 0;
    wait 1;
    var_1 destroy();
}

handle_starts()
{
    level.start_struct = spawnstruct();
    common_scripts\utility::create_dvar( "start", "" );

    if ( getdvar( "scr_generateClipModels" ) != "" && getdvar( "scr_generateClipModels" ) != "0" )
        return;

    if ( !isdefined( level.start_functions ) )
        level.start_functions = [];

    var_0 = tolower( getdvar( "start" ) );
    var_1 = get_start_dvars();

    if ( isdefined( level.start_point ) )
        var_0 = level.start_point;

    var_2 = 0;

    for ( var_3 = 0; var_3 < var_1.size; var_3++ )
    {
        if ( var_0 == var_1[var_3] )
        {
            var_2 = var_3;
            level.start_point = var_1[var_3];
            break;
        }
    }

    if ( isdefined( level.default_start_override ) && !isdefined( level.start_point ) )
    {
        foreach ( var_6, var_5 in var_1 )
        {
            if ( level.default_start_override == var_5 )
            {
                var_2 = var_6;
                level.start_point = var_5;
                break;
            }
        }
    }

    if ( !isdefined( level.start_point ) )
    {
        if ( isdefined( level.default_start ) )
            level.start_point = "default";
        else if ( maps\_utility::level_has_start_points() )
            level.start_point = level.start_functions[0]["name"];
        else
            level.start_point = "default";
    }

    var_7 = getdvarint( "sv_loadingsavegame", 0 );

    if ( var_7 != 0 )
    {
        var_8 = getdvar( "sv_savegametransients", "" );

        if ( var_8 == "" )
            loadstartpointtransient( "" );
        else
        {
            var_9 = strtok( var_8, "," );
            loadstartpointtransient( var_9 );
        }
    }
    else if ( level.start_point != "default" )
    {
        var_10 = level.start_arrays[level.start_point];

        if ( isdefined( var_10["transients_to_load"] ) )
        {
            var_11 = var_10["transients_to_load"];

            if ( var_11.size > 0 )
                loadstartpointtransient( var_11 );
            else
                loadstartpointtransient( "" );
        }
    }

    waittillframeend;
    common_scripts\utility::flag_set( "start_is_set" );
    thread start_menu();

    if ( level.start_point == "default" )
    {
        if ( isdefined( level.default_start ) )
            level thread [[ level.default_start ]]();
    }
    else
    {
        var_10 = level.start_arrays[level.start_point];
        thread [[ var_10["start_func"] ]]();
    }

    if ( maps\_utility::is_default_start() )
    {
        var_12 = get_string_for_starts( var_1 );
        setdvar( "start", var_12 );
    }

    waittillframeend;

    if ( var_7 != 0 )
        wait 0.1;

    var_13 = [];

    if ( !maps\_utility::is_default_start() && level.start_point != "no_game" )
    {
        var_14 = gettime();

        for ( var_3 = 0; var_3 < level.start_functions.size; var_3++ )
        {
            var_10 = level.start_functions[var_3];

            if ( var_10["name"] == level.start_point )
                break;

            if ( !isdefined( var_10["catchup_function"] ) )
                continue;

            [[ var_10["catchup_function"] ]]();
        }
    }

    for ( var_3 = var_2; var_3 < level.start_functions.size; var_3++ )
    {
        var_10 = level.start_functions[var_3];

        if ( !isdefined( var_10["logic_func"] ) )
            continue;

        if ( already_ran_function( var_10["logic_func"], var_13 ) )
            continue;

        level.start_struct [[ var_10["logic_func"] ]]();
        var_13[var_13.size] = var_10["logic_func"];
    }
}

already_ran_function( var_0, var_1 )
{
    foreach ( var_3 in var_1 )
    {
        if ( var_3 == var_0 )
            return 1;
    }

    return 0;
}

get_string_for_starts( var_0 )
{
    var_1 = " ** No starts have been set up for this map with maps_utility::add_start().";

    if ( var_0.size )
    {
        var_1 = " ** ";

        for ( var_2 = var_0.size - 1; var_2 >= 0; var_2-- )
            var_1 = var_1 + var_0[var_2] + " ";
    }

    setdvar( "start", var_1 );
    return var_1;
}

create_start( var_0, var_1 )
{
    var_2 = 1;
    var_3 = ( 0.9, 0.9, 0.9 );

    if ( var_1 != -1 )
    {
        var_4 = 5;

        if ( var_1 != var_4 )
            var_2 = 1 - abs( var_4 - var_1 ) / var_4;
        else
            var_3 = ( 1, 1, 0 );
    }

    if ( var_2 == 0 )
        var_2 = 0.05;

    var_5 = newhudelem();
    var_5.alignx = "left";
    var_5.aligny = "middle";
    var_5.x = 80;
    var_5.y = 80 + var_1 * 18;
    var_5 settext( var_0 );
    var_5.alpha = 0;
    var_5.foreground = 1;
    var_5.color = var_3;
    var_5.fontscale = 1.75;
    var_5 fadeovertime( 0.5 );
    var_5.alpha = var_2;
    return var_5;
}

start_menu()
{

}

start_nogame()
{
    common_scripts\utility::array_call( getaiarray(), ::delete );
    common_scripts\utility::array_call( getspawnerarray(), ::delete );
}

get_start_dvars()
{
    var_0 = [];

    for ( var_1 = 0; var_1 < level.start_functions.size; var_1++ )
        var_0[var_0.size] = level.start_functions[var_1]["name"];

    return var_0;
}

display_starts()
{
    level.display_starts_pressed = 1;

    if ( level.start_functions.size <= 0 )
        return;

    var_0 = get_start_dvars();
    var_0[var_0.size] = "default";
    var_0[var_0.size] = "cancel";
    var_1 = start_list_menu();
    var_2 = create_start( "Selected Start:", -1 );
    var_2.color = ( 1, 1, 1 );
    var_3 = [];

    for ( var_4 = 0; var_4 < var_0.size; var_4++ )
    {
        var_5 = var_0[var_4];
        var_6 = "[" + var_0[var_4] + "]";

        if ( var_5 != "cancel" && var_5 != "default" )
        {
            if ( isdefined( level.start_arrays[var_5]["start_loc_string"] ) )
            {
                var_6 += " -> ";
                var_6 += level.start_arrays[var_5]["start_loc_string"];
            }
        }

        var_3[var_3.size] = var_6;
    }

    var_7 = var_0.size - 1;
    var_8 = 0;
    var_9 = 0;

    for ( var_10 = 0; var_7 > 0; var_7-- )
    {
        if ( var_0[var_7] == level.start_point )
        {
            var_10 = 1;
            break;
        }
    }

    if ( !var_10 )
        var_7 = var_0.size - 1;

    start_list_settext( var_1, var_3, var_7 );
    var_11 = var_7;

    for (;;)
    {
        if ( !level.player buttonpressed( "F10" ) )
            level.display_starts_pressed = 0;

        if ( var_11 != var_7 )
        {
            start_list_settext( var_1, var_3, var_7 );
            var_11 = var_7;
        }

        if ( !var_8 )
        {
            if ( level.player buttonpressed( "UPARROW" ) || level.player buttonpressed( "DPAD_UP" ) || level.player buttonpressed( "APAD_UP" ) )
            {
                var_8 = 1;
                var_7--;
            }
        }
        else if ( !level.player buttonpressed( "UPARROW" ) && !level.player buttonpressed( "DPAD_UP" ) && !level.player buttonpressed( "APAD_UP" ) )
            var_8 = 0;

        if ( !var_9 )
        {
            if ( level.player buttonpressed( "DOWNARROW" ) || level.player buttonpressed( "DPAD_DOWN" ) || level.player buttonpressed( "APAD_DOWN" ) )
            {
                var_9 = 1;
                var_7++;
            }
        }
        else if ( !level.player buttonpressed( "DOWNARROW" ) && !level.player buttonpressed( "DPAD_DOWN" ) && !level.player buttonpressed( "APAD_DOWN" ) )
            var_9 = 0;

        if ( var_7 < 0 )
            var_7 = var_0.size - 1;

        if ( var_7 >= var_0.size )
            var_7 = 0;

        if ( level.player buttonpressed( "BUTTON_B" ) )
        {
            start_display_cleanup( var_1, var_2 );
            break;
        }

        if ( level.player buttonpressed( "kp_enter" ) || level.player buttonpressed( "BUTTON_A" ) || level.player buttonpressed( "enter" ) )
        {
            if ( var_0[var_7] == "cancel" )
            {
                start_display_cleanup( var_1, var_2 );
                break;
            }

            setdvar( "start", var_0[var_7] );
        }

        wait 0.05;
    }
}

start_list_menu()
{
    var_0 = [];

    for ( var_1 = 0; var_1 < 11; var_1++ )
    {
        var_2 = create_start( "", var_1 );
        var_0[var_0.size] = var_2;
    }

    return var_0;
}

start_list_settext( var_0, var_1, var_2 )
{
    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
    {
        var_4 = var_3 + var_2 - 5;

        if ( isdefined( var_1[var_4] ) )
            var_5 = var_1[var_4];
        else
            var_5 = "";

        var_0[var_3] settext( var_5 );
    }
}

start_display_cleanup( var_0, var_1 )
{
    var_1 destroy();

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
        var_0[var_2] destroy();
}

background_block()
{
    self.origin -= self.script_bg_offset;
}

set_player_viewhand_model( var_0 )
{
    level.player_viewhand_model = var_0;
    precachemodel( level.player_viewhand_model );
}

setobjectivetextcolors()
{
    var_0 = "1.0 1.0 1.0";
    var_1 = "0.9 0.9 0.9";
    var_2 = "0.85 0.85 0.85";
    setsaveddvar( "con_typewriterColorBase", var_0 );
}

ammo_pickup( var_0 )
{
    var_1 = [];

    if ( var_0 == "grenade_launcher" )
    {
        var_1[var_1.size] = "alt_m4_grenadier";
        var_1[var_1.size] = "alt_m4m203_acog";
        var_1[var_1.size] = "alt_m4m203_acog_payback";
        var_1[var_1.size] = "alt_m4m203_eotech";
        var_1[var_1.size] = "alt_m4m203_motion_tracker";
        var_1[var_1.size] = "alt_m4m203_reflex";
        var_1[var_1.size] = "alt_m4m203_reflex_arctic";
        var_1[var_1.size] = "alt_m4m203_silencer";
        var_1[var_1.size] = "alt_m4m203_silencer_reflex";
        var_1[var_1.size] = "alt_m16_grenadier";
        var_1[var_1.size] = "alt_ak47_grenadier";
        var_1[var_1.size] = "alt_ak47_desert_grenadier";
        var_1[var_1.size] = "alt_ak47_digital_grenadier";
        var_1[var_1.size] = "alt_ak47_fall_grenadier";
        var_1[var_1.size] = "alt_ak47_woodland_grenadier";
    }
    else if ( var_0 == "rpg" )
    {
        var_1[var_1.size] = "rpg";
        var_1[var_1.size] = "rpg_player";
        var_1[var_1.size] = "rpg_straight";
    }
    else if ( var_0 == "c4" )
        var_1[var_1.size] = "c4";
    else if ( var_0 == "claymore" )
        var_1[var_1.size] = "claymore";
    else if ( var_0 == "556" )
    {
        var_1[var_1.size] = "m4_grenadier";
        var_1[var_1.size] = "m4_grunt";
        var_1[var_1.size] = "m4_sd_cloth";
        var_1[var_1.size] = "m4_shotgun";
        var_1[var_1.size] = "m4_silencer";
        var_1[var_1.size] = "m4_silencer_acog";
        var_1[var_1.size] = "m4m203_acog";
        var_1[var_1.size] = "m4m203_acog_payback";
        var_1[var_1.size] = "m4m203_eotech";
        var_1[var_1.size] = "m4m203_motion_tracker";
        var_1[var_1.size] = "m4m203_reflex";
        var_1[var_1.size] = "m4m203_reflex_arctic";
        var_1[var_1.size] = "m4m203_silencer";
        var_1[var_1.size] = "m4m203_silencer_reflex";
        var_1[var_1.size] = "m4m203_silencer";
    }
    else if ( var_0 == "762" )
    {
        var_1[var_1.size] = "ak47";
        var_1[var_1.size] = "ak47_acog";
        var_1[var_1.size] = "ak47_eotech";
        var_1[var_1.size] = "ak47_grenadier";
        var_1[var_1.size] = "ak47_reflex";
        var_1[var_1.size] = "ak47_shotgun";
        var_1[var_1.size] = "ak47_silencer";
        var_1[var_1.size] = "ak47_thermal";
        var_1[var_1.size] = "ak47_desert";
        var_1[var_1.size] = "ak47_desert_acog";
        var_1[var_1.size] = "ak47_desert_eotech";
        var_1[var_1.size] = "ak47_desert_grenadier";
        var_1[var_1.size] = "ak47_desert_reflex";
        var_1[var_1.size] = "ak47_digital";
        var_1[var_1.size] = "ak47_digital_acog";
        var_1[var_1.size] = "ak47_digital_eotech";
        var_1[var_1.size] = "ak47_digital_grenadier";
        var_1[var_1.size] = "ak47_digital_reflex";
        var_1[var_1.size] = "ak47_fall";
        var_1[var_1.size] = "ak47_fall_acog";
        var_1[var_1.size] = "ak47_fall_eotech";
        var_1[var_1.size] = "ak47_fall_grenadier";
        var_1[var_1.size] = "ak47_fall_reflex";
        var_1[var_1.size] = "ak47_woodland";
        var_1[var_1.size] = "ak47_woodland_acog";
        var_1[var_1.size] = "ak47_woodland_eotech";
        var_1[var_1.size] = "ak47_woodland_grenadier";
        var_1[var_1.size] = "ak47_woodland_reflex";
    }
    else if ( var_0 == "45" )
    {
        var_1[var_1.size] = "ump45";
        var_1[var_1.size] = "ump45_acog";
        var_1[var_1.size] = "ump45_eotech";
        var_1[var_1.size] = "ump45_reflex";
        var_1[var_1.size] = "ump45_silencer";
        var_1[var_1.size] = "ump45_arctic";
        var_1[var_1.size] = "ump45_arctic_acog";
        var_1[var_1.size] = "ump45_arctic_eotech";
        var_1[var_1.size] = "ump45_arctic_reflex";
        var_1[var_1.size] = "ump45_digital";
        var_1[var_1.size] = "ump45_digital_acog";
        var_1[var_1.size] = "ump45_digital_eotech";
        var_1[var_1.size] = "ump45_digital_reflex";
    }
    else if ( var_0 == "pistol" )
    {
        var_1[var_1.size] = "beretta";
        var_1[var_1.size] = "beretta393";
        var_1[var_1.size] = "usp";
        var_1[var_1.size] = "usp_scripted";
        var_1[var_1.size] = "usp_silencer";
        var_1[var_1.size] = "glock";
    }

    var_2 = spawn( "trigger_radius", self.origin, 0, 25, 32 );

    for (;;)
    {
        common_scripts\utility::flag_wait( "allow_ammo_pickups" );
        var_2 waittill( "trigger", var_3 );

        if ( !common_scripts\utility::flag( "allow_ammo_pickups" ) )
            continue;

        if ( !isdefined( var_3 ) )
            continue;

        if ( !isplayer( var_3 ) )
            continue;

        var_4 = undefined;
        var_5 = undefined;
        var_6 = var_3 getweaponslistall();

        for ( var_7 = 0; var_7 < var_6.size; var_7++ )
        {
            for ( var_8 = 0; var_8 < var_1.size; var_8++ )
            {
                if ( var_6[var_7] == var_1[var_8] )
                    var_4 = var_6[var_7];
            }
        }

        if ( !isdefined( var_4 ) && var_0 == "claymore" )
        {
            var_5 = 1;
            var_4 = "claymore";
            break;
        }

        if ( !isdefined( var_4 ) && var_0 == "c4" )
        {
            var_5 = 1;
            var_4 = "c4";
            break;
        }

        if ( !isdefined( var_4 ) )
            continue;

        if ( var_3 getfractionmaxammo( var_4 ) >= 1 )
            continue;

        break;
    }

    if ( isdefined( var_5 ) )
        var_3 giveweapon( var_4 );
    else
    {
        var_9 = 1;

        if ( var_0 == "556" || var_0 == "762" )
            var_9 = 30;
        else if ( var_0 == "45" )
            var_9 = 25;
        else if ( var_0 == "pistol" )
            var_9 = 15;

        var_3 setweaponammostock( var_4, var_3 setweaponammostock( var_4 ) + var_9 );
    }

    var_3 playlocalsound( "grenade_pickup" );
    var_2 delete();

    if ( isdefined( self ) )
        self delete();
}

remove_level_first_frame()
{
    wait 0.05;
    level.first_frame = -1;
}

load_friendlies()
{
    if ( isdefined( game["total characters"] ) )
        var_0 = game["total characters"];
    else
        return;

    var_1 = getaiarray( "allies" );
    var_2 = var_1.size;
    var_3 = 0;
    var_4 = getspawnerteamarray( "allies" );
    var_5 = var_4.size;
    var_6 = 0;

    for (;;)
    {
        if ( var_2 <= 0 && var_5 <= 0 || var_0 <= 0 )
            return;

        if ( var_2 > 0 )
        {
            if ( isdefined( var_1[var_3].script_friendname ) )
            {
                var_2--;
                var_3++;
                continue;
            }

            var_1[var_3] codescripts\character::new();
            var_1[var_3] thread codescripts\character::load( game["character" + var_0 - 1] );
            var_2--;
            var_3++;
            var_0--;
            continue;
        }

        if ( var_5 > 0 )
        {
            if ( isdefined( var_4[var_6].script_friendname ) )
            {
                var_5--;
                var_6++;
                continue;
            }

            var_7 = game["character" + var_0 - 1];
            maps\_utility::precache( var_7["model"] );
            maps\_utility::precache( var_7["model"] );
            var_4[var_6] thread maps\_utility::spawn_setcharacter( game["character" + var_0 - 1] );
            var_5--;
            var_6++;
            var_0--;
            continue;
        }
    }
}

check_flag_for_stat_tracking( var_0 )
{
    if ( !common_scripts\utility::issuffix( var_0, "aa_" ) )
        return;

    [[ level.sp_stat_tracking_func ]]( var_0 );
}

precache_script_models()
{
    waittillframeend;

    if ( !isdefined( level.scr_model ) )
        return;

    var_0 = getarraykeys( level.scr_model );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        if ( isarray( level.scr_model[var_0[var_1]] ) )
        {
            for ( var_2 = 0; var_2 < level.scr_model[var_0[var_1]].size; var_2++ )
                precachemodel( level.scr_model[var_0[var_1]][var_2] );

            continue;
        }

        precachemodel( level.scr_model[var_0[var_1]] );
    }
}

player_death_detection()
{
    setdvar( "player_died_recently", "0" );
    thread player_died_recently_degrades();
    level maps\_utility::add_wait( common_scripts\utility::flag_wait, "missionfailed" );
    level.player maps\_utility::add_wait( maps\_utility::waittill_msg, "death" );
    maps\_utility::do_wait_any();
    var_0 = [];
    var_0[0] = 70;
    var_0[1] = 30;
    var_0[2] = 0;
    var_0[3] = 0;
    setdvar( "player_died_recently", var_0[level.gameskill] );
}

player_died_recently_degrades()
{
    for (;;)
    {
        var_0 = getdvarint( "player_died_recently", 0 );

        if ( var_0 > 0 )
        {
            var_0 -= 5;
            setdvar( "player_died_recently", var_0 );
        }

        wait 5;
    }
}

recon_player()
{
    self notify( "new_recon_player" );
    self endon( "new_recon_player" );
    self waittill( "death", var_0, var_1, var_2 );

    if ( !isdefined( var_2 ) )
        var_2 = "script_kill";

    var_3 = 0;
    var_4 = "none";
    var_5 = ( 0, 0, 0 );

    if ( isdefined( var_0 ) )
    {
        var_4 = var_0.classname;
        var_5 = var_0.origin;
        var_6 = vectornormalize( var_5 - self.origin );
        var_7 = anglestoforward( self getangles() );
        var_3 = vectordot( var_6, var_7 );
    }

    reconspatialevent( self.origin, "script_player_death: playerid %s, enemy %s, enemyposition %v, enemydotproduct %f, cause %s, weapon %s", self.unique_id, var_4, var_5, var_3, var_1, var_2 );

    if ( isdefined( var_0 ) )
        reconspatialevent( var_0.origin, "script_player_killer: playerid %s, enemy %s, playerposition %v, enemydotproduct %f, cause %s, weapon %s", self.unique_id, var_4, self.origin, var_3, var_1, var_2 );
}

recon_player_downed()
{
    self notify( "new_player_downed_recon" );
    self endon( "new_player_downed_recon" );
    self endon( "death" );

    for (;;)
    {
        self waittill( "player_downed" );
        var_0 = getlevelticks() * 0.05;
        var_1 = var_0;

        if ( isdefined( self.last_downed_time ) )
            var_0 = var_1 - self.last_downed_time;

        self.last_downed_time = var_1;
        reconspatialevent( self.origin, "script_player_downed: playerid %s, leveltime %d, deltatime %d", self.unique_id, var_1, var_0 );
    }
}

init_level_players()
{
    level.players = getentarray( "player", "classname" );

    for ( var_0 = 0; var_0 < level.players.size; var_0++ )
        level.players[var_0].unique_id = "player" + var_0;

    level.player = level.players[0];

    if ( level.players.size > 1 )
        level.player2 = level.players[1];

    level notify( "level.players initialized" );

    foreach ( var_2 in level.players )
    {
        var_2 thread recon_player();

        if ( maps\_utility::is_specialop() )
            var_2 thread recon_player_downed();
    }
}

kill_all_players_trigger()
{
    self waittill( "trigger", var_0 );
    var_0 maps\_utility::kill_wrapper();
}

watchweaponchange()
{
    if ( !isdefined( level.friendly_thermal_reflector_effect ) )
        level.friendly_thermal_reflector_effect = loadfx( "vfx/unique/thermal_beacon_inverted" );

    self endon( "death" );
    var_0 = self getcurrentweapon();

    if ( weap_has_thermal( var_0 ) )
        thread thermal_tracker();
    else if ( weap_is_em1( var_0 ) )
        thread em1_heat_meter();
    else if ( weap_is_hbra3( var_0 ) )
        thread hbra3_signature();
    else if ( player_has_printing_himar() )
        thread himar_print_ammo();

    for (;;)
    {
        self waittill( "weapon_change", var_1 );

        if ( weap_has_thermal( var_1 ) )
            thread thermal_tracker();
        else
            self notify( "acogThermalTracker" );

        if ( weap_is_em1( var_1 ) )
            thread em1_heat_meter();

        if ( weap_is_hbra3( var_1 ) )
            thread hbra3_signature();

        if ( player_has_printing_himar() )
            thread himar_print_ammo();
    }
}

em1_heat_meter_off()
{
    common_scripts\utility::waittill_any( "death", "weapon_change", "em1_heat_meter" );
    setomnvar( "ui_em1", 0 );
    setomnvar( "ui_em1_heat", 0 );
}

em1_heat_meter()
{
    self endon( "death" );
    self endon( "weapon_change" );
    self notify( "em1_heat_meter" );
    self endon( "em1_heat_meter" );
    thread em1_heat_meter_off();
    setomnvar( "ui_em1", 1 );
    setomnvar( "ui_em1_heat", 0 );

    for (;;)
    {
        var_0 = self getcurrentweapon();
        var_1 = self getweaponheatlevel( var_0 );
        setomnvar( "ui_em1_heat", var_1 );
        wait 0.05;
    }
}

weap_is_em1( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( weaponclass( var_0 ) == "beam" && issubstr( var_0, "_em1" ) )
        return 1;

    return 0;
}

hbra3_signature_off()
{
    common_scripts\utility::waittill_any( "death", "weapon_change", "hbra3_signature" );
    setomnvar( "ui_hbra3", 0 );
}

hbra3_signature()
{
    self endon( "death" );
    self endon( "weapon_change" );
    self notify( "hbra3_signature" );
    self endon( "hbra3_signature" );
    thread hbra3_signature_off();
    setomnvar( "ui_hbra3", 1 );
}

weap_is_hbra3( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( weaponclass( var_0 ) == "rifle" && issubstr( var_0, "_hbra3" ) )
        return 1;

    return 0;
}

himar_print_ammo()
{
    self endon( "death" );
    self endon( "himar_print_ammo_stop" );

    if ( isdefined( self.himar_printer_equipped ) && self.himar_printer_equipped )
        return;

    self.himar_printer_equipped = 1;
    self notify( "himar_print_ammo" );
    self endon( "himar_print_ammo" );
    setomnvar( "ui_himar", 1 );
    setomnvar( "ui_himar_printing", 0 );
    var_0 = undefined;

    foreach ( var_2 in self getweaponslistprimaries() )
    {
        if ( issubstr( var_2, "himar" ) )
        {
            var_0 = var_2;
            break;
        }
    }

    if ( !isdefined( var_0 ) )
        return;

    for (;;)
    {
        var_4 = self getfractionmaxammo( var_0 );
        setomnvar( "ui_himar_printing", var_4 );

        if ( var_4 < 1.0 )
        {
            thread himar_printing_ammo_full_check( var_0 );
            common_scripts\utility::waittill_notify_or_timeout( "himar_ammo_full", 30 );
            self notify( "stop_himar_printing_ammo_full_check" );
            var_5 = self setweaponammostock( var_0 );
            var_6 = weaponmaxammo( var_0 );
            var_7 = var_5 + weaponclipsize( var_0 );

            if ( var_7 > var_6 )
                var_7 = var_6;

            self setweaponammostock( var_0, var_7 );
            continue;
        }

        wait 1;
    }
}

himar_printing_ammo_full_check( var_0 )
{
    self endon( "stop_himar_printing_ammo_full_check" );

    while ( self getfractionmaxammo( var_0 ) != 1 )
        wait 0.5;

    self notify( "himar_ammo_full" );
}

weap_is_himar( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( weaponclass( var_0 ) == "rifle" && issubstr( var_0, "_himar" ) )
        return 1;

    return 0;
}

player_has_printing_himar()
{
    foreach ( var_1 in self getweaponslistprimaries() )
    {
        if ( issubstr( var_1, "iw5_himar_sp" ) && issubstr( var_1, "himarscope" ) )
            return 1;
    }

    self.himar_printer_equipped = undefined;
    self notify( "himar_print_ammo_stop" );
    setomnvar( "ui_himar", 0 );
    setomnvar( "ui_himar_printing", 0 );
    return 0;
}

weap_has_thermal( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( var_0 == "none" )
        return 0;

    if ( weaponhasthermalscope( var_0 ) )
        return 1;

    return 0;
}

thermal_tracker()
{
    self endon( "death" );
    self notify( "acogThermalTracker" );
    self endon( "acogThermalTracker" );
    var_0 = 0;

    for (;;)
    {
        var_1 = var_0;
        var_0 = self playerads();

        if ( turn_thermal_on( var_0, var_1 ) )
            thermal_effectson();
        else if ( turn_thermal_off( var_0, var_1 ) )
            thermal_effectsoff();

        wait 0.05;
    }
}

turn_thermal_on( var_0, var_1 )
{
    if ( var_0 <= var_1 )
        return 0;

    if ( var_0 <= 0.65 )
        return 0;

    return !isdefined( self.is_in_thermal_vision );
}

turn_thermal_off( var_0, var_1 )
{
    if ( var_0 >= var_1 )
        return 0;

    if ( var_0 >= 0.8 )
        return 0;

    return isdefined( self.is_in_thermal_vision );
}

thermal_effectson()
{
    self.is_in_thermal_vision = 1;
    var_0 = getaiarray( "allies" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2.has_thermal_fx ) )
            continue;

        var_2.has_thermal_fx = 1;
        var_2 thread loop_friendly_thermal_reflector_effect( self.unique_id );
    }

    if ( maps\_utility::is_coop() )
    {
        var_4 = maps\_utility::get_other_player( self );

        if ( !isdefined( var_4.has_thermal_fx ) )
        {
            var_4.has_thermal_fx = 1;
            var_4 thread loop_friendly_thermal_reflector_effect( self.unique_id, self );
        }
    }
}

thermal_effectsoff()
{
    self.is_in_thermal_vision = undefined;
    level notify( "thermal_fx_off" + self.unique_id );
    var_0 = getaiarray( "allies" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        var_0[var_1].has_thermal_fx = undefined;

    if ( maps\_utility::is_coop() )
    {
        var_2 = maps\_utility::get_other_player( self );
        var_2.has_thermal_fx = undefined;
    }
}

loop_friendly_thermal_reflector_effect( var_0, var_1 )
{
    if ( isdefined( self.has_no_ir ) )
        return;

    level endon( "thermal_fx_off" + var_0 );
    self endon( "death" );

    for (;;)
    {
        if ( isdefined( var_1 ) )
            playfxontagforclients( level.friendly_thermal_reflector_effect, self, "J_Spine4", var_1 );
        else
            playfxontag( level.friendly_thermal_reflector_effect, self, "J_Spine4" );

        wait 0.2;
    }
}

claymore_pickup_think_global()
{
    precacheshellshock( "claymore" );
    self endon( "deleted" );
    self setcursorhint( "HINT_NOICON" );
    self sethintstring( &"WEAPON_CLAYMORE_PICKUP" );
    self makeusable();
    var_0 = weaponmaxammo( "claymore" ) + weaponclipsize( "claymore" );

    if ( isdefined( self.script_ammo_clip ) )
        var_0 = self.script_ammo_clip;

    while ( var_0 > 0 )
    {
        self waittill( "trigger", var_1 );
        var_1 playsound( "null" );
        var_2 = 0;

        if ( !var_1 hasweapon( "claymore" ) )
            var_1 giveweapon( "claymore" );
        else
            var_2 = var_1 getammocount( "claymore" );

        if ( isdefined( var_0 ) && var_0 > 0 )
        {
            var_0 = var_2 + var_0;
            var_3 = weaponmaxammo( "claymore" );
            var_4 = weaponclipsize( "claymore" );

            if ( var_0 >= var_4 )
            {
                var_0 -= var_4;
                var_1 setweaponammoclip( "claymore", var_4 );
            }

            if ( var_0 >= var_3 )
            {
                var_0 -= var_3;
                var_1 setweaponammostock( "claymore", var_3 );
            }
            else if ( var_0 > 0 )
            {
                var_1 setweaponammostock( "claymore", var_0 );
                var_0 = 0;
            }
        }
        else
            var_1 givemaxammo( "claymore" );

        var_5 = 4;

        if ( isdefined( var_1.remotemissile_actionslot ) && var_1.remotemissile_actionslot == 4 )
            var_5 = 2;

        var_1 setactionslot( var_5, "weapon", "claymore" );
        var_1 switchtoweapon( "claymore" );
    }

    if ( isdefined( self.target ) )
    {
        var_6 = getentarray( self.target, "targetname" );

        foreach ( var_8 in var_6 )
            var_8 delete();
    }

    self makeunusable();
    self delete();
}

ammo_cache_think_global( var_0 )
{
    self endon( "remove_ammo_cache" );
    self.use_trigger = spawn( "script_model", self.origin + ( 0, 0, 28 ) );
    self.use_trigger setmodel( "tag_origin" );
    self.use_trigger makeusable();
    self.use_trigger setcursorhint( "HINT_NOICON" );
    var_1 = &"WEAPON_CACHE_USE_HINT";

    if ( getdvar( "consoleGame" ) == "true" )
        var_1 = &"WEAPON_CACHE_USE_CONTROLLER_HINT";

    self.use_trigger sethintstring( var_1 );

    if ( !isdefined( var_0 ) || isdefined( var_0 ) && var_0 )
        thread ammo_icon_think();

    for (;;)
    {
        self.use_trigger waittill( "trigger", var_2 );

        if ( isdefined( var_2.dont_allow_ammo_cache ) )
            continue;

        var_2.using_ammo_cache = 1;
        self notify( "used_ammo_cache" );
        self.use_trigger makeunusable();
        var_2 playsound( "player_refill_all_ammo" );
        var_2 disableweapons();
        wait 0.1;
        var_3 = var_2 getweaponslistall();

        foreach ( var_5 in var_3 )
        {
            if ( var_5 == "claymore" )
                continue;

            if ( var_5 == "c4" )
                continue;

            var_2 givemaxammo( var_5 );
            var_6 = weaponclipsize( var_5 );

            if ( isdefined( var_6 ) )
            {
                if ( var_2 getweaponammoclip( var_5 ) < var_6 )
                    var_2 setweaponammoclip( var_5, var_6 );
            }
        }

        wait 1.4;
        var_2 enableweapons();
        self.use_trigger makeusable();
        var_2.using_ammo_cache = undefined;
    }
}

ammo_icon_think()
{
    self endon( "remove_ammo_cache" );
    var_0 = spawn( "trigger_radius", self.origin, 0, 320, 72 );
    var_1 = newhudelem();
    var_1 setshader( "waypoint_ammo", 1, 1 );
    var_1.alpha = 0;
    var_1.color = ( 1, 1, 1 );
    var_1.x = self.origin[0];
    var_1.y = self.origin[1];
    var_1.z = self.origin[2] + 16;
    var_1 setwaypoint( 1, 1 );
    self.ammo_icon = var_1;
    self.ammo_icon_trig = var_0;

    if ( isdefined( self.icon_always_show ) && self.icon_always_show )
    {
        ammo_icon_fade_in( var_1 );
        return;
    }

    wait 0.05;

    for (;;)
    {
        var_0 waittill( "trigger", var_2 );

        if ( !isplayer( var_2 ) )
            continue;

        while ( var_2 istouching( var_0 ) )
        {
            var_3 = 1;
            var_4 = var_2 getcurrentweapon();

            if ( var_4 == "none" )
                var_3 = 0;
            else if ( var_2 getfractionmaxammo( var_4 ) > 0.9 )
                var_3 = 0;

            if ( maps\_utility::player_looking_at( self.origin, 0.8, 1 ) && var_3 )
                ammo_icon_fade_in( var_1 );
            else
                ammo_icon_fade_out( var_1 );

            wait 0.25;
        }

        ammo_icon_fade_out( var_1 );
    }
}

ammo_icon_fade_in( var_0 )
{
    if ( var_0.alpha != 0 )
        return;

    var_0 fadeovertime( 0.2 );
    var_0.alpha = 0.3;
    wait 0.2;
}

ammo_icon_fade_out( var_0 )
{
    if ( var_0.alpha == 0 )
        return;

    var_0 fadeovertime( 0.2 );
    var_0.alpha = 0;
    wait 0.2;
}

window_destroy()
{
    var_0 = getglass( self.target );

    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( self.script_noteworthy ) )
    {
        if ( self.script_noteworthy == "ondamage" || self.script_noteworthy == "ondamage_appear" )
        {
            if ( self.script_noteworthy == "ondamage_appear" )
                self hide();

            level waittillmatch( "glass_damaged", var_0 );

            if ( self.script_noteworthy == "ondamage_appear" )
            {
                self show();
                level waittillmatch( "glass_destroyed", var_0 );
            }

            self delete();
        }
        else
        {
            level waittillmatch( "glass_destroyed", var_0 );
            self delete();
        }
    }
    else
    {
        level waittillmatch( "glass_destroyed", var_0 );
        self delete();
    }
}

global_empty_callback( var_0, var_1, var_2, var_3, var_4 )
{

}

weapon_list_debug()
{
    common_scripts\utility::create_dvar( "weaponlist", "0" );

    if ( !getdvarint( "weaponlist" ) )
        return;

    var_0 = getentarray();
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3.code_classname ) )
            continue;

        if ( issubstr( var_3.code_classname, "weapon" ) )
            var_1[var_3.classname] = 1;
    }

    foreach ( var_7, var_6 in var_1 )
    {

    }

    var_8 = getspawnerarray();
    var_9 = [];

    foreach ( var_11 in var_8 )
        var_9[var_11.code_classname] = 1;

    foreach ( var_14, var_6 in var_9 )
    {

    }
}

slowmo_system_init()
{
    level.slowmo = spawnstruct();
    slowmo_system_defaults();
    notifyoncommand( "_cheat_player_press_slowmo", "+melee" );
    notifyoncommand( "_cheat_player_press_slowmo", "+melee_breath" );
    notifyoncommand( "_cheat_player_press_slowmo", "+melee_zoom" );
}

slowmo_system_defaults()
{
    level.slowmo.lerp_time_in = 0.0;
    level.slowmo.lerp_time_out = 0.25;
    level.slowmo.speed_slow = 0.4;
    level.slowmo.speed_norm = 1.0;
}

add_no_game_starts()
{
    var_0 = getentarray( "script_origin_start_nogame", "classname" );

    if ( !var_0.size )
        return;

    foreach ( var_2 in var_0 )
    {
        if ( !isdefined( var_2.script_startname ) )
            continue;

        maps\_utility::add_start( "no_game_" + var_2.script_startname, ::start_nogame );
    }
}

do_no_game_start()
{
    if ( !maps\_utility::is_no_game_start() )
        return;

    setsaveddvar( "ufoHitsTriggers", "1" );
    level.stop_load = 1;

    if ( isdefined( level.custom_no_game_setupfunc ) )
        level [[ level.custom_no_game_setupfunc ]]();

    maps\_loadout::init_loadout();
    soundscripts\_audio::aud_init();
    soundscripts\_snd::snd_init();
    maps\_global_fx::main();
    do_no_game_start_teleport();
    common_scripts\utility::array_call( getentarray( "truckjunk", "targetname" ), ::delete );
    common_scripts\utility::array_call( getentarray( "truckjunk", "script_noteworthy" ), ::delete );
    level waittill( "eternity" );
}

do_no_game_start_teleport()
{
    var_0 = getentarray( "script_origin_start_nogame", "classname" );

    if ( !var_0.size )
        return;

    var_0 = sortbydistance( var_0, level.player.origin );

    if ( level.start_point == "no_game" )
    {
        level.player maps\_utility::teleport_player( var_0[0] );
        return;
    }

    var_1 = getsubstr( level.start_point, 8 );
    var_2 = 0;

    foreach ( var_4 in var_0 )
    {
        if ( !isdefined( var_4.script_startname ) )
            continue;

        if ( var_1 != var_4.script_startname )
            continue;

        if ( isdefined( var_4.script_visionset ) )
            maps\_utility::vision_set_fog_changes( var_4.script_visionset, 0 );

        level.player maps\_utility::teleport_player( var_4 );
        var_2 = 1;
        break;
    }

    if ( !var_2 )
        level.player maps\_utility::teleport_player( var_0[0] );
}

init_animsounds()
{
    level.animsounds = [];
    level.animsound_aliases = [];
    waittillframeend;
    waittillframeend;
    var_0 = getarraykeys( level.scr_notetrack );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        init_notetracks_for_animname( var_0[var_1] );

    var_0 = getarraykeys( level.scr_animsound );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        init_animsounds_for_animname( var_0[var_1] );
}

init_animsounds_for_animname( var_0 )
{
    var_1 = getarraykeys( level.scr_animsound[var_0] );

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        var_3 = var_1[var_2];
        var_4 = level.scr_animsound[var_0][var_3];
        level.animsound_aliases[var_0][var_3]["#" + var_3]["soundalias"] = var_4;
        level.animsound_aliases[var_0][var_3]["#" + var_3]["created_by_animSound"] = 1;
    }
}

init_notetracks_for_animname( var_0 )
{
    foreach ( var_10, var_2 in level.scr_notetrack[var_0] )
    {
        foreach ( var_9, var_4 in var_2 )
        {
            foreach ( var_6 in var_4 )
            {
                var_7 = var_6["sound"];

                if ( !isdefined( var_7 ) )
                    continue;

                level.animsound_aliases[var_0][var_10][var_9]["soundalias"] = var_7;

                if ( isdefined( var_6["created_by_animSound"] ) )
                    level.animsound_aliases[var_0][var_10][var_9]["created_by_animSound"] = 1;
            }
        }
    }
}

default_footsteps()
{
    animscripts\utility::setfootstepeffect( "default", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffect( "asphalt", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffect( "brick", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffect( "carpet", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffect( "cloth", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffect( "concrete", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffect( "cushion", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffect( "dirt", loadfx( "vfx/treadfx/footstep_dust" ) );
    animscripts\utility::setfootstepeffect( "foliage", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffect( "grass", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffect( "gravel", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffect( "mud", loadfx( "vfx/treadfx/footstep_mud" ) );
    animscripts\utility::setfootstepeffect( "rock", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffect( "sand", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffect( "wood", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffect( "water_waist", loadfx( "vfx/treadfx/footstep_water" ) );
    animscripts\utility::setfootstepeffect( "water_ankle", loadfx( "vfx/treadfx/footstep_water" ) );
    animscripts\utility::setfootstepeffect( "water_knee", loadfx( "vfx/treadfx/footstep_water" ) );
    animscripts\utility::setfootstepeffect( "snow", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffect( "ice", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffectsmall( "default", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffectsmall( "asphalt", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffectsmall( "brick", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffectsmall( "carpet", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffectsmall( "cloth", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffectsmall( "concrete", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffectsmall( "cushion", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffectsmall( "dirt", loadfx( "vfx/treadfx/footstep_dust" ) );
    animscripts\utility::setfootstepeffectsmall( "foliage", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffectsmall( "grass", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffectsmall( "gravel", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffectsmall( "mud", loadfx( "vfx/treadfx/footstep_mud" ) );
    animscripts\utility::setfootstepeffectsmall( "rock", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffectsmall( "sand", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffectsmall( "wood", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffectsmall( "water_waist", loadfx( "vfx/treadfx/footstep_water" ) );
    animscripts\utility::setfootstepeffectsmall( "water_ankle", loadfx( "vfx/treadfx/footstep_water" ) );
    animscripts\utility::setfootstepeffectsmall( "water_knee", loadfx( "vfx/treadfx/footstep_water" ) );
    animscripts\utility::setfootstepeffectsmall( "snow", loadfx( "vfx/unique/no_fx" ) );
    animscripts\utility::setfootstepeffectsmall( "ice", loadfx( "vfx/unique/no_fx" ) );
    var_0 = "bodyfall small";
    var_1 = "J_SpineLower";
    var_2 = "bodyfall_";
    var_3 = "_small";
    animscripts\utility::setnotetrackeffect( var_0, var_1, "dirt", loadfx( "vfx/treadfx/bodyfall_default_runner" ), var_2, var_3 );
    animscripts\utility::setnotetrackeffect( var_0, var_1, "concrete", loadfx( "vfx/treadfx/bodyfall_default_runner" ), var_2, var_3 );
    animscripts\utility::setnotetrackeffect( var_0, var_1, "asphalt", loadfx( "vfx/treadfx/bodyfall_default_runner" ), var_2, var_3 );
    animscripts\utility::setnotetrackeffect( var_0, var_1, "rock", loadfx( "vfx/treadfx/bodyfall_default_runner" ), var_2, var_3 );
    var_4 = [ "brick", "carpet", "foliage", "grass", "gravel", "ice", "metal", "painted metal", "mud", "plaster", "sand", "snow", "slush", "water", "wood", "ceramic" ];

    foreach ( var_6 in var_4 )
        animscripts\utility::setnotetracksound( var_0, var_6, var_2, var_3 );

    var_0 = "bodyfall small";
    var_1 = "J_SpineLower";
    var_2 = "bodyfall_";
    var_3 = "_large";
    animscripts\utility::setnotetrackeffect( var_0, var_1, "dirt", loadfx( "vfx/treadfx/bodyfall_default_runner" ), var_2, var_3 );
    animscripts\utility::setnotetrackeffect( var_0, var_1, "concrete", loadfx( "vfx/treadfx/bodyfall_default_runner" ), var_2, var_3 );
    animscripts\utility::setnotetrackeffect( var_0, var_1, "asphalt", loadfx( "vfx/treadfx/bodyfall_default_runner" ), var_2, var_3 );
    animscripts\utility::setnotetrackeffect( var_0, var_1, "rock", loadfx( "vfx/treadfx/bodyfall_default_runner" ), var_2, var_3 );

    foreach ( var_6 in var_4 )
        animscripts\utility::setnotetracksound( var_0, var_6, var_2, var_3 );
}

functional_tester_load_next_start()
{
    wait 3;

    if ( level.start_functions.size <= 0 )
        return;

    var_0 = get_start_dvars();

    if ( !isdefined( var_0 ) || !isdefined( level.start_point ) )
        return;

    var_1 = 0;

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        if ( var_0[var_1] == level.start_point )
        {
            var_1++;
            break;
        }
    }

    if ( var_1 >= var_0.size )
        return;

    setdvar( "start", var_0[var_1] );
}
