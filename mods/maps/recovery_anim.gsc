// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    if ( level.nextgen )
        anim.forced_s1_motionset = 1;

    player_anims();
    generic_human();
    script_model_anims();
    vehicle_anims();
    maps\_patrol_anims::main();
}

#using_animtree("player");

player_anims()
{
    level.scr_model["player_rig_funeral"] = "s1_gfl_ump45_viewbody";
    level.scr_animtree["player_rig_funeral"] = #animtree;
    level.scr_anim["player_rig_funeral"]["rec_funeral_altascard_vm"] = %rec_funeral_altascard_vm;
    level.scr_anim["player_rig_funeral"]["rec_funeral_eulogy_ends_vm"] = %rec_funeral_eulogy_ends_vm;
    level.scr_anim["player_rig_funeral"]["rec_funeral_walktocar_vm"] = %rec_funeral_walktocar_vm;
    level.scr_anim["player_rig_funeral"]["rec_funeral_casket_idle_vm"][0] = %rec_funeral_casket_idle_vm;
    level.scr_anim["player_rig_funeral"]["rec_funeral_eulogy_idle_vm"][0] = %rec_funeral_eulogy_idle_vm;
    level.scr_model["player_rig"] = "s1_gfl_ump45_viewbody";
    level.scr_animtree["player_rig"] = #animtree;
    level.scr_anim["player_rig"]["rec_atlas_exo_arm_vm_fullbody"] = %rec_atlas_exo_arm_vm_fullbody;
    level.scr_anim["player_rig"]["rec_atlas_shootingrange_talk_vm"] = %rec_atlas_shootingrange_talk_vm;
    level.scr_anim["player_rig"]["rec_campdavid_intro"] = %rec_campdavid_intro_vm;
    maps\_anim::addnotetrack_customfunction( "player_rig", "vfx_raindrop", maps\recovery_fx::vfx_raindrop, "rec_campdavid_intro" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "gun_up", ::training_s1_intro_gun_up, "rec_campdavid_intro" );
    level.scr_anim["player_rig"]["training_s1_player_end"] = %rec_ending01_vm;
    maps\_anim::addnotetrack_customfunction( "player_rig", "fov_start", ::training_s1_end_fov_start, "training_s1_player_end" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "fov_end", ::training_s1_end_fov_end, "training_s1_player_end" );
    maps\_anim::addnotetrack_flag( "player_rig", "vfx_rain_stops", "training_s1_flag_vfx_rain_stops", "training_s1_player_end" );
    maps\_anim::addnotetrack_flag( "player_rig", "lights_on", "training_s1_flag_lights_on", "training_s1_player_end" );
    maps\_anim::addnotetrack_flag( "player_rig", "wall_interior_decloak", "training_s1_flag_wall_interior_decloak", "training_s1_player_end" );
    maps\_anim::addnotetrack_flag( "player_rig", "trees_decloak", "training_s1_flag_trees_cloak", "training_s1_player_end" );
    maps\_anim::addnotetrack_flag( "player_rig", "doors_open", "training_s1_flag_doors_open", "training_s1_player_end" );
    level.scr_anim["player_rig"]["training_s1_player_end_jeep_enter"] = %rec_ending01_enter_ride_vm;
    level.scr_anim["player_rig"]["training_s2_player_end"] = %rec_ending02_vm;
    level.scr_anim["player_rig"]["training_s2_player_helicopter"] = %rec_ending03_vm;
    maps\_anim::addnotetrack_flag( "player_rig", "fade_out", "outro_start", "training_s2_player_helicopter" );
    level.scr_anim["player_rig"]["rec_tour_ride_a_pt1"][0] = %rec_tour_ride_a_pt1_vm_fullbody;
    level.scr_anim["player_rig"]["rec_tour_ride_b_pt1"][0] = %rec_tour_ride_b_pt1_vm_fullbody;
    level.scr_anim["player_rig"]["rec_tour_ride_c_pt1"] = %rec_tour_ride_c_pt1_vm_fullbody;
    level.scr_anim["player_rig"]["rec_tour_enter_vm"] = %rec_tour_enter_vm;
    level.scr_anim["player_rig"]["rec_tour_exit_vm"] = %rec_tour_exit_vm;
    level.scr_anim["player_rig"]["rec_tour_ride_vm_fullbody"][0] = %rec_tour_ride_vm_fullbody;

    if ( level.nextgen )
        level.scr_model["player_rig_repair"] = "s1_gfl_ump45_viewbody";
    else
        level.scr_model["player_rig_repair"] = "s1_gfl_ump45_viewbody";

    level.scr_animtree["player_rig_repair"] = #animtree;
    level.scr_anim["player_rig_repair"]["rec_exo_arm_repair_attempt_01_vm"] = %rec_exo_arm_repair_attempt_01_vm;
    level.scr_anim["player_rig_repair"]["rec_exo_arm_repair_attempt_02_vm"] = %rec_exo_arm_repair_attempt_02_vm;
    level.scr_anim["player_rig_repair"]["rec_exo_arm_repair_attempt_03_vm"] = %rec_exo_arm_repair_attempt_03_vm;
    level.scr_anim["player_rig_repair"]["rec_exo_arm_repair_attempt_exit_vm"] = %rec_exo_arm_repair_attempt_exit_vm;
    level.scr_anim["player_rig_repair"]["rec_exo_arm_repair_vm"] = %rec_exo_arm_repair_vm;
    maps\_anim::addnotetrack_notify( "player_rig_repair", "npc_snap", "tour_exo_arm_repair_player_looking_at_desk", "rec_exo_arm_repair_vm" );
    level.scr_anim["player_rig"]["training_s1_breach"] = %rec_campdavid_mute_breach_start_vm;
    maps\_anim::addnotetrack_customfunction( "player_rig", "slowmo_start", ::training_s1_breach_slowmo_start, "training_s1_breach" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "gun_up", ::training_s1_breach_gun_up, "training_s1_breach" );
    maps\_anim::addnotetrack_notify( "player_rig", "spwan_joker", "force_joker_breach_position", "training_s1_breach" );
    level.scr_anim["player_rig"]["training_s2_breach"] = %rec_campdavid_exo_breach_start_vm;
    maps\_anim::addnotetrack_customfunction( "player_rig", "slowmo_start", ::training_s2_breach_slowmo_start, "training_s2_breach" );
    level.scr_anim["player_rig"]["rec_atlas_elevator_talk_vm_fullbody"] = %rec_atlas_elevator_talk_vm_fullbody;
}

#using_animtree("generic_human");

