// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    if ( level.nextgen )
        anim.forced_s1_motionset = 1;

    generic_human();
    civilian_anims();
    player_anims();
    ally_anims();
    animated_prop_anims();
    vehicle_anims();
    script_model_anims();
}

#using_animtree("generic_human");

generic_human()
{
    level.scr_anim["cormack"]["briefing_start"] = %ie_briefing_start_cormack;
    level.scr_anim["ilana"]["briefing_start"] = %ie_briefing_start_ilona;
    level.scr_anim["knox"]["briefing_start"] = %ie_briefing_start_knox;
    level.scr_anim["worker1"]["briefing_start_worker1"] = %ie_briefing_start_worker1;
    level.scr_anim["worker2"]["briefing_start_worker2"] = %ie_briefing_start_worker2;
    level.scr_anim["worker3"]["briefing_start_worker3"] = %ie_briefing_start_worker3;
    level.scr_anim["worker4"]["briefing_start_worker4"] = %ie_briefing_start_worker4;
    level.scr_anim["worker5"]["briefing_start_worker5"] = %ie_briefing_start_worker5;
    level.scr_anim["generic"]["_stealth_look_around_upward"][0] = %ie_stealth_alerted;
    level.scr_anim["generic"]["CQB_stand_wave_on_me_generic"] = %cqb_stand_wave_on_me;
    level.scr_anim["knox"]["ie_intro_idle"] = %ie_intro_idle_ally_3;
    level.scr_anim["cormack"]["ie_intro_ally"] = %ie_intro_ally_1;
    maps\_anim::addnotetrack_notify( "cormack", "ready_hooks", "ready_hooks", "ie_intro_ally" );
    level.scr_anim["ilana"]["ie_intro_ally"] = %ie_intro_ally_2;
    level.scr_anim["knox"]["ie_intro_ally"] = %ie_intro_ally_3;
    level.scr_anim["cormack"]["ie_intro_grapple_start"] = %ie_intro_grapple_start_ally_1;
    level.scr_anim["ilana"]["ie_intro_grapple_start"] = %ie_intro_grapple_start_ally_2;
    level.scr_anim["knox"]["ie_intro_grapple_start"] = %ie_intro_grapple_start_ally_3;
    level.scr_anim["doctor"]["doctor_walk"][0] = %det_casual_walk_slow_burke;
    level.scr_anim["generic"]["doctor_walk"][0] = %det_casual_walk_slow_burke;
    level.scr_anim["generic"]["casual_walk"][0] = %det_casual_walk_slow_cormack;
    level.scr_anim["generic"]["casual_walk_idle"][0] = %casual_stand_idle;
    level.scr_anim["cormack"]["recon_enter"] = %ie_recon_enter_cormack;
    level.scr_anim["ilana"]["recon_enter"] = %ie_recon_enter_ilona;
    level.scr_anim["knox"]["recon_enter"] = %ie_recon_enter_knox;
    level.scr_anim["knox"]["recon_idle"][0] = %ie_recon_knox_idle;
    level.scr_anim["knox"]["recon_exit"] = %ie_recon_exit_knox;
    level.scr_anim["knox"]["recon_exit_idle"][0] = %ie_recon_exit_knox_idle;
    level.scr_anim["generic"]["stealth_display_tutorial_enemy_1"] = %ie_stealth_meter_guard_1;
    level.scr_anim["generic"]["stealth_display_tutorial_enemy_2"] = %ie_stealth_meter_guard_2;
    level.scr_anim["generic"]["stealth_display_tutorial_enemy_3"] = %ie_stealth_meter_guard_3;
    level.scr_anim["generic"]["ie_stealth_meter_guard_idle"][0] = %ie_stealth_meter_idle_guard_3;
    level.scr_anim["generic"]["ie_stealth_meter_guard_react"] = %ie_stealth_meter_react_guard_3;
    level.scr_anim["generic"]["patrol_unarmed_idle"][0] = %patrol_unarmed_idle;
    level.scr_anim["generic"]["ie_frontyard_garden_wander_enemy1"] = %ie_frontyard_garden_wander_enemy1;
    level.scr_anim["ilana"]["takedown_idle"][0] = %casual_crouch_idle;
    level.scr_anim["ilana"]["penthouse_balcony_enter"] = %ie_pent_balcony_enter_ilona;
    level.scr_anim["ilana"]["open_balcony_door"] = %cqb_stand_wave_on_me;
    level.scr_anim["ilana"]["pent_enter"] = %ie_pent_enter_ilona;
    level.scr_anim["ilana"]["pent_stair_idle"][0] = %ie_pent_stair_idle_ilona;
    level.scr_anim["ilana"]["pent_desk_enter"] = %ie_pent_desk_enter_ilona;
    level.scr_anim["ilana"]["pent_desk_loop"][0] = %ie_pent_desk_loop_ilona;
    level.scr_anim["ilana"]["pent_desk_exit"] = %ie_pent_desk_exit_ilona;
    level.scr_anim["ilana"]["capture_idle"][0] = %ie_pent_capture_idle_ilona;
    level.scr_anim["ilana"]["capture"] = %ie_pent_capture_exit_ilona;
    level.scr_anim["ilana"]["ambush_idle"][0] = %ie_pent_ambush_idle_ilona;
    level.scr_anim["ilana"]["ambush"] = %ie_pent_ambush_ilona;
    level.scr_anim["ilana"]["pent_exit"] = %ie_pent_exit_ilona;
    level.scr_anim["ilana"]["pent_exit_idle"][0] = %ie_pent_exit_ilona_idle;
    level.scr_anim["assistant"]["capture"] = %ie_pent_capture_asst;
    level.scr_anim["assistant"]["capture_fail"] = %ie_pent_capture_fail_asst;
    level.scr_anim["penthouse_enemy_1"]["ambush"] = %ie_pent_ambush_enemy_1;
    level.scr_anim["penthouse_enemy_2"]["ambush"] = %ie_pent_ambush_enemy_2;
    level.scr_anim["penthouse_enemy_3"]["ambush"] = %ie_pent_ambush_enemy_3;
    level.scr_anim["penthouse_enemy_4"]["ambush"] = %ie_pent_ambush_enemy_4;
    level.scr_anim["penthouse_enemy_5"]["ambush"] = %ie_pent_ambush_enemy_5;
    level.scr_anim["penthouse_enemy_6"]["ambush"] = %ie_pent_ambush_enemy_6;
    level.scr_anim["assistant"]["human_shield_idle"][0] = %ie_pent_hostage_idle_asst;
    level.scr_anim["assistant"]["human_shield_run"][0] = %ie_pent_hostage_walk_asst;
    level.scr_anim["cormack"]["guardhouse_traversal"] = %ie_guardhouse_traversal_cormack;
    level.scr_anim["cormack"]["guardhouse_enter"] = %ie_guardhouse_enter_cormack;
    level.scr_anim["cormack"]["guardhouse_idle"][0] = %ie_guardhouse_aim_cormack_loop;
    level.scr_anim["generic"]["guardhouse_idle_generic"][0] = %ie_guardhouse_enter_enemy1_idle;
    level.scr_anim["guardhouse_cormack_guy"]["guardhouse_idle"][0] = %ie_guardhouse_enter_enemy2_idle;
    level.scr_anim["cormack"]["guardhouse_shoot"] = %ie_guardhouse_shoot_cormack;
    level.scr_anim["guardhouse_player_guy"]["guardhouse_shoot"] = %ie_guardhouse_shoot_enemy1;
    level.scr_anim["guardhouse_cormack_guy"]["guardhouse_shoot"] = %ie_guardhouse_shoot_enemy2;
    level.scr_anim["cormack"]["guardhouse_exit_enter"] = %ie_car_ride_approach_cormack;
    level.scr_anim["cormack"]["guardhouse_exit_idle"][0] = %ie_car_ride_approach_cormack_idle;
    level.scr_anim["doctor"]["car_ride_enter"] = %ie_car_ride_enter_kva;
    level.scr_anim["doctor"]["car_ride_enter_idle"][0] = %ie_car_ride_enter_kva_idle;
    level.scr_anim["doctor"]["car_ride_driving"] = %ie_car_ride_driving_kva;
    level.scr_anim["generic"]["lag_lobby_exit_elevator_react_guy1"] = %lag_lobby_exit_elevator_react_guy1;
    level.scr_anim["generic"]["lag_lobby_exit_elevator_react_guy2"] = %lag_lobby_exit_elevator_react_guy2;
    level.scr_anim["generic"]["breach_idle"][0] = %casual_stand_idle;
    level.scr_anim["generic"]["breach_idle"][1] = %casual_stand_idle_twitch;
    level.scr_anim["generic"]["breach_idle"][2] = %casual_stand_idle_twitchb;
    level.scr_anim["generic"]["smg_exposed_tracking_turn180l"] = %smg_exposed_tracking_turn180l;
    level.scr_anim["generic"]["smg_exposed_tracking_turn180r"] = %smg_exposed_tracking_turn180r;
    level.scr_anim["generic"]["smg_stand_2_run_180l"] = %smg_stand_2_run_180l;
    level.scr_anim["generic"]["smg_casual_stand_idle_trans_out"] = %smg_casual_stand_idle_trans_out;
    level.scr_anim["generic"]["smg_stand_2_run_l"] = %smg_stand_2_run_l;
    level.scr_anim["generic"]["smg_stand_2_run_r"] = %smg_stand_2_run_r;
    level.scr_anim["generic"]["smg_exposed_idle_reactb"] = %smg_exposed_idle_reactb;
    level.scr_anim["cormack"]["pent_enter"] = %ie_pent_enter_cormack;
    level.scr_anim["cormack_stealth_takedown_guy"]["pent_enter"] = %ie_pent_enter_enemy;
    level.scr_anim["cormack"]["pent_desk_idle"][0] = %ie_pent_desk_cormack_loop;
    level.scr_anim["cormack"]["pent_desk"] = %ie_pent_desk_cormack_exit;
    level.scr_anim["cormack"]["pent_escape"] = %ie_pent_escape_cormack;
    level.scr_anim["generic"]["whimper_react"] = %cqb_stop_3;
    level.patrol_scriptedanims["whimper_react"] = "whimper_react";
    level.scr_anim["atrium_door_enter_enemy1"]["atrium_door_enter"] = %ie_backyard_door_enemy1;
    level.scr_anim["atrium_door_enter_enemy2"]["atrium_door_enter"] = %ie_backyard_door_enemy2;
    level.scr_anim["dropdown_enemy1"]["atrium_dropdown_balcony"] = %ie_backyard_dropdown_enemy1;
    level.scr_anim["dropdown_enemy2"]["atrium_dropdown_balcony"] = %ie_backyard_dropdown_enemy2;
    level.scr_anim["cormack"]["hangar_enter"] = %ie_hangar_cormack_enter;
    level.scr_anim["cormack"]["hangar_enter_run"] = %ie_hangar_cormack_enter_run;
    level.scr_anim["cormack"]["hangar_enter_loop"][0] = %ie_hangar_cormack_enter_loop;
    level.scr_anim["cormack"]["hangar_loop"][0] = %ie_hangar_cormack_loop;
    level.scr_anim["irons"]["hangar_loop"][0] = %ie_hangar_irons_loop;
    level.scr_anim["doctor"]["hangar_loop"][0] = %ie_hangar_kva_loop;
    level.scr_anim["lift_worker_01"]["hangar_loop"][0] = %ie_hangar_worker1_loop;
    level.scr_anim["lift_worker_02"]["hangar_loop"][0] = %ie_hangar_worker2_loop;
    level.scr_anim["cormack"]["hangar"] = %ie_hangar_cormack;
    level.scr_anim["irons"]["hangar"] = %ie_hangar_irons;
    level.scr_anim["doctor"]["hangar"] = %ie_hangar_kva;
    level.scr_anim["lift_worker_01"]["hangar"] = %ie_hangar_worker1;
    level.scr_anim["lift_worker_02"]["hangar"] = %ie_hangar_worker2;
    level.scr_anim["car_ride_driving_worker_1"]["car_ride_driving_workers"] = %ie_car_ride_driving_worker1;
    level.scr_anim["car_ride_driving_worker_2"]["car_ride_driving_workers"] = %ie_car_ride_driving_worker2;
    level.scr_anim["generic"]["ie_hangar_ambience_welder_loop"][0] = %ie_hangar_ambience_welder_loop;
    level.scr_anim["generic"]["training_humvee_soldier_idle"][0] = %training_humvee_soldier_idle;
    level.scr_anim["forklift_driver"]["forklift_loop"][0] = %ie_hangar_ambience_forklift_driver_loop;
    level.scr_anim["generic"]["s1_exposed_backpedal"] = %s1_exposed_backpedal;
    level.scr_anim["generic"]["s1_exposed_backpedal_v2"] = %s1_exposed_backpedal_v2;
    level.scr_anim["elevator_top_enemy_1"]["elevator_top_enemies"] = %ie_pent_escape_enemy1;
    level.scr_anim["elevator_top_enemy_2"]["elevator_top_enemies"] = %ie_pent_escape_enemy2;
    level.scr_anim["elevator_bottom_enemy_1"]["elevator_bottom_enemies"] = %ie_pent_escape_enemy3;
    level.scr_anim["elevator_bottom_enemy_2"]["elevator_bottom_enemies"] = %ie_pent_escape_enemy4;
    maps\_anim::addnotetrack_customfunction( "cormack", "helmet_open", maps\irons_estate_code::helmet_open );
    maps\_anim::addnotetrack_customfunction( "cormack", "helmet_close", maps\irons_estate_code::helmet_close );
}

