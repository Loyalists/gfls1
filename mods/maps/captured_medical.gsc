// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

pre_load()
{
    precachemodel( "vm_kvaHasmatKnifeDown" );
}

post_load()
{
    setthreatbias( "allies", "playerseek", -1024 );
    setthreatbias( "playerseek", "allies", -1024 );
    setthreatbias( "playerseek", "player", 512 );
    common_scripts\utility::flag_init( "flag_tc_approach" );
    common_scripts\utility::flag_init( "flag_tc_move_down" );
    common_scripts\utility::flag_init( "flag_tc_gideon_at_door" );
    common_scripts\utility::flag_init( "gps_ah_combat_start" );
    common_scripts\utility::flag_init( "gps_ah_open_morgue" );
    common_scripts\utility::flag_init( "gps_ah_in_morgue" );
    common_scripts\utility::flag_init( "flag_ah_combat_start" );
    common_scripts\utility::flag_init( "flag_ah_ai_blocker" );
    common_scripts\utility::flag_init( "flag_ah_combat_hall" );
    common_scripts\utility::flag_init( "flag_ah_combat_front" );
    common_scripts\utility::flag_init( "flag_ah_combat_goto_mid" );
    common_scripts\utility::flag_init( "flag_ah_combat_mid" );
    common_scripts\utility::flag_init( "flag_ah_combat_back" );
    common_scripts\utility::flag_init( "flag_ah_combat_near_done" );
    common_scripts\utility::flag_init( "flag_ah_combat_done" );
    common_scripts\utility::flag_init( "flag_ah_ready_to_leave" );
    common_scripts\utility::flag_init( "flag_spawning_autopsy_techs" );
    common_scripts\utility::flag_init( "flag_autopsy_enter" );
    common_scripts\utility::flag_init( "flag_autopsy_doctor_door" );
    common_scripts\utility::flag_init( "flag_autopsy_chute" );
    common_scripts\utility::flag_init( "flag_autopsy_gideon_at_door" );
    common_scripts\utility::flag_init( "flag_autopsy_doctor_scene_start" );
    common_scripts\utility::flag_init( "flag_autopsy_safe_to_open_door" );
    common_scripts\utility::flag_init( "flag_autopsy_start_fail" );

    if ( isdefined( common_scripts\utility::getstruct( "struct_playerstart_autopsy", "targetname" ) ) )
    {
        thread setup_spawners();
        thread ah_init_track_doors();
        level.tcah_doors = [];
        level.tcah_doors = [ maps\_utility::spawn_anim_model( "tcah_door_l" ), maps\_utility::spawn_anim_model( "tcah_door_r" ) ];
        level.tcah_node = common_scripts\utility::getstruct( "anim_tc_chamber", "targetname" );
        level.tcah_node maps\_anim::anim_first_frame( level.tcah_doors, "tc_enter_test_exit_door" );
        getent( "tcah_door_l_link", "targetname" ) linkto( level.tcah_doors[0], "j_bone_door_left" );
        getent( "tcah_door_r_link", "targetname" ) linkto( level.tcah_doors[1], "j_bone_door_right" );
    }
    else
        iprintln( "Warning: Autopsy start point missing.  Compiled out?" );
}

start_test_chamber()
{
    thread maps\_utility::battlechatter_off( "allies" );
    thread maps\_utility::battlechatter_off( "axis" );
    maps\captured_util::warp_allies( "struct_allystart_test_chamber" );
    level.player maps\captured_util::warp_to_start( "struct_playerstart_test_chamber" );
    level.player thread maps\captured_util::start_one_handed_gunplay( "iw5_sn6pickup_sp_xmags" );
    maps\_player_exo::player_exo_activate();
    thread test_chamber_stairs_up_door();
    soundscripts\_snd::snd_message( "start_test_chamber" );
}

