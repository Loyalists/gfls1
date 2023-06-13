// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    playersafehouseanimations();
    ilanasafehouseanimations();
    kvaguardanimations();
    civilianmarketanimations();
    precachescriptmodelanimations();
    precachevehicleanimations();
    animalanimations();
}

#using_animtree("player");

playersafehouseanimations()
{
    level.scr_animtree["player_cafe_rig"] = #animtree;
    level.scr_model["player_cafe_rig"] = "s1_gfl_ump45_viewbody";
    level.scr_anim["player_cafe_rig"]["hms_greece_market_intro"] = %hms_greece_market_intro_vm;
    maps\_anim::addnotetrack_notify( "player_cafe_rig", "free_cam", "MarketIntroUnlockCamControl", "hms_greece_market_intro" );
    level.scr_anim["player_cafe_rig"]["hms_greece_market_intro_loop"][0] = %hms_greece_market_intro_loop_vm;
    level.scr_anim["player_cafe_rig"]["hms_greece_market_intro_activate"] = %hms_greece_market_intro_activate_vm;
    level.scr_anim["player_cafe_rig"]["hms_greece_market_outro"] = %hms_greece_market_outro_vm;
    maps\_anim::addnotetrack_notify( "player_cafe_rig", "camera_dof", "CafeTransitionBackFOV", "hms_greece_market_outro" );
    level.scr_anim["player_cafe_rig"]["safehouse_takedown"] = %hms_greece_safehouse_takedown_vm;
    maps\_anim::addnotetrack_customfunction( "player_cafe_rig", "neck_snap", maps\greece_safehouse::marketkvafollowtargetnecksnaprumble, "safehouse_takedown" );
    level.scr_anim["player_cafe_rig"]["bag_drop"] = %hms_greece_safehouse_bagdrop_vm;
    maps\_anim::addnotetrack_customfunction( "player_cafe_rig", "light_rumble", ::safehousebagdroprumblelight, "bag_drop" );
    level.scr_anim["player_cafe_rig"]["courtyard_takedown"] = %hms_greece_safehouse_courtyard_takedown_vm;
    maps\_anim::addnotetrack_customfunction( "player_cafe_rig", "neck_snap", maps\greece_safehouse::marketkvafollowtargetnecksnaprumble, "courtyard_takedown" );
    level.scr_animtree["player_safehouse_rig"] = #animtree;
    level.scr_model["player_safehouse_rig"] = "s1_gfl_ump45_viewbody";
    level.scr_anim["player_safehouse_rig"]["drone_pre_launch"] = %hms_greece_safehouse_dronelaunch_fadeup_vm;
    level.scr_anim["player_safehouse_rig"]["drone_launch_control_pad"] = %hms_greece_safehouse_dronelaunch_pad_vm;
    level.scr_anim["player_safehouse_rig"]["exit_2floor"] = %hms_greece_safehouse_exit_2floor_vm;
}

#using_animtree("animated_props");

