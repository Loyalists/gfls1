// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

df_baghdad_snipers_pre_load()
{
    precacheturret( "sniper_bipod" );
    common_scripts\utility::flag_init( "specific_warbird_deathflag1" );
    common_scripts\utility::flag_init( "specific_warbird_deathflag2" );
    common_scripts\utility::flag_init( "specific_warbird_deathflag3" );
}

setup_snipers()
{
    maps\df_baghdad_code::setup_common();
    thread handle_sniper_turrets();
    thread maps\df_baghdad_combat::setup_threatbias_combat();
    common_scripts\utility::flag_set( "tower_helis_death" );
    common_scripts\utility::flag_set( "player_near_tower" );
    common_scripts\utility::flag_set( "intro_finished" );
    maps\_utility::delaythread( 0.1, common_scripts\utility::flag_set, "knuckleduster_sniper" );
    soundscripts\_snd::snd_message( "snd_start_snipers" );
}

begin_snipers()
{
    thread maps\_utility::autosave_by_name( "intro_done" );
    thread maps\df_baghdad_code::sniper_objectives();
    thread sniper_reinforce();
    thread specific_warbird_deathflag();
    thread handle_turret1_spawns();
    thread handle_turret2_spawns();
    thread handle_turret3_spawns();
    common_scripts\utility::flag_wait( "snipers_finished" );
}

watch_turn_off_mbs()
{
    common_scripts\utility::flag_wait( "flag_in_sniper_zone" );
    maps\_utility::stop_magic_bullet_shield();
}

sniper_reinforce()
{
    common_scripts\utility::flag_wait( "player_on_sniper" );
    var_0 = maps\df_baghdad_code::array_spawn_targetname_allow_fail( "sniper_reinforce", 1 );

    foreach ( var_2 in var_0 )
        var_2 setthreatbiasgroup( "tower_guys" );

    maps\_utility::waittill_dead_or_dying( var_0, var_0.size - 3, 25 );
    common_scripts\utility::flag_set( "snipers_move_to_top" );
}

ambient_sniper_rockets()
{
    var_0 = maps\df_baghdad_code::array_spawn_targetname_allow_fail( "sniper_exos", 1 );
    common_scripts\utility::array_thread( var_0, ::handle_sniper_exos );
    level endon( "snipers_finished" );
}

handle_sniper_exos()
{
    self.ignoreall = 0;
    self.favoriteenemy = level.player;
    thread maps\_mech::mech_start_rockets();
}

handle_turret1_spawns()
{
    level.player waittill( "player_enters_mobile_turret", var_0 );

    if ( var_0 == level.sniper_turret1 )
    {
        thread kick_off_snipers_dead1_specific();
        thread handle_turret2_spawns();
        thread handle_turret3_spawns();
    }
}

handle_turret2_spawns()
{
    level.player waittill( "player_enters_mobile_turret", var_0 );

    if ( var_0 == level.sniper_turret2 )
    {
        thread kick_off_snipers_dead2_specific();
        thread handle_turret1_spawns();
        thread handle_turret3_spawns();
    }
}

handle_turret3_spawns()
{
    level.player waittill( "player_enters_mobile_turret", var_0 );

    if ( var_0 == level.sniper_turret3 )
    {
        thread kick_off_snipers_dead3_specific();
        thread handle_turret1_spawns();
        thread handle_turret2_spawns();
    }
}

kick_off_snipers_dead1_specific()
{
    var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive( "snipers_dead1_vehicles" );
    var_1 = level.sniper_turret1.mgturret[0];

    foreach ( var_3 in var_0 )
    {
        var_3.preferred_crash_style = 3;
        var_3.enablerocketdeath = 1;
        var_3 thread maps\df_baghdad_code::heli_start_shooting();
        var_3 thread maps\_damagefeedback::monitordamage();
        soundscripts\_snd::snd_message( "aud_avs_enemy_warbird", var_3 );
    }

    thread vo_nag_get_warbirds();
}