generic_human()
{
    level.scr_anim["generic"]["patrol_bored_twitch_salute"] = %patrol_bored_twitch_salute;
    level.scr_anim["generic"]["civilian_stand_idle"][0] = %civilian_stand_idle;
    level.scr_anim["generic"]["civilian_sitting_talking_B_1"][0] = %civilian_sitting_talking_b_1;
    level.scr_anim["generic"]["civilian_sitting_talking_B_2"][0] = %civilian_sitting_talking_b_2;
    level.scr_anim["generic"]["rec_funeral_ceramony_soldier_idle_a_guy01"][0] = %rec_funeral_ceramony_soldier_idle_a_guy01;
    level.scr_anim["generic"]["rec_funeral_ceramony_soldier_idle_a_guy02"][0] = %rec_funeral_ceramony_soldier_idle_a_guy02;
    level.scr_anim["generic"]["rec_funeral_ceramony_soldier_idle_b_guy01"][0] = %rec_funeral_ceramony_soldier_idle_b_guy01;
    level.scr_anim["generic"]["rec_funeral_ceramony_soldier_idle_b_guy02"][0] = %rec_funeral_ceramony_soldier_idle_b_guy02;
    level.scr_anim["generic"]["rec_militery_dressblue_idle_npc1"][0] = %rec_militery_dressblue_idle_npc1;
    level.scr_anim["generic"]["rec_militery_dressblue_idle_npc2"][0] = %rec_militery_dressblue_idle_npc2;
    level.scr_anim["generic"]["rec_militery_dressblue_idle_npc3"][0] = %rec_militery_dressblue_idle_npc3;
    level.scr_anim["generic"]["rec_militery_dressblue_idle_npc4"][0] = %rec_militery_dressblue_idle_npc4;
    level.scr_anim["generic"]["rec_militery_dressblue_idle_npc5"][0] = %rec_militery_dressblue_idle_npc5;
    level.scr_anim["generic"]["rec_militery_dressblue_idle_npc6"][0] = %rec_militery_dressblue_idle_npc6;
    level.scr_anim["generic"]["rec_militery_dressblue_idle_npc7"][0] = %rec_militery_dressblue_idle_npc7;
    level.scr_anim["generic"]["rec_militery_dressblue_idle_npc8"][0] = %rec_militery_dressblue_idle_npc8;
    level.scr_anim["generic"]["rec_militery_dressblue_idle_npc9"][0] = %rec_militery_dressblue_idle_npc9;
    level.scr_anim["generic"]["rec_militery_dressblue_idle_npc10"][0] = %rec_militery_dressblue_idle_npc10;
    level.scr_anim["generic"]["rec_militery_dressblue_idle_npc11"][0] = %rec_militery_dressblue_idle_npc11;
    level.scr_anim["generic"]["rec_militery_dressblue_idle_npc12"][0] = %rec_militery_dressblue_idle_npc12;
    level.scr_anim["generic"]["rec_militery_dressblue_idle_npc13"][0] = %rec_militery_dressblue_idle_npc13;
    level.scr_anim["generic"]["rec_militery_dressblue_idle_npc14"][0] = %rec_militery_dressblue_idle_npc14;
    level.scr_anim["generic"]["rec_funeral_exit_standing_idle_npc_01"][0] = %rec_funeral_exit_standing_idle_npc_01;
    level.scr_anim["generic"]["rec_funeral_exit_standing_idle_npc_02"][0] = %rec_funeral_exit_standing_idle_npc_02;
    level.scr_anim["generic"]["rec_funeral_exit_standing_idle_npc_03"][0] = %rec_funeral_exit_standing_idle_npc_03;
    level.scr_anim["generic"]["rec_funeral_exit_standing_idle_npc_04"][0] = %rec_funeral_exit_standing_idle_npc_04;
    level.scr_anim["generic"]["rec_funeral_exit_standing_idle_npc_05"][0] = %rec_funeral_exit_standing_idle_npc_05;
    level.scr_anim["generic"]["rec_funeral_exit_standing_idle_npc_06"][0] = %rec_funeral_exit_standing_idle_npc_06;
    level.scr_animtree["chair_actor_01"] = #animtree;
    level.scr_animtree["chair_actor_02"] = #animtree;
    level.scr_animtree["chair_actor_03"] = #animtree;
    level.scr_animtree["chair_actor_04"] = #animtree;
    level.scr_animtree["chair_actor_05"] = #animtree;
    level.scr_animtree["chair_actor_06"] = #animtree;
    level.scr_animtree["chair_actor_07"] = #animtree;
    level.scr_animtree["chair_actor_08"] = #animtree;
    level.scr_animtree["standing_actor_01"] = #animtree;
    level.scr_animtree["standing_actor_02"] = #animtree;
    level.scr_animtree["standing_actor_03"] = #animtree;
    level.scr_animtree["standing_actor_04"] = #animtree;
    level.scr_animtree["standing_actor_05"] = #animtree;
    level.scr_animtree["standing_actor_06"] = #animtree;
    level.scr_animtree["standing_actor_07"] = #animtree;
    level.scr_animtree["standing_actor_08"] = #animtree;
    level.scr_animtree["standing_actor_09"] = #animtree;
    level.scr_animtree["standing_actor_10"] = #animtree;
    level.scr_anim["chair_actor_01"]["rec_funeral_eulogy_idle"][0] = %rec_funeral_idle_npc_01;
    level.scr_anim["chair_actor_02"]["rec_funeral_eulogy_idle"][0] = %rec_funeral_idle_npc_02;
    level.scr_anim["chair_actor_03"]["rec_funeral_eulogy_idle"][0] = %rec_funeral_idle_npc_03;
    level.scr_anim["chair_actor_04"]["rec_funeral_eulogy_idle"][0] = %rec_funeral_idle_npc_04;
    level.scr_anim["chair_actor_05"]["rec_funeral_eulogy_idle"][0] = %rec_funeral_idle_npc_05;
    level.scr_anim["chair_actor_06"]["rec_funeral_eulogy_idle"][0] = %rec_funeral_idle_npc_06;
    level.scr_anim["chair_actor_07"]["rec_funeral_eulogy_idle"][0] = %rec_funeral_idle_npc_07;
    level.scr_anim["chair_actor_08"]["rec_funeral_eulogy_idle"][0] = %rec_funeral_idle_npc_08;
    level.scr_anim["standing_actor_01"]["rec_funeral_eulogy_idle"][0] = %rec_funeral_exit_standing_idle_npc_01;
    level.scr_anim["standing_actor_02"]["rec_funeral_eulogy_idle"][0] = %rec_funeral_exit_standing_idle_npc_02;
    level.scr_anim["standing_actor_03"]["rec_funeral_eulogy_idle"][0] = %rec_funeral_exit_standing_idle_npc_03;
    level.scr_anim["standing_actor_04"]["rec_funeral_eulogy_idle"][0] = %rec_funeral_exit_standing_idle_npc_04;
    level.scr_anim["standing_actor_05"]["rec_funeral_eulogy_idle"][0] = %rec_funeral_exit_standing_idle_npc_05;
    level.scr_anim["standing_actor_06"]["rec_funeral_eulogy_idle"][0] = %rec_funeral_exit_standing_idle_npc_06;
    level.scr_anim["standing_actor_07"]["rec_funeral_eulogy_idle"][0] = %rec_funeral_exit_standing_idle_npc_07;
    level.scr_anim["standing_actor_08"]["rec_funeral_eulogy_idle"][0] = %rec_funeral_exit_standing_idle_npc_08;
    level.scr_anim["standing_actor_09"]["rec_funeral_eulogy_idle"][0] = %rec_funeral_exit_standing_idle_npc_09;
    level.scr_anim["standing_actor_10"]["rec_funeral_eulogy_idle"][0] = %rec_funeral_exit_standing_idle_npc_10;
    level.scr_anim["chair_actor_01"]["rec_funeral_eulogy_exit"] = %rec_funeral_exit_npc_01;
    level.scr_anim["chair_actor_02"]["rec_funeral_eulogy_exit"] = %rec_funeral_exit_npc_02;
    level.scr_anim["chair_actor_03"]["rec_funeral_eulogy_exit"] = %rec_funeral_exit_npc_03;
    level.scr_anim["chair_actor_04"]["rec_funeral_eulogy_exit"] = %rec_funeral_exit_npc_04;
    level.scr_anim["chair_actor_05"]["rec_funeral_eulogy_exit"] = %rec_funeral_exit_npc_05;
    level.scr_anim["chair_actor_06"]["rec_funeral_eulogy_exit"] = %rec_funeral_exit_npc_06;
    level.scr_anim["chair_actor_07"]["rec_funeral_eulogy_exit"] = %rec_funeral_exit_npc_07;
    level.scr_anim["chair_actor_08"]["rec_funeral_eulogy_exit"] = %rec_funeral_exit_npc_08;
    level.scr_anim["standing_actor_01"]["rec_funeral_eulogy_exit"] = %rec_funeral_exit_standing_exit_npc_01;
    level.scr_anim["standing_actor_02"]["rec_funeral_eulogy_exit"] = %rec_funeral_exit_standing_exit_npc_02;
    level.scr_anim["standing_actor_03"]["rec_funeral_eulogy_exit"] = %rec_funeral_exit_standing_exit_npc_03;
    level.scr_anim["standing_actor_04"]["rec_funeral_eulogy_exit"] = %rec_funeral_exit_standing_exit_npc_04;
    level.scr_anim["standing_actor_05"]["rec_funeral_eulogy_exit"] = %rec_funeral_exit_standing_exit_npc_05;
    level.scr_anim["standing_actor_06"]["rec_funeral_eulogy_exit"] = %rec_funeral_exit_standing_exit_npc_06;
    level.scr_anim["cormack"]["rec_funeral_eulogy_ends_cormack"] = %rec_funeral_eulogy_ends_cormack;
    level.scr_anim["cormack"]["rec_funeral_walktocar_cormack"] = %rec_funeral_walktocar_cormack;
    level.scr_anim["cormack"]["rec_funeral_altascard_cormack"] = %rec_funeral_altascard_cormack;
    level.scr_anim["cormack"]["rec_funeral_car_idle_cormack"][0] = %rec_funeral_car_idle_cormack;
    level.scr_anim["cormack"]["rec_funeral_casket_idle_cormack"][0] = %rec_funeral_casket_idle_cormack;
    level.scr_anim["cormack"]["rec_funeral_eulogy_idle_cormack"][0] = %rec_funeral_eulogy_idle_cormack;
    level.scr_anim["irons"]["rec_funeral_eulogy_ends_irons"] = %rec_funeral_eulogy_ends_irons;
    level.scr_anim["irons"]["rec_funeral_walktocar_irons"] = %rec_funeral_walktocar_irons;
    level.scr_anim["irons"]["rec_funeral_altascard_irons"] = %rec_funeral_altascard_irons;
    level.scr_anim["irons"]["rec_funeral_car_idle_irons"][0] = %rec_funeral_car_idle_irons;
    level.scr_anim["irons"]["rec_funeral_casket_idle_irons"][0] = %rec_funeral_casket_idle_irons;
    level.scr_anim["irons"]["rec_funeral_eulogy_idle_irons"][0] = %rec_funeral_eulogy_idle_irons;
    level.scr_anim["irons_wife"]["rec_funeral_eulogy_idle_wife"][0] = %rec_funeral_eulogy_idle_wife;
    level.scr_anim["irons_wife"]["rec_funeral_eulogy_ends_wife"] = %rec_funeral_eulogy_ends_wife;
    level.scr_anim["funeral_driver"]["rec_funeral_eulogy_ends_driver"] = %rec_funeral_eulogy_ends_driver;
    level.scr_anim["funeral_driver"]["rec_funeral_walktocar_driver"] = %rec_funeral_walktocar_driver;
    level.scr_anim["funeral_driver"]["rec_funeral_altascard_driver"] = %rec_funeral_altascard_driver;
    level.scr_anim["funeral_driver"]["rec_funeral_car_idle_driver"][0] = %rec_funeral_car_idle_driver;
    level.scr_anim["funeral_driver"]["rec_funeral_casket_idle_driver"][0] = %rec_funeral_casket_idle_driver;
    level.scr_anim["funeral_driver"]["rec_funeral_eulogy_idle_driver"][0] = %rec_funeral_eulogy_idle_driver;
    maps\_anim::addnotetrack_notify( "cormack", "walk_away", "initiate_walk_away", "rec_funeral_eulogy_ends_cormack" );
    level.scr_anim["joker"]["rec_campdavid_intro"] = %rec_campdavid_intro_guy01;
    level.scr_anim["generic"]["CMC_insurgent_cornerLeft_rambo_short"] = %cmc_insurgent_cornerleft_rambo_short;
    level.scr_anim["generic"]["training_s1_flash_guy_in"] = %rec_campdavid_training01_breach01_guy01_in;
    level.scr_anim["generic"]["training_s1_flash_guy_in_idle"][0] = %rec_campdavid_training01_breach01_guy01_idle;
    level.scr_anim["generic"]["training_s1_flash_guy_open"] = %rec_campdavid_training01_breach01_guy01_open;
    level.scr_anim["generic"]["training_s1_flash_guy_open_idle"][0] = %rec_campdavid_training01_breach01_guy01_open_idle;
    level.scr_anim["generic"]["training_s1_flash_guy_out"] = %rec_campdavid_training01_breach01_guy01_out;
    level.scr_anim["generic"]["training_s1_flash_enemy_idle"][0] = %parabolic_leaning_guy_idle;
    maps\_anim::addnotetrack_customfunction( "generic", "head_shot1", ::training_s1_head_shot1, "training_s1_flash_guy_out" );
    level.scr_anim["joker"]["training_s1_threat_guy_in"] = %rec_campdavid_training02_breach01_guy01_in;
    level.scr_anim["joker"]["training_s1_threat_guy_in_idle"][0] = %rec_campdavid_training02_breach01_guy01_idle;
    level.scr_anim["joker"]["training_s1_threat_guy_open"] = %rec_campdavid_training02_breach01_guy01_open;
    level.scr_anim["joker"]["training_s1_threat_guy_open_idle"][0] = %rec_campdavid_training02_breach01_guy01_open_idle;
    level.scr_anim["joker"]["training_s1_threat_guy_open_fire_idle"][0] = %rec_campdavid_training02_breach01_guy01_open_fire_idle;
    level.scr_anim["joker"]["training_s1_threat_guy_open_idle2fire"] = %rec_campdavid_training02_breach01_guy01_open_idle2fire;
    level.scr_anim["joker"]["training_s1_threat_guy_out"] = %rec_campdavid_training02_breach01_guy01_out;
    level.scr_anim["joker"]["training_s1_threat_enemy_idle"][0] = %guarda_sit_sleeper_sleep_idle;
    level.scr_anim["generic"]["training_s1_take_down_enemy"] = %lab_knife_takedown_guy_01;
    level.scr_anim["ally_squad_member_4"]["training_s1_take_down_hero"] = %lab_knife_takedown_hero_01;
    level.scr_anim["joker"]["training_s1_exo_breach_joker_approach"] = %rec_campdavid_mute_breach_approach_guy1;
    level.scr_anim["joker"]["training_s1_exo_breach_joker_start_idle"][0] = %rec_campdavid_mute_breach_start_idle_guy1;
    level.scr_anim["joker"]["training_s1_exo_breach_joker_start"] = %rec_campdavid_mute_breach_start_guy1;
    level.scr_anim["joker"]["training_s1_exo_breach_joker_release"] = %rec_campdavid_mute_breach_release_guy1;
    level.scr_anim["joker"]["training_s1_exo_breach_joker_release_idle"][0] = %rec_campdavid_mute_breach_release_idle_guy1;
    level.scr_anim["joker"]["training_s1_exo_breach_joker_shoot_bathroom_guy"] = %rec_campdavid_mute_breach_fire_guy1;
    maps\_anim::addnotetrack_flag( "joker", "fire", "training_s1_flag_bathroom_guy_shot", "training_s1_exo_breach_joker_shoot_bathroom_guy" );
    level.scr_anim["president"]["training_s1_exo_breach_president_start"] = %rec_campdavid_mute_breach_start_pres;
    level.scr_anim["president"]["training_s1_exo_breach_president_idle"][0] = %rec_campdavid_mute_breach_react_idle_pres;
    level.scr_anim["president"]["training_s1_exo_breach_president_success"] = %rec_campdavid_mute_breach_success_pres;
    level.scr_anim["president"]["training_s1_exo_breach_president_fail"] = %rec_campdavid_mute_breach_fail_pres;
    level.scr_anim["president"]["training_s1_exo_breach_president_release_idle"][0] = %rec_campdavid_mute_breach_release_idle_pres;
    level.scr_anim["president"]["training_s1_exo_breach_president_release"] = %rec_campdavid_mute_breach_release_pres1;
    level.scr_anim["generic"]["training_s1_exo_breach_kva1_start"] = %rec_campdavid_mute_breach_start_kva1;
    level.scr_anim["generic"]["training_s1_exo_breach_kva1_idle"][0] = %rec_campdavid_mute_breach_react_idle_kva1;
    level.scr_anim["generic"]["training_s1_exo_breach_kva1_success"] = %rec_campdavid_mute_breach_success_kva1;
    level.scr_anim["generic"]["training_s1_exo_breach_kva1_fail"] = %rec_campdavid_mute_breach_fail_kva1;
    maps\_anim::addnotetrack_flag( "generic", "fire", "training_s1_flag_president_shot", "training_s1_exo_breach_kva1_fail" );
    level.scr_anim["generic"]["training_s1_exo_breach_kva2_start"] = %rec_campdavid_mute_breach_start_kva2;
    level.scr_anim["generic"]["training_s1_exo_breach_kva2_death"] = %rec_campdavid_mute_breach_start_death_kva2;
    level.scr_anim["generic"]["training_s1_exo_breach_kva3_start"] = %rec_campdavid_mute_breach_start_kva3;
    maps\_anim::addnotetrack_flag( "generic", "hit_wall", "training_s1_flag_screen_smash", "training_s1_exo_breach_kva3_start" );
    level.scr_anim["kva"]["training_s1_exo_breach_kva_bathroom_start"] = %rec_campdavid_mute_breach_bathroom_kva3;
    level.scr_anim["kva"]["training_s1_exo_breach_kva_bathroom_idle"][0] = %rec_campdavid_mute_breach_bathroom_fire_idle_kva3;
    level.scr_anim["kva"]["training_s1_exo_breach_kva_bathroom_death"] = %rec_campdavid_mute_breach_bathroom_fire_death_kva3;
    level.scr_anim["president"]["training_s2_exo_breach_president_react"] = %rec_campdavid_exo_breach_react_pres;
    level.scr_anim["president"]["training_s2_exo_breach_president_react_idle"][0] = %rec_campdavid_exo_breach_react_idle_pres;
    level.scr_anim["president"]["training_s2_exo_breach_president_fail"] = %rec_campdavid_exo_breach_fail_pres;
    level.scr_anim["president"]["training_s2_exo_breach_president_success"] = %rec_campdavid_exo_breach_success_pres;
    level.scr_anim["president"]["training_s2_exo_breach_president_release"] = %rec_campdavid_exo_breach_release_pres;
    level.scr_anim["president"]["training_s2_exo_breach_president_release_idle"][0] = %rec_campdavid_exo_breach_release_idle_pres;
    level.scr_anim["generic"]["training_s2_exo_breach_kva1_react"] = %rec_campdavid_exo_breach_react_kva1;
    level.scr_anim["generic"]["training_s2_exo_breach_kva1_react_idle"][0] = %rec_campdavid_exo_breach_react_idle_kva1;
    level.scr_anim["generic"]["training_s2_exo_breach_kva1_fail"] = %rec_campdavid_exo_breach_fail_kva1;
    level.scr_anim["generic"]["training_s2_exo_breach_kva1_success"] = %rec_campdavid_exo_breach_success_kva1;
    maps\_anim::addnotetrack_flag( "generic", "fire", "training_s2_flag_president_shot", "training_s2_exo_breach_kva1_fail" );
    level.scr_anim["generic"]["training_s2_exo_breach_kva2_start"] = %rec_campdavid_exo_breach_react_idle_kva2;
    level.scr_anim["generic"]["training_s2_exo_breach_kva3_start"] = %rec_campdavid_exo_breach_react_idle_kva3;
    level.scr_anim["gideon"]["training_s2_exo_breach_gideon_approach"] = %rec_campdavid_mute_breach_approach_guy1;
    level.scr_anim["gideon"]["training_s2_exo_breach_gideon_start_idle"][0] = %rec_campdavid_mute_breach_start_idle_guy1;
    level.scr_anim["gideon"]["training_s2_exo_breach_gideon_release"] = %rec_campdavid_exo_breach_release_guy1;
    level.scr_anim["joker"]["training_s1_patio_joker_door_in"] = %rec_campdavid_doubledoor_bust_open_in_guy1;
    level.scr_anim["joker"]["training_s1_patio_joker_door_idle"][0] = %rec_campdavid_doubledoor_bust_open_idle_guy1;
    level.scr_anim["joker"]["training_s1_patio_joker_door_out"] = %rec_campdavid_doubledoor_bust_open_out_guy1;
    level.scr_anim["joker"]["training_s1_patio_joker_door_alert_idle"][0] = %rec_campdavid_doubledoor_bust_open_alert_idle_guy1;
    level.scr_anim["joker"]["training_s1_patio_joker_door_slow_open"] = %rec_campdavid_doubledoor_slow_open_door_guy1;
    level.scr_anim["joker"]["training_s1_patio_joker_door_slow_idle"][0] = %rec_campdavid_doubledoor_slow_open_idle_guy1;
    level.scr_anim["joker"]["training_s1_patio_joker_door_slow_in"] = %rec_campdavid_doubledoor_slow_open_in_guy1;
    level.scr_anim["joker"]["training_s1_patio_joker_door_slow_out"] = %rec_campdavid_doubledoor_slow_open_out_guy1;
    level.scr_anim["gideon"]["training_s2_patio_gideon_door_idle"][0] = %rec_campdavid_doubledoor_bust_open_idle_guy1;
    level.scr_anim["gideon"]["training_s2_patio_gideon_door_in"] = %rec_campdavid_doubledoor_bust_open_in_guy1;
    level.scr_anim["gideon"]["training_s2_patio_gideon_door_out"] = %rec_campdavid_doubledoor_bust_open_out_guy1;
    level.scr_anim["gideon"]["training_s1_gideon_end"] = %rec_ending01_gideon;
    maps\_anim::addnotetrack_customfunction( "gideon", "fire", maps\recovery_fx::training_s1_president_blood, "training_s1_gideon_end" );
    maps\_anim::addnotetrack_customfunction( "gideon", "fire", maps\recovery_fx::wind_gate_open, "training_s1_gideon_end" );
    maps\_anim::addnotetrack_customfunction( "gideon", "fire", maps\recovery_utility::gideon_change_mask, "training_s1_gideon_end" );
    maps\_anim::addnotetrack_customfunction( "gideon", "gideon_hit_vfx", maps\recovery_fx::training_escape_gideon_punch, "training_s1_gideon_end" );
    maps\_anim::addnotetrack_flag( "gideon", "fire", "flag_obj_rescue1_complete", "training_s1_gideon_end" );
    level.scr_anim["gideon"]["training_s1_gideon_end_enter"] = %rec_ending01_enter_ride_gideon;
    level.scr_anim["gideon"]["training_s1_gideon_end_idle"][0] = %rec_ending01_gideon_idle;
    level.scr_anim["irons"]["training_s1_irons_end"] = %rec_ending01_irons;
    level.scr_anim["irons"]["training_s1_irons_end_idle"][0] = %rec_ending01_irons_idle;
    level.scr_anim["president"]["training_s1_president_end"] = %rec_ending01_victim;
    level.scr_anim["president"]["training_s1_president_end_idle"][0] = %rec_ending01_idle_victim;
    level.scr_anim["driver"]["training_s1_driver_end"] = %rec_ending01_driver;
    level.scr_anim["driver"]["training_s1_driver_end_enter"] = %rec_ending01_enter_ride_driver;
    level.scr_anim["driver"]["training_s1_driver_end_idle"][0] = %rec_ending01_idle_driver;
    level.scr_anim["driver"]["training_s2_driver_end_drivein"] = %rec_ending02_driver_drivein;
    level.scr_anim["driver"]["training_s2_driver_end_driveout"] = %rec_ending02_driver;
    level.scr_anim["president"]["training_s2_president_end"] = %rec_ending02_president;
    level.scr_anim["gideon"]["training_s2_gideon_helicopter"] = %rec_ending03_gideon;
    level.scr_anim["irons"]["training_s2_irons_helicopter_landing"] = %rec_ending03_landing_irons;
    level.scr_anim["irons"]["training_s2_irons_helicopter_idle"][0] = %rec_ending03_idle_irons;
    level.scr_anim["irons"]["training_s2_irons_helicopter"] = %rec_ending03_irons;
    level.scr_anim["driver"]["rec_tour_ride_a_pt1"][0] = %rec_tour_ride_a_pt1_driver;
    level.scr_anim["driver"]["rec_tour_ride_a_pt2"] = %rec_tour_ride_a_pt2_driver;
    level.scr_anim["driver"]["rec_tour_ride_b_pt1"][0] = %rec_tour_ride_b_pt1_driver;
    level.scr_anim["driver"]["rec_tour_ride_b_pt2"] = %rec_tour_ride_b_pt2_driver;
    level.scr_anim["driver"]["rec_tour_ride_c_pt1"] = %rec_tour_ride_c_pt1_driver;
    level.scr_anim["driver"]["rec_tour_ride_c_pt2"][0] = %rec_tour_ride_c_pt2_driver;
    level.scr_anim["gideon"]["rec_tour_ride_a_pt1"][0] = %rec_tour_ride_a_pt1_gideon;
    level.scr_anim["gideon"]["rec_tour_ride_a_pt2"] = %rec_tour_ride_a_pt2_gideon;
    level.scr_anim["gideon"]["rec_tour_ride_b_pt1"][0] = %rec_tour_ride_b_pt1_gideon;
    level.scr_anim["gideon"]["rec_tour_ride_b_pt2"] = %rec_tour_ride_b_pt2_gideon;
    level.scr_anim["gideon"]["rec_tour_ride_c_pt1"] = %rec_tour_ride_c_pt1_gideon;
    level.scr_anim["gideon"]["rec_tour_ride_c_pt2"][0] = %rec_tour_ride_c_pt2_gideon;
    level.scr_anim["gideon"]["rec_tour_ride_c_pt3"] = %rec_tour_ride_c_pt3_gideon;
    level.scr_anim["gideon"]["rec_tour_ride_gideon_dialogue_gideon"] = %rec_tour_ride_gideon_dialogue_gideon;
    level.scr_anim["irons"]["rec_tour_ride_a_pt1"][0] = %rec_tour_ride_a_pt1_irons;
    level.scr_anim["irons"]["rec_tour_ride_a_pt2"] = %rec_tour_ride_a_pt2_irons;
    level.scr_anim["irons"]["rec_tour_ride_b_pt1"][0] = %rec_tour_ride_b_pt1_irons;
    level.scr_anim["irons"]["rec_tour_ride_b_pt2"] = %rec_tour_ride_b_pt2_irons;
    level.scr_anim["irons"]["rec_tour_ride_c_pt1"] = %rec_tour_ride_c_pt1_irons;
    level.scr_anim["irons"]["rec_tour_ride_c_pt2"][0] = %rec_tour_ride_c_pt2_irons;
    maps\_anim::addnotetrack_notify( "irons", "Iron_turns", "jeep_ride_irons_talk_start", "rec_tour_ride_a_pt2" );
    maps\_anim::addnotetrack_notify( "irons", "aud_end_rec_tour_ride_a_pt2_irons", "jeep_ride_irons_talk_stop", "rec_tour_ride_a_pt2" );
    maps\_anim::addnotetrack_notify( "irons", "iron_turns", "jeep_ride_irons_talk_start", "rec_tour_ride_b_pt2" );
    maps\_anim::addnotetrack_notify( "irons", "aud_end_rec_tour_ride_b_pt2_irons", "jeep_ride_irons_talk_stop", "rec_tour_ride_b_pt2" );
    level.scr_anim["driver"]["tour_jeep_idle"][0] = %rec_tour_ride_driver;
    level.scr_anim["gideon"]["tour_jeep_idle"][0] = %rec_tour_ride_gideon;
    level.scr_anim["irons"]["tour_jeep_idle"][0] = %rec_tour_ride_irons;
    level.scr_anim["driver"]["rec_tour_exit"] = %rec_tour_exit_driver;
    level.scr_anim["gideon"]["rec_tour_exit"] = %rec_tour_exit_gideon;
    level.scr_anim["irons"]["rec_tour_exit"] = %rec_tour_exit_irons;
    level.scr_anim["driver"]["rec_tour_ride_a_look_L_driver"] = %rec_tour_ride_a_look_l_driver;
    level.scr_anim["driver"]["rec_tour_ride_a_look_R_driver"] = %rec_tour_ride_a_look_r_driver;
    level.scr_anim["driver"]["rec_tour_ride_b_look_L_driver"] = %rec_tour_ride_b_look_l_driver;
    level.scr_anim["driver"]["rec_tour_ride_b_look_R_driver"] = %rec_tour_ride_b_look_r_driver;
    level.scr_anim["generic"]["patrol_walk_casual_urgent"][0] = %bet_unarmed_casual_walk01_gideon;
    level.scr_anim["generic"]["patrol_transin_casual_urgent"] = %bet_casual_startstop_walk_to_idle_gideon;
    level.scr_anim["generic"]["patrol_transout_casual_urgent"] = %bet_casual_startstop_idle_to_walk_gideon;
    level.scr_anim["generic"]["patrol_idle_casual_urgent"][0] = %bet_casual_startstop_idle_gideon;
    level.scr_anim["gideon"]["rec_shooting_stairs_down_guy01"] = %rec_shooting_stairs_down_guy01;
    level.scr_anim["gideon"]["rec_shooting_stairs_up_guy01"] = %rec_shooting_stairs_up_guy01;
    level.scr_anim["gideon"]["rec_readyroom_seq"] = %rec_readyroom_stairs_down_guy01;
    level.scr_anim["gideon"]["rec_readyroom_idle_guy01"][0] = %rec_readyroom_idle_guy01;
    level.scr_anim["gideon"]["rec_readyroom_up_guy01"] = %rec_readyroom_up_guy01;
    maps\_anim::addnotetrack_notify( "gideon", "elevator_button_pressed", "gideon_presses_elevator_button", "rec_readyroom_seq" );
    level.scr_anim["generic"]["civilian_stand_idle"][0] = %civilian_stand_idle;
    level.scr_anim["generic"]["civilian_walk_cool"] = %civilian_walk_cool;
    level.scr_anim["generic"]["cliffhanger_welder_engine"][0] = %cliffhanger_welder_engine;
    level.scr_anim["generic"]["cliffhanger_welder_engine"][1] = %cliffhanger_welder_engine_twitch_1;
    level.scr_anim["generic"]["cliffhanger_welder_engine"][2] = %cliffhanger_welder_engine_twitch_2;
    level.scr_anim["generic"]["stand_alertb_idle1"][0] = %stand_alertb_idle1;
    level.scr_anim["generic"]["training_intro_foley_idle_1"][0] = %training_intro_foley_idle_1;
    level.scr_anim["generic"]["patrol_bored_idle"][0] = %patrol_bored_idle;
    level.scr_anim["generic"]["patrolstand_idle"][0] = %patrolstand_idle;
    level.scr_anim["generic"]["casual_stand_idle"][0] = %casual_stand_idle;
    level.scr_anim["generic"]["casual_crouch_idle"][0] = %casual_crouch_idle;
    level.scr_anim["generic"]["bet_ceremony_security_idle_guy01"][0] = %bet_ceremony_security_idle_guy01;
    level.scr_anim["generic"]["bet_ceremony_security_idle_guy02"][0] = %bet_ceremony_security_idle_guy02;
    level.scr_anim["generic"]["active_patrolwalk_gundown"] = %active_patrolwalk_gundown;
    level.scr_anim["generic"]["training_jog_guy1"] = %training_jog_guy1;
    level.scr_anim["generic"]["training_jog_guy2"] = %training_jog_guy2;
    level.scr_anim["exo_observer_01"]["rec_atlas_exo_observe_idle"][0] = %rec_atlas_spectator_idle_guy01;
    level.scr_anim["exo_observer_02"]["rec_atlas_exo_observe_idle"][0] = %rec_atlas_spectator_idle_guy02;
    level.scr_anim["exo_observer_03"]["rec_atlas_exo_observe_idle"][0] = %rec_atlas_spectator_idle_guy03;
    level.scr_anim["exo_observer_04"]["rec_atlas_exo_observe_idle"][0] = %rec_atlas_spectator_idle_guy04;
    level.scr_anim["generic"]["rec_atlas_spectator_idle_guy01"][0] = %rec_atlas_spectator_idle_guy01;
    level.scr_anim["generic"]["rec_atlas_spectator_idle_guy02"][0] = %rec_atlas_spectator_idle_guy02;
    level.scr_anim["generic"]["rec_atlas_spectator_idle_guy03"][0] = %rec_atlas_spectator_idle_guy03;
    level.scr_anim["generic"]["rec_atlas_spectator_idle_guy04"][0] = %rec_atlas_spectator_idle_guy04;
    level.scr_anim["generic"]["rec_atlas_push_lab_idle_01"][0] = %rec_atlas_push_lab_idle_01;
    level.scr_anim["generic"]["rec_atlas_push_lab_idle_02"][0] = %rec_atlas_push_lab_idle_02;
    level.scr_anim["generic"]["rec_atlas_push_lab_idle_03"][0] = %rec_atlas_push_lab_idle_03;
    level.scr_anim["pusher_1"]["rec_atlas_push_idle"][0] = %rec_atlas_push_idle_guy01;
    level.scr_anim["pusher_2"]["rec_atlas_push_idle"][0] = %rec_atlas_push_idle_guy02;
    maps\_anim::addnotetrack_notify( "pusher_1", "push_guy01", "initiate_push_01", "rec_atlas_push_idle" );
    maps\_anim::addnotetrack_notify( "pusher_2", "push_guy02", "initiate_push_02", "rec_atlas_push_idle" );
    maps\_anim::addnotetrack_notify( "pusher_2", "start", "start_anim_push_02", "rec_atlas_push_idle" );
    level.scr_anim["climber_1"]["rec_atlas_climb_idle_guy02"][0] = %rec_atlas_climb_idle_guy02;
    level.scr_anim["climber_1"]["rec_atlas_climb_guy02"] = %rec_atlas_climb_guy02;
    level.scr_anim["wrestler_1"]["rec_atlas_wrestling_idle"] = %rec_atlas_wrestling_idle_guy01;
    maps\_anim::addnotetrack_notify( "wrestler_1", "shows_over", "notify_vo_shows_over", "rec_atlas_wrestling_idle" );
    level.scr_anim["wrestler_2"]["rec_atlas_wrestling_idle"] = %rec_atlas_wrestling_idle_guy02;
    level.scr_anim["wrestler_3"]["rec_atlas_wrestling_idle"] = %rec_atlas_wrestling_idle_guy03;
    level.scr_anim["wrestler_4"]["rec_atlas_wrestling_idle"] = %rec_atlas_wrestling_idle_guy04;
    level.scr_anim["wrestler_5"]["rec_atlas_wrestling_idle"] = %rec_atlas_wrestling_idle_guy05;
    level.scr_anim["wrestler_1"]["rec_atlas_warmup_idle"][0] = %rec_atlas_warmup_idle_guy01;
    level.scr_anim["wrestler_2"]["rec_atlas_warmup_idle"][0] = %rec_atlas_warmup_idle_guy02;
    level.scr_anim["wrestler_3"]["rec_atlas_warmup_idle"][0] = %rec_atlas_warmup_idle_guy03;
    level.scr_anim["wrestler_4"]["rec_atlas_warmup_idle"][0] = %rec_atlas_warmup_idle_guy04;
    level.scr_anim["wrestler_5"]["rec_atlas_warmup_idle"][0] = %rec_atlas_warmup_idle_guy05;
    level.scr_anim["shielder_1"]["rec_exo_shield_intro"] = %rec_exo_shield_intro_npc;
    level.scr_anim["shielder_1"]["rec_exo_shield_idle"][0] = %rec_exo_shield_idle_npc;
    maps\_anim::addnotetrack_flag( "shielder_1", "shoot_start", "flag_shield_turret_shooting", "rec_exo_shield_intro" );
    maps\_anim::addnotetrack_flag_clear( "shielder_1", "shoot_end", "flag_shield_turret_shooting", "rec_exo_shield_intro" );
    maps\_anim::addnotetrack_flag( "shielder_1", "shoot_start", "flag_shield_turret_shooting", "rec_exo_shield_idle" );
    maps\_anim::addnotetrack_flag_clear( "shielder_1", "shoot_end", "flag_shield_turret_shooting", "rec_exo_shield_idle" );
    level.scr_anim["gideon"]["rec_exo_arm_repair_readyroom_gideon_idle_in"] = %rec_exo_arm_repair_readyroom_gideon_idle_in;
    level.scr_anim["gideon"]["rec_exo_arm_repair_readyroom_gideon_idle"][0] = %rec_exo_arm_repair_readyroom_gideon_idle;
    level.scr_anim["gideon"]["rec_exo_arm_repair_readyroom_gideon_idle_out"] = %rec_exo_arm_repair_readyroom_gideon_idle_out;
    level.scr_anim["repairer_1"]["rec_exo_repair_idle"][0] = %rec_exo_idle_scientist01;
    level.scr_anim["repairer_2"]["rec_exo_repair_idle"][0] = %rec_exo_idle_scientist02;
    level.scr_anim["repairer_1"]["rec_exo_repair"] = %rec_exo_repair_scientist01;
    level.scr_anim["repairer_2"]["rec_exo_repair"] = %rec_exo_repair_scientist02;
    level.scr_anim["repairer_1"]["rec_exo_arm_repair_attempt_01_npc"] = %rec_exo_arm_repair_attempt_01_npc;
    level.scr_anim["repairer_1"]["rec_exo_arm_repair_attempt_02_npc"] = %rec_exo_arm_repair_attempt_02_npc;
    level.scr_anim["repairer_1"]["rec_exo_arm_repair_attempt_03_npc"] = %rec_exo_arm_repair_attempt_03_npc;
    level.scr_anim["repairer_1"]["rec_exo_arm_repair_attempt_exit_npc"] = %rec_exo_arm_repair_attempt_exit_npc;
    level.scr_anim["repairer_1"]["rec_exo_arm_repair_attempt_response_idle_01_npc"][0] = %rec_exo_arm_repair_attempt_response_idle_01_npc;
    level.scr_anim["repairer_1"]["rec_exo_arm_repair_attempt_response_idle_02_npc"][0] = %rec_exo_arm_repair_attempt_response_idle_02_npc;
    level.scr_anim["repairer_1"]["rec_exo_arm_repair_attempt_response_idle_03_npc"][0] = %rec_exo_arm_repair_attempt_response_idle_03_npc;
    level.scr_anim["repairer_1"]["rec_exo_arm_repair_npc"] = %rec_exo_arm_repair_npc;
    level.scr_anim["repairer_1"]["rec_exo_arm_repair_standing_idle_guy"][0] = %rec_exo_arm_repair_standing_idle_guy_01;
    level.scr_anim["repairer_2"]["rec_exo_arm_repair_standing_idle_guy"][0] = %rec_exo_arm_repair_standing_idle_guy_02;
    level.scr_anim["repairer_1"]["rec_exo_arm_repair_table_idle_guy"][0] = %rec_exo_arm_repair_table_idle_guy_01;
    level.scr_anim["repairer_2"]["rec_exo_arm_repair_table_idle_guy"][0] = %rec_exo_arm_repair_table_idle_guy_02;
    level.scr_anim["repairer_1"]["rec_exo_arm_repair_walk2table_guy"] = %rec_exo_arm_repair_walk2table_guy_01;
    level.scr_anim["repairer_2"]["rec_exo_arm_repair_walk2table_guy"] = %rec_exo_arm_repair_walk2table_guy_02;
    level.scr_anim["ilona"]["rec_atlas_shootingrange_talk_ilona"] = %rec_atlas_shootingrange_talk_ilana;
    level.scr_anim["ilona"]["rec_atlas_shootingrange_ilona_idle01"][0] = %rec_atlas_shootingrange_ilana_idle01;
    level.scr_anim["ilona"]["rec_atlas_shootingrange_ilona_idle02"][0] = %rec_atlas_shootingrange_ilana_idle02;
    level.scr_anim["ilona"]["rec_atlas_shootingrange_ilana_look_idle"][0] = %rec_atlas_shootingrange_ilana_look_idle;
    level.scr_anim["ilona"]["rec_atlas_shootingrange_ilana_screen_idle"][0] = %rec_atlas_shootingrange_ilana_screen_idle;
    level.scr_anim["ilona"]["rec_atlas_shootingrange_ilana_screentolook"] = %rec_atlas_shootingrange_ilana_screentolook;
    level.scr_anim["ilona"]["rec_atlas_shootingrange_ilana_looktoscreen"] = %rec_atlas_shootingrange_ilana_looktoscreen;
    maps\_anim::addnotetrack_customfunction( "ilona", "turn_yes", ::ilona_can_turn, "rec_atlas_shootingrange_ilana_look_idle" );
    maps\_anim::addnotetrack_customfunction( "ilona", "turn_no", ::ilona_cannot_turn, "rec_atlas_shootingrange_ilana_look_idle" );
    maps\_anim::addnotetrack_customfunction( "ilona", "turn_yes", ::ilona_can_turn, "rec_atlas_shootingrange_ilana_screen_idle" );
    maps\_anim::addnotetrack_customfunction( "ilona", "turn_no", ::ilona_cannot_turn, "rec_atlas_shootingrange_ilana_screen_idle" );
    level.scr_anim["gideon"]["rec_atlas_shootingrange_gideon_talk"] = %rec_atlas_shootingrange_gideon_talk;
    level.scr_anim["gideon"]["rec_atlas_shootingrange_gideon_idle02"][0] = %rec_atlas_shootingrange_gideon_idle02;
    level.scr_anim["gideon"]["rec_atlas_shootingrange_gideon_exit"] = %rec_atlas_shootingrange_gideon_exit;
    level.scr_anim["gideon"]["rec_aug_threatgrenade_gideon_in"] = %rec_aug_threatgrenade_gideon_in;
    level.scr_anim["gideon"]["rec_aug_threatgrenade_gideon_out"] = %rec_aug_threatgrenade_gideon_out;
    level.scr_anim["gideon"]["rec_aug_threatgrenade_gideon_idle"][0] = %rec_aug_threatgrenade_gideon_idle;
    maps\_anim::addnotetrack_customfunction( "gideon", "can_exit", ::gideon_can_exit_range, "rec_aug_threatgrenade_gideon_idle" );
    maps\_anim::addnotetrack_customfunction( "gideon", "cannot_exit", ::gideon_cannot_exit_range, "rec_aug_threatgrenade_gideon_idle" );
    level.scr_anim["gideon"]["rec_atlas_elevator_talk_gideon"] = %rec_atlas_elevator_talk_gideon;
    level.scr_anim["gideon"]["rec_atlas_elevator_idle01_gideon"][0] = %rec_atlas_elevator_idle01_gideon;
    level.scr_anim["gideon"]["rec_atlas_elevator_idle02_gideon"][0] = %rec_atlas_elevator_idle02_gideon;
}

