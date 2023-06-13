// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

lagos_title_screen()
{
    level.player disableweapons();
    level.player freezecontrols( 1 );
    thread maps\_shg_utility::play_chyron_video( "chyron_text_lagos", 2, 3 );
    common_scripts\utility::flag_wait( "chyron_video_done" );
    soundscripts\_snd::snd_message( "intro_fly_drone_idle" );
}

setup_gameplay()
{
    setup_alpha_squad();
    thread squad_opening();
    thread exo_door();
    thread government_building();
    thread roundabout_setup();
    thread roundabout_combat();
    thread spawncivilians_roundabout();
    thread roundabout_traffic();
    thread alley1_combat();
    thread alley1_oncoming();
    thread alley2_combat();
    thread flank_combat();
    thread frogger_combat();
    thread traffic_rooftop_traverse();
    thread traffic_takedown();
    thread level_bounds();
    thread level_progress();
    thread flank_alley_door_kick();
    player_upkeep();
}

monitorstartdronecontrol( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    var_2 = getent( "PlayerDroneStartpoint", "targetname" );
    var_3 = getent( "PlayerDroneTargetpoint", "targetname" );
    var_4 = getent( "PlayerDroneLookAt", "targetname" );
    var_5 = [];
    var_5[var_5.size] = getent( "FlyDroneBottomN", "targetname" );
    var_5[var_5.size] = getent( "FlyDroneBottomE", "targetname" );
    var_5[var_5.size] = getent( "FlyDroneBottomS", "targetname" );
    var_5[var_5.size] = getent( "FlyDroneBottomW", "targetname" );
    level.player thread maps\_controlled_orbiting_drone::startdronecontrol( var_3, var_2, var_4, var_0, var_1, var_5 );

    if ( var_0 == 1 )
    {
        wait 0.25;
        level.player setblurforplayer( 0, 1.0 );
        wait 0.25;
        maps\_hud_util::fade_in( 0.5, "white" );
    }

    thread monitorenddronecontrol();
}

monitorenddronecontrol()
{
    common_scripts\utility::flag_wait( "FlagPlayerEndDroneControl" );
    maps\_controlled_orbiting_drone::enddronecontrol();
    drone_intro_fov_shift_off();
}

hide_radio()
{

}

setup_alpha_squad()
{
    level.burke = getent( "burke", "targetname" ) maps\_utility::spawn_ai( 1, 1 );
    level.joker = getent( "joker", "targetname" ) maps\_utility::spawn_ai( 1, 1 );
    level.ajani = getent( "ajani", "targetname" ) maps\_utility::spawn_ai( 1, 1 );
    level.ajani thread hide_radio();
    level.burke maps\_utility::forceuseweapon( "iw5_bal27_sp", "primary" );
    level.joker maps\_utility::forceuseweapon( "iw5_bal27_sp", "primary" );
    level.burke.animname = "burke";
    level.joker.animname = "joker";
    level.ajani.animname = "ajani";
    level.alpha_squad = [ level.burke, level.joker, level.ajani ];
    level.alpha_squad_and_player = [ level.burke, level.joker, level.ajani, level.player ];
}

drone_intro()
{
    thread maps\_player_exo::player_exo_deactivate();
    var_0 = 105;
    level.origfov = getdvarint( "cg_fov" );
    level.player lerpfov( var_0, 0.5 );
    common_scripts\utility::flag_set( "fly_drone_in_progess" );
    thread lagos_title_screen();
    thread drone_intro_kva_front_setup();
    thread drone_intro_nig_mil_setup();
    thread drone_intro_conf_room_scene();
    thread gov_hostage_h_breach_doors();
    common_scripts\utility::flag_wait( "chyron_video_done" );
    thread maps\lagos_vo::fly_drone_intro_dialogue();
    wait 5;
    thread vig_tram_setup_intro();
    thread drone_start_player_input();
    common_scripts\utility::flag_wait( "flag_player_input_for_drone_start" );
    wait 1;
    thread maps\lagos_utility::rumble_flydrone_animation();
    thread maps\lagos_utility::fly_drone_ui_on();
    thread monitorstartdronecontrol( 1, 0 );
    level waittill( "drone_opening_finished" );
    common_scripts\utility::flag_set( "fly_drone_done_lighting" );
    common_scripts\utility::flag_set( "intro_playerstart" );
    level.fly_drone_rumbling = 0;
    level notify( "fly_drone_not_moving" );
    maps\_utility::teleport_player( common_scripts\utility::getstruct( "intro_playerstart", "targetname" ) );
    level.player freezecontrols( 0 );
    maps\_shg_utility::show_player_hud();
    level notify( "drone_intro_complete" );
    common_scripts\utility::flag_set( "obj_rescue_PM" );
    wait 1;
    common_scripts\utility::flag_set( "FlagPlayerEndDroneControl" );
}

drone_intro_fov_shift()
{
    var_0 = 105;
    level.origfov = getdvarint( "cg_fov" );
    level.player lerpfov( var_0, 0.5 );
    level waittill( "drone_opening_finished" );
    level.player lerpfov( level.origfov, 2 );
}

drone_intro_fov_shift_on( var_0 )
{
    var_1 = 50;
    level.player lerpfov( var_1, 0.1 );
}

drone_intro_fov_shift_off( var_0 )
{
    level.player lerpfov( level.origfov, 0.5 );
}

drone_intro_conf_room_scene()
{
    var_0 = getent( "anim_org_drone_opening", "targetname" );
    level.player maps\_shg_utility::setup_player_for_scene();
    var_1 = maps\_utility::spawn_anim_model( "player_arms" );
    level.player playerlinktodelta( var_1, "tag_player", 1, 30, 30, 0, 0, 1 );
    soundscripts\_snd::snd_message( "fly_drone_camera_start_1", var_1, level.player );
    var_1 hide();
    var_2 = getent( "kva_hostage_leader", "targetname" );
    level.kva_hostage_leader = var_2 maps\_utility::spawn_ai( 1 );
    level.kva_hostage_leader.animname = "kva_hostage_leader";
    level.kva_hostage_leader maps\_utility::gun_remove();
    level.kva_hostage_leader attach( "npc_titan45_nocamo", "TAG_WEAPON_RIGHT", 0 );
    var_3 = getent( "kva_hostage_minister_intro", "targetname" );
    level.kva_hostage_minister = var_3 maps\_utility::spawn_ai( 1 );
    level.kva_hostage_minister.animname = "kva_hostage_minister";
    level.kva_hostage_minister maps\_utility::gun_remove();
    level.kva_hostage_minister.name = "";
    var_4 = getent( "kva_hostage_victim", "targetname" );
    level.kva_hostage_victim = var_4 maps\_utility::spawn_ai( 1 );
    level.kva_hostage_victim.animname = "kva_hostage_victim";
    level.kva_hostage_victim maps\_utility::gun_remove();
    level.kva_hostage_victim character\gfl\character_gfl_suomi::main();
    var_5 = maps\_utility::spawn_anim_model( "drone_photo" );
    var_5 maps\_utility::assign_animtree();
    var_5 attach( "lag_polaroid_hostage_photo", "TAG_ORIGIN_animated", 0 );
    var_6 = maps\_utility::spawn_anim_model( "pm_cuffs" );
    var_6 maps\_utility::assign_animtree();
    var_7 = maps\_utility::spawn_anim_model( "vic_cuffs" );
    var_7 maps\_utility::assign_animtree();
    var_0 thread maps\_anim::anim_loop_solo( var_1, "drone_opening_idle", "player_input_for_drone_start" );
    common_scripts\utility::flag_wait( "flag_player_input_for_drone_start" );
    var_0 notify( "player_input_for_drone_start" );
    thread maps\lagos_h_breach::drone_intro_conf_flythrough_actors( var_0 );
    var_8 = [];
    var_8[0] = level.kva_hostage_leader;
    var_8[1] = level.kva_hostage_minister;
    var_8[2] = level.kva_hostage_victim;
    var_8[3] = var_5;
    var_8[4] = var_6;
    var_8[5] = var_7;
    var_9 = drone_intro_anim_length();
    thread drone_flyin_vm( var_0, var_1 );
    var_0 thread maps\_anim::anim_single( var_8, "drone_opening" );

    if ( level.currentgen )
        thread set_stream_origin_for_intro();

    wait(var_9);
    thread maps\_introscreen::introscreen_generic_black_fade_in( 1, 0.89, 0.1 );
    level notify( "drone_opening_finished" );
    wait 0.5;

    foreach ( var_11 in var_8 )
        var_11 delete();

    var_1 delete();
}

set_stream_origin_for_intro()
{
    var_0 = drone_intro_anim_length();
    var_0 -= 10.0;
    wait(var_0);
    var_1 = ( -49739, 15569, 314 );
    level.player playersetstreamorigin( var_1 );
    common_scripts\utility::flag_wait( "squad_opening_start" );
    wait 2.0;
    level.player playerclearstreamorigin();
}

drone_start_player_input()
{
    thread maps\lagos_utility::hint_instant( &"LAGOS_START_FLY_DRONE" );
    soundscripts\_snd::snd_message( "fly_drone_picture_live" );

    while ( !common_scripts\utility::flag( "flag_player_input_for_drone_start" ) )
    {
        if ( level.player usebuttonpressed() )
        {
            common_scripts\utility::flag_set( "flag_player_input_for_drone_start" );
            soundscripts\_snd::snd_message( "fly_drone_activate" );
            wait 0.25;
            thread maps\lagos_utility::hint_fade_instant();
            return;
        }

        waitframe();
    }
}

drone_flyin_vm( var_0, var_1 )
{
    var_0 maps\_anim::anim_single_solo( var_1, "drone_opening_player_control" );
    common_scripts\utility::flag_set( "drone_fly_anim_done" );
}

#using_animtree("player");

drone_intro_anim_length()
{
    var_0 = getanimlength( %lag_gov_hostage_room_flythrough_vm );
    var_1 = 1.5;
    var_2 = var_0 - var_1;
    return var_2;
}

drone_intro_kva_front_setup()
{
    var_0 = common_scripts\utility::getstruct( "anim_org_drone_intro2", "targetname" );
    var_1 = getent( "drone_intro_spawner", "targetname" );
    var_2 = [];
    var_3 = 6;

    for ( var_4 = 0; var_4 < var_3; var_4++ )
    {
        var_1.count = 1;
        var_5 = var_1 maps\_utility::spawn_ai( 1 );
        waitframe();
        var_5.animname = "drone_intro";
        var_5 thread maps\lagos_utility::disable_awareness();
        var_2 = common_scripts\utility::array_add( var_2, var_5 );
    }

    var_6 = maps\_utility::spawn_anim_model( "intro_duffle" );
    var_6 maps\_utility::assign_animtree();
    var_2 = common_scripts\utility::array_add( var_2, var_6 );
    level.kva_opening_vo = var_2[5];
    wait 2;
    common_scripts\utility::flag_wait( "flag_player_input_for_drone_start" );
    var_0 thread maps\_anim::anim_single_solo( var_2[0], "drop_bag" );
    var_0 thread maps\_anim::anim_single_solo( var_2[1], "run_into_room" );
    var_0 thread maps\_anim::anim_single_solo( var_2[2], "aim_turret" );
    var_0 thread maps\_anim::anim_single_solo( var_2[3], "aim_forward" );
    var_0 thread maps\_anim::anim_single_solo( var_2[4], "guy_5" );
    var_0 thread maps\_anim::anim_single_solo( var_2[5], "guy_6" );
    var_0 thread maps\_anim::anim_single_solo( var_6, "drop_bag" );
    var_2[2] maps\_utility::gun_remove();
    level waittill( "drone_intro_complete" );

    foreach ( var_8 in var_2 )
    {
        if ( isdefined( var_8 ) && isalive( var_8 ) )
            var_8 delete();
    }
}

drone_intro_nig_mil_setup()
{
    common_scripts\utility::flag_wait( "flag_player_input_for_drone_start" );
    var_0 = getentarray( "militia_drive_start_front", "targetname" );
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        var_4 = var_3 maps\_utility::spawn_ai( 1 );
        var_3.count = 1;
        var_4.goalradius = 16;
        var_4 thread maps\_utility::magic_bullet_shield( 1 );
        var_1 = common_scripts\utility::array_add( var_1, var_4 );
        var_4 thread gov_building_firefight_change_pos();
    }

    level waittill( "drone_intro_complete" );

    foreach ( var_4 in var_1 )
        var_4 delete();
}

warbird_hide_blury_rotors()
{
    self hidepart( "TAG_SPIN_MAIN_ROTOR_L" );
    self hidepart( "TAG_SPIN_MAIN_ROTOR_R" );
    self hidepart( "TAG_SPIN_TAIL_ROTOR" );
}

squad_opening()
{
    level.squad_opening_warbird = getent( "squad_opening_warbird", "targetname" );
    thread opening_prop_deletes();
    common_scripts\utility::flag_wait( "obj_rescue_PM" );
    common_scripts\utility::flag_wait( "squad_opening_start" );
    thread vig_intro_civ_populate();

    if ( common_scripts\utility::flag( "no_anim_squad_opening" ) )
        return;

    var_0 = [];
    var_1 = getent( "anim_org_opening_squad", "targetname" );
    var_2 = var_1 common_scripts\utility::spawn_tag_origin();
    var_2.origin -= ( 0, 0, 7 );
    soundscripts\_snd::snd_message( "start_intro_ambience" );
    level.squad_opening_warbird.origin += ( 70000, 0, 0 );
    level.squad_opening_warbird.animname = "squad_opening_warbird";
    level.squad_opening_warbird maps\_utility::assign_animtree();
    level.squad_opening_warbird soundscripts\_snd::snd_message( "opening_warbird" );
    level.squad_opening_warbird warbird_hide_blury_rotors();
    var_3 = maps\_utility::spawn_anim_model( "lag_intro_prop1" );
    var_1 maps\_anim::anim_first_frame_solo( var_3, "squad_opening" );
    var_4 = maps\_utility::spawn_anim_model( "lag_intro_prop2" );
    var_1 maps\_anim::anim_first_frame_solo( var_4, "squad_opening" );
    level.player maps\_shg_utility::setup_player_for_scene();
    level.player enableslowaim( 0.2, 0.2 );
    var_5 = maps\_utility::spawn_anim_model( "player_rig" );
    var_1 maps\_anim::anim_first_frame_solo( var_5, "squad_opening" );
    level.player playerlinktodelta( var_5, "tag_player", 1, 7, 7, 5, 5, 1 );
    var_6 = [ var_3, var_4 ];
    var_2 thread maps\_anim::anim_first_frame( [ level.squad_opening_warbird ], "squad_opening" );
    var_1 maps\_anim::anim_first_frame( var_6, "squad_opening" );
    thread maps\lagos_vo::pcap_squad_briefing();
    thread squad_intro_walkway_goto();
    var_1 thread maps\_anim::anim_single( var_6, "squad_opening" );
    var_2 thread maps\_anim::anim_single( [ level.squad_opening_warbird ], "squad_opening" );
    self.animarrayfuncs["exposed"]["stand"] = animscripts\corner::set_standing_animarray_aiming;
    self.animarrayfuncs["exposed"]["crouch"] = animscripts\corner::set_crouching_animarray_aiming;
    level.burke thread squad_intro_anim_burke( var_1 );
    level.joker thread squad_intro_anim_joker( var_1 );
    level.ajani thread squad_intro_anim_ajani( var_1 );
    thread squad_opening_names();
    var_1 maps\_anim::anim_single_solo( var_5, "squad_opening" );
    common_scripts\utility::flag_set( "obj_rescue_PM_pos" );
    level.player unlink();
    var_5 delete();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    level.player disableslowaim();
    level.player disableinvulnerability();
    level.player enableweapons();
    level.player enableweaponswitch();
    level.player enableoffhandweapons();
    level.player allowads( 1 );
    maps\_utility::autosave_by_name();
    level notify( "intro_walkway_go" );
    thread maps\_player_exo::player_exo_activate();
    common_scripts\utility::flag_wait( "vo_squad_move_out_dialogue" );
    thread maps\lagos_vo::squad_move_out_dialogue();
    level waittill( "gov_driveup_started" );
    level.squad_opening_warbird delete();
}

opening_prop_deletes()
{
    wait 3;

    if ( common_scripts\utility::flag( "obj_progress_exo_door_clear" ) )
        level.squad_opening_warbird delete();
}

squad_opening_names()
{
    level.burke thread maps\lagos_utility::hide_friendname_until_flag_or_notify( "show_names" );
    level.joker thread maps\lagos_utility::hide_friendname_until_flag_or_notify( "show_names" );
    level.ajani thread maps\lagos_utility::hide_friendname_until_flag_or_notify( "show_names" );
    wait 0.5;
    level notify( "show_names" );
}

squad_intro_anim_burke( var_0 )
{
    var_1 = level.burke gettagorigin( "J_SpineUpper" );
    var_2 = level.burke gettagangles( "J_SpineUpper" );
    var_3 = maps\_utility::spawn_anim_model( "rooftop_breach_device" );
    var_3.origin = var_1;
    var_3.angles = var_2;
    waitframe();
    var_3 linkto( level.burke, "J_SpineUpper", ( 5, -6, 0 ), ( 0, 0, 90 ) );
    thread maps\lagos_utility::ally_redirect_goto_node( "Gideon", "intro_walkway_burke", 1, maps\lagos_utility::disable_awareness );
    var_0 maps\_anim::anim_single_solo_run( level.burke, "squad_opening" );
    level waittill( "roof_breach_start" );
    var_3 delete();
}

squad_intro_anim_joker( var_0 )
{
    thread maps\lagos_utility::ally_redirect_goto_node( "Joker", "intro_walkway_joker", 1, maps\lagos_utility::disable_awareness );
    var_0 maps\_anim::anim_single_solo_run( self, "squad_opening" );
}

squad_intro_anim_ajani( var_0 )
{
    thread maps\lagos_utility::ally_redirect_goto_node( "Ajani", "intro_walkway_ajani", 1, maps\lagos_utility::disable_awareness );
    var_0 maps\_anim::anim_single_solo_run( self, "squad_opening" );
}

squad_intro_fov_shift_on( var_0 )
{
    var_1 = 50;
    level.player lerpfov( var_1, 0.5 );
}

squad_intro_fov_shift_off( var_0 )
{
    if ( !isdefined( level.origfov ) )
        level.origfov = 65;

    level.player lerpfov( level.origfov, 0.5 );
}

vig_intro_civ_populate()
{
    thread vig_vehicle_traffic_init();
    thread vig_vehicle_removal();
    thread vig_civ_traffic_init();

    if ( level.nextgen )
        thread vig_bike_rider_maintainer( "bike_rider_path", 5 );

    thread vig_tram_setup();
    thread vig_mil_balc_setup();
    level notify( "tram_start" );
}

vig_vehicle_traffic_init()
{
    if ( !level.currentgen )
    {
        level.intro_reg_vehicles = [];
        thread vig_vehicle_traffic_scripted_left();
        thread vig_vehicle_traffic_scripted_right();
    }
}

vig_vehicle_traffic_straight_mover_movement( var_0 )
{
    var_1 = int( self.script_parameters );
    var_2 = randomfloatrange( 3, 7 );
    var_3 = randomfloatrange( 0.5, 1.5 );
    var_4 = randomfloatrange( 0.5, 1.5 );

    if ( isdefined( var_0 ) )
    {
        level waittill( var_0 );
        self moveto( self.origin + ( 0, var_1 * -1, 0 ), var_2, var_3, var_4 );
        wait(var_2);
        level notify( "straight_done_moving" );
    }
    else
    {
        self moveto( self.origin + ( 0, var_1 * -1, 0 ), var_2, var_3, var_4 );
        level notify( "straight_done_moving" );
    }
}

vig_vehicle_traffic_turn_mover_movement( var_0, var_1 )
{
    var_2 = maps\_utility::spawn_vehicle();
    var_2 thread vig_vehicle_fail_on_death();
    wait(randomfloat( 0.75 ));
    var_2 maps\_vehicle::gopath();
    wait(randomfloat( 0.55 ));
    var_2 vehicle_setspeedimmediate( 0, 50, 50 );

    if ( isdefined( var_0 ) )
        level waittill( var_0 );

    if ( !iscaralive( var_2 ) )
        return;

    level.intro_reg_vehicles = common_scripts\utility::array_add( level.intro_reg_vehicles, var_2 );
    var_2 vehicle_setspeed( 5, 10, 10 );
    var_2 maps\_vehicle::gopath();
    var_2 waittill( "goal" );

    if ( isdefined( var_1 ) )
        level notify( var_1 );
}

vig_vehicle_traffic_scripted_left()
{
    var_0 = 1;
    var_1 = 8;
    var_2 = getent( "turn_mover1_lt", "script_noteworthy" );
    var_3 = getent( "turn_mover3_lt", "script_noteworthy" );
    var_4 = getent( "turn_mover4_lt", "script_noteworthy" );
    var_5 = getent( "turn_mover5_lt", "script_noteworthy" );
    var_6 = getent( "turn_mover6_lt", "script_noteworthy" );
    var_7 = getent( "turn_mover7_lt", "script_noteworthy" );
    var_2 thread vig_vehicle_traffic_turn_mover_movement( "mover1_go", "mover1_stop" );
    var_3 thread vig_vehicle_traffic_turn_mover_movement( "mover3_go", "mover1_stop" );
    var_4 thread vig_vehicle_traffic_turn_mover_movement( "mover4_go", "mover1_stop" );
    var_5 thread vig_vehicle_traffic_turn_mover_movement( "mover5_go", "mover1_stop" );
    var_6 thread vig_vehicle_traffic_turn_mover_movement( "mover6_go", "mover1_stop" );
    var_7 thread vig_vehicle_traffic_turn_mover_movement( "mover7_go", "mover1_stop" );
    level waittill( "intro_walkway_go" );
    level notify( "mover1_go" );
    wait(randomfloatrange( var_0, var_1 ));
    wait(randomfloatrange( var_0, var_1 ));
    level notify( "mover3_go" );
    wait(randomfloatrange( var_0, var_1 ));
    level notify( "mover4_go" );
    wait(randomfloatrange( var_0, var_1 ));
    level notify( "mover5_go" );
    wait(randomfloatrange( var_0, var_1 ));
    level notify( "mover6_go" );
    wait(randomfloatrange( var_0, var_1 ));
    level notify( "mover7_go" );
}

vig_vehicle_traffic_scripted_right()
{
    var_0 = 1;
    var_1 = 8;
    var_2 = getent( "turn_mover1_rt", "script_noteworthy" );
    var_3 = getent( "turn_mover3_rt", "script_noteworthy" );
    var_4 = getent( "turn_mover4_rt", "script_noteworthy" );
    var_5 = getent( "turn_mover6_rt", "script_noteworthy" );
    var_6 = getent( "turn_mover7_rt", "script_noteworthy" );
    var_2 thread vig_vehicle_traffic_turn_mover_movement( "mover1_go", "mover1_stop" );
    var_3 thread vig_vehicle_traffic_turn_mover_movement( "mover3_go", "mover1_stop" );
    var_4 thread vig_vehicle_traffic_turn_mover_movement( "mover4_go", "mover1_stop" );
    var_5 thread vig_vehicle_traffic_turn_mover_movement( "mover6_go", "mover1_stop" );
    var_6 thread vig_vehicle_traffic_turn_mover_movement( "mover7_go", "mover1_stop" );
    level waittill( "intro_walkway_go" );
    level notify( "mover1_go" );
    wait(randomfloatrange( var_0, var_1 ));
    wait(randomfloatrange( var_0, var_1 ));
    level notify( "mover3_go" );
    wait(randomfloatrange( var_0, var_1 ));
    level notify( "mover4_go" );
    wait(randomfloatrange( var_0, var_1 ));
    wait(randomfloatrange( var_0, var_1 ));
    level notify( "mover6_go" );
    wait(randomfloatrange( var_0, var_1 ));
    level notify( "mover7_go" );
}

vig_vehicle_traffic_jammer()
{
    level.intro_traffic_lanes = [ "traffic_lane1", "traffic_lane2", "traffic_lane3", "traffic_lane4" ];
    var_0 = undefined;

    for (;;)
    {
        level.intro_traffic_lanes = common_scripts\utility::array_randomize( level.intro_traffic_lanes );
        var_1 = level.intro_traffic_lanes[0];

        if ( isdefined( var_0 ) && var_1 == var_0 )
        {
            waitframe();
            continue;
        }

        thread maps\_vehicle_traffic::traffic_path_head_car_traffic_jam( var_1 );
        wait(randomfloatrange( 5, 10 ));
        thread maps\_vehicle_traffic::traffic_path_head_car_traffic_jam_end_thread( var_1 );
        wait(randomfloatrange( 10, 20 ));
        var_0 = var_1;
    }
}

vig_vehicle_traffic_removal()
{
    level waittill( "remove_civs" );
    maps\_vehicle_traffic::delete_traffic_path( "traffic_lane1" );
    maps\_vehicle_traffic::delete_traffic_path( "traffic_lane2" );
    maps\_vehicle_traffic::delete_traffic_path( "traffic_lane3" );
    maps\_vehicle_traffic::delete_traffic_path( "traffic_lane4" );
}

vig_vehicle_fail_on_death()
{
    level endon( "remove_civs" );

    while ( iscaralive( self ) )
        waitframe();

    setdvar( "ui_deadquote", &"SCRIPT_MISSIONFAIL_CIVILIAN_KILLED" );
    maps\_utility::missionfailedwrapper();
}

iscaralive( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( issubstr( var_0.classname, "corpse" ) )
        return 0;

    return 1;
}

vig_vehicle_removal()
{
    var_0 = getentarray( "intro_vehicles_static", "targetname" );
    level waittill( "remove_civs" );

    foreach ( var_2 in var_0 )
        var_2 delete();

    if ( isdefined( level.intro_reg_vehicles ) )
    {
        foreach ( var_2 in level.intro_reg_vehicles )
            var_2 delete();
    }
}

vig_civ_traffic_init()
{
    level.vig_civ_streetarray = [];
    level.vig_walker_streetarray = [];
    thread vig_civ_traffic_balcony_setup();
    thread vig_civ_traffic_street_setup();
}

vig_civ_traffic_balcony_setup()
{
    var_0 = getent( "balcony_traffic_civ_male", "targetname" );
    var_1 = getent( "balcony_traffic_civ_female", "targetname" );
    var_2 = common_scripts\utility::getstructarray( "civ_vig_loc_male_balcony", "targetname" );
    var_3 = common_scripts\utility::getstructarray( "civ_vig_loc_female_balcony", "targetname" );
    thread vig_civ_traffic_spawn_idle_drones( var_0, var_2 );
    thread vig_civ_traffic_spawn_idle_drones( var_1, var_3 );
}

vig_civ_traffic_street_setup()
{
    var_0 = getent( "street_traffic_civ_male", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "civ_vig_loc_street_lt", "targetname" );
    var_2 = common_scripts\utility::getstructarray( "civ_vig_loc_street_rt", "targetname" );
    thread vig_civ_traffic_spawn_idle_drones( var_0, var_1 );
    thread vig_civ_traffic_spawn_idle_drones( var_0, var_2 );
}

vig_civ_traffic_spawn_idle_drones( var_0, var_1, var_2 )
{
    foreach ( var_4 in var_1 )
    {
        var_5 = var_0 maps\_utility::dronespawn();

        if ( isdefined( var_2 ) )
        {
            if ( maps\_utility::s1_motionset_avaliable() )
                var_5 maps\_drone::drone_set_archetype_idle( "s1_soldier" );
            else
                var_5 maps\_drone::drone_set_archetype_idle( "soldier" );
        }

        level.vig_civ_streetarray = common_scripts\utility::array_add( level.vig_civ_streetarray, var_5 );
        var_0.count = 1;
        var_5.origin = var_4.origin;
        var_5.angles = var_4.angles;
        waitframe();

        if ( isdefined( var_4.animation ) )
            var_5 thread maps\lagos_utility::loopingidleanimation( var_4 );

        var_5 thread vig_civ_removal();
    }
}

vig_civ_fail_on_damage()
{
    self setcandamage( 1 );
    self waittill( "damage" );
    setdvar( "ui_deadquote", &"LAGOS_FAIL_FRIENDLY_FIRE" );
    maps\_utility::missionfailedwrapper();
}

vig_civ_traffic_walker_setup()
{
    var_0 = 10;
    var_1 = [];
    var_2 = getent( "civ_walker_lt_female", "targetname" );
    var_3 = getent( "civ_walker_lt_male", "targetname" );
    var_1 = common_scripts\utility::array_add( var_1, var_2 );
    var_1 = common_scripts\utility::array_add( var_1, var_3 );
    var_4 = common_scripts\utility::getstructarray( "vig_walker_lt_start", "targetname" );
    var_5 = getnodearray( "vig_walker_lt_endpoint", "targetname" );
    thread vig_civ_traffic_spawn_walker_drones( var_1, var_4, var_5, var_0 );
    var_6 = [];
    var_7 = getent( "civ_walker_rt_female", "targetname" );
    var_8 = getent( "civ_walker_rt_male", "targetname" );
    var_6 = common_scripts\utility::array_add( var_6, var_7 );
    var_6 = common_scripts\utility::array_add( var_6, var_8 );
    var_9 = common_scripts\utility::getstructarray( "vig_walker_rt_start", "targetname" );
    var_10 = getnodearray( "vig_walker_rt_endpoint", "targetname" );
    thread vig_civ_traffic_spawn_walker_drones( var_6, var_9, var_10, var_0 );
}

vig_civ_traffic_spawn_walker_drones( var_0, var_1, var_2, var_3 )
{
    foreach ( var_5 in var_1 )
    {
        var_0 = common_scripts\utility::array_randomize( var_0 );
        var_2 = common_scripts\utility::array_randomize( var_2 );
        var_0[0].count = 1;

        if ( level.vig_walker_streetarray.size < var_3 )
        {
            var_6 = var_0[0] maps\_utility::spawn_ai( 1 );
            level.vig_walker_streetarray = common_scripts\utility::array_add( level.vig_walker_streetarray, var_6 );
            var_6.goalradius = 32;
            var_6.ignoreall = 1;
            var_6 forceteleport( var_5.origin, var_5.angles );
            waitframe();
            var_6 setgoalnode( var_2[0] );
            var_6 thread vig_civ_walker_removal();
        }
    }

    thread vig_civ_walker_maintainer( var_0, var_1, var_2, var_3 );
}

vig_civ_walker_maintainer( var_0, var_1, var_2, var_3 )
{
    level endon( "remove_civs" );

    for (;;)
    {
        if ( level.vig_walker_streetarray.size < var_3 )
        {
            var_1 = common_scripts\utility::array_randomize( var_1 );
            var_2 = common_scripts\utility::array_randomize( var_2 );
            var_0 = common_scripts\utility::array_randomize( var_0 );
            var_0[0].count = 1;
            var_4 = var_0[0] maps\_utility::spawn_ai( 1 );
            level.vig_walker_streetarray = common_scripts\utility::array_add( level.vig_walker_streetarray, var_4 );
            var_4.goalradius = 32;
            var_4 forceteleport( var_1[0].origin, var_1[0].angles );
            waitframe();
            var_4 setgoalnode( var_2[0] );
            var_4 thread vig_civ_walker_removal();
        }

        waitframe();
    }
}

vig_civ_model_randomizer()
{
    var_0 = [];
    var_0[0] = "body_africa_civ_male_a";
    var_0[1] = "body_africa_civ_male_b";
    var_0[2] = "body_africa_civ_male_c";
    var_0[3] = "body_india_female_a";
    var_0[4] = "body_india_female_b";
    var_0[5] = "body_london_female_bb";
    var_0[6] = "body_city_civ_male_a";
    var_0[7] = "body_city_civ_female_a";
    var_0 = common_scripts\utility::array_randomize( var_0 );
    return var_0[0];
}

vig_civ_removal()
{
    level waittill( "remove_civs" );
    level.vig_civ_streetarray = common_scripts\utility::array_remove( level.vig_civ_streetarray, self );
    self delete();
}

vig_civ_walker_removal()
{
    self waittill( "goal" );
    level.vig_walker_streetarray = common_scripts\utility::array_remove( level.vig_walker_streetarray, self );
    self delete();
}

vig_mil_balc_setup()
{
    var_0 = getent( "militiaSoldier", "targetname" );
    var_1 = getent( "atlasSoldier", "targetname" );
    var_2 = common_scripts\utility::getstructarray( "mil_vig_loc_soldier", "targetname" );
    var_3 = common_scripts\utility::getstructarray( "mil_vig_loc_soldier2", "targetname" );
    thread vig_civ_traffic_spawn_idle_drones( var_0, var_2, 1 );
    thread vig_civ_traffic_spawn_idle_drones( var_1, var_3, 1 );
}

#using_animtree("generic_human");

