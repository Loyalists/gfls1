// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\_utility::template_level( "sanfran_b" );
    maps\_utility::set_console_status();
    precachestring( &"sanfran_b_videolog" );
    precachestring( &"SANFRAN_B_OBJ_PLANT_JAMMERS" );
    precachestring( &"SANFRAN_B_OBJ_JAMMER" );
    precachestring( &"SANFRAN_B_OBJ_SECURE_DECK" );
    precachestring( &"SANFRAN_B_OBJ_DECK_TARGETS" );
    precachestring( &"SANFRAN_B_OBJ_BRIDGE" );
    precachestring( &"SANFRAN_B_OBJ_CONSOLE" );
    precachestring( &"SANFRAN_B_OBJ_LASER" );
    precachestring( &"SANFRAN_B_DEACTIVATE_JAMMER" );
    precachestring( &"SANFRAN_B_OBJ_DESTROY" );
    precachestring( &"SANFRAN_B_SONAR_HINT" );
    precachestring( &"SANFRAN_B_CONSOLE_HINT" );
    precachestring( &"SANFRAN_B_LASER_HINT" );
    precachestring( &"SANFRAN_B_ALIGN_HINT" );
    precachestring( &"railgun_hud_update" );
    precacheshellshock( "iw5_m160_sp_deam160_variablereddot" );
    precacheshellshock( "iw5_m160cqb_sp_cqbreddot" );
    precacheshellshock( "iw5_hbra3_sp" );
    precacheshellshock( "mob_missile" );
    precacheshellshock( "rpg_player" );
    precacheshellshock( "mob_turret_missile" );
    precacheshellshock( "cargo_ship_missile" );
    precacheshellshock( "cargo_ship_missile_railgun" );
    precacheshellshock( "iw5_maul_sp" );
    precacheturret( "warbird_turret" );
    precacheturret( "cargoship_turret" );
    precachemodel( "worldhands_player_sentinel" );
    precachemodel( "viewbody_sentinel" );
    precachemodel( "civ_domestic_mini_dstrypv" );
    precachemodel( "vehicle_civ_pickup_truck_01_wrecked" );
    precachemodel( "vm_jamming_device" );
    precachemodel( "vm_jamming_device_obj" );
    precachemodel( "vehicle_mobile_cover" );
    precachemodel( "vehicle_mobile_cover_dstrypv" );
    precachemodel( "mob_mess_hall_table_broken" );
    precachemodel( "mob_door_interior_rigged" );
    precachemodel( "mob_bridge_console_04b" );
    precachemodel( "mob_bridge_console_04b_obj" );
    precachemodel( "mob_bridge_console_04a_obj" );
    precachemodel( "vehicle_airplane_shrike_static_prkd" );
    precachemodel( "mob_door_interior_mirrored" );
    precachemodel( "vehicle_atlas_cargo_container_dmg_k" );
    precachemodel( "vehicle_mob_deck_large_calibur_turret_vm" );
    precacheshader( "reticle_center_cross" );
    precacheshader( "overlay_static_digital" );
    precacherumble( "heavy_1s" );
    precacherumble( "heavy_2s" );
    precacherumble( "heavy_3s" );
    precacherumble( "light_1s" );
    precacherumble( "artillery_rumble" );
    precacherumble( "damage_heavy" );
    precacherumble( "damage_light" );
    precacherumble( "steady_rumble" );
    level.cosine = [];
    level.cosine["45"] = cos( 45 );
    precachesonarvisioncodeassets();

    if ( level.currentgen )
    {
        setsaveddvar( "r_gunSightColorEntityScale", "0.95" );
        setsaveddvar( "r_gunSightColorNoneScale", "0.95" );
        maps\_utility::tff_sync_setup();
    }

    setsaveddvar( "high_jump_double_tap", "1" );
    common_scripts\utility::flag_init( "flag_obj_marker_enter_ship" );
    common_scripts\utility::flag_init( "show_enter_ship_obj_marker" );
    common_scripts\utility::flag_init( "deck_reinforcement_1" );
    common_scripts\utility::flag_init( "deck_reinforcement_2" );
    common_scripts\utility::flag_init( "deck_reinforcement_3" );
    common_scripts\utility::flag_init( "obj_track_enemies" );
    common_scripts\utility::flag_init( "obj_secure_deck_complete" );
    common_scripts\utility::flag_init( "flag_bridge" );
    common_scripts\utility::flag_init( "flag_obj_leave_cafeteria" );
    common_scripts\utility::flag_init( "flag_obj_enter_hanger" );
    common_scripts\utility::flag_init( "flag_obj_leave_hanger" );
    common_scripts\utility::flag_init( "obj_bridge_start" );
    common_scripts\utility::flag_init( "obj_bridge" );
    common_scripts\utility::flag_init( "obj_bridge_complete" );
    common_scripts\utility::flag_init( "obj_console" );
    common_scripts\utility::flag_init( "obj_laser" );
    common_scripts\utility::flag_init( "intro_radio_vo" );
    common_scripts\utility::flag_init( "intro_dialogue" );
    common_scripts\utility::flag_init( "intro_anim_finished" );
    common_scripts\utility::flag_init( "obj_track_jammers" );
    common_scripts\utility::flag_init( "boost_incoming_vo" );
    common_scripts\utility::flag_init( "planting_jammer_1" );
    common_scripts\utility::flag_init( "planting_jammer_2" );
    common_scripts\utility::flag_init( "jammer_1_deactivated" );
    common_scripts\utility::flag_init( "deck_warbird_vo" );
    common_scripts\utility::flag_init( "jammer_2_vo" );
    common_scripts\utility::flag_init( "jammer_2_deactivated" );
    common_scripts\utility::flag_init( "jammer_3_deactivated" );
    common_scripts\utility::flag_init( "all_jammers_deactivated" );
    common_scripts\utility::flag_init( "flag_move_gideon_into_interior" );
    common_scripts\utility::flag_init( "enemy_warbird_1" );
    common_scripts\utility::flag_init( "deck_warbird_3_unloaded" );
    common_scripts\utility::flag_init( "deck_warbird_4_unloaded" );
    common_scripts\utility::flag_init( "all_deck_warbirds_deployed" );
    common_scripts\utility::flag_init( "flag_cleanup_deck_drones" );
    common_scripts\utility::flag_init( "rail_guns_secure_vo" );
    common_scripts\utility::flag_init( "boosters_off_vo" );
    common_scripts\utility::flag_init( "boosters_off_anim_started" );
    common_scripts\utility::flag_init( "boosters_off_anim_finished" );
    common_scripts\utility::flag_init( "exo_takedown_started" );
    common_scripts\utility::flag_init( "flag_allow_night_vision_hint" );
    common_scripts\utility::flag_init( "player_exit_cafeteria" );
    common_scripts\utility::flag_init( "hangar_fastzip_1" );
    common_scripts\utility::flag_init( "hangar_fastzip_2" );
    common_scripts\utility::flag_init( "hangar_reinforcements" );
    common_scripts\utility::flag_init( "ast_vo" );
    common_scripts\utility::flag_init( "through_door_vo" );
    common_scripts\utility::flag_init( "pulloff_anim_started" );
    common_scripts\utility::flag_init( "cormack_on_console" );
    common_scripts\utility::flag_init( "target_vo" );
    common_scripts\utility::flag_init( "player_using_mob_turret" );
    common_scripts\utility::flag_init( "player_on_turret_1" );
    common_scripts\utility::flag_init( "player_switching_to_turret_2" );
    common_scripts\utility::flag_init( "player_on_turret_2" );
    common_scripts\utility::flag_init( "first_cargo_ship_damaged" );
    common_scripts\utility::flag_init( "second_cargo_ship_damaged" );
    common_scripts\utility::flag_init( "first_cargo_ship_destroyed" );
    common_scripts\utility::flag_init( "second_cargo_ship_destroyed" );
    common_scripts\utility::flag_init( "cargo_ship_destroyed" );
    common_scripts\utility::flag_init( "switching_cargo_ships" );
    common_scripts\utility::flag_init( "laser_targets_destroyed" );
    common_scripts\utility::flag_init( "outro_dialogue_finished" );
    common_scripts\utility::flag_init( "RemoveCormack" );
    common_scripts\utility::flag_init( "sonar_threat_detection_off" );
    common_scripts\utility::flag_init( "useyourboosters_vo" );
    common_scripts\utility::flag_init( "flag_end_sonar_vision" );
    forcesharedammo();
    maps\_utility::add_start( "deck", ::start_deck, "", ::armada_intro_screen );
    maps\_utility::add_start( "interior", ::start_interior, "", ::interior );
    maps\_utility::add_start( "hangar", ::start_hangar, "", ::hangar );
    maps\_utility::add_start( "information_center", ::start_information_center, "", ::information_center );
    maps\_utility::add_start( "rail_gun", ::start_bridge, "", ::bridge );
    maps\_utility::add_start( "demo_with_itiot", ::start_demo_with_itiot, "", undefined );
    // level.start_point = "deck";

    if ( level.currentgen )
    {
        var_0 = [ "sanfran_b_intro_tr" ];
        maps\_utility::set_start_transients( "deck", var_0 );
        maps\_utility::set_start_transients( "interior", var_0 );
        var_0[0] = "sanfran_b_outro_tr";
        maps\_utility::set_start_transients( "hangar", var_0 );
        maps\_utility::set_start_transients( "information_center", var_0 );
        var_0[1] = "sanfran_b_intro_tr";
        maps\_utility::set_start_transients( "rail_gun", var_0 );
        var_0 = [ "sanfran_b_intro_tr" ];
        maps\_utility::set_start_transients( "demo_with_itiot", var_0 );
    }

    maps\createart\sanfran_b_art::main();
    maps\sanfran_b_fx::main();
    maps\sanfran_b_precache::main();
    maps\_load::main();
    thread maps\_player_exo::main( "assault", 1 );
    maps\sanfran_b_anim::main();
    level.player setviewmodel( "s1_gfl_ump45_viewhands" );
    thread maps\sanfran_b_lighting::main();
    maps\sanfran_b_aud::main();
    maps\_player_high_jump::main();
    maps\sanfran_b_laser::main();
    maps\sanfran_b_sonar_vision::main();
    maps\sanfran_b_vo::main();
    maps\sanfran_b_util::init_bobbing_boats();
    maps\_microdronelauncher::init();
    maps\_drone_ai::init();
    maps\_drone_civilian::init();
    maps\_microwave_grenade::main();
    animscripts\traverse\boost::precache_boost_fx_npc();
    maps\_utility::add_hint_string( "hint_use_sonar", &"SANFRAN_B_SONAR_HINT", maps\sanfran_b_code::should_end_sonar_hint );
    maps\_utility::add_hint_string( "hint_use_laser", &"SANFRAN_B_LASER_HINT", maps\sanfran_b_code::should_end_laser_hint );
    maps\_utility::add_hint_string( "hint_align_laser", &"SANFRAN_B_ALIGN_HINT", maps\sanfran_b_code::should_end_align_hint );
    setup();
    setup_portal_scripting();
    common_scripts\utility::run_thread_on_targetname( "fail_jumped_off_boat", maps\sanfran_b_util::fall_fail );
    setsaveddvar( "bg_fallDamageMinHeight", 490 );
    setsaveddvar( "bg_fallDamageMaxHeight", 640 );
    var_1 = getdvarint( "demo_itiot", 0 );

    if ( var_1 )
    {
        soundscripts\_snd::snd_message( "e3_demo_fade_in" );
        level.player.auxillary_hud = newclienthudelem( level.player );
        level.player.auxillary_hud setshader( "black", 1280, 720 );
        level.player.auxillary_hud.horzalign = "fullscreen";
        level.player.auxillary_hud.vertalign = "fullscreen";
        level.player.auxillary_hud.alpha = 1;
        level.player.auxillary_hud fadeovertime( 0.5 );
        level.player.auxillary_hud.alpha = 0;
        level.player.auxillary_hud.foreground = 1;
        setsaveddvar( "objectiveHide", "0" );
    }
}