kick_off_snipers_dead2_specific()
{
    var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive( "snipers_dead2_vehicles" );
    var_1 = level.sniper_turret2.mgturret[0];

    foreach ( var_3 in var_0 )
    {
        var_3.preferred_crash_style = 3;
        var_3.enablerocketdeath = 1;
        var_3 thread maps\df_baghdad_code::heli_start_shooting();
        var_3 thread maps\_damagefeedback::monitordamage();
        soundscripts\_snd::snd_message( "aud_avs_enemy_warbird", var_3 );
    }

    thread vo_nag_get_warbirds();
}

kick_off_snipers_dead3_specific()
{
    var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive( "snipers_dead3_vehicles" );
    
    foreach ( var_2 in var_0 )
    {
        var_2.preferred_crash_style = 3;
        var_2.enablerocketdeath = 1;
        var_2 thread maps\df_baghdad_code::heli_start_shooting();
        var_2 thread maps\_damagefeedback::monitordamage();
        soundscripts\_snd::snd_message( "aud_avs_enemy_warbird", var_2 );
    }

    thread vo_nag_get_warbirds();
}

specific_warbird_deathflag()
{
    thread specific_warbird_deathflag1();
    thread specific_warbird_deathflag2();
    thread specific_warbird_deathflag3();
}

specific_warbird_deathflag1()
{
    common_scripts\utility::flag_wait( "specific_warbird_deathflag1" );
    level notify( "notify_specific_warbird1_dead" );
}

specific_warbird_deathflag2()
{
    common_scripts\utility::flag_wait( "specific_warbird_deathflag2" );
    level notify( "notify_specific_warbird2_dead" );
}

specific_warbird_deathflag3()
{
    common_scripts\utility::flag_wait( "specific_warbird_deathflag3" );
    level notify( "notify_specific_warbird1_dead" );
}

vo_nag_get_warbirds()
{
    level endon( "notify_specific_warbird1_dead" );
    level endon( "notify_specific_warbird2_dead" );
    level endon( "notify_specific_warbird3_dead" );
    thread maps\_utility::smart_radio_dialogue_interrupt( "df_nox_birdsincoming" );
    wait 6;
    thread maps\_utility::smart_radio_dialogue_interrupt( "df_gid_targetbirds" );
    wait 10;
    thread maps\_utility::smart_radio_dialogue_interrupt( "df_nox_fireonbirds" );
    wait 15;
    thread maps\_utility::smart_radio_dialogue_interrupt( "df_iln_takingfirebirds" );
}

handle_sniper_turrets()
{
    level.debug_turrets = 0;
    level.sniper_turret1 = thread maps\_vehicle::spawn_vehicle_from_targetname( "sniper_turret1" );
    level.sniper_turret2 = thread maps\_vehicle::spawn_vehicle_from_targetname( "sniper_turret2" );
    level.sniper_turret3 = thread maps\_vehicle::spawn_vehicle_from_targetname( "sniper_turret3" );
    thread init_note_targets();
    level.sniper_turret1 hide();
    level.sniper_turret2 hide();
    level.sniper_turret3 hide();
    level.sniper_turret1 maps\_vehicle::godon();
    level.sniper_turret2 maps\_vehicle::godon();
    level.sniper_turret3 maps\_vehicle::godon();
    level.sniper_turret1 thread handle_turret_shootloop();
    level.sniper_turret2 thread handle_turret_shootloop();
    level.sniper_turret3 thread handle_turret_shootloop();
    level.sniper_turret1.base = getent( "turret1_base", "targetname" );
    level.sniper_turret2.base = getent( "turret2_base", "targetname" );
    level.sniper_turret3.base = getent( "turret3_base", "targetname" );
    level.sniper_turret1.base_clip = getent( "turret1_clip", "targetname" );
    level.sniper_turret2.base_clip = getent( "turret2_clip", "targetname" );
    level.sniper_turret3.base_clip = getent( "turret3_clip", "targetname" );
    thread turret_exploding_debug( level.sniper_turret1 );
    thread handle_turret_specific_saves();
}

turret_exploding_debug( var_0 )
{
    var_1 = var_0;
    var_1 waittill( "damage" );
}

handle_turret_specific_saves()
{
    thread turret1spawns();
    thread turret2spawns();
    thread turret3spawns();
}

turret1spawns()
{
    common_scripts\utility::flag_wait( "snipers_dead1" );
    wait 1;
    thread maps\_utility::autosave_by_name_silent( "sv_snipers_dead1" );
}