vig_bike_rider_init( var_0, var_1 )
{
    if ( !isdefined( var_1 ) || var_1 == 0 )
        var_1 = 1;

    for ( var_2 = 0; var_2 < var_1; var_2++ )
    {
        var_0 = common_scripts\utility::array_randomize( var_0 );
        var_3 = var_0[0];
        var_4 = spawn( "script_model", var_3.origin );
        var_4.angles = var_3.angles;
        var_5 = spawn( "script_model", var_4.origin );

        if ( common_scripts\utility::cointoss() )
            var_5 character\character_civilian_slum_male_aa::main();
        else
            var_5 character\character_civilian_slum_male_ab::main();

        var_5 useanimtree( #animtree );
        var_5 setanim( level.scr_anim["generic"]["bike_rider"] );
        var_6 = randomint( 6 );

        switch ( var_6 )
        {
            case 0:
                var_4 setmodel( "vehicle_scooter_vespa_static_blue" );
                thread vig_bike_rider_scooter( var_4, var_5, var_3 );
                break;
            case 1:
                var_4 setmodel( "vehicle_scooter_vespa_static_green" );
                thread vig_bike_rider_scooter( var_4, var_5, var_3 );
                break;
            case 2:
                var_4 setmodel( "vehicle_scooter_vespa_static_cream" );
                thread vig_bike_rider_scooter( var_4, var_5, var_3 );
                break;
            case 3:
                var_4 setmodel( "vehicle_scooter_vespa_static_lightblue" );
                thread vig_bike_rider_scooter( var_4, var_5, var_3 );
                break;
            case 4:
                vig_bike_rider_cyclist( var_4, var_5, var_3 );
                break;
            case 5:
                vig_bike_rider_cyclist( var_4, var_5, var_3 );
                break;
        }

        wait(randomfloatrange( 2, 5 ));
    }
}

vig_bike_rider_maintainer( var_0, var_1 )
{
    level endon( "remove_bikers" );
    level.bike_riders = [];
    var_2 = common_scripts\utility::getstructarray( var_0, "targetname" );
    thread vig_bike_rider_removal();

    for (;;)
    {
        if ( level.bike_riders.size < var_1 )
        {
            var_3 = var_1 - level.bike_riders.size;
            thread vig_bike_rider_init( var_2, var_3 );
        }

        wait(randomfloatrange( 2, 5 ));
    }
}

vig_bike_rider_scooter( var_0, var_1, var_2 )
{
    var_1.origin = var_0.origin;
    var_1.angles = var_0.angles;
    var_1 linkto( var_0 );
    level.bike_riders = common_scripts\utility::array_add( level.bike_riders, var_1 );
    level.bike_riders = common_scripts\utility::array_add( level.bike_riders, var_0 );
    var_0 thread vig_bike_rider_nav( var_1, var_0, var_2 );
}

vig_bike_rider_cyclist( var_0, var_1, var_2 )
{
    var_0 setmodel( "com_bike_animated" );
    var_0 useanimtree( level.scr_animtree["bike"] );
    var_0 setanim( level.scr_anim["bike"]["pedal"] );
    var_1.origin = var_0 gettagorigin( "j_frame" );
    var_1.origin += ( -12, 0, -30 );
    var_1.angles = var_0 gettagangles( "j_frame" );
    var_1.angles += ( 0, 180, 0 );
    var_1 linkto( var_0, "j_frame" );
    level.bike_riders = common_scripts\utility::array_add( level.bike_riders, var_1 );
    level.bike_riders = common_scripts\utility::array_add( level.bike_riders, var_0 );
    var_0 thread vig_bike_rider_nav( var_1, var_0, var_2 );
}

vig_bike_rider_nav( var_0, var_1, var_2 )
{
    level endon( "remove_bikers" );
    var_3 = 0.0025;

    for (;;)
    {
        var_4 = common_scripts\utility::getstruct( var_2.target, "targetname" );
        var_5 = vig_bike_rider_set_speed( var_2, var_4, var_3 );
        var_6 = vectortoangles( var_2.origin - var_4.origin );

        if ( var_1.model == "com_bike_animated" )
            var_1.angles = ( 0, var_6[1], 0 );
        else
            var_1.angles = ( 0, var_6[1] + 180, 0 );

        var_1 moveto( var_4.origin, var_5, 0, 0 );

        if ( !isdefined( var_4.target ) )
        {
            wait(var_5);
            level.bike_riders = common_scripts\utility::array_remove( level.bike_riders, var_0 );
            level.bike_riders = common_scripts\utility::array_remove( level.bike_riders, var_1 );
            var_1 delete();
            var_0 delete();
            return;
        }

        wait(var_5);
        var_2 = var_4;
    }
}

vig_bike_rider_set_speed( var_0, var_1, var_2 )
{
    var_3 = distance( var_0.origin, var_1.origin );
    var_4 = var_2 * var_3;
    return var_4 + 0.05;
}

vig_bike_rider_removal()
{
    level waittill( "remove_bikers" );

    foreach ( var_1 in level.bike_riders )
        var_1 delete();
}

vig_tram_setup()
{
    var_0 = getent( "anim_monorail", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "intro_tram1" );
    var_1 thread vig_tram_setup_car_fx();
    thread vig_tram_setup_movement( var_1, "tram1_movement", var_0, "tram_shutdown" );
    var_1 soundscripts\_snd::snd_message( "vig_tram_setup_car", 1 );
    common_scripts\utility::flag_wait( "flag_intro_walkway" );
    var_2 = maps\_utility::spawn_anim_model( "intro_tram1" );
    var_2 thread vig_tram_setup_car_fx();
    thread vig_tram_setup_movement( var_2, "tram2_movement", var_0, "tram_shutdown" );
    var_2 soundscripts\_snd::snd_message( "vig_tram_setup_car", 1 );
    common_scripts\utility::flag_wait( "tram_shutdown" );
    var_3 = maps\_utility::spawn_anim_model( "intro_tram1" );
    var_3 thread vig_tram_setup_car_fx();
    thread vig_tram_setup_movement( var_3, "tram3_movement", var_0, undefined );
    var_3 soundscripts\_snd::snd_message( "vig_tram_setup_car", 0, 0.4 );
    common_scripts\utility::flag_wait( "exo_door_trigger" );
    var_2 delete();
    common_scripts\utility::flag_wait( "gov_h_breach_adv2" );
    var_1 delete();
    var_3 delete();
}

vig_tram_setup_movement( var_0, var_1, var_2, var_3 )
{
    var_4 = [ var_0 ];

    if ( isdefined( var_3 ) )
    {
        while ( !common_scripts\utility::flag( var_3 ) )
        {
            var_2 maps\_anim::anim_single( var_4, var_1 );
            wait(randomintrange( 20, 30 ));
        }
    }
    else
    {
        var_2 maps\_anim::anim_single( var_4, var_1 );
        maps\_anim::anim_set_time( var_4, var_1, 1.0 );
        var_0 notify( "tram_shutdown" );
    }
}

vig_tram_setup_car_fx()
{
    self endon( "tram_delete" );
    self endon( "tram_shutdown" );
    var_0 = common_scripts\utility::getfx( "tram_dust" );
    var_1 = common_scripts\utility::getfx( "tram_sparks" );
    playfxontag( var_0, self, "car01" );
    playfxontag( var_0, self, "car02" );
    playfxontag( var_0, self, "car03" );
    playfxontag( var_1, self, "car01" );
    playfxontag( var_1, self, "car02" );
    playfxontag( var_1, self, "car03" );
}

vig_tram_setup_car_shaker( var_0, var_1 )
{
    self endon( "tram_delete" );
    self endon( "tram_shutdown" );

    for (;;)
    {
        var_2 = distance( self.origin, level.player.origin );

        if ( var_2 < var_0 )
        {
            earthquake( 0.4, var_1, self.origin, var_0 );
            wait(var_1);
        }

        waitframe();
    }
}

vig_tram_setup_intro()
{
    var_0 = getent( "anim_org_drone_opening", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "intro_tram1" );
    var_0 maps\_anim::anim_single_solo( var_1, "tram1_flythrough" );
    var_1 delete();
}

squad_intro_walkway_goto()
{
    level waittill( "intro_walkway_go" );
    common_scripts\utility::flag_wait( "flag_intro_walkway" );
    thread squad_exo_door_goto();
}

squad_exo_door_goto()
{
    thread maps\lagos_utility::ally_redirect_goto_node( "Gideon", "exo_door_burke", 1, maps\lagos_utility::disable_awareness );
    thread maps\lagos_utility::ally_redirect_goto_node( "Joker", "exo_door_joker", 1, maps\lagos_utility::disable_awareness );
    thread maps\lagos_utility::ally_redirect_goto_node( "Ajani", "exo_door_ajani", 1, maps\lagos_utility::disable_awareness );
    thread gov_transition_clean_up();
}

gov_transition_clean_up()
{
    common_scripts\utility::flag_wait( "flag_level_progress_exoDoor" );
    level notify( "remove_civs" );
    level notify( "remove_bikers" );
}

exo_door_disable_melee()
{
    level endon( "flag_exo_door_started" );

    for (;;)
    {
        self waittill( "trigger", var_0 );

        if ( isplayer( var_0 ) )
        {
            level.player allowmelee( 0 );
            thread maps\lagos_utility::hint_instant( &"LAGOS_EXO_DOOR_BREACH" );

            while ( common_scripts\utility::flag( "flag_exo_door_trigger" ) )
            {
                if ( level.player meleebuttonpressed() )
                {
                    thread maps\lagos_utility::hint_fade_instant();
                    common_scripts\utility::flag_set( "flag_exo_door_started" );
                    return;
                }

                waitframe();
            }

            level.player allowmelee( 1 );
            thread maps\lagos_utility::hint_fade_instant();
        }
    }
}

exo_door()
{
    level.player endon( "death" );
    var_0 = getent( "exo_door_model", "targetname" );
    var_0 overridematerial( "mtl_lag_exo_door_breach_broken", "mtl_lag_exo_door_breach" );

    if ( level.currentgen )
        var_0 overridematerial( "mq/mtl_lag_exo_door_breach_broken", "mq/mtl_lag_exo_door_breach" );

    var_0.animname = "exo_door_model";
    var_0 maps\_utility::assign_animtree();
    var_1 = getent( "anim_org_exo_door", "targetname" );
    var_1 maps\_anim::anim_first_frame_solo( var_0, "exo_door" );
    var_2 = [ var_0 ];
    common_scripts\utility::flag_wait( "gov_transition_door_close" );
    thread gov_building_firefight_setup();
    thread gov_building_firefight_driveup();
    common_scripts\utility::flag_wait( "flag_irons_videolog_complete" );
    common_scripts\utility::flag_wait( "exo_door_trigger" );
    common_scripts\utility::run_thread_on_targetname( "trigger_player_ready_for_exo_door", ::exo_door_disable_melee );
    var_3 = getent( "exo_door_trigger", "targetname" );
    var_4 = common_scripts\utility::getstruct( "obj_exo_door", "targetname" );
    var_5 = var_3 maps\_shg_utility::hint_button_trigger( "melee", 400 );
    common_scripts\utility::flag_wait( "flag_exo_door_started" );
    var_5 maps\_shg_utility::hint_button_clear();
    var_3 makeunusable();
    level.player maps\_utility::store_players_weapons( "player_weapons" );
    var_6 = maps\_player_exo::player_exo_is_active_single( "shield" );

    if ( var_6 )
        level.player maps\_player_exo::player_exo_remove_single( "shield" );

    level.player takeallweapons();
    soundscripts\_snd::snd_message( "plr_exo_door_kick" );
    common_scripts\utility::flag_set( "obj_progress_exo_door_clear" );
    level notify( "tram_stop" );
    level notify( "gov_driveup_go" );
    wait 0.5;
    common_scripts\utility::flag_set( "exo_door_lighting" );
    common_scripts\utility::flag_set( "done_exo_door_kick" );
    level.player maps\_shg_utility::setup_player_for_scene();
    var_7 = maps\_utility::spawn_anim_model( "player_rig" );
    var_8 = getent( "exo_door_blocker", "targetname" );
    var_8 delete();
    var_1 maps\_anim::anim_first_frame_solo( var_7, "exo_door" );
    var_7 hide();
    var_9 = 0.5;
    level.player playerlinktoblend( var_7, "tag_player", var_9, var_9 * 0.5, var_9 * 0.5 );
    wait(var_9);
    var_7 show();
    level.player playerlinktodelta( var_7, "tag_player", 1, 7, 7, 5, 5, 1 );
    var_2 = common_scripts\utility::array_add( var_2, var_7 );
    thread exo_door_tilt_camera_during_animation( var_7 );
    var_7 common_scripts\utility::delaycall( 3.33333, ::hide );
    var_1 maps\_anim::anim_single( var_2, "exo_door" );
    var_0 overridematerialreset();
    waitframe();
    level.player unlink();
    var_7 delete();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    level.player maps\_utility::restore_players_weapons( "player_weapons" );

    if ( var_6 )
        level.player maps\_player_exo::player_exo_add_single( "shield" );

    level notify( "gov_driveup_started" );
    common_scripts\utility::flag_wait( "vo_government_building_reveal_dialogue" );
    thread maps\lagos_vo::government_building_reveal_dialogue();
    level notify( "nig_mil_start_shoot" );
    maps\_utility::autosave_by_name();
}

exo_door_tilt_camera_during_animation( var_0 )
{
    level.player endon( "death" );
    wait 3.0;
    level.player lerpviewangleclamp( 1, 0.75, 0.25, 45, 45, 0, 0 );
}

gov_building_firefight_init_shooting()
{
    level waittill( "nig_mil_start_shoot" );

    foreach ( var_1 in level.gov_soldiers_front )
        var_1 thread gov_building_ai_timed_shooting();

    foreach ( var_4 in level.gov_kva_soldiers )
        var_4 thread gov_building_ai_timed_shooting();

    foreach ( var_7 in level.gov_soldiers_veh )
        var_7 thread gov_building_ai_timed_shooting();
}

gov_building_mil_devstart_setup()
{
    var_0 = getnode( "tram_bridge_burke", "targetname" );
    level.burke maps\_utility::teleport_ai( var_0 );
    var_1 = getnode( "tram_bridge_joker", "targetname" );
    level.joker maps\_utility::teleport_ai( var_1 );
    var_2 = getnode( "tram_bridge_ajani", "targetname" );
    level.ajani maps\_utility::teleport_ai( var_2 );
    level.burke thread maps\lagos_utility::disable_awareness();
    level.joker thread maps\lagos_utility::disable_awareness();
    level.ajani thread maps\lagos_utility::disable_awareness();
    thread gov_building_exo_climb_goto();
}

gov_building_firefight_setup()
{
    level.gov_soldiers_front = [];
    level.gov_soldiers_veh = [];
    level.gov_kva_soldiers = [];

    if ( !common_scripts\utility::flag( "government_courtyard_playerstart" ) )
        thread gov_building_ally_goto();

    thread gov_building_firefight_roadblock();
    thread gov_building_firefight_front_soldiers();
    thread gov_building_firefight_kva();
    thread gov_roof_breach_anim_chunks();
    level waittill( "firefight_init" );

    foreach ( var_1 in level.alpha_squad_and_player )
        var_1.ignoreall = 1;

    foreach ( var_4 in level.gov_kva_soldiers )
        var_4.ignoreall = 1;

    foreach ( var_7 in level.gov_soldiers_front )
        var_7.ignoreall = 1;

    common_scripts\utility::flag_wait( "gov_driveup_complete" );
    wait 2;
    maps\_utility::activate_trigger( "mil_driveup_trigger", "targetname", level.player );
}

gov_building_firefight_driveup()
{
    level waittill( "gov_driveup_go" );
    thread gov_building_firefight_driveup_explode();
    level.gov_veh_spawners = getentarray( "gov_veh_spawner", "targetname" );

    foreach ( var_1 in level.gov_veh_spawners )
    {
        var_2 = var_1 maps\_utility::spawn_vehicle();
        var_2 soundscripts\_snd::snd_message( "gov_bldg_driveup" );
        var_2 thread gov_building_firefight_removal();
        maps\_vehicle::gopath( var_2 );
        wait(randomfloatrange( 0.75, 1 ));
    }

    if ( level.currentgen )
        wait 0.5;

    level.gov_soldiers_veh = maps\_utility::get_living_ai_array( "gov_building_soldier", "script_noteworthy" );
    var_4 = maps\_utility::get_living_ai_array( "gov_building_soldier_explode", "script_noteworthy" );
    level.gov_soldiers_veh = common_scripts\utility::array_combine( var_4, level.gov_soldiers_veh );

    foreach ( var_6 in level.gov_soldiers_veh )
    {
        var_6 thread gov_building_firefight_removal();
        var_6 thread maps\_utility::magic_bullet_shield( 1 );
        var_6 thread maps\lagos_utility::disable_awareness();
        var_6 thread gov_building_firefight_change_pos();
    }
}

gov_building_firefight_driveup_explode()
{
    wait 2;
    var_0 = getent( "gov_veh_spawner_explode", "targetname" );
    var_1 = var_0 maps\_utility::spawn_vehicle();
    var_1 thread gov_building_firefight_removal();

    if ( level.currentgen )
        var_1 thread tff_cleanup_vehicle( "intro" );

    maps\_vehicle::gopath( var_1 );
    level waittill( "nig_mil_start_shoot" );
    wait 7;
    level notify( "tram_bridge_redirect" );
}

gov_building_firefight_roadblock()
{
    var_0 = getentarray( "gov_road_block_soldier", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = var_2 maps\_utility::spawn_ai( 1 );
        var_3.goalradius = 16;
        var_3 thread maps\_utility::magic_bullet_shield( 1 );
        var_3 thread gov_building_firefight_removal();
        var_3 thread maps\lagos_utility::disable_awareness();

        if ( isdefined( var_3.script_noteworthy ) && var_3.script_noteworthy == "gov_road_block_patrol" )
            var_3 thread gov_road_block_patrol_route();
    }
}

gov_building_firefight_anim_wounded()
{
    var_0 = getent( "drag_wounded_spawner", "targetname" );
    var_1 = getent( "drag_carrier_spawner", "targetname" );
    var_2 = var_0 maps\_utility::spawn_ai( 1 );
    waitframe();
    var_2 maps\_utility::gun_remove();
    var_2.goalradius = 16;
    var_2 thread maps\_utility::magic_bullet_shield( 1 );
    var_2 thread gov_building_firefight_removal();
    var_2 thread maps\lagos_utility::disable_awareness();
    var_2 thread gov_building_firefight_change_pos();
    var_3 = var_1 maps\_utility::spawn_ai( 1 );
    waitframe();
    var_3.goalradius = 16;
    var_3 thread maps\_utility::magic_bullet_shield( 1 );
    var_3 thread gov_building_firefight_removal();
    var_3 thread maps\lagos_utility::disable_awareness();
    var_3 thread gov_building_firefight_change_pos();
}

gov_building_firefight_anim_explode()
{
    level waittill( "nig_mil_start_shoot" );
    var_0 = common_scripts\utility::getstruct( "anim_walk_wounded_org", "targetname" );
    var_1 = maps\_utility::get_living_ai_array( "gov_building_soldier_explode", "script_noteworthy" );
    var_2 = 0;

    foreach ( var_4 in var_1 )
    {
        if ( var_2 == 0 )
            var_4.animname = "prague_walk";
        else
            var_4.animname = "prague_help";

        var_4 maps\jake_tools::invulnerable( 1 );
        var_2++;
    }

    level waittill( "explode_anim_pos" );
    var_0 maps\_anim::anim_single( var_1, "prague_woundwalk" );
    var_6 = [];

    foreach ( var_4 in var_1 )
    {
        if ( isalive( var_4 ) )
            var_6[var_6.size] = var_4;
    }

    var_0 thread maps\_anim::anim_loop( var_6, "prague_woundwalk_help" );
}

gov_fail_on_death()
{
    level endon( "exo_climb_success" );
    level endon( "burke_climb" );
    self waittill( "damage" );

    if ( common_scripts\utility::flag( "roundabout_playerstart" ) || common_scripts\utility::flag( "gov_player_exiting_area" ) )
        return;
    else
    {
        setdvar( "ui_deadquote", &"LAGOS_FAIL_STAY_ON_MISSION" );
        maps\_utility::missionfailedwrapper();
    }
}

gov_building_firefight_kva()
{
    var_0 = getentarray( "kva_gov_building_driveup_enemies", "targetname" );
    var_1 = 1;

    foreach ( var_3 in var_0 )
    {
        var_4 = getnode( var_3.target, "targetname" );
        var_5 = var_3 maps\_utility::spawn_ai( 1 );
        var_5.ignoreall = 1;
        waitframe();
        var_5 maps\_utility::teleport_ai( var_4 );
        var_5 maps\_utility::set_goal_node( var_4 );
        var_5 thread maps\_utility::enable_surprise();
        var_5 thread gov_firefight_detect_breach();
        var_5 thread gov_building_firefight_removal();
        var_5 thread gov_fail_on_death();
        level.gov_kva_soldiers = common_scripts\utility::array_add( level.gov_kva_soldiers, var_5 );

        if ( isdefined( var_5.script_parameters ) && var_5.script_parameters == "front_kva_3" )
        {

        }
        else
            var_5 thread gov_firefight_enemy_reload_anims( var_4 );

        waitframe();
    }

    level notify( "firefight_init" );
    common_scripts\utility::flag_wait( "player_landed_roof_breach" );
}

gov_building_firefight_front_soldiers()
{
    var_0 = getentarray( "militia_drive_start_front", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = var_2 maps\_utility::spawn_ai( 1 );
        var_3.ignoreall = 1;
        var_3.goalradius = 16;
        var_3 thread maps\_utility::magic_bullet_shield( 1 );
        var_3 thread gov_building_firefight_removal();
        level.gov_soldiers_front = common_scripts\utility::array_add( level.gov_soldiers_front, var_3 );
        var_3 thread gov_building_firefight_change_pos();
    }

    level.nigerian_bullhorn = level.gov_soldiers_front[0];
    level.nigerian_bullhorn.animname = "nigerian_army";
}

gov_building_firefight_change_pos()
{
    level.pos_array = getnodearray( "gov_dev_tp_point", "script_noteworthy" );
    level endon( "" );
    level waittill( "start_pos_switching" );

    for (;;)
    {
        level.pos_array = common_scripts\utility::array_randomize( level.pos_array );

        if ( !isnodeoccupied( level.pos_array[0] ) )
        {
            if ( isdefined( self.last_set_goalnode ) && self.last_set_goalnode != level.pos_array[0] )
                level.pos_array = common_scripts\utility::array_add( level.pos_array, self.last_set_goalnode );

            maps\_utility::set_goal_node( level.pos_array[0] );
            level.pos_array = common_scripts\utility::array_remove( level.pos_array, level.pos_array[0] );
            self waittill( "goal" );
            wait(randomintrange( 10, 20 ));
        }
        else
            wait 20;

        waitframe();
    }
}

gov_building_gren_guy()
{
    var_0 = maps\_utility::get_living_ai( "front_mil_gren_guy", "script_noteworthy" );
    var_1 = common_scripts\utility::getstruct( "gren_target", "targetname" );
    magicgrenade( "smoke_grenade_american", var_0.origin, var_1.origin, 1 );
}

gov_building_explode_advance_guys()
{
    var_0 = maps\_utility::get_living_ai( "gov_explode_advance1", "script_noteworthy" );
    var_1 = maps\_utility::get_living_ai( "gov_explode_advance2", "script_noteworthy" );
    var_2 = getnode( "gov_explode_node1", "script_noteworthy" );
    var_3 = getnode( "gov_explode_node2", "script_noteworthy" );
    level waittill( "explode_anim_pos" );
    wait 1;
    var_0 maps\_utility::set_goal_node( var_2 );
    var_1 maps\_utility::set_goal_node( var_3 );
}

gov_building_firefight_turret_settings( var_0 )
{
    self allowedstances( "stand" );
    self.fixednode = 1;
    self.goalradius = 70;
    self.combatmode = "ambush";
    maps\_utility::disable_long_death();
    self setgoalpos( var_0.origin );
    self waittill( "goal" );
    self useturret( var_0 );
    var_0 makeunusable();
    var_0 setturretteam( "axis" );
    var_0 setturretcanaidetach( 0 );
    var_0 setconvergencetime( 3, "yaw" );
    var_0 setconvergencetime( 1.5, "pitch" );
    var_0 setaispread( 5 );
}

gov_firefight_enemy_reload_anims( var_0 )
{
    level endon( "roof_breach_start" );
    self endon( "death" );
    var_1 = getnodearray( "kva_breach_reload_point", "targetname" );
    var_1 = sortbydistance( var_1, self.origin );
    self.animname = "gov_breach";
    self.goalradius = 16;
    maps\_utility::set_allowdeath( 1 );

    for (;;)
    {
        foreach ( var_3 in var_1 )
        {
            if ( !isnodeoccupied( var_3 ) )
            {
                maps\_utility::set_goal_node( var_3 );
                self waittill( "goal" );
                var_3 maps\_anim::anim_single_solo( self, "gov_kva_reload" );
                self.goalradius = 16;
                maps\_utility::set_goal_node( var_0 );
                wait(randomfloatrange( 20, 40 ));
            }

            if ( isnodeoccupied( var_3 ) )
            {
                wait(randomfloatrange( 3, 5 ));
                continue;
            }
        }

        waitframe();
    }
}

gov_firefight_detect_breach()
{
    level waittill( "allies_breached" );
    wait 1.5;
    self stopanimscripted();
    self.ignoreall = 0;

    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "gov_building_kva_soldier" )
    {
        self setthreatbiasgroup();
        var_0 = randomint( level.alpha_squad_and_player.size );
        maps\_utility::set_favoriteenemy( level.alpha_squad_and_player[var_0] );
    }
}

gov_road_block_patrol_route()
{
    self endon( "death" );
    self endon( "road_block_patrol_stop" );
    self.goalradius = 8;
    self.alertlevel = "noncombat";
    maps\_utility::disable_exits();
    maps\_utility::disable_arrivals();
    self.animname = "road_block";
    maps\_utility::set_idle_anim( "patrol_idle" );
    maps\_utility::set_run_anim( "patrol_walk" );
    var_0 = getnodearray( "road_patrol_goal", "targetname" );
    common_scripts\utility::flag_wait( "road_block_patrol_go" );

    for (;;)
    {
        wait(randomfloatrange( 1, 3 ));
        var_0 = common_scripts\utility::array_randomize( var_0 );

        if ( common_scripts\utility::cointoss() )
        {
            maps\_utility::set_goal_node( var_0[0] );
            self waittill( "goal" );
        }
    }
}

gov_building_firefight_removal()
{
    if ( self.code_classname == "script_vehicle" )
    {
        common_scripts\utility::flag_wait_either( "roundabout_playerstart", "gov_player_exiting_area" );
        self delete();
    }
    else
    {
        self endon( "death" );
        common_scripts\utility::flag_wait_either( "roundabout_playerstart", "gov_player_exiting_area" );

        if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "gov_road_block_patrol" )
            self notify( "road_block_patrol_stop" );

        self delete();
    }
}

gov_building_rear_removal()
{
    if ( self.code_classname == "script_vehicle" )
    {
        common_scripts\utility::flag_wait_either( "roundabout_playerstart", "flag_roundabout_move_2" );
        self delete();
    }
    else
    {
        self endon( "death" );
        common_scripts\utility::flag_wait_either( "roundabout_playerstart", "flag_roundabout_move_2" );

        if ( level.currentgen )
        {
            var_0 = getent( "anim_HM_post_breach", "targetname" );
            var_0 notify( "stop_anim_notify" );
        }

        self delete();
    }
}

gov_building_ai_timed_shooting()
{
    self endon( "death" );

    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "gov_building_kva_soldier" )
    {
        self endon( "allies_breached" );
        self endon( "cease_fire_init" );
    }

    if ( common_scripts\utility::array_contains( level.gov_soldiers_front, self ) || common_scripts\utility::array_contains( level.gov_soldiers_veh, self ) )
        self endon( "cease_fire_init" );

    self.grenadeammo = 0;

    for (;;)
    {
        var_0 = randomfloat( 100 );

        if ( self.team == "allies" )
        {
            if ( var_0 < 75 )
            {
                self.ignoreall = 0;
                wait(randomfloatrange( 3, 20 ));
            }
            else
            {
                self.ignoreall = 1;
                wait(randomfloatrange( 2, 5 ));
            }
        }

        if ( self.team == "axis" )
        {
            if ( var_0 < 25 )
            {
                self.ignoreall = 0;
                wait(randomfloatrange( 3, 20 ));
            }
            else
            {
                self.ignoreall = 1;
                wait(randomfloatrange( 2, 5 ));
            }
        }

        waitframe();
    }
}

gov_building_ally_goto()
{
    level waittill( "gov_driveup_started" );
    thread maps\lagos_utility::ally_redirect_goto_node( "Gideon", "gov_overlook_burke" );
    thread maps\lagos_utility::ally_redirect_goto_node( "Joker", "gov_overlook_joker" );
    thread maps\lagos_utility::ally_redirect_goto_node( "Ajani", "gov_overlook_ajani" );
    wait 3;
    thread gov_tram_bridge_ally_goto();
}

gov_tram_bridge_ally_goto()
{
    level waittill( "tram_bridge_redirect" );
    thread gov_building_exo_climb_goto();
    common_scripts\utility::flag_set( "obj_progress_tram_track" );
    thread maps\lagos_utility::ally_redirect_goto_node( "Gideon", "tram_bridge_burke" );
    wait 1;
    thread maps\lagos_utility::ally_redirect_goto_node( "Joker", "tram_bridge_joker" );
    wait 3;
    thread maps\lagos_utility::ally_redirect_goto_node( "Ajani", "tram_bridge_ajani" );
    level.player.ignoreme = 1;
}

gov_building_exo_climb_goto()
{
    if ( !common_scripts\utility::flag( "government_courtyard_playerstart" ) )
        common_scripts\utility::flag_wait( "gov_exo_climb_start" );

    foreach ( var_1 in level.alpha_squad )
        var_1.goalradius = 16;

    level.burke thread gov_building_exo_climb_burke_anims();
    wait 1;
    thread maps\lagos_utility::ally_redirect_goto_node( "Joker", "exo_climb_joker" );
    wait 2;
    thread maps\lagos_utility::ally_redirect_goto_node( "Ajani", "exo_climb_ajani" );
    wait 2;
    level.burke thread gov_building_exo_climb_in_position();
    level.joker thread gov_building_exo_climb_in_position();
    level.ajani thread gov_building_exo_climb_in_position();
}

gov_building_exo_climb_in_position()
{
    thread gov_building_exo_climb_position_counter();
    self waittill( "goal" );
    waitframe();
    level notify( "in_exo_climb_pos" );
}

gov_building_exo_climb_position_counter()
{
    level endon( "exo_climb_pos_set" );
    var_0 = 3;
    var_1 = 0;

    while ( var_1 < var_0 )
    {
        level waittill( "in_exo_climb_pos" );
        var_1++;

        if ( var_1 == var_0 )
        {
            level notify( "exo_climb_pos_set" );
            return;
        }

        waitframe();
    }
}

gov_building_exo_climb_burke_anims()
{
    var_0 = getent( "anim_org_exo_climb_approach", "targetname" );
    thread gov_building_exo_climb_burke_climb( var_0 );

    if ( !common_scripts\utility::flag( "flag_start_mag_climb" ) )
        var_0 maps\_anim::anim_reach_solo( self, "exo_climb_approach", undefined, 1 );

    if ( !common_scripts\utility::flag( "flag_start_mag_climb" ) )
        var_0 maps\_anim::anim_single_solo( self, "exo_climb_approach" );

    if ( !common_scripts\utility::flag( "flag_start_mag_climb" ) )
        var_0 thread maps\_anim::anim_loop_solo( self, "exo_climb_approach_idle", "burke_climb" );
}

gov_building_exo_climb_burke_climb( var_0 )
{
    common_scripts\utility::flag_wait( "flag_start_mag_climb" );
    var_0 notify( "burke_climb" );
    var_1 = getent( "anim_org_exo_climb_gideon", "targetname" );
    level.burke soundscripts\_snd::snd_message( "aud_exo_climb_burke" );
    level.player soundscripts\_snd::snd_message( "exo_climb_pullup_start" );
    var_1 maps\_anim::anim_single_solo( level.burke, "exo_climb_burke" );
    waitframe();
    var_2 = getnode( "gov_breach_goto_burke", "targetname" );
    var_3 = getnode( "gov_breach_goto_joker", "targetname" );
    var_4 = getnode( "gov_breach_goto_ajani", "targetname" );
    level.burke maps\_utility::teleport_ai( var_2 );
    level.joker maps\_utility::teleport_ai( var_3 );
    level.ajani maps\_utility::teleport_ai( var_4 );
}

goverment_building_exoclimb_listen()
{
    level waittill( "exoclimb_start_mount_anim" );
    common_scripts\utility::flag_set( "flag_start_mag_climb" );
}

government_building()
{
    thread gov_roof_breach_sequence();
    thread gov_roof_breach_anim_setup();
    thread gov_building_exo_climb_vo();
    thread gov_building_delete_soft_clip();
    thread goverment_building_exoclimb_listen();
    level.player.exo_climb_overrides = spawnstruct();
    level.player.exo_climb_overrides.idle_look_sideways_limit_mag = 50;
    level.player.exo_climb_overrides.idle_look_down_limit_mag = 20;
    var_0 = getent( "anim_org_exo_climb", "targetname" );
    thread wall_climb_force_dismount( var_0 );
    level.xraywall_on = getentarray( "xraywall_on", "targetname" );
    common_scripts\utility::array_call( level.xraywall_on, ::hide );

    foreach ( var_2 in level.xraywall_on )
    {
        if ( var_2.classname == "script_model" )
            var_2 notsolid();
    }

    var_4 = common_scripts\utility::getstruct( "exo_climb_start_1", "targetname" );
    var_5 = common_scripts\utility::getstruct( "exo_climb_start_2", "targetname" );
    common_scripts\utility::flag_wait( "vo_government_building_mag_exo_dialogue" );
    common_scripts\utility::flag_wait( "flag_start_mag_climb" );
    level notify( "burke_climb" );
    common_scripts\utility::flag_set( "climb_begin_lighting" );
    common_scripts\utility::flag_set( "obj_progress_exo_climb_clear" );
    common_scripts\utility::flag_wait( "flag_end_mag_climb" );
    common_scripts\utility::flag_set( "climb_ending_lighting" );
    thread gov_anims_joker();
    thread gov_anims_ajani();
    maps\_utility::autosave_by_name();
    waitframe();
    level notify( "exo_climb_success" );
    level notify( "wall_pullup_burke_anim_start" );
}

gov_anims_joker()
{
    var_0 = getent( "anim_org_exo_climb", "targetname" );
    var_0 maps\_anim::anim_single_solo( level.joker, "exo_climb_joker" );
    var_0 = getent( "anim_org_govRoof", "targetname" );
    level.joker thread gov_roof_breach_prep_squad_anims( var_0, "joker_in_breach_pos", 1 );
}

gov_anims_ajani()
{
    var_0 = getent( "anim_org_exo_climb", "targetname" );
    var_0 maps\_anim::anim_single_solo( level.ajani, "exo_climb_ajani" );
    var_0 = getent( "anim_org_govRoof", "targetname" );
    level.ajani thread gov_roof_breach_prep_squad_anims( var_0, "ajani_in_breach_pos", 1 );
}

gov_building_delete_soft_clip()
{
    common_scripts\utility::flag_wait( "delete_soft_clip_gov_building_landing_from_rail" );
    wait 0.5;
}

wall_climb_force_dismount( var_0 )
{
    common_scripts\utility::flag_wait( "flag_end_mag_climb" );
    var_1 = "player_rig";
    var_2 = "exo_climb_pullup_exit";
    level.scr_goaltime["player_rig"]["exo_climb_pullup_exit"] = 0.7;
    maps\_exo_climb::force_animated_dismount( var_0, var_1, var_2 );
    level notify( "mag_climb_complete" );
}

wall_pullup_burke_anim_start( var_0 )
{
    level notify( "wall_pullup_burke_anim_start" );
}

gov_building_exo_climb_vo()
{
    common_scripts\utility::flag_wait( "vo_government_building_mag_exo_dialogue" );
    thread maps\lagos_vo::government_building_mag_exo_dialogue();
}

gov_roof_breach_sequence()
{
    level waittill( "exo_climb_success" );
    thread gov_hostage_approach();
    level waittill( "cease_fire_init" );

    foreach ( var_1 in level.alpha_squad_and_player )
        var_1.ignoreme = 1;

    foreach ( var_4 in level.gov_soldiers_veh )
        var_4 thread maps\lagos_utility::disable_awareness();

    foreach ( var_4 in level.gov_soldiers_front )
        var_4 thread maps\lagos_utility::disable_awareness();

    level waittill( "gov_breach_init" );

    foreach ( var_9 in level.gov_kva_soldiers )
    {

    }

    thread gov_roof_breach_success_monitor();
    thread gov_roof_breach_kill_assignment();
    level waittill( "allies_breached" );
    wait 1.5;

    foreach ( var_1 in level.alpha_squad_and_player )
        var_1.ignoreme = 0;
}

gov_roof_breach_anim_chunks()
{
    var_0 = getent( "roof_breach_chunks", "targetname" );
    var_1 = getent( "anim_org_govRoof", "targetname" );
    var_0.animname = "rooftop_chunks";
    var_0 maps\_utility::assign_animtree();
    var_1 maps\_anim::anim_first_frame_solo( var_0, "roof_mute_breach_plant" );
    level waittill( "roof_breach_start" );
    var_1 maps\_anim::anim_single_solo( var_0, "roof_mute_breach_plant" );
    var_1 maps\_anim::anim_last_frame_solo( var_0, "roof_mute_breach_plant" );
}

gov_roof_breach_anim_setup()
{
    thread gov_roof_breach_marker_setup();
    thread gov_roof_breach_roof_destruction();
    level waittill( "exo_climb_success" );
    var_0 = getent( "anim_org_govRoof", "targetname" );
    level.burke thread gov_roof_breach_prep_squad_anims( var_0, "burke_in_breach_pos", 0 );
    common_scripts\utility::flag_set( "obj_progress_roof_breach_goto" );
    thread maps\lagos_vo::government_building_roof_breach_dialogue();
    thread gov_roof_breach_to_hbreach_vo();
    level notify( "in_breach_pos" );
    common_scripts\utility::flag_wait( "flag_roof_charge_planted" );
    level notify( "roof_breach_start" );
    common_scripts\utility::flag_set( "gov_breach_start_lighting" );
    common_scripts\utility::flag_set( "done_roof_breach_start" );
    common_scripts\utility::flag_set( "obj_progress_roof_breach_clear" );
    level.player maps\_shg_utility::setup_player_for_scene();
    var_1 = maps\_utility::spawn_anim_model( "player_rig", level.player.origin );
    var_2 = maps\_utility::spawn_anim_model( "mute_breach_device", var_0.origin );
    var_3 = maps\_utility::spawn_anim_model( "roof_breach_device", var_0.origin );
    var_4 = [ level.burke, var_2, var_3 ];
    var_5 = [ level.joker, level.ajani ];
    var_0 maps\_anim::anim_first_frame_solo( var_1, "roof_mute_breach_plant" );
    var_2 soundscripts\_snd::snd_message( "gov_building_mute_device" );
    var_1 hide();
    var_6 = 0.5;
    level.player playerlinktoblend( var_1, "tag_player", var_6, var_6 * 0.5, var_6 * 0.5 );
    wait(var_6);
    var_1 show();
    level.player playerlinktodelta( var_1, "tag_player", 1, 7, 7, 5, 5, 1 );
    level.burke maps\_utility::place_weapon_on( level.burke.primaryweapon, "chest" );
    var_0 maps\_anim::anim_first_frame( var_4, "roof_mute_breach_plant" );
    var_0 thread maps\_anim::anim_single_solo( var_1, "roof_mute_breach_plant" );
    var_0 thread maps\_anim::anim_single( var_4, "roof_mute_breach_plant" );
    wait 0.25;
    var_0 thread maps\_anim::anim_single( var_5, "roof_mute_breach_plant" );
    var_7 = 1;

    foreach ( var_9 in level.gov_kva_soldiers )
    {
        var_10 = var_9.script_parameters;
        var_9.animname = var_10;

        if ( var_9.animname != "front_kva_5" && var_9.animname != "front_kva_6" )
        {
            var_9.health = 1;
            var_9 thread gov_roof_breach_enemy_react_anims( var_0 );
            var_0 thread maps\_anim::anim_single_solo( var_9, "roof_breach_enemy_react" );
        }
    }

    wait 10.5;
    wait 1;
    level notify( "destroy_roof" );
    var_3 delete();
    thread gov_roof_breach_enable_player_invul();
    thread gov_roof_breach_end_slomo();
    wait 1.7;
    level.player enableweapons();
    wait 0.3;
    level notify( "allies_breached" );
    var_12 = rooftop_anim_length();
    var_0 thread maps\_anim::anim_single_solo( level.burke, "roof_mute_breach_jumpdown" );
    var_0 thread maps\_anim::anim_single_solo( level.joker, "roof_mute_breach_jumpdown", undefined, 2 );
    var_0 thread maps\_anim::anim_single_solo( level.ajani, "roof_mute_breach_jumpdown" );
    var_0 thread maps\_anim::anim_single_solo( var_1, "roof_mute_breach_jumpdown" );
    var_13 = 0.3;
    var_12 -= var_13;
    wait(var_13);
    level.player playersetgroundreferenceent( var_1 );
    level.player playersetgroundreferenceent( undefined );
    level.player playerlinktodelta( var_1, "tag_player", 0, 60, 20, 30, 30, 0 );
    wait(var_12);
    common_scripts\utility::flag_set( "player_landed_roof_breach" );
    var_14 = common_scripts\utility::getstruct( "roof_breach_joker_tp", "targetname" );
    level.joker forceteleport( var_14.origin, var_14.angles );
    level.player unlink();
    var_1 delete();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    level notify( "player_landed_roof_breach" );
    maps\_utility::autosave_by_name();
    common_scripts\utility::flag_set( "obj_progress_h_breach_goto" );
    level.burke maps\_utility::place_weapon_on( level.burke.primaryweapon, "right" );
}

gov_roof_breach_marker_setup()
{
    var_0 = getent( "mute_breach_obj_prop", "targetname" );
    var_1 = spawn( "script_model", ( 0, 0, 0 ) );
    var_1 setmodel( "mutecharge_obj" );
    var_1.angles = var_0.angles;
    var_1.origin = var_0.origin;
    level waittill( "exo_climb_success" );
    var_2 = getent( "gov_breach_trigger", "targetname" );
    var_3 = var_2 maps\_shg_utility::hint_button_trigger( "x", 400 );
    var_2 sethintstring( &"LAGOS_ROOF_MUTE_CHARGE" );
    var_2 waittill( "trigger", var_4 );
    var_3 maps\_shg_utility::hint_button_clear();
    var_2 sethintstring( "" );
    var_2 makeunusable();
    common_scripts\utility::flag_set( "flag_roof_charge_planted" );
    level waittill( "roof_breach_start" );
    wait 0.4;

    if ( isdefined( var_1 ) )
        var_1 delete();
}

gov_roof_breach_start_slowmo( var_0 )
{
    soundscripts\_snd::snd_message( "rooftop_slo_mo_override" );
    setslowmotion( 1, 0.15, 0.3 );
}

gov_roof_breach_end_slomo()
{
    level waittill( "breach_success" );
    setslowmotion( 0.15, 1, 0.8 );
}

#using_animtree("player");

rooftop_anim_length()
{
    var_0 = getanimlength( %lag_roof_breach_jumpdown_vm );
    return var_0;
}

#using_animtree("generic_human");