armada_intro_screen()
{
    if ( !isdefined( level.start_point ) || level.start_point == "deck" )
    {
        level.player disableweapons();
        level.player freezecontrols( 1 );
        thread maps\_shg_utility::play_chyron_video( "chyron_text_sanfran_b", 1, 1 );
        common_scripts\utility::flag_wait( "chyron_video_done" );
        thread deck();
    }
    else
        thread maps\_introscreen::introscreen_generic_black_fade_in( 2, 2 );
}

start_deck()
{
    soundscripts\_snd::snd_message( "start_deck" );

    if ( level.nextgen )
    {
        level.player lightsetforplayer( "sanfran_b_intro" );
        level.player setclutforplayer( "clut_sanfran_b_fire", 0 );
        thread maps\_utility::vision_set_changes( "sfb_neutral", 0 );
        thread maps\_utility::fog_set_changes( "sanfran_b_exterior_dark_fog", 0 );
    }
    else
    {
        level.player lightsetforplayer( "sanfran_b_intro" );
        maps\_utility::vision_set_fog_changes( "sanfran_b_exterior_dark_fog", 0 );
    }
}

deck()
{
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );
    common_scripts\utility::flag_set( "player_can_boost_jump" );
    maps\sanfran_b_code::spawn_allies();
    thread maps\sanfran_b_code::tilt_boat( 0 );
    thread maps\sanfran_b_util::hide_navy_boats();
    thread maps\sanfran_b_code::intro_scene();
    thread maps\sanfran_b_code::initial_combat();
    thread maps\sanfran_b_code::move_initial_enemies();

    if ( level.nextgen )
        thread maps\sanfran_b_code::shrike_takeoff();
    else
        thread maps\sanfran_b_code::shrike_takeoff_cg();

    if ( level.nextgen )
        thread maps\sanfran_b_code::ambient_deck();

    thread maps\sanfran_b_code::cargo_ship_missiles();
    thread maps\sanfran_b_code::shrike_flyby();
    thread maps\sanfran_b_obj::obj_secure_deck();
    thread maps\sanfran_b_obj::obj_bridge_start();
    thread maps\sanfran_b_code::manage_deck_combat();
    thread maps\sanfran_b_code::mob_enter_player_clip();
    thread maps\sanfran_b_code::close_interior_door();
    thread maps\sanfran_b_code::boosters_off_anim( 0 );
    thread maps\sanfran_b_util::setup_corpses( 1 );
    thread maps\sanfran_b_fx::vfx_heli_drop_off_intro_on();
    common_scripts\utility::flag_set( "intro_radio_vo" );

    if ( level.nextgen )
        setsaveddvar( "r_fog_ev_adjust", 0.5 );

    level.player lightsetforplayer( "sanfran_b_intro" );

    if ( level.currentgen )
        maps\_utility::vision_set_fog_changes( "sanfran_b_exterior_dark_fog", 0 );

    if ( level.nextgen )
    {
        level.player setclutforplayer( "clut_sanfran_b_fire", 0 );
        thread maps\_utility::vision_set_changes( "sfb_neutral", 0 );
        thread maps\_utility::fog_set_changes( "sanfran_b_exterior_dark_fog", 0 );
    }
}

