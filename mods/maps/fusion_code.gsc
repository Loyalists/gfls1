// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

fusion_intro_screen()
{
    level.player freezecontrols( 1 );
    thread fusion_intro_background( 8.3 + level.intro_hades_video_length, 5 );
    thread fusion_intro_title_text();
    common_scripts\utility::flag_set( "intro_screen_done" );
    common_scripts\utility::flag_set( "introscreen_complete" );
    wait(11 + level.intro_hades_video_length);
    level.player freezecontrols( 0 );
}

fusion_intro_title_text()
{
    setsaveddvar( "cg_cinematicfullscreen", "1" );
    maps\_shg_utility::play_chyron_video( "chyron_text_fusion" );
    var_0 = getdvarint( "cg_cinematicCanPause", 0 );
    setsaveddvar( "cg_cinematicCanPause", 1 );
    // cinematicingame( "fusion_videolog02" );
    // waitframe();

    // while ( !iscinematicplaying() )
    //     waitframe();

    // fusion_intro_hades_videolog_vo();
    setsaveddvar( "cg_cinematicCanPause", var_0 );
    common_scripts\utility::flag_set( "intro_text_cinematic_over" );
}

fusion_intro_hades_videolog_vo()
{
    var_0 = spawn( "script_origin", level.player.origin );
    var_0 playscheduledcinematicsound( 106, "fus_hade_peopleoftheworldyou" );
    var_0 playscheduledcinematicsound( 269, "fus_hade_technologyisacancerrotting" );
    var_0 playscheduledcinematicsound( 595, "fus_hade_todaywestrikeatthe" );
    wait 1;

    while ( iscinematicplaying() )
        waitframe();

    var_0 delete();
}

fusion_intro_background( var_0, var_1 )
{
    var_2 = newclienthudelem( level.player );
    var_2 setshader( "black", 1280, 720 );
    var_2.horzalign = "fullscreen";
    var_2.vertalign = "fullscreen";
    var_2.alpha = 1;
    var_2.foreground = 0;
    wait(var_0);
    var_2 fadeovertime( var_1 );
    var_2.alpha = 0;
    wait(var_1);
    var_2 destroy();
}

gameplay_setup()
{
    maps\_variable_grenade::main();
    vehicle_scripts\_pdrone_tactical_picker::main();
    maps\_stingerm7::init();
    maps\_player_exo::player_exo_add_single( "high_jump" );

    if ( level.nextgen )
        thread hide_water();

    thread setup_m_turret();
    thread setup_spawn_functions();
    thread finale_enemy_transports();
    thread finale_enemy_gaz();
    thread reactor_entrance_rally();
    thread interior_gameplay();
    thread evacuation_setup();
    thread setup_evacuation_scene();
    thread extraction_chopper();
    thread cooling_tower_collapse();

    if ( level.currentgen )
        thread mobile_cover_drones_cg();

    thread setup_dont_leave_failure();
    thread setup_dont_leave_hint();
    maps\_utility::add_hint_string( "hint_dont_leave_mission", &"FUSION_DONT_LEAVE", ::should_break_dont_leave );
}

setup_spawn_functions()
{
    maps\_utility::array_spawn_function_noteworthy( "enemy_street_wave_01", ::street_enemy_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_street_wave_02", ::street_enemy_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_street_turret_wave_2", ::street_enemy_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_street_wave_rear_mi17_01", ::street_enemy_think );

    if ( level.nextgen )
        maps\_utility::array_spawn_function_noteworthy( "enemy_street_wave_03", ::street_enemy_building_east_think );

    maps\_utility::array_spawn_function_noteworthy( "enemy_street_wave_04", ::street_enemy_building_west_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_street_zip_rooftop", ::rooftop_enemy_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_street_zip_rooftop_strafe", ::rooftop_enemy_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_street_tank_stage_01", ::street_enemy_tank_battle_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_street_tank_stage_02", ::street_enemy_tank_battle_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_street_tank_stage_03", ::street_enemy_tank_battle_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_street_turret_wave_1", ::street_enemy_tank_damaged_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_street_turret_wave_2", ::street_enemy_tank_damaged_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_street_blown_building", ::street_enemy_blown_building_think );

    if ( level.currentgen )
    {
        maps\_utility::array_spawn_function_noteworthy( "enemy_street_zip_rooftop_left", ::rooftop_enemy_think_left );
        maps\_utility::array_spawn_function_noteworthy( "enemy_street_zip_rooftop_right", ::rooftop_enemy_think_right );
    }

    maps\_utility::array_spawn_function_noteworthy( "turbine_room_enemy", ::turbine_room_enemy_think );
    common_scripts\utility::array_thread( getentarray( "corpse_trigger", "targetname" ), ::corpse_trigger_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_street_wave_rear", ::street_enemy_think );
    maps\_utility::array_spawn_function_noteworthy( "rpg_vehicle", ::postspawn_rpg_vehicle );
    maps\_utility::array_spawn_function_targetname( "hangar_enemies_01", ::hangar_enemy_think );
    maps\_utility::add_global_spawn_function( "allies", ::disable_badplace_for_red_guys );
    maps\_utility::add_global_spawn_function( "allies", ::ally_enable_boost_traversals );
    maps\_utility::array_spawn_function_noteworthy( "evacuation_first_drones", ::evacuation_first_drones_think );
    thread enemy_combat_equip_microwave_grenades();
    maps\_utility::add_global_spawn_function( "axis", ::detect_turret_death );
    maps\_utility::add_global_spawn_function( "axis", maps\_chargeable_weapon::ai_detect_charged_damage );
}

tff_cleanup_vehicle( var_0 )
{
    switch ( var_0 )
    {
        case "intro":
            level waittill( "tff_pre_transition_intro_to_middle" );
            break;
        case "middle":
            level waittill( "tff_pre_transition_middle_to_outro" );
            break;
    }

    if ( isdefined( self ) )
    {
        if ( maps\_vehicle::isvehicle() )
            self freevehicle();

        self delete();
    }
}

setup_dont_leave_failure()
{
    common_scripts\utility::flag_wait( "player_left_map" );
    level notify( "mission failed" );
    setdvar( "ui_deadquote", &"FUSION_DONT_LEAVE_FAILURE" );
    maps\_utility::missionfailedwrapper();
}

setup_dont_leave_hint()
{
    level endon( "mission failed" );

    for (;;)
    {
        common_scripts\utility::flag_wait( "player_leaving_map" );
        maps\_utility::display_hint( "hint_dont_leave_mission" );
        common_scripts\utility::flag_wait_either( "player_leaving_map", "player_returning_to_map" );
        waitframe();
    }
}

should_break_dont_leave()
{
    if ( common_scripts\utility::flag( "missionfailed" ) )
        return 1;

    if ( common_scripts\utility::flag( "player_returning_to_map" ) )
        return 1;
    else
        return 0;
}

mobile_cover_drones_cg()
{
    if ( level.start_point != "fly_in_animated" && level.start_point != "fly_in_animated_part2" && level.start_point != "courtyard" )
        return;

    var_0 = getentarray( "mobile_cover_drones", "targetname" );
    var_1 = [];

    foreach ( var_3 in var_0 )
        var_1[var_1.size] = var_3 maps\_utility::spawn_vehicle();

    level waittill( "tff_pre_transition_intro_to_middle" );
    common_scripts\utility::array_call( var_1, ::delete );
}

heroes_post_zip()
{
    if ( level.nextgen )
    {
        var_0 = getent( "hero_alpha_leader", "script_noteworthy" );
        var_0 maps\_utility::add_spawn_function( ::alpha_leader_think );
        level.alpha_leader = var_0 maps\_utility::spawn_ai( 1 );
        level.alpha_leader.animname = "alpha_leader";
        level.alpha_leader maps\_utility::magic_bullet_shield( 1 );
    }

    level.carter unlink();
    level.carter maps\_utility::teleport_ent( common_scripts\utility::getstruct( "carter_zip_dest", "targetname" ) );
    level.carter maps\_utility::disable_ai_color();
    level.carter maps\_utility::enable_sprint();
    level.carter maps\_utility::gun_recall();
    level.carter show();
    level.joker unlink();
    level.joker maps\_utility::teleport_ent( common_scripts\utility::getstruct( "joker_zip_dest", "targetname" ) );
    level.joker maps\_utility::gun_recall();
    level.joker show();
}

alpha_leader_think()
{
    common_scripts\utility::flag_wait( "flag_walker_destroyed" );
    level.alpha_leader maps\_utility::set_force_color( "y" );
}

ally_enable_boost_traversals()
{
    self.canjumppath = 1;
}

disable_badplace_for_red_guys()
{
    if ( !isdefined( self.script_forcecolor ) || self.script_forcecolor != "r" )
        return;

    thread maps\fusion_utility::ignore_badplace( undefined, "flag_mt_wall_rpg_impact" );
}

objectives()
{
    thread set_obj_markers_current();
    obj_shut_down_reactor();
    obj_escape();
}

obj_shut_down_reactor()
{
    if ( !common_scripts\utility::flag( "flag_intro_objective_given" ) )
    {
        maps\_utility::flag_set_delayed( "flag_intro_objective_given", 33 + level.intro_hades_video_length );
        common_scripts\utility::flag_wait( "flag_intro_objective_given" );
    }

    objective_add( maps\_utility::obj( "shutdown_reactor" ), "active", &"FUSION_OBJECTIVE_REACTOR" );
    objective_current( maps\_utility::obj( "shutdown_reactor" ) );
    objective_position( maps\_utility::obj( "shutdown_reactor" ), getent( "obj_reactor_01", "targetname" ).origin );
    common_scripts\utility::flag_wait( "update_obj_pos_walker" );

    if ( isdefined( level.walker ) )
    {
        objective_setpointertextoverride( maps\_utility::obj( "shutdown_reactor" ), &"FUSION_OBJECTIVE_WALKER" );
        var_0 = common_scripts\utility::spawn_tag_origin();
        var_0 linkto( level.walker, "tag_camera", ( 0, 0, -24 ), ( 0, 0, 0 ) );
        objective_onentity( maps\_utility::obj( "shutdown_reactor" ), var_0, ( 0, 0, 0 ) );
        common_scripts\utility::flag_wait( "flag_walker_destroyed" );
        objective_setpointertextoverride( maps\_utility::obj( "shutdown_reactor" ), "" );
        var_0 delete();
    }

    common_scripts\utility::flag_wait( "update_obj_pos_security_entrance_1" );
    objective_position( maps\_utility::obj( "shutdown_reactor" ), common_scripts\utility::getstruct( "obj_pos_security_entrance_1", "targetname" ).origin );
    common_scripts\utility::flag_wait( "update_obj_pos_security_entrance_2" );
    objective_position( maps\_utility::obj( "shutdown_reactor" ), common_scripts\utility::getstruct( "obj_pos_security_entrance_2", "targetname" ).origin );
    common_scripts\utility::flag_wait( "update_obj_pos_security_room" );
    objective_position( maps\_utility::obj( "shutdown_reactor" ), common_scripts\utility::getstruct( "obj_pos_security_room", "targetname" ).origin );
    common_scripts\utility::flag_wait( "update_obj_pos_security_elevator_burke" );

    if ( isdefined( level.burke ) )
        objective_onentity( maps\_utility::obj( "shutdown_reactor" ), level.burke );

    common_scripts\utility::flag_wait( "update_obj_pos_security_elevator" );
    objective_position( maps\_utility::obj( "shutdown_reactor" ), common_scripts\utility::getstruct( "obj_pos_security_elevator", "targetname" ).origin );
    common_scripts\utility::flag_wait( "update_obj_pos_elevator_descent" );
    objective_position( maps\_utility::obj( "shutdown_reactor" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "update_obj_pos_lab_follow_joker" );

    if ( isdefined( level.joker ) )
        objective_onentity( maps\_utility::obj( "shutdown_reactor" ), level.joker );

    common_scripts\utility::flag_wait( "update_obj_pos_lab_follow_burke" );

    if ( isdefined( level.burke ) )
        objective_onentity( maps\_utility::obj( "shutdown_reactor" ), level.burke );

    common_scripts\utility::flag_wait( "update_obj_pos_lab_follow_carter" );

    if ( isdefined( level.carter ) )
        objective_onentity( maps\_utility::obj( "shutdown_reactor" ), level.carter );

    common_scripts\utility::flag_wait( "update_obj_pos_reactor_1" );
    objective_position( maps\_utility::obj( "shutdown_reactor" ), common_scripts\utility::getstruct( "obj_pos_reactor_1", "targetname" ).origin );
    common_scripts\utility::flag_wait( "update_obj_pos_reactor_2" );
    objective_position( maps\_utility::obj( "shutdown_reactor" ), common_scripts\utility::getstruct( "obj_pos_reactor_2", "targetname" ).origin );
    common_scripts\utility::flag_wait( "update_obj_pos_reactor_exit" );
    objective_position( maps\_utility::obj( "shutdown_reactor" ), common_scripts\utility::getstruct( "obj_pos_reactor_exit", "targetname" ).origin );
    common_scripts\utility::flag_wait( "update_obj_pos_reactor_storage_1" );
    objective_position( maps\_utility::obj( "shutdown_reactor" ), common_scripts\utility::getstruct( "obj_pos_reactor_storage_1", "targetname" ).origin );
    common_scripts\utility::flag_wait( "update_obj_pos_reactor_storage_2" );
    objective_position( maps\_utility::obj( "shutdown_reactor" ), common_scripts\utility::getstruct( "obj_pos_reactor_storage_2", "targetname" ).origin );
    common_scripts\utility::flag_wait( "update_obj_pos_turbine_elevator" );
    objective_position( maps\_utility::obj( "shutdown_reactor" ), common_scripts\utility::getstruct( "obj_pos_turbine_elevator", "targetname" ).origin );
    common_scripts\utility::flag_wait( "update_obj_pos_turbine_elevator_button" );
    objective_position( maps\_utility::obj( "shutdown_reactor" ), getent( "elevator_button", "targetname" ).origin );
    objective_setpointertextoverride( maps\_utility::obj( "shutdown_reactor" ), &"FUSION_OBJ_POINTER_USE" );
    common_scripts\utility::flag_wait( "update_obj_pos_turbine_elevator_ascent" );
    objective_position( maps\_utility::obj( "shutdown_reactor" ), ( 0, 0, 0 ) );
    objective_setpointertextoverride( maps\_utility::obj( "shutdown_reactor" ), "" );
    common_scripts\utility::flag_wait( "update_obj_pos_turbine_room_1" );
    objective_position( maps\_utility::obj( "shutdown_reactor" ), common_scripts\utility::getstruct( "obj_pos_turbine_room_1", "targetname" ).origin );
    common_scripts\utility::flag_wait( "update_obj_pos_turbine_room_exit" );
    objective_position( maps\_utility::obj( "shutdown_reactor" ), common_scripts\utility::getstruct( "obj_pos_turbine_room_exit", "targetname" ).origin );
    common_scripts\utility::flag_wait( "update_obj_pos_control_room_door" );
    objective_position( maps\_utility::obj( "shutdown_reactor" ), common_scripts\utility::getstruct( "obj_pos_control_room_door", "targetname" ).origin );
    common_scripts\utility::flag_wait( "update_obj_pos_control_room_explosion" );
    objective_position( maps\_utility::obj( "shutdown_reactor" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "update_obj_pos_control_room_console" );
    objective_position( maps\_utility::obj( "shutdown_reactor" ), common_scripts\utility::getstruct( "obj_pos_control_room_console", "targetname" ).origin );
    objective_setpointertextoverride( maps\_utility::obj( "shutdown_reactor" ), &"FUSION_OBJ_POINTER_USE" );
    common_scripts\utility::flag_wait( "update_obj_pos_control_room_using_console" );
    objective_position( maps\_utility::obj( "shutdown_reactor" ), ( 0, 0, 0 ) );
    objective_setpointertextoverride( maps\_utility::obj( "shutdown_reactor" ), "" );
    common_scripts\utility::flag_wait( "flag_shut_down_reactor_failed" );
    wait 2;
    objective_state( maps\_utility::obj( "shutdown_reactor" ), "failed" );
    wait 2;
}

set_obj_markers_current()
{
    common_scripts\utility::flag_wait_all( "flag_obj_markers", "flag_burke_rally_street_dialogue_complete" );
    objective_add( maps\_utility::obj( "use_mobile_cover" ), "invisible", "" );
    objective_add( maps\_utility::obj( "enter_mobile_turret" ), "invisible", "" );
    objective_add( maps\_utility::obj( "use_smaw" ), "invisible", "" );
    thread obj_use_mobile_cover();
    thread obj_enter_mobile_turret();
    thread obj_use_smaw();
}

obj_use_mobile_cover()
{
    common_scripts\utility::flag_wait( "flag_mcd_vo_done" );
    objective_state_nomessage( maps\_utility::obj( "use_mobile_cover" ), "active" );
    objective_current_nomessage( maps\_utility::obj( "use_mobile_cover" ), maps\_utility::obj( "shutdown_reactor" ), maps\_utility::obj( "enter_mobile_turret" ) );
    objective_setpointertextoverride( maps\_utility::obj( "use_mobile_cover" ), &"FUSION_OBJ_POINTER_USE" );
    objective_position( maps\_utility::obj( "use_mobile_cover" ), getent( "org_obj_use_mobile_cover", "targetname" ).origin );
    objective_additionalposition( maps\_utility::obj( "use_mobile_cover" ), 1, getent( "org_obj_use_mobile_cover2", "targetname" ).origin );
    level.player waittill( "player_linked_to_cover" );
    objective_state_nomessage( maps\_utility::obj( "use_mobile_cover" ), "done" );
}

obj_enter_mobile_turret()
{
    common_scripts\utility::flag_wait( "flag_mt_move_up_03" );
    objective_state_nomessage( maps\_utility::obj( "enter_mobile_turret" ), "active" );
    objective_current_nomessage( maps\_utility::obj( "enter_mobile_turret" ), maps\_utility::obj( "shutdown_reactor" ) );
    objective_setpointertextoverride( maps\_utility::obj( "enter_mobile_turret" ), &"FUSION_OBJ_POINTER_ENTER" );
    objective_position( maps\_utility::obj( "enter_mobile_turret" ), getent( "org_obj_enter_mobile_turret", "targetname" ).origin );
    level.player waittill( "player_starts_entering_mobile_turret" );
    objective_state_nomessage( maps\_utility::obj( "enter_mobile_turret" ), "done" );
}

obj_use_smaw()
{
    common_scripts\utility::flag_wait( "flag_enemy_walker" );
    thread track_smaw();
    objective_state_nomessage( maps\_utility::obj( "use_smaw" ), "active" );
    objective_current_nomessage( maps\_utility::obj( "use_smaw" ), maps\_utility::obj( "shutdown_reactor" ) );
    objective_setpointertextoverride( maps\_utility::obj( "use_smaw" ), &"FUSION_OBJ_POINTER_USE" );
    common_scripts\utility::flag_wait( "flag_walker_reveal_dialogue_complete" );
    var_0 = 0;

    while ( !common_scripts\utility::flag( "flag_walker_destroyed" ) || !common_scripts\utility::flag( "flag_walker_death_anim_start" ) )
    {
        if ( does_player_have_smaw() )
        {
            if ( var_0 )
            {
                objective_state_nomessage( maps\_utility::obj( "use_smaw" ), "done" );
                var_0 = 0;
            }
        }
        else if ( !var_0 )
        {
            objective_state_nomessage( maps\_utility::obj( "use_smaw" ), "active" );
            objective_current_nomessage( maps\_utility::obj( "use_smaw" ), maps\_utility::obj( "shutdown_reactor" ) );
            objective_setpointertextoverride( maps\_utility::obj( "use_smaw" ), &"FUSION_OBJ_POINTER_USE" );
            objective_onentity( maps\_utility::obj( "use_smaw" ), level.smaw_location );
            var_0 = 1;
        }

        waitframe();
    }

    if ( var_0 )
    {
        objective_state_nomessage( maps\_utility::obj( "use_smaw" ), "done" );
        var_0 = 0;
    }

    level notify( "stop_track_smaw" );
    level.smaw_location delete();
    level.smaw_location = undefined;
}

track_smaw()
{
    level endon( "stop_track_smaw" );
    level.smaw_location = common_scripts\utility::spawn_tag_origin();
    level.smaw_location.origin = getent( "org_obj_use_smaw", "targetname" ).origin;

    for (;;)
    {
        level.player waittill( "pickup", var_0, var_1 );

        if ( isdefined( var_1 ) && issubstr( var_1.classname, "iw5_stingerm7_sp" ) )
            level.smaw_location linkto( var_1, "", ( -10, 8, 1 ), ( 0, 0, 0 ) );
    }
}

does_player_have_smaw()
{
    var_0 = level.player getweaponslistall();

    foreach ( var_2 in var_0 )
    {
        if ( var_2 == "iw5_stingerm7_sp" )
            return 1;
    }

    return 0;
}

obj_escape()
{
    var_0 = maps\_utility::obj( "obj_escape_power_plant" );
    objective_add( var_0, "active", &"FUSION_OBJECTIVE_ESCAPE" );
    objective_current( var_0 );
    objective_position( var_0, getent( "obj_escape_01", "targetname" ).origin );
    common_scripts\utility::flag_wait( "update_obj_pos_control_room_exit_1" );
    objective_position( var_0, common_scripts\utility::getstruct( "obj_pos_control_room_exit_1", "targetname" ).origin );
    common_scripts\utility::flag_wait( "update_obj_pos_control_room_exit_2" );
    objective_position( var_0, common_scripts\utility::getstruct( "obj_pos_control_room_exit_2", "targetname" ).origin );
    common_scripts\utility::flag_wait( "update_obj_pos_hangar_entrance" );
    objective_position( var_0, common_scripts\utility::getstruct( "obj_pos_hangar_entrance", "targetname" ).origin );
    common_scripts\utility::flag_wait( "flag_obj_02_pos_update_02" );
    objective_position( var_0, getent( "obj_escape_02", "targetname" ).origin );
    common_scripts\utility::flag_wait( "flag_obj_02_pos_update_03" );
    objective_position( var_0, getent( "obj_escape_03", "targetname" ).origin );
    common_scripts\utility::flag_wait( "objective_on_extraction_chopper" );

    if ( isdefined( level.extraction_chopper ) )
        objective_onentity( var_0, level.extraction_chopper );

    common_scripts\utility::flag_wait( "tower_knockback" );
    wait 5;
    objective_position( var_0, ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "play_ending" );
    objective_state( var_0, "done" );
}

squad_heli_zip()
{
    common_scripts\utility::flag_wait( "intro_squad_helis_start" );
    wait 0.05;
    level.heli_squad_01.animname = "npc_zip_warbird";
    level.heli_squad_01.goalradius = 1;
    var_0 = spawn( "script_origin", ( -80, -2480, 752 ) );
    var_0.angles = ( 0, 265, 0 );
    common_scripts\utility::flag_wait( "flag_squad_heli_2_unload" );

    if ( level.nextgen )
    {
        level.heli_squad_01 setvehgoalpos( var_0.origin, 1 );
        level.heli_squad_01 waittill( "goal" );
        level.heli_squad_01 vehicle_setspeedimmediate( 0, 0.05, 0.05 );
        level.heli_squad_01 sethoverparams( 0, 0, 0 );
        level.heli_squad_01 notify( "stop_handle_rotors" );
        var_0 maps\_anim::anim_first_frame_solo( level.heli_squad_01, "npc_zip" );
        var_1 = getent( "npc_zip_guy_1", "targetname" );
        var_2 = getent( "npc_zip_guy_2", "targetname" );
        var_3 = getent( "npc_zip_guy_3", "targetname" );
        var_4 = getent( "npc_zip_guy_4", "targetname" );
        level.guy_1 = var_1 maps\_utility::spawn_ai( 1 );
        level.guy_1.animname = "npc_zip_1";
        level.guy_1.ignoreme = 1;
        level.guy_2 = var_2 maps\_utility::spawn_ai( 1 );
        level.guy_2.animname = "npc_zip_2";
        level.guy_2.ignoreme = 1;
        var_5 = var_3 maps\_utility::spawn_ai( 1 );
        var_5.animname = "npc_zip_3";
        var_5.ignoreme = 1;
        var_6 = var_4 maps\_utility::spawn_ai( 1 );
        var_6.animname = "npc_zip_4";
        var_6.ignoreme = 1;
        var_7 = maps\_utility::spawn_anim_model( "zipline_1" );
        var_8 = maps\_utility::spawn_anim_model( "zipline_2" );
        var_9 = maps\_utility::spawn_anim_model( "zipline_3" );
        var_10 = maps\_utility::spawn_anim_model( "zipline_4" );
        var_11 = [ level.guy_1, level.guy_2, var_5, var_6, var_7, var_8, var_9, var_10 ];
        level.heli_squad_01 maps\_anim::anim_first_frame( var_11, "npc_zip", "TAG_GUY0" );

        foreach ( var_13 in var_11 )
            var_13 linkto( level.heli_squad_01, "TAG_GUY0" );

        var_0 thread maps\_anim::anim_single_solo( level.heli_squad_01, "npc_zip" );
        level.heli_squad_01 maps\_anim::anim_single( var_11, "npc_zip", "TAG_GUY0" );

        foreach ( var_13 in var_11 )
            var_13 unlink();

        var_7 delete();
        var_8 delete();
        var_9 delete();
        var_10 delete();
        level.guy_1 maps\fusion_utility::goto_node( "node_squad_zip_guard_01", 0 );
        level.guy_2 maps\fusion_utility::goto_node( "node_squad_zip_guard_02", 0 );
        var_5 delete();
        var_6 delete();
        wait 2;
    }

    if ( level.currentgen )
        wait 10;

    common_scripts\utility::flag_set( "flag_rpg_at_heli" );
    common_scripts\utility::flag_set( "flag_squad_heli_01_zip_complete" );
    level.heli_squad_01 sethoverparams( 50, 10, 10 );
    level.heli_squad_01 setmaxpitchroll( 15, 40 );
    level.heli_squad_01 thread vehicle_scripts\_xh9_warbird::handle_rotors();
    level.heli_squad_01.script_vehicle_selfremove = 1;
    common_scripts\utility::flag_wait( "flag_player_zip_started" );

    if ( level.nextgen )
    {
        level.guy_1 delete();
        level.guy_2 delete();
        var_0 delete();
    }
}

#using_animtree("vehicles");

fly_in_scene_part1( var_0, var_1, var_2 )
{
    var_3 = getanimlength( %fusion_fly_in_intro_warbird_a );
    level.player shellshock( "fusion_slowview", var_3 );
    level.joker maps\_utility::gun_remove();
    level.carter maps\_utility::gun_remove();
    var_4 = [];
    var_4[0] = var_1;
    var_0 maps\_anim::anim_first_frame( var_4, "fly_in_intro" );
    var_5 = [];
    var_5[0] = var_2;
    var_5[1] = level.burke;
    var_5[2] = level.joker;
    var_5[3] = level.carter;
    var_5[4] = level.copilot_intro;
    var_5[5] = level.pilot_intro;
    var_5[6] = level.guy_facing_player_intro;

    foreach ( var_7 in var_5 )
        var_7 thread maps\fusion_utility::hide_friendname_until_flag_or_notify( "warbird_fly_in_arrived" );

    var_1 maps\_anim::anim_first_frame( var_5, "fly_in_intro", "tag_guy0" );

    foreach ( var_7 in var_5 )
        var_7 linkto( var_1, "tag_guy0" );

    level.player playerlinktodelta( var_2, "tag_player", 1, 0, 0, 0, 0, 1 );
    wait(level.intro_hades_video_length);
    soundscripts\_snd::snd_message( "start_hologram_audio" );
    soundscripts\_snd::snd_message( "start_burke_foley", level.burke );
    soundscripts\_snd::snd_message( "start_intro_npc_foley", level.guy_facing_player_intro );
    common_scripts\utility::flag_wait( "intro_screen_done" );
    thread intro_heli_movies();
    thread fly_in_rumble();
    level.player thread widen_player_view( var_2 );
    var_0 thread maps\_anim::anim_single( var_4, "fly_in_intro" );
    var_1 maps\_anim::anim_single( var_5, "fly_in_intro", "tag_guy0" );
    var_11 = common_scripts\utility::spawn_tag_origin();
    var_11 linkto( var_1, "TAG_ORIGIN", ( 0, 0, 0 ), ( 270, 0, 0 ) );
    playfxontag( common_scripts\utility::getfx( "warbird_rotor" ), var_11, "TAG_ORIGIN" );
}

fly_in_rumble()
{
    common_scripts\utility::flag_wait( "intro_text_cinematic_over" );
    var_0 = maps\_utility::get_rumble_ent( "steady_rumble" );
    var_0.intensity = 0.08;
    level.burke waittillmatch( "single anim", "start_video_3" );
    level.player playrumblelooponentity( "tank_rumble" );
    wait 3.5;
    level.player stoprumble( "tank_rumble" );
    level waittill( "intro_missile_hit" );
    level.player playrumbleonentity( "damage_heavy" );
    level.player waittill( "fastzip_landed" );
    stopallrumbles();
}

intro_missile_hit( var_0 )
{
    level notify( "intro_missile_hit" );
}

widen_player_view( var_0 )
{
    wait 0.2;
    self playerlinktodelta( var_0, "tag_player", 0.75, 35, 0, 15, 25, 1 );
    common_scripts\utility::flag_wait( "flag_combat_zip_rooftop_start" );
    self lerpviewangleclamp( 4.0, 2.0, 2.0, 50, 40, 15, 45 );
}

lerp_wind( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = ( var_2 - var_0 ) / ( var_4 / 0.05 );
    var_6 = ( var_3 - var_1 ) / ( var_4 / 0.05 );

    while ( var_4 > 0 )
    {
        var_0 += var_5;
        var_1 += var_6;
        setsaveddvar( "r_reactiveMotionWindAmplitudeScale", var_0 );
        setsaveddvar( "r_reactiveMotionWindFrequencyScale", var_1 );
        var_4 -= 0.05;
        wait 0.05;
    }
}

wind_over_trees()
{
    wait 20;
    lerp_wind( 0.3, 1, 15, 1.5, 1.5 );
    wait 1.75;
    lerp_wind( 15, 1.5, 10, 1, 1 );
    wait 3;
    lerp_wind( 10, 1, 20, 2, 2 );
    wait 5;
    setsaveddvar( "r_reactiveMotionWindAmplitudeScale", "0.3" );
    setsaveddvar( "r_reactiveMotionWindFrequencyScale", "0.5" );
}

fly_in_scene_part2( var_0, var_1, var_2 )
{
    thread wind_over_trees();
    level.player shellshock( "fusion_slowview", 50 );
    var_3 = maps\_vehicle::spawn_vehicle_from_targetname( "squad_blackhawk" );
    var_3.animname = "warbird_b";
    var_3.no_anim_rotors = 1;
    var_3 vehicle_turnengineoff();
    var_4 = maps\_vehicle::spawn_vehicle_from_targetname( "warbird_c" );
    var_4.animname = "warbird_c";
    var_4.no_anim_rotors = 1;
    var_4 vehicle_turnengineoff();
    var_5 = maps\_vehicle::spawn_vehicle_from_targetname( "warbird_d" );
    var_5.animname = "warbird_d";
    var_5.no_anim_rotors = 1;
    var_5 vehicle_turnengineoff();
    var_6 = maps\_vehicle::spawn_vehicle_from_targetname( "warbird_e" );
    var_6.animname = "warbird_e";
    var_6.no_anim_rotors = 1;
    var_6 vehicle_turnengineoff();
    var_7 = getent( "npc_b", "targetname" );
    var_8 = var_7 maps\_utility::spawn_ai( 1 );
    var_8.animname = "npc_b";
    var_9 = getent( "npc_c", "targetname" );
    var_10 = var_9 maps\_utility::spawn_ai( 1 );
    var_10.animname = "npc_c";
    var_11 = getent( "npc_d", "targetname" );
    var_12 = var_11 maps\_utility::spawn_ai( 1 );
    var_12.animname = "npc_d";
    var_13 = getent( "npc_e", "targetname" );
    var_14 = var_13 maps\_utility::spawn_ai( 1 );
    var_14.animname = "npc_e";
    waittillframeend;
    waittillframeend;
    var_3 vehicle_scripts\_xh9_warbird::cloak_warbird();
    var_8 hide();
    var_10 hide();
    var_12 hide();
    var_14 hide();
    var_3 thread wait_to_decloak_helicopter( 4.25, var_8, var_10, var_12, var_14 );
    thread fly_in_squad_uncloak();
    var_15 = maps\_utility::spawn_anim_model( "tower_debris" );

    if ( level.currentgen )
        var_15 overridelightingorigin( ( 890, -11485, 2280 ) );

    var_16 = common_scripts\utility::getstruct( "tower_debris_part", "targetname" );
    var_17 = [];
    var_17[0] = var_1;
    var_17[1] = var_3;
    var_17[2] = var_4;
    var_17[3] = var_5;
    var_17[4] = var_6;
    var_18 = [];
    var_18[0] = var_2;
    var_18[1] = level.burke;
    var_18[2] = level.joker;
    var_18[3] = level.carter;
    var_18[4] = level.copilot_intro;
    var_18[5] = level.pilot_intro;
    var_18[6] = level.guy_facing_player_intro;
    var_0 maps\_anim::anim_first_frame( [ var_3, var_4, var_5, var_6 ], "fly_in_part2" );
    var_19 = [];
    var_19[0] = var_8;
    var_19[1] = var_10;
    var_19[2] = var_12;
    var_19[3] = var_14;
    playfxontag( common_scripts\utility::getfx( "distortion_warbird" ), var_3, "TAG_STATIC_MAIN_ROTOR_R" );
    var_3 maps\_anim::anim_first_frame( var_19, "fly_in_part2", "tag_guy0" );

    foreach ( var_21 in var_19 )
        var_21 linkto( var_3, "tag_guy0" );

    var_4 thread play_warbird_carrying_walker( "warbird_pulley_c", "warbird_walker_c", "fly_in_part2", "tag_guy0", "TAG_ATTACH" );
    var_5 thread play_warbird_carrying_walker( "warbird_pulley_d", "warbird_walker_d", "fly_in_part2", "tag_guy0", "TAG_ATTACH" );
    var_6 thread play_warbird_carrying_walker( "warbird_pulley_e", "warbird_walker_e", "fly_in_part2", "tag_guy0", "TAG_ATTACH" );
    var_4 thread custom_dust_kickup();
    var_5 thread custom_dust_kickup();
    var_6 thread custom_dust_kickup();
    var_1 maps\fusion_anim::clear_vehicle_anim( 0 );
    var_3 maps\fusion_anim::clear_vehicle_anim( 0 );
    var_2 maps\fusion_anim::clear_player_anim( 0 );
    level.burke maps\fusion_anim::clear_npc_anim( 0 );
    level.joker maps\fusion_anim::clear_npc_anim( 0 );
    level.carter maps\fusion_anim::clear_npc_anim( 0 );
    level.copilot_intro maps\fusion_anim::clear_npc_anim( 0 );
    level.pilot_intro maps\fusion_anim::clear_npc_anim( 0 );
    var_0 thread maps\_anim::anim_single( var_17, "fly_in_part2" );
    var_16 thread maps\_anim::anim_single_solo( var_15, "tower_debris_collision" );
    var_16 thread maps\fusion_fx::play_tower_debris_fx( var_15 );
    var_3 thread maps\_anim::anim_single( var_19, "fly_in_part2", "tag_guy0" );
    level.guy_facing_player_intro common_scripts\utility::delaycall( 3, ::delete );
    var_1 maps\_anim::anim_single( var_18, "fly_in_part2", "tag_guy0" );
    var_0 thread maps\_anim::anim_loop_solo( var_1, "burke_intro_zip_loop", "stop_idle" );

    if ( !isremovedentity( var_8 ) )
        var_8 delete();

    if ( !isremovedentity( var_10 ) )
        var_10 delete();

    if ( !isremovedentity( var_12 ) )
        var_12 delete();

    if ( !isremovedentity( var_14 ) )
        var_14 delete();

    var_4 delete();
    var_5 delete();
    var_6 delete();
    level notify( "warbird_fly_in_arrived" );
    thread rooftop_strafe();
    thread delete_guys_in_heli_when_vo_complete();
    thread delete_tower_debris( var_15 );
}

delete_tower_debris( var_0 )
{
    common_scripts\utility::flag_wait( "player_fly_in_done" );
    var_0 stopanimscripted();
    var_0 delete();
}

play_warbird_carrying_walker( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = maps\_utility::spawn_anim_model( var_0 );
    maps\_anim::anim_first_frame_solo( var_5, var_2, var_3 );
    var_5 linkto( self, var_3 );
    var_6 = maps\_utility::spawn_anim_model( var_1 );
    var_5 maps\_anim::anim_first_frame_solo( var_6, var_2, var_4 );
    var_6 linkto( var_5, "TAG_ATTACH" );
    var_7 = common_scripts\utility::spawn_tag_origin();
    var_7 linkto( self, "tag_origin", ( 0, 0, 0 ), ( -90, 0, 0 ) );
    playfxontag( common_scripts\utility::getfx( "warbird_shadow" ), var_7, "tag_origin" );
    thread maps\_anim::anim_single_solo( var_5, var_2, var_3 );
    var_5 thread maps\_anim::anim_single_solo( var_6, var_2, var_4 );
    level waittill( "warbird_fly_in_arrived" );
    stopfxontag( common_scripts\utility::getfx( "warbird_shadow" ), var_7, "tag_origin" );
    var_7 delete();
    var_5 delete();
    var_6 delete();
}

delete_guys_in_heli_when_vo_complete()
{
    common_scripts\utility::flag_wait( "squad_out_dialogue_complete" );
}

launch_missile( var_0 )
{
    var_1 = maps\_utility::spawn_anim_model( var_0 );
    var_1.animname = var_0;
    var_1 thread missile_fly( self, var_0 );
    return var_1;
}

missile_fly( var_0, var_1 )
{
    if ( var_1 == "missile_0" )
        var_2 = common_scripts\utility::getfx( "smoketrail_groundtoair_large" );
    else
        var_2 = common_scripts\utility::getfx( "smoketrail_groundtoair" );

    playfxontag( var_2, self, "TAG_FX" );
    var_0 maps\_anim::anim_single_solo( self, "fly_in_part2" );

    if ( var_1 == "missile_0" )
        var_2 = common_scripts\utility::getfx( "smoketrail_groundtoair_large" );
    else
        var_2 = common_scripts\utility::getfx( "smoketrail_groundtoair" );

    stopfxontag( var_2, self, "TAG_FX" );
    self delete();
}

spawn_intro_pilots()
{
    var_0 = getent( "npc_f", "targetname" );
    level.copilot_intro = var_0 maps\_utility::spawn_ai( 1 );
    level.copilot_intro.animname = "npc_f";
    level.copilot_intro maps\_utility::gun_remove();
    var_1 = getent( "npc_g", "targetname" );
    level.pilot_intro = var_1 maps\_utility::spawn_ai( 1 );
    level.pilot_intro.animname = "npc_g";
    level.pilot_intro maps\_utility::gun_remove();
    thread clean_up_intro_pilots();
}

clean_up_intro_pilots()
{
    level waittill( "warbird_fly_in_arrived" );
    level.copilot_intro delete();
    level.pilot_intro delete();
}

spawn_intro_heroes()
{
    var_0 = getent( "npc_h", "targetname" );
    level.guy_facing_player_intro = var_0 maps\_utility::spawn_ai( 1 );
    level.guy_facing_player_intro.animname = "npc_h";
}

fly_in_sequence()
{
    common_scripts\utility::flag_set( "sun_shad_fly_in" );
    maps\_utility::battlechatter_off( "allies" );
    thread maps\_utility::flag_set_delayed( "intro_squad_helis_start", 37 + level.intro_hades_video_length );
    thread maps\_utility::flag_set_delayed( "street_combat_start", 77 + level.intro_hades_video_length );
    thread move_squad_and_walkers();
    thread squad_heli_zip();
    thread fly_in_ambient_heli_squad();
    maps\_utility::delaythread( 27 + level.intro_hades_video_length, ::fly_in_ambient_jets );
    thread fly_in_ambient_street_jets();
    thread hide_objective_during_fly_in();
    level.warbird_a = maps\_vehicle::spawn_vehicle_from_targetname( "blackhawk" );
    level.warbird_a.animname = "warbird_a";
    level.warbird_a.no_anim_rotors = 1;
    level.warbird_a vehicle_turnengineoff();
    level.warbird_a soundscripts\_snd::snd_message( "player_warbird_spawn" );
    spawn_intro_heroes();
    spawn_intro_pilots();
    var_0 = spawn_player_anim_rig();
    var_0 hide();
    level.player maps\_shg_utility::setup_player_for_scene();
    maps\_player_exo::player_exo_deactivate();
    var_1 = common_scripts\utility::getstruct( "org_flyin", "targetname" );
    fly_in_scene_part1( var_1, level.warbird_a, var_0 );
    finish_fly_in_sequence( var_1, level.warbird_a, var_0 );
}

play_dust( var_0 )
{
    level notify( "warbird_door_open" );
    common_scripts\utility::noself_delaycall( 1, ::playfxontag, common_scripts\utility::getfx( "fast_blowing_dust" ), level.warbird_a, "TAG_outside_door" );
}

hide_objective_during_fly_in()
{
    setsaveddvar( "objectiveHide", 1 );
    common_scripts\utility::flag_wait( "player_fly_in_done" );
    setsaveddvar( "objectiveHide", 0 );
}

finish_fly_in_sequence( var_0, var_1, var_2 )
{
    maps\_utility::delaythread( 50, ::start_rooftop_combat );
    var_1.missile_org = var_0;
    fly_in_scene_part2( var_0, var_1, var_2 );
    level.burke maps\_utility::gun_recall();
    thread burke_rooftop_combat( var_0, var_1 );
    common_scripts\utility::noself_delaycall( 0, ::stopfxontag, common_scripts\utility::getfx( "fast_blowing_dust" ), level.warbird_a, "TAG_outside_door" );
    thread burke_fastzip_scene( var_0, level.warbird_a );
    common_scripts\utility::flag_wait( "player_can_zip" );
    wait 0.5;
    common_scripts\utility::flag_set( "ready_zip" );
    maps\_utility::activate_trigger_with_targetname( "trig_move_squad_from_heli" );
    var_2 hide();
    var_3 = maps\_utility::spawn_anim_model( "player_arms", var_2.origin );
    var_3.angles = var_2.angles;
    var_3 hide();
    thread rooftop_slide();
    level.player thread maps\_player_fastzip::fastzip_turret_think( level.warbird_a, "tag_turret_zipline_kl", var_3, 2.7 );
    level.player waittill( "fastzip_start" );
    thread zip_debris_anim();
    thread street_hanging_pipes_anim();
    common_scripts\utility::flag_set( "flag_player_zip_started" );
    level.player waittill( "fastzip_arrived" );
    common_scripts\utility::flag_set( "sun_shad_off_zip" );
    maps\_player_exo::player_exo_activate();
    var_2 delete();
    var_3 delete();
    wait 0.05;
    common_scripts\utility::flag_set( "player_fly_in_done" );
    maps\_utility::delaythread( 3, maps\_utility::autosave_by_name );
    thread delete_rooftop_los_blockers();
    thread show_hide_plant_vista();
    maps\_utility::battlechatter_on( "allies" );
    level.warbird_a vehicle_setspeed( 60, 15, 5 );
    var_4 = common_scripts\utility::getstruct( "heli_path_leave", "targetname" );
    level.warbird_a thread maps\_utility::vehicle_dynamicpath( var_4, 0 );
    level.warbird_a soundscripts\_snd::snd_message( "player_warbird_flyout" );
    level.warbird_a.script_vehicle_selfremove = 1;
}

show_hide_plant_vista()
{
    var_0 = getentarray( "brushmodel_vista_plant", "targetname" );

    if ( isdefined( var_0 ) )
    {
        var_0 thread hide_plant_vista_via_trigger();
        var_0 thread show_plant_vista_via_trigger();
    }
}

show_hide_plant_vista_intro()
{
    var_0 = getentarray( "brushmodel_vista_plant", "targetname" );

    if ( isdefined( var_0 ) )
    {
        var_0 thread hide_plant_vista_intro();
        var_0 thread show_plant_vista_intro();
    }
}

hide_plant_vista_intro()
{
    foreach ( var_1 in self )
        var_1 hide();
}

show_plant_vista_intro()
{
    level.player endon( "death" );
    wait 71;

    foreach ( var_1 in self )
        var_1 show();
}

hide_plant_vista_via_trigger()
{
    level endon( "street_cleanup" );

    for (;;)
    {
        maps\_utility::trigger_wait_targetname( "trig_hide_plant_vista" );

        foreach ( var_1 in self )
            var_1 hide();
    }
}

show_plant_vista_via_trigger()
{
    level endon( "street_cleanup" );

    for (;;)
    {
        maps\_utility::trigger_wait_targetname( "trig_show_plant_vista" );

        foreach ( var_1 in self )
            var_1 show();
    }
}

zip_debris_anim()
{
    wait 1.0;
    var_0 = common_scripts\utility::getstruct( "org_zip_debris", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "zip_debris_01" );
    var_2 = maps\_utility::spawn_anim_model( "zip_debris_02" );
    var_3 = [ var_1, var_2 ];
    var_0 maps\_anim::anim_single( var_3, "zip_falling_debris" );
    maps\_utility::array_delete( var_3 );
}

street_hanging_pipes_anim()
{
    var_0 = common_scripts\utility::getstruct( "org_hanging_pipes_01", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "street_pipes_01" );
    var_0 maps\_anim::anim_loop_solo( var_1, "street_hanging_pipes" );

    if ( level.currentgen )
    {
        level waittill( "tff_pre_transition_intro_to_middle" );
        var_0 maps\_utility::anim_stopanimscripted();
        var_1 delete();
    }
}

fly_in_ambient_heli_squad()
{
    common_scripts\utility::flag_wait( "intro_squad_helis_start" );
    level.heli_squad_01 = spawn_ambient_warbird( "squad_warbird_01", 25, 45 );
    level.heli_squad_02 = spawn_ambient_warbird( "squad_warbird_02", 25, 45, 1 );
    level.heli_squad_03 = spawn_ambient_warbird( "squad_warbird_03", 20, 50, 1 );
    level.heli_squad_05 = spawn_ambient_warbird( "squad_warbird_05", 25, 50, 1 );
    level.heli_squad_06 = spawn_ambient_warbird( "squad_warbird_06", 25, 50, 1 );
    level.heli_squad_07 = spawn_ambient_warbird( "squad_warbird_07", 25, 50, 1 );
    level.heli_squad_08 = spawn_ambient_warbird( "squad_warbird_08", 10, 25, 1 );
    level.heli_squad_09 = spawn_ambient_warbird( "squad_warbird_09", 10, 25, 1 );
    level.heli_squad_11 = spawn_ambient_warbird( "squad_warbird_cargo11", 10, 25, 1 );
    level.heli_squad_11 thread add_warbird_cargo( "cargo_walker11", "cargo_pully11" );
    level.heli_squad_08 thread add_warbird_cargo( "cargo_walker12", "cargo_pully12" );
    level.heli_squad_05 thread add_warbird_cargo( "cargo_walker13", "cargo_pully13" );
    level.heli_squad_01 vehicle_turnengineoff();
    level.heli_squad_02 vehicle_turnengineoff();
    level.heli_squad_03 vehicle_turnengineoff();
    level.heli_squad_05 vehicle_turnengineoff();
    level.heli_squad_06 vehicle_turnengineoff();
    level.heli_squad_07 vehicle_turnengineoff();
    level.heli_squad_08 vehicle_turnengineoff();
    level.heli_squad_09 vehicle_turnengineoff();
    level.heli_squad_11 vehicle_turnengineoff();

    if ( level.currentgen )
        level.heli_squad_01 thread tff_cleanup_vehicle( "intro" );
}

spawn_ambient_warbird( var_0, var_1, var_2, var_3 )
{
    var_4 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( var_0 );
    var_4 vehicle_scripts\_xh9_warbird::cloak_warbird();
    var_4 setmaxpitchroll( var_1, var_2 );
    var_4 vehicle_scripts\_xh9_warbird::set_cloak_parameter( 0.0, 0.0 );

    if ( isdefined( var_3 ) )
        var_4.script_vehicle_selfremove = var_3;

    var_4.shadow_tag = common_scripts\utility::spawn_tag_origin();
    var_4.shadow_tag linkto( var_4, "tag_origin", ( 0, 0, 0 ), ( -90, 0, 0 ) );
    playfxontag( common_scripts\utility::getfx( "warbird_shadow_cloaked" ), var_4.shadow_tag, "tag_origin" );
    return var_4;
}

add_warbird_cargo( var_0, var_1 )
{
    var_2 = getent( var_0, "targetname" );
    var_2 linkto( self );
    var_3 = getent( var_1, "targetname" );
    var_3 linkto( self );
    self waittill( "death" );
    var_2 unlink();
    var_2 delete();
    var_3 unlink();
    var_3 delete();
}

fly_in_squad_uncloak()
{
    wait 3.5;
    level.heli_squad_01 thread uncloak_ambient_warbird( level.shadow_tag_01, 3.3 );
    wait 0.15;
    level.heli_squad_09 thread uncloak_ambient_warbird( level.shadow_tag_09, 3.3 );
    wait 0.15;
    level.heli_squad_11 thread uncloak_ambient_warbird( level.shadow_tag_11, 3.3 );
    wait 0.15;
    level.heli_squad_06 thread uncloak_ambient_warbird( level.shadow_tag_06, 3.3 );
    wait 0.15;
    level.heli_squad_07 thread uncloak_ambient_warbird( level.shadow_tag_07, 3.3 );
    wait 0.15;
    level.heli_squad_08 thread uncloak_ambient_warbird( level.shadow_tag_08, 3.3 );
    wait 0.15;
    level.heli_squad_05 thread uncloak_ambient_warbird( level.shadow_tag_05, 3.3 );
    wait 0.15;
    wait 0.15;
    level.heli_squad_03 thread uncloak_ambient_warbird( level.shadow_tag_03, 3.3 );
    wait 1.25;
    level.heli_squad_02 thread uncloak_ambient_warbird( level.shadow_tag_02, 3.3 );
    common_scripts\utility::flag_wait( "fx_flak_intro" );
    level.heli_squad_01 clean_up_shadow_tag();
    level.heli_squad_02 clean_up_shadow_tag();
    level.heli_squad_03 clean_up_shadow_tag();
    level.heli_squad_05 clean_up_shadow_tag();
    level.heli_squad_06 clean_up_shadow_tag();
    level.heli_squad_07 clean_up_shadow_tag();
    level.heli_squad_08 clean_up_shadow_tag();
    level.heli_squad_09 clean_up_shadow_tag();
    level.heli_squad_11 clean_up_shadow_tag();
}

uncloak_ambient_warbird( var_0, var_1 )
{
    var_2 = 3.3;

    if ( isdefined( var_1 ) )
        var_1 = var_2;

    vehicle_scripts\_xh9_warbird::uncloak_warbird( var_1 );

    if ( isdefined( self.shadow_tag ) )
    {
        stopfxontag( common_scripts\utility::getfx( "warbird_shadow_cloaked" ), self.shadow_tag, "tag_origin" );
        playfxontag( common_scripts\utility::getfx( "warbird_shadow" ), self.shadow_tag, "tag_origin" );
    }
}

clean_up_shadow_tag()
{
    if ( isdefined( self.shadow_tag ) )
    {
        stopfxontag( common_scripts\utility::getfx( "warbird_shadow" ), self.shadow_tag, "tag_origin" );
        self.shadow_tag delete();
    }
}

fly_in_ambient_jets()
{
    level.jets = [];
    thread spawn_looping_jets( "f15_01" );
    thread spawn_looping_jets( "f15_03" );
    thread spawn_looping_jets( "f15_06" );
    wait 1;
    thread spawn_looping_jets( "f15_05" );
}

spawn_looping_jets( var_0 )
{
    while ( !common_scripts\utility::flag( "flag_combat_zip_rooftop_complete" ) )
    {
        var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( var_0 );
        level.jets = common_scripts\utility::array_removeundefined( level.jets );
        level.jets[level.jets.size] = var_1;
        var_1 waittill( "death" );
    }
}

fly_in_ambient_street_jets()
{
    common_scripts\utility::flag_wait( "player_fly_in_done" );

    if ( !isdefined( level.jets ) )
        level.jets = [];

    while ( level.jets.size > 0 )
    {
        level.jets = common_scripts\utility::array_removeundefined( level.jets );
        waitframe();
    }

    thread spawn_looping_street_jets( "f15_street01" );
    wait 0.5;
    thread spawn_looping_street_jets( "f15_street03" );
    wait 0.5;
    thread spawn_looping_street_jets( "f15_street05" );
    wait 0.5;
    thread spawn_looping_street_jets( "f15_street07" );
}

spawn_looping_street_jets( var_0 )
{
    while ( !common_scripts\utility::flag( "flag_player_at_reactor_entrance" ) )
    {
        var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( var_0 );
        level.jets = common_scripts\utility::array_removeundefined( level.jets );
        level.jets[level.jets.size] = var_1;
        var_1 soundscripts\_snd::snd_message( "snd_start_ambient_jet" );
        var_1 waittill( "death" );
    }

    level.jets = common_scripts\utility::array_removeundefined( level.jets );
}

wait_to_decloak_helicopter( var_0, var_1, var_2, var_3, var_4 )
{
    level.player endon( "death" );
    wait(var_0);
    soundscripts\_snd::snd_message( "decloak_intro_helicopter" );
    thread vehicle_scripts\_xh9_warbird::uncloak_warbird( 3.0 );
    wait 1.5;
    var_1 show();
    var_2 show();
    var_3 show();
    var_4 show();
    var_1 stopusingheroonlylighting();
    var_2 stopusingheroonlylighting();
    var_3 stopusingheroonlylighting();
    var_4 stopusingheroonlylighting();
}

#using_animtree("generic_human");

burke_rooftop_combat( var_0, var_1 )
{
    if ( common_scripts\utility::flag( "flag_burke_zip" ) )
        return;

    var_0 maps\_anim::anim_single_solo( level.burke, "burke_rooftop_shoot_enter" );
    level.burke.face_direction = anglestoforward( level.burke.angles );
    level.burke notify( "killanimscript" );
    level.burke.custom_animscript["combat"] = ::burke_rooftop_combat_animscript;
    level.burke.custom_animscript["stop"] = ::burke_rooftop_combat_animscript;
    common_scripts\utility::flag_wait( "flag_burke_zip" );
    level.burke.custom_animscript["combat"] = undefined;
    level.burke.custom_animscript["stop"] = undefined;
    level.burke notify( "killanimscript" );
    level.burke clearanim( %burke_aiming, 0.2 );
    level.burke clearanim( %burke_add_fire, 0.2 );
    level.burke.last_pitch_aim = undefined;
    level.burke.last_yaw_aim = undefined;
    level.burke.face_direction = undefined;
}

burke_rooftop_combat_animscript()
{
    self notify( "killanimscript" );
    self endon( "killanimscript" );
    level.burke orientmode( "face direction", level.burke.face_direction );
    setup_burke_aim_anims();
    var_0 = undefined;

    for (;;)
    {
        if ( !isdefined( var_0 ) || !isalive( var_0 ) )
        {
            if ( isdefined( self.enemy ) && self cansee( self.enemy ) && isalive( self.enemy ) )
                var_0 = self.enemy;
        }

        if ( isdefined( var_0 ) )
        {
            var_1 = animscripts\shared::getshootfrompos();
            var_2 = var_0 getshootatpos();
            var_3 = var_2 - var_1;
            var_4 = vectortoangles( var_3 );
            var_5 = aim_burke_at_angles( var_4, 48 );

            if ( var_5 )
            {
                var_6 = randomintrange( 2, 4 );

                for ( var_7 = 0; var_7 < var_6; var_7++ )
                {
                    burke_burst_shoot( var_0 );
                    wait(randomfloatrange( 0.2, 0.4 ));
                }

                wait(randomfloatrange( 3, 5 ));
            }
        }

        if ( common_scripts\utility::cointoss() )
            var_0 = undefined;

        wait 0.05;
    }
}

setup_burke_aim_anims()
{
    self clearanim( %root, 0.2 );
    self setanim( %fusion_fly_in_burke_aim_5, 1, 0.2, 1 );
    self setanimlimited( %fusion_fly_in_burke_aim_4, 1, 0, 1 );
    self setanimlimited( %fusion_fly_in_burke_aim_6, 1, 0, 1 );
    self setanimlimited( %fusion_fly_in_burke_aim_2, 1, 0, 1 );
    self setanimlimited( %fusion_fly_in_burke_aim_8, 1, 0, 1 );
    self setanimlimited( %burke_aim_4, 0, 0, 1 );
    self setanimlimited( %burke_aim_6, 0, 0, 1 );
    self setanimlimited( %burke_aim_2, 0, 0, 1 );
    self setanimlimited( %burke_aim_8, 0, 0, 1 );
    self setanim( %fusion_fly_in_burke_aim_idle, 1, 0, 1 );
}

aim_burke_at_angles( var_0, var_1 )
{
    var_2 = 1;

    if ( !isdefined( self.last_pitch_aim ) )
        self.last_pitch_aim = 0;

    if ( !isdefined( self.last_yaw_aim ) )
        self.last_yaw_aim = 0;

    var_3 = angleclamp180( var_0[0] - self.angles[0] );

    if ( abs( var_3 ) > var_1 )
        var_3 = 0;

    var_4 = var_3 / var_1;
    var_5 = var_4 - self.last_pitch_aim;

    if ( abs( var_5 ) > 0.2 )
    {
        var_2 = 0;
        var_5 = clamp( var_5, -0.2, 0.2 );
        var_4 = self.last_pitch_aim + var_5;
    }

    if ( var_4 < 0 )
    {
        self setanimlimited( %burke_aim_8, abs( var_4 ), 0.2, 1 );
        self setanimlimited( %burke_aim_2, 0, 0.2, 1 );
    }
    else
    {
        self setanimlimited( %burke_aim_8, 0, 0.2, 1 );
        self setanimlimited( %burke_aim_2, var_4, 0.2, 1 );
    }

    var_6 = angleclamp180( var_0[1] - self.angles[1] );

    if ( abs( var_6 ) > var_1 )
        var_6 = 0;

    var_7 = var_6 / var_1;
    var_8 = var_7 - self.last_yaw_aim;

    if ( abs( var_8 ) > 0.2 )
    {
        var_2 = 0;
        var_8 = clamp( var_8, -0.2, 0.2 );
        var_7 = self.last_yaw_aim + var_8;
    }

    if ( var_7 < 0 )
    {
        self setanimlimited( %burke_aim_6, abs( var_7 ), 0.2, 1 );
        self setanimlimited( %burke_aim_4, 0, 0.2, 1 );
    }
    else
    {
        self setanimlimited( %burke_aim_6, 0, 0.2, 1 );
        self setanimlimited( %burke_aim_4, var_7, 0.2, 1 );
    }

    self.last_pitch_aim = var_4;
    self.last_yaw_aim = var_7;
    return var_2;
}

burke_burst_shoot( var_0 )
{
    var_1 = randomintrange( 2, 4 );

    for ( var_2 = 0; var_2 < var_1; var_2++ )
    {
        self shoot();
        self setanimrestart( %fusion_fly_in_burke_fire, 1, 0, 1 );
        wait 0.1;
    }
}

start_rooftop_combat()
{
    common_scripts\utility::flag_set( "flag_combat_zip_rooftop_start" );
    maps\_utility::autosave_by_name();
    wait 2;
    level.player enableweapons();
    level.player enablehybridsight( "iw5_bal27_sp_variablereddot", 1 );
    level.player enableoffhandweapons();
    level maps\_utility::_setsaveddvar( "ammoCounterHide", 0 );
    maps\_player_exo::player_exo_activate();
    thread handle_disabling_sonic_blast();
}

handle_disabling_sonic_blast()
{
    var_0 = maps\_player_exo::player_exo_get_owned_array( [ "sonic_blast" ] );

    if ( var_0.size > 0 )
    {
        maps\_player_exo::player_exo_remove_array( var_0 );
        common_scripts\utility::flag_wait( "player_fly_in_done" );
        maps\_player_exo::player_exo_add_single( "sonic_blast" );
    }
}

rooftop_strafe()
{
    var_0 = common_scripts\utility::getstruct( "path_rooftop_strafe", "targetname" );
    level.heli_squad_01 thread maps\_utility::vehicle_dynamicpath( var_0, 0 );
    level.heli_squad_01 setmaxpitchroll( 10, 10 );
    common_scripts\utility::flag_wait_or_timeout( "flag_player_cleared_rooftop", 15.0 );
    common_scripts\utility::flag_set( "flag_rooftop_strafe" );
    level.heli_squad_01 soundscripts\_snd::snd_message( "rooftop_strafe_start" );
    level.heli_squad_01 thread warbird_shooting_think( 1 );
    wait 1;
    level.heli_squad_01 notify( "warbird_fire" );
    common_scripts\utility::flag_wait( "flag_combat_zip_rooftop_complete" );
    level.heli_squad_01 notify( "warbird_stop_firing" );
}

delete_rooftop_los_blockers()
{
    var_0 = getentarray( "street_rooftop_los_blocker", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 delete();
}

allow_player_zip()
{
    wait 8.9;
    common_scripts\utility::flag_wait( "flag_combat_zip_rooftop_complete" );
    common_scripts\utility::flag_set( "player_can_zip" );
}

burke_fastzip_scene( var_0, var_1 )
{
    common_scripts\utility::flag_wait( "flag_burke_zip" );
    var_1 notify( "stop_idle" );
    var_0 notify( "stop_idle" );
    thread burke_fastzip_aim_turret( var_1, "tag_turret_zipline_fl" );
    var_2 = var_1.zipline_gun_model["tag_turret_zipline_fl"];
    var_2 unlink();
    level.burke unlink();
    thread burke_rally_init();
    thread allow_player_zip();
    level.burke maps\_utility::anim_stopanimscripted();
    var_0 thread maps\_anim::anim_single_solo_run( level.burke, "burke_intro_zip" );
    var_3 = [ var_1, var_2 ];
    var_0 maps\_anim::anim_single( var_3, "burke_intro_zip" );
    common_scripts\utility::flag_set( "burke_fastzip_done" );
    var_4 = [ var_1, var_2 ];
    var_0 thread maps\_anim::anim_loop( var_4, "burke_intro_zip_loop", "stop_loop" );
    thread heroes_post_zip();
    thread allies_rally_init();
    common_scripts\utility::flag_wait( "player_fly_in_done" );
    var_0 notify( "stop_loop" );
    var_2 linkto( var_1, "tag_turret_zipline_fl", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

#using_animtree("script_model");

burke_fastzip_aim_turret( var_0, var_1 )
{
    var_2 = var_0.zipline_gun_model[var_1];
    var_3 = var_0 vehicle_scripts\_xh9_warbird::spawn_zipline_turret( "zipline_gun_rope", var_1, var_2.rope_model, "_turret_fastzip" );
    var_3 hide();
    var_4 = common_scripts\utility::spawn_tag_origin();
    var_4.origin = var_2 gettagorigin( "jnt_harpoon" );
    var_3 settargetentity( var_4 );

    while ( !common_scripts\utility::flag( "burke_fastzip_done" ) )
    {
        var_4.origin = var_2 gettagorigin( "jnt_harpoon" );
        wait 0.1;
    }

    var_4.origin = var_2 gettagorigin( "jnt_harpoon" );
    var_5 = var_2 gettagorigin( "tag_flash" );
    var_6 = distance( var_5, var_4.origin ) / 12;
    var_7 = var_6 / 200;
    var_8 = %fastzip_launcher_fire_right;
    var_3 setanimknob( var_8, 1, 0, 0 );
    var_3 setanimtime( var_8, var_7 );

    if ( isdefined( var_2.rope_model ) )
        var_2 detach( var_2.rope_model );

    var_3 show();
    var_3 maps\_player_fastzip::retract_rope( var_6, "right" );
    var_4 delete();
    var_3 delete();
}

burke_rally_init()
{
    level.burke maps\_utility::set_force_color( "g" );
    level.burke maps\_utility::disable_ai_color();
    var_0 = getnode( "node_cover_burke_after_zip", "targetname" );
    level.burke maps\fusion_utility::goto_node( var_0, 0 );
    thread courtyard_burke_rally();
}

allies_rally_init()
{
    level.joker maps\_utility::disable_ai_color();
    var_0 = getnode( "node_cover_joker_after_zip", "targetname" );
    level.joker maps\fusion_utility::goto_node( var_0, 0 );
}

move_squad_and_walkers()
{
    level.player endon( "death" );
    common_scripts\utility::flag_wait( "ready_zip" );
    maps\_utility::activate_trigger_with_targetname( "trig_move_squad_from_heli" );
}

setup_m_turret()
{
    maps\_vehicle_shg::set_player_rig_spawn_function( ::spawn_player_anim_rig );

    if ( level.currentgen )
    {
        if ( level.start_point != "fly_in_animated" && level.start_point != "fly_in_animated_part2" && level.start_point != "courtyard" && level.start_point != "security_room" )
            return;
    }

    level.x4walker_wheels_fusion_turret = 1;
    var_0 = getentarray( "mobile_turret", "targetname" );
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        var_4 = var_3 maps\_utility::spawn_vehicle();
        var_4 thread monitor_mobile_turret_health();
        var_4 thread disable_cover_drone_on_mobile_turret_mount();
        var_4 thread close_enemy_check_on_mt_exit();
        var_4 thread disable_mobile_turret_if_not_destroyed();
        var_4.godmode = 1;
        var_1[var_1.size] = var_4;
    }

    if ( level.currentgen )
    {
        level waittill( "tff_pre_transition_intro_to_middle" );
        common_scripts\utility::array_call( var_1, ::delete );
    }
}

disable_cover_drone_on_mobile_turret_mount()
{
    level.player endon( "death" );

    for (;;)
    {
        level.player waittill( "player_starts_entering_mobile_turret" );
        thread maps\fusion_lighting::setup_dof_enter_turret();
        level.player.disable_cover_drone = 1;
        level.player waittill( "player_exited_mobile_turret" );
        thread maps\fusion_lighting::setup_dof_exit_turret();
        level.player.disable_cover_drone = undefined;
    }
}

wait_for_drone_message_or_death( var_0 )
{
    var_0 endon( "death" );
    level.player waittill( "hiding_cover_drone_hint", var_1 );
    return var_1;
}

close_enemy_check_on_mt_exit()
{
    for (;;)
    {
        level.player waittill( "player_exited_mobile_turret" );
        var_0 = getaiarray( "axis" );
        var_0 = maps\_utility::array_removedead_or_dying( var_0 );

        foreach ( var_2 in var_0 )
        {
            if ( isdefined( var_2 ) && isalive( var_2 ) )
            {
                if ( distancesquared( level.player.origin, var_2.origin ) < squared( 100 ) )
                {
                    var_2 maps\fusion_utility::bloody_death( 0 );
                    continue;
                }

                if ( distancesquared( level.player.origin, var_2.origin ) < squared( 250 ) )
                    var_2 maps\fusion_utility::bloody_death( randomfloatrange( 0.5, 1 ) );
            }
        }
    }
}

setup_personal_drone()
{
    var_0 = getent( "player_pdrone", "targetname" );
    level.player thread maps\_weapon_pdrone::give_player_pdrone( var_0 );
}

setup_ally_squad()
{
    if ( level.currentgen )
        return;

    common_scripts\utility::flag_wait( "street_combat_start" );
    var_0 = getentarray( "allies_street", "script_noteworthy" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) )
            var_2 maps\_utility::spawn_ai( 1 );
    }

    var_4 = getaiarray( "allies" );

    foreach ( var_6 in var_4 )
    {
        if ( isdefined( var_6 ) )
        {
            if ( !isdefined( var_6.magic_bullet_shield ) )
                var_6 thread maps\_utility::deletable_magic_bullet_shield();
        }
    }
}

road_battle_setup()
{
    thread setup_triggers_street_battle();
    thread setup_cover_nodes_street();
    thread combat_zip_rooftop();
    common_scripts\utility::flag_wait( "street_combat_start" );
    thread biasgroup_think();

    if ( level.nextgen )
        thread moblie_turrets_intro();

    thread street_volume_manager();
    thread combat_street_wave_01();
    thread combat_street_wave_02();
    thread combat_street_wave_03();
    thread combat_street_mid_checkpoint_1();
    thread combat_street_mid_checkpoint_2();
    thread combat_street_blown_building();
    thread combat_player_in_m_turret();
    thread combat_street_wave_04();
    thread combat_street_initial();
    thread combat_street_wave_rear();
    thread combat_enemy_trans_heli_wave_01();
    thread combat_enemy_tank();
    thread rpg_at_heli();
    thread wall_explosion_01();
    thread building_explosion_01();
    thread courtyard_mobile_cover_guys();
    thread courtyard_ally_mcd_safeguard_init();
    thread boost_jump_hint();

    if ( level.nextgen )
        thread street_mobile_cover_guys();

    thread mobile_turret_dropoff();
    thread smaw_laser_think();
}

boost_jump_hint()
{
    level.player endon( "player_starts_entering_mobile_turret" );
    common_scripts\utility::flag_wait( "flag_obj_markers" );
    wait 1;
    common_scripts\utility::flag_wait( "flag_boost_jump_reminder_dialogue_done" );
    maps\_utility::hintdisplaymintimehandler( "hint_use_boost", 5 );
}

boost_use_hint()
{
    if ( isdefined( level.player.drivingvehicleandturret ) || level.player ishighjumping() )
        return 1;

    return 0;
}

biasgroup_think()
{
    level.player setthreatbiasgroup( "player" );
    createthreatbiasgroup( "drones" );
    setthreatbias( "drones", "axis_street", -20000 );
    common_scripts\utility::flag_wait( "flag_enemy_bullet_shield_off" );
    setthreatbias( "player", "axis_street", 8000 );
    common_scripts\utility::flag_wait( "flag_enemy_walker" );
    setthreatbias( "player", "axis_street", 0 );

    while ( !common_scripts\utility::flag( "elevator_descent_player" ) )
    {
        if ( common_scripts\utility::flag( "flag_player_at_reactor_door" ) )
            setthreatbias( "player", "axis_street", -20000 );
        else
            setthreatbias( "player", "axis_street", 0 );

        wait 1;
    }

    setthreatbias( "player", "axis_street", 0 );
}

setup_triggers_street_battle()
{
    var_0 = getent( "color_t_street_end", "targetname" );
    var_0 common_scripts\utility::trigger_off();
    var_1 = getent( "color_t_walker_destroyed", "targetname" );
    var_1 common_scripts\utility::trigger_off();
    var_2 = getent( "color_t_mt_destroyed", "targetname" );
    var_2 common_scripts\utility::trigger_off();
    common_scripts\utility::flag_wait_all( "flag_mt_wall_rpg_impact", "flag_mt_move_up_02" );
    wait 1;
    var_2 common_scripts\utility::trigger_on();
    maps\_utility::activate_trigger_with_targetname( "color_t_mt_destroyed" );
    var_3 = getentarray( "bcs_titan", "targetname" );

    foreach ( var_5 in var_3 )
        var_5 common_scripts\utility::trigger_off();

    common_scripts\utility::flag_wait( "flag_enemy_walker" );

    if ( isdefined( var_2 ) )
        var_2 common_scripts\utility::trigger_off();

    wait 3;

    foreach ( var_5 in var_3 )
        var_5 common_scripts\utility::trigger_on();

    var_9 = getentarray( "bcs_hill", "targetname" );

    foreach ( var_5 in var_9 )
        var_5 common_scripts\utility::trigger_off();
}

setup_cover_nodes_street()
{
    var_0 = getnodearray( "cover_node_walker_hill", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 disconnectnode();

    common_scripts\utility::flag_wait( "flag_enemy_walker" );

    foreach ( var_2 in var_0 )
        var_2 connectnode();
}

moblie_turrets_intro()
{
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname( "ally_walker_02" );
    var_0 thread maps\fusion_utility::kill_path_on_death();
    var_0 soundscripts\_snd::snd_message( "spawn_ally_walker_02" );
    var_0 maps\_vehicle::godon();
    var_1 = getent( "clip_mobile_turret_player", "targetname" );
    var_1 linkto( var_0 );
    common_scripts\utility::flag_wait( "ready_zip" );
    var_2 = [ var_0 ];

    foreach ( var_4 in var_2 )
    {
        if ( isdefined( var_4.riders ) )
        {
            foreach ( var_6 in var_4.riders )
            {
                if ( isdefined( var_6.deletable_magic_bullet_shield ) )
                    var_6 maps\_utility::stop_magic_bullet_shield();
            }
        }
    }

    var_0 maps\_utility::delaythread( 2, ::mobile_turret_gopath );
    common_scripts\utility::flag_wait( "flag_mt_move_up_03" );
    var_0 maps\_vehicle::godoff();

    if ( level.currentgen )
    {
        level waittill( "tff_pre_transition_intro_to_middle" );
        var_0 delete();
    }
}

mobile_turret_gopath()
{
    self endon( "death" );
    maps\_vehicle::gopath();
    wait 0.1;

    for (;;)
    {
        level.player waittill_pushed_by( self );
        self vehicle_setspeed( 0, 60, 60 );
        var_0 = distancesquared( level.player.origin, self.origin );

        for ( var_1 = var_0 * 2; var_0 < var_1; var_0 = distancesquared( level.player.origin, self.origin ) )
            wait 0.1;

        self resumespeed( 1 );
    }
}

waittill_pushed_by( var_0 )
{
    thread monitor_player_pushed( var_0 );
    thread monitor_player_unresolved( var_0 );
    thread monitor_player_pushed_while_linked( var_0 );

    for (;;)
    {
        self waittill( "notify_push", var_1 );

        if ( var_0 == var_1 )
            break;
    }

    self notify( "kill_push_monitor" );
}

monitor_player_pushed( var_0 )
{
    self endon( "kill_push_monitor" );
    var_0 endon( "death" );

    for (;;)
    {
        self waittill( "player_pushed", var_1, var_2 );
        self notify( "notify_push", var_2 );
    }
}

monitor_player_unresolved( var_0 )
{
    self endon( "kill_push_monitor" );
    var_0 endon( "death" );

    for (;;)
    {
        self waittill( "unresolved_collision", var_1 );
        self notify( "notify_push", var_1 );
    }
}

monitor_player_pushed_while_linked( var_0 )
{
    self endon( "kill_push_monitor" );
    var_0 endon( "death" );

    for (;;)
    {
        var_1 = 200;
        var_2 = 80;
        var_3 = cos( var_2 );

        while ( self islinked() )
        {
            var_4 = anglestoforward( var_0.angles );
            var_5 = vectornormalize( level.player.origin - var_0.origin );

            if ( vectordot( var_4, var_5 ) >= var_3 && distance( self.origin, var_0.origin ) < var_1 )
            {
                self notify( "notify_push", var_0 );
                return;
            }

            wait 0.1;
        }

        wait 0.05;
    }
}

monitor_turret_2_death()
{
    self waittill( "death" );
    common_scripts\utility::flag_set( "flag_m_turret_dead" );
}

rooftop_enemy_think()
{
    thread rooftop_enemy_counter();
    self endon( "death" );
    maps\_utility::set_baseaccuracy( 0.5 );
    maps\fusion_utility::disable_grenades();
    maps\_utility::disable_long_death();
    common_scripts\utility::flag_wait( "flag_combat_zip_rooftop_complete" );
    maps\fusion_utility::bloody_death( 2 );
}

rooftop_enemy_think_left()
{
    thread rooftop_enemy_counter();
    self endon( "death" );
    maps\_utility::set_baseaccuracy( 0.5 );
    maps\fusion_utility::disable_grenades();
    maps\_utility::disable_long_death();

    if ( level.currentgen )
    {
        wait 3;
        var_0 = getnode( "enemy_street_zip_rooftop_goal_node_left", "script_noteworthy" );
        maps\_utility::set_goal_node( var_0 );
        maps\_utility::set_goal_radius( 256 );
    }

    common_scripts\utility::flag_wait( "flag_combat_zip_rooftop_complete" );
    maps\fusion_utility::bloody_death( 2 );
}

rooftop_enemy_think_right()
{
    thread rooftop_enemy_counter();
    self endon( "death" );
    maps\_utility::set_baseaccuracy( 0.5 );
    maps\fusion_utility::disable_grenades();
    maps\_utility::disable_long_death();

    if ( level.currentgen )
    {
        wait 3;
        var_0 = getnode( "enemy_street_zip_rooftop_goal_node_right", "script_noteworthy" );
        maps\_utility::set_goal_node( var_0 );
        maps\_utility::set_goal_radius( 256 );
    }

    common_scripts\utility::flag_wait( "flag_combat_zip_rooftop_complete" );
    maps\fusion_utility::bloody_death( 2 );
}

rooftop_enemy_counter()
{
    level endon( "flag_combat_zip_rooftop_complete" );
    level endon( "player_participated_in_rooftop_fight" );
    self waittill( "death", var_0 );

    if ( var_0 == level.player )
        common_scripts\utility::flag_set( "player_participated_in_rooftop_fight" );
}

street_enemy_think()
{
    self endon( "death" );
    self setthreatbiasgroup( "axis_street" );
    var_0 = getent( "vol_street_battle_01_left", "targetname" );
    var_1 = getent( "vol_street_battle_01_right", "targetname" );
    var_2 = [ var_0, var_1 ];
    street_set_volume_from_pair( var_2 );
    common_scripts\utility::flag_wait( "flag_mt_move_up_03" );
    var_0 = getent( "vol_street_battle_02_left", "targetname" );
    var_1 = getent( "vol_street_battle_02_right", "targetname" );
    var_2 = [ var_0, var_1 ];
    street_set_volume_from_pair( var_2 );
    common_scripts\utility::flag_wait( "flag_mt_move_up_05" );
    var_0 = getent( "vol_street_battle_03_left", "targetname" );
    var_1 = getent( "vol_street_battle_03_right", "targetname" );
    var_2 = [ var_0, var_1 ];
    street_set_volume_from_pair( var_2 );
    common_scripts\utility::flag_wait( "flag_obj_01_pos_update_02" );
    var_0 = getent( "vol_street_battle_reactor_entrance_left", "targetname" );
    var_1 = getent( "vol_street_battle_reactor_entrance_right", "targetname" );
    var_2 = [ var_0, var_1 ];
    street_set_volume_from_pair( var_2 );
    common_scripts\utility::flag_wait( "flag_enemy_walker" );
    self.grenadeammo = 0;
    thread walker_death_courtyard_kva_cleanup();
    common_scripts\utility::flag_wait( "flag_walker_destroyed" );

    if ( !isdefined( self.playerseeker ) )
    {
        self cleargoalvolume();
        self setgoalvolumeauto( getent( "vol_street_battle_reactor_entrance", "targetname" ) );
    }

    common_scripts\utility::flag_wait( "flag_player_at_reactor_entrance" );

    if ( !isdefined( self.playerseeker ) )
    {
        self cleargoalvolume();
        self setgoalvolumeauto( getent( "vol_street_battle_reactor_entrance_end", "targetname" ) );
    }
}

street_enemy_blown_building_think()
{
    self endon( "death" );
    self setthreatbiasgroup( "axis_street" );

    if ( !isdefined( self.playerseeker ) )
    {
        self cleargoalvolume();
        self setgoalvolumeauto( getent( "vol_street_battle_02_left", "targetname" ) );
    }

    common_scripts\utility::flag_wait( "flag_spawn_gaz_01" );
    var_0 = getent( "vol_street_battle_03_left", "targetname" );
    var_1 = getent( "vol_street_battle_03_right", "targetname" );
    var_2 = [ var_0, var_1 ];
    street_set_volume_from_pair( var_2 );
    common_scripts\utility::flag_wait( "flag_obj_01_pos_update_02" );
    var_0 = getent( "vol_street_battle_reactor_entrance_left", "targetname" );
    var_1 = getent( "vol_street_battle_reactor_entrance_right", "targetname" );
    var_2 = [ var_0, var_1 ];
    street_set_volume_from_pair( var_2 );
    thread walker_death_courtyard_kva_cleanup();
    common_scripts\utility::flag_wait( "flag_walker_destroyed" );

    if ( !isdefined( self.playerseeker ) )
    {
        self cleargoalvolume();
        self setgoalvolumeauto( getent( "vol_street_battle_reactor_entrance", "targetname" ) );
    }

    common_scripts\utility::flag_wait( "flag_player_at_reactor_entrance" );

    if ( !isdefined( self.playerseeker ) )
    {
        self cleargoalvolume();
        self setgoalvolumeauto( getent( "vol_street_battle_reactor_entrance_end", "targetname" ) );
    }
}

street_volume_manager()
{
    var_0 = getent( "vol_street_battle_01_left", "targetname" );
    var_1 = getent( "vol_street_battle_01_right", "targetname" );
    var_2 = [ var_0, var_1 ];
    street_enemy_movement( "flag_mt_move_up_03", 2, 5, var_2 );
    var_0 = getent( "vol_street_battle_02_left", "targetname" );
    var_1 = getent( "vol_street_battle_02_right", "targetname" );
    var_2 = [ var_0, var_1 ];
    street_enemy_movement( "flag_mt_move_up_05", 2, 5, var_2 );
    var_0 = getent( "vol_street_battle_03_left", "targetname" );
    var_1 = getent( "vol_street_battle_03_right", "targetname" );
    var_2 = [ var_0, var_1 ];
    street_enemy_movement( "flag_obj_01_pos_update_02", 2, 5, var_2 );
    var_0 = getent( "vol_street_battle_reactor_entrance_left", "targetname" );
    var_1 = getent( "vol_street_battle_reactor_entrance_right", "targetname" );
    var_2 = [ var_0, var_1 ];
    street_enemy_movement( "flag_walker_destroyed", 8, 20, var_2 );
}

walker_death_courtyard_kva_cleanup()
{
    self endon( "death" );
    common_scripts\utility::flag_wait( "flag_walker_destroyed" );
    var_0 = getnodearray( "walker_retreat_point", "targetname" );

    if ( level.nextgen )
        maps\fusion_utility::bloody_death( 10 );
    else
        thread walker_death_courtyard_kva_cleanup_cg( var_0 );
}

walker_death_courtyard_kva_cleanup_cg( var_0 )
{
    self endon( "death" );
    var_1 = 200;
    var_2 = distance2d( self.origin, level.player.origin );

    if ( var_2 < var_1 )
        thread maps\_utility::player_seek_enable();
    else
    {
        var_0 = common_scripts\utility::array_randomize( var_0 );
        self setgoalnode( var_0[0] );
        self waittill( "goal" );
        self kill();
    }
}

street_set_volume_from_pair( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    var_1 = undefined;

    if ( isarray( var_0 ) )
    {
        if ( common_scripts\utility::cointoss() )
        {
            var_1 = var_0[0];

            if ( self istouching( var_1 ) )
                var_1 = var_0[1];
        }
        else
        {
            var_1 = var_0[1];

            if ( self istouching( var_1 ) )
                var_1 = var_0[0];
        }
    }

    if ( !isdefined( self.playerseeker ) )
    {
        if ( isdefined( var_1 ) )
        {
            self cleargoalvolume();
            self setgoalvolumeauto( var_1 );
        }
    }
}

street_enemy_movement( var_0, var_1, var_2, var_3 )
{
    level.player endon( "death" );
    level endon( var_0 );

    if ( !isdefined( var_1 ) )
        var_1 = 5;

    if ( !isdefined( var_2 ) )
        var_2 = 15;

    while ( !common_scripts\utility::flag( var_0 ) )
    {
        wait(randomfloatrange( var_1, var_2 ));
        var_4 = [];

        foreach ( var_6 in var_3 )
        {
            var_7 = var_6 maps\_utility::get_ai_touching_volume( "axis" );

            if ( var_7.size > 0 )
                var_4 = common_scripts\utility::array_combine( var_4, var_7 );
        }

        if ( var_4.size > 0 )
        {
            var_9 = var_4[randomint( var_4.size )];
            var_9 street_set_volume_from_pair( var_3 );
        }
    }
}

mover_debug_text()
{
    self endon( "death" );
    var_0 = 5;

    while ( var_0 > 0 )
    {
        var_0 -= 0.05;
        wait 0.05;
    }
}

street_enemy_tank_battle_think()
{
    self endon( "death" );

    if ( !isdefined( self.playerseeker ) )
        self setgoalvolumeauto( getent( "vol_street_tank_stage_01", "targetname" ) );

    common_scripts\utility::flag_wait( "flag_enemy_walker" );
    self.grenadeammo = 0;
    thread walker_death_courtyard_kva_cleanup();
    common_scripts\utility::flag_wait( "flag_walker_destroyed" );

    if ( !isdefined( self.playerseeker ) )
    {
        self cleargoalvolume();
        self setgoalvolumeauto( getent( "vol_street_battle_reactor_entrance", "targetname" ) );
    }

    common_scripts\utility::flag_wait( "flag_player_at_reactor_entrance" );

    if ( !isdefined( self.playerseeker ) )
    {
        self cleargoalvolume();
        self setgoalvolumeauto( getent( "vol_street_battle_reactor_entrance_end", "targetname" ) );
    }
}

street_enemy_tank_damaged_think()
{
    self endon( "death" );
    self.grenadeammo = 0;
    common_scripts\utility::flag_wait( "walker_damaged" );

    if ( !isdefined( self.playerseeker ) )
    {
        self cleargoalvolume();
        self setgoalvolumeauto( getent( "vol_street_battle_reactor_entrance", "targetname" ) );
    }

    thread walker_death_courtyard_kva_cleanup();
    common_scripts\utility::flag_wait( "flag_player_at_reactor_entrance" );

    if ( !isdefined( self.playerseeker ) )
    {
        self cleargoalvolume();
        self setgoalvolumeauto( getent( "vol_street_battle_reactor_entrance_end", "targetname" ) );
    }
}

street_enemy_building_east_think()
{
    self endon( "death" );

    if ( !isdefined( self.playerseeker ) )
        self setgoalvolumeauto( getent( "vol_street_battle_rear_building_east", "targetname" ) );

    common_scripts\utility::flag_wait( "flag_obj_01_pos_update_02" );

    if ( !isdefined( self.playerseeker ) )
    {
        self cleargoalvolume();
        self setgoalvolumeauto( getent( "vol_street_battle_reactor_entrance", "targetname" ) );
    }

    common_scripts\utility::flag_wait( "flag_enemy_walker" );
    self.grenadeammo = 0;
    thread walker_death_courtyard_kva_cleanup();
    common_scripts\utility::flag_wait( "flag_player_at_reactor_entrance" );

    if ( !isdefined( self.playerseeker ) )
    {
        self cleargoalvolume();
        self setgoalvolumeauto( getent( "vol_street_battle_reactor_entrance_end", "targetname" ) );
    }
}

street_enemy_building_west_think()
{
    self endon( "death" );

    if ( !isdefined( self.playerseeker ) )
        self setgoalvolumeauto( getent( "vol_street_battle_rear_building_west", "targetname" ) );

    common_scripts\utility::flag_wait( "flag_obj_01_pos_update_02" );

    if ( !isdefined( self.playerseeker ) )
    {
        self cleargoalvolume();
        self setgoalvolumeauto( getent( "vol_street_battle_reactor_entrance", "targetname" ) );
    }

    thread walker_death_courtyard_kva_cleanup();
    common_scripts\utility::flag_wait( "flag_player_at_reactor_entrance" );

    if ( !isdefined( self.playerseeker ) )
    {
        self cleargoalvolume();
        self setgoalvolumeauto( getent( "vol_street_battle_reactor_entrance_end", "targetname" ) );
    }
}

combat_street_wave_01()
{
    if ( level.currentgen )
    {
        common_scripts\utility::flag_wait( "ready_zip" );

        if ( level.currentgen )
        {
            var_0 = [ "enemy_street_wave_01", "enemy_street_wave_02", "enemy_street_wave_mobile_cover_a", "enemy_street_wave_mobile_cover_b", "enemy_street_blown_building", "enemy_street_wave_04", "enemy_street_wave_rear", "enemy_street_tank_stage_01", "enemy_street_tank_stage_02", "enemy_street_reactor_entrance", "enemy_street_turret_wave_1", "enemy_street_turret_wave_2" ];
            thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor( "elevator_descent_player", var_0, 15, 0 );
        }
    }

    var_1 = getentarray( "enemy_street_wave_01", "script_noteworthy" );

    if ( var_1.size > 0 )
        maps\_spawner::flood_spawner_scripted( var_1 );

    foreach ( var_3 in getentarray( "enemy_street_wave_01", "script_noteworthy" ) )
    {
        if ( isalive( var_3 ) )
            var_3 maps\_utility::deletable_magic_bullet_shield();
    }

    common_scripts\utility::flag_wait( "flag_enemy_bullet_shield_off" );

    foreach ( var_3 in getentarray( "enemy_street_wave_01", "script_noteworthy" ) )
    {
        if ( isalive( var_3 ) && isdefined( var_3.magic_bullet_shield ) )
            var_3 maps\_utility::stop_magic_bullet_shield();
    }

    common_scripts\utility::flag_wait( "flag_mt_move_up_03" );
    var_1 = [ "enemy_street_wave_01" ];
    maps\fusion_utility::delete_spawners( var_1 );
}

combat_street_wave_02()
{
    common_scripts\utility::flag_wait( "flag_mt_move_up_01" );
    var_0 = getentarray( "enemy_street_wave_02", "script_noteworthy" );

    if ( var_0.size > 0 )
        maps\_spawner::flood_spawner_scripted( var_0 );

    var_0 = getentarray( "enemy_street_wave_mobile_cover_a", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 maps\_utility::spawn_ai( 1 );

    common_scripts\utility::flag_wait( "flag_mt_move_up_02" );
    var_0 = getentarray( "enemy_street_wave_mobile_cover_b", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 maps\_utility::spawn_ai( 1 );

    common_scripts\utility::flag_wait( "flag_delete_spawners_wave_02" );
    var_0 = [ "enemy_street_wave_02" ];
    maps\fusion_utility::delete_spawners( var_0 );
}

combat_street_wave_03()
{
    common_scripts\utility::flag_wait( "flag_delete_spawners_wave_02" );
    var_0 = getentarray( "enemy_street_wave_03", "script_noteworthy" );

    if ( var_0.size > 0 )
        maps\_spawner::flood_spawner_scripted( var_0 );

    common_scripts\utility::flag_wait( "flag_enemy_reinforcements_big_wave" );
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "enemy_trans_street_01" );
    var_1 thread heli_turret_death_think();
    soundscripts\_snd::snd_message( "courtyard_mi17_spawn_01", var_1 );
    var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "enemy_trans_street_02" );
    var_2 thread heli_turret_death_think();
    soundscripts\_snd::snd_message( "courtyard_mi17_spawn_02", var_2 );
    common_scripts\utility::flag_wait( "flag_mt_move_up_03" );
    var_0 = [ "enemy_street_wave_03" ];
    maps\fusion_utility::delete_spawners( var_0 );
}

combat_street_mid_checkpoint_1()
{
    level endon( "flag_enemy_walker" );
    common_scripts\utility::flag_wait( "flag_road_combat_mid_save_1" );
    maps\_utility::autosave_by_name();
}

combat_street_mid_checkpoint_2()
{
    level endon( "flag_walker_destroyed" );
    common_scripts\utility::flag_wait( "flag_road_combat_mid_save_2" );
    maps\_utility::autosave_by_name();
}

combat_street_blown_building()
{
    common_scripts\utility::flag_wait( "flag_combat_blown_building" );

    if ( !common_scripts\utility::flag( "flag_delete_spawners_wave_02" ) )
    {
        var_0 = getentarray( "enemy_street_blown_building", "script_noteworthy" );

        if ( var_0.size > 0 )
            maps\_spawner::flood_spawner_scripted( var_0 );
    }

    common_scripts\utility::flag_wait( "flag_slow_explosions_2" );
    var_0 = [ "enemy_street_blown_building" ];
    maps\fusion_utility::delete_spawners( var_0 );
}

heli_turret_death_think()
{
    level.player endon( "death" );
    level endon( "street_cleanup" );
    self waittill( "death", var_0 );
    wait 0.05;
    self notify( "crash_done" );
}

combat_player_in_m_turret()
{
    level endon( "street_cleanup" );
    level.player waittill( "player_enters_mobile_turret" );
    thread hint_mt_controls();
    maps\_utility::delaythread( 2, maps\_utility::autosave_now );
    var_0 = getentarray( "enemy_street_turret_wave_1", "script_noteworthy" );

    if ( var_0.size > 0 )
        maps\_spawner::flood_spawner_scripted( var_0 );

    var_1 = getentarray( "enemy_street_turret_wave_2", "script_noteworthy" );

    if ( var_1.size > 0 )
        maps\_spawner::flood_spawner_scripted( var_1 );

    common_scripts\utility::flag_wait( "walker_damaged" );
    var_0 = [ "enemy_street_turret_wave_1" ];
    maps\fusion_utility::delete_spawners( var_0 );
    var_1 = [ "enemy_street_turret_wave_2" ];
    maps\fusion_utility::delete_spawners( var_1 );
}

hint_mt_controls()
{
    level.player endon( "player_exited_mobile_turret" );
    wait 1.0;
    maps\_utility::hintdisplayhandler( "hint_mt_fire_missiles" );
    common_scripts\utility::flag_wait( "flag_hint_mt_control_fire_missiles_press" );
    maps\_utility::hintdisplaymintimehandler( "hint_mt_fire_missiles_release" );
}

monitor_mobile_turret_health()
{
    level.player endon( "death" );
    level endon( "street_cleanup" );
    level.player waittill( "player_starts_entering_mobile_turret" );
    common_scripts\utility::flag_set( "flag_player_starts_entering_mobile_turret" );
    level.player waittill( "player_enters_mobile_turret" );
    common_scripts\utility::flag_set( "flag_player_enters_mobile_turret" );
    thread mobile_turret_tutorial_hints();
    var_0 = getentarray( "mobile_turret_damage", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 linkto( self );

    var_4 = getent( "trig_mobile_turret_health_1", "targetname" );
    var_4 mobile_turret_health_think( self, ::mobile_turret_health_1 );
    var_4 = getent( "trig_mobile_turret_health_2", "targetname" );
    var_4 mobile_turret_health_think( self, ::mobile_turret_health_2 );
    var_4 = getent( "trig_mobile_turret_health_3", "targetname" );
    var_4 mobile_turret_health_think( self, ::mobile_turret_health_3 );
    var_4 = getent( "trig_mobile_turret_missile", "targetname" );
    var_4 mobile_turret_health_think( self, ::mobile_turret_missile );
}

mobile_turret_tutorial_hints()
{

}

mobile_turret_health_think( var_0, var_1 )
{
    level.player endon( "death" );
    var_0 endon( "death" );
    level endon( "street_cleanup" );

    for (;;)
    {
        self waittill( "trigger", var_2 );

        if ( var_2 == level.player && isdefined( var_0.player_driver ) && var_0.player_driver == level.player )
        {
            var_0 thread [[ var_1 ]]();
            break;
        }
    }
}

mobile_turret_health_1()
{
    self endon( "death" );
    self endon( "stop_mobile_turret_health_1" );
}

mobile_turret_health_2()
{
    self endon( "death" );
    self endon( "stop_mobile_turret_health_2" );
    var_0 = "mobile_turret_sparks";
    var_1 = "TAG_SPARKS_1";
    var_2 = "TAG_SPARKS_2";
    play_and_store_fx_on_tag( var_0, self, var_1 );
    wait 0.1;
    play_and_store_fx_on_tag( var_0, self, var_2 );
}

mobile_turret_health_3()
{
    self endon( "death" );
    self endon( "stop_mobile_turret_health_3" );
}

mobile_turret_missile()
{
    self endon( "death" );
    var_0 = common_scripts\utility::getstruct( "org_missile_disable_mt", "targetname" );
    var_1 = var_0.origin + anglestoforward( var_0.angles ) * 256;
    var_2 = magicbullet( "mobile_turret_missile", var_0.origin, var_1 );
    var_2 missile_settargetpos( self.mgturret[0] gettagorigin( "tag_flash" ) + anglestoforward( self.mgturret[0].angles ) * 64 );
    var_2 missile_setflightmodedirect();
    var_2 waittill( "death" );
    playfx( common_scripts\utility::getfx( "rpg_explode" ), self.mgturret[0].origin );
    var_3 = self.mgturret[0].origin;

    if ( isdefined( self.player_driver ) )
    {
        soundscripts\_snd::snd_message( "player_mobile_turret_warning" );
        var_3 = self.player_driver.origin;
        thread maps\_utility::flag_set_delayed( "flag_bailout_vo", 0.5 );
    }

    earthquake( 2.0, 1.0, var_3, 256 );
    thread mobile_turret_health_4();
}

mobile_turret_health_4()
{
    maps\_utility::ent_flag_waitopen( "player_in_transition" );

    if ( isdefined( level.player.drivingvehicleandturret ) )
    {
        var_0 = self.mgturret[0];
        level.player drivevehicleandcontrolturretoff( self );
        thread mobile_turret_burning_limit_controls( var_0 );
        thread mobile_turret_burning();
        self.burning = 1;
        var_1 = "mobile_turret_fire_large";
        var_2 = "TAG_FIRE_2";
        play_and_store_fx_on_tag( var_1, self, var_2 );
    }
    else
    {
        self.burning = 1;
        destroy_mobile_turret();
    }
}

mobile_turret_burning_limit_controls( var_0 )
{
    level.player enableslowaim( 0.005, 0.005 );
    level.player maps\_utility::set_ignoreme( 1 );
    var_0 turretfiredisable();
    self notify( "end_rocket_think" );
    self notify( "fire_missile_system" );
    self notify( "disable_missile_input" );
    self notify( "force_clear_all_turret_locks" );
    self.reticle vehicle_scripts\_x4walker_wheels_turret::reticle_hide();
    self waittill( "dismount_vehicle_and_turret" );
    level.player maps\_utility::set_ignoreme( 0 );
    level.player disableslowaim();
}

mobile_turret_burning()
{
    thread destroy_turret_when_player_leaves();
    level.player endon( "death" );
    level endon( "street_cleanup" );
    self endon( "dismount_vehicle_and_turret" );
    self notify( "play_damage_warning" );
    var_0 = 20;
    wait(var_0 - 1);
    var_1 = self.angles + ( -90, 90, 0 );
    playfx( common_scripts\utility::getfx( "fusion_vehicle_mobile_cover_explosion" ), level.player geteye() + ( 0, -50, 20 ) );
    earthquake( 1, 1.6, level.player.origin, 625 );
    wait 1;
    level.player disableinvulnerability();
    level notify( "mission failed" );
    setdvar( "ui_deadquote", &"FUSION_MOBILE_TURRET_DETROYED" );
    maps\_utility::missionfailedwrapper();
}

destroy_turret_when_player_leaves()
{
    level.player endon( "death" );
    level endon( "street_cleanup" );
    self waittill( "player_exited_mobile_turret" );
    destroy_mobile_turret();
}

destroy_mobile_turret()
{
    level.player endon( "death" );
    level endon( "street_cleanup" );
    vehicle_scripts\_x4walker_wheels_turret::make_mobile_turret_unusable();
    var_0 = 256;
    var_1 = 20;

    while ( distance( self.origin, level.player.origin ) < var_0 && var_1 >= 0 )
    {
        var_1 -= 0.05;
        wait 0.05;
    }

    self.mgturret[0] hide();
    self setmodel( "vehicle_x4walker_wheels_dstrypv" );
    playfxontag( common_scripts\utility::getfx( "mobile_turret_explosion" ), self, "tag_death_fx" );
    earthquake( 1, 1.6, self.origin, 625 );
    soundscripts\_snd::snd_message( "player_mobile_turret_explo" );
    self notify( "stop_mobile_turret_health_1" );
    self notify( "stop_mobile_turret_health_2" );
    self notify( "stop_mobile_turret_health_3" );
    self notify( "stop_mobile_turret_health_4" );
    wait 0.5;
    playfxontag( common_scripts\utility::getfx( "mobile_turret_ground_smoke" ), self, "tag_death_fx" );
}

disable_mobile_turret_if_not_destroyed()
{
    level.player endon( "death" );
    self endon( "stop_mobile_turret_health_4" );
    var_0 = getent( "trig_mobile_turret_missile", "targetname" );
    var_0 waittill( "trigger" );

    if ( !isdefined( level.player.drivingvehicleandturret ) )
        vehicle_scripts\_x4walker_wheels_turret::make_mobile_turret_unusable();
}

play_and_store_fx_on_tag( var_0, var_1, var_2 )
{
    playfxontag( common_scripts\utility::getfx( var_0 ), var_1.mgturret[0], var_2 );
    var_3 = spawnstruct();
    var_3.name = var_0;
    var_3.tag = var_2;

    if ( !isdefined( var_1.damage_fx ) )
        var_1.damage_fx = [];

    var_1.damage_fx[self.damage_fx.size] = var_3;
}

combat_street_wave_04()
{
    common_scripts\utility::flag_wait( "flag_delete_spawners_wave_02" );
    var_0 = getentarray( "enemy_street_wave_04", "script_noteworthy" );

    if ( var_0.size > 0 )
        maps\_spawner::flood_spawner_scripted( var_0 );

    common_scripts\utility::flag_wait( "flag_enemy_walker" );
    var_0 = [ "enemy_street_wave_04" ];
    maps\fusion_utility::delete_spawners( var_0 );
}

combat_street_wave_rear()
{
    common_scripts\utility::flag_wait( "flag_mt_move_up_05" );
    var_0 = getentarray( "enemy_street_wave_rear", "script_noteworthy" );

    if ( var_0.size > 0 )
        maps\_spawner::flood_spawner_scripted( var_0 );

    foreach ( var_2 in getentarray( "enemy_street_wave_rear", "script_noteworthy" ) )
    {
        if ( isalive( var_2 ) )
            var_2 maps\_utility::deletable_magic_bullet_shield();
    }

    foreach ( var_2 in getentarray( "enemy_street_wave_rear", "script_noteworthy" ) )
    {
        if ( isalive( var_2 ) && isdefined( var_2.magic_bullet_shield ) )
            var_2 maps\_utility::stop_magic_bullet_shield();
    }

    if ( level.currentgen )
        common_scripts\utility::flag_wait( "flag_walker_destroyed" );
    else
        common_scripts\utility::flag_wait( "flag_mt_move_up_05" );

    var_0 = [ "enemy_street_wave_rear" ];
    maps\fusion_utility::delete_spawners( var_0 );
}

combat_enemy_tank()
{
    common_scripts\utility::flag_wait( "walker_trophy_1" );
    var_0 = getentarray( "enemy_street_tank_stage_01", "script_noteworthy" );

    if ( var_0.size > 0 )
        maps\_spawner::flood_spawner_scripted( var_0 );

    common_scripts\utility::flag_wait( "walker_trophy_2" );
    thread rpg_at_squad_01();
    var_0 = getentarray( "enemy_street_tank_stage_02", "script_noteworthy" );

    if ( var_0.size > 0 )
        maps\_spawner::flood_spawner_scripted( var_0 );

    common_scripts\utility::flag_wait( "walker_damaged" );
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "enemy_m_turret_03" );
    var_1 thread gaz_turret_guy_think();
    common_scripts\utility::flag_wait( "flag_walker_destroyed" );
    var_0 = [ "enemy_street_tank_stage_01", "enemy_street_tank_stage_02" ];
    maps\fusion_utility::delete_spawners( var_0 );

    if ( !level.nextgen )
    {
        level waittill( "tff_pre_transition_intro_to_middle" );
        var_1 delete();
    }
}

gaz_turret_guy_think()
{
    var_0 = undefined;

    foreach ( var_2 in self.riders )
    {
        if ( isdefined( var_2.vehicle_position ) && var_2.vehicle_position == 3 )
        {
            var_0 = var_2;
            var_0 endon( "death" );
        }

        var_2 thread walker_death_courtyard_kva_cleanup();
    }

    if ( !isdefined( var_0 ) )
        return;

    common_scripts\utility::flag_wait( "flag_walker_destroyed" );
    var_0.health = 1;
    var_0.ignoreme = 0;
}

combat_enemy_trans_heli_wave_01()
{
    common_scripts\utility::flag_wait( "flag_mt_move_up_05" );
}

combat_zip_rooftop()
{
    common_scripts\utility::flag_wait( "flag_combat_zip_rooftop_start" );
    var_0 = missile_createrepulsorent( level.warbird_a, 5000, 1000 );
    var_1 = getentarray( "enemy_street_zip_rooftop", "script_noteworthy" );

    foreach ( var_3 in var_1 )
        var_3 maps\_utility::spawn_ai( 1 );

    if ( level.currentgen )
    {
        var_1 = getentarray( "enemy_street_zip_rooftop_left", "script_noteworthy" );
        var_5 = getentarray( "enemy_street_zip_rooftop_right", "script_noteworthy" );
        var_1 = common_scripts\utility::array_combine( var_1, var_5 );

        foreach ( var_3 in var_1 )
            var_3 maps\_utility::spawn_ai( 1 );
    }

    if ( level.nextgen )
        maps\fusion_utility::spawn_metrics_waittill_deaths_reach( 4, [ "enemy_street_zip_rooftop" ], 1 );
    else
        maps\fusion_utility::spawn_metrics_waittill_deaths_reach( 4, [ "enemy_street_zip_rooftop", "enemy_street_zip_rooftop_left", "enemy_street_zip_rooftop_right" ], 1 );

    common_scripts\utility::flag_set( "flag_burke_zip" );

    if ( level.nextgen )
        maps\fusion_utility::spawn_metrics_waittill_deaths_reach( 6, [ "enemy_street_zip_rooftop" ], 1 );
    else
        maps\fusion_utility::spawn_metrics_waittill_deaths_reach( 6, [ "enemy_street_zip_rooftop", "enemy_street_zip_rooftop_left", "enemy_street_zip_rooftop_right" ], 1 );

    var_1 = getentarray( "enemy_street_zip_rooftop_strafe", "script_noteworthy" );

    foreach ( var_3 in var_1 )
        var_3 maps\_utility::spawn_ai( 1 );

    waittillframeend;

    if ( !common_scripts\utility::flag( "flag_rooftop_strafe" ) )
        common_scripts\utility::flag_set( "flag_player_cleared_rooftop" );

    if ( level.nextgen )
        maps\fusion_utility::spawn_metrics_waittill_deaths_reach( 9, [ "enemy_street_zip_rooftop", "enemy_street_zip_rooftop_strafe" ], 1 );
    else
        maps\fusion_utility::spawn_metrics_waittill_deaths_reach( 9, [ "enemy_street_zip_rooftop", "enemy_street_zip_rooftop_left", "enemy_street_zip_rooftop_right", "enemy_street_zip_rooftop_strafe" ], 1 );

    common_scripts\utility::flag_set( "flag_combat_zip_rooftop_complete" );
    soundscripts\_snd::snd_music_message( "mus_combat_zip_rooftop_complete" );
}

combat_street_initial()
{
    if ( level.currentgen )
        common_scripts\utility::flag_wait( "flag_spawn_gaz_01" );

    var_0 = getentarray( "enemy_street_reactor_entrance", "script_noteworthy" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) )
            var_2 maps\_utility::spawn_ai( 1 );
    }

    if ( level.nextgen )
        common_scripts\utility::flag_wait( "flag_spawn_gaz_01" );

    var_4 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "enemy_m_turret_02" );
    var_5 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "enemy_m_turret_01" );
    var_4 thread gaz_turret_guy_think();
    var_5 thread gaz_turret_guy_think();
    var_6 = getent( "titan_friendly_badplace", "targetname" );
    badplace_brush( "titan_hill_friendly_bad", -1, var_6, "allies" );
    common_scripts\utility::flag_wait( "flag_obj_01_pos_update_02" );
    var_0 = [ "enemy_street_reactor_entrance" ];
    maps\fusion_utility::delete_spawners( var_0 );

    if ( level.currentgen )
    {
        level waittill( "tff_pre_transition_intro_to_middle" );
        var_4 delete();
        var_5 delete();
    }
}

rpg_at_heli()
{
    common_scripts\utility::flag_wait( "flag_rpg_at_heli" );
    wait 2.5;
    maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "rpg_at_heli" );
}

rpg_at_squad_01()
{
    maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "rpg_at_squad_01" );
    wait 1;
    maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "rpg_at_squad_02" );
}

wall_explosion_01()
{
    var_0 = getentarray( "street_wall_1_decal", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 hide();

    common_scripts\utility::flag_wait( "flag_mt_wall_rpg_fire" );
    var_4 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "rpg_at_wall_01" );
    common_scripts\utility::flag_wait( "flag_mt_wall_rpg_impact" );
    var_5 = getent( "blocker_wall_1_explode", "targetname" );
    var_5 delete();

    foreach ( var_2 in var_0 )
        var_2 show();

    maps\_utility::activate_trigger_with_targetname( "street_wall_1_explode" );
    var_8 = common_scripts\utility::getstruct( "vfx_street_wall_1_explode", "targetname" );
    thread maps\fusion_lighting::firelight_volume();
    thread maps\fusion_lighting::firelight_volume2();
    soundscripts\_snd::snd_message( "street_wall_1_explode", var_8.origin );
    radiusdamage( var_8.origin, 200, 200, 100, undefined, "MOD_EXPLOSIVE" );
    physicsexplosionsphere( var_8.origin, 200, 10, 1 );
}

building_explosion_01()
{
    common_scripts\utility::flag_wait( "flag_mt_move_up_05" );
    maps\_utility::activate_trigger_with_targetname( "street_building_top_1_explode" );
    var_0 = common_scripts\utility::getstruct( "vfx_street_building_1_explode", "targetname" );
    soundscripts\_snd::snd_message( "building_explode", var_0.origin );
    radiusdamage( var_0.origin, 200, 200, 100, undefined, "MOD_EXPLOSIVE" );
    physicsexplosionsphere( var_0.origin, 200, 10, 1 );
}

spawn_player_anim_rig()
{
    return maps\_utility::spawn_anim_model( "player_rig", ( 0, 0, 0 ) );
}

courtyard_ambient_explosions()
{
    level.player endon( "death" );
    level endon( "start_itiot" );
    level endon( "street_cleanup" );
    level endon( "flag_walker_destroyed" );
    common_scripts\utility::flag_wait( "flag_ambient_explosions_start" );
    childthread courtyard_ambient_bullet_impacts();
}

courtyard_ambient_bullet_impacts()
{
    var_0 = common_scripts\utility::getstructarray( "ambient_bullet_origins", "targetname" );
    var_1 = 0.05;

    if ( level.currentgen )
        var_1 = 0.5;

    for (;;)
    {
        var_2 = 0.25;
        var_3 = 0.5;

        if ( common_scripts\utility::flag( "flag_slow_explosions_1" ) )
        {
            var_2 = 1.25;
            var_3 = 1.5;
        }

        if ( common_scripts\utility::flag( "flag_slow_explosions_2" ) )
        {
            var_2 = 2.25;
            var_3 = 2.5;
        }

        if ( level.currentgen )
        {
            var_2 *= 2.0;
            var_3 *= 2.0;
        }

        wait(randomfloatrange( var_2, var_3 ));
        var_4 = anglestoforward( level.player.angles );
        var_5 = anglestoright( level.player.angles );
        var_6 = spawn( "script_origin", ( 0, 0, 0 ) );
        var_4 *= randomintrange( 256, 512 );
        var_5 *= randomintrange( -256, 256 );
        var_7 = randomint( 360 );
        var_6.angles = ( 0, var_7, 0 );
        var_8 = var_0[randomint( var_0.size )];
        var_9 = 0;
        var_10 = level.player.origin + var_4 + var_5;
        var_11 = randomintrange( 64, 256 );

        if ( level.currentgen )
            var_12 = randomintrange( 2, 8 );
        else
            var_12 = randomintrange( 4, 15 );

        var_13 = var_10 + anglestoforward( var_6.angles ) * var_11;
        var_14 = var_13 - var_10;
        var_15 = var_12 * var_1;

        while ( var_9 < var_15 )
        {
            var_16 = randomfloat( 1 );

            if ( var_16 < 0.8 )
            {
                var_6.origin = var_10 + var_14 * var_9 / var_15;
                var_17 = randomintrange( -40, 40 );
                var_18 = randomintrange( -40, 40 );
                var_19 = randomintrange( -5, 5 );
                var_6.origin += ( var_17, var_18, var_19 );

                if ( !maps\_utility::shot_endangers_any_player( var_8.origin, var_6.origin ) )
                {
                    magicbullet( "iw5_ak12_sp", var_8.origin, var_6.origin );
                    soundscripts\_snd::snd_message( "courtyard_ambient_bullet_impact", "iw5_ak12_sp", var_8.origin, var_6.origin );
                }
            }

            var_9 += var_1;
            wait(var_1);
        }

        var_6 delete();
    }
}

rooftop_slide()
{
    common_scripts\utility::flag_wait( "flag_player_zip_started" );
    var_0 = getent( "rooftop_slide_guy_1", "targetname" );
    var_0.count++;
    var_1 = var_0 maps\_utility::spawn_ai( 1 );
    level.get_in_mobile_turret_guy = var_1;
    var_1.animname = "guy1";
    var_1 maps\_utility::deletable_magic_bullet_shield();
    var_2 = [ var_1 ];
    var_3 = undefined;

    if ( level.nextgen )
    {
        var_4 = getent( "rooftop_slide_guy_2", "targetname" );
        var_4.count++;
        var_3 = var_4 maps\_utility::spawn_ai( 1 );
        var_3.animname = "guy2";
        var_3 maps\_utility::deletable_magic_bullet_shield();
        var_2 = common_scripts\utility::array_add( var_2, var_3 );
    }

    var_5 = common_scripts\utility::getstruct( "struct_rooftop_slide", "script_noteworthy" );
    var_5 maps\_anim::anim_first_frame( var_2, "fusion_rooftop_slide" );
    var_5 maps\_anim::anim_single( var_2, "fusion_rooftop_slide" );

    if ( isdefined( var_3 ) )
        var_3 maps\_utility::stop_magic_bullet_shield();

    var_6 = getnode( "node_mt_guy_after_zip", "targetname" );
    var_1 thread maps\fusion_utility::goto_node( var_6, 0 );
    var_1 maps\fusion_utility::disable_awareness();
    var_1 maps\_utility::delaythread( 5.5, ::guy_approach_mobile_turret );

    if ( isdefined( var_3 ) )
    {
        var_7 = getnode( "node_cover_joker_after_zip", "targetname" );
        var_3 maps\fusion_utility::goto_node( var_7, 1 );
    }

    common_scripts\utility::flag_wait( "player_fly_in_done" );
    wait 4.5;

    if ( isdefined( var_3 ) )
        var_3 maps\_utility::set_force_color( "p" );
}

hide_water()
{
    if ( level.start_point == "fly_in_animated" || level.start_point == "courtyard" )
        common_scripts\utility::flag_wait( "player_fly_in_done" );

    var_0 = getent( "water_on", "targetname" );
    var_0 delete();
}

courtyard_burke_rally()
{
    common_scripts\utility::flag_wait( "flag_player_zip_started" );
    common_scripts\utility::flag_set( "flag_boots_on_ground_dialogue" );
    common_scripts\utility::flag_wait( "burke_fastzip_done" );
    common_scripts\utility::flag_wait( "player_fly_in_done" );
    waittillframeend;
    level.burke.animname = "burke";
    level.joker.animname = "joker";
    level.carter.animname = "carter";
    level.burke maps\_utility::set_ignoreall( 1 );
    level.joker maps\_utility::set_ignoreall( 1 );
    var_0 = common_scripts\utility::getstruct( "struct_courtyard_burke_rally", "script_noteworthy" );
    maps\_utility::delaythread( 6.0, ::color_activate_post_burk_rally );
    var_0 maps\_anim::anim_reach_solo( level.burke, "street_burke_rally" );
    level.burke maps\_utility::set_ignoreall( 0 );
    var_0 thread maps\_anim::anim_single_solo_run( level.burke, "street_burke_rally" );
    level.burke maps\_utility::enable_ai_color();
    common_scripts\utility::flag_set( "flag_burke_rally_street_dialogue" );
    level.carter maps\_utility::delaythread( 9, maps\_utility::enable_ai_color );
    level.joker maps\_utility::set_ignoreall( 0 );
    var_0 maps\_anim::anim_reach_solo( level.joker, "street_burke_rally_in" );
    var_0 maps\_anim::anim_single_solo( level.joker, "street_burke_rally_in" );
    var_0 thread maps\_anim::anim_loop_solo( level.joker, "street_burke_rally_idle", "ender_string" );
    wait 2.75;
    var_0 notify( "ender_string" );
    var_0 maps\_anim::anim_single_solo_run( level.joker, "street_burke_rally_out" );
    level.joker maps\_utility::enable_ai_color();
}

color_activate_post_burk_rally()
{
    var_0 = getent( "color_t_fastzip_landing", "targetname" );

    if ( isdefined( var_0 ) )
        maps\_utility::activate_trigger_with_targetname( "color_t_fastzip_landing" );

    level.carter maps\_utility::disable_sprint();

    if ( isdefined( var_0 ) )
        var_0 common_scripts\utility::trigger_off();
}

courtyard_mobile_cover_guys()
{
    var_0 = getent( "mobile_cover_guy_2", "targetname" );
    var_0.count++;
    var_1 = var_0 maps\_utility::spawn_ai( 1 );
    var_1.animname = "guy2";
    var_1 maps\_utility::deletable_magic_bullet_shield();
    var_2 = [ var_1 ];
    var_3 = undefined;

    if ( level.nextgen )
    {
        var_4 = getent( "mobile_cover_guy_1", "targetname" );
        var_4.count++;
        var_3 = var_4 maps\_utility::spawn_ai( 1 );
        var_3.animname = "guy1";
        var_3 maps\_utility::deletable_magic_bullet_shield();
        var_2 = common_scripts\utility::array_add( var_2, var_3 );
    }

    var_5 = common_scripts\utility::spawn_tag_origin();
    var_5.origin = ( -960.107, -3213.48, -72 );
    var_5.angles = ( 0, 11, 0 );
    var_6 = spawn( "script_model", var_5.origin );
    var_6 setmodel( "vehicle_mobile_cover" );
    var_6 maps\_utility::assign_animtree( "mobile_cover" );
    var_7 = getent( "mobile_cover_courtyard_clip", "targetname" );
    var_7 connectpaths();
    var_5 thread maps\_anim::anim_first_frame( var_2, "fusion_mobile_cover" );
    var_5 thread maps\_anim::anim_first_frame_solo( var_6, "fusion_mobile_cover" );
    var_7.origin = var_6.origin;
    var_7 linkto( var_6 );
    common_scripts\utility::flag_wait( "flag_ambient_explosions_start" );
    var_6 thread mobile_cover_badplace();
    var_6 thread mobile_cover_courtyard_start( var_7, var_5 );
    var_5 maps\_anim::anim_single_run( var_2, "fusion_mobile_cover" );
    var_1 maps\_utility::stop_magic_bullet_shield();
    var_1 kill();
    var_1 startragdoll();
    var_8 = getnode( "node_mobile_cover_courtyard", "targetname" );

    if ( isdefined( var_3 ) )
    {
        var_3 maps\fusion_utility::goto_node( var_8, 1 );
        var_3 maps\_utility::set_force_color( "y" );
        var_3 maps\_utility::stop_magic_bullet_shield();
    }

    if ( level.nextgen )
        level waittill( "street_cleanup" );
    else
        level waittill( "tff_pre_transition_intro_to_middle" );

    var_5 delete();
    var_6 delete();
}

mobile_cover_courtyard_start( var_0, var_1 )
{
    soundscripts\_snd::snd_message( "cvrdrn_paired_anim_start" );
    var_1 maps\_anim::anim_single_solo( self, "fusion_mobile_cover" );
    soundscripts\_snd::snd_message( "cvrdrn_paired_anim_explo" );
    mobile_cover_explosion( var_0 );
}

mobile_cover_badplace()
{
    self endon( "stop_mobile_cover_badplace" );

    for (;;)
    {
        badplace_cylinder( "mobile_cover_badplace", 0.25, self.origin, 96, 96, "axis", "allies" );
        wait 0.25;
    }
}

street_mobile_cover_guys()
{
    level.player endon( "death" );
    common_scripts\utility::flag_wait( "flag_mobile_cover_se_2" );
    var_0 = common_scripts\utility::getstruct( "street_mobile_cover_guys_node", "script_noteworthy" );

    while ( distance( level.player.origin, var_0.origin ) < 195 || maps\_utility::player_looking_at( var_0.origin, cos( 60 ), 1 ) )
        wait 0.5;

    var_1 = getent( "mobile_cover_2_guy_1", "targetname" );
    var_2 = getent( "mobile_cover_2_guy_2", "targetname" );
    var_1.count++;
    var_2.count++;
    var_3 = var_1 maps\_utility::spawn_ai( 1 );
    var_4 = var_2 maps\_utility::spawn_ai( 1 );
    var_3.animname = "guy1";
    var_4.animname = "guy2";
    var_3 maps\_utility::deletable_magic_bullet_shield();
    var_4 maps\_utility::deletable_magic_bullet_shield();
    var_5 = getent( "street_mobile_cover_guys_cover", "script_noteworthy" );
    var_6 = var_5 maps\_utility::spawn_vehicle();
    var_6 maps\_utility::assign_animtree( "mobile_cover" );
    var_6 vehicle_scripts\_cover_drone::cover_drone_disable();
    var_7 = [ var_3, var_4, var_6 ];
    var_0 thread maps\_anim::anim_first_frame( var_7, "fusion_mobile_cover_2" );
    var_0 maps\_anim::anim_single( var_7, "fusion_mobile_cover_2" );
    var_6 stopanimscripted();
    var_6 vehicle_scripts\_cover_drone::cover_drone_enable();
    var_3 maps\fusion_utility::disable_awareness();
    var_4 maps\fusion_utility::disable_awareness();
    var_4 maps\fusion_utility::goto_node( "node_cover_mb_guy_01", 0 );
    var_3 maps\fusion_utility::goto_node( "node_cover_mb_guy_02", 0 );
    var_3 maps\fusion_utility::enable_awareness();
    var_4 maps\fusion_utility::enable_awareness();
    var_3 maps\_utility::stop_magic_bullet_shield();
    var_4 maps\_utility::stop_magic_bullet_shield();
    var_7 = [ var_3, var_4 ];
    common_scripts\utility::flag_wait( "flag_walker_destroyed" );

    foreach ( var_9 in var_7 )
    {
        if ( isalive( var_9 ) )
            var_9 maps\_utility::set_force_color( "y" );
    }
}

mobile_cover_explosion( var_0 )
{
    self notify( "stop_mobile_cover_badplace" );
    var_1 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_1.origin = self.origin;
    var_2 = self.angles + ( -90, 90, 0 );
    var_0 delete();
    self setmodel( "vehicle_mobile_cover_dstrypv" );
    playfx( common_scripts\utility::getfx( "fusion_vehicle_mobile_cover_explosion" ), var_1.origin, anglestoforward( var_2 ), anglestoup( var_2 ) );
    earthquake( 1, 1.6, var_1.origin, 625 );
    radiusdamage( var_1.origin, 100, 200, 100, undefined, "MOD_EXPLOSIVE" );
    physicsexplosionsphere( var_1.origin, 200, 10, 1 );
    common_scripts\utility::play_sound_in_space( "mortar_explosion", var_1.origin );
    var_1 delete();
}

mobile_turret_dropoff()
{
    level.player endon( "death" );
    common_scripts\utility::flag_wait( "flag_player_zip_started" );
    wait 3;
    common_scripts\utility::flag_set( "cam_shake_start" );
    var_0 = common_scripts\utility::getstruct( "org_mobile_turret_warbird_deploy", "targetname" );
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname( "warbird_mobile_turret_deploy" );
    var_1 soundscripts\_snd::snd_message( "warbird_mobile_turret_dropoff" );
    var_1.animname = "warbird_deploy";
    var_1 maps\_vehicle::godon();
    var_1 maps\_vehicle::vehicle_lights_on( "running" );
    var_1 vehicle_turnengineoff();
    var_2 = maps\_utility::spawn_anim_model( "walker_deploy" );
    var_2.animname = "walker_deploy";
    var_2 soundscripts\_snd::snd_message( "walker_mobile_turret_dropoff" );
    var_3 = maps\_utility::spawn_anim_model( "pulley_deploy" );
    var_3.animname = "pulley_deploy";
    var_1 thread custom_dust_kickup();
    var_0 maps\_anim::anim_first_frame( [ var_1, var_3, var_2 ], "mobile_turret_deploy" );
    var_0 thread play_warbird_mobile_turret_dropoff( var_1, var_3 );
    var_0 maps\_anim::anim_single_solo( var_2, "mobile_turret_deploy" );
    var_4 = maps\_vehicle::spawn_vehicle_from_targetname( "walker_mobile_turret_deploy" );
    var_4 soundscripts\_snd::snd_message( "spawn_walker_mobile_turret_deploy" );
    var_4.animname = "mobile_turret";
    var_4 maps\_vehicle::godon();
    var_4 vehicle_teleport( var_2.origin, var_2.angles );
    var_2 delete();
    common_scripts\utility::flag_set( "cam_shake_stop" );
    var_5 = getent( "clip_mobile_turret_warbird_deploy", "targetname" );
    var_5 connectpaths();
    var_5 delete();
    var_6 = getent( "clip_mobile_turret_warbird_deploy_player", "targetname" );
    var_6 linkto( var_4 );
    thread guy_get_in_mobile_turret( var_4 );

    if ( level.currentgen )
    {
        level waittill( "tff_pre_transition_intro_to_middle" );
        var_4 delete();
    }
}

guy_approach_mobile_turret()
{

}

custom_dust_kickup()
{
    wait 0.05;
    self notify( "stop_kicking_up_dust" );
    var_0 = common_scripts\utility::spawn_tag_origin();
    var_0 linkto( self, "tag_origin", ( 0, -150, -100 ), ( 0, 0, 0 ) );
    thread maps\_vehicle::aircraft_wash( var_0 );
    self waittill( "death" );
    self notify( "stop_kicking_up_dust" );
    var_0 delete();
}

courtyard_ally_mcd_safeguard_init()
{
    common_scripts\utility::array_thread( getentarray( "courtyard_trig_ally_mcd_safeguard", "targetname" ), ::courtyard_ally_mcd_safeguard );
}

courtyard_ally_mcd_safeguard()
{
    level endon( "flag_walker_destroyed" );
    var_0 = getent( self.target, "targetname" );
    var_1 = common_scripts\utility::getstructarray( "courtyard_pos_ally_mcd_safeguard", "targetname" );

    for (;;)
    {
        self waittill( "trigger", var_2 );
        var_3 = [ level.carter, level.joker, level.burke ];

        foreach ( var_7, var_5 in var_3 )
        {
            var_6 = var_1[var_7];

            if ( var_5 istouching( var_0 ) && !maps\_utility::player_can_see_ai( var_5 ) && !maps\_utility::player_looking_at( var_6.origin, undefined, 1 ) )
                var_5 forceteleport( var_6.origin, var_6.angles );
        }
    }
}

play_warbird_mobile_turret_dropoff( var_0, var_1 )
{
    maps\_anim::anim_single( [ var_0, var_1 ], "mobile_turret_deploy" );
    var_1 linkto( var_0 );
    var_0 maps\_utility::vehicle_detachfrompath();
    var_0 vehicle_setspeed( 60, 15, 5 );
    var_2 = common_scripts\utility::getstruct( "warbird_path_after_turret_deploy", "targetname" );
    var_0 thread maps\_utility::vehicle_dynamicpath( var_2, 0 );
    common_scripts\utility::flag_wait( "warbird_turret_deploy_delete" );
    var_1 delete();
    var_0 delete();
}

guy_get_in_mobile_turret( var_0 )
{
    level.player endon( "death" );

    if ( level.nextgen )
        level endon( "street_cleanup" );
    else
        level endon( "tff_pre_transition_intro_to_middle" );

    var_1 = level.get_in_mobile_turret_guy;
    var_1 notify( "guy_getting_in_mobile_turret" );
    var_2 = getdvarint( "ai_friendlySuppression" );
    setsaveddvar( "ai_friendlySuppression", 0 );
    var_1 maps\fusion_utility::disable_awareness();
    var_1 pushplayer( 1 );
    var_1 maps\_utility::delaythread( 2, maps\_utility::enable_sprint );
    var_0 maps\_anim::anim_reach_solo( var_1, "guy_enter_mobile_turret", "tag_guy" );
    var_0 thread maps\_anim::anim_single_solo( var_1, "guy_enter_mobile_turret", "tag_guy" );
    var_0 maps\_anim::anim_single_solo( var_0, "guy_enter_mobile_turret" );
    setsaveddvar( "ai_friendlySuppression", var_2 );
    var_0 thread maps\_vehicle_aianim::guy_enter( var_1 );
    level.get_in_mobile_turret_guy = undefined;
    var_3 = getvehiclenode( "deployed_turret_path", "targetname" );
    var_0.target = "deployed_turret_path";
    var_0 thread maps\_vehicle_code::getonpath();
    var_0 thread mobile_turret_gopath();
    var_0 thread monitor_turret_2_death();
    var_0 thread maps\fusion_utility::kill_path_on_death();
    common_scripts\utility::flag_wait( "flag_mt_wall_rpg_fire" );
    var_0 notify( "stop_vehicle_turret_ai" );
    var_4 = common_scripts\utility::spawn_tag_origin();
    var_4 linkto( var_0, "tag_body", ( 10000, 0, 0 ), ( 0, 0, 0 ) );
    var_0 setturrettargetent( var_4 );
    common_scripts\utility::flag_wait( "flag_mt_wall_rpg_impact" );
    wait 0.25;
    var_0 maps\_vehicle::godoff();
    var_0 dodamage( var_0.health + 200, ( 0, 0, 0 ) );
    var_0 thread walker_guy_death( var_1 );
    var_4 delete();
}

#using_animtree("generic_human");

walker_guy_death( var_0 )
{
    var_1 = %x4walker_wheels_destructed_death_right_npc;
    var_0 = maps\_vehicle_aianim::convert_guy_to_drone( var_0, 0, 0 );
    [[ level.global_kill_func ]]( "MOD_RIFLE_BULLET", "torso_upper", var_0.origin );
    var_0 linkto( self, "tag_guy", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_0 notsolid();
    var_0 setflaggedanim( "death", var_1 );
    var_0 thread maps\fusion_fx::set_guy_on_fire();
    var_2 = getanimlength( var_1 );
    var_3 = getnotetracktimes( var_1, "start_ragdoll" );

    if ( isdefined( var_3 ) && var_3.size > 0 )
        var_2 *= var_3[0];
    else
        var_2 -= 0.15;

    wait(var_2);
    var_0 unlink();
}

enemy_walker()
{
    common_scripts\utility::flag_wait( "flag_enemy_walker" );
    level.walker = maps\_vehicle::spawn_vehicle_from_targetname( "enemy_walker" );
    level.walker thread enemy_walker_set_launcher_targets();
    level.walker soundscripts\_snd::snd_message( "titan_init" );
    common_scripts\utility::flag_set( "update_obj_pos_walker" );
    level.walker.mobile_turret_rocket_target = 0;
    level.walker thread walker_anims();
    level.walker thread manage_walker_health();
    level.walker thread walker_trophy_system();
    level.walker thread walker_badplace();
    level.walker thread enemy_walker_kill_player_if_too_close();
    thread launcher_out_of_ammo_think();
    thread enemy_walker_target_player_if_targeted();

    if ( isalive( level.walker ) )
        level.walker waittill( "death" );

    level.walker setcontents( 0 );
    common_scripts\utility::flag_set( "flag_walker_destroyed" );
    common_scripts\utility::flag_set( "update_obj_pos_security_entrance_1" );

    if ( level.nextgen )
        thread spawn_more_allies();

    maps\_utility::delaythread( 2, maps\_utility::autosave_now );
    var_0 = getent( "color_t_street_end", "targetname" );
    var_0 common_scripts\utility::trigger_on();
    wait 1;

    if ( isdefined( var_0 ) )
        maps\_utility::activate_trigger_with_targetname( "color_t_street_end" );
}

launcher_out_of_ammo_think()
{
    level endon( "flag_walker_destroyed" );
    level.active_objective = [];
    level.inactive_objective = [];
    var_0 = getent( "org_obj_get_launcher_ammo", "targetname" );
    objective_add( maps\_utility::obj( "obj_launcher_ammo" ), "invisible", "", var_0.origin );
    maps\_utility::set_objective_inactive( "obj_launcher_ammo" );

    for (;;)
    {
        wait 0.5;

        if ( isalive( level.walker ) )
        {
            var_1 = level.player getweaponslist( "primary" );

            if ( !common_scripts\utility::array_contains( var_1, "iw5_stingerm7_sp" ) )
            {
                launcher_out_of_ammo_obj_clear( var_0 );
                continue;
            }

            foreach ( var_3 in var_1 )
            {
                if ( issubstr( var_3, "iw5_stingerm7_sp" ) )
                {
                    if ( level.player getammocount( "iw5_stingerm7_sp" ) > 0 )
                    {
                        launcher_out_of_ammo_obj_clear( var_0 );
                        common_scripts\utility::flag_clear( "flag_launcher_out_of_ammo" );
                        common_scripts\utility::flag_set( "flag_launcher_ammo_gathered" );
                    }

                    if ( level.player getammocount( "iw5_stingerm7_sp" ) == 0 )
                    {
                        launcher_out_of_ammo_obj( var_0, var_1 );
                        common_scripts\utility::flag_set( "flag_launcher_out_of_ammo" );
                        common_scripts\utility::flag_clear( "flag_launcher_ammo_gathered" );
                    }
                }
            }
        }
    }
}

launcher_out_of_ammo_obj( var_0, var_1 )
{
    wait 0.5;

    foreach ( var_3 in var_1 )
    {
        if ( issubstr( var_3, "iw5_stingerm7_sp" ) )
        {
            if ( level.player getammocount( "iw5_stingerm7_sp" ) == 0 )
            {
                if ( maps\_utility::objective_is_inactive( "obj_launcher_ammo" ) )
                {
                    objective_state_nomessage( maps\_utility::obj( "obj_launcher_ammo" ), "active" );
                    objective_current_nomessage( maps\_utility::obj( "obj_launcher_ammo" ), maps\_utility::obj( "shutdown_reactor" ) );
                    objective_setpointertextoverride( maps\_utility::obj( "obj_launcher_ammo" ), &"FUSION_OBJ_AMMO_CRATE" );
                    maps\_utility::set_objective_active( "obj_launcher_ammo" );
                }
            }
        }
    }
}

launcher_out_of_ammo_obj_clear( var_0 )
{
    if ( maps\_utility::objective_is_active( "obj_launcher_ammo" ) )
        objective_delete( maps\_utility::obj( "obj_launcher_ammo" ) );
}

enemy_walker_set_launcher_targets()
{
    while ( !thread does_player_have_smaw() )
        waitframe();

    level.scripttargets = [];
    var_0 = [ "kneeb_fr", "kneeb_fl", "kneeb_kr", "kneeb_kl", "shoulder_fl", "shoulder_fr", "launcher_left", "launcher_right", "tag_sparks2", "tag_sparks3" ];

    foreach ( var_4, var_2 in var_0 )
    {
        var_3[var_4] = common_scripts\utility::spawn_tag_origin();
        var_3[var_4].origin = self gettagorigin( var_2 );
        var_3[var_4].stinger_override_tags = [ "tag_origin" ];
        var_3[var_4].script_team = "axis";
        var_3[var_4] linkto( level.walker, var_2 );
        var_3[var_4].health = 100;
        var_3[var_4].walkernode = 1;
        level.scripttargets[level.scripttargets.size] = var_3[var_4];
    }
}

enemy_walker_kill_player_if_too_close()
{
    self endon( "death" );
    common_scripts\utility::flag_wait( "player_too_close_to_walker" );
    maps\_vehicle::godon();
    level.player endon( "death" );
    level.player enablehealthshield( 0 );

    foreach ( var_1 in self.mgturret )
    {
        var_1 notify( "stop_vehicle_turret_ai" );
        var_1 thread walker_tank_turret_fire_at_player( level.player );
    }

    for (;;)
    {
        level.player dodamage( 15 / level.player.damagemultiplier, self.origin, self );
        var_3 = randomfloatrange( 0.1, 0.3 );
        wait(var_3);
    }
}

enemy_walker_target_player_if_targeted()
{
    self endon( "flag_walker_destroyed" );
    var_0 = 0;
    var_1 = 0;

    if ( isdefined( level.player.stingerm7_info ) && isdefined( level.player.stingerm7_info.locked_targets ) )
        var_1 = level.player.stingerm7_info.locked_targets.size;

    var_0 = var_1;

    for (;;)
    {
        if ( isdefined( level.player.stingerm7_info ) && isdefined( level.player.stingerm7_info.locked_targets ) )
            var_1 = level.player.stingerm7_info.locked_targets.size;

        if ( var_0 != var_1 )
        {
            if ( var_1 == 0 )
                walker_tank_turret_fire_at_player_clear();

            if ( isdefined( level.player.stingerm7_info ) && isdefined( level.player.stingerm7_info.locked_targets ) )
            {
                var_2 = level.player.stingerm7_info.locked_targets;

                foreach ( var_4 in var_2 )
                {
                    if ( isdefined( var_4.ent.walkernode ) && var_4.ent.walkernode == 1 )
                        thread walker_tank_turret_fire_at_player_think();
                }
            }
        }

        var_0 = var_1;
        waitframe();
    }
}

walker_tank_turret_fire_at_player_think()
{
    self notify( "walker_hit" );
    self endon( "walker_hit" );
    level endon( "flag_walker_death_anim_start" );
    level.walker vehicle_scripts\_vehicle_turret_ai::vehicle_set_forced_target( level.player );
}

walker_tank_turret_fire_at_player_clear()
{
    level.walker.ai_target_force_scripted = undefined;
}

walker_tank_turret_fire_at_player( var_0 )
{
    self endon( "death" );
    self endon( "stop_vehicle_turret_ai" );
    self setturretteam( "axis" );
    self setmode( "manual" );
    self settargetentity( var_0 );
    self turretfireenable();
    self startfiring();
}

spawn_more_allies()
{
    var_0 = getentarray( "allies_street_end", "script_noteworthy" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) )
            var_2 maps\_utility::spawn_ai( 1 );
    }
}

combat_street_seeker_ai()
{
    var_0 = 1;
    var_1 = [];

    while ( !common_scripts\utility::flag( "flag_enemy_walker" ) )
    {
        var_2 = getaiarray( "axis" );
        waitframe();
        var_1 = [];

        for ( var_3 = 0; var_3 < var_0; var_3++ )
        {
            if ( var_2.size > var_3 )
            {
                var_4 = var_2[var_3];

                if ( isalive( var_4 ) )
                {
                    if ( isdefined( var_4.magic_bullet_shield ) )
                        var_4 maps\_utility::stop_magic_bullet_shield();

                    var_4.playerseeker = 1;
                    var_4 cleargoalvolume();
                    var_4 thread maps\_utility::player_seek();
                    var_4.favoriteenemy = level.player;
                    var_1[var_1.size] = var_4;
                }
            }
        }

        if ( var_1.size > 0 )
            maps\_utility::array_wait( var_1, "death" );

        if ( common_scripts\utility::flag( "player_in_x4walker" ) )
            common_scripts\utility::flag_waitopen( "player_in_x4walker" );

        wait 5;
    }

    foreach ( var_6 in var_1 )
    {
        if ( isalive( var_6 ) )
            var_6 notify( "goal" );
    }
}

walker_badplace()
{
    while ( !common_scripts\utility::flag( "flag_walker_tank_on_mount" ) )
    {
        badplace_cylinder( "walker_tank_badplace", 0.5, self.origin, 280, 300, "axis", "team3", "allies" );
        wait 0.55;
    }
}

walker_missile_barrage()
{
    wait 0.25;
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "tank_missile_01" );
    playfxontag( common_scripts\utility::getfx( "walker_tank_rocket_wv" ), var_0, "tag_origin" );
    var_0 soundscripts\_snd::snd_message( "titan_missile" );
    wait 0.15;
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "tank_missile_02" );
    playfxontag( common_scripts\utility::getfx( "walker_tank_rocket_wv" ), var_1, "tag_origin" );
    var_1 soundscripts\_snd::snd_message( "titan_missile" );
    wait 0.15;
    var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "tank_missile_03" );
    playfxontag( common_scripts\utility::getfx( "walker_tank_rocket_wv" ), var_2, "tag_origin" );
    var_2 soundscripts\_snd::snd_message( "titan_missile" );
    wait 1.15;
    var_3 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "tank_missile_04" );
    playfxontag( common_scripts\utility::getfx( "walker_tank_rocket_wv" ), var_3, "tag_origin" );
    var_3 soundscripts\_snd::snd_message( "titan_missile" );
    wait 0.15;
    var_4 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "tank_missile_05" );
    playfxontag( common_scripts\utility::getfx( "walker_tank_rocket_wv" ), var_4, "tag_origin" );
    var_4 soundscripts\_snd::snd_message( "titan_missile" );
    wait 0.15;
    var_5 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "tank_missile_06" );
    playfxontag( common_scripts\utility::getfx( "walker_tank_rocket_wv" ), var_5, "tag_origin" );
    var_5 soundscripts\_snd::snd_message( "titan_missile" );
    wait 0.15;
    var_6 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "tank_missile_07" );
    playfxontag( common_scripts\utility::getfx( "walker_tank_rocket_wv" ), var_6, "tag_origin" );
    var_6 soundscripts\_snd::snd_message( "titan_missile" );
}

walker_anims()
{
    self endon( "stop_walker_tank_anims" );
    level.player endon( "death" );
    self.animname = "walker_tank";
    var_0 = common_scripts\utility::getstruct( "org_enemy_walker", "targetname" );
    soundscripts\_snd::snd_message( "titan_enter" );
    var_0 maps\_anim::anim_single_solo( self, "fusion_walker_tank_enter" );
    self.state = "forward";
    self.death_state = "forward";
    self.prev_state = "forward";
    common_scripts\utility::flag_set( "flag_walker_tank_on_mount" );
    var_0 thread maps\_anim::anim_loop_solo( self, "fusion_walker_tank_fwd_idle", "walker_stop_idle" );
    self disconnectpaths();

    for (;;)
    {
        wait(randomfloatrange( 5, 10 ));
        var_1 = [];

        switch ( self.state )
        {
            case "forward":
                var_1 = [ "left", "right" ];
                break;
            case "left":
                var_1 = [ "forward", "right" ];
                break;
            case "right":
                var_1 = [ "forward", "left" ];
                break;
        }

        self.prev_state = self.state;

        if ( common_scripts\utility::cointoss() )
            self.state = var_1[0];
        else
            self.state = var_1[1];

        var_0 notify( "walker_stop_idle" );

        if ( self.state == "left" )
        {
            if ( self.prev_state == "right" )
            {
                self.death_state = "right";
                var_0 maps\_anim::anim_single_solo( self, "fusion_walker_tank_right_2_fwd" );
                self.death_state = "forward";
            }

            var_0 maps\_anim::anim_single_solo( self, "fusion_walker_tank_fwd_2_left" );
            self.death_state = "left";
            var_0 thread maps\_anim::anim_loop_solo( self, "fusion_walker_tank_left_idle", "walker_stop_idle" );
        }

        if ( self.state == "right" )
        {
            if ( self.prev_state == "left" )
            {
                self.death_state = "left";
                var_0 maps\_anim::anim_single_solo( self, "fusion_walker_tank_left_2_fwd" );
                self.death_state = "forward";
            }

            var_0 maps\_anim::anim_single_solo( self, "fusion_walker_tank_fwd_2_right" );
            self.death_state = "right";
            var_0 thread maps\_anim::anim_loop_solo( self, "fusion_walker_tank_right_idle", "walker_stop_idle" );
        }

        if ( self.state == "forward" )
        {
            if ( self.prev_state == "left" )
            {
                self.death_state = "left";
                var_0 maps\_anim::anim_single_solo( self, "fusion_walker_tank_left_2_fwd" );
            }

            if ( self.prev_state == "right" )
            {
                self.death_state = "right";
                var_0 maps\_anim::anim_single_solo( self, "fusion_walker_tank_right_2_fwd" );
            }

            self.death_state = "forward";
            var_0 thread maps\_anim::anim_loop_solo( self, "fusion_walker_tank_fwd_idle", "walker_stop_idle" );
        }
    }
}

walker_trophy_system()
{
    self endon( "death" );
    level.player endon( "death" );
    self.trophy_count = 5;
    self.current_projectile = 1;

    while ( self.trophy_count >= 0 )
    {
        level waittill( "stinger_fired", var_0, var_1 );

        foreach ( var_3 in var_1 )
            thread player_projectile_think( var_3, self );
    }
}

player_projectile_think( var_0, var_1 )
{
    level.player endon( "projectile_impact" );
    var_0 endon( "death" );
    var_1 endon( "death" );
    level.player endon( "death" );
    var_2 = 512;

    if ( var_1.trophy_count <= 0 )
        return;

    while ( isdefined( var_0 ) )
    {
        var_3 = distance( var_0.origin, var_1.origin );

        if ( var_3 <= var_2 )
        {
            playfx( common_scripts\utility::getfx( "trophy_ignition_smoke" ), var_1.origin + ( 0, 0, 96 ) );
            playfx( common_scripts\utility::getfx( "trophy_explosion" ), var_0.origin );
            soundscripts\_snd::snd_message( "trophy_system_explosion", var_0.origin );
            var_1.trophy_count--;

            if ( var_1.current_projectile <= 2 )
                common_scripts\utility::flag_set( "walker_trophy_" + var_1.current_projectile );

            var_1.current_projectile++;
            var_0 delete();
        }

        wait 0.05;
    }
}

manage_walker_health()
{
    self endon( "death" );
    level.player endon( "death" );
    maps\_vehicle::godon();
    thread walker_damage_fx();
    wait_for_walker_to_be_hit_by_smaw();
    common_scripts\utility::flag_set( "walker_damaged" );
    wait 1;
    wait_for_walker_to_be_hit_by_smaw();
    objective_state_nomessage( maps\_utility::obj( "use_smaw" ), "done" );
    objective_state_nomessage( maps\_utility::obj( "obj_launcher_ammo" ), "done" );
    self notify( "stop_vehicle_turret_ai" );
    self notify( "stop_walker_tank_anims" );

    foreach ( var_1 in level.scripttargets )
    {
        if ( isdefined( var_1 ) && var_1.health > 0 )
            var_1 kill();
    }

    level.stinger_targets = common_scripts\utility::array_remove_array( level.stinger_targets, level.scripttargets );
    maps\_utility::array_delete( level.scripttargets );
    level.scripttargets = undefined;
    walker_play_death_anim();
}

wait_for_walker_to_be_hit_by_smaw()
{
    level.player endon( "death" );

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

        if ( isplayer( var_1 ) && var_4 == "MOD_PROJECTILE" && var_9 == "iw5_stingerm7_sp" )
        {
            soundscripts\_snd::snd_message( "titan_take_damage_from_smaw" );
            break;
        }
    }
}

walker_damage_fx()
{
    common_scripts\utility::flag_wait( "walker_damaged" );
    playfxontag( common_scripts\utility::getfx( "vehicle_damaged_sparks_l" ), self, "TAG_SPARKS1" );
    thread maps\_utility::play_sound_on_tag( "titan_take_smaw_dmg_sparks", "TAG_SPARKS1", 1 );
    waitframe();
    playfxontag( common_scripts\utility::getfx( "vehicle_damaged_sparks_l" ), self, "TAG_SPARKS2" );
    thread maps\_utility::play_sound_on_tag( "titan_take_smaw_dmg_sparks", "TAG_SPARKS1", 1 );
    waitframe();
    playfxontag( common_scripts\utility::getfx( "vehicle_damaged_sparks_l" ), self, "TAG_SPARKS3" );
    thread maps\_utility::play_sound_on_tag( "titan_take_smaw_dmg_sparks", "TAG_SPARKS1", 1 );
    waitframe();
    playfxontag( common_scripts\utility::getfx( "vehicle_damaged_sparks_l" ), self, "TAG_SPARKS4" );
    thread maps\_utility::play_sound_on_tag( "titan_take_smaw_dmg_sparks", "TAG_SPARKS1", 1 );
    waitframe();
}

walker_play_death_anim()
{
    common_scripts\utility::flag_set( "flag_walker_death_anim_start" );
    var_0 = "";

    switch ( self.death_state )
    {
        case "forward":
            var_0 = "fusion_walker_tank_fwd_idle_death";
            break;
        case "left":
            var_0 = "fusion_walker_tank_left_idle_death";
            break;
        case "right":
            var_0 = "fusion_walker_tank_right_idle_death";
            break;
    }

    var_1 = common_scripts\utility::getstruct( "org_enemy_walker", "targetname" );
    thread maps\fusion_fx::walker_dying_fx();
    soundscripts\_snd::snd_message( "titan_death" );
    var_1 maps\_anim::anim_single_solo( self, var_0 );
}

destroy_walker_tank( var_0 )
{
    var_0 vehicle_teleport( var_0.origin, var_0.angles - ( 0, 28.225, 0 ) );
    var_0 setmodel( "vehicle_walker_tank_dstrypv" );
    playfxontag( common_scripts\utility::getfx( "walker_explosion" ), var_0, "TAG_DEATH_FX" );
    var_1 = var_0.origin;
    var_2 = var_0 gettagorigin( "TAG_FIRE" );
    var_3 = var_0 gettagangles( "TAG_FIRE" );
    var_4 = var_0 gettagorigin( "TAG_FIRE2" );
    var_5 = var_0 gettagangles( "TAG_FIRE2" );
    var_6 = var_0 gettagorigin( "TAG_SPARKS" );
    var_7 = var_0 gettagorigin( "TAG_SPARKS" );
    var_0 kill( var_0.origin, level.player );
    wait 0.1;
    earthquake( 1, 1.6, var_1, 1350 );
    radiusdamage( var_1, 400, 200, 100, undefined, "MOD_EXPLOSIVE" );
    physicsexplosionsphere( var_1, 400, 10, 1 );
    wait 1;
    playfx( common_scripts\utility::getfx( "vehicle_destroyed_fire_m" ), var_2, anglestoforward( var_3 ), anglestoup( var_3 ) );
    playfx( common_scripts\utility::getfx( "vehicle_destroyed_fire_m" ), var_4, anglestoforward( var_5 ), anglestoup( var_5 ) );
    playfx( common_scripts\utility::getfx( "electrical_sparks_runner" ), var_6, anglestoforward( var_7 ), anglestoup( var_7 ) );
}

add_to_javelin_targeting()
{
    target_set( self, ( 0, 0, 56 ) );
    target_setjavelinonly( self, 1 );

    if ( isalive( level.walker ) )
        self waittill( "death" );

    target_remove( self );
}

btr_turret_think()
{
    self endon( "death" );
    self endon( "kill_btr_turret_think" );
    thread maps\_vehicle::vehicle_turret_scan_on();

    for (;;)
    {
        wait(randomfloatrange( 0.3, 0.8 ));
        var_0 = btr_get_target();

        if ( isdefined( var_0 ) )
        {
            btr_fire_at_target( var_0 );
            wait 0.3;
        }
    }
}

btr_fire_at_target( var_0 )
{
    var_0 endon( "death" );
    level endon( "walker_death_anim_started" );
    self setturrettargetent( var_0, ( 0, 0, 32 ) );

    if ( common_scripts\utility::cointoss() )
    {
        if ( isdefined( self.mgturret ) )
        {
            foreach ( var_2 in self.mgturret )
            {
                if ( isdefined( var_2 ) )
                {
                    var_2 setturretteam( "axis" );
                    var_2 setmode( "manual" );
                    var_2 settargetentity( var_0 );
                    var_2 startfiring();
                }
            }
        }

        wait(randomfloatrange( 3, 5 ));

        if ( isdefined( self.mgturret ) )
        {
            foreach ( var_2 in self.mgturret )
            {
                if ( isdefined( var_2 ) )
                {
                    var_2 cleartargetentity();
                    var_2 stopfiring();
                }
            }
        }
    }
    else
    {
        for ( var_6 = 0; var_6 < randomintrange( 1, 3 ); var_6++ )
        {
            burst_fire_weapon();
            wait 0.5;
        }
    }
}

burst_fire_weapon()
{
    for ( var_0 = 0; var_0 < randomintrange( 2, 4 ); var_0++ )
    {
        self fireweapon();
        wait 0.2;
    }
}

btr_get_target()
{
    var_0 = 4;
    var_1 = getaiarray( "allies" );

    for ( var_2 = 0; var_2 < var_0; var_2++ )
        var_1[var_1.size] = level.player;

    return common_scripts\utility::random( var_1 );
}

reactor_entrance_rally()
{
    var_0 = getentarray( "security_door_right", "targetname" );
    var_1 = getentarray( "security_door_left", "targetname" );

    foreach ( var_3 in var_0 )
    {
        if ( var_3.classname == "script_brushmodel" )
            var_3 disconnectpaths();
    }

    foreach ( var_3 in var_1 )
    {
        if ( var_3.classname == "script_brushmodel" )
            var_3 disconnectpaths();
    }

    common_scripts\utility::flag_wait( "flag_walker_destroyed" );
    var_7 = common_scripts\utility::getstruct( "security_doors_animnode", "targetname" );
    var_8 = spawn( "script_origin", var_7.origin );
    var_8.angles = var_7.angles;
    var_9 = "fusion_security_doors_approach";
    var_10 = "fusion_security_doors_idle";
    var_11 = "fusion_security_doors_open";
    var_12 = "security_door_ender";
    var_13 = [];
    var_13[var_13.size] = level.burke;
    var_13[var_13.size] = level.carter;
    var_14 = maps\_utility::spawn_anim_model( "security_door_right" );
    var_15 = maps\_utility::spawn_anim_model( "security_door_left" );
    var_16 = [];
    var_16[var_16.size] = var_14;
    var_16[var_16.size] = var_15;
    var_8 maps\_anim::anim_first_frame( var_16, var_11 );

    foreach ( var_3 in var_0 )
        var_3 linkto( var_14, "tag_origin_animated" );

    foreach ( var_3 in var_1 )
        var_3 linkto( var_15, "tag_origin_animated" );

    level.burke thread security_doors_approach( var_8, var_9, var_10, var_12 );
    level.carter thread security_doors_approach( var_8, var_9, var_10, var_12 );
    level waittill( "security_door_npc_ready" );
    level waittill( "security_door_npc_ready" );
    common_scripts\utility::flag_wait( "flag_player_at_reactor_door" );
    var_8 notify( var_12 );
    var_8 thread maps\_anim::anim_single_solo_run( level.burke, var_11 );
    var_8 thread maps\_anim::anim_single_solo( var_14, var_11 );
    wait 0.5;
    var_8 thread maps\_anim::anim_single_solo_run( level.carter, var_11 );
    var_8 thread maps\_anim::anim_single_solo( var_15, var_11 );

    foreach ( var_3 in var_0 )
    {
        if ( var_3.classname == "script_brushmodel" )
            var_3 connectpaths();
    }

    foreach ( var_3 in var_1 )
    {
        if ( var_3.classname == "script_brushmodel" )
            var_3 connectpaths();
    }

    maps\_utility::activate_trigger_with_targetname( "security_room_doors_open" );
}

security_doors_approach( var_0, var_1, var_2, var_3 )
{
    maps\_utility::disable_ai_color();
    self notify( "stop_goto_node" );
    self notify( "goal" );
    var_0 maps\_anim::anim_reach_solo( self, var_1 );
    var_0 maps\_anim::anim_single_solo( self, var_1 );
    maps\_utility::enable_cqbwalk();
    level notify( "security_door_npc_ready" );
    maps\_utility::enable_ai_color();
    var_0 maps\_anim::anim_loop_solo( self, var_2, var_3 );
}

reactor_entrance_rally_anim( var_0 )
{
    self endon( "death" );
    var_1 = self.animname + "_ender";
    maps\_utility::disable_ai_color();
    var_0 maps\_anim::anim_reach_solo( self, "reactor_entrance_st" );
    maps\_utility::ent_flag_set( "flag_reactor_entrance_ready" );
    var_0 maps\_anim::anim_single_solo( self, "reactor_entrance_st" );
    var_0 thread maps\_anim::anim_loop_solo( self, "reactor_entrance_idle", var_1 );
    common_scripts\utility::flag_wait( "interior_allies" );
    var_0 notify( var_1 );
}

postspawn_rpg_vehicle()
{
    self setmodel( "projectile_rpg7" );
    var_0 = common_scripts\utility::getfx( "rpg_trail" );
    playfxontag( var_0, self, "tag_origin" );
    var_0 = common_scripts\utility::getfx( "rpg_muzzle" );
    playfxontag( var_0, self, "tag_origin" );
    self playsound( "weap_rpg_fire_npc" );

    if ( isdefined( self.script_sound ) )
    {
        if ( isdefined( self.script_wait ) )
            common_scripts\utility::delaycall( self.script_wait, ::playsound, self.script_sound );
        else
            self playsound( self.script_sound );
    }
    else
        self playloopsound( "weap_rpg_loop" );

    self waittill( "reached_end_node" );
    self notify( "explode", self.origin );
    var_1 = 0;

    if ( isdefined( self.script_exploder ) )
    {
        common_scripts\_exploder::exploder( self.script_exploder );
        var_1 = 1;
    }
    else if ( isdefined( self.currentnode ) )
    {
        var_2 = undefined;

        for ( var_3 = self.currentnode; isdefined( var_3 ); var_3 = getvehiclenode( var_3.target, "targetname" ) )
        {
            var_2 = var_3;

            if ( !isdefined( var_3.target ) )
                break;
        }

        if ( isdefined( var_2.target ) )
        {
            var_4 = common_scripts\utility::getstruct( var_2.target, "targetname" );

            if ( isdefined( var_4 ) )
            {
                level thread rpg_explosion( var_4.origin, var_4.angles );
                var_1 = 1;
            }
        }
    }

    if ( !var_1 )
    {
        var_4 = spawnstruct();
        var_4.origin = self.origin;
        var_4.angles = ( -90, 0, 0 );
        level thread rpg_explosion( var_4.origin, var_4.angles );
    }

    self delete();
}

rpg_explosion( var_0, var_1 )
{
    var_2 = common_scripts\utility::getfx( "rpg_explode" );
    playfx( var_2, var_0, anglestoforward( var_1 ), anglestoup( var_1 ) );
    radiusdamage( var_0, 200, 150, 50 );
    thread common_scripts\utility::play_sound_in_space( "null", var_0 );
}

interior_gameplay()
{
    thread interior_allies();
    thread security_room();
    thread laboratory();
    thread reactor_room();
    thread turbine_room();
    thread control_room();
    level.pipesdamage = 0;
}

interior_allies()
{
    waittillframeend;
    common_scripts\utility::flag_wait_any( "interior_allies", "flag_walker_destroyed" );
    level.burke maps\_utility::set_force_color( "r" );
    level.joker maps\_utility::set_force_color( "g" );
    level.carter maps\_utility::set_force_color( "o" );
}

security_room()
{
    if ( level.start_point != "fly_in_animated" && level.start_point != "fly_in_animated_part2" && level.start_point != "courtyard" && level.start_point != "security_room" )
        return;

    common_scripts\utility::flag_wait_any( "interior_allies", "flag_walker_destroyed" );
    var_0 = "security_room_check_corpse";
    var_1 = "security_room_check_corpse_idle";
    var_2 = "security_room_check_corpse_idle_stop";
    var_3 = getent( "fusion_security_room_corpse", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_3 setcontents( 0 );
    var_3.animname = "generic";
    var_4 = common_scripts\utility::getstruct( "fusion_security_room_corpse_fall_npc", "targetname" );
    var_5 = spawn( "script_origin", var_4.origin );
    var_6 = ( 0, 0, 0 );

    if ( isdefined( var_4.angles ) )
    {
        var_6 = var_4.angles;
        var_5.angles = var_4.angles;
    }

    var_3 clearanim( %body, 0.2 );
    var_3 stopanimscripted();
    var_5 maps\_anim::anim_first_frame_solo( var_3, var_0 );
    wait 0.05;
    var_7 = spawn( "script_model", var_3 gettagorigin( "TAG_WEAPON_RIGHT" ) );
    var_7.angles = var_3 gettagangles( "TAG_WEAPON_RIGHT" );
    var_7 setmodel( "npc_m160" );
    var_7 linkto( var_3, "TAG_WEAPON_RIGHT" );
    var_8 = getent( "security_room_elevator_doors", "targetname" );
    var_8 maps\_utility::assign_animtree( "security_room_elevator_doors" );
    var_5 maps\_anim::anim_first_frame_solo( var_8, "security_room_open_elevator" );
    var_9 = getent( "security_elevator_door_left", "targetname" );
    var_10 = getent( "security_elevator_door_right", "targetname" );
    var_9 linkto( var_8, "elevator_back_left_jnt" );
    var_10 linkto( var_8, "elevator_back_right_jnt" );
    common_scripts\utility::flag_wait( "security_room_check_corpse" );
    maps\_utility::battlechatter_off( "allies" );
    level.burke thread start_cqb_when_near( getstartorigin( var_5.origin, var_6, level.scr_anim["burke"][var_0] ) );
    var_5 maps\_anim::anim_reach_solo( level.burke, var_0 );
    maps\_utility::delaythread( 3, common_scripts\utility::flag_set, "vo_security_room_elevator_access" );
    thread security_elevator_open();
    soundscripts\_snd::snd_message( "start_dead_guy_foley", var_3 );
    var_5 thread maps\_anim::anim_generic( var_3, var_0 );
    var_5 maps\_anim::anim_single_solo( level.burke, var_0 );

    if ( !common_scripts\utility::flag( "elevator_door_open" ) )
    {
        var_5 thread maps\_anim::anim_loop_solo( level.burke, var_1, var_2 );
        common_scripts\utility::flag_wait( "elevator_door_open" );
        var_5 notify( var_2 );
    }

    var_11 = "security_room_turn_to_elevator";
    var_12 = "elevator_descent_start_idle";
    var_5 maps\_anim::anim_single_solo( level.burke, var_11 );
    common_scripts\utility::flag_set( "burke_facing_elevator" );
    var_5 thread maps\_anim::anim_loop_solo( level.burke, var_12, var_12 );
    wait 2;
    common_scripts\utility::flag_wait( "elevator_descent" );
    var_5 notify( var_12 );
    var_5 delete();

    if ( level.currentgen )
    {
        level waittill( "tff_pre_transition_intro_to_middle" );
        var_9 delete();
        var_10 delete();
        var_7 delete();
        var_3 delete();
    }
}

start_cqb_when_near( var_0 )
{
    var_1 = 40000;

    while ( distancesquared( self.origin, var_0 ) > var_1 )
        wait 0.1;

    maps\_utility::enable_cqbwalk();
}

security_elevator_open()
{
    var_0 = common_scripts\utility::getstruct( "fusion_security_room_corpse_fall_npc", "targetname" );
    var_1 = spawn( "script_origin", var_0.origin );

    if ( isdefined( var_0.angles ) )
        var_1.angles = var_0.angles;

    var_2 = "security_room_approach_elevator";
    var_3 = "security_room_open_elevator_idle";
    var_4 = "end_approach_idle";
    var_5 = "security_room_open_elevator";
    var_6 = "security_room_elevator_opened_idle";
    soundscripts\_snd::snd_message( "start_elevator_zone_audio" );
    var_7 = [];
    var_7[var_7.size] = level.joker;
    var_7[var_7.size] = level.carter;
    level.joker maps\_utility::disable_ai_color();
    level.carter maps\_utility::disable_ai_color();
    level.burke maps\_utility::disable_ai_color();
    common_scripts\utility::array_thread( var_7, ::security_elevator_approach, var_1, var_2, var_3, var_4 );
    level waittill( "elevator_open_guy_ready" );
    level waittill( "elevator_open_guy_ready" );
    common_scripts\utility::flag_wait( "elevator_door_open" );
    var_1 notify( var_4 );
    common_scripts\_exploder::exploder( "elevator_door_open_fx" );
    var_8 = getent( "security_room_elevator_doors", "targetname" );
    var_8 maps\_utility::assign_animtree( "security_room_elevator_doors" );
    common_scripts\utility::flag_set( "vo_security_room_elevator_open" );
    level.joker thread security_elevator_open_anim( var_1, 1, var_5, var_6 );
    level.carter thread security_elevator_open_anim( var_1, 0, var_5, var_6 );
    var_1 thread maps\_anim::anim_single_solo( var_8, var_5 );
    soundscripts\_snd::snd_message( "Sec_Room_Elevator_Open" );
    security_elevator_descent( var_1 );
    var_1 delete();
}

security_elevator_approach( var_0, var_1, var_2, var_3 )
{
    if ( self == level.joker )
        wait 4;

    var_0 maps\_anim::anim_reach_solo( self, var_1 );

    if ( self == level.joker )
        soundscripts\_snd::snd_message( "Sec_Room_Move_To_Elevator" );

    var_0 maps\_anim::anim_single_solo( self, var_1 );

    if ( self == level.joker )
        soundscripts\_snd::snd_message( "Sec_Room_Attach_To_Elevator" );

    var_0 thread maps\_anim::anim_loop_solo( self, var_2, var_3 );
    level notify( "elevator_open_guy_ready" );
}

security_elevator_open_anim( var_0, var_1, var_2, var_3 )
{
    var_4 = "stop_opened_idle";
    var_5 = spawn( "script_origin", var_0.origin );
    var_5 maps\_anim::anim_single_solo( self, var_2 );

    if ( !common_scripts\utility::flag( "elevator_descent_player" ) )
    {
        var_5 thread maps\_anim::anim_loop_solo( self, var_3, var_4 );
        common_scripts\utility::flag_wait( "elevator_descent_player" );
        var_5 notify( var_4 );
    }
}

security_elevator_descent( var_0 )
{
    thread security_elevator_descent_player();
    common_scripts\utility::flag_wait( "burke_facing_elevator" );
    wait 2;
    common_scripts\utility::flag_wait( "elevator_descent" );
    level.guys_down_elevator = 0;
    level.burke thread security_elevator_descent_ai( var_0 );
    thread security_elevator_prompt();
    common_scripts\utility::flag_wait( "elevator_descent_player" );
    wait 1;
    level.joker thread security_elevator_descent_ai( var_0 );
    level.carter security_elevator_descent_ai( var_0 );
}

security_elevator_prompt()
{
    wait 4;

    if ( common_scripts\utility::flag( "elevator_descent_player" ) )
        return;

    var_0 = maps\_shg_utility::hint_button_position( "jump", common_scripts\utility::getstruct( "obj_pos_security_elevator", "targetname" ).origin, 128, 512 );
    common_scripts\utility::flag_wait( "elevator_descent_player" );
    var_0 maps\fusion_utility::hint_button_clear_fus();
}

transient_transition_intro_to_middle()
{
    if ( level.currentgen )
    {
        level notify( "tff_pre_transition_intro_to_middle" );
        unloadtransient( "fusion_intro_tr" );
        loadtransient( "fusion_middle_tr" );

        while ( !istransientloaded( "fusion_middle_tr" ) )
            wait 0.05;

        level notify( "tff_post_transition_intro_to_middle" );
    }
}

security_elevator_descent_player()
{
    var_0 = common_scripts\utility::getstruct( "elevator_descent_org", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "player_rig", level.player.origin );
    var_0 thread maps\_anim::anim_first_frame_solo( var_1, "elevator_descent" );
    var_1 hide();
    common_scripts\utility::flag_wait( "elevator_descent_player" );
    thread transient_transition_intro_to_middle();
    level.player maps\_utility::blend_movespeedscale_percent( 0 );
    soundscripts\_snd::snd_message( "start_player_elevator_slide" );
    common_scripts\utility::flag_set( "update_obj_pos_elevator_descent" );
    level.player maps\_utility::add_wait( maps\_shg_utility::setup_player_for_scene, 1 );
    var_1 maps\_utility::add_call( ::show );
    thread maps\_utility::do_wait();
    var_2 = 0.3;
    level.player playerlinktoblend( var_1, "tag_player", var_2 );
    level.player common_scripts\utility::delaycall( var_2, ::playerlinktodelta, var_1, "tag_player", 0, 20, 20, 20, 20 );
    var_3 = 3.25;

    if ( level.currentgen )
        var_3 *= 1.35;

    level.player common_scripts\utility::delaycall( var_3, ::enableweapons );
    level.player common_scripts\utility::delaycall( 1.5, ::givemaxammo, "iw5_bal27_sp_variablereddot" );
    common_scripts\utility::noself_delaycall( 1.0, ::playfxontag, common_scripts\utility::getfx( "elevator_player_slide_dust" ), var_1, "J_MainRoot" );
    level.player thread elevator_rumble();
    soundscripts\_snd::snd_message( "start_player_elevator_jump" );
    var_0 maps\_anim::anim_single_solo( var_1, "elevator_descent" );
    level.player unlink();
    var_1 delete();
    level.player enableweapons();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    common_scripts\utility::flag_set( "lab_cqb" );
    common_scripts\utility::flag_set( "vo_lab_elevator_slide_complete" );
    thread street_cleanup();
    maps\_utility::autosave_by_name( "elevator_slide_complete" );
}

elevator_rumble()
{
    wait 0.5;
    var_0 = maps\_utility::get_rumble_ent( "steady_rumble" );
    var_0.intensity = 0.2;
    wait 2.3;
    stopallrumbles();
}

play_lab_reactor_pip()
{
    level notify( "stop_evacuation_kiosk_movie" );
    wait 0.5;
    common_scripts\utility::flag_wait( "vo_lab_elevator_slide_complete" );
    setsaveddvar( "cg_cinematicfullscreen", "0" );
    maps\_shg_utility::play_videolog( "fusion_videolog", "screen_add" );
    wait 0.5;
    evacuation_kiosk_movie();
}

sync_transients_after_time( var_0 )
{
    wait(var_0);
    synctransients();
}

corpse_trigger_think()
{
    self waittill( "trigger" );
    var_0 = getentarray( self.target, "targetname" );
    var_1 = maps\_utility::getstructarray_delete( var_0[0].script_noteworthy, "script_noteworthy" );

    foreach ( var_3 in var_1 )
    {
        var_4 = var_0[randomintrange( 0, var_0.size )];
        var_5 = var_4 maps\_utility::spawn_ai();
        var_5.origin = var_3.origin;
        var_5.angles = var_3.angles;
        var_5 setcandamage( 0 );

        if ( isdefined( var_5.weapon ) && var_5.weapon != "none" )
            var_5 maps\_utility::gun_remove();

        var_6 = level.scr_anim["generic"][var_3.animation];

        if ( isarray( var_6 ) )
            var_6 = var_6[0];

        var_5 animscripted( "endanim", var_3.origin, var_3.angles, var_6 );

        if ( isdefined( var_3.script_parameters ) )
        {
            if ( var_3.script_parameters == "notsolid" )
                var_5 notsolid();

            if ( var_3.script_parameters == "ripples" )
                var_5 thread ripples_on_body( var_3 );
        }

        if ( issubstr( var_3.animation, "death" ) )
            var_5 common_scripts\utility::delaycall( 0.05, ::setanimtime, var_6, 1.0 );
    }

    if ( isdefined( self.script_flag ) )
    {
        common_scripts\utility::flag_wait( self.script_flag );
        common_scripts\utility::array_call( getentarray( var_0[0].script_noteworthy, "script_noteworthy" ), ::delete );
    }
}

ripples_on_body( var_0 )
{
    self endon( "death" );
    wait 0.1;
    var_1 = common_scripts\utility::get_target_ent( var_0.target );
    var_2 = ( self.origin[0], self.origin[1], var_1.origin[2] - 1 );

    for (;;)
    {
        playfx( common_scripts\utility::getfx( "water_movement" ), var_2 );
        wait(randomfloatrange( 0.5, 1 ));
    }
}

street_cleanup()
{
    level notify( "street_cleanup" );
    waittillframeend;
    var_0 = getaiarray();
    var_0 = common_scripts\utility::array_remove( var_0, level.burke );
    var_0 = common_scripts\utility::array_remove( var_0, level.joker );
    var_0 = common_scripts\utility::array_remove( var_0, level.carter );
    common_scripts\utility::array_call( var_0, ::delete );
    common_scripts\utility::array_call( getentarray( "script_vehicle_x4walker_wheels_turret", "classname" ), ::delete );
    common_scripts\utility::array_call( getentarray( "script_vehicle_x4walker_wheels_turret_explosive", "classname" ), ::delete );

    if ( isdefined( level.player.linked_to_cover ) )
        level.player.linked_to_cover vehicle_scripts\_cover_drone::player_unlink_from_cover();

    common_scripts\utility::array_call( getentarray( "script_vehicle_cover_drone", "classname" ), ::delete );
    common_scripts\utility::array_call( getentarray( "mobile_turret", "targetname" ), ::delete );
    common_scripts\utility::array_call( getentarray( "script_vehicle_pdrone", "classname" ), ::delete );

    if ( isdefined( level.walker ) )
        level.walker connectpaths();
}

security_elevator_descent_ai( var_0 )
{
    var_1 = "elevator_descent";

    if ( self == level.burke )
    {
        soundscripts\_snd::snd_message( "start_burke_elevator_slide" );
        var_0 thread maps\_anim::anim_single_solo( self, var_1 );
        maps\_utility::delaythread( 3, common_scripts\utility::flag_set, "update_obj_pos_security_elevator" );
        common_scripts\utility::waittill_any_ents( var_0, var_1, level, "burke_elevator_landing" );
        var_1 = "elevator_descent_exit";
        var_0 maps\_anim::anim_single_solo( self, var_1 );
    }
    else
    {
        self stopanimscripted();
        var_0 maps\_anim::anim_single_solo( self, var_1 );
    }

    laboratory_start_idle();
}

laboratory_start_idle()
{
    var_0 = "elevator_descent_end_idle";
    var_1 = "elevator_descent_end_idle_2_cqb";
    var_2 = "elevator_descent_end_idle_stop";
    var_3 = common_scripts\utility::getstruct( "fusion_security_room_corpse_fall_npc", "targetname" );
    var_4 = spawn( "script_origin", var_3.origin );

    if ( isdefined( var_3.angles ) )
        var_4.angles = var_3.angles;

    var_4 thread maps\_anim::anim_loop_solo( self, var_0, var_2 );

    if ( !isdefined( level.guys_down_elevator ) )
        level.guys_down_elevator = 0;

    level.guys_down_elevator++;
    level notify( "guy_down_elevator" );

    while ( level.guys_down_elevator < 3 )
        level waittill( "guy_down_elevator" );

    common_scripts\utility::flag_wait( "negotiation_elevator_to_hall" );

    if ( self == level.burke )
        wait 4;
    else if ( self == level.carter )
        wait 1;

    var_4 notify( var_2 );
    maps\_utility::enable_cqbwalk();
    maps\_utility::enable_ai_color();
    self.moveplaybackrate = 1.1;

    if ( self == level.joker )
        common_scripts\utility::flag_set( "start_lab_traversals" );
    else
        var_4 maps\_anim::anim_single_solo_run( self, var_1 );

    var_4 delete();
}

laboratory()
{
    level endon( "airlock_scene_prep" );
    thread laboratory_cqb();
    thread play_lab_reactor_pip();
    common_scripts\utility::flag_wait( "start_lab_traversals" );
    thread lab_doorway_dyn_path();
    thread color_group_enter_lab_trigger();
    laboratory_traversal( "negotiation_elevator_to_hall", level.joker );
    laboratory_traversal( "negotiation_hall_to_lab", level.burke, "negotiation_curved_hall" );
    waitframe();
    laboratory_traversal( "negotiation_curved_hall", level.burke, "negotiation_locker_room_entrance" );
    waitframe();
    laboratory_traversal( "negotiation_locker_room_entrance", level.carter, "airlock_scene_prep" );
}

color_group_enter_lab_trigger()
{
    var_0 = getent( "color_group_enter_lab", "targetname" );

    if ( isdefined( var_0 ) )
        var_0 waittill( "trigger" );

    var_1 = getent( "negotiation_hall_to_lab_carter", "targetname" );
    var_1 delete();
    var_2 = getent( "negotiation_hall_to_lab_joker", "targetname" );
    var_2 delete();
}

lab_doorway_dyn_path()
{
    var_0 = getent( "lab_doorway_dyn_path", "targetname" );
    var_0 disconnectpaths();
    level waittill( "negotiation_hall_to_lab_dyn_path" );
    wait 5;
    var_0 connectpaths();
    var_0 delete();
}

laboratory_traversal( var_0, var_1, var_2 )
{
    if ( isdefined( var_2 ) )
        level endon( var_2 );

    common_scripts\utility::flag_wait( var_0 );
    var_3 = var_0;

    switch ( var_0 )
    {
        case "negotiation_elevator_to_hall":
            thread laboratory_elevator_to_hall( var_0, var_2 );
            var_3 = "elevator_descent_end_idle_2_cqb";
            common_scripts\utility::flag_set( "update_obj_pos_lab_follow_joker" );
            break;
        case "negotiation_hall_to_lab":
            thread negotiation_hall_to_lab( var_0, var_2 );
            maps\_utility::delaythread( 3, common_scripts\utility::flag_set, "update_obj_pos_lab_follow_burke" );
            break;
        case "negotiation_curved_hall":
            break;
        case "negotiation_locker_room_entrance":
            maps\_utility::delaythread( 3, common_scripts\utility::flag_set, "update_obj_pos_lab_follow_carter" );
            break;
        default:
            break;
    }

    var_4 = common_scripts\utility::getstruct( var_0, "targetname" );
    var_1 notify( "stop_color_move" );

    if ( var_0 != "negotiation_elevator_to_hall" )
    {
        waitframe();
        var_4 maps\_anim::anim_reach_solo( var_1, var_3, undefined, 1 );

        if ( var_0 == "negotiation_hall_to_lab" )
            level notify( "negotiation_hall_to_lab_dyn_path" );
    }
    else
        var_4 = common_scripts\utility::getstruct( "fusion_security_room_corpse_fall_npc", "targetname" );

    var_5 = var_0 + "_exit";
    var_6 = getent( var_5, "targetname" );

    if ( isdefined( var_6 ) )
        maps\_utility::activate_trigger_with_targetname( var_0 + "_exit" );

    var_4 maps\_anim::anim_single_solo_run( var_1, var_3 );
}

laboratory_elevator_to_hall( var_0, var_1 )
{
    wait 1;
    maps\_utility::activate_trigger_with_targetname( var_0 + "_carter" );

    if ( isdefined( level.carter.node ) )
        level.carter.node.script_delay = undefined;

    wait 1;

    if ( !common_scripts\utility::flag( "negotiation_hall_to_lab" ) )
        maps\_utility::activate_trigger_with_targetname( var_0 + "_burke" );

    if ( isdefined( level.burke.node ) )
        level.burke.node.script_delay = undefined;
}

negotiation_hall_to_lab( var_0, var_1 )
{
    level endon( var_1 );
    wait 1;

    if ( isdefined( getent( var_0 + "_carter", "targetname" ) ) )
        maps\_utility::activate_trigger_with_targetname( var_0 + "_carter" );

    if ( isdefined( level.carter.node ) )
        level.carter.node.script_delay = undefined;

    wait 3;

    if ( isdefined( getent( var_0 + "_carter", "targetname" ) ) )
        maps\_utility::activate_trigger_with_targetname( var_0 + "_joker" );

    if ( isdefined( level.joker.node ) )
        level.joker.node.script_delay = undefined;
}

laboratory_cqb()
{
    common_scripts\utility::flag_wait( "lab_cqb" );
    level.player maps\_utility::blend_movespeedscale_percent( 75 );
    setsaveddvar( "ai_friendlyFireBlockDuration", 0 );
    common_scripts\utility::flag_wait( "reactor_room_reveal_scene" );
    level.player maps\_utility::blend_movespeedscale_percent( 100, 5 );
    common_scripts\utility::flag_wait( "reactor_room_reveal_allies_advance" );
    setsaveddvar( "ai_friendlyFireBlockDuration", 2000 );
}

reactor_room()
{
    thread reactor_room_reveal_scene();
    thread reactor_room_drones();
    thread reactor_room_crane();
    thread handle_outline_on_grenade_launcher();

    if ( level.nextgen )
        thread reactor_room_robots();
}

handle_outline_on_grenade_launcher()
{
    var_0 = getent( "weapon_iw5_microdronelauncher_sp", "classname" );

    while ( isdefined( var_0 ) )
    {
        var_0 hudoutlinedisable( 6, 1 );

        while ( isdefined( var_0 ) && distance( var_0.origin, level.player.origin ) > 300 )
            waitframe();

        if ( !isdefined( var_0 ) )
            break;

        var_0 hudoutlineenable( 6, 1 );

        while ( isdefined( var_0 ) && distance( var_0.origin, level.player.origin ) <= 300 )
            waitframe();

        waitframe();
    }
}

reactor_room_reveal_scene()
{
    common_scripts\utility::flag_wait( "airlock_scene_prep" );

    if ( level.currentgen )
    {
        var_0 = [ "reactor_room_enemies" ];
        thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor( "reactor_room_cleanup", var_0, 15, 0 );
    }

    soundscripts\_snd::snd_message( "start_airlock_anim_notetracks" );
    var_1 = "fusion_airlock_opening_approach";
    var_2 = "fusion_airlock_opening_idle";
    var_3 = common_scripts\utility::getstruct( "airlock_anim_node", "targetname" );
    var_4 = "reactor_room_reveal_scene";
    thread reactor_room_reveal_door( var_3, "fusion_airlock_opening" );
    thread reactor_room_reveal_ally_vo_close_check();
    var_5 = [];
    var_5[var_5.size] = level.burke;
    var_5[var_5.size] = level.carter;
    level.reactor_room_reveal_scene_guys_ready = 0;
    common_scripts\utility::array_thread( var_5, ::reactor_room_reveal_scene_approach, var_3, var_1, var_2, var_4 );
    level waittill( "reactor_room_reveal_scene_prepped" );
    var_1 = "fusion_airlock_opening";
    common_scripts\utility::flag_wait( "reactor_room_reveal_scene" );
    level notify( "reactor_room_reveal_scene_started" );
    var_3 notify( var_4 );
    maps\_utility::array_notify( var_5, "reactor_room_reveal_scene" );

    if ( level.nextgen )
    {
        common_scripts\utility::array_thread( getentarray( "reactor_redshirts", "script_noteworthy" ), ::reactor_room_redshirts );
        thread reactor_room_redshirt_cleanup();
    }

    var_6 = getent( "reactor_room_airlock_enemy", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_6 notify( "handle_detection" );
    var_6 setcontents( 0 );
    var_6.ignoresonicaoe = 1;
    var_6.animname = "generic";
    var_5[var_5.size] = var_6;
    var_6 setcontents( 0 );
    var_3 thread maps\_anim::anim_single_run( var_5, var_1 );
    level.burke maps\_utility::disable_cqbwalk();
    level.joker maps\_utility::disable_cqbwalk();
    level.carter maps\_utility::disable_cqbwalk();
    level.burke.moveplaybackrate = 1;
    level.joker.moveplaybackrate = 1;
    level.carter.moveplaybackrate = 1;
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );
    maps\_utility::delaythread( 15, maps\_utility::battlechatter_on, "allies" );
    maps\_utility::delaythread( 15, maps\_utility::battlechatter_on, "axis" );
    level.burke thread reactor_room_reveal_scene_ally_think();
    level.joker thread reactor_room_reveal_scene_ally_think();
    level.carter thread reactor_room_reveal_scene_ally_think();
    common_scripts\utility::flag_set( "vo_reactor_entrance" );
    maps\_utility::delaythread( 12, maps\_utility::activate_trigger_with_noteworthy, "reactor_room_first_spawn_trigger" );
    common_scripts\utility::array_thread( getentarray( "reactor_room_robot_grid_safeguard", "targetname" ), ::reactor_room_robot_grid_ally_safeguard );
    maps\_utility::delaythread( 12, maps\_utility::activate_trigger_with_targetname, "reactor_room_door_open_color_trigger" );
    common_scripts\utility::flag_wait( "reactor_room_reveal_allies_advance" );
    level.burke maps\_utility::enable_ai_color();
    level.carter maps\_utility::enable_ai_color();

    if ( !common_scripts\utility::flag( "reactor_redshirts_enable" ) )
        maps\_utility::activate_trigger_with_targetname( "reactor_room_door_open_color_trigger" );

    common_scripts\utility::flag_set( "update_obj_pos_reactor_1" );
    maps\_utility::autosave_by_name();
    thread reactor_room_combat();
    thread reactor_room_sonic_hint_use_check();
    wait 10;
    common_scripts\utility::flag_set( "flag_show_boost_slam_hint" );
}

reactor_room_sonic_hint_use_check()
{
    level endon( "SonicAoEStarted" );
    var_0 = 512;
    wait 35;

    while ( !common_scripts\utility::flag( "flag_show_sonic_hint" ) )
    {
        var_1 = getaiarray( "axis" );
        var_1 = maps\_utility::array_removedead_or_dying( var_1 );
        var_2 = maps\_utility::get_within_range( level.player.origin, var_1, var_0 );

        if ( var_2.size > 0 )
            common_scripts\utility::flag_set( "flag_show_sonic_hint" );

        waitframe();
    }
}

reactor_room_reveal_scene_approach( var_0, var_1, var_2, var_3 )
{
    if ( self == level.carter )
        common_scripts\utility::flag_wait( "reactor_room_reveal_burke_ready" );

    maps\_utility::disable_ai_color();
    self notify( "stop_goto_node" );
    self notify( "goal" );
    var_0 maps\_anim::anim_reach_solo( self, var_1 );

    if ( self == level.burke )
        common_scripts\utility::flag_set( "reactor_room_reveal_burke_ready" );

    var_0 maps\_anim::anim_single_solo( self, var_1 );
    var_0 thread maps\_anim::anim_loop_solo( self, var_2, var_3 );
    level.reactor_room_reveal_scene_guys_ready++;

    if ( level.reactor_room_reveal_scene_guys_ready >= 2 )
        level notify( "reactor_room_reveal_scene_prepped" );
}

reactor_room_reveal_ally_vo_close_check()
{
    var_0 = getent( "airlock_vo_start_check", "targetname" );

    while ( !level.burke istouching( var_0 ) )
        wait 0.3;

    common_scripts\utility::flag_set( "vo_reactor_open_airlock" );
}

reactor_room_reveal_scene_ally_think()
{
    var_0 = self.grenadeawareness;
    self.grenadeawareness = 0;
    self.ignoreall = 1;
    common_scripts\utility::flag_wait( "reactor_room_reveal_allies_advance" );
    self.disablebulletwhizbyreaction = 1;
    self.nogrenadereturnthrow = 1;
    var_1 = self.goalradius;
    self.goalradius = 64;
    waittillframeend;
    common_scripts\utility::waittill_notify_or_timeout( "goal", 5 );
    self.ignoreall = 0;
    self.grenadeawareness = var_0;
    self.disablebulletwhizbyreaction = 0;
    self.nogrenadereturnthrow = 0;
    self.goalradius = var_1;
}

reactor_room_reveal_enemies_think()
{
    self endon( "death" );
    self.grenadeammo = 0;

    if ( isdefined( self.target ) )
        self.goalradius = 16;

    var_0 = 40000;

    while ( distancesquared( self.origin, level.burke.origin ) > var_0 )
        wait 0.1;
}

reactor_room_reveal_door( var_0, var_1 )
{
    var_2 = getent( "reactor_airlock_door_1", "targetname" );
    var_3 = getent( var_2.target, "targetname" );
    var_3 disconnectpaths();
    var_2.animname = "fusion_airlock_door";
    var_2 maps\_anim::setanimtree();
    var_0 thread maps\_anim::anim_first_frame_solo( var_2, var_1 );
    level waittill( "reactor_room_reveal_scene_prepped" );
    var_3 linkto( var_2, "door" );
    common_scripts\utility::flag_wait( "reactor_room_reveal_scene" );
    soundscripts\_snd::snd_message( "start_reactor_airlock_open", var_2 );
    soundscripts\_snd::snd_message( "start_reactor_zone_audio" );
    soundscripts\_snd::snd_message( "start_reactor_burke_attack" );
    var_4 = 45;
    var_2 playrumblelooponentity( "subtle_tank_rumble" );
    earthquake( 0.1, var_4, var_2.origin, 1000 );
    common_scripts\_exploder::exploder( 3301 );
    common_scripts\_exploder::exploder( 3302 );
    common_scripts\_exploder::exploder( 3303 );
    common_scripts\_exploder::exploder( 3304 );
    common_scripts\_exploder::exploder( 3201 );
    common_scripts\_exploder::exploder( 3202 );
    var_0 thread maps\_anim::anim_single_solo( var_2, var_1 );
    var_5 = getanimlength( var_2 maps\_utility::getanim( var_1 ) );
    common_scripts\utility::noself_delaycall( var_5, ::stopallrumbles );
    wait 15.5;
    common_scripts\utility::flag_set( "reactor_room_reveal_allies_advance" );
    var_3 connectpaths();
    waittillframeend;
    var_3 disconnectpaths();
    common_scripts\utility::flag_set( "vo_reactor_gogogo" );
}

reactor_room_reveal_squibs( var_0, var_1 )
{
    level endon( "intro_truck_left" );
    var_2 = common_scripts\utility::getstruct( "reactor_reveal_bullet_org", "targetname" );
    var_3 = common_scripts\utility::getstructarray( var_2.target, "targetname" );
    var_3 = common_scripts\utility::array_randomize( var_3 );
    var_4 = -5;
    var_5 = 5;
    var_6 = 0;

    for ( var_7 = 0; var_7 < var_0; var_7++ )
    {
        magicbullet( "iw5_ak12_sp", var_2.origin, var_3[var_6].origin + ( randomfloatrange( var_4, var_5 ), randomfloatrange( var_4, var_5 ), randomfloatrange( var_4, var_5 ) ) );

        if ( randomint( 100 ) < 10 )
            level.player playrumbleonentity( "damage_light" );

        var_6++;

        if ( var_6 >= var_3.size )
        {
            var_3 = common_scripts\utility::array_randomize( var_3 );
            var_6 = 0;
        }

        wait 0.1;
    }
}

reactor_room_robot_grid_ally_safeguard()
{
    level endon( "elevator_ascend" );
    var_0 = getent( self.target, "targetname" );
    var_1 = common_scripts\utility::getstruct( var_0.target, "targetname" );

    for (;;)
    {
        self waittill( "trigger", var_2 );
        var_3 = getaiarray( "allies" );

        foreach ( var_5 in var_3 )
        {
            if ( var_5 istouching( var_0 ) && !maps\_utility::player_can_see_ai( var_5 ) && !maps\_utility::player_looking_at( var_1.origin, undefined, 1 ) )
                var_5 forceteleport( var_1.origin, var_1.angles );
        }
    }
}

reactor_room_drones()
{
    common_scripts\utility::flag_wait( "reactor_drones_1" );
    var_0 = [];
    var_0[var_0.size] = thread vehicle_scripts\_pdrone::start_flying_attack_drone( "reactor_drone_1" );

    foreach ( var_2 in var_0 )
    {
        var_2 thread maps\_shg_utility::make_emp_vulnerable();
        var_2 laseron();
        var_2 thread reactor_room_drone_cleanup();
    }

    common_scripts\utility::flag_wait( "reactor_drones_2" );
    var_4 = [];
    var_4[var_4.size] = thread vehicle_scripts\_pdrone::start_flying_attack_drone( "reactor_drone_3" );
    var_4[var_4.size] = thread vehicle_scripts\_pdrone::start_flying_attack_drone( "reactor_drone_4" );

    foreach ( var_2 in var_4 )
    {
        var_2 thread maps\_shg_utility::make_emp_vulnerable();
        var_2 laseron();
        var_2 thread reactor_room_drone_cleanup();
    }
}

reactor_room_drone_cleanup()
{
    self endon( "death" );
    common_scripts\utility::flag_wait( "reactor_room_end_combat" );
    wait(randomfloatrange( 1, 3 ));
    self kill();
}

reactor_room_crane()
{
    level waittill( "reactor_room_reveal_scene_started" );
    var_0 = getentarray( "reactor_crane_track", "targetname" );
    var_1 = [];
    var_2 = common_scripts\utility::getstruct( "reactor_crane_track_inner", "targetname" );
    var_3 = common_scripts\utility::getstruct( var_2.target, "targetname" );
    var_1["min_dist"] = int( distance( var_0[0].origin, var_2.origin ) );
    var_1["max_dist"] = int( distance( var_0[0].origin, var_3.origin ) );
    var_4 = common_scripts\utility::getstruct( "reactor_crane_height_top", "targetname" );
    var_5 = common_scripts\utility::getstruct( var_4.target, "targetname" );
    var_1["crane_height_delta"] = distance( var_4.origin, var_5.origin );
    var_1["rot_speed"] = 30;
    var_1["rot_delay"] = 0.1;
    var_1["crane_housing_move_speed"] = 75;
    var_1["crane_housing_move_delay"] = 1;
    var_1["height_time"] = 2.5;
    var_1["height_acc"] = 0.5;
    var_1["height_dec"] = 1.5;
    var_1["lower_delay"] = 1;
    var_1["raise_delay"] = 1;
    var_1["crate_height"] = 72;
    var_1["cable_height"] = 40;
    level.reactor_room_crate_tracking = [];
    level.reactor_room_crate_tracking["scripted_crate"] = 0;
    level.reactor_room_crate_tracking["near_player"] = 0;
    level.reactor_room_crate_tracking["near_enemies"] = 0;
    var_6 = getentarray( "reactor_cover_crate", "script_noteworthy" );
    common_scripts\utility::array_thread( var_6, ::reactor_room_crate_think );
    var_0 = getentarray( "reactor_crane_track", "targetname" );
    var_0[0] thread reactor_room_crane_think( var_1, "north", var_6 );
    var_0[1] thread reactor_room_crane_think( var_1, "south", var_6 );
}

crane_cable( var_0, var_1 )
{
    var_2 = self;

    while ( isdefined( var_2.target ) )
    {
        var_2 = getent( var_2.target, "targetname" );
        var_2 hide();
    }

    var_3 = var_1["cable_height"];
    thread stop_crane_audio( var_0 );

    for (;;)
    {
        var_0 reactor_room_link_cables( self, 1 );
        var_0 waittill( "crane_moving" );
        var_0 reactor_room_link_cables( self, 0 );
        soundscripts\_snd::snd_message( "crane_claw_drop_start", var_0 );
        var_0 crane_animated_down( self, var_0, var_1 );
        var_0 waittill( "crane_stopped" );
        soundscripts\_snd::snd_message( "crane_claw_drop_stop", var_0 );
        var_0 waittill( "crane_moving" );
        soundscripts\_snd::snd_message( "crane_claw_rise_start", var_0 );
        var_0 crane_animated_up( self, var_0, var_1 );
        var_0 waittill( "crane_stopped" );
        soundscripts\_snd::snd_message( "crane_claw_rise_stop", var_0 );
    }
}

stop_crane_audio( var_0 )
{
    if ( level.currentgen )
    {
        level waittill( "tff_pre_transition_middle_to_outro" );
        var_0 notify( "stop_claw_beep" );
        var_0 stoploopsound( "crane_rctr_claw_drop_lp" );
        var_0 stoploopsound( "crane_rctr_claw_rise_lp" );
    }
}

crane_animated_down( var_0, var_1, var_2 )
{
    var_0 thread crane_cable_down( var_1, var_2 );
}

crane_animated_up( var_0, var_1, var_2 )
{
    var_1.last_cable thread crane_cable_up( var_1 );
}

crane_cable_down( var_0, var_1 )
{
    attach_housing( var_0 );
    var_0 endon( "crane_stopped" );

    while ( distancesquared( self.og, self getorigin() ) < squared( var_1["cable_height"] ) )
        wait 0.05;

    if ( !isdefined( self.target ) )
        return;

    var_2 = getent( self.target, "targetname" );
    var_2 thread crane_cable_down( var_0, var_1 );
}

attach_housing( var_0 )
{
    self.og = self getorigin();
    self linkto( var_0 );
    var_0.last_cable = self;

    if ( !isdefined( self.target ) )
        return;

    var_1 = getent( self.target, "targetname" );
    var_1 show();
}

crane_cable_up( var_0 )
{
    var_0 endon( "crane_stopped" );

    while ( distancesquared( self.og, self getorigin() ) > squared( 10 ) )
        wait 0.05;

    thread detach_housing( var_0 );

    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "crane_cable" )
        return;

    var_1 = getent( self.targetname, "target" );
    var_1 thread crane_cable_up( var_0 );
}

detach_housing( var_0 )
{
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "crane_cable" )
        return;

    self unlink();
    var_1 = 0.5;
    self moveto( self.og, var_1 );
    wait(var_1);
    self hide();
}

reactor_room_crane_think( var_0, var_1, var_2 )
{
    level endon( "elevator_ascend" );
    var_3 = self;
    var_4 = getent( var_3.target, "targetname" );
    var_5 = getentarray( var_4.target, "targetname" );
    var_6 = undefined;
    var_7 = undefined;
    var_8 = undefined;
    var_9 = undefined;

    foreach ( var_11 in var_5 )
    {
        if ( var_11.classname == "script_model" )
        {
            var_6 = var_11;
            continue;
        }

        if ( var_11.classname == "script_brushmodel" )
        {
            var_8 = var_11;
            continue;
        }

        if ( var_11.classname == "trigger_multiple" )
        {
            var_9 = var_11;
            continue;
        }

        var_7 = var_11;
    }

    var_8 linkto( var_6 );
    var_9 enablelinkto();
    var_9 linkto( var_6 );
    var_6.animname = "reactor_crane";
    var_6 maps\_anim::setanimtree();
    var_6 thread maps\_anim::anim_first_frame_solo( var_6, "crane_opened" );
    var_13 = getent( var_6.target, "targetname" );
    var_13 thread crane_cable( var_6, var_0 );
    var_6 linkto( var_4 );
    var_4 linkto( var_3 );
    var_3.track_inner = common_scripts\utility::spawn_tag_origin();
    var_3.track_inner.origin = var_3.origin + ( 742, 0, 0 );
    var_3.track_inner linkto( var_3 );
    var_3.track_inner thread maps\fusion_utility::delete_on_notify( "reactor_room_cleanup" );
    var_3.track_outer = common_scripts\utility::spawn_tag_origin();
    var_3.track_outer.origin = var_3.origin + ( 1354, 0, 0 );
    var_3.track_outer linkto( var_3 );
    var_3.track_outer thread maps\fusion_utility::delete_on_notify( "reactor_room_cleanup" );
    var_14 = common_scripts\utility::spawn_tag_origin();
    var_14.origin = var_4.origin;
    var_14 linkto( var_4 );
    var_14 thread maps\fusion_utility::delete_on_notify( "reactor_room_cleanup" );
    var_15 = common_scripts\utility::spawn_tag_origin();
    var_15.origin = var_6.origin;
    var_15 linkto( var_6 );
    var_15 thread maps\fusion_utility::delete_on_notify( "reactor_room_cleanup" );
    var_7 enablelinkto();
    var_7 linkto( var_6 );
    var_6 thread reactor_room_crane_light();
    var_16 = [];

    foreach ( var_18 in var_2 )
    {
        var_19 = vectortoangles( var_18.origin - var_3.origin )[1];

        if ( var_19 < 20 )
            var_19 += 360;

        if ( var_19 < 200 && var_1 == "south" )
            continue;

        if ( var_19 >= 200 && var_1 == "north" )
            continue;

        var_16[var_16.size] = var_18;
    }

    var_21 = 175;

    if ( var_1 == "south" )
    {
        var_21 = 200;
        reactor_room_crane_rotate_to_angle( var_3, 200, var_0["rot_speed"], var_0["rot_delay"] );
        common_scripts\utility::flag_wait( "reactor_room_crane_south_start" );
    }
    else
        wait 15;

    for (;;)
    {
        if ( var_1 == "north" && common_scripts\utility::flag( "reactor_room_crane_south_start" ) )
            break;

        if ( var_16.size == 0 )
            break;

        var_18 = reactor_room_get_best_crate( var_16, var_1 );
        var_16 = common_scripts\utility::array_remove( var_16, var_18 );
        var_19 = vectortoangles( var_18.origin - var_3.origin )[1];
        reactor_room_crane_rotate_to_angle( var_3, var_19, var_0["rot_speed"], var_0["rot_delay"] );
        var_22 = distance2d( var_3.origin, var_18.origin );
        var_4 unlink();
        playfxontag( common_scripts\utility::getfx( "fus_crane_housing_dust_fall" ), var_14, "tag_origin" );
        reactor_room_crane_adjust_housing( var_3, var_4, var_19, var_22, var_0["crane_housing_move_speed"], var_0["crane_housing_move_delay"] );
        var_4 linkto( var_3 );
        var_6 unlink();
        var_23 = var_6.origin;
        var_6 notify( "crane_moving" );
        thread reactor_room_crane_murderplayer_think( var_9, var_6, var_18, var_0 );
        playfxontag( common_scripts\utility::getfx( "fus_crane_housing_dust" ), var_15, "tag_origin" );
        var_6 moveto( var_18.origin + ( 0, 0, var_0["crate_height"] ), var_0["height_time"], var_0["height_acc"], var_0["height_dec"] );
        wait(var_0["height_time"]);
        var_6 notify( "crane_stopped" );
        thread reactor_room_crane_grab_crate( var_6, var_18, var_0 );
        var_6 waittill( "crate_grabbed" );
        var_24 = common_scripts\utility::spawn_tag_origin();
        var_24.origin = var_18.origin;
        var_24 linkto( var_18 );
        playfxontag( common_scripts\utility::getfx( "fus_crate_dust_lift" ), var_24, "tag_origin" );
        var_18 notify( "crate_raised" );
        level notify( "crate_raising" );
        var_6 notify( "crane_moving" );
        var_6 moveto( var_23, var_0["height_time"], var_0["height_acc"], var_0["height_dec"] );
        wait(var_0["height_time"]);
        var_6 notify( "crane_stopped" );
        wait(var_0["raise_delay"]);
        var_6 linkto( var_4 );
        var_19 = var_21;
        reactor_room_crane_rotate_to_angle( var_3, var_19, var_0["rot_speed"], var_0["rot_delay"] );
        var_22 = randomintrange( var_0["min_dist"], var_0["max_dist"] );
        var_4 unlink();
        reactor_room_crane_adjust_housing( var_3, var_4, var_19, var_22, var_0["crane_housing_move_speed"], var_0["crane_housing_move_delay"] );
        var_4 linkto( var_3 );
        var_6 notify( "crane_moving" );
        var_6 unlink();
        var_6 moveto( var_6.origin - ( 0, 0, var_0["crane_height_delta"] ), var_0["height_time"], var_0["height_acc"], var_0["height_dec"] );
        wait(var_0["height_time"]);
        var_6 notify( "crane_stopped" );
        wait(var_0["lower_delay"]);
        var_6 notify( "crate_release" );
        var_24 delete();
        wait 0.05;
        var_6 notify( "crane_moving" );
        var_6 moveto( var_6.origin + ( 0, 0, var_0["crane_height_delta"] ), var_0["height_time"], var_0["height_acc"], var_0["height_dec"] );
        wait(var_0["height_time"]);
        var_6 notify( "crane_stopped" );
        wait(var_0["raise_delay"]);
        var_6 linkto( var_4 );
    }

    for (;;)
    {
        switch ( var_1 )
        {
            case "north":
                var_19 = randomintrange( 25, 180 );
                break;
            case "south":
            default:
                var_19 = randomintrange( 180, 360 );
                break;
        }

        var_22 = randomintrange( var_0["min_dist"], var_0["max_dist"] );
        reactor_room_crane_rotate_to_angle( var_3, var_19, var_0["rot_speed"], var_0["rot_delay"] );
        var_4 unlink();
        playfxontag( common_scripts\utility::getfx( "fus_crane_housing_dust_fall" ), var_14, "tag_origin" );
        reactor_room_crane_adjust_housing( var_3, var_4, var_19, var_22, var_0["crane_housing_move_speed"], var_0["crane_housing_move_delay"] );
        var_4 linkto( var_3 );
        wait(randomfloatrange( 3, 7 ));
    }
}

reactor_room_crane_murderplayer_think( var_0, var_1, var_2, var_3 )
{
    var_1 endon( "crane_stopped" );
    self endon( "murderbox_activate" );

    for (;;)
    {
        if ( distance( var_0.origin, var_2.origin ) < 85 )
        {
            if ( level.player istouching( var_0 ) )
            {
                var_4 = level.player.health / level.player.damagemultiplier;
                level.player dodamage( var_4, var_1.origin );
                self notify( "murderbox_activate" );
            }
        }

        waitframe();
    }
}

reactor_room_crane_grab_crate( var_0, var_1, var_2 )
{
    var_0 maps\_anim::anim_single_solo( var_0, "crane_grab" );
    var_0 thread maps\_anim::anim_first_frame_solo( var_0, "crane_closed" );
    soundscripts\_snd::snd_message( "crane_claw_crate_grab", var_0 );
    var_1 linkto( var_0 );
    wait 0.05;
    var_0 notify( "crate_grabbed" );
    var_0 waittill( "crate_release" );
    var_0 thread maps\_anim::anim_first_frame_solo( var_0, "crane_opened" );
    soundscripts\_snd::snd_message( "crane_claw_crate_release", var_0 );
    var_1 delete();
}

reactor_room_crane_light()
{
    level endon( "elevator_ascend" );
    var_0 = common_scripts\utility::spawn_tag_origin();
    var_0.origin = self.origin;
    var_0.angles = self.angles;
    var_0 linkto( self );
    var_0 thread maps\fusion_utility::delete_on_notify( "reactor_room_cleanup" );

    while ( !common_scripts\utility::flag( "elevator_ascend" ) )
    {
        playfxontag( common_scripts\utility::getfx( "fus_crane_light_red" ), var_0, "tag_origin" );
        self waittill( "crate_grabbed" );
        stopfxontag( common_scripts\utility::getfx( "fus_crane_light_red" ), var_0, "tag_origin" );
        playfxontag( common_scripts\utility::getfx( "fus_crane_light_green" ), var_0, "tag_origin" );
        self waittill( "crate_release" );
        stopfxontag( common_scripts\utility::getfx( "fus_crane_light_green" ), var_0, "tag_origin" );
    }
}

reactor_room_link_cables( var_0, var_1 )
{
    var_2 = var_0;

    if ( var_1 )
        var_2 linkto( self );
    else
        var_2 unlink();

    while ( isdefined( var_2.target ) )
    {
        var_2 = getent( var_2.target, "targetname" );

        if ( var_1 )
        {
            var_2 linkto( self );
            continue;
        }

        var_2 unlink();
    }
}

reactor_room_get_best_crate( var_0, var_1 )
{
    var_2 = 10000;
    var_3 = 10000;
    var_4 = 1000000;
    var_5 = ( 0, 0, 32 );
    var_6 = 65;

    if ( level.reactor_room_crate_tracking["scripted_crate"] < 1 )
    {
        level.reactor_room_crate_tracking["scripted_crate"]++;
        thread reactor_room_allies_run_from_crate();
        return common_scripts\utility::getclosest( ( 3290, 3676, -601 ), var_0, 200 );
    }

    if ( level.reactor_room_crate_tracking["near_player"] < 1 )
    {
        foreach ( var_8 in var_0 )
        {
            if ( distancesquared( var_8.origin, level.player.origin ) < var_2 )
            {
                level.reactor_room_crate_tracking["near_player"]++;
                return var_8;
            }
        }
    }

    if ( level.reactor_room_crate_tracking["near_enemies"] < 3 )
    {
        foreach ( var_8 in var_0 )
        {
            foreach ( var_12 in getaiarray( "axis" ) )
            {
                if ( distancesquared( var_8.origin, var_12.origin ) < var_3 )
                {
                    if ( distancesquared( level.player.origin, var_8.origin ) < var_4 )
                    {
                        level.reactor_room_crate_tracking["near_enemies"]++;
                        return var_8;
                    }
                }
            }
        }
    }

    foreach ( var_8 in var_0 )
    {
        if ( level.player worldpointinreticle_circle( var_8.origin + var_5, var_6, 500 ) )
        {
            if ( distancesquared( level.player.origin, var_8.origin ) > var_2 )
            {
                if ( distancesquared( level.player.origin, var_8.origin ) < var_4 )
                    return var_8;
            }
        }
    }

    return var_0[randomint( var_0.size )];
}

reactor_room_crane_rotate_to_angle( var_0, var_1, var_2, var_3 )
{
    if ( var_1 >= 360 )
        var_1 -= 360;

    var_4 = abs( var_0.angles[1] - var_1 ) / var_2;
    var_5 = 2;
    var_6 = 2;

    if ( var_4 < 2 )
        var_4 = 2;

    if ( var_4 < 4 )
    {
        var_5 = var_4 / 2;
        var_6 = var_4 / 2;
    }

    if ( var_4 > 0 )
    {
        playfxontag( common_scripts\utility::getfx( "fus_crane_track_sparks" ), var_0.track_inner, "tag_origin" );
        playfxontag( common_scripts\utility::getfx( "fus_crane_track_sparks" ), var_0.track_outer, "tag_origin" );
        soundscripts\_snd::snd_message( "crane_mach_mvmnt_start", var_0.track_inner, var_0.track_outer );
        var_0 rotateto( ( 0, var_1, 0 ), var_4, var_5, var_6 );
        wait(var_4);
        stopfxontag( common_scripts\utility::getfx( "fus_crane_track_sparks" ), var_0.track_inner, "tag_origin" );
        stopfxontag( common_scripts\utility::getfx( "fus_crane_track_sparks" ), var_0.track_outer, "tag_origin" );
        soundscripts\_snd::snd_message( "crane_mach_mvmnt_stop", var_0.track_inner, var_0.track_outer );
    }

    wait(var_3);
}

reactor_room_crane_adjust_housing( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = cos( var_2 ) * var_3;
    var_7 = sin( var_2 ) * var_3;
    var_8 = ( var_0.origin[0] + var_6, var_0.origin[1] + var_7, var_1.origin[2] );
    var_9 = distance( var_8, var_1.origin ) / var_4;

    if ( var_9 > 0 )
    {
        soundscripts\_snd::snd_message( "crane_claw_mvmnt_start", var_1 );
        var_1 moveto( var_8, var_9, var_9 / 2, var_9 / 2 );
        wait(var_9);
        soundscripts\_snd::snd_message( "crane_claw_mvmnt_stop", var_1 );
    }

    wait(var_5);
}

reactor_room_crate_think()
{
    self disconnectpaths();
    var_0 = common_scripts\utility::get_target_ent();
    var_0 linkto( self );
    self waittill( "crate_raised" );
    var_1 = self.origin;
    badplace_cylinder( "", 3, var_1, 80, 64, "axis", "allies" );
    var_2 = getnodesinradius( var_1, 80, 0, 128, "Cover" );

    foreach ( var_4 in var_2 )
        var_4 disconnectnode();

    wait 3;
    self connectpaths();
    self waittill( "death" );
    var_0 delete();
}

get_angle_from_center( var_0, var_1 )
{
    return vectortoangles( var_1 - var_0 )[1];
}

reactor_room_robots()
{
    common_scripts\utility::flag_wait( "reactor_room_reveal_scene" );
    var_0 = getentarray( "reactor_bot", "targetname" );
    common_scripts\utility::array_thread( getentarray( "reactor_bot", "targetname" ), ::reactor_room_robot_think );
    common_scripts\utility::array_thread( getentarray( "reactor_bot_scripted", "targetname" ), ::reactor_room_robot_scripted_think );
}

reactor_room_robot_think()
{
    level endon( "elevator_ascend" );
    self endon( "death" );
    self endon( "stop_movement" );
    self.health = 100;
    self setcandamage( 1 );
    thread reactor_room_robot_monitor_death();
    thread maps\_shg_utility::make_emp_vulnerable();
    self.emp_death_function = ::reactor_room_robot_emp_death;
    self.facing = 1;
    var_0 = common_scripts\utility::getstruct( self.target, "targetname" );
    var_1 = common_scripts\utility::getstruct( var_0.target, "targetname" );
    var_2 = common_scripts\utility::getstruct( var_1.target, "targetname" );
    self.collision = getent( self.target, "targetname" );
    self.collision linkto( self );
    var_3 = 32;
    var_4 = 0.5;
    var_5 = distance( var_0.origin, var_1.origin ) / var_3 + 1;
    var_6 = distance( var_1.origin, var_2.origin ) / var_3 + 1;

    if ( var_5 - int( var_5 ) > 0.5 )
    {
        var_5 = int( var_5 );
        var_5++;
    }
    else
        var_5 = int( var_5 );

    if ( var_6 - int( var_6 ) > 0.5 )
    {
        var_6 = int( var_6 );
        var_6++;
    }
    else
        var_6 = int( var_6 );

    var_7 = vectortoangles( var_1.origin - var_0.origin );
    var_8 = vectortoangles( var_2.origin - var_1.origin );
    var_9 = getentarray( var_2.target, "targetname" );
    self.collision thread reactor_robots_badplace_think();
    common_scripts\utility::array_thread( var_9, ::reactor_robots_shelf_think );
    var_10 = [];

    for ( var_11 = 0; var_11 < var_5; var_11++ )
    {
        for ( var_12 = 0; var_12 < var_6; var_12++ )
        {
            var_10[var_11][var_12] = spawnstruct();
            var_13 = var_3 * var_11 * cos( var_7[1] ) + var_3 * var_12 * sin( -1 * var_7[1] );
            var_14 = -1 * var_3 * var_11 * cos( var_8[1] ) + var_3 * var_12 * sin( var_8[1] );
            var_10[var_11][var_12].origin = ( var_13, var_14, 0 ) + var_0.origin;
            var_15 = 0;

            foreach ( var_17 in var_9 )
            {
                var_18 = var_10[var_11][var_12].origin;

                if ( distance( var_10[var_11][var_12].origin, var_17.origin ) < 16 )
                {
                    var_10[var_11][var_12].shelf = 1;
                    var_17.x = var_11;
                    var_17.y = var_12;
                }
            }

            if ( distance( var_10[var_11][var_12].origin, self.origin ) < 10 )
            {
                var_10[var_11][var_12].robot = 1;
                self.x = var_11;
                self.y = var_12;
            }
        }
    }

    for (;;)
    {
        foreach ( var_17 in var_9 )
        {
            var_10 = clear_path_weights( var_10 );
            var_10 = add_path_weights( var_10, var_17.x, var_17.y, 0, 0 );

            if ( !isdefined( var_17.starting_origin ) )
                var_17.starting_origin = var_17.origin;

            self notify( "update_path_weights" );
            move_to_dest( var_10, var_17.x, var_17.y );
            var_10 = clear_path_weights( var_10 );
            var_21 = 0;
            var_22 = 10;
            var_23 = 0;
            var_24 = 0;

            while ( var_21 <= var_22 && !( isdefined( var_10[var_23][var_24].path_weight ) && isdefined( var_10[self.x][self.y].path_weight ) && ( var_23 != self.x || var_24 != self.y ) ) )
            {
                var_23 = randomint( var_5 );
                var_24 = randomint( var_6 );
                var_10 = clear_path_weights( var_10 );
                var_10 = add_path_weights( var_10, var_23, var_24, 0, 1 );
                var_21++;
                wait 0.05;
            }

            if ( var_21 > var_22 )
            {
                wait 2;
                continue;
            }

            soundscripts\_snd::snd_message( "reactor_bot_shelf_pickup", self );
            var_17 moveto( ( var_17.origin[0], var_17.origin[1], var_17.starting_origin[2] + var_4 ), 0.2, 0.1, 0.1 );
            wait 0.2;
            var_17 linkto( self );
            self.shelf = var_17;
            self notify( "update_path_weights" );
            move_to_dest( var_10, var_23, var_24 );
            var_17.x = var_23;
            var_17.y = var_24;
            var_17 unlink();
            self.shelf = undefined;
            soundscripts\_snd::snd_message( "reactor_bot_shelf_drop", self );
            var_17 moveto( ( var_17.origin[0], var_17.origin[1], var_17.starting_origin[2] + var_4 ), 0.2, 0.1, 0.1 );
            wait 0.2;
        }
    }
}

reactor_room_robot_emp_death()
{
    self endon( "death" );
    self notify( "stop_movement" );
    self notify( "emp" );
    playfxontag( common_scripts\utility::getfx( "emp_reactor_robot_damage" ), self, "tag_origin" );
    self moveto( self.origin, 0.05 );
    self rotateto( self.angles, 0.05 );
    wait(randomfloatrange( 0.5, 1.5 ));
    stopfxontag( common_scripts\utility::getfx( "emp_reactor_robot_damage" ), self, "tag_origin" );
    self notify( "death" );
}

reactor_room_robot_monitor_death()
{
    self endon( "emp" );
    self endon( "robot_lowered" );
    self waittill( "death" );
    self notify( "stop_movement" );
    playfx( common_scripts\utility::getfx( "reactor_robot_death" ), self.origin );
}

move_to_dest( var_0, var_1, var_2 )
{
    self endon( "stop_movement" );
    var_3 = 1;
    var_4 = 1;
    var_5 = 0.05;

    for ( var_6 = isdefined( self.shelf ); !( self.x == var_1 && self.y == var_2 ); self.y = var_7[1] )
    {
        var_7 = get_next_grid_position( var_0, self.x, self.y );

        if ( var_6 )
            var_0[self.x][self.y].shelf = undefined;

        if ( self.facing_goal != self.facing )
        {
            if ( var_6 )
                self.shelf unlink();

            self.collision unlink();
            self rotateto( self.angles + ( 0, 90 * ( self.facing_goal - self.facing ), 0 ), var_4 );
            self.facing = self.facing_goal;

            if ( var_6 )
                soundscripts\_snd::snd_message( "reactor_bot_turn_shelf", self );
            else
                soundscripts\_snd::snd_message( "reactor_bot_turn_self", self );

            wait(var_4 + var_5);

            if ( var_6 )
                self.shelf linkto( self );

            self.collision linkto( self );
        }

        wait_until_path_safe();

        if ( var_6 )
            soundscripts\_snd::snd_message( "reactor_bot_drive_shelf_start", self );
        else
            soundscripts\_snd::snd_message( "reactor_bot_drive_self_start", self );

        self moveto( var_0[var_7[0]][var_7[1]].origin, var_3 );
        wait(var_3 + var_5);

        if ( var_6 )
            soundscripts\_snd::snd_message( "reactor_bot_drive_shelf_stop", self );
        else
            soundscripts\_snd::snd_message( "reactor_bot_drive_self_stop", self );

        if ( var_6 )
            var_0[var_7[0]][var_7[1]].shelf = 1;

        self.x = var_7[0];
    }
}

wait_until_path_safe()
{
    var_0 = 0;

    while ( !var_0 )
    {
        var_0 = 1;

        if ( distance( self.origin, level.player.origin ) < 200 )
        {
            var_0 = 0;
            wait 0.5;
            continue;
        }

        foreach ( var_2 in getaiarray() )
        {
            if ( distancesquared( self.origin, var_2.origin ) < 9216 )
            {
                var_0 = 0;
                wait 0.5;
                break;
            }
        }
    }
}

get_next_grid_position( var_0, var_1, var_2 )
{
    var_3 = var_0[var_1][var_2].path_weight;
    var_4 = var_0.size;
    var_5 = var_0[0].size;
    var_6 = 999;
    var_7 = undefined;

    if ( var_1 > 0 )
    {
        var_8 = var_0[var_1 - 1][var_2].path_weight;

        if ( isdefined( var_8 ) )
        {
            if ( var_8 < var_6 )
            {
                var_6 = var_8;
                var_7 = "left";
            }
        }
    }

    if ( var_1 < var_4 - 1 )
    {
        var_8 = var_0[var_1 + 1][var_2].path_weight;

        if ( isdefined( var_8 ) )
        {
            if ( var_8 < var_6 )
            {
                var_6 = var_8;
                var_7 = "right";
            }
        }
    }

    if ( var_2 > 0 )
    {
        var_8 = var_0[var_1][var_2 - 1].path_weight;

        if ( isdefined( var_8 ) )
        {
            if ( var_8 < var_6 )
            {
                var_6 = var_8;
                var_7 = "down";
            }
        }
    }

    if ( var_2 < var_5 - 1 )
    {
        var_8 = var_0[var_1][var_2 + 1].path_weight;

        if ( isdefined( var_8 ) )
        {
            if ( var_8 < var_6 )
            {
                var_6 = var_8;
                var_7 = "up";
            }
        }
    }

    var_9 = [];

    switch ( var_7 )
    {
        case "left":
            var_9 = [ var_1 - 1, var_2 ];
            self.facing_goal = 1;
            break;
        case "right":
            var_9 = [ var_1 + 1, var_2 ];
            self.facing_goal = 3;
            break;
        case "down":
            var_9 = [ var_1, var_2 - 1 ];
            self.facing_goal = 2;
            break;
        case "up":
            var_9 = [ var_1, var_2 + 1 ];
            self.facing_goal = 0;
            break;
        default:
            break;
    }

    return var_9;
}

clear_path_weights( var_0 )
{
    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        for ( var_2 = 0; var_2 < var_0[var_1].size; var_2++ )
            var_0[var_1][var_2].path_weight = undefined;
    }

    return var_0;
}

add_path_weights( var_0, var_1, var_2, var_3, var_4 )
{
    if ( var_4 && isdefined( var_0[var_1][var_2].shelf ) && var_0[var_1][var_2].shelf && !( self.x == var_1 && self.y == var_2 ) )
    {
        var_0[var_1][var_2].path_weight = undefined;
        return var_0;
    }

    var_5 = var_0[var_1][var_2].path_weight;
    var_6 = var_0.size;
    var_7 = var_0[0].size;

    if ( var_3 > 25 )
        return var_0;

    if ( !isdefined( var_5 ) || var_5 > var_3 )
    {
        var_0[var_1][var_2].path_weight = var_3;
        var_3++;

        if ( var_1 > 0 )
            var_0 = add_path_weights( var_0, var_1 - 1, var_2, var_3, var_4 );

        if ( var_1 < var_6 - 1 )
            var_0 = add_path_weights( var_0, var_1 + 1, var_2, var_3, var_4 );

        if ( var_2 > 0 )
            var_0 = add_path_weights( var_0, var_1, var_2 - 1, var_3, var_4 );

        if ( var_2 < var_7 - 1 )
            var_0 = add_path_weights( var_0, var_1, var_2 + 1, var_3, var_4 );
    }

    return var_0;
}

reactor_robots_shelf_think()
{
    var_0 = getentarray( self.target, "targetname" );

    foreach ( var_2 in var_0 )
        var_2 linkto( self );

    reactor_robots_badplace_think();
}

reactor_robots_badplace_think()
{
    var_0 = 0.1;

    if ( level.currentgen )
        var_0 = 0.3;

    var_1 = 31;
    var_2 = 128;

    while ( !common_scripts\utility::flag( "elevator_ascend" ) )
    {
        self connectpaths();
        self disconnectpaths();
        wait(var_0);
    }

    self connectpaths();
}

reactor_room_robot_scripted_think()
{
    level endon( "elevator_ascend" );
    var_0 = getentarray( self.target, "targetname" );
    var_0 = common_scripts\utility::array_combine( var_0, common_scripts\utility::getstructarray( self.target, "targetname" ) );
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;
    var_7 = 1;
    var_8 = [];
    var_8[var_8.size] = 18;
    var_8[var_8.size] = 36;
    var_8[var_8.size] = 54;

    foreach ( var_10 in var_0 )
    {
        switch ( var_10.script_parameters )
        {
            case "start_node":
                var_1 = var_10;
                break;
            case "initial_lift":
                var_11 = getentarray( "reactor_robot_lift", "script_noteworthy" );

                foreach ( var_13 in var_11 )
                {
                    if ( distance( var_13.origin, var_10.origin ) < 10 )
                    {
                        var_3 = var_13;
                        break;
                    }
                }

                break;
            case "initial_lift_gate":
                var_15 = getentarray( "bot_lift_gate", "script_noteworthy" );

                foreach ( var_17 in var_15 )
                {
                    if ( distance( var_17.origin, var_10.origin ) < 10 )
                    {
                        var_2 = var_17;
                        break;
                    }
                }

                break;
            case "final_lift":
                var_11 = getentarray( "reactor_robot_lift", "script_noteworthy" );

                foreach ( var_13 in var_11 )
                {
                    if ( distance( var_13.origin, var_10.origin ) < 10 )
                    {
                        var_4 = var_13;
                        break;
                    }
                }

                break;
            case "final_gate":
                var_21 = getentarray( "reactor_robot_final_gate", "script_noteworthy" );

                foreach ( var_17 in var_21 )
                {
                    if ( distance( var_17.origin, var_10.origin ) < 10 )
                    {
                        var_5 = var_17;
                        break;
                    }
                }

                break;
            case "shelf":
                var_6 = var_10;
                var_6 thread reactor_robots_badplace_think();
                break;
            default:
                break;
        }
    }

    if ( !isdefined( var_1 ) )
        return;

    if ( !isdefined( var_3 ) )
        return;

    if ( !isdefined( var_2 ) )
        return;

    if ( !isdefined( var_4 ) )
        return;

    if ( !isdefined( var_5 ) )
        return;

    if ( !isdefined( var_6 ) )
        return;

    var_25 = var_6.origin;
    var_26 = 1;
    var_27 = 32;
    var_28 = 4;
    var_29 = 64;
    var_30 = 3;
    var_31 = 1;
    var_32 = 1;
    var_33 = 3;
    var_34 = 1;
    var_35 = 1;
    var_36 = 1;
    var_29 = 44;
    var_37 = var_33;
    var_30 = var_33 / 2;
    var_31 = var_30 / 2;
    var_32 = var_30 / 2;
    var_38 = 1;
    var_39 = 0.5;
    var_40 = 0.5;
    var_41 = common_scripts\utility::getstruct( var_5.target, "targetname" ).origin;
    var_42 = var_5.origin;
    var_43 = 128;
    var_44 = 3;
    var_45 = 1;
    var_46 = 1;
    var_3.bars = [];
    var_4.bars = [];
    var_47 = common_scripts\utility::getstructarray( "lift_bars", "targetname" );

    foreach ( var_49 in var_47 )
    {
        if ( distance( var_49.origin, var_3.origin ) < 64 )
        {
            var_3.bars[var_3.bars.size] = var_49;
            var_50 = getentarray( var_49.target, "targetname" );

            foreach ( var_52 in var_50 )
                var_52 linkto( var_3 );

            continue;
        }

        if ( distance( var_49.origin, var_4.origin ) < 64 )
        {
            var_4.bars[var_4.bars.size] = var_49;
            var_50 = getentarray( var_49.target, "targetname" );

            foreach ( var_52 in var_50 )
                var_52 linkto( var_4 );
        }
    }

    for (;;)
    {
        reactor_room_robots_lift_adjust_bars( var_3, "lower", "initial" );
        wait(randomfloatrange( 1, 10 ));
        var_6.origin = var_25;
        var_6 linkto( self );
        wait 0.05;
        var_57 = var_1.angles;
        var_58 = var_57;

        if ( self.angles != var_1.angles )
        {
            self rotateto( var_1.angles, 0.05 );
            wait 0.1;
        }

        var_59 = spawn( "script_model", self.origin );
        var_59 setmodel( "fus_shelving_robot_01" );
        var_59.angles = self.angles;
        var_59 linkto( self );
        var_59 endon( "stop_movement" );
        var_59.health = 100;
        var_59 setcandamage( 1 );
        var_59 thread maps\_shg_utility::make_emp_vulnerable();
        var_59.emp_death_function = ::reactor_room_robot_emp_death;
        var_59 thread reactor_room_robot_monitor_death();
        var_60 = spawn( "script_model", self.origin );
        var_60 setmodel( "fus_shelving_unit_cage_01" );
        var_60.angles = self.angles;
        var_60 linkto( var_6 );
        var_6.models = [];
        var_6.models[var_6.models.size] = var_59;
        var_6.models[var_6.models.size] = var_60;

        for ( var_61 = 0; var_61 < 3; var_61++ )
        {
            if ( common_scripts\utility::cointoss() )
            {
                var_62 = spawn( "script_model", self.origin + ( 0, 0, var_8[var_61] ) );
                var_62 setmodel( "fus_shelving_unit_item_01" );
                var_62.angles = self.angles + ( 0, 90, 0 );
                var_62 linkto( var_6 );
                var_6.models[var_6.models.size] = var_62;
            }
        }

        self linkto( var_3 );
        var_63 = common_scripts\utility::getstruct( var_1.target, "targetname" );
        var_64 = self.origin[2] - var_63.origin[2];
        soundscripts\_snd::snd_message( "reactor_bot_elevator_start_lp", var_3 );
        var_3 moveto( var_3.origin - ( 0, 0, var_64 ), var_33, var_34, var_35 );
        var_2 common_scripts\utility::delaycall( var_37, ::moveto, var_2.origin - ( 0, 0, var_29 ), var_30, var_31, var_32 );
        wait(var_33);
        soundscripts\_snd::snd_message( "reactor_bot_initial_elevator_stop", var_3 );
        soundscripts\_snd::snd_message( "reactor_bot_elevator_stop_lp", var_3 );
        reactor_room_robots_lift_adjust_bars( var_3, "raise", "initial" );
        self unlink();
        var_65 = common_scripts\utility::getstruct( var_63.target, "targetname" );
        var_66 = vectortoangles( var_65.origin - self.origin );

        if ( abs( var_66[1] - var_57[1] ) > 2 )
        {
            wait 0.1;
            self rotateto( var_66, var_7 );
            soundscripts\_snd::snd_message( "reactor_bot_turn_self", self );
            wait(var_7 + 0.1);
            var_57 = var_66;
            wait 0.1;
        }

        var_67 = 0;

        while ( isdefined( var_63.target ) )
        {
            var_63 = common_scripts\utility::getstruct( var_63.target, "targetname" );
            var_66 = vectortoangles( var_63.origin - self.origin );

            if ( abs( var_66[1] - var_57[1] ) > 2 )
            {
                var_6 unlink();
                wait 0.1;
                self rotateto( var_66, var_7 );
                soundscripts\_snd::snd_message( "reactor_bot_turn_shelf", self );
                wait(var_7 + 0.1);
                var_57 = var_66;
                var_6 linkto( self );
                wait 0.1;
            }

            while ( distance( self.origin, var_63.origin ) > var_27 + 4 )
            {
                wait_until_path_safe();
                soundscripts\_snd::snd_message( "reactor_bot_drive_shelf_start", self );
                self moveto( vectornormalize( var_63.origin - self.origin ) * 32 + self.origin, var_26 );
                var_67++;
                wait(var_26);
                soundscripts\_snd::snd_message( "reactor_bot_drive_shelf_stop", self );

                if ( var_67 == 2 )
                {
                    soundscripts\_snd::snd_message( "reactor_bot_initial_elevator_start", var_3, var_36 );
                    var_3 common_scripts\utility::delaycall( var_36, ::moveto, var_3.origin + ( 0, 0, var_64 ), var_33, var_34, var_35 );
                    var_2 moveto( var_2.origin + ( 0, 0, var_29 ), var_30, var_31, var_32 );
                }
            }

            wait_until_path_safe();
            soundscripts\_snd::snd_message( "reactor_bot_drive_shelf_start", self );
            var_68 = var_26 * distance( self.origin, var_63.origin ) / var_27;
            self moveto( var_63.origin, var_68 );
            wait(var_68);
            soundscripts\_snd::snd_message( "reactor_bot_drive_shelf_stop", self );
        }

        reactor_room_robots_lift_adjust_bars( var_4, "lower", "final" );
        self linkto( var_4 );
        soundscripts\_snd::snd_message( "reactor_bot_final_elevator_start", var_4 );
        var_4 moveto( var_4.origin - ( 0, 0, var_43 ), var_44, var_45, var_46 );
        var_5 common_scripts\utility::delaycall( 2, ::moveto, var_41, var_38, var_39, var_40 );
        wait(var_44);
        self unlink();
        var_69 = self setcontents( 0 );
        var_59 notify( "robot_lowered" );

        foreach ( var_71 in var_6.models )
            var_71 delete();

        self hide();
        wait 0.5;
        self.origin = var_1.origin;
        wait 0.5;
        self setcontents( var_69 );
        self show();
        reactor_room_robots_lift_adjust_bars( var_4, "raise", "final" );
        soundscripts\_snd::snd_message( "reactor_bot_elevator_start_lp", var_4 );
        var_4 moveto( var_4.origin + ( 0, 0, var_43 ), var_44, var_45, var_46 );
        soundscripts\_snd::snd_message( "reactor_bot_final_elevator_stop", var_4, var_44 );
        soundscripts\_snd::snd_message( "reactor_bot_elevator_stop_lp", var_4, var_44 );
        var_5 moveto( var_42, var_38, var_39, var_40 );
        soundscripts\_snd::snd_message( "reactor_bot_elevator_open", var_5 );
    }
}

reactor_room_robots_lift_adjust_bars( var_0, var_1, var_2 )
{
    if ( var_2 == "initial" )
        var_3 = "start_bars";
    else
        var_3 = "end_bars";

    var_4 = undefined;
    var_5 = undefined;

    foreach ( var_7 in var_0.bars )
    {
        if ( var_7.script_noteworthy == var_3 )
            var_5 = var_7;
    }

    var_9 = 45;
    var_10 = 1;
    var_11 = 0.5;
    var_12 = 0.5;

    if ( var_1 == "raise" )
        var_9 *= -1;

    var_5 = getentarray( var_5.target, "targetname" );
    var_13 = undefined;
    var_14 = undefined;

    foreach ( var_16 in var_5 )
    {
        if ( var_16.script_noteworthy == "roll_down_bar_left" )
            var_13 = var_16;
        else
            var_14 = var_16;

        var_16 unlink();
    }

    var_14 rotateroll( var_9, var_10, var_11, var_12 );
    var_13 rotateroll( var_9, var_10, var_11, var_12 );
    wait(var_10);

    foreach ( var_16 in var_5 )
    {
        var_16 unlink();
        var_16 linkto( var_0 );
    }

    wait 0.05;
}

reactor_room_allies_run_from_crate()
{
    level waittill( "crate_raising" );
    var_0 = getent( "reveal_crate_color_trigger", "targetname" );

    if ( isdefined( var_0 ) )
        var_0 maps\_utility::activate_trigger();
}

reactor_room_redshirts()
{
    level endon( "turbine_elevator_reached_top" );

    for (;;)
    {
        common_scripts\utility::flag_wait( "reactor_redshirts_enable" );
        self.count++;
        var_0 = maps\_utility::spawn_ai();
        var_0 waittill( "death" );
        wait(randomfloatrange( 1, 5 ));
    }
}

reactor_room_redshirt_cleanup()
{
    level waittill( "turbine_elevator_reached_top" );
    waittillframeend;
    common_scripts\utility::array_call( getentarray( "reactor_redshirts", "script_noteworthy" ), ::delete );
}

reactor_room_combat()
{
    thread reactor_room_catwalk_combat();
    thread reactor_room_combat_seek_player();
    thread reactor_room_combat_mid_checkpoint();
    common_scripts\utility::flag_wait( "reactor_room_end_combat" );
    level.burke maps\_utility::disable_careful();
    level.joker maps\_utility::disable_careful();
    level.carter maps\_utility::disable_careful();
}

enemy_combat_equip_microwave_grenades()
{
    var_0 = getaiarray( "axis" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2.script_parameters ) && var_2.script_parameters == "microwave_equipped" )
            var_2 maps\_utility::add_spawn_function( ::reactor_room_microwave_grenade_equip );
    }
}

reactor_room_combat_mid_checkpoint()
{
    level endon( "elevator_ascend" );
    common_scripts\utility::flag_wait( "reactor_room_combat_mid_save_1" );
    maps\_utility::autosave_by_name();
}

reactor_room_combat_seek_player()
{
    common_scripts\utility::flag_wait( "flag_reactor_room_combat_seek_player" );
    level.burke maps\_utility::disable_careful();
    level.joker maps\_utility::disable_careful();
    level.carter maps\_utility::disable_careful();
    var_0 = getaiarray( "axis" );

    foreach ( var_2 in var_0 )
        var_2 thread maps\_utility::player_seek_enable();
}

reactor_room_microwave_grenade_equip()
{
    maps\fusion_utility::equip_microwave_grenade();
}

reactor_room_catwalk_death()
{
    level endon( "elevator_ascend" );
    common_scripts\utility::flag_wait( "reactor_room_catwalk_death" );
    var_0 = common_scripts\utility::getstruct( "reactor_room_catwalk_death", "targetname" );
    var_1 = getdvarint( "cg_fov" );

    if ( !level.player worldpointinreticle_circle( var_0.origin, var_1, 250 ) )
    {
        var_2 = var_0 common_scripts\utility::get_target_ent() maps\_utility::spawn_ai();
        var_2.deathfunction = undefined;
        var_2.animname = "generic";
        var_2 maps\_utility::set_deathanim( "reactor_room_catwalk_death" );
        var_2 kill();
    }
}

reactor_room_catwalk_combat()
{
    level endon( "elevator_ascend" );
    var_0 = getent( "reactor_room_below_catwalk", "targetname" );
    var_1 = common_scripts\utility::getstruct( "reactor_room_catwalk_struct", "targetname" );
    var_2 = getentarray( "reactor_catwalk_spawner_test", "script_noteworthy" );
    common_scripts\utility::array_thread( var_2, ::reactor_catwalk_spawner_trigger_think );

    for (;;)
    {
        level waittill( "reactor_catwalk_spawner_trigger_hit" );

        if ( level.player istouching( var_0 ) )
        {
            wait 0.1;
            var_3 = getaiarray( "axis" );

            foreach ( var_5 in var_3 )
            {
                if ( isalive( var_5 ) && var_5.origin[2] >= var_1.origin[2] && distance2dsquared( var_5.origin, var_1.origin ) < var_1.radius * var_1.radius )
                    var_5 thread maps\fusion_utility::bloody_death();
            }
        }
    }
}

reactor_catwalk_spawner_trigger_think()
{
    self waittill( "trigger" );
    level notify( "reactor_catwalk_spawner_trigger_hit" );
}

turbine_room()
{
    thread turbine_room_elevator();
    thread turbine_room_explosion();
    thread turbine_room_entrance_steam();
    thread turbine_room_turbines();
    thread turbine_room_atmosphere();
    thread turbine_room_combat();
    thread turbine_combat_mid_checkpoint_1();
    thread turbine_room_pre_explosion();
    thread pdrone_activate( "turbine_room_combat_start" );
    thread pdrone_deactivate_think();
    thread pdrone_deploy_hint();
}

turbine_room_elevator()
{
    var_0 = getent( "turbine_elevator_badplace", "targetname" );
    badplace_brush( "turbine_elevator_badplace", 0, var_0, "axis" );
    var_1 = getent( "elevator_ascend_use_trigger", "targetname" );

    if ( level.player usinggamepad() )
        var_1 sethintstring( &"FUSION_OPERATE_ELEVATOR" );
    else
        var_1 sethintstring( &"FUSION_OPERATE_ELEVATOR_PC" );

    var_2 = getent( "elevator_cover_col", "targetname" );
    var_3 = getent( "elevator_door_col", "targetname" );
    var_2 notsolid();
    var_3 notsolid();
    var_4 = getent( "deployable_cover_final_model", "targetname" );
    var_4.contents = var_4 setcontents( 0 );
    var_4 hide();
    common_scripts\utility::flag_wait( "turbine_elevator_enter" );

    if ( level.nextgen )
        common_scripts\utility::array_thread( getaiarray( "axis" ), maps\fusion_utility::bloody_death, 5 );
    else
        thread turbine_enemy_elevator_removal();

    var_5 = getent( "elevator_control", "targetname" );
    var_6 = getent( "elevator_button", "targetname" );
    var_7 = 6;
    var_8 = 4;
    var_9 = getent( "turbine_elevator_animnode", "targetname" );
    var_9 linkto( var_5 );
    var_4 linkto( var_5 );
    var_10 = "elevator_button_scene";
    level.player_rig = maps\_utility::spawn_anim_model( "player_arms" );
    level.player_rig hide();
    var_9 maps\_anim::anim_first_frame_solo( level.player_rig, var_10 );

    if ( !isdefined( level.turbine_room_elevator_ascent_time ) )
    {
        common_scripts\utility::flag_set( "vo_turbine_elevator_near" );
        var_11 = "stop_elevator_idle";
        level.burke thread turbine_room_elevator_think( var_9, var_11 );
        level.carter thread turbine_room_elevator_think( var_9, var_11 );
        var_12 = level.joker.goalradius;
        level.joker.goalradius = 16;
        var_13 = [ level.burke, level.carter, level.joker, level.player ];
        var_14 = getent( "inside_elevator_trigger", "targetname" );

        while ( !var_14 check_if_multiple_ents_inside( var_13 ) )
            wait 1;

        level.burke maps\_utility::disable_ai_color();
        level.joker maps\_utility::disable_ai_color();
        level.carter maps\_utility::disable_ai_color();
        common_scripts\utility::flag_set( "update_obj_pos_turbine_elevator_button" );
        common_scripts\utility::flag_set( "vo_turbine_elevator_ready" );
        var_15 = maps\_shg_utility::hint_button_position( "use", var_6.origin, 40, 512 );
        level.joker.goalradius = var_12;
        common_scripts\utility::flag_set( "elevator_ascend_ready" );
        common_scripts\utility::flag_wait( "elevator_ascend" );
        var_15 maps\_shg_utility::hint_button_clear();
        common_scripts\utility::flag_set( "update_obj_pos_turbine_elevator_ascent" );
        thread turbine_room_elevator_button_pressed_anim( var_10, var_9 );
        common_scripts\utility::array_thread( getaiarray( "axis" ), maps\_vehicle::force_kill );
        var_1 delete();
        level waittill( "flag_anim_elevator_button_pressed" );
        var_6 setmodel( "fus_elevator_button_02" );
        var_16 = getent( "joker_elevator_cover", "targetname" );
        level.joker forceteleport( var_16.origin, var_16.angles );
        level.joker thread turbine_room_elevator_think( var_9, var_11, var_4 );
        soundscripts\_snd::snd_message( "start_turbine_elevator" );
        level.turbine_room_elevator_ascent_time = 10;

        if ( level.currentgen )
            level.turbine_room_elevator_ascent_time = 15;

        var_17 = getent( "elevator_door_bottom_1", "script_noteworthy" );
        var_18 = getent( "elevator_door_bottom_2", "script_noteworthy" );
        var_19 = getent( "elevator_door_bottom_3", "script_noteworthy" );
        var_20 = getent( "elevator_door_bottom_4", "script_noteworthy" );
        var_17 moveto( var_17.origin + ( 0, 0, -51 ), var_7 / 2, var_7 / 6, var_7 / 6 );
        var_18 moveto( var_18.origin + ( 0, 0, -93 ), var_7 * 2 / 3, var_7 / 12, var_7 / 12 );
        var_19 moveto( var_19.origin + ( 0, 0, -140 ), var_7, var_7 / 18, var_7 / 18 );
        var_20 common_scripts\utility::delaycall( var_7 * 3 / 4, ::moveto, var_20.origin + ( 0, 0, 8 ), var_7 / 4, var_7 / 8, var_7 / 8 );
        var_21 = getentarray( "elevator_inner_door_upper", "targetname" );
        var_22 = getentarray( "elevator_inner_door_lower", "targetname" );

        foreach ( var_24 in var_21 )
            var_24 moveto( var_24.origin + ( 0, 0, -80 ), var_8, var_8 / 6, var_8 / 6 );

        foreach ( var_24 in var_22 )
            var_24 moveto( var_24.origin + ( 0, 0, 48 ), var_8, var_8 / 6, var_8 / 6 );

        maps\_utility::delaythread( 0.5, common_scripts\utility::flag_set, "vo_turbine_elevator" );
        maps\_utility::delaythread( 3, common_scripts\utility::flag_set, "joker_place_elevator_cover" );
        var_2 solid();
        var_2 linkto( var_5 );
        var_3 solid();
        wait(var_7);

        if ( level.currentgen )
        {
            level notify( "tff_pre_transition_middle_to_outro" );
            unloadtransient( "fusion_middle_tr" );
            loadtransient( "fusion_outro_tr" );
        }
    }
    else
    {
        var_2 solid();
        var_2 linkto( var_5 );
        var_3 solid();
        var_4 show();
        var_4 setcontents( var_4.contents );
        common_scripts\utility::flag_set( "update_obj_pos_turbine_elevator_button" );
    }

    level notify( "reactor_room_cleanup" );
    soundscripts\_snd::snd_message( "disable_turbine_elevator_trigger" );
    common_scripts\utility::array_call( getentarray( "reactor_room_enemies", "script_noteworthy" ), ::delete );
    var_28 = getentarray( "turbine_room_elevator", "script_noteworthy" );

    foreach ( var_24 in var_28 )
        var_24 linkto( var_5 );

    var_31 = getent( "elevator_destination", "targetname" );
    var_32 = getent( "elevator_door_top_1", "script_noteworthy" );
    var_33 = getent( "elevator_door_top_2", "script_noteworthy" );
    var_34 = getent( "elevator_door_top_3", "script_noteworthy" );
    var_35 = getent( "elevator_door_top_4", "script_noteworthy" );
    var_33 disconnectpaths();
    var_34 disconnectpaths();

    if ( level.turbine_room_elevator_ascent_time )
    {
        common_scripts\utility::flag_wait( "joker_placing_turbine_elevator_cover" );
        var_36 = maps\_utility::get_rumble_ent();
        var_36.intensity = 0.1;
        common_scripts\utility::noself_delaycall( level.turbine_room_elevator_ascent_time, ::stopallrumbles );
        var_5 moveto( var_31.origin, level.turbine_room_elevator_ascent_time, 2, 2 );
        wait(level.turbine_room_elevator_ascent_time);

        if ( level.currentgen )
        {
            while ( !istransientloaded( "fusion_outro_tr" ) )
                wait 0.1;

            level notify( "tff_post_transition_middle_to_outro" );
        }
    }
    else
    {
        var_37 = var_31.origin - var_5.origin;
        var_5.origin += var_37;
        var_2.origin += var_37;
        var_9.origin += var_37;
        var_10 = "turbine_elevator_exit";
        var_38 = "turbine_elevator_idle";
        var_11 = "stop_elevator_idle";
        var_9 thread maps\_anim::anim_single_solo_run( level.burke, var_10 );
        var_9 thread maps\_anim::anim_single_solo_run( level.carter, var_10 );
        var_9 thread maps\_anim::anim_loop_solo( level.joker, var_38, var_11 );
        var_9 thread maps\_utility::notify_delay( var_11, 5.5 );
        var_9 maps\_utility::delaythread( 5.5, maps\_anim::anim_single_solo_run, level.joker, var_10 );
    }

    var_2 disconnectpaths();
    var_39 = getentarray( "elevator_inner_exit_door_upper", "targetname" );
    var_40 = getentarray( "elevator_inner_exit_door_lower", "targetname" );

    if ( isdefined( var_32 ) )
    {
        var_32 moveto( var_32.origin + ( 0, 0, 51 ), var_7 / 2, var_7 / 6, var_7 / 6 );
        var_33 moveto( var_33.origin + ( 0, 0, 93 ), var_7 * 2 / 3, var_7 / 12, var_7 / 12 );
        var_34 moveto( var_34.origin + ( 0, 0, 140 ), var_7, var_7 / 18, var_7 / 18 );
        var_35 common_scripts\utility::delaycall( var_7 * 3 / 4, ::moveto, var_35.origin + ( 0, 0, -8 ), var_7 / 4, var_7 / 8, var_7 / 8 );
        var_21 = getentarray( "elevator_inner_door_upper", "targetname" );
        var_22 = getentarray( "elevator_inner_door_lower", "targetname" );

        foreach ( var_24 in var_21 )
            var_24 moveto( var_24.origin + ( 0, 0, -80 ), var_8, var_8 / 6, var_8 / 6 );

        foreach ( var_24 in var_22 )
            var_24 moveto( var_24.origin + ( 0, 0, 48 ), var_8, var_8 / 6, var_8 / 6 );
    }

    foreach ( var_24 in var_39 )
    {
        var_24 unlink();
        var_24 moveto( var_24.origin + ( 0, 0, 80 ), var_8, var_8 / 6, var_8 / 6 );
    }

    foreach ( var_24 in var_40 )
    {
        var_24 unlink();
        var_24 moveto( var_24.origin + ( 0, 0, -48 ), var_8, var_8 / 6, var_8 / 6 );
    }

    common_scripts\_exploder::exploder( 3501 );
    common_scripts\_exploder::exploder( 3502 );
    level notify( "turbine_elevator_reached_top" );

    if ( level.currentgen )
    {
        var_49 = [ "turbine_room_enemy" ];
        thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor( "turbine_room_stop_combat", var_49, 15, 0 );
        common_scripts\utility::flag_set( "portal_on_turbine_room_flag" );
    }

    soundscripts\_snd::snd_message( "stop_turbine_elevator" );
    common_scripts\utility::flag_set( "control_room_run_prep" );
    soundscripts\_snd::snd_message( "start_turbine_loop" );
    common_scripts\utility::flag_set( "update_obj_pos_turbine_room_1" );
    common_scripts\utility::flag_set( "turbine_room_combat_start" );
    maps\_utility::delaythread( 10, common_scripts\utility::flag_set, "vo_turbine_room_entrance" );
    maps\_utility::autosave_by_name( "turbine_elevator_complete" );
    wait 1;
    var_33 connectpaths();
    var_34 connectpaths();
}

turbine_enemy_elevator_removal()
{
    var_0 = getaiarray( "axis" );

    foreach ( var_2 in var_0 )
        var_2 thread maps\_utility::player_seek_enable();

    thread maps\_utility::ai_delete_when_out_of_sight( var_0, 500 );
}

check_if_multiple_ents_inside( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        if ( !var_2 istouching( self ) )
            return 0;
    }

    return 1;
}

turbine_room_elevator_button_pressed_anim( var_0, var_1 )
{
    level.player maps\_shg_utility::setup_player_for_scene();
    thread maps\_player_exo::player_exo_deactivate();
    var_2 = 0.4;
    level.player playerlinktoblend( level.player_rig, "tag_player", var_2 );
    level.player common_scripts\utility::delaycall( var_2, ::playerlinktodelta, level.player_rig, "tag_player", 1, 7, 7, 5, 5, 1 );
    level.player take_car_door_shields();
    wait(var_2);
    level.player_rig show();
    level.player soundscripts\_snd::snd_message( "turbine_room_elevator_button" );
    var_1 maps\_anim::anim_single_solo( level.player_rig, var_0 );
    level.player_rig delete();
    level.player unlink();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    thread maps\_player_exo::player_exo_activate();
}

turbine_room_elevator_think( var_0, var_1, var_2 )
{
    var_3 = "turbine_elevator_enter";
    var_4 = "turbine_elevator_idle";
    var_5 = "turbine_elevator_exit";

    if ( self == level.joker )
        common_scripts\utility::flag_wait( "joker_place_elevator_cover" );

    if ( self == level.burke )
        wait 2;

    var_0 maps\_anim::anim_reach_solo( self, var_3 );

    if ( self == level.joker )
    {
        common_scripts\utility::flag_set( "joker_placing_turbine_elevator_cover" );
        var_6 = spawn( "script_model", ( 0, 0, 0 ) );
        var_6.animname = "deployable_cover";
        var_6 setmodel( "deployable_cover" );
        var_6 maps\_anim::setanimtree();
        var_6 linkto( var_0 );
        var_0 thread maps\_anim::anim_single_solo( var_6, "deployable_cover_deploy" );
        maps\_utility::delaythread( 2.1, common_scripts\_exploder::exploder, "fx_cover_deploy_impact" );
        maps\_utility::delaythread( 5.0, common_scripts\_exploder::exploder, "fx_cover_deploy_impact_delay" );
        var_7 = 5.4;
        var_2 common_scripts\utility::delaycall( var_7, ::setcontents, var_2.contents );
        var_2 common_scripts\utility::delaycall( var_7, ::show );
        var_6 common_scripts\utility::delaycall( var_7, ::delete );
    }

    self linkto( var_0 );
    var_0 maps\_anim::anim_single_solo( self, var_3 );
    var_0 thread maps\_anim::anim_loop_solo( self, var_4, var_1 );

    if ( self == level.joker )
    {
        if ( level.currentgen )
            level waittill( "tff_post_transition_middle_to_outro" );
        else
            wait 5.5;
    }
    else if ( level.currentgen )
        level waittill( "tff_post_transition_middle_to_outro" );
    else
        level waittill( "turbine_elevator_reached_top" );

    self unlink();
    var_0 notify( var_1 );
    var_0 thread maps\_anim::anim_single_solo_run( self, var_5 );
    maps\_utility::disable_surprise();
    maps\_utility::disable_bulletwhizbyreaction();
    wait 10;
    maps\_utility::enable_surprise();
    maps\_utility::enable_bulletwhizbyreaction();
}

turbine_room_combat()
{
    common_scripts\utility::flag_wait( "player_in_turbine_room" );
    level.burke maps\_utility::enable_careful();
    level.joker maps\_utility::enable_careful();
    level.carter maps\_utility::enable_careful();
    level.turbine_room_goal_volume = getent( "turbine_room_initial_goal", "script_noteworthy" );
    common_scripts\utility::array_thread( getentarray( "turbine_room_goal_volume_trigger", "targetname" ), ::turbine_room_goal_volume_trigger_think );
    common_scripts\utility::flag_wait( "turbine_room_combat_start" );
    level.burke maps\_utility::enable_ai_color();
    level.joker maps\_utility::enable_ai_color();
    level.carter maps\_utility::enable_ai_color();
    thread turbine_room_combat_initial();
    thread turbine_room_combat_seek_player();
    common_scripts\utility::flag_wait( "turbine_room_stop_combat" );

    foreach ( var_1 in getaiarray( "axis" ) )
        var_1 thread maps\fusion_utility::bloody_death( randomfloatrange( 0, 3 ) );
}

turbine_combat_mid_checkpoint_1()
{
    level endon( "turbine_room_stop_combat" );
    common_scripts\utility::flag_wait( "flag_turbine_combat_mid_save_1" );
    maps\_utility::autosave_by_name();
}

turbine_room_combat_initial()
{
    thread turbine_room_squibs();
    var_0 = getaiarray( "axis" );

    foreach ( var_2 in var_0 )
    {
        if ( randomfloat( 1 ) < 0.25 )
            var_2.favoriteenemy = level.player;
    }

    wait 5;
    common_scripts\utility::flag_set( "turbine_room_initial_combat_retreat" );
}

turbine_room_combat_seek_player()
{
    common_scripts\utility::flag_wait( "flag_turbine_room_combat_seek_player" );
    level.burke maps\_utility::disable_careful();
    level.joker maps\_utility::disable_careful();
    level.carter maps\_utility::disable_careful();
    var_0 = getaiarray( "axis" );

    foreach ( var_2 in var_0 )
        var_2 thread maps\_utility::player_seek_enable();
}

turbine_room_squibs()
{
    level endon( "turbine_room_initial_combat_retreat" );
    var_0 = common_scripts\utility::getstructarray( "turbine_room_squib_source", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "turbine_room_squib_dest", "targetname" );
    wait 1;

    for (;;)
    {
        var_2 = randomintrange( 1, var_0.size );

        for ( var_3 = 0; var_3 < var_2; var_3++ )
        {
            var_4 = var_0[randomint( var_0.size )];
            var_5 = var_1[randomint( var_1.size )];
            magicbullet( "iw5_ak12_sp", var_4.origin, var_5.origin );
            wait(randomfloat( 0.2 ));
        }

        wait(randomfloat( 0.2 ));
    }
}

turbine_room_goal_volume_trigger_think()
{
    var_0 = common_scripts\utility::get_target_ent();
    level endon( "turbine_room_stop_combat" );

    for (;;)
    {
        self waittill( "trigger" );

        if ( var_0 != level.turbine_room_goal_volume )
        {
            level.turbine_room_goal_volume = var_0;
            level notify( "turbine_room_update_goal" );
        }

        wait 0.5;
    }
}

turbine_room_enemy_think()
{
    self endon( "death" );

    while ( !isdefined( level.turbine_room_goal_volume ) )
        wait 1;

    for (;;)
    {
        level waittill( "turbine_room_update_goal" );
        self setgoalvolumeauto( level.turbine_room_goal_volume );
        wait 1;
    }
}

turbine_room_turbines()
{
    common_scripts\utility::flag_wait( "elevator_ascend" );
    common_scripts\utility::array_thread( getentarray( "turbine_fan", "targetname" ), ::turbine_fan_think );
}

turbine_fan_think()
{
    var_0 = 10;
    var_1 = 360;

    if ( isdefined( self.script_parameters ) )
    {
        if ( self.script_parameters == "ccw" )
            var_1 = -1 * var_1;
    }

    for (;;)
    {
        self rotateroll( var_1 * var_0, var_0, 0, 0 );
        wait(var_0);
    }
}

turbine_room_entrance_steam()
{
    common_scripts\utility::flag_wait( "turbine_room_entrance_steam" );
    common_scripts\_exploder::exploder( "turbine_looping_steam_fx" );
}

turbine_room_pre_explosion()
{
    common_scripts\utility::flag_wait( "turbine_room_pre_explosion" );
    maps\_utility::pauseexploder( "turbine_looping_steam_fx" );
    wait 2.2;
    common_scripts\_exploder::exploder( "turbine_room_spark_steam" );
    soundscripts\_snd::snd_message( "turbine_pre_explo" );
    wait 0.4;
    common_scripts\_exploder::exploder( "turbine_room_spark_steam_2" );
    common_scripts\_exploder::exploder( "turbine_looping_steam_fx_2" );
    common_scripts\_exploder::exploder( "turbine_looping_steam_fx" );
}

turbine_room_explosion()
{
    var_0 = getent( "turbine_explosion_volume", "targetname" );
    badplace_brush( "turbine_explosion_volume", 0, var_0, "allies" );
    var_1 = getentarray( "turbine_damaged", "targetname" );
    common_scripts\utility::array_call( var_1, ::hide );
    var_2 = getentarray( "turbine_fan_damaged", "targetname" );
    common_scripts\utility::array_call( var_2, ::hide );
    common_scripts\utility::flag_wait( "turbine_room_explosion" );
    soundscripts\_snd::snd_message( "turbine_explo_audio" );
    wait 0.2;
    var_3 = common_scripts\utility::getstructarray( "turbine_explosion_damage_source", "targetname" );

    foreach ( var_5 in var_3 )
        radiusdamage( var_5.origin, var_5.radius, 200, 100 );

    maps\_utility::pauseexploder( "turbine_looping_steam_fx" );
    maps\_utility::pauseexploder( "turbine_looping_steam_fx_2" );
    common_scripts\_exploder::exploder( "turbine_explosion_fx" );
    var_7 = getent( "turbine_explosion_catwalk_source", "targetname" );
    var_7 playsound( "detpack_explo_metal" );
    earthquake( 0.5, 0.5, var_7.origin, 3000 );
    badplace_delete( "turbine_explosion_volume" );
    badplace_brush( "turbine_explosion_volume", 0, var_0, "axis", "allies" );
    var_8 = getentarray( "turbine_intact", "targetname" );
    common_scripts\utility::array_call( var_8, ::delete );
    common_scripts\utility::array_call( var_1, ::show );
    common_scripts\utility::array_call( var_2, ::show );
    common_scripts\utility::array_thread( var_2, ::turbine_fan_think );
    wait 1.5;
    common_scripts\_exploder::exploder( "turbine_explosion_steam_fx" );
    common_scripts\_exploder::exploder( "turbine_damage_sparks" );
    common_scripts\utility::flag_set( "vo_turbine_explosion" );
    soundscripts\_snd::snd_message( "start_pa_emergency_turbine" );

    if ( level.currentgen )
    {
        level waittill( "notify_out_of_control_room" );
        maps\_utility::stop_exploder( "turbine_explosion_fx" );
    }
}

turbine_room_explosion_flying_blades()
{
    var_0 = common_scripts\utility::getstructarray( "turbine_blade_flying_start", "targetname" );

    foreach ( var_2 in var_0 )
        thread turbine_room_explosion_launch_blade( var_2 );
}

turbine_room_explosion_launch_blade( var_0 )
{
    if ( isdefined( var_0.script_delay ) )
        wait(var_0.script_delay);

    var_1 = common_scripts\utility::getstruct( var_0.target, "targetname" );
    var_2 = distance( var_0.origin, var_1.origin );
    var_3 = 3000;
    var_4 = var_2 / var_3;
    var_5 = spawn( "script_model", var_0.origin );
    var_5 setmodel( "vehicle_v22_osprey_damaged_static_bladepiece_left" );
    var_5.angles = var_0.angles;
    var_5 moveto( var_1.origin, var_4, 0, 0 );
    var_5 rotatepitch( 1080, var_4, 0, 0 );
    wait(var_4);
    var_5.angles = var_1.angles;
    var_5 thread maps\fusion_utility::delete_on_notify( "turbine_room_cleanup" );
}

turbine_room_atmosphere()
{
    level endon( "flag_shut_down_reactor_failed" );
    level.player endon( "death" );
    var_0 = common_scripts\utility::getstructarray( "turbine_center", "script_noteworthy" );
    var_1 = 0.07;
    var_2 = 0.12;
    var_3 = var_2 - var_1;
    var_4 = 0.08;
    var_5 = 0.12;
    var_6 = var_5 - var_4;

    for (;;)
    {
        common_scripts\utility::flag_wait( "player_in_turbine_room" );
        var_7 = maps\_utility::get_rumble_ent( "steady_rumble" );
        var_7.intensity = 0.08;
        var_8 = 1;

        while ( common_scripts\utility::flag( "player_in_turbine_room" ) )
        {
            var_9 = common_scripts\utility::getclosest( level.player.origin, var_0 );
            var_10 = get_turbine_shake_value( var_9 );
            var_7.intensity = var_1 + var_10 * var_3;
            earthquake( var_4 + var_10 * var_6, var_8, level.player.origin, 1000 );
            wait(randomfloatrange( var_8 / 4, var_8 / 2 ));
        }

        stopallrumbles();
    }
}

get_turbine_shake_value( var_0 )
{
    var_1 = 300;
    var_2 = 600;
    var_3 = var_2 - var_1;
    var_4 = distance( level.player.origin, var_0.origin );

    if ( var_4 < var_1 )
        return 1;

    if ( var_4 > var_2 )
        return 0;

    return 1 - ( var_4 - var_1 ) / var_3;
}

turbine_room_steam_player()
{
    level endon( "flag_shut_down_reactor_failed" );

    while ( common_scripts\utility::flag( "player_in_turbine_room" ) )
    {
        playfx( common_scripts\utility::getfx( "steam_player" ), level.player.origin + ( 0, 0, 0 ) );
        wait 0.3;
    }
}

control_room()
{
    thread control_room_run();
    thread control_room_explosion();
}

control_room_run()
{
    common_scripts\utility::flag_wait( "control_room_run_prep" );
    var_0 = getent( "clip_explosion_door", "targetname" );
    var_0 hide();
    var_1 = common_scripts\utility::getstruct( "control_room_burke_position", "targetname" );
    var_2 = "fusion_door_explosion";
    var_3 = getent( "fusion_door_open_postup_doors", "targetname" );
    var_3.animname = "fusion_door_open_postup_doors";
    var_3 maps\_anim::setanimtree();
    var_1 maps\_anim::anim_first_frame_solo( var_3, var_2 );
    var_4 = getent( "fusion_door_open_postup_door_left", "targetname" );
    var_4 linkto( var_3, "door_R" );
    var_5 = getent( "fusion_door_open_postup_door_right", "targetname" );
    var_5 linkto( var_3, "door_L" );
    common_scripts\utility::flag_wait( "control_room_run_approach" );
    var_6 = getaiarray( "axis" );
    var_6 = maps\_utility::array_removedead_or_dying( var_6 );

    while ( var_6.size >= 4 )
    {
        var_6 = getaiarray( "axis" );
        var_6 = maps\_utility::array_removedead_or_dying( var_6 );
        waitframe();
    }

    var_6 = getaiarray( "axis" );
    var_6 = maps\_utility::array_removedead_or_dying( var_6 );

    foreach ( var_8 in var_6 )
        maps\fusion_utility::bloody_death( randomfloatrange( 1, 2 ) );

    level.burke maps\_utility::disable_careful();
    level.joker maps\_utility::disable_careful();
    level.carter maps\_utility::disable_careful();
    waitframe();
    var_10 = [];
    var_10[var_10.size] = level.burke;
    var_10[var_10.size] = level.carter;
    var_11 = "fusion_door_explosion_postup";
    var_12 = "fusion_door_explosion_postup_loop";
    var_13 = spawn( "script_origin", var_1.origin );
    var_13.angles = var_1.angles;
    var_14 = "control_room_run";
    level.burke thread start_cqb_when_near( getstartorigin( var_13.origin, var_13.angles, level.scr_anim["burke"][var_11] ) );
    level.carter thread start_cqb_when_near( getstartorigin( var_13.origin, var_13.angles, level.scr_anim["carter"][var_11] ) );
    var_10 = [];
    var_10[var_10.size] = level.burke;
    var_10[var_10.size] = level.carter;
    common_scripts\utility::array_thread( var_10, ::control_room_run_approach, var_13, var_11, var_12, var_14 );
    level waittill( "control_room_run_guy_ready" );
    level waittill( "control_room_run_guy_ready" );
    common_scripts\utility::flag_wait( "control_room_run" );
    thread control_room_run_player();
    thread control_room_screens();
    level.burke maps\_utility::disable_cqbwalk();
    level.carter maps\_utility::disable_cqbwalk();
    var_13 notify( "control_room_run" );
    thread control_room_run_joker();
    maps\_utility::delaythread( 2.5, common_scripts\utility::flag_set, "update_obj_pos_control_room_door" );
    var_10[var_10.size] = var_3;
    common_scripts\utility::array_call( getentarray( "control_room_doors", "targetname" ), ::delete );
    var_15 = maps\_utility::spawn_anim_model( "fusion_door_explosion_door_a", ( 0, 0, 0 ) );
    var_16 = [];
    var_16[var_16.size] = var_15;
    soundscripts\_snd::snd_message( "start_turbine_door_breach" );
    soundscripts\_snd::snd_message( "start_turbine_door_impt", var_4, var_5 );
    thread control_room_scene_player( var_1 );
    maps\_utility::delaythread( 5, common_scripts\utility::flag_set, "vo_control_hall_door_stack" );
    maps\_utility::delaythread( 6, common_scripts\utility::flag_set, "vo_control_hall_door_kicked" );
    var_10[var_10.size] = var_15;
    var_17 = getanimlength( level.burke maps\_utility::getanim( var_2 ) );
    var_1 thread maps\_anim::anim_single( var_10, var_2 );
    var_18 = 24;
    maps\_utility::delaythread( var_18, ::control_room_scene, var_17 - var_18 );
    wait(var_17);
    var_0 show();
    var_13 delete();
}

control_room_run_approach( var_0, var_1, var_2, var_3 )
{
    var_0 maps\_anim::anim_reach_solo( self, var_1 );
    var_0 maps\_anim::anim_single_solo( self, var_1 );
    var_0 thread maps\_anim::anim_loop_solo( self, var_2, var_3 );
    level notify( "control_room_run_guy_ready" );
}

control_room_run_player()
{
    var_0 = common_scripts\utility::getstruct( "control_room_door_explosion_dmg_org", "targetname" );
    var_1 = var_0.radius;
    common_scripts\utility::flag_wait( "control_room_explosion" );
    playrumbleonposition( "grenade_rumble", var_0.origin );
    var_2 = getent( "control_room_door_clip", "targetname" );

    if ( isdefined( var_2 ) )
        var_2 delete();

    var_3 = distance2d( var_0.origin, level.player.origin );

    if ( var_3 < var_1 )
    {
        var_4 = level.player.health * 0.9 / level.player.damagemultiplier;
        var_5 = ( var_1 - var_3 ) / var_1 * var_4;
        level.player dodamage( var_5, var_0.origin );
        var_6 = common_scripts\utility::getstructarray( "control_room_door_explosion_dmg_dest", "targetname" );
        var_7 = [];

        foreach ( var_9 in var_6 )
            var_7[var_7.size] = length( vectorfromlinetopoint( var_0.origin, var_9.origin, level.player.origin ) );

        var_11 = 0;
        var_12 = 1000;

        for ( var_13 = 0; var_13 < var_7.size; var_13++ )
        {
            if ( var_7[var_13] < var_12 )
            {
                var_11 = var_13;
                var_12 = var_7[var_13];
            }
        }

        var_14 = var_6[var_11];
        var_15 = common_scripts\utility::spawn_tag_origin();
        var_15.origin = level.player.origin;
        var_15.angles = level.player.angles;
        var_16 = 0.5;
        level.player playerlinktoblend( var_15, "tag_origin", var_16 );
        var_15 moveto( var_14.origin, var_16, 0.05, 0.05 );
        var_17 = common_scripts\utility::getstruct( "control_room_door_explosion_view_org", "targetname" );
        var_15 rotateto( ( 0, vectortoangles( var_17.origin - var_14.origin )[1], 0 ), var_16, 0.05, 0.05 );
        level.player playrumbleonentity( "damage_heavy" );
        wait(var_16);
        level.player unlink();
        var_15 delete();
    }
    else
        level.player playrumbleonentity( "damage_light" );
}

control_room_run_joker()
{
    wait 6;
    getent( "fusion_door_open_postup_door_left", "targetname" ) connectpaths();
    getent( "fusion_door_open_postup_door_right", "targetname" ) connectpaths();
    wait 1;
    var_0 = getnode( "pre_control_room_joker_position", "targetname" );
    var_1 = level.joker.goalradius;
    level.joker.goalradius = 64;
    level.joker maps\_utility::enable_cqbwalk();
    level.joker setgoalnode( var_0 );
    level.joker waittill( "goal" );
    level.joker allowedstances( "crouch" );
    maps\_utility::trigger_wait_targetname( "cover_allies_complete" );
    wait 1;
    var_2 = common_scripts\utility::getstruct( "control_room_joker_position", "targetname" );
    var_1 = level.joker.goalradius;
    level.joker.goalradius = 64;
    level.joker maps\_utility::enable_cqbwalk();
    level.joker setgoalpos( var_2.origin );
    level.joker waittill( "goal" );
    level.joker allowedstances( "crouch" );
    level waittill( "control_room_scene_complete" );
    level.joker allowedstances( "prone", "crouch", "stand" );
    level.joker maps\_utility::disable_cqbwalk();
    level.joker.goalradius = var_1;
}

control_room_explosion()
{
    var_0 = getentarray( "control_room_hall_intact", "targetname" );
    var_1 = getentarray( "control_room_hall_destroyed", "targetname" );

    foreach ( var_3 in var_1 )
        var_3 hide();

    level waittill( "doors_explode" );

    foreach ( var_3 in var_1 )
        var_3 show();

    foreach ( var_3 in var_0 )
        var_3 delete();

    common_scripts\utility::flag_set( "control_room_explosion" );
    common_scripts\utility::flag_set( "update_obj_pos_control_room_explosion" );
    common_scripts\utility::flag_set( "vo_control_room_explosion" );
    level thread maps\fusion_fx::vfx_control_room_explo();
    soundscripts\_snd::snd_message( "start_control_room_explo" );
}

control_room_scene_player( var_0 )
{
    common_scripts\utility::flag_wait( "control_room_console_enable" );
    var_1 = getent( "control_room_console_use_trigger", "targetname" );
    var_2 = common_scripts\utility::getstruct( "obj_pos_control_room_console", "targetname" );

    if ( level.player usinggamepad() )
        var_1 sethintstring( &"FUSION_USE_CONSOLE" );
    else
        var_1 sethintstring( &"FUSION_USE_CONSOLE_PC" );

    var_3 = var_1 maps\_shg_utility::hint_button_trigger( "use" );
    common_scripts\utility::flag_wait( "control_room_console_used" );
    level.burke thread maps\fusion_utility::hide_friendname_until_flag_or_notify( "control_room_scene_complete" );
    level.joker thread maps\fusion_utility::hide_friendname_until_flag_or_notify( "control_room_scene_complete" );
    level.carter thread maps\fusion_utility::hide_friendname_until_flag_or_notify( "control_room_scene_complete" );
    var_1 delete();
    var_3 maps\fusion_utility::hint_button_clear_fus();
    common_scripts\utility::flag_set( "update_obj_pos_control_room_using_console" );
    var_4 = getdvarint( "cg_fov" );
    var_5 = maps\_utility::spawn_anim_model( "player_rig", level.player.origin );
    var_5 hide();
    var_0 thread maps\_anim::anim_first_frame_solo( var_5, "control_room_scene" );
    level.player disableweapons();
    maps\_player_exo::player_exo_deactivate();
    var_6 = 1;
    level.player playerlinktoblend( var_5, "tag_player", var_6 );
    thread maps\fusion_anim::fov_lerp_to_50_blendtime( level.player, var_6 );
    var_5 common_scripts\utility::delaycall( var_6, ::show );
    level.player common_scripts\utility::delaycall( var_6, ::playerlinktodelta, var_5, "tag_player", 0, 30, 30, 30, 30 );
    level.player allowcrouch( 0 );
    level.player allowprone( 0 );
    level.player disableweapons();
    level.player maps\_utility::blend_movespeedscale_percent( 0 );
    wait(var_6);
    common_scripts\utility::flag_wait( "control_room_scene_ready" );
    common_scripts\utility::flag_set( "control_room_scene" );
    level.player playerlinktodelta( var_5, "tag_player", 0, 60, 60, 70, 65 );
    var_0 thread maps\_anim::anim_single_solo( var_5, "control_room_scene" );
    var_7 = getanimlength( var_5 maps\_utility::getanim( "control_room_scene" ) );
    wait(var_7 - 1);
    level.player allowcrouch( 1 );
    level.player allowprone( 1 );
    level.player enableweapons();
    maps\_player_exo::player_exo_activate();
    wait 1;
    var_5 delete();
    level.player unlink();
    level.player maps\_utility::blend_movespeedscale_percent( 100, 1 );
    thread maps\fusion_anim::fov_reset_previous( level.player, var_4 );
}

control_room_scene( var_0 )
{
    common_scripts\utility::flag_set( "control_room_scene_ready" );
    thread control_room_scene_actors( var_0 );
    level waittill( "control_room_event_1" );
    thread maps\fusion_aud::do_inside_bombshake();
    level waittill( "control_room_event_2" );
    thread maps\fusion_aud::do_inside_bombshake();
    level waittill( "control_room_event_3" );
    thread maps\fusion_aud::do_inside_bombshake();
}

control_room_scene_actors( var_0 )
{
    var_1 = common_scripts\utility::getstruct( "control_room_burke_position", "targetname" );
    var_2 = spawn( "script_origin", var_1.origin );
    var_2.angles = var_1.angles;
    var_3 = spawn( "script_origin", var_1.origin );
    var_3.angles = var_1.angles;
    var_4 = spawn( "script_origin", var_1.origin );
    var_4.angles = var_1.angles;
    var_5 = "control_room_idle";
    var_6 = [];
    var_6[var_6.size] = level.burke;
    var_6[var_6.size] = level.carter;

    if ( isdefined( var_0 ) )
        common_scripts\utility::flag_wait_or_timeout( "control_room_scene", var_0 );

    var_2 thread maps\_anim::anim_loop_solo( level.burke, var_5, "control_room_scene" );
    var_4 thread maps\_anim::anim_loop_solo( level.carter, var_5, "control_room_scene" );
    var_5 = "control_room_scene";
    var_6[var_6.size] = level.joker;
    common_scripts\utility::flag_wait( "control_room_scene" );
    level notify( "turbine_room_cleanup" );
    var_2 notify( "control_room_scene" );
    var_4 notify( "control_room_scene" );
    var_4 delete();
    maps\_utility::clear_all_color_orders( "allies" );
    level.burke maps\_utility::enable_ai_color();
    level.joker maps\_utility::enable_ai_color();
    level.carter maps\_utility::enable_ai_color();
    level.joker maps\_utility::set_force_color( "o" );
    level.carter maps\_utility::set_force_color( "o" );
    maps\_utility::delaythread( 1, maps\_utility::activate_trigger_with_targetname, "control_room_scene_complete_color_trigger" );
    common_scripts\utility::flag_set( "vo_control_room_scene" );
    var_2 maps\_anim::anim_single_run( var_6, var_5 );
    var_2 delete();
    common_scripts\utility::flag_set( "flag_shut_down_reactor_failed" );
    common_scripts\utility::flag_set( "evacuation_started" );
    common_scripts\utility::flag_set( "update_obj_pos_control_room_exit_1" );
    control_room_scene_exit();
}

control_room_screens()
{
    level notify( "stop_evacuation_kiosk_movie" );
    setsaveddvar( "cg_cinematicFullScreen", "0" );
    cinematicingameloop( "fusion_control_room_loop" );
    common_scripts\utility::flag_wait( "control_room_scene" );
    wait 12;
    cinematicingameloop( "fusion_control_room_loop_red" );
    common_scripts\utility::flag_wait( "evacuation_started" );

    if ( level.nextgen )
        thread evacuation_kiosk_movie();
}

control_room_scene_exit()
{
    wait 0.45;
    var_0 = getent( "control_room_exit_door", "targetname" );
    getent( var_0.target, "targetname" ) linkto( var_0 );
    var_1 = 0.5;
    var_0 rotateto( var_0.angles - ( 0, 120, 0 ), var_1, 0, 0 );
    wait(var_1 + 0.05);
    var_0 rotateto( var_0.angles - ( 0, -10, 0 ), 1, 0, 1 );
    common_scripts\utility::flag_wait( "raise_control_room_emergency_exit_door" );
    common_scripts\utility::flag_set( "update_obj_pos_control_room_exit_2" );
}

scene_control_room_ai()
{
    maps\_utility::disable_surprise();
    maps\_utility::disable_bulletwhizbyreaction();
    maps\_utility::disable_pain();
    level waittill( "control_room_scene_complete" );
    maps\_utility::enable_surprise();
    maps\_utility::enable_bulletwhizbyreaction();
    maps\_utility::enable_pain();
}

scene_control_room_fade_up()
{
    if ( !isdefined( level.overlay ) )
    {
        level.overlay = maps\_hud_util::create_client_overlay( "black", 1, level.player );
        level.overlay.sort = -1;
        level.overlay.foreground = 1;
        level.overlay.color = ( 0, 0, 0 );
    }

    wait 1;
    var_0 = 1;
    level.overlay fadeovertime( var_0 );
    level.overlay.alpha = 0;
    wait(var_0);
    level.overlay destroy();
}

evacuation_setup()
{
    common_scripts\utility::flag_wait( "evacuation_started" );
    thread evacuation_corpses();
}

dialog_meltdown()
{
    thread dialog_collapse();
    level endon( "collapse_start" );
    common_scripts\utility::flag_wait( "hangar_enemies" );
    level.joker maps\fusion_vo::dialogue_queue_global( "fus_jkr_gideontangosarebailinout" );
    level.burke maps\fusion_vo::dialogue_queue_global( "fus_gdn_soarewekeepmoving" );
    common_scripts\utility::flag_wait( "hangar_combat_retreat" );
    level.carter maps\fusion_vo::dialogue_queue_global( "fus_ctr_jokerwhatsyourgeigerreading" );
    level.joker maps\fusion_vo::dialogue_queue_global( "fus_jkr_weregoodjustkeepshooting" );
    common_scripts\utility::flag_wait( "hangar_combat_retreat_02" );
    level.burke maps\fusion_vo::dialogue_queue_global( "fus_gdn_prophetwevegotkvaextraction" );
    maps\fusion_vo::radio_dialogue_queue_global( "fus_prt_affirmativebravoone" );
    common_scripts\utility::flag_wait( "hangar_exit_retreat" );
    level.burke maps\fusion_vo::dialogue_queue_global( "fus_gdn_wraithtwothreeweneedimmediate" );
    maps\fusion_vo::radio_dialogue_queue_global( "fus_ch1_copybravooneinboundinthirty" );
    maps\fusion_vo::radio_dialogue_queue_global( "fus_prt_bravopressurereadingsarecritical" );
    soundscripts\_snd::snd_music_message( "mus_fusion_pressure_readings_critical" );
    level.joker maps\fusion_vo::dialogue_queue_global( "fus_jkr_youheardtheman" );
    common_scripts\utility::flag_wait( "reaction_explo01a" );
    wait 0.75;
    level.joker maps\fusion_vo::dialogue_queue_global( "fus_jkr_goddamn2" );
    level.carter maps\fusion_vo::dialogue_queue_global( "fus_ctr_whatthehellwasthat" );
    level.burke maps\fusion_vo::dialogue_queue_global( "fus_gdn_pressureexplosions" );
    common_scripts\utility::flag_wait( "ct_combat_retreat" );
    wait 2;
    common_scripts\utility::flag_wait( "reaction_explo01" );
    wait 2;

    if ( level.nextgen )
    {
        maps\fusion_vo::radio_dialogue_queue_global( "fus_ch1_bravothisiswraithtwothree" );
        level.burke maps\fusion_vo::dialogue_queue_global( "fus_gdn_youreadamnwelcomesight" );
    }

    common_scripts\utility::flag_wait( "reaction_explo02" );
    wait 4;
    common_scripts\utility::flag_set( "extraction_chopper_move_from_explosion" );
    maps\fusion_vo::radio_dialogue_queue_global( "fus_ch1_bravowecantgetnear" );
    level.burke maps\fusion_vo::dialogue_queue_global( "fus_gdn_copythattwothree" );
    level.joker maps\fusion_vo::dialogue_queue_global( "fus_jkr_comeon" );
    level.carter maps\fusion_vo::dialogue_queue_global( "fus_ctr_gogo" );
    common_scripts\utility::flag_wait( "ct_final_retreat" );
    level.joker maps\fusion_vo::dialogue_queue_global( "fus_jkr_theresourexfil" );
}

dialog_monitor_drones_down()
{
    common_scripts\utility::flag_wait( "evacuation_first_drones_down" );

    if ( !common_scripts\utility::flag( "reaction_explo01" ) && !common_scripts\utility::flag( "collapse_start" ) )
        level.joker maps\fusion_vo::dialogue_queue_global( "fus_jkr_dronesaredown" );
}

dialog_collapse()
{
    common_scripts\utility::flag_wait( "tower_debris" );
}

outro_newscast()
{

}

combat_hangar()
{
    var_0 = getentarray( "hangar_enemies_01", "targetname" );
    var_1 = getentarray( "ct_enemies_01", "targetname" );
    var_2 = getentarray( "hangar_runaway", "targetname" );
    var_3 = getentarray( "hangar_runaway_02", "targetname" );
    common_scripts\utility::array_thread( var_0, maps\_utility::add_spawn_function, maps\_utility::disable_long_death );
    common_scripts\utility::array_thread( var_1, maps\_utility::add_spawn_function, maps\_utility::disable_long_death );
    common_scripts\utility::array_thread( var_2, maps\_utility::add_spawn_function, maps\_utility::disable_long_death );
    common_scripts\utility::array_thread( var_3, maps\_utility::add_spawn_function, maps\_utility::disable_long_death );
    level.hangar_enemies = [];
    common_scripts\utility::flag_wait( "hangar_combat_start" );

    if ( level.currentgen )
    {
        var_4 = [ "hanger_enemies" ];
        thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor( "collapse_start", var_4, 12, 0 );
    }

    var_5 = maps\_utility::array_spawn( var_2, 1, 1 );
    common_scripts\utility::array_thread( var_5, ::runaway_guy_delete );
    common_scripts\utility::flag_wait( "hangar_enemies" );
    level.carter.dontmelee = 1;
    level.joker.dontmelee = 1;
    maps\_spawner::flood_spawner_scripted( var_0 );
    common_scripts\utility::flag_wait( "hangar_combat_retreat" );
    level.carter.dontmelee = undefined;
    level.joker.dontmelee = undefined;
    common_scripts\utility::flag_set( "hangar_retreat_done" );
    common_scripts\utility::array_thread( level.hangar_enemies, ::enemy_run_away, "vol_final_runaway", 1 );
    common_scripts\utility::flag_wait( "hangar_combat_retreat_02" );
    level.ct_enemies = maps\_utility::array_spawn( var_1, 1, 1 );
    var_6 = maps\_utility::array_spawn( var_3, 1, 1 );
    common_scripts\utility::array_thread( level.ct_enemies, maps\_utility::flagwaitthread, "reaction_explo01a", ::enemy_run_away, "vol_ct_02", 0 );
    common_scripts\utility::flag_wait( "ct_combat_retreat" );
    common_scripts\utility::flag_wait( "reaction_explo01" );
    maps\_utility::autosave_by_name();

    if ( level.nextgen )
    {
        var_7 = getentarray( "ct_runaway_drones", "targetname" );
        common_scripts\utility::array_thread( var_7, ::runaway_drone_think );
    }

    var_8 = getentarray( "final_collapse_enemies", "targetname" );
    maps\_utility::flood_spawn( var_8 );
    common_scripts\utility::flag_wait( "ct_final_retreat" );
    common_scripts\utility::array_thread( var_8, maps\_spawner::flood_spawner_stop );
}

extraction_chopper()
{
    common_scripts\utility::flag_wait( "reaction_explo01" );

    if ( level.nextgen )
    {
        level.extraction_chopper = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "ct_extraction_chopper" );
        level.extraction_chopper soundscripts\_snd::snd_message( "extraction_chopper_spawn" );
        level.extraction_chopper thread warbird_shooting_think();
        level.extraction_chopper setmaxpitchroll( 20, 60 );
        level.extraction_chopper maps\_vehicle::vehicle_lights_on( "running" );
        level.extraction_chopper vehicle_turnengineoff();
    }

    wait 2;

    if ( level.nextgen )
        level.extraction_chopper notify( "warbird_fire" );

    wait 8;
    common_scripts\utility::flag_set( "objective_on_extraction_chopper" );

    if ( level.nextgen )
    {
        level.extraction_chopper setgoalyaw( 330 );
        level.extraction_chopper sethoverparams( 50, 50, 25 );
        common_scripts\utility::flag_wait( "extraction_chopper_move_from_explosion" );
        level.extraction_chopper notify( "warbird_stop_firing" );
        level.extraction_chopper soundscripts\_snd::snd_message( "extraction_chopper_move" );
        level.extraction_chopper cleargoalyaw();
        level.extraction_chopper maps\_vehicle::vehicle_paths( common_scripts\utility::getstruct( "extraction_chopper_move_from_explosion", "targetname" ) );
    }
}

extraction_chopper_collapse()
{
    common_scripts\utility::flag_wait( "tower_debris" );
    wait 5;
    var_0 = common_scripts\utility::getstruct( "extraction_chopper_final_path", "targetname" );

    if ( !isdefined( level.extraction_chopper ) )
    {
        level.extraction_chopper = maps\_vehicle::spawn_vehicle_from_targetname( "ct_extraction_chopper" );
        level.extraction_chopper vehicle_turnengineoff();
    }

    level.extraction_chopper vehicle_setspeedimmediate( 0 );
    level.extraction_chopper vehicle_teleport( var_0.origin, var_0.angles );
    level.extraction_chopper maps\_vehicle::vehicle_paths( var_0 );
}

enemy_run_away( var_0, var_1 )
{
    if ( !isdefined( self ) )
        return;

    if ( distance( self.origin, level.player.origin ) <= 600 )
        return;

    self notify( "enemy_run_away" );
    self endon( "enemy_run_away" );
    self endon( "death" );
    self.ignoreall = 1;
    var_2 = getent( var_0, "targetname" );
    self cleargoalvolume();
    self setgoalvolumeauto( var_2 );

    if ( isdefined( var_1 ) && var_1 )
        thread enemy_delete_at_goal();

    var_3 = 10000;

    for (;;)
    {
        common_scripts\utility::waittill_any( "damage", "bad_path" );
        level notify( "ct_enemies_runaway_damage" );
    }
}

enemy_delete_at_goal()
{
    self notify( "enemy_delete_at_goal" );
    self endon( "enemy_delete_at_goal" );
    self endon( "death" );
    self waittill( "goal" );

    if ( isdefined( self ) && isalive( self ) )
        self delete();
}

hangar_enemy_think()
{
    level.hangar_enemies[level.hangar_enemies.size] = self;
    self cleargoalvolume();

    if ( !common_scripts\utility::flag( "hangar_retreat_done" ) )
        self setgoalvolumeauto( getent( "vol_enemy_hangar", "targetname" ) );
    else
        self setgoalvolumeauto( getent( "vol_ct_01", "targetname" ) );
}

runaway_guy_delete()
{
    self endon( "death" );
    self waittill( "goal" );

    if ( isdefined( self ) && isalive( self ) )
        self delete();
}

runaway_drone_think()
{
    var_0 = maps\_utility::spawn_ai( 1 );
    var_0 thread runaway_guy_delete();
    var_0 endon( "death" );
    common_scripts\utility::flag_wait( "collapse_start" );
    var_0 kill();
}

add_drone_to_squad()
{
    if ( isdefined( self.script_parameters ) && self.script_parameters == "personal_drone" )
    {
        var_0 = getent( "squad_drone_spawner", "targetname" );
        maps\_weapon_pdrone::pdrone_launch( var_0 );

        if ( isdefined( self.pdrone ) )
        {
            self.pdrone setthreatbiasgroup( "drones" );
            self.pdrone thread cleanup_squad_drone();
        }
    }
}

cleanup_squad_drone()
{
    if ( level.nextgen )
        level waittill( "street_cleanup" );
    else
        level waittill( "tff_pre_transition_intro_to_middle" );

    self delete();
}

reaction_explosions()
{
    if ( level.currentgen )
        common_scripts\utility::flag_wait( "hangar_enemies" );

    var_0 = getentarray( "pressure_explosion_1_before", "targetname" );
    var_1 = getentarray( "pressure_explosion_1_after", "targetname" );
    var_2 = getentarray( "pressure_explosion_2_before", "targetname" );
    var_3 = getentarray( "pressure_explosion_2_after", "targetname" );
    common_scripts\utility::array_call( var_1, ::hide );
    common_scripts\utility::array_call( var_1, ::notsolid );
    common_scripts\utility::array_call( var_3, ::hide );
    common_scripts\utility::array_call( var_3, ::notsolid );
    var_4 = getent( "explosion_cart", "targetname" );
    var_4.animname = "cart";
    var_4 maps\_anim::setanimtree();
    var_5 = getent( "fusion_utility_cart_collision", "targetname" );
    var_5 linkto( var_4, "TAG_ORIGIN" );
    var_6 = getent( "org_reaction_pickup_event", "targetname" );
    var_7 = "fusion_utility_cart_explode_cart";
    thread reaction_pickup_event();

    if ( level.nextgen )
        common_scripts\utility::flag_wait( "hangar_enemies" );

    wait 1.5;
    common_scripts\utility::flag_wait( "reaction_explo01a" );
    common_scripts\utility::array_call( var_0, ::delete );
    common_scripts\utility::array_call( var_1, ::show );
    common_scripts\utility::array_call( var_1, ::solid );
    thread pressure_explosion_damage( 1 );
    level thread maps\fusion_fx::big_pipe_explosion_vfx_after_hangar();
    wait 0.5;
    common_scripts\utility::flag_wait( "reaction_explo01" );
    wait 0.5;
    common_scripts\utility::array_call( var_2, ::delete );
    common_scripts\utility::array_call( var_3, ::show );
    common_scripts\utility::array_call( var_3, ::solid );
    thread pressure_explosion_damage( 2 );
    var_4 setmodel( "vehicle_ind_utility_tractor_01_dstrypv" );
    var_6 thread maps\_anim::anim_single_solo( var_4, var_7 );
    thread explosion_cart_kill_trigger();
    var_4 thread maps\fusion_fx::underground_pipe_explosion_utility_truck_vfx();
    var_6 waittill( var_7 );
    var_5 disconnectpaths();
}

explosion_cart_kill_trigger()
{
    wait 0.75;
    var_0 = common_scripts\utility::getstruct( "explosion_cart_kill_struct", "targetname" );
    radiusdamage( var_0.origin, var_0.radius, 300, 300, undefined );
}

pressure_explosion_damage( var_0 )
{
    var_1 = common_scripts\utility::getstruct( "pressure_explosion_" + var_0 + "_damage", "targetname" );
    playrumbleonposition( "grenade_rumble", var_1.origin );
    radiusdamage( var_1.origin, var_1.radius, 300, 300, undefined, "MOD_EXPLOSIVE" );
}

reaction_pickup_event()
{
    var_0 = getentarray( "crater_models", "targetname" );
    var_0 = common_scripts\utility::array_add( var_0, getent( "crater_brush", "targetname" ) );
    var_1 = getent( "crater_brush_surface", "targetname" );
    var_2 = getent( "crater_connectpaths", "targetname" );
    var_3 = getent( "explosion_pickup_intact", "targetname" );
    var_4 = getent( "explosion_pickup", "targetname" );
    var_4.animname = "pickup";
    var_4 maps\_anim::setanimtree();
    var_4 hide();

    foreach ( var_6 in var_0 )
        var_6 hide();

    var_8 = getent( "truck_flip_collision", "targetname" );
    var_8 disconnectpaths();
    var_9 = [];
    var_9[var_9.size] = var_4;
    var_10 = getent( "org_reaction_pickup_event", "targetname" );
    var_10 maps\_anim::anim_first_frame( var_9, "fusion_reaction_pickup_event" );
    common_scripts\utility::flag_wait( "reaction_explo02" );
    var_8 connectpaths();
    var_8 delete();
    var_10 thread maps\_anim::anim_single( var_9, "fusion_reaction_pickup_event" );
    var_4 thread reaction_pickup_queue_explosion();
    var_4 thread reaction_pickup_player_proximity();
    level waittill( "truck_explosion" );
    var_3 hide();
    var_4 show();
    var_1 hide();
    var_1 notsolid();
    var_2 solid();
    var_2 disconnectpaths();
    common_scripts\utility::array_call( var_0, ::show );
    var_4 thread maps\fusion_fx::underground_pipe_explosion_pickup_truck_vfx();
    thread pressure_explosion_damage( 3 );
    wait 0.8;
    radiusdamage( var_4.origin, 220, 200, 100, undefined, "MOD_EXPLOSIVE" );
    wait 0.3;
    radiusdamage( var_4.origin, 180, 200, 100, undefined, "MOD_EXPLOSIVE" );
}

reaction_pickup_queue_explosion()
{
    level endon( "truck_explosion" );
    self waittillmatch( "single anim", "truck_explosion" );
    level notify( "truck_explosion" );
}

reaction_pickup_player_proximity()
{
    level endon( "truck_explosion" );
    var_0 = 202500;

    for (;;)
    {
        if ( distancesquared( self.origin, level.player.origin ) < var_0 )
        {
            var_1 = [];
            var_1[0] = self;
            maps\_anim::anim_set_time( var_1, "fusion_reaction_pickup_event", 0.43 );
            level notify( "truck_explosion" );
        }

        wait 0.05;
    }
}

reaction_ai()
{
    var_0 = getentarray( "ct_enemies_runaway", "targetname" );
    common_scripts\utility::flag_wait( "ct_combat_retreat" );
    common_scripts\utility::array_thread( var_0, maps\_utility::add_spawn_function, maps\_utility::disable_long_death );
    var_1 = maps\_utility::array_spawn( var_0 );
    common_scripts\utility::flag_wait( "reaction_explo01" );
    common_scripts\utility::array_thread( level.ct_enemies, ::enemy_run_away, "vol_final_runaway", 1 );
    common_scripts\utility::array_thread( var_1, ::enemy_run_away, "vol_final_runaway", 1 );
    var_2 = getentarray( "ct_runaway_enemies", "targetname" );
    common_scripts\utility::array_thread( var_2, maps\_utility::add_spawn_function, maps\_utility::disable_long_death );
    var_2 = maps\_utility::array_spawn( var_2 );
    common_scripts\utility::flag_wait( "reaction_explo02" );
    thread ct_enemies_final_runaway_faceplayer( var_0 );
    var_3 = getentarray( "ct_enemies_final_runaway", "targetname" );
    common_scripts\utility::array_thread( var_3, maps\_utility::add_spawn_function, maps\_utility::disable_long_death );
    var_4 = maps\_utility::array_spawn( var_3, 1, 1 );
    common_scripts\utility::flag_wait( "ct_final_retreat" );
    var_5 = getaiarray( "axis" );
    common_scripts\utility::array_thread( var_5, ::enemy_run_away, "vol_final_runaway", 1 );
}

ct_enemies_runaway_faceplayer()
{
    common_scripts\utility::flag_wait( "kva_retreat_faceplayer" );
    var_0 = getentarray( "ct_runaway_enemies_backup", "script_noteworthy" );

    foreach ( var_2 in var_0 )
    {
        if ( isalive( var_2 ) )
            var_2 thread maps\_utility::player_seek_enable();
    }
}

ct_enemies_final_runaway_faceplayer( var_0 )
{
    self notify( "enemy_aggro" );
    self endon( "enemy_aggro" );
    sortbydistance( var_0, level.player.origin );
    level waittill( "ct_enemies_runaway_damage" );
}

finale_enemy_transports()
{
    if ( isdefined( level.start_point ) && level.start_point == "cooling_tower" )
        return;

    common_scripts\utility::flag_wait( "evacuation_started" );
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname( "ct_enemy_transport_01" );
    var_0 maps\_vehicle::godon();
    var_0 thread tigger_hurt_rotor();
    var_0 setmaxpitchroll( 30, 30 );
    var_0 maps\_vehicle::vehicle_lights_on( "running" );
    var_0.snd_disable_vehicle_system = 1;
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname( "ct_enemy_transport_02" );
    var_1 maps\_vehicle::godon();
    var_1 setmaxpitchroll( 30, 40 );
    var_0 maps\_vehicle::vehicle_lights_on( "running" );
    var_1.snd_disable_vehicle_system = 1;
    common_scripts\utility::flag_wait( "hangar_enemies" );
    var_0.snd_disable_vehicle_system = 0;
    var_1.snd_disable_vehicle_system = 0;
    common_scripts\utility::flag_wait( "hangar_combat_retreat_02" );

    if ( level.nextgen )
        maps\_utility::delaythread( 1, ::spawn_transport_flying_01 );

    common_scripts\utility::flag_wait( "hangar_exit_retreat" );
    maps\_utility::autosave_by_name();

    if ( level.nextgen )
        maps\_utility::delaythread( 1, ::spawn_transport_flying_02 );

    level.get_pdrone_crash_location_override = ::get_pdrone_crash_location_override;
    var_2 = vehicle_scripts\_pdrone::start_flying_attack_drones( "kva_retreat_drones" );

    foreach ( var_4 in var_2 )
    {
        var_4 thread maps\_shg_utility::make_emp_vulnerable();
        var_4 thread drone_delete_at_goal();
    }

    maps\_vehicle::gopath( var_0 );
    soundscripts\_snd::snd_message( "hangar_transport_01_away", var_0 );
    common_scripts\utility::flag_wait( "ct_combat_retreat" );
    var_6 = vehicle_scripts\_pdrone::start_flying_attack_drones( "kva_retreat_drones_02" );

    foreach ( var_4 in var_6 )
    {
        var_4 thread maps\_shg_utility::make_emp_vulnerable();
        var_4 thread drone_delete_at_goal();
    }

    maps\_vehicle::gopath( var_1 );
    common_scripts\utility::flag_wait( "reaction_explo01" );
    var_9 = vehicle_scripts\_pdrone::start_flying_attack_drones( "kva_retreat_drones_03" );

    foreach ( var_4 in var_9 )
    {
        var_4 thread maps\_shg_utility::make_emp_vulnerable();
        var_4 thread drone_delete_at_goal();
    }

    common_scripts\utility::flag_wait( "reaction_explo02" );

    foreach ( var_4 in var_2 )
    {
        if ( isdefined( var_4 ) && isalive( var_4 ) )
            var_4 common_scripts\utility::delaycall( randomfloatrange( 0.05, 10 ), ::kill );
    }

    level waittill( "truck_explosion" );

    foreach ( var_4 in var_6 )
    {
        if ( isdefined( var_4 ) && isalive( var_4 ) )
            var_4 common_scripts\utility::delaycall( randomfloatrange( 0.05, 1 ), ::kill );
    }

    foreach ( var_4 in var_9 )
    {
        if ( isdefined( var_4 ) && isalive( var_4 ) )
            var_4 common_scripts\utility::delaycall( randomfloatrange( 0.05, 1 ), ::kill );
    }
}

tigger_hurt_rotor()
{
    var_0 = getent( "trig_hurt_transport_01", "targetname" );
    var_0 enablelinkto();
    var_0 linkto( self );
    self waittill( "death" );
    var_0 unlink();
    var_0 delete();
}

spawn_transport_flying_01()
{
    var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive( "ct_enemy_transport_flying_01" );

    foreach ( var_2 in var_0 )
        var_2 maps\_vehicle::godon();

    soundscripts\_snd::snd_message( "hangar_transport_flying_01_away", var_0[0] );
}

spawn_transport_flying_02()
{
    var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive( "ct_enemy_transport_flying_02" );

    foreach ( var_2 in var_0 )
        var_2 maps\_vehicle::godon();

    soundscripts\_snd::snd_message( "hangar_transport_flying_02_away", var_0[0] );
}

evacuation_first_drones_think()
{
    level endon( "collapse_start" );
    self waittill( "death" );

    if ( !isdefined( level.evacuation_first_drones_dead ) )
        level.evacuation_first_drones_dead = 0;

    level.evacuation_first_drones_dead++;

    if ( level.evacuation_first_drones_dead >= 5 )
        common_scripts\utility::flag_set( "evacuation_first_drones_down" );
}

kva_retreat_drones_animated()
{
    var_0 = getent( "drone_deploy_run_npc", "targetname" );
    var_1 = getent( "drone_deploy_crouch_npc", "targetname" );
    thread kva_retreat_drone_think( var_0, 0 );
    thread kva_retreat_drone_think( var_1, 0, "Cover Crouch" );
}

kva_retreat_drone_think( var_0, var_1, var_2 )
{
    var_3 = var_0 maps\_utility::spawn_ai( 1 );
    var_3.animname = "generic";
    var_4 = common_scripts\utility::getstruct( var_0.target, "targetname" );
    var_5 = spawn( "script_origin", var_4.origin );
    var_5.angles = var_4.angles;
    var_6 = getent( var_4.target, "targetname" );
    var_7 = getsubstr( var_4.animation, 0, var_4.animation.size - 4 );
    var_8 = spawn( "script_model", var_3 gettagorigin( "TAG_STOWED_BACK" ) );
    var_8 setmodel( var_6.model );
    var_8.angles = var_3 gettagangles( "TAG_STOWED_BACK" );
    var_8 linkto( var_3, "TAG_STOWED_BACK" );
    var_8.animname = "personal_drone";
    var_8 useanimtree( level.scr_animtree["personal_drone"] );
    var_8 thread maps\_anim::anim_loop_solo( var_8, "personal_drone_folded_idle" );

    if ( isdefined( var_2 ) )
        var_5 maps\_anim::anim_reach_and_approach_solo( var_3, var_7, undefined, "Cover Crouch" );
    else
        var_5 maps\_anim::anim_generic_reach( var_3, var_7 );

    var_5 maps\_anim::anim_generic_reach( var_3, var_7 );

    if ( var_1 )
        var_5 thread maps\_anim::anim_generic_run( var_3, var_7 );
    else
        var_5 thread maps\_anim::anim_generic( var_3, var_7 );

    var_6.origin = var_8.origin;
    var_6.angles = var_8.angles;
    var_9 = var_6 maps\_utility::spawn_vehicle();
    var_8 delete();
    var_9.animname = "personal_drone";
    var_5 maps\_anim::anim_single_solo( var_9, var_7 );

    if ( isdefined( var_9.target ) )
        var_9 maps\_vehicle::gopath();

    if ( var_9.script_team == "axis" )
        var_9 thread maps\_shg_utility::make_emp_vulnerable();
}

get_pdrone_crash_location_override()
{
    level.get_pdrone_crash_location_override = undefined;
    return level.player.origin + 200 * anglestoforward( level.player.angles );
}

finale_enemy_gaz()
{
    common_scripts\utility::flag_wait( "evacuation_started" );

    if ( isdefined( level.start_point ) && level.start_point != "cooling_tower" )
    {
        if ( level.nextgen )
            thread finale_enemy_gaz_1();
    }

    var_0 = maps\_vehicle::spawn_vehicle_from_targetname( "retreat_gaz_02" );
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname( "retreat_gaz_03" );
    var_0 maps\_vehicle::godon();
    var_1 maps\_vehicle::godon();
    common_scripts\utility::flag_wait( "ct_final_retreat" );
    wait 1;
    soundscripts\_snd::snd_message( "start_gaz_02_retreat", var_0 );
    maps\_vehicle::gopath( var_0 );
    wait 1.5;
    soundscripts\_snd::snd_message( "start_gaz_03_retreat", var_1 );
    maps\_vehicle::gopath( var_1 );
}

finale_enemy_gaz_1()
{
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname( "retreat_gaz_01" );
    var_0 maps\_vehicle::godon();
    var_0.snd_disable_vehicle_system = 1;
    common_scripts\utility::flag_wait( "hangar_enemies" );
    var_0.snd_disable_vehicle_system = 0;
    common_scripts\utility::flag_wait( "stop_ambient_explosions" );
    wait 5;
    maps\_vehicle::gopath( var_0 );
}

cooling_tower_collapse()
{
    var_0 = getentarray( "collapse_geo_before", "targetname" );
    var_1 = getentarray( "collapse_geo_after", "targetname" );
    common_scripts\utility::array_call( var_1, ::hide );
    common_scripts\utility::array_call( var_1, ::notsolid );
    var_2 = getentarray( "cooling_tower_static", "targetname" );
    thread cooling_tower_collapse_visibility( var_2 );
    common_scripts\utility::flag_wait( "collapse_start" );
    soundscripts\_snd::snd_message( "tower_collapse_prep" );

    if ( !isdefined( level.player_rig ) )
        level.player_rig = maps\_utility::spawn_anim_model( "player_rig" );

    var_3 = maps\_utility::spawn_anim_model( "player_rig", ( 0, 0, 0 ) );
    var_3 hide();
    var_4 = spawn( "script_model", ( 0, 0, 0 ) );
    var_4 setmodel( "fus_sever_debris" );
    var_4 hide();
    var_4.animname = "collapse_debris_arm";
    var_4 maps\_anim::setanimtree();
    var_5 = maps\_utility::spawn_anim_model( "fus_sever_debris_02" );
    var_5 hide();
    var_6 = spawn( "script_model", ( 0, 0, 0 ) );
    var_6 setmodel( "fus_end_scene_rubble" );
    var_6 hide();
    var_6.animname = "fus_end_scene_rubble";
    var_6 maps\_anim::setanimtree();
    var_7 = maps\_utility::spawn_anim_model( "vehicle_xh9_warbird" );
    var_7 hide();
    var_8 = maps\_utility::spawn_anim_model( "fusion_chunk_combo" );
    var_9 = maps\_utility::spawn_anim_model( "fusion_rock_chunk01" );
    var_10 = maps\_utility::spawn_anim_model( "fusion_rock_chunk02" );
    var_11 = maps\_utility::spawn_anim_model( "player_dismembered_arm" );
    var_11 hide();
    var_12 = [];
    var_12[0] = level.burke;
    var_12[1] = level.player_rig;
    var_12[2] = var_4;
    var_12[3] = var_11;
    var_12[4] = var_6;
    var_12[5] = var_5;
    var_12[6] = var_8;
    var_12[7] = var_9;
    var_12[8] = var_10;
    var_13 = [];
    var_14 = spawn( "script_model", ( 0, 0, 0 ) );
    var_14 setmodel( "fus_cooling_tower_collapse_chunks" );
    var_14.animname = "fus_cooling_tower_collapse_chunks";
    var_14 maps\_anim::setanimtree();
    var_13["chunks"] = var_14;
    var_14 = spawn( "script_model", ( 0, 0, 0 ) );
    var_14 setmodel( "fus_cooling_tower_collapse_concrete_shattered" );
    var_14.animname = "fus_cooling_tower_collapse_concrete_shattered";
    var_14 maps\_anim::setanimtree();
    var_13["concrete_shattered"] = var_14;
    var_14 = spawn( "script_model", ( 0, 0, 0 ) );
    var_14 setmodel( "fus_cooling_tower_collapse_concrete_shattered2" );
    var_14.animname = "fus_cooling_tower_collapse_concrete_shattered2";
    var_14 maps\_anim::setanimtree();
    var_13["concrete_shattered2"] = var_14;
    var_14 = spawn( "script_model", ( 0, 0, 0 ) );
    var_14 setmodel( "fus_cooling_tower_collapse_street_collapse" );
    var_14.animname = "fus_cooling_tower_collapse_street_collapse";
    var_14 maps\_anim::setanimtree();
    var_13["street"] = var_14;
    common_scripts\utility::array_call( var_13, ::hide );
    var_15 = maps\_utility::getanim_from_animname( "fusion_silo_collapse_vm_pt02", level.player_rig.animname );
    var_16 = getanimlength( var_15 );
    var_17 = getangledelta( level.scr_anim["player_rig"]["fusion_silo_collapse_vm_pt02"], 0, 1 );
    var_18 = getmovedelta( level.scr_anim["player_rig"]["fusion_silo_collapse_vm_pt02"], 0, 1 );
    var_19 = getent( "org_collapse_new", "targetname" );
    level.player thread collapse_player_dynamic_speed( var_19 );
    var_19 maps\_anim::anim_first_frame( var_13, "fusion_collapse_ground_tower" );
    thread collapse_player_disable_exo_and_weapons();
    level thread maps\fusion_fx::pressure_explosion_lead_up();
    wait 1.1;
    level notify( "collapse_animation_started" );
    soundscripts\_snd::snd_message( "tower_collapse_start" );
    var_19 thread collapse_animate_lamps( "fusion_collapse_ground_tower" );
    level thread maps\fusion_fx::big_moment_ending_vfx( var_13 );
    common_scripts\utility::array_call( var_2, ::hide );
    common_scripts\utility::array_call( var_13, ::show );
    var_20 = getaiarray( "axis" );

    foreach ( var_22 in var_20 )
        var_22 kill();

    common_scripts\utility::array_thread( getentarray( "collapse_stop_signs", "targetname" ), ::collapse_stop_sign_think, var_19 );
    common_scripts\utility::array_thread( getaiarray( "allies" ), ::collapse_friendly_think, var_19 );
    var_19 thread maps\_anim::anim_single( var_13, "fusion_collapse_ground_tower" );
    common_scripts\utility::flag_wait( "tower_knockback" );
    thread tower_collapse_knockback_disable_sonar();
    thread collapse_shellshock();
    soundscripts\_snd::snd_message( "tower_collapse_player_stumble" );
    var_19 maps\_utility::delaythread( 1, maps\_anim::anim_first_frame_solo, level.burke, "fusion_silo_stumble_npc" );
    level.burke common_scripts\utility::delaycall( 1, ::hide );
    common_scripts\utility::noself_delaycall( 1, ::setsaveddvar, "g_friendlynamedist", 0 );
    level.burke common_scripts\utility::delaycall( 1, ::setcontents, 0 );
    level.player thread maps\_shg_utility::setup_player_for_scene();
    level.player maps\_anim::anim_first_frame_solo( level.player_rig, "fusion_silo_collapse_vm_pt01" );
    var_24 = 0.5;
    level.player playerlinktoblend( level.player_rig, "tag_player", var_24 );
    level.player common_scripts\utility::delaycall( var_24, ::playerlinktodelta, level.player_rig, "tag_player", 1, 5, 5, 5, 5, 1 );
    level.player_rig common_scripts\utility::delaycall( var_24, ::show );
    var_25 = "fusion_silo_collapse_vm_pt01";
    maps\_utility::delaythread( 1, common_scripts\utility::array_call, var_0, ::delete );
    maps\_utility::delaythread( 1, common_scripts\utility::array_call, var_1, ::show );
    maps\_utility::delaythread( 1, common_scripts\utility::array_call, var_1, ::solid );
    thread maps\_utility::lerp_fov_overtime( 3, 75 );
    var_26 = getanimlength( level.player_rig maps\_utility::getanim( var_25 ) );
    level.player common_scripts\utility::delaycall( var_26 - 0.5, ::enableweapons );
    level.player thread collapse_player_look_at_tower( var_25, var_19.origin );
    level.player maps\_anim::anim_single_solo( level.player_rig, var_25 );
    level.player thread maps\_shg_utility::setup_player_for_gameplay();
    level.player_rig hide();
    level.player unlink();
    thread collapse_player_disable_exo_and_weapons();
    common_scripts\utility::flag_wait( "tower_debris" );
    soundscripts\_snd::snd_message( "tower_collapse_player_knockback" );
    wait 0.3;
    level.player disableweapons();
    thread maps\_utility::lerp_fov_overtime( 3, 65 );
    level.player thread maps\_shg_utility::setup_player_for_scene();
    level.player maps\_anim::anim_first_frame_solo( level.player_rig, "fusion_silo_collapse_vm_pt02" );
    var_19 maps\_anim::anim_first_frame_solo( level.burke, "fusion_silo_collapse_finale" );
    var_19 maps\_anim::anim_first_frame_solo( var_7, "fusion_silo_collapse_warbird" );
    var_27 = combineangles( level.player_rig.angles, ( 0, 0, var_17 ) );
    var_28 = level.player_rig.origin + var_18[0] * anglestoforward( level.player_rig.angles ) + var_18[1] * anglestoright( level.player_rig.angles ) + var_18[2] * anglestoup( level.player_rig.angles );
    var_29 = var_3.origin - var_28;
    var_30 = var_3.angles - var_27;
    level.player_rig.angles = ( 0, vectortoangles( var_19.origin - level.player.origin )[1], 0 );
    level.player_rig.origin = level.player.origin;
    var_24 = 0.5;
    level.player playerlinktoblend( level.player_rig, "tag_player", var_24 );
    level.player common_scripts\utility::delaycall( var_24, ::playerlinktodelta, level.player_rig, "tag_player", 1, 20, 20, 20, 0, 1 );
    level.player_rig common_scripts\utility::delaycall( var_24, ::show );
    level.player freezecontrols( 1 );
    level.player_rig maps\_anim::anim_single_solo( level.player_rig, "fusion_silo_collapse_vm_pt02" );
    level notify( "stop_player_pos_update" );
    soundscripts\_snd::snd_message( "silo_collapse_plr_stunned" );
    var_6 show();
    soundscripts\_snd::snd_message( "fus_outro_burke_foley" );
    var_7 show();
    level.burke show();
    var_31 = common_scripts\utility::spawn_tag_origin();
    var_31 linkto( var_7, "TAG_light_body_l", ( 10, 0, -20 ), ( 14, 110, 0 ) );
    playfxontag( common_scripts\utility::getfx( "fusion_light_heli_strobe_outro" ), var_31, "TAG_ORIGIN" );
    var_7 soundscripts\_snd::snd_message( "fusion_silo_collapse_warbird" );
    var_19 thread maps\_anim::anim_single_solo( level.burke, "fusion_silo_collapse_finale" );
    var_19 thread maps\_anim::anim_single_solo( var_7, "fusion_silo_collapse_warbird" );
    var_19 thread maps\_anim::anim_single( var_12, "fusion_silo_collapse_finale" );
    var_32 = maps\_utility::getanim_from_animname( "fusion_silo_collapse_finale", level.player_rig.animname );
    level notify( "stop_evacuation_kiosk_movie" );
    var_33 = getanimlength( var_32 );
    wait(var_33 - 2.0);
    common_scripts\utility::flag_set( "play_ending" );
    var_34 = 2;
    soundscripts\_snd::snd_message( "ending_fade_out", var_34 );
    maps\_utility::nextmission();
}

ending_fade_out( var_0 )
{
    setblur( 10, var_0 );
    var_1 = newhudelem();
    var_1.x = 0;
    var_1.y = 0;
    var_1.horzalign = "fullscreen";
    var_1.vertalign = "fullscreen";
    var_1 setshader( "black", 640, 480 );

    if ( isdefined( var_0 ) && var_0 > 0 )
    {
        var_1.alpha = 0;
        var_1 fadeovertime( var_0 );
        var_1.alpha = 1;
        wait(var_0);
    }

    waittillframeend;
    var_1 destroy();
}

collapse_shellshock()
{
    var_0 = 10;
    level.player shellshock( "fusion_pre_collapse", var_0 );
    common_scripts\utility::flag_wait( "tower_debris" );
    wait 1;
    var_0 = 7;
    level.player shellshock( "fusion_collapse", var_0 );
    wait 8;
    var_0 = 60;
    level.player shellshock( "fusion_pre_collapse", var_0 );
}

collapse_friendly_think( var_0 )
{
    var_1 = 0.0005;
    var_2 = distance( self.origin, var_0.origin ) * var_1 - 0.97;
    wait(var_2);
    maps\_utility::flashbangstart( 4 );

    if ( self != level.burke )
    {
        common_scripts\utility::flag_wait( "tower_knockback" );
        wait 3;
        maps\_utility::stop_magic_bullet_shield();
        self delete();
    }
}

collapse_stop_sign_think( var_0 )
{
    var_1 = 0.0005;
    var_2 = distance( self.origin, var_0.origin ) * var_1 - 0.97;
    wait(var_2);
    var_3 = getent( self.target, "targetname" );
    var_3 linkto( self );
    var_4 = vectortoangles( var_0.origin - self.origin );

    if ( self.angles[1] - var_4[1] > -180 )
        var_5 = var_4 + ( 0, -90, 90 );
    else
        var_5 = var_4 + ( 0, 90, -90 );

    var_6 = 0.3;
    self rotateto( var_5, var_6, 0.1, 0 );
    wait(var_6);
    var_3 delete();
    self delete();
}

collapse_animate_lamps( var_0 )
{
    var_1 = getentarray( "collapse_streetlight", "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3 ) )
            var_3 delete();
    }

    var_5 = [];

    for ( var_6 = 1; var_6 < 10; var_6++ )
        var_5[var_5.size] = maps\_utility::spawn_anim_model( "fusion_silo_lamp0" + var_6 );

    for ( var_6 = 0; var_6 <= 5; var_6++ )
        var_5[var_5.size] = maps\_utility::spawn_anim_model( "fusion_silo_lamp1" + var_6 );

    maps\_anim::anim_single( var_5, var_0 );
}

cooling_tower_collapse_visibility( var_0 )
{
    level endon( "collapse_start" );
    common_scripts\utility::array_call( var_0, ::hide );

    for (;;)
    {
        common_scripts\utility::flag_wait( "show_collapse_tower" );
        common_scripts\utility::array_call( var_0, ::show );
        common_scripts\utility::flag_waitopen( "show_collapse_tower" );
        common_scripts\utility::array_call( var_0, ::hide );
    }
}

grey_out_player()
{
    var_0 = maps\_hud_util::create_client_overlay( "white", 0, level.player );
    var_0.sort = -1;
    var_0.foreground = 1;
    var_0.color = ( 0.6, 0.6, 0.6 );
    var_1 = 0.1;
    var_2 = 1;
    var_0 fadeovertime( var_1 );
    var_0.alpha = var_2;
    wait(var_1);
    var_1 = 0.05;
    wait(var_1);
    var_1 = 0.1;
    var_2 = 0;
    var_0 fadeovertime( var_1 );
    var_0.alpha = var_2;
    wait(var_1);
    var_0 destroy();
}

collapse_player_dynamic_speed( var_0 )
{
    level endon( "stop_player_pos_update" );
    var_1 = 2636;
    var_2 = 4000;
    var_3 = var_2 - var_1;
    var_4 = 0.05;
    var_5 = 1;

    for (;;)
    {
        var_6 = ( distance( level.player.origin, var_0.origin ) - var_1 ) / var_3;

        if ( var_6 < var_4 )
            var_6 = var_4;
        else if ( var_6 > var_5 )
            var_6 = var_5;

        level.player setmovespeedscale( var_6 );
        wait 0.05;
    }

    level.player maps\_utility::blend_movespeedscale_percent( 50, 3 );
}

collapse_player_disable_exo_and_weapons()
{
    maps\_player_exo::player_exo_deactivate();
    level.player disableweaponswitch();
    level.player disableoffhandweapons();
    level.player enableinvulnerability();
    level.player allowjump( 0 );
    level.player.ignoreme = 1;
}

collapse_player_look_at_tower( var_0, var_1 )
{
    var_2 = maps\_utility::getanim_from_animname( var_0, level.player_rig.animname );
    var_3 = getanimlength( var_2 );
    var_4 = vectortoangles( var_1 - level.player.origin );
    level.player setangles( ( 0, var_4[1], 0 ) );
}

collapse_cleanup()
{
    wait 1;
    var_0 = getaiarray();

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2.magic_bullet_shield ) && var_2.magic_bullet_shield )
            var_2 maps\_utility::stop_magic_bullet_shield();
    }

    common_scripts\utility::array_call( var_0, ::delete );
}

play_fullscreen_blood_splatter( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = newclienthudelem( self );
    var_5.x = 0;
    var_5.y = 0;
    var_5 setshader( var_0, 640, 480 );
    var_5.splatter = 1;
    var_5.alignx = "left";
    var_5.aligny = "top";
    var_5.sort = 1;
    var_5.foreground = 0;
    var_5.horzalign = "fullscreen";
    var_5.vertalign = "fullscreen";
    var_5.alpha = 0;
    var_5.enablehudlighting = 1;
    var_6 = 0;

    if ( !isdefined( var_2 ) )
        var_2 = 1;

    if ( !isdefined( var_3 ) )
        var_3 = 1;

    if ( !isdefined( var_4 ) )
        var_4 = 1;

    var_7 = 0.05;

    if ( var_2 > 0 )
    {
        var_8 = 0;
        var_9 = var_4 / ( var_2 / var_7 );

        while ( var_8 < var_4 )
        {
            var_5.alpha = var_8;
            var_8 += var_9;
            wait(var_7);
        }
    }

    var_5.alpha = var_4;
    wait(var_1 - var_2 + var_3);

    if ( var_3 > 0 )
    {
        var_8 = var_4;
        var_10 = var_4 / ( var_3 / var_7 );

        while ( var_8 > 0 )
        {
            var_5.alpha = var_8;
            var_8 -= var_10;
            wait(var_7);
        }
    }

    var_5.alpha = 0;
    var_5 destroy();
}

warbird_shooting_think( var_0 )
{
    level.player endon( "death" );
    self endon( "death" );
    self.mgturret[0] setmode( "manual" );
    self.mgturret[1] setmode( "manual" );

    if ( !maps\_utility::ent_flag_exist( "fire_turrets" ) )
        maps\_utility::ent_flag_init( "fire_turrets" );

    maps\_utility::ent_flag_set( "fire_turrets" );
    thread warbird_fire_monitor();

    for (;;)
    {
        self waittill( "warbird_fire" );
        thread warbird_fire( var_0 );
    }
}

warbird_fire( var_0 )
{
    self endon( "death" );
    var_1 = self.mgturret[0];
    var_2 = self.mgturret[1];

    while ( maps\_utility::ent_flag( "fire_turrets" ) )
    {
        var_3 = getaiarray( "axis" );

        if ( isdefined( level.flying_attack_drones ) )
            var_4 = level.flying_attack_drones;
        else
            var_4 = [];

        if ( isdefined( level.drones ) && isdefined( level.drones["axis"].array ) )
            var_3 = common_scripts\utility::array_combine( var_3, level.drones["axis"].array );

        var_3 = common_scripts\utility::array_combine( var_3, var_4 );
        var_5 = [];

        foreach ( var_7 in var_3 )
        {
            if ( isdefined( var_7.ignoreme ) && var_7.ignoreme )
                continue;
            else
                var_5[var_5.size] = var_7;
        }

        var_5 = sortbydistance( var_5, self.origin );
        var_9 = undefined;

        foreach ( var_7 in var_5 )
        {
            if ( !isdefined( var_7 ) )
                continue;

            if ( !isalive( var_7 ) )
                continue;

            if ( isdefined( var_0 ) && var_0 )
            {
                var_11 = self.mgturret[0] gettagorigin( "tag_flash" );
                var_12 = var_7 geteye();
                var_13 = vectornormalize( var_12 - var_11 );
                var_14 = var_11 + var_13 * 20;

                if ( !sighttracepassed( var_14, var_12, 0, var_7, self.mgturret[0] ) )
                    continue;
            }

            var_9 = var_7;
            break;
        }

        if ( isdefined( var_9 ) )
        {
            var_1 settargetentity( var_9 );
            var_2 settargetentity( var_9 );
            var_1 turretfireenable();
            var_2 turretfireenable();
            var_1 startfiring();
            var_2 startfiring();
            wait_for_warbird_fire_target_done( var_9, var_0 );
            var_1 cleartargetentity();
            var_2 cleartargetentity();
            var_1 turretfiredisable();
            var_2 turretfiredisable();
        }

        wait 0.05;
    }

    var_1 turretfiredisable();
    var_2 turretfiredisable();
}

wait_for_warbird_fire_target_done( var_0, var_1 )
{
    var_0 endon( "death" );

    if ( !maps\_utility::ent_flag( "fire_turrets" ) )
        return;

    self endon( "fire_turrets" );

    for (;;)
    {
        if ( isdefined( var_1 ) && var_1 )
        {
            var_2 = self.mgturret[0] gettagorigin( "tag_flash" );
            var_3 = var_0 geteye();
            var_4 = vectornormalize( var_3 - var_2 );
            var_5 = var_2 + var_4 * 20;

            if ( !sighttracepassed( var_5, var_3, 0, var_0, self.mgturret[0] ) )
                return;
        }

        wait 0.3;
    }
}

warbird_fire_monitor()
{
    self endon( "death" );
    self waittill( "warbird_stop_firing" );
    maps\_utility::ent_flag_clear( "fire_turrets" );
}

heli_looking_at_target( var_0 )
{
    var_1 = 45;
    var_2 = cos( var_1 );
    var_3 = anglestoforward( self.angles );
    var_4 = vectornormalize( var_0.origin - self.origin );

    if ( vectordot( var_3, var_4 ) >= var_2 )
        return 1;
    else
        return 0;
}

demo_skip_forward()
{
    common_scripts\utility::flag_wait( "start_itiot" );

    if ( getdvarint( "demo_itiot" ) == 1 )
    {
        wait 0.5;
        level.overlay = maps\_hud_util::create_client_overlay( "black", 0, level.player );
        level.overlay.sort = -1;
        level.overlay.foreground = 1;
        level.overlay.color = ( 0, 0, 0 );
        level.overlay fadeovertime( 1 );
        level.overlay.alpha = 1;
        soundscripts\_snd::snd_message( "itiot_fade_out" );
        var_0 = [];
        var_0[0] = "In the interest of time...";
        thread demo_feed_lines( var_0, 1 );
        wait 1;

        if ( isdefined( level.player.drivingvehicle ) )
        {
            level.player.drivingvehicle notify( "exit_vehicle_dof" );
            level.player maps\_utility::player_dismount_vehicle();
        }
        else if ( isdefined( level.player.drivingvehicleandturret ) )
        {
            level.player.drivingvehicleandturret notify( "exit_vehicle_dof" );
            level.player.drivingvehicleandturret notify( "dismount_vehicle_and_turret" );
            level.player.drivingvehicleandturret = undefined;
        }

        if ( isdefined( level.alpha_leader ) )
            level.alpha_leader maps\_utility::stop_magic_bullet_shield();

        if ( isdefined( level.joker ) )
            level.joker maps\_utility::stop_magic_bullet_shield();

        if ( isdefined( level.carter ) )
            level.carter maps\_utility::stop_magic_bullet_shield();

        if ( isdefined( level.burke ) )
            level.burke maps\_utility::stop_magic_bullet_shield();

        level.burke maps\_utility::anim_stopanimscripted();
        level.joker maps\_utility::anim_stopanimscripted();
        level notify( "itiot_cleanup" );
        common_scripts\utility::array_call( getaiarray(), ::delete );
        common_scripts\utility::array_call( getentarray( "script_vehicle_x4walker_wheels_turret", "classname" ), ::delete );

        if ( isdefined( level.player.linked_to_cover ) )
            level.player.linked_to_cover vehicle_scripts\_cover_drone::player_unlink_from_cover();

        common_scripts\utility::array_call( getentarray( "script_vehicle_cover_drone", "classname" ), ::delete );
        common_scripts\utility::array_call( getentarray( "mobile_turret", "targetname" ), ::delete );
        common_scripts\utility::array_call( getentarray( "script_vehicle_pdrone", "classname" ), ::delete );
        level.player setstance( "stand" );
        level.player freezecontrols( 1 );
        level.player maps\_utility::teleport_player( common_scripts\utility::getstruct( "itiot_player_start", "targetname" ) );
        level.player setangles( level.player.angles + ( 7, 0, 0 ) );
        wait 4;
        soundscripts\_snd::snd_message( "itiot_fade_in" );
        level.player freezecontrols( 0 );
        common_scripts\utility::flag_set( "flag_shut_down_reactor_failed" );
        common_scripts\utility::flag_set( "evacuation_started" );
    }
}

demo_feed_lines( var_0, var_1 )
{
    var_2 = getarraykeys( var_0 );

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        var_4 = var_2[var_3];
        var_5 = var_3 * var_1 + 1;
        maps\_utility::delaythread( var_5, ::centerlinethread, var_0[var_4], var_0.size - var_3 - 1, var_1, var_4 );
    }
}

centerlinethread( var_0, var_1, var_2, var_3 )
{
    level notify( "new_introscreen_element" );
    var_4 = newhudelem();
    var_4.x = 0;
    var_4.y = 0;
    var_4.alignx = "center";
    var_4.aligny = "middle";
    var_4.horzalign = "center";
    var_4.vertalign = "middle_adjustable";
    var_4.sort = 1;
    var_4.foreground = 1;
    var_4 settext( var_0 );
    var_4.alpha = 0;
    var_4 fadeovertime( 0.2 );
    var_4.alpha = 1;
    var_4.hidewheninmenu = 1;
    var_4.fontscale = 2.4;
    var_4.color = ( 0.8, 1, 0.8 );
    var_4.font = "objective";
    var_4.glowcolor = ( 0.3, 0.6, 0.3 );
    var_4.glowalpha = 1;
    var_5 = int( var_2 * 1000 + 4000 );
    var_4 setpulsefx( 30, var_5, 700 );
    thread maps\_introscreen::hudelem_destroy( var_4 );

    if ( !isdefined( var_3 ) )
        return;

    if ( !isstring( var_3 ) )
        return;

    if ( var_3 != "date" )
        return;
}

introscreen_generic_fade_out( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 1.5;

    var_4 = newhudelem();
    var_4.x = 0;
    var_4.y = 0;
    var_4.horzalign = "fullscreen";
    var_4.vertalign = "fullscreen";
    var_4.foreground = 1;
    var_4 setshader( var_0, 640, 480 );

    if ( isdefined( var_3 ) && var_3 > 0 )
    {
        var_4.alpha = 0;
        var_4 fadeovertime( var_3 );
        var_4.alpha = 1;
        wait(var_3);
    }

    wait(var_1);

    if ( isdefined( var_2 ) && var_2 > 0 )
    {
        var_4.alpha = 1;
        var_4 fadeovertime( var_2 );
        var_4.alpha = 0;
    }

    var_4 destroy();
}

prep_cinematic( var_0 )
{
    setsaveddvar( "cg_cinematicFullScreen", "0" );
    cinematicingame( var_0, 1 );
    level.current_cinematic = var_0;
}

play_cinematic( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        soundscripts\_audio::deprecated_aud_send_msg( "begin_cinematic", var_0 );

    if ( isdefined( level.current_cinematic ) )
    {
        pausecinematicingame( 0 );
        setsaveddvar( "cg_cinematicFullScreen", "1" );
        level.current_cinematic = undefined;
    }
    else
        cinematicingame( var_0 );

    if ( !isdefined( var_2 ) || !var_2 )
        setsaveddvar( "cg_cinematicCanPause", "1" );

    wait 1;

    while ( iscinematicplaying() )
        wait 0.05;

    if ( !isdefined( var_2 ) || !var_2 )
        setsaveddvar( "cg_cinematicCanPause", "0" );

    if ( !isdefined( var_1 ) )
        soundscripts\_audio::deprecated_aud_send_msg( "end_cinematic", var_0 );
}

setup_evacuation_scene()
{
    maps\_drone_civilian::init();
    maps\_drone_ai::init();
    level.evacuation_scene_spawners = [];
    level.evacuation_scene_spawners["civilian"] = getentarray( "evacuation_scene_spawners_civilians", "targetname" );
    level.evacuation_scene_spawners["axis"] = getentarray( "evacuation_scene_spawners_axis", "targetname" );
    level.evacuation_scene_index = [];
    level.evacuation_scene_index["civilian"] = 0;
    level.evacuation_scene_index["axis"] = 0;
    level.scr_anim["civilian"]["civilian_run_hunched_A_relative"] = %civilian_run_hunched_a_relative;
    level.scr_anim["civilian"]["civilian_run_upright_relative"] = %civilian_run_upright_relative;
    level.scr_anim["civilian"]["unarmed_scared_run"] = %unarmed_scared_run;
    level.scr_anim["civilian"]["civilian_leaning_death"] = %civilian_leaning_death;
    level.scr_anim["civilian"]["DC_Burning_bunker_stumble"] = %dc_burning_bunker_stumble;
    level.scr_anim["civilian"]["civilian_run_upright_turnL90"] = %civilian_run_upright_turnl90;
    level.scr_anim["civilian"]["civilian_run_hunched_turnL90_slide"] = %civilian_run_hunched_turnl90_slide;
    thread handle_evacuation_scene_triggers();
}

handle_evacuation_scene_triggers()
{
    var_0 = getentarray( "evacuation_scene_trigger", "script_noteworthy" );
    common_scripts\utility::array_thread( var_0, ::evacuation_scene_trigger_think );
}

evacuation_scene_trigger_think()
{
    var_0 = common_scripts\utility::getstructarray( self.target, "targetname" );
    self waittill( "trigger", var_1 );
    common_scripts\utility::flag_set( "hangar_exit_explosion" );

    foreach ( var_3 in var_0 )
        var_3 thread evacuation_scene_think();
}

evacuation_scene_think()
{
    var_0 = get_evacuation_scene_spawner( self.script_parameters );

    if ( isdefined( self.script_delay ) )
        wait(self.script_delay);

    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "runner" )
    {
        var_0.target = self.target;
        var_1 = var_0 maps\_utility::spawn_ai( 1 );
        var_0.target = undefined;
        var_1.origin = self.origin;
        var_1.no_friendly_fire_penalty = 1;
        var_1 thread evacuation_scene_run_actor( self.animation, self.script_parameters );
    }
    else if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "run_and_die" )
    {
        var_0.target = self.target;
        var_1 = var_0 maps\_utility::spawn_ai( 1 );
        var_0.target = undefined;
        var_1.origin = self.origin;
        var_1.no_friendly_fire_penalty = 1;
        var_1 thread evacuation_scene_run_actor_and_die( self.animation, self.script_parameters );
    }
    else if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "anim_then_run" )
    {
        var_0.target = self.target;
        var_0.script_moveoverride = 1;
        var_1 = var_0 maps\_utility::spawn_ai( 1 );
        var_1.no_friendly_fire_penalty = 1;
        var_0.script_moveoverride = undefined;
        var_1.animname = self.script_parameters;
        var_2 = var_1 evacuation_scene_determine_run_cycle( self.animation );
        var_1 maps\_utility::set_run_anim_array( var_2, undefined, 1 );
        evacuation_scene_animate_actor( var_1 );
        var_1 notify( "move" );
        var_1 waittill( "goal" );
        var_1 kill();
    }
    else
    {
        var_1 = var_0 maps\_utility::spawn_ai( 1 );
        var_1.no_friendly_fire_penalty = 1;
        var_1.animname = self.script_parameters;
        thread evacuation_scene_animate_actor( var_1 );
    }
}

get_evacuation_scene_spawner( var_0 )
{
    var_1 = level.evacuation_scene_spawners[var_0][level.evacuation_scene_index[var_0]];
    level.evacuation_scene_index[var_0]++;

    if ( level.evacuation_scene_index[var_0] >= level.evacuation_scene_spawners[var_0].size )
        level.evacuation_scene_index[var_0] = 0;

    return var_1;
}

evacuation_scene_animate_actor( var_0 )
{
    var_0 endon( "death" );
    var_0.allowdeath = 1;
    var_1 = self.animation;

    if ( isarray( level.scr_anim[var_0.animname][var_1] ) )
    {
        var_2 = 1;
        thread maps\_anim::anim_generic_loop( var_0, var_1, "stop_idle" );
    }
    else
    {
        var_3 = issubstr( var_1, "death" );

        if ( var_3 )
        {
            var_0.skipdeathanim = 1;
            var_0.noragdoll = 1;
        }

        if ( var_1 == "dubai_restaurant_rolling_soldier" )
            var_0 common_scripts\utility::delaycall( 1.8, ::startragdoll );

        if ( issubstr( var_1, "run" ) )
            maps\_anim::anim_single_solo_run( var_0, var_1 );
        else
            maps\_anim::anim_single_solo( var_0, var_1 );

        if ( var_3 )
            var_0 kill();

        var_4 = var_1 + "_idle";

        if ( isdefined( level.scr_anim[var_0.animname][var_4] ) )
            thread maps\_anim::anim_loop_solo( var_0, var_4, "stop_idle" );
    }
}

evacuation_scene_run_actor( var_0, var_1 )
{
    self.runanim = level.scr_anim[var_1][var_0];
    self waittill( "goal" );
    self delete();
}

evacuation_scene_run_actor_and_die( var_0, var_1 )
{
    self waittill( "goal" );
    self.animation = var_0;
    self.animname = var_1;
    var_2 = common_scripts\utility::getstruct( self.target, "targetname" );
    var_2 evacuation_scene_animate_actor( self );
}

evacuation_scene_determine_run_cycle( var_0 )
{
    if ( issubstr( var_0, "civilian_run_hunched" ) )
        var_0 = "civilian_run_hunched_A_relative";
    else if ( issubstr( var_0, "civilian_run_upright" ) )
        var_0 = "civilian_run_upright_relative";
    else
    {

    }

    self.runanim = level.scr_anim[self.animname][var_0];
    return var_0;
}

evacuation_balcony_death()
{
    common_scripts\utility::flag_wait( "reaction_explo01" );
    var_0 = getent( "evacuation_scene_civilian_balcony_death", "targetname" );
    var_1 = common_scripts\utility::getstruct( var_0.target, "targetname" );
    var_2 = var_0 maps\_utility::spawn_ai( 1 );
    var_2.no_friendly_fire_penalty = 1;
    var_2.origin = var_1.origin;
    var_2.angles = var_1.angles;
    var_1 maps\_anim::anim_generic( var_2, "payback_comp_balcony_kick_enemy" );
    var_2 kill( level.player.origin );
    var_2 startragdoll();
}

evacuation_corpses()
{
    var_0 = getent( "evacuation_corpse_civilian", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "evacuation_corpse", "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( !isdefined( var_3.script_parameters ) )
            continue;

        var_4 = undefined;

        switch ( var_3.script_parameters )
        {
            case "civilian":
                var_4 = var_0 maps\_utility::spawn_ai();
                break;
            case "allies":
            case "axis":
            default:
                break;
        }

        if ( !isdefined( var_4 ) )
            continue;

        var_4.origin = var_3.origin;
        var_4.angles = var_3.angles;
        var_4 setcandamage( 0 );
        var_5 = level.scr_anim["generic"][var_3.animation];

        if ( isarray( var_5 ) )
            var_5 = var_5[0];

        var_4 animscripted( "endanim", var_3.origin, var_3.angles, var_5 );
        var_4 notsolid();

        if ( issubstr( var_3.animation, "death" ) )
            var_4 common_scripts\utility::delaycall( 0.05, ::setanimtime, var_5, 1.0 );
    }
}

detect_turret_death()
{
    self.deathfunction = ::set_turret_death_anim;
}

set_turret_death_anim()
{
    if ( self.damageweapon == "none" && self.damagetaken > 100 )
    {
        var_0 = animscripts\death::getstrongbulletdamagedeathanim();

        if ( isdefined( var_0 ) )
            self.deathanim = var_0;
    }

    return 0;
}

smaw_laser_think()
{
    for (;;)
    {
        level.player waittill( "weaponchange" );

        if ( level.player getcurrentweapon() == "smaw_nolock_fusion" )
        {
            level.player laseron();
            continue;
        }

        level.player laseroff();
    }
}

intro_heli_movies()
{
    common_scripts\utility::flag_wait( "intro_text_cinematic_over" );
    setsaveddvar( "cg_cinematicFullScreen", "0" );
    cinematicingameloop( "fusion_heliscreen01" );
    level.burke waittillmatch( "single anim", "start_video_2" );
    stopcinematicingame();
    cinematicingameloop( "fusion_heliscreen02" );
    level.burke waittillmatch( "single anim", "start_video_3" );
    stopcinematicingame();
    cinematicingame( "fusion_heliscreen03" );
    wait 1.9;
    stopcinematicingame();
    cinematicingameloop( "fusion_heliscreen01" );
    wait 90;
    stopcinematicingame();
}

evacuation_kiosk_movie()
{
    level endon( "stop_evacuation_kiosk_movie" );
    setsaveddvar( "cg_cinematicFullScreen", "0" );
    var_0 = 0;

    for (;;)
    {
        var_1 = level.player.origin[0] < 7200;
        var_0 = var_0 && iscinematicplaying();

        if ( !var_0 && var_1 )
        {
            cinematicingameloop( "fusion_evacuation" );
            var_0 = 1;
        }
        else if ( var_0 && !var_1 )
        {
            stopcinematicingame();
            var_0 = 0;
        }

        wait 0.5;
    }
}

take_car_door_shields()
{
    self notify( "remove_car_doors" );
}

drone_delete_at_goal()
{
    self waittill( "reached_path_end" );
    self delete();
}

give_night_vision( var_0 )
{
    level endon( "flag_end_sonar_vision" );

    if ( isdefined( var_0 ) )
        common_scripts\utility::flag_wait( var_0 );

    level.player setweaponhudiconoverride( "actionslot1", "dpad_icon_nvg" );
    level.player notifyonplayercommand( "sonar_vision", "+actionslot 1" );
    level.player thread maps\fusion_utility::thermal_with_nvg();
}

sonar_hint()
{
    level.player endon( "death" );
    common_scripts\utility::flag_wait( "turbine_room_combat_start" );
    wait 7.0;

    if ( !maps\_nightvision::nightvision_check( level.player ) )
        maps\_utility::hintdisplaymintimehandler( "hint_use_sonar", 8 );
}

tower_collapse_knockback_disable_sonar()
{
    wait 1.0;
    maps\sanfran_b_sonar_vision::sonar_vision_off();
    maps\fusion_utility::sonar_off();
    common_scripts\utility::flag_set( "flag_end_sonar_vision" );
}

pdrone_deploy_hint()
{
    level.player endon( "death" );
    common_scripts\utility::flag_wait( "turbine_room_combat_start" );
    wait 7.0;

    if ( !common_scripts\utility::flag( "flag_player_using_drone" ) )
    {
        maps\_utility::hintdisplaymintimehandler( "drone_deploy_prompt", 8 );
        common_scripts\utility::flag_set( "drone_deploy_prompt_displayed" );
    }
}

pdrone_activate( var_0 )
{
    if ( isdefined( var_0 ) )
        common_scripts\utility::flag_wait( var_0 );

    level.player setweaponhudiconoverride( "actionslot1", "dpad_icon_drone" );
    level.player notifyonplayercommand( "use_drone", "-actionslot 1" );
    thread maps\fusion_utility::spawn_player_drone_think();
}

pdrone_deactivate_think()
{
    common_scripts\utility::flag_wait( "turbine_room_stop_combat" );

    if ( !common_scripts\utility::flag( "player_drone_attack_done" ) )
    {
        level.player setweaponhudiconoverride( "actionslot1", "dpad_icon_drone_off" );
        common_scripts\utility::flag_clear( "flag_player_using_drone" );
        common_scripts\utility::flag_set( "player_drone_attack_done" );
    }
}