precachescriptmodelanimations()
{
    level.scr_animtree["keycard_door"] = #animtree;
    level.scr_anim["keycard_door"]["keycard_door_open"] = %hms_greece_safehouse_keycard_door_open;
    level.scr_goaltime["keycard_door"]["keycard_door_open"] = 0;
    level.scr_animtree["backpack_drone_small"] = #animtree;
    level.scr_model["backpack_drone_small"] = "backpack_drone_small";
    level.scr_anim["backpack_drone_small"]["bag_drop"] = %hms_greece_safehouse_bagdrop_backpack_npc;
    level.scr_anim["backpack_drone_small"]["hms_greece_market_intro"] = %hms_greece_market_intro_backpack2;
    level.scr_anim["backpack_drone_small"]["hms_greece_market_outro"] = %hms_greece_market_outro_backpack2;
    level.scr_anim["backpack_drone_small"]["hms_greece_market_vendor_loop"][0] = %hms_greece_market_vendor_loop_backpack2;
    level.scr_anim["backpack_drone_small"]["hms_greece_market_vendor_exit"] = %hms_greece_market_vendor_exit_backpack2;
    level.scr_animtree["backpack_drone_large"] = #animtree;
    level.scr_model["backpack_drone_large"] = "greece_duffelbag_rigged";
    level.scr_anim["backpack_drone_large"]["bag_drop"] = %hms_greece_safehouse_bagdrop_backpack_vm;
    level.scr_anim["backpack_drone_large"]["hms_greece_market_intro"] = %hms_greece_market_intro_backpack1;
    level.scr_anim["backpack_drone_large"]["hms_greece_market_outro"] = %hms_greece_market_outro_backpack1;
    level.scr_animtree["sniper_drone"] = #animtree;
    level.scr_model["sniper_drone"] = "vehicle_sniper_drone";
    level.scr_anim["sniper_drone"]["drone_pre_launch"][0] = %hms_greece_safehouse_dronelaunch_idle_drone;
    level.scr_anim["sniper_drone"]["drone_launch"] = %hms_greece_safehouse_dronelaunch_drone;
    maps\_anim::addnotetrack_notify( "sniper_drone", "cloak_on", "SafehouseDroneStartCloak", "drone_launch" );
    level.scr_anim["sniper_drone"]["drone_post_launch"][0] = %hms_greece_safehouse_dronelaunch_drone_idle_hold;
    level.scr_animtree["coffee_cup"] = #animtree;
    level.scr_model["coffee_cup"] = "coffee_cup";
    level.scr_anim["coffee_cup"]["safehouse_pacing_npc"][0] = %hms_greece_safehouse_pacing_coffeecup;
    level.scr_animtree["tea_cup"] = #animtree;
    level.scr_anim["tea_cup"]["cafe_tea_time"][0] = %hms_greece_cafe_civ_sit_teasipper_cup;
    level.scr_anim["tea_cup"]["hms_greece_market_intro"] = %hms_greece_market_intro_cup;
    level.scr_anim["tea_cup"]["hms_greece_market_intro_loop"][0] = %hms_greece_market_intro_loop_cup;
    level.scr_anim["tea_cup"]["hms_greece_market_outro"] = %hms_greece_market_outro_cup;
    level.scr_animtree["palm_tree"] = #animtree;
    level.scr_anim["palm_tree"]["light_sway"][0] = %palmtree_med1_sway;
    level.scr_model["keycard"] = "security_keycard_01";
    level.scr_animtree["keycard"] = #animtree;
    level.scr_anim["keycard"]["safehouse_takedown"] = %hms_greece_safehouse_takedown_keycard;
    maps\_anim::addnotetrack_customfunction( "keycard", "visibility_on", ::notetrackshow, "safehouse_takedown" );
    maps\_anim::addnotetrack_customfunction( "keycard", "visibility_off", ::notetrackhide, "safehouse_takedown" );
    level.scr_anim["keycard"]["keycard_door_open"] = %hms_greece_safehouse_keycard_open;
    maps\_anim::addnotetrack_customfunction( "keycard", "visibility_on", ::notetrackshow, "keycard_door_open" );
    maps\_anim::addnotetrack_customfunction( "keycard", "visibility_off", ::notetrackhide, "keycard_door_open" );
    level.scr_anim["keycard"]["keycard_door_open_in"] = %hms_greece_safehouse_keycard_prop_in;
    level.scr_anim["keycard"]["keycard_door_open_idle"][0] = %hms_greece_safehouse_keycard_idle;
    level.scr_model["threat_grenade"] = "vm_variable_grenade_nonlethal_paint";
    level.scr_animtree["threat_grenade"] = #animtree;
    level.scr_anim["threat_grenade"]["threat_grenade_npc"] = %hms_greece_safehouse_threat_grenade;
    maps\_anim::addnotetrack_customfunction( "threat_grenade", "visibility_on", ::notetrackshow, "threat_grenade_npc" );
    level.scr_anim["drone_control_pad"]["exit_2floor"] = %hms_greece_safehouse_exit_2floor_pad;
    maps\_anim::addnotetrack_customfunction( "drone_control_pad", "tablet_touch2_fx", maps\greece_safehouse_fx::outro_drone_tablet_touch_fx );
    level.scr_animtree["cafe_control_pad"] = #animtree;
    level.scr_model["cafe_control_pad"] = "greece_cafe_gps_pad";
    level.scr_anim["cafe_control_pad"]["hms_greece_market_intro"] = %hms_greece_market_intro_pad;
    level.scr_anim["cafe_control_pad"]["hms_greece_market_intro_loop"][0] = %hms_greece_market_intro_loop_pad;
    level.scr_anim["cafe_control_pad"]["hms_greece_market_intro_activate"] = %hms_greece_market_intro_activate_pad;
    maps\_anim::addnotetrack_customfunction( "cafe_control_pad", "tablet_touch_fx", maps\greece_safehouse_fx::intro_tablet_touch_fx );
    level.scr_anim["cafe_control_pad"]["hms_greece_market_outro"] = %hms_greece_market_outro_pad;
    maps\_anim::addnotetrack_customfunction( "cafe_control_pad", "tablet_touch2_fx", maps\greece_safehouse_fx::outro_tablet_touch_fx );
    level.scr_animtree["player_chair"] = #animtree;
    level.scr_model["player_chair"] = "greece_cafe_chair_03_anim";
    level.scr_anim["player_chair"]["hms_greece_market_intro"] = %hms_greece_market_intro_chair1;
    level.scr_anim["player_chair"]["hms_greece_market_outro"] = %hms_greece_market_outro_chair1;
    level.scr_animtree["ilana_chair"] = #animtree;
    level.scr_model["ilana_chair"] = "greece_cafe_chair_03_anim";
    level.scr_anim["ilana_chair"]["hms_greece_market_intro"] = %hms_greece_market_intro_chair2;
    level.scr_anim["ilana_chair"]["hms_greece_market_outro"] = %hms_greece_market_outro_chair2;
    level.scr_animtree["sitter_chair"] = #animtree;
    level.scr_model["sitter_chair"] = "greece_cafe_chair_03_anim";
    level.scr_anim["sitter_chair"]["hms_greece_market_outro"] = %hms_greece_market_outro_chair3;
    level.scr_animtree["lemon"] = #animtree;
    level.scr_model["lemon"] = "fruit_single_lemon_01";
    level.scr_anim["lemon"]["market_shopper_loop"][0] = %hms_greece_market_vendor_fem_lemon;
    level.scr_animtree["lemon01"] = #animtree;
    level.scr_model["lemon01"] = "fruit_single_lemon_01";
    level.scr_anim["lemon01"]["market_vendor_lemons_loop"][0] = %hms_greece_market_vendor_lemon_01;
    level.scr_animtree["lemon02"] = #animtree;
    level.scr_model["lemon02"] = "fruit_single_lemon_01";
    level.scr_anim["lemon02"]["market_vendor_lemons_loop"][0] = %hms_greece_market_vendor_lemon_02;
    level.scr_animtree["lemon03"] = #animtree;
    level.scr_model["lemon03"] = "fruit_single_lemon_01";
    level.scr_anim["lemon03"]["market_vendor_lemons_loop"][0] = %hms_greece_market_vendor_lemon_03;
    level.scr_animtree["lemon04"] = #animtree;
    level.scr_model["lemon04"] = "fruit_single_lemon_01";
    level.scr_anim["lemon04"]["market_vendor_lemons_loop"][0] = %hms_greece_market_vendor_lemon_04;
    level.scr_animtree["lemon05"] = #animtree;
    level.scr_model["lemon05"] = "fruit_single_lemon_01";
    level.scr_anim["lemon05"]["market_vendor_lemons_loop"][0] = %hms_greece_market_vendor_lemon_05;
    level.scr_animtree["broom"] = #animtree;
    level.scr_model["broom"] = "greece_broom_01";
    level.scr_anim["broom"]["market_vendor_sweep_loop"][0] = %hms_greece_market_vendor_sweeper_broom;
    maps\_anim::addnotetrack_customfunction( "broom", "broom_sweep", maps\greece_safehouse_fx::broom_sweep_dust_fx );
    level.scr_animtree["market_menu1"] = #animtree;
    level.scr_animtree["market_menu2"] = #animtree;
    level.scr_anim["market_menu1"]["cafe_meet_02_trans_in_guy1"] = %hms_greece_cafe_meet_02_trans_in_menu_m;
    level.scr_anim["market_menu2"]["cafe_meet_02_trans_in_fem"] = %hms_greece_cafe_meet_02_trans_in_menu_f;
    level.scr_anim["market_menu1"]["cafe_meet_02_loop_guy1"][0] = %hms_greece_cafe_meet_02_loop_menu_m;
    level.scr_anim["market_menu2"]["cafe_meet_02_loop_fem"][0] = %hms_greece_cafe_meet_02_loop_menu_f;
    level.scr_animtree["marketgate"] = #animtree;
    level.scr_anim["marketgate"]["hms_greece_market_target_exit"] = %hms_greece_market_target_walk_exit_door;
    level.scr_animtree["safehousegate"] = #animtree;
    level.scr_anim["safehousegate"]["market_marketgate_open"] = %hms_greece_market_marketgate_open;
    level.scr_anim["safehousegate"]["market_marketgate_closed"] = %hms_greece_market_marketgate_closed;
    level.scr_animtree["vendorgate"] = #animtree;
    level.scr_anim["vendorgate"]["hms_greece_market_vendor_exit"] = %hms_greece_market_vendor_exit_gate;
    level.scr_animtree["greece_door_h"] = #animtree;
    level.scr_anim["greece_door_h"]["courtyard_takedown"] = %hms_greece_safehouse_courtyard_takedown_door;
    level.scr_animtree["safehouse_pillow"] = #animtree;
    level.scr_anim["safehouse_pillow"]["safehouse_sleeping_guard_kill"] = %hms_greece_safehouse_enter2_death_pillow;
    level.scr_anim["safehouse_pillow"]["safehouse_enter2"] = %hms_greece_safehouse_enter2_pillow;
    level.scr_anim["safehouse_pillow"]["safehouse_enter2_alt"] = %hms_greece_safehouse_enter2_alt_pillow;
    level.scr_anim["safehouse_pillow"]["safehouse_sleeping_guard_kill_alt"] = %hms_greece_safehouse_enter2_death_alt_pillow;
    level.scr_animtree["greece_blimp"] = #animtree;
    level.scr_model["greece_blimp"] = "greece_blimp_rigged";
    level.scr_anim["greece_blimp"]["market_intro_blimp"][0] = %hms_greece_market_intro_blimp;
}