sanfran_b_dim()
{
    level.player lightsetforplayer( "sanfran_b_interior" );
}

start_interior()
{
    soundscripts\_snd::snd_message( "start_interior" );
    maps\sanfran_b_code::spawn_allies();

    if ( level.currentgen )
        maps\_utility::vision_set_fog_changes( "sanfran_b_interior", 0 );
    else
    {
        thread maps\_utility::vision_set_changes( "sfb_neutral", 0 );
        thread maps\_utility::fog_set_changes( "sanfran_b_interior", 0 );
        level.player setclutforplayer( "", 0 );
    }

    if ( level.nextgen )
        thread maps\sanfran_b_lighting::interior_dof_blend();

    level.player lightsetforplayer( "sanfran_b_dim" );
    maps\_utility::delaythread( 8, ::sanfran_b_dim );
    common_scripts\utility::flag_set( "intro_anim_finished" );
    common_scripts\utility::flag_set( "flag_move_gideon_into_interior" );
    common_scripts\utility::flag_set( "flag_player_entered_interior" );
    common_scripts\utility::flag_set( "player_can_boost_jump" );
    thread maps\sanfran_b_code::tilt_boat( 1 );
    maps\sanfran_b_util::teleport_to_scriptstruct( "org_start_interior" );
    objective_add( maps\_utility::obj( "obj_plant_jammers" ), "current", &"SANFRAN_B_OBJ_PLANT_JAMMERS" );
    maps\_utility::objective_complete( maps\_utility::obj( "obj_plant_jammers" ) );
    objective_add( maps\_utility::obj( "obj_bridge" ), "current", &"SANFRAN_B_OBJ_BRIDGE" );
    common_scripts\utility::flag_set( "obj_bridge" );
    common_scripts\utility::flag_set( "flag_obj_marker_enter_ship" );
    thread maps\sanfran_b_obj::obj_secure_deck();
    thread maps\sanfran_b_code::close_interior_door();
    thread maps\sanfran_b_code::mob_enter_player_clip();
    thread maps\sanfran_b_code::boosters_off_anim( 1 );
    thread maps\sanfran_b_code::slow_player_inside();
}

