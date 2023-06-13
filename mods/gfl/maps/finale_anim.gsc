// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    if ( level.nextgen )
        anim.forced_s1_motionset = 1;

    load_player_anims();
    load_actor_anims();
    load_prop_anims();
    load_vehicles_anims();
}

#using_animtree("player");

load_player_anims()
{
    level.scr_anim_vm_index["blast_idle_handsblocking"] = 3;
    level.scr_anim_vm["blast_idle_handsblocking"] = %s1_playermech_blast_idle_vm;
    level.scr_anim_vm_index["blast_walk_handsblocking"] = 4;
    level.scr_anim_vm["blast_walk_handsblocking"] = %s1_playermech_blast_walk_vm;
    level.scr_anim_vm_index["blast_idle_nogun"] = 5;
    level.scr_anim_vm["blast_idle_nogun"] = %s1_playermech_blast_no_gun_idle;
    level.scr_anim_vm_index["blast_walk_nogun"] = 6;
    level.scr_anim_vm["blast_walk_nogun"] = %s1_playermech_blast_no_gun_walk;
    level.scr_anim_vm_index["blast_idle_nohands"] = 7;
    level.scr_anim_vm["blast_idle_nohands"] = %s1_playermech_blast_nohands_idle;
    level.scr_anim_vm_index["blast_walk_nohands"] = 8;
    level.scr_anim_vm["blast_walk_nohands"] = %s1_playermech_blast_nohands_walk;
    level.scr_anim_vm_index["gun_up_vm_takeout"] = 9;
    level.scr_anim_vm["gun_up_vm_takeout"] = %fin_blast_gun_up_mech_vm;
    level.scr_anim_vm_index["gun_limp"] = 11;
    level.scr_anim_vm["gun_limp"] = %fin_drag_shoot_aim_limp_vm;
    level.scr_anim_vm_index["s1_playermech_putaway"] = 12;
    level.scr_anim_vm["s1_playermech_putaway"] = %s1_playermech_putaway;
    level.scr_animtree["world_body"] = #animtree;
    level.scr_model["world_body"] = "s1_gfl_ump45_viewbody";
    level.scr_animtree["world_body_mech"] = #animtree;
    level.scr_model["world_body_mech"] = "vm_world_body_mech";
    level.scr_animtree["world_body_damaged"] = #animtree;
    level.scr_model["world_body_damaged"] = "s1_gfl_ump45_viewbody";
    level.scr_animtree["world_body_damaged_no_exo"] = #animtree;
    level.scr_model["world_body_damaged_no_exo"] = "s1_gfl_ump45_viewbody";
    level.scr_animtree["world_body_damaged_no_exo_no_arm"] = #animtree;
    level.scr_model["world_body_damaged_no_exo_no_arm"] = "s1_gfl_ump45_viewbody_dismembered";
    level.scr_animtree["world_hands"] = #animtree;
    level.scr_model["world_hands"] = "s1_gfl_ump45_viewhands_player";
    level.scr_anim["world_body_mech"]["intro_flyin"] = %fin_mech_flyin_vm;
    level.scr_anim["world_body_mech"]["intro_flyin_release_vm"] = %fin_mech_flyin_release_vm;
    maps\_anim::addnotetrack_customfunction( "world_body_mech", "vfx_mech_vm_water_splash", maps\finale_fx::player_canal_drop, "intro_flyin_release_vm" );
    maps\_anim::addnotetrack_customfunction( "world_body_mech", "rumble_moderate", ::notetrack_rumble_moderate, "intro_flyin_release_vm" );
    maps\_anim::addnotetrack_customfunction( "world_body_mech", "rumble_intense", ::notetrack_rumble_intense, "intro_flyin_release_vm" );
    level.scr_anim["world_body_mech"]["canal_breach"] = %fin_canal_breach_vm;
    level.scr_anim["world_body_mech"]["exhaust_hatch_vm_approach"] = %fin_silo_exhaust_hatch_breach_intro_mech_vm;
    maps\_anim::addnotetrack_customfunction( "world_body_mech", "rumble_moderate", ::notetrack_rumble_moderate, "exhaust_hatch_vm_approach" );
    level.scr_anim["world_body_mech"]["exhaust_hatch_vm_idle_noinput"][0] = %fin_silo_exhaust_hatch_breach_intro_mech_hold_idle_vm;
    level.scr_anim["world_body_mech"]["exhaust_hatch_vm_noinput_to_input"] = %fin_silo_exhaust_hatch_breach_intro_mech_idle_in_vm;
    level.scr_anim["world_body_mech"]["exhaust_hatch_vm_idle_input"][0] = %fin_silo_exhaust_hatch_breach_intro_mech_idle_vm;
    level.scr_anim["world_body_mech"]["exhaust_hatch_vm_input_to_noinput"] = %fin_silo_exhaust_hatch_breach_intro_mech_idle_out_vm;
    level.scr_anim["world_body_mech"]["exhaust_hatch_open"] = %fin_silo_exhaust_hatch_breach_intro_mech_break_vm;
    maps\_anim::addnotetrack_customfunction( "world_body_mech", "break_bar", maps\finale_shaft::notetrack_break_bar, "exhaust_hatch_open" );
    maps\_anim::addnotetrack_customfunction( "world_body_mech", "break_bar", maps\finale_fx::exhaust_hatch_break_player, "exhaust_hatch_open" );
    maps\_anim::addnotetrack_customfunction( "world_body_mech", "break_bar", ::notetrack_rumble_heavy, "exhaust_hatch_open" );
    level.scr_anim["world_body_mech"]["exhaust_hatch_jumpdown"] = %fin_silo_exhaust_hatch_breach_intro_mech_jumpdown_vm;
    level.scr_anim["world_body_mech"]["shaft_both_hands"][0] = %fin_shaft_fall_idle_both_hands_mech_vm;
    level.scr_anim["world_body_mech"]["shaft_left_hand"][0] = %fin_shaft_fall_idle_left_hand_mech_vm;
    level.scr_anim["world_body_mech"]["shaft_no_hands"][0] = %fin_shaft_fall_idle_no_hands_mech_vm;
    level.scr_anim["world_body_mech"]["shaft_right_hand"][0] = %fin_shaft_fall_idle_right_hand_mech_vm;
    level.scr_anim["world_body_mech"]["shaft_both_hands_to_left"] = %fin_shaft_both_to_left_mech_vm;
    level.scr_anim["world_body_mech"]["shaft_both_hands_to_no"] = %fin_shaft_both_to_no_hands_mech_vm;
    level.scr_anim["world_body_mech"]["shaft_both_hands_to_right"] = %fin_shaft_both_to_right_mech_vm;
    level.scr_anim["world_body_mech"]["shaft_no_hands_to_both"] = %fin_shaft_fall_idle_no_hands_to_both_mech_vm;
    level.scr_anim["world_body_mech"]["shaft_no_hands_to_left"] = %fin_shaft_fall_idle_no_hands_to_left_mech_vm;
    level.scr_anim["world_body_mech"]["shaft_no_hands_to_right"] = %fin_shaft_fall_idle_no_hands_to_right_mech_vm;
    level.scr_anim["world_body_mech"]["shaft_left_hand_to_both"] = %fin_shaft_left_to_both_mech_vm;
    level.scr_anim["world_body_mech"]["shaft_left_hand_to_no"] = %fin_shaft_left_to_no_hands_mech_vm;
    level.scr_anim["world_body_mech"]["shaft_left_hand_to_right"] = %fin_shaft_left_to_right_mech_vm;
    level.scr_anim["world_body_mech"]["shaft_right_hand_to_both"] = %fin_shaft_right_to_both_mech_vm;
    level.scr_anim["world_body_mech"]["shaft_right_hand_to_left"] = %fin_shaft_right_to_left_mech_vm;
    level.scr_anim["world_body_mech"]["shaft_right_hand_to_no"] = %fin_shaft_right_to_no_hands_mech_vm;
    level.scr_anim["world_body_mech"]["exhaust_land_vm"] = %fin_silo_exhaust_shaft_land_mech_vm;
    maps\_anim::addnotetrack_customfunction( "world_body_mech", "gideon_start", ::notetrack_gideon_start, "exhaust_land_vm" );
    maps\_anim::addnotetrack_customfunction( "world_body_mech", "vfx_mech_land_vm", maps\finale_fx::exhaust_hatch_land_player, "exhaust_land_vm" );
    maps\_anim::addnotetrack_customfunction( "world_body_mech", "rumble_heavy", ::notetrack_rumble_heavy, "exhaust_land_vm" );
    level.scr_anim["world_body_mech"]["exhaust_blast_react"] = %fin_silo_blast_react_mech_vm;
    maps\_anim::addnotetrack_customfunction( "world_body_mech", "rumble_intense", ::notetrack_rumble_intense, "exhaust_blast_react" );
    level.scr_anim["world_body_mech"]["missile_stopped_vm"] = %fin_silo_missle_launch_stopped_vm;
    maps\_anim::addnotetrack_customfunction( "world_body_mech", "fade_out", ::notetrack_missile_stopped_vm_fade_out, "missile_stopped_vm" );
    level.scr_anim["world_body_mech"]["missile_launch"] = %fin_silo_missle_launch_stopped_vm;
    maps\_anim::addnotetrack_customfunction( "world_body_mech", "vfx_vm_damage_sparks", maps\finale_fx::vfx_vm_mech_sparks );
    maps\_anim::addnotetrack_customfunction( "world_body_mech", "vfx_vm_stop_effects", maps\finale_fx::vfx_vm_mech_stop_effects );
    maps\_anim::addnotetrack_customfunction( "world_body_mech", "rumble_heavy", ::notetrack_rumble_heavy );
    maps\_anim::addnotetrack_customfunction( "world_body_mech", "rumble_intense", ::notetrack_rumble_intense );
    level.scr_anim["world_body_mech"]["missile_launch_far_fail"] = %fin_silo_missle_launch_stopped_vm_rel;
    level.scr_anim["world_body_mech"]["mech_exit"] = %fin_exhaust_mech_exit_vm_mech;
    maps\_anim::addnotetrack_customfunction( "world_body_mech", "vfx_vm_mech_damaged_smk", maps\finale_fx::vfx_vm_mech_dmg_sparks, "mech_exit" );
    maps\_anim::addnotetrack_customfunction( "world_body_mech", "vfx_vm_mech_smk_stop", maps\finale_fx::vfx_vm_mech_dmg_stop, "mech_exit" );
    level.scr_anim["world_body"]["mech_exit"] = %fin_exhaust_mech_exit_vm;
    maps\_anim::addnotetrack_customfunction( "world_body", "fade_out", ::mech_exit_fade_out, "mech_exit" );
    maps\_anim::addnotetrack_customfunction( "world_body", "fov_change", ::notetrack_mech_exit_fov_change, "mech_exit" );
    maps\_anim::addnotetrack_customfunction( "world_body", "fade_in", maps\finale_lighting::rocket_success_pt2_lighting_debugging );
    level.scr_anim["world_body_damaged"]["drag_pickup01"] = %fin_drag_pickup01_vm;
    level.scr_anim["world_body_damaged"]["drag_pickup02"] = %fin_drag_pickup02_vm;
    maps\_anim::addnotetrack_customfunction( "world_body_damaged", "fade_out", ::notetrack_pickup02_fade_out, "drag_pickup02" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged", "fade_in", ::notetrack_pickup02_fade_in, "drag_pickup02" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged", "rumble_light", ::notetrack_rumble_light );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged", "rumble_moderate", ::notetrack_rumble_moderate );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged", "rumble_heavy", ::notetrack_rumble_heavy );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged", "rumble_intense", ::notetrack_rumble_intense );
    level.scr_anim["world_body_damaged"]["drag_putdown"] = %fin_drag_putdown_vm;
    level.scr_anim["world_body_damaged"]["drag_run01"] = %fin_drag_run01_vm;
    level.scr_anim["world_body_damaged"]["drag_run02"] = %fin_drag_run02_vm;
    level.scr_anim["world_body_damaged"]["drag_run03"] = %fin_drag_run03_vm;
    level.scr_anim["world_body_damaged"]["drag_run04"] = %fin_drag_run04_vm;
    maps\_anim::addnotetrack_customfunction( "world_body_damaged", "fade_out", ::notetrack_run01_fade_out, "drag_run01" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged", "fade_in", ::notetrack_run01_fade_in, "drag_run01" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged", "fade_out", ::notetrack_run02_fade_out, "drag_run02" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged", "fade_in", ::notetrack_run02_fade_in, "drag_run02" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged", "fade_out", ::notetrack_run03_fade_out, "drag_run03" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged", "fade_in", ::notetrack_run03_fade_in, "drag_run03" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged", "fade_out", ::notetrack_run04_fade_out, "drag_run04" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged", "fade_in", ::notetrack_run04_fade_in, "drag_run04" );
    level.scr_anim["world_body"]["will_reveal"] = %fin_will_reveal_vm;
    level.scr_anim["world_hands"]["will_reveal_irons"] = %fin_will_reveal_cam;
    maps\_anim::addnotetrack_customfunction( "world_body", "fov_default", ::will_reveal_fov_default, "will_reveal" );
    level.scr_anim["world_body_damaged"]["irons_reveal"] = %fin_irons_reveal_player_vm;
    level.scr_anim["world_body_damaged"]["irons_reveal_fire_add"] = %fin_will_reveal_vm_fire_add;
    level.scr_anim["world_body_damaged"]["irons_reveal_button_press"] = %fin_irons_reveal_button_press_vm;
    level.scr_anim["world_body_damaged"]["fin_irons_reveal_button_press_finger_loop_vm"] = %fin_irons_reveal_button_press_finger_loop_vm;
    level.scr_anim["world_body_damaged"]["irons_reveal_part2"] = %fin_irons_reveal_part2_player_vm;
    maps\_anim::addnotetrack_flag( "world_body_damaged", "turn_on_light", "turn_on_lights" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged", "fx_arm_glow", maps\finale_fx::exo_release_vm_error_glow, "irons_reveal" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged", "import_empty_fullbody_exo_skel", maps\finale_code::se_irons_reveal_exo, "irons_reveal_part2" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged", "building_explosion", maps\finale_fx::vfx_explosion_rumble_dust, "irons_reveal_part2" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged", "sit_down", maps\finale_lighting::animated_lights, "irons_reveal" );
    maps\_anim::addnotetrack_flag( "world_body_damaged", "sit_down", "flag_sit_down", "irons_reveal" );
    maps\_anim::addnotetrack_flag( "world_body_damaged", "detach_exo", "flag_material_swap_detach_exo", "irons_reveal_part2" );
    maps\_anim::addnotetrack_flag( "world_body_damaged", "confirm_button", "flag_material_swap_confirm_button", "irons_reveal_part2" );
    maps\_anim::addnotetrack_flag( "world_body_damaged", "gideon_error", "flag_material_swap_gideon_error", "irons_reveal_part2" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged", "fov_out", ::notetrack_irons_reveal_lerp_fov_out, "irons_reveal_part2" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged_no_exo", "rumble_light", ::notetrack_rumble_light );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged_no_exo", "rumble_moderate", ::notetrack_rumble_moderate );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged_no_exo", "rumble_heavy", ::notetrack_rumble_heavy );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged_no_exo", "rumble_intense", ::notetrack_rumble_intense );
    level.scr_anim["world_body_damaged_no_exo"]["bridge_takedown"] = %fin_bridge_takedown_start_vm;
    maps\_anim::addnotetrack_customfunction( "world_body_damaged_no_exo", "start_window", ::notetrack_takedown_start_window, "bridge_takedown" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged_no_exo", "start_slo_mo", ::ending_slowmo_start, "bridge_takedown" );
    level.scr_anim["world_body_damaged_no_exo"]["bridge_takedown_fail"] = %fin_bridge_takedown_fail_vm;
    maps\_anim::addnotetrack_customfunction( "world_body_damaged_no_exo", "fade_black", ::bridge_takedown_fail_fade, "bridge_takedown_fail" );
    level.scr_anim["world_body_damaged_no_exo"]["bridge_takedown_success"] = %fin_bridge_takedown_success_vm;
    maps\_anim::addnotetrack_customfunction( "world_body_damaged_no_exo", "end_slo_mo", ::ending_slowmo_end, "bridge_takedown_success" );
    level.scr_anim["world_body"]["irons_end"] = %fin_final_vm;
    level.scr_anim["world_body"]["irons_end_pt2"] = %fin_final_pt2_vm;
    level.scr_anim["world_body"]["rocket_body"] = %finale_rocket_pushback;
    level.scr_anim["world_hands"]["rocket_hands"] = %finale_rocket_pushback_hands;
    level.scr_animtree["world_body_mech"] = #animtree;
    level.scr_model["world_body_mech"] = "vm_world_body_mech";
    level.scr_anim["world_body_mech"]["shaft_both_hands"][0] = %fin_shaft_fall_idle_both_hands_mech_vm;
    level.scr_anim["world_body_mech"]["shaft_left_hand"][0] = %fin_shaft_fall_idle_left_hand_mech_vm;
    level.scr_anim["world_body_mech"]["shaft_no_hands"][0] = %fin_shaft_fall_idle_no_hands_mech_vm;
    level.scr_anim["world_body_mech"]["shaft_no_hands_noloop"] = %fin_shaft_fall_idle_no_hands_mech_vm_noloop;
    level.scr_anim["world_body_mech"]["shaft_right_hand"][0] = %fin_shaft_fall_idle_right_hand_mech_vm;
    level.scr_anim["world_body_damaged_no_exo"]["balcony_finale_pt1"] = %fin_balcony_finale_pt1_vm;
    level.scr_anim["world_body_damaged_no_exo"]["balcony_finale_pt2"] = %fin_balcony_finale_pt2_vm;
    level.scr_anim["world_body_damaged_no_exo"]["balcony_finale_pt2b_idle"] = %fin_balcony_finale_pt3_idle_vm;
    level.scr_anim["world_body_damaged_no_exo"]["balcony_finale_pt2b_success"] = %fin_balcony_finale_pt3_mash_vm;
    level.scr_anim["world_body_damaged_no_exo"]["balcony_finale_pt3_combined"] = %fin_balcony_finale_pt3_combined_vm;
    level.scr_anim["world_body_damaged_no_exo"]["balcony_finale_pt5"] = %fin_balcony_finale_pt5_vm;
    level.scr_goaltime["world_body_damaged_no_exo"]["balcony_finale_pt5"] = 0;
    maps\_anim::addnotetrack_flag( "world_body_damaged_no_exo", "finale_xbutton_mash_start", "flag_xbutton_mash_start", "balcony_finale_pt3_combined" );
    maps\_anim::addnotetrack_flag( "world_body_damaged_no_exo", "finale_xbutton_mash_end", "flag_xbutton_mash_end", "balcony_finale_pt3_combined" );
    maps\_anim::addnotetrack_flag( "world_body_damaged_no_exo", "fin_stab_mash_button", "flag_stab_mash_button_start", "balcony_finale_pt3_combined" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged_no_exo", "vfx_vm_stab_arm", maps\finale_fx::vfx_vm_arm_stab, "balcony_finale_pt5" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged_no_exo", "vfx_vm_sever_arm", maps\finale_fx::vfx_vm_arm_sever, "balcony_finale_pt5" );
    level.scr_anim["world_body_damaged_no_exo"]["balcony_finale_pt6"] = %fin_balcony_finale_pt6_vm;
    maps\_anim::addnotetrack_flag( "world_body_damaged_no_exo", "swap_vm_arm", "flag_arm_severed", "balcony_finale_pt5" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged_no_exo", "start_slomo", ::notetrack_final_part5_success_slomo, "balcony_finale_pt5" );
    maps\_anim::addnotetrack_flag( "world_body_damaged_no_exo", "end_slomo", "flag_part5_success_slomo_stop", "balcony_finale_pt5" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged_no_exo", "swap_vm_arm", ::notrack_final_part5_body_swap, "balcony_finale_pt5" );
    level.scr_anim["world_body_damaged_no_exo"]["balcony_finale_pt1_fail"] = %fin_balcony_finale_pt1_fail_vm;
    level.scr_anim["world_body_damaged_no_exo"]["balcony_finale_pt2_fail"] = %fin_balcony_finale_pt2_fail_vm;
    level.scr_anim["world_body_damaged_no_exo"]["balcony_finale_pt3_fail"] = %fin_balcony_finale_pt3_fail_vm;
    level.scr_anim["world_body_damaged_no_exo"]["balcony_finale_pt4_fail"] = %fin_balcony_finale_pt4_fail_vm;
    level.scr_goaltime["world_body_damaged_no_exo"]["balcony_finale_pt1_fail"] = 0.0;
    level.scr_goaltime["world_body_damaged_no_exo"]["balcony_finale_pt2_fail"] = 0.0;
    level.scr_goaltime["world_body_damaged_no_exo"]["balcony_finale_pt3_fail"] = 0.0;
    level.scr_goaltime["world_body_damaged_no_exo"]["balcony_finale_pt4_fail"] = 0.0;
    maps\_anim::addnotetrack_customfunction( "world_body_damaged_no_exo", "slo_mo_start", ::notetrack_final_fail_slowmo, "balcony_finale_pt2_fail" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged_no_exo", "slo_mo_start", ::notetrack_final_fail_slowmo, "balcony_finale_pt3_fail" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged_no_exo", "slo_mo_start", ::notetrack_final_fail_slowmo, "balcony_finale_pt4_fail" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged_no_exo", "fade_white", ::notetrack_fade_to_white_fail, "balcony_finale_pt2_fail" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged_no_exo", "fade_white", ::notetrack_fade_to_white_fail, "balcony_finale_pt3_fail" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged_no_exo", "fade_white", ::notetrack_fade_to_white_fail, "balcony_finale_pt4_fail" );
    level.scr_anim["world_body_damaged_no_exo"]["balcony_finale_end"] = %fin_balcony_finale_end_vm;
    maps\_anim::addnotetrack_customfunction( "world_body_damaged_no_exo", "fov_change", ::notetrack_fov_end, "balcony_finale_end" );
    maps\_anim::addnotetrack_flag( "world_body_damaged_no_exo", "start_fade", "flag_ending_start_fade" );
}

#using_animtree("generic_human");

load_actor_anims()
{
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
    level.scr_animtree["gideon_mech"] = #animtree;
    level.scr_model["gideon_mech"] = "npc_exo_armor_base";
    level.scr_anim["gideon_mech"]["intro_flyin"] = %fin_mech_flyin_mech;
    level.scr_anim["gideon_mech"]["intro_flyin_idle"][0] = %fin_mech_flyin_wait_idle_mech;
    level.scr_anim["gideon_mech"]["intro_flyin_release"] = %fin_mech_flyin_release_mech;
    level.scr_anim["gideon_mech"]["intro_flyin_idle_test"] = %fin_mech_flyin_wait_idle_mech_rel;

    if ( level.nextgen )
        maps\_anim::addnotetrack_customfunction( "gideon_mech", "vfx_gideon_splash_water", maps\finale_fx::gideon_water_splash, "intro_flyin_release" );
    else
        maps\_anim::addnotetrack_customfunction( "gideon_mech", "vfx_gideon_splash_water", maps\finale_fx::gideon_water_splash_cg, "intro_flyin_release" );

    maps\_anim::addnotetrack_customfunction( "gideon_mech", "vfx_gideon_hit_canal_bottom", maps\finale_fx::gideon_canal_bottom, "intro_flyin_release" );
    level.scr_anim["gideon_mech"]["canal_breach"] = %fin_canal_breach_mech01;
    level.scr_anim["gideon_mech"]["kick_door_enter_mech"] = %fin_kick_door_enter_mech;
    level.scr_anim["gideon_mech"]["kick_door_idle_mech"][0] = %fin_kick_door_idle_mech;
    level.scr_anim["gideon_mech"]["kick_door"] = %fin_kick_door_mech;
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "fx_mech_kick", maps\finale_fx::gideon_door_mech_kick, "kick_door" );
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "rumble_moderate", ::notetrack_rumble_moderate_on_gideon, "kick_door" );
    level.scr_anim["gideon_mech"]["exhaust_hatch_enter"] = %fin_silo_exhaust_hatch_breach_intro_mech;
    level.scr_anim["gideon_mech"]["exhaust_hatch_idle"][0] = %fin_silo_exhaust_hatch_breach_idle_mech;
    level.scr_anim["gideon_mech"]["exhaust_hatch_idle_noloop"] = %fin_silo_exhaust_hatch_breach_idle_mech_noloop;
    level.scr_anim["gideon_mech"]["exhaust_hatch_idle_wave"][0] = %fin_silo_exhaust_hatch_breach_wave_idle_mech;
    level.scr_anim["gideon_mech"]["exhaust_hatch_idle_wave_noloop"] = %fin_silo_exhaust_hatch_breach_wave_idle_mech_noloop;
    level.scr_anim["gideon_mech"]["exhaust_hatch_open"] = %fin_silo_exhaust_hatch_breach_mech;
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "bar_break_gideon", maps\finale_fx::exhaust_hatch_break_gideon, "exhaust_hatch_open" );
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "hatch_open_vfx", maps\finale_fx::exhaust_hatch_open, "exhaust_hatch_open" );
    level.scr_anim["gideon_mech"]["exhaust_hatch_end_idle"][0] = %fin_silo_exhaust_hatch_breach_standing_idle_mech;
    level.scr_anim["gideon_mech"]["exhaust_land"] = %fin_silo_exhaust_shaft_land_mech;
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "vfx_mech_land", maps\finale_fx::exhaust_hatch_land_gideon, "exhaust_land" );
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "aud_countdown_start", ::notetrack_aud_countdown_start, "exhaust_land" );
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "player_control", ::notetrack_player_control, "exhaust_land" );
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "player_blast_react", ::notetrack_player_blast_react, "exhaust_land" );
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "vfx_blast", ::notetrack_vfx_blast, "exhaust_land" );
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "vfx_ignition", ::notetrack_vfx_ignition, "exhaust_land" );
    level.scr_anim["gideon_mech"]["missile_stopped"] = %fin_silo_missle_launch_stopped_gideon;
    level.scr_goaltime["gideon_mech"]["missile_stopped"] = 1.0;
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "rocket_launch_start", ::notetrack_rocket_launch_start, "missile_stopped" );
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "aud_shoot_missile_start", ::notetrack_aud_shoot_missile_start, "missile_stopped" );
    level.scr_anim["gideon_mech"]["missile_stopped_idle"][0] = %fin_silo_missle_launch_stopped_gideon_idle;
    level.scr_anim["gideon_mech"]["missile_launch"] = %fin_silo_missle_launch_stopped_gideon_death;
    level.scr_anim["gideon_mech"]["missile_stopped_vm"] = %fin_silo_missle_launch_stopped_gideon_death;
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "vfx_gideon_mech_sparks", maps\finale_fx::vfx_gideon_mech_sparks );
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "vfx_gideon_rolls_over", maps\finale_fx::vfx_gideon_mech_rolls_over );
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "notetrack_rocket_success_start", maps\finale_lighting::rocket_cine_dof );
    level.scr_anim["gideon"]["mech_exit"] = %fin_exhaust_mech_exit_gideon;
    maps\_anim::addnotetrack_customfunction( "gideon", "gideon_in_frame", maps\finale_lighting::rocket_success_pt2_gideon_in_frame );
    level.scr_anim["gideon"]["drag_pickup01"] = %fin_drag_pickup01_gideon;
    level.scr_anim["gideon"]["drag_pickup02"] = %fin_drag_pickup02_gideon;
    level.scr_anim["gideon"]["drag_putdown"] = %fin_drag_putdown_gideon;
    level.scr_anim["gideon"]["drag_run01"] = %fin_drag_run01_gideon;
    level.scr_anim["gideon"]["drag_run02"] = %fin_drag_run02_gideon;
    level.scr_anim["gideon"]["drag_run03"] = %fin_drag_run03_gideon;
    level.scr_anim["gideon"]["drag_run04"] = %fin_drag_run04_gideon;
    level.scr_anim["gideon"]["drag_cover"][0] = %fin_drag_cover_idle_gideon;
    maps\_anim::addnotetrack_customfunction( "gideon", "pickup", maps\finale_drag::notetrack_drag_cover_pickup, "drag_cover" );
    maps\_anim::addnotetrack_customfunction( "gideon", "dont_pickup", maps\finale_drag::notetrack_drag_cover_dont_pickup, "drag_cover" );
    level.scr_anim["gideon"]["will_reveal"] = %fin_will_reveal_gideon;
    level.scr_anim["irons"]["will_reveal_irons"] = %fin_will_reveal_irons;
    level.scr_anim["guy_bridge_takedown"]["bridge_takedown"] = %fin_bridge_takedown_start_npc;
    level.scr_anim["guy_bridge_takedown"]["bridge_takedown_fail"] = %fin_bridge_takedown_fail_npc;
    level.scr_anim["guy_bridge_takedown"]["bridge_takedown_success"] = %fin_bridge_takedown_success_npc;
    maps\_anim::addnotetrack_customfunction( "guy_bridge_takedown", "vfx_dust_landing_npc", maps\finale_fx::vfx_landing_dust_npc, "bridge_takedown" );
    maps\_anim::addnotetrack_customfunction( "guy_bridge_takedown", "jump_complete", ::bridge_takedown_jump_complete, "bridge_takedown" );
    level.scr_anim["gideon"]["irons_reveal"] = %fin_irons_reveal_npc_gideon;
    level.scr_anim["gideon"]["irons_reveal_part2"] = %fin_irons_reveal_part2_npc_gideon;
    level.scr_anim["gideon"]["irons_reveal_idle"][0] = %fin_irons_reveal_npc_idle_gideon;
    level.scr_anim["gideon"]["irons_reveal_button_idle"][0] = %fin_irons_reveal_npc_button_press_loop_gideon;
    level.scr_anim["irons"]["irons_reveal"] = %fin_irons_reveal_npc_irons;
    maps\_anim::addnotetrack_customfunction( "irons", "press01", maps\finale_code::irons_exo_hack, "irons_reveal" );
    maps\_anim::addnotetrack_customfunction( "irons", "open_glass_door", maps\finale_code::door_irons_reveal_open, "irons_reveal" );
    level.scr_anim["irons"]["irons_run_left_turn_up_stairs"] = %fin_irons_run_left_turn_up_stairs;
    level.scr_anim["irons"]["irons_run_takedown_to_elevator"] = %fin_irons_run_takedown_to_elevator;
    level.scr_anim["irons"]["irons_run_takedown_to_elevator_fail"] = %fin_irons_run_takedown_to_elevator_fail;
    level.scr_anim["irons"]["irons_run_to_elevator_full"] = %fin_irons_run_to_elevator_full;
    maps\_anim::addnotetrack_customfunction( "irons", "close_elevator", ::notetrack_close_elevator_doors, "irons_run_to_elevator_full" );
    level.scr_anim["irons"]["irons_end_idle"][0] = %fin_final_irons_idle;
    level.scr_anim["irons"]["irons_end_look_r"] = %fin_final_irons_look_r;
    level.scr_anim["irons"]["irons_end_look_l"] = %fin_final_irons_look_l;
    level.scr_anim["irons"]["irons_end"] = %fin_final_irons;
    level.scr_goaltime["irons"]["irons_end"] = 1.0;
    level.scr_anim["gideon"]["irons_end"] = %fin_final_gideon;
    level.scr_anim["knox"]["irons_end"] = %fin_final_knox;
    level.scr_anim["irons"]["irons_end_pt2"] = %fin_final_pt2_irons;
    maps\_anim::addnotetrack_customfunction( "irons", "slowMo_start", ::ending_slowmo_start, "irons_end_pt2" );
    maps\_anim::addnotetrack_customfunction( "irons", "slowMo_end", ::ending_slowmo_end, "irons_end_pt2" );
    maps\_anim::addnotetrack_customfunction( "irons", "fade_out_start", ::ending_fade_out, "irons_end_pt2" );
    level.scr_anim["gideon"]["irons_end_pt2"] = %fin_final_pt2_gideon;
    level.scr_anim["knox"]["irons_end_pt2"] = %fin_final_pt2_knox;
    level.scr_anim["irons"]["balcony_finale_pt1"] = %fin_balcony_finale_pt1_npc;
    level.scr_anim["irons"]["balcony_finale_pt2"] = %fin_balcony_finale_pt2_npc;
    maps\_anim::addnotetrack_customfunction( "irons", "vfx_irons_tackle", maps\finale_fx::vfx_irons_tackle, "balcony_finale_pt2" );
    maps\_anim::addnotetrack_customfunction( "irons", "vfx_balcony_break_through", maps\finale_fx::vfx_balcony_break_through, "balcony_finale_pt2" );
    level.scr_anim["irons"]["balcony_finale_pt3_combined"] = %fin_balcony_finale_pt3_combined_npc;
    level.scr_anim["irons"]["balcony_finale_pt5"] = %fin_balcony_finale_pt5_npc;
    level.scr_goaltime["irons"]["balcony_finale_pt5"] = 0;
    maps\_anim::addnotetrack_customfunction( "irons", "vfx_irons_fall", maps\finale_fx::vfx_irons_fall_death, "balcony_finale_pt5" );
    level.scr_anim["irons"]["balcony_finale_pt6"] = %fin_balcony_finale_pt6_npc;
    level.scr_anim["irons"]["balcony_finale_pt1_fail"] = %fin_balcony_finale_pt1_fail_npc;
    level.scr_anim["irons"]["balcony_finale_pt2_fail"] = %fin_balcony_finale_pt2_fail_npc;
    level.scr_anim["irons"]["balcony_finale_pt3_fail"] = %fin_balcony_finale_pt3_fail_npc;
    level.scr_anim["irons"]["balcony_finale_pt4_fail"] = %fin_balcony_finale_pt4_fail_npc;
    level.scr_goaltime["irons"]["balcony_finale_pt1_fail"] = 0.0;
    level.scr_goaltime["irons"]["balcony_finale_pt2_fail"] = 0.0;
    level.scr_goaltime["irons"]["balcony_finale_pt3_fail"] = 0.0;
    level.scr_goaltime["irons"]["balcony_finale_pt4_fail"] = 0.0;
    level.scr_anim["gideon"]["balcony_finale_end"] = %fin_balcony_finale_end_gideon;
}