#using_animtree("script_model");

script_model_anims()
{
    level.scr_animtree["funeral_flag"] = #animtree;
    level.scr_model["funeral_flag"] = "genericprop";
    level.scr_anim["funeral_flag"]["rec_funeral_eulogy_ends_flag"] = %rec_funeral_eulogy_ends_flag;
    level.scr_anim["funeral_flag"]["rec_funeral_eulogy_idle_flag"][0] = %rec_funeral_eulogy_idle_flag;
    level.scr_anim["funeral_flag"]["rec_funeral_eulogy_idle_flag_non_loop"] = %rec_funeral_eulogy_idle_flag;
    level.scr_animtree["marine_pin_cormack"] = #animtree;
    level.scr_model["marine_pin_cormack"] = "genericprop";
    level.scr_anim["marine_pin_cormack"]["rec_funeral_eulogy_ends_cormack_pin"] = %rec_funeral_eulogy_ends_cormack_pin;
    level.scr_animtree["marine_pin_player"] = #animtree;
    level.scr_model["marine_pin_player"] = "genericprop";
    level.scr_anim["marine_pin_player"]["rec_funeral_walktocar_vm_pin"] = %rec_funeral_walktocar_vm_pin;
    level.scr_animtree["atlas_card"] = #animtree;
    level.scr_model["atlas_card"] = "genericprop";
    level.scr_anim["atlas_card"]["rec_funeral_altascard_card"] = %rec_funeral_altascard_card;
    maps\_anim::addnotetrack_notify( "atlas_card", "animated_card", "play_atlas_card", "rec_funeral_altascard_card" );
    level.scr_animtree["atlas_gun"] = #animtree;
    level.scr_model["atlas_gun"] = "vm_bal27_base_black";
    level.scr_anim["atlas_gun"]["rec_campdavid_intro"] = %rec_campdavid_intro_gun;
    level.scr_animtree["windsock"] = #animtree;
    level.scr_anim["windsock"]["lab2_windsock_01_anim"] = %lab2_windsock_01_anim;
    level.scr_anim["windsock"]["lab2_windsock_02_anim"] = %lab2_windsock_02_anim;
    level.scr_anim["windsock"]["lab2_windsock_03_anim"] = %lab2_windsock_03_anim;
    level.scr_animtree["generic_prop"] = #animtree;
    level.scr_model["generic_prop"] = "genericprop";
    level.scr_anim["generic_prop"]["rec_atlas_exo_arm_machine"] = %rec_atlas_exo_arm_machine;
    level.scr_anim["generic_prop"]["rec_atlas_exo_arm_newarm"] = %rec_atlas_exo_arm_newarm;
    level.scr_anim["generic_prop"]["rec_atlas_exo_arm_oldarm"] = %rec_atlas_exo_arm_oldarm;
    level.scr_animtree["exo_push_sled_01"] = #animtree;
    level.scr_model["exo_push_sled_01"] = "genericprop";
    level.scr_anim["exo_push_sled_01"]["rec_atlas_push_idle"][0] = %rec_atlas_push_idle_box01;
    maps\_anim::addnotetrack_customfunction( "exo_push_sled_01", "vfx_shake_box01", maps\recovery_fx::exo_push_sparks01_quake, "rec_atlas_push_idle" );
    maps\_anim::addnotetrack_customfunction( "exo_push_sled_01", "vfx_pushstart_box01", maps\recovery_fx::exo_push_sparks01, "rec_atlas_push_idle" );
    level.scr_animtree["exo_push_sled_02"] = #animtree;
    level.scr_model["exo_push_sled_02"] = "genericprop";
    level.scr_anim["exo_push_sled_02"]["rec_atlas_push_idle"][0] = %rec_atlas_push_idle_box02;
    maps\_anim::addnotetrack_customfunction( "exo_push_sled_02", "vfx_shake_box02", maps\recovery_fx::exo_push_sparks02_quake, "rec_atlas_push_idle" );
    maps\_anim::addnotetrack_customfunction( "exo_push_sled_02", "vfx_pushstart_box02", maps\recovery_fx::exo_push_sparks02, "rec_atlas_push_idle" );
    maps\_anim::addnotetrack_flag_clear( "exo_push_sled_02", "vfx_pushstart_box02", "flag_vo_exo_push_dialog", "rec_atlas_push_idle" );
    maps\_anim::addnotetrack_flag( "exo_push_sled_02", "dialogue_crate_stop", "flag_vo_exo_push_dialog", "rec_atlas_push_idle" );
    level.scr_animtree["exo_push_crane_01"] = #animtree;
    level.scr_model["exo_push_crane_01"] = "genericprop";
    level.scr_anim["exo_push_crane_01"]["rec_atlas_push_idle"][0] = %rec_atlas_push_idle_crane01;
    level.scr_animtree["exo_push_crane_02"] = #animtree;
    level.scr_model["exo_push_crane_02"] = "genericprop";
    level.scr_anim["exo_push_crane_02"]["rec_atlas_push_idle"][0] = %rec_atlas_push_idle_crane02;
    level.scr_animtree["exo_shield_01"] = #animtree;
    level.scr_model["exo_shield_01"] = "prop_exo_riot_shield_B";
    level.scr_anim["exo_shield_01"]["rec_exo_shield_intro"] = %rec_exo_shield_intro_shield;
    level.scr_anim["exo_shield_01"]["rec_exo_shield_idle"][0] = %rec_exo_shield_idle_shield;
    level.scr_animtree["animated_desk"] = #animtree;
    level.scr_model["animated_desk"] = "rec_exolab_med_desk";
    level.scr_anim["animated_desk"]["rec_exo_arm_repair_desk"] = %rec_exo_arm_repair_desk;
    level.scr_anim["animated_desk"]["rec_exo_arm_repair_exit_desk"] = %rec_exo_arm_repair_exit_desk;
    level.scr_anim["animated_desk"]["rec_exo_arm_repair_idle_desk"][0] = %rec_exo_arm_repair_idle_desk;
    level.scr_anim["animated_desk"]["rec_exo_arm_repair_chair_unfold_idle_desk"][0] = %rec_exo_arm_repair_chair_unfold_idle_desk;
    level.scr_anim["animated_desk"]["rec_exo_arm_repair_start_idle_desk"][0] = %rec_exo_arm_repair_start_idle_desk;
    level.scr_anim["animated_desk"]["rec_exo_arm_repair_chair_unfold_desk"] = %rec_exo_arm_repair_chair_unfold_desk;
    level.scr_animtree["ready_room_elevator_left"] = #animtree;
    level.scr_model["ready_room_elevator_left"] = "rec_elevator";
    level.scr_anim["ready_room_elevator_left"]["rec_readyroom_seq"] = %rec_readyroom_elevator_left;
    level.scr_anim["ready_room_elevator_left"]["rec_readyroom_elevator_left_open"] = %rec_readyroom_elevator_left_open;
    level.scr_animtree["ready_room_elevator_right"] = #animtree;
    level.scr_model["ready_room_elevator_right"] = "rec_elevator";
    level.scr_anim["ready_room_elevator_right"]["rec_readyroom_seq"] = %rec_readyroom_elevator_right;
    level.scr_anim["ready_room_elevator_right"]["rec_readyroom_up_elevator_right"] = %rec_readyroom_up_elevator_right;
    level.scr_animtree["ready_room_assault_rifle"] = #animtree;
    level.scr_model["ready_room_assault_rifle"] = "genericprop";
    level.scr_anim["ready_room_assault_rifle"]["rec_readyroom_seq"] = %rec_readyroom_gun_pickedup;
    level.scr_anim["ready_room_assault_rifle"]["rec_readyroom_idle_gun_pickedup"][0] = %rec_readyroom_idle_gun_pickedup;
    level.scr_animtree["ready_room_sniper_rifle"] = #animtree;
    level.scr_model["ready_room_sniper_rifle"] = "genericprop";
    level.scr_anim["ready_room_sniper_rifle"]["rec_readyroom_gun_ontable"] = %rec_readyroom_gun_ontable;
    maps\_anim::addnotetrack_notify( "ready_room_sniper_rifle", "swap_gun", "swap_sniper_rifle", "rec_readyroom_gun_ontable" );
    level.scr_animtree["mute_charge"] = #animtree;
    level.scr_model["mute_charge"] = "mutecharge";
    level.scr_anim["mute_charge"]["breach_02_mutecharge"] = %rec_campdavid_mute_breach_start_mutedevice;
    maps\_anim::addnotetrack_customfunction( "mute_charge", "vfx_mute_device", maps\recovery_fx::mute_fx_on, "breach_02_mutecharge" );
    level.scr_model["door_prop"] = "rec_cd_door_01_rig";
    level.scr_animtree["door_prop"] = #animtree;
    level.scr_anim["door_prop"]["training_s1_flash_door_open"] = %rec_campdavid_training01_breach01_door_open;
    level.scr_anim["door_prop"]["training_s1_flash_door_open_idle"][0] = %rec_campdavid_training01_breach01_door_open_idle;
    level.scr_anim["door_prop"]["training_s1_flash_door_out"] = %rec_campdavid_training01_breach01_door_out;
    level.scr_anim["door_prop"]["training_s1_threat_door_open"] = %rec_campdavid_training02_breach01_door_open;
    level.scr_anim["door_prop"]["training_s1_threat_door_open_idle"][0] = %rec_campdavid_training02_breach01_door_open_idle;
    level.scr_anim["door_prop"]["training_s1_threat_door_open_fire_idle"][0] = %rec_campdavid_training02_breach01_door_open_fire_idle;
    level.scr_anim["door_prop"]["training_s1_threat_door_out"] = %rec_campdavid_training02_breach01_door_out;
    level.scr_anim["door_prop"]["training_s2_threat_door_open"] = %rec_campdavid_training02_breach01_door_open;
    level.scr_anim["door_prop"]["training_s2_threat_door_open_idle"][0] = %rec_campdavid_training02_breach01_door_open_idle;
    level.scr_anim["door_prop"]["training_s2_threat_door_out"] = %rec_campdavid_training02_breach01_door_out;
    level.scr_anim["door_prop"]["training_s2_exo_door"] = %rec_campdavid_exo_breach_start_door;
    level.scr_anim["door_prop"]["training_s1_exo_door"] = %rec_campdavid_mute_breach_start_door;
    maps\_anim::addnotetrack_customfunction( "door_prop", "door_breach", maps\recovery_fx::breach_office_door, "training_s2_exo_door" );
    maps\_anim::addnotetrack_customfunction( "door_prop", "door_breach", maps\recovery_fx::breach_office_door, "training_s1_exo_door" );
    level.scr_anim["door_prop"]["training_s1_bathroom_door"] = %rec_campdavid_mute_breach_bathroom_door;
    level.scr_model["patio_doors"] = "rec_french_door_01_pristine_rig";
    level.scr_animtree["patio_doors"] = #animtree;
    level.scr_anim["patio_doors"]["training_s1_patio_doors_in"] = %rec_campdavid_doubledoor_bust_open_in_door;
    level.scr_anim["patio_doors"]["training_s1_patio_doors_idle"][0] = %rec_campdavid_doubledoor_bust_open_idle_door;
    level.scr_anim["patio_doors"]["training_s1_patio_doors_out"] = %rec_campdavid_doubledoor_bust_open_out_door;
    level.scr_anim["patio_doors"]["training_s1_patio_doors_alert_idle"][0] = %rec_campdavid_doubledoor_bust_open_alert_idle_door;
    level.scr_anim["patio_doors"]["training_s1_patio_doors_slow_open"] = %rec_campdavid_doubledoor_slow_open_door;
    level.scr_anim["patio_doors"]["training_s1_patio_doors_slow_idle"][0] = %rec_campdavid_doubledoor_slow_open_idle_door;
    level.scr_anim["patio_doors"]["training_s1_patio_doors_slow_in"] = %rec_campdavid_doubledoor_slow_open_in_door;
    level.scr_anim["patio_doors"]["training_s1_patio_doors_slow_out"] = %rec_campdavid_doubledoor_slow_open_out_door;
    level.scr_anim["patio_doors"]["training_s2_patio_doors_idle"][0] = %rec_campdavid_doubledoor_bust_open_idle_door;
    level.scr_anim["patio_doors"]["training_s2_patio_doors_in"] = %rec_campdavid_doubledoor_bust_open_in_door;
    level.scr_anim["patio_doors"]["training_s2_patio_doors_out"] = %rec_campdavid_doubledoor_bust_open_out_door;
    level.scr_model["knife_prop"] = "weapon_spyderco_folding_knife";
    level.scr_animtree["knife_prop"] = #animtree;
    level.scr_anim["knife_prop"]["training_s2_exo_knife"] = %rec_campdavid_exo_breach_release_knife;
    level.scr_model["ziptie_prop"] = "rec_zip_cuffs";
    level.scr_animtree["ziptie_prop"] = #animtree;
    level.scr_anim["ziptie_prop"]["training_s1_exo_ziptie_fail"] = %rec_campdavid_mute_breach_fail_handcuffs;
    level.scr_anim["ziptie_prop"]["training_s1_exo_ziptie_start"] = %rec_campdavid_mute_breach_start_handcuffs;
    level.scr_anim["ziptie_prop"]["training_s1_exo_ziptie_react_idle"][0] = %rec_campdavid_mute_breach_react_idle_handcuffs;
    level.scr_anim["ziptie_prop"]["training_s1_exo_ziptie_release"] = %rec_campdavid_mute_breach_release_handcuff;
    level.scr_anim["ziptie_prop"]["training_s1_exo_ziptie_release_idle"][0] = %rec_campdavid_mute_breach_release_idle_handcuffs;
    level.scr_anim["ziptie_prop"]["training_s1_exo_ziptie_success"] = %rec_campdavid_mute_breach_success_handcuffs;
    level.scr_anim["ziptie_prop"]["training_s2_exo_ziptie_fail"] = %rec_campdavid_exo_breach_fail_handcuffs;
    level.scr_anim["ziptie_prop"]["training_s2_exo_ziptie_start"] = %rec_campdavid_exo_breach_react_handcuffs;
    level.scr_anim["ziptie_prop"]["training_s2_exo_ziptie_react_idle"][0] = %rec_campdavid_exo_breach_react_idle_handcuffs;
    level.scr_anim["ziptie_prop"]["training_s2_exo_ziptie_release"] = %rec_campdavid_exo_breach_release_handcuffs;
    level.scr_anim["ziptie_prop"]["training_s2_exo_ziptie_release_idle"][0] = %rec_campdavid_exo_breach_release_idle_handcuffs;
    level.scr_anim["ziptie_prop"]["training_s2_exo_ziptie_success"] = %rec_campdavid_exo_breach_success_handcuffs;
}

