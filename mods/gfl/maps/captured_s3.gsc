// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

pre_load()
{

}

post_load()
{
    common_scripts\utility::flag_init( "s3_escape_exit_door_open" );
    common_scripts\utility::flag_init( "flag_scene_doctor_done" );
    common_scripts\utility::flag_init( "flag_injured_player_active" );
    common_scripts\utility::flag_init( "flag_s3escape_doctor" );
    common_scripts\utility::flag_init( "flag_s3guard_security_door_shuts" );
    common_scripts\utility::flag_init( "s3_player_pickedup_console_gun" );
    common_scripts\utility::flag_init( "s3_interrogation_player_ready" );
    common_scripts\utility::flag_init( "s3_interrogation_allies_ready" );
    common_scripts\utility::flag_init( "lgt_flag_interrogation_esc" );
    common_scripts\utility::flag_init( "lgt_flag_interrogation_begin" );
    common_scripts\utility::flag_init( "lgt_flag_interrogation_esc_done" );

    if ( isdefined( common_scripts\utility::getstruct( "struct_interrogation_scene", "targetname" ) ) )
        thread setup_spawners();
}

setup_spawners()
{
    maps\_utility::array_spawn_function( getentarray( "actor_s3_interrogation", "targetname" ), ::opfor_interrogation );
    maps\_utility::array_spawn_function( getentarray( "s3_escape_main_room_guards", "targetname" ), maps\captured_medical::opfor_ah );
    maps\_utility::array_spawn_function( getentarray( "s3escape_hall_enemies", "targetname" ), maps\captured_medical::opfor_ah );
}

opfor_interrogation()
{
    self endon( "death" );
    self.no_pain_sound = 1;
    self.allowpain = 0;
    self.diequietly = 1;
    self.nocorpsedelete = 1;
    self.noragdoll = 1;

    if ( isdefined( self.script_parameters ) )
        self.animname = self.script_parameters;

    maps\_utility::gun_remove();

    if ( !isdefined( self.script_parameters ) || self.script_parameters != "irons" )
        maps\_utility::place_weapon_on( "iw5_titan45onearmgundown_sp", "right" );

    maps\captured_util::ignore_everything();
    self.allowdeath = 1;
}

start( var_0 )
{
    level.player disableweapons();
    level.player disableoffhandweapons();
    level.player disableweaponswitch();
    thread maps\_utility::battlechatter_off( "allies" );
    thread maps\_utility::battlechatter_off( "axis" );
    level.player maps\captured_util::warp_to_start( var_0 );

    if ( issubstr( level.start_point, "s3trolley" ) )
    {
        setsaveddvar( "g_friendlyNameDist", 0 );
        iprintln( "The trolley start point has been removed" );
    }
    else if ( issubstr( level.start_point, "s3interrogate" ) )
        setsaveddvar( "g_friendlyNameDist", 0 );
    else if ( issubstr( level.start_point, "escape" ) )
    {
        common_scripts\utility::flag_set( "s3_interrogation_allies_ready" );
        level.player.mover = common_scripts\utility::spawn_tag_origin();
        getent( "glass_interrogation_before", "targetname" ) delete();
        common_scripts\utility::flag_set( "flag_injured_player_active" );
        level.player thread injured_player_blur();
    }
}

main_s3trolley()
{

}

