// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    if ( level.nextgen )
        anim.forced_s1_motionset = 1;

    load_player_anims();
    load_actor_anims();
    load_vehicle_anims();
    load_prop_anims();
    maps\_patrol_anims_creepwalk::main();
    maps\_patrol_anims_patroljog::main();
    maps\_patrol_anims_active::main();
    maps\_patrol_anims_casualkiller::main();
    maps\_patrol_anims::main();
}

#using_animtree("player");

load_player_anims()
{
    level.scr_animtree["player_rig"] = #animtree;
    level.scr_model["player_rig"] = "s1_gfl_ump45_viewbody";
    level.scr_anim["player_rig"]["intro"] = %bet_intro_vm;
    maps\_anim::addnotetrack_customfunction( "player_rig", "fov_swap", ::change_fov_back_to_65, "intro" );
    level.scr_anim["player_rig"]["confrontation_pt2"] = %bet_confrontation_pt2_vm;
    maps\_anim::addnotetrack_customfunction( "player_rig", "rumble_medium", ::simple_player_rumble_medium, "confrontation_pt2" );
    level.scr_anim["player_rig"]["confrontation_pt2_pause"] = %bet_confrontation_pt2_idle_vm;
    level.scr_anim["player_rig"]["escape_pt1"] = %bet_escape_pt1_vm;
    maps\_anim::addnotetrack_customfunction( "player_rig", "start_success_window", maps\betrayal_code::confrontation_scene_escape_qte_kick, "escape_pt1" );
    level.scr_anim["player_rig"]["escape_pt1_fail"] = %bet_escape_pt1_fail_vm;
    maps\_anim::addnotetrack_customfunction( "player_rig", "mission_fail", maps\betrayal_code::confrontation_scene_escape_qte_fail, "escape_pt1_fail" );
    level.scr_anim["player_rig"]["escape_pt2"] = %bet_escape_pt2_vm;
    maps\_anim::addnotetrack_customfunction( "player_rig", "rumble_medium", ::simple_player_rumble_medium, "escape_pt2" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "raise_gun", maps\betrayal_code::confrontation_scene_escape_qte_raise_gun, "escape_pt2" );
    level.scr_anim["player_rig"]["elevator_climb_dismount"] = %bet_elevator_exoclimb_dismount_vm;
    level.scr_anim["player_rig"]["tower_climb_dismount"] = %vm_exoclimb_dismount_down;
    level.scr_anim["player_rig"]["roof_slide"] = %bet_rooftop_slide_vm;
    maps\_anim::addnotetrack_customfunction( "player_rig", "fx_glass_impact", maps\betrayal_fx::vm_glass_impact, "roof_slide" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "water_splash", maps\betrayal_fx::vm_water_impact, "roof_slide" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "water_splash", maps\betrayal_code::roof_scene_hide_rig, "roof_slide" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "viewmodel_medium", ::simple_player_rumble_medium, "roof_slide" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "viewmodel_large", ::simple_player_rumble_heavy, "roof_slide" );
    level.scr_anim["player_rig"]["boat_getin"] = %bet_boat_chase_enter_vm;
    level.scr_anim["grapple_launcher"]["boat_getin"] = %bet_boat_chase_enter_grapple;
    // maps\_anim::addnotetrack_customfunction( "player_rig", "grapple_arm_swap", maps\betrayal_code::boat_scene_swap_to_grapple_body, "boat_getin" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "rumble_small", ::simple_player_rumble_light, "boat_getin" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "rumble_medium", ::simple_player_rumble_medium, "boat_getin" );
    level.scr_animtree["player_rig_grapple"] = #animtree;
    level.scr_model["player_rig_grapple"] = "s1_gfl_ump45_viewbody";
    level.scr_anim["player_rig_grapple"]["boat_crash"] = %bet_boat_crash_vm;
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "black_out", maps\betrayal_code::boat_scene_crash_moment_whiteout, "boat_crash" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "black_out", maps\betrayal_fx::vm_boat_crash_se_whiteout, "boat_crash" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "rumble_large", ::simple_player_rumble_heavy, "boat_crash" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "rumble_small", ::simple_player_rumble_light, "boat_crash" );
    level.scr_anim["player_rig_grapple"]["boat_getout"] = %bet_boat_exit_vm;
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "start_action", maps\betrayal_code::climb_scene_start_action, "boat_getout" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "rumble_small", ::simple_player_rumble_light, "boat_getout" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "rumble_medium", ::simple_player_rumble_medium, "boat_getout" );
    level.scr_anim["player_rig_grapple"]["crane_mount"] = %bet_finale_mag_mount_walkway_to_crane_vm;
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "grab_rumble", maps\betrayal_code::climb_scene_crane_grab_rumble, "crane_mount" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "grab_shake", maps\betrayal_code::climb_scene_crane_grab_shake, "crane_mount" );
    level.scr_anim["player_rig_grapple"]["left_move"] = %bet_exo_crane_climb_l_grab_vm;
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "plant_left_hand", maps\betrayal_code::climb_scene_crane_move_rumble, "left_move" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "plant_left_hand", maps\betrayal_code::climb_scene_crane_move_shake, "left_move" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "allow_player_input", maps\betrayal_code::climb_scene_crane_allow_input, "left_move" );
    level.scr_anim["player_rig_grapple"]["right_move"] = %bet_exo_crane_climb_r_grab_vm;
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "plant_right_hand", maps\betrayal_code::climb_scene_crane_move_rumble, "right_move" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "plant_right_hand", maps\betrayal_code::climb_scene_crane_move_shake, "right_move" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "allow_player_input", maps\betrayal_code::climb_scene_crane_allow_input, "right_move" );
    level.scr_anim["player_rig_grapple"]["left_idle"][0] = %bet_exo_crane_climb_l_idle_vm;
    level.scr_anim["player_rig_grapple"]["right_idle"][0] = %bet_exo_crane_climb_r_idle_vm;
    level.scr_anim["player_rig_grapple"]["crane_to_final"] = %bet_finale_mag_mount_crane_to_rooftop_vm;
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "vfx_vm_land_edge", maps\betrayal_fx::vfx_vm_land_crane_edge, "crane_to_final" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "rumble_large", ::simple_player_rumble_heavy, "crane_to_final" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "rumble_medium", ::simple_player_rumble_medium, "crane_to_final" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "rumble_small", ::simple_player_rumble_light, "crane_to_final" );
    level.scr_anim["player_rig_grapple"]["finale_scene"] = %bet_finale_vm;
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "vfx_vm_land_roof", maps\betrayal_fx::vfx_vm_land_roof, "finale_scene" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "vfx_vm_land_roof_hands", maps\betrayal_fx::vfx_vm_land_roof_hands, "finale_scene" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "fade_out", maps\betrayal_code::climb_scne_finale_fade_out, "finale_scene" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "hide_viewbody", maps\betrayal_code::climb_scne_finale_hide_body, "finale_scene" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "vfx_vm_land_roof", ::simple_player_rumble_heavy, "finale_scene" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "vfx_vm_land_roof_hands", ::simple_player_rumble_heavy, "finale_scene" );
    level.scr_animtree["player_hands"] = #animtree;
    level.scr_model["player_hands"] = "s1_gfl_ump45_viewhands";
    level.scr_anim["player_hands"]["sewer_grate_open"] = %bet_sewer_climb_out_sewer_grate_vm;
    maps\_anim::addnotetrack_customfunction( "player_hands", "teleport_ilona", maps\betrayal_code::sewer_scene_teleport_ilona_to_sewer_exit, "sewer_grate_open" );
    maps\_anim::addnotetrack_customfunction( "player_hands", "rumble_medium", ::simple_player_rumble_medium, "sewer_grate_open" );
    maps\_anim::addnotetrack_customfunction( "player_hands", "rumble_small", ::simple_player_rumble_light, "sewer_grate_open" );
}