#using_animtree("vehicles");

precachevehicleanimations()
{
    level.scr_animtree["scooter"] = #animtree;
}

#using_animtree("generic_human");

ilanasafehouseanimations()
{
    level.scr_anim["Ilona"]["hms_greece_market_intro"] = %hms_greece_market_intro_ilana;
    maps\_anim::addnotetrack_notify( "Ilona", "dialog", "MarketIlanaSayThanks", "hms_greece_market_intro" );
    level.scr_anim["Ilona"]["hms_greece_market_intro_loop"][0] = %hms_greece_market_intro_loop_ilana;
    level.scr_anim["Ilona"]["hms_greece_market_outro"] = %hms_greece_market_outro_ilana;
    maps\_anim::addnotetrack_flag( "Ilona", "start_vendor_couple", "FlagStartMarketCouple", "hms_greece_market_outro" );
    maps\_anim::addnotetrack_flag( "Ilona", "start_pip", "FlagStartCafeVideoLog", "hms_greece_market_outro" );
    level.scr_anim["Ilona"]["hms_greece_market_vendor_loop"][0] = %hms_greece_market_vendor_loop_ilana;
    level.scr_anim["Ilona"]["hms_greece_market_vendor_exit"] = %hms_greece_market_vendor_exit_ilana;
    level.scr_anim["Ilona"]["civilian_hurried_walk"][0] = %civilian_walk_hurried_1;
    level.scr_anim["Ilona"]["civilian_hurried_walk"][1] = %civilian_walk_hurried_2;
    level.scr_anim["Ilona"]["london_station_civ1_idle"][0] = %london_station_civ1_idle;
    level.scr_anim["Ilona"]["london_loader1_idle"][0] = %london_loader1_idle;
    level.scr_anim["Ilona"]["london_guard_idle1"][0] = %london_guard_idle1;
    level.scr_anim["Ilona"]["london_guard_idle1"][1] = %london_guard_twitch_lookleft1;
    level.scr_anim["Ilona"]["london_guard_idle1"][2] = %london_guard_twitch_lookright1;
    level.scr_anim["Ilona"]["london_guard_idle1"][3] = %london_guard_twitch_stretch;
    level.scr_animtree["Mitchell"] = #animtree;
    level.scr_model["Mitchell"] = "body_complete_civilian_suit_male_1";
    level.scr_anim["Mitchell"]["Mitchell_scanning"][0] = %hms_greece_cafe_meet_02_loop_fem;
    level.scr_anim["Ilona"]["keycard_door_open"] = %hms_greece_safehouse_keycard_npc;
    maps\_anim::addnotetrack_customfunction( "Ilona", "door_unlock", maps\greece_safehouse::safehousedoorunlockednotetrack, "keycard_door_open" );
    maps\_anim::addnotetrack_notify( "Ilona", "remove_collisionbox", "SafehousePlayerBlockerDelete", "keycard_door_open" );
    level.scr_anim["Ilona"]["keycard_door_open_in"] = %hms_greece_safehouse_keycard_in;
    level.scr_anim["Ilona"]["keycard_door_open_idle"][0] = %hms_greece_safehouse_keycard_idle_npc;
    level.scr_anim["Ilona"]["keycard_wall_idle"][0] = %hms_greece_safehouse_wall_idle_npc;
    level.scr_anim["Ilona"]["wall_exit_npc"] = %hms_greece_safehouse_wall_exit_npc;
    level.scr_anim["Ilona"]["safehouse_enter"] = %hms_greece_safehouse_enter_ilana;
    level.scr_anim["Ilona"]["safehouse_enter_idle"][0] = %hms_greece_safehouse_enter_idle_ilana;
    level.scr_anim["Ilona"]["safehouse_enter2"] = %hms_greece_safehouse_enter2_ilana;
    maps\_anim::addnotetrack_flag( "Ilona", "fire_bullet", "FlagIlanaShootPlanningGuard", "safehouse_enter2" );
    level.scr_anim["Ilona"]["safehouse_enter2_alt"] = %hms_greece_safehouse_enter2_alt_ilana;
    level.scr_anim["Ilona"]["safehouse_enter2_idle"][0] = %hms_greece_safehouse_enter2_idle_ilana;
    level.scr_anim["Ilona"]["threat_grenade_npc"] = %hms_greece_safehouse_threat_grenade_npc;
    level.scr_anim["Ilona"]["safehouse_takedown"] = %hms_greece_safehouse_takedown_ally;
    level.scr_anim["Victim"]["safehouse_takedown"] = %hms_greece_safehouse_takedown_enemy;
    level.scr_anim["Victim"]["stand_flinch"] = %hms_greece_stand_flinch;
    level.scr_anim["Ilona"]["courtyard_takedown_idle"][0] = %hms_greece_safehouse_courtyard_takedown_idle_ilana;
    level.scr_anim["Ilona"]["courtyard_takedown"] = %hms_greece_safehouse_courtyard_takedown_ilana;
    maps\_anim::addnotetrack_notify( "Ilona", "keycard_spawn", "CourtyardTakedownSpawnKeycard", "courtyard_takedown" );
    maps\_anim::addnotetrack_notify( "Ilona", "keycard_hide", "CourtyardTakedownHideKeycard", "courtyard_takedown" );
    maps\_anim::addnotetrack_notify( "Ilona", "unholster_weapon", "CourtyardTakedownUnholsterWeapon", "courtyard_takedown" );
    level.scr_anim["Ilona"]["courtyard_takedown_enter"] = %hms_greece_safehouse_courtyard_takedown_enter_ilana;
    level.scr_anim["Ilona"]["courtyard_takedown_fail"] = %hms_greece_safehouse_courtyard_takedown_fail_ilana;
    level.scr_anim["KeyMan"]["courtyard_takedown_enter"] = %hms_greece_safehouse_courtyard_idle_enter_npc_1;
    level.scr_anim["KeyMan"]["courtyard_takedown_idle"][0] = %hms_greece_safehouse_courtyard_idle_npc_1;
    level.scr_anim["KeyMan"]["courtyard_takedown"] = %hms_greece_safehouse_courtyard_takedown_npc_1;
    level.scr_anim["KeyMan"]["courtyard_takedown_fail"] = %hms_greece_safehouse_courtyard_takedown_fail_npc1;
    maps\_anim::addnotetrack_customfunction( "KeyMan", "weapon_equip", ::marketkvafollowtargetdrawgun, "courtyard_takedown_fail" );
    level.scr_anim["Victim"]["courtyard_takedown"] = %hms_greece_safehouse_courtyard_takedown_npc;
    level.scr_anim["Victim"]["courtyard_takedown_idle"][0] = %hms_greece_safehouse_courtyard_takedown_idle_npc;
    level.scr_anim["Victim"]["courtyard_takedown_fail"] = %hms_greece_safehouse_courtyard_takedown_fail_npc;
    maps\_anim::addnotetrack_customfunction( "Victim", "weapon_equip", ::marketkvaambusherdrawgun, "courtyard_takedown_fail" );
    level.scr_anim["Ilona"]["safehouse_sleeping_guard_kill_alt"] = %hms_greece_safehouse_enter2_kill_alt;
    level.scr_anim["Ilona"]["safehouse_sleeping_guard_kill"] = %hms_greece_safehouse_enter2_kill_ilana;
    level.scr_anim["KeyMan"]["hms_greece_market_target_walk"] = %hms_greece_market_target_walk_npc;
    maps\_anim::addnotetrack_notify( "KeyMan", "Start_walker_03", "MarketStartWalker03", "hms_greece_market_target_walk" );
    maps\_anim::addnotetrack_notify( "KeyMan", "Start_walker_07", "MarketStartWalker07", "hms_greece_market_target_walk" );
    maps\_anim::addnotetrack_notify( "KeyMan", "Start_walker_08", "MarketStartWalker08", "hms_greece_market_target_walk" );
    maps\_anim::addnotetrack_notify( "KeyMan", "AI_move_01", "MarketStartAmbWalker01", "hms_greece_market_target_walk" );
    maps\_anim::addnotetrack_notify( "KeyMan", "AI_move_02", "MarketStartAmbWalker02", "hms_greece_market_target_walk" );
    maps\_anim::addnotetrack_notify( "KeyMan", "AI_move_03", "MarketStartAmbWalker03", "hms_greece_market_target_walk" );
    maps\_anim::addnotetrack_notify( "KeyMan", "AI_move_04", "MarketStartAmbWalker04", "hms_greece_market_target_walk" );
    maps\_anim::addnotetrack_notify( "KeyMan", "AI_move_05", "MarketStartAmbWalker05", "hms_greece_market_target_walk" );
    maps\_anim::addnotetrack_notify( "KeyMan", "AI_move_06", "MarketStartAmbWalker06", "hms_greece_market_target_walk" );
    maps\_anim::addnotetrack_notify( "KeyMan", "AI_move_07", "MarketStartAmbWalker07", "hms_greece_market_target_walk" );
    maps\_anim::addnotetrack_notify( "KeyMan", "AI_move_08", "MarketStartAmbWalker08", "hms_greece_market_target_walk" );
    maps\_anim::addnotetrack_notify( "KeyMan", "AI_move_09", "MarketStartAmbWalker09", "hms_greece_market_target_walk" );
    maps\_anim::addnotetrack_notify( "KeyMan", "AI_move_10", "MarketStartAmbWalker10", "hms_greece_market_target_walk" );
    maps\_anim::addnotetrack_notify( "KeyMan", "AI_move_11", "MarketStartAmbWalker11", "hms_greece_market_target_walk" );
    level.scr_anim["KeyMan"]["hms_greece_market_target_idle"][0] = %hms_greece_market_target_idle_npc;
    level.scr_anim["KeyMan"]["hms_greece_market_target_exit"] = %hms_greece_market_target_walk_exit_npc;
    maps\_anim::addnotetrack_notify( "KeyMan", "Gate_open", "MarketTargetEscaped", "hms_greece_market_target_exit" );
    level.scr_anim["KeyMan"]["civilian_stand_idle"][0] = %civilian_stand_idle;
    level.scr_anim["KeyMan"]["civilian_cool_walk"][0] = %civilian_walk_cool;
    level.scr_anim["Ilona"]["safehouse_enter3"] = %hms_greece_safehouse_enter3_ilana;
    level.scr_anim["Ilona"]["safehouse_enter3_idle"][0] = %hms_greece_safehouse_enter3_idle_ilana;
    level.scr_anim["Ilona"]["bag_drop"] = %hms_greece_safehouse_bagdrop_npc;
    level.scr_anim["Ilona"]["drone_pre_launch"][0] = %hms_greece_safehouse_dronelaunch_idle_npc;
    level.scr_anim["Ilona"]["drone_launch"] = %hms_greece_safehouse_dronelaunch_npc;
    maps\_anim::addnotetrack_flag( "Ilona", "dialog", "FlagSniperDroneLaunched", "drone_launch" );
    level.scr_anim["Ilona"]["drone_post_launch"][0] = %hms_greece_safehouse_dronelaunch_idle2_npc;
    level.scr_anim["Ilona"]["stairsclimb_arch_in"] = %hms_greece_safehouse_stairsclimb_arch_in;
    level.scr_anim["Ilona"]["stairsclimb"] = %hms_greece_safehouse_stairsclimb_stairs;
    level.scr_anim["Ilona"]["room3_transition_out"] = %hms_greece_safehouse_room3_ilana_exitcover;
    level.scr_anim["Ilona"]["room3_transition_idle"][0] = %hms_greece_safehouse_room3_ilana_idlecover;
    level.scr_anim["Ilona"]["turn2exit"] = %hms_greece_safehouse_turn2exit_ilana;
    level.scr_anim["Ilona"]["exit_stairs"] = %hms_greece_safehouse_exit_stairs;
    level.scr_anim["Ilona"]["exit_2floor"] = %hms_greece_safehouse_exit_2floor_npc;
    maps\_anim::addnotetrack_notify( "Ilona", "dialog", "NotifyIlonaExitDialog", "exit_2floor" );
    maps\_anim::addnotetrack_notify( "Ilona", "toggle_gun_vis", "NotifyIlonaExitGunShow", "exit_2floor" );
    level.scr_anim["Ilona"]["exit_1stfloor_idle"][0] = %hms_greece_safehouse_exit_1stfloor_idle;
    level.scr_anim["Ilona"]["exit_1stfloor_dodge"] = %hms_greece_safehouse_exit_1stfloor_dodge;
    level.scr_anim["Ilona"]["exit_1stfloor_arch_idle"][0] = %hms_greece_safehouse_exit_1stfloor_arch_idle;
    level.scr_anim["Ilona"]["exit_1stfloor_turn"] = %hms_greece_safehouse_exit_1stfloor_turn;
    level.scr_anim["Ilona"]["exit_1stfloor_all"] = %hms_greece_safehouse_exit_1stfloor_all2exit;
}