#using_animtree("script_model");

load_prop_anims( var_0 )
{
    level.scr_animtree["locator"] = #animtree;
    level.scr_model["locator"] = "genericprop";
    level.scr_anim["locator"]["shaft_drop"] = %locator_shaft_falling_anim;
    level.scr_animtree["catwalk_narrow_01"] = #animtree;
    level.scr_model["catwalk_narrow_01"] = "fin_folding_catwalk_01_a";
    level.scr_anim["catwalk_narrow_01"]["catwalk"] = %fin_drawbridge_clamp;
    level.scr_animtree["catwalk_narrow_02"] = #animtree;
    level.scr_model["catwalk_narrow_02"] = "fin_folding_catwalk_01_b";
    level.scr_anim["catwalk_narrow_02"]["catwalk"] = %fin_drawbridge_bar;
    level.scr_animtree["catwalk_wide_01"] = #animtree;
    level.scr_model["catwalk_wide_01"] = "fin_folding_catwalk_02_a";
    level.scr_anim["catwalk_wide_01"]["catwalk"] = %fin_drawbridge_clamp;
    level.scr_animtree["catwalk_wide_02"] = #animtree;
    level.scr_model["catwalk_wide_02"] = "fin_folding_catwalk_02_b";
    level.scr_anim["catwalk_wide_02"]["catwalk"] = %fin_drawbridge_bar;
    level.scr_animtree["missile_main"] = #animtree;
    level.scr_model["missile_main"] = "fin_missile_main_engine_01";
    level.scr_anim["missile_main"]["missile_load"] = %fin_silo_missile_loading_mainmissile;
    level.scr_anim["missile_main"]["missile_launch"] = %fin_silo_missile_launch_fail_mainmissile;
    level.scr_animtree["minigun"] = #animtree;
    level.scr_model["minigun"] = "vm_exo_armor_minigun_base";
    level.scr_anim["minigun"]["missile_stopped_vm"] = %fin_silo_missle_launch_stopped_vm_gun;
    level.scr_anim["minigun"]["missile_launch"] = %fin_silo_missle_launch_stopped_vm_gun;
    level.scr_animtree["missile_01"] = #animtree;
    level.scr_animtree["missile_02"] = #animtree;
    level.scr_animtree["missile_03"] = #animtree;
    level.scr_animtree["missile_04"] = #animtree;
    level.scr_animtree["missile_05"] = #animtree;
    level.scr_animtree["missile_06"] = #animtree;
    level.scr_model["missile_01"] = "fin_side_missile_01";
    level.scr_model["missile_02"] = "fin_side_missile_01";
    level.scr_model["missile_03"] = "fin_side_missile_01";
    level.scr_model["missile_04"] = "fin_side_missile_01";
    level.scr_model["missile_05"] = "fin_side_missile_01";
    level.scr_model["missile_06"] = "fin_side_missile_01";
    level.scr_anim["missile_01"]["missile_load"] = %fin_silo_missile_loading_sidemissile01;
    maps\_anim::addnotetrack_customfunction( "missile_01", "vfx_missile_load_01", maps\finale_fx::vfx_missile_loading, "missile_load" );
    level.scr_anim["missile_02"]["missile_load"] = %fin_silo_missile_loading_sidemissile02;
    level.scr_anim["missile_03"]["missile_load"] = %fin_silo_missile_loading_sidemissile03;
    level.scr_anim["missile_04"]["missile_load"] = %fin_silo_missile_loading_sidemissile04;
    level.scr_anim["missile_05"]["missile_load"] = %fin_silo_missile_loading_sidemissile05;
    level.scr_anim["missile_06"]["missile_load"] = %fin_silo_missile_loading_sidemissile06;
    maps\_anim::addnotetrack_customfunction( "missile_06", "vfx_missile_lock_06", maps\finale_fx::vfx_missile_docking_end, "missile_load" );
    maps\_anim::addnotetrack_customfunction( "missile_06", "catwalk_open", ::silo_catwalks_open, "missile_load" );
    level.scr_animtree["kick_door_l"] = #animtree;
    level.scr_animtree["kick_door_r"] = #animtree;
    level.scr_model["kick_door_l"] = "genericprop";
    level.scr_model["kick_door_r"] = "genericprop";
    level.scr_anim["kick_door_l"]["kick_door"] = %fin_kick_door_door_l;
    level.scr_anim["kick_door_r"]["kick_door"] = %fin_kick_door_door_r;
    maps\_anim::addnotetrack_customfunction( "kick_door_l", "fx_l_door_kick", maps\finale_fx::door_kick_smoke, "kick_door" );
    level.scr_animtree["hatch"] = #animtree;
    level.scr_model["hatch"] = "fin_silo_floor_hatch";
    level.scr_anim["hatch"]["exhaust_hatch_enter"] = %fin_silo_exhaust_hatch_breach_intro_piston_hatch;
    level.scr_anim["hatch"]["exhaust_hatch_idle"][0] = %fin_silo_exhaust_hatch_breach_idle_piston_hatch;
    level.scr_anim["hatch"]["exhaust_hatch_open"] = %fin_silo_exhaust_hatch_breach_breach_piston_hatch;
    level.scr_animtree["piston_r"] = #animtree;
    level.scr_model["piston_r"] = "fin_silo_floor_hatch_piston_r";
    level.scr_anim["piston_r"]["exhaust_hatch_vm_approach"] = %fin_silo_exhaust_hatch_breach_intro_piston_r;
    level.scr_anim["piston_r"]["exhaust_hatch_vm_idle"][0] = %fin_silo_exhaust_hatch_breach_idle_piston_r;
    level.scr_anim["piston_r"]["exhaust_hatch_open"] = %fin_silo_exhaust_hatch_breach_breach_piston_r;
    level.scr_animtree["piston_l"] = #animtree;
    level.scr_model["piston_l"] = "fin_silo_floor_hatch_piston_l";
    level.scr_anim["piston_l"]["exhaust_hatch_enter"] = %fin_silo_exhaust_hatch_breach_intro_piston_l;
    level.scr_anim["piston_l"]["exhaust_hatch_idle"][0] = %fin_silo_exhaust_hatch_breach_idle_piston_l;
    level.scr_anim["piston_l"]["exhaust_hatch_open"] = %fin_silo_exhaust_hatch_breach_breach_piston_l;
    level.scr_animtree["vents"] = #animtree;
    level.scr_model["vents"] = "fin_ventilation_01";
    level.scr_anim["vents"]["exhaust_land_vm"] = %fin_silo_exhaust_shaft_land_mech_vents;
    maps\_anim::addnotetrack_customfunction( "vents", "vfx_open_vent", maps\finale_fx::vfx_open_vent, "exhaust_land_vm" );
    level.scr_animtree["pistol"] = #animtree;
    level.scr_model["pistol"] = "npc_titan45_cutscene";
    level.scr_anim["pistol"]["irons_reveal"] = %fin_irons_reveal_pistol;
    level.scr_animtree["exo"] = #animtree;
    level.scr_model["exo"] = "body_sentinel_exo_ingress";
    level.scr_anim["exo"]["irons_reveal_exo"] = %fin_irons_reveal_npc_empty_exo_fall;
    level.scr_anim["exo"]["irons_reveal_exo_idle"][0] = %fin_irons_reveal_npc_empty_exo_idle;
    level.scr_animtree["irons_pistol"] = #animtree;
    level.scr_model["irons_pistol"] = "npc_titan45_cutscene";
    level.scr_anim["irons_pistol"]["irons_end"] = %fin_final_pistol;
    level.scr_anim["irons_pistol"]["irons_end_pt2"] = %fin_final_pt2_pistol;
    level.scr_animtree["irons_phone"] = #animtree;
    level.scr_model["irons_phone"] = "ironsphone";
    level.scr_animtree["door"] = #animtree;
    level.scr_model["door"] = "fin_body_scanner_door";
    level.scr_anim["door"]["irons_reveal_exit_door"] = %fin_will_room_open_scanner_doors;
    level.scr_animtree["drag_pistol"] = #animtree;
    level.scr_model["drag_pistol"] = "vm_titan45_base_loot";
    level.scr_anim["drag_pistol"]["drag_pickup02"] = %fin_drag_pickup02_gun;
    level.scr_animtree["breach_bomb"] = #animtree;
    level.scr_model["breach_bomb"] = "semx_explosive_mech";
    level.scr_anim["breach_bomb"]["canal_breach"] = %fin_canal_breach_bomb;
    level.scr_animtree["keypad_door"] = #animtree;
    level.scr_model["keypad_door"] = "fin_irons_security_door";
    level.scr_anim["keypad_door"]["irons_run_to_keypad_door"] = %fin_irons_run_to_keypad_door;
    level.scr_animtree["player_knife"] = #animtree;
    level.scr_model["player_knife"] = "npc_mitchell_finale_knife";
    level.scr_anim["player_knife"]["bridge_takedown_success"] = %fin_bridge_takedown_success_knife;
    maps\_anim::addnotetrack_customfunction( "player_knife", "knife_vis_on", ::notetrack_show_takedown_knife );
    level.scr_animtree["balcony"] = #animtree;
    level.scr_model["balcony"] = "fin_railing_roof_03_anim";
    level.scr_anim["balcony"]["balcony_finale_pt2"] = %fin_balcony_finale_pt2_balcony;
    level.scr_animtree["elevator_doors"] = #animtree;
    level.scr_model["elevator_doors"] = "fin_balcony_elevator_door_01";
    level.scr_anim["elevator_doors"]["balcony_finale_pt1_fail_elevator_close"] = %fin_balcony_finale_pt1_fail_elevator_close;
    level.scr_animtree["severed_arm"] = #animtree;
    level.scr_model["severed_arm"] = "s1_gfl_ump45_arm";
    level.scr_anim["severed_arm"]["balcony_finale_pt5"] = %fin_balcony_finale_pt5_vm_arm;
    maps\_anim::addnotetrack_flag( "severed_arm", "vfx_vm_arm_piece_fall", "arm_off" );
    maps\_anim::addnotetrack_customfunction( "severed_arm", "vfx_vm_arm_piece_fall", maps\finale_fx::vfx_arm_piece_fall, "balcony_finale_pt5" );
}