gov_roof_breach_enemy_react_anims( var_0 )
{
    self.allowdeath = 1;

    switch ( self.script_parameters )
    {
        case "front_kva_1":
            self.deathanim = %lag_roof_breach_react_death_guy1;
            self waittill( "damage" );
            self.ignoreme = 1;
            break;
        case "front_kva_2":
            self.deathanim = %lag_roof_breach_react_death_guy2;
            self waittill( "damage" );
            self.ignoreme = 1;
            break;
        case "front_kva_3":
            self.deathanim = %lag_roof_breach_react_death_guy3;
            self waittill( "damage" );
            self.ignoreme = 1;
            break;
        case "front_kva_4":
            self.deathanim = %lag_roof_breach_react_death_guy4;
            self waittill( "damage" );
            self.ignoreme = 1;
            break;
        case "front_kva_5":
            var_1 = getnode( "front_kva_5_goal", "targetname" );
            maps\_utility::teleport_ai( var_1 );
            maps\_utility::set_goal_node( var_1 );
            break;
        case "front_kva_6":
            var_1 = getnode( "front_kva_5_goal", "targetname" );
            maps\_utility::teleport_ai( var_1 );
            maps\_utility::set_goal_node( var_1 );
            break;
    }
}

gov_roof_breach_enable_player_invul()
{
    level endon( "end_shoot_dudes" );
    level.player enableinvulnerability();
    level waittill( "player_landed_roof_breach" );
    level.player disableinvulnerability();
}

gov_roof_breach_multi_kill( var_0 )
{
    var_1 = common_scripts\utility::getstructarray( "magic_bullet_loc", "targetname" );
    var_1 = common_scripts\utility::array_randomize( var_1 );
    thread multi_sync_kills( level.gov_kva_soldiers, var_1 );
}

multi_sync_kills( var_0, var_1 )
{
    level.target_array = var_0;
    level.shoot_point_array = var_1;

    while ( level.target_array.size > 0 )
    {
        level.target_array = maps\_utility::array_removedead_or_dying( level.target_array );

        if ( isalive( level.target_array[0] ) )
        {
            var_2 = level.target_array[0];
            var_3 = level.shoot_point_array[0];
            level.target_array = common_scripts\utility::array_remove( level.target_array, level.target_array[0] );
            level.shoot_point_array = common_scripts\utility::array_remove( level.shoot_point_array, level.shoot_point_array[0] );
            thread multi_sync_kill_shooter( var_2, var_3 );
        }

        waitframe();
    }
}

multi_sync_kill_shooter( var_0, var_1 )
{
    var_0.maxhealth = 1;
    var_0.health = 1;
    var_2 = var_0 gettagorigin( "TAG_EYE" );

    while ( isalive( var_0 ) )
    {
        if ( !isdefined( var_1 ) )
        {
            waitframe();
            continue;
        }

        magicbullet( "iw5_bal27_sp", var_1.origin, var_2 );
        wait(randomfloatrange( 0.07, 0.1 ));
    }

    level.shoot_point_array = common_scripts\utility::array_add( level.shoot_point_array, var_1 );
    level.shoot_point_array = common_scripts\utility::array_randomize( level.shoot_point_array );
}

gov_roof_breach_prep_squad_anims( var_0, var_1, var_2 )
{
    if ( isdefined( var_2 ) && var_2 )
    {
        maps\_utility::enable_cqbwalk();
        var_0 maps\_anim::anim_reach_solo( self, "roof_mute_breach_goto" );
    }

    var_0 maps\_anim::anim_single_solo( self, "roof_mute_breach_goto" );

    if ( !common_scripts\utility::flag( "done_roof_breach_start" ) )
    {
        var_0 thread maps\_anim::anim_loop_solo( self, "roof_mute_breach_idle", "roof_breach_start" );
        self.allowdeath = 1;
        level waittill( "roof_breach_start" );
        waitframe();
        var_0 notify( "roof_breach_start" );
    }
}

gov_roof_breach_roof_destruction()
{
    var_0 = getentarray( "mute_breach_brush", "targetname" );
    var_1 = getentarray( "mute_breach_brush_damage", "targetname" );
    common_scripts\utility::array_call( var_1, ::hide );
    common_scripts\utility::array_call( var_1, ::notsolid );
    level waittill( "destroy_roof" );
}

notetrack_swap_roof_brush( var_0 )
{
    var_1 = getentarray( "mute_breach_brush", "targetname" );
    var_2 = getentarray( "mute_breach_brush_damage", "targetname" );
    common_scripts\utility::array_call( var_1, ::delete );
    common_scripts\utility::array_call( var_2, ::show );
    common_scripts\utility::array_call( var_2, ::solid );
}

gov_roof_breach_kill_assignment()
{
    while ( !common_scripts\utility::flag( "player_landed_roof_breach" ) )
        waitframe();

    level notify( "end_shoot_dudes" );

    foreach ( var_1 in level.alpha_squad )
        var_1 thread gov_roof_breach_elim_setting_on();

    level.gov_kva_soldiers = common_scripts\utility::array_randomize( level.gov_kva_soldiers );
    level.burke thread gov_roof_breach_elim_guy( level.gov_kva_soldiers );
    waitframe();
    level.joker thread gov_roof_breach_elim_guy( level.gov_kva_soldiers );
    waitframe();
    level.ajani thread gov_roof_breach_elim_guy( level.gov_kva_soldiers );
    waitframe();

    foreach ( var_1 in level.alpha_squad )
        var_1 thread gov_roof_breach_elim_setting_off();
}

gov_roof_breach_elim_guy( var_0 )
{
    self endon( "breach_success" );

    foreach ( var_2 in level.gov_kva_soldiers )
    {
        var_2.maxhealth = 1;
        var_2.health = 1;
        var_2.dontattackme = undefined;

        if ( isalive( var_2 ) && !isdefined( var_2.attacker ) )
        {
            self.favoriteenemy = var_2;
            var_2.attacker = self;
        }
    }
}

gov_roof_breach_elim_setting_on()
{
    self.alertlevel = "combat";
    maps\_utility::disable_dontevershoot();
    self.ignoreall = 0;
    self.baseaccuracy = 5000;
}

gov_roof_breach_elim_setting_off()
{
    self.favoriteenemy = undefined;
    self.alertlevel = "noncombat";
    maps\_utility::enable_dontevershoot();
    self.ignoreall = 1;
    self.baseaccuracy = 1;
}

gov_roof_breach_success_monitor()
{
    level endon( "breach_success" );

    for (;;)
    {
        level.gov_kva_soldiers = maps\_utility::array_removedead_or_dying( level.gov_kva_soldiers );

        if ( level.gov_kva_soldiers.size == 0 )
        {
            gov_roof_breach_elim_setting_off();
            level notify( "breach_success" );
        }

        waitframe();
    }
}

gov_hostage_h_breach_doors()
{
    level.h_breach_doors = getent( "h_breach_doors", "targetname" );
    level.h_breach_doors.animname = "h_breach_doors";
    level.h_breach_doors maps\_utility::assign_animtree();
    var_0 = getent( "anim_HM_post_breach", "targetname" );
    var_0 thread maps\_anim::anim_first_frame_solo( level.h_breach_doors, "h_breach_pt1" );
    level.h_breach_doors waittill( "anim_breach_complete" );
    var_0 thread maps\_anim::anim_last_frame_solo( level.h_breach_doors, "h_breach_pt1" );
}

gov_hostage_approach()
{
    level waittill( "breach_success" );
    common_scripts\utility::flag_set( "obj_progress_h_breach_goto" );
    thread gov_rear_setup();
    thread gov_hostage_breach_setup();
    wait 2;
    level.burke allowedstances( "crouch", "stand" );
    level.joker allowedstances( "crouch", "stand" );
    level.ajani allowedstances( "crouch", "stand" );
    level.burke maps\_utility::enable_cqbwalk();
    level.joker maps\_utility::enable_cqbwalk();
    level.ajani maps\_utility::enable_cqbwalk();
    level.burke thread gov_hostage_approach_redirect();
    level.joker thread gov_hostage_approach_redirect();
    level.ajani thread gov_hostage_approach_redirect();
    common_scripts\utility::flag_clear( "gov_h_breach_adv1" );
    common_scripts\utility::flag_wait( "gov_h_breach_adv1" );
    thread maps\lagos_utility::ally_redirect_goto_node( "Gideon", "gov_h_breach_burke" );
    thread maps\lagos_utility::ally_redirect_goto_node( "Joker", "gov_h_breach_joker" );
    thread maps\lagos_utility::ally_redirect_goto_node( "Ajani", "gov_h_breach_ajani" );
    common_scripts\utility::flag_clear( "gov_h_breach_init" );
    level notify( "h_breach_prep" );
    common_scripts\utility::flag_wait( "flag_h_breach_started" );
    common_scripts\utility::flag_set( "obj_progress_h_breach_clear" );
    common_scripts\utility::flag_set( "done_gov_building_h_breach_start" );
    common_scripts\utility::flag_set( "begin_harmonic_breach_lighting" );
    level notify( "h_breach_anim_init" );
    thread maps\lagos_vo::harmonic_breach_start_dialogue();
    wait 2;
    level.anim_org_ajani_post_breach = getent( "anim_HM_post_breach", "targetname" );
    level.anim_org_ajani_post_breach maps\_anim::anim_loop_solo( level.ajani, "h_breach_pre_idle", "end_pre_idle" );
}

gov_roof_breach_to_hbreach_vo()
{
    common_scripts\utility::flag_wait( "flag_roof_breach_mute_complete" );
    thread maps\lagos_vo::government_building_interior_dialogue();
}

gov_hostage_approach_redirect()
{
    switch ( self.script_friendname )
    {
        case "Gideon":
            thread maps\lagos_utility::ally_redirect_goto_node( "Gideon", "gov_hostage_0_burke" );
            wait 5;
            thread maps\lagos_utility::ally_redirect_goto_node( "Gideon", "gov_hostage_1_burke" );
            break;
        case "Joker":
            thread maps\lagos_utility::ally_redirect_goto_node( "Joker", "gov_hostage_1_joker" );
            break;
        case "Ajani":
            wait 2;
            thread maps\lagos_utility::ally_redirect_goto_node( "Ajani", "gov_hostage_0_ajani" );
            wait 5;
            thread maps\lagos_utility::ally_redirect_goto_node( "Ajani", "gov_hostage_1_ajani" );
            break;
    }
}

gov_hostage_breach_in_pos( var_0, var_1, var_2 )
{
    wait(var_0);
    var_1 maps\_anim::anim_reach_solo( self, var_2 );
    var_1 thread maps\_anim::anim_loop_solo( self, var_2, "h_breach_anim_init" );
}

gov_hostage_breach_anim_idler()
{
    var_0 = [];
    var_0[0] = "cqb_idle";
    var_0[1] = "cqb_idle1";
    var_0[2] = "cqb_idle2";
    var_0[3] = "cqb_idle3";
    var_0[4] = "cqb_idle4";
    var_1 = common_scripts\utility::random( var_0 );
    return var_1;
}

fail_trigger_move_on_notify( var_0 )
{
    level waittill( var_0 );
    self.origin += ( 0, 0, -10000 );
}

gov_hostage_breach_fail_trigger()
{
    level endon( "h_breach_anim_init" );
    var_0 = getent( "trig_harmonic_breach_damage_fail_trigger", "targetname" );
    var_0 thread fail_trigger_move_on_notify( "h_breach_anim_init" );

    for (;;)
    {
        var_0 waittill( "damage", var_1, var_2, var_3, var_4, var_5 );

        if ( var_2 == level.player && !issubstr( var_5, "MELEE" ) )
        {
            setdvar( "ui_deadquote", &"LAGOS_HBREACH_FAILED" );
            maps\_utility::missionfailedwrapper();
        }
    }
}

gov_hostage_breach_fail_miss_trigger()
{
    level endon( "BreachComplete" );
    level endon( "missionfailed" );
    var_0 = getent( "trig_harmonic_breach_miss_fail_trigger", "targetname" );

    for (;;)
    {
        var_0 waittill( "damage", var_1, var_2, var_3, var_4, var_5 );

        if ( var_2 == level.player && !issubstr( var_5, "MELEE" ) )
        {
            wait 3;
            level notify( "BreachFailed" );
        }
    }
}

gov_hostage_breach_setup()
{
    if ( common_scripts\utility::flag( "pre_h_breach_playerstart" ) )
    {
        level.pre_h_breach_burke_start = common_scripts\utility::getstruct( "gov_hostage_4_burke", "targetname" );
        level.pre_h_breach_joker_start = common_scripts\utility::getstruct( "gov_hostage_4_joker", "targetname" );
        level.pre_h_breach_ajani_start = common_scripts\utility::getstruct( "gov_hostage_4_ajani", "targetname" );
        level.burke teleport( level.pre_h_breach_burke_start.origin, level.pre_h_breach_burke_start.angles );
        level.joker teleport( level.pre_h_breach_joker_start.origin, level.pre_h_breach_joker_start.angles );
        level.ajani teleport( level.pre_h_breach_ajani_start.origin, level.pre_h_breach_ajani_start.angles );
        thread maps\lagos_utility::ally_redirect_goto_node( "Gideon", "gov_h_breach_burke" );
        thread maps\lagos_utility::ally_redirect_goto_node( "Joker", "gov_h_breach_joker" );
        thread maps\lagos_utility::ally_redirect_goto_node( "Ajani", "gov_h_breach_ajani" );
    }

    thread gov_hostage_breach_anim_setup();
    thread gov_hostage_breach_post_anim_setup();
    thread gov_hostage_breach_fail_trigger();
    level waittill( "h_breach_start" );
    soundscripts\_snd::snd_message( "hb_sensor_flash_on" );

    if ( common_scripts\utility::flag( "pre_h_breach_playerstart" ) )
    {
        level.pre_h_breach_burke_start notify( "h_breach_start" );
        level.pre_h_breach_joker_start notify( "h_breach_start" );
        level.pre_h_breach_ajani_start notify( "h_breach_start" );
    }

    thread maps\lagos_h_breach::startharmonicbreach( level.alpha_squad );
    thread maps\lagos_vo::harmonic_breach_timer_warning_dialogue();
}

gov_hostage_breach_anim_setup()
{
    thread gov_hostage_breach_marker_setup();
    level waittill( "h_breach_anim_init" );
    var_0 = getent( "anim_HM_breach", "targetname" );
    level.player maps\_shg_utility::setup_player_for_scene();
    var_1 = maps\_utility::spawn_anim_model( "player_arms", level.player.origin );
    soundscripts\_snd::snd_message( "hb_gun_away" );
    var_0 maps\_anim::anim_first_frame_solo( var_1, "h_breach" );
    var_1 hide();
    var_2 = 0.5;
    level.player playerlinktoblend( var_1, "tag_player", var_2, var_2 * 0.5, var_2 * 0.5 );
    wait(var_2);
    var_1 show();
    level.player playerlinktodelta( var_1, "tag_player", 1, 7, 7, 5, 5, 1 );
    var_3 = maps\_utility::spawn_anim_model( "h_breach_device", var_0.origin );
    var_4 = getent( "harmonic_breach_lighting_centroid", "targetname" );
    var_3 overridelightingorigin( var_4.origin );
    var_5 = [ var_1, var_3, level.joker ];
    var_0 maps\_anim::anim_single( var_5, "h_breach" );
    level.player unlink();
    var_1 delete();
    var_6 = getent( "harmonic_breach_player_blocker", "targetname" );
    var_6 solid();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    level notify( "h_breach_start" );
    maps\_utility::autosave_by_name();
    level waittill( "BreachComplete" );
    level thread maps\lagos_fx::harmonic_breach_flash_off();
    var_6 notsolid();
    common_scripts\utility::flag_set( "flag_h_breach_complete" );
}

gov_hostage_breach_marker_setup()
{
    var_0 = getent( "h_breach_obj_prop", "targetname" );
    var_1 = spawn( "script_model", ( 0, 0, 0 ) );
    var_1 setmodel( "lag_harmonic_breach_device_obj" );
    var_1.angles = var_0.angles;
    var_1.origin = var_0.origin;
    level waittill( "h_breach_prep" );
    var_2 = var_1 common_scripts\utility::spawn_tag_origin();
    var_2.origin += ( 0, 0, 8 );
    var_3 = getent( "gov_h_breach_trigger", "targetname" );
    var_4 = var_3 maps\_shg_utility::hint_button_trigger( "x", 400 );
    var_3 sethintstring( &"LAGOS_PLACE_SENSOR" );
    var_3 waittill( "trigger", var_5 );
    common_scripts\utility::flag_set( "flag_h_breach_started" );
    thread gov_hostage_breach_fail_miss_trigger();
    level waittill( "h_breach_anim_init" );
    var_4 maps\_shg_utility::hint_button_clear();
    var_3 sethintstring( "" );
    wait 0.4;

    if ( isdefined( var_1 ) )
        var_1 delete();
}

gov_hostage_breach_post_anim_setup()
{
    var_0 = [];
    var_1 = getent( "anim_HM_post_breach", "targetname" );

    if ( common_scripts\utility::flag( "post_h_breach_playerstart" ) )
    {
        level.post_h_breach_burke_start = common_scripts\utility::getstruct( "gov_hostage_4_burke", "targetname" );
        level.post_h_breach_joker_start = common_scripts\utility::getstruct( "gov_hostage_4_joker", "targetname" );
        level.post_h_breach_ajani_start = common_scripts\utility::getstruct( "gov_hostage_4_ajani", "targetname" );
        level.burke teleport( level.post_h_breach_burke_start.origin, level.post_h_breach_burke_start.angles );
        level.joker teleport( level.post_h_breach_joker_start.origin, level.post_h_breach_joker_start.angles );
        level.ajani teleport( level.post_h_breach_ajani_start.origin, level.post_h_breach_ajani_start.angles );
        thread maps\lagos_utility::ally_redirect_goto_node( "Gideon", "gov_h_breach_burke" );
        thread maps\lagos_utility::ally_redirect_goto_node( "Joker", "gov_h_breach_joker" );
        thread maps\lagos_utility::ally_redirect_goto_node( "Ajani", "gov_h_breach_ajani" );
    }

    level waittill( "BreachComplete" );
    wait 1;
    thread h_breach_blockers_delete();

    if ( common_scripts\utility::flag( "post_h_breach_playerstart" ) )
    {
        level.post_h_breach_burke_start notify( "breach_done" );
        level.post_h_breach_joker_start notify( "breach_done" );
        level.post_h_breach_ajani_start notify( "breach_done" );
        level.burke maps\_utility::anim_stopanimscripted();
        level.joker maps\_utility::anim_stopanimscripted();
        level.ajani maps\_utility::anim_stopanimscripted();
    }

    var_2 = maps\_utility::array_spawn_targetname( "kva_hostage_execution" );
    var_3 = 3;

    foreach ( var_5 in var_2 )
    {
        var_5.animname = "hostage_" + var_3;
        var_3++;
        var_5 thread gov_building_rear_removal();
        var_5.weapon = "none";
        var_5.ignoreall = 1;
        var_5.ignoreme = 1;
    }

    var_7 = getent( "kva_hostage_victim", "targetname" );
    var_8 = var_7 maps\_utility::spawn_ai( 1 );
    var_8.animname = "hostage_1";
    var_8 thread gov_building_rear_removal();
    var_8 maps\_utility::gun_remove();
    var_8.ignoreall = 1;
    var_8.ignoreme = 1;
    var_8 setcontents( 0 );
    var_8 character\gfl\character_gfl_suomi::main();
    var_9 = getent( "kva_hostage_minister", "targetname" );
    var_10 = var_9 maps\_utility::spawn_ai( 1 );
    var_10.animname = "hostage_2";
    var_10 thread gov_building_rear_removal();
    var_10 maps\_utility::gun_remove();
    var_10.ignoreall = 1;
    var_10.ignoreme = 1;
    // var_10.name = "Prime Minister";
    var_10 maps\_utility::set_friendlyfire_warnings( 1 );
    var_10.allowdeath = 1;
    var_10.health = 1;
    var_11 = common_scripts\utility::getstruct( "intro_beatup_hostage_org", "targetname" );
    var_12 = getent( "kva_hostage_beatup", "targetname" );
    var_13 = var_12 maps\_utility::spawn_ai( 1 );
    var_13.animname = "hostage_6";
    var_13 thread gov_building_rear_removal();
    var_13 maps\_utility::gun_remove();
    var_13.ignoreall = 1;
    var_13.ignoreme = 1;
    var_14 = getent( "kva_hostage_leader_post_pcap", "targetname" );
    var_15 = var_14 maps\_utility::spawn_ai( 1 );
    var_15.animname = "kva_1";
    var_15.ignoreall = 1;
    var_15.ignoreme = 1;
    var_15 thread maps\_utility::deletable_magic_bullet_shield();
    var_15 setcontents( 0 );
    var_15 thread gov_building_rear_removal();
    var_15 disableaimassist();
    var_16 = getent( "kva_guard_beatup", "targetname" );
    var_17 = var_16 maps\_utility::spawn_ai( 1 );
    var_17.animname = "kva_2";
    var_17.ignoreall = 1;
    var_17.ignoreme = 1;
    var_17 thread maps\_utility::deletable_magic_bullet_shield();
    var_17 setcontents( 0 );
    var_17 thread gov_building_rear_removal();
    var_17 disableaimassist();
    var_18 = getent( "kva_guard_corner", "targetname" );
    var_19 = var_18 maps\_utility::spawn_ai( 1 );
    var_19.animname = "kva_3";
    var_19.ignoreall = 1;
    var_19.ignoreme = 1;
    var_19 thread maps\_utility::deletable_magic_bullet_shield();
    var_19 setcontents( 0 );
    var_19 thread gov_building_rear_removal();
    var_19 disableaimassist();
    var_20 = getent( "kva_pm_guard", "targetname" );
    var_21 = var_20 maps\_utility::spawn_ai( 1 );
    var_21.animname = "kva_4";
    var_21.ignoreall = 1;
    var_21.ignoreme = 1;
    var_21 thread maps\_utility::deletable_magic_bullet_shield();
    var_21 setcontents( 0 );
    var_21 thread gov_building_rear_removal();
    var_21 disableaimassist();
    var_22 = maps\_utility::spawn_anim_model( "pm_cuffs" );
    var_22 maps\_utility::assign_animtree();
    var_23 = maps\_utility::spawn_anim_model( "vic_cuffs" );
    var_23 maps\_utility::assign_animtree();

    if ( isdefined( var_21 ) )
        var_21 maps\_utility::pretend_to_be_dead();

    if ( isdefined( var_15 ) )
        var_15 maps\_utility::pretend_to_be_dead();

    if ( isdefined( var_17 ) )
        var_17 maps\_utility::pretend_to_be_dead();

    if ( isdefined( var_19 ) )
        var_19 maps\_utility::pretend_to_be_dead();

    level.ajani thread gov_hostage_breach_give_radio();
    common_scripts\utility::flag_set( "harmonic_complete_lighting" );
    thread maps\lagos_vo::harmonic_breach_complete_dialogue();
    thread gov_hostage_player_scan( var_1, var_22 );
    thread restrict_movement_while_releasing_the_pm();
    thread maps\lagos_vo::pcap_pm_rescue();
    thread maps\lagos_fx::env_effects_hostage_room();

    if ( isdefined( level.anim_org_ajani_post_breach ) )
        level.anim_org_ajani_post_breach notify( "end_pre_idle" );

    thread gov_hostage_breach_actor_anims_straight_to_idle( var_1, var_2[0], "h_breach_pt1", "h_breach_post", "stop_anim_notify", "h_breach_pt2" );
    thread gov_hostage_breach_actor_anims_straight_to_idle( var_1, var_2[1], "h_breach_pt1", "h_breach_post", "stop_anim_notify", "h_breach_pt2" );
    thread gov_hostage_breach_actor_anims_straight_to_idle( var_1, var_2[2], "h_breach_pt1", "h_breach_post", "stop_anim_notify", "h_breach_pt2" );
    thread gov_hostage_breach_actor_anims_straight_to_idle( var_1, var_13, "h_breach_pt1", "h_breach_post", "stop_anim_notify", "h_breach_pt2" );
    thread gov_hostage_breach_actor_anims_and_idle( var_1, var_8, "h_breach_pt1", "h_breach_idle", "h_breach_idle_ender" );
    thread gov_hostage_breach_actor_anims_and_idle( var_1, var_10, "h_breach_pt1", "h_breach_idle", "h_breach_idle_ender" );
    thread gov_hostage_breach_actor_anims_and_idle( var_1, var_15, "h_breach_pt1", "h_breach_idle", "h_breach_idle_ender" );
    thread gov_hostage_breach_actor_anims_and_idle( var_1, var_17, "h_breach_pt1", "h_breach_idle", "h_breach_idle_ender" );
    thread gov_hostage_breach_actor_anims_and_idle( var_1, var_19, "h_breach_pt1", "h_breach_idle", "h_breach_idle_ender" );
    thread gov_hostage_breach_actor_anims_and_idle( var_1, var_21, "h_breach_pt1", "h_breach_idle", "h_breach_idle_ender" );
    thread gov_hostage_breach_actor_anims_and_idle( var_1, level.burke, "h_breach_pt1", "h_breach_idle", "h_breach_idle_ender" );
    thread gov_hostage_breach_actor_anims_and_idle( var_1, level.ajani, "h_breach_pt1", "h_breach_idle", "h_breach_idle_ender" );
    thread gov_hostage_breach_actor_anims_and_idle( var_1, var_22, "h_breach_pt1", "h_breach_idle", "h_breach_idle_ender" );
    thread gov_hostage_breach_actor_anims_and_idle( var_1, level.h_breach_doors, "h_breach_pt1" );
    thread gov_hostage_breach_actor_anims_and_idle( var_1, var_23, "h_breach_pt1" );
    thread gov_post_h_breach_joker_actions();
    wait 15;
    common_scripts\utility::flag_set( "obj_progress_free_pm" );
    level waittill( "player_end_scan" );
    thread maps\_player_exo::player_exo_deactivate();
    var_1 notify( "h_breach_idle_ender" );
    waitframe();
    soundscripts\_snd::snd_message( "pm_rescue_foley" );
    thread gov_hostage_breach_actor_anims_and_idle( var_1, var_8, "h_breach_pt2", "h_breach_post", undefined );
    thread gov_hostage_breach_actor_anims_and_idle( var_1, var_10, "h_breach_pt2", "h_breach_post", undefined );
    thread gov_hostage_breach_actor_anims_and_idle( var_1, var_15, "h_breach_pt2", "h_breach_post", undefined );
    thread gov_hostage_breach_actor_anims_and_idle( var_1, var_17, "h_breach_pt2", "h_breach_post", undefined );
    thread gov_hostage_breach_actor_anims_and_idle( var_1, var_19, "h_breach_pt2", "h_breach_post", undefined );
    thread gov_hostage_breach_actor_anims_and_idle( var_1, var_21, "h_breach_pt2", "h_breach_post", undefined );
    thread gov_hostage_breach_actor_anims_and_idle( var_1, level.burke, "h_breach_pt2" );
    thread gov_hostage_breach_actor_anims_and_idle( var_1, level.ajani, "h_breach_pt2" );
    thread gov_hostage_breach_actor_anims_and_idle( var_1, var_22, "h_breach_pt2" );
    thread gov_hostage_breach_actor_anims_and_idle( var_1, var_23, "h_breach_pt2" );
    level notify( "breach_anims_complete" );
    wait 25;
    thread maps\_player_exo::player_exo_activate();
    common_scripts\utility::flag_set( "gov_hostage_exit_door_open" );
}

gov_post_h_breach_joker_actions()
{
    wait 3;
    thread maps\lagos_utility::ally_redirect_goto_node( "Joker", "gov_h_breach_joker_post" );
    var_0 = getent( "anim_HM_post_breach_door", "targetname" );
    var_1 = getent( "anim_HM_post_breach_joker", "targetname" );
    var_2 = getent( "gov_hostage_ext_door", "targetname" );
    var_2.animname = "gov_exit_door";
    var_2 maps\_utility::assign_animtree();
    var_0 thread maps\_anim::anim_first_frame_solo( var_2, "h_breach_exit_door_open" );
    common_scripts\utility::flag_wait( "flag_hostage_scan_started" );
    wait 0.5;
    var_1 thread maps\_anim::anim_single_solo_run( level.joker, "h_breach_exit_door_open" );
    var_0 thread maps\_anim::anim_single_solo( var_2, "h_breach_exit_door_open" );
    wait 26.8;
    var_3 = getent( "gov_hostage_ext_door_collision", "targetname" );

    if ( level.nextgen )
        var_3 delete();

    thread maps\lagos_utility::ally_redirect_goto_node( "Joker", "gov_exit_joker" );

    if ( level.currentgen )
    {
        var_3.origin -= ( 0, 0, 200 );
        common_scripts\utility::flag_wait( "gov_player_exiting_area" );
        var_3.origin += ( 0, 0, 200 );
    }
}

h_breach_blockers_delete()
{
    wait 4.4;
    var_0 = getent( "gov_h_breach_blocker", "targetname" );
    var_0 delete();
    var_1 = getent( "hbreach_NoSight", "targetname" );
    var_1 delete();
}

gov_hostage_breach_actor_anims_and_idle( var_0, var_1, var_2, var_3, var_4 )
{
    var_1 endon( "death" );
    var_1 notify( "anim_breach_begin" );

    if ( isdefined( var_4 ) )
        var_0 endon( var_4 );

    if ( isdefined( var_3 ) )
        var_0 maps\_anim::anim_single_solo( var_1, var_2 );
    else
        var_0 maps\_anim::anim_single_solo_run( var_1, var_2 );

    if ( !common_scripts\utility::flag( "pm_released" ) )
    {
        if ( isdefined( var_3 ) )
            var_0 maps\_anim::anim_loop_solo( var_1, var_3, var_4 );
    }

    var_1 notify( "anim_breach_complete" );
}

debug_anim_time( var_0 )
{
    self endon( "death" );

    for (;;)
        waitframe();
}

gov_hostage_breach_actor_anims_straight_to_idle( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_1 endon( "death" );
    var_0 maps\_anim::anim_single_solo( var_1, var_2 );

    if ( isdefined( var_5 ) )
        var_0 maps\_anim::anim_single_solo( var_1, var_5 );

    if ( isdefined( var_3 ) )
    {
        var_0 thread maps\_anim::anim_loop_solo( var_1, var_3, var_4 );

        if ( isdefined( var_4 ) )
        {
            level waittill( var_4 );
            waitframe();
            var_0 notify( var_4 );
        }
    }
}

gov_hostage_breach_give_radio()
{
    var_0 = self gettagorigin( "TAG_INHAND" );
    var_1 = self gettagangles( "TAG_INHAND" );
    var_2 = spawn( "script_model", self.origin );
    var_2 setmodel( "com_hand_radio" );
    var_2.origin = var_0;
    var_2.angles = var_1;
    var_2 linkto( self, "TAG_INHAND" );
    self waittill( "anim_breach_complete" );
    var_2 delete();
}

restrict_movement_while_releasing_the_pm()
{
    var_0 = getent( "player_release_pm_volume", "targetname" );

    for (;;)
    {
        if ( level.player istouching( var_0 ) )
        {
            level.player allowcrouch( 0 );
            level.player allowprone( 0 );

            while ( level.player istouching( var_0 ) )
                waitframe();

            level.player allowcrouch( 1 );
            level.player allowprone( 1 );
        }

        waitframe();
    }
}

gov_hostage_player_scan( var_0, var_1 )
{
    level waittill( "scan_idle_go" );
    maps\_utility::autosave_by_name();
    var_2 = getent( "player_release_pm_trigger", "targetname" );
    var_3 = var_2 maps\_shg_utility::hint_button_trigger( "x", 400 );
    var_2 sethintstring( &"LAGOS_RELEASE_PM" );
    var_2 waittill( "trigger", var_4 );
    var_3 maps\_shg_utility::hint_button_clear();
    var_2 sethintstring( "" );
    var_2 makeunusable();
    common_scripts\utility::flag_set( "hostage_release_lighting" );
    common_scripts\utility::flag_set( "flag_hostage_scan_started" );
    level.player maps\_shg_utility::setup_player_for_scene();
    level.player enableslowaim( 0.2, 0.2 );
    getent( "PM_use_clip", "targetname" ) delete();
    var_5 = maps\_utility::spawn_anim_model( "player_rig", level.player.origin );
    var_5 hide();
    var_0 maps\_anim::anim_first_frame_solo( var_5, "h_breach_pt2" );
    var_6 = 0.5;
    level.player playerlinktoblend( var_5, "tag_player", var_6, var_6 * 0.5, var_6 * 0.5 );
    wait(var_6);
    level.player playerlinktodelta( var_5, "tag_player", 1, 7, 7, 5, 5, 1 );
    var_5 show();
    level notify( "player_end_scan" );
    common_scripts\utility::flag_set( "pm_released" );
    common_scripts\utility::flag_set( "obj_progress_free_pm_clear" );
    var_0 maps\_anim::anim_single_solo( var_5, "h_breach_pt2" );
    common_scripts\utility::flag_clear( "pm_released" );
    level.player unlink();
    var_5 delete();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    level.player disableslowaim();
    wait 1;
    common_scripts\utility::flag_set( "obj_complete_rescue_PM" );
    wait 1;
    common_scripts\utility::flag_set( "obj_find_hostage_truck" );
    common_scripts\utility::flag_wait( "flag_leaving_gov_building" );
    maps\_utility::autosave_by_name();
}

gov_rear_setup()
{
    thread gov_rear_squad_roundabout_goto();
    level waittill( "BreachComplete" );

    if ( common_scripts\utility::flag( "pre_h_breach_playerstart" ) || common_scripts\utility::flag( "post_h_breach_playerstart" ) )
    {
        level.gov_veh_spawners = [];
        level.gov_soldiers_veh = [];
    }

    var_0 = getentarray( "gov_rear_foot_soldier", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = var_2 maps\_utility::spawn_ai( 1 );
        var_4 = var_3.target;
        var_3 maps\_utility::set_goal_node( getnode( var_3.target, "targetname" ) );
        var_3 thread gov_building_rear_removal();
    }

    common_scripts\utility::flag_wait( "gov_rear_init" );
    var_0 = maps\_utility::get_living_ai_array( "gov_rear_soldier", "script_noteworthy" );

    foreach ( var_2 in var_0 )
    {
        var_2 thread gov_building_rear_removal();
        level.gov_soldiers_veh = common_scripts\utility::array_add( level.gov_soldiers_veh, var_2 );
    }
}

gov_rear_squad_roundabout_goto()
{
    level waittill( "breach_anims_complete" );

    foreach ( var_1 in level.alpha_squad )
    {
        var_1.ignoreall = 0;
        var_1 maps\_utility::disable_cqbwalk();
    }

    thread maps\lagos_utility::ally_redirect_goto_node( "Gideon", "gov_exit_burke" );
    thread maps\lagos_utility::ally_redirect_goto_node( "Ajani", "gov_exit_ajani" );
    common_scripts\utility::flag_wait( "gov_hostage_exit_door_open" );
    common_scripts\utility::flag_wait( "gov_player_exiting_area" );
    thread maps\lagos_utility::ally_redirect_goto_node( "Gideon", "roundabout_start_burke" );
    wait 1;
    thread maps\lagos_utility::ally_redirect_goto_node( "Joker", "roundabout_start_joker" );
    wait 1;
    thread maps\lagos_utility::ally_redirect_goto_node( "Ajani", "roundabout_start_ajani" );
}

roundabout_setup()
{
    level.lookat_roundabout_rappel_trigger = getent( "lookat_roundabout_rappel_trigger", "targetname" );
    level.lookat_roundabout_tanker_explode_trigger = getent( "lookat_roundabout_tanker_explode_trigger", "targetname" );
    level.lookat_roundabout_rappel_trigger common_scripts\utility::trigger_off();
    level.lookat_roundabout_tanker_explode_trigger common_scripts\utility::trigger_off();
    level.tanker_fire_hurt_trigger = getent( "trigger_tanker_fire_hurt", "targetname" );
    level.tanker_fire_hurt_trigger common_scripts\utility::trigger_off();
    level.rb_blast_marks = getentarray( "roundabout_rpg_building_blast_geo", "targetname" );

    if ( isdefined( level.rb_blast_marks ) )
    {
        foreach ( var_1 in level.rb_blast_marks )
            var_1 hide();
    }

    var_3 = getent( "badPlace_roundabout_lobby", "targetname" );
    badplace_cylinder( "ally_badPlace_roundabout_lobby", -1, var_3.origin, 150, 200, "allies" );
    var_4 = getentarray( "roundabout_badplace_lobby_to_center", "targetname" );

    foreach ( var_6 in var_4 )
        badplace_brush( "roundabout_badplace_lobby_to_center", -1, var_6, "neutral" );

    thread maps\lagos_vo::leaving_gov_building();
    thread maps\lagos_vo::approaching_roundabout_dialogue();
    thread maps\lagos_vo::roundabout_combat_dialogue();
    common_scripts\utility::flag_wait( "checkpoint_roundabout_lobby" );
    maps\_utility::autosave_by_name( "checkpoint_roundabout_lobby" );
    level.burke maps\lagos_utility::enable_awareness();
    level.joker maps\lagos_utility::enable_awareness();
    level.ajani maps\lagos_utility::enable_awareness();
    common_scripts\utility::flag_wait( "roundabout_combat_begin" );
    badplace_delete( "ally_badPlace_roundabout_lobby" );
    common_scripts\utility::flag_wait( "checkpoint_roundabout_center" );
    maps\_utility::autosave_by_name_silent( "checkpoint_roundabout_center" );
}