main_s3interrogate()
{
    if ( level.currentgen )
    {
        if ( !istransientloaded( "captured_interrogate_tr" ) )
            level waittill( "tff_post_s2walk_to_interrogate" );
    }

    level thread s3_interrogate_doctor_scene();
    var_0 = common_scripts\utility::getstruct( "struct_interrogation_scene", "targetname" );
    var_1 = maps\_utility::array_spawn( getentarray( "actor_s3_interrogation", "targetname" ) );
    var_2 = common_scripts\utility::array_combine( var_1, level.allies );
    var_3 = maps\_utility::spawn_anim_model( "torque_wrench" );
    var_4 = [ maps\_utility::spawn_anim_model( "stockade_01" ), maps\_utility::spawn_anim_model( "stockade_02" ) ];
    var_0 maps\_anim::anim_first_frame( common_scripts\utility::add_to_array( var_4, var_3 ), "s3_interrogation" );
    level.breakout_glass = [ maps\_utility::spawn_anim_model( "breakout_window_1" ), maps\_utility::spawn_anim_model( "breakout_window_2" ) ];
    common_scripts\utility::getstruct( "struct_interrogation_glass", "targetname" ) thread maps\_anim::anim_first_frame( level.breakout_glass, "s3_breakout_break" );
    common_scripts\utility::array_call( level.breakout_glass, ::hide );
    var_5 = spawn( "script_model", ( 5000, -9928, -1748 ) );
    var_5 setmodel( "tag_origin" );

    foreach ( var_7 in level.breakout_glass )
    {
        var_7 common_scripts\utility::delaycall( 0.5, ::retargetscriptmodellighting, var_5 );
        var_7 common_scripts\utility::delaycall( 0.5, ::overridereflectionprobe, var_5.origin );
    }

    foreach ( var_10 in level.allies )
    {
        var_10 maps\_utility::gun_remove();

        if ( var_10.animname != "ally_2" && !isdefined( var_10.hasattachedprops ) )
        {
            var_10 attach( "s1_captured_handcuffs", "tag_weapon_left" );
            var_10.hasattachedprops = 1;
            continue;
        }

        if ( var_10.animname == "ally_2" && isdefined( var_10.hasattachedprops ) )
        {
            var_10 detach( "s1_captured_handcuffs", "tag_weapon_left" );
            var_10.hasattachedprops = undefined;
        }
    }

    if ( level.currentgen )
        level.player lerpfov( 60, 0 );
    else
        level.player lerpfov( 50, 0 );

    level.player unlink();
    level.player takeallweapons();
    level.player allowmelee( 0 );
    level.player allowstand( 1 );
    level.player allowcrouch( 0 );
    level.player allowprone( 0 );
    level.player allowsprint( 0 );
    level.player allowjump( 0 );
    var_12 = [ maps\_utility::spawn_anim_model( "player_rig_noexo" ), maps\_utility::spawn_anim_model( "player_rig_smashed_noexo" ) ];
    var_12[0].toggle = var_12[1];
    var_12[1].toggle = var_12[0];
    var_0 maps\_anim::anim_first_frame( var_12, "s3_interrogation" );
    var_12[1] hide();
    wait 0.05;
    level.player maps\captured_util::smooth_player_link( var_12[0], 0.05 );
    soundscripts\_snd::snd_message( "aud_interrogation_scene" );
    common_scripts\utility::flag_set( "lgt_flag_interrogation_begin" );
    setsaveddvar( "r_adaptiveSubdiv", 0 );
    var_13 = getanimlength( var_12[0] maps\_utility::getanim( "s3_interrogation" ) );
    var_0 thread maps\_anim::anim_single( var_2, "s3_interrogation" );
    var_0 thread maps\_anim::anim_single( var_4, "s3_interrogation" );
    var_0 thread maps\_anim::anim_single( [ var_12[0], var_12[1], var_3 ], "s3_interrogation" );
    var_14 = common_scripts\utility::spawn_tag_origin();

    foreach ( var_16 in getentarray( "model_s3interrogation_doorin", "targetname" ) )
        var_16 linkto( var_14 );

    wait 10.0;
    var_14 moveto( var_14.origin - ( 0, 90, 0 ), 2, 2, 0 );
    level.player common_scripts\utility::delaycall( 114.3, ::playrumbleonentity, "heavy_2s" );
    level.player common_scripts\utility::delaycall( 118.1, ::playrumbleonentity, "heavy_2s" );
    wait(var_13 - 20);
    var_18 = maps\_hud_util::create_client_overlay( "black", 0, level.player );
    var_18 thread s3_fade_over_time( 1, 10 );
    wait 6.0;
    var_14 moveto( var_14.origin + ( 0, 90, 0 ), 2, 2, 0 );
    wait 4.0;
    maps\_utility::array_delete( var_1 );
    var_1 = maps\_utility::array_spawn( getentarray( "actor_s3_breakout", "script_noteworthy" ) );
    common_scripts\_exploder::exploder( "fx_rescue_guard_2_blood_pool" );
    soundscripts\_snd::snd_message( "aud_rescue_drone" );
    level.player lerpfov( 55, 0 );
    wait 3.0;
    soundscripts\_snd::snd_message( "aud_cap_interrogation_transition_vo" );
    wait 6.0;
    common_scripts\utility::flag_set( "flag_injured_player_active" );
    level.player thread injured_player_blur();
    var_18 maps\_utility::delaythread( 0.25, ::s3_fade_over_time, 0, 3 );
    maps\_utility::delaythread( getanimlength( level.ally maps\_utility::getanim( "s3_breakout" ) ), common_scripts\utility::flag_set, "s3_interrogation_allies_ready" );
    level.player common_scripts\utility::delaycall( 23.5, ::lerpfov, 65, 4 );
    maps\_utility::delaythread( 24.75, ::breakout_opfor_cleanup, var_0, var_1, var_4, var_3 );
    level.player common_scripts\utility::delaycall( 24, ::playerlinktodelta, var_12[1], "tag_player", 0.5, 20, 30, 15, 15, 1 );
    level.player common_scripts\utility::delaycall( 24, ::enableslowaim, 0.3, 0.15 );
    var_0 thread maps\captured_anim::anim_single_to_loop( [ level.allies[1], level.allies[2] ], "s3_breakout", "s3_breakout_loop", "leave_interrogation_room_allies" );
    var_0 thread maps\captured_anim::anim_single_to_loop( level.ally, "s3_breakout", "s3_breakout_loop", "leave_interrogation_room" );
    var_0 thread maps\_anim::anim_single( var_1, "s3_breakout" );
    var_0 thread maps\_anim::anim_single( var_4, "s3_breakout" );
    var_0 maps\_anim::anim_single( var_12, "s3_breakout" );
    setsaveddvar( "r_adaptiveSubdiv", 1 );

    foreach ( var_10 in level.allies )
    {
        if ( isdefined( var_10.hasattachedprops ) )
        {
            var_10 detach( "s1_captured_handcuffs", "tag_weapon_left" );
            var_10.hasattachedprops = undefined;
        }
    }

    maps\_utility::flagwaitthread( "s3_interrogation_player_ready", maps\_utility::autosave_now );
    setsaveddvar( "g_friendlyNameDist", level.friendlynamedist );
    level.player allowmelee( 1 );
    level.player allowstand( 1 );
    level.player allowcrouch( 1 );
    level.player allowprone( 1 );
    level.player allowjump( 1 );
    level.player disableslowaim();
    level.player unlink();
    common_scripts\utility::array_call( var_12, ::delete );
    common_scripts\utility::flag_set( "flag_s3interrogate_end" );
}

s3_toggle_rig( var_0 )
{
    var_0 show();
    var_0.toggle hide();
}

s3_interrogate_doctor_scene()
{
    if ( level.currentgen )
        return;

    var_0 = maps\_utility::spawn_targetname( "actor_interrogation_doctor" );
    var_0.animname = "doctor";
    var_0 maps\_utility::gun_remove();
    var_0 maps\captured_util::ignore_everything();
    var_1 = common_scripts\utility::getstruct( "s3_interrogate_hanging_body", "targetname" );
    var_2 = spawn( "script_model", var_1.origin );
    var_2.angles = var_1.angles;
    var_2 setmodel( "cap_morgue_body_c" );
    var_3 = common_scripts\utility::getstruct( "anim_interrogation_doctor", "targetname" );
    var_3 thread maps\_anim::anim_loop( [ var_0 ], "autopsy_doctor_loop_start", "stop_interrogate_doctor" );
    common_scripts\utility::flag_wait( "s3_escape_exit_door_open" );
    var_3 notify( "stop_interrogate_doctor" );
    var_0 delete();
    var_2 delete();
}

s3_fade_over_time( var_0, var_1 )
{
    self fadeovertime( var_1 );
    self.alpha = var_0;
}

s3_break_glass( var_0 )
{
    common_scripts\utility::array_call( level.breakout_glass, ::show );
    common_scripts\utility::getstruct( "struct_interrogation_glass", "targetname" ) thread maps\_anim::anim_single( level.breakout_glass, "s3_breakout_break" );
    common_scripts\_exploder::exploder( "fx_int_glass_shatter" );
    common_scripts\_exploder::kill_exploder( "fx_int_guard_fire_3" );
    common_scripts\_exploder::kill_exploder( "fx_int_guard_fire_4" );
    common_scripts\_exploder::kill_exploder( "fx_int_guard_fire_5" );
    getent( "glass_interrogation_before", "targetname" ) delete();
    common_scripts\utility::flag_wait( "s3_escape_exit_door_open" );
    common_scripts\utility::array_call( level.breakout_glass, ::delete );
}