main_test_chamber()
{
    getscriptablearray( "s3_escape_console_monitor", "targetname" )[0] setscriptablepartstate( 0, 3 );
    setsaveddvar( "cg_cinematicfullscreen", "0" );
    cinematicingameloop( "captured_manticore_display", 1.0, 1 );

    if ( level.allies.size > 1 )
    {
        for ( var_0 = level.allies.size - 1; var_0 > 0; var_0-- )
        {
            level.allies[var_0] maps\_utility::stop_magic_bullet_shield();
            level.allies[var_0] delete();
        }
    }

    var_1 = getentarray( "tc_manticore_doors", "targetname" );

    foreach ( var_3 in var_1 )
    {
        var_3.door_tag = common_scripts\utility::spawn_tag_origin();
        var_3.door_tag.origin = var_3.origin;
        var_3.door_tag.angles = var_3.angles;
        var_3.door_tag.script_noteworthy = "aut_cleanup";
        var_3.animname = "controlroom_entrance_door";
        var_3 maps\_utility::assign_animtree();
        var_3.script_noteworthy = "aut_cleanup";
        var_3.door_tag thread maps\_anim::anim_first_frame_solo( var_3, "s3escape_takedown" );
    }

    var_5 = getent( "test_chamber_door_a_clip", "targetname" );
    var_5 notsolid();
    thread tc_side_door_movement();
    level.player thread maps\_utility::blend_movespeedscale( 0.5 );
    var_6 = common_scripts\utility::getstruct( "anim_tc_observation", "targetname" );
    var_7 = [ maps\_utility::spawn_targetname( "opfor_tc_observation_scientist_1" ), maps\_utility::spawn_targetname( "opfor_tc_observation_scientist_2" ) ];
    var_8 = [ maps\_utility::spawn_targetname( "opfor_tc_observation_scientist_3" ), maps\_utility::spawn_targetname( "opfor_tc_observation_scientist_4" ) ];
    var_7[0].animname = "scientist_1";
    var_7[1].animname = "scientist_2";
    var_8[0].animname = "scientist_3";
    var_8[1].animname = "scientist_4";
    var_7[0] thread observation_room_scientist_anims( var_7, 1 );
    var_7[1] thread observation_room_scientist_anims( var_7, 2 );
    var_8[0] thread observation_room_scientist_setup( 3 );
    var_8[1] thread observation_room_scientist_setup( 4 );
    var_9 = common_scripts\utility::getstruct( "struct_scene_test_chamber_manticore", "targetname" );
    var_9 maps\_anim::anim_first_frame( var_8, "tc_manticore_start" );
    level.ally maps\_utility::disable_ai_color();
    var_10 = common_scripts\utility::getstruct( "anim_tc_stairs", "targetname" );
    var_10 thread tc_manticore_ally_traverse();
    common_scripts\utility::flag_wait( "flag_tc_player_can_see_manticore" );
    var_11 = common_scripts\utility::getstruct( "struct_scene_s3escape_security", "targetname" );
    var_11 notify( "s3_close_sliding_door" );
    thread maps\captured_util::physics_bodies_on( "test_chamber_bodies_1", 0 );
    thread maps\captured_util::physics_bodies_on( "test_chamber_bodies_2", 0 );
    var_9 thread maps\captured_anim::anim_single_to_loop( var_8, "tc_manticore_start", "tc_manticore_loop", "tc_manticore_ender" );
    common_scripts\utility::flag_wait( "flag_tc_gideon_at_door" );
    var_12 = getnode( "tc_ally_exit_manticore_node", "targetname" );
    level.ally.goalradius = 16;
    level.ally setgoalnode( var_12 );
    common_scripts\utility::flag_wait( "flag_tc_player_can_see_manticore" );
    thread maps\_utility::battlechatter_on( "allies" );
    thread maps\_utility::battlechatter_on( "axis" );
    wait 1.0;
    var_13 = getentarray( "med_observation_enemies", "targetname" );
    var_14 = maps\_utility::array_spawn( var_13, 1 );
    soundscripts\_snd::snd_message( "aud_door", "test_chamber" );

    foreach ( var_3 in var_1 )
        var_3.door_tag thread maps\_anim::anim_single_solo( var_3, "s3escape_takedown" );

    wait 1.0;
    var_17 = getent( "tc_manticore_doors_col", "targetname" );
    var_17 connectpaths();
    var_17 delete();
    level notify( "start_anim_tc_melee" );
    level.allies[0] maps\captured_util::unignore_everything();
    common_scripts\utility::flag_wait( "flag_med_observation_enemies" );
    thread maps\_utility::battlechatter_off( "allies" );
    thread maps\_utility::battlechatter_off( "axis" );
    maps\_utility::autosave_by_name( "observation" );
    common_scripts\utility::flag_wait( "flag_tc_approach" );
    level notify( "start_anim_tc_approach" );
    var_18 = getnode( "tc_ally_enter_observation_node", "targetname" );
    level.ally.goalradius = 16;
    level.ally setgoalnode( var_18 );
    var_10 notify( "ally_keep_moving" );
    common_scripts\utility::flag_wait( "flag_tc_move_to_door" );
    var_19 = common_scripts\utility::getstruct( "anim_tc_chamber", "targetname" );
    var_19 maps\_anim::anim_reach_solo( level.ally, "tc_observation" );
    var_19 maps\_anim::anim_single_solo( level.ally, "tc_observation" );

    if ( !common_scripts\utility::flag( "flag_tc_move_down" ) )
    {
        var_19 maps\_anim::anim_reach_solo( level.ally, "tc_observation_loop" );
        var_19 thread maps\_anim::anim_loop_solo( level.ally, "tc_observation_loop", "tc_observation_loop_ender" );
    }
    else
        level.tcah_node maps\_anim::anim_reach_solo( level.ally, "tc_exit_stairs" );

    common_scripts\utility::flag_wait( "flag_tc_move_down" );
    soundscripts\_snd::snd_message( "aud_door", "test_chamber_exit", "open" );
    var_20 = getent( "tc_exit_stairs_door", "targetname" );
    var_21 = getent( var_20.target, "targetname" );
    var_21 linkto( var_20 );
    var_20 moveto( var_20.origin + ( 52, 0, 0 ), 1, 0.25, 0.5 );
    level notify( "start_anim_tc_exit_stairs" );
    var_19 notify( "tc_observation_loop_ender" );
    thread tc_door_to_stairs_closer( var_20 );

    if ( level.currentgen )
        thread tc_ai_clip_blocker();

    level.tcah_node maps\_anim::anim_single_solo( level.ally, "tc_exit_stairs" );

    if ( !common_scripts\utility::flag( "flag_tc_chamber_enter" ) )
        level.tcah_node thread maps\_anim::anim_loop_solo( level.ally, "tc_exit_door_loop", "ally_keep_moving" );

    level notify( "start_anim_tc_exit_door_loop" );
    common_scripts\utility::flag_wait( "flag_tc_chamber_enter" );
    soundscripts\_snd::snd_message( "aud_zap_scene" );
    level notify( "start_anim_tc_enter_test" );
    level.tcah_node notify( "ally_keep_moving" );
    maps\_utility::delaythread( 2.0, ::tc_uv_rumble );
    var_5 solid();
    var_22 = getent( "test_chamber_door_a_rt", "targetname" );
    var_23 = getent( "test_chamber_door_a_lt", "targetname" );
    var_23 movex( 29, 0.3 );
    var_22 movex( -29, 0.3 );
    stopcinematicingame();
    var_8 = maps\_utility::array_removedead( var_8 );
    maps\_utility::array_delete( var_8 );
    maps\captured_util::physics_bodies_off();
    var_24 = getentarray( "physics_chair_cleanup", "script_noteworthy" );
    maps\_utility::array_delete( var_24 );
    thread maps\captured_util::physics_bodies_on( "test_chamber_bodies_1", 5 );
    thread maps\captured_util::physics_bodies_on( "test_chamber_bodies_2", 5 );
    var_25 = getent( "test_chamber_door_b", "targetname" );
    var_26 = getent( "test_chamber_door_b_collision", "targetname" );
    var_26 linkto( var_25 );
    var_25 common_scripts\utility::delaycall( 6, ::movex, -55, 0.3 );

    if ( level.currentgen )
    {
        if ( !istransientloaded( "captured_autopsy_halls_tr" ) )
            level waittill( "tff_post_load_autopsy_halls" );
    }

    level notify( "start_anim_tc_enter_test" );
    thread test_chamber_body_pushes();
    level.tcah_node maps\_anim::anim_single_solo( level.ally, "tc_enter_test" );
    level notify( "end_anim_tc_enter_test" );
    level.tcah_node thread maps\_anim::anim_loop_solo( level.ally, "tc_enter_test_loop", "tc_enter_test_loop_ender" );
    common_scripts\utility::flag_wait( "flag_test_chamber_end" );
}

tc_uv_rumble()
{
    var_0 = level.player maps\_utility::get_rumble_ent( "steady_rumble" );
    var_0 maps\_utility::set_rumble_intensity( 0.01 );
    var_0 maps\_utility::rumble_ramp_to( 1, 2.1 );
    var_0 stoprumble( "steady_rumble" );
}

tc_ai_clip_blocker()
{
    var_0 = getent( "ah_ai_clip_blocker_test_chamber", "targetname" );
    var_0 notsolid();
    var_0 connectpaths();
    common_scripts\utility::flag_wait( "flag_ah_ai_blocker" );
    var_0 solid();
    var_0 disconnectpaths();
}

tc_door_to_stairs_closer( var_0 )
{
    maps\_utility::wait_for_targetname_trigger( "tc_player_on_stairs_to_tc" );
    level notify( "tc_stairs_down" );
    soundscripts\_snd::snd_message( "aud_door", "test_chamber_exit", "close" );
    var_0 moveto( var_0.origin - ( 52, 0, 0 ), 1.25, 0.2, 0.5 );
}

test_chamber_stairs_up_door()
{
    var_0 = common_scripts\utility::getstruct( "anim_tc_stairs", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "tc_stairs_door_1" );
    var_2 = maps\_utility::spawn_anim_model( "tc_stairs_door_2" );
    var_3 = getent( "door_tc_stairs_01", "targetname" );
    var_3 linkto( var_1, "j_bone_door_left", ( -28, 0, 48 ), ( 0, 90, 0 ) );
    var_4 = [ var_1, var_2 ];
    var_0 maps\_anim::anim_first_frame( var_4, "tc_stairs" );
    level waittill( "tc_stair_door_1" );
    var_0 thread maps\_anim::anim_single( var_4, "tc_stairs" );

    if ( level.currentgen )
    {
        if ( !istransientloaded( "captured_test_chamber_tr" ) )
        {
            level waittill( "tff_pre_escape_to_test_chamber" );
            soundscripts\_snd::snd_message( "aud_door", "test_chamber_stairwell", "close" );
            var_0 maps\_anim::anim_first_frame( var_4, "tc_stairs" );
        }
    }

    level waittill( "start_anim_tc_enter_test" );
    maps\_utility::array_delete( var_4 );
}

test_chamber_stairs_up_door_notetrack( var_0 )
{
    level notify( "tc_stair_door_1" );
}

test_chamber_stairs_up_door_swipe_sfx_notetrack( var_0 )
{
    soundscripts\_snd::snd_message( "aud_escape_keycard", "tc_stairs_door" );
}

computer_door_entry_sfx_notetrack( var_0 )
{
    soundscripts\_snd::snd_message( "aud_morgue_computer_door_entry_sfx" );
}

tc_manticore_ally_traverse()
{
    var_0 = self;
    var_1 = getnode( "tc_ally_exit_manticore_node", "targetname" );
    level.ally.goalradius = 16;
    level.ally setgoalnode( var_1 );
    var_0 maps\_anim::anim_single_solo( level.ally, "tc_stairs" );
    var_0 = common_scripts\utility::getstruct( "anim_tc_observation", "targetname" );

    if ( !common_scripts\utility::flag( "flag_tc_player_can_see_manticore" ) )
        var_0 thread maps\_anim::anim_loop_solo( level.ally, "tc_landing_loop", "tc_hall_ender" );

    common_scripts\utility::flag_wait( "flag_tc_player_can_see_manticore" );
    var_0 = common_scripts\utility::getstruct( "anim_tc_observation", "targetname" );
    level.ally.goalradius = 16;
    var_0 notify( "tc_hall_ender" );
    level notify( "manticore_hall_vo" );
    var_0 maps\_anim::anim_single_solo( level.ally, "tc_hall" );
    common_scripts\utility::flag_set( "flag_tc_gideon_at_door" );
}