turret2spawns()
{
    common_scripts\utility::flag_wait( "snipers_dead2" );
    wait 1;
    thread maps\_utility::autosave_by_name_silent( "sv_snipers_dead2" );
}

turret3spawns()
{
    common_scripts\utility::flag_wait( "snipers_dead3" );
    wait 1;
    thread maps\_utility::autosave_by_name_silent( "sv_snipers_dead3" );
}

disable_all_turrets()
{
    common_scripts\utility::flag_wait( "snipers_finished" );
    level.player notify( "exit_message" );

    if ( isdefined( level.sniper_turret1 ) )
        level.sniper_turret1 vehicle_scripts\_x4walker_wheels_turret_closed::make_mobile_turret_unusable();

    if ( isdefined( level.sniper_turret2 ) )
        level.sniper_turret2 vehicle_scripts\_x4walker_wheels_turret_closed::make_mobile_turret_unusable();

    if ( isdefined( level.sniper_turret3 ) )
        level.sniper_turret3 vehicle_scripts\_x4walker_wheels_turret_closed::make_mobile_turret_unusable();
}

handle_turret_shootloop()
{
    level.debug_turrets++;
    var_0 = level.debug_turrets;
    wait 0.1;
    self setvehicleteam( "axis" );
    self.script_team = "axis";

    if ( !maps\_utility::ent_flag_exist( "turret_fire_noteworthy" ) )
    {
        maps\_utility::ent_flag_init( "turret_fire_noteworthy" );
        maps\_utility::ent_flag_init( "turret_continue_path" );
        maps\_utility::ent_flag_init( "turret_fire_parms" );
    }

    if ( self.script_parameters == "intro_fire" || self.script_parameters == "no_loop" )
        var_1 = 0;

    thread watch_rider_death( var_0 );
    self endon( "death" );
    self endon( "player_roof_kill" );
    self.riders[0] endon( "death" );
    self.mgturret[0] setmode( "manual" );
    var_2 = 147456;

    for (;;)
    {
        wait( randomfloatrange( 2, 4 ) );

        if ( common_scripts\utility::flag( "player_on_knuckles" ) )
            continue;

        var_3 = randomintrange( 15, 20 );
        var_4 = level.notes[randomint( level.notes.size )];
        self.mgturret[0] settargetentity( var_4 );

        for ( var_5 = 0; var_5 < var_3; var_5++ )
        {
            self.mgturret[0] shootturret();
            wait 0.1;
        }

        wait 0.1;

        if ( !randomintrange( 0, 3 ) )
        {
            if ( distancesquared( var_4.origin, level.player.origin ) > var_2 )
                turret_shoot_missile( var_4 );

            self.mgturret[0] cleartargetentity();
        }
    }
}

init_note_targets()
{
    level.notes = [];
    level.notes[0] = getent( "sniper_turret_fire1", "targetname" );
    level.notes[1] = getent( "sniper_turret_fire2", "targetname" );
    level.notes[2] = getent( "sniper_turret_fire3", "targetname" );
    level.notes[3] = getent( "sniper_turret_fire4", "targetname" );
    var_0 = getent( "sniper_turret_fire1_start", "targetname" );
    var_1 = getent( "sniper_turret_fire1_end", "targetname" );
    var_2 = getent( "sniper_turret_fire2_start", "targetname" );
    var_3 = getent( "sniper_turret_fire2_end", "targetname" );
    var_4 = getent( "sniper_turret_fire3_start", "targetname" );
    var_5 = getent( "sniper_turret_fire3_end", "targetname" );
    var_6 = getent( "sniper_turret_fire4_start", "targetname" );
    var_7 = getent( "sniper_turret_fire4_end", "targetname" );
    level.notes[0] thread moving_note_targets( var_0, var_1 );
    level.notes[1] thread moving_note_targets( var_2, var_3 );
    level.notes[2] thread moving_note_targets( var_4, var_5 );
    level.notes[3] thread moving_note_targets( var_6, var_7 );
}