kvaguardanimations()
{
    level.scr_anim["generic"]["safehouse_sitting01_npc"][0] = %hms_greece_safehouse_sitting01_npc;
    level.scr_anim["pacing_guard"]["safehouse_pacing_npc"][0] = %hms_greece_safehouse_pacing_npc;
    level.scr_anim["generic"]["safehouse_sleeping_guard_idle"][0] = %hms_greece_safehouse_enter2_idle_npc;
    level.scr_anim["generic"]["safehouse_sleeping_guard_death"] = %hms_greece_safehouse_enter2_death_npc;
    level.scr_anim["generic"]["safehouse_sleeping_guard_kill"] = %hms_greece_safehouse_enter2_kill_npc;
    level.scr_anim["pacing_guard"]["casual_stand_idle"][0] = %casual_stand_idle;
    level.scr_anim["pacing_guard"]["casual_stand_idle"][1] = %casual_stand_idle_twitch;
    level.scr_anim["pacing_guard"]["casual_stand_idle"][2] = %casual_stand_idle_twitchb;
    level.scr_anim["pacing_guard"]["safehouse_videochat_01"] = %hms_greece_safehouse_videochat_01;
    level.scr_anim["pacing_guard"]["safehouse_videochat_idle"][0] = %hms_greece_safehouse_videochat_idle;
    level.scr_anim["pacing_guard"]["safehouse_videochat_alert"] = %hms_greece_safehouse_videochat_alert;
    level.scr_anim["pacing_guard"]["safehouse_videochat_death"] = %hms_greece_safehouse_videochat_death;
    level.scr_anim["planner_left"]["plan_idle"][0] = %hms_greece_safehouse_plan_guards_idle_l;
    level.scr_anim["planner_right"]["plan_idle"][0] = %hms_greece_safehouse_plan_guards_idle_r;
    level.scr_anim["planner_left"]["plan_fail"] = %hms_greece_safehouse_plan_guards_fail_l;
    maps\_anim::addnotetrack_notify( "planner_left", "toggle_gun_vis_l", "SafehousePlanningGuardLeftPlanFail", "plan_fail" );
    level.scr_goaltime["planner_left"]["plan_fail"] = 0.5;
    level.scr_anim["planner_right"]["plan_fail"] = %hms_greece_safehouse_plan_guards_fail_r;
    maps\_anim::addnotetrack_notify( "planner_right", "toggle_gun_vis_r", "SafehousePlanningGuardRightPlanFail", "plan_fail" );
    level.scr_goaltime["planner_right"]["plan_fail"] = 0.5;
    level.scr_anim["planner_left"]["plan_success"] = %hms_greece_safehouse_plan_guards_success_l_r;
    level.scr_goaltime["planner_left"]["plan_success"] = 0.5;
    level.scr_anim["planner_left"]["plan_success_alt"] = %hms_greece_safehouse_plan_guards_success_l_l;
    level.scr_anim["planner_left"]["plan_success_alt2"] = %hms_greece_safehouse_plan_guards_success_l;
    level.scr_anim["planner_right"]["plan_success"] = %hms_greece_safehouse_plan_guards_success_r;
    level.scr_goaltime["planner_right"]["plan_success"] = 0.5;
    level.scr_anim["planner_right"]["plan_success_alt"] = %hms_greece_safehouse_plan_guards_success_r_m;
    level.scr_anim["planner_left"]["plan_failsuccess"] = %hms_greece_safehouse_plan_guards_failsuccess_l;
    level.scr_goaltime["planner_left"]["plan_failsuccess"] = 0.5;
    level.scr_anim["planner_right"]["plan_failsuccess"] = %hms_greece_safehouse_plan_guards_failsuccess_r;
    level.scr_goaltime["planner_right"]["plan_failsuccess"] = 0.5;
}