interior()
{
    common_scripts\utility::flag_wait( "flag_player_entered_interior" );
    common_scripts\utility::flag_set( "boosters_off_vo" );

    if ( level.nextgen )
        thread maps\sanfran_b_lighting::play_flickering_interior_light();

    setsaveddvar( "sm_sunSampleSizeNear", 0.1 );

    if ( getdvar( "player_cqb" ) == "1" )
        thread maps\sanfran_b_code::cqb_test();

    thread maps\sanfran_b_util::setup_corpses();
    thread maps\sanfran_b_code::open_door_anim();
    thread maps\sanfran_b_code::exo_takedown();
    thread maps\sanfran_b_code::interior_shake_1();
    thread maps\sanfran_b_code::handle_sonar_hint();
    thread maps\sanfran_b_code::table_pulldown();
    thread maps\sanfran_b_code::cafeteria_reinforcements();
    thread maps\sanfran_b_obj::obj_bridge();
    thread maps\sanfran_b_code::move_to_hangar();
    thread maps\sanfran_b_code::hand_signal_to_hangar();
    thread maps\sanfran_b_code::end_squad_cqb();
    maps\sanfran_b_code::give_night_vision();
    setsaveddvar( "r_fog_ev_adjust", 1.5 );
}

start_hangar()
{
    soundscripts\_snd::snd_message( "start_hangar" );
    maps\sanfran_b_code::spawn_allies();

    if ( level.currentgen )
        maps\_utility::vision_set_fog_changes( "sanfran_b_interior_dark", 0 );
    else
    {
        level.player setclutforplayer( "", 0 );
        thread maps\_utility::vision_set_changes( "sfb_neutral", 0 );
        thread maps\_utility::fog_set_changes( "sanfran_b_interior_dark", 0 );
    }

    level.player lightsetforplayer( "sanfran_b_darker" );
    common_scripts\utility::flag_set( "flag_player_entered_interior" );
    common_scripts\utility::flag_set( "intro_anim_finished" );
    thread maps\sanfran_b_code::tilt_boat( 1 );
    level.burke maps\_utility::enable_cqbwalk();
    level.cormack maps\_utility::enable_cqbwalk();
    level.maddox maps\_utility::enable_cqbwalk();
    maps\sanfran_b_util::teleport_to_scriptstruct( "org_start_hangar" );
    maps\_utility::activate_trigger( "trig_interior_vo_2", "targetname" );
    maps\sanfran_b_code::give_night_vision();
    common_scripts\utility::flag_set( "player_exit_cafeteria" );
    objective_add( maps\_utility::obj( "obj_plant_jammers" ), "current", &"SANFRAN_B_OBJ_PLANT_JAMMERS" );
    maps\_utility::objective_complete( maps\_utility::obj( "obj_plant_jammers" ) );
    objective_add( maps\_utility::obj( "obj_bridge" ), "current", &"SANFRAN_B_OBJ_BRIDGE" );
    common_scripts\utility::flag_set( "obj_bridge" );
    common_scripts\utility::flag_set( "flag_obj_marker_enter_ship" );
    thread maps\sanfran_b_util::setup_corpses();
    thread maps\sanfran_b_obj::obj_secure_deck();
    thread maps\sanfran_b_obj::obj_bridge();
    common_scripts\utility::flag_set( "sonar_threat_detection_off" );
    soundscripts\_snd::snd_message( "enter_ship" );
    thread maps\sanfran_b_code::close_interior_door();
    thread maps\sanfran_b_code::move_to_hangar();
    thread maps\sanfran_b_code::hand_signal_to_hangar();
    wait 0.5;
    maps\_utility::activate_trigger_with_targetname( "trigger_move_allies_into_cafeteria" );
    wait 0.5;
    maps\_utility::activate_trigger( "trig_interior_vo_2", "targetname" );
    level.player maps\_player_high_jump::disable_high_jump();
}

