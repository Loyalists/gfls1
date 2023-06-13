// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

meet_cormack_pt2_start()
{
    level.start_point_scripted = "infil_hangar";
    maps\irons_estate::irons_estate_objectives();
    maps\irons_estate_code::spawn_player_checkpoint();
    maps\irons_estate_code::spawn_allies();
    soundscripts\_snd::snd_message( "start_meet_cormack_pt2" );

    if ( !isdefined( level.meet_cormack_kill_org ) )
        level.meet_cormack_kill_org = common_scripts\utility::getstruct( "meet_cormack_kill_org", "targetname" );

    thread elevator_top_enemies_setup();
    level.player takeallweapons();
    level.player giveweapon( "iw5_pbwsingleshot_sp_silencerpistol" );
    level.player giveweapon( "iw5_kf5fullauto_sp_opticsreddot_silencer01" );
    level.player switchtoweapon( "iw5_kf5fullauto_sp_opticsreddot_silencer01" );
}

meet_cormack_pt2_main()
{
    level.start_point_scripted = "infil_hangar";
    thread meet_cormack_pt2_begin();
    common_scripts\utility::flag_wait( "meet_cormack_pt2_end" );
    level.stealth_fail_fast = undefined;
    thread maps\_utility::autosave_by_name();
}

meet_cormack_pt2_begin()
{
    common_scripts\utility::flag_set( "meet_cormack_pt2_start" );
    level.player.grapple["dist_max"] = 800;
    level.player maps\_utility::set_player_attacker_accuracy( 0.5 );

    if ( !isdefined( level.allies[0] ) )
    {
        level.allies[0] = maps\irons_estate_code::spawn_ally( "cormack" );
        level.allies[0].animname = "cormack";
        level.allies[0] thread maps\irons_estate_code::set_helmet_open();
    }

    if ( !isdefined( level.meet_cormack_kill_org ) )
        level.meet_cormack_kill_org = common_scripts\utility::getstruct( "meet_cormack_kill_org", "targetname" );

    maps\_stealth_utility::disable_stealth_system();
    thread player_rappel();
    thread cormack_rappel();
    thread setup_meet_cormack_pt2_objective();
    thread setup_car_ride_moment();
    thread guard_house_light_exit_light();
    thread meet_cormack_pt2_enemies();
    thread hangar_drones();
    thread convoy_barrier_setup();
}

hangar_drones()
{
    common_scripts\utility::flag_wait_any( "start_car_ride_moment", "gaz_intro_finished" );
    var_0 = vehicle_scripts\_pdrone_security::drone_spawn_and_drive( "hangar_drones" );
    common_scripts\utility::flag_wait( "meet_cormack_pt2_end" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) )
            var_2 delete();
    }
}

guardhouse_grapple_timer()
{
    level endon( "start_convoy" );
    wait 10.0;
    level.allies[0] maps\_utility::smart_dialogue( "ie_nox_almosthere" );
    wait 10.0;
    level.allies[0] maps\_utility::smart_dialogue( "ie_crmk_runningout1" );
    wait 10.0;
    maps\_player_death::set_deadquote( &"IRONS_ESTATE_FAILED_TO_REACH_CONVOY" );
    thread maps\_utility::missionfailedwrapper();
}

setup_meet_cormack_pt2_objective()
{
    common_scripts\utility::flag_wait( "meet_cormack_pt2_end" );
    maps\_utility::objective_complete( maps\_utility::obj( "infiltrate_hangar" ) );
}

meet_cormack_pt2_enemies()
{
    common_scripts\utility::flag_wait_any( "start_car_ride_moment", "gaz_intro_finished" );
    var_0 = maps\_utility::array_spawn_targetname( "ie_east_spawners_02", 1 );
    common_scripts\utility::flag_wait( "player_under_car" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) && isalive( var_2 ) )
            var_2.ignoreall = 1;
    }

    common_scripts\utility::flag_wait( "meet_cormack_pt2_end" );
    var_0 = maps\_utility::remove_dead_from_array( var_0 );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) )
            var_2 delete();
    }
}

meet_cormack_pt2_vo()
{
    level endon( "start_convoy" );
    level.allies[0] maps\_utility::smart_dialogue( "ie_crmk_tickettohangar8" );
    guardhouse_grapple_timer();
}