roundabout_combat()
{
    level.enemies_1_a_south = [];
    var_0 = [];
    var_1 = [];
    var_2 = [];
    var_3 = [];
    var_4 = [];
    var_5 = [];
    var_6 = [];
    var_7 = [];
    var_8 = [];
    var_9 = [];
    roundabout_combat_initial();
    common_scripts\utility::flag_wait( "roundabout_combat_begin" );
    var_10 = undefined;
    var_11 = getentarray( "tanker_explosion_tanker", "script_noteworthy" );

    foreach ( var_13 in var_11 )
    {
        if ( var_13.classname == "script_model" )
            var_10 = var_13;
    }

    var_15 = 2000;
    var_10.health = var_15;
    var_10 setcandamage( 1 );
    var_10 thread roundabout_tanker_damage( var_15 );
    level.roundabout_ropes = [];
    wait 4;

    if ( level.currentgen )
    {
        var_0 = [];
        var_0 = maps\_utility::array_spawn_targetname_cg( "Roundabout_enemies_1_C_south", 1, 0.05 );
    }
    else
        var_0 = maps\_utility::array_spawn_targetname( "Roundabout_enemies_1_C_south", 1 );

    var_7 = common_scripts\utility::array_combine( var_7, level.enemies_1_a_south );
    var_7 = common_scripts\utility::array_combine( var_7, level.enemies_1_a2_south );
    var_7 = common_scripts\utility::array_combine( var_7, var_0 );
    thread maps\lagos_utility::spawn_wave_upkeep_and_flag( var_7, "roundabout_wave_1A_complete", 2, 0 );
    thread roundabout_magic_microwave_grenade();
    thread hint_text_exo_shield();
    thread roundabout_rush_goal( var_7, "enemy_goal_Roundabout_rush_SE", 8 );
    thread roundabout_rush_goal( var_7, "enemy_goal_Roundabout_rush_SE_inside", 10 );
    thread roundabout_rush_goal( var_7, "enemy_goal_Roundabout_D", 12 );
    common_scripts\utility::flag_wait( "roundabout_wave_1A_complete" );
    var_7 = maps\_utility::array_removedead_or_dying( var_7 );
    var_16 = getent( "enemy_goal_Roundabout_C", "targetname" );

    foreach ( var_18 in var_7 )
    {
        if ( isdefined( var_18 ) && isalive( var_18 ) )
        {
            var_18 cleargoalvolume();
            var_18 maps\_utility::player_seek_disable();
            waitframe();

            if ( isdefined( var_18 ) && isalive( var_18 ) )
                var_18 setgoalvolumeauto( var_16 );
        }
    }

    if ( !common_scripts\utility::flag( "obj_progress_find_hostage_truck_roundabout_complete" ) )
    {
        if ( level.currentgen )
        {
            var_1 = [];
            var_1 = maps\_utility::array_spawn_targetname_cg( "Roundabout_enemies_2_A_south", 1, 0.05 );
        }
        else
            var_1 = maps\_utility::array_spawn_targetname( "Roundabout_enemies_2_A_south", 1 );

        foreach ( var_18 in var_1 )
            var_18.health = 100;

        wait 2;

        foreach ( var_18 in var_1 )
        {
            if ( isdefined( var_18.script_noteworthy ) && issubstr( var_18.script_noteworthy, "sniper" ) )
            {
                var_18.custom_laser_function = maps\lagos_utility::lagos_custom_laser;
                var_18 maps\lagos_utility::lagos_custom_laser();
                var_18.goalradius = 2;
            }
        }

        var_7 = common_scripts\utility::array_combine( var_7, var_1 );
        thread maps\lagos_utility::spawn_wave_upkeep_and_flag( var_7, "roundabout_wave_1B_complete", 2, 0 );
        common_scripts\utility::flag_wait( "roundabout_wave_1B_complete" );
        var_7 = maps\_utility::array_removedead_or_dying( var_7 );

        if ( level.currentgen )
        {
            var_2 = [];
            var_2 = maps\_utility::array_spawn_targetname_cg( "Roundabout_enemies_2_B_west", 1, 0.05 );
        }
        else
            var_2 = maps\_utility::array_spawn_targetname( "Roundabout_enemies_2_B_west", 1 );

        foreach ( var_18 in var_2 )
        {
            var_18.ignoreall = 1;
            var_18.ignoreme = 1;

            if ( !isdefined( var_18.damage_functions ) )
                var_18.damage_functions = [];
        }

        thread anim_roundabout_rappel_1( var_2 );

        if ( level.currentgen )
        {
            var_26 = [];
            var_26 = maps\_utility::array_spawn_targetname_cg( "Roundabout_enemies_2_E_west", 1, 0.05 );
        }
        else
            var_26 = maps\_utility::array_spawn_targetname( "Roundabout_enemies_2_E_west", 1 );

        var_8 = common_scripts\utility::array_combine( var_8, var_7 );
        var_8 = common_scripts\utility::array_combine( var_8, var_2 );
        var_8 = common_scripts\utility::array_combine( var_8, var_26 );
        thread maps\lagos_utility::spawn_wave_upkeep_and_flag( var_8, "roundabout_wave_2A_complete", 2, 0 );
        common_scripts\utility::flag_wait( "roundabout_wave_2A_complete" );
        maps\_utility::autosave_by_name();
        var_8 = maps\_utility::array_removedead_or_dying( var_8 );

        if ( level.currentgen )
        {
            var_3 = [];
            var_3 = maps\_utility::array_spawn_targetname_cg( "Roundabout_enemies_2_C_west", 1, 0.05 );
        }
        else
            var_3 = maps\_utility::array_spawn_targetname( "Roundabout_enemies_2_C_west", 1 );

        if ( level.currentgen )
        {
            var_4 = [];
            var_4 = maps\_utility::array_spawn_targetname_cg( "Roundabout_enemies_2_D_west", 1, 0.05 );
        }
        else
            var_4 = maps\_utility::array_spawn_targetname( "Roundabout_enemies_2_D_west", 1 );

        common_scripts\utility::flag_set( "roundabout_wave_2_all_spawned" );

        foreach ( var_18 in var_4 )
        {
            var_18.ignoreall = 1;
            var_18.ignoreme = 1;

            if ( !isdefined( var_18.damage_functions ) )
                var_18.damage_functions = [];
        }

        thread anim_roundabout_rappel_2( var_4 );
        var_8 = common_scripts\utility::array_combine( var_8, var_3 );
        var_8 = common_scripts\utility::array_combine( var_8, var_4 );
        thread maps\lagos_utility::spawn_wave_upkeep_and_flag( var_8, "roundabout_wave_2B_complete", 2, 0 );
        thread roundabout_rush_goal( var_8, "enemy_goal_Roundabout_van_SW", 1, 1 );
        thread roundabout_rush_goal( var_8, "enemy_goal_Roundabout_rush_SW", 9 );
        thread roundabout_rush_goal( var_8, "enemy_goal_Roundabout_rush_SW_inside", 10 );
        thread roundabout_rush_goal( var_8, "enemy_goal_Roundabout_B", 13 );
        common_scripts\utility::flag_wait( "roundabout_wave_2B_complete" );
        var_8 = maps\_utility::array_removedead_or_dying( var_8 );
        var_16 = getent( "enemy_goal_Roundabout_B", "targetname" );

        foreach ( var_18 in var_8 )
        {
            if ( isdefined( var_18 ) && isalive( var_18 ) )
            {
                var_18 cleargoalvolume();
                var_18 maps\_utility::player_seek_disable();
                waitframe();

                if ( isdefined( var_18 ) && isalive( var_18 ) )
                    var_18 setgoalvolumeauto( var_16 );
            }
        }
    }

    if ( !common_scripts\utility::flag( "obj_progress_find_hostage_truck_roundabout_complete" ) )
    {
        if ( level.currentgen )
        {
            var_5 = [];
            var_5 = maps\_utility::array_spawn_targetname_cg( "Roundabout_enemies_3_A_east", 1, 0.05 );
        }
        else
            var_5 = maps\_utility::array_spawn_targetname( "Roundabout_enemies_3_A_east", 1 );

        var_9 = common_scripts\utility::array_combine( var_9, var_8 );
        var_9 = common_scripts\utility::array_combine( var_9, var_5 );
        thread maps\lagos_utility::spawn_wave_upkeep_and_flag( var_9, "roundabout_wave_3A_complete", 2, 0 );
        thread roundabout_rush_goal( var_9, "enemy_goal_Roundabout_rush_SE_inside", 4 );
        common_scripts\utility::flag_wait( "roundabout_wave_3A_complete" );
        var_9 = maps\_utility::array_removedead_or_dying( var_9 );
        var_6 = maps\_utility::array_spawn_targetname( "Roundabout_enemies_3_B_south", 1 );
        common_scripts\utility::flag_set( "roundabout_wave_3_all_spawned" );
        var_9 = common_scripts\utility::array_combine( var_9, var_6 );
        thread roundabout_rush_goal( var_9, "enemy_goal_Roundabout_van_SE", 1, 1 );
        thread roundabout_rush_goal( var_9, "enemy_goal_Roundabout_rush_E", 8 );
        thread roundabout_rush_goal( var_9, "enemy_goal_Roundabout_rush_SE_inside", 10 );
        wait 3;

        if ( !common_scripts\utility::flag( "flag_roundabout_tanker_explode" ) )
        {
            if ( level.currentgen )
            {
                var_31 = [];
                var_31 = maps\_utility::array_spawn_targetname_cg( "Roundabout_enemies_OnTanker", 1, 0.05 );
            }
            else
                var_31 = maps\_utility::array_spawn_targetname( "Roundabout_enemies_OnTanker", 1 );

            foreach ( var_18 in var_31 )
            {
                var_18.ignoreme = 1;
                var_18 thread roundabout_tanker_enemy_settings();
            }

            thread maps\lagos_utility::spawn_wave_upkeep_and_flag( var_31, "roundabout_wave_3_complete", 0 );
            common_scripts\utility::flag_wait( "roundabout_wave_3_complete" );

            if ( !common_scripts\utility::flag( "flag_roundabout_tanker_explode" ) )
            {
                thread roundabout_tanker_magic_rpg();
                wait 1.33;

                if ( !common_scripts\utility::flag( "flag_roundabout_tanker_explode" ) )
                {
                    roundabout_combat_tanker_explode();
                    var_9 = maps\_utility::array_removedead_or_dying( var_9 );
                    common_scripts\utility::array_call( var_9, ::kill );
                }
            }
        }
        else
        {
            var_9 = maps\_utility::array_removedead_or_dying( var_9 );
            thread maps\lagos_utility::spawn_wave_upkeep_and_flag( var_9, "roundabout_wave_3_complete", 0, 0 );
            common_scripts\utility::flag_wait( "roundabout_wave_3_complete" );
        }

        wait 0.25;
        common_scripts\utility::flag_set( "obj_progress_find_hostage_truck_roundabout" );
        common_scripts\utility::flag_set( "obj_progress_find_hostage_truck_roundabout_complete" );
        var_34 = getnode( "node_roundabout_escape_burke", "targetname" );
        var_35 = getnode( "node_roundabout_escape_joker", "targetname" );
        var_36 = getnode( "node_roundabout_escape_ajani", "targetname" );
        level.burke maps\_utility::set_goal_node( var_34 );
        level.joker maps\_utility::set_goal_node( var_35 );
        level.ajani maps\_utility::set_goal_node( var_36 );
        var_37 = getent( "kva_goal_Roundabout_complete", "targetname" );

        if ( var_9.size > 0 )
        {
            var_38 = 0;

            foreach ( var_18 in var_9 )
            {
                if ( isdefined( var_18 ) && isalive( var_18 ) )
                {
                    var_18 cleargoalvolume();
                    var_18 maps\_utility::player_seek_disable();
                    waitframe();
                    var_18 setgoalvolumeauto( var_37 );

                    if ( var_38 % 2 )
                        var_18 thread maps\lagos_utility::ignore_all_until_path_end();

                    var_38++;
                }
            }
        }

        common_scripts\utility::flag_wait( "alley1_spawn" );

        foreach ( var_42 in level.roundabout_ropes )
            var_42 delete();
    }
}

roundabout_magic_microwave_grenade()
{
    wait 5;
    var_0 = common_scripts\utility::getstruct( "microwave_gren_throw", "targetname" );
    var_1 = common_scripts\utility::getstruct( "microwave_gren_target", "targetname" );
    var_2 = magicgrenade( "microwave_grenade", var_0.origin, var_1.origin );
    var_2 thread maps\_microwave_grenade::microwave_grenade_explode_wait();
    var_2 waittill( "explode", var_3 );
    common_scripts\utility::flag_set( "flag_roundabout_magic_MWG" );
}

hint_text_exo_shield()
{
    level.player endon( "death" );
    wait 25;

    if ( level.player maps\_player_exo::exo_shield_is_on() == 0 )
    {
        if ( level.player.exobatterylevel >= 1 )
        {
            maps\_utility::hintdisplayhandler( "use_exo_shield", 5 );

            while ( !common_scripts\utility::flag( "flag_roundabout_exo_shield" ) )
            {
                if ( level.player buttonpressed( "DPAD_DOWN" ) )
                    common_scripts\utility::flag_set( "flag_roundabout_exo_shield" );

                waitframe();
            }
        }
    }
}

use_exo_shield_check()
{
    level.player endon( "death" );

    if ( common_scripts\utility::flag( "flag_roundabout_exo_shield" ) )
        return 1;
    else
        return 0;
}