civilianmarketanimations()
{
    level.scr_anim["waiter"]["hms_greece_market_intro"] = %hms_greece_market_intro_npc;
    level.scr_anim["waiter"]["hms_greece_market_intro_loop"][0] = %hms_greece_market_intro_loop_npc;
    level.scr_anim["sitter"]["hms_greece_market_outro"] = %hms_greece_market_outro_npc;
    level.scr_anim["sitter"]["hms_greece_market_outro_loop"][0] = %hms_greece_market_sit_idle_npc;
    level.scr_anim["generic"]["cafe_civ_sit_read_idle_01"] = %hms_greece_cafe_civ_sit_read_idle_01;
    level.scr_anim["generic"]["cafe_civ_sit_read_trans2crossed_01"] = %hms_greece_cafe_civ_sit_read_trans2crossed_01;
    level.scr_anim["generic"]["cafe_civ_sit_read_idlecrossed_01"] = %hms_greece_cafe_civ_sit_read_idlecrossed_01;
    level.scr_anim["generic"]["cafe_civ_sit_read_trans2sit_01"] = %hms_greece_cafe_civ_sit_read_trans2sit_01;
    level.scr_anim["generic"]["cafe_civ_sit_read_trans2sit_long_01"] = %hms_greece_cafe_civ_sit_read_trans2sit_long_01;
    level.scr_anim["TeaGuy"]["cafe_tea_time"][0] = %hms_greece_cafe_civ_sit_teasipper_npc;
    level.scr_anim["greet_male"]["cafe_meet_02_trans_in_guy1"] = %hms_greece_cafe_meet_02_trans_in_guy1;
    level.scr_anim["greet_female"]["cafe_meet_02_trans_in_fem"] = %hms_greece_cafe_meet_02_trans_in_fem;
    level.scr_anim["greet_male"]["cafe_meet_02_loop_guy1"][0] = %hms_greece_cafe_meet_02_loop_guy1;
    level.scr_anim["greet_female"]["cafe_meet_02_loop_fem"][0] = %hms_greece_cafe_meet_02_loop_fem;
    level.scr_anim["generic"]["civilian_cool_walk"][0] = %civilian_walk_cool;
    level.scr_anim["generic"]["civilian_hurried_walk"][0] = %civilian_walk_hurried_1;
    level.scr_anim["generic"]["civilian_hurried_walk"][1] = %civilian_walk_hurried_2;
    level.scr_anim["generic"]["civilian_directions_1_A"][0] = %civilian_directions_1_a;
    level.scr_anim["generic"]["civilian_directions_1_B"][0] = %civilian_directions_1_b;
    level.scr_anim["generic"]["civilian_directions_2_A_idle"][0] = %civilian_directions_2_a_idle;
    level.scr_anim["generic"]["hms_greece_trans_alley_cafe_civ_idle_01"][0] = %hms_greece_trans_alley_cafe_civ_idle_01;
    level.scr_anim["generic"]["hms_greece_trans_alley_cafe_civ_idle_02"][0] = %hms_greece_trans_alley_cafe_civ_idle_02;
    level.scr_anim["generic"]["hms_greece_trans_alley_cafe_civ_idle_03"][0] = %hms_greece_trans_alley_cafe_civ_idle_03;
    level.scr_anim["generic"]["hms_greece_trans_alley_cafe_civ_idle_04"][0] = %hms_greece_trans_alley_cafe_civ_idle_04;
    level.scr_anim["generic"]["hms_greece_trans_alley_cafe_civ_idle_05"][0] = %hms_greece_trans_alley_cafe_civ_idle_05;
    level.scr_anim["generic"]["hms_greece_trans_alley_cafe_civ_idle_06"][0] = %hms_greece_trans_alley_cafe_civ_idle_06;
    level.scr_anim["generic"]["hms_greece_trans_alley_cafe_civ_idle_07"][0] = %hms_greece_trans_alley_cafe_civ_idle_07;
    level.scr_anim["MarketDecoy1"]["hms_greece_market_decoy_walker"] = %hms_greece_market_decoy_walker_01;
    level.scr_anim["MarketDecoy2"]["hms_greece_market_decoy_walker"] = %hms_greece_market_decoy_walker_02;
    level.scr_anim["MarketDecoy3"]["hms_greece_market_decoy_walker"] = %hms_greece_market_decoy_walker_03;
    level.scr_anim["MarketDecoy4"]["hms_greece_market_decoy_walker"] = %hms_greece_market_decoy_walker_04;
    level.scr_anim["MarketDecoy5"]["hms_greece_market_decoy_walker"] = %hms_greece_market_decoy_walker_05;
    level.scr_anim["MarketDecoy6"]["hms_greece_market_decoy_walker"] = %hms_greece_market_decoy_walker_06;
    level.scr_anim["MarketDecoy7"]["hms_greece_market_decoy_walker"] = %hms_greece_market_decoy_walker_07;
    level.scr_anim["MarketDecoy8"]["hms_greece_market_decoy_walker"] = %hms_greece_market_decoy_walker_08;
    level.scr_anim["MarketDecoy1"]["civilian_slow_walk_male"] = %hms_greece_market_civ_walk_slow_male_01;
    level.scr_anim["MarketDecoy2"]["civilian_slow_walk_male"] = %hms_greece_market_civ_walk_slow_male_01;
    level.scr_anim["MarketDecoy3"]["civilian_slow_walk_male"] = %hms_greece_market_civ_walk_slow_male_01;
    level.scr_anim["MarketDecoy4"]["civilian_slow_walk_male"] = %hms_greece_market_civ_walk_slow_male_01;
    level.scr_anim["MarketDecoy5"]["civilian_slow_walk_male"] = %hms_greece_market_civ_walk_slow_male_01;
    level.scr_anim["MarketDecoy6"]["civilian_slow_walk_male"] = %hms_greece_market_civ_walk_slow_male_01;
    level.scr_anim["MarketDecoy7"]["civilian_slow_walk_male"] = %hms_greece_market_civ_walk_slow_male_01;
    level.scr_anim["MarketDecoy8"]["civilian_slow_walk_male"] = %hms_greece_market_civ_walk_slow_male_01;
    level.scr_anim["generic"]["civ_idletrans_in_r"] = %hms_greece_market_civ_idletrans_in_r;
    level.scr_anim["generic"]["civ_idletrans_in_f"] = %hms_greece_market_civ_idletrans_in_f;
    level.scr_anim["generic"]["civ_idletrans_in_l"] = %hms_greece_market_civ_idletrans_in_l;
    level.scr_anim["generic"]["civ_idletrans_out_r"] = %hms_greece_market_civ_idletrans_out_r;
    level.scr_anim["generic"]["civ_idletrans_out_b"] = %hms_greece_market_civ_idletrans_out_b;
    level.scr_anim["generic"]["civ_idletrans_out_l"] = %hms_greece_market_civ_idletrans_out_l;
    level.scr_anim["generic"]["civilian_walk_male"][0] = %hms_greece_market_civ_walk_male_01;
    level.scr_anim["generic"]["civilian_slow_walk_male"][0] = %hms_greece_market_civ_walk_slow_male_01;
    level.scr_anim["generic"]["london_civ_idle"][0] = %london_civ_idle_lookover;
    level.scr_anim["generic"]["london_civ_idle"][1] = %london_civ_idle_checkwatch;
    level.scr_anim["generic"]["london_civ_idle"][2] = %london_civ_idle_lookbehind;
    level.scr_anim["generic"]["london_civ_idle"][3] = %london_civ_idle_wave;
    level.scr_anim["generic"]["london_civ_idle"][4] = %london_civ_idle_scratchnose;
    level.scr_anim["generic"]["london_civ_idle"][5] = %london_civ_idle_foldarms_scratchass;
    level.scr_anim["generic"]["london_civ_idle"][6] = %london_civ_idle_foldarms2;
    level.scr_anim["generic"]["london_civ_idle"][7] = %hms_greece_market_civ_idle_01;
    level.scr_anim["generic"]["london_civ_idle"][8] = %hms_greece_market_civ_idle_02;
    level.scr_anim["generic"]["london_civ_idle"][9] = %hms_greece_market_civ_idle_03;
    level.scr_anim["generic"]["london_civ_idle"][10] = %hms_greece_market_civ_idle_04;
    level.scr_anim["generic"]["hms_greece_cc_takedown_idle_target"][0] = %hms_greece_cc_takedown_idle_target;
    level.scr_anim["generic"]["hms_greece_cc_balconykill_idle"][0] = %hms_greece_cc_balconykill_idle;
    level.scr_anim["generic"]["hms_greece_cc_breach_meeting_guest1_idle"][0] = %hms_greece_cc_breach_meeting_guest1_idle;
    level.scr_anim["generic"]["hms_greece_cc_breach_meeting_guest2_idle"][0] = %hms_greece_cc_breach_meeting_guest2_idle;
    level.scr_anim["generic"]["hms_greece_cc_breach_meeting_guest3_idle"][0] = %hms_greece_cc_breach_meeting_guest3_idle;
    level.scr_anim["market_vendor"]["market_vendor_loop"][0] = %hms_greece_market_vendor_vendor_loop;
    level.scr_anim["market_male"]["market_vendor_in"] = %hms_greece_market_vendor_male_in;
    level.scr_anim["market_female"]["market_vendor_in"] = %hms_greece_market_vendor_female_in;
    maps\_anim::addnotetrack_flag( "market_female", "reached_vendor", "FlagMarketCoupleAtGoal", "market_vendor_in" );
    level.scr_anim["market_male"]["market_shopper_loop"][0] = %hms_greece_market_vendor_male_loop;
    level.scr_anim["market_female"]["market_shopper_loop"][0] = %hms_greece_market_vendor_female_loop;
    level.scr_anim["market_sweeper"]["market_vendor_sweep_loop"][0] = %hms_greece_market_vendor_sweeper;
    level.scr_anim["Host"]["market_host_in"] = %hms_greece_market_outro_npc1;
    level.scr_anim["Host"]["market_host_loop"][0] = %hms_greece_market_outro_idle_npc1;
    level.scr_anim["civ1"]["market_fntn_civ_talk"][0] = %hms_greece_market_fntn_civ_talk_npc;
    level.scr_anim["civ2"]["market_fntn_civ_talk"][0] = %hms_greece_market_fntn_civ_talk_npc1;
    level.scr_anim["generic"]["npc_urgent_walk_idle"][0] = %npc_urgent_walk_twitch01_idle;
    level.scr_anim["generic"]["npc_urgent_walk_idle"][1] = %npc_urgent_walk_twitch02_idle;
    level.scr_anim["generic"]["npc_urgent_walk_idle"][2] = %npc_urgent_walk_twitch03_idle;
    level.scr_anim["generic"]["npc_urgent_walk_idle"][3] = %npc_urgent_walk_idle;
    level.scr_anim["generic"]["patrol_unarmed_idle"][0] = %patrol_unarmed_idle;
    level.scr_anim["generic"]["patrol_unarmed_idle"][1] = %patrol_unarmed_idle_fidget_1;
    level.scr_anim["generic"]["bet_casual_startstop_idle_gideon"][0] = %bet_casual_startstop_idle_gideon;
    level.scr_anim["generic"]["det_unarmed_casual_idle"][0] = %det_unarmed_casual_idle;
}

