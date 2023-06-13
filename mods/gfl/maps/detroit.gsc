// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    common_scripts\utility::flag_init( "exitdrive_lights_on" );
    common_scripts\utility::flag_init( "player_fall" );
    common_scripts\utility::flag_init( "enter_night_club" );
    common_scripts\utility::flag_init( "drivein_player_bike_used" );
    common_scripts\utility::flag_init( "bike_lights_off" );
    common_scripts\utility::flag_init( "burke_ride_finished" );
    common_scripts\utility::flag_init( "2_mile_radius" );
    common_scripts\utility::flag_init( "begin_setup_alley" );
    common_scripts\utility::flag_init( "time_to_fight_outside_school" );
    common_scripts\utility::flag_init( "outside_school_fight_finished" );
    common_scripts\utility::flag_init( "player_close_to_door" );
    common_scripts\utility::flag_init( "flag_kva_basement_1_open_door" );
    common_scripts\utility::flag_init( "flag_basement_guy_1_end_idle" );
    common_scripts\utility::flag_init( "rendezvous" );
    common_scripts\utility::flag_init( "rendezvous_obj_reached" );
    common_scripts\utility::flag_init( "march_to_hospital" );
    common_scripts\utility::flag_init( "burke_nightclub_advance" );
    common_scripts\utility::flag_init( "hospital_wave_2" );
    common_scripts\utility::flag_init( "hospital_inner_fight" );
    common_scripts\utility::flag_init( "go_go_go" );
    common_scripts\utility::flag_init( "hospital_breached" );
    common_scripts\utility::flag_init( "school_trains" );
    common_scripts\utility::flag_init( "spraypaint" );
    common_scripts\utility::flag_init( "open_school_door" );
    common_scripts\utility::flag_init( "flag_stage_dialogue_start_audio" );
    common_scripts\utility::flag_init( "flag_stage_dialogue_end_audio" );
    common_scripts\utility::flag_init( "flag_stage_dialogue_end" );
    common_scripts\utility::flag_init( "flag_decon_ready_burke" );
    common_scripts\utility::flag_init( "flag_decon_ready_joker" );
    common_scripts\utility::flag_init( "flag_decon_ready_bones" );
    common_scripts\utility::flag_init( "flag_decon_ready_player" );
    common_scripts\utility::flag_init( "flag_scanner_doors_open" );
    common_scripts\utility::flag_init( "burke_cleared" );
    common_scripts\utility::flag_init( "joker_cleared" );
    common_scripts\utility::flag_init( "bones_cleared" );
    common_scripts\utility::flag_init( "flag_camp_visibility_04" );
    common_scripts\utility::flag_init( "shake_tiles" );
    common_scripts\utility::flag_init( "open_massive_door" );
    common_scripts\utility::flag_init( "massive_door_lights" );
    common_scripts\utility::flag_init( "massive_door_guard_in_position" );
    common_scripts\utility::flag_init( "show_cracked_floor" );
    common_scripts\utility::flag_init( "delete_cracked_floor" );
    common_scripts\utility::flag_init( "exit_drive_started" );
    common_scripts\utility::flag_init( "burke_leaving_bodies_room" );
    common_scripts\utility::flag_init( "begin_final_slice_moment" );
    common_scripts\utility::flag_init( "school_player_falling" );
    common_scripts\utility::flag_init( "school_jeep_delete" );
    common_scripts\utility::flag_init( "refugee_camp_cleanup" );
    common_scripts\utility::flag_init( "security_checkpoint_cleanup" );
    common_scripts\utility::flag_init( "massive_door_cleanup" );
    common_scripts\utility::flag_init( "can_burke_exit_trash" );
    common_scripts\utility::flag_init( "check_school" );
    common_scripts\utility::flag_init( "ride_over" );
    common_scripts\utility::flag_init( "burke_needs_to_idle" );
    common_scripts\utility::flag_init( "resume_100_speed" );
    common_scripts\utility::flag_init( "player_has_started_outside_combat" );
    common_scripts\utility::flag_init( "start_kva_notice_dialogue" );
    common_scripts\utility::flag_init( "stop_burke_asking_player_to_drop_patrol" );
    common_scripts\utility::flag_init( "sentinel_reveal_started" );
    common_scripts\utility::flag_init( "qte_success_breach" );
    common_scripts\utility::flag_init( "jetbike_dynfx_on" );
    common_scripts\utility::flag_init( "wall_grab_success" );
    common_scripts\utility::flag_init( "flag_send_team_to_the_truck" );
    common_scripts\utility::flag_init( "exo_moment_everyone_pushing" );
    common_scripts\utility::flag_init( "exo_moment_everyone_reaching" );
    common_scripts\utility::flag_init( "exo_push_should_idle" );
    common_scripts\utility::flag_init( "exo_push_should_push" );
    common_scripts\utility::flag_init( "exo_push_player_attached" );
    common_scripts\utility::flag_init( "exo_push_burke_attaching" );
    common_scripts\utility::flag_init( "aud_ambulance_pushing" );
    common_scripts\utility::flag_init( "flag_open_door_to_bikes" );
    common_scripts\utility::flag_init( "player_on_exitdrive_jetbike" );
    common_scripts\utility::flag_init( "doctor_on_bike" );
    common_scripts\utility::flag_init( "level_intro_cinematic_complete" );
    common_scripts\utility::flag_init( "player_has_dismounted_and_moved_ahead" );
    common_scripts\utility::flag_init( "onfoot_segment_complete" );
    common_scripts\utility::flag_init( "start_exit_trains" );
    common_scripts\utility::flag_init( "exo_push_phase1_complete" );
    common_scripts\utility::flag_init( "exo_push_phase2_complete" );
    common_scripts\utility::flag_init( "exo_push_phase3_complete" );
    common_scripts\utility::flag_init( "window_exo_guys_spawned_yet" );
    common_scripts\utility::flag_init( "spawn_more_hospital_roof_guys" );
    common_scripts\utility::flag_init( "send_exopush_guys_into_hospital" );
    common_scripts\utility::flag_init( "send_exopush_secondline_into_hospital" );
    common_scripts\utility::flag_init( "portal_grp_gate_on" );
    common_scripts\utility::flag_init( "squad_gestures_done_burke" );
    common_scripts\utility::flag_init( "squad_gestures_done_joker" );
    common_scripts\utility::flag_init( "send_all_teammates_upstairs" );
    common_scripts\utility::flag_init( "obj_acquire_bikes_give" );
    common_scripts\utility::flag_init( "obj_acquire_bikes_pos_bike" );
    common_scripts\utility::flag_init( "obj_acquire_bikes_complete" );
    common_scripts\utility::flag_init( "obj_check_school_give" );
    common_scripts\utility::flag_init( "obj_check_school_pos_door" );
    common_scripts\utility::flag_init( "obj_check_school_on_burke" );
    common_scripts\utility::flag_init( "obj_check_school_complete" );
    common_scripts\utility::flag_init( "obj_reunite_with_burke_give" );
    common_scripts\utility::flag_init( "obj_reunite_with_burke_pos_reunite" );
    common_scripts\utility::flag_init( "obj_reunite_with_burke_complete" );
    common_scripts\utility::flag_init( "obj_rendezvous_joker_complete" );
    common_scripts\utility::flag_init( "obj_exo_push_give" );
    common_scripts\utility::flag_init( "obj_exo_push_complete" );
    common_scripts\utility::flag_init( "obj_capture_doctor_pos_doctor" );
    common_scripts\utility::flag_init( "obj_capture_doctor_pos_doctor_breached" );
    common_scripts\utility::flag_init( "obj_capture_doctor_complete" );
    common_scripts\utility::flag_init( "obj_escape_detroit_give" );
    common_scripts\utility::flag_init( "obj_escape_detroit_pos_sentinel_reveal" );
    common_scripts\utility::flag_init( "obj_escape_detroit_pos_exit_stairs" );
    common_scripts\utility::flag_init( "obj_escape_detroit_on_player_bike" );
    common_scripts\utility::flag_init( "obj_escape_detroit_on_player_bike_mount" );
    common_scripts\utility::flag_init( "obj_escape_detroit_on_burke" );
    common_scripts\utility::flag_init( "obj_escape_detroit_complete" );
    common_scripts\utility::flag_init( "begin_kva_assault_on_sentinel" );
    common_scripts\utility::flag_init( "send_joker_and_doctor_to_bikes" );
    common_scripts\utility::flag_init( "sentinel_reveal_guy1_decloak" );
    common_scripts\utility::flag_init( "sentinel_reveal_guy2_decloak" );
    common_scripts\utility::flag_init( "sentinel_reveal_guy3_decloak" );
    common_scripts\utility::flag_init( "sentinel_recloak" );
    common_scripts\utility::flag_init( "sentinel_kva_fov_lerp_out" );
    common_scripts\utility::flag_init( "reveal_the_sentinels" );
    common_scripts\utility::flag_init( "gate_pulse_light" );
    common_scripts\utility::flag_init( "player_captured_doctor" );
    common_scripts\utility::flag_init( "joker_wait_before_reveal" );
    common_scripts\utility::flag_init( "joker_wait_before_doorway" );
    common_scripts\utility::flag_init( "send_burke_to_sentinel_reveal_spot" );
    common_scripts\utility::flag_init( "capture_animation_complete" );
    common_scripts\utility::flag_init( "sentinel_reveal_animation_complete" );
    common_scripts\utility::flag_init( "let_burke_reach_sentinel_reveal" );
    common_scripts\utility::flag_init( "joker_deliver_decon_line" );
    common_scripts\utility::flag_init( "knock_over_paymachine" );
    common_scripts\utility::flag_init( "exo_push_has_been_started" );
    common_scripts\utility::flag_init( "lightning_on" );
    common_scripts\utility::flag_init( "lightning_on_school" );
    common_scripts\utility::flag_init( "capture_start" );
    common_scripts\utility::flag_init( "flag_autofocus_on" );
    common_scripts\utility::flag_init( "basement_clear" );
    common_scripts\utility::flag_init( "show_capture_bag" );
    common_scripts\utility::flag_init( "show_capture_head" );
    common_scripts\utility::flag_init( "swap_to_head_bagged" );
    common_scripts\utility::flag_init( "ok_to_start_exo_push" );
    common_scripts\utility::flag_init( "doctor_inside_office_now" );
    common_scripts\utility::flag_init( "grab_the_doctor" );
    common_scripts\utility::flag_init( "burke_is_shimmey_halfway_can_continue" );
    common_scripts\utility::flag_init( "exo_push_spawner_scaffolding_trigger" );
    common_scripts\utility::flag_init( "burke_180_loop_end" );
    common_scripts\utility::flag_init( "red_dim" );
    common_scripts\utility::flag_init( "all_street_fighters_dead" );
    common_scripts\utility::flag_init( "player_has_entered_the_bar" );
    common_scripts\utility::flag_init( "bar_has_been_cleared" );
    common_scripts\utility::flag_init( "copy_that_stay_alert" );
    common_scripts\utility::flag_init( "player_failed_wall_grab_stop" );
    common_scripts\utility::flag_init( "player_is_shocked" );
    common_scripts\utility::flag_init( "doctor_has_run_once" );
    common_scripts\utility::flag_init( "flag_cg_kill_camp_chopper_loop" );
    common_scripts\utility::flag_init( "flag_cg_intro_cin_has_run" );
    common_scripts\utility::flag_init( "send_bones_joker_to_cover1" );
    common_scripts\utility::flag_init( "kill_the_two_guys_by_ambulance" );
    common_scripts\utility::flag_init( "stop_shooting_ambulance_now" );
    common_scripts\utility::flag_init( "start_tracking_sniper_deaths" );
    common_scripts\utility::flag_init( "show_grab_doctor_prompt" );
    common_scripts\utility::flag_init( "team_move_hospital" );
    common_scripts\utility::flag_init( "hospital_escape_trains_only" );
    common_scripts\utility::flag_init( "start_kva_window_ambush" );
    common_scripts\utility::flag_init( "move_to_be_killed" );
    common_scripts\utility::flag_init( "window_ambush_flag" );
    common_scripts\utility::flag_init( "gourney_guys_dead" );
    common_scripts\utility::flag_init( "secondline_guys_killed" );
    common_scripts\utility::flag_init( "backline_guys_alldead" );
    common_scripts\utility::flag_init( "van_pushed_atlaest_once" );
    common_scripts\utility::flag_init( "burke needs to stop rubber banding now" );
    common_scripts\utility::flag_init( "everone_motorpool_animate" );
    common_scripts\utility::flag_init( "begin_player_mount_bike" );
    common_scripts\utility::flag_init( "disable_player_jetbike_lights" );
    common_scripts\utility::flag_init( "bones_speed_zero" );
    common_scripts\utility::flag_init( "start_slowing_bones_down" );
    common_scripts\utility::flag_init( "begin_bike_dismount_player" );
    common_scripts\utility::flag_init( "kill_the_valve_anim" );
    common_scripts\utility::flag_init( "level_name_intro_done" );
    common_scripts\utility::flag_init( "fade_in_intro_screen" );
    common_scripts\utility::flag_init( "sitrep_dialogue_line" );
    common_scripts\utility::flag_init( "player_used_bodies_room_door" );
    common_scripts\utility::flag_init( "basement_string_objectives" );
    common_scripts\utility::flag_init( "open_school_basement_door" );
    common_scripts\utility::flag_init( "begin_objectives" );
    common_scripts\utility::flag_init( "joker_pickup_doctor_is_ok_now" );
    common_scripts\utility::flag_init( "truck_button_in_place" );
    common_scripts\utility::flag_init( "dont_spawn_art_room_flashlight_guy" );
    common_scripts\utility::flag_init( "dont_spawn_basement_troop_2" );
    common_scripts\utility::flag_init( "player_basement_spotted" );
    common_scripts\utility::flag_init( "stop_exit_drive_rumbles" );
    common_scripts\utility::flag_init( "kill_scare_team" );
    common_scripts\utility::flag_init( "show_sentinel_guys_now" );
    common_scripts\utility::flag_init( "one_street_guy_dead_kickoff_fight_now" );
    common_scripts\utility::flag_init( "begin_pa_system_dialogue" );
    common_scripts\utility::flag_init( "no_more_basement_alerts" );
    common_scripts\utility::flag_init( "third_guy_alerted" );
    common_scripts\utility::flag_init( "flashbang" );
    common_scripts\utility::flag_init( "doctor_grabbed" );
    common_scripts\utility::flag_init( "doctor_can_be_killed_now" );
    common_scripts\utility::flag_init( "connect_basement_door_clip" );
    common_scripts\utility::flag_init( "last_school_guy_dead" );
    common_scripts\utility::flag_init( "wall_grab_guy_dead" );
    common_scripts\utility::flag_init( "intro_animation_completed_now" );
    common_scripts\utility::flag_init( "level_intro_cinematic_complete_real" );
    maps\_utility::add_control_based_hint_strings( "jetbike_controls_controller", &"DETROIT_JETBIKE_CONTROLS_CONTROLLER", maps\detroit_exit_drive::player_input_control_hint_off, &"DETROIT_JETBIKE_CONTROLS_PC", &"DETROIT_JETBIKE_CONTROLS_CONTROLLER_SP" );
    maps\detroit_vo::init_dialogue_flags();
    level.detroit_drive_in_fov = 60;
    level.detroit_spring_cam_lerp_speed = 1.1;
    level.detroit_spring_cam_release_speed = 0.4;
    level.exclusive_fog_tech = "dfog";
    maps\_utility::add_start( "level_start", ::start_refugee_camp, "" );
    maps\_utility::add_start( "mount_bikes", ::debug_start_drive_in );
    maps\_utility::add_start( "school_begin", maps\detroit_refugee_camp::school_begin_onbike );
    maps\_utility::add_start( "school_interior_start", ::debug_start_school_interior );
    maps\_utility::add_start( "school_before_fall", ::debug_start_school_before_fall );
    maps\_utility::add_start( "school_basement", ::debug_start_school_basement );
    maps\_utility::add_start( "school_wall_grab", ::debug_start_school_wall_grab, "" );
    maps\_utility::add_start( "alleyway", ::debug_start_alleyway );
    maps\_utility::add_start( "office", ::debug_start_nightclub );
    maps\_utility::add_start( "exo_push", ::debug_start_exopush );
    maps\_utility::add_start( "hospital", ::debug_start_hospital );
    maps\_utility::add_start( "hospital_capture_animation", ::debug_start_hospital_capture );
    maps\_utility::add_start( "sentinel_reveal", ::debug_start_sentinel_reveal );
    maps\_utility::add_start( "exit_drive", ::debug_start_exit_drive );
    maps\_utility::add_start( "exit_drive_end", ::debug_start_exit_drive_end );
    maps\_utility::add_start( "demo_with_itiot", ::debug_start_demo_with_itiot, "" );
    maps\_utility::add_start( "edge_magazine_turntable", ::gideon_turntable_demo );
    // level.start_point = "school_basement";

    if ( level.currentgen )
    {
        maps\_utility::set_start_transients( "level_start", [ "detroit_intro_tr", "detroit_introa_tr" ] );
        maps\_utility::set_start_transients( "mount_bikes", [ "detroit_intro_tr", "detroit_gatetrans_tr" ] );
        var_0 = [ "detroit_school_interior_tr", "detroit_middle_tr" ];
        maps\_utility::set_start_transients( "school_begin", [ "detroit_middle_tr", "detroit_gatetrans_tr" ] );
        maps\_utility::set_start_transients( "school_interior_start", [ "detroit_middle_tr", "detroit_school_interior_tr" ] );
        maps\_utility::set_start_transients( "school_before_fall", var_0 );
        maps\_utility::set_start_transients( "school_basement", var_0 );
        maps\_utility::set_start_transients( "school_wall_grab", var_0 );
        var_1 = [ "detroit_middle_tr", "detroit_nightclub_interior_tr" ];
        maps\_utility::set_start_transients( "alleyway", [ "detroit_middle_tr", "detroit_school_interior_tr" ] );
        maps\_utility::set_start_transients( "office", [ "detroit_nightclub_interior_tr", "detroit_middle_tr" ] );
        var_2 = [ "detroit_middle_tr", "detroit_hospital_interior_tr" ];
        maps\_utility::set_start_transients( "exo_push", var_2 );
        maps\_utility::set_start_transients( "hospital", var_2 );
        maps\_utility::set_start_transients( "hospital_capture_animation", var_2 );
        maps\_utility::set_start_transients( "sentinel_reveal", var_2 );
        maps\_utility::set_start_transients( "exit_drive", var_2 );
        var_3 = [ "detroit_middle_tr", "detroit_outro_tr" ];
        maps\_utility::set_start_transients( "exit_drive_end", var_3 );
        maps\_utility::tff_sync_setup();
    }

    maps\_utility::template_level( "detroit" );
    maps\createart\detroit_art::main();
    maps\detroit_fx::main();
    maps\detroit_precache::main();
    maps\_load::main();
    thread maps\_player_exo::main( "specialist", 1 );
    maps\detroit_anim::main();
    maps\_patrol_extended::main();
    maps\_stealth::main();
    maps\detroit_aud::main();
    maps\detroit_lighting::main2();
    maps\_drone_civilian::init();
    maps\_drone_ai::init();
    maps\detroit_vo::main();
    maps\_variable_grenade::init_variable_grenade();
    maps\_car_door_shield::init_door_shield();
    level.spotlight_owner = undefined;
    level.give_player_flashlight = 1;
    level.spotlights = [];
    level.player notifyonplayercommand( "dpad_down", "+actionslot 2" );
    level.player notifyonplayercommand( "dpad_left", "+actionslot 3" );
    level.player notifyonplayercommand( "dpad_right", "+actionslot 4" );
    level.player notifyonplayercommand( "dpad_up", "+actionslot 1" );
    level.player notifyonplayercommand( "a_pressed", "+gostand" );
    level.player notifyonplayercommand( "b_pressed", "+stance" );
    level.player notifyonplayercommand( "y_pressed", "weapnext" );
    level.player notifyonplayercommand( "x_pressed", "+usereload" );
    level.player notifyonplayercommand( "attack_pressed", "+attack" );

    if ( level.currentgen )
        maps\detroit_transients_cg::detroit_cg_precache_models();

    precachemodel( "det_ticketmachine_damaged_rigged" );

    if ( level.nextgen )
        precachemodel( "body_fso_vest_a" );

    precachemodel( "det_hospital_shelf_01" );
    precachemodel( "det_shimmy_panels_01_anim" );
    precachemodel( "ehq_baseball" );
    precachemodel( "ehq_baseball_glove_01" );
    precachemodel( "com_spray_can01" );
    precachemodel( "det_hospital_door_02" );
    precachemodel( "vehicle_xh9_warbird" );
    precachemodel( "vehicle_xh9_warbird_interior_only" );
    precachemodel( "vehicle_xh9_warbird_mp" );
    precachemodel( "viewbody_atlas_military" );
    precachemodel( "worldhands_s1_pmc" );
    precachemodel( "viewbody_atlas_military_detroit" );
    precachemodel( "viewhands_atlas_military_detroit" );
    precachemodel( "worldhands_atlas_military_detroit" );
    precachemodel( "s1_lightfluohang_double_on_dim" );
    precachemodel( "me_lightfluohang_double_destroyed" );
    precachemodel( "vehicle_mil_hoverbike_ai" );
    precachemodel( "vehicle_mil_hoverbike_ai_obj" );
    precachemodel( "vehicle_mil_hoverbike_parked_static" );
    precachemodel( "npc_bal_27_grey" );
    precachemodel( "vehicle_mil_hoverbike_vm" );
    precachemodel( "genericprop" );
    precachemodel( "det_basement_valve_01_anim" );
    precachemodel( "det_school_door_01_anim" );
    precachemodel( "body_hero_burke_sentinel_covert_cloak" );
    precachemodel( "sentinel_covert_body_a" );
    precachemodel( "kva_hazmat_head_a_damaged" );
    precachemodel( "det_doctor_prop_bagA" );
    precachemodel( "vehicle_civ_det_train_car_01" );
    precachemodel( "det_cargo_box_single_01" );
    precachemodel( "det_school_door_01_anim_obj" );
    precachemodel( "det_floor_collapse_01_anim" );
    precachemodel( "det_doctor_head_bagA" );
    precachemodel( "vehicle_mil_humvee_cleaner_01_ai" );
    precachemodel( "prop_cigarette" );
    precachelaser( "lag_snipper_laser" );
    precachemodel( "det_school_door_01_anim" );
    precachemodel( "kva_hazmat_body_a_stabbed" );
    precacherumble( "damage_light" );
    precacherumble( "light_1s" );
    precacherumble( "light_2s" );
    precacherumble( "light_3s" );
    precacherumble( "damage_heavy" );
    precacherumble( "heavy_1s" );
    precacherumble( "heavy_2s" );
    precacherumble( "heavy_3s" );
    precacherumble( "steady_rumble" );

    if ( level.currentgen )
    {
        precachemodel( "civ_urban_male_dead_body_a" );
        precachemodel( "civ_urban_male_dead_body_b" );
        precachemodel( "civ_urban_male_dead_body_c" );
        precachemodel( "civ_urban_female_dead_body_a" );
        precachemodel( "civ_urban_female_dead_body_b" );
        precachemodel( "head_male_sp_siejak" );
        precachemodel( "head_male_mp_brickerson" );
        precachemodel( "civ_urban_male_head_kanik" );
        precachemodel( "head_ilana_civilian" );
    }

    // precacheshellshock( "mp7_silencer" );
    // precacheshellshock( "heli_minigun_so" );
    // precacheshellshock( "mig_25mm_cannon" );
    // precacheshellshock( "sidewinder_warhawk_aftermath" );
    // precacheshellshock( "flash_grenade" );
    // precacheshellshock( "flash_grenade_var" );
    precacheshellshock( "iw5_unarmed_nullattach" );
    precacheshellshock( "iw5_unarmeddetroit_nullattach" );
    precacheshellshock( "iw5_bal27_sp" );
    precacheshellshock( "iw5_bal27down_sp" );
    precacheshellshock( "iw5_bal27_sp_silencer01_variablereddot" );
    precacheshellshock( "iw5_bal27_sp_variablereddot" );
    precacheshellshock( "iw5_bal27_sp_opticsthermal" );
    precacheshellshock( "iw5_hbra3_sp_opticstargetenhancer" );
    // precacheshellshock( "paris_scripted_flashbang" );
    precacheshellshock( "iw5_mp11_sp" );
    precacheshellshock( "iw5_arx160_sp" );
    precacheshader( "s1_railgun_hud_outer_shadow" );

    if ( level.nextgen )
    {
        precacheshader( "m/mtl_mil_hoverbike_emissive" );
        precacheshader( "m/mtl_burke_sentinel_covert_headgear_a_cloak" );
        precacheshader( "mc/mtl_burke_sentinel_covert_headgear_a_cloak" );
        precacheshader( "m/cloak_generic" );
        precacheshader( "m/mtl_dr_pas_head_damaged" );
    }
    else
    {
        precacheshader( "mq/mtl_burke_sentinel_covert_headgear_a_cloak" );
        precacheshader( "mqc/mtl_burke_sentinel_covert_headgear_a_cloak" );
        precacheshader( "mq/cloak_generic" );
        precacheshader( "mq/mtl_dr_pas_head_damaged" );
    }

    precachestring( &"on_hoverbike_update" );
    precachestring( &"DETROIT_FOUR_YEARS_LATER" );
    thread setup_player();
    thread objective_manager();
    thread maps\detroit_refugee_camp::refugee_camp_main();
    thread maps\detroit_school::school_main();
    thread maps\detroit_streets::streets_main();
    thread maps\detroit_hospital::hospital_main();
    thread maps\detroit_exit_drive::exit_drive_main();
    thread debug_all();
    thread player_health_current();
    maps\_utility::add_global_spawn_function( "allies", ::stealth_spawn_function );
    maps\_utility::add_global_spawn_function( "axis", ::stealth_spawn_function );
    maps\_utility::add_global_spawn_function( "axis", ::ai_thermal );
    maps\_stealth_utility::stealth_ai_event_dist_default();
    var_4 = [];
    var_4["ai_eventDistFootstep"] = [];
    var_4["ai_eventDistFootstepWalk"] = [];
    var_4["ai_eventDistFootstep"]["hidden"] = 110;
    var_4["ai_eventDistFootstepWalk"]["hidden"] = 85;
    thread maps\_stealth_utility::stealth_ai_event_dist_custom( var_4 );
    level.flashcount = 0;
    setup_portal_scripting();
    maps\_load::set_player_viewhand_model( "s1_gfl_ump45_viewhands" );

    if ( level.currentgen )
    {
        setsaveddvar( "r_gunSightColorEntityScale", "7" );
        setsaveddvar( "r_gunSightColorNoneScale", "0.8" );
    }

    var_5 = getdvarint( "demo_itiot", 0 );

    if ( var_5 )
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
    }
}