#using_animtree("vehicles");

vehicle_anims()
{
    level.scr_animtree["warbird"] = #animtree;
    level.scr_model["warbird"] = "vehicle_xh9_warbird";
    level.scr_anim["warbird"]["warbird_landing"] = %rec_ending03_landing_airship;
    level.scr_anim["warbird"]["warbird_land_idle"][0] = %rec_ending03_idle_airship;
    level.scr_anim["warbird"]["warbird_takeoff"] = %rec_ending03_airship;
    maps\_anim::addnotetrack_customfunction( "warbird", "warbird_shoot", ::warbird_start_shooting, "warbird_landing" );
    maps\_anim::addnotetrack_customfunction( "warbird", "crush", ::warbird_crush_player, "warbird_landing" );
    maps\_anim::addnotetrack_customfunction( "warbird", "cloak_off", maps\recovery_fx::helicopter_landing, "warbird_landing" );
    maps\_anim::addnotetrack_customfunction( "warbird", "fov_change", ::warbird_land_fov_change, "warbird_takeoff" );
    level.scr_model["pdrone"] = "vehicle_pdrone_kva";
    level.scr_anim["pdrone"]["training_s1_search_drone01"] = %rec_campdavid_training01_droneattack_drone01;
    level.scr_anim["pdrone"]["training_s1_search_drone02"] = %rec_campdavid_training01_droneattack_drone02;
    level.scr_model["avt"] = "vehicle_mil_avt_ai";
    level.scr_anim["avt"]["training_s1_vehicle_end"] = %rec_ending01_car;
    level.scr_anim["avt"]["training_s2_vehicle_end_drivein"] = %rec_ending02_car_drivein;
    level.scr_anim["avt"]["training_s2_vehicle_end"] = %rec_ending02_car;
    level.scr_animtree["jeep"] = #animtree;
    level.scr_model["jeep"] = "vehicle_mil_atlas_jeep_ai";
    level.scr_anim["jeep"]["training_s1_vehicle_tour_end"] = %rec_ending01_jeep;
    level.scr_anim["jeep"]["training_s1_vehicle_tour_end_enter"] = %rec_ending01_enter_ride_jeep;
    level.scr_anim["jeep"]["training_s1_vehicle_tour_end_idle"][0] = %rec_ending01_idle_jeep;
    level.scr_anim["jeep"]["rec_tour_ride_a_pt1"][0] = %rec_tour_ride_a_pt1_jeep;
    level.scr_anim["jeep"]["rec_tour_ride_a_pt2"] = %rec_tour_ride_a_pt2_jeep;
    level.scr_anim["jeep"]["rec_tour_ride_b_pt1"][0] = %rec_tour_ride_b_pt1_jeep;
    level.scr_anim["jeep"]["rec_tour_ride_b_pt2"] = %rec_tour_ride_b_pt2_jeep;
    level.scr_anim["jeep"]["rec_tour_ride_b_pt2"] = %rec_tour_ride_b_pt2_jeep;
    maps\_anim::addnotetrack_customfunction( "jeep", "tread_effects", maps\recovery_fx::tour_jeep_tread, "training_s1_vehicle_tour_end" );
    level.scr_anim["jeep"]["rec_tour_enter_door"] = %rec_tour_enter_door;
    level.scr_anim["jeep"]["rec_tour_exit_door"] = %rec_tour_exit_door;
    level.scr_anim["jeep"]["rec_tour_ride_c_pt1_jeep"] = %rec_tour_ride_c_pt1_jeep;
    level.scr_animtree["titan"] = #animtree;
    level.scr_model["titan"] = "vehicle_walker_tank";
    level.scr_anim["titan"]["walk_across"] = %rec_walker_walk;
    maps\_anim::addnotetrack_customfunction( "titan", "vfx_impact_FR", maps\recovery_fx::titan_impact_fx_fr, "walk_across" );
    maps\_anim::addnotetrack_customfunction( "titan", "vfx_impact_FL", maps\recovery_fx::titan_impact_fx_fl, "walk_across" );
    maps\_anim::addnotetrack_customfunction( "titan", "vfx_impact_RR", maps\recovery_fx::titan_impact_fx_rr, "walk_across" );
    maps\_anim::addnotetrack_customfunction( "titan", "vfx_impact_RL", maps\recovery_fx::titan_impact_fx_rl, "walk_across" );
}