#using_animtree("vehicles");

load_vehicles_anims( var_0 )
{
    level.scr_animtree["helo_intro_gideon"] = #animtree;
    level.scr_model["helo_intro_gideon"] = "vehicle_mil_helicopter_littlebird_drone_ai";
    level.scr_anim["helo_intro_gideon"]["intro_flyin"] = %fin_mech_flyin_littlebird;
    level.scr_anim["helo_intro_gideon"]["intro_flyin_idle"][0] = %fin_mech_flyin_wait_idle_littlebird;
    level.scr_anim["helo_intro_gideon"]["intro_flyin_release"] = %fin_mech_flyin_release_littlebird;
    level.scr_anim["helo_ending_01"]["irons_end"] = %fin_final_razor1;
    level.scr_anim["helo_ending_01"]["irons_end_idle"][0] = %fin_final_razor1_idle;
    level.scr_anim["helo_ending_02"]["irons_end"] = %fin_final_razor2;
    level.scr_anim["helo_ending_02"]["irons_end_idle"][0] = %fin_final_razor2_idle;
}

silo_catwalks_open( var_0 )
{
    common_scripts\utility::flag_set( "flag_silo_watwalks_open" );
}

notetrack_mech_exit_fov_change( var_0 )
{
    var_0.fov_original = getdvarint( "cg_fov" );
    maps\_utility::lerp_fov_overtime( 0.5, 50 );
}