tc_side_door_movement()
{
    var_0 = getentarray( "tc_side_doors", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = getentarray( var_2.target, "targetname" );
        common_scripts\utility::array_call( var_3, ::linkto, var_2 );
    }

    while ( !common_scripts\utility::flag( "flag_test_chamber_end" ) )
    {
        common_scripts\utility::flag_wait( "flag_tc_side_door_open" );
        soundscripts\_snd::snd_message( "aud_door", "test_chamber_side", "open" );
        var_0[0] moveto( var_0[0].origin + ( 0, 50, 0 ), 1.25, 0.2, 0.5 );
        var_0[1] moveto( var_0[1].origin - ( 0, 50, 0 ), 1.25, 0.2, 0.5 );
        wait 1.5;

        while ( common_scripts\utility::flag( "flag_tc_side_door_open" ) )
            wait 0.05;

        soundscripts\_snd::snd_message( "aud_door", "test_chamber_side", "close" );
        var_0[0] moveto( var_0[0].origin - ( 0, 50, 0 ), 1.25, 0.2, 0.5 );
        var_0[1] moveto( var_0[1].origin + ( 0, 50, 0 ), 1.25, 0.2, 0.5 );
        wait 1.5;
    }
}

test_chamber_body_pushes()
{
    wait 16.36;
    var_0 = level.ally gettagorigin( "tag_flash" );
    physicsexplosionsphere( var_0, 30, 30, 0.3 );
    wait 1.9;
    var_1 = level.ally gettagorigin( "tag_stowed_back" );
    physicsexplosionsphere( var_1, 25, 25, 0.3 );
}

test_chamber_exit_door( var_0 )
{
    wait 1.0;
    var_1 = tc_setup_door( "tc_exit_door" );
    var_1 rotateyaw( 100, 1.0, 0.25, 0.25 );
}

test_chamber_exit_door_notetrack( var_0 )
{
    level notify( "tc_exit_door" );
}

observation_room_scientist_anims( var_0, var_1 )
{
    self endon( "death" );
    maps\_utility::set_ignoreall( 1 );
    maps\_utility::set_ignoreme( 1 );
    self.grenadeammo = 0;
    maps\_utility::disable_pain();
    maps\_utility::magic_bullet_shield( 1 );
    self.no_friendly_fire_penalty = 1;
    self.ignoresonicaoe = 1;
    self pushplayer( 1 );
    maps\_utility::set_deathanim( "tc_scientist_" + var_1 + "_death" );
    var_2 = "observation_room_scientist_node_" + var_1;
    var_3 = common_scripts\utility::getstruct( var_2, "targetname" );
    var_4 = maps\_utility::spawn_anim_model( "observation_chair_" + var_1 );
    thread observation_room_scientist_death( var_3, var_1, var_4 );
    var_5 = [ self, var_4 ];
    var_3 maps\_anim::anim_first_frame( var_5, "tc_melee" );
    level waittill( "start_anim_tc_melee" );
    var_3 maps\_anim::anim_single( var_5, "tc_melee" );
    var_3 maps\_anim::anim_loop( var_5, "tc_scientist_" + var_1 + "_loop", "observation_room_scientist_endloop" );
    common_scripts\utility::flag_wait( "flag_tc_chamber_enter" );
    var_3 notify( "observation_room_scientist_endloop" );
    var_0 = common_scripts\utility::array_removeundefined( var_0 );

    if ( var_0.size > 0 )
    {
        common_scripts\utility::array_thread( var_0, maps\_utility::anim_stopanimscripted );
        common_scripts\utility::array_call( var_0, ::delete );
    }

    var_4 delete();
}

observation_room_scientist_death( var_0, var_1, var_2 )
{
    level endon( "tc_stairs_down" );
    self waittill( "damage", var_3, var_4 );
    var_0 notify( "observation_room_scientist_endloop" );
    var_5 = [ self, var_2 ];
    var_6 = "tc_scientist_" + var_1 + "_death";

    if ( var_4 == level.player )
    {
        if ( !level.missionfailed )
        {
            setdvar( "ui_deadquote", &"CAPTURED_FAIL_INNOCENT" );
            thread maps\_utility::missionfailedwrapper();
        }
    }

    var_0 thread maps\_anim::anim_single( var_5, var_6 );
    var_7 = getanimlength( maps\_utility::getanim( var_6 ) );
    wait(var_7 - 0.05);
    self setanimrate( maps\_utility::getanim( var_6 ), 0 );
    var_2 setanimrate( var_2 maps\_utility::getanim( var_6 ), 0 );
}

observation_room_scientist_setup( var_0 )
{
    maps\_utility::set_ignoreall( 1 );
    maps\_utility::set_ignoreme( 1 );
    self.grenadeammo = 0;
    maps\_utility::disable_pain();
    self.no_friendly_fire_penalty = 1;
    self.ignoresonicaoe = 1;
    self pushplayer( 1 );
    thread vign_ai_check_for_death( 1 );
}

vign_ai_check_for_death( var_0 )
{
    self notify( "stop_check_for_death" );
    self endon( "stop_check_for_death" );
    self endon( "flag_test_chamber_end" );
    self waittill( "damage", var_1, var_2, var_3, var_4 );

    if ( isplayer( var_2 ) )
    {
        if ( !level.missionfailed )
        {
            setdvar( "ui_deadquote", &"CAPTURED_FAIL_INNOCENT" );
            thread maps\_utility::missionfailedwrapper();
        }
    }

    if ( !isdefined( var_0 ) )
        level.ally stopanimscripted();

    self startragdollfromimpact( var_4, var_3 );
    level notify( "tech_dead" );
}

tc_setup_door( var_0, var_1 )
{
    var_2 = getent( var_0, "targetname" );
    var_3 = getentarray( var_2.target, "targetname" );
    var_4 = undefined;

    foreach ( var_6 in var_3 )
    {
        if ( var_6.classname == "script_brushmodel" )
            var_4 = var_6;

        var_6 linkto( var_2 );
    }

    if ( isdefined( var_1 ) )
        return [ var_2, var_4 ];
    else
        return var_2;
}

start_autopsy_halls()
{
    maps\captured_util::warp_allies( "struct_allystart_autopsy_halls" );
    level.player thread maps\_utility::blend_movespeedscale( 0.5 );
    level.player maps\captured_util::warp_to_start( "struct_playerstart_autopsy_halls" );
    level.player thread maps\captured_util::start_one_handed_gunplay( "iw5_titan45pickup_sp_xmags" );
    soundscripts\_snd::snd_message( "start_halls_to_autopsy" );
    maps\_player_exo::player_exo_activate();
    level thread autopsy_first_frame_entry_doors();
    soundscripts\_snd::snd_message( "aud_alarm_submix" );
}