roundabout_tanker_damage( var_0 )
{
    while ( isdefined( self ) && isalive( self ) )
    {
        self waittill( "damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 );

        if ( var_2 != level.player && self.health / var_0 <= 0.25 && self.health > 0 )
            self.health += var_1;

        if ( self.health <= 100 && var_2 == level.player )
        {
            common_scripts\utility::flag_set( "flag_roundabout_tanker_explode" );
            roundabout_combat_tanker_explode();
            return;
        }

        waitframe();
    }
}

roundabout_rush_goal( var_0, var_1, var_2, var_3 )
{
    wait(var_2);
    var_0 = maps\_utility::array_removedead_or_dying( var_0 );

    if ( var_0.size <= 0 )
        return;

    var_4 = getent( var_1, "targetname" );

    foreach ( var_6 in var_0 )
        var_6.distance_to_goalvol_sq = distancesquared( var_6.origin, var_4.origin );

    if ( isdefined( var_3 ) && var_3 )
        var_0 = common_scripts\utility::array_sort_with_func( var_0, maps\lagos_utility::closer_to_goal_vol );
    else
        var_0 = common_scripts\utility::array_sort_with_func( var_0, maps\lagos_utility::farther_to_goal_vol );

    foreach ( var_6 in var_0 )
    {
        if ( isdefined( var_6.rushed ) || issubstr( var_6.classname, "sniper" ) || issubstr( var_6.classname, "rpg" ) )
            var_0 = common_scripts\utility::array_remove( var_0, var_6 );
    }

    foreach ( var_6 in var_0 )
    {
        if ( isdefined( var_6 ) && isalive( var_6 ) )
        {
            if ( isdefined( var_3 ) && var_3 )
                var_6.goalradius = 16;

            var_6.ignoreme = 1;
            var_6.grenadeammo = 0;
            var_6 setgoalvolumeauto( var_4 );
            var_6.rushed = 1;
            var_6 thread maps\lagos_utility::ignore_until_goal_reached();
            var_6 waittill( "goal" );

            if ( isdefined( var_6 ) && isalive( var_6 ) )
            {
                if ( !isdefined( var_3 ) || !var_3 )
                    var_6 thread maps\_utility::player_seek_enable();
                else if ( isdefined( var_3 ) && var_3 )
                    var_6.script_fixednode = 1;
            }

            wait 2;

            if ( isdefined( var_6 ) && isalive( var_6 ) )
                var_6.ignoreme = 0;

            return;
        }
    }
}

roundabout_tanker_enemy_settings()
{
    self.deathanim = %bog_b_rpg_fall_death;
    self waittill( "death" );

    if ( common_scripts\utility::flag( "flag_roundabout_tanker_explode" ) )
    {
        self hide();
        self delete();
        return;
    }

    wait 1.5;

    if ( isdefined( self ) )
    {
        self.weapon = "none";
        self hide();
        self delete();
    }
}

roundabout_tanker_enemy_settings_other()
{
    common_scripts\utility::flag_wait( "flag_delete_other_tanker_enemies" );
    wait 1.5;

    if ( isdefined( self ) )
    {
        self.weapon = "none";
        self hide();
        self delete();
    }
}

roundabout_tanker_magic_rpg()
{
    var_0 = getent( "magicOrg_roundabout_tanker_source", "targetname" );
    var_1 = getent( "magicOrg_roundabout_tanker_dest", "targetname" );
    wait 1;
    magicbullet( "iw5_mahemstraight_sp", var_0.origin, var_1.origin );
}

roundabout_combat_initial()
{
    common_scripts\utility::flag_wait( "roundabout_combat_starting_soon" );

    if ( level.currentgen )
    {
        level.enemies_1_a2_south = [];
        level.enemies_1_a2_south = maps\_utility::array_spawn_targetname_cg( "Roundabout_enemies_1_A2_south", 1, 0.05 );
    }
    else
        level.enemies_1_a2_south = maps\_utility::array_spawn_targetname( "Roundabout_enemies_1_A2_south", 1 );

    foreach ( var_1 in level.enemies_1_a2_south )
    {
        var_1.ignoreall = 1;
        var_1.ignoreme = 1;
        var_1 thread maps\_utility::magic_bullet_shield();
        var_1.goalradius = 16;
    }

    common_scripts\utility::flag_wait( "roundabout_combat_begin" );
    var_3 = getent( "magicOrg_roundabout_opening_1", "targetname" );
    var_4 = getent( "magicOrg_roundabout_opening_2", "targetname" );
    var_5 = getent( "magicOrg_roundabout_opening_3", "targetname" );
    var_6 = getent( "magicOrg_roundabout_opening_4", "targetname" );
    var_7 = getent( "magicDest_roundabout_opening_1", "targetname" );
    var_8 = getent( "magicDest_roundabout_opening_1_A", "targetname" );
    var_9 = getent( "magicDest_roundabout_opening_2", "targetname" );
    var_10 = getent( "magicDest_roundabout_opening_3", "targetname" );
    var_11 = getent( "magicDest_roundabout_opening_4", "targetname" );
    var_12 = getent( "magicDest_roundabout_opening_5", "targetname" );
    var_13 = getent( "magicDest_roundabout_opening_6", "targetname" );
    common_scripts\utility::flag_set( "roundabout_RPG_start" );
    soundscripts\_snd::snd_message( "roundabout_general_mayhem" );
    level.player enableinvulnerability();
    var_14 = magicbullet( "iw5_mahemstraight_sp", var_5.origin, var_7.origin );
    var_14 soundscripts\_snd::snd_message( "roundabout_rpg_fire" );
    wait 0.75;
    var_14 = magicbullet( "iw5_mahemstraight_sp", var_3.origin, var_8.origin );
    var_14 soundscripts\_snd::snd_message( "roundabout_rpg_fire" );
    wait 0.25;
    var_14 = magicbullet( "iw5_mahemstraight_sp", var_4.origin, var_9.origin );
    var_14 soundscripts\_snd::snd_message( "roundabout_rpg_fire" );
    wait 0.5;
    level notify( "drivers_get_out" );
    common_scripts\utility::flag_set( "flag_Roundabout_Civilians_Flee" );
    soundscripts\_snd::snd_message( "roundabout_combat_started" );

    if ( level.currentgen )
    {
        level.enemies_1_a_south = [];
        level.enemies_1_a_south = maps\_utility::array_spawn_targetname_cg( "Roundabout_enemies_1_A_south", 1, 0.05 );
    }
    else
        level.enemies_1_a_south = maps\_utility::array_spawn_targetname( "Roundabout_enemies_1_A_south", 1 );

    var_15 = level.enemies_1_a_south[0].goalradius;

    foreach ( var_1 in level.enemies_1_a_south )
    {
        var_1.ignoreall = 1;
        var_1.ignoreme = 1;
        var_1 thread maps\_utility::magic_bullet_shield();
        var_1.goalradius = 16;
    }

    if ( level.nextgen )
    {
        var_14 = magicbullet( "iw5_mahemstraight_sp", var_5.origin, var_10.origin );
        var_14 soundscripts\_snd::snd_message( "roundabout_rpg_fire" );
        wait 0.25;
        var_14 = magicbullet( "iw5_mahemstraight_sp", var_6.origin, var_11.origin );
        var_14 soundscripts\_snd::snd_message( "roundabout_rpg_fire" );
        wait 0.25;
        var_14 = magicbullet( "iw5_mahemstraight_sp", var_5.origin, var_12.origin );
        var_14 soundscripts\_snd::snd_message( "roundabout_rpg_fire" );
        wait 0.75;
        var_14 = magicbullet( "iw5_mahemstraight_sp", var_5.origin, var_13.origin );
        var_14 soundscripts\_snd::snd_message( "roundabout_rpg_fire" );
    }

    thread maps\lagos_utility::stop_vehicle_traffic_roundabout_straightways();
    level.player disableinvulnerability();

    if ( level.nextgen )
        radiusdamage( common_scripts\utility::getstruct( "roundabout_magic_extra_damage_1", "targetname" ).origin, 350, 10000, 9000 );

    foreach ( var_1 in level.enemies_1_a_south )
    {
        if ( isdefined( var_1 ) && isalive( var_1 ) )
        {
            var_1.ignoreall = 0;
            var_1.ignoreme = 0;
            var_1 maps\_utility::stop_magic_bullet_shield();
        }
    }

    foreach ( var_1 in level.enemies_1_a2_south )
    {
        if ( isdefined( var_1 ) && isalive( var_1 ) )
        {
            var_1.ignoreall = 0;
            var_1.ignoreme = 0;
            var_1 maps\_utility::stop_magic_bullet_shield();
        }
    }

    wait 2;
    var_22 = getent( "enemy_goal_Roundabout_Fallback_East", "targetname" );

    foreach ( var_1 in level.enemies_1_a_south )
        var_1 setgoalvolumeauto( var_22 );

    maps\_utility::battlechatter_on( "allies" );
    maps\_utility::battlechatter_on( "axis" );
}

roundabout_combat_tanker_explode()
{
    soundscripts\_snd::snd_message( "roundabout_tanker_explosion" );
    level thread maps\lagos_fx::roundabout_tanker_explosion();
    var_0 = common_scripts\utility::getstruct( "struct_roundabout_tanker_loc", "targetname" );
    earthquake( 0.6, 0.5, var_0.origin, 3000 );
    thread maps\lagos_utility::rumble_roundabout_tanker();
    var_1 = getentarray( "tanker_explosion_tanker", "script_noteworthy" );

    foreach ( var_3 in var_1 )
    {
        if ( var_3.classname == "script_model" )
            var_3 setmodel( "ind_semi_truck_fuel_tank_destroy" );
    }

    var_5 = getentarray( "tanker_explosion_cab", "script_noteworthy" );

    foreach ( var_3 in var_5 )
    {
        if ( var_3.classname == "script_model" )
            var_3 setmodel( "ind_semi_truck_03_destroy" );
    }

    var_8 = getentarray( "roundabout_rpg_building_clean_geo", "targetname" );

    if ( isdefined( var_8 ) )
    {
        foreach ( var_10 in var_8 )
            var_10 hide();
    }

    if ( isdefined( level.rb_blast_marks ) )
    {
        foreach ( var_10 in level.rb_blast_marks )
            var_10 show();
    }

    if ( level.nextgen )
    {
        radiusdamage( common_scripts\utility::getstruct( "kill_kva_rpgs_0", "targetname" ).origin, 300, 10000, 9000 );
        radiusdamage( common_scripts\utility::getstruct( "kill_kva_rpgs_1", "targetname" ).origin, 300, 10000, 9000 );
        radiusdamage( common_scripts\utility::getstruct( "kill_kva_rpgs_2", "targetname" ).origin, 300, 10000, 9000 );
        wait 0.5;
        radiusdamage( common_scripts\utility::getstruct( "roundabout_tanker_ground_damage_1", "targetname" ).origin, 350, 10000, 9000 );
        radiusdamage( common_scripts\utility::getstruct( "roundabout_tanker_ground_damage_2", "targetname" ).origin, 350, 10000, 9000 );
        wait 0.5;
        radiusdamage( common_scripts\utility::getstruct( "roundabout_tanker_ground_damage_3", "targetname" ).origin, 350, 10000, 9000 );
        wait 0.5;
        radiusdamage( common_scripts\utility::getstruct( "roundabout_tanker_ground_damage_5", "targetname" ).origin, 350, 10000, 9000 );
        radiusdamage( common_scripts\utility::getstruct( "roundabout_tanker_ground_damage_6", "targetname" ).origin, 350, 10000, 9000 );
    }
    else
        roundabout_combat_tanker_explode_veh_cg();

    var_14 = getcorpsearray();

    foreach ( var_16 in var_14 )
    {
        if ( issubstr( var_16.classname, "rpg" ) )
            var_16 delete();
    }

    var_18 = getweaponarray();

    foreach ( var_16 in var_18 )
    {
        if ( issubstr( var_16.classname, "mahem" ) )
            var_16 delete();
    }

    thread roundabout_combat_tanker_fire_damage();
}

roundabout_combat_tanker_fire_damage()
{
    level.tanker_fire_hurt_trigger common_scripts\utility::trigger_on();
    common_scripts\utility::flag_wait( "kill_roundabout_flames" );
    level.tanker_fire_hurt_trigger common_scripts\utility::trigger_off();
}

roundabout_combat_tanker_explode_veh_cg()
{
    var_0 = getent( "magicOrg_roundabout_tanker_dest", "targetname" );
    var_1 = getent( "magicOrg_roundabout_tanker_source", "targetname" );
    level.roundabout_center_vehicles_tank_explo = common_scripts\utility::array_add( level.roundabout_center_vehicles_tank_explo, var_1 );
    level.roundabout_center_vehicles_tank_explo = sortbydistance( level.roundabout_center_vehicles_tank_explo, var_0.origin );

    foreach ( var_3 in level.roundabout_center_vehicles_tank_explo )
    {
        wait(randomfloatrange( 0.1, 0.5 ));

        if ( isdefined( var_3 ) )
            radiusdamage( var_3.origin, 150, 10000, 9000 );
    }
}

roundabout_bicycle_riders()
{
    common_scripts\utility::flag_wait( "flag_roundabout_bikes_move" );
    maps\_utility::delaythread( 0.01, maps\lagos_utility::bike_rider, "roundabout_bike_path_1", 8 );
    maps\_utility::delaythread( 1.0, maps\lagos_utility::bike_rider, "roundabout_bike_path_2", 7 );
}

roundabout_combat_start_slow_motion()
{
    level.player thread maps\_utility::play_sound_on_entity( "slomo_whoosh" );
    level.player thread maps\lagos_qte::player_heartbeat();
    maps\_utility::slowmo_start();
    level.player allowmelee( 0 );
    maps\_utility::slowmo_setspeed_slow( 0.1 );
    maps\_utility::slowmo_setlerptime_in( 0.25 );
    maps\_utility::slowmo_lerp_in();
    wait 0.5;
    level notify( "stop_player_heartbeat" );
    level.player thread maps\_utility::play_sound_on_entity( "slomo_whoosh" );
    maps\_utility::slowmo_setlerptime_out( 0.75 );
    maps\_utility::slowmo_lerp_out();
    level.player allowmelee( 1 );
    maps\_utility::slowmo_end();
    earthquake( 0.5, 1, level.player.origin, 1000 );
}

anim_roundabout_rappel_1( var_0 )
{
    level.lookat_roundabout_rappel_trigger common_scripts\utility::trigger_on();
    thread maps\lagos_utility::timeout_and_flag( "lookat_roundabout_rappel_go", 2 );
    common_scripts\utility::flag_wait( "lookat_roundabout_rappel_go" );
    var_1 = getent( "anim_org_rb_rappel_R1", "targetname" );
    var_2 = getent( "anim_org_rb_rappel_R2", "targetname" );

    if ( var_0.size >= 2 )
    {
        if ( isalive( var_0[0] ) )
        {
            var_0[0].animname = "KVA_rappel_right";
            var_0[0] maps\_utility::add_damage_function( ::kill_kva_on_rope );
            thread threaded_anim_roundabout_rappel( var_1, var_0[0], "rb_rappel_right" );
            wait 0.5;
        }

        if ( isalive( var_0[1] ) )
        {
            var_0[1].animname = "KVA_rappel_right";
            var_0[1] maps\_utility::add_damage_function( ::kill_kva_on_rope );
            thread threaded_anim_roundabout_rappel( var_2, var_0[1], "rb_rappel_right" );
            wait 0.5;
        }
    }

    level.lookat_roundabout_rappel_trigger common_scripts\utility::trigger_off();
    common_scripts\utility::flag_clear( "lookat_roundabout_rappel_go" );
}

kill_kva_on_rope( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    self endon( "rappel_complete" );

    if ( var_1 == level.player )
    {
        self notify( "killanimscript" );
        maps\lagos_utility::challenge_point_award();
        self kill( self.origin );
        self startragdoll();
    }
}

anim_roundabout_rappel_2( var_0 )
{
    level.lookat_roundabout_rappel_trigger common_scripts\utility::trigger_on();
    thread maps\lagos_utility::timeout_and_flag( "lookat_roundabout_rappel_go", 2 );
    common_scripts\utility::flag_wait( "lookat_roundabout_rappel_go" );
    var_1 = getent( "anim_org_rb_rappel_L1", "targetname" );
    var_2 = getent( "anim_org_rb_rappel_L2", "targetname" );

    if ( var_0.size >= 2 )
    {
        if ( isalive( var_0[0] ) )
        {
            var_0[0].animname = "KVA_rappel_left";
            var_0[0] maps\_utility::add_damage_function( ::kill_kva_on_rope );
            thread threaded_anim_roundabout_rappel( var_1, var_0[0], "rb_rappel_left" );
            wait 0.5;
        }

        if ( isalive( var_0[1] ) )
        {
            var_0[1].animname = "KVA_rappel_left";
            var_0[1] maps\_utility::add_damage_function( ::kill_kva_on_rope );
            thread threaded_anim_roundabout_rappel( var_2, var_0[1], "rb_rappel_left" );
            wait 0.5;
        }
    }
}

threaded_anim_roundabout_rappel( var_0, var_1, var_2 )
{
    var_1 endon( "death" );
    var_3 = spawn( "script_model", var_0.origin );
    var_3 setmodel( "rope50ft" );
    var_3 useanimtree( level.scr_animtree["rappel_roundabout"] );
    var_3.animname = "rappel_roundabout";
    level.roundabout_ropes = common_scripts\utility::array_add( level.roundabout_ropes, var_3 );

    if ( issubstr( var_2, "right" ) )
        var_0 maps\_anim::anim_single_solo( var_3, "start_rope_right" );
    else if ( issubstr( var_2, "left" ) )
        var_0 maps\_anim::anim_single_solo( var_3, "start_rope_left" );

    wait 0.1;

    if ( issubstr( var_2, "right" ) )
    {
        var_0 maps\_anim::anim_first_frame_solo( var_3, "rope_right" );
        var_0 maps\_anim::anim_first_frame_solo( var_1, var_2 );
        wait 0.05;
        var_0 thread maps\_anim::anim_single_solo( var_3, "rope_right" );
        var_0 thread maps\_anim::anim_single_solo( var_1, var_2 );
    }
    else if ( issubstr( var_2, "left" ) )
    {
        var_0 maps\_anim::anim_first_frame_solo( var_3, "rope_left" );
        var_0 maps\_anim::anim_first_frame_solo( var_1, var_2 );
        wait 0.05;
        var_0 thread maps\_anim::anim_single_solo( var_3, "rope_left" );
        var_0 thread maps\_anim::anim_single_solo( var_1, var_2 );
    }

    wait 3.8;
    var_1 notify( "rappel_complete" );
    var_1.ignoreall = 0;
    var_1.ignoreme = 0;
}

roundabout_tanker_lookat()
{
    wait 15;
    level.lookat_roundabout_tanker_explode_trigger common_scripts\utility::trigger_on();
    thread maps\lagos_utility::timeout_and_flag( "lookat_roundabout_rappel_go", 10 );
    common_scripts\utility::flag_wait( "lookat_roundabout_rappel_go" );
    common_scripts\utility::flag_set( "roundabout_wave_3_complete" );
}

spawncivilians_roundabout()
{
    level.rb_flee_goal_pick = 0;
    common_scripts\utility::flag_wait( "flag_roundabout_spawn_vehicles" );
    thread spawnmalecivilians_roundabout();
    thread spawnfemalecivilians_roundabout();
    thread spawnwalkingcivilians_roundabout();
    thread roundabout_lobby_elevator();
    thread roundabout_lobby_couch();
    thread roundabout_lobby_security_desk();
    thread roundabout_lobby_phone();
    thread roundabout_lobby_phone2();
    thread roundabout_lobby_walkingtalk();
    thread roundabout_street_drop_bikes();
    thread roundabout_street_car_hood_hit();
    thread roundabout_lobby_couch_front();
    thread roundabout_lobby_security_desk_front();
    thread roundabout_lobby_phone_front();
    level.roundabout_flee_goals = getentarray( "goal_roundabout_flee", "targetname" );
}

roundabout_lobby_security_desk_front()
{
    var_0 = getent( "rb_lobby_security_desk_1_front", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_1 = getent( "rb_lobby_security_desk_2_front", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_0 endon( "death" );
    var_1 endon( "death" );
    var_0.alertlevelint = 0;
    var_1.alertlevelint = 0;
    var_0 maps\lagos_utility::immune_sonic_blast();
    var_1 maps\lagos_utility::immune_sonic_blast();
    var_0.animname = "lobby_security";
    var_1.animname = "lobby_security";
    level.civilian_roundabout_vo_1 = var_0;
    var_2 = getent( "anim_org_rb_lobby_security_desk_front", "targetname" );
    var_3 = getent( "anim_org_rb_lobby_security_desk_front_2", "targetname" );
    var_2 thread maps\_anim::anim_loop_solo( var_0, "security_loop_1", "stop_loop" );
    var_3 thread maps\_anim::anim_loop_solo( var_1, "security_loop_2", "stop_loop" );
    common_scripts\utility::flag_wait( "flag_roundabout_player_move_0" );
    var_3 notify( "stop_loop" );
    var_1 setlookatentity( level.player );
    var_3 maps\_anim::anim_single_solo( var_1, "security_react_2" );
    var_3 maps\_anim::anim_single_solo( var_1, "security_react_loop_2" );
    var_1 thread fleeingcivilian_roundaboutexit_lobby( "civilian_goal_Roundabout_delete_front" );
    common_scripts\utility::flag_wait( "roundabout_wave_1A_complete" );
    var_0 maps\_shg_design_tools::delete_auto();
}

roundabout_lobby_phone_front()
{
    var_0 = getent( "rb_lobby_phone_1_front", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_0 endon( "death" );
    var_0.alertlevelint = 0;
    var_0 maps\lagos_utility::immune_sonic_blast();
    var_0.animname = "lobby_phone";
    var_1 = getent( "anim_org_rb_lobby_phone_front", "targetname" );
    var_0 attach( "electronics_pda_big", "TAG_WEAPON_RIGHT", 1 );
    var_0.hasattachedprops = 1;
    var_0.attachedpropmodel = "electronics_pda_big";
    var_0.attachedproptag = "TAG_WEAPON_RIGHT";
    var_1 thread maps\_anim::anim_loop_solo( var_0, "phone_loop_1", "stop_loop" );
    common_scripts\utility::flag_wait( "flag_roundabout_player_move_0" );
    var_1 notify( "stop_loop" );
    var_0 setlookatentity( level.player );
    var_1 maps\_anim::anim_single_solo( var_0, "phone_react_1" );
    var_1 thread maps\_anim::anim_loop_solo( var_0, "phone_react_loop_1", "stop_loop" );
    common_scripts\utility::flag_wait( "roundabout_wave_1A_complete" );
    var_1 notify( "stop_loop" );
    var_0 maps\_shg_design_tools::delete_auto();
}

roundabout_lobby_couch_front()
{
    var_0 = getent( "rb_lobby_couch_1_front", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_1 = getent( "rb_lobby_couch_2_front", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_0 endon( "death" );
    var_1 endon( "death" );
    var_0.alertlevelint = 0;
    var_1.alertlevelint = 0;
    var_0 maps\lagos_utility::immune_sonic_blast();
    var_1 maps\lagos_utility::immune_sonic_blast();
    var_0.animname = "lobby_couch";
    var_1.animname = "lobby_couch";
    var_2 = getent( "anim_org_rb_lobby_couch_front", "targetname" );
    var_3 = spawn( "script_model", var_2.origin );
    var_3 setmodel( "npc_exo_launch_pad" );
    var_3.animname = "lobby_tablet";
    var_3 useanimtree( level.scr_animtree["lobby_tablet"] );
    var_2 thread maps\_anim::anim_loop_solo( var_0, "couch_loop_1", "stop_loop" );
    var_2 thread maps\_anim::anim_loop_solo( var_1, "couch_loop_2", "stop_loop" );
    var_2 thread maps\_anim::anim_loop_solo( var_3, "lobby_tablet_loop", "stop_loop" );
    common_scripts\utility::flag_wait( "flag_roundabout_player_move_0" );
    var_2 notify( "stop_loop" );
    var_1 setlookatentity( level.player );
    var_2 thread roundabout_lobby_reacts_into_walk( var_0, "couch_react_1_short" );
    var_2 thread roundabout_lobby_reacts_into_walk( var_1, "couch_react_2_short" );
    var_2 maps\_anim::anim_single_solo_run( var_3, "lobby_tablet_react_short" );
}

roundabout_lobby_elevator()
{
    var_0 = common_scripts\utility::get_noteworthy_ent( "rb_lobby_elevator_door_left" );
    var_1 = common_scripts\utility::get_noteworthy_ent( "rb_lobby_elevator_door_right" );
    var_2 = getent( "rb_lobby_elevator_waiting_1", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_3 = getent( "rb_lobby_elevator_waiting_2", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_4 = getent( "rb_lobby_elevator_exiting_1", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_5 = getent( "rb_lobby_elevator_exiting_2", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_2 endon( "death" );
    var_3 endon( "death" );
    var_4 endon( "death" );
    var_5 endon( "death" );
    var_2.alertlevelint = 0;
    var_3.alertlevelint = 0;
    var_4.alertlevelint = 0;
    var_5.alertlevelint = 0;
    var_2 maps\lagos_utility::immune_sonic_blast();
    var_3 maps\lagos_utility::immune_sonic_blast();
    var_4 maps\lagos_utility::immune_sonic_blast();
    var_5 maps\lagos_utility::immune_sonic_blast();
    var_2.animname = "lobby_elevator";
    var_3.animname = "lobby_elevator";
    var_4.animname = "lobby_elevator";
    var_5.animname = "lobby_elevator";
    var_6 = getent( "anim_org_rb_lobby_elevator_waiting_1", "targetname" );
    var_7 = getent( "anim_org_rb_lobby_elevator_waiting_2", "targetname" );
    var_8 = getent( "anim_org_rb_lobby_elevator_exiting_1", "targetname" );
    var_9 = getent( "anim_org_rb_lobby_elevator_exiting_2", "targetname" );
    var_2 thread roundabout_lobby_elevator_waiting_react_1( var_6 );
    var_3 thread roundabout_lobby_elevator_waiting_react_2( var_7 );
    var_4 thread roundabout_lobby_elevator_exiting_react_1( var_8 );
    var_5 thread roundabout_lobby_elevator_exiting_react_2( var_9 );
    common_scripts\utility::flag_wait( "flag_roundabout_player_move_1" );
    var_0 moveto( ( -52453, 7644, 321.5 ), 1.5, 0.25, 0.25 );
    var_1 moveto( ( -52273, 7644, 321.5 ), 1.5, 0.25, 0.25 );
    common_scripts\utility::flag_wait( "roundabout_wave_1A_complete" );
    var_6 notify( "stop_loop" );
    var_7 notify( "stop_loop" );
    var_8 notify( "stop_loop" );
    var_9 notify( "stop_loop" );
    var_2 maps\_shg_design_tools::delete_auto();
    var_3 maps\_shg_design_tools::delete_auto();
    var_4 maps\_shg_design_tools::delete_auto();
    var_5 maps\_shg_design_tools::delete_auto();
}

roundabout_lobby_elevator_waiting_react_1( var_0 )
{
    self endon( "death" );
    var_0 thread maps\_anim::anim_loop_solo( self, "waiting_react_1_pre", "stop_loop" );
    common_scripts\utility::flag_wait( "flag_roundabout_player_move_0" );
    var_0 notify( "stop_loop" );
    var_0 maps\_anim::anim_single_solo( self, "waiting_react_1" );
    var_0 maps\_anim::anim_loop_solo( self, "waiting_react_loop_1", "stop_loop" );
}

roundabout_lobby_elevator_waiting_react_2( var_0 )
{
    self endon( "death" );
    var_0 thread maps\_anim::anim_loop_solo( self, "waiting_react_2_pre", "stop_loop" );
    common_scripts\utility::flag_wait( "flag_roundabout_player_move_0" );
    var_0 notify( "stop_loop" );
    self setlookatentity( level.player );
    var_0 maps\_anim::anim_single_solo( self, "waiting_react_2" );
    var_0 maps\_anim::anim_loop_solo( self, "waiting_react_loop_2", "stop_loop" );
}

roundabout_lobby_elevator_exiting_react_1( var_0 )
{
    self endon( "death" );
    var_0 maps\_anim::anim_first_frame_solo( self, "exiting_react_1" );
    common_scripts\utility::flag_wait( "flag_roundabout_player_move_1" );
    wait 1.5;
    self setlookatentity( level.player );
    var_0 maps\_anim::anim_single_solo( self, "exiting_react_1" );
    var_0 maps\_anim::anim_loop_solo( self, "exiting_react_loop_1", "stop_loop" );
}

roundabout_lobby_elevator_exiting_react_2( var_0 )
{
    self endon( "death" );
    var_0 maps\_anim::anim_first_frame_solo( self, "exiting_react_2" );
    common_scripts\utility::flag_wait( "flag_roundabout_player_move_1" );
    wait 1.5;
    var_0 maps\_anim::anim_single_solo( self, "exiting_react_2" );
    var_0 maps\_anim::anim_loop_solo( self, "exiting_react_loop_2", "stop_loop" );
}

roundabout_lobby_reacts_into_walk( var_0, var_1 )
{
    maps\_anim::anim_single_solo_run( var_0, var_1 );
    var_0 fleeingcivilian_roundaboutexit_lobby( "civilian_goal_Roundabout_delete_front" );
}

roundabout_lobby_couch()
{
    var_0 = getent( "rb_lobby_couch_1", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_1 = getent( "rb_lobby_couch_2", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_0 endon( "death" );
    var_1 endon( "death" );
    var_0.alertlevelint = 0;
    var_1.alertlevelint = 0;
    var_0 maps\lagos_utility::immune_sonic_blast();
    var_1 maps\lagos_utility::immune_sonic_blast();
    var_0.animname = "lobby_couch";
    var_1.animname = "lobby_couch";
    var_2 = getent( "anim_org_rb_lobby_couch", "targetname" );
    var_2 thread maps\_anim::anim_loop_solo( var_0, "couch_loop_1", "stop_loop" );
    var_2 thread maps\_anim::anim_loop_solo( var_1, "couch_loop_2", "stop_loop" );
    common_scripts\utility::flag_wait( "flag_roundabout_player_move_1" );
    var_2 notify( "stop_loop" );
    var_1 setlookatentity( level.player );
    var_2 thread roundabout_lobby_reacts_into_walk( var_0, "couch_react_1" );
    var_2 thread roundabout_lobby_reacts_into_walk( var_1, "couch_react_2" );
}

roundabout_lobby_security_desk()
{
    var_0 = getent( "rb_lobby_security_desk_1", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_1 = getent( "rb_lobby_security_desk_2", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_0 endon( "death" );
    var_1 endon( "death" );
    var_0.alertlevelint = 0;
    var_1.alertlevelint = 0;
    var_0 maps\lagos_utility::immune_sonic_blast();
    var_1 maps\lagos_utility::immune_sonic_blast();
    var_0.animname = "lobby_security";
    var_1.animname = "lobby_security";
    level.civilian_roundabout_vo_2 = var_0;
    var_2 = getent( "anim_org_rb_lobby_security_desk", "targetname" );
    var_3 = getent( "anim_org_rb_lobby_security_desk_2", "targetname" );
    var_2 thread maps\_anim::anim_loop_solo( var_0, "security_loop_1", "stop_loop" );
    var_3 thread maps\_anim::anim_loop_solo( var_1, "security_loop_2", "stop_loop" );
    common_scripts\utility::flag_wait( "flag_roundabout_player_move_2" );
    var_3 notify( "stop_loop" );
    var_1 setlookatentity( level.player );
    var_3 maps\_anim::anim_single_solo( var_1, "security_react_2" );
    var_3 maps\_anim::anim_single_solo( var_1, "security_react_loop_2" );
    var_1 thread fleeingcivilian_roundaboutexit_lobby( "civilian_goal_Roundabout_delete_front" );
    common_scripts\utility::flag_wait( "roundabout_wave_1A_complete" );
    var_2 notify( "stop_loop" );
    var_0 maps\_shg_design_tools::delete_auto();
}

roundabout_lobby_phone()
{
    var_0 = getent( "rb_lobby_phone_1", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_0 endon( "death" );
    var_0.alertlevelint = 0;
    var_0 maps\lagos_utility::immune_sonic_blast();
    var_0.animname = "lobby_phone";
    var_1 = getent( "anim_org_rb_lobby_phone_1", "targetname" );
    var_0 attach( "electronics_pda_big", "TAG_WEAPON_RIGHT", 1 );
    var_0.hasattachedprops = 1;
    var_0.attachedpropmodel = "electronics_pda_big";
    var_0.attachedproptag = "TAG_WEAPON_RIGHT";
    common_scripts\utility::flag_wait( "flag_roundabout_move_1" );
    var_0 setlookatentity( level.player );
    var_1 thread maps\_anim::anim_single_solo( var_0, "phone_react_1" );
    var_1 thread maps\_anim::anim_loop_solo( var_0, "phone_react_loop_1", "stop_loop" );
    common_scripts\utility::flag_wait( "roundabout_wave_1A_complete" );
    var_1 notify( "stop_loop" );
    var_0 maps\_shg_design_tools::delete_auto();
}

roundabout_lobby_phone2()
{
    var_0 = getent( "rb_lobby_phone_2", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_0 endon( "death" );
    var_0.alertlevelint = 0;
    var_0 maps\lagos_utility::immune_sonic_blast();
    var_0.animname = "lobby_phone";
    var_1 = getent( "anim_org_rb_lobby_phone_2", "targetname" );
    var_0 attach( "electronics_pda_big", "TAG_WEAPON_RIGHT", 1 );
    var_0.hasattachedprops = 1;
    var_0.attachedpropmodel = "electronics_pda_big";
    var_0.attachedproptag = "TAG_WEAPON_RIGHT";
    common_scripts\utility::flag_wait( "flag_roundabout_move_1" );
    var_1 maps\_anim::anim_single_solo( var_0, "phone_react_2" );
    var_0 thread fleeingcivilian_roundaboutexit_lobby( "civilian_goal_Roundabout_delete_front" );

    if ( isdefined( var_0.attachedpropmodel ) )
    {
        var_0 detach( "electronics_pda_big", "TAG_WEAPON_RIGHT" );
        var_0.hasattachedprops = undefined;
    }

    common_scripts\utility::flag_wait( "roundabout_wave_1A_complete" );
    var_0 maps\_shg_design_tools::delete_auto();
}

roundabout_lobby_walkingtalk()
{
    var_0 = getent( "rb_lobby_walktalk_1", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_1 = getent( "rb_lobby_walktalk_2", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_0 endon( "death" );
    var_1 endon( "death" );
    var_0.alertlevelint = 0;
    var_1.alertlevelint = 0;
    var_0 maps\lagos_utility::immune_sonic_blast();
    var_1 maps\lagos_utility::immune_sonic_blast();
    var_0.animname = "lobby_walktalk";
    var_1.animname = "lobby_walktalk";
    var_2 = getent( "anim_org_rb_lobby_walkingtalk", "targetname" );
    common_scripts\utility::flag_wait( "flag_roundabout_move_1" );
    var_2 thread roundabout_lobby_reacts_into_walk( var_0, "walktalk_react_1" );
    var_2 thread roundabout_lobby_reacts_into_walk( var_1, "walktalk_react_2" );
}

roundabout_street_drop_bikes()
{
    var_0 = getent( "rb_street_bike_drop_1", "targetname" ) maps\_utility::spawn_ai( 1, 1 );
    var_1 = getent( "rb_street_bike_drop_2", "targetname" ) maps\_utility::spawn_ai( 1, 1 );
    var_0 endon( "death" );
    var_1 endon( "death" );
    level.civilian_roundabout_vo_3 = var_0;
    var_0.alertlevelint = 0;
    var_1.alertlevelint = 0;
    var_0 maps\lagos_utility::immune_sonic_blast();
    var_1 maps\lagos_utility::immune_sonic_blast();
    var_0.animname = "street_drop_bike";
    var_1.animname = "street_drop_bike";
    var_2 = getent( "anim_org_rb_street_bike_drop", "targetname" );
    var_3 = spawn( "script_model", var_2.origin );
    var_3 setmodel( "s1_bicycle" );
    var_3.animname = "bike";
    var_3 useanimtree( level.scr_animtree["bike"] );
    common_scripts\utility::flag_wait( "flag_roundabout_traffic_move" );
    var_2 thread maps\_anim::anim_loop_solo( var_0, "drop_bike_loop_1", "stop_loop" );
    var_2 thread maps\_anim::anim_loop_solo( var_1, "drop_bike_loop_2", "stop_loop" );
    var_2 thread maps\_anim::anim_loop_solo( var_3, "drop_bike_loop", "stop_loop" );
    common_scripts\utility::flag_wait( "roundabout_combat_starting_soon" );
    var_2 notify( "stop_loop" );
    var_2 thread maps\_anim::anim_single_solo( var_3, "drop_bike_react" );
    var_2 thread maps\_anim::anim_single_solo( var_0, "drop_bike_react_1", undefined, 5.25 );
    var_2 maps\_anim::anim_single_solo( var_1, "drop_bike_react_2", undefined, 5.25 );
    var_0 thread maps\lagos_utility::civilain_flee_to_goal();
    var_1 thread maps\lagos_utility::civilain_flee_to_goal();
}

roundabout_street_car_hood_hit()
{
    var_0 = getent( "rb_car_hood_exit", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_0.alertlevelint = 0;
    var_0 maps\lagos_utility::immune_sonic_blast();
    var_0.animname = "car_hood";
    var_1 = getent( "anim_org_rb_burke_hood_stop", "targetname" );
    var_2 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_NW_4" );
    var_2.animname = "car_hood";
    var_1 maps\_anim::anim_first_frame_solo( var_2, "car_drive_hood_stop" );
    var_2.damage_functions = [];
    var_2 maps\_utility::add_damage_function( ::roundabout_rpg_car_damage_function );
    common_scripts\utility::flag_wait( "flag_roundabout_move_2" );
    level.burke maps\_utility::disable_ai_color();
    common_scripts\utility::flag_set( "roundabout_combat_starting_soon" );
    var_1 maps\_anim::anim_reach_solo( level.burke, "burke_car_hood" );
    common_scripts\utility::flag_set( "roundabout_burke_hood_anim_begin" );
    var_1 thread maps\_anim::anim_single_solo( var_2, "car_drive_hood_stop" );

    if ( !common_scripts\utility::flag( "roundabout_combat_begin" ) )
    {
        var_1 thread maps\_anim::anim_single_solo( level.burke, "burke_car_hood" );

        if ( isdefined( var_0 ) && isalive( var_0 ) )
            thread roundabout_street_car_hood_hit_driver( var_1, var_0 );

        wait 7;
        common_scripts\utility::flag_set( "roundabout_combat_begin" );
    }

    level.burke maps\_utility::enable_ai_color();
}

roundabout_rpg_car_damage_function( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( var_4 == "MOD_PROJECTILE" )
        maps\lagos_utility::rumble_roundabout_rpg_car_hit();
}

roundabout_street_car_hood_hit_driver( var_0, var_1 )
{
    var_1 endon( "death" );

    if ( isdefined( var_1 ) && isalive( var_1 ) )
        var_0 thread maps\_anim::anim_single_solo( var_1, "guy_exit_car" );

    if ( isdefined( var_1 ) && isalive( var_1 ) )
        var_1 thread maps\lagos_utility::civilain_flee_to_goal();
}

fleeingcivilian_roundaboutexit_lobby( var_0 )
{
    if ( isdefined( self ) && isalive( self ) )
    {
        self setlookatentity();
        self.ignoreall = 1;
        self.ignoreme = 1;
        self setgoalvolumeauto( getent( var_0, "targetname" ) );
        thread maps\lagos_utility::cleanup_on_goal();
    }
}

spawnmalecivilians_roundabout()
{
    var_0 = getent( "civilian_male_roundabout", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "node_roundabout_male_standing", "targetname" );
    var_2 = maps\lagos_utility::populate_ai_civilians( var_0, var_1, 1, "flag_Roundabout_Civilians_Flee" );
    common_scripts\utility::flag_wait( "roundabout_wave_1A_complete" );

    foreach ( var_4 in var_2 )
    {
        if ( isdefined( var_4 ) )
            var_4 delete();
    }

    common_scripts\utility::flag_wait( "roundabout_wave_3_complete" );
    var_0 = getent( "civilian_male_roundabout_outro", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "node_roundabout_male_standing_outro", "targetname" );
    var_2 = maps\lagos_utility::populate_drone_civilians( var_0, var_1 );
    common_scripts\utility::flag_wait( "flag_delete_roundabout_vehicles" );

    foreach ( var_4 in var_2 )
    {
        if ( isdefined( var_4 ) )
            var_4 delete();
    }
}

spawnfemalecivilians_roundabout()
{
    var_0 = getent( "civilian_female_roundabout", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "node_roundabout_female_standing", "targetname" );
    var_2 = maps\lagos_utility::populate_ai_civilians( var_0, var_1, 1, "flag_Roundabout_Civilians_Flee" );
    common_scripts\utility::flag_wait( "roundabout_wave_1A_complete" );

    foreach ( var_4 in var_2 )
    {
        if ( isdefined( var_4 ) )
            var_4 delete();
    }

    common_scripts\utility::flag_wait( "roundabout_wave_3_complete" );
    var_0 = getent( "civilian_female_roundabout_outro", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "node_roundabout_female_standing_outro", "targetname" );
    var_2 = maps\lagos_utility::populate_drone_civilians( var_0, var_1 );
    common_scripts\utility::flag_wait( "flag_delete_roundabout_vehicles" );

    foreach ( var_4 in var_2 )
    {
        if ( isdefined( var_4 ) )
            var_4 delete();
    }
}

spawnwalkingcivilians_roundabout()
{
    var_0 = getent( "badPlace_roundabout_center", "targetname" );
    badplace_cylinder( "civilian_badPlace_roundabout_center", -1, var_0.origin, 505, 200, "neutral" );
}

roundabout_traffic()
{
    if ( level.nextgen )
        common_scripts\utility::flag_wait( "flag_roundabout_spawn_vehicles" );
    else if ( !istransientloaded( "lagos_middle_tr" ) )
        level waittill( "tff_post_intro_to_middle" );

    if ( level.currentgen )
    {
        roundabout_lobby_vehicles_cg();
        thread roundabout_center_vehicles_cg();
    }
    else
    {
        roundabout_lobby_vehicles();
        thread roundabout_center_vehicles();
    }

    if ( level.nextgen )
        thread maps\lagos_utility::start_vehicle_traffic_roundabout_straightways();

    common_scripts\utility::flag_wait( "flag_delete_roundabout_vehicles" );
    var_0 = common_scripts\utility::array_combine( level.roundabout_center_vehicles, level.roundabout_lobby_vehicles );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) )
            var_2 delete();
    }

    maps\lagos_utility::delete_vehicle_traffic_roundabout_straightways();
}

roundabout_lobby_vehicles()
{
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname( "roundabout_lobby_1" );
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname( "roundabout_lobby_2" );
    var_2 = maps\_vehicle::spawn_vehicle_from_targetname( "roundabout_lobby_3" );
    var_3 = maps\_vehicle::spawn_vehicle_from_targetname( "roundabout_lobby_4" );
    var_4 = maps\_vehicle::spawn_vehicle_from_targetname( "roundabout_lobby_5" );
    var_5 = maps\_vehicle::spawn_vehicle_from_targetname( "roundabout_lobby_6" );
    var_6 = maps\_vehicle::spawn_vehicle_from_targetname( "roundabout_lobby_7" );
    var_7 = maps\_vehicle::spawn_vehicle_from_targetname( "roundabout_lobby_8" );
    var_8 = maps\_vehicle::spawn_vehicle_from_targetname( "roundabout_lobby_9" );
    var_9 = maps\_vehicle::spawn_vehicle_from_targetname( "roundabout_lobby_10" );
    var_10 = [ "roundabout_lobby_1", "roundabout_lobby_2", "roundabout_lobby_3", "roundabout_lobby_4", "roundabout_lobby_5", "roundabout_lobby_6", "roundabout_lobby_7", "roundabout_lobby_8", "roundabout_lobby_9", "roundabout_lobby_10" ];
    level.roundabout_lobby_vehicles = [ var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 ];
}

roundabout_center_vehicles()
{
    roundabout_setup_center_vehicles();
    roundabout_setup_center_vehicle_nodes();
    common_scripts\utility::flag_wait( "flag_roundabout_traffic_move" );

    for ( var_0 = 0; var_0 < level.roundabout_center_vehicles.size; var_0++ )
    {
        level.roundabout_center_vehicles[var_0] thread maps\_vehicle::vehicle_paths( level.roundabout_center_vehicle_nodes[var_0] );
        level.roundabout_center_vehicles[var_0] startpath( level.roundabout_center_vehicle_nodes[var_0] );
    }
}

roundabout_setup_center_vehicles()
{
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_W_1" );
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_W_2" );
    var_2 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_W_3" );
    var_3 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_W_4" );
    var_4 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_W_5" );
    var_5 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_NW_1" );
    var_6 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_NW_2" );
    var_7 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_NW_3" );
    var_8 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_N_1" );
    var_9 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_N_2" );
    var_10 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_N_3" );
    var_11 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_N_4" );
    var_12 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_N_5" );
    var_13 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_NE_1" );
    var_14 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_NE_2" );
    var_15 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_NE_3" );
    var_16 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_NE_4" );
    var_17 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_E_1" );
    var_18 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_E_2" );
    var_19 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_E_3" );
    var_20 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_E_4" );
    var_21 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_E_5" );
    var_22 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_SE_1" );
    var_23 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_SE_2" );
    var_24 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_SE_3" );
    var_25 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_SE_4" );
    var_26 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_S_1" );
    var_27 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_S_2" );
    var_28 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_S_3" );
    var_29 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_S_4" );
    var_30 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_S_5" );
    var_31 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_SW_1" );
    var_32 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_SW_2" );
    var_33 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_SW_3" );
    var_34 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_SW_4" );
    level.roundabout_center_vehicles = [ var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18, var_19, var_20, var_21, var_22, var_23, var_24, var_25, var_26, var_27, var_28, var_29, var_30, var_31, var_32, var_33, var_34 ];
    var_35 = [ "rb_W_1", "rb_W_2", "rb_W_3", "rb_W_4", "rb_W_5", "rb_NW_1", "rb_NW_2", "rb_NW_3", "rb_N_1", "rb_N_2", "rb_N_3", "rb_N_4", "rb_N_5", "rb_NE_1", "rb_NE_2", "rb_NE_3", "rb_NE_4" ];

    foreach ( var_37 in var_35 )
    {
        maps\lagos_utility::civilian_get_out_of_car_setup( var_37, "civ_roundabout_driver_ai", "drivers_get_out" );
        wait 0.05;
    }

    thread roundabout_swap_vehicle_for_model( var_27, "rb_S_2_swap" );
    thread roundabout_swap_vehicle_for_model( var_14, "rb_NE_2_swap" );
}

roundabout_swap_vehicle_for_model( var_0, var_1 )
{
    var_2 = getentarray( var_1, "targetname" );

    foreach ( var_4 in var_2 )
    {
        if ( issubstr( var_4.classname, "script_model" ) || issubstr( var_4.classname, "script_brushmodel" ) )
        {
            var_4 hide();
            var_4 setcontents( 0 );
        }
    }

    common_scripts\utility::flag_wait( "roundabout_combat_begin" );

    foreach ( var_4 in var_2 )
    {
        if ( issubstr( var_4.classname, "script_model" ) || issubstr( var_4.classname, "script_brushmodel" ) )
        {
            var_4 show();
            var_4 setcontents( 1 );
        }
    }

    level.roundabout_center_vehicles = common_scripts\utility::array_remove( level.roundabout_center_vehicles, var_0 );
    var_0 delete();
    common_scripts\utility::flag_wait( "flag_delete_roundabout_vehicles" );

    foreach ( var_4 in var_2 )
        var_4 delete();
}

roundabout_setup_center_vehicle_nodes()
{
    var_0 = getvehiclenode( "node_rb_W_1", "targetname" );
    var_1 = getvehiclenode( "node_rb_W_2", "targetname" );
    var_2 = getvehiclenode( "node_rb_W_3", "targetname" );
    var_3 = getvehiclenode( "node_rb_W_4", "targetname" );
    var_4 = getvehiclenode( "node_rb_W_5", "targetname" );
    var_5 = getvehiclenode( "node_rb_NW_1", "targetname" );
    var_6 = getvehiclenode( "node_rb_NW_2", "targetname" );
    var_7 = getvehiclenode( "node_rb_NW_3", "targetname" );
    var_8 = getvehiclenode( "node_rb_N_1", "targetname" );
    var_9 = getvehiclenode( "node_rb_N_2", "targetname" );
    var_10 = getvehiclenode( "node_rb_N_3", "targetname" );
    var_11 = getvehiclenode( "node_rb_N_4", "targetname" );
    var_12 = getvehiclenode( "node_rb_N_5", "targetname" );
    var_13 = getvehiclenode( "node_rb_NE_1", "targetname" );
    var_14 = getvehiclenode( "node_rb_NE_2", "targetname" );
    var_15 = getvehiclenode( "node_rb_NE_3", "targetname" );
    var_16 = getvehiclenode( "node_rb_NE_4", "targetname" );
    var_17 = getvehiclenode( "node_rb_E_1", "targetname" );
    var_18 = getvehiclenode( "node_rb_E_2", "targetname" );
    var_19 = getvehiclenode( "node_rb_E_3", "targetname" );
    var_20 = getvehiclenode( "node_rb_E_4", "targetname" );
    var_21 = getvehiclenode( "node_rb_E_5", "targetname" );
    var_22 = getvehiclenode( "node_rb_SE_1", "targetname" );
    var_23 = getvehiclenode( "node_rb_SE_2", "targetname" );
    var_24 = getvehiclenode( "node_rb_SE_3", "targetname" );
    var_25 = getvehiclenode( "node_rb_SE_4", "targetname" );
    var_26 = getvehiclenode( "node_rb_S_1", "targetname" );
    var_27 = getvehiclenode( "node_rb_S_2", "targetname" );
    var_28 = getvehiclenode( "node_rb_S_3", "targetname" );
    var_29 = getvehiclenode( "node_rb_S_4", "targetname" );
    var_30 = getvehiclenode( "node_rb_S_5", "targetname" );
    var_31 = getvehiclenode( "node_rb_SW_1", "targetname" );
    var_32 = getvehiclenode( "node_rb_SW_2", "targetname" );
    var_33 = getvehiclenode( "node_rb_SW_3", "targetname" );
    var_34 = getvehiclenode( "node_rb_SW_4", "targetname" );
    level.roundabout_center_vehicle_nodes = [ var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18, var_19, var_20, var_21, var_22, var_23, var_24, var_25, var_26, var_27, var_28, var_29, var_30, var_31, var_32, var_33, var_34 ];
}

roundabout_lobby_vehicles_cg()
{
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname( "roundabout_lobby_5" );
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname( "roundabout_lobby_6" );
    var_2 = maps\_vehicle::spawn_vehicle_from_targetname( "roundabout_lobby_9" );
    var_3 = [ "roundabout_lobby_5", "roundabout_lobby_6", "roundabout_lobby_9" ];
    level.roundabout_lobby_vehicles = [ var_0, var_1, var_2 ];
}

roundabout_center_vehicles_cg()
{
    roundabout_setup_center_vehicles_cg();
    roundabout_setup_center_vehicle_nodes_cg();
    common_scripts\utility::flag_wait( "flag_roundabout_traffic_move" );

    for ( var_0 = 0; var_0 < level.roundabout_center_vehicles_moving.size; var_0++ )
    {
        level.roundabout_center_vehicles_moving[var_0] thread maps\_vehicle::vehicle_paths( level.roundabout_center_vehicle_nodes_cg[var_0] );
        level.roundabout_center_vehicles_moving[var_0] startpath( level.roundabout_center_vehicle_nodes_cg[var_0] );
        wait(randomfloatrange( 0.1, 0.25 ));
    }
}

roundabout_setup_center_vehicles_cg()
{
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_W_1" );
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_W_2" );
    var_2 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_W_3" );
    var_3 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_W_4" );
    var_4 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_W_5" );
    var_5 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_NW_3" );
    var_6 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_N_4" );
    var_7 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_NE_1" );
    var_8 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_E_1" );
    var_9 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_E_3" );
    var_10 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_SE_2" );
    var_11 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_SE_3" );
    var_12 = maps\_vehicle::spawn_vehicle_from_targetname( "rb_SW_3" );
    level.roundabout_center_vehicles = [ var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12 ];
    level.roundabout_center_vehicles_moving = [ var_2, var_5, var_1, var_3 ];
    var_13 = [ "rb_W_1", "rb_W_2", "rb_W_4", "rb_W_5", "rb_NW_3", "rb_N_4", "rb_NE_1" ];
    level.roundabout_center_vehicles_tank_explo = [ var_10, var_0, var_4 ];

    foreach ( var_15 in var_13 )
    {
        maps\lagos_utility::civilian_get_out_of_car_setup( var_15, "civ_roundabout_driver_ai", "drivers_get_out" );
        wait 0.05;
    }
}

roundabout_setup_center_vehicle_nodes_cg()
{
    var_0 = getvehiclenode( "node_rb_W_3", "targetname" );
    var_1 = getvehiclenode( "node_rb_NW_3", "targetname" );
    var_2 = getvehiclenode( "node_rb_W_2", "targetname" );
    var_3 = getvehiclenode( "node_rb_W_4", "targetname" );
    level.roundabout_center_vehicle_nodes_cg = [ var_0, var_1, var_2, var_3 ];
}

alley1_combat()
{
    common_scripts\utility::flag_wait( "vo_alley1" );
    soundscripts\_snd::snd_message( "crossing_into_alley" );
    thread maps\lagos_vo::alley_a_dialogue();
    common_scripts\utility::flag_wait( "alley1_spawn" );
    soundscripts\_snd::snd_message( "roundabout_exited" );
    level.alley1_kva = [];
    thread alley1_stage1_combat();
    thread alley1_stage2_combat();
    thread alley1_stage3_combat();

    if ( common_scripts\utility::flag( "alley1_playerstart" ) )
    {
        var_0 = getnode( "alley1_burke_start", "targetname" );
        var_1 = getnode( "alley1_joker_start", "targetname" );
        var_2 = getnode( "alley1_ajani_start", "targetname" );
        level.burke maps\_utility::teleport_ai( var_0 );
        level.joker maps\_utility::teleport_ai( var_1 );
        level.ajani maps\_utility::teleport_ai( var_2 );
    }

    level notify( "alley1_stage1_go" );
}

alley1_veh_destro()
{
    var_0 = getent( "alley1_veh_destro", "targetname" );
    var_1 = common_scripts\utility::getstruct( "alley1_veh_destro_impulse_org", "targetname" );
    common_scripts\utility::flag_wait( "alley1_veh_destro_hit" );
    var_0 maps\_vehicle::vehicle_set_health( 1 );
    radiusdamage( var_1.origin, 350, 10000, 9000 );
    physicsexplosionsphere( var_1.origin, 350, 300, 3 );
}

alley1_stage1_combat()
{
    level waittill( "alley1_stage1_go" );
    var_0 = 3;
    maps\_utility::activate_trigger( "alley1_stage1_ally_goto", "targetname", level.player );
    var_1 = [];
    var_2 = maps\_utility::array_spawn_targetname( "alley1_stage1_enemy" );

    foreach ( var_4 in var_2 )
    {
        var_4 setengagementmaxdist( 256, 512 );
        level.alley1_kva = common_scripts\utility::array_add( level.alley1_kva, var_4 );
        var_1 = common_scripts\utility::array_add( var_1, var_4 );
        var_4.allowdeath = 1;
        var_4 maps\_utility::disable_long_death();
        var_4 maps\lagos_utility::equip_microwave_grenade();

        if ( isdefined( var_4.script_parameters ) )
        {
            if ( var_4.script_parameters == "stage3_ally" )
            {
                var_4 maps\lagos_utility::assign_goal_vol( "alley1_stage3_ally" );
                var_4 thread maps\lagos_utility::ignore_until_goal_reached();
            }
        }
    }

    var_6 = [];
    var_7 = getentarray( "alley1_stage1_refill", "targetname" );

    foreach ( var_9 in var_7 )
    {
        var_4 = var_9 maps\_utility::spawn_ai( 1 );
        waitframe();
        level.alley1_kva = common_scripts\utility::array_add( level.alley1_kva, var_4 );
        var_6 = common_scripts\utility::array_add( var_6, var_4 );
        var_4.allowdeath = 1;
        var_4 maps\_utility::disable_long_death();
        var_4 maps\lagos_utility::equip_microwave_grenade();
        var_4 thread maps\lagos_utility::ignore_until_goal_reached();
        var_4 thread alley1_stage1_rooftop_movedown();
    }

    waitframe();
    maps\_utility::activate_trigger( "alley1_stage1_ally_trigger", "targetname", level.player );
    var_11 = 0;

    while ( !var_11 )
    {
        level.alley1_kva = maps\_utility::array_removedead_or_dying( level.alley1_kva );
        var_1 = maps\_utility::array_removedead_or_dying( var_1 );

        if ( level.alley1_kva.size < var_0 )
        {
            foreach ( var_4 in level.alley1_kva )
            {
                var_4 maps\_utility::player_seek_disable();
                waitframe();
                var_4 maps\lagos_utility::assign_goal_vol( "alley1_stage2_vol2" );
            }

            var_11 = 1;
            level notify( "alley1_stage2_go" );
        }

        waitframe();
    }
}

alley1_stage1_rooftop_movedown()
{
    wait(randomintrange( 5, 8 ));
    maps\lagos_utility::assign_goal_vol( "alley1_stage1_vol1" );
}

alley1_force_deaths()
{
    common_scripts\utility::flag_wait( "alley1_oncoming_start" );

    foreach ( var_1 in self )
    {
        if ( isdefined( var_1 ) && isalive( var_1 ) )
            var_1 kill();
    }
}

alley1_stage2_combat_flag()
{
    common_scripts\utility::flag_wait( "flag_alley1_combat_stage_2" );
    level notify( "alley1_stage2_go" );
}

alley1_stage2_combat()
{
    thread alley1_stage2_combat_flag();
    level waittill( "alley1_stage2_go" );
    level endon( "alley1_stage3_go" );
    setthreatbias( "friendly_squad", "player_haters", -10000 );
    setthreatbias( "player_haters", "friendly_squad", -10000 );
    setthreatbias( "player_haters", "player", 10000 );
    level.player setthreatbiasgroup( "player" );
    var_0 = 3;
    var_1 = 1;
    var_2 = [];
    var_3 = getent( "alley1_stage2_balcony_enemy", "targetname" );
    var_4 = 1;
    var_5 = [];
    var_6 = getent( "alley1_stage2_ground_enemy", "targetname" );

    for ( var_7 = 0; var_7 < var_1; var_7++ )
    {
        var_8 = var_3 maps\_utility::spawn_ai( 1 );
        var_3.count = 1;
        waitframe();
        var_2 = common_scripts\utility::array_add( var_2, var_8 );
        level.alley1_kva = common_scripts\utility::array_add( level.alley1_kva, var_8 );
        var_8.allowdeath = 1;
        var_8 maps\_utility::disable_long_death();
        var_8 maps\lagos_utility::equip_microwave_grenade();
        var_8 setengagementmaxdist( 256, 512 );
        var_8 maps\lagos_utility::assign_goal_vol( "alley1_stage2_vol1" );
    }

    var_9 = getent( "alley1_stage2_balcony_enemy_A", "targetname" ) maps\_utility::spawn_ai( 1 );
    level.alley1_kva = common_scripts\utility::array_add( level.alley1_kva, var_9 );
    var_9 setengagementmaxdist( 256, 512 );
    var_9 maps\lagos_utility::assign_goal_vol( "alley1_stage2_vol1_A" );
    var_2 thread alley1_force_deaths();

    for ( var_7 = 0; var_7 < var_4; var_7++ )
    {
        var_8 = var_6 maps\_utility::spawn_ai( 1 );
        var_6.count = 1;
        waitframe();
        var_5 = common_scripts\utility::array_add( var_5, var_8 );
        level.alley1_kva = common_scripts\utility::array_add( level.alley1_kva, var_8 );
        var_8.allowdeath = 1;
        var_8 maps\_utility::disable_long_death();
        var_8 maps\lagos_utility::equip_microwave_grenade();
        var_8 setengagementmaxdist( 256, 512 );
        var_8 maps\lagos_utility::assign_goal_vol( "alley1_stage2_vol2" );
    }

    maps\_utility::activate_trigger( "alley1_stage2_ally_trigger", "targetname", level.player );
    maps\_utility::array_spawn_targetname( "alley1_stage3_refill", 1 );
    var_10 = 0;

    while ( !var_10 )
    {
        level.alley1_kva = maps\_utility::array_removedead_or_dying( level.alley1_kva );

        if ( level.alley1_kva.size < var_0 )
        {
            foreach ( var_8 in level.alley1_kva )
            {
                if ( isdefined( var_8 ) )
                    var_8 thread maps\_utility::player_seek_enable();
            }

            var_10 = 1;
            level notify( "alley1_stage3_go" );
        }

        waitframe();
    }
}

alley1_stage3_combat_flag()
{
    common_scripts\utility::flag_wait( "flag_alley1_combat_stage_3" );
    level notify( "alley1_stage3_go" );
}

alley1_stage3_combat()
{
    thread alley1_stage3_combat_flag();
    level waittill( "alley1_stage3_go" );
    level endon( "alley1_stage3_end" );
    var_0 = 3;
    thread alley1_oncoming_goto();
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "alley1_stage3_vehicle" );
    var_1 thread maps\lagos_utility::vehicle_unload_how_at_end();

    if ( level.currentgen )
    {
        var_1 thread alley_veh_god_on();
        var_1 thread tff_cleanup_vehicle( "alley" );
    }

    waitframe();
    var_2 = [];
    var_2 = var_1.riders;

    foreach ( var_4 in var_2 )
    {
        var_4 maps\lagos_utility::assign_goal_vol( "alley1_stage3_vol1" );
        level.alley1_kva = common_scripts\utility::array_add( level.alley1_kva, var_4 );
        var_4.allowdeath = 1;
        var_4 maps\_utility::disable_long_death();
        var_4 maps\lagos_utility::equip_microwave_grenade();
        var_4 setengagementmaxdist( 256, 512 );
    }

    wait 1;
    maps\_utility::activate_trigger( "alley1_stage3_ally_trigger", "targetname", level.player );

    for (;;)
    {
        level.alley1_kva = maps\_utility::array_removedead_or_dying( level.alley1_kva );

        if ( level.alley1_kva.size < var_0 )
        {
            foreach ( var_4 in level.alley1_kva )
            {
                if ( isdefined( var_4 ) )
                {
                    var_4 thread maps\_utility::player_seek_enable();
                    var_4 maps\_utility::delaythread( 5, maps\lagos_utility::bloody_death, randomintrange( 1, 3 ) );
                }
            }
        }

        if ( level.alley1_kva.size == 0 )
        {
            level notify( "alley_oncoming_ally_goto" );
            common_scripts\utility::flag_set( "flag_alley1_clear" );
            common_scripts\utility::flag_set( "obj_pos_pursue_hostage_truck_oncoming1_wait" );
            waitframe();
            level notify( "alley1_stage3_end" );
        }

        waitframe();
    }
}

alley_veh_god_on()
{
    maps\_vehicle::godon();
    self waittill( "reached_end_node" );
    wait 2;
    maps\_vehicle::godoff();
}

alley1_oncoming_goto()
{
    level waittill( "alley_oncoming_ally_goto" );
    maps\_utility::activate_trigger( "alley_oncoming_trigger", "targetname", level.player );
}

alley1_oncoming()
{
    var_0 = getent( "alley_oncoming_trigger_start", "targetname" );
    var_0 makeunusable();
    var_1 = getnode( "oncoming_anim_joker_goto", "targetname" );
    var_2 = getnode( "oncoming_anim_ajani_goto", "targetname" );
    var_3 = getnode( "alley2_joker_start", "targetname" );
    var_4 = getnode( "alley2_ajani_start", "targetname" );

    if ( level.currentgen )
    {
        if ( level.start_point != "alley_1" && level.start_point != "oncoming_alley" && level.start_point != "alley_2" )
            level waittill( "tff_post_load_alley" );
    }

    var_5 = getent( "anim_org_alley_1_gate_open", "targetname" );
    var_6 = getent( "oncoming_gate", "targetname" );
    var_6.animname = "oncoming_gate";
    var_6 maps\_utility::assign_animtree();
    var_5 thread maps\_anim::anim_first_frame_solo( var_6, "oncoming_gate_open" );
    var_7 = getent( "oncoming_gate_blocker", "targetname" );
    var_7 linkto( var_6, "gateSlide" );
    var_7 disconnectpaths();
    var_8 = [ level.joker, var_6 ];
    level waittill( "alley_oncoming_ally_goto" );
    thread maps\lagos_vo::alley_1_complete_dialogue();
    common_scripts\utility::flag_wait( "alley1_oncoming_start" );

    if ( common_scripts\utility::flag( "oncoming_downhill_playerstart" ) )
    {
        var_9 = getnode( "alley_oncoming_burke", "targetname" );
        var_10 = getnode( "alley_oncoming_joker", "targetname" );
        var_11 = getnode( "alley_oncoming_ajani", "targetname" );
        level.burke maps\_utility::teleport_ai( var_9 );
        level.joker maps\_utility::teleport_ai( var_10 );
        level.ajani maps\_utility::teleport_ai( var_11 );
    }

    level.burke maps\_utility::disable_pain();
    level.joker maps\_utility::disable_pain();
    level.ajani maps\_utility::disable_pain();
    level.burke thread alley1_oncoming_grenade_awareness();
    level.joker thread alley1_oncoming_grenade_awareness();
    level.ajani thread alley1_oncoming_grenade_awareness();
    thread alley1_oncoming_burke_alley_enter();
    var_5 maps\_anim::anim_reach_solo( level.joker, "oncoming_gate_open" );
    soundscripts\_snd::snd_message( "alley_1_big_metal_gate" );
    var_5 thread maps\_anim::anim_single_solo( var_6, "oncoming_gate_open" );
    var_5 thread maps\_anim::anim_single_run_solo( level.joker, "oncoming_gate_open" );
    common_scripts\utility::flag_set( "alley_oncoming_gate_lighting" );
    wait 4;
    level notify( "oncoming_gate_open" );
    var_7 connectpaths();
    common_scripts\utility::flag_set( "obj_pos_pursue_hostage_truck_oncoming1_set" );
    thread alley1_oncoming_truck_seq();
    thread maps\lagos_vo::alley_oncoming_dialogue();
    level notify( "oncoming_go" );
    level.player maps\_utility::blend_movespeedscale_percent( 85, 1 );
    level.joker thread maps\lagos_utility::ally_move_dynamic_speed();
    level.ajani thread maps\lagos_utility::ally_move_dynamic_speed();
    level.joker maps\_utility::delaythread( 1, maps\_hms_ai_utility::gototogoal, var_1, "sprint" );
    level.ajani maps\_utility::delaythread( 3, maps\_hms_ai_utility::gototogoal, var_2, "sprint" );
    common_scripts\utility::flag_wait( "reset_player_speed" );
    level.player maps\_utility::blend_movespeedscale_percent( 100, 1 );
    level waittill( "player_safe" );
    level.joker thread maps\_hms_ai_utility::gototogoal( var_3, "sprint" );
    level.ajani thread maps\_hms_ai_utility::gototogoal( var_4, "sprint" );
}

alley1_oncoming_grenade_awareness()
{
    self.grenadeawarenessold = self.grenadeawareness;
    self.grenadeawareness = 0;
    common_scripts\utility::flag_wait( "alley2_spawn" );
    self.grenadeawareness = self.grenadeawarenessold;
    self.grenadeawarenessold = undefined;
}

alley1_oncoming_burke_alley_enter()
{
    var_0 = getnode( "oncoming_anim_burke_goto", "targetname" );
    var_1 = getnode( "alley2_burke_start", "targetname" );
    var_2 = common_scripts\utility::getstruct( "oncoming_burke_idle_goto", "targetname" );
    var_3 = getent( "anim_org_oncoming_alley", "targetname" );
    level.burke maps\lagos_utility::assign_goal_node( "alley_oncoming_burke", 32 );
    level waittill( "oncoming_gate_open" );
    wait 0.5;
    level.burke thread maps\_hms_ai_utility::gototogoal( var_0, "sprint" );
    level waittill( "oncoming_truck_enter" );
    maps\_utility::battlechatter_off( "axis" );
    maps\_utility::battlechatter_off( "allies" );
    var_3 maps\_anim::anim_reach_solo( level.burke, "oncoming_alley_seq_enter" );
    level.burke thread maps\_hms_ai_utility::gototogoal( var_1, "sprint" );
    level notify( "oncoming_truck_go" );
    common_scripts\utility::flag_set( "obj_pos_pursue_hostage_truck_oncoming2" );
    var_3 maps\_anim::anim_single_solo_run( level.burke, "oncoming_alley_seq_enter" );
}

#using_animtree("vehicles");

alley1_oncoming_truck_seq()
{
    var_0 = getent( "anim_org_oncoming_alley", "targetname" );
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname( "vehicle_downhill_stairs" );
    var_1.animname = "oncoming_truck";
    var_1 useanimtree( #animtree );
    var_2 = getent( "oncoming_truck_sweeper", "targetname" );
    var_2 maps\lagos_utility::fake_linkto( var_1 );
    var_1.vehicle_stays_alive = 1;

    if ( level.currentgen )
        var_1 thread tff_cleanup_vehicle( "alley" );

    thread alley1_oncoming_truck_anims( var_1, var_0 );
    common_scripts\utility::flag_wait( "oncoming_alley_player_pos" );
    level.player thread alley1_oncoming_truck_sweeper_monitor( var_2 );
    level notify( "oncoming_truck_enter" );
    level notify( "alley1_oncoming_fx" );
    var_1 soundscripts\_snd::snd_message( "oncoming_alley_truck" );
    common_scripts\utility::flag_set( "alley_oncoming_truck_lighting" );
}

alley1_oncoming_truck_anims( var_0, var_1 )
{
    level waittill( "oncoming_truck_go" );
    var_2 = maps\_utility::spawn_targetname( "vehicle_downhill_stairs_turret_guy", 1 );
    var_2 maps\_utility::gun_remove();
    var_2.allowdeath = 0;
    var_2 maps\_utility::disable_pain();
    var_3 = maps\_utility::spawn_anim_model( "oncoming_truck_prop" );
    var_4 = maps\_utility::spawn_anim_model( "oncoming_truck_turret" );
    var_4 thread alley1_oncoming_turret_think( var_2 );
    thread maps\_shg_design_tools::notify_on_death( var_2, "stop_turret_fire" );
    var_2.animname = "guy1";
    var_2.ignoreme = 1;
    var_5 = [ var_2, var_4 ];
    var_0 hide();
    var_6 = [ var_0, var_3 ];
    var_1 thread maps\_anim::anim_single( var_5, "oncoming_alley_seq_enter" );
    var_1 maps\_anim::anim_single( var_6, "oncoming_alley_seq_enter" );
    common_scripts\utility::flag_set( "aud_oncoming_truck_check" );

    if ( level.currentgen )
    {
        var_3 thread tff_cleanup_vehicle( "middle" );
        var_4 thread tff_cleanup_vehicle( "middle" );
        var_2 thread tff_cleanup_vehicle( "middle" );
    }

    if ( common_scripts\utility::flag( "flag_oncoming_player_junction" ) )
    {
        var_4 thread delay_oncoming_bypass_kill( 1, var_2, "flag_oncoming_player_bypass_straight_kill" );
        var_4 thread delay_oncoming_bypass_kill( 3, var_2, "flag_oncoming_player_bypass_turn_kill" );
        var_4 thread delay_oncoming_bypass_kill( 5, var_2, "flag_oncoming_player_standstill_turn_kill" );
        var_4 thread delay_oncoming_bypass_kill( 6, var_2, "flag_oncoming_player_wait_alley2_kill" );
        var_1 thread maps\_anim::anim_single( var_6, "oncoming_alley_seq_turn" );
        level notify( "player_safe" );
        wait(getanimlength( var_0 maps\_utility::getanim( "oncoming_alley_seq_turn" ) ) - 0.05);

        if ( isalive( var_2 ) )
            maps\_anim::anim_set_rate_single( var_2, "oncoming_alley_seq_enter", 0 );
    }
    else
    {
        foreach ( var_8 in var_5 )
            var_8 maps\_utility::anim_stopanimscripted();

        var_1 thread maps\_anim::anim_single( var_5, "oncoming_alley_seq_straight" );
        var_1 thread maps\_anim::anim_single( var_6, "oncoming_alley_seq_straight" );
        var_4 oncoming_bypass_kill( var_2, "flag_oncoming_player_bypass_straight_kill" );
    }
}

delay_oncoming_bypass_kill( var_0, var_1, var_2 )
{
    wait(var_0);
    oncoming_bypass_kill( var_1, var_2 );
}

oncoming_bypass_kill( var_0, var_1 )
{
    while ( !common_scripts\utility::flag( "progress_in_alley2" ) )
    {
        if ( common_scripts\utility::flag( var_1 ) )
        {
            level.player dodamage( level.player.maxhealth / 50, self gettagorigin( "tag_flash" ), var_0, var_0, "MOD_RIFLE_BULLET" );
            wait 0.2;
            level.player dodamage( level.player.maxhealth, self gettagorigin( "tag_flash" ), var_0, var_0, "MOD_RIFLE_BULLET" );
            wait 0.1;

            if ( isalive( level.player ) )
                level.player kill();
        }

        waitframe();
    }
}

alley1_oncoming_turret_think( var_0 )
{
    var_0 endon( "death" );
    thread alley1_oncoming_turret_fire();
    maps\lagos_utility::notify_on_flag( "stop_turret_fire", "progress_in_alley2" );
    self waittillmatch( "single anim", "start_turret_fire" );
    thread alley1_oncoming_turret_fire();
    self waittillmatch( "single anim", "stop_turret_fire" );
    self notify( "stop_turret_fire" );
    self waittillmatch( "single anim", "start_turret_fire" );
    thread alley1_oncoming_turret_fire();
    self waittillmatch( "single anim", "stop_turret_fire" );
    self notify( "stop_turret_fire" );
}

alley1_oncoming_turret_fire()
{
    self endon( "stop_turret_fire" );
    level endon( "stop_turret_fire" );
    var_0 = 0.05;
    var_1 = 1;
    var_2 = 0;
    var_3 = "tag_flash";

    for (;;)
    {
        if ( var_2 == 0 )
            var_3 = "tag_flash";
        else
            var_3 = "tag_flash2";

        var_4 = self gettagorigin( var_3 );
        magicbullet( "50cal_turret_technical_lagos", var_4, var_4 + anglestoforward( self gettagangles( var_3 ) ) * 100 );

        if ( var_3 == "tag_flash" )
            soundscripts\_snd::snd_message( "lagos_technical_turret_fire" );

        playfx( common_scripts\utility::getfx( "technical_muzzle_flash" ), var_4, anglestoforward( self gettagangles( var_3 ) ) );
        var_2 = ( var_2 + 1 ) % 2;
        wait(var_0);
    }
}

flank_alley_turret_fire( var_0 )
{
    var_0 endon( "death" );
    var_1 = self.mgturret;
    var_2 = var_1[0];
    var_3 = "tag_flash2";

    for (;;)
    {
        var_2 waittill( "turret_fire" );
        waitframe();
        var_4 = var_2 gettagorigin( var_3 );
        magicbullet( "50cal_turret_technical_lagos", var_4, var_4 + anglestoforward( var_2 gettagangles( var_3 ) ) * 100 );
        playfx( common_scripts\utility::getfx( "technical_muzzle_flash" ), var_4, anglestoforward( var_2 gettagangles( var_3 ) ) );
        soundscripts\_snd::snd_message( "lagos_technical_turret_fire" );
    }
}

alley1_oncoming_truck_sweeper_monitor( var_0 )
{
    while ( !common_scripts\utility::flag( "flag_oncoming_player_safe" ) )
    {
        var_0 waittill( "trigger", var_1 );

        if ( isdefined( var_1 ) && isplayer( var_1 ) )
            self kill();

        waitframe();
    }
}

alley2_combat()
{
    common_scripts\utility::flag_wait( "alley2_spawn" );
    level.burke maps\_utility::enable_pain();
    level.joker maps\_utility::enable_pain();
    level.ajani maps\_utility::enable_pain();
    maps\_utility::battlechatter_on( "axis" );
    maps\_utility::battlechatter_on( "allies" );
    level.joker thread maps\lagos_utility::ally_stop_dynamic_speed();
    level.ajani thread maps\lagos_utility::ally_stop_dynamic_speed();
    level.alley2_kva = [];
    thread alley2_stage1_combat();

    if ( common_scripts\utility::flag( "alley2_playerstart" ) )
    {
        var_0 = getnode( "alley2_burke_start", "targetname" );
        var_1 = getnode( "alley2_joker_start", "targetname" );
        var_2 = getnode( "alley2_ajani_start", "targetname" );
        level.burke maps\_utility::teleport_ai( var_0 );
        level.joker maps\_utility::teleport_ai( var_1 );
        level.ajani maps\_utility::teleport_ai( var_2 );
    }

    level notify( "alley2_stage1_go" );
    thread maps\lagos_vo::alley_b_dialogue();
}

alley2_jumpers()
{
    common_scripts\utility::flag_wait( "alley2_jumpers" );
    var_0 = getent( "alley2_jumper1", "targetname" );
    var_1 = getent( "alley2_jumper2", "targetname" );
    var_2 = getnode( "alley2_jumper_goto1", "targetname" );
    var_3 = getnode( "alley2_jumper_goto2", "targetname" );
    thread alley2_jumpers_setup( var_0, var_2 );
    thread alley2_jumpers_setup( var_1, var_3 );
}

alley2_jumpers_setup( var_0, var_1 )
{
    var_2 = var_0 maps\_utility::spawn_ai( 1 );
    waitframe();
    var_2.goalradius = 16;
    var_2.ignoreall = 1;
    var_2.ignoreme = 1;
    var_2 setgoalnode( var_1 );
    var_2 waittill( "goal" );
    var_2 stopanimscripted();
    var_2 delete();
}

alley2_stage1_combat()
{
    setthreatbias( "friendly_squad", "player_haters", -10000 );
    setthreatbias( "player_haters", "friendly_squad", -10000 );
    setthreatbias( "player_haters", "player", 10000 );
    level.player setthreatbiasgroup( "player" );
    var_0 = 1;
    var_1 = 1;
    var_2 = [];
    level endon( "alley2_stage2_go" );
    level waittill( "alley2_stage1_go" );
    maps\_utility::activate_trigger( "alley2_stage1_burke_goto", "targetname", level.player );
    level.burke maps\_utility::disable_surprise();
    maps\_utility::delaythread( 2, maps\_utility::activate_trigger, "alley2_stage1_joker_goto", "targetname", level.player );
    maps\_utility::delaythread( 4, maps\_utility::activate_trigger, "alley2_stage1_ajani_goto", "targetname", level.player );
    wait 2;
    var_3 = maps\_utility::array_spawn_targetname( "alley2_stage1_enemy", 1 );
    thread maps\lagos_utility::spawn_wave_upkeep_and_flag( var_3, "alley2_combat_move_1", 0 );

    foreach ( var_5 in var_3 )
    {
        if ( isdefined( var_5 ) && isalive( var_5 ) )
        {
            if ( !issubstr( var_5.classname, "dog" ) )
            {
                var_5.goalradius = 16;
                var_5 thread maps\lagos_utility::ignore_until_goal_reached();
            }
        }
    }

    common_scripts\utility::flag_wait( "alley2_combat_move_1" );
    thread flank_alley_goto();
    common_scripts\utility::flag_wait( "alley2_combat_move_2" );
    level.burke maps\_utility::disable_pain();
    level.joker maps\_utility::disable_pain();
    level.ajani maps\_utility::disable_pain();
    var_7 = maps\_utility::array_spawn_targetname( "alley2_stage2_enemy", 1 );
    thread maps\lagos_utility::spawn_wave_upkeep_and_flag( var_3, "alley2_complete", 0 );

    foreach ( var_5 in var_7 )
    {
        if ( isdefined( var_5 ) && isalive( var_5 ) )
            var_5 thread maps\_utility::player_seek_enable();
    }

    common_scripts\utility::flag_wait( "alley2_complete" );
}

alley2_stage2_combat()
{
    level endon( "alley2_stage3_go" );
    level waittill( "alley2_stage2_go" );
    var_0 = 1;
    var_1 = 1;
    var_2 = [];
    var_3 = getentarray( "alley2_stage2_enemy", "targetname" );
    var_4 = getent( "alley2_combat_enemy_loc_3", "targetname" );

    for ( var_5 = 0; var_5 < var_0; var_5++ )
    {
        var_3 = common_scripts\utility::array_randomize( var_3 );
        var_6 = level.player alley2_spawner_locator( var_3 );
        var_7 = var_6 maps\_utility::spawn_ai( 1 );
        var_6.count = 1;
        var_2 = common_scripts\utility::array_add( var_2, var_7 );
        level.alley2_kva = common_scripts\utility::array_add( level.alley2_kva, var_7 );
        var_7.allowdeath = 1;
        wait 0.25;
        var_7 maps\lagos_utility::assign_goal_vol( "alley2_combat_enemy_loc_3" );
    }

    for (;;)
    {
        var_2 = maps\_utility::array_removedead_or_dying( var_2 );
        level.alley2_kva = maps\_utility::array_removedead_or_dying( level.alley2_kva );

        if ( var_2.size < var_1 )
            level notify( "alley2_stage3_go" );

        waitframe();
    }
}

alley2_stage3_combat()
{
    level endon( "alley2_stage3_end" );
    common_scripts\utility::flag_wait( "alley2_combat_move_1" );
    thread flank_alley_goto();
    var_0 = 2;
    var_1 = 3;
    var_2 = [];
    var_3 = getentarray( "alley2_stage3_enemy", "targetname" );
    var_4 = getent( "alley2_combat_enemy_loc_8", "targetname" );

    for ( var_5 = 0; var_5 < var_0; var_5++ )
    {
        var_3 = common_scripts\utility::array_randomize( var_3 );
        var_6 = level.player alley2_spawner_locator( var_3 );
        var_7 = var_6 maps\_utility::spawn_ai( 1 );
        var_6.count = 1;
        var_2 = common_scripts\utility::array_add( var_2, var_7 );
        level.alley2_kva = common_scripts\utility::array_add( level.alley2_kva, var_7 );
        var_7.allowdeath = 1;
        waitframe();
        var_7 maps\lagos_utility::assign_goal_vol( "alley2_combat_enemy_loc_8" );
    }

    for (;;)
    {
        var_2 = maps\_utility::array_removedead_or_dying( var_2 );
        level.alley2_kva = maps\_utility::array_removedead_or_dying( level.alley2_kva );

        if ( level.alley2_kva.size < var_1 )
        {
            level.alley2_kva = maps\_utility::array_removedead_or_dying( level.alley2_kva );

            foreach ( var_7 in level.alley2_kva )
                var_7 thread maps\_utility::player_seek_enable();
        }

        if ( level.alley2_kva.size == 0 )
        {
            level notify( "flank_combat_goto" );
            waitframe();
            level notify( "alley2_stage3_end" );
            level.burke maps\_utility::enable_surprise();
        }

        waitframe();
    }
}

alley2_combat_enemy_vol_assign( var_0 )
{
    level endon( "flank_combat_goto" );
    var_1 = getent( "alley2_combat_loc_1", "targetname" );
    var_2 = getent( "alley2_combat_loc_2", "targetname" );
    var_3 = getent( "alley2_combat_loc_3", "targetname" );
    var_4 = getent( "alley2_combat_loc_4", "targetname" );
    var_5 = getent( "alley2_combat_loc_5", "targetname" );

    for (;;)
    {
        waitframe();
        var_0 = maps\_utility::array_removedead_or_dying( var_0 );
        alley2_combat_player_monitor( var_1, "alley2_ally_trig_1", "alley2_combat_enemy_loc_2", "alley2_combat_enemy_loc_3", var_0 );
        alley2_combat_player_monitor( var_2, "alley2_ally_trig_2", "alley2_combat_enemy_loc_3", undefined, var_0 );
        alley2_combat_player_monitor( var_3, "alley2_ally_trig_3", "alley2_combat_enemy_loc_3", "alley2_combat_enemy_loc_5", var_0 );
        alley2_combat_player_monitor( var_4, "alley2_ally_trig_4", "alley2_combat_enemy_loc_3", "alley2_combat_enemy_loc_6", var_0 );
        alley2_combat_player_monitor( var_5, "alley2_ally_trig_5", "alley2_combat_enemy_loc_6", "alley2_combat_enemy_loc_8", var_0 );
        wait(randomintrange( 5, 10 ));
    }
}

alley2_combat_player_monitor( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !level.player istouching( var_0 ) )
    {
        waitframe();
        return;
    }

    maps\_utility::activate_trigger( var_1, "targetname", level.player );
    alley2_combat_vol_assign( var_4, var_2, var_3 );
}

alley2_combat_vol_assign( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = var_1;

    foreach ( var_4 in var_0 )
    {
        var_5 = var_4 getgoalvolume();

        if ( randomint( 100 ) > 80 )
        {
            if ( var_5 != var_1 && var_5 != var_2 )
            {
                if ( common_scripts\utility::cointoss() )
                {
                    var_4 maps\lagos_utility::assign_goal_vol( var_1 );
                    continue;
                }

                var_4 maps\lagos_utility::assign_goal_vol( var_2 );
            }
        }
    }
}

alley2_spawner_locator( var_0 )
{
    var_1 = undefined;

    while ( !isdefined( var_1 ) )
    {
        foreach ( var_3 in var_0 )
        {
            var_4 = self geteye();
            var_5 = var_3.origin;
            var_6 = sighttracepassed( var_4, var_5, 0, self );

            if ( !var_6 )
            {
                var_1 = var_3;
                return var_1;
            }
        }

        waitframe();
    }
}

flank_alley_goto()
{
    thread maps\lagos_utility::ally_redirect_goto_node( "Gideon", "flank_start_burke" );
    wait 0.5;
    thread maps\lagos_utility::ally_redirect_goto_node( "Joker", "flank_start_joker" );
    wait 0.5;
    thread maps\lagos_utility::ally_redirect_goto_node( "Ajani", "flank_start_ajani" );
}

flank_magic_gren()
{
    var_0 = common_scripts\utility::getstruct( "microwave_gren_throw_flank", "targetname" );
    var_1 = common_scripts\utility::getstruct( "microwave_gren_target_flank", "targetname" );
    var_2 = magicgrenade( "microwave_grenade", var_0.origin, var_1.origin );
    var_2 thread maps\_microwave_grenade::microwave_grenade_explode_wait();
}

flank_combat()
{
    common_scripts\utility::flag_wait( "alley_flank_start" );
    level.burke maps\_utility::disable_pain();
    level.joker maps\_utility::disable_pain();
    level.ajani maps\_utility::disable_pain();

    if ( common_scripts\utility::flag( "flank_playerstart" ) )
    {
        var_0 = getnode( "flank_start_burke", "targetname" );
        var_1 = getnode( "flank_start_joker", "targetname" );
        var_2 = getnode( "flank_start_ajani", "targetname" );
        level.burke maps\_utility::teleport_ai( var_0 );
        level.joker maps\_utility::teleport_ai( var_1 );
        level.ajani maps\_utility::teleport_ai( var_2 );
    }

    spawncivilians_flank_alley();
    common_scripts\utility::flag_wait( "flank_spawn" );
    thread flank_wall_climb_force_check();
    thread flank_wall_climb_force_dismount();
    var_3 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "enemy_vehicle_Flank_Hummer" );
    var_3.dontunloadonend = 1;
    var_3.vehicle_stays_alive = 1;
    var_3.mgturret[0] maketurretsolid();

    if ( level.currentgen )
        var_3 thread tff_cleanup_vehicle( "alley" );

    var_4 = [];
    var_5 = [];

    foreach ( var_7 in var_3.riders )
    {
        if ( var_7.vehicle_position == 1 )
        {
            var_8 = var_7;
            var_8 thread maps\_utility::magic_bullet_shield();
            var_8 maps\_utility::disable_pain();
            var_8.allowdeath = 0;
            var_8.ignoresonicaoe = 1;
            var_4 = common_scripts\utility::array_add( var_4, var_8 );
            var_8 thread flank_make_gunner_vulerable();
            var_3 thread flank_alley_turret_fire( var_8 );
            continue;
        }

        var_5 = common_scripts\utility::array_add( var_5, var_7 );
    }

    soundscripts\_snd::snd_message( "truck_turret_flank_alley", var_3 );
    thread civilians_flank_alley_react();
    thread maps\lagos_vo::alley_flank_dialogue();
    thread maps\lagos_utility::timeout_and_flag( "flank_technical_move", 5 );
    common_scripts\utility::flag_wait( "flank_technical_move" );
    soundscripts\_snd::snd_message( "truck_turret_flank_alley_drive_away", var_3 );
    var_10 = getvehiclenode( "node_flank_hummer_second_path", "targetname" );
    var_3 thread maps\_vehicle::vehicle_paths( var_10 );
    var_3 startpath( var_10 );
    var_3.dontunloadonend = 0;
    var_11 = maps\_utility::array_spawn_targetname( "enemy_spawner_Flank_A", 1 );
    var_3 thread flank_technical_unload();
    var_12 = [];
    var_13 = [];
    var_14 = [];
    var_15 = [];
    var_13 = flank_alley_spawn_group_b();
    var_14 = flank_alley_spawn_group_c();
    var_15 = flank_alley_spawn_group_d();
    thread maps\lagos_utility::spawn_wave_upkeep_and_flag( var_4, "flank_vehicle_turret_dead", 0 );
    common_scripts\utility::flag_wait( "flank_player_behind_gunner" );
    var_12 = common_scripts\utility::array_combine( var_12, var_5 );
    var_12 = common_scripts\utility::array_combine( var_12, var_11 );
    var_12 = common_scripts\utility::array_combine( var_12, var_13 );
    var_12 = common_scripts\utility::array_combine( var_12, var_14 );
    var_12 = common_scripts\utility::array_combine( var_12, var_15 );
    var_12 = maps\_utility::array_removedead_or_dying( var_12 );
    common_scripts\utility::flag_wait( "flank_vehicle_turret_dead" );

    foreach ( var_7 in var_12 )
    {
        if ( isdefined( var_7 ) && isalive( var_7 ) && !maps\_utility::player_can_see_ai( var_7 ) )
            var_7 kill();

        var_12 = maps\_utility::array_removedead_or_dying( var_12 );
    }

    foreach ( var_7 in var_12 )
    {
        if ( isdefined( var_7 ) && isalive( var_7 ) )
            var_7 thread maps\_utility::player_seek_enable();
    }

    while ( var_12.size > 0 )
    {
        var_12 = maps\_utility::array_removedead_or_dying( var_12 );
        waitframe();
    }

    wait 2;
    common_scripts\utility::flag_set( "flank_alley_complete" );
    level.burke maps\_utility::enable_pain();
    level.joker maps\_utility::enable_pain();
    level.ajani maps\_utility::enable_pain();
    var_0 = getnode( "flank_wall_start_burke", "targetname" );
    var_1 = getnode( "flank_wall_start_joker", "targetname" );
    var_2 = getnode( "flank_wall_start_ajani", "targetname" );
    level.burke setgoalnode( var_0 );
    level.joker setgoalnode( var_1 );
    level.ajani setgoalnode( var_2 );
}

flank_technical_unload()
{
    self waittill( "reached_end_node" );
    maps\_vehicle::vehicle_unload( "all_but_gunner" );
}

flank_wall_climb_force_check()
{
    common_scripts\utility::flag_wait( "flag_start_mag_climb_flank" );
    thread maps\lagos_lighting::setup_flank_wall_climb_lighting();
    level.player.hack_fix_lagos_flank_alley_camera_pop = 1;

    if ( !common_scripts\utility::flag( "flank_vehicle_turret_dead" ) )
        level.player kill();
}

flank_wall_climb_force_dismount()
{
    common_scripts\utility::flag_wait( "flag_end_mag_climb_flank" );
    thread maps\lagos_lighting::setup_flank_wall_climb_lighting_complete();
    level.player.hack_fix_lagos_flank_alley_camera_pop = undefined;
    maps\_exo_climb::disable_mount_point( "climb_mount_flank_alley" );
    var_0 = getent( "anim_org_exo_climb_flank", "targetname" );
    var_1 = "player_rig";
    var_2 = "flank_wall_climb";
    level.scr_goaltime["player_rig"]["flank_wall_climb"] = 0.5;
    maps\_exo_climb::force_animated_dismount( var_0, var_1, var_2 );

    if ( level.currentgen )
        thread maps\_utility::tff_sync( 7 );

    level notify( "mag_climb_complete" );
    level notify( "flag_cancel_exo_climb" );
    maps\_utility::delaythread( 8, common_scripts\utility::flag_set, "obj_progress_mag_climb_flank_complete" );
    level.burke maps\_utility::disable_pain();
    var_0 maps\_anim::anim_single_solo_run( level.burke, "flank_wall_climb" );
    var_3 = getnode( "flank_wall_teleport_joker", "targetname" );
    var_4 = getnode( "flank_wall_teleport_ajani", "targetname" );
    level.joker maps\_utility::teleport_ai( var_3 );
    level.ajani maps\_utility::teleport_ai( var_4 );
    level.burke maps\_utility::enable_pain();
    var_5 = getnode( "frogger_start_burke", "targetname" );
    var_6 = getnode( "frogger_start_joker", "targetname" );
    var_7 = getnode( "frogger_start_ajani", "targetname" );
    level.burke setgoalnode( var_5 );
    level.joker setgoalnode( var_6 );
    wait 1;
    level.ajani setgoalnode( var_7 );
}

flank_handle_player_bypass()
{
    common_scripts\utility::flag_wait( "flank_player_behind_gunner_bypass" );

    if ( !common_scripts\utility::flag( "flank_vehicle_turret_dead" ) )
    {
        var_0 = maps\_utility::array_spawn_targetname( "enemy_spawner_Flank_bypass", 1 );

        foreach ( var_2 in var_0 )
        {
            if ( issubstr( var_2.classname, "dog" ) )
                var_2 thread maps\lagos_utility::ignore_until_goal_reached();
        }
    }
}

tff_cleanup_vehicle( var_0 )
{
    var_1 = "";

    switch ( var_0 )
    {
        case "intro":
            var_1 = "tff_pre_intro_to_middle";
            break;
        case "middle":
            var_1 = "tff_pre_unload_middle";
            break;
        case "alley":
            var_1 = "tff_pre_alley_to_outro";
            break;
        case "roundabout_lobby":
            var_1 = "tff_pre_unload_lobby";
            break;
    }

    if ( var_1 == "" )
        return;

    level waittill( var_1 );

    if ( isdefined( self ) )
    {
        if ( maps\_vehicle::isvehicle() )
            maps\_vehicle_code::_freevehicle();

        self delete();
    }
}

flank_alley_door_kick()
{
    var_0 = getent( "anim_org_flank_kick", "targetname" );
    var_1 = getent( "flank_alley_door", "targetname" );
    var_1.animname = "flank_alley_door";
    var_1 maps\_utility::assign_animtree();
    var_0 thread maps\_anim::anim_first_frame_solo( var_1, "flank_alley_door_kick_open" );
    var_2 = getent( "flank_alley_door_collision_a", "targetname" );
    var_3 = getent( "flank_alley_door_collision_b", "targetname" );
    var_2 linkto( var_1, "doora" );
    var_3 linkto( var_1, "doorb" );
    common_scripts\utility::flag_wait( "alley_flank_start" );

    if ( distance2dsquared( level.player.origin, var_0.origin ) < distance2dsquared( level.burke.origin, var_0.origin ) && !common_scripts\utility::flag( "flank_playerstart" ) )
    {
        var_0 thread maps\_anim::anim_single_solo( var_1, "flank_alley_door_kick_open" );
        var_2 common_scripts\utility::delaycall( 2, ::connectpaths );
        var_3 common_scripts\utility::delaycall( 2, ::connectpaths );
        common_scripts\utility::flag_wait( "flank_spawn" );

        if ( !common_scripts\utility::flag( "flank_vehicle_turret_dead" ) )
            var_0 maps\_anim::anim_reach_solo( level.burke, "burke_flank_kick_start", undefined, 1 );

        if ( !common_scripts\utility::flag( "flank_vehicle_turret_dead" ) )
            var_0 maps\_anim::anim_reach_solo( level.burke, "burke_flank_kick_loop", undefined, 1 );

        if ( !common_scripts\utility::flag( "flank_vehicle_turret_dead" ) )
            var_0 thread maps\_anim::anim_loop_solo( level.burke, "burke_flank_kick_loop", "stop_loop" );
    }
    else
    {
        common_scripts\utility::flag_wait( "flank_spawn" );
        var_4 = getent( "civilian_female_flank_burke_cover", "targetname" ) maps\_utility::spawn_ai( 1, 1 );
        var_4.animname = "civ_flank";
        var_0 maps\_anim::anim_reach_solo( level.burke, "burke_flank_kick_start" );
        thread flank_alley_door_kick_civilian_react( var_0, var_4 );
        var_0 thread maps\_anim::anim_single_solo( var_1, "flank_alley_door_kick_open" );
        var_2 common_scripts\utility::delaycall( 2, ::connectpaths );
        var_3 common_scripts\utility::delaycall( 2, ::connectpaths );
        var_0 maps\_anim::anim_single_solo( level.burke, "burke_flank_kick_start" );

        if ( !common_scripts\utility::flag( "flank_vehicle_turret_dead" ) )
            var_0 thread maps\_anim::anim_loop_solo( level.burke, "burke_flank_kick_loop", "stop_loop" );
    }

    common_scripts\utility::flag_wait( "flank_burke_move_from_window" );
    var_0 notify( "stop_loop" );

    if ( !common_scripts\utility::flag( "flank_vehicle_turret_dead" ) )
        var_0 maps\_anim::anim_single_solo( level.burke, "burke_flank_kick_exit" );
}

flank_alley_door_kick_doors_open( var_0, var_1 )
{
    wait 2;
    var_2 = ( 0, 26.3, 0 );
    var_3 = ( 0, 313.1, 0 );
    var_0 rotateto( var_2, 0.1 );
    var_1 rotateto( var_3, 0.1 );
}

flank_alley_door_kick_civilian_react( var_0, var_1 )
{
    var_0 maps\_anim::anim_single_solo( var_1, "burke_flank_kick_civ_react" );
    var_0 maps\_anim::anim_loop_solo( var_1, "burke_flank_kick_civ_idle" );
}

flank_make_gunner_vulerable()
{
    self endon( "death" );

    if ( !isdefined( self.damage_functions ) )
        self.damage_functions = [];

    maps\_utility::add_damage_function( ::flank_gunner_damage_function );
    common_scripts\utility::flag_wait( "flank_player_behind_gunner" );
    maps\_utility::stop_magic_bullet_shield();
    maps\_utility::enable_pain();
    self.allowdeath = 1;
    common_scripts\utility::flag_wait( "flank_player_behind_gunner_bypass" );
    wait 4;

    if ( isdefined( self ) && isalive( self ) )
        self kill();
}

flank_gunner_damage_function( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( var_1 != level.player && !common_scripts\utility::flag( "flank_player_behind_gunner_bypass" ) )
    {
        if ( self.health > 0 )
            self.health += var_0;
    }
}

flank_alley_spawn_group_b( var_0 )
{
    common_scripts\utility::flag_wait( "flank_spawn_enemies_B" );
    var_0 = maps\_utility::array_spawn_targetname( "enemy_spawner_Flank_B", 1 );
    return var_0;
}

flank_alley_spawn_group_c( var_0 )
{
    common_scripts\utility::flag_wait( "flank_spawn_enemies_C" );
    var_0 = maps\_utility::array_spawn_targetname( "enemy_spawner_Flank_C", 1 );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) && isalive( var_2 ) )
            var_2 thread maps\lagos_utility::ignore_until_goal_reached();
    }

    return var_0;
}

flank_alley_spawn_group_d( var_0 )
{
    common_scripts\utility::flag_wait( "flank_spawn_enemies_D" );
    var_0 = maps\_utility::array_spawn_targetname( "enemy_spawner_Flank_D", 1 );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) && isalive( var_2 ) )
            var_2 thread maps\lagos_utility::ignore_until_goal_reached();
    }

    return var_0;
}

spawncivilians_flank_alley()
{
    var_0 = getent( "civilian_female_flank_alley", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "node_Flank_Alley_female_standing", "targetname" );
    var_2 = maps\lagos_utility::populate_ai_civilians( var_0, var_1, 1, "flag_Flank_Alley_civilians_flee" );
    var_3 = getent( "civilian_male_flank_alley", "targetname" );
    var_4 = common_scripts\utility::getstructarray( "node_Flank_Alley_male_standing", "targetname" );
    var_5 = maps\lagos_utility::populate_ai_civilians( var_3, var_4, 1, "flag_Flank_Alley_civilians_flee" );
}

civilians_flank_alley_react()
{
    common_scripts\utility::flag_set( "flag_Flank_Alley_react" );
    common_scripts\utility::flag_wait( "flank_technical_move" );
    common_scripts\utility::flag_set( "flag_Flank_Alley_civilians_flee" );
}

frogger_impact_damage_function( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( var_4 == "MOD_CRUSH" )
        var_0 += level.player.maxhealth;
}

frogger_combat()
{
    level.frogger_vehicles = [];

    if ( !isdefined( level.lookbothways ) )
        level.lookbothways = 1;

    common_scripts\utility::flag_wait( "trigger_start_timed_lane_traffic" );
    setthreatbias( "friendly_squad", "player_haters", -10000 );
    setthreatbias( "player_haters", "friendly_squad", -10000 );
    setthreatbias( "player_haters", "player", 10000 );
    level.player setthreatbiasgroup( "player" );
    level.player maps\_utility::add_damage_function( ::frogger_impact_damage_function );
    level.frogger_spawners = getentarray( "frogger_car_spawner", "targetname" );

    foreach ( var_1 in level.frogger_spawners )
        var_1.traffic_locked = 0;

    level.frogger_bus_spawners = getentarray( "frogger_bus_spawner", "targetname" );

    foreach ( var_1 in level.frogger_bus_spawners )
        var_1.traffic_locked = 0;

    thread spawn_vehicle_lane( 1, 3 );

    if ( level.nextgen )
        thread spawn_vehicle_lane( 2, 4 );

    thread spawn_vehicle_lane( 3, 5 );

    if ( level.nextgen )
        thread spawn_vehicle_lane( 5, 4 );

    thread spawn_vehicle_lane( 6, 5 );

    if ( level.nextgen )
        thread spawn_vehicle_lane( 7, 3 );

    thread spawn_vehicle_lane( 8, 4 );
    common_scripts\utility::run_thread_on_targetname( "trigger_release_southbound", ::frogger_release_vehicle_at_trigger );
    common_scripts\utility::run_thread_on_targetname( "trigger_release_northbound", ::frogger_release_vehicle_at_trigger );
    common_scripts\utility::run_thread_on_targetname( "trigger_despawn_southbound", ::delete_vehicle_at_trigger );
    common_scripts\utility::run_thread_on_targetname( "trigger_despawn_northbound", ::delete_vehicle_at_trigger );
    var_5 = getent( "frogger_bad_place_street_1", "targetname" );
    badplace_brush( "enemy_badPlace_frogger_street_1", -1, var_5, "axis" );
    var_6 = getent( "frogger_bad_place_street_2", "targetname" );
    badplace_brush( "enemy_badPlace_frogger_street_2", -1, var_6, "axis" );
    thread frogger_squad_crossing();
    common_scripts\utility::flag_wait( "trigger_start_frogger_kva" );
    level.burke.grenadeammo = 0;
    level.joker.grenadeammo = 0;
    level.ajani.grenadeammo = 0;
    var_7 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "enemy_vehicle_Frogger_Hummer" );
    var_7 maps\_vehicle::vehicle_set_health( 1000000 );
    var_8 = [];
    var_8 = common_scripts\utility::array_combine( var_8, var_7.riders );
    var_7 thread maps\lagos_utility::vehicle_unload_how_at_end();

    foreach ( var_10 in var_8 )
    {
        if ( !common_scripts\utility::flag( "frogger_flag_player_middle" ) )
            var_10 thread maps\lagos_utility::ignore_until_goal_reached();
    }

    wait 0.5;

    if ( level.nextgen )
        thread spawn_vehicle_lane( 4, 3 );

    wait 3.5;

    if ( level.nextgen )
    {
        level.non_vehicle_guys_a = maps\_utility::array_spawn_targetname( "enemy_spawner_Frogger_A2", 1 );

        foreach ( var_10 in level.non_vehicle_guys_a )
        {
            if ( !common_scripts\utility::flag( "frogger_flag_player_middle" ) )
                var_10 thread maps\lagos_utility::ignore_until_goal_reached();
        }
    }

    level.frogger_middle_guys = [];
    level.frogger_middle_guys = common_scripts\utility::array_combine( level.frogger_middle_guys, var_8 );

    if ( level.nextgen )
        level.frogger_middle_guys = common_scripts\utility::array_combine( level.frogger_middle_guys, level.non_vehicle_guys_a );

    thread frogger_handle_bypass_middle();
    common_scripts\utility::flag_set( "flag_frogger_middle_spawned" );
    thread maps\lagos_utility::spawn_wave_upkeep_and_flag( level.frogger_middle_guys, "flag_frogger_middle_dead" );
    common_scripts\utility::flag_wait( "trigger_start_frogger_kva_B" );
    var_14 = [];

    if ( level.nextgen )
        var_14 = maps\_utility::array_spawn_targetname( "enemy_spawner_Frogger_C", 1 );
    else
        var_14 = maps\_utility::array_spawn_targetname_cg( "enemy_spawner_Frogger_C", 1, 0.05 );

    foreach ( var_10 in var_14 )
        var_10 thread maps\lagos_utility::ignore_until_goal_reached();

    common_scripts\utility::flag_wait( "trigger_start_frogger_kva_D" );
    var_17 = [];

    if ( level.nextgen )
        var_17 = maps\_utility::array_spawn_targetname( "enemy_spawner_Frogger_D", 1 );
    else
        var_17 = maps\_utility::array_spawn_targetname_cg( "enemy_spawner_Frogger_D", 1, 0.05 );

    foreach ( var_10 in var_17 )
        var_10 thread maps\lagos_utility::ignore_until_goal_reached();

    wait 2;
    var_20 = [];

    if ( level.nextgen )
        var_20 = maps\_utility::array_spawn_targetname( "enemy_spawner_Frogger_D_dog", 1 );

    var_21 = [];
    var_21 = common_scripts\utility::array_combine( var_21, var_14 );
    var_21 = common_scripts\utility::array_combine( var_21, var_17 );

    if ( level.nextgen )
        var_21 = common_scripts\utility::array_combine( var_21, var_20 );

    thread maps\lagos_utility::spawn_wave_upkeep_and_flag( var_21, "flag_frogger_complete", 0 );
    common_scripts\utility::flag_wait( "flag_frogger_complete" );
    // common_scripts\utility::flag_wait( "frogger_squad_at_end" );
    common_scripts\utility::flag_set( "begin_traffic_traverse" );
    traffic_traverse_start();
}

frogger_handle_bypass_middle()
{
    var_0 = getthreatbias( "frogger_middle", "friendly_squad" );
    var_1 = getthreatbias( "frogger_middle", "player" );
    common_scripts\utility::flag_wait( "frogger_flag_player_middle" );
    level.player setthreatbiasgroup( "player" );
    setthreatbias( "frogger_middle", "friendly_squad", -10000 );
    setthreatbias( "frogger_middle", "player", 10000 );
}

frogger_squad_crossing()
{
    var_0 = getent( "frogger_bad_place_street_1", "targetname" );
    badplace_brush( "alley_badPlace_frogger_street_1", -1, var_0, "allies" );
    var_1 = getent( "frogger_bad_place_street_2", "targetname" );
    badplace_brush( "alley_badPlace_frogger_street_2", -1, var_1, "allies" );
    level.frogger_teleport_middle = getnodearray( "frogger_teleport_middle", "targetname" );
    level.frogger_teleport_end = getnodearray( "frogger_teleport_end", "targetname" );

    foreach ( var_3 in level.frogger_teleport_middle )
        var_3 disconnectnode();

    foreach ( var_3 in level.frogger_teleport_end )
        var_3 disconnectnode();

    common_scripts\utility::flag_wait( "frogger_flag_player_middle" );
    level.burke thread frogger_teleport_middle_check();
    level.joker thread frogger_teleport_middle_check();
    level.ajani thread frogger_teleport_middle_check();
    common_scripts\utility::flag_wait( "frogger_flag_player_end" );
    level.burke notify( "skip_middle" );
    level.joker notify( "skip_middle" );
    level.ajani notify( "skip_middle" );
    level.burke thread frogger_teleport_end_check();
    level.joker thread frogger_teleport_end_check();
    level.ajani thread frogger_teleport_end_check();
    common_scripts\utility::run_thread_on_targetname( "frogger_squad_at_end", ::frogger_squad_crossing_complete_check, "frogger_squad_at_end" );
}

frogger_teleport_middle_check()
{
    self endon( "death" );
    self endon( "skip_middle" );
    var_0 = 0;
    var_1 = 0;
    var_2 = getdvarfloat( "cg_fov" );
    var_3 = gettime();
    var_4 = 0;

    while ( !var_0 )
    {
        var_4 = 0;

        while ( !maps\_utility::within_fov_2d( level.player.origin, level.player.angles, self.origin, cos( var_2 ) ) )
        {
            if ( var_4 >= 2000 )
            {
                var_0 = 1;
                break;
            }

            var_4 = gettime() - var_3;
            waitframe();
        }

        waitframe();
    }

    while ( !var_1 )
    {
        foreach ( var_6 in level.frogger_teleport_middle )
        {
            if ( !maps\_utility::within_fov_2d( level.player.origin, level.player.angles, var_6.origin, cos( var_2 ) ) && distance2d( level.player.origin, var_6.origin ) > 56 )
            {
                var_6 connectnode();
                level.frogger_teleport_middle = common_scripts\utility::array_remove( level.frogger_teleport_middle, var_6 );
                var_1 = 1;
                maps\_utility::teleport_ai( var_6 );
                break;
            }
        }

        waitframe();
    }
}

frogger_teleport_end_check()
{
    self endon( "death" );
    var_0 = 0;
    var_1 = 0;
    var_2 = getdvarfloat( "cg_fov" );
    var_3 = gettime();
    var_4 = 0;

    while ( !var_0 )
    {
        var_4 = 0;

        while ( !maps\_utility::within_fov_2d( level.player.origin, level.player.angles, self.origin, cos( var_2 ) ) )
        {
            if ( var_4 >= 3000 )
            {
                var_0 = 1;
                break;
            }

            var_4 = gettime() - var_3;
            waitframe();
        }

        waitframe();
    }

    while ( !var_1 )
    {
        foreach ( var_6 in level.frogger_teleport_end )
        {
            if ( !maps\_utility::within_fov_2d( level.player.origin, level.player.angles, var_6.origin, cos( var_2 ) ) && distance2d( level.player.origin, var_6.origin ) > 56 )
            {
                var_6 connectnode();
                level.frogger_teleport_end = common_scripts\utility::array_remove( level.frogger_teleport_end, var_6 );
                var_1 = 1;
                maps\_utility::teleport_ai( var_6 );
                break;
            }
        }

        waitframe();
    }
}

frogger_middle_kill_check()
{
    common_scripts\utility::flag_wait( "frogger_flag_player_end" );
    maps\lagos_utility::kill_after_timeout( level.frogger_middle_guys, 8, 1 );
}

frogger_brake_vehicle_at_trigger( var_0 )
{
    while ( !common_scripts\utility::flag( var_0 ) )
    {
        self waittill( "trigger", var_1 );

        if ( var_1 maps\_vehicle::isvehicle() )
        {
            var_1 vehicle_setspeed( 0, 15, 15 );
            thread frogger_slow_down_lane( var_1.lane, var_0 );
        }
    }
}

frogger_slow_down_lane( var_0, var_1 )
{
    var_2 = "destroy_all_frogger_vehicles_lane_" + var_0;
    level endon( var_2 );

    while ( !common_scripts\utility::flag( var_1 ) )
    {
        if ( var_0 == 1 && !common_scripts\utility::flag( "frogger_stop_lane_1" ) )
            common_scripts\utility::flag_set( "frogger_stop_lane_1" );
        else if ( var_0 == 2 && !common_scripts\utility::flag( "frogger_stop_lane_2" ) )
            common_scripts\utility::flag_set( "frogger_stop_lane_2" );
        else if ( var_0 == 3 && !common_scripts\utility::flag( "frogger_stop_lane_3" ) )
            common_scripts\utility::flag_set( "frogger_stop_lane_3" );
        else if ( var_0 == 4 && !common_scripts\utility::flag( "frogger_stop_lane_4" ) )
            common_scripts\utility::flag_set( "frogger_stop_lane_4" );
        else if ( var_0 == 5 && !common_scripts\utility::flag( "frogger_stop_lane_5" ) )
            common_scripts\utility::flag_set( "frogger_stop_lane_5" );
        else if ( var_0 == 6 && !common_scripts\utility::flag( "frogger_stop_lane_6" ) )
            common_scripts\utility::flag_set( "frogger_stop_lane_6" );
        else if ( var_0 == 7 && !common_scripts\utility::flag( "frogger_stop_lane_7" ) )
            common_scripts\utility::flag_set( "frogger_stop_lane_7" );
        else if ( var_0 == 8 && !common_scripts\utility::flag( "frogger_stop_lane_8" ) )
            common_scripts\utility::flag_set( "frogger_stop_lane_8" );

        foreach ( var_4 in level.frogger_vehicles )
        {
            if ( isdefined( var_4 ) && isdefined( var_4.lane ) && var_4 maps\_vehicle::isvehicle() && var_4.lane == var_0 && var_4 vehicle_getspeed() != 0 )
            {
                if ( var_4 maps\_vehicle::isvehicle() )
                    var_4 vehicle_setspeed( 0, 15, 5 );
            }
        }

        waitframe();
    }

    foreach ( var_4 in level.frogger_vehicles )
    {
        if ( isdefined( var_4 ) && isdefined( var_4.lane ) && var_4 maps\_vehicle::isvehicle() && var_4.lane == var_0 && var_4 vehicle_getspeed() != 40 )
        {
            if ( var_4 maps\_vehicle::isvehicle() )
                var_4 vehicle_setspeed( 40, 15, 5 );
        }
    }

    if ( var_0 == 1 )
        common_scripts\utility::flag_set( "frogger_restart_lane_1" );
    else if ( var_0 == 2 )
        common_scripts\utility::flag_set( "frogger_restart_lane_2" );
    else if ( var_0 == 3 )
        common_scripts\utility::flag_set( "frogger_restart_lane_3" );
    else if ( var_0 == 4 )
        common_scripts\utility::flag_set( "frogger_restart_lane_4" );
    else if ( var_0 == 5 )
        common_scripts\utility::flag_set( "frogger_restart_lane_5" );
    else if ( var_0 == 6 )
        common_scripts\utility::flag_set( "frogger_restart_lane_6" );
    else if ( var_0 == 7 )
        common_scripts\utility::flag_set( "frogger_restart_lane_7" );
    else if ( var_0 == 8 )
        common_scripts\utility::flag_set( "frogger_restart_lane_8" );
}

frogger_squad_crossing_complete_check( var_0 )
{
    var_1 = 0;
    var_2 = 0;
    var_3 = 0;

    for (;;)
    {
        self waittill( "trigger", var_4 );

        if ( issubstr( var_4.script_friendname, "Gideon" ) && var_1 == 0 )
            var_1 = 1;

        if ( issubstr( var_4.script_friendname, "Joker" ) && var_2 == 0 )
            var_2 = 1;

        if ( issubstr( var_4.script_friendname, "Ajani" ) && var_3 == 0 )
            var_3 = 1;

        if ( var_1 == 1 && var_2 == 1 && var_3 == 1 )
            common_scripts\utility::flag_set( var_0 );
    }
}

spawn_vehicle_lane( var_0, var_1 )
{
    var_2 = "destroy_all_frogger_vehicles_lane_" + var_0;
    level endon( var_2 );
    var_3 = 1;
    var_4 = 0;

    while ( !common_scripts\utility::flag( "trigger_stop_timed_lane_traffic" ) )
    {
        if ( common_scripts\utility::flag( "frogger_stop_lane_1" ) && var_0 == 1 )
            common_scripts\utility::flag_wait( "frogger_restart_lane_1" );
        else if ( common_scripts\utility::flag( "frogger_stop_lane_2" ) && var_0 == 2 )
            common_scripts\utility::flag_wait( "frogger_restart_lane_2" );
        else if ( common_scripts\utility::flag( "frogger_stop_lane_3" ) && var_0 == 3 )
            common_scripts\utility::flag_wait( "frogger_restart_lane_3" );
        else if ( common_scripts\utility::flag( "frogger_stop_lane_4" ) && var_0 == 4 )
            common_scripts\utility::flag_wait( "frogger_restart_lane_4" );
        else if ( common_scripts\utility::flag( "frogger_stop_lane_5" ) && var_0 == 5 )
            common_scripts\utility::flag_wait( "frogger_restart_lane_5" );
        else if ( common_scripts\utility::flag( "frogger_stop_lane_6" ) && var_0 == 6 )
            common_scripts\utility::flag_wait( "frogger_restart_lane_6" );
        else if ( common_scripts\utility::flag( "frogger_stop_lane_7" ) && var_0 == 7 )
            common_scripts\utility::flag_wait( "frogger_restart_lane_7" );
        else if ( common_scripts\utility::flag( "frogger_stop_lane_8" ) && var_0 == 8 )
            common_scripts\utility::flag_wait( "frogger_restart_lane_8" );

        if ( var_3 % var_1 )
            var_4 = 0;
        else
            var_4 = 1;

        if ( level.nextgen )
        {
            while ( level.frogger_vehicles.size > 60 )
                waitframe();
        }
        else
        {
            while ( level.frogger_vehicles.size > 10 )
                waitframe();
        }

        var_5 = frogger_spawn_selection( var_0, var_4 );
        level.frogger_vehicles = common_scripts\utility::array_add( level.frogger_vehicles, var_5 );
        waitframe();
        var_5.vehicle_stays_alive = 1;
        var_3++;
        wait(randomfloatrange( 2.5, 4.0 ));
    }
}

frogger_vehicle_hit_react()
{
    self waittill( "damage", var_0, var_1, var_2, var_3, var_4 );

    if ( isplayer( var_1 ) )
        maps\lagos_utility::vehicle_crazy_steering_frogger();
}

frogger_vehicle_hit_fail()
{
    self waittill( "damage", var_0, var_1, var_2, var_3, var_4 );

    if ( isplayer( var_1 ) )
    {
        if ( isdefined( level.lookbothways ) )
            level.lookbothways = 0;

        if ( var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_GRENADE" )
        {
            self kill();
            setdvar( "ui_deadquote", &"SCRIPT_MISSIONFAIL_CIVILIAN_KILLED" );
            maps\_utility::missionfailedwrapper();
        }
    }
}

frogger_spawn_selection( var_0, var_1 )
{
    if ( !var_1 )
    {
        var_2 = randomintrange( 0, level.frogger_spawners.size - 1 );

        while ( level.frogger_spawners[var_2].traffic_locked == 1 )
            waitframe();

        level.frogger_spawners[var_2].traffic_locked = 1;
        var_3 = level.frogger_spawners[var_2] maps\_utility::spawn_vehicle();
        var_3.lane = var_0;
        thread unlock_frogger_traffic_spawner( level.frogger_spawners[var_2] );
        soundscripts\_snd::snd_message( "frogger_vehicle_by", var_3 );
        var_3 thread frogger_vehicle_hit_fail();

        if ( level.nextgen )
        {
            if ( var_0 != 8 && var_0 != 7 && var_0 != 4 )
            {
                var_3 vehphys_disablecrashing();
                var_3 thread frogger_vehicle_hit_react();
            }
        }
    }
    else
    {
        var_2 = randomintrange( 0, level.frogger_bus_spawners.size - 1 );

        while ( level.frogger_bus_spawners[var_2].traffic_locked == 1 )
            waitframe();

        level.frogger_bus_spawners[var_2].traffic_locked = 1;
        var_3 = level.frogger_bus_spawners[var_2] maps\_utility::spawn_vehicle();
        var_3.lane = var_0;
        var_3 thread frogger_vehicle_hit_fail();
        thread unlock_frogger_traffic_spawner( level.frogger_bus_spawners[var_2] );
        soundscripts\_snd::snd_message( "frogger_vehicle_by", var_3 );
    }

    var_3 thread frogger_vehicle_rumble();
    var_4 = undefined;
    var_5 = getent( "civ_vehicle_driver_spawner", "targetname" );

    if ( isdefined( var_5 ) )
    {
        var_4 = var_5 maps\_utility::spawn_ai( 1 );
        var_3 maps\_utility::guy_enter_vehicle( var_4 );
        var_4 setcandamage( 0 );
    }

    var_6 = getvehiclenode( "frogger_lane_" + var_0, "targetname" );
    var_3 vehicle_teleport( var_6.origin, var_6.angles, 1 );
    var_3 thread maps\_vehicle::vehicle_paths( var_6 );
    var_3 startpath( var_6 );
    return var_3;
}

frogger_vehicle_rumble()
{
    self endon( "death" );

    while ( isdefined( self ) )
    {
        if ( common_scripts\utility::distance_2d_squared( self.origin, level.player.origin ) <= 40000 )
        {
            maps\lagos_utility::rumble_frogger_vehicles();
            wait 2;
        }

        waitframe();
    }
}

unlock_frogger_traffic_spawner( var_0 )
{
    waitframe();
    var_0.traffic_locked = 0;
}

delete_vehicle_at_trigger()
{
    for (;;)
    {
        self waittill( "trigger", var_0 );

        if ( var_0 maps\_vehicle::isvehicle() )
        {
            var_0.free_on_death = 1;
            var_0 maps\_vehicle_code::_freevehicle();
            wait 0.05;

            if ( isdefined( var_0.deathfx_ent ) )
                var_0.deathfx_ent delete();

            level.frogger_vehicles = common_scripts\utility::array_remove( level.frogger_vehicles, var_0 );
            var_0 delete();
        }
    }
}

frogger_release_vehicle_at_trigger()
{
    for (;;)
    {
        self waittill( "trigger", var_0 );

        if ( var_0 maps\_vehicle::isvehicle() )
        {
            level.frogger_vehicles = common_scripts\utility::array_remove( level.frogger_vehicles, var_0 );

            if ( level.nextgen )
                var_0 vehicle_setspeed( 40, 15, 5 );
        }
    }
}

destroy_all_frogger_vehicles_lane( var_0 )
{
    var_1 = "destroy_all_frogger_vehicles_lane_" + var_0;
    level notify( var_1 );
    var_2 = [];

    if ( isdefined( level.frogger_vehicles ) && level.frogger_vehicles.size > 0 )
    {
        foreach ( var_4 in level.frogger_vehicles )
        {
            if ( isalive( var_4 ) && var_4.lane == var_0 )
                var_4 delete();
        }
    }
}

player_exo_jump_release_hint_off()
{
    if ( level.player buttonpressed( "DPAD_UP" ) )
        return 1;

    return 0;
}

player_exo_jump_hint_off()
{
    if ( level.player jumpbuttonpressed() )
        return 1;

    return 0;
}

traffic_traverse_start()
{
    soundscripts\_snd::snd_message( "traffic_traverse" );
    common_scripts\utility::flag_wait( "begin_traffic_traverse" );

    while ( !isdefined( level.player_bus_start ) )
        waitframe();

    thread maps\lagos_vo::highway_ledge_jump_prep_dialogue();
    maps\_utility::battlechatter_off( "axis" );
    maps\_utility::battlechatter_off( "allies" );
    var_0 = getent( "anim_org_fence_tear_jump", "targetname" );
    level.org_player_highway_ledge = getent( "anim_org_fence_tear_jump_player", "targetname" );
    var_1 = getent( "highway_pullback_fence", "targetname" );
    var_1.animname = "highway_fence";
    var_1 maps\_utility::assign_animtree();
    var_0 thread maps\_anim::anim_first_frame_solo( var_1, "highway_fence_pull_back" );
    var_2 = maps\_vehicle::spawn_vehicle_from_targetname( "KVA_hostage_truck_pass_fence" );
    var_2.animname = "hostage_truck_fence";
    level.player_bus_start.animname = "highway_bus_1";
    var_0 maps\_anim::anim_reach_solo( level.burke, "burke_traffic_start_pt1" );
    var_0 thread maps\_anim::anim_single_solo( var_1, "highway_fence_pull_back" );
    soundscripts\_snd::snd_message( "traffic_traverse_fence_rip" );
    thread traffic_ledge_burke_loop_wait( var_0 );
    thread traffic_traverse_ledge_player_input();
    common_scripts\utility::flag_wait( "flag_highway_ledge_climb_started" );
    thread check_look_both_ways_achievement();
    common_scripts\utility::flag_set( "obj_progress_pursue_hostage_truck_highway" );
    common_scripts\utility::flag_set( "done_traffic_ledge_jump_start" );
    common_scripts\utility::flag_set( "traffic_ledge_lighting" );
    level.player enableslowaim( 0.2, 0.2 );
    level.player maps\_shg_utility::setup_player_for_scene();
    thread maps\_player_exo::player_exo_deactivate();
    level.player_rig_highway_ledge = maps\_utility::spawn_anim_model( "player_rig", level.player.origin );
    level.player_rig_highway_ledge hide();
    var_3 = 0.5;
    level.player playerlinktoblend( level.player_rig_highway_ledge, "tag_player", var_3 );
    level.player common_scripts\utility::delaycall( var_3, ::playerlinktodelta, level.player_rig_highway_ledge, "tag_player", 1, 7, 7, 5, 5, 1 );
    level.player_rig_highway_ledge common_scripts\utility::delaycall( var_3, ::show );
    thread maps\lagos_vo::highway_ledge_jump_go_dialogue();
    level.player maps\_utility::remove_damage_function( ::frogger_impact_damage_function );
    level.burke maps\lagos_utility::setup_ai_for_bus_sequence();
    level.burke animscripts\utility::setunstableground( 1 );
    level.burke maps\_utility::disable_pain();
    level.burke maps\_utility::disable_surprise();
    level.burke.grenadeammo = 0;
    level.burke.baseaccuracy = 0.15;
    level.burke thread maps\lagos_utility::keep_filling_clip_ammo( 1 );
    level.burke pushplayer( 1 );
    level.burke.pushable = 0;
    var_0 maps\_anim::anim_first_frame_solo( level.player_rig_highway_ledge, "traffic_start_VM" );
    var_0 notify( "stop_loop" );
    var_0 thread maps\_anim::anim_single_solo( level.burke, "burke_traffic_start_pt2" );
    var_0 thread maps\_anim::anim_single_solo( level.player_bus_start, "highway_bus_1_pass_fence" );
    thread start_bus_moving_before_anim_ends( level.player_bus_start, "start_bus_traverse_1", 14.0 );
    thread traffic_anim_bus_1( var_0, var_2 );

    if ( level.currentgen )
        level.org_player_highway_ledge maps\_anim::anim_single_solo( level.player_rig_highway_ledge, "traffic_start_VM", undefined, 0.25 );
    else
        level.org_player_highway_ledge maps\_anim::anim_single_solo( level.player_rig_highway_ledge, "traffic_start_VM" );

    level.burke maps\_utility::set_goal_radius( 16 );
    var_4 = getnode( "cover_bus_traverse_1", "targetname" );
    level.burke maps\_utility::set_goal_node( var_4 );
    level.player unlink();
    level.player_rig_highway_ledge delete();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    level.player allowjump( 1 );
    level.player thread maps\lagos_utility::give_player_more_ammo( 5 );
    level.player disableslowaim();

    if ( level.currentgen )
        level.player setorigin( level.player.origin + ( 0, -36, 5 ) );

    common_scripts\utility::flag_set( "obj_progress_pursue_hostage_truck_highway_traverse" );
    thread maps\lagos_jump::exo_jump_process();
    thread maps\_player_exo::player_exo_activate();
    common_scripts\utility::flag_set( "flag_player_traversing_traffic" );
    thread traffic_traverse_fail_check();
}

check_look_both_ways_achievement()
{
    if ( isdefined( level.lookbothways ) && level.lookbothways )
        maps\_utility::giveachievement_wrapper( "LEVEL_3A" );
}

traffic_ledge_burke_loop_wait( var_0 )
{
    var_0 maps\_anim::anim_single_solo( level.burke, "burke_traffic_start_pt1" );

    if ( !common_scripts\utility::flag( "flag_highway_ledge_climb_started" ) )
        var_0 thread maps\_anim::anim_loop_solo( level.burke, "burke_traffic_start_idle", "stop_loop" );
}

start_bus_moving_before_anim_ends( var_0, var_1, var_2 )
{
    wait(var_2);
    var_3 = getvehiclenode( var_1, "targetname" );
    var_0 startpath( var_3 );
}

traffic_anim_bus_1( var_0, var_1 )
{
    thread traffic_start_camera_shake();
    var_1 thread wheel_for_hostage_car();
    var_0 maps\_anim::anim_single_solo( var_1, "hostage_truck_pass_fence" );
    common_scripts\utility::flag_set( "flag_start_traffic_traverse" );
}

wheel_for_hostage_car()
{
    wait 0.5;
    self setanim( %lag_takedown_van_wheels, 1, 0, -1 );
}

traffic_start_camera_shake()
{
    level endon( "flag_highway_ledge_jump_fail" );
    wait 13;

    if ( common_scripts\utility::flag( "flag_highway_ledge_jump_started" ) && !common_scripts\utility::flag( "missionfailed" ) )
    {
        earthquake( 0.4, 8, level.player.origin, 5000 );
        wait 4;
        traffic_camera_shake_before_middle_td();
    }
}

traffic_camera_shake_before_middle_td()
{
    var_0 = common_scripts\utility::getstruct( "camera_shake_traffic_1", "targetname" );
    earthquake( 0.2, 500, var_0.origin, 15000 );
}

traffic_camera_shake_after_middle_td()
{
    var_0 = common_scripts\utility::getstruct( "camera_shake_traffic_2", "targetname" );
    earthquake( 0.2, 500, var_0.origin, 24000 );
}

trigger_kill_player()
{
    level endon( "player_fell_highway" );
    level.player endon( "qte_fail" );

    while ( !common_scripts\utility::flag( "flag_highway_final_takedown_started" ) )
    {
        self waittill( "trigger", var_0 );

        if ( isdefined( var_0 ) && isplayer( var_0 ) && level.player.jump_state != 2 && !common_scripts\utility::flag( "flag_highway_final_takedown_started" ) )
        {
            earthquake( 0.5, 2, level.player.origin, 512 );
            level.player playrumbleonentity( "damage_heavy" );
            level.player freezecontrols( 1 );
            level.player kill();
            level notify( "player_fell_highway" );
        }
    }
}

traffic_traverse_ledge_player_input()
{
    wait 3;
    common_scripts\utility::run_thread_on_targetname( "trigger_player_ready_for_ledge_climb", ::traffic_traverse_ledge_player_validation );
    var_0 = getent( "traffic_traverse_mantle_point", "targetname" );
    var_1 = maps\_shg_utility::hint_button_position( "a", var_0.origin, 150, 500 );
    common_scripts\utility::flag_wait( "flag_highway_ledge_climb_started" );
    var_1 maps\_shg_utility::hint_button_clear();
}

traffic_traverse_ledge_player_validation()
{
    level endon( "flag_highway_ledge_climb_started" );

    for (;;)
    {
        self waittill( "trigger", var_0 );

        if ( isplayer( var_0 ) )
        {
            level.player allowjump( 0 );
            thread maps\lagos_utility::hint_instant( &"LAGOS_BUS_JUMP_1" );

            while ( common_scripts\utility::flag( "flag_traffic_ledge_jump_trigger" ) )
            {
                if ( level.player jumpbuttonpressed() )
                {
                    thread maps\lagos_utility::hint_fade_instant();
                    common_scripts\utility::flag_set( "flag_highway_ledge_climb_started" );
                    return;
                }

                waitframe();
            }

            level.player allowjump( 1 );
            thread maps\lagos_utility::hint_fade_instant();
        }
    }
}

traffic_traverse_start_player_input()
{
    level.traffic_ledge_jump_trigger_use = getent( "traffic_ledge_jump_trigger_use", "targetname" );
    common_scripts\utility::run_thread_on_targetname( "trigger_player_ready_for_ledge_jump", ::traffic_traverse_start_player_validation );
    var_0 = level.player_bus_start maps\_shg_utility::hint_button_tag( "a", "tag_roof_a", 900, 900 );
    common_scripts\utility::waittill_any_ents( level.player, "traffic_traverse_start_player", level, "flag_highway_ledge_jump_fail" );
    var_0 maps\_shg_utility::hint_button_clear();
}

traffic_traverse_start_player_validation()
{
    level.player notifyonplayercommand( "traffic_traverse_start_player", "+gostand" );
    level.player waittill( "traffic_traverse_start_player" );
    level.player notifyonplayercommandremove( "traffic_traverse_start_player", "+gostand" );
    common_scripts\utility::flag_set( "flag_highway_ledge_jump_started" );
}

traffic_rooftop_traverse()
{
    common_scripts\utility::flag_wait( "flag_setup_highway_vehicles" );
    common_scripts\utility::array_thread( getentarray( "trigger_hurt_player", "targetname" ), ::trigger_kill_player );
    level.bus_jump_count = 1;
    level thread maps\lagos_utility::start_vehicle_traffic_highway_traverse();
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname( "KVA_hostage_truck_chase" );
    var_1 = getvehiclenode( "start_KVA_hostage_truck_chase", "targetname" );
    var_2 = maps\lagos_jump::spawn_vehicle_from_targetname_and_setup_jump_targets( "bus_traverse_1", 4, "tag_roof_a", "tag_roof_b" );
    var_3 = maps\lagos_jump::spawn_vehicle_from_targetname_and_setup_jump_targets( "bus_traverse_2", 4, "tag_roof_a", "tag_roof_b" );
    var_4 = maps\lagos_jump::spawn_vehicle_from_targetname_and_setup_jump_targets( "bus_traverse_3", 4, "tag_roof_a", "tag_roof_b" );
    var_5 = maps\lagos_jump::spawn_vehicle_from_targetname_and_setup_jump_targets( "bus_traverse_4", 4, "tag_roof_a", "tag_roof_b" );
    var_6 = maps\lagos_jump::spawn_vehicle_from_targetname_and_setup_jump_targets( "bus_traverse_5", 4, "tag_roof_a", "tag_roof_b", "tag_roof_c" );
    var_2.vehicle_stays_alive = 1;
    var_3.vehicle_stays_alive = 1;
    var_4.vehicle_stays_alive = 1;
    var_5.vehicle_stays_alive = 1;
    var_6.vehicle_stays_alive = 1;
    thread maps\_vehicle_traffic::add_script_car( var_2, 0 );
    thread maps\_vehicle_traffic::add_script_car( var_3, 0 );
    thread maps\_vehicle_traffic::add_script_car( var_4, 0 );
    thread maps\_vehicle_traffic::add_script_car( var_5, 0 );
    thread maps\_vehicle_traffic::add_script_car( var_6, 0 );
    soundscripts\_snd::snd_message( "handle_busses", [ var_2, var_3, var_4, var_5, var_6 ] );
    level.player_bus_start = var_2;
    level.player_bus = var_4;
    thread traffic_suv_takedown();
    var_7 = getvehiclenode( "start_bus_traverse_1", "targetname" );
    var_8 = getvehiclenode( "start_bus_traverse_2", "targetname" );
    var_9 = getvehiclenode( "start_bus_traverse_3", "targetname" );
    var_10 = getvehiclenode( "start_bus_traverse_4", "targetname" );
    var_11 = getvehiclenode( "start_bus_traverse_5", "targetname" );
    var_12 = getent( "sb_bus_traverse_1", "targetname" );
    var_13 = getent( "sb_bus_traverse_2", "targetname" );
    var_14 = getent( "sb_bus_traverse_3", "targetname" );
    var_15 = getent( "sb_bus_traverse_4", "targetname" );
    var_16 = getent( "sb_bus_traverse_5", "targetname" );
    var_12 linkto( var_2 );
    var_13 linkto( var_3 );
    var_14 linkto( var_4 );
    var_15 linkto( var_5 );
    var_16 linkto( var_6 );
    var_17 = getent( "trigger_bus_traverse_2", "targetname" );
    var_18 = getent( "trigger_bus_traverse_3", "targetname" );
    var_19 = getent( "trigger_bus_traverse_4", "targetname" );
    var_20 = getent( "trigger_bus_traverse_5", "targetname" );
    var_17 maps\lagos_utility::fake_linkto( var_3 );
    var_18 maps\lagos_utility::fake_linkto( var_4 );
    var_19 maps\lagos_utility::fake_linkto( var_5 );
    var_20 maps\lagos_utility::fake_linkto( var_6 );
    level.trigger_bus_traverse_5_flag_in = getent( "traffic_final_takedown_trigger_in", "targetname" );
    level.trigger_bus_traverse_5_flag_in maps\lagos_utility::fake_linkto( var_6 );
    level.trigger_bus_traverse_5_threaded = getent( "trigger_player_ready_for_final_takedown", "targetname" );
    level.trigger_bus_traverse_5_threaded enablelinkto();
    level.trigger_bus_traverse_5_threaded linkto( var_6 );
    level.trigger_bus_traverse_5_looking = getent( "traffic_final_takedown_trigger_looking", "targetname" );
    level.trigger_bus_traverse_5_looking maps\lagos_utility::fake_linkto( var_6 );
    level.final_bus = var_6;
    level.final_bus.animname = "final_bus";
    level.bus_5_hop_blocker_a = getent( "bus_5_hop_blocker_a", "targetname" );
    level.bus_5_hop_blocker_b = getent( "bus_5_hop_blocker_b", "targetname" );
    level.bus_5_hop_blocker_a linkto( var_6 );
    level.bus_5_hop_blocker_b linkto( var_6 );
    var_21 = getent( "trigger_bus_traverse_2_burke", "targetname" );
    var_22 = getent( "trigger_bus_traverse_3_burke", "targetname" );
    var_23 = getent( "trigger_bus_traverse_4_burke", "targetname" );
    var_24 = getent( "trigger_bus_traverse_5_burke", "targetname" );
    var_21 maps\lagos_utility::fake_linkto( var_3 );
    var_22 maps\lagos_utility::fake_linkto( var_4 );
    var_23 maps\lagos_utility::fake_linkto( var_5 );
    var_24 maps\lagos_utility::fake_linkto( var_6 );

    if ( !isdefined( level.debugstart_middle_takedown ) )
    {
        common_scripts\utility::flag_wait( "flag_start_traffic_traverse" );
        var_2 startpath( var_7 );
        var_2 vehphys_disablecrashing();
        var_3 startpath( var_8 );
        var_3 vehphys_disablecrashing();
        common_scripts\utility::flag_wait( "flag_highway_VM_looking_forward" );
        thread traffic_suv_group_a();
        thread traffic_suv_group_b();
        thread traffic_suv_group_c();
    }

    thread traffic_suv_group_d();

    if ( !isdefined( level.debugstart_middle_takedown ) )
    {
        traffic_vehicle_start_check( "trigger_spawn_traverse_2", "bus_traverse_1" );
        thread traffic_burke_jump_bus_2();
        traffic_vehicle_start_check( "trigger_spawn_traverse_3_start", "bus_traverse_2" );
        var_4 startpath( var_9 );
        var_4 vehphys_disablecrashing();
        traffic_vehicle_start_check( "trigger_spawn_traverse_3", "bus_traverse_2" );
        thread traffic_bus_3_flag_check();
        thread traffic_burke_jump_bus_3();
    }

    if ( level.nextgen )
    {
        if ( isdefined( level.burke_middle_takedown ) )
            traffic_vehicle_start_check( "trigger_spawn_traverse_4_start_debug", "bus_traverse_3" );
        else
            traffic_vehicle_start_check( "trigger_spawn_traverse_4_start", "bus_traverse_3" );
    }
    else
        traffic_vehicle_start_check( "trigger_spawn_traverse_4_start_debug", "bus_traverse_3" );

    var_5 startpath( var_10 );
    var_5 vehphys_disablecrashing();
    traffic_vehicle_start_check( "trigger_spawn_traverse_4", "bus_traverse_3" );
    thread traffic_burke_jump_bus_4();
    traffic_vehicle_start_check( "trigger_spawn_traverse_5_start", "bus_traverse_4" );
    var_6 startpath( var_11 );
    var_6 vehphys_disablecrashing();
    var_0 startpath( var_1 );
    traffic_vehicle_start_check( "trigger_spawn_traverse_5", "bus_traverse_4" );
    thread traffic_burke_jump_bus_5();
    common_scripts\utility::flag_wait( "flag_bus_traverse_5_start_takedown" );
    var_0 delete();
}

test_look_b()
{
    for (;;)
    {
        var_0 = common_scripts\utility::flag( "flag_lookat_highway_enemies_B" );

        if ( var_0 )
        {
            iprintlnbold( "B FLAG" );
            return;
        }

        waitframe();
    }
}

test_look_c()
{
    for (;;)
    {
        var_0 = common_scripts\utility::flag( "flag_lookat_highway_enemies_C" );

        if ( var_0 )
        {
            iprintlnbold( "C FLAG" );
            return;
        }

        waitframe();
    }
}

traffic_vehicle_start_check( var_0, var_1 )
{
    var_2 = getent( var_0, "targetname" );

    for (;;)
    {
        var_2 waittill( "trigger", var_3 );

        if ( isdefined( var_3 ) && var_3 maps\_vehicle::isvehicle() && var_3.vehicle_spawner.targetname == var_1 )
            return;
    }
}

traffic_bus_start_check_old( var_0, var_1 )
{
    common_scripts\utility::flag_clear( var_0 );

    for (;;)
    {
        var_2 = common_scripts\utility::flag_wait( var_0 );

        if ( var_2.vehicle_spawner.targetname == var_1 )
            return;
        else
            common_scripts\utility::flag_clear( var_0 );
    }
}

traffic_burke_jump_settings( var_0 )
{
    level.burke_bus_goal = var_0;

    if ( isdefined( level.bus_jump_count ) )
        level.bus_jump_count++;

    level.burke notify( "abort_reload" );
    level.burke maps\_utility::set_ignoreall( 1 );
    level.burke.ignoreme = 1;
    level.burke maps\_utility::set_goal_node( var_0 );
    level.burke waittill( "traverse_finish" );
    level.burke maps\_utility::set_ignoreall( 0 );
    level.burke.ignoreme = 0;

    if ( isdefined( level.bus_jump_count ) )
        thread traffic_burke_miss_failsafe();
}

traffic_burke_miss_failsafe()
{
    wait 8;

    if ( !common_scripts\utility::flag( "flag_bus_traverse_" + level.bus_jump_count + "_burke" ) )
        traffic_burke_recover_failed_jump();
}

traffic_burke_recover_failed_jump()
{
    level.burke maps\_utility::teleport_ai( level.burke_bus_goal );
}

traffic_burke_jump_bus_2()
{
    wait 1;
    thread maps\lagos_vo::highway_traffic_jump_2_dialogue();
    wait 1;
    var_0 = getnode( "cover_bus_traverse_2", "targetname" );
    traffic_burke_jump_settings( var_0 );
}

traffic_burke_jump_bus_3()
{
    thread maps\lagos_vo::highway_traffic_jump_3_dialogue();
    wait 1;
    var_0 = getnode( "cover_bus_traverse_3", "targetname" );
    traffic_burke_jump_settings( var_0 );
}

traffic_burke_jump_bus_4()
{
    wait 1;
    thread maps\lagos_vo::highway_traffic_jump_4_dialogue();
    wait 1;
    var_0 = getnode( "cover_bus_traverse_4", "targetname" );
    traffic_burke_jump_settings( var_0 );
}

traffic_burke_jump_bus_5()
{
    wait 1.5;
    thread maps\lagos_vo::highway_traffic_jump_5_dialogue();
    wait 1;
    var_0 = getnode( "cover_bus_traverse_5", "targetname" );
    traffic_burke_jump_settings( var_0 );
}

traffic_bus_3_flag_check()
{
    common_scripts\utility::flag_wait( "flag_bus_traverse_3" );
    wait 1;
    common_scripts\utility::flag_set( "flag_begin_suv_takedown" );
}

traffic_link_luggage( var_0, var_1, var_2 )
{
    foreach ( var_4 in var_1 )
    {
        if ( var_4.classname == "script_origin" )
            var_0 = var_4;
    }

    foreach ( var_4 in var_1 )
    {
        if ( var_4.classname != "script_origin" )
            var_4 linkto( var_0 );
    }

    var_0 linkto( var_2 );
}

traffic_suv_group_a()
{
    traffic_vehicle_start_check( "trigger_enemy_suv_A", "bus_traverse_1" );

    if ( !common_scripts\utility::flag( "flag_lookat_highway_enemies_A" ) )
        var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "traffic_enemy_suv_A1" );
    else
        var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "traffic_enemy_suv_A1_ALT" );

    var_0 maps\_vehicle::vehicle_set_health( 3000 );
    var_0 soundscripts\_snd::snd_message( "bus_chase_suv_oneshots" );
    var_0 thread maps\lagos_utility::handle_vehicle_death();
    thread maps\_vehicle_traffic::add_script_car( var_0 );
    thread maps\lagos_vo::highway_traffic_first_suvs();
}

traffic_suv_group_b()
{
    traffic_vehicle_start_check( "trigger_enemy_suv_B", "bus_traverse_2" );
    var_0 = common_scripts\utility::flag( "flag_lookat_highway_enemies_B" );

    if ( !common_scripts\utility::flag( "flag_lookat_highway_enemies_B" ) && !common_scripts\utility::flag( "flag_lookat_highway_enemies_B_behind" ) )
        var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "traffic_enemy_suv_B1" );
    else if ( !common_scripts\utility::flag( "flag_lookat_highway_enemies_B_behind" ) )
        var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "traffic_enemy_suv_B1_ALT" );
    else
        var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "traffic_enemy_suv_B1_ALT_2" );

    var_1 maps\_vehicle::vehicle_set_health( 3000 );
    var_1 soundscripts\_snd::snd_message( "bus_chase_suv_oneshots" );
    var_1 thread maps\lagos_utility::handle_vehicle_death();
    thread maps\_vehicle_traffic::add_script_car( var_1 );
}

traffic_suv_group_c()
{
    traffic_vehicle_start_check( "trigger_enemy_suv_C", "bus_traverse_2" );
    var_0 = common_scripts\utility::flag( "flag_lookat_highway_enemies_C" );

    if ( !common_scripts\utility::flag( "flag_lookat_highway_enemies_C" ) )
        var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "traffic_enemy_suv_C1" );
    else
        var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "traffic_enemy_suv_C1_ALT" );

    var_1 maps\_vehicle::vehicle_set_health( 3000 );
    var_1 soundscripts\_snd::snd_message( "bus_chase_suv_oneshots" );
    var_1 thread maps\lagos_utility::handle_vehicle_death();
    thread maps\_vehicle_traffic::add_script_car( var_1 );
}

traffic_suv_group_d()
{
    traffic_vehicle_start_check( "trigger_enemy_helicopter", "bus_traverse_3" );
    traffic_helicopter();
}

traffic_suv_group_e()
{
    traffic_vehicle_start_check( "trigger_enemy_suv_E", "bus_traverse_5" );
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "traffic_enemy_suv_E1" );
    var_0 maps\_vehicle::vehicle_set_health( 3000 );
    var_0 soundscripts\_snd::snd_message( "bus_chase_suv_oneshots" );
    var_0 thread maps\lagos_utility::handle_vehicle_death();
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "traffic_enemy_suv_E2" );
    var_1 maps\_vehicle::vehicle_set_health( 3000 );
    var_1 soundscripts\_snd::snd_message( "bus_chase_suv_oneshots" );
    var_1 thread maps\lagos_utility::handle_vehicle_death();
    thread maps\_vehicle_traffic::add_script_car( var_1 );
}