breakout_opfor_cleanup( var_0, var_1, var_2, var_3 )
{
    foreach ( var_5 in var_1 )
    {
        var_5 setanimrate( var_5 maps\_utility::getanim( "s3_breakout" ), 0 );
        var_5 maps\captured_util::kill_no_react();
    }

    common_scripts\utility::flag_wait( "s3_escape_exit_door_open" );
    common_scripts\utility::array_call( var_2, ::delete );
    var_3 delete();

    foreach ( var_8 in level.allies )
    {
        if ( isdefined( var_8.cuff ) )
            var_8.cuff delete();
    }
}

main_s3escape()
{
    level.player thread injured_player_wobble();
    common_scripts\utility::array_thread( level.allies, maps\_utility::enable_cqbwalk );
    thread maps\captured_util::physics_bodies_on( "escape_bodies_1", 0, 1 );
    thread slow_player_scaler();
    var_0 = common_scripts\utility::getstruct( "struct_scene_s3escape_takedown", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "takedown_monitor" );
    var_0 maps\_anim::anim_first_frame_solo( var_1, "s3escape_takedown" );
    thread s3_escape_outer_door();
    var_2 = getent( "s3_escape_large_security_door", "targetname" );
    var_2 moveto( var_2.origin + ( 0, 0, 112 ), 1, 0.2, 0.05 );
    var_3 = getentarray( "s3_escape_elevator", "targetname" );
    var_4 = undefined;

    foreach ( var_6 in var_3 )
    {
        if ( var_6.classname == "script_brushmodel" )
            var_4 = var_6;
    }

    foreach ( var_6 in var_3 )
    {
        if ( var_6.classname == "script_model" )
            var_6 linkto( var_4 );
    }

    var_4 moveto( var_4.origin + ( 0, 0, 150 ), 1.5, 0.2, 0.05 );
    common_scripts\utility::flag_wait_all( "s3_interrogation_player_ready", "s3_interrogation_allies_ready" );
    var_10 = common_scripts\utility::getstruct( "struct_scene_s3escape_hallway", "targetname" );

    while ( !common_scripts\utility::within_fov( level.player.origin, level.player.angles, var_10.origin, 0.8 ) )
        wait 0.05;

    level notify( "leave_interrogation_room" );
    thread s3escape_intro_scene( var_10 );
    common_scripts\utility::flag_wait( "flag_s3escape_hall" );
    thread s3escape_doctor_scene();
    common_scripts\utility::flag_wait( "flag_scene_doctor_done" );
    common_scripts\utility::flag_waitopen( "flag_s3escape_hall" );
    var_10 notify( "s3escape_hallway_gideon_ender" );
    common_scripts\utility::flag_set( "flag_injured_player_active" );
    var_10 = s3_enter_security_room( var_10, var_1 );
    s3_splitup_event( var_10 );
    common_scripts\utility::flag_wait( "flag_s3escape_end" );
}

s3escape_console_setup()
{
    setsaveddvar( "cg_cinematicfullscreen", "0" );
    cinematicingame( "captured_elevator_controls", 0, 1.0, 1 );

    if ( !iscinematicplaying() )
        wait 0.1;

    wait 1;
    pausecinematicingame( 1 );
    var_0 = getscriptablearray( "s3_escape_console_monitor", "targetname" );
    level.s3_escape_console_monitor = var_0[0];

    if ( !common_scripts\utility::flag_exist( "s3_escape_console_monitor_unfreeze" ) )
        common_scripts\utility::flag_init( "s3_escape_console_monitor_unfreeze" );

    while ( !common_scripts\utility::flag( "s3_escape_console_monitor_unfreeze" ) )
    {
        level.s3_escape_console_monitor setscriptablepartstate( 0, 0 );
        wait 0.2;

        if ( !common_scripts\utility::flag( "s3_escape_console_monitor_unfreeze" ) )
        {
            level.s3_escape_console_monitor setscriptablepartstate( 0, 1 );
            wait 0.2;
        }
    }
}

s3escape_console_pause_checkpoint()
{
    if ( !iscinematicplaying() )
        wait 0.05;

    wait 0.6;
    pausecinematicingame( 1 );
}

s3escape_console_cinematic_watcher()
{
    wait 1;
    pausecinematicingame( 0 );

    while ( cinematicgettimeinmsec() < 10270 )
        waitframe();

    wait 1;
    level.s3_escape_console_monitor setscriptablepartstate( 0, 3 );
}

s3escape_intro_scene( var_0 )
{
    if ( level.currentgen )
    {
        if ( !istransientloaded( "captured_escape_tr" ) )
            level waittill( "tff_post_load_escape" );
    }

    var_1 = common_scripts\utility::getstruct( "struct_interrogation_scene", "targetname" );
    var_1 notify( "leave_interrogation_room" );
    var_2 = common_scripts\utility::spawn_tag_origin();

    foreach ( var_4 in getentarray( "model_s3escape_doorout", "targetname" ) )
        var_4 linkto( var_2 );

    if ( level.currentgen )
    {
        var_6 = getent( "model_s3escape_doorout_coll", "targetname" );
        var_6 linkto( var_2 );
        var_6 connectpaths();
    }

    var_2 moveto( var_2.origin + ( 0, 90, 0 ), 2, 2, 0 );
    soundscripts\_snd::snd_message( "aud_door", "rescue" );
    var_7 = level.allies;

    foreach ( var_9 in var_7 )
    {
        var_9 maps\captured_util::ignore_everything();
        var_9 maps\_utility::gun_remove();
    }

    var_0 thread maps\captured_anim::anim_single_to_loop( var_7[0], "s3escape_hallway", "s3escape_hallway_loop", "s3escape_hallway_gideon_ender" );
    common_scripts\utility::flag_wait( "flag_s3escape_hall" );
    common_scripts\utility::flag_waitopen( "flag_s3escape_hall" );
    var_1 notify( "leave_interrogation_room_allies" );
    var_0 thread maps\captured_anim::anim_single_to_loop( var_7[1], "s3escape_hallway", "s3escape_hallway_loop", "s3escape_hallway_ender" );
    var_0 thread maps\captured_anim::anim_single_to_loop( var_7[2], "s3escape_hallway", "s3escape_hallway_loop", "s3escape_hallway_ender" );

    if ( level.currentgen )
    {
        wait 3.0;
        common_scripts\utility::flag_wait( "flag_tff_allow_interrogate_unload" );
        var_6 = getent( "model_s3escape_doorout_coll", "targetname" );
        var_6 disconnectpaths();
        var_2 moveto( var_2.origin - ( 0, 90, 0 ), 0.25, 0.25, 0 );
        wait 1.0;
        common_scripts\utility::flag_set( "flag_tff_unload_interrogate" );
    }
}