civilian_anims()
{
    level.scr_anim["generic"]["civilian_stand_idle"][0] = %civilian_stand_idle;
    level.scr_anim["generic"]["unarmed_covercrouch_hide_idle"][0] = %unarmed_covercrouch_hide_idle;
    level.scr_anim["generic"]["unarmed_cowercrouch_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["civilain_crouch_hide_idle_loop"][0] = %civilain_crouch_hide_idle_loop;
    level.scr_anim["generic"]["unarmed_cowercrouch_idle_duck"][0] = %unarmed_cowercrouch_idle_duck;
    level.scr_anim["generic"]["forklift_cower_idle"][0] = %ie_hangar_ambience_forklift_driver_alert;
    level.scr_anim["generic"]["patrol_walk_cool"] = %civilian_walk_cool;
    level.scr_anim["generic"]["patrol_idle_cool"] = %civilian_stand_idle;
    level.scr_anim["generic"]["patrol_walk_alert"] = %civilian_run_hunched_a;
    level.scr_anim["generic"]["patrol_idle_alert"] = %unarmed_cowercrouch_idle_duck;
    level.scr_anim["generic"]["landing_pad_worker_cower_idle"][0] = %unarmed_cowercrouch_idle_duck;
    level.scr_anim["generic"]["civilian_pool_1"][0] = %hms_greece_market_outro_idle_npc1;
    level.scr_anim["generic"]["civilian_pool_2"][0] = %hms_greece_market_civ_idle_02;
    level.scr_anim["generic"]["civilian_pool_3"][0] = %hms_greece_market_vendor_loop_ilana;
    level.scr_anim["generic"]["civilian_pool_4"][0] = %hms_greece_market_civ_idle_04;
    level.scr_anim["generic"]["civilian_poolhouse_1"][0] = %ie_frontyard_pooltable_guy_1;
    level.scr_anim["generic"]["civilian_poolhouse_2"][0] = %ie_frontyard_pooltable_guy_2;
    level.scr_anim["generic"]["civilian_poolhouse_3"][0] = %civilian_texting_standing;
    level.scr_anim["generic"]["patrol_walk_lady_phone"] = %ie_penthouse_lady_phone_walk;
    level.scr_anim["generic"]["patrol_idle_lady_phone"] = %ie_penthouse_lady_phone_idle;
    level.scr_anim["generic"]["civilian_guesthouse_1"][0] = %hms_greece_trans_alley_cafe_civ_idle_03;
    level.scr_anim["generic"]["civilian_guesthouse_2"][0] = %hms_greece_trans_alley_cafe_civ_idle_02;
    level.scr_anim["generic"]["civilian_guesthouse_3"][0] = %hms_greece_trans_alley_cafe_civ_idle_06;
    level.scr_anim["generic"]["civilian_guesthouse_1_react"] = %ie_frontyard_react_civ_03;
    level.scr_anim["generic"]["civilian_guesthouse_2_react"] = %ie_frontyard_react_civ_02;
    level.scr_anim["generic"]["civilian_guesthouse_3_react"] = %ie_frontyard_react_civ_06;
    level.scr_anim["generic"]["patrol_walk_man_phone"] = %civilian_cellphonewalk;
    level.scr_anim["generic"]["patrol_idle_man_phone"] = %ie_penthouse_lady_phone_idle;
    level.scr_anim["generic"]["ie_frontyard_cellphone_transition"] = %ie_frontyard_cellphone_transition;
    level.scr_anim["generic"]["civilian_drone_scan_enter_drone_scan_male"] = %ie_frontyard_drone_scan_enter_man;
    level.scr_anim["generic"]["civilian_drone_scan_loop_drone_scan_male"][0] = %ie_frontyard_drone_scan_loop_man;
    level.scr_anim["generic"]["civilian_drone_scan_exit_drone_scan_male"] = %ie_frontyard_drone_scan_exit_man;
    level.scr_anim["generic"]["civilian_drone_scan_enter_drone_scan_female"] = %ie_frontyard_drone_scan_enter_woman;
    level.scr_anim["generic"]["civilian_drone_scan_loop_drone_scan_female"][0] = %ie_frontyard_drone_scan_loop_woman;
    level.scr_anim["generic"]["civilian_drone_scan_exit_drone_scan_female"] = %ie_frontyard_drone_scan_exit_woman;
    level.scr_anim["generic"]["holding_hands_drone_scan_male"] = %innocent_civ_couple_walk_man;
    level.scr_anim["generic"]["holding_hands_drone_scan_female"] = %innocent_civ_couple_walk_woman;
    level.scr_anim["generic"]["holding_hands_walk_drone_scan_male"] = %ie_frontyard_drone_scan_walk_man;
    level.scr_anim["generic"]["holding_hands_walk_drone_scan_female"] = %ie_frontyard_drone_scan_walk_woman;
    level.scr_anim["generic"]["holding_hands_end_transition_drone_scan_male"] = %ie_frontyard_drone_end_man;
    level.scr_anim["generic"]["holding_hands_end_transition_drone_scan_female"] = %ie_frontyard_drone_end_woman;
    level.scr_anim["generic"]["holding_hands_end_drone_scan_male"][0] = %hms_greece_market_civ_idle_03;
    level.scr_anim["generic"]["holding_hands_end_drone_scan_female"][0] = %hms_greece_market_civ_idle_04;
    level.scr_anim["generic"]["hms_greece_market_civ_idle_01"][0] = %hms_greece_market_civ_idle_01;
    level.scr_anim["generic"]["hms_greece_market_civ_idle_02"][0] = %hms_greece_market_civ_idle_02;
    level.scr_anim["generic"]["hms_greece_market_shopper_idle_03"][0] = %hms_greece_market_shopper_idle_03;
    level.scr_anim["generic"]["hms_greece_market_shopper_idle_08"][0] = %hms_greece_market_shopper_idle_08;
    level.scr_anim["generic"]["civilian_garage_1_panel_idle"][0] = %ie_frontyard_garage_panel_idle_guy1;
    level.scr_anim["generic"]["civilian_garage_2_panel_idle"][0] = %ie_frontyard_garage_panel_idle_guy2;
    level.scr_anim["generic"]["civilian_garage_1_panel_to_car"] = %ie_frontyard_garage_panel_to_car_guy1;
    level.scr_anim["generic"]["civilian_garage_2_panel_to_car"] = %ie_frontyard_garage_panel_to_car_guy2;
    level.scr_anim["generic"]["civilian_garage_1_car_idle"][0] = %ie_frontyard_garage_inspect_car_guy1;
    level.scr_anim["generic"]["civilian_garage_2_car_idle"][0] = %ie_frontyard_garage_inspect_car_guy2;
    level.scr_anim["generic"]["civilian_right_side_1"][0] = %hms_greece_market_civ_idle_04;
    level.scr_anim["generic"]["civilian_right_side_2"][0] = %hms_greece_market_civ_idle_02;
    level.scr_anim["generic"]["civilian_right_side_3"][0] = %hms_greece_market_civ_idle_03;
    level.scr_anim["generic"]["ie_frontyard_lost_civ_guy"] = %ie_frontyard_lost_civ_guy;
    maps\_anim::addnotetrack_notify( "generic", "start_guard", "start_guard", "ie_frontyard_lost_civ_guy" );
    level.scr_anim["generic"]["ie_frontyard_lost_civ_guard"] = %ie_frontyard_lost_civ_guard;
    level.scr_anim["generic"]["running_car_driver"][0] = %civ_domestic_truck_driver_idle;
    level.scr_anim["generic"]["driveway_car_1_driver"][0] = %civ_domestic_sedan_driver_idle;
    level.scr_anim["generic"]["driveway_car_1_passenger"][0] = %ie_frontyard_sedan_passenger_drive_idle;
    level.scr_anim["generic"]["driveway_car_1_idle_driveway_female"][0] = %ie_frontyard_car_enter_idle_woman;
    level.scr_anim["generic"]["driveway_car_1_idle_driveway_male"][0] = %ie_frontyard_car_enter_idle_man;
    level.scr_anim["generic"]["driveway_car_1_enter_driveway_female"] = %ie_frontyard_car_enter_woman;
    level.scr_anim["generic"]["driveway_car_1_enter_driveway_male"] = %ie_frontyard_car_enter_man;
    level.scr_anim["generic"]["driveway_car_1_enter_guard"] = %ie_frontyard_car_enter_guard;
    level.scr_anim["generic"]["driveway_car_2_driver"][0] = %civ_domestic_truck_driver_idle;
}

#using_animtree("player");

player_anims()
{
    level.scr_animtree["player_rig"] = #animtree;
    level.scr_model["player_rig"] = "s1_gfl_ump45_viewbody";
    level.scr_anim["player_rig"]["briefing_start"] = %ie_briefing_start_player;
    level.scr_anim["player_rig"]["tutorial_idle_first_frame_only"] = %ie_stealth_meter_idle_player;
    level.scr_anim["player_rig"]["tutorial_idle"][0] = %ie_stealth_meter_idle_player;
    level.scr_anim["player_rig"]["tutorial_exit"] = %ie_stealth_meter_exit_player;
    level.scr_anim["player_rig"]["plant_emp"] = %ie_sec_center_enter_player;
    level.scr_anim["player_rig"]["handprint"] = %ie_sec_center_handprint_player;
    level.scr_anim["player_rig"]["security_center_exit"] = %ie_sec_center_exit_player;
    level.scr_anim["player_rig"]["pent_desk"] = %ie_pent_desk_player;
    level.scr_anim["player_rig"]["pent_escape"] = %ie_pent_escape_player;
    level.scr_anim["player_rig"]["capture"] = %ie_pent_capture_player;
    level.scr_anim["player_rig"]["pent_desk_finish_player"] = %ie_pent_desk_finish_player;
    level.scr_anim["player_rig"]["guardhouse_enter"] = %ie_guardhouse_enter_player;
    level.scr_anim["player_rig"]["guardhouse_reenter"] = %ie_guardhouse_aim_player_enter;
    level.scr_anim["player_rig"]["guardhouse_idle"][0] = %ie_guardhouse_aim_player_loop;
    level.scr_anim["player_rig"]["guardhouse_exit"] = %ie_guardhouse_aim_player_exit;
    level.scr_anim["player_rig"]["guardhouse_shoot"] = %ie_guardhouse_shoot_player;
    level.scr_anim["player_rig"]["exfil"] = %ie_exfil_player;
    level.scr_anim["player_rig"]["exfil_impact"] = %ie_exfil_player_impact;
    level.scr_anim["player_rig"]["exfil_recovery"] = %ie_exfil_player_recovery;
    level.scr_anim["player_rig"]["car_ride_enter"] = %ie_car_ride_enter_player;
    level.scr_anim["player_rig"]["car_ride_idle"][0] = %ie_car_ride_enter_player_idle;
    level.scr_anim["player_rig"]["car_ride_driving"] = %ie_car_ride_driving_player;
    level.scr_anim["player_rig"]["hangar"] = %ie_hangar_player;
    level.scr_anim["player_rig"]["human_shield_idle"][0] = %ie_pent_hostage_idle_player;
    level.scr_anim["player_rig"]["human_shield_run"][0] = %ie_pent_hostage_walk_player;
    level.scr_anim["player_rig"]["atrium_door_enter"] = %ie_backyard_door_player;
    level.scr_anim["player_rig"]["atrium_rappel"] = %ie_backyard_dropdown_player;
}

#using_animtree("generic_human");

ally_anims()
{
    level.scr_anim["cormack"]["crouched_talking"][0] = %casual_crouch_v2_talk;
    level.scr_anim["cormack"]["dive"] = %stand_2_prone;
    level.scr_anim["cormack"]["jump_down"] = %traverse_jumpdown_130;
    level.scr_anim["cormack"]["exfil_enter"] = %ie_exfil_stairs_enter_cormack;
    level.scr_anim["cormack"]["exfil_enter_end_1"] = %ie_exfil_stairs_top1_cormack;
    level.scr_anim["cormack"]["exfil_enter_end_2"] = %ie_exfil_stairs_top2_cormack;
    level.scr_anim["cormack"]["exfil"] = %ie_exfil_cormack;
    level.scr_anim["exfil_ally1"]["exfil"] = %ie_exfil_ally1;
    level.scr_anim["exfil_ally2"]["exfil"] = %ie_exfil_ally2;
    level.scr_anim["cormack"]["car_ride_enter"] = %ie_car_ride_enter_cormack;
    level.scr_anim["cormack"]["car_ride_enter_idle"][0] = %ie_car_ride_enter_cormack_idle;
    level.scr_anim["cormack"]["car_ride_driving"] = %ie_car_ride_driving_cormack;
}

#using_animtree("animated_props");

animated_prop_anims()
{
    level.scr_animtree["generic_prop_raven"] = #animtree;
    level.scr_model["generic_prop_raven"] = "generic_prop_raven";
    level.scr_anim["generic_prop_raven"]["atrium_door_enter"] = %ie_backyard_door_jprop_laser;
    level.scr_anim["generic_prop_raven"]["atrium_dropdown_balcony"] = %ie_backyard_dropdown_jprop_laser;
    level.scr_animtree["guardhouse_player_window_prop"] = #animtree;
    level.scr_model["guardhouse_player_window_prop"] = "generic_prop_raven";
    level.scr_animtree["guardhouse_cormack_window_prop"] = #animtree;
    level.scr_model["guardhouse_cormack_window_prop"] = "generic_prop_raven";
    level.scr_anim["guardhouse_player_window_prop"]["guardhouse_enter"] = %ie_guardhouse_enter_prop_window1;
    level.scr_anim["guardhouse_cormack_window_prop"]["guardhouse_enter"] = %ie_guardhouse_enter_prop_window2;
    level.scr_animtree["guardhouse_cormack_chair_prop"] = #animtree;
    level.scr_model["guardhouse_cormack_chair_prop"] = "generic_prop_raven";
    level.scr_anim["guardhouse_cormack_chair_prop"]["guardhouse_shoot_chair"] = %ie_guardhouse_shoot_prop_chair2;
    level.scr_animtree["palm_tree_01"] = #animtree;
    level.scr_model["palm_tree_01"] = "foliage_fan_palm_tree_01_anim";
    level.scr_anim["palm_tree_01"]["palm_tree_01"][0] = %ie_palm_wind_gust_med_01;
    level.scr_animtree["palm_tree_02"] = #animtree;
    level.scr_model["palm_tree_02"] = "foliage_fan_palm_tree_02_anim";
    level.scr_anim["palm_tree_02"]["palm_tree_02"][0] = %ie_palm_wind_gust_med_02;
    level.scr_animtree["palm_tree_03"] = #animtree;
    level.scr_model["palm_tree_03"] = "foliage_fan_palm_tree_02_anim";
    level.scr_anim["palm_tree_03"]["palm_tree_03"][0] = %ie_palm_wind_gust_med_03;
    level.scr_animtree["intro_drone"] = #animtree;
    level.scr_model["intro_drone"] = "base_drone_security_01";
    level.scr_anim["intro_drone"]["ie_intro_drone_scan"] = %ie_intro_drone_scan;
    level.scr_animtree["intro_drone_1"] = #animtree;
    level.scr_model["intro_drone_1"] = "base_drone_security_01";
    level.scr_anim["intro_drone_1"]["ie_intro_drone_scan"] = %ie_intro_drone_back_scan_1;
    level.scr_animtree["intro_drone_2"] = #animtree;
    level.scr_model["intro_drone_2"] = "base_drone_security_01";
    level.scr_anim["intro_drone_2"]["ie_intro_drone_scan"] = %ie_intro_drone_back_scan_2;
    level.scr_animtree["tutorial_overlook_door_prop"] = #animtree;
    level.scr_model["tutorial_overlook_door_prop"] = "generic_prop_raven";
    level.scr_anim["tutorial_overlook_door_prop"]["ie_stealth_meter_door"] = %ie_stealth_meter_door;
    level.scr_animtree["emp"] = #animtree;
    level.scr_model["emp"] = "mutecharge";
    level.scr_anim["emp"]["plant_emp"] = %ie_sec_center_enter_emp;
    level.scr_animtree["hatch_door_middle"] = #animtree;
    level.scr_model["hatch_door_middle"] = "base_door_hatch_on_anim";
    level.scr_anim["hatch_door_middle"]["plant_emp"] = %ie_sec_center_enter_hatch;
    level.scr_anim["hatch_door_middle"]["hatch_close"] = %ie_sec_center_exit_hatch;
    level.scr_animtree["hatch_door_left"] = #animtree;
    level.scr_model["hatch_door_left"] = "base_door_hatch_on_anim";
    level.scr_anim["hatch_door_left"]["hatch_left_open"] = %ie_sec_center_open_hatch;
    level.scr_anim["hatch_door_left"]["hatch_left_close"] = %ie_sec_center_exit_hatch;
    level.scr_animtree["drone_scan_prop"] = #animtree;
    level.scr_model["drone_scan_prop"] = "generic_prop_raven";
    level.scr_anim["drone_scan_prop"]["drone_scan_enter_door"] = %ie_frontyard_drone_scan_enter_door;
    level.scr_animtree["lost_civilian_prop"] = #animtree;
    level.scr_model["lost_civilian_prop"] = "generic_prop_raven";
    level.scr_anim["lost_civilian_prop"]["ie_frontyard_lost_civ_door"] = %ie_frontyard_lost_civ_door;
    level.scr_animtree["vtol"] = #animtree;
    level.scr_model["vtol"] = "atlas_vtol_cargo_plane_ext_ai";
    level.scr_anim["vtol"]["exfil"] = %ie_exfil_vtol;
    level.scr_anim["vtol"]["cormack_stealth_takedown"] = %ie_flyover_vtol_enter;
    level.scr_anim["vtol"]["flyover_idle"][0] = %ie_flyover_vtol_idle;
    level.scr_animtree["gaz"] = #animtree;
    level.scr_model["gaz"] = "mil_gaz_chassis_vm";
    level.scr_anim["gaz"]["car_ride_intro"] = %ie_guardhouse_gaz;
    level.scr_anim["gaz"]["car_ride_enter"] = %ie_car_ride_enter_gaz;
    level.scr_anim["gaz"]["car_ride_driving"] = %ie_car_ride_driving_gaz;
    level.scr_anim["gaz"]["hangar"][0] = %ie_hangar_gaz;
    level.scr_animtree["gaz2"] = #animtree;
    level.scr_model["gaz2"] = "civ_humvee_ai";
    level.scr_anim["gaz2"]["car_ride_intro"] = %ie_guardhouse_gaz2;
    level.scr_anim["gaz2"]["car_ride_enter"] = %ie_car_ride_enter_gaz2;
    level.scr_anim["gaz2"]["car_ride_driving"] = %ie_car_ride_driving_gaz2;
    level.scr_anim["gaz2"]["hangar"][0] = %ie_hangar_gaz2;
    level.scr_anim["generic_prop_raven"]["capture"] = %ie_pent_capture_exit_door;
    level.scr_anim["generic_prop_raven"]["capture_exit"] = %ie_pent_capture_exit_door;
    level.scr_anim["generic_prop_raven"]["capture_fail"] = %ie_pent_capture_fail_door;
    level.scr_anim["generic_prop_raven"]["pent_search"] = %ie_pent_search_door;
    level.scr_anim["generic_prop_raven"]["ambush"] = %ie_pent_ambush_door;
    level.scr_anim["generic_prop_raven"]["pent_escape"] = %ie_pent_escape_prop_elevator_doors_jprop;
    level.scr_anim["generic_prop_raven"]["hangar"] = %ie_hangar_prop_elevator_jprop;
    level.scr_animtree["cargo_crate"] = #animtree;
    level.scr_model["cargo_crate"] = "atlas_stabilize_crate";
    level.scr_anim["cargo_crate"]["hangar"] = %ie_hangar_prop_crate;
    level.scr_animtree["tracking_device"] = #animtree;
    level.scr_model["tracking_device"] = "tracking_device";
    level.scr_anim["tracking_device"]["tracking_device_plant"] = %ie_exfil_prop_tracker;
    level.scr_anim["generic_prop_raven"]["exfil_breathers"] = %ie_exfil_prop_breather_jprop;
    level.scr_animtree["generic_prop_raven_x3"] = #animtree;
    level.scr_model["generic_prop_raven_x3"] = "generic_prop_raven_x3";
    level.scr_anim["generic_prop_raven_x3"]["guardhouse_shoot"] = %ie_guardhouse_shoot_prop_chair1;
    level.scr_anim["generic_prop_raven_x3"]["elevator_top_enemies"] = %ie_pent_escape_prop_upper_doors_jprop;
    level.scr_anim["generic_prop_raven_x3"]["elevator_bottom_enemies"] = %ie_pent_escape_prop_lower_doors_jprop;
    level.scr_anim["generic_prop_raven_x3"]["forklift_loop"][0] = %ie_hangar_ambience_doors_jprop_loop;
    level.scr_anim["generic_prop_raven"]["forklift_loop"][0] = %ie_hangar_ambience_crate_loop;
    level.scr_animtree["genericprop_x5"] = #animtree;
    level.scr_model["genericprop_x5"] = "genericprop_x5";
    level.scr_anim["genericprop_x5"]["hangar"] = %ie_hangar_prop_crate_jprop;
    level.scr_anim["genericprop_x5"]["exfil"] = %ie_exfil_prop_spotlights_jprop;
    level.scr_anim["genericprop_x5"]["pent_enter"] = %ie_pent_enter_prop_doors_chair_jprop;
    level.scr_animtree["forklift"] = #animtree;
    level.scr_model["forklift"] = "vehicle_ind_personal_forklift_ai";
    level.scr_anim["forklift"]["forklift_loop"][0] = %ie_hangar_ambience_forklift_loop;
    level.scr_animtree["ie_door"] = #animtree;
    level.scr_model["ie_door"] = "door_single_01_estate_anim";
    level.scr_anim["ie_door"]["car_ride_enter"] = %ie_car_ride_enter_prop_door;
    level.scr_anim["ie_door"]["atrium_door_enter"] = %ie_backyard_door_door;
    level.scr_anim["ie_door"]["pent_enter"] = %ie_backyard_meet_cormack_prop_door;
    level.scr_animtree["lower_stairwell_door"] = #animtree;
    level.scr_model["lower_stairwell_door"] = "door_single_right_01_estate_anim";
    level.scr_anim["lower_stairwell_door"]["lower_stairwell_door"] = %ie_exfil_stairs_door_lower;
    level.scr_animtree["upper_stairwell_door_left"] = #animtree;
    level.scr_model["upper_stairwell_door_left"] = "door_single_right_01_estate_anim";
    level.scr_anim["upper_stairwell_door_left"]["upper_stairwell_doors"] = %ie_exfil_stairs_door_upper_l;
    level.scr_animtree["upper_stairwell_door_right"] = #animtree;
    level.scr_model["upper_stairwell_door_right"] = "door_single_01_estate_anim";
    level.scr_anim["upper_stairwell_door_right"]["upper_stairwell_doors"] = %ie_exfil_stairs_door_upper_r;
    level.scr_animtree["base_grapple_scale_rope"] = #animtree;
    level.scr_model["base_grapple_scale_rope"] = "base_grapple_scale_rope";
    level.scr_anim["base_grapple_scale_rope"]["guardhouse_shoot"] = %ie_guardhouse_shoot_prop_rope;
    level.scr_anim["base_grapple_scale_rope"]["pent_enter"] = %ie_pent_enter_prop_rope;
}

#using_animtree("vehicles");

vehicle_anims()
{
    level.scr_animtree["sedan"] = #animtree;
    level.scr_anim["sedan"]["driveway_car_1_enter"] = %ie_frontyard_car_enter_sedan;
}

script_model_anims()
{

}