mech_exit_fade_out( var_0 )
{
    var_0 maps\finale_utility::screen_fade_out( 1 );
}

will_reveal_fov_default( var_0 )
{
    level.player lerpfov( 65, 2.5 );
}

bridge_takedown_fail_fade( var_0 )
{
    maps\finale_utility::screen_fade_out( 0 );
}

bridge_takedown_jump_complete( var_0 )
{
    common_scripts\utility::flag_set( "flag_bridge_takedown_jump_complete" );
}

notetrack_takedown_start_window( var_0 )
{
    level notify( "noteworthy_start_window" );
}

ending_slowmo_start( var_0 )
{
    var_0 maps\_utility::slowmo_lerp_in();
    soundscripts\_snd::snd_message( "fin_skybridge_slo_mo_start" );
}

ending_slowmo_end( var_0 )
{
    var_0 maps\_utility::slowmo_lerp_out();
    soundscripts\_snd::snd_message( "fin_skybridge_slo_mo_stop" );
}

ending_fade_out( var_0 )
{
    var_0 maps\finale_utility::screen_fade_out( 3.5 );
}

notetrack_gideon_start( var_0 )
{
    level.player notify( "notetrack_gideon_start" );
}

notetrack_player_blast_react( var_0 )
{
    level.player notify( "notetrack_player_blast_react" );
}