s3escape_doctor_scene()
{
    level endon( "s3escape_player_killed_doctor" );
    var_0 = common_scripts\utility::getstruct( "s3_escape_doctor_scene", "targetname" );
    var_1 = maps\_utility::spawn_targetname( "s3secape_doctor", 1 );
    var_1 character\gfl\character_gfl_dima::main();
    var_1 maps\captured_util::ignore_everything();
    var_1.animname = "doctor";
    var_2 = spawn( "script_model", var_0.origin );
    var_2 setmodel( "cap_hanging_bodybag" );
    var_2.animname = "escape_bodybag";
    var_2 maps\_anim::setanimtree();
    var_3 = spawn( "script_model", var_2.origin );
    var_3 setmodel( "trolley_block" );
    var_3 linkto( var_2, "tag_origin", ( 0, 0, 6 ), ( 0, 0, 0 ) );
    var_4 = spawn( "script_model", var_0.origin );
    var_4 setmodel( "det_patient_chart_01" );
    var_4.animname = "escape_clipboard";
    var_4 maps\_anim::setanimtree();
    var_5 = [ var_1, var_2, var_4 ];
    var_6 = common_scripts\utility::spawn_tag_origin();

    foreach ( var_8 in getentarray( "model_s3escape_docdoor", "targetname" ) )
        var_8 linkto( var_6 );

    common_scripts\utility::flag_clear( "flag_injured_player_active" );
    common_scripts\utility::flag_set( "lgt_flag_interrogation_esc" );
    soundscripts\_snd::snd_message( "aud_escape_doctor_bodybag" );
    var_6 common_scripts\utility::delaycall( 7.5, ::moveto, var_6.origin, 1.5, 1.5, 0 );
    var_6 moveto( var_6.origin + ( 0, 90, 0 ), 1.5, 1.5, 0 );
    maps\_utility::delaythread( 7.5, common_scripts\utility::flag_set, "flag_scene_doctor_done" );
    var_0 maps\_anim::anim_single( var_5, "s3escape_doctor_scene" );
    var_5 = maps\_utility::remove_dead_from_array( var_5 );
    common_scripts\utility::array_call( var_5, ::delete );
    common_scripts\utility::flag_set( "lgt_flag_interrogation_esc_done" );
}

s3_escape_deathwatcher( var_0 )
{
    self waittill( "damage" );
    var_0 stopanimscripted();
    var_0 delete();

    if ( isalive( self ) )
    {
        self stopanimscripted();
        self kill();
    }

    common_scripts\utility::flag_set( "flag_scene_doctor_done" );
}

s3escape_doctor_kill( var_0 )
{
    level waittill( "s3escape_player_killed_doctor" );
    iprintlnbold( "[ Player kills the doctor. ]" );
    var_0 delete();
}

s3escape_doctor_killbox_prompt()
{
    level endon( "s3escape_doctor_survived" );
    common_scripts\utility::flag_wait( "s3escape_doctor_killbox" );

    for (;;)
    {
        if ( common_scripts\utility::flag( "s3escape_doctor_killbox" ) )
        {
            if ( level.player meleebuttonpressed() )
            {
                level notify( "s3escape_player_killed_doctor" );
                break;
            }
        }

        wait 0.05;
    }
}

#using_animtree("generic_human");