main_autopsy_halls()
{
    var_0 = getentarray( "ent_ah_autopsy_doors", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_2.script_noteworthy = "aut_cleanup";
        var_2 maps\_utility::assign_animtree( "controlroom_entrance_door" );
        var_2.door_tag = common_scripts\utility::spawn_tag_origin();
        var_2.door_tag.origin = var_2.origin;
        var_2.door_tag.angles = var_2.angles;
        var_2.door_tag.script_noteworthy = "aut_cleanup";
        var_2.door_tag maps\_anim::anim_first_frame_solo( var_2, "s3escape_takedown" );
        getent( var_2.target, "targetname" ) linkto( var_2 );
    }

    var_4 = common_scripts\utility::getstructarray( "ent_ah_track_body", "targetname" );
    common_scripts\utility::array_thread( getentarray( "ent_ah_track_block", "targetname" ), ::ah_init_track_block, var_4 );
    level.player thread ah_player_bodybag_slowdown( 0.4, 0.8, 0.05, 0.1 );
    thread ah_morgue_doors();
    soundscripts\_snd::snd_message( "aud_morgue_bodybag_line_emt" );
    var_5 = common_scripts\utility::array_add( level.tcah_doors, level.ally );
    level.tcah_node notify( "tc_enter_test_loop_ender" );
    soundscripts\_snd::snd_music_message( "mus_captured_halls" );
    soundscripts\_snd::snd_message( "start_indoor_alarms_2" );
    soundscripts\_snd::snd_message( "aud_stop_horror_ambience" );
    level.tcah_node thread maps\_anim::anim_single( var_5, "tc_enter_test_exit_door", undefined, 0.2 );
    maps\_utility::array_spawn( getentarray( "civ_ah_intro", "targetname" ), 1 );
    wait 1.5;

    if ( !level.currentgen )
        maps\_utility::array_spawn( getentarray( "civ_ah_start", "targetname" ), 1 );

    level.ally thread maps\_utility::enable_cqbwalk();
    level.ally thread maps\_utility::follow_path( getnode( "node_ah_ally_start", "targetname" ) );
    common_scripts\utility::flag_set( "flag_ah_ai_blocker" );
    common_scripts\utility::flag_wait( "flag_ah_combat_start" );
    thread maps\_utility::battlechatter_on( "allies" );
    thread maps\_utility::battlechatter_on( "axis" );
    level.nextgrenadedrop = 573000;
    level.one_handed_help = 1;
    level.player thread maps\_utility::blend_movespeedscale( 0.8, 1.0 );
    soundscripts\_snd::snd_message( "aud_limp_off" );
    level.ally thread maps\_utility::disable_cqbwalk();
    maps\_utility::array_spawn( getentarray( "opfor_ah_start_front", "targetname" ) );
    maps\_utility::array_spawn( getentarray( "opfor_ah_start", "targetname" ) );
    maps\captured_util::delay_retreat( "opfor_ah", 10, -2, "flag_ah_combat_hall", "color_ah_combat_hall", 1 );
    level.ally thread maps\_utility::notify_delay( "stop_going_to_node", 0.5 );
    level.ally maps\_utility::delaythread( 0.5, maps\_utility::set_force_color, "r" );
    level thread ah_delay_playerseek( 10, "gps_ah_combat_start" );
    maps\_utility::flood_spawn( getentarray( "opfor_ah_front", "targetname" ) );
    maps\captured_util::delay_retreat( "opfor_ah", 60, [ -4, 3 ], "flag_ah_combat_front", "color_ah_combat_front", 1 );
    maps\_utility::flood_spawn( getentarray( "opfor_ah_mid", "targetname" ) );
    maps\_utility::flagwaitthread( "flag_ah_combat_goto_mid", maps\_utility::autosave_by_name, "ah_morgue" );
    level.player thread ah_morgue_threat_proc();
    maps\captured_util::delay_retreat( "opfor_ah", 60, [ -6, 4 ], "flag_ah_combat_mid", "color_ah_combat_mid", 1 );
    thread maps\_spawner::killspawner( 91 );
    common_scripts\utility::flag_set( "flag_ah_combat_goto_mid" );
    wait 1.0;
    maps\captured_util::delay_retreat( "opfor_ah", 60, 2, "flag_ah_combat_back", "color_ah_combat_back", 1 );
    thread maps\_spawner::killspawner( 92 );
    maps\_utility::array_spawn( getentarray( "opfor_ah_back", "targetname" ) );
    var_6 = getent( "color_ah_combat_near_done", "targetname" );
    var_6 maps\_utility::flagwaitthread( "flag_ah_combat_near_done", maps\_utility::notify_delay, "trigger", 0.0 );
    maps\captured_util::delay_retreat( "opfor_ah", 60, 0, "flag_ah_combat_done" );
    level.one_handed_help = undefined;
    maps\_utility::delaythread( 5, maps\_utility::kill_deathflag, "flag_ah_combat_done", 3.0, 1 );
    soundscripts\_snd::snd_music_message( "mus_captured_halls_end" );
    var_7 = common_scripts\utility::getstruct( "node_ah_security_console", "targetname" );
    level.ally maps\_utility::disable_ai_color();
    level.ally maps\_utility::follow_path( var_7 );
    level notify( "obj_exit_morgue" );
    var_8 = common_scripts\utility::getstruct( "struct_vign_autopsy_door", "targetname" );
    var_8 maps\_anim::anim_reach_solo( level.ally, "morgue_exit_door_start" );
    var_8 maps\_anim::anim_single_solo( level.ally, "morgue_exit_door_start" );
    var_8 thread maps\_anim::anim_loop_solo( level.ally, "morgue_exit_door_loop", "morgue_exit_door_loop_ender" );

    while ( !common_scripts\utility::flag( "flag_ah_combat_near_done" ) )
        wait 0.05;

    thread ah_tranistion_doors( var_8, var_0 );
    level notify( "vo_morgue_transition" );
    var_8 notify( "morgue_exit_door_loop_ender" );
    var_8 maps\_anim::anim_single_solo( level.ally, "morgue_exit_door_end" );
    common_scripts\utility::flag_set( "flag_ah_ready_to_leave" );
}

ah_player_bodybag_slowdown( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    self notify( "stop_bodybag_slowdown" );
    self endon( "stop_bodybag_slowdown" );

    for (;;)
    {
        if ( common_scripts\utility::flag( "flag_player_hit_bodybag" ) && self.movespeedscale > var_0 )
            maps\_utility::blend_movespeedscale( max( var_0, self.movespeedscale - var_2 ), 0.05 );
        else if ( !common_scripts\utility::flag( "flag_player_hit_bodybag" ) && self.movespeedscale < var_1 )
            maps\_utility::blend_movespeedscale( min( var_1, self.movespeedscale + var_3 ), 0.05 );

        wait 0.05;
    }
}

ah_tranistion_doors( var_0, var_1 )
{
    foreach ( var_3 in var_1 )
        var_3.closed = var_3.origin;

    level waittill( "ally_opens_autopsy_outer_door" );
    soundscripts\_snd::snd_message( "aud_door", "autopsy_pre_doors", "open" );

    foreach ( var_3 in var_1 )
        var_3.door_tag thread maps\_anim::anim_single_solo( var_3, "s3escape_takedown" );

    var_7 = getent( "ent_ah_autopsy_doors_col", "targetname" );
    var_7 notsolid();
    common_scripts\utility::flag_wait( "flag_ah_ready_to_leave" );
    var_8 = getent( "trig_autopsy_halls_end", "targetname" );

    while ( !level.player istouching( var_8 ) )
        wait 0.05;

    var_8 delete();
    soundscripts\_snd::snd_message( "aud_door", "autopsy_pre_doors", "close" );

    foreach ( var_3 in var_1 )
        var_3 moveto( var_3.closed, 0.5, 0.05, 0.05 );

    var_7 solid();
    wait 0.5;
    common_scripts\utility::flag_set( "flag_autopsy_halls_end" );
    thread ah_fast_body_cleanup();

    if ( level.currentgen )
        common_scripts\utility::flag_set( "tff_trans_autopsy_halls_to_autopsy" );

    level waittill( "autopsy_enemy_door_open" );

    if ( level.nextgen )
    {
        var_1[0] moveto( var_1[0].origin + ( 0, 52, 0 ), 1.0, 0.05, 0.05 );
        var_1[1] moveto( var_1[1].origin - ( 0, 52, 0 ), 1.0, 0.05, 0.05 );
    }
    else
    {
        var_11 = getent( var_1[0].target, "targetname" );
        var_12 = getent( var_1[1].target, "targetname" );
        var_11 delete();
        var_12 delete();
    }
}

ah_delay_playerseek( var_0, var_1, var_2 )
{
    if ( isdefined( var_1 ) )
        level endon( var_1 );

    if ( isdefined( level.flag[var_1] ) && common_scripts\utility::flag( var_1 ) )
        return;

    if ( !isdefined( var_2 ) )
        var_2 = 0;
    else if ( var_2 > 4 )
        return;

    wait(var_0);
    var_3 = undefined;
    var_4 = common_scripts\utility::get_array_of_closest( level.player.origin, maps\_utility::get_ai_group_ai( "opfor_ah" ), undefined, undefined, 1536 );

    foreach ( var_6 in var_4 )
    {
        if ( isdefined( var_6.enemy ) && isplayer( var_6.enemy ) )
        {
            var_3 = var_6;
            break;
        }
    }

    if ( !isdefined( var_3 ) || !isalive( var_3 ) )
    {
        level thread ah_delay_playerseek( 1, var_1, var_2 + 1 );
        return;
    }

    var_3 endon( "death" );
    var_3 setthreatbiasgroup( "playerseek" );
    var_3 thread maps\_utility::player_seek();
}