warbird_start_shooting( var_0 )
{
    level.warbird notify( "warbird_fire" );
    wait 3;
    common_scripts\utility::flag_set( "training_s2_warbird_kill_enemies" );
}

warbird_crush_player( var_0 )
{
    common_scripts\utility::flag_wait( "flag_warbird_crush" );
    level.player kill();
}

training_s1_head_shot1( var_0 )
{
    if ( isalive( var_0 ) )
    {
        var_1 = common_scripts\utility::getstruct( "training_s1_kill_location", "targetname" );
        magicbullet( "iw5_bal27_sp_silencer01_variablereddot", var_1.origin, var_0 geteye() );
    }
}

training_s1_head_shot2( var_0 )
{
    if ( isalive( var_0 ) )
    {
        var_1 = common_scripts\utility::getstruct( "training_s1_kill_location", "targetname" );
        var_0 maps\_utility::stop_magic_bullet_shield();
        var_0 maps\_utility::set_allowdeath( 1 );
        magicbullet( "iw5_bal27_sp_silencer01_variablereddot", var_1.origin, var_0 geteye() );
        var_0.noragdoll = 1;
        ai_kill( var_0 );
    }
}

ai_kill( var_0 )
{
    if ( !isalive( var_0 ) )
        return;

    var_0.allowdeath = 1;
    var_0.a.nodeath = 1;
    var_0 maps\_utility::set_battlechatter( 0 );
    wait 0.05;
    var_0 kill();
}