s3_enter_security_room( var_0, var_1 )
{
    var_2 = level.allies;
    var_3 = common_scripts\utility::getstruct( "struct_scene_s3escape_hallway", "targetname" );
    var_4 = common_scripts\utility::getstruct( "struct_scene_s3escape_takedown", "targetname" );
    var_5 = maps\_utility::spawn_anim_model( "controlroom_entrance_door" );
    var_6 = getent( "s3_escape_controlroom_entrance_col", "targetname" );
    var_4 maps\_anim::anim_first_frame_solo( var_5, "s3escape_takedown" );
    var_4 thread s3_escape_sliding_door_player( var_5, var_6, "s3escape_takedown" );
    var_7 = maps\_utility::spawn_anim_model( "takedown_gun_gideon" );
    var_4 maps\_anim::anim_first_frame_solo( var_7, "s3escape_takedown" );
    var_8 = getent( "s3escape_guard_1", "targetname" );
    var_9 = maps\_utility::dronespawn_bodyonly( var_8 );
    var_9.animname = "guard_1";
    var_9 maps\captured_util::ignore_everything();
    var_9.diequietly = 1;
    var_9 maps\_utility::clear_deathanim();
    var_9.noragdoll = 1;
    var_9 maps\_utility::gun_remove();
    var_9.no_ai = 1;
    var_9.allowpain = 0;
    var_9.skipdeathanim = 1;
    var_9.dont_break_anim = 1;
    var_10 = spawn( "script_model", var_4.origin );
    var_10 setmodel( "cap_lab_chair" );
    var_10.animname = "takedown_chair";
    var_10 maps\_anim::setanimtree();
    var_11 = [ var_9, var_10, var_1 ];
    var_4 thread maps\_anim::anim_loop( var_11, "s3escape_hallway_end_loop", "s3escape_hallway_door_ender" );
    var_3 thread maps\captured_anim::anim_single_to_loop( var_2[0], "s3escape_hallway_end", "s3escape_hallway_end_loop", "s3escape_hallway_door_gideon_ender", var_4 );
    wait(getanimlength( %cap_s3_escape_hallway_cormack_01_end ));
    common_scripts\utility::flag_wait( "flag_s3_escape_at_security_room" );
    var_0 notify( "s3escape_hallway_ender" );
    var_3 thread maps\captured_anim::anim_single_to_loop( var_2[1], "s3escape_hallway_end", "s3escape_hallway_end_loop", "s3escape_hallway_door_ender", var_4 );
    var_3 thread maps\captured_anim::anim_single_to_loop( var_2[2], "s3escape_hallway_end", "s3escape_hallway_end_loop", "s3escape_hallway_door_ender", var_4 );
    var_4 notify( "s3escape_hallway_door_gideon_ender" );
    soundscripts\_snd::snd_message( "aud_stop_headspace_ambience" );
    thread maps\captured::dialogue_guardroom_door( var_9 );
    var_4 thread maps\captured_anim::anim_single_to_loop( level.allies[0], "s3escape_takedown", "s3escape_takedown_loop", "s3escape_takedown_gideon_ender" );
    var_4 thread s3escape_gideon_gun_anim( var_7 );
    var_4 thread maps\_anim::anim_single( var_11, "s3escape_takedown" );
    wait(getanimlength( %cap_s3_escape_takedown_guard_01 ) - 0.05);
    var_9 setanimrate( %cap_s3_escape_takedown_guard_01, 0 );
    level notify( "s3_escape_guard_down" );
    var_4 notify( "s3escape_hallway_door_ender" );
    var_4 thread maps\captured_anim::anim_single_to_loop( level.allies[1], "s3escape_takedown", "s3escape_takedown_loop", "s3escape_takedown_ender" );
    var_4 thread maps\captured_anim::anim_single_to_loop( level.allies[2], "s3escape_takedown", "s3escape_takedown_loop", "s3escape_takedown_ender" );
    var_12 = maps\_utility::spawn_anim_model( "takedown_gun" );
    var_12 hidepart( "tag_rail_master_on" );
    var_4 maps\_anim::anim_first_frame_solo( var_12, "s3escape_takedown" );
    var_12 hide();
    var_13 = common_scripts\utility::getstruct( "s3_escape_get_weapon_marker", "targetname" );
    var_14 = spawn( "script_origin", var_13.origin );
    var_14 makeusable();
    var_14 maps\_utility::addhinttrigger( &"CAPTURED_HINT_TAKE_CONSOLE", &"CAPTURED_HINT_TAKE_PC" );
    maps\captured_actions::s3_escape_gun_action( var_14, var_12 );
    level.player soundscripts\_snd::snd_message( "aud_escape_give_gun_exo" );
    var_14 delete();
    level.player disableweapons();
    var_15 = maps\_utility::spawn_anim_model( "player_rig_noexo" );
    var_15 hide();
    var_16 = [ var_15, var_9 ];
    setsaveddvar( "g_friendlyNameDist", 0 );
    level.player setstance( "stand" );
    level.player allowcrouch( 0 );
    level.player allowjump( 0 );
    level.player allowprone( 0 );
    var_17 = getanimlength( var_15 maps\_utility::getanim( "s3escape_takedown_start" ) );
    thread s3escape_fade_to_black( var_17 );
    var_4 thread s3_escape_player_exo_and_gun_anim( var_16, var_9, var_15, var_12, var_17 );
    level waittill( "s3_escape_player_got_gun" );
    var_4 s3_escape_ally_gun_help_anim( var_7 );
    return var_4;
}

s3_escape_outer_door()
{
    var_0 = common_scripts\utility::getstruct( "struct_scene_s3escape_takedown", "targetname" );
    var_1 = spawn( "script_model", var_0.origin );
    var_1 setmodel( "cpt_hinge_door_rght_01" );
    var_2 = getent( "s3_escape_security_door_col", "targetname" );
    var_2 linkto( var_1, "j_bone_door_right", ( 28, 1.5, 48 ), ( 0, 0, 0 ) );
    var_1.animname = "takedown_door";
    var_1 maps\_anim::setanimtree();
    var_0 maps\_anim::anim_first_frame_solo( var_1, "s3escape_takedown" );
    level waittill( "s3_outer_door_open" );
    var_1 thread soundscripts\_snd::snd_message( "aud_escape_guard_takedown_door" );
    var_0 maps\_anim::anim_single_solo( var_1, "s3escape_takedown" );
}

s3escape_gideon_gun_anim( var_0 )
{
    maps\_anim::anim_single_solo( var_0, "s3escape_takedown" );

    if ( !isremovedentity( var_0 ) )
        var_0 hide();

    level.allies[0] maps\_utility::gun_recall();
    level.allies[0] showallparts();
}

s3_escape_sliding_door_player( var_0, var_1, var_2, var_3 )
{
    var_4 = self;
    var_1 linkto( var_0 );
    var_4 waittill( "s3_escape_open_door" );

    if ( var_2 == "s3escape_takedown" )
        soundscripts\_snd::snd_message( "aud_door", "control_rm", "open" );
    else
        soundscripts\_snd::snd_message( "aud_door", "control_rm_exit", "open" );

    var_4 maps\_anim::anim_single_solo( var_0, var_2 );
    var_4 waittill( "s3_close_sliding_door" );
    soundscripts\_snd::snd_message( "aud_door", "control_rm", "close" );

    if ( isdefined( var_3 ) )
        var_0 moveto( var_0.origin + ( 0, 53, 0 ), 1, 0.25, 0.25 );
    else
        var_0 moveto( var_0.origin - ( 0, 53, 0 ), 1, 0.25, 0.25 );

    common_scripts\utility::flag_wait( "flag_test_chamber_end" );
    var_0 delete();
    var_1 delete();
}

s3_escape_door_notetrack( var_0 )
{
    level notify( "s3_outer_door_open" );
}

s3_escape_player_gun( var_0 )
{
    level notify( "s3_escape_player_got_gun" );
    soundscripts\_snd::snd_music_message( "mus_captured_escape" );
}

s3_escape_controlroom_door_notetrack( var_0 )
{
    soundscripts\_snd::snd_message( "aud_escape_keycard", "control_room" );
    var_1 = common_scripts\utility::getstruct( "struct_scene_s3escape_takedown", "targetname" );
    var_1 notify( "s3_escape_open_door" );
}