ah_init_track_block( var_0 )
{
    self endon( "death" );
    self.models = [ "cap_hanging_bodybag", "cap_hanging_bodybag_02", "cap_hanging_bodybag_b", "cap_hanging_bodybag_c", "cap_hanging_bodybag_02_b", "cap_hanging_bodybag_02_c" ];
    var_1 = common_scripts\utility::getclosest( self.origin, var_0, 128 );
    self.body = spawn( "script_model", var_1.origin );
    self.body setmodel( common_scripts\utility::random( self.models ) );
    self.body.angles = ( self.angles[0], randomint( 360 ), self.angles[2] );
    self.slow_trig = getent( var_1.target, "targetname" );
    self.slow_trig enablelinkto();
    wait 0.05;
    self.body linkto( self );
    self.slow_trig linkto( self );
    self.offset = ( 0, 4, -7 );
    self.track_start = getent( "org_ah_track_start", "targetname" );
    self.track_end = getent( "org_ah_track_end", "targetname" );
    var_2 = getent( self.target, "targetname" );
    thread ah_move_track_block( var_2 );
}

ah_move_track_block( var_0 )
{
    self endon( "death" );
    level endon( "stop_moving_bodies" );

    while ( !common_scripts\utility::flag( "flag_autopsy_halls_end" ) )
    {
        var_1 = distance( self.origin, var_0.origin ) * 0.03;

        if ( isdefined( var_0.doors ) )
            var_0 thread ah_track_door_open( var_1 );

        self moveto( var_0.origin, var_1 );
        wait(var_1);

        if ( isdefined( var_0.script_noteworthy ) && var_0.script_noteworthy == "turn" )
        {
            wait 0.25;
            self rotateto( var_0.angles, 1 );
            wait 1;
        }

        var_0 = getent( var_0.target, "targetname" );

        if ( var_0 == self.track_start )
        {
            self.body delete();
            self teleportentityrelative( self.track_end, self.track_start );
            self dontinterpolate();
            wait 0.05;
            self.body = spawn( "script_model", self.origin + self.offset + ( 0, 0, randomfloatrange( -1, 1 ) ) );
            self.body setmodel( common_scripts\utility::random( self.models ) );
            self.body.angles = ( self.angles[0], randomint( 360 ), self.angles[2] );
            wait 0.05;
            self.body linkto( self );
            var_0 = getent( var_0.target, "targetname" );
        }
    }

    self delete();
}

ah_fast_body_cleanup()
{
    level notify( "stop_moving_bodies" );
    var_0 = getentarray( "ent_ah_track_block", "targetname" );

    foreach ( var_2 in var_0 )
        var_2.body delete();
}

ah_init_track_doors()
{
    var_0 = getent( "org_ah_track_start", "targetname" );

    if ( isdefined( var_0 ) )
    {
        for ( var_1 = getent( var_0.target, "targetname" ); var_1 != var_0; var_1 = getent( var_1.target, "targetname" ) )
        {
            if ( isdefined( var_1.script_noteworthy ) && var_1.script_noteworthy != "turn" )
            {
                var_1.doors = getentarray( var_1.script_noteworthy, "targetname" );

                foreach ( var_3 in var_1.doors )
                {
                    var_4 = getentarray( var_3.target, "targetname" );
                    common_scripts\utility::array_call( var_4, ::linkto, var_3 );
                    var_3.open = var_3.origin;
                    var_3.close = var_3.open + 28 * vectornormalize( ( var_1.origin[0], var_1.origin[1], var_3.open[2] ) - var_3.open );
                    var_3 moveto( var_3.close, 0.05 );
                }
            }
        }
    }
}

ah_track_door_open( var_0 )
{
    wait(var_0 - 1.25);

    foreach ( var_2 in self.doors )
        var_2 moveto( var_2.open, 1.0, 0.1, 0.4 );

    soundscripts\_snd::snd_message( "aud_morgue_bodybag_doors", "open" );
    wait 1.5;

    foreach ( var_2 in self.doors )
        var_2 moveto( var_2.close, 1.0, 0.2, 0.2 );

    soundscripts\_snd::snd_message( "aud_morgue_bodybag_doors", "close" );
}

ah_morgue_doors()
{
    var_0 = common_scripts\utility::getstruct( "door_ah_morgue_close", "targetname" );
    var_1 = getentarray( "door_ah_morgue", "targetname" );

    foreach ( var_3 in var_1 )
    {
        var_4 = getentarray( var_3.target, "targetname" );
        common_scripts\utility::array_call( var_4, ::linkto, var_3 );
        var_3.open = var_3.origin;
        var_3.close = var_0.origin;
        var_3 moveto( var_3.close, 0.05 );
    }

    while ( !common_scripts\utility::flag( "flag_incinerator_saved" ) )
    {
        common_scripts\utility::flag_wait( "gps_ah_open_morgue" );
        soundscripts\_snd::snd_message( "aud_door", "morgue_doors", "open" );

        foreach ( var_3 in var_1 )
            var_3 moveto( var_3.open, 1.25, 0.2, 0.5 );

        wait 1.5;

        while ( common_scripts\utility::flag( "gps_ah_open_morgue" ) )
            wait 0.05;

        soundscripts\_snd::snd_message( "aud_door", "morgue_doors", "close" );

        foreach ( var_3 in var_1 )
            var_3 moveto( var_3.close, 1.25, 0.2, 0.5 );
    }
}

ah_morgue_threat_proc()
{
    self endon( "death" );
    self.threat_stance = "none";

    while ( !common_scripts\utility::flag( "flag_incinerator_saved" ) )
    {
        while ( common_scripts\utility::flag( "gps_ah_in_morgue" ) )
        {
            var_0 = self getstance();

            if ( self.threat_stance != var_0 )
                maps\captured_util::one_handed_modify_threatbias( var_0 );

            wait 0.05;
        }

        maps\captured_util::one_handed_modify_threatbias( "none" );
        common_scripts\utility::flag_wait( "gps_ah_in_morgue" );
    }

    self.threat_stance = undefined;
}

start_autopsy()
{
    if ( level.nextgen )
    {
        var_0 = getentarray( "ent_ah_autopsy_doors", "targetname" );
        common_scripts\utility::array_call( var_0, ::delete );
    }
    else
    {
        var_1 = getentarray( "ent_ah_autopsy_doors", "targetname" );

        foreach ( var_3 in var_1 )
        {
            var_3.script_noteworthy = "aut_cleanup";
            var_3 maps\_utility::assign_animtree( "controlroom_entrance_door" );
            var_3.door_tag = common_scripts\utility::spawn_tag_origin();
            var_3.door_tag.origin = var_3.origin;
            var_3.door_tag.angles = var_3.angles;
            var_3.door_tag.script_noteworthy = "aut_cleanup";
            var_3.door_tag maps\_anim::anim_first_frame_solo( var_3, "s3escape_takedown" );
        }
    }

    maps\captured_util::warp_allies( "struct_allystart_autopsy" );
    level.player thread maps\_utility::blend_movespeedscale( 0.8 );
    level.player maps\captured_util::warp_to_start( "struct_playerstart_autopsy" );
    level.player thread maps\captured_util::start_one_handed_gunplay( "iw5_titan45pickup_sp_xmags" );
    maps\_player_exo::player_exo_activate();
    common_scripts\utility::flag_set( "flag_autopsy_halls_end" );
}

main_autopsy()
{
    thread maps\_utility::battlechatter_off( "allies" );
    thread maps\_utility::battlechatter_off( "axis" );
    level thread autopsy_start();
    common_scripts\utility::flag_wait( "flag_autopsy_end" );
}