hangar()
{
    common_scripts\utility::flag_wait( "player_exit_cafeteria" );
    thread maps\sanfran_b_lighting::play_flickering_hanger_light();
    thread maps\sanfran_b_lighting::stop_flickering_interior_light();
    thread maps\sanfran_b_util::show_navy_boats();
    common_scripts\utility::flag_set( "sonar_threat_detection_off" );
    thread maps\sanfran_b_code::boat_rocking_hangar();
    thread maps\sanfran_b_code::boat_rocking_jet_moment();
    thread maps\sanfran_b_code::ambient_hangar();
    thread maps\sanfran_b_code::initial_hangar_setup();
    thread maps\sanfran_b_code::hangar_combat();
    thread maps\sanfran_b_code::hangar_combat_reinforcements();
    thread maps\sanfran_b_code::hangar_exit_door();
    thread maps\sanfran_b_code::hand_signal_after_hangar();
    thread maps\sanfran_b_code::sf_b_videolog();
    thread maps\sanfran_b_code::ambient_combat();
    thread maps\sanfran_b_code::door_takedown_door();
    thread maps\sanfran_b_lighting::flip_spot_light();
    setsaveddvar( "r_fog_ev_adjust", 1.5 );
}

start_information_center()
{
    soundscripts\_snd::snd_message( "start_information_center" );
    maps\sanfran_b_code::spawn_allies();

    if ( level.currentgen )
        maps\_utility::vision_set_fog_changes( "sanfran_b_hanger_top", 0 );
    else
    {
        level.player setclutforplayer( "", 0 );
        thread maps\_utility::vision_set_changes( "sfb_neutral", 0 );
        thread maps\_utility::fog_set_changes( "sanfran_b_hanger_top", 0 );
    }

    common_scripts\utility::flag_set( "flag_player_entered_interior" );
    common_scripts\utility::flag_set( "intro_anim_finished" );
    maps\sanfran_b_util::teleport_to_scriptstruct( "org_start_information_center" );
    thread maps\sanfran_b_code::tilt_boat( 1 );
    maps\sanfran_b_code::give_night_vision();
    objective_add( maps\_utility::obj( "obj_plant_jammers" ), "current", &"SANFRAN_B_OBJ_PLANT_JAMMERS" );
    maps\_utility::objective_complete( maps\_utility::obj( "obj_plant_jammers" ) );
    objective_add( maps\_utility::obj( "obj_bridge" ), "current", &"SANFRAN_B_OBJ_BRIDGE" );
    common_scripts\utility::flag_set( "obj_bridge" );
    common_scripts\utility::flag_set( "flag_obj_marker_enter_ship" );
    common_scripts\utility::flag_set( "flag_obj_leave_cafeteria" );
    common_scripts\utility::flag_set( "obj_marker_follow_cormack_to_hanger" );
    common_scripts\utility::flag_set( "flag_obj_enter_hanger" );
    common_scripts\utility::flag_set( "flag_obj_leave_hanger" );
    thread maps\sanfran_b_util::setup_corpses();
    thread maps\sanfran_b_code::door_takedown_door();
    thread maps\sanfran_b_obj::obj_secure_deck();
    thread maps\sanfran_b_obj::obj_bridge();
    common_scripts\utility::flag_set( "flag_information_center" );
    common_scripts\utility::flag_set( "flag_door_takedown_cormack_ahead" );
    common_scripts\utility::flag_set( "flag_door_takedown" );
    common_scripts\utility::flag_set( "sonar_threat_detection_off" );
    level.player maps\_player_high_jump::disable_high_jump();
}