#using_animtree("generic_human");

load_actor_anims()
{
    level.scr_anim["gideon"]["intro"] = %bet_intro_gideon;
    level.scr_anim["generic"]["patrol_walk_casual_urgent"][0] = %bet_unarmed_casual_walk01_gideon;
    level.scr_anim["generic"]["patrol_walk_casual_urgent"][1] = %bet_casual_gestures_talk01_gideon;
    level.scr_anim["generic"]["patrol_walk_casual_urgent"][2] = %bet_casual_gestures_talk02_gideon;
    level.scr_anim["generic"]["patrol_walk_casual_urgent"][3] = %bet_casual_gestures_talk03_gideon;
    var_0 = [];
    var_0[0] = 7;
    var_0[1] = 1;
    var_0[2] = 1;
    var_0[3] = 1;
    level.scr_anim["generic"]["patrol_walk_weights_casual_urgent"] = common_scripts\utility::get_cumulative_weights( var_0 );
    level.scr_anim["generic"]["patrol_transin_casual_urgent"] = %bet_casual_startstop_walk_to_idle_gideon;
    level.scr_anim["generic"]["patrol_transout_casual_urgent"] = %bet_casual_startstop_idle_to_walk_gideon;
    level.scr_anim["generic"]["patrol_idle_casual_urgent"][0] = %bet_casual_startstop_idle_gideon;
    level.scr_anim["generic"]["patrol_walk_gunsearch"][0] = %payback_search_walk_1;
    level.scr_anim["generic"]["patrol_walk_gunsearch"][1] = %payback_search_walk_2;
    level.scr_anim["generic"]["patrol_walk_casual"][0] = %patrol_bored_patrolwalk;
    level.scr_anim["generic"]["patrol_walk_unaware"][0] = %civilian_walk_cool;
    level.scr_anim["generic"]["patrol_idle_unaware"][0] = %civilian_stand_idle;
    level.scr_anim["generic"]["patrol_walk_panic"][0] = %civilian_run_hunched_a;
    level.scr_anim["generic"]["patrol_walk_panic"][1] = %civilian_run_hunched_c;
    level.scr_anim["generic"]["patrol_walk_panic"][2] = %civilian_run_upright;
    level.scr_anim["generic"]["patrol_idle_panic"][0] = %unarmed_crouch_idle1;
    level.scr_anim["generic"]["patrol_idle_panic"][1] = %unarmed_cowercrouch_idle_duck;
    level.scr_anim["generic"]["patrol_idle_panic"][2] = %unarmed_crouch_twitch1;
    level.scr_anim["generic"]["patrol_idle_panic"][3] = %unarmed_cowerstand_pointidle;
    level.scr_anim["generic"]["det_casual_walk_fast_burke"][0] = %det_casual_walk_fast_burke;
    level.scr_anim["generic"]["bet_ceremony_security_idle_guy01"][0] = %bet_ceremony_security_idle_guy01;
    level.scr_anim["generic"]["bet_ceremony_security_idle_guy01weight"][0] = 0.92;
    level.scr_anim["generic"]["bet_ceremony_security_idle_guy01"][1] = %bet_ceremony_security_idle_twitch_a_guy01;
    level.scr_anim["generic"]["bet_ceremony_security_idle_guy01weight"][1] = 0.02;
    level.scr_anim["generic"]["bet_ceremony_security_idle_guy01"][2] = %bet_ceremony_security_idle_twitch_b_guy01;
    level.scr_anim["generic"]["bet_ceremony_security_idle_guy01weight"][2] = 0.02;
    level.scr_anim["generic"]["bet_ceremony_security_idle_guy01"][3] = %bet_ceremony_security_idle_twitch_c_guy01;
    level.scr_anim["generic"]["bet_ceremony_security_idle_guy01weight"][3] = 0.02;
    level.scr_anim["generic"]["bet_ceremony_security_idle_guy01"][4] = %bet_ceremony_security_idle_twitch_d_guy01;
    level.scr_anim["generic"]["bet_ceremony_security_idle_guy01weight"][4] = 0.02;
    level.scr_anim["generic"]["bet_ceremony_security_idle_guy02"][0] = %bet_ceremony_security_idle_guy02;
    level.scr_anim["generic"]["bet_ceremony_security_idle_guy02weight"][0] = 0.91;
    level.scr_anim["generic"]["bet_ceremony_security_idle_guy02"][1] = %bet_ceremony_security_idle_twitch_a_guy02;
    level.scr_anim["generic"]["bet_ceremony_security_idle_guy02weight"][1] = 0.03;
    level.scr_anim["generic"]["bet_ceremony_security_idle_guy02"][2] = %bet_ceremony_security_idle_twitch_c_guy02;
    level.scr_anim["generic"]["bet_ceremony_security_idle_guy02weight"][2] = 0.03;
    level.scr_anim["generic"]["bet_ceremony_security_idle_guy02"][3] = %bet_ceremony_security_idle_twitch_d_guy02;
    level.scr_anim["generic"]["bet_ceremony_security_idle_guy02weight"][3] = 0.03;
    level.scr_anim["business_civilian"]["idle_combat"][0] = %civilian_stand_idle;
    level.scr_anim["business_civilian"]["idle_noncombat"][0] = %civilian_stand_idle;
    level.scr_anim["business_civilian"]["run_noncombat"][0] = %civilian_walk_cool;
    level.scr_anim["gideon"]["atlas_bldg_double_stairs"] = %bet_atlas_bldg_double_stairs_gideon;
    level.scr_anim["gideon"]["atlas_bldg_swipe_door"] = %bet_confrontation_room_enter_gideon;
    maps\_anim::addnotetrack_customfunction( "gideon", "card_swipe", maps\betrayal_code::office_scene_open_swipe_door, "atlas_bldg_swipe_door" );
    maps\_anim::addnotetrack_customfunction( "gideon", "fx_arm_scan", maps\betrayal_fx::gideon_arm_scan, "atlas_bldg_swipe_door" );
    level.scr_anim["gideon"]["confrontation_pt1"] = %bet_confrontation_pt1_gideon;
    level.scr_anim["ilana"]["confrontation_pt1"] = %bet_confrontation_pt1_ilona;
    level.scr_anim["irons"]["confrontation_pt1"] = %bet_confrontation_pt1_irons;
    maps\_anim::addnotetrack_customfunction( "ilana", "fx_scrambler_light", maps\betrayal_fx::scrambler_light, "confrontation_pt1" );
    // maps\_anim::addnotetrack_customfunction( "irons", "model_swap", maps\betrayal_code::confrontation_scene_irons_no_gun, "confrontation_pt1" );
    maps\_anim::addnotetrack_customfunction( "irons", "hologram_on", ::show_hologram, "confrontation_pt1" );
    maps\_anim::addnotetrack_customfunction( "irons", "fx_gun_shot", maps\betrayal_fx::confrontation_irons_gun_shot, "confrontation_pt1" );
    maps\_anim::addnotetrack_customfunction( "ilana", "fx_scrambler_light_off", maps\betrayal_fx::scrambler_light_off, "confrontation_pt1" );
    level.scr_anim["technologist"]["confrontation_pt1"] = %bet_confrontation_pt1_technician;
    maps\_anim::addnotetrack_customfunction( "technologist", "hologram_on", ::show_hologram, "confrontation_pt1" );
    maps\_anim::addnotetrack_customfunction( "technologist", "fx_tech_blood", maps\betrayal_fx::confrontation_tech_blood, "confrontation_pt1" );
    level.scr_anim["guard1"]["confrontation_pt1"] = %bet_confrontation_pt1_guy01;
    maps\_anim::addnotetrack_customfunction( "guard1", "door_open", maps\betrayal_code::confrontation_scene_open_flashbang_door, "confrontation_pt1" );
    level.scr_anim["gideon"]["confrontation_pt2"] = %bet_confrontation_pt2_gideon;
    level.scr_anim["ilana"]["confrontation_pt2"] = %bet_confrontation_pt2_ilona;
    level.scr_anim["irons"]["confrontation_pt2"] = %bet_confrontation_pt2_irons;
    level.scr_anim["guard1"]["confrontation_pt2"] = %bet_confrontation_pt2_npc1;
    level.scr_anim["guard2"]["confrontation_pt2"] = %bet_confrontation_pt2_npc2;
    level.scr_anim["ilana"]["confrontation_pt2_pause"] = %bet_confrontation_pt2_idle_ilona;
    level.scr_anim["guard1"]["confrontation_pt2_pause"] = %bet_confrontation_pt2_idle_npc1;
    level.scr_anim["guard2"]["confrontation_pt2_pause"] = %bet_confrontation_pt2_idle_npc2;
    level.scr_anim["ilana"]["escape_pt1_fail"] = %bet_escape_pt1_fail_ilona;
    level.scr_anim["guard1"]["escape_pt1_fail"] = %bet_escape_pt1_fail_npc1;
    level.scr_anim["guard2"]["escape_pt1_fail"] = %bet_escape_pt1_fail_npc2;
    level.scr_anim["ilana"]["escape_pt1"] = %bet_escape_pt1_ilona;
    level.scr_anim["guard1"]["escape_pt1"] = %bet_escape_pt1_npc1;
    level.scr_anim["guard2"]["escape_pt1"] = %bet_escape_pt1_npc2;
    maps\_anim::addnotetrack_customfunction( "guard2", "fx_pipe_burst", maps\betrayal_fx::escape_sprinklers_on, "escape_pt1" );
    level.scr_anim["ilana"]["escape_pt2"] = %bet_escape_pt2_ilona;
    maps\_anim::addnotetrack_customfunction( "ilana", "start_success_window", maps\betrayal_code::confrontation_scene_escape_qte_shoot, "escape_pt2" );
    level.scr_anim["guard1"]["escape_pt2"] = %bet_escape_pt2_npc1;
    maps\_anim::addnotetrack_customfunction( "guard1", "guard_dead", maps\betrayal_code::confrontation_scene_escape_qte_kick_kill, "escape_pt2" );
    level.scr_anim["guard2"]["escape_pt2"] = %bet_escape_pt2_npc2;
    level.scr_anim["ilana"]["escape_pt3_fail"] = %bet_escape_pt3_fail_ilona;
    maps\_anim::addnotetrack_customfunction( "ilana", "mission_fail", maps\betrayal_code::confrontation_scene_escape_qte_fail, "escape_pt3_fail" );
    level.scr_anim["guard2"]["escape_pt3_fail"] = %bet_escape_pt3_fail_npc2;
    level.scr_anim["ilana"]["escape_pt3"] = %bet_escape_pt3_ilona;
    maps\_anim::addnotetrack_customfunction( "ilana", "swap_gun_to_Ilona", maps\betrayal_code::confrontation_scene_gun_swap, "escape_pt3" );
    level.scr_anim["guard2"]["escape_pt3"] = %bet_escape_pt3_npc2;
    level.scr_anim["ilana"]["react_to_opening_elevator_doors"] = %stand_cover_reaction_a;
    level.scr_anim["ilana"]["roof_escape_fence_pull_back"] = %lag_pullbackfence_jump_burke_pt1;
    level.scr_anim["roof_guard_1"]["roof_slide"] = %bet_rooftop_slide_guy_01;
    maps\_anim::addnotetrack_customfunction( "roof_guard_1", "slomo_start", maps\betrayal_code::roof_scene_slide_slomo_start, "roof_slide" );
    maps\_anim::addnotetrack_customfunction( "roof_guard_1", "slomo_end", maps\betrayal_code::roof_scene_slide_slomo_stop, "roof_slide" );
    level.scr_anim["roof_guard_2"]["roof_slide"] = %bet_rooftop_slide_guy_02;
    level.scr_anim["roof_guard_3"]["roof_slide"] = %bet_rooftop_slide_guy_03;
    level.scr_anim["ilana"]["roof_slide"] = %bet_rooftop_slide_ilana;
    maps\_anim::addnotetrack_customfunction( "ilana", "remove_collision_for_rooftop_shatter", maps\betrayal_code::roof_scene_slide_remove_glass_blocker, "roof_slide" );
    maps\_anim::addnotetrack_customfunction( "ilana", "raise_rooftop_gate", maps\betrayal_code::roof_scene_slide_raise_gates, "roof_slide" );
    maps\_anim::addnotetrack_customfunction( "ilana", "fx_glass_impact", maps\betrayal_fx::ilana_glass_impact, "roof_slide" );
    maps\_anim::addnotetrack_customfunction( "ilana", "fx_water_impact", maps\betrayal_fx::ilana_water_impact, "roof_slide" );
    level.scr_anim["flr2_set4_spawner1"]["boostjump_128_196up"] = %boost_jump_128_across_196_up;
    level.scr_anim["generic"]["crouch_fast_gren"] = %s1_exposed_crouch_fast_grenade_2;
    level.scr_anim["generic"]["exo_doorkick"] = %africa_soap_kickin_door;
    maps\_anim::addnotetrack_notify( "generic", "door_open", "door_smash_open", "exo_doorkick" );
    level.scr_anim["generic"]["civilian_texting_sitting"][0] = %civilian_texting_sitting;
    level.scr_anim["generic"]["civilian_sitting_business_lunch_A_1"][0] = %civilian_sitting_business_lunch_a_1;
    level.scr_anim["generic"]["civilian_sitting_business_lunch_B_1"][0] = %civilian_sitting_business_lunch_b_1;
    level.scr_anim["generic"]["civilian_sitting_talking_A_1"][0] = %civilian_sitting_talking_a_1;
    level.scr_anim["generic"]["civilian_sitting_talking_A_2"][0] = %civilian_sitting_talking_a_2;
    level.scr_anim["generic"]["civilian_sitting_talking_B_1"][0] = %civilian_sitting_talking_b_1;
    level.scr_anim["generic"]["civilian_sitting_talking_B_2"][0] = %civilian_sitting_talking_b_2;
    level.scr_anim["generic"]["civilian_reader_1"][0] = %civilian_reader_1;
    level.scr_anim["generic"]["civilian_reader_2"][0] = %civilian_reader_2;
    level.scr_anim["generic"]["guardB_sit_drinker_idle"][0] = %guardb_sit_drinker_idle;
    level.scr_anim["generic"]["london_civ_idle_lookover"][0] = %london_civ_idle_lookover;
    level.scr_anim["generic"]["london_civ_idle_checkwatch"][0] = %london_civ_idle_checkwatch;
    level.scr_anim["generic"]["london_civ_idle_lookbehind"][0] = %london_civ_idle_lookbehind;
    level.scr_anim["generic"]["london_civ_idle_sneeze"][0] = %london_civ_idle_sneeze;
    level.scr_anim["generic"]["london_civ_idle_foldarms2"][0] = %london_civ_idle_foldarms2;
    level.scr_anim["generic"]["civilian_texting_standing"][0] = %civilian_texting_standing;
    level.scr_anim["generic"]["civilian_stand_idle"][0] = %civilian_stand_idle;
    level.scr_anim["generic"]["civilian_smoking_a"][0] = %civilian_smoking_a;
    level.scr_anim["generic"]["civilian_smoking_b"][0] = %civilian_smoking_b;
    level.scr_anim["generic"]["hijack_president_idle_panic_fidget_1"][0] = %hijack_president_idle_panic_fidget_1;
    level.scr_anim["generic"]["unarmed_cowercrouch_idle_duck"][0] = %unarmed_cowercrouch_idle_duck;
    level.scr_anim["generic"]["unarmed_crouch_idle1"][0] = %unarmed_crouch_idle1;
    level.scr_anim["generic"]["unarmed_crouch_twitch1"][0] = %unarmed_crouch_twitch1;
    level.scr_anim["generic"]["unarmed_scared_run"][0] = %unarmed_scared_run;
    level.scr_anim["generic"]["turbine_elevator_enter"] = %fusion_lift_deploy_cover_right_enter;
    level.scr_anim["cover_guy"]["cover_placement"] = %fusion_lift_deploy_cover_carter_enter;
    level.scr_anim["left_guy"]["cover_placement"] = %fusion_lift_deploy_cover_left_enter;
    level.scr_anim["generic"]["turbine_elevator_idle"][0] = %fusion_lift_deploy_cover_right_idle;
    level.scr_anim["generic"]["turbine_elevator_idle"][0] = %fusion_lift_deploy_cover_carter_idle;
    level.scr_anim["generic"]["turbine_elevator_idle"][0] = %fusion_lift_deploy_cover_left_idle;
    level.scr_anim["generic"]["turbine_elevator_exit"] = %fusion_lift_deploy_cover_right_exit;
    level.scr_anim["generic"]["turbine_elevator_exit"] = %fusion_lift_deploy_cover_carter_exit;
    level.scr_anim["generic"]["turbine_elevator_exit"] = %fusion_lift_deploy_cover_left_exit;
    level.scr_anim["generic"]["cabinet_pull"] = %bet_pulldown_cabinet_guy1;
    level.scr_anim["dock_anim_jumper1"]["boost_jump_512_across_256_over"] = %boost_jump_512_across_256_over;
    level.scr_anim["dock_anim_jumper2"]["boost_jump_512_across_64_over"] = %boost_jump_512_across_64_over;
    level.scr_anim["dock_anim_jumper3"]["boost_jump_512_across_270_down"] = %boost_jump_512_across_270_down;
    level.scr_anim["generic"]["civilian_stand_idle2"][0] = %hms_greece_market_civ_idle_02;
    level.scr_anim["generic"]["civilian_stand_idle4"][0] = %hms_greece_market_civ_idle_04;
    level.scr_anim["generic"]["civilian_stand_idle5"][0] = %london_civ_idle_foldarms2;
    level.scr_anim["generic"]["civilian_stand_idle6"][0] = %london_station_civ1_idle;
    level.scr_anim["generic"]["civilian_stand_idle7"][0] = %london_station_civ5_idle;
    level.scr_anim["generic"]["civilian_stand_idle8"][0] = %london_station_civ7_idle;
    level.scr_anim["generic"]["civilian_stand_idle9"][0] = %london_station_civ11_idle;
    level.scr_anim["generic"]["civilian_stand_idle_male1"][0] = %london_civ_idle_foldarms_scratchass;
    level.scr_anim["generic"]["civilian_walk1_male"][0] = %hms_greece_market_civ_walk_male_01;
    level.scr_anim["generic"]["civilian_walk2_male"][0] = %hms_greece_market_civ_walk_slow_look_male_01;
    level.scr_anim["generic"]["civilian_walk3_male"][0] = %hms_greece_market_civ_walk_slow_male_01;
    level.scr_anim["generic"]["civilian_walk1_female"][0] = %hms_greece_market_civ_walk_slow_female_01;
    level.scr_anim["generic"]["civilian_walk2_female"][0] = %hms_greece_market_civ_walk_slow_look_female_01;
    level.scr_anim["generic"]["civilian_run1_male"][0] = %hms_greece_sniperscramble_droneflee_civ_m_02;
    level.scr_anim["generic"]["civilian_run2_male"][0] = %hms_greece_sniperscramble_droneflee_civ_m_01;
    level.scr_anim["generic"]["civilian_run3_male"][0] = %hms_greece_sniperscramble_droneflee_civ_m_03;
    level.scr_anim["civilian_react"]["civilian_cower1_neutral"][0] = %hms_greece_alleys_civ_panic_ground_02_idle;
    level.scr_anim["civilian_react"]["civilian_cower2_neutral"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["civilian_react"]["civilian_cower1_male"][0] = %hms_greece_trans_alley_civ_panic_pair_cov_loop_m;
    level.scr_anim["civilian_react"]["civilian_cower1_female"][0] = %hms_greece_sni_scram_hothall_civ_idle_end_f_1;
    level.scr_anim["civilian_react"]["bet_civilians_cowering_idle_01"][0] = %bet_civilians_cowering_idle_01;
    level.scr_anim["civilian_react"]["bet_civilians_cowering_idle_02"][0] = %bet_civilians_cowering_idle_02;
    level.scr_anim["civilian_react"]["bet_civilians_cowering_idle_03"][0] = %bet_civilians_cowering_idle_03;
    level.scr_anim["civilian_react"]["bet_civilians_cowering_idle_04"][0] = %bet_civilians_cowering_idle_04;
    level.scr_anim["civilian_react"]["bet_civilians_cowering_idle_05"][0] = %bet_civilians_cowering_idle_05;
    level.scr_anim["civilian_react"]["bet_civilians_cowering_idle_06"][0] = %bet_civilians_cowering_idle_06;
    level.scr_anim["generic"]["civilian_idle_film_phone"][0] = %hms_greece_trans_alley_civ_gawk_phone_mir;
    level.scr_anim["civilian_react"]["civilian_react_to_cower1"] = %hms_greece_alleys_civ_panic_ground_01;
    level.scr_anim["civilian_react"]["civilian_react_to_cower2"] = %hms_greece_alleys_civ_panic_ground_02;
    level.scr_anim["civilian_react"]["civilian_react_stand2run1"] = %hms_greece_alleys_npc_civtd_civp2_02;
    level.scr_anim["civilian_react"]["civilian_react_stand2run2"] = %hms_greece_trans_alley_cafe_civ_exit_04;
    level.scr_anim["civilian_react"]["civilian_react_sit2run1"] = %hms_greece_trans_alley_cafe_civ_exit_02;
    level.scr_anim["civilian_react"]["civilian_react_sit2run2"] = %hms_greece_trans_alley_cafe_civ_exit_03;
    level.scr_anim["civilian_react"]["civilian_react_sit2run3"] = %hms_greece_trans_alley_cafe_civ_exit_05;
    level.scr_anim["civilian_react"]["civilian_react_sit2run4"] = %hms_greece_trans_alley_cafe_civ_exit_06;
    level.scr_anim["civilian_react"]["civilian_react_sit2run5"] = %hms_greece_trans_alley_cafe_civ_exit_07;
    level.scr_anim["generic"]["civilian_sit_read1"][0] = %hms_greece_cafe_civ_sit_read_idle_01;
    level.scr_anim["generic"]["civilian_sit_read2"][0] = %hms_greece_cafe_civ_sit_read_idlecrossed_01;
    level.scr_anim["generic"]["civilian_sit_idle1"][0] = %hms_greece_market_fntn_civ_talk_npc;
    level.scr_anim["generic"]["civilian_sit_idle3"][0] = %hms_greece_trans_alley_cafe_civ_idle_02;
    level.scr_anim["generic"]["civilian_sit_idle4"][0] = %hms_greece_trans_alley_cafe_civ_idle_03;
    level.scr_anim["generic"]["civilian_sit_idle5"][0] = %hms_greece_trans_alley_cafe_civ_idle_06;
    level.scr_anim["generic"]["civilian_female_dodge_right"] = %hms_greece_market_civ_walk_dodge_r_female_02;
    level.scr_anim["generic"]["civilian_transin_forward"] = %hms_greece_market_civ_idletrans_in_f;
    level.scr_anim["generic"]["civilian_transin_left"] = %hms_greece_market_civ_idletrans_in_l;
    level.scr_anim["generic"]["civilian_transin_right"] = %hms_greece_market_civ_idletrans_in_r;
    level.scr_anim["generic"]["civilian_transout_backward"] = %hms_greece_market_civ_idletrans_out_b;
    level.scr_anim["generic"]["civilian_transout_left"] = %hms_greece_market_civ_idletrans_out_l;
    level.scr_anim["generic"]["civilian_transout_right"] = %hms_greece_market_civ_idletrans_out_r;
    level.scr_anim["generic"]["bet_run_bang_door_guy2_loop"][0] = %bet_run_bang_door_guy2_loop;
    level.scr_anim["generic"]["bet_run_bang_door_guy1_loop"][0] = %bet_run_bang_door_guy1_loop;
    level.scr_anim["generic"]["bet_lobby_civ_sidestep_R"] = %bet_lobby_civ_sidestep_r;
    level.scr_anim["generic"]["civilian_texting_standing"][0] = %civilian_texting_standing;
    level.scr_anim["generic"]["civilian_crossedarms_stand_idle_2"][0] = %london_station_civ1_idle;
    level.scr_anim["generic"]["civilian_sitting_talking_a_2"][0] = %civilian_sitting_talking_a_2;
    level.scr_anim["generic"]["civilian_sitting_talking_b_1"][0] = %civilian_sitting_talking_b_1;
    level.scr_anim["generic"]["civilian_sitting_talking_b_2"][0] = %civilian_sitting_talking_b_2;
    level.scr_anim["generic"]["civilian_texting_sitting"][0] = %civilian_texting_sitting;
    level.scr_anim["generic"]["civilian_directions_stand_idle"][0] = %civilian_directions_1_a;
    level.scr_anim["civilian_react"]["civilian_directions_stand_idle_2"][0] = %civilian_directions_1_b;
    level.scr_anim["generic"]["civilian_argue_stand_idle"][0] = %lag_lobby_securityguard_loop_guy2;
    level.scr_anim["generic"]["civilian_smoking_leaning_idle"][0] = %parabolic_leaning_guy_smoking_idle;
    level.scr_anim["civilian_react"]["civ_react_retreat_stand_to_run_1"] = %london_station_civ7_reaction;
    level.scr_anim["civilian_react"]["civ_react_retreat_stand_to_crouch"] = %unarmed_cowerstand_react_2_crouch;
    level.scr_anim["civilian_react"]["civ_react_retreat_stand_to_stand"] = %unarmed_cowerstand_react;
    level.scr_anim["civilian_react"]["civ_react_cower_crouch_to_crouch"][0] = %unarmed_cowercrouch_idle_duck;
    level.scr_anim["civilian_react"]["civ_react_crouch_idle"][0] = %casual_crouch_v2_idle;
    level.scr_anim["civilian_react"]["civ_react_cower_hunch_to_hunch"][0] = %hijack_president_idle_panic_fidget_1;
    level.scr_anim["civilian_react"]["civ_react_cower_crouch_to_crouch_2"][0] = %unarmed_crouch_idle1;
    level.scr_anim["generic"]["civ_react_cower_crouch_to_crouch_2"][0] = %unarmed_crouch_idle1;
    level.scr_anim["civilian_react"]["civ_react_handsup_stand_to_stand"][0] = %unarmed_cowerstand_pointidle;
    level.scr_anim["civilian_react"]["civ_react_cower_crouch_to_crouch_3"][0] = %civilain_crouch_hide_idle_loop;
    level.scr_anim["generic"]["civ_run_hunch1"][0] = %civilian_run_hunched_a;
    level.scr_anim["generic"]["civ_run_stand1"][0] = %civilian_run_upright;
    level.scr_anim["generic"]["civilian_crowd_walk_stand"][0] = %civilian_crowd_behavior_a;
    level.scr_anim["generic"]["civilian_walk_nervous"][0] = %civilian_walk_nervous;
    level.scr_anim["generic"]["civilian_walk_pda"][0] = %civilian_walk_pda;
    level.scr_anim["generic"]["civilian_walk_hurried"][0] = %civilian_walk_hurried_1;
    level.scr_anim["generic"]["civilian_male_walk_cool"][0] = %civilian_walk_cool;
    level.scr_anim["atlas_guard_1"]["boost_jump_256_across_128_over"] = %boost_jump_256_across_128_over;
    level.scr_anim["atlas_guard_2"]["boost_jump_256_across_128_over"] = %boost_jump_256_across_128_over;
    level.scr_anim["atlas_guard_3"]["boost_jump_256_across_128_over"] = %boost_jump_256_across_128_over;
    level.scr_anim["atlas_guard_4"]["boost_jump_256_across_128_over"] = %boost_jump_256_across_128_over;
    level.scr_anim["atlas_guard_1"]["boost_jump_256_across_384_down_variation"] = %boost_jump_256_across_384_down_variation;
    level.scr_anim["atlas_guard_2"]["boost_jump_256_across_384_down_variation"] = %boost_jump_256_across_384_down_variation;
    level.scr_anim["atlas_guard_3"]["boost_jump_256_across_384_down_variation"] = %boost_jump_256_across_384_down_variation;
    level.scr_anim["atlas_guard_4"]["boost_jump_256_across_384_down_variation"] = %boost_jump_256_across_384_down_variation;
    level.scr_anim["scripted"]["civilian_texting_standing"][0] = %civilian_texting_standing;
    level.scr_anim["scripted"]["civilian_stand_idle"][0] = %civilian_stand_idle;
    level.scr_anim["scripted"]["civilian_crossedarms_stand_idle_2"][0] = %london_station_civ1_idle;
    level.scr_anim["scripted"]["civilian_smoking_stand_idle"][0] = %civilian_smoking_a;
    level.scr_anim["scripted"]["civilian_smoking_stand_idle_2"][0] = %civilian_smoking_b;
    level.scr_anim["scripted"]["civilian_directions_stand_idle"][0] = %civilian_directions_1_a;
    level.scr_anim["scripted"]["civilian_directions_stand_idle_2"][0] = %civilian_directions_1_b;
    level.scr_anim["scripted"]["civ_react_retreat_stand_to_run_1"] = %london_station_civ7_reaction;
    level.scr_anim["scripted"]["civ_react_retreat_stand_to_run_2"] = %london_station_civ6_reaction;
    level.scr_anim["scripted"]["civ_react_retreat_stand_to_crouch"] = %unarmed_cowerstand_react_2_crouch;
    level.scr_anim["scripted"]["civ_react_retreat_stand_to_hunch"] = %london_station_civ9a_reaction;
    level.scr_anim["scripted"]["civ_react_retreat_stand_to_hunch_2"] = %london_station_civ9b_reaction;
    level.scr_anim["scripted"]["civ_react_handsup"] = %unarmed_cowerstand_idle2point;
    level.scr_anim["scripted"]["civ_react_handsup_idle"][0] = %unarmed_cowerstand_pointidle;
    level.scr_anim["scripted"]["civ_react_handsup_stand_to_stand_2"] = %unarmed_cowerstand_idle2point;
    level.scr_anim["scripted"]["civ_react_cower_crouch_to_crouch"][0] = %unarmed_cowercrouch_idle_duck;
    level.scr_anim["scripted"]["civ_react_crouch_idle"][0] = %casual_crouch_v2_idle;
    level.scr_anim["scripted"]["civ_react_cower_hunch_to_hunch"][0] = %hijack_president_idle_panic_fidget_1;
    level.scr_anim["scripted"]["civ_react_cower_crouch_to_crouch_2"][0] = %unarmed_crouch_idle1;
    level.scr_anim["scripted"]["civ_react_handsup_stand_to_stand"][0] = %unarmed_cowerstand_pointidle;
    level.scr_anim["scripted"]["civ_react_cower_crouch_to_crouch_3"][0] = %civilain_crouch_hide_idle_loop;
    level.scr_anim["scripted"]["civ_walking_relative_idle"] = %civilian_walk_hurried_1;
    level.scr_anim["scripted"]["ny_manhattan_radio_sandman_talk"] = %ny_manhattan_radio_sandman_talk;
    level.scr_anim["scripted"]["soldier_drone_standing_gun_raised_idle"][0] = %stinger_idle;
    level.scr_anim["scripted"]["soldier_drone_walk_to_and_point"] = %mob2_arc_e;
    level.scr_anim["scripted"]["soldier_walk_and_direct"] = %casual_killer_walk_wave;
    level.scr_anim["scripted"]["soldier_walk"] = %lab_breachroom_hazmat_walk_guy1;
    level.scr_anim["ilana"]["ilona_transition_to_walk"] = %seo_react_to_war_run_2_idle;
    level.scr_anim["ilana"]["ilona_react_to_drone"] = %berlin_delta_react_to_falling_debris_1;
    level.scr_anim["ilana"]["ilona_turn_90r_to_watch"] = %training_intro_foley_turnaround_1;
    level.scr_anim["ilana"]["boat_getout"] = %bet_boat_exit_ilana;
    level.scr_anim["cormack"]["finale_scene"] = %bet_finale_cormack;
    maps\_anim::addnotetrack_customfunction( "cormack", "decloak", ::finale_cloak_off, "finale_scene" );
    level.scr_anim["gideon"]["finale_scene"] = %bet_finale_gideon;
    maps\_anim::addnotetrack_customfunction( "gideon", "vfx_warbird_approach_dust", maps\betrayal_fx::vfx_warbird_dust_roof, "finale_scene" );
    maps\_anim::addnotetrack_customfunction( "gideon", "vfx_gideon_land_roof", maps\betrayal_fx::vfx_gideon_land_roof, "finale_scene" );
    level.scr_anim["ilana"]["finale_scene"] = %bet_finale_ilana;
    maps\_anim::addnotetrack_customfunction( "ilana", "vfx_ilana_land_rooftop", maps\betrayal_fx::vfx_ilana_land_roof, "finale_scene" );
    level.scr_anim["joker"]["finale_scene"] = %bet_finale_joker;
    maps\_anim::addnotetrack_customfunction( "joker", "vfx_joker_land_roof", maps\betrayal_fx::vfx_joker_land_roof, "finale_scene" );
    level.scr_anim["sentinel1"]["finale_scene"] = %bet_finale_sentinel_1;
    maps\_anim::addnotetrack_customfunction( "sentinel1", "decloak", ::finale_cloak_off, "finale_scene" );
    level.scr_anim["sentinel2"]["finale_scene"] = %bet_finale_sentinel_2;
    maps\_anim::addnotetrack_customfunction( "sentinel2", "decloak", ::finale_cloak_off, "finale_scene" );
}

#using_animtree("vehicles");

load_vehicle_anims()
{
    level.scr_anim["warbird"]["finale_scene"] = %bet_finale_warbird;
    level.scr_animtree["player_boat"] = #animtree;
    level.scr_model["player_boat"] = "vehicle_mil_atlas_speedboat_glass_cracked_ai";
    level.scr_anim["player_boat"]["boat_getin"] = %bet_boat_chase_enter_boat;
    level.scr_anim["player_boat"]["boat_crash"] = %bet_boat_crash_boat;
    maps\_anim::addnotetrack_customfunction( "player_boat", "hit_scaffolding", ::boat_crash_break_glass, "boat_crash" );
    maps\_anim::addnotetrack_customfunction( "player_boat", "hit_building", ::boat_crash_break_glass, "boat_crash" );
    level.scr_anim["player_boat"]["boat_getout"] = %bet_boat_exit_boat;
}

#using_animtree("script_model");

load_prop_anims()
{
    level.scr_animtree["jammer"] = #animtree;
    level.scr_model["jammer"] = "lag_harmonic_breach_device";
    level.scr_anim["jammer"]["confrontation_pt1"] = %bet_confrontation_pt1_jammer;
    level.scr_animtree["irons_chair"] = #animtree;
    level.scr_model["irons_chair"] = "dem_irons_chair_01_cloaktrans";
    level.scr_anim["irons_chair"]["confrontation_pt1"] = %bet_confrontation_pt1_chair_irons;
    maps\_anim::addnotetrack_customfunction( "irons_chair", "hologram_on", ::show_hologram, "confrontation_pt1" );
    level.scr_animtree["guest_chair"] = #animtree;
    level.scr_model["guest_chair"] = "dem_irons_guest_chair_01_rig_cloaktrans";
    level.scr_anim["guest_chair"]["confrontation_pt1"] = %bet_confrontation_pt1_chair_technician;
    maps\_anim::addnotetrack_customfunction( "guest_chair", "hologram_on", ::show_hologram, "confrontation_pt1" );
    level.scr_animtree["flash_bang"] = #animtree;
    level.scr_model["flash_bang"] = "npc_flash_grenade";
    level.scr_anim["flash_bang"]["confrontation_pt1"] = %bet_confrontation_pt1_flash_grenade;
    maps\_anim::addnotetrack_customfunction( "flash_bang", "explode_flash", maps\betrayal_code::confrontation_scene_flashbang_explode, "confrontation_pt1" );
    maps\_anim::addnotetrack_customfunction( "flash_bang", "explode_flash", maps\betrayal_fx::confrontation_flashbang, "confrontation_pt1" );
    level.scr_animtree["player_pistol"] = #animtree;
    level.scr_model["player_pistol"] = "vm_titan45_nocamo";
    level.scr_anim["player_pistol"]["confrontation_pt2"] = %bet_confrontation_pt2_pistol;
    level.scr_animtree["roof_escape_fence"] = #animtree;
    level.scr_anim["roof_escape_fence"]["roof_escape_fence_pull_back"] = %lag_pullbackfence_jump_fence_pt1;
    maps\_anim::addnotetrack_customfunction( "roof_escape_fence", "fence_dust", maps\betrayal_fx::pull_fence_dust, "roof_escape_fence_pull_back" );
    level.scr_animtree["sewer_lid"] = #animtree;
    level.scr_model["sewer_lid"] = "btr_sewer_cover_01_rig";
    level.scr_anim["sewer_lid"]["sewer_grate_open"] = %bet_sewer_climb_out_sewer_grate_lid;
    level.scr_animtree["deployable_cover"] = #animtree;
    level.scr_model["deployable_cover"] = "deployable_cover";
    level.scr_anim["deployable_cover"]["deployable_cover_deploy"] = %fusion_lift_deploy_cover_deployable_cover_prop_enter;
    level.scr_anim["deployable_cover"]["deployable_cover_closed_idle"] = %fusion_lift_deploy_cover_idle_closed;
    level.scr_anim["deployable_cover"]["deployable_cover_open_idle"] = %fusion_lift_deploy_cover_idle_opened;
    level.scr_animtree["cabinet_org"] = #animtree;
    level.scr_model["cabinet_org"] = "genericprop";
    level.scr_anim["cabinet_org"]["cabinet_pull"] = %bet_pulldown_cabinet_cabinet;
    level.scr_anim["construction_crate"]["crate_corner_left"] = %bet_crate_corner_left;
    level.scr_anim["construction_crate"]["crate_corner_right"] = %bet_crate_corner_right;
    level.scr_animtree["finale_crate_ext"] = #animtree;
    level.scr_model["finale_crate_ext"] = "btr_construction_crate_with_door_anim_01_exterior";
    level.scr_anim["finale_crate_ext"]["finale_scene"] = %bet_finale_crate;
    level.scr_animtree["finale_crate_int"] = #animtree;
    level.scr_model["finale_crate_int"] = "btr_construction_crate_with_door_anim_01_interior";
    level.scr_anim["finale_crate_int"]["finale_scene"] = %bet_finale_crate;
}

simple_player_rumble_heavy( var_0 )
{
    level.player playrumbleonentity( "grenade_rumble" );
}

simple_player_rumble_medium( var_0 )
{
    level.player playrumbleonentity( "damage_heavy" );
}

simple_player_rumble_light( var_0 )
{
    level.player playrumbleonentity( "damage_light" );
}

boat_crash_break_glass( var_0 )
{
    glassradiusdamage( level.player.origin, 125, 50, 50 );
}

change_fov_back_to_65( var_0 )
{
    level.player lerpfov( 65, 0.6 );
}

finale_cloak_off( var_0 )
{
    var_0 thread cloak_off();
}

show_hologram( var_0 )
{
    var_0 show();
    var_0 dontcastshadows();
    thread show_hologram_reveal( var_0 );
}

show_hologram_reveal( var_0 )
{
    var_1 = 57;

    if ( !isdefined( level.confrontation_holo ) )
        level.confrontation_holo = [];

    if ( var_0.model == "dem_irons_chair_01_cloaktrans" )
    {
        level.confrontation_holo[level.confrontation_holo.size] = var_0;
        thread maps\betrayal_code::confrontation_static_start();
        wait 0.05;
        var_0 setmaterialscriptparam( 0.0, 0.0 );
        wait 0.05;
        var_0 setmaterialscriptparam( 1.0, 3.0 );
        var_0 hudoutlineenable( 0, 1 );
        wait(var_1);
        var_0 setmaterialscriptparam( 0.0, 1.0 );
        wait 1.0;
        var_0 hide();
    }

    if ( var_0.model == "dem_irons_guest_chair_01_rig_cloaktrans" )
    {
        level.confrontation_holo[level.confrontation_holo.size] = var_0;
        wait 0.05;
        var_0 setmaterialscriptparam( 0.0, 0.0 );
        wait 0.05;
        var_0 setmaterialscriptparam( 1.0, 3.0 );
        var_0 hudoutlineenable( 0, 1 );
        wait(var_1);
        var_0 setmaterialscriptparam( 0.0, 1.0 );
        wait 1.0;
        var_0 hide();
    }

    if ( var_0.model == "irons_casual" )
    {
        level.confrontation_holo[level.confrontation_holo.size] = var_0;
        var_0 overridematerial( "mtl_irons_casual_upperbody_skin", "mtl_irons_casual_upperbody_skin_cloak" );
        var_0 overridematerial( "mtl_irons_casual_upperbody", "mtl_irons_casual_upperbody_cloak" );
        var_0 overridematerial( "mtl_irons_casual_lowerbody", "mtl_irons_casual_lowerbody_cloak" );
        var_0 overridematerial( "mtl_irons_casual_loadouts", "mtl_irons_casual_loadouts_cloak" );
        var_0 overridematerial( "mtl_faceitem_tongue", "mtl_faceitem_tongue_cloak" );
        var_0 overridematerial( "mtl_faceitems_teeth", "mtl_faceitems_teeth_cloak" );
        var_0 overridematerial( "mtl_eyebrow_burke", "mtl_eyebrow_burke_cloak" );
        var_0 overridematerial( "mtl_faceitem_eyelash_irons", "mtl_faceitem_eyelash_irons_cloak" );

        if ( level.nextgen )
        {
            var_0 overridematerial( "mtl_irons_eye_shader_r", "mtl_irons_eye_shader_r_cloak" );
            var_0 overridematerial( "mtl_irons_eye_shader_l", "mtl_irons_eye_shader_l_cloak" );
        }
        else
        {
            var_0 overridematerial( "mtl_eyeball_irons_cg", "mtl_eyeball_irons_cg_cloak" );
            var_0 overridematerial( "mtl_irons_head_wrinkle_tns", "mtl_irons_head_wrinkle_tns_cloak" );
        }

        var_0 overridematerial( "mtl_mp443_base", "mtl_mp443_base_cloak" );
        var_0 overridematerial( "mtl_iron_sights_color", "mtl_mp443_base_nocamo_cloaktrans" );
        var_0 overridematerial( "mtl_caddy_pistol_small", "mtl_caddy_pistol_small_cloak" );
        var_0 overridematerial( "mtl_range_pistol_small_01a", "mtl_mp443_base_nocamo_cloaktrans" );
        wait 0.05;
        var_0 setmaterialscriptparam( 0.0, 0.0 );
        wait 0.05;
        var_0 setmaterialscriptparam( 1.0, 3.0 );
        var_0 hudoutlineenable( 0, 1 );
        wait(var_1);
        var_0 setmaterialscriptparam( 0.0, 1.0 );
        wait 0.5;
        var_0 hide();
        thread maps\betrayal_code::confrontation_hudoutline_cleanup();
        thread maps\betrayal_fx::confrontation_fx_cleanup();
    }

    if ( var_0.model == "civ_urban_male_body_f" )
    {
        level.confrontation_holo[level.confrontation_holo.size] = var_0;
        var_0 setmodel( "dr_mwi_body_cloaktrans" );
        var_0 overridematerial( "mtl_faceitem_tongue", "mtl_faceitem_tongue_cloak" );
        var_0 overridematerial( "mtl_faceitems_teeth", "mtl_faceitems_teeth_cloak" );

        if ( level.nextgen )
        {
            var_0 overridematerial( "mtl_prime_minister_eye_shader_l", "mtl_irons_eye_shader_l_cloak" );
            var_0 overridematerial( "mtl_prime_minister_eye_shader_r", "mtl_irons_eye_shader_r_cloak" );
        }
        else
            var_0 overridematerial( "mtl_cormack_eye", "mtl_cormack_eye_cloak" );

        var_0 overridematerial( "mtl_faceitem_eyelash", "mtl_faceitem_eyelash_irons_cloak" );
        var_0 overridematerial( "mtl_shg_shiny_lense", "mtl_shg_shiny_lense_cloak" );
        var_0 overridematerial( "mtl_head_m_gen_cau_shipley", "mtl_head_m_gen_cau_shipley_cloaktrans" );
        wait 0.05;
        var_0 setmaterialscriptparam( 0.0, 0.0 );
        wait 0.05;
        var_0 setmaterialscriptparam( 1.0, 3.0 );
        var_0 hudoutlineenable( 0, 1 );
        wait(var_1);
        var_0 setmaterialscriptparam( 0.0, 1.0 );
        wait 1;
        var_0 hide();
    }
}

assign_cloak_model( var_0 )
{
    self.cloakedmodel = var_0;
    self.defaultmodel = self.model;
}

cloak_on( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0.75;

    var_1 = 0;
    self setmodel( self.cloakedmodel );
    self drawpostresolve();
    self setmaterialscriptparam( 0.0, var_0 );
    self.cloak = "on";
    wait 0.1;
    maps\_cloak::set_cloak_material_for_npc_weapon();
}

cloak_off( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0.75;

    var_1 = 0;
    self setmaterialscriptparam( 1.0, var_0 );
    wait(var_0);
    self drawpostresolveoff();
    self setmodel( self.defaultmodel );
    self.cloak = "off";
}

set_cloak_material_for_npc_weapon()
{
    if ( self.weapon != "iw5_unarmed" )
    {
        self overridematerial( "_base_black", "m/mtl_burke_sentinel_covert_headgear_a_cloak" );
        self overridematerial( "_iron_sights_black", "m/mtl_burke_sentinel_covert_headgear_a_cloak" );
        self overridematerial( "_iron_sights_color", "m/mtl_burke_sentinel_covert_headgear_a_cloak" );
        self overridematerial( "mtl_weapon_suppressor_b", "m/mtl_burke_sentinel_covert_headgear_a_cloak" );
        self overridematerial( "mtl_bal27_screen_a_green", "m/mtl_burke_sentinel_covert_headgear_a_cloak" );
        self overridematerial( "mtl_bal27_magazine_out", "m/mtl_burke_sentinel_covert_headgear_a_cloak" );
        self overridematerial( "mtl_bal27_magazine_inside", "m/mtl_burke_sentinel_covert_headgear_a_cloak" );
        self overridematerial( "mtl_optics_variable_red_dot", "m/mtl_burke_sentinel_covert_headgear_a_cloak" );
        self overridematerial( "mtl_optics_variable_red_dot_lens_02", "m/mtl_burke_sentinel_covert_headgear_a_cloak" );
        self overridematerial( "mtl_bal27_iron_sights", "m/mtl_burke_sentinel_covert_headgear_a_cloak" );
    }
}