s3_escape_player_exo_and_gun_anim( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = self;
    var_5 thread maps\_anim::anim_single( var_0, "s3escape_takedown_start" );
    level.player playerlinktoblend( var_2, "tag_player", 0.5 );
    wait 0.5;
    var_2 show();
    level.player playerlinktodelta( var_2, "tag_player", 0.75, 45, 45, 30, 30, 1 );
    level.player common_scripts\utility::delaycall( 3.5, ::playrumbleonentity, "light_2s" );
    level.player common_scripts\utility::delaycall( 4.25, ::lerpfov, 42, 1 );
    level.player common_scripts\utility::delaycall( 6, ::lerpfov, 65, 3 );
    wait(var_4 - 0.5);
    var_2 delete();
    var_2 = maps\_utility::spawn_anim_model( "player_rig" );
    level.player playerlinktodelta( var_2, "tag_player", 1, 0, 0, 0, 0, 1 );
    var_1 delete();
    var_6 = getent( "s3escape_noexo_guard", "targetname" );
    var_1 = maps\_utility::dronespawn_bodyonly( var_6 );
    var_1.animname = "guard_1";
    var_1 maps\captured_util::ignore_everything();
    var_1.diequietly = 1;
    var_1 maps\_utility::clear_deathanim();
    var_1.noragdoll = 1;
    var_1 maps\_utility::gun_remove();
    var_1.no_ai = 1;
    var_1.allowpain = 0;
    var_1.skipdeathanim = 1;
    var_1.dont_break_anim = 1;
    var_5 thread maps\_anim::anim_last_frame_solo( var_1, "s3escape_takedown_start" );
    var_7 = [ var_3, var_2 ];
    var_3 show();
    var_5 thread maps\_anim::anim_single( var_7, "s3escape_takedown" );
    var_8 = getanimlength( var_2 maps\_utility::getanim( "s3escape_takedown" ) );
    var_5 notify( "s3escape_takedown_gideon_ender" );
    wait(var_8);
    maps\_player_exo::player_exo_activate();
    level notify( "s3_escape_player_helped" );
    level.player unlink();
    var_2 delete();
    var_3 delete();
    level.player takeallweapons();
    level.player enableweapons();
    level.player giveweapon( "iw5_titan45onearmgundown_sp" );
    level.player setweaponammostock( "iw5_titan45onearmgundown_sp", 0 );
    level.player switchtoweapon( "iw5_titan45onearmgundown_sp" );
    level.player allowmelee( 0 );
    level.player allowfire( 0 );
    level.player allowcrouch( 1 );
    level.player allowjump( 1 );
    level.player allowprone( 1 );
    common_scripts\utility::flag_wait( "escape_guards_dead" );
    var_1 delete();
}

s3_escape_ally_gun_help_anim( var_0 )
{
    var_1 = self;
    var_0 show();
    level.allies[0] maps\_utility::gun_remove();
    var_2 = [ level.allies[0], var_0 ];
    var_3 = getanimlength( level.allies[0] maps\_utility::getanim( "s3escape_takedown_gun_help" ) );
    var_1 maps\_anim::anim_single( var_2, "s3escape_takedown_gun_help" );
    var_0 delete();
    level.allies[0] maps\_utility::gun_recall();
    level.allies[0] showallparts();
}