moving_note_targets( var_0, var_1 )
{
    var_2 = 4;
    var_3 = 4;

    for (;;)
    {
        self moveto( var_1.origin, var_2, 0.5, 0.5 );
        wait( var_2 );
        self moveto( var_0.origin, var_3, 0.5, 0.5 );
        wait( var_3 );
    }
}

turret_shoot_missile( var_0 )
{
    var_1 = self.origin + ( 0, 120, 74 );
    var_2 = var_0.origin;
    var_3 = magicbullet( "bagh_mahem_cheaptrail", var_1, var_2 );
    var_3 waittill( "death" );
}

stationary_anim_pose()
{
    self.animname = "spider_turret";
    self useanimtree( level.scr_animtree[self.animname] );
    maps\_anim::anim_first_frame_solo( self, "spider_turret_emplaced" );
}

death_watch( var_0 )
{
    self waittill( "death" );
}

watch_rider_death( var_0 )
{
    self.riders[0] waittill( "death" );
    self notify( "newpath" );
    self vehicle_setspeed( 0, 20, 20 );
    wait 1;
    wait 1;
}

turret_shoot_vtols()
{
    common_scripts\utility::flag_wait( "player_on_intro_balcony" );
    var_0 = level.intro_helis;
    var_1 = 0;

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3 ) )
            continue;

        var_3 maps\_utility::delaythread( 1.7, maps\_vehicle::godoff );

        if ( var_1 == 1 )
            thread maps\_utility::smart_radio_dialogue_interrupt( "df_cp2_evasive" );

        while ( isdefined( var_3 ) && var_3 maps\_vehicle::isvehicle() )
        {
            var_4 = ( 0, 0, 60 );

            if ( var_3 maps\_utility::ent_flag( "right_door_open" ) )
                var_4 = ( 0, 0, 30 );

            self.mgturret[0] settargetentity( var_3, var_4 );
            wait 0.2;
            self.mgturret[0] shootturret();
            wait( randomfloatrange( 0.75, 1.25 ) );
        }

        if ( var_1 == 1 )
            thread maps\_utility::smart_radio_dialogue_interrupt( "df_cp1_werehit1" );
        else if ( var_1 == 3 )
            thread maps\_utility::smart_radio_dialogue_interrupt( "df_ss1_birdsdown" );

        var_1++;
    }

    thread maps\_utility::smart_radio_dialogue_interrupt( "df_ss2_takingfire" );
    wait 2;
    level.allies[1] maps\_utility::smart_dialogue( "df_iln_teamdown" );
    wait 1;
    level.allies[0] maps\_utility::smart_dialogue( "df_gid_clearitout" );
}

vtol_battle_redux()
{
    common_scripts\utility::flag_wait( "flag_kickoff_VTOL_battle" );
    setsaveddvar( "bg_fallDamageMinHeight", 400 );
    setsaveddvar( "bg_fallDamageMaxHeight", 6000 );
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname( "sniper_heli_top" );
    var_0 setvehicleteam( "axis" );
    thread hack_destroy_heli_at_end_progression( var_0 );
    wait 0.05;
    var_1 = getent( "VTOL_crash_location", "targetname" );
    var_0.preferred_crash_style = 3;
    var_0.preferred_crash_location = var_1;
    level.old_crash_loc = level.helicopter_crash_locations;
    level.helicopter_crash_locations = [];
    level.helicopter_crash_locations[level.helicopter_crash_locations.size] = var_1;
    var_2 = getent( "VTOL_fight_guy_driver", "targetname" );
    var_3 = var_2 maps\_utility::spawn_ai();
    var_3.health = 999;
    var_3.script_startingposition = 0;
    var_3.allowdeath = 1;
    var_3 character\gfl\randomizer_atlas::main();
    var_0 thread maps\_vehicle_aianim::guy_enter( var_3 );
    var_0 thread vtol_death_if_pilot_shot( var_3 );
    thread handle_player_jump_off_roof();
    var_0 thread vehicle_scripts\_xh9_warbird::open_left_door();
    var_0 thread vehicle_scripts\_xh9_warbird::open_right_door();
    var_4 = maps\_utility::getstructarray_delete( "knuckle_dudester_teleport_loc", "targetname" );
    wait 2;
    var_0 thread maps\_vehicle::gopath();
}