setup_spawners()
{
    common_scripts\utility::array_call( getentarray( "opfor_tc_observation_scientist", "script_noteworthy" ), ::setspawnerteam, "allies" );
    maps\_utility::array_spawn_function( getentarray( "civ_ah_intro", "targetname" ), ::civ_ah );
    maps\_utility::array_spawn_function( getentarray( "civ_ah_start", "targetname" ), ::civ_ah );
    maps\_utility::array_spawn_function( getentarray( "opfor_ah_start_front", "targetname" ), ::opfor_ah_start_front );
    maps\_utility::array_spawn_function( getentarray( "opfor_ah_start", "targetname" ), ::opfor_ah );
    maps\_utility::array_spawn_function( getentarray( "opfor_ah_front", "targetname" ), ::opfor_ah );
    maps\_utility::array_spawn_function( getentarray( "opfor_ah_front_pyr", "targetname" ), ::opfor_ah );
    maps\_utility::array_spawn_function( getentarray( "opfor_ah_mid", "targetname" ), ::opfor_ah );
    maps\_utility::array_spawn_function( getentarray( "opfor_ah_mid_pyr", "targetname" ), ::opfor_ah );
    maps\_utility::array_spawn_function( getentarray( "opfor_ah_back", "targetname" ), ::opfor_ah );
    maps\_utility::array_spawn_function( getentarray( "med_observation_enemies", "targetname" ), ::opfor_ah );
    maps\_utility::array_spawn_function_targetname( "opfor_autopsy_guard", ::autopsy_guard );
    maps\_utility::array_spawn_function_targetname( "opfor_autopsy_doctor", ::autopsy_main_doctor );
}

civ_ah()
{
    self endon( "death" );
    self.no_friendly_fire_penalty = 1;
    self.a.disablelongdeath = 1;

    if ( isdefined( self.script_noteworthy ) )
    {
        self.health = 50;
        self.allowdeath = 1;
        self.ignoresonicaoe = 1;
        thread vign_ai_check_for_death();
        level.tcah_node maps\_anim::anim_single( [ self ], "tc_enter_test_exit_door", undefined, 0.2, self.script_noteworthy );
        self notify( "stop_check_for_death" );
    }

    thread maps\captured_util::cap_civilian_damage_proc();
    thread maps\_spawner::go_to_node( undefined, undefined, undefined, randomintrange( 448, 576 ) );
    self waittill( "civ_kill_me" );

    for (;;)
    {
        if ( distancesquared( self.origin, level.player.origin ) > 1048576 && !maps\_utility::player_can_see_ai( self ) )
            break;

        wait 0.1;
    }

    self delete();
}

opfor_ah()
{
    self endon( "death" );
    thread maps\captured_util::opfor_death_mod();
    thread maps\captured_util::opfor_ammo_drop_mod();
    thread maps\_utility::set_grenadeammo( 0 );
    var_0 = undefined;

    if ( isdefined( self.target, "targetname" ) )
        var_0 = getentarray( self.target, "targetname" );

    while ( isdefined( var_0 ) && var_0.size > 0 )
    {
        var_1 = randomint( var_0.size );

        if ( isdefined( var_0[var_1].target ) && isdefined( var_0[var_1].script_flag_wait ) && common_scripts\utility::flag( var_0[var_1].script_flag_wait ) )
        {
            var_0 = getentarray( var_0[var_1].target, "targetname" );
            continue;
        }

        thread maps\_utility::follow_path( var_0[var_1] );
        break;
    }
}

opfor_ah_start_front()
{
    self endon( "death" );
    thread maps\captured_util::opfor_death_mod();
    thread maps\captured_util::opfor_ammo_drop_mod();
    thread maps\_utility::set_grenadeammo( 0 );
    maps\_utility::set_favoriteenemy( level.ally );
    maps\_utility::set_baseaccuracy( 0.5 );
    self waittill( "goal" );
    self.health = 1;
    level.ally maps\_utility::set_favoriteenemy( self );
}

autopsy_guard()
{
    self endon( "death" );
    self.baseaccuracy = 0;
    self.script_noteworthy = "aut_cleanup";

    if ( !isdefined( self.script_delay ) || self.script_delay < 3 )
    {
        maps\_utility::gun_remove();
        maps\_utility::place_weapon_on( "iw5_titan45pickup_sp", "right" );
    }

    maps\_utility::set_ignoreall( 1 );
    wait(randomfloatrange( 4, 8 ));
    maps\_utility::set_ignoreall( 0 );
    maps\_utility::delaythread( 3, ::autopsy_guard_player_hit );

    while ( !common_scripts\utility::flag( "flag_incinerator_fires_start" ) )
    {
        self.baseaccuracy = min( 1, self.baseaccuracy + randomfloat( 0.05 ) );
        self.bulletsinclip = weaponclipsize( self.weapon );

        if ( common_scripts\utility::cointoss() )
            maps\_utility::enable_dontevershoot();
        else
            maps\_utility::disable_dontevershoot();

        wait(randomfloatrange( 0.5, 1.0 ));
    }

    self delete();
}

autopsy_guard_player_hit()
{
    self endon( "death" );
    level endon( "stop_autopsy_guard_player_hit" );

    for (;;)
    {
        self waittill( "shooting" );

        if ( isplayer( self.enemy ) && self cansee( level.player ) && randomfloat( 1 ) < self.baseaccuracy )
            level.player dodamage( 10, self geteye(), self );
    }
}

autopsy_main_doctor()
{
    self endon( "death" );
    self.animname = "doctor";
    self.grenadeammo = 0;
    self.ignoresonicaoe = 1;
    maps\_utility::magic_bullet_shield( 1 );
    maps\_utility::set_ignoreall( 1 );
    maps\_utility::set_ignoreme( 1 );
    maps\_utility::gun_remove();
    maps\_utility::place_weapon_on( "iw5_titan45pickup_sp", "left" );
    thread vign_ai_check_for_death();
    self pushplayer( 1 );
    self waittill( "vig_kill_me" );
    self notify( "stop_check_for_death" );
    maps\_utility::stop_magic_bullet_shield();
    self.a.nodeath = 1;
    self.allowdeath = 1;
    self.diequietly = 1;
    self kill();
}

doc_fire( var_0 )
{
    var_0 shoot();
}

doc_punched( var_0 )
{
    playfxontag( level._effect["punch_mouth_blood_spit"], var_0, "j_head" );
}

rifle_butt( var_0 )
{
    playfxontag( level._effect["punch_mouth_blood_spit"], var_0, "J_Elbow_RI" );
}

autopsy_first_frame_entry_doors()
{
    var_0 = [];
    var_0["left"] = getent( "aut_door_lt", "targetname" );
    var_0["left_col"] = getent( "aut_door_lt_col", "targetname" );
    var_0["left"] maps\_utility::assign_animtree( "autopsy_door" );
    var_0["left_col"] linkto( var_0["left"], "j_bone_door_left" );
    var_0["right"] = getent( "aut_door_rt", "targetname" );
    var_0["right_col"] = getent( "aut_door_rt_col", "targetname" );
    var_0["right"] maps\_utility::assign_animtree( "autopsy_door_rt" );
    var_0["right_col"] linkto( var_0["right"], "j_bone_door_right" );
    var_1 = common_scripts\utility::getstruct( "struct_vign_autopsy_door", "targetname" );
    var_1 thread maps\_anim::anim_first_frame( [ var_0["left"], var_0["right"] ], "autopsy_door" );
    return var_0;
}

#using_animtree("generic_human");