notetrack_player_control( var_0 )
{
    level.player notify( "notetrack_player_control" );
}

notetrack_vfx_blast( var_0 )
{
    level.player notify( "notetrack_vfx_blast" );
    soundscripts\_snd::snd_slate( "notetrack_vfx_blast" );
}

notetrack_vfx_ignition( var_0 )
{
    level.player notify( "notetrack_vfx_ignition" );
    soundscripts\_snd::snd_slate( "notetrack_vfx_ignition" );
}

notetrack_pickup02_fade_in( var_0 )
{
    maps\finale_utility::screen_fade_in( 0.5 );
}

notetrack_pickup02_fade_out( var_0 )
{
    maps\finale_utility::screen_fade_out( 0.5 );
}

notetrack_run01_fade_in( var_0 )
{
    maps\finale_utility::screen_fade_in( 0.5 );
}

notetrack_run01_fade_out( var_0 )
{
    maps\finale_utility::screen_fade_out( 0.5 );
}

notetrack_run02_fade_in( var_0 )
{
    maps\finale_utility::screen_fade_in( 0.5 );
}

notetrack_run02_fade_out( var_0 )
{
    maps\finale_utility::screen_fade_out( 0.5 );
}

notetrack_run03_fade_in( var_0 )
{
    maps\finale_utility::screen_fade_in( 0.5 );
}