debug_turrets()
{
    for (;;)
    {
        var_0 = [];
        var_1 = getentarray( "misc_turret", "code_classname" );

        foreach ( var_3 in var_1 )
        {
            var_4 = var_3.model;

            if ( !isdefined( var_0[var_4] ) )
            {
                var_0[var_4] = 1;
                continue;
            }

            var_0[var_4]++;
        }

        var_6 = "total:" + var_1.size + ", ";

        foreach ( var_4, var_8 in var_0 )
            var_6 += ( var_4 + ":" + var_8 + ", " );

        wait 0.05;
    }
}

spawn_bikes()
{
    var_0 = getent( "player_jetbike", "targetname" ) maps\_utility::spawn_vehicle();
    var_1 = getent( "burke_jetbike", "targetname" ) maps\_utility::spawn_vehicle();
    var_2 = getent( "joker_jetbike", "targetname" ) maps\_utility::spawn_vehicle();
    var_3 = getent( "bones_jetbike", "targetname" ) maps\_utility::spawn_vehicle();
    var_0.animname = "player_bike";
    var_3.animname = "bones_bike";
    var_1.animname = "burke_bike";
    var_2.animname = "joker_bike";
    var_3 vehphys_disablecrashing();
    var_1 vehphys_disablecrashing();
    var_2 vehphys_disablecrashing();
    level.burke_bike = var_1;
    level.joker_bike = var_2;
    level.bones_bike = var_3;
    level.player_bike = var_0;
}