autopsy_start()
{
    level endon( "missionfailed" );
    level notify( "start_autopsy_enter" );
    level.ally maps\_utility::follow_path( getnode( "node_autopsy_hold_0", "targetname" ) );
    level.ally maps\_utility::enable_cqbwalk();
    var_0 = maps\_utility::spawn_targetname( "opfor_autopsy_doctor" );
    var_0 character\gfl\randomizer_atlas::main();
    var_1 = common_scripts\utility::getstruct( "struct_vign_autopsy_doctor_door", "targetname" );
    var_1 thread maps\_anim::anim_loop_solo( var_0, "autopsy_doctor_loop_start", "stop_doctor_loop" );
    common_scripts\utility::flag_set( "flag_spawning_autopsy_techs" );
    level maps\_utility::delaythread( 0.05, ::autopsy_create_fodder_techs );
    var_2 = autopsy_first_frame_entry_doors();
    var_3 = maps\_utility::spawn_anim_model( "autopsy_hatch" );
    var_1 maps\_anim::anim_first_frame_solo( var_3, "autopsy_doctor_door_open" );
    var_4 = common_scripts\utility::getstruct( "struct_vign_autopsy_door", "targetname" );
    var_4 thread maps\_anim::anim_loop_solo( level.ally, "autopsy_entrance_door_loop", "autopsy_entrance_door_loop_ender" );
    common_scripts\utility::flag_wait( "flag_autopsy_halls_end" );
    var_4 notify( "autopsy_entrance_door_loop_ender" );
    level notify( "ready_for_autopsy_start" );
    thread maps\captured_util::physics_bodies_off();
    thread maps\captured_util::physics_bodies_on( "autopsy_bodies_1", 0.0 );

    if ( level.currentgen )
    {
        if ( !istransientloaded( "captured_autopsy_tr" ) )
            level waittill( "tff_post_autopsy_halls_to_autopsy" );
    }

    common_scripts\utility::flag_set( "flag_autopsy_enter" );
    level.mission_fail_func = undefined;
    soundscripts\_snd::snd_message( "aud_autopsy_entrance" );
    level.ally maps\_utility::ai_ignore_everything();
    var_4 thread autopsy_door_tech();
    var_4 thread maps\_anim::anim_single( [ level.ally, var_2["left"], var_2["right"] ], "autopsy_door", undefined, 0.2 );
    var_1 thread autopsy_doctor_door_doctor( var_0 );
    var_1 maps\_anim::anim_reach_solo( level.ally, "autopsy_doctor_gideon_walk" );
    common_scripts\utility::flag_set( "flag_autopsy_doctor_scene_start" );
    var_1 thread autopsy_doctor_door_gideon();
    var_5 = [ "cap_dcr_getbackorillshoot", "cap_dcr_imwarningyou" ];
    var_0 thread maps\captured_util::dialogue_nag_loop( var_5, "doctor_door_weapon_hidden", 3.0, 4.0, 3.0, 8.0 );
    common_scripts\utility::flag_wait( "flag_autopsy_gideon_at_door" );
    common_scripts\utility::flag_wait( "flag_autopsy_safe_to_open_door" );
    var_6 = getent( "aut_door_use_trig", "targetname" );
    var_6 maps\_utility::addhinttrigger( &"CAPTURED_HINT_OPEN_CONSOLE", &"CAPTURED_HINT_OPEN_PC" );
    maps\captured_actions::autopsy_door_action( var_6, var_1 );
    var_6 delete();
    var_1 thread autopsy_doctor_door_player();
    thread maps\captured::dialogue_s3_head_doctor( var_0 );
    level waittill( "doctor_door_weapon_hidden" );
    soundscripts\_snd_common::snd_enable_soundcontextoverride( "bullet_whizby_glass" );
    var_1 notify( "stop_gideon_loop" );
    var_1 notify( "stop_doctor_loop" );
    var_7 = [];
    var_7["doctor"] = var_0;
    var_7["autopsy_hatch"] = var_3;
    var_7["sliding_door"] = getent( "aut_doctor_doors", "targetname" );
    var_7["sliding_door"] maps\_utility::assign_animtree( "autopsy_doc_doors" );
    level.cover_warnings_disabled = 1;
    level maps\_utility::delaythread( 8, ::autopsy_doctor_door_enemies );
    thread maps\captured_fx::fx_autopsy_hatch_open();
    var_0 thread maps\_utility::notify_delay( "vig_kill_me", getanimlength( %cap_s3_autopsydoc_opendoor_doc ) );
    var_1 thread maps\captured_anim::anim_single_to_loop_solo( level.ally, "autopsy_doctor_door_open", "autopsy_doctor_hatch_open_loop", "autopsy_hatch_ender" );
    var_1 thread maps\_anim::anim_single( var_7, "autopsy_doctor_door_open" );
    wait(getanimlength( level.ally maps\_utility::getanim( "autopsy_doctor_door_open" ) ));
    level.ally maps\_utility::ai_unignore_everything();
    var_8 = common_scripts\utility::getstructarray( "action_doctor_hatch_node", "targetname" );
    array_waittill_player_lookat( var_8, 0.8, 0.25, 1, 3.0, var_3 );
    common_scripts\utility::flag_set( "flag_autopsy_chute" );
    var_7 = [];
    var_7["ally_0"] = level.ally;
    var_7["autopsy_hatch"] = var_3;
    var_1 notify( "autopsy_hatch_ender" );
    soundscripts\_snd::snd_message( "aud_hatch_gideon" );
    var_9 = getanimlength( level.ally maps\_utility::getanim( "autopsy_doctor_hatch_open_jump" ) );
    var_1 thread maps\_anim::anim_single( var_7, "autopsy_doctor_hatch_open_jump" );
    level.ally common_scripts\utility::delaycall( var_9, ::hide );
    level.ally maps\_utility::delaythread( var_9, maps\_utility::disable_cqbwalk );
    common_scripts\utility::getstruct( "struct_anim_incinerator", "targetname" ) maps\_utility::delaythread( var_9, maps\_anim::anim_first_frame_solo, level.ally, "incinerator_intro" );
    wait 2;

    for (;;)
    {
        array_waittill_player_lookat( var_8, 0.9, 0.15, 1 );

        if ( distance2d( level.player.origin, var_8[0].origin ) < 70 && level.player isonground() )
        {
            setdemigodmode( level.player, 1 );
            break;
        }

        waitframe();
    }

    var_10 = maps\_utility::spawn_anim_model( "player_rig" );
    var_10 hide();
    level.player freezecontrols( 1 );
    level.player allowprone( 0 );
    level.player allowcrouch( 0 );
    level.player allowstand( 1 );
    level.player allowjump( 0 );
    level.player setstance( "stand" );

    while ( level.player getstance() != "stand" )
        wait 0.05;

    level thread maps\_utility::notify_delay( "stop_autopsy_guard_player_hit", 2 );
    level notify( "autopsy_player_jumping_into_hatch" );
    thread maps\captured_util::smooth_player_link( var_10, 0.4 );
    var_1 maps\_anim::anim_single( [ var_10, var_3 ], "autopsy_doctor_player_jump", undefined, 0.25 );
    level.player unlink();
    var_10 delete();
    level.player freezecontrols( 0 );
    level.cover_warnings_disabled = undefined;
    common_scripts\utility::flag_set( "flag_autopsy_end" );
    soundscripts\_snd_common::snd_disable_soundcontextoverride( "bullet_whizby_glass" );
    wait 2;
    setdemigodmode( level.player, 0 );
    var_3 delete();
    common_scripts\utility::array_call( var_2, ::delete );
    thread maps\captured_util::physics_bodies_off();
}

array_waittill_player_lookat( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = spawnstruct();

    foreach ( var_9 in var_0 )
        var_7 thread array_waittill_player_lookat_proc( var_9, var_1, var_2, var_3, var_4, var_5, var_6 );

    var_7 waittill( "lookat_complete" );
}

array_waittill_player_lookat_proc( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    self endon( "lookat_complete" );
    var_0 maps\_utility::waittill_player_lookat( var_1, var_2, var_3, var_4, var_5, var_6 );
    self notify( "lookat_complete" );
}

autopsy_doctor_door_no_hint()
{
    if ( !isalive( level.player ) )
        return 1;

    if ( common_scripts\utility::flag( "missionfailed" ) )
        return 1;

    return 0;
}