notetrack_run03_fade_out( var_0 )
{
    maps\finale_utility::screen_fade_out( 0.5 );
}

notetrack_run04_fade_in( var_0 )
{
    maps\finale_utility::screen_fade_in( 0.5 );
}

notetrack_run04_fade_out( var_0 )
{
    maps\finale_utility::screen_fade_out( 0.5 );
}

notetrack_missile_stopped_vm_fade_out( var_0 )
{
    maps\finale_utility::screen_fade_out( 3 );
}

notetrack_rocket_launch_start( var_0 )
{
    level.player notify( "notetrack_rocket_launch_start" );
    soundscripts\_snd::snd_slate( "notetrack_rocket_launch_start" );
}

notetrack_aud_countdown_start( var_0 )
{
    level.player notify( "notetrack_aud_countdown_start" );
}

notetrack_aud_shoot_missile_start( var_0 )
{
    level.player notify( "notetrack_aud_shoot_missile_start" );
}

notetrack_irons_reveal_lerp_fov_out( var_0 )
{
    level.player lerpfov( 65, 1 );
}

notetrack_close_elevator_doors( var_0 )
{
    var_1 = getent( "fin_balcony_elevator_door_01", "targetname" );
    var_1.animname = "elevator_doors";
    var_1 maps\_utility::assign_animtree();
    var_2 = common_scripts\utility::getstruct( "se_balcony_finale", "script_noteworthy" );
    maps\finale_utility::chase_timer_cancel();
    setdvar( "ui_deadquote", &"FINALE_FAILED_IRONS_CHASE" );
    maps\_utility::missionfailedwrapper();
    var_2 maps\_anim::anim_single_solo( var_1, "balcony_finale_pt1_fail_elevator_close" );
}