training_s1_breach_slowmo_start( var_0 )
{
    var_1 = 0.5;
    var_2 = 0.65;
    var_3 = 0.1;
    var_4 = 0.2;
    var_5 = 2.0;
    level.player thread maps\_utility::play_sound_on_entity( "slomo_whoosh" );
    maps\_utility::slowmo_start();
    soundscripts\_snd::snd_message( "rec_mute_breach_slo_mo1", var_5 );
    maps\_utility::slowmo_setspeed_slow( var_4 );
    maps\_utility::slowmo_setlerptime_in( var_1 );
    maps\_utility::slowmo_lerp_in();
    level.player setmovespeedscale( var_3 );
    wait(var_5);
    level.player thread maps\_utility::play_sound_on_entity( "slomo_whoosh" );
    maps\_utility::slowmo_setlerptime_out( var_2 );
    maps\_utility::slowmo_lerp_out();
    maps\_utility::slowmo_end();
    level.player setmovespeedscale( 1.0 );
}

training_s1_breach_gun_up( var_0 )
{
    level.player enableweapons();
}

training_s2_breach_slowmo_start( var_0 )
{
    var_1 = 0.5;
    var_2 = 0.65;
    var_3 = 0.1;
    var_4 = 0.2;
    var_5 = 3.0;
    level.player thread maps\_utility::play_sound_on_entity( "slomo_whoosh" );
    maps\_utility::slowmo_start();
    soundscripts\_snd::snd_message( "rec_s2_breach_slo_mo", var_5 );
    maps\_utility::slowmo_setspeed_slow( var_4 );
    maps\_utility::slowmo_setlerptime_in( var_1 );
    maps\_utility::slowmo_lerp_in();
    level.player setmovespeedscale( var_3 );
    wait(var_5);
    level.player thread maps\_utility::play_sound_on_entity( "slomo_whoosh" );
    maps\_utility::slowmo_setlerptime_out( var_2 );
    maps\_utility::slowmo_lerp_out();
    maps\_utility::slowmo_end();
    level.player setmovespeedscale( 1.0 );
}

training_s1_end_fov_start( var_0 )
{
    level.player lerpfov( 50, 2 );
}

training_s1_end_fov_end( var_0 )
{
    level.player lerpfov( 65, 2 );
}

training_s1_intro_gun_up( var_0 )
{
    level.player enableweapons();
}

gideon_can_exit_range( var_0 )
{
    common_scripts\utility::flag_set( "gideon_range_exit_ok" );
}

gideon_cannot_exit_range( var_0 )
{
    common_scripts\utility::flag_clear( "gideon_range_exit_ok" );
}

ilona_can_turn( var_0 )
{
    common_scripts\utility::flag_set( "ilona_range_turn_ok" );
}

ilona_cannot_turn( var_0 )
{
    common_scripts\utility::flag_clear( "ilona_range_turn_ok" );
}

warbird_land_fov_change( var_0 )
{
    level.player lerpfov( 45, 2 );
}