information_center()
{
    common_scripts\utility::flag_wait( "flag_information_center" );
    thread maps\sanfran_b_lighting::play_flickering_info_light();
    thread maps\sanfran_b_lighting::fire_inside_02_manage();
    maps\_utility::autosave_by_name();
    thread maps\sanfran_b_code::door_takedown();
    thread maps\sanfran_b_code::player_entering_server_room();
    thread maps\sanfran_b_code::sonar_hint_2();
    thread maps\sanfran_b_code::information_center_combat();
    thread maps\sanfran_b_lighting::flip_spot_light();
    thread maps\sanfran_b_obj::enable_cormack_follow();
    thread maps\sanfran_b_lighting::sundark_call();
    level.player lightsetforplayer( "sanfran_b" );
}

start_bridge()
{
    soundscripts\_snd::snd_message( "start_bridge" );
    maps\sanfran_b_code::spawn_allies();

    if ( level.currentgen )
        maps\_utility::vision_set_fog_changes( "sanfran_b_interior_dark", 0 );
    else
    {
        level.player setclutforplayer( "", 0 );
        thread maps\_utility::vision_set_changes( "sfb_neutral", 0 );
        thread maps\_utility::fog_set_changes( "sanfran_b_interior_dark", 0 );
    }

    level.player lightsetforplayer( "sanfran_b_darker" );
    thread maps\sanfran_b_fx::setup_window_explosion_wait();
    thread maps\sanfran_b_lighting::play_flickering_info_light();
    common_scripts\utility::flag_set( "flag_player_entered_interior" );
    common_scripts\utility::flag_set( "intro_anim_finished" );
    level.burke maps\_utility::disable_cqbwalk();
    level.cormack maps\_utility::disable_cqbwalk();
    level.maddox maps\_utility::disable_cqbwalk();
    maps\sanfran_b_util::teleport_to_scriptstruct( "org_start_bridge" );
    thread maps\sanfran_b_code::tilt_boat( 1 );
    common_scripts\utility::flag_set( "flag_bridge" );
    objective_add( maps\_utility::obj( "obj_plant_jammers" ), "current", &"SANFRAN_B_OBJ_PLANT_JAMMERS" );
    maps\_utility::objective_complete( maps\_utility::obj( "obj_plant_jammers" ) );
    objective_add( maps\_utility::obj( "obj_bridge" ), "current", &"SANFRAN_B_OBJ_BRIDGE" );
    common_scripts\utility::flag_set( "obj_bridge" );
    common_scripts\utility::flag_set( "flag_obj_marker_enter_ship" );
    common_scripts\utility::flag_set( "flag_obj_leave_cafeteria" );
    common_scripts\utility::flag_set( "obj_marker_follow_cormack_to_hanger" );
    common_scripts\utility::flag_set( "flag_obj_enter_hanger" );
    common_scripts\utility::flag_set( "flag_obj_leave_hanger" );
    common_scripts\utility::flag_set( "obj_bridge_complete" );
    thread maps\sanfran_b_obj::obj_secure_deck();
    thread maps\sanfran_b_util::setup_corpses();
    thread maps\sanfran_b_obj::obj_bridge();
    soundscripts\_snd::snd_message( "enter_server_room" );
    maps\sanfran_b_code::give_night_vision();
    level.player maps\_player_high_jump::disable_high_jump();
}