debug_ai_count()
{
    for (;;)
    {
        var_0 = getaiarray();
        var_1 = 0;

        foreach ( var_3 in var_0 )
        {
            if ( sighttracepassed( var_3 geteye(), level.player geteye(), 0, level.player_bike ) )
            {
                var_1++;
                var_3.was_ever_visible = 1;
            }
        }

        var_5 = 0;

        foreach ( var_3 in var_0 )
        {
            if ( !isdefined( var_3.was_ever_visible ) )
            {
                var_5++;
                continue;
            }
        }

        waitframe();
    }
}

stealth_spawn_function()
{
    if ( isdefined( self.script_stealthgroup ) && self.script_stealthgroup >= 0 )
        maps\_stealth_utility::stealth_default();
}

ai_thermal()
{
    self thermaldrawenable();
}

debug_all()
{
    for (;;)
        level waittill( "event_awareness", var_0 );
}

objective_manager()
{
    waittillframeend;
    set_completed_objective_flags();
    var_0 = ( 0, 0, 32 );
    common_scripts\utility::flag_wait( "begin_objectives" );
    objective_add( maps\_utility::obj( "Follow Gideon" ), "current", &"DETROIT_FOLLOW_GIDEON", level.burke.origin );
    objective_onentity( maps\_utility::obj( "Follow Gideon" ), level.burke );
    common_scripts\utility::flag_wait( "obj_acquire_bikes_pos_bike" );
    var_1 = getent( "player_jetbike", "targetname" );

    if ( isdefined( level.player_bike ) )
    {
        var_2 = getent( "use_hoverbike_xprompt", "targetname" );
        objective_position( maps\_utility::obj( "Follow Gideon" ), var_2.origin );
        objective_setpointertextoverride( maps\_utility::obj( "Follow Gideon" ), &"DETROIT_USE" );
    }

    common_scripts\utility::flag_wait( "obj_check_school_give" );

    if ( isdefined( level.burke ) )
        objective_onentity( maps\_utility::obj( "Follow Gideon" ), level.burke );

    common_scripts\utility::flag_wait( "obj_check_school_pos_door" );
    var_3 = getent( "obj_investigate_school_pos_door_struct", "targetname" );
    objective_position( maps\_utility::obj( "Follow Gideon" ), var_3.origin );
    common_scripts\utility::flag_wait( "obj_check_school_on_burke" );

    if ( isdefined( level.burke ) )
        objective_onentity( maps\_utility::obj( "Follow Gideon" ), level.burke );

    common_scripts\utility::flag_wait( "obj_check_school_complete" );
    maps\_utility::objective_complete( maps\_utility::obj( "Follow Gideon" ) );
    common_scripts\utility::flag_wait( "obj_reunite_with_burke_give" );
    var_4 = getent( "alpha_reunite_objective_org", "targetname" );
    objective_add( maps\_utility::obj( "Reunite with Burke" ), "current", &"DETROIT_OBJECTIVE_RENDEZVOUS_BURKE", ( 0, 0, 0 ) );
    common_scripts\utility::flag_set( "basement_string_objectives" );
    common_scripts\utility::flag_wait( "obj_reunite_with_burke_pos_reunite" );
    objective_position( maps\_utility::obj( "Reunite with Burke" ), var_4.origin );
    common_scripts\utility::flag_wait( "obj_reunite_with_burke_complete" );
    maps\_utility::objective_complete( maps\_utility::obj( "Reunite with Burke" ) );
    wait 0.5;
    objective_add( maps\_utility::obj( "Push forward!" ), "current", &"DETROIT_OBJECTIVE_PUSH_VEHICLE", common_scripts\utility::getstruct( "obj_rendezvous_joker_struct", "targetname" ).origin );
    common_scripts\utility::flag_wait( "obj_rendezvous_joker_pos_office_atrium" );
    objective_position( maps\_utility::obj( "Push forward!" ), common_scripts\utility::getstruct( "obj_rendezvous_joker_pos_office_atrium_struct", "targetname" ).origin );
    common_scripts\utility::flag_wait( "obj_rendezvous_joker_pos_office_window" );
    objective_position( maps\_utility::obj( "Push forward!" ), common_scripts\utility::getstruct( "obj_rendezvous_joker_pos_office_window_struct", "targetname" ).origin );
    common_scripts\utility::flag_wait( "obj_rendezvous_joker_pos_joker" );
    objective_position( maps\_utility::obj( "Push forward!" ), common_scripts\utility::getstruct( "obj_rendezvous_joker_pos_joker_struct", "targetname" ).origin );
    common_scripts\utility::flag_wait( "obj_rendezvous_joker_complete" );
    common_scripts\utility::flag_wait( "obj_exo_push_give" );
    var_5 = getent( "exo_push_ambulance", "targetname" );

    if ( isdefined( var_5 ) )
    {
        objective_onentity( maps\_utility::obj( "Push forward!" ), var_5, level.truck_org_cords );
        objective_setpointertextoverride( maps\_utility::obj( "Push forward!" ), &"DETROIT_OBJECTIVE_POINTER_PUSH" );
    }

    common_scripts\utility::flag_wait( "obj_exo_push_complete" );
    maps\_utility::objective_complete( maps\_utility::obj( "Push forward!" ) );
    objective_add( maps\_utility::obj( "Capture the doctor" ), "current", &"DETROIT_OBJECTIVE_CAPTURE_DOCTOR", common_scripts\utility::getstruct( "obj_capture_doctor_pos_ground_floor_struct", "targetname" ).origin );
    common_scripts\utility::flag_wait( "obj_capture_doctor_pos_stairs" );
    objective_position( maps\_utility::obj( "Capture the doctor" ), common_scripts\utility::getstruct( "obj_capture_doctor_pos_stairs_struct", "targetname" ).origin );
    common_scripts\utility::flag_wait( "obj_capture_doctor_pos_2nd_floor" );
    objective_position( maps\_utility::obj( "Capture the doctor" ), common_scripts\utility::getstruct( "obj_capture_doctor_pos_2nd_floor_struct", "targetname" ).origin );
    common_scripts\utility::flag_wait( "obj_capture_doctor_pos_doctor" );
    objective_setpointertextoverride( maps\_utility::obj( "Capture the doctor" ), &"DETROIT_OBJECTIVE_CAPTURE" );

    if ( isdefined( level.doctor ) )
        objective_onentity( maps\_utility::obj( "Capture the doctor" ), level.doctor );

    common_scripts\utility::flag_wait( "doctor_inside_office_now" );
    objective_setpointertextoverride( maps\_utility::obj( "Capture the doctor" ), &"SCRIPT_WAYPOINT_BREACH" );
    objective_position( maps\_utility::obj( "Capture the doctor" ), common_scripts\utility::getstruct( "obj_capture_doctor_pos_door_struct", "targetname" ).origin );
    common_scripts\utility::flag_wait( "obj_capture_doctor_pos_doctor_breached" );

    if ( isdefined( level.doctor ) )
        objective_onentity( maps\_utility::obj( "Capture the doctor" ), level.doctor );

    objective_setpointertextoverride( maps\_utility::obj( "Capture the doctor" ), &"DETROIT_OBJECTIVE_CAPTURE" );
    common_scripts\utility::flag_wait( "obj_capture_doctor_complete" );
    maps\_utility::objective_complete( maps\_utility::obj( "Capture the doctor" ) );
    common_scripts\utility::flag_wait( "obj_escape_detroit_give" );
    objective_add( maps\_utility::obj( "deliver the cargo" ), "current", &"DETROIT_OBJECTIVE_ESCAPE_DETROIT", common_scripts\utility::getstruct( "obj_escape_detroit_give_struct", "targetname" ).origin );
    common_scripts\utility::flag_wait( "obj_escape_detroit_pos_hospital_stairs" );
    objective_position( maps\_utility::obj( "deliver the cargo" ), common_scripts\utility::getstruct( "obj_escape_detroit_pos_hospital_stairs_struct", "targetname" ).origin );
    common_scripts\utility::flag_wait( "obj_escape_detroit_pos_hospital_stairs_top" );
    objective_position( maps\_utility::obj( "deliver the cargo" ), common_scripts\utility::getstruct( "obj_escape_detroit_pos_hospital_stairs_top_struct", "targetname" ).origin );
    common_scripts\utility::flag_wait( "obj_escape_detroit_pos_sentinel_stairs" );
    objective_position( maps\_utility::obj( "deliver the cargo" ), common_scripts\utility::getstruct( "obj_escape_detroit_pos_sentinel_stairs_struct", "targetname" ).origin );
    common_scripts\utility::flag_wait( "obj_escape_detroit_pos_sentinel_doors" );
    objective_position( maps\_utility::obj( "deliver the cargo" ), common_scripts\utility::getstruct( "obj_escape_detroit_pos_sentinel_doors_struct", "targetname" ).origin );
    common_scripts\utility::flag_wait( "obj_escape_detroit_pos_sentinel_reveal" );
    objective_position( maps\_utility::obj( "deliver the cargo" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "obj_escape_detroit_pos_exit_stairs" );
    objective_position( maps\_utility::obj( "deliver the cargo" ), common_scripts\utility::getstruct( "obj_escape_detroit_pos_exit_stairs_struct", "targetname" ).origin );
    common_scripts\utility::flag_wait( "obj_escape_detroit_on_player_bike" );

    if ( isdefined( level.jetbike ) )
    {
        var_2 = getent( "exit_drive_starting_prompt", "targetname" );
        objective_setpointertextoverride( maps\_utility::obj( "deliver the cargo" ), &"DETROIT_USE" );
        objective_position( maps\_utility::obj( "deliver the cargo" ), var_2.origin );
    }

    common_scripts\utility::flag_wait( "obj_escape_detroit_on_player_bike_mount" );
    objective_position( maps\_utility::obj( "deliver the cargo" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "obj_escape_detroit_on_burke" );
    objective_setpointertextoverride( maps\_utility::obj( "deliver the cargo" ), &"DETROIT_FOLLOW" );

    if ( isdefined( level.burke ) )
        objective_onentity( maps\_utility::obj( "deliver the cargo" ), level.burke );

    common_scripts\utility::flag_wait( "obj_escape_detroit_complete" );
    maps\_utility::objective_complete( maps\_utility::obj( "deliver the cargo" ) );
}

set_completed_objective_flags()
{
    if ( maps\_utility::is_default_start() )
        return;

    var_0 = level.start_point;

    if ( var_0 == "demo_with_itiot" )
        return;

    common_scripts\utility::flag_set( "begin_objectives" );
    common_scripts\utility::flag_set( "obj_acquire_bikes_give" );
    common_scripts\utility::flag_set( "obj_acquire_bikes_pos_bike" );
    common_scripts\utility::flag_set( "obj_acquire_bikes_complete" );
    common_scripts\utility::flag_set( "flag_scanner_doors_open" );
    common_scripts\utility::flag_set( "flag_camp_visibility_04" );
    common_scripts\utility::flag_set( "flag_cg_intro_cin_has_run" );

    if ( var_0 == "mount_bikes" )
        return;

    if ( var_0 == "player_controlled_drive_start" )
        return;

    common_scripts\utility::flag_set( "portal_grp_gate_on" );

    if ( var_0 == "school_begin" )
        return;

    common_scripts\utility::flag_set( "obj_check_school_give" );

    if ( var_0 == "school_interior_start" )
        return;

    common_scripts\utility::flag_set( "obj_check_school_pos_door" );
    common_scripts\utility::flag_set( "obj_check_school_on_burke" );

    if ( var_0 == "school_before_fall" )
        return;

    common_scripts\utility::flag_set( "obj_check_school_complete" );
    common_scripts\utility::flag_set( "obj_reunite_with_burke_give" );
    common_scripts\utility::flag_set( "school_jeep_delete" );

    if ( var_0 == "school_basement" )
        return;

    if ( var_0 == "school_wall_grab" )
        return;

    common_scripts\utility::flag_set( "obj_reunite_with_burke_pos_reunite" );

    if ( var_0 == "alleyway" )
        return;

    common_scripts\utility::flag_set( "obj_reunite_with_burke_complete" );

    if ( var_0 == "office" )
        return;

    common_scripts\utility::flag_set( "obj_rendezvous_joker_pos_office_atrium" );
    common_scripts\utility::flag_set( "obj_rendezvous_joker_pos_office_window" );
    common_scripts\utility::flag_set( "obj_rendezvous_joker_pos_joker" );
    common_scripts\utility::flag_set( "obj_rendezvous_joker_complete" );
    common_scripts\utility::flag_set( "obj_exo_push_give" );

    if ( var_0 == "exo_push" )
        return;

    common_scripts\utility::flag_set( "obj_exo_push_complete" );

    if ( var_0 == "hospital" )
        return;

    common_scripts\utility::flag_set( "obj_capture_doctor_pos_stairs" );
    common_scripts\utility::flag_set( "obj_capture_doctor_pos_2nd_floor" );
    common_scripts\utility::flag_set( "obj_capture_doctor_pos_doctor" );

    if ( var_0 == "hospital_capture_animation" )
        return;

    common_scripts\utility::flag_set( "obj_capture_doctor_complete" );
    common_scripts\utility::flag_set( "obj_escape_detroit_give" );
    common_scripts\utility::flag_set( "obj_escape_detroit_pos_hospital_stairs" );
    common_scripts\utility::flag_set( "obj_escape_detroit_pos_hospital_stairs_top" );
    common_scripts\utility::flag_set( "obj_escape_detroit_pos_sentinel_stairs" );

    if ( var_0 == "sentinel_reveal" )
        return;

    common_scripts\utility::flag_set( "doctor_inside_office_now" );
    common_scripts\utility::flag_set( "obj_escape_detroit_pos_sentinel_doors" );
    common_scripts\utility::flag_set( "obj_escape_detroit_pos_sentinel_reveal" );
    common_scripts\utility::flag_set( "obj_escape_detroit_pos_exit_stairs" );

    if ( var_0 == "exit_drive" )
        return;

    common_scripts\utility::flag_set( "obj_escape_detroit_on_player_bike" );
    common_scripts\utility::flag_set( "obj_escape_detroit_on_player_bike_mount" );
    common_scripts\utility::flag_set( "obj_escape_detroit_on_burke" );

    if ( var_0 == "exit_drive_end" )
        return;
}

setup_team()
{
    level.bones = setup_bones();
    level.joker = setup_joker();
    level.burke = setup_burke();
}

setup_bones()
{
    var_0 = getent( "bones_spawner", "targetname" );
    var_1 = var_0 maps\_shg_design_tools::actual_spawn();
    var_1 thread maps\_utility::deletable_magic_bullet_shield();
    var_1.animname = "bones";
    var_1 maps\_utility::set_force_color( "y" );
    var_1.ignoreall = 1;
    var_1 maps\_utility::forceuseweapon( "iw5_bal27_sp_silencer01_variablereddot", "primary" );
    return var_1;
}

setup_joker()
{
    var_0 = getent( "joker_spawner", "targetname" );
    var_1 = var_0 maps\_shg_design_tools::actual_spawn();
    var_1 thread maps\_utility::deletable_magic_bullet_shield();
    var_1.animname = "joker";
    var_1 maps\_utility::set_force_color( "o" );
    var_1.ignoreall = 1;
    var_1 maps\_utility::forceuseweapon( "iw5_bal27_sp_silencer01_variablereddot", "primary" );
    return var_1;
}

setup_burke()
{
    var_0 = maps\_utility::spawn_targetname( "burke_spawner", 1 );
    var_0 thread maps\_utility::deletable_magic_bullet_shield();
    var_0.animname = "burke";
    var_0 maps\_utility::set_force_color( "r" );
    var_0.ignoreall = 1;
    var_0 maps\_utility::forceuseweapon( "iw5_bal27_sp_silencer01_variablereddot", "primary" );
    return var_0;
}

burke_aggression()
{
    for (;;)
    {
        var_0 = level.burke.ignoreall;

        if ( var_0 == 0 )
            iprintln( "Burke is Active" );

        if ( var_0 == 1 )
            iprintln( "Burke is Passive" );

        wait 0.05;
    }
}

set_patrol_anim_set( var_0, var_1, var_2 )
{
    self.patrol_walk_twitch = undefined;
    self.patrol_walk_anim = undefined;
    self.script_animation = var_0;
    maps\_patrol::set_patrol_run_anim_array();
    self.goalradius = 32;
    self allowedstances( "stand" );
    self.disablearrivals = 1;
    self.disableexits = 1;
    self.allowdeath = 1;
    self.oldcombatmode = self.combatmode;
    self.combatmode = "no_cover";
    maps\_utility::disable_cqbwalk();
    self.patrol_anim_set = var_0;

    if ( isdefined( var_1 ) && var_1 )
    {
        maps\_utility::ent_flag_set( "_stealth_enabled" );
        thread maps\detroit_school::monitor_stealth_flags();
    }
}

start_refugee_camp()
{
    level.player maps\_stealth_utility::stealth_default();
    debug_start_common();
    level.player lightsetforplayer( "detroit_intro_1" );
    maps\_utility::vision_set_fog_changes( "detroit_intro", 0 );
    level.player setclutforplayer( "clut_detroit_level_start_intro", 0 );
    level notify( "vfx_rain_intro" );
    soundscripts\_snd::snd_message( "start_refugee_camp" );
    thread battle_chatter_off_both();
    thread maps\detroit_refugee_camp::setup_motorpool();
    thread maps\detroit_refugee_camp::setup_refugee_camp_soldiers();
    level.player thread maps\_player_exo::player_exo_deactivate();
    opening_movie_function();
    thread maps\detroit_refugee_camp::security_triggers();
    thread maps\detroit_refugee_camp::setup_civs_walkers();
    thread maps\detroit_refugee_camp::tv_movie();
    thread give_regular_grenades();
    thread maps\detroit_lighting::intro_helipad_lights();
    thread maps\detroit_lighting::intro_lighting();
    thread maps\detroit_lighting::intro_dof_physically_based();
    thread maps\detroit_refugee_camp::disable_same_side_blocking();
}

opening_movie_function()
{
    level.player disableweapons();
    level.player freezecontrols( 1 );
    thread maps\_shg_utility::play_chyron_video( "chyron_text_detroit", 2, 2 );
    common_scripts\utility::flag_wait( "chyron_video_done" );
    common_scripts\utility::flag_set( "level_name_intro_done" );
    thread maps\detroit_refugee_camp::opening_start();
    soundscripts\_snd::snd_message( "start_refugee_camp" );
}

debug_start_drive_in()
{
    level.player lightsetforplayer( "detroit_intro" );
    maps\_utility::vision_set_fog_changes( "detroit_camp", 0 );
    level.player setclutforplayer( "clut_detroit_camp", 0 );
    level.player maps\_stealth_utility::stealth_default();
    debug_start_common();
    level notify( "vfx_rain_intro" );
    soundscripts\_snd::snd_message( "start_drive_in" );
    thread battle_chatter_off_both();
    level.playerisonleft = 0;
    thread maps\detroit_refugee_camp::debug_start_bike_ride_in();
    thread give_regular_grenades();
    level.player takeallweapons();
    common_scripts\utility::flag_set( "vo_camp_bike_ready" );
    common_scripts\utility::flag_set( "vo_autopilot_engaged" );
    common_scripts\utility::flag_set( "flag_camp_visibility_03" );
    var_0 = getnode( "player_drive_in_startpoint", "targetname" );
    level.player maps\_utility::teleport_player( var_0 );
    waitframe();
    var_1 = 1;
    thread maps\detroit_refugee_camp::setup_motorpool( var_1 );
}

debug_start_school_begin()
{
    debug_start_common();
    spawn_bikes();
    maps\detroit_school::school_animated_fences();
    soundscripts\_snd::snd_message( "start_school" );
    var_0 = getent( "actual_dismount_animation_origin", "targetname" );
    var_0 thread maps\_anim::anim_first_frame_solo( level.player_bike, "bike_dismount" );
    var_0 thread maps\_anim::anim_first_frame_solo( level.burke_bike, "bike_dismount" );
    var_0 thread maps\_anim::anim_first_frame_solo( level.bones_bike, "bike_dismount" );
    var_0 thread maps\_anim::anim_first_frame_solo( level.joker_bike, "bike_dismount" );
    level.player_bike.world_body = maps\_utility::spawn_anim_model( "world_body" );
    level.player_bike.world_body linkto( level.player_bike, "tag_driver", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.player_bike.world_body setanim( level.player_bike.world_body maps\_utility::getanim( "jetbike_casual_drive_idle" ) );
    thread give_regular_grenades();
    common_scripts\utility::flag_set( "begin_bike_dismount_joker" );
    common_scripts\utility::flag_set( "begin_bike_dismount_bones" );
    common_scripts\utility::flag_set( "begin_bike_dismount_burke" );
    common_scripts\utility::flag_set( "begin_bike_dismount_player" );
    maps\_utility::vision_set_fog_changes( "detroit_garage", 0 );
    level.player lightsetforplayer( "garage" );

    if ( level.nextgen )
    {
        setsaveddvar( "r_mbEnable", "2" );
        setsaveddvar( "r_mbVelocityScalar", "1" );
    }

    wait 0.1;
    level.player takeallweapons();
    level.player giveweapon( "iw5_hbra3_sp_opticstargetenhancer" );
    level.player switchtoweapon( "iw5_hbra3_sp_opticstargetenhancer" );
    thread give_regular_grenades();
}

debug_start_school_interior()
{
    level.player lightsetforplayer( "city_dark" );
    maps\_utility::vision_set_fog_changes( "detroit_city_school", 0 );
    level.player setclutforplayer( "clut_detroit_exterior", 0 );
    level.player maps\_stealth_utility::stealth_default();
    debug_start_common();
    soundscripts\_snd::snd_message( "start_school_interior" );
    level.player maps\_utility::teleport_player( common_scripts\utility::getstruct( "org_start_school_exterior_player_teleport", "targetname" ) );
    thread maps\detroit_school::monitor_flashlight_burke();
    thread maps\detroit_lighting::school_jeep_light_tgl();
    thread maps\detroit_school::setup_school_stealth();
    thread maps\detroit_school::setup_school_bodies();
    thread maps\detroit_school::burke_deadroom_door();
    thread give_regular_grenades();
    thread maps\detroit_school::teleport_burke_to_alley();
    level.player takeallweapons();
    level.player giveweapon( "iw5_hbra3_sp_opticstargetenhancer" );
    level.player switchtoweapon( "iw5_hbra3_sp_opticstargetenhancer" );
    thread give_regular_grenades();
    waitframe();
    common_scripts\utility::flag_set( "vo_school_checkpoint_blue" );
    level.burke maps\_utility::set_moveplaybackrate( 1.5 );
    maps\detroit_school::burke_at_school_door();
    maps\detroit_school::burke_busted_light();
    level notify( "ok_to_start_school" );
    level.burke maps\_utility::set_moveplaybackrate( 1 );
}

debug_start_school_before_fall()
{
    level.player lightsetforplayer( "school_sun" );
    maps\_utility::vision_set_fog_changes( "detroit_school_walk", 0 );
    level.player setclutforplayer( "clut_detroit_interior", 0 );
    level.player maps\_stealth_utility::stealth_default();
    debug_start_common();
    thread give_regular_grenades();
    soundscripts\_snd::snd_message( "start_school_before_fall" );
    var_0 = getnode( "test_burkespot", "targetname" );
    var_1 = var_0 common_scripts\utility::spawn_tag_origin();
    var_1.origin = var_1 maps\_shg_design_tools::offset_position_from_tag( "backward", "tag_origin", 100 );
    level.player maps\_utility::teleport_player( var_1 );
    var_1 delete();

    while ( !isdefined( level.burke ) )
        waitframe();

    thread maps\detroit_school::setup_school_stealth();
    wait 0.1;
    common_scripts\utility::flag_clear( "lightning_on" );
    common_scripts\utility::flag_clear( "lightning_on" );
    thread maps\detroit_school::begin_the_shimmey_for_burke();
    level.player takeallweapons();
    level.player giveweapon( "iw5_hbra3_sp_opticstargetenhancer" );
    level.player switchtoweapon( "iw5_hbra3_sp_opticstargetenhancer" );
    thread give_regular_grenades();
}

debug_start_school_basement()
{
    level.player lightsetforplayer( "school" );
    maps\_utility::vision_set_fog_changes( "detroit_school_basement", 0 );
    level.player setclutforplayer( "clut_detroit_basement", 0 );
    level.player maps\_stealth_utility::stealth_default();
    debug_start_common();
    level.player setmovespeedscale( 0.6 );
    soundscripts\_snd::snd_message( "start_school_basement" );
    wait 0.05;
    thread maps\detroit_school::setup_school_stealth();
    wait 0.1;
    common_scripts\utility::flag_clear( "lightning_on" );
    level.player allowsprint( 0 );
    level.player takeallweapons();
    level.player thread handle_unarmed_viewbob();
    level.player giveweapon( "iw5_titan45_sp" );
    level.player switchtoweapon( "iw5_titan45_sp" );
    level.player setweaponammostock( "iw5_titan45_sp", 0 );
    level.player setweaponammoclip( "iw5_titan45_sp", 1 );
    level.player maps\_utility::teleport_player( common_scripts\utility::getstruct( "org_checkpoint_basement_start", "targetname" ) );
    thread maps\detroit_lighting::toggle_lighting_spot01_on_checkpoint();
    thread maps\detroit_lighting::basement_fog_checkpoint();
    thread maps\detroit_school::remove_unarmed_when_pickup_new_wep();
    common_scripts\utility::flag_set( "basement_string_objectives" );
}

debug_start_school_wall_grab()
{
    level.player lightsetforplayer( "school" );
    level.player setclutforplayer( "clut_detroit_interior", 0 );
    maps\_utility::vision_set_fog_changes( "detroit_school", 0 );
    level.player maps\_stealth_utility::stealth_default();
    debug_start_common();
    soundscripts\_snd::snd_message( "start_school_wall_grab" );
    var_0 = getnode( "guy2_hide_spot", "targetname" );
    level.player maps\_utility::teleport_player( var_0 );
    thread maps\detroit_school::setup_school_stealth();
    waittillframeend;
    level.player allowsprint( 0 );
    level.player takeallweapons();
    level.player thread handle_unarmed_viewbob();
    level.player giveweapon( "iw5_titan45_sp" );
    level.player switchtoweapon( "iw5_titan45_sp" );
    level.player setweaponammostock( "iw5_titan45_sp", 0 );
    level.player setweaponammoclip( "iw5_titan45_sp", 1 );
    wait 0.1;
    common_scripts\utility::flag_clear( "lightning_on" );
    thread maps\detroit_lighting::toggle_lighting_spot01_on_checkpoint();
    thread battle_chatter_off_both();
}

schoolfall_start()
{
    debug_start_common();
    level.player lightsetforplayer( "city" );
    maps\_utility::vision_set_fog_changes( "detroit_city", 0 );
    var_0 = getnode( "school_fall_start", "targetname" );
    wait 0.05;
    maps\_utility::teleport_player( var_0 );
}

handle_unarmed_viewbob()
{
    level.player endon( "death" );
    var_0 = getdvar( "bg_viewBobAmplitudeStanding" );
    var_1 = getdvar( "bg_viewBobAmplitudeDucked" );
    var_2 = getdvar( "bg_viewBobMax" );
    waitframe();
    setsaveddvar( "bg_viewBobAmplitudeStanding", "0.005 0.01" );
    setsaveddvar( "bg_viewBobAmplitudeDucked", "0.002 0.005" );
    setsaveddvar( "bg_viewBobMax", 3 );
    level.player setbobrate( 0.8 );
    level common_scripts\utility::waittill_any( "player_no_longer_unarmed", "weapon_take_no_longer_needed" );
    setsaveddvar( "bg_viewBobAmplitudeStanding", var_0 );
    setsaveddvar( "bg_viewBobAmplitudeDucked", var_1 );
    setsaveddvar( "bg_viewBobMax", var_2 );
    level.player setbobrate( 1 );
}

debug_start_alleyway()
{
    level.player lightsetforplayer( "city" );
    maps\_utility::vision_set_fog_changes( "detroit_city", 0 );
    level.player setclutforplayer( "clut_detroit_interior", 0 );
    level.player maps\_stealth_utility::stealth_default();
    debug_start_common();
    soundscripts\_snd::snd_message( "start_alleyway" );
    street1_teleportplayer();
    street1_ingame();
    level.player takeallweapons();
    level.player giveweapon( "iw5_hbra3_sp_opticstargetenhancer" );
    level.player switchtoweapon( "iw5_hbra3_sp_opticstargetenhancer" );
    thread give_regular_grenades();
    var_0 = getglass( "burke_street_glass" );
    destroyglass( var_0 );
}

give_regular_grenades( var_0 )
{
    if ( isdefined( var_0 ) )
        wait(var_0);

    maps\_variable_grenade::give_player_variable_grenade();
}

debug_start_nightclub()
{
    level.player lightsetforplayer( "club" );
    maps\_utility::vision_set_fog_changes( "detroit_club", 0 );
    level.player setclutforplayer( "clut_detroit_exterior", 0 );
    debug_start_common();
    level.burke maps\_utility::enable_careful();
    soundscripts\_snd::snd_message( "start_office" );
    var_0 = getnode( "player_nightclub_start_inside", "targetname" );
    level.player maps\_utility::teleport_player( var_0 );
    wait 0.05;
    var_1 = getnode( "burke_path_onfoot_01a", "targetname" );
    level.burke maps\_utility::teleport_ai( var_1 );
    var_2 = getnode( "burke_path_onfoot_01a", "targetname" );
    level.burke setgoalnode( var_2 );
    level.player takeallweapons();
    level.player giveweapon( "iw5_hbra3_sp_opticstargetenhancer" );
    level.player switchtoweapon( "iw5_hbra3_sp_opticstargetenhancer" );
    thread give_regular_grenades();
    level.burke.ignoreall = 0;
}

debug_start_exopush()
{
    level.player lightsetforplayer( "city" );
    maps\_utility::vision_set_fog_changes( "detroit_city_far_fog", 0 );
    level.player setclutforplayer( "clut_detroit_exterior", 0 );
    debug_start_common();
    soundscripts\_snd::snd_message( "start_exopush" );
    thread give_regular_grenades();
    var_0 = getnode( "player_exo_push_startnode", "targetname" );
    var_1 = getnode( "burke_exo_push_startnode", "targetname" );
    var_2 = getnode( "bones_supressed_outside_node", "targetname" );
    var_3 = getnode( "joker_supressed_outside_node", "targetname" );
    level.burke maps\_utility::teleport_ai( var_1 );
    level.bones maps\_utility::teleport_ai( var_2 );
    level.joker maps\_utility::teleport_ai( var_3 );
    level.player maps\_utility::teleport_player( var_0 );
    level.player takeallweapons();
    level.player giveweapon( "iw5_hbra3_sp_opticstargetenhancer" );
    level.player switchtoweapon( "iw5_hbra3_sp_opticstargetenhancer" );
    thread maps\detroit_streets::preplaced_guys_function();
    thread maps\detroit_streets::begin_exo_push( 1 );
    thread maps\detroit_streets::exo_push_combat_manager();
    thread maps\detroit_streets::new_kva_window_ambush();
    waitframe();
    common_scripts\utility::flag_set( "exo_push_spawner_scaffolding_trigger" );
    common_scripts\utility::flag_set( "vo_exo_push_start" );
    common_scripts\utility::flag_set( "flicker_street_lights" );
    common_scripts\utility::flag_set( "begin_spawning_troops_hospital" );
}

debug_start_hospital()
{
    maps\_utility::vision_set_fog_changes( "detroit_city_far_fog", 0 );
    level.player lightsetforplayer( "city" );
    level.player setclutforplayer( "clut_detroit_exterior", 0 );
    debug_start_common();
    common_scripts\utility::flag_set( "exo_push_arrived" );
    soundscripts\_snd::snd_message( "start_hospital" );
    level.player takeallweapons();
    level.player giveweapon( "iw5_hbra3_sp_opticstargetenhancer" );
    level.player switchtoweapon( "iw5_hbra3_sp_opticstargetenhancer" );
    thread give_regular_grenades();
    var_0 = getnode( "player_hospital_start", "targetname" );
    var_1 = getnode( "burke_hospital", "targetname" );
    var_2 = getnode( "joker_hospital", "targetname" );
    var_3 = getnode( "bones_hospital", "targetname" );
    wait 0.05;
    level.burke thread maps\_utility::teleport_ai( var_1 );
    level.joker thread maps\_utility::teleport_ai( var_2 );
    level.bones thread maps\_utility::teleport_ai( var_3 );
    level.player thread maps\_utility::teleport_player( var_0 );
    level.burke.ignoreall = 1;
    level.bones.ignoreall = 1;
    level.joker.ignoreall = 1;
    thread maps\detroit_hospital::setup_hospital();
    maps\_utility::activate_trigger_with_targetname( "team_move_hospital" );
}

debug_start_hospital_capture()
{
    debug_start_common();
    soundscripts\_snd::snd_message( "start_hospital_capture_animation" );
    maps\_utility::vision_set_fog_changes( "detroit_hospital_top", 0 );
    level.player lightsetforplayer( "hospital" );
    level.player takeallweapons();
    level.player giveweapon( "iw5_hbra3_sp_opticstargetenhancer" );
    level.player switchtoweapon( "iw5_hbra3_sp_opticstargetenhancer" );
    thread give_regular_grenades();
    var_0 = getnode( "hide_node_2", "targetname" );
    var_1 = getnode( "burke_spot_3_hospital", "targetname" );
    var_2 = getnode( "joker_spot_3_hospital", "targetname" );
    var_3 = getnode( "bones_spot_3_hospital", "targetname" );
    wait 0.05;
    common_scripts\utility::flag_set( "obj_capture_doctor_pos_stairs" );
    common_scripts\utility::flag_set( "obj_capture_doctor_pos_2nd_floor" );
    common_scripts\utility::flag_set( "obj_capture_doctor_pos_doctor" );
    common_scripts\utility::flag_set( "doctor_inside_office_now" );
    level.burke thread maps\_utility::teleport_ai( var_1 );
    level.joker thread maps\_utility::teleport_ai( var_2 );
    level.bones thread maps\_utility::teleport_ai( var_3 );
    level.player thread maps\_utility::teleport_player( var_0 );
    level.burke.ignoreall = 1;
    level.bones.ignoreall = 1;
    level.joker.ignoreall = 1;
    wait 0.5;
    thread maps\detroit_hospital::doctor_capture_new_breach_doctor_takedown();
}

debug_start_sentinel_reveal()
{
    maps\_utility::vision_set_fog_changes( "detroit_city_top", 0 );
    level.player lightsetforplayer( "city_dark" );
    level.player setclutforplayer( "clut_detroit_hospital", 0 );
    debug_start_common();
    soundscripts\_snd::snd_message( "start_sentinel_reveal" );
    level.player takeallweapons();
    level.player giveweapon( "iw5_hbra3_sp_opticstargetenhancer" );
    level.player switchtoweapon( "iw5_hbra3_sp_opticstargetenhancer" );
    thread give_regular_grenades();
    var_0 = getnode( "player_sentinel_start", "targetname" );
    var_1 = getnode( "burke_post_before_sentinel_room", "targetname" );
    var_2 = getnode( "joker_spot_3_hospital", "targetname" );
    var_3 = getnode( "bones_spot_3_hospital", "targetname" );
    var_4 = getnode( "bones_guard_doctor_node", "targetname" );
    var_5 = getnode( "joker_and_doctor_debug_node", "targetname" );
    var_6 = getnode( "joker_escape_location", "targetname" );
    wait 0.05;
    level.burke thread maps\_utility::teleport_ai( var_1 );
    level.joker thread maps\_utility::teleport_ai( var_2 );
    level.bones thread maps\_utility::teleport_ai( var_3 );
    level.player thread maps\_utility::teleport_player( var_0 );
    spawn_doctor();
    level.doctor thread maps\detroit_hospital::mission_fail_on_dead();
    level.burke.ignoreall = 1;
    level.bones.ignoreall = 1;
    level.joker.ignoreall = 1;
    common_scripts\utility::flag_set( "obj_capture_doctor_pos_stairs" );
    common_scripts\utility::flag_set( "obj_capture_doctor_pos_2nd_floor" );
    common_scripts\utility::flag_set( "obj_capture_doctor_pos_doctor" );
    common_scripts\utility::flag_set( "doctor_inside_office_now" );
    common_scripts\utility::flag_set( "obj_capture_doctor_pos_doctor_breached" );
    common_scripts\utility::flag_set( "send_burke_to_stairs_waitpoint" );
    common_scripts\utility::flag_set( "send_burke_to_railway_half" );
    common_scripts\utility::flag_set( "send_burke_fully_across" );
    common_scripts\utility::flag_set( "make_burke_anim_reach_sentinel" );
    common_scripts\utility::flag_set( "let_burke_reach_sentinel_reveal" );
    common_scripts\utility::flag_set( "capture_start" );
    common_scripts\utility::flag_set( "obj_capture_doctor_complete" );
    common_scripts\utility::flag_set( "obj_escape_detroit_give" );
    wait 0.5;
    thread maps\detroit_hospital::burke_pre_sentinel_kva_reveal();
    level.bones setgoalnode( var_4 );
    thread maps\detroit_lighting::jetbike_exit_pre_mount_lighting();
    common_scripts\utility::flag_set( "start_exit_trains" );
    var_7 = getent( "breach_clip", "targetname" );
    var_7 delete();
    var_8 = getent( "dr_pickup_placed_org", "targetname" );
    var_9 = getnode( "joker_with_doctor_waitnode", "targetname" );
    maps\detroit_hospital::doctor_capture_doctor_carry( var_8, "reveal_the_sentinels", var_9 );
}

debug_start_exit_drive()
{
    level.player lightsetforplayer( "city" );
    maps\_utility::vision_set_fog_changes( "detroit_city_fog_close", 0 );
    level.player setclutforplayer( "clut_detroit_exterior", 0 );
    debug_start_common();
    level.player takeallweapons();
    level.player giveweapon( "iw5_hbra3_sp_opticstargetenhancer" );
    level.player switchtoweapon( "iw5_hbra3_sp_opticstargetenhancer" );
    thread give_regular_grenades();
    soundscripts\_snd::snd_message( "start_exit_drive" );
    var_0 = getent( "player_spawn_exitdrive", "targetname" );
    var_1 = getent( "burke_spawn_exitdrive", "targetname" );
    var_2 = getent( "joker_spawn_exitdrive", "targetname" );
    var_3 = getent( "bones_spawn_exitdrive", "targetname" );
    wait 0.05;
    level.burke thread maps\_utility::teleport_ent( var_1 );
    level.joker thread maps\_utility::teleport_ent( var_2 );
    level.bones thread maps\_utility::teleport_ent( var_3 );
    level.player thread maps\_utility::teleport_player( var_0 );
    spawn_doctor();
    thread maps\detroit_lighting::jetbike_exit_pre_mount_lighting();
    common_scripts\utility::flag_set( "obj_capture_doctor_pos_stairs" );
    common_scripts\utility::flag_set( "obj_capture_doctor_pos_2nd_floor" );
    common_scripts\utility::flag_set( "obj_capture_doctor_pos_doctor" );
    common_scripts\utility::flag_set( "doctor_inside_office_now" );
    common_scripts\utility::flag_set( "obj_capture_doctor_pos_doctor_breached" );
    common_scripts\utility::flag_set( "send_burke_to_stairs_waitpoint" );
    common_scripts\utility::flag_set( "send_burke_to_railway_half" );
    common_scripts\utility::flag_set( "send_burke_fully_across" );
    common_scripts\utility::flag_set( "make_burke_anim_reach_sentinel" );
    common_scripts\utility::flag_set( "let_burke_reach_sentinel_reveal" );
    common_scripts\utility::flag_set( "capture_start" );
    common_scripts\utility::flag_set( "obj_capture_doctor_complete" );
    common_scripts\utility::flag_set( "obj_escape_detroit_give" );
    common_scripts\utility::flag_set( "onfoot_segment_complete" );
    common_scripts\utility::flag_set( "exit_drive_cinematic_start" );
}

debug_start_exit_drive_end()
{
    level.player lightsetforplayer( "jetbike_gate" );
    maps\_utility::vision_set_fog_changes( "detroit_jetbike_end", 0 );
    level.player setclutforplayer( "clut_detroit_exterior", 0 );
    debug_start_common();
    common_scripts\utility::flag_set( "onfoot_segment_complete" );
    common_scripts\utility::flag_set( "exit_drive_cinematic_start" );
    level.final_scripted_chopper = maps\_vehicle::spawn_vehicle_from_targetname( "exitdrive_chopper_final" );
    spawn_doctor();
    common_scripts\utility::flag_set( "exit_drive_started" );
    common_scripts\utility::flag_set( "exitdrive_ending_approach" );
    waittillframeend;
    level.jetbike attach( level.scr_model["world_body"], "tag_driver" );
    level.player mountvehicle( level.jetbike );
    common_scripts\utility::flag_set( "exit_drive_ending_begin_player" );

    if ( level.nextgen )
        setsaveddvar( "r_mbEnable", "2" );
}

debug_start_demo_with_itiot()
{
    thread itiot_logic( "obj_reunite_with_burke_give", "school_wall_grab" );

    if ( isdefined( level.introscreen ) && isdefined( level.introscreen.customfunc ) )
        thread [[ level.introscreen.customfunc ]]();

    start_refugee_camp();
}

gideon_turntable_demo()
{
    level.player lerpfov( 50, 1 );
    level.player.auxillary_hud = newclienthudelem( level.player );
    level.player.auxillary_hud setshader( "black", 1280, 720 );
    level.player.auxillary_hud.horzalign = "fullscreen";
    level.player.auxillary_hud.vertalign = "fullscreen";
    level.player.auxillary_hud.alpha = 0;
    level.player.auxillary_hud.alpha = 1;
    level.player.auxillary_hud.foreground = 1;
    level.player lerpfov( 50, 1 );
    level.player maps\_shg_utility::setup_player_for_scene();
    var_0 = getent( "burke_turntable_animorg", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "world_body" );
    level.burke = maps\_utility::spawn_targetname( "burke_spawner", 1 );
    level.burke.animname = "burke";
    level.burke maps\_utility::forceuseweapon( "iw5_bal27_sp_silencer01_variablereddot", "primary" );
    level.player playerlinktodelta( var_1, "tag_player", 1, 0, 0, 0, 0, 1 );
    var_0 thread maps\_anim::anim_loop_solo( level.burke, "burke_turntable" );
    var_0 thread maps\_anim::anim_loop_solo( var_1, "player_turntable" );
    setsaveddvar( "objectiveHide", "1" );
    setsaveddvar( "g_friendlyNameDist", 0 );

    if ( level.nextgen )
    {
        setsaveddvar( "r_dof_physical_bokehEnable", 1 );
        setsaveddvar( "r_mbEnable", "2" );
    }

    wait 0.5;
    level.player.auxillary_hud.alpha = 1;
    level.player.auxillary_hud fadeovertime( 0.5 );
    level.player.auxillary_hud.alpha = 0;
    level.player.auxillary_hud.foreground = 0;
}

debug_start_common()
{
    setup_team();
}

street1_teleportplayer()
{
    level.player lightsetforplayer( "city" );
    maps\_utility::vision_set_fog_changes( "detroit_city_fog", 0 );
    var_0 = getent( "player_start_school_ext", "targetname" );
    level.player maps\_utility::teleport_player( var_0 );
}

street1_ingame()
{
    thread maps\detroit_streets::onfoot_start_alley_setup();
}

hasmat_kva_move_in()
{
    var_0 = getent( "bridge_mid_vol", "targetname" );

    foreach ( var_2 in level.bridge_kva_hasmat )
    {
        if ( isalive( var_2 ) )
            var_2 setgoalvolumeauto( var_0 );

        wait 0.05;
    }
}

setup_cleanup_vehicle()
{
    self.sirentag = common_scripts\utility::spawn_tag_origin();
    self.sirentag.origin = self.origin + ( 0, 0, 96 );
    self.sirentag linkto( self, "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "caution_light_01" ), self.sirentag, "tag_origin" );
    self waittill( "death" );
    stopfxontag( common_scripts\utility::getfx( "caution_light_01" ), self.sirentag, "tag_origin" );
}

burke_advance()
{
    maps\_utility::trigger_wait_targetname( "Burke_nightclub_advance" );
    var_0 = getnode( "burke_advanced", "targetname" );
    level.burke setgoalnode( var_0 );
    wait 6;

    if ( common_scripts\utility::flag( "burke_nightclub_advance" ) )
        return;
    else
    {
        var_0 = getnode( "burke_advanced_2", "targetname" );
        level.burke setgoalnode( var_0 );
    }
}

spawn_guy_and_firstframe( var_0, var_1, var_2, var_3 )
{
    var_4 = var_1 maps\_utility::spawn_ai( 1 );
    var_4.animname = "generic";
    var_4 teleport( var_0.origin, var_0.angles );
    var_4 thread maps\_anim::anim_generic_first_frame( var_4, var_0.animation );

    if ( !isdefined( var_2 ) )
        return var_4;

    var_4 thread play_anim_on_trigger( var_0.animation, var_2, var_3 );
    return var_4;
}

play_anim_on_trigger( var_0, var_1, var_2 )
{
    maps\_shg_design_tools::waittill_trigger_with_name( var_1 );

    if ( isdefined( var_2 ) )
        wait(var_2);

    thread maps\_anim::anim_generic( self, var_0 );
    level notify( "scripted_anim_begun" );
}

form_patrol_group( var_0 )
{
    foreach ( var_2 in var_0 )
        var_2 thread monitor_alerted( var_0 );
}

monitor_alerted( var_0 )
{
    common_scripts\utility::waittill_any( "alert", "damage", "death" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) && var_2 != self )
            var_2 notify( "alert" );
    }
}

delete_me_in( var_0 )
{
    wait(var_0);
    self delete();
}

delete_this_on_death( var_0 )
{
    self waittill( "death" );
    var_0 delete();
}

setup_player()
{
    if ( !level.give_player_flashlight )
        return;
}

force_patrol_anim_set( var_0, var_1, var_2 )
{
    maps\_patrol_extended::force_patrol_anim_set( var_0, var_1, 0, var_2 );
}

disable_grenades()
{
    if ( isdefined( self.grenadeammo ) && !isdefined( self.oldgrenadeammo ) )
        self.oldgrenadeammo = self.grenadeammo;

    self.grenadeammo = 0;
}

enable_grenades()
{
    if ( isdefined( self.oldgrenadeammo ) )
    {
        self.grenadeammo = self.oldgrenadeammo;
        self.oldgrenadeammo = undefined;
    }
}

goto_node( var_0, var_1, var_2 )
{
    self endon( "stop_goto_node" );

    if ( !isdefined( var_2 ) )
        var_2 = 16;

    maps\_utility::set_goal_radius( var_2 );

    if ( isstring( var_0 ) )
        var_3 = getnode( var_0, "script_noteworthy" );
    else
        var_3 = var_0;

    if ( isdefined( var_3 ) )
        maps\_utility::set_goal_node( var_3 );
    else
    {
        var_3 = common_scripts\utility::getstruct( var_0, "script_noteworthy" );
        maps\_utility::set_goal_pos( var_3.origin );
    }

    if ( var_1 )
        self waittill( "goal" );
}

setup_portal_scripting()
{
    if ( level.start_point != "exit_drive_end" )
        thread maps\_shg_utility::portal_group_on( "portal_grp_gate_on", "portal_grp_gate" );
}

bloody_death( var_0 )
{
    self endon( "death" );

    if ( !issentient( self ) || !isalive( self ) )
        return;

    if ( isdefined( self.bloody_death ) && self.bloody_death )
        return;

    self.bloody_death = 1;

    if ( isdefined( var_0 ) )
        wait(randomfloat( var_0 ));

    var_1 = [];
    var_1[0] = "j_hip_le";
    var_1[1] = "j_hip_ri";
    var_1[2] = "j_head";
    var_1[3] = "j_spine4";
    var_1[4] = "j_elbow_le";
    var_1[5] = "j_elbow_ri";
    var_1[6] = "j_clavicle_le";
    var_1[7] = "j_clavicle_ri";

    for ( var_2 = 0; var_2 < 3 + randomint( 5 ); var_2++ )
    {
        var_3 = randomintrange( 0, var_1.size );
        thread bloody_death_fx( var_1[var_3], undefined );
        wait(randomfloat( 0.1 ));
    }

    self dodamage( self.health + 50, self.origin );
}

bloody_death_fx( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = level._effect["flesh_hit"];

    playfxontag( var_1, self, var_0 );
}

battle_chatter_on_both()
{
    level endon( "kill_battle_silence" );
    var_0 = 0;
    level notify( "kill_battle_chatter" );
    maps\_utility::battlechatter_on( "allies" );
    maps\_utility::battlechatter_on( "axis" );

    while ( var_0 == 1 )
        wait 0.05;
}

battle_chatter_off_both()
{
    level endon( "kill_battle_chatter" );
    var_0 = 0;
    level notify( "kill_battle_silence" );
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );

    while ( var_0 == 1 )
        wait 0.05;
}

hud_off()
{
    setsaveddvar( "compass", "0" );
    setsaveddvar( "ammoCounterHide", "1" );
    setsaveddvar( "hud_showstance", "0" );
    setsaveddvar( "actionSlotsHide", "1" );
}

hud_on()
{
    setsaveddvar( "compass", "1" );
    setsaveddvar( "ammoCounterHide", "0" );
    setsaveddvar( "hud_showstance", "1" );
    setsaveddvar( "actionSlotsHide", "0" );
}

player_health_current()
{
    level.player endon( "death" );
    var_0 = 0;

    while ( var_0 == 1 )
        wait 0.05;
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
    level.player disableweapons();
    level.player.auxillary_hud.foreground = 0;
    wait 7;
    var_2 = getnode( "guy2_hide_spot", "targetname" );
    level.player maps\_utility::teleport_player( var_2 );
    soundscripts\_snd::snd_message( "e3_demo_clear_basement_footsteps" );
    soundscripts\_snd::snd_message( "e3_demo_fade_in" );
    level.player.auxillary_hud.alpha = 1;
    level.player.auxillary_hud fadeovertime( 0.5 );
    level.player.auxillary_hud.alpha = 0;
    level.player.auxillary_hud.foreground = 0;
    setsaveddvar( "objectiveHide", "0" );
    level.player enableweapons();
    level.player allowsprint( 0 );
    level.player takeallweapons();
    level.player giveweapon( "iw5_titan45_sp" );
    level.player switchtoweapon( "iw5_titan45_sp" );
    level.player setweaponammostock( "iw5_titan45_sp", 0 );
    level.player setweaponammoclip( "iw5_titan45_sp", 1 );
}

controller_rumble_heavy0()
{
    level.player playrumbleonentity( "damage_heavy" );
}

controller_rumble_heavy1()
{
    level.player playrumbleonentity( "heavy_1s" );
}

controller_rumble_heavy2()
{
    level.player playrumbleonentity( "heavy_2s" );
}

controller_rumble_heavy3()
{
    level.player playrumbleonentity( "heavy_3s" );
}

controller_rumble_light0()
{
    level.player playrumbleonentity( "damage_light" );
}

controller_rumble_light1()
{
    level.player playrumbleonentity( "light_1s" );
}

controller_rumble_light2()
{
    level.player playrumbleonentity( "light_2s" );
}

controller_rumble_light3()
{
    level.player playrumbleonentity( "light_3s" );
}

spawn_doctor()
{
    var_0 = getent( "doctor_kva", "targetname" );
    var_0.count = 1;
    level.doctor = var_0 maps\_utility::spawn_ai( 1, 1 );
    waitframe();
    level.doctor.ignoresonicaoe = 1;
    level.doctor.animname = "doctor";
    level.doctor.name = "Doctor";
    level.doctor maps\_utility::disable_surprise();
    level.doctor maps\_utility::disable_pain();
    level.doctor maps\_utility::disable_bulletwhizbyreaction();
    level.doctor setlookattext( "Doctor", &"" );
}