traffic_suv_takedown()
{
    level.player endon( "death" );
    common_scripts\utility::flag_wait( "flag_begin_suv_takedown" );
    maps\lagos_qte_middle::setup_vehicles_for_middle_takedown();
    var_0 = getent( "KVA_0_middle_takedown", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_1 = getent( "KVA_1_middle_takedown", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_2 = getent( "KVA_3_middle_takedown", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_0.ignoreall = 1;
    var_1.ignoreall = 1;
    var_2.ignoreall = 1;
    var_0.animname = "KVA_0";
    var_1.animname = "KVA_1";
    var_2.animname = "KVA_3";
    var_1 thread maps\lagos_utility::challenge_point_award_on_damage();
    var_2 thread maps\lagos_utility::challenge_point_award_on_damage();
    var_3 = maps\_utility::spawn_anim_model( "player_rig" );
    var_4 = getent( "anim_org_middle_takedown", "targetname" );
    thread maps\lagos_vo::highway_traffic_middle_takedown_dialogue();
    common_scripts\utility::flag_clear( "flag_player_traversing_traffic" );
    thread maps\lagos_qte_middle::takedown_qte_middle( var_4, var_0, var_1, var_2, var_3, level.player_bus, level.kva_truck );
    wait 2;

    if ( isdefined( level.burke_middle_takedown ) )
    {
        if ( level.burke_middle_takedown )
        {
            var_5 = getnode( "cover_bus_traverse_3", "targetname" );
            level.burke maps\_utility::teleport_ai( var_5 );
        }
    }
}

#using_animtree("generic_human");

traffic_helicopter()
{
    level.helo = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "KVA_helicopter_1" );
    level.helo maps\_vehicle::vehicle_set_health( 4200 );
    level.helo endon( "death" );
    thread maps\lagos_vo::highway_traffic_helo_callout();
    level.vehicle_aianims["script_vehicle_littlebird_kva_armed"][2].explosion_death = %death_explosion_stand_f_v1;
    level.vehicle_aianims["script_vehicle_littlebird_kva_armed"][3].explosion_death = %death_explosion_stand_f_v2;
    level.vehicle_aianims["script_vehicle_littlebird_kva_armed"][4].explosion_death = %death_explosion_stand_f_v3;
    level.vehicle_aianims["script_vehicle_littlebird_kva_armed"][5].explosion_death = %death_explosion_stand_f_v4;
    level.vehicle_aianims["script_vehicle_littlebird_kva_armed"][6].explosion_death = %death_explosion_stand_f_v1;
    level.vehicle_aianims["script_vehicle_littlebird_kva_armed"][7].explosion_death = %death_explosion_stand_f_v2;
    level.helo soundscripts\_snd::snd_message( "spawn_traffic_helicopter" );
    var_0 = getent( "heli_bullet_source_left", "targetname" );
    var_0 linkto( level.helo );
    var_1 = getent( "heli_bullet_source_right", "targetname" );
    var_1 linkto( level.helo );
    level.burke.baseaccuracy = 0.05;
    level.player maps\_utility::add_damage_function( ::highway_veteran_helo_reduction );
    wait 3;
    level.helo thread traffic_helicopter_magic_bullet_fire( var_1, "flag_traffic_helicopter_stop_right" );
    wait 4;
    common_scripts\utility::flag_set( "flag_traffic_helicopter_stop_right" );
    wait 3;
    level.helo thread traffic_helicopter_magic_bullet_fire( var_0, "flag_traffic_helicopter_stop_left" );
    common_scripts\utility::flag_wait( "flag_kill_helicopter" );
    common_scripts\utility::flag_set( "flag_traffic_helicopter_stop_left" );

    if ( isdefined( level.helo ) || isalive( level.helo ) )
        level.helo notify( "death" );

    level.player maps\_utility::remove_damage_function( ::highway_veteran_helo_reduction );
}

highway_veteran_helo_reduction( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( var_4 == "MOD_RIFLE_BULLET" && ( maps\_utility::getdifficulty() == "fu" || maps\_utility::getdifficulty() == "hard" ) )
        var_0 = level.player.maxhealth * 0.152 / level.player.damagemultiplier;
}

traffic_helicopter_magic_bullet_fire( var_0, var_1 )
{
    self endon( "death" );
    var_2 = 0;
    var_3 = level.burke.origin;

    while ( !common_scripts\utility::flag( var_1 ) )
    {
        if ( !isdefined( level.helo ) || !isalive( level.helo ) || isdefined( level.helo.crashing ) )
            return;

        if ( var_2 == 0 )
            var_3 = level.burke.origin + 75 * anglestoright( level.burke.origin );
        else if ( var_2 == 1 )
            var_3 = level.burke.origin - 75 * anglestoright( level.burke.origin );
        else if ( var_2 == 2 )
            var_3 = level.player.origin + 75 * anglestoforward( level.burke.origin );
        else if ( var_2 == 3 )
            var_3 = level.burke.origin - 75 * anglestoforward( level.burke.origin );
        else if ( var_2 == 4 )
            var_3 = level.player.origin + 60 * anglestoup( level.player.angles );
        else if ( var_2 == 5 )
            var_3 = level.burke.origin + 75 * anglestoforward( level.burke.origin );
        else if ( var_2 == 6 )
            var_3 = level.burke.origin - 75 * anglestoright( level.burke.origin );
        else if ( var_2 == 7 )
            var_3 = level.player.origin - 75 * anglestoright( level.burke.origin );
        else if ( var_2 == 8 )
            var_3 = level.player.origin;

        magicbullet( "iw5_bal27_sp", var_0.origin, var_3 );
        soundscripts\_snd::snd_message( "chase_heli_fire" );
        wait 0.15;
        var_2++;

        if ( var_2 > 8 )
            var_2 = 0;
    }
}

traffic_takedown()
{
    common_scripts\utility::flag_wait( "flag_bus_traverse_5_start_takedown" );
    thread maps\lagos_lighting::ramp_down_motion_blur();

    if ( isdefined( "traffic_weapons" ) )
        level.player maps\_utility::restore_players_weapons( "traffic_weapons" );

    thread maps\_player_exo::player_exo_deactivate();
    thread maps\lagos_vo::highway_traffic_takedown_dialogue();
    var_0 = getent( "anim_org_takedown", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "player_rig", ( -7582.65, 53106.6, 1405.83 ), ( 0, 209.996, 0 ) );
    var_1 hide();

    if ( !common_scripts\utility::flag( "takedown_playerstart" ) )
    {
        level waittill( "bus_jump_player_landed" );
        level.player notify( "exo_jump_process_end" );
        level.bus_5_hop_blocker_a delete();
        level.bus_5_hop_blocker_b delete();
        thread maps\lagos_utility::start_end_takedown_highway_path_player_side();
        var_0 maps\lagos_qte::setup_vehicles_for_takedown();
        var_0 maps\_anim::anim_first_frame_solo( level.hostage_truck, "hostage_truck_takedown_pt1" );
        level.player unlink();
        var_1.origin = getstartorigin( level.hostage_truck gettagorigin( "tag_body" ), level.hostage_truck gettagangles( "tag_body" ), var_1 maps\_utility::getanim( "hostage_truck_takedown_pt0" ) );
        var_1 dontcastshadows();
        level.hostage_truck maps\_anim::anim_first_frame_solo( var_1, "hostage_truck_takedown_pt0", "tag_body" );
        var_0 maps\_anim::anim_first_frame_solo( level.final_bus, "hostage_truck_takedown_pt1" );
        var_1 linkto( level.hostage_truck, "tag_body" );
        level.player setorigin( var_1 gettagorigin( "tag_player" ) );
        level.player playerlinktoabsolute( var_1, "tag_player" );
        var_1 show();
        level.hostage_truck thread maps\_anim::anim_single_solo( var_1, "hostage_truck_takedown_pt0", "tag_body" );
        var_2 = getanimlength( var_1 maps\_utility::getanim( "hostage_truck_takedown_pt0" ) );
        level.player common_scripts\utility::delaycall( var_2, ::unlink );
        var_1 common_scripts\utility::delaycall( var_2, ::hide );
        level.player maps\_utility::delaythread( var_2, maps\_shg_utility::setup_player_for_gameplay );
        earthquake( 1, 0.5, level.player.origin, 10000 );

        if ( isdefined( level.jumping_rig ) )
            level.jumping_rig delete();
    }
    else
        var_0 maps\lagos_qte::setup_vehicles_for_takedown();

    var_1 show();
    level.player notifyonplayercommandremove( "exo_jump_button", "+gostand" );

    if ( !common_scripts\utility::flag( "takedown_playerstart" ) )
    {
        thread maps\_utility::autosave_now_silent();
        var_3 = [];
        var_3[var_3.size] = level.final_bus;
        var_3[var_3.size] = level.hostage_truck;
        var_0 thread maps\_anim::anim_single_solo( level.final_bus, "hostage_truck_takedown_pt1" );
        var_0 thread traffic_traverse_final_takedown_truck_start( level.hostage_truck );
        level.burke thread traffic_traverse_final_takedown_burke_start();
        thread traffic_traverse_final_takedown_start_player_input();
        common_scripts\utility::flag_wait( "flag_highway_final_takedown_started" );
    }
    else
        common_scripts\utility::flag_set( "flag_highway_final_takedown_started" );

    setsaveddvar( "g_friendlynamedist", 0 );
    common_scripts\utility::flag_clear( "flag_player_traversing_traffic" );

    if ( !isdefined( level.burke ) )
        level.burke = getent( "burke_takedown", "targetname" ) maps\_utility::spawn_ai( 1, 1 );

    var_4 = getent( "KVA_1_takedown", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_5 = getent( "KVA_2_takedown", "targetname" ) maps\_utility::spawn_ai( 1 );
    level.hostage_1 = getent( "hostage_1_takedown", "targetname" ) maps\_utility::spawn_ai( 1, 1 );
    var_6 = getent( "hostage_2_takedown", "targetname" ) maps\_utility::spawn_ai( 1, 1 );
    var_7 = getent( "hostage_3_takedown", "targetname" ) maps\_utility::spawn_ai( 1, 1 );
    var_8 = getent( "oncoming_driver_takedown", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_6.ignoreall = 1;
    var_7.ignoreall = 1;
    var_6.ignoreme = 1;
    var_7.ignoreme = 1;
    var_4 maps\_utility::gun_remove();
    var_5 maps\_utility::gun_remove();
    var_4 maps\_utility::place_weapon_on( "iw5_kf5_sp", "right" );
    var_5 maps\_utility::place_weapon_on( "iw5_kf5_sp", "right" );
    var_4.weapon = "iw5_kf5_sp";
    var_5.weapon = "iw5_kf5_sp";
    level.burke.ignoreall = 1;
    level.burke.animname = "burke";
    var_4.animname = "KVA_1";
    var_5.animname = "KVA_2";
    level.hostage_1.animname = "hostage_1";
    var_6.animname = "hostage_2";
    var_7.animname = "hostage_3";
    var_8.animname = "oncoming_driver";
    var_4.ignoreall = 1;
    var_5.ignoreall = 1;
    var_4.health = 1;
    var_5.health = 1;
    var_4 thread maps\lagos_utility::challenge_point_award_on_damage();
    var_5 thread maps\lagos_utility::challenge_point_award_on_damage();
    maps\lagos_utility::disable_exo_for_highway();
    thread maps\lagos_qte::takedown_qte( var_0, level.burke, var_4, var_5, level.hostage_1, var_6, var_7, var_8, var_1, level.hostage_truck, level.hostage_truck_oncoming );
    level waittill( "swimming_start" );
    common_scripts\utility::flag_set( "obj_progress_pursue_hostage_truck_highway_swim" );
    thread enable_player_swimming();
    thread lagos_player_swimming_pt1();
    thread lagos_player_swimming_pt2();
    level waittill( "swimming_fade" );
    level.player enableinvulnerability();
    var_9 = 3;
    thread maps\_hud_util::fade_out( var_9, "black" );
    var_1 common_scripts\utility::delaycall( var_9, ::delete );
    thread shore_pcap();
    maps\_utility::notify_delay( "swimming_end", var_9 );
}

traffic_traverse_final_takedown_truck_start( var_0 )
{
    level endon( "flag_player_hold_on" );
    level endon( "flag_highway_final_takedown_started" );
    thread maps\_anim::anim_single_solo( var_0, "hostage_truck_takedown_pt1" );
    var_0 thread wheel_for_hostage_car();
    level waittill( "hostage_truck_takedown_pt1_fail" );
    level notify( "traffic_traverse_final_takedown_jump_failed" );
    setdvar( "ui_deadquote", &"LAGOS_BUS_JUMP_FAILED" );
    thread maps\_utility::missionfailedwrapper();
}

traffic_traverse_final_takedown_burke_start()
{
    level endon( "flag_player_hold_on" );
    level.burke linkto( level.hostage_truck, "tag_body" );
    level.hostage_truck maps\_anim::anim_single_solo( level.burke, "lag_truck_takedown_pt1_into", "tag_body" );
    level.player.jump_state = 0;
    level.hostage_truck maps\_anim::anim_loop_solo( level.burke, "lag_truck_takedown_pt1_burke_loop", undefined, "tag_body" );
}

traffic_traverse_final_takedown_start_player_input()
{
    var_0 = 600;
    common_scripts\utility::run_thread_on_targetname( "trigger_player_ready_for_final_takedown", ::traffic_traverse_final_takedown_start_player_validation, var_0 );
    var_1 = level.hostage_truck maps\_shg_utility::hint_button_tag( "a", "tag_mirror_right", 900, 900 );
    common_scripts\utility::flag_wait( "flag_highway_final_takedown_started" );
    soundscripts\_snd::snd_message( "final_takedown_abutton_hit" );
    thread maps\lagos_lighting::ramp_up_motion_blur();
    var_1 maps\_shg_utility::hint_button_clear();
}

traffic_traverse_final_takedown_start_player_validation( var_0 )
{
    level.player notifyonplayercommand( "final_takedown_jump", "+gostand" );
    level endon( "flag_highway_final_takedown_started" );
    level endon( "traffic_traverse_final_takedown_jump_failed" );

    for (;;)
    {
        while ( !level.player isonground() )
            wait 0.05;

        level.player waittill( "final_takedown_jump" );

        if ( traffic_player_hostage_truck_jump_passed( var_0 ) )
            common_scripts\utility::flag_set( "flag_highway_final_takedown_started" );
    }
}

traffic_player_hostage_truck_jump_passed( var_0 )
{
    if ( level.player worldpointinreticle_circle( level.hostage_truck.origin + ( 0, 0, 72 ), 65, 500 ) )
    {
        if ( distance( level.player.origin, level.hostage_truck.origin ) <= var_0 )
        {
            if ( level.player getnormalizedmovement()[0] > 0.5 )
            {
                if ( common_scripts\utility::flag( "flag_traffic_final_takedown_trigger_in" ) )
                    return 1;
            }
        }
    }

    return 0;
}

shore_pcap( var_0 )
{
    common_scripts\utility::flag_set( "obj_complete_pursue_hostage_truck" );
    thread maps\_player_exo::player_exo_deactivate();
    level.player enableslowaim( 0.2, 0.2 );

    if ( isdefined( var_0 ) )
        wait(var_0);
    else
        wait 6;

    var_1 = 55;
    level.player lerpfov( var_1, 0.1 );

    if ( !isdefined( level.burke ) )
        level.burke = getent( "burke_takedown", "targetname" ) maps\_utility::spawn_ai( 1, 1 );

    if ( !isdefined( level.hostage_1 ) )
        level.hostage_1 = getent( "hostage_1_takedown", "targetname" ) maps\_utility::spawn_ai( 1 );

    var_2 = getent( "joker_takedown", "targetname" ) maps\_utility::spawn_ai( 1, 1 );
    var_3 = getent( "ajani_takedown", "targetname" ) maps\_utility::spawn_ai( 1, 1 );
    var_2.animname = "joker";
    var_3.animname = "ajani";
    level.hostage_1.animname = "hostage_1";
    var_4 = maps\_utility::spawn_anim_model( "player_rig" );
    level.player maps\_shg_utility::setup_player_for_scene();
    var_5 = getent( "anim_org_takedown", "targetname" );
    thread maps\_hud_util::fade_in( 3, "black" );
    thread maps\lagos_vo::pcap_shore_outro();
    var_6 = [ level.burke, var_2, var_3, var_4, level.hostage_1 ];
    level.player playerlinktodelta( var_4, "tag_player", 1, 7, 7, 5, 5, 1 );
    waitframe();
    soundscripts\_snd::snd_message( "shore_ending" );
    level.hostage_1 attach( "npc_bal27_nocamo", "TAG_WEAPON_RIGHT", 0 );
    var_5 thread maps\_anim::anim_single( var_6, "hostage_truck_takedown_pt5" );
    thread maps\lagos_fx::vfx_shore_outro_start();
    common_scripts\utility::flag_set( "shoreline_lighting" );
    maps\lagos_utility::prep_cinematic( "fusion_endlogo" );
    wait 30;
    var_7 = 2;
    thread maps\lagos_utility::ending_fade_out( var_7 );
    thread maps\_utility::battlechatter_off( "allies" );
    thread maps\_utility::battlechatter_off( "axis" );
    wait(var_7);
    level.player freezecontrols( 1 );
    level.player unlink();
    var_4 delete();
    maps\_utility::nextmission();
}

enable_player_swimming()
{
    thread disable_player_swimming();
    level.player disableweapons();
    level.player disableinvulnerability();
}

disable_player_swimming()
{
    level waittill( "swimming_end" );
}

lagos_player_swimming_pt1()
{
    level waittill( "latch_opened" );
    level notify( "pry_check_success" );
    level notify( "swimming_saved" );
}

lagos_player_swimming_pt2()
{
    level waittill( "swimming_saved" );
    common_scripts\utility::flag_wait( "player_swimming_end" );
    level notify( "swimming_shore" );
}

lagos_player_swimming_truck_anims()
{
    waitframe();
}

hostage_truck_swimming_drowning_monitor( var_0 )
{
    level endon( "swimming_saved" );
    level endon( "swimming_shore" );
    wait 15;

    for ( var_1 = 0; !common_scripts\utility::flag( var_0 ); var_1++ )
    {
        level.player dodamage( 10, level.player.origin );

        if ( var_1 == 1 || var_1 == 4 || var_1 == 8 )
        {

        }

        wait 1;
    }
}

traffic_traverse_fail_check()
{
    level.player endon( "death" );
    var_0 = 1210000;

    while ( common_scripts\utility::flag( "flag_player_traversing_traffic" ) && isdefined( level.bus_jump_count ) )
    {
        if ( distance2dsquared( level.player.origin, level.burke.origin ) > var_0 )
        {
            if ( level.bus_jump_count > 1 && !common_scripts\utility::flag( "flag_bus_traverse_" + level.bus_jump_count + "_burke" ) )
                traffic_burke_recover_failed_jump();
        }

        if ( distance2dsquared( level.player.origin, level.burke.origin ) > var_0 )
        {
            common_scripts\utility::flag_clear( "flag_player_traversing_traffic" );
            setdvar( "ui_deadquote", &"LAGOS_BUS_JUMP_FAILED" );
            maps\_utility::missionfailedwrapper();
        }

        wait 0.25;
    }
}

player_upkeep()
{
    level.player givemaxammo( "iw5_bal27_sp_variablereddot" );
}

level_bounds()
{
    thread level_bounds_nag();
    thread level_bounds_fail();
}

level_bounds_nag()
{
    var_0 = 0;

    for (;;)
    {
        if ( common_scripts\utility::flag( "flag_level_bounds_nag" ) )
        {
            while ( common_scripts\utility::flag( "flag_level_bounds_nag" ) )
            {
                thread maps\lagos_vo::level_bounds_nag_vo( var_0 );
                thread maps\lagos_utility::hint_instant( &"LAGOS_BOUNDS_WARNING", 8 );
                wait 8;
                var_0++;

                if ( var_0 > 2 )
                    var_0 = 0;
            }
        }

        waitframe();
    }
}

level_bounds_fail()
{
    for (;;)
    {
        if ( common_scripts\utility::flag( "flag_level_bounds_fail" ) )
        {
            level notify( "level_bounds_fail" );
            setdvar( "ui_deadquote", &"LAGOS_BOUNDS_FAIL" );
            maps\_utility::missionfailedwrapper();
            return;
        }

        wait 1;
    }
}

level_progress()
{
    thread level_progress_exodoor();
    thread level_progress_monorail();
    thread level_progress_govexit();
    thread level_progress_roundaboutcombat();
    thread level_progress_alley1combat();
    thread level_progress_oncomingcombat();
    thread level_progress_flankcombat();
    thread level_progress_froggercombat();
    thread level_progress_froggercomplete();
}

level_progress_nag( var_0 )
{
    var_1 = 0;

    for (;;)
    {
        if ( common_scripts\utility::flag( var_0 ) )
        {
            while ( common_scripts\utility::flag( var_0 ) )
            {
                thread maps\lagos_vo::level_bounds_nag_vo( var_1 );
                thread maps\lagos_utility::hint_instant( &"LAGOS_BOUNDS_WARNING", 8 );
                wait 8;
                var_1++;

                if ( var_1 > 2 )
                    var_1 = 0;
            }
        }

        waitframe();
    }
}

level_progress_fail( var_0 )
{
    level endon( "level_bounds_fail" );

    for (;;)
    {
        if ( common_scripts\utility::flag( var_0 ) )
        {
            waitframe();
            setdvar( "ui_deadquote", &"LAGOS_BOUNDS_FAIL" );
            maps\_utility::missionfailedwrapper();
            return;
        }

        wait 1;
    }
}

level_progress_exodoor()
{
    var_0 = getent( "level_progress_exoDoor_nag", "targetname" );
    var_1 = getent( "level_progress_exoDoor_fail", "targetname" );
    var_0 common_scripts\utility::trigger_off();
    var_1 common_scripts\utility::trigger_off();
    common_scripts\utility::flag_wait( "flag_level_progress_exoDoor" );
    wait 2;
    var_0 common_scripts\utility::trigger_on();
    var_1 common_scripts\utility::trigger_on();
    thread level_progress_nag( "flag_level_progress_exoDoor_nag" );
    thread level_progress_fail( "flag_level_progress_exoDoor_fail" );
}

level_progress_monorail()
{
    var_0 = getent( "level_progress_monorail_nag", "targetname" );
    var_1 = getent( "level_progress_monorail_fail", "targetname" );
    var_0 common_scripts\utility::trigger_off();
    var_1 common_scripts\utility::trigger_off();
    common_scripts\utility::flag_wait( "flag_level_progress_monorail" );
    wait 2;
    var_0 common_scripts\utility::trigger_on();
    var_1 common_scripts\utility::trigger_on();
    thread level_progress_nag( "flag_level_progress_monorail_nag" );
    thread level_progress_fail( "flag_level_progress_monorail_fail" );
}

level_progress_govexit()
{
    var_0 = getent( "level_progress_govExit_nag", "targetname" );
    var_1 = getent( "level_progress_govExit_fail", "targetname" );
    var_0 common_scripts\utility::trigger_off();
    var_1 common_scripts\utility::trigger_off();
    common_scripts\utility::flag_wait( "flag_level_progress_govExit" );
    var_0 common_scripts\utility::trigger_on();
    var_1 common_scripts\utility::trigger_on();
    thread level_progress_nag( "flag_level_progress_govExit_nag" );
    thread level_progress_fail( "flag_level_progress_govExit_fail" );
}

level_progress_roundaboutcombat()
{
    var_0 = getent( "level_progress_roundaboutCombat_nag", "targetname" );
    var_1 = getent( "level_progress_roundaboutCombat_fail", "targetname" );
    var_2 = getent( "level_progress_roundaboutCombat_bypass_nag", "targetname" );
    var_3 = getent( "level_progress_roundaboutCombat_bypass_fail", "targetname" );
    var_0 common_scripts\utility::trigger_off();
    var_1 common_scripts\utility::trigger_off();
    var_2 common_scripts\utility::trigger_off();
    var_3 common_scripts\utility::trigger_off();
    common_scripts\utility::flag_wait( "flag_level_progress_roundaboutCombat" );
    var_0 common_scripts\utility::trigger_on();
    var_1 common_scripts\utility::trigger_on();
    var_2 common_scripts\utility::trigger_on();
    var_3 common_scripts\utility::trigger_on();
    thread level_progress_nag( "flag_level_progress_roundaboutCombat_nag" );
    thread level_progress_fail( "flag_level_progress_roundaboutCombat_fail" );
    thread level_progress_nag( "flag_level_progress_roundaboutCombat_bypass_nag" );
    thread level_progress_fail( "flag_level_progress_roundaboutCombat_bypass_fail" );
    common_scripts\utility::flag_wait( "obj_progress_find_hostage_truck_roundabout_complete" );
    var_2 common_scripts\utility::trigger_off();
    var_3 common_scripts\utility::trigger_off();
}

level_progress_alley1combat()
{
    var_0 = getent( "level_progress_alley1Combat_nag", "targetname" );
    var_1 = getent( "level_progress_alley1Combat_fail", "targetname" );
    var_0 common_scripts\utility::trigger_off();
    var_1 common_scripts\utility::trigger_off();
    common_scripts\utility::flag_wait( "flag_level_progress_alley1Combat" );
    common_scripts\utility::flag_wait( "flag_level_progress_alley1Combat_squad" );
    var_0 common_scripts\utility::trigger_on();
    var_1 common_scripts\utility::trigger_on();
    thread level_progress_nag( "flag_level_progress_alley1Combat_nag" );
    thread level_progress_fail( "flag_level_progress_alley1Combat_fail" );
}

level_progress_oncomingcombat()
{
    var_0 = getent( "level_progress_oncomingCombat_nag", "targetname" );
    var_1 = getent( "level_progress_oncomingCombat_fail", "targetname" );
    var_0 common_scripts\utility::trigger_off();
    var_1 common_scripts\utility::trigger_off();
    common_scripts\utility::flag_wait( "oncoming_alley_player_pos" );
    var_0 common_scripts\utility::trigger_on();
    var_1 common_scripts\utility::trigger_on();
    thread level_progress_nag( "flag_level_progress_oncomingCombat_nag" );
    thread level_progress_fail( "flag_level_progress_oncomingCombat_fail" );
}

level_progress_flankcombat()
{
    var_0 = getent( "level_progress_flankCombat_nag", "targetname" );
    var_1 = getent( "level_progress_flankCombat_fail", "targetname" );
    var_0 common_scripts\utility::trigger_off();
    var_1 common_scripts\utility::trigger_off();
    common_scripts\utility::flag_wait( "flag_level_progress_flankCombat" );
    var_0 common_scripts\utility::trigger_on();
    var_1 common_scripts\utility::trigger_on();
    thread level_progress_nag( "flag_level_progress_flankCombat_nag" );
    thread level_progress_fail( "flag_level_progress_flankCombat_fail" );
}

level_progress_froggercombat()
{
    var_0 = getent( "level_progress_froggerCombat_nag", "targetname" );
    var_1 = getent( "level_progress_froggerCombat_fail", "targetname" );
    var_0 common_scripts\utility::trigger_off();
    var_1 common_scripts\utility::trigger_off();
    common_scripts\utility::flag_wait( "flag_level_progress_froggerCombat" );
    var_0 common_scripts\utility::trigger_on();
    var_1 common_scripts\utility::trigger_on();
    thread level_progress_nag( "flag_level_progress_froggerCombat_nag" );
    thread level_progress_fail( "flag_level_progress_froggerCombat_fail" );
}

level_progress_froggercomplete()
{
    var_0 = getent( "level_progress_froggerComplete_nag", "targetname" );
    var_1 = getent( "level_progress_froggerComplete_fail", "targetname" );
    var_0 common_scripts\utility::trigger_off();
    var_1 common_scripts\utility::trigger_off();
    common_scripts\utility::flag_wait( "flag_level_progress_froggerComplete" );
    var_0 common_scripts\utility::trigger_on();
    var_1 common_scripts\utility::trigger_on();
    thread level_progress_nag( "flag_level_progress_froggerComplete_nag" );
    thread level_progress_fail( "flag_level_progress_froggerComplete_fail" );
}

notetrack_gov_wall_climb_intro_right_start( var_0 )
{
    level.player playrumbleonentity( "damage_light" );
}

notetrack_gov_wall_climb_intro_left_start( var_0 )
{
    level.player playrumbleonentity( "damage_light" );
}

notetrack_gov_wall_climb_intro_right_plant( var_0 )
{
    level.player playrumbleonentity( "artillery_rumble" );
}

notetrack_gov_wall_climb_intro_left_plant( var_0 )
{
    level.player playrumbleonentity( "artillery_rumble" );
}

notetrack_roof_breach_medium( var_0 )
{
    level.player playrumbleonentity( "damage_heavy" );
}

notetrack_roof_breach_small( var_0 )
{
    level.player playrumbleonentity( "damage_light" );
    wait 4;
    level.player playrumbleonentity( "damage_heavy" );
}

notetrack_roof_breach_large( var_0 )
{
    wait 0.5;
    level.player playrumbleonentity( "artillery_rumble" );
}

notetrack_roof_breach_land( var_0 )
{
    level.player playrumbleonentity( "artillery_rumble" );
}

notetrack_h_breach_small( var_0 )
{
    level.player playrumbleonentity( "damage_light" );
}

notetrack_gov_rescue_handcuffs( var_0 )
{
    level.player playrumbleonentity( "damage_light" );
}

notetrack_highway_bus_land_from_ledge( var_0 )
{
    level.player playrumbleonentity( "artillery_rumble" );
}

notetrack_highway_jump_land( var_0 )
{
    level.player playrumbleonentity( "artillery_rumble" );
}

notetrack_middle_takedown_grab_side( var_0 )
{
    wait 0.1;
    level.player playrumbleonentity( "damage_heavy" );
}

notetrack_middle_takedown_truck_swipe( var_0 )
{
    common_scripts\utility::flag_wait( "flag_player_dodge" );
    wait 0.25;
    level.player playrumbleonentity( "artillery_rumble" );
}

notetrack_middle_takedown_jump_to_truck( var_0 )
{
    common_scripts\utility::flag_wait( "flag_player_jump" );
    level.player playrumbleonentity( "damage_light" );
}

notetrack_middle_takedown_land_on_truck( var_0 )
{
    common_scripts\utility::flag_wait( "flag_player_jump" );
    wait 1.25;
    level.player playrumbleonentity( "artillery_rumble" );
}

notetrack_middle_takedown_punch_window( var_0 )
{
    common_scripts\utility::flag_wait( "flag_player_pull_windshield" );
    wait 0.25;
    level.player playrumbleonentity( "artillery_rumble" );
    rumble_middle_takedown_throw_guy();
}

rumble_middle_takedown_throw_guy()
{
    wait 1.5;
    level.player playrumbleonentity( "damage_heavy" );
    wait 2;
    level.player playrumbleonentity( "artillery_rumble" );
}

notetrack_middle_takedown_jump_to_bus( var_0 )
{
    common_scripts\utility::flag_wait( "flag_player_jump2" );
    level.player playrumbleonentity( "damage_light" );
}

notetrack_middle_takedown_land_on_bus( var_0 )
{
    common_scripts\utility::flag_wait( "flag_player_jump2" );
    wait 1.5;
    level.player playrumbleonentity( "artillery_rumble" );
}

notetrack_highway_final_td_mirror_snap_and_drag( var_0 )
{
    level.player playrumbleonentity( "damage_heavy" );
    wait 1;
    level.player playrumbleonentity( "artillery_rumble" );
}

notetrack_highway_final_td_suv_collision( var_0 )
{
    level.player playrumbleonentity( "artillery_rumble" );
}

notetrack_highway_final_td_truck_rail_impact( var_0 )
{
    level.player playrumbleonentity( "damage_heavy" );
    wait 0.4;
    level.player playrumbleonentity( "artillery_rumble" );
}

notetrack_highway_final_td_truck_water_impact( var_0 )
{
    wait 0.7;
    level.player playrumbleonentity( "artillery_rumble" );
}