bridge()
{
    common_scripts\utility::flag_wait( "flag_bridge" );
    common_scripts\utility::flag_set( "sonar_threat_detection_off" );
    thread maps\sanfran_b_lighting::play_flickering_bridge_light();
    thread maps\sanfran_b_fx::setup_window_explosion_wait();
    thread common_scripts\_exploder::exploder( 7013 );
    thread common_scripts\_exploder::exploder( 7014 );
    thread common_scripts\_exploder::exploder( 7015 );
    thread common_scripts\_exploder::exploder( 7016 );
    thread common_scripts\_exploder::exploder( 7017 );
    thread common_scripts\_exploder::exploder( 7018 );
    thread common_scripts\_exploder::exploder( 7019 );
    thread common_scripts\_exploder::exploder( 7020 );
    thread maps\sanfran_b_code::move_squad_to_bridge();
    thread maps\sanfran_b_code::console_guy();
    thread maps\sanfran_b_code::delete_specific_navy_ships();
    thread maps\sanfran_b_code::control_room_anims();
    thread maps\sanfran_b_code::handle_mob_turret();
    thread maps\sanfran_b_obj::obj_console();
    thread maps\sanfran_b_obj::obj_laser();
    thread maps\sanfran_b_code::setup_mob_turret_targets();
    thread maps\sanfran_b_code::cargo_ship_fights_back();
    var_0 = getent( "trig_use_console", "targetname" );
    var_0 common_scripts\utility::trigger_off();
    setsaveddvar( "r_fog_ev_adjust", 1.5 );
}

start_demo_with_itiot()
{
    thread itiot_logic( "DestroyCineCopter", "rail_gun" );
    start_deck();
    deck();
    interior();
    hangar();
    information_center();
    bridge();
}

setup()
{
    setdvarifuninitialized( "player_cqb", 0 );
    setup_player();
    spawn_functions();
    setup_threat_bias_groups();
}

setup_player()
{
    maps\_variable_grenade::main();
    level.player thread maps\sanfran_b_util::dynamic_boost_jump();
    thread refill_starting_weapons();
}

refill_starting_weapons()
{
    if ( !isdefined( level.start_point ) || level.start_point == "deck" )
    {
        var_0 = level.player getweaponslistall();

        foreach ( var_2 in var_0 )
            level.player givestartammo( var_2 );
    }
}