autopsy_doctor_door_player()
{
    maps\_utility::autosave_by_name_silent( "autopsy_doctor" );
    common_scripts\utility::flag_set( "flag_autopsy_doctor_door" );
    var_0 = maps\_utility::spawn_anim_model( "player_rig" );
    var_0 hide();
    maps\_anim::anim_first_frame( [ var_0 ], "autopsy_doctor_door_open" );
    setsaveddvar( "g_friendlyNameDist", 0 );
    level.player disableweapons();
    level.player allowmelee( 0 );
    level.player setstance( "stand" );
    level.player allowstand( 1 );
    level.player allowcrouch( 0 );
    level.player allowprone( 0 );
    level.player allowsprint( 0 );
    level.player playerlinktoblend( var_0, "tag_player", 0.5 );

    if ( issubstr( tolower( level.player.one_weap ), "titan45" ) || issubstr( tolower( level.player.one_weap ), "knife" ) )
    {
        soundscripts\_snd::snd_message( "aud_autopsy_knife_pry_door", "handgun" );
        wait 0.6;
    }
    else
    {
        soundscripts\_snd::snd_message( "aud_autopsy_knife_pry_door", "rifle" );
        wait 1.0;
    }

    level notify( "doctor_door_weapon_hidden" );
    level.player notify( "stop_one_handed_gunplay" );
    level.player takeallweapons();
    maps\_player_exo::player_exo_deactivate();
    level notify( "stop_overdrive_tracker" );
    var_0 show();
    var_0 attach( "vm_kvaHasmatKnifeDown", "tag_weapon_right" );
    level.player playerlinktodelta( var_0, "tag_player", 1, 0, 0, 0, 0, 1 );
    maps\_anim::anim_single( [ var_0 ], "autopsy_doctor_door_open" );
    level.player allowsprint( 1 );
    level.player allowprone( 1 );
    level.player allowcrouch( 1 );
    level.player allowstand( 1 );
    level.player takeallweapons();
    level.player enableweapons();
    level.player unlink();
    var_0 delete();
}

autopsy_doctor_door_gideon()
{
    level.ally endon( "death" );
    maps\_utility::delaythread( 3, common_scripts\utility::flag_set, "flag_autopsy_gideon_at_door" );
    maps\captured_anim::anim_single_to_loop_solo( level.ally, "autopsy_doctor_gideon_walk", "autopsy_doctor_gideon_door_loop", "stop_gideon_loop" );
}

autopsy_doctor_door_doctor( var_0 )
{
    var_0 endon( "death" );

    while ( distance( var_0.origin, level.ally.origin ) > 704 )
        wait 0.05;

    self notify( "stop_doctor_loop" );
    maps\_anim::anim_single_solo( var_0, "autopsy_doctor_grabgun" );
    common_scripts\utility::flag_set( "flag_autopsy_safe_to_open_door" );
    maps\_anim::anim_loop_solo( var_0, "autopsy_doctor_grabgun_loop", "stop_doctor_loop" );
}

autopsy_doctor_door_fail()
{
    level endon( "missionfailed" );
    level endon( "flag_autopsy_chute" );
    var_0 = 10;
    common_scripts\utility::flag_set( "flag_autopsy_start_fail" );
    wait(var_0);

    if ( !common_scripts\utility::flag( "flag_autopsy_chute" ) )
    {
        setdvar( "ui_deadquote", &"CAPTURED_FAIL_AUTOPSY_ESCAPE" );
        thread maps\_utility::missionfailedwrapper();
    }
}

autopsy_doctor_door_enemies()
{
    level notify( "autopsy_enemy_door_open" );
    var_0 = getent( "aut_glass_clip", "targetname" );
    var_0 delete();
    maps\_utility::flood_spawn( getentarray( "opfor_autopsy_guard", "targetname" ) );
}

autopsy_doctor_door_enemy_think( var_0 )
{
    var_1 = common_scripts\utility::getstruct( "aut_door_enemy_node_" + var_0, "targetname" );
    self.script_noteworthy = "aut_cleanup";
    maps\_utility::set_ignoreall( 1 );
    self.goalradius = 16;
    self setgoalpos( var_1.origin );
    wait 4;
    maps\_utility::set_ignoreall( 0 );
}

autopsy_doctor_door_enemy_ammo()
{
    self endon( "death" );

    for (;;)
    {
        self givemaxammo( self.weapon );
        wait 1;
    }
}

autopsy_door_tech()
{
    if ( level.currentgen )
    {
        if ( !istransientloaded( "captured_autopsy_tr" ) )
            level waittill( "tff_post_autopsy_halls_to_autopsy" );
    }

    var_0 = maps\_utility::spawn_targetname( "aut_tech", 1 );
    common_scripts\utility::flag_clear( "flag_spawning_autopsy_techs" );
    var_0 maps\_utility::set_ignoreall( 1 );
    var_0 maps\_utility::set_ignoreme( 1 );
    var_0.grenadeammo = 0;
    var_0.animname = "autopsy_tech";
    var_0.ignoresonicaoe = 1;
    var_0 pushplayer( 1 );
    var_0 endon( "death" );
    var_0 thread vign_ai_check_for_death();
    var_0 maps\_utility::delaythread( 6.75, ::vign_ai_check_for_death, 0 );
    maps\_anim::anim_single_solo( var_0, "autopsy_door" );
    thread maps\_anim::anim_loop_solo( var_0, "autopsy_door_tech_loop", "stop_looping" );
}

autopsy_create_fodder_techs()
{
    var_0 = common_scripts\utility::getstructarray( "aut_tech", "targetname" );
    common_scripts\utility::flag_waitopen( "flag_spawning_autopsy_techs" );
    waitframe();

    foreach ( var_2 in var_0 )
    {
        var_2 thread autopsy_fodder_tech_think();
        waitframe();
    }
}

autopsy_fodder_tech_think()
{
    var_0 = self.origin;
    var_1 = self.angles;
    var_2 = maps\_utility::spawn_targetname( "aut_tech", 1 );
    var_2 maps\_utility::set_ignoreall( 1 );
    var_2 maps\_utility::set_ignoreme( 1 );
    var_2.grenadeammo = 0;
    var_2.animname = "tech";
    var_2 forceteleport( var_0, var_1 );
    var_2 setgoalpos( var_0 );
    var_2 maps\_utility::set_deathanim( "cap_s3_autopsy_tech_death" );
    var_2 thread vign_ai_check_for_death( 1 );
    var_2.ignoresonicaoe = 1;
    var_2 pushplayer( 1 );
    var_2 endon( "death" );
    var_3 = 0;
    var_4 = 0;

    if ( isdefined( self.script_index ) )
        var_4 = 0.01 * self.script_index;

    if ( isdefined( self.script_count ) )
        var_3 = self.script_count;

    var_2 maps\_anim::anim_first_frame_solo( var_2, self.animation );
    wait(var_3);
    var_2 common_scripts\utility::delaycall( 0.05, ::setanimtime, level.scr_anim[var_2.animname][self.animation], var_4 );
    thread autopsy_fodder_tech_animate( var_2 );
}

autopsy_fodder_tech_animate( var_0 )
{
    var_0 endon( "death" );
    var_0 maps\_anim::anim_single_solo( var_0, self.animation );
    var_0 thread maps\_anim::anim_loop_solo( var_0, self.animation + "_loop" );
}

autopsy_cleanup()
{
    var_0 = getentarray( "aut_cleanup", "script_noteworthy" );
    maps\_utility::array_delete( var_0 );
}

bmcd_debug_loop()
{
    while ( !common_scripts\utility::flag( "flag_battle_to_heli_end" ) )
    {
        if ( !level.player buttonpressed( "BUTTON_B" ) )
        {
            wait 0.1;
            continue;
        }

        if ( level.player buttonpressed( "DPAD_LEFT" ) || level.player buttonpressed( "LEFTARROW" ) )
        {
            maps\_player_exo::player_exo_activate();
            iprintln( "Exo On" );
            wait 0.2;
        }
        else if ( level.player buttonpressed( "DPAD_RIGHT" ) || level.player buttonpressed( "RIGHTARROW" ) )
        {
            maps\_player_exo::player_exo_deactivate();
            iprintln( "Exo Off" );
            wait 0.2;
        }
        else if ( level.player buttonpressed( "DPAD_UP" ) || level.player buttonpressed( "UPARROW" ) )
        {
            level.player notify( "stop_one_handed_gunplay" );
            iprintln( "One Handed Off" );
            wait 0.2;
        }
        else if ( level.player buttonpressed( "DPAD_DOWN" ) || level.player buttonpressed( "DOWNARROW" ) )
        {
            if ( isdefined( level.debugging_on ) )
            {
                level.debugging_on = undefined;
                iprintln( "Debugging Off" );
            }
            else
            {
                level.debugging_on = 1;
                iprintln( "Debugging On" );
            }

            wait 0.2;
        }

        wait 0.1;
    }
}