notetrack_show_takedown_knife( var_0 )
{
    soundscripts\_snd::snd_message( "bridge_takedown_success" );

    if ( isdefined( level.player_knife ) )
        level.player_knife show();
}

notetrack_final_part5_success_slomo( var_0 )
{
    soundscripts\_snd::snd_message( "fin_ending_slo_mo_override" );
    maps\_utility::slowmo_start();
    maps\_utility::slowmo_setspeed_slow( 0.5 );
    maps\_utility::slowmo_setlerptime_in( 0.5 );
    maps\_utility::slowmo_lerp_in();
    common_scripts\utility::flag_wait( "flag_part5_success_slomo_stop" );
    maps\_utility::slowmo_lerp_out();
}

notrack_final_part5_body_swap( var_0 )
{
    level.player_rig setmodel( "s1_gfl_ump45_viewbody_dismembered" );
}

notetrack_final_fail_slowmo( var_0 )
{
    maps\_utility::slowmo_start();
    maps\_utility::slowmo_setspeed_slow( 0.5 );
    maps\_utility::slowmo_setlerptime_in( 0.5 );
    maps\_utility::slowmo_lerp_in();
}

notetrack_fade_to_white_fail( var_0 )
{
    level.player.strikewhitefade = newclienthudelem( level.player );
    level.player.strikewhitefade.x = 0;
    level.player.strikewhitefade.y = 0;
    level.player.strikewhitefade setshader( "white", 640, 480 );
    level.player.strikewhitefade.alignx = "left";
    level.player.strikewhitefade.aligny = "top";
    level.player.strikewhitefade.horzalign = "fullscreen";
    level.player.strikewhitefade.vertalign = "fullscreen";
    level.player.strikewhitefade.alpha = 0;
    level.player.strikewhitefade fadeovertime( 1.5 );
    level.player.strikewhitefade.alpha = 1;
}

notetrack_fov_end( var_0 )
{
    level.player lerpfov( 50, 1 );
}

notetrack_rumble_light( var_0 )
{
    level.player playrumbleonentity( "damage_light" );
}

notetrack_rumble_moderate( var_0 )
{
    level.player playrumbleonentity( "damage_heavy" );
}

notetrack_rumble_heavy( var_0 )
{
    level.player playrumbleonentity( "light_1s" );
}

notetrack_rumble_intense( var_0 )
{
    level.player playrumbleonentity( "heavy_1s" );
}

notetrack_rumble_moderate_on_gideon( var_0 )
{
    var_1 = distance( level.player.origin, level.gideon.origin );

    if ( var_1 < 75 )
        level.player playrumbleonentity( "heavy_1s" );
    else if ( var_1 < 125 )
        level.player playrumbleonentity( "light_1s" );
    else if ( var_1 < 175 )
        level.player playrumbleonentity( "damage_heavy" );
    else if ( var_1 < 225 )
        level.player playrumbleonentity( "damage_light" );
}