spawn_functions()
{
    maps\_utility::add_global_spawn_function( "axis", maps\sanfran_b_code::enable_jump_jet_pathing );
    maps\_utility::add_global_spawn_function( "axis", maps\_variable_grenade::handle_detection );
    maps\_utility::add_global_spawn_function( "axis", maps\sanfran_b_util::add_to_threat_bias, "axis" );
    maps\_utility::add_global_spawn_function( "axis", maps\sanfran_b_code::handle_enemy_when_player_is_in_cqb );
    maps\_utility::add_global_spawn_function( "axis", maps\sanfran_b_code::enable_my_thermal );
    maps\_utility::add_global_spawn_function( "allies", maps\sanfran_b_code::enable_jump_jet_pathing );
    maps\_utility::add_global_spawn_function( "allies", maps\sanfran_b_util::add_to_threat_bias, "allies" );
    maps\_utility::add_global_spawn_function( "allies", maps\sanfran_b_code::disable_ir_in_nightvision );
    maps\_utility::add_global_spawn_function( "allies", maps\sanfran_b_code::disable_my_thermal );
    maps\_utility::array_spawn_function_targetname( "deck_reinforcement_ally", maps\sanfran_b_code::deck_reinforcement_ally_think );
    maps\_utility::array_spawn_function_noteworthy( "navy_deck_guys_initial", maps\sanfran_b_code::initial_deck_guys_invuln );
    maps\_utility::array_spawn_function_noteworthy( "enemy_deck_guys_initial", maps\sanfran_b_code::initial_deck_guys_invuln );
    maps\_utility::array_spawn_function_noteworthy( "server_room_guys", maps\sanfran_b_code::server_room_lasers );
    maps\_utility::array_spawn_function_noteworthy( "bridge_drones", maps\sanfran_b_code::track_bridge_drone_deaths );
    maps\_utility::array_spawn_function_noteworthy( "rpg_vehicle", maps\sanfran_b_util::postspawn_rpg_vehicle );
    maps\_utility::array_spawn_function_noteworthy( "reinforcement_left_guys", maps\sanfran_b_util::equip_microwave_grenade );
    maps\_utility::array_spawn_function_noteworthy( "reinforcement_back_guys", maps\sanfran_b_util::equip_microwave_grenade );
    maps\_utility::array_spawn_function_noteworthy( "initial_hangar_enemies", maps\sanfran_b_util::equip_microwave_grenade );
    maps\_utility::array_spawn_function_noteworthy( "fastzip_enemies", maps\sanfran_b_util::equip_microwave_grenade );
    maps\_utility::array_spawn_function_noteworthy( "hangar_enemy_reinforcements_1", maps\sanfran_b_util::hanger_reinforcements_think );
    maps\_utility::array_spawn_function_targetname( "deck_combat_first_wave_guys", maps\sanfran_b_util::equip_microwave_grenade );
}

setup_threat_bias_groups()
{
    createthreatbiasgroup( "player" );
    level.player setthreatbiasgroup( "player" );
}

setup_portal_scripting()
{
    thread handle_sfb_portal_groups_toggle( "portal_grp_bridge", "toggle_bridge_portal" );
    thread handle_sfb_portal_groups_toggle( "portal_grp_info_center", "toggle_info_center_portal" );
}

handle_sfb_portal_groups_toggle( var_0, var_1 )
{
    level.player endon( "death" );
    level endon( "missionfailed" );
    var_2 = getentarray( var_0, "targetname" );
    var_2[0] enableportalgroup( 1 );

    for (;;)
    {
        common_scripts\utility::flag_wait( var_1 );
        var_2[0] enableportalgroup( 0 );
        common_scripts\utility::flag_waitopen( var_1 );
        var_2[0] enableportalgroup( 1 );
    }
}

itiot_logic( var_0, var_1 )
{
    common_scripts\utility::flag_wait( var_0 );
    setdvar( "demo_itiot", "1" );
    soundscripts\_snd::snd_message( "e3_demo_fade_out" );
    level.player.auxillary_hud = newclienthudelem( level.player );
    level.player.auxillary_hud setshader( "black", 1280, 720 );
    level.player.auxillary_hud.horzalign = "fullscreen";
    level.player.auxillary_hud.vertalign = "fullscreen";
    level.player.auxillary_hud.alpha = 0;
    level.player.auxillary_hud fadeovertime( 0.5 );
    level.player.auxillary_hud.alpha = 1;
    level.player.auxillary_hud.foreground = 1;
    setsaveddvar( "objectiveHide", "1" );
    wait 0.5;
    level.player.auxillary_hud.foreground = 0;
    wait 7;
    maps\sanfran_b_util::teleport_to_scriptstruct( "org_start_bridge" );
    level.player.auxillary_hud.alpha = 1;
    level.player.auxillary_hud fadeovertime( 1 );
    level.player.auxillary_hud.alpha = 0;
    soundscripts\_snd::snd_message( "e3_demo_fade_in" );
    common_scripts\utility::flag_set( "flag_bridge" );
    bridge();
}