cormack_rappel()
{
    level endon( "start_convoy" );
    level.allies[0] maps\_stealth_utility::disable_stealth_for_ai();
    level.allies[0].dontevershoot = undefined;
    level.allies[0].baseaccuracy = 0.7;
    level.allies[0].ignoreall = 0;
    level.allies[0].ignoreme = 0;
    level.allies[0].ignoresuppression = 1;
    level.allies[0].disablebulletwhizbyreaction = 1;
    level.allies[0] maps\_utility::disable_pain();
    var_0 = maps\_utility::spawn_anim_model( "generic_prop_raven" );
    level.meet_cormack_kill_org maps\_anim::anim_first_frame_solo( var_0, "pent_escape" );
    var_1 = getent( "upper_elevator_door_left", "targetname" );
    var_1 linkto( var_0, "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_2 = getent( "upper_elevator_door_left_clip", "targetname" );
    var_2 linkto( var_1 );
    var_3 = getent( "upper_elevator_door_right", "targetname" );
    var_3 linkto( var_0, "j_prop_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_4 = getent( "upper_elevator_door_right_clip", "targetname" );
    var_4 linkto( var_3 );
    objective_add( maps\_utility::obj( "infiltrate_hangar" ), "current", &"IRONS_ESTATE_OBJ_INFILTRATE_HANGAR" );
    objective_onentity( maps\_utility::obj( "infiltrate_hangar" ), level.allies[0] );
    level.allies[0] maps\_utility::unset_forcegoal();
    level.allies[0] maps\_utility::set_fixednode_false();
    level.allies[0] maps\_utility::set_goalradius( 16 );
    var_5 = getnode( "cormack_pent_escape_node", "targetname" );
    level.allies[0] setgoalnode( var_5 );
    common_scripts\utility::flag_wait( "penthouse_reinforcements_01_dead" );
    level.allies[0] maps\_utility::disable_cqbwalk();
    thread meet_cormack_pt2_vo();
    level.meet_cormack_kill_org maps\_anim::anim_reach_solo( level.allies[0], "pent_escape" );
    level.meet_cormack_kill_org thread maps\_anim::anim_single( [ level.allies[0], var_0 ], "pent_escape" );
    thread elevator_bottom_enemies_setup();
    wait 1.2;
    soundscripts\_snd_playsound::snd_play_at( "irons_cormack_elev_door", ( 1245, -3955, 1113 ) );
    wait 2.1;
    soundscripts\_snd_playsound::snd_play_at( "irons_cormack_elev_slide", ( 1245, -3955, 1113 ) );
    wait 0.7;
    var_6 = common_scripts\utility::getstruct( "elevator_rappel_org", "targetname" );
    objective_position( maps\_utility::obj( "infiltrate_hangar" ), var_6.origin );
    common_scripts\utility::flag_set( "elevator_rappel_start_ready" );
    var_7 = getent( "upper_elevator_door_player_clip", "targetname" );
    var_7 delete();
    level.allies[0] waittillmatch( "single anim", "end" );
    level.allies[0] unlink();
    var_8 = getnode( "cormack_post_rappel_cover_spot", "targetname" );
    level.allies[0] maps\_utility::set_goal_radius( 16 );
    level.allies[0] setgoalnode( var_8 );
}

player_rappel()
{
    level.elevator_rappel_rig = maps\_utility::spawn_anim_model( "player_rig" );
    level.elevator_rappel_rig hide();
    level.meet_cormack_kill_org maps\_anim::anim_first_frame_solo( level.elevator_rappel_rig, "pent_escape" );
    common_scripts\utility::flag_wait( "elevator_rappel_start" );
    thread player_rappel_rumbles();
    soundscripts\_snd_playsound::snd_play_2d( "irons_player_elev_slide" );
    common_scripts\utility::flag_set( "post_penthouse_trees" );
    level.player freezecontrols( 1 );
    level.player allowpowerslide( 0 );
    level.player allowdodge( 0 );
    level.player setstance( "stand" );

    if ( level.player ispowersliding() || level.player isdodging() )
    {
        while ( level.player ispowersliding() || level.player isdodging() )
            wait 0.05;
    }

    level.player maps\_shg_utility::setup_player_for_scene();
    setsaveddvar( "objectiveHide", 1 );
    level.player thread maps\_shg_utility::disable_features_entering_cinema( 1 );
    level.player thread maps\_tagging::tagging_set_binocs_enabled( 0 );
    level.player maps\_tagging::tagging_set_enabled( 0 );
    level.player thread maps\irons_estate_stealth::irons_estate_whistle( 0 );
    level.player disableweapons();
    level.player disableweaponswitch();
    level.player disableoffhandweapons();
    level.player disableoffhandsecondaryweapons();
    level.player playerlinktoblend( level.elevator_rappel_rig, "tag_player", 0.5 );
    level.player allowprone( 0 );
    level.player allowcrouch( 0 );
    level.player setstance( "stand" );
    level.meet_cormack_kill_org thread maps\_anim::anim_single_solo( level.elevator_rappel_rig, "pent_escape" );
    wait 0.5;
    level.elevator_rappel_rig show();
    level.elevator_rappel_rig waittillmatch( "single anim", "end" );
    setsaveddvar( "objectiveHide", 0 );
    objective_onentity( maps\_utility::obj( "infiltrate_hangar" ), level.allies[0] );
    level.player unlink();
    level.elevator_rappel_rig delete();
    level.player freezecontrols( 0 );
    level.player thread maps\_shg_utility::enable_features_exiting_cinema( 1 );
    level.player thread maps\_tagging::tagging_set_binocs_enabled( 1 );
    level.player maps\_tagging::tagging_set_enabled( 1 );
    level.player thread maps\irons_estate_stealth::irons_estate_whistle( 1 );
    level.player maps\_shg_utility::setup_player_for_gameplay();
    level.player enableweapons();
    level.player enableweaponswitch();
    level.player enableoffhandweapons();
    level.player enableoffhandsecondaryweapons();
    level.player allowprone( 1 );
    level.player allowcrouch( 1 );
    level.player allowpowerslide( 1 );
    level.player allowdodge( 1 );
    thread maps\irons_estate_code::irons_estate_stealth_enable();
}

player_rappel_rumbles()
{
    level.elevator_rappel_rig waittillmatch( "single anim", "cable_slide_start" );
    var_0 = level.player maps\_utility::get_rumble_ent( "ie_vtol_ride_rumble_low" );
    var_0 thread maps\_utility::rumble_ramp_to( 0.5, 2.0 );
    level.elevator_rappel_rig waittillmatch( "single anim", "cable_slide_end" );
    var_0 thread maps\_utility::rumble_ramp_to( 1.0, 0.05 );
    wait 0.25;
    var_0 delete();
}

elevator_top_enemies_setup()
{
    var_0 = getent( "penthouse_reinforcement_door_left", "targetname" );
    var_1 = getent( "penthouse_reinforcement_door_right", "targetname" );
    var_2 = maps\_utility::spawn_anim_model( "generic_prop_raven_x3" );
    level.meet_cormack_kill_org maps\_anim::anim_first_frame_solo( var_2, "elevator_top_enemies" );
    wait 0.05;
    var_0 linkto( var_2, "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_1 linkto( var_2, "j_prop_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "spawn_penthouse_reinforcements_01" );
    soundscripts\_snd::snd_message( "aud_reinforcements_door1" );
    var_3 = maps\_utility::array_spawn_targetname( "penthouse_reinforcements_01", 1 );
    var_3[0].animname = "elevator_top_enemy_1";
    var_3[0].baseaccuracy = 0.5;
    var_3[0] maps\_utility::disable_long_death();
    var_3[1].animname = "elevator_top_enemy_2";
    var_3[1].baseaccuracy = 0.5;
    var_3[1] maps\_utility::disable_long_death();
    level.meet_cormack_kill_org thread maps\_anim::anim_single( [ var_2, var_3[0], var_3[1] ], "elevator_top_enemies" );
    var_3[0] thread elevator_top_enemies_waits( 0.5 );
    var_3[1] thread elevator_top_enemies_waits( 1.25 );
    var_3[0] thread penthouse_reinforcements_01_guy_01_vo();
    var_3[1] thread penthouse_reinforcements_01_guy_02_vo();
}

elevator_top_enemies_waits( var_0 )
{
    self endon( "death" );

    if ( isdefined( var_0 ) )
        wait(var_0);

    maps\_utility::set_allowdeath( 1 );
    self waittillmatch( "single anim", "end" );
}

elevator_bottom_enemies_setup()
{
    var_0 = getent( "penthouse_reinforcement_door_left_lower", "targetname" );
    var_1 = getent( "penthouse_reinforcement_door_right_lower", "targetname" );
    var_2 = maps\_utility::spawn_anim_model( "generic_prop_raven_x3" );
    level.meet_cormack_kill_org maps\_anim::anim_first_frame_solo( var_2, "elevator_bottom_enemies" );
    wait 0.05;
    var_0 linkto( var_2, "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_1 linkto( var_2, "j_prop_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.elevator_rappel_rig waittillmatch( "single anim", "start_enemy_anim" );
    var_3 = maps\_utility::array_spawn_targetname( "penthouse_reinforcements_02", 1 );
    var_3[0].animname = "elevator_bottom_enemy_1";
    var_3[0].baseaccuracy = 0.5;
    var_3[0] maps\_utility::disable_long_death();
    var_3[1].animname = "elevator_bottom_enemy_2";
    var_3[1].baseaccuracy = 0.5;
    var_3[1] maps\_utility::disable_long_death();
    level.meet_cormack_kill_org thread maps\_anim::anim_single( [ var_2, var_3[0], var_3[1] ], "elevator_bottom_enemies" );
    soundscripts\_snd::snd_message( "aud_reinforcements_door2" );
    var_3[0] thread elevator_bottom_enemies_waits( 1.0 );
    var_3[1] thread elevator_bottom_enemies_waits( 1.25 );
    var_3[0] thread penthouse_reinforcements_02_guy_01_vo();
    var_3[1] thread penthouse_reinforcements_02_guy_02_vo();
}

elevator_bottom_enemies_waits( var_0 )
{
    self endon( "death" );

    if ( isdefined( var_0 ) )
        wait(var_0);

    maps\_utility::set_allowdeath( 1 );
    self waittillmatch( "single anim", "end" );
}

penthouse_reinforcements_01_guy_01_vo()
{
    self endon( "death" );
    wait(randomfloatrange( 0.5, 1.5 ));
    maps\_utility::smart_dialogue_generic( "ie_as2_requestbackup1" );
    wait(randomfloatrange( 0.25, 1.0 ));
    maps\_utility::smart_dialogue_generic( "ie_as2_sendreinforce" );
    wait(randomfloatrange( 0.25, 1.0 ));
    maps\_utility::smart_dialogue_generic( "ie_as2_enemyinsight1" );
    wait(randomfloatrange( 0.25, 1.0 ));
    maps\_utility::smart_dialogue_generic( "ie_as2_dropweapon1" );
}

penthouse_reinforcements_01_guy_02_vo()
{
    self endon( "death" );
    wait(randomfloatrange( 0.5, 1.5 ));
    maps\_utility::smart_dialogue_generic( "ie_as2_soundalarm1" );
    wait(randomfloatrange( 0.25, 1.0 ));
    maps\_utility::smart_dialogue_generic( "ie_as2_needbackup1" );
    wait(randomfloatrange( 0.25, 1.0 ));
    maps\_utility::smart_dialogue_generic( "ie_as2_hesarmed" );
}

penthouse_reinforcements_02_guy_01_vo()
{
    self endon( "death" );
    common_scripts\utility::waittill_either( "reached_path_end", "damage" );
    wait(randomfloatrange( 0.5, 1.5 ));
    maps\_utility::smart_dialogue_generic( "ie_as2_requestbackup1" );
    wait(randomfloatrange( 0.25, 1.0 ));
    maps\_utility::smart_dialogue_generic( "ie_as2_sendreinforce" );
    wait(randomfloatrange( 0.25, 1.0 ));
    maps\_utility::smart_dialogue_generic( "ie_as2_enemyinsight1" );
    wait(randomfloatrange( 0.25, 1.0 ));
    maps\_utility::smart_dialogue_generic( "ie_as2_dropweapon1" );
}

penthouse_reinforcements_02_guy_02_vo()
{
    self endon( "death" );
    common_scripts\utility::waittill_either( "reached_path_end", "damage" );
    wait(randomfloatrange( 0.5, 1.5 ));
    maps\_utility::smart_dialogue_generic( "ie_as2_soundalarm1" );
    wait(randomfloatrange( 0.25, 1.0 ));
    maps\_utility::smart_dialogue_generic( "ie_as2_needbackup1" );
    wait(randomfloatrange( 0.25, 1.0 ));
    maps\_utility::smart_dialogue_generic( "ie_as2_hesarmed" );
}

lower_elevator_door()
{
    var_0 = getent( "lower_elevator_door_left", "targetname" );
    var_1 = getent( "lower_elevator_door_right", "targetname" );
    var_0 moveto( var_0.origin + ( 44, 0, 0 ), 1.0 );
    var_1 moveto( var_1.origin - ( 44, 0, 0 ), 1.0 );
    wait 1.05;
    wait 0.05;
}

setup_car_ride_moment()
{
    if ( level.currentgen && !istransientloaded( "irons_estate_upper_tr" ) )
        level waittill( "tff_post_lower_to_upper" );

    level.car_ride_org = common_scripts\utility::getstruct( "car_ride", "targetname" );
    level.car_ride_player_rig = maps\_utility::spawn_anim_model( "player_rig" );
    level.car_ride_player_rig hide();
    level.car_ride_org maps\_anim::anim_first_frame_solo( level.car_ride_player_rig, "car_ride_enter" );
    level.guardhouse_door = maps\_utility::spawn_anim_model( "ie_door" );
    level.car_ride_org maps\_anim::anim_first_frame_solo( level.guardhouse_door, "car_ride_enter" );
    level.guard_house_exit_door_clip = getent( "guard_house_exit_door_clip", "targetname" );
    level.guard_house_exit_door_clip linkto( level.guardhouse_door, "tag_origin", ( 0, 0, 0 ), ( 0, -90, 0 ) );
    var_0 = [];
    level.gaz = maps\_utility::spawn_anim_model( "gaz" );
    level.gaz.player_clip = getent( "gaz_clip", "targetname" );
    level.gaz.player_clip linkto( level.gaz, "tag_body", ( 0, 0, -24 ), ( 0, 0, 0 ) );
    var_0[var_0.size] = level.gaz;
    level.gaz hide();
    level.gaz thread gaz_damage_watcher();

    if ( level.nextgen )
        thread hangar_car_door_light();
    else if ( level.currentgen )
        thread hangar_car_door_light_audio();

    thread gaz_splash_waits();
    thread car_ride_driving_workers_wait();
    level.gaz thread gaz_brake_lights_detail();
    level.gaz2 = maps\_utility::spawn_anim_model( "gaz2" );
    level.gaz2.player_clip = getent( "gaz2_clip", "targetname" );
    level.gaz2.player_clip linkto( level.gaz2, "tag_body", ( 0, 0, -24 ), ( 0, 0, 0 ) );
    var_0[var_0.size] = level.gaz2;
    level.gaz2 hide();
    level.gaz2 thread gaz_damage_watcher();
    level.gaz2 thread gaz_brake_lights();
    level.car_ride_org maps\_anim::anim_first_frame( var_0, "car_ride_intro" );
    common_scripts\utility::flag_wait( "start_convoy" );
    thread theres_the_convoy_vo();
    thread maps\_utility::autosave_by_name();
    level.gaz show();
    level.gaz2 show();
    playfxontag( level._effect["headlight_civhumvee_bright"], level.gaz2, "tag_headlight_left" );
    playfxontag( level._effect["headlight_civhumvee_bright"], level.gaz2, "tag_headlight_right" );
    level.gaz2.spotlight_tag = level.gaz2 common_scripts\utility::spawn_tag_origin();
    level.gaz2.spotlight_tag linkto( level.gaz2, "tag_origin", ( 104, 0, 44 ), ( 0, 0, 0 ) );
    playfxontag( level._effect["headlight_gaz_spotlight"], level.gaz2.spotlight_tag, "tag_origin" );
    playfxontag( level._effect["headlight_civhumvee_bright"], level.gaz, "tag_headlight_left" );
    playfxontag( level._effect["headlight_civhumvee_bright"], level.gaz, "tag_headlight_right" );
    level.gaz.spotlight_tag = level.gaz common_scripts\utility::spawn_tag_origin();
    level.gaz.spotlight_tag linkto( level.gaz, "tag_origin", ( 104, 0, 44 ), ( 0, 0, 0 ) );
    playfxontag( level._effect["headlight_gaz_spotlight"], level.gaz.spotlight_tag, "tag_origin" );
    level.car_ride_org thread maps\_anim::anim_single( var_0, "car_ride_intro" );
    level.gaz thread gaz_intro_waits();
    level.gaz2 thread gaz_intro_waits();
    common_scripts\utility::flag_wait( "penthouse_reinforcements_02_dead" );
    thread maps\_stealth_utility::enable_stealth_system();
    level.allies[0] thread maps\_stealth_utility::enable_stealth_for_ai();
    level.car_ride_org maps\_anim::anim_reach_solo( level.allies[0], "guardhouse_exit_enter" );
    level.car_ride_org maps\_anim::anim_single_solo( level.allies[0], "guardhouse_exit_enter" );
    common_scripts\utility::flag_set( "enable_start_car_ride_moment" );
    thread maps\_utility::autosave_by_name();

    if ( common_scripts\utility::flag( "start_car_ride_moment" ) )
    {
        level.gaz maps\_utility::anim_stopanimscripted();
        level.gaz2 maps\_utility::anim_stopanimscripted();
    }
    else
    {
        level.car_ride_org thread maps\_anim::anim_loop_solo( level.allies[0], "guardhouse_exit_idle", "stop_guardhouse_exit_idle" );
        wait 0.05;
        var_1 = common_scripts\utility::flag_wait_any_return( "start_car_ride_moment", "gaz_intro_finished" );

        if ( var_1 == "start_car_ride_moment" )
        {
            level.gaz maps\_utility::anim_stopanimscripted();
            level.gaz2 maps\_utility::anim_stopanimscripted();
        }
    }

    thread car_ride_intro_fail();
    thread car_ride_boundary_fail();
    level.stealth_fail_fast = 1;
    level endon( "_stealth_spotted" );
    var_2 = [];
    var_2[var_2.size] = level.allies[0];
    level.doctor = maps\_utility::spawn_targetname( "car_ride_kva_doctor", 1 );
    level.doctor maps\_utility::set_ignoresonicaoe( 1 );
    level.doctor.tagged[0] = 1;
    level.doctor.animname = "doctor";

    if ( !isdefined( level.doctor.magic_bullet_shield ) )
        level.doctor maps\_utility::magic_bullet_shield( 1 );

    level.doctor maps\_utility::set_generic_run_anim( "casual_walk" );
    level.doctor maps\_utility::gun_remove();
    level.doctor.grapple_magnets = [];
    var_2[var_2.size] = level.doctor;
    var_2[var_2.size] = level.gaz;
    var_2[var_2.size] = level.gaz2;
    soundscripts\_snd::snd_message( "aud_trucks_arrive" );
    level.car_ride_org notify( "stop_guardhouse_exit_idle" );
    objective_setpointertextoverride( maps\_utility::obj( "infiltrate_hangar" ), "" );
    objective_onentity( maps\_utility::obj( "infiltrate_hangar" ), level.allies[0] );
    wait 0.05;
    level notify( "start_car_ride_moment_anims" );
    var_2[var_2.size] = level.guardhouse_door;
    level.car_ride_org thread maps\_anim::anim_single( var_2, "car_ride_enter" );
    level.guardhouse_door thread guardhouse_door_waits();
    wait 0.05;
    level.allies[0] thread car_ride_enter_cormack_waits();
    level.doctor thread car_ride_enter_doctor_waits();
    level.gaz thread car_ride_gaz_waits();
    level.allies[0] waittillmatch( "single anim", "sd_ie_crmk_now1" );
    level.gaz.player_clip delete();
    thread prone_hint_trigger();
    level notify( "stop_car_ride_intro_fail" );
    var_3 = getent( "car_ride_trigger", "targetname" );
    var_3 enablelinkto();
    var_3 linkto( level.car_ride_player_rig, "tag_player", ( 0, 0, -16 ), ( 0, 0, 0 ) );
    wait 0.05;
    objective_position( maps\_utility::obj( "infiltrate_hangar" ), level.car_ride_player_rig gettagorigin( "tag_player" ) );
    var_3 waittill( "trigger" );
    thread in_position_vo();
    level.allies[0] thread maps\irons_estate_code::hide_friendname_until_flag_or_notify( "meet_cormack_pt2_end" );
    common_scripts\utility::flag_set( "player_under_car" );
    objective_position( maps\_utility::obj( "infiltrate_hangar" ), ( 0, 0, 0 ) );
    level.player maps\_utility::set_ignoreme( 1 );
    level.allies[0] maps\_utility::set_ignoreme( 1 );
    var_3 delete();
    level.player freezecontrols( 1 );
    level.player thread maps\_shg_utility::disable_features_entering_cinema( 1 );
    level.player allowsprint( 0 );
    thread maps\_stealth_display::stealth_display_off();
    level.player thread maps\_tagging::tagging_set_binocs_enabled( 0 );
    level.player maps\_tagging::tagging_set_enabled( 0 );
    level.player thread maps\irons_estate_stealth::irons_estate_whistle( 0 );
    level.player allowprone( 1 );
    level.player allowcrouch( 0 );
    level.player allowstand( 0 );
    level.player maps\_grapple::grapple_take();

    if ( level.player getstance() != "prone" )
        level.player setstance( "prone" );

    level.player disableweapons();
    level.player disableoffhandweapons();
    level.player playerlinktoblend( level.car_ride_player_rig, "tag_player", 0.6 );
    level.car_ride_org thread maps\_anim::anim_single_solo( level.car_ride_player_rig, "car_ride_enter" );
    wait 0.6;
    level.player playerlinktodelta( level.car_ride_player_rig, "tag_player", 1.0, 0, 0, 0, 0, 1 );
    level.car_ride_player_rig show();
    level.car_ride_player_rig waittillmatch( "single anim", "end" );

    if ( !common_scripts\utility::flag( "cormack_under_car" ) )
    {
        level.car_ride_org thread maps\_anim::anim_loop_solo( level.car_ride_player_rig, "car_ride_idle", "stop_car_ride_idle" );
        wait 0.05;
        level.player lerpviewangleclamp( 0.5, 0.5, 0.25, 70, 30, 25, 5 );
        common_scripts\utility::flag_wait( "cormack_under_car" );
    }

    common_scripts\utility::flag_wait( "in_position_vo_done" );
    var_2 = common_scripts\utility::array_remove( var_2, level.guardhouse_door );
    var_2[var_2.size] = level.car_ride_player_rig;
    level.car_ride_org notify( "stop_car_ride_enter_idle_cormack" );
    level.car_ride_org notify( "stop_car_ride_enter_idle_doctor" );
    level.car_ride_org notify( "stop_car_ride_idle" );
    wait 0.05;
    thread hangar_door();
    thread maps\irons_estate_fx::hangar_fx();
    level.car_ride_org thread maps\_anim::anim_single( var_2, "car_ride_driving" );
    thread car_ride_bink();
    thread car_ride_rumble();
    level notify( "stop_gaz_under_heat" );
    level.doctor thread car_ride_doctor_waits();
    thread post_car_ride_player();
    thread car_ride_view_clamps();
    level.allies[0] thread post_car_ride_cormack();
}

theres_the_convoy_vo()
{
    wait 1.0;
    level.allies[0] maps\_utility::smart_dialogue( "ie_crmk_theresconvoy1" );
    level.allies[0] maps\_utility::smart_dialogue( "ie_crmk_hijackintercom" );
    maps\_utility::smart_radio_dialogue( "ie_nox_roger2" );
    level.allies[0] maps\_utility::smart_dialogue( "ie_crmk_followme4" );
}

in_position_vo()
{
    common_scripts\utility::flag_wait( "cormack_under_car" );
    level.allies[0] maps\_utility::smart_dialogue( "ie_crmk_inposition1" );
    level.doctor maps\_utility::play_sound_on_entity( "ie_nox_allclear1" );
    common_scripts\utility::flag_set( "in_position_vo_done" );
}

guardhouse_door_waits()
{
    self waittillmatch( "single anim", "end" );
    wait 0.05;
    level.guard_house_exit_door_clip connectpaths();
}

gaz_intro_waits()
{
    level endon( "start_car_ride_moment" );
    self waittillmatch( "single anim", "end" );
    common_scripts\utility::flag_set( "gaz_intro_finished" );
}

car_ride_enter_cormack_waits()
{
    self waittillmatch( "single anim", "end" );

    if ( common_scripts\utility::flag( "_stealth_spotted" ) )
        return;

    level.car_ride_org thread maps\_anim::anim_loop_solo( self, "car_ride_enter_idle", "stop_car_ride_enter_idle_cormack" );
    wait 0.05;
    common_scripts\utility::flag_set( "cormack_under_car" );
}

car_ride_enter_doctor_waits()
{
    level.car_ride_org endon( "stop_car_ride_enter_idle_doctor" );
    self.old_contents = self setcontents( 0 );
    self waittillmatch( "single anim", "end" );
    level.car_ride_org thread maps\_anim::anim_loop_solo( self, "car_ride_enter_idle", "stop_car_ride_enter_idle_doctor" );
}

car_ride_gaz_waits()
{
    self waittillmatch( "single anim", "heat_waves" );
    thread gaz_under_heat();
}

car_ride_doctor_waits()
{
    self waittillmatch( "single anim", "end" );
    self setcontents( self.old_contents );
    stopfxontag( level._effect["headlight_civhumvee_bright"], level.gaz, "tag_headlight_left" );
    stopfxontag( level._effect["headlight_civhumvee_bright"], level.gaz, "tag_headlight_right" );
    stopfxontag( level._effect["headlight_gaz_spotlight"], level.gaz.spotlight_tag, "tag_origin" );
    wait 0.1;
    stopfxontag( level._effect["headlight_civhumvee_bright"], level.gaz2, "tag_headlight_left" );
    stopfxontag( level._effect["headlight_civhumvee_bright"], level.gaz2, "tag_headlight_right" );
    stopfxontag( level._effect["headlight_gaz_spotlight"], level.gaz2.spotlight_tag, "tag_origin" );
    thread maps\irons_estate_track_irons::handle_doctor();
}

fx_leaves()
{
    wait 2.0;
    common_scripts\_exploder::exploder( 700 );
    wait 2.0;
    common_scripts\_exploder::exploder( 701 );
}

guard_house_light_exit_light()
{
    level waittill( "start_car_ride_moment_anims" );
    var_0 = getent( "guard_house_exit_light_model", "targetname" );
    var_1 = getent( "guard_house_exit_light", "targetname" );

    if ( level.nextgen )
        level.guard_house_exit_light_02 = getent( "guard_house_exit_light_02", "targetname" );

    var_2 = getent( "guard_house_exit_light_03", "targetname" );
    level.allies[0] waittillmatch( "single anim", "light_smash" );
    common_scripts\_exploder::exploder( 14 );
    soundscripts\_snd::snd_message( "aud_conduit_smash" );
    var_0 setmodel( "bay_light_a" );
    var_1 setlightintensity( 0 );

    if ( level.nextgen )
        level.guard_house_exit_light_02 setlightintensity( 0 );

    var_2 setlightintensity( 0 );
    thread fx_leaves();
}

post_car_ride_player()
{
    level.car_ride_player_rig waittillmatch( "single anim", "to_stand" );
    level.player allowcrouch( 1 );
    level.player allowstand( 1 );
    level.player setstance( "stand" );
    level.car_ride_player_rig waittillmatch( "single anim", "end" );
    level.player unlink();
    level.player allowsprint( 1 );
    level.player freezecontrols( 0 );
    level.player thread maps\_shg_utility::enable_features_exiting_cinema( 1 );
    thread maps\_stealth_display::stealth_display_on();
    level.player maps\_grapple::grapple_give();
    level.player thread maps\_tagging::tagging_set_binocs_enabled( 1 );
    level.player maps\_tagging::tagging_set_enabled( 1 );
    level.player thread maps\irons_estate_stealth::irons_estate_whistle( 1 );
    level.player enableweapons();
    level.player enableoffhandweapons();
    level.car_ride_player_rig delete();
    common_scripts\utility::flag_set( "meet_cormack_pt2_end" );
    wait 1.0;
    level.player.ignoreme = 0;
}

post_car_ride_cormack()
{
    level endon( "track_irons_start" );
    self waittillmatch( "single anim", "end" );
    maps\_stealth_utility::enable_stealth_for_ai();
    self setgoalpos( self.origin );
    wait 1.0;
    var_0 = getnode( "cormack_girder_node_01", "targetname" );
    maps\_utility::set_goalradius( 16 );
    self setgoalnode( var_0 );
}

hangar_door()
{
    wait 9.0;
    var_0 = getent( "hangar_door_left", "targetname" );
    var_1 = getent( "hangar_door_right", "targetname" );
    var_0 movey( 96, 3.0 );
    var_1 movey( -96, 3.0 );
    wait 9.0;
    var_0 movey( -96, 3.0 );
    var_1 movey( 96, 3.0 );
}

car_ride_view_clamps()
{
    level.player lerpviewangleclamp( 0.5, 0.5, 0.25, 80, 50, 25, 5 );
    level.car_ride_player_rig waittillmatch( "single anim", "clamp_change" );
    level.player lerpviewangleclamp( 0.5, 0.5, 0.25, 80, 50, 25, 5 );
    level.car_ride_player_rig waittillmatch( "single anim", "clamp_change" );
    level.player lerpviewangleclamp( 1.0, 0.5, 0.25, 10, 10, 10, 5 );
    level.car_ride_player_rig waittillmatch( "single anim", "clamp_change" );
    level.player lerpviewangleclamp( 1.0, 0.5, 0.25, 80, 80, 10, 5 );
    level.car_ride_player_rig waittillmatch( "single anim", "clamp_change" );
    level.player lerpviewangleclamp( 1.0, 0.5, 0.25, 0, 0, 0, 0 );
}

car_ride_intro_fail()
{
    level endon( "stop_car_ride_intro_fail" );
    common_scripts\utility::flag_wait( "car_ride_intro_fail" );
    maps\irons_estate_code::player_alerted_mission_fail_convoy();
}

car_ride_boundary_fail()
{
    level endon( "player_under_car" );
    common_scripts\utility::flag_wait( "car_ride_boundary_fail" );
    maps\irons_estate_code::player_alerted_mission_fail();
}

hangar_car_door_light()
{
    var_0 = getent( "hangar_car_door_light", "targetname" );
    var_0 setlightintensity( 0 );
    level.gaz waittillmatch( "single anim", "light_on" );
    var_0 setlightintensity( 25000 );
    soundscripts\_snd::snd_message( "aud_hangar_car_door_exit" );
    level.gaz waittillmatch( "single anim", "light_off" );
    var_0 setlightintensity( 0 );
}

hangar_car_door_light_audio()
{
    level.gaz waittillmatch( "single anim", "light_on" );
    soundscripts\_snd::snd_message( "aud_hangar_car_door_exit" );
}

gaz_splash_waits()
{
    level.gaz waittillmatch( "single anim", "splash_sound" );
    soundscripts\_snd::snd_message( "aud_tire_splash" );
    level.gaz waittillmatch( "single anim", "splash_sound" );
    soundscripts\_snd::snd_message( "aud_tire_splash" );
    level.gaz waittillmatch( "single anim", "splash_sound" );
    soundscripts\_snd::snd_message( "aud_tire_splash" );
}

car_ride_driving_workers_wait()
{
    if ( !isdefined( level.car_ride_org ) )
        level.car_ride_org = common_scripts\utility::getstruct( "car_ride", "targetname" );

    var_0 = maps\_utility::array_spawn_targetname( "car_ride_driving_workers", 1 );
    var_0[0].animname = "car_ride_driving_worker_1";
    var_0[1].animname = "car_ride_driving_worker_2";

    foreach ( var_2 in var_0 )
    {
        var_2 maps\_utility::gun_remove();
        var_2.grapple_magnets = [];
        var_2 maps\_utility::set_allowdeath( 1 );
    }

    level.car_ride_org maps\_anim::anim_first_frame( var_0, "car_ride_driving_workers" );
    level.gaz waittillmatch( "single anim", "worker_anim_start" );
    level.car_ride_org thread maps\_anim::anim_single( var_0, "car_ride_driving_workers" );
    var_0[0] thread car_ride_driving_workers_waits();
    var_0[1] thread car_ride_driving_workers_waits();
}

car_ride_driving_workers_waits()
{
    self endon( "death" );
    self waittillmatch( "single anim", "end" );
    self delete();
}

gaz_damage_watcher()
{
    level endon( "player_under_car" );
    self setcandamage( 1 );

    for (;;)
    {
        self waittill( "damage", var_0, var_1 );

        if ( isdefined( var_1 ) && var_1 == level.player )
            maps\irons_estate_code::player_alerted_mission_fail();

        wait 0.05;
    }
}

gaz_brake_lights_detail()
{
    playfxontag( level._effect["ie_humvee_tail_l_v2"], self, "tag_brakelight_left" );
    playfxontag( level._effect["ie_humvee_tail_r_v2"], self, "tag_brakelight_right" );
    self waittillmatch( "single anim", "brakelights_on" );
    playfxontag( level._effect["ie_humvee_tail_l_v2"], self, "tag_brakelight_left" );
    playfxontag( level._effect["ie_humvee_tail_l_v2"], self, "tag_brakelight_right" );
    self waittillmatch( "single anim", "brakelights_off" );
    stopfxontag( level._effect["ie_humvee_tail_l_v2"], self, "tag_brakelight_left" );
    stopfxontag( level._effect["ie_humvee_tail_l_v2"], self, "tag_brakelight_right" );
    self waittillmatch( "single anim", "brakelights_on" );
    playfxontag( level._effect["ie_humvee_tail_l_v2"], self, "tag_brakelight_left" );
    playfxontag( level._effect["ie_humvee_tail_l_v2"], self, "tag_brakelight_right" );
    self waittillmatch( "single anim", "brakelights_off" );
    stopfxontag( level._effect["ie_humvee_tail_l_v2"], self, "tag_brakelight_left" );
    stopfxontag( level._effect["ie_humvee_tail_l_v2"], self, "tag_brakelight_right" );
    self waittillmatch( "single anim", "end" );
    stopfxontag( level._effect["ie_humvee_tail_l_v2"], self, "tag_brakelight_left" );
    stopfxontag( level._effect["ie_humvee_tail_r_v2"], self, "tag_brakelight_right" );
}

gaz_brake_lights()
{
    playfxontag( level._effect["ie_humvee_tail_l"], self, "tag_brakelight_left" );
    playfxontag( level._effect["ie_humvee_tail_r"], self, "tag_brakelight_right" );
    self waittillmatch( "single anim", "brakelights_on" );
    playfxontag( level._effect["ie_humvee_brake_l"], self, "tag_brakelight_left" );
    playfxontag( level._effect["ie_humvee_brake_r"], self, "tag_brakelight_right" );
    self waittillmatch( "single anim", "brakelights_off" );
    stopfxontag( level._effect["ie_humvee_brake_l"], self, "tag_brakelight_left" );
    stopfxontag( level._effect["ie_humvee_brake_r"], self, "tag_brakelight_right" );
    self waittillmatch( "single anim", "brakelights_on" );
    playfxontag( level._effect["ie_humvee_brake_l"], self, "tag_brakelight_left" );
    playfxontag( level._effect["ie_humvee_brake_r"], self, "tag_brakelight_right" );
    self waittillmatch( "single anim", "brakelights_off" );
    stopfxontag( level._effect["ie_humvee_brake_l"], self, "tag_brakelight_left" );
    stopfxontag( level._effect["ie_humvee_brake_r"], self, "tag_brakelight_right" );
    self waittillmatch( "single anim", "end" );
    stopfxontag( level._effect["ie_humvee_tail_l"], self, "tag_brakelight_left" );
    stopfxontag( level._effect["ie_humvee_tail_r"], self, "tag_brakelight_right" );
}

gaz_under_heat()
{
    playfxontag( level._effect["civ_humvee_under_heat"], self, "tag_origin" );
    level waittill( "stop_gaz_under_heat" );
    stopfxontag( level._effect["civ_humvee_under_heat"], self, "tag_origin" );
}

car_ride_rumble()
{
    wait 1.0;
    var_0 = level.player maps\_utility::get_rumble_ent( "steady_rumble" );
    var_0 maps\_utility::set_rumble_intensity( 0.1 );
    var_0 maps\_utility::rumble_ramp_to( 0.1, 1.0 );
    level.gaz waittillmatch( "single anim", "end" );
    var_0 maps\_utility::rumble_ramp_off( 1.0 );
    wait 0.6;
    var_0 delete();
}

car_ride_bink()
{
    setsaveddvar( "cg_cinematicCanPause", "1" );
    setsaveddvar( "cg_cinematicFullScreen", "0" );
    // cinematicingame( "base_videolog", 1 );
    wait 8.12;
    // var_0 = newhudelem();
    // var_0.x = 0;
    // var_0.y = 5;
    // var_0.alignx = "left";
    // var_0.aligny = "top";
    // var_0.horzalign = "left";
    // var_0.vertalign = "top";
    // var_0.sort = -1;
    // var_0 setshader( "cinematic_add", int( 340.0 ), int( 231.2 ) );
    // var_0.alpha = 1.0;
    pausecinematicingame( 0 );
    soundscripts\_snd::snd_message( "aud_vehicle_ride_data" );

    while ( iscinematicplaying() )
        wait 0.05;

    setsaveddvar( "cg_cinematicCanPause", "0" );
    // var_0 destroy();
    setsaveddvar( "cg_cinematicFullScreen", "1" );
}

prone_hint_trigger()
{
    var_0 = getent( "prone_hint_trigger", "targetname" );
    var_0 waittill( "trigger" );

    if ( level.player common_scripts\utility::is_player_gamepad_enabled() )
        level.player thread maps\_utility::display_hint( "HINT_PRONE" );
    else if ( maps\_utility::is_command_bound( "toggleprone" ) )
        level.player thread maps\_utility::display_hint( "HINT_PRONE_TOGGLE" );
    else if ( maps\_utility::is_command_bound( "+prone" ) )
        level.player thread maps\_utility::display_hint( "HINT_PRONE_HOLD" );
    else if ( maps\_utility::is_command_bound( "+stance" ) )
        level.player thread maps\_utility::display_hint( "HINT_PRONE" );
}

convoy_barrier_setup()
{
    var_0 = getentarray( "convoy_barrier", "targetname" );

    if ( isdefined( var_0 ) && var_0.size > 0 )
        common_scripts\utility::array_thread( var_0, ::convoy_barrier );
}

convoy_barrier()
{
    var_0 = 1.5;
    var_1 = getent( self.target, "targetname" );
    var_1 linkto( self );

    if ( level.currentgen )
        common_scripts\utility::flag_wait( "start_convoy" );

    level.gaz waittillmatch( "single anim", "barrier_down" );
    self movez( -34, var_0 );
    level.gaz waittillmatch( "single anim", "barrier_up" );
    self movez( 34, var_0 );
}