s3_splitup_event( var_0 )
{
    var_1 = common_scripts\utility::getstruct( "struct_scene_s3escape_security", "targetname" );
    var_2 = level.allies;
    var_3 = getent( "s3_escape_pickup_gun", "targetname" );
    var_3 hide();
    var_4 = getent( "s3_escape_security_door_blocker", "targetname" );
    var_4 notsolid();
    var_5 = getent( "controlroom_exit_door", "targetname" );
    var_5.animname = "controlroom_exit_door";
    var_5 maps\_anim::setanimtree();
    var_6 = getent( "s3_escape_controlroom_exit_col", "targetname" );
    var_1 maps\_anim::anim_first_frame_solo( var_5, "s3escape_controlroom_exit" );
    var_1 thread s3_escape_sliding_door_player( var_5, var_6, "s3escape_controlroom_exit", 1 );
    thread maps\_utility::autosave_now();
    thread s3escape_console_setup();
    var_1 thread maps\captured_anim::anim_single_to_loop( var_2[0], "s3escape_controlroom", "s3escape_controlroom_loop", "s3escape_control_room_ender" );
    common_scripts\utility::flag_wait( "s3_escape_entered_security_center" );
    level.player disableweaponpickup();
    var_0 notify( "s3escape_takedown_ender" );
    var_1 thread maps\captured_anim::anim_single_to_loop( var_2[1], "s3escape_controlroom", "s3escape_controlroom_loop", "s3escape_control_room_ender" );
    var_1 thread maps\captured_anim::anim_single_to_loop( var_2[2], "s3escape_controlroom", "s3escape_controlroom_loop", "s3escape_control_room_ender" );
    common_scripts\utility::flag_wait( "s3_escape_hurry_up_move_done" );
    var_7 = getent( "s3_escape_security_console_trigger", "targetname" );
    var_7 maps\_utility::addhinttrigger( &"CAPTURED_HINT_USE_CONSOLE", &"CAPTURED_HINT_USE_PC" );
    var_8 = common_scripts\utility::getstruct( "s3_escape_console_use_marker", "targetname" );
    maps\captured_actions::s3_escape_hack_action( var_7, var_8 );
    level.player setstance( "stand" );
    level.player allowcrouch( 0 );
    level.player allowjump( 0 );
    level.player allowprone( 0 );
    level.player freezecontrols( 1 );
    maps\_player_exo::player_exo_deactivate();
    level notify( "started_door_hacking" );
    var_7 delete();
    soundscripts\_snd::snd_message( "aud_separation_logic" );
    var_9 = maps\_utility::spawn_anim_model( "player_rig" );
    var_9 hide();
    level.player disableweapons();
    var_10 = spawn( "script_model", level.player.origin );
    var_10 setmodel( "vm_titan45_nocamo" );
    var_10 linkto( var_9, "tag_weapon_right", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_1 thread maps\_anim::anim_single_solo( var_9, "s3escape_console_start" );
    thread s3escape_console_cinematic_watcher();
    common_scripts\utility::flag_set( "s3_escape_console_monitor_unfreeze" );
    level.s3_escape_console_monitor setscriptablepartstate( 0, 2 );
    level.player playerlinktoblend( var_9, "tag_player", 0.5 );
    wait 0.5;
    level.player freezecontrols( 0 );
    var_9 show();
    level.player playerlinktodelta( var_9, "tag_player", 1, 0, 0, 0, 0, 1 );
    wait(getanimlength( var_9 maps\_utility::getanim( "s3escape_console_start" ) ) - 0.5);
    var_1 thread maps\_anim::anim_loop_solo( var_9, "s3escape_console_loop", "s3escape_console_ender" );
    level waittill( "s3_escape_guards_entering_room" );
    soundscripts\_snd::snd_music_message( "mus_captured_escape_end" );
    var_11 = getentarray( "s3_escape_main_room_guards", "targetname" );
    var_12 = maps\_utility::array_spawn( var_11 );
    var_12[0].animname = "guard_2";
    var_12[1].animname = "guard_3";
    thread maps\captured::dialogue_control_room_attack( var_12[0], var_12[1] );
    common_scripts\utility::array_thread( var_12, maps\captured_util::ignore_everything );
    var_13 = getent( "s3_escape_security_guard_door", "targetname" );
    var_13.animname = "controlroom_guard_door";
    var_13 maps\_utility::assign_animtree();
    var_1 notify( "s3escape_control_room_ender" );
    var_1 thread maps\captured_anim::anim_single_to_loop( level.allies[1], "s3escape_controlroom_attack", "s3escape_controlroom_attack_loop", "s3escape_control_room_attack_ender" );
    var_1 thread maps\captured_anim::anim_single_to_loop( level.allies[2], "s3escape_controlroom_attack", "s3escape_controlroom_attack_loop", "s3escape_control_room_attack_ender" );
    var_1 thread maps\_anim::anim_single_solo( var_13, "s3escape_controlroom_attack" );
    var_1 thread maps\_anim::anim_single( var_12, "s3escape_controlroom_attack" );
    thread s3_escape_elevator_movement();
    var_1 thread maps\_anim::anim_single_solo( level.allies[0], "s3escape_controlroom_attack" );
    var_14 = getnode( "s3_escape_ally_attack_node", "targetname" );
    level.allies[0] setgoalnode( var_14 );
    wait 3.0;
    level notify( "finished_door_hacking" );
    common_scripts\utility::flag_set( "s3_escape_exit_door_open" );
    thread maps\captured_actions::s3_escape_console_gun_action( var_1, var_9, var_10 );
    var_0 notify( "s3_close_sliding_door" );
    var_4 solid();
    level.player maps\_utility::wait_for_notify_or_timeout( "captured_action_complete", 3 );
    waitframe();

    if ( !common_scripts\utility::flag( "s3_player_pickedup_console_gun" ) )
    {
        var_1 notify( "s3escape_console_ender" );
        level.player unlink();
        var_9 delete();
        level.player thread maps\captured_util::start_one_handed_gunplay( "iw5_kvahazmatknifeonearm_sp" );
        level.player switchtoweaponimmediate( "iw5_kvahazmatknifeonearm_sp" );
        var_10 delete();
        setsaveddvar( "ammoCounterHide", "0" );
        var_3 show();
        level.player maps\_utility::lerp_player_view_to_position( ( 4709.12, -10660.2, -1760 ), level.player.angles, 0.9, 0.5 );
        level.player allowfire( 1 );
        level.player showviewmodel();
        level.player allowmelee( 1 );
        level.player allowsprint( 1 );
        level.player allowcrouch( 1 );
        level.player allowjump( 1 );
        level.player allowprone( 1 );
        level.player enableoffhandweapons();
        maps\_player_exo::player_exo_activate();
        wait 0.3;
    }
    else
    {
        level.player enableoffhandweapons();
        maps\_player_exo::player_exo_activate();
        wait 1.6;
    }

    setsaveddvar( "ammoCounterHide", "0" );
    common_scripts\utility::flag_set( "s3_player_pickedup_console_gun" );
    level.allies[0] unlink();
    level.allies[0].ignoreall = 0;
    level.allies[0].ignoreme = 0;
    level.allies[0].dontmelee = 1;
    common_scripts\utility::array_thread( var_12, maps\captured_util::unignore_everything );
    common_scripts\utility::array_thread( var_12, maps\_utility::anim_stopanimscripted );
    maps\_utility::kill_deathflag( "escape_guards_dead", 2.5 );
    wait 1.0;
    common_scripts\utility::flag_wait( "escape_guards_dead" );
    level.allies[0] maps\captured_util::ignore_everything();
    var_15 = getent( "s3_escape_large_security_door", "targetname" );
    var_15 moveto( var_15.origin - ( 0, 0, 112 ), 1, 0.2, 0.05 );
    soundscripts\_snd::snd_message( "aud_separation_door" );
    soundscripts\_snd::snd_message( "start_indoor_alarms" );
    maps\captured_util::physics_bodies_off();
    thread maps\captured_util::physics_bodies_on( "escape_bodies_2", 5, 1 );
    common_scripts\utility::flag_set( "flag_s3guard_security_door_shuts" );
    level.allies[0].dontmelee = 0;
    var_1 notify( "s3escape_control_room_attack_ender" );
    thread maps\captured_medical::test_chamber_stairs_up_door();
    thread s3_body_movement();
    var_2 = common_scripts\utility::array_remove( var_2, level.allies[0] );
    level notify( "split_scene_start" );
    var_1 notify( "s3escape_controlroom_attack_loop" );
    var_1 thread maps\_anim::anim_single( var_2, "s3escape_controlroom_exit" );
    var_1 thread maps\_anim::anim_single_solo( level.allies[0], "s3escape_controlroom_exit" );
    var_1 waittill( "s3_escape_open_door" );
    thread maps\_utility::autosave_now();
    thread s3escape_console_pause_checkpoint();
    var_16 = getentarray( "s3escape_hall_enemies", "targetname" );
    var_17 = maps\_utility::array_spawn( var_16, 1 );
    var_18 = getent( "s3escape_enemy_goal_volume_1", "targetname" );

    foreach ( var_20 in var_17 )
        var_20 thread s3_escape_guard_function();

    thread maps\_utility::battlechatter_on( "allies" );
    thread maps\_utility::battlechatter_on( "axis" );
    wait 2.0;
    level.allies[0] stopanimscripted();
    level.allies[0].goalradius = 8;
    var_22 = getnodearray( "s3escape_ally_cover_nodes", "targetname" );
    var_23 = randomintrange( 0, 1 );
    level.allies[0] setgoalnode( var_22[var_23] );
    level.allies[0] maps\_utility::set_force_cover( 1 );
    level.allies[0] waittill( "goal" );
    level.allies[0] maps\captured_util::unignore_everything();
    common_scripts\utility::flag_wait_either( "flag_s3escape_exit", "s3escape_hall_enemies_dead" );
    var_24 = getent( "s3escape_enemy_goal_volume_2", "targetname" );

    foreach ( var_20 in var_17 )
    {
        if ( isalive( var_20 ) )
            var_20 setgoalvolumeauto( var_24 );
    }

    level.allies[0] maps\_utility::set_force_cover( 0 );
    common_scripts\utility::flag_wait( "s3escape_hall_enemies_dead" );
    level.allies[0] maps\captured_util::ignore_everything();
    thread maps\_utility::battlechatter_off( "allies" );
    thread maps\_utility::battlechatter_off( "axis" );
    level.allies[0].goalradius = 24;
    var_1 maps\_anim::anim_reach_and_idle_solo( level.allies[0], "s3escape_controlroom_exit_loop", "s3escape_controlroom_exit_loop", "s3escape_controlroom_exit_loop_enter" );
    common_scripts\utility::flag_wait( "flag_s3escape_end" );
    maps\_utility::autosave_by_name( "s3escape_end" );
    wait 1.0;
    var_1 notify( "s3escape_controlroom_exit_loop_enter" );
}

s3_escape_elevator_movement()
{
    wait 2.0;
    soundscripts\_snd::snd_message( "aud_separation_elevator" );
    var_0 = getentarray( "s3_escape_elevator", "targetname" );
    var_1 = undefined;
    wait 0.5;
    var_2 = getent( "s3_escape_door_left", "targetname" );
    var_2 moveto( var_2.origin + ( 52, 0, 0 ), 0.75, 0.2, 0.05 );
    var_3 = getent( "s3_escape_door_right", "targetname" );
    var_3 moveto( var_3.origin + ( -52, 0, 0 ), 0.75, 0.2, 0.05 );

    foreach ( var_5 in var_0 )
    {
        if ( var_5.classname == "script_brushmodel" )
            var_1 = var_5;
    }

    foreach ( var_5 in var_0 )
    {
        if ( var_5.classname == "script_model" )
            var_5 linkto( var_1 );
    }

    var_1 moveto( var_1.origin + ( 0, 0, -150 ), 1.5, 0.2, 0.2 );
    level waittill( "split_scene_start" );
    wait 15.0;
    var_2 moveto( var_2.origin + ( -52, 0, 0 ), 0.75, 0.2, 0.05 );
    var_3 moveto( var_3.origin + ( 52, 0, 0 ), 0.75, 0.2, 0.05 );
}

s3_escape_guards_enter( var_0 )
{
    level notify( "s3_escape_guards_entering_room" );
}

s3_escape_elevator_start( var_0 )
{

}

s3_escape_controlroom_exit_door_notetrack( var_0 )
{
    var_1 = common_scripts\utility::getstruct( "struct_scene_s3escape_security", "targetname" );
    var_1 notify( "s3_escape_open_door" );
}

s3_escape_controlroom_exit_door_swipe_sfx_notetrack( var_0 )
{
    soundscripts\_snd::snd_message( "aud_escape_keycard", "exit_door" );
}

s3_body_movement()
{
    wait 15.0;
    var_0 = level.hanging_bodies;

    foreach ( var_2 in var_0 )
        var_2 moveto( var_2.origin - ( 0, 160, 0 ), 4, 0.05, 0.05 );
}

s3_escape_guard_function()
{
    self endon( "death" );
    maps\captured_util::ignore_everything();
    self.goalradius = 16;
    self waittill( "goal" );
    maps\captured_util::unignore_everything();
}

s3escape_fade_to_black( var_0 )
{
    var_1 = newclienthudelem( level.player );
    var_1 setshader( "black", 1280, 720 );
    var_1.horzalign = "fullscreen";
    var_1.vertalign = "fullscreen";
    var_1.alpha = 0;
    var_1.foreground = 0;
    var_1 fadeovertime( 2 );
    var_1.alpha = 1;
    wait(var_0);
    var_1 fadeovertime( 3.5 );
    var_1.alpha = 0;
    wait 3.5;
    var_1 destroy();
    var_1 = undefined;
}

slow_player_scaler()
{
    level.player allowsprint( 0 );
    level.player allowjump( 0 );
    soundscripts\_snd::snd_message( "aud_limp_on" );
    level.player maps\_utility::blend_movespeedscale( 0.27 );
    wait 0.5;
    common_scripts\utility::flag_wait( "flag_scene_doctor_done" );
    level.player maps\_utility::blend_movespeedscale( 0.5, 5 );
    wait 8.0;
    level.player allowjump( 1 );
}

injured_player_wobble()
{
    self endon( "start_sprint_wobble" );
    var_0 = common_scripts\utility::spawn_tag_origin();
    var_0.angles = ( 0, 0, 0 );
    self playersetgroundreferenceent( var_0 );
    var_1 = 6;
    var_2 = var_0.angles;

    while ( !common_scripts\utility::flag( "flag_scene_doctor_done" ) )
    {
        common_scripts\utility::flag_wait( "flag_injured_player_active" );
        wait(randomfloatrange( 3, 5 ));
        var_3 = randomfloatrange( 3, 5 );
        var_4 = randomfloatrange( 0, var_3 );
        var_5 = var_3 - var_4;
        var_0 rotateto( ( var_2[0] + randomfloatrange( var_1 * -1, var_1 ), var_2[1] + randomfloatrange( var_1 * -1, var_1 ), var_2[2] + randomfloatrange( var_1 * -1, var_1 ) ), var_3, var_4, var_5 );
        wait(var_3);
        var_3 = randomfloatrange( 3, 5 );
        var_4 = randomfloatrange( 0, var_3 );
        var_5 = var_3 - var_4;
        var_0 rotateto( var_2, var_3, var_4, var_5 );
        wait(var_3);
    }

    self playersetgroundreferenceent( undefined );
    var_0 delete();
}

injured_player_blur()
{
    self endon( "start_sprint_wobble" );

    while ( !common_scripts\utility::flag( "flag_scene_doctor_done" ) )
    {
        common_scripts\utility::flag_wait( "flag_injured_player_active" );
        var_0 = randomfloatrange( 1, 2 );
        setblur( randomfloatrange( 1, 3 ), var_0 );
        wait(var_0);
        setblur( 0, var_0 );
        wait(var_0);
        wait(randomfloatrange( 3, 5 ));
    }
}