#using_animtree("animals");

animalanimations()
{
    level.scr_animtree["goose_01"] = #animtree;
    level.scr_model["goose_01"] = "goose";
    level.scr_animtree["goose_02"] = #animtree;
    level.scr_model["goose_02"] = "goose";
    level.scr_animtree["goose_03"] = #animtree;
    level.scr_model["goose_03"] = "goose";
    level.scr_anim["goose_01"]["market_intro_geese"] = %hms_greece_market_intro_goose_01;
    level.scr_anim["goose_02"]["market_intro_geese"] = %hms_greece_market_intro_goose_02;
    level.scr_anim["goose_03"]["market_intro_geese"] = %hms_greece_market_intro_goose_03;
}

notetrackshow( var_0 )
{
    var_0 show();
}

notetrackhide( var_0 )
{
    var_0 hide();
}

notetrackdelete( var_0 )
{
    var_0 stopanimscripted();
    var_0 delete();
}

notetrackshoot( var_0 )
{
    var_0 shoot();
}

notetrackgatebash( var_0 )
{
    var_0 startscriptedanim();
}

safehousebagdroprumblelight( var_0 )
{
    var_1 = randomfloatrange( 0.1, 0.3 );
    var_2 = randomfloatrange( 0.1, 0.3 );
    earthquake( var_1, var_2, level.player.origin, 128 );
    level.player playrumbleonentity( "damage_light" );
}

marketkvafollowtargetdrawgun( var_0 )
{
    var_0 detach( "weapon_parabolic_knife", "TAG_WEAPON_RIGHT", 0 );
    var_0 maps\_utility::forceuseweapon( "iw5_titan45_sp", "primary" );
}

marketkvaambusherdrawgun( var_0 )
{
    var_0 maps\_utility::forceuseweapon( "iw5_titan45_sp", "primary" );
}