waittill_shot_then_die()
{
    self waittill( "damage" );
    self kill();
}

vtol_death_if_pilot_shot( var_0 )
{
    var_0 waittill( "damage" );
    var_0.animname = "generic";
    thread chopper_pilot_death_anim( "boneyard_driver_death", var_0, 0, 0, 0 );
    wait 0.05;
    self kill();
    wait 2;
    maps\_utility::smart_radio_dialogue_interrupt( "df_nox_itsgoingdown" );
    wait 3;
    maps\_utility::smart_radio_dialogue_interrupt( "df_nox_downnetwork" );
    common_scripts\utility::flag_set( "sniper_support_finished" );
    setsaveddvar( "bg_fallDamageMinHeight", 400 );
    setsaveddvar( "bg_fallDamageMaxHeight", 1024 );
}

hack_destroy_heli_at_end_progression( var_0 )
{
    common_scripts\utility::flag_wait( "VTOL_pilot_shot" );
    var_0 kill();
    maps\_utility::smart_radio_dialogue_interrupt( "df_nox_itsgoingdown" );
    wait 3;
    maps\_utility::smart_radio_dialogue_interrupt( "df_nox_downnetwork" );
    common_scripts\utility::flag_set( "sniper_support_finished" );
    maps\df_baghdad_code::safe_activate_trigger_with_targetname( "trig_ally_colors_to_streets" );
    common_scripts\utility::flag_set( "approach_atlas_snipers_finished" );
    setsaveddvar( "bg_fallDamageMinHeight", 400 );
    setsaveddvar( "bg_fallDamageMaxHeight", 1024 );
}

vtol_reset_player_orientations( var_0 )
{
    level endon( "player_out_of_VTOL" );
    var_1 = 16384;

    for (;;)
    {
        if ( distancesquared( var_0.origin, level.player.origin ) > var_1 )
        {
            level.player playersetgroundreferenceent( undefined );
            waitframe();
            level endon( "player_out_of_VTOL" );
        }
        else
            wait 0.05;

        wait 0.2;
        waitframe();
    }
}

chopper_pilot_death_anim( var_0, var_1, var_2, var_3, var_4 )
{
    var_1 notify( "stop_idle" );
    var_1 notify( "stop_anim" );
    var_1 endon( "stop_anim" );
    var_1 maps\_anim::anim_single_solo( var_1, var_0 );

    if ( isdefined( var_3 ) && !var_3 )
    {
        if ( isdefined( var_4 ) && var_4 )
            self unlink();

        self notify( "vehicle_play_guy_anim_complete" );
        return;
    }
}

handle_player_jump_off_roof()
{
    common_scripts\utility::flag_wait( "player_jump_off_roof" );
    common_scripts\utility::flag_set( "sniper_support_finished" );

    if ( isdefined( level.vtol_fight ) )
        level.vtol_fight kill();
}

watch_jumper( var_0 )
{
    var_1 = getent( "jumper_trigger", "targetname" );
    var_1 waittill( "trigger", var_2 );
    var_2 maps\_utility::set_goal_ent( var_0 );
}

heli_fight()
{
    self endon( "death" );
    thread maps\_utility::notify_delay( "death", 22 );
    maps\_vehicle::godoff();
    thread path_heli();
    var_0 = 2;
    var_1 = var_0 + 1.5;
    self setlookatent( level.player );

    for (;;)
    {
        var_2 = level.player;

        if ( common_scripts\utility::cointoss() )
            var_2 = level.allies[randomint( 2 )];

        for ( var_3 = 0; var_3 < 2; var_3++ )
        {
            var_4 = self.mgturret[var_3];
            var_4 setmode( "manual" );
            var_4 settargetentity( var_2, ( 0, 0, 36 ) );
            var_4 startfiring();
            var_4 common_scripts\utility::delaycall( var_0, ::stopfiring );
        }

        wait( var_1 );
    }
}

path_heli()
{
    self endon( "death" );
    var_0 = common_scripts\utility::getstruct( "heli_east_tower", "targetname" );
    thread maps\_vehicle::vehicle_paths( var_0 );
    self waittill( "reached_dynamic_path_end" );
    iprintlnbold( "heli at end of east path." );
}
