// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    playerscrambleanimations();
    ilanascrambleanimations();
    enemyscrambleanimations();
    civscrambleanimations();
    allyscrambleanimations();
    sniperscrambleexittruckanimations();
    sniperscramblewindmilldestructionanimations();
    sniperscrambleintrodooranimations();
    sniperscramblegondolaanimations();
    sniperscramblefishanimations();
}

#using_animtree("player");

playerscrambleanimations()
{
    level.scr_animtree["player_scramble_rig"] = #animtree;
    level.scr_model["player_scramble_rig"] = "s1_gfl_ump45_viewbody";
    level.scr_anim["player_scramble_rig"]["parkour_jump"] = %hms_greece_sniperscramble_parkour_jump_vm;
    maps\_anim::addnotetrack_notify( "player_scramble_rig", "window_break", "ScramblePlayerBreakWindowGapJump", "parkour_jump" );
    maps\_anim::addnotetrack_notify( "player_scramble_rig", "sniper_shot_miss", "ScrambleSniperShootGapJump", "parkour_jump" );
    level.scr_anim["player_scramble_rig"]["hotel_jump"] = %hms_greece_sniperscramble_hoteltraversal_vm;
    maps\_anim::addnotetrack_notify( "player_scramble_rig", "sniper_fire_miss", "ScrambleSniperShootHotelJump", "hotel_jump" );
    maps\_anim::addnotetrack_customfunction( "player_scramble_rig", "rumble_1", ::scramblejumprumblelight, "hotel_jump" );
    maps\_anim::addnotetrack_customfunction( "player_scramble_rig", "rumble_2", ::scramblejumprumbleheavy, "hotel_jump" );
    level.scr_anim["player_scramble_rig"]["cafe_jump"] = %hms_greece_sniperscramble_entrancetraversal_vm;
    maps\_anim::addnotetrack_notify( "player_scramble_rig", "sniper_shot_miss", "ScrambleSniperShootCafeJump", "cafe_jump" );
    maps\_anim::addnotetrack_customfunction( "player_scramble_rig", "rumble_1", ::scramblejumprumblelight, "cafe_jump" );
    maps\_anim::addnotetrack_customfunction( "player_scramble_rig", "rumble_2", ::scramblejumprumblelight, "cafe_jump" );
    maps\_anim::addnotetrack_customfunction( "player_scramble_rig", "rumble_3", ::scramblejumprumbleheavy, "cafe_jump" );
    level.scr_anim["player_scramble_rig"]["move_truck"] = %hms_greece_sniperscramble_truckpush_vm;
    maps\_anim::addnotetrack_customfunction( "player_scramble_rig", "rumble_1", ::scrambletruckpushrumbleheavy, "move_truck" );
}

#using_animtree("generic_human");

ilanascrambleanimations()
{
    level.scr_anim["Ilona"]["parkour_jump"] = %hms_greece_sniperscramble_parkour_jump_npc;
    level.scr_anim["Ilona"]["trans_alley_sprint_wpn_ilana"][0] = %hms_greece_trans_alley_sprint_wpn_ilana;
    level.scr_anim["Ilona"]["hotel_traversal"] = %hms_greece_sniperscramble_illana_hoteltraversal;
    level.scr_anim["Ilona"]["cafe_traversal"] = %hms_greece_sniperscramble_illana_entrancetraversal;
    level.scr_anim["Ilona"]["cafe_traversal_alt"] = %hms_greece_sniperscramble_illana_entrancetraversal_alt;
    level.scr_anim["Ilona"]["run_to_truck"] = %hms_greece_sniperscramble_run2street_ilana;
    maps\_anim::addnotetrack_notify( "Ilona", "vo_start_ilana_fuckthatguy", "ScrambleSniperWinVO", "run_to_truck" );
    maps\_anim::addnotetrack_notify( "Ilona", "vo_start_prophet_bravohades", "ScrambleSniperWinRadioVO", "run_to_truck" );
    maps\_anim::addnotetrack_notify( "Ilona", "vo_start_ilana_copythat", "ScrambleSniperWinCopyVO", "run_to_truck" );
    level.scr_anim["Ilona"]["move_truck_idle"][0] = %hms_greece_sniperscramble_truckpush_illana_idle;
    level.scr_anim["Ilona"]["move_truck"] = %hms_greece_sniperscramble_truckpush_illana;
    level.scr_anim["Ilona"]["scramble_intro_door_in"] = %hms_greece_sniperscramble_intro_ilana_in;
    level.scr_anim["Ilona"]["scramble_intro_door_loop"][0] = %hms_greece_sniperscramble_intro_ilana_idle;
    level.scr_anim["Ilona"]["scramble_intro_door_out"] = %hms_greece_sniperscramble_intro_ilana_out;
    maps\_anim::addnotetrack_notify( "Ilona", "sniper_shot", "ScrambleSniperFireFirstShot", "scramble_intro_door_out" );
    maps\_anim::addnotetrack_notify( "Ilona", "sniper_shot_2", "ScrambleSniperFireSecondShot", "scramble_intro_door_out" );
    maps\_anim::addnotetrack_notify( "Ilona", "sniper_shot_3", "ScrambleSniperFireThirdShot", "scramble_intro_door_out" );
    maps\_anim::addnotetrack_notify( "Ilona", "start_vo_ilana_poppinsmoke", "ScramblePoppinSmokeVO", "scramble_intro_door_out" );
    maps\_anim::addnotetrack_notify( "Ilona", "start_vo_ilana_smokewontlast", "ScrambleSmokeWontLastVO", "scramble_intro_door_out" );
    maps\_anim::addnotetrack_notify( "Ilona", "start_vo_ilana_heknows", "ScrambleHeKnowsVO", "scramble_intro_door_out" );
    level.scr_anim["Ilona"]["scram_hothall"] = %hms_greece_sni_scram_hothall_ilana;
    maps\_anim::addnotetrack_notify( "Ilona", "snipershot", "hothall_sniper_shot", "scram_hothall" );
    level.scr_anim["Ilona"]["scramble_check_ally_enter"] = %hms_greece_sn_scramble_wounded_soldier_ilana_enter;
    level.scr_anim["Ilona"]["scramble_check_ally_idle"][0] = %hms_greece_sn_scramble_wounded_soldier_ilana_idle;
    level.scr_anim["Ilona"]["scramble_check_ally_exit"] = %hms_greece_sn_scramble_ilana_soldier_death;
    level.scr_anim["Ilona"]["RestaurantOpenDoor"] = %hms_greece_sni_scram_civ_cafe_exit_ilana;
    maps\_anim::addnotetrack_notify( "Ilona", "sniper_shot", "ScrambleRestaurantIlanaShot", "RestaurantOpenDoor" );
}

enemyscrambleanimations()
{
    level.scr_anim["generic"]["death_explosion_stand_R_v1"] = %death_explosion_stand_r_v1;
    level.scr_anim["generic"]["death_explosion_stand_L_v2"] = %death_explosion_stand_l_v2;
}

civscrambleanimations()
{
    level.scr_anim["generic"]["PatioFlee01_idle"][0] = %hms_greece_sniperscramble_intro_civ_idle;
    level.scr_anim["generic"]["PatioFlee01_reaction"] = %hms_greece_sniperscramble_intro_civ_out;
    maps\_anim::addnotetrack_notify( "generic", "fx_civ_shot", "ScramblePatioCivShot", "PatioFlee01_reaction" );
    level.scr_anim["generic"]["PatioFlee02_idle"][0] = %hms_greece_sniperscramble_gapjump_gawker_idle;
    level.scr_anim["generic"]["PatioFlee02_reaction"] = %hms_greece_sniperscramble_gapjump_gawker;
    level.scr_anim["generic"]["PatioFlee03_idle"][0] = %london_station_civ7_idle;
    level.scr_anim["generic"]["PatioFlee03_reaction"] = %london_station_civ7_reaction;
    level.scr_anim["generic"]["PatioFlee04_idle"][0] = %civilian_stand_idle;
    level.scr_anim["generic"]["PatioFlee04_reaction"] = %hms_greece_sniperscramble_droneflee_civ_f_02;
    level.scr_anim["generic"]["PatioFlee05_idle"][0] = %civilian_stand_idle;
    level.scr_anim["generic"]["PatioFlee05_reaction"] = %hms_greece_sniperscramble_droneflee_civ_f_01;
    level.scr_anim["generic"]["PatioFlee06_idle"][0] = %civilian_stand_idle;
    level.scr_anim["generic"]["PatioFlee06_reaction"] = %hms_greece_sniperscramble_droneflee_civ_m_01;
    level.scr_anim["hothall_male01"]["scram_hothall_idle"][0] = %hms_greece_sni_scram_hothall_civ_idle_m_1;
    level.scr_anim["hothall_male01"]["scram_hothall"] = %hms_greece_sni_scram_hothall_civ_m_1;
    level.scr_anim["hothall_male01"]["scram_hothall_idle_end"][0] = %hms_greece_sni_scram_hothall_civ_idle_end_m_1;
    level.scr_anim["hothall_female01"]["scram_hothall_idle"][0] = %hms_greece_sni_scram_hothall_civ_idle_f_1;
    level.scr_anim["hothall_female01"]["scram_hothall"] = %hms_greece_sni_scram_hothall_civ_f_1;
    level.scr_anim["hothall_female01"]["scram_hothall_idle_end"][0] = %hms_greece_sni_scram_hothall_civ_idle_end_f_1;
    level.scr_anim["hothall_male02"]["scram_hothall_idle"][0] = %hms_greece_sni_scram_hothall_civ_idle_m_2;
    level.scr_anim["hothall_male02"]["scram_hothall"] = %hms_greece_sni_scram_hothall_civ_m_2;
    level.scr_anim["hothall_female02"]["scram_hothall_idle"][0] = %hms_greece_sni_scram_hothall_civ_idle_f_2;
    level.scr_anim["hothall_female02"]["scram_hothall"] = %hms_greece_sni_scram_hothall_civ_f_2;
    level.scr_anim["generic"]["HotelFlee01_idle"][0] = %london_station_civ11_idle;
    level.scr_anim["generic"]["HotelFlee01_reaction"] = %london_station_civ11_reaction;
    level.scr_anim["generic"]["HotelFlee02_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["HotelFlee02_reaction"] = %hms_greece_alleys_civ_panic_ground_02;
    level.scr_anim["generic"]["HotelFlee02_newidle"][0] = %hms_greece_alleys_civ_panic_ground_02_idle;
    level.scr_anim["generic"]["HotelFlee03_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["HotelFlee03_reaction"] = %civilian_run_hunched_turnl90_stumble;
    level.scr_anim["generic"]["HotelFlee04_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["HotelFlee04_reaction"] = %unarmed_covercrouch_exit_4;
    level.scr_anim["generic"]["PoolFlee01_idle"][0] = %civilian_stand_idle;
    level.scr_anim["generic"]["PoolFlee01_reaction"] = %hms_greece_sniperscramble_droneflee_civ_f_01;
    level.scr_anim["generic"]["PoolFlee02_idle"][0] = %civilian_stand_idle;
    level.scr_anim["generic"]["PoolFlee02_reaction"] = %unarmed_panickedrun_stumble;
    level.scr_anim["generic"]["PoolFlee03_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["PoolFlee03_reaction"] = %hms_greece_sniperscramble_droneflee_civ_m_03;
    level.scr_anim["generic"]["PoolFlee04_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["PoolFlee04_reaction"] = %unarmed_run_pain_fall;
    level.scr_anim["generic"]["DronesFlee01_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["DronesFlee01_reaction"] = %london_station_civ4_reaction;
    level.scr_anim["generic"]["DronesFlee02_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["DronesFlee02_reaction"] = %london_station_civ7_reaction;
    level.scr_anim["generic"]["DronesFlee03_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["DronesFlee03_reaction"] = %sf_a_civillian_pedestrian_run_exit_05;
    level.scr_anim["generic"]["DronesFlee04_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["DronesFlee04_reaction"] = %hms_greece_sniperscramble_droneflee_civ_f_02;
    level.scr_anim["generic"]["DronesFlee05_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["DronesFlee05_reaction"] = %hms_greece_sniperscramble_droneflee_civ_m_02;
    level.scr_anim["generic"]["DronesFlee06_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["DronesFlee06_reaction"] = %sf_a_civillian_pedestrian_run_exit_01;
    level.scr_anim["generic"]["DronesFlee07_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["DronesFlee07_reaction"] = %airport_civ_in_line_10_a_reaction;
    level.scr_anim["generic"]["DronesFlee08_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["DronesFlee08_reaction"] = %civilian_run_2_crawldeath;
    level.scr_anim["generic"]["DronesFlee09_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["DronesFlee09_reaction"] = %airport_civ_in_line_15_b_reaction;
    level.scr_anim["generic"]["DronesFlee10_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["DronesFlee10_reaction"] = %hms_greece_civ_couple_panic_ground_01_in_f;
    level.scr_anim["generic"]["DronesFlee10_newidle"][0] = %hms_greece_civ_couple_panic_ground_01_idle_f;
    level.scr_anim["generic"]["RestaurantOpenDoor_idle"][0] = %hms_greece_sni_scram_civ_cafe_exit_idle;
    level.scr_anim["generic"]["RestaurantOpenDoor"] = %hms_greece_sni_scram_civ_cafe_exit;
    maps\_anim::addnotetrack_notify( "generic", "doors_open", "ScrambleRestaurantDoorsOpen", "RestaurantOpenDoor" );
    maps\_anim::addnotetrack_notify( "generic", "sniper_shot", "ScrambleRestaurantCivShot", "RestaurantOpenDoor" );
    level.scr_anim["generic"]["RestaurantFlee01_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["RestaurantFlee01_reaction"] = %hms_greece_civ_couple_panic_ground_02_in_f;
    level.scr_anim["generic"]["RestaurantFlee02_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["RestaurantFlee02_reaction"] = %hms_greece_civ_couple_panic_ground_02_in_m;
    level.scr_anim["generic"]["FinaleFlee01_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["FinaleFlee01_reaction"] = %airport_civ_in_line_6_c_reaction;
    level.scr_anim["generic"]["FinaleFlee02_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["FinaleFlee02_reaction"] = %airport_civ_in_line_15_b_reaction;
    level.scr_anim["generic"]["FinaleFlee03_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["FinaleFlee03_reaction"] = %hms_greece_sniperscramble_droneflee_civ_m_03;
    level.scr_anim["generic"]["FinaleFlee04_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["FinaleFlee04_reaction"] = %hms_greece_sniperscramble_droneflee_civ_m_01;
    level.scr_anim["generic"]["FinaleFlee05_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["FinaleFlee05_reaction"] = %hms_greece_sniperscramble_droneflee_civ_f_02;
    level.scr_anim["generic"]["FinaleFlee06_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["FinaleFlee06_reaction"] = %unarmed_stumble_trashcan;
    level.scr_anim["generic"]["PatioCower01_idle"][0] = %hms_greece_alleys_civ_panic_ground_02_idle;
    level.scr_anim["generic"]["PatioCower02_idle"][0] = %hms_greece_civ_couple_panic_ground_01_idle_f;
    level.scr_anim["generic"]["PatioCower03_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["PatioCower03_reaction"] = %unarmed_cowercrouch_idle_duck;
    level.scr_anim["generic"]["PoolCower01_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["PoolCower01_reaction"] = %unarmed_cowercrouch_idle_duck;
    level.scr_anim["generic"]["PoolCower02_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["PoolCower02_reaction"] = %unarmed_cowercrouch_idle_duck;
    level.scr_anim["generic"]["PoolCower03_idle"][0] = %hms_greece_trans_alley_civ_panic_pair_cov_loop_f;
    level.scr_anim["generic"]["PoolCower04_idle"][0] = %hms_greece_trans_alley_civ_panic_pair_cov_loop_m;
    level.scr_anim["generic"]["PoolCower05_idle"][0] = %airport_civ_cower_piller_idle;
    level.scr_anim["generic"]["PoolCower06_idle"][0] = %prague_woundidle_wounded;
    level.scr_anim["generic"]["PoolCower07_idle"][0] = %sf_a_civ_injured_seated_face;
    level.scr_anim["generic"]["DronesCower01_idle"][0] = %sf_a_civ_injured_laying_agony_b;
    level.scr_anim["generic"]["DronesCower02_idle"][0] = %sf_a_civ_injured_seated_crying;
    level.scr_anim["generic"]["DronesCower03_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["DronesCower03_reaction"] = %unarmed_cowercrouch_idle_duck;
    level.scr_anim["generic"]["DronesCower04_idle"][0] = %sf_a_civ_injured_seated_mourned;
    level.scr_anim["generic"]["DronesCower05_idle"][0] = %sf_a_civ_injured_seated_mourner;
    level.scr_anim["generic"]["DronesCower06_idle"][0] = %sf_a_civ_injured_seated_helper;
    level.scr_anim["generic"]["DronesCower07_idle"][0] = %sf_a_civ_injured_seated_helped;
    level.scr_anim["generic"]["RestaurantCower01_idle"][0] = %hms_greece_alleys_civ_panic_ground_01_idle;
    level.scr_anim["generic"]["RestaurantCower02_idle"][0] = %sf_a_civ_injured_laying_agony_b;
    level.scr_anim["generic"]["RestaurantCower03_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["RestaurantCower03_reaction"] = %unarmed_cowercrouch_idle_duck;
    level.scr_anim["generic"]["RestaurantCower04_idle"][0] = %hunted_pronehide_idle_v2;
    level.scr_anim["generic"]["RestaurantCower05_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["RestaurantCower05_reaction"] = %unarmed_cowercrouch_idle_duck;
    level.scr_anim["generic"]["RestaurantCower06_idle"][0] = %sf_a_civ_injured_seated_crying;
    level.scr_anim["generic"]["RestaurantCower07_idle"][0] = %unarmed_covercrouch_hide_idle;
    level.scr_anim["generic"]["RestaurantCower07_reaction"] = %unarmed_covercrouch_hide_look;
    level.scr_anim["generic"]["FinaleCower01_idle"][0] = %hms_greece_alleys_civ_panic_ground_01_idle;
    level.scr_anim["generic"]["FinaleCower02_idle"][0] = %hms_greece_alleys_civ_panic_ground_02_idle;
    level.scr_anim["generic"]["FinaleCower03_idle"][0] = %sf_a_civ_injured_seated_crying;
    level.scr_anim["generic"]["FinaleCower04_idle"][0] = %sf_a_civ_injured_laying_agony_a;
    level.scr_anim["generic"]["FinaleCower05_idle"][0] = %sf_a_civ_injured_laying_agony_b;
    level.scr_anim["generic"]["FinaleCower06_idle"][0] = %sf_a_civ_injured_seated_face;
    level.scr_anim["generic"]["FinaleCower07_idle"][0] = %hunted_pronehide_idle_v2;
    level.scr_anim["generic"]["FinaleCower08_idle"][0] = %hms_greece_trans_alley_civ_panic_pair_cov_loop_f;
    level.scr_anim["generic"]["FinaleCower09_idle"][0] = %hms_greece_trans_alley_civ_panic_pair_cov_loop_m;
    level.scr_anim["generic"]["FinaleCower10_idle"][0] = %hunted_pronehide_idle_v2;
}

allyscrambleanimations()
{
    level.scr_anim["generic"]["jeepride_dying_approach"] = %jeepride_dying_approach;
    level.scr_anim["Rivers"]["civilian_crawl_1_death_A"] = %civilian_crawl_1_death_a;
    level.scr_anim["Torres"]["sanchez_wounded_idle"][0] = %hms_greece_sn_scramble_wounded_soldier_idle;
    level.scr_anim["Torres"]["sanchez_wounded_death"] = %hms_greece_sn_scramble_wounded_soldier_death;
    maps\_anim::addnotetrack_notify( "Torres", "npc_vo_start", "ScrambleWoundedSoldierVO", "sanchez_wounded_death" );
    maps\_anim::addnotetrack_notify( "Torres", "wounded_shot", "ScrambleSniperShootWoundedSoldier", "sanchez_wounded_death" );
}

#using_animtree("vehicles");

sniperscrambleexittruckanimations()
{
    level.scr_animtree["exit_truck"] = #animtree;
    level.scr_anim["exit_truck"]["move_truck"] = %hms_greece_sniperscramble_truckpush_truck;
    level.scr_animtree["pitbull_veh"] = #animtree;
    level.scr_anim["pitbull_veh"]["pitbull_destroyed"][0] = %hms_greece_sniperscramble_pitbull_destroyed_veh;
}

#using_animtree("animated_props");

sniperscramblewindmilldestructionanimations()
{
    level.scr_animtree["greece_sniper_tower_des_01"] = #animtree;
    level.scr_model["greece_sniper_tower_des_01"] = "greece_sniper_tower_des_01";
    level.scr_anim["greece_sniper_tower_des_01"]["windmill_explode"] = %sniper_tower_seg_01;
    level.scr_animtree["greece_sniper_tower_des_02"] = #animtree;
    level.scr_model["greece_sniper_tower_des_02"] = "greece_sniper_tower_des_02";
    level.scr_anim["greece_sniper_tower_des_02"]["windmill_explode"] = %sniper_tower_seg_02;
    level.scr_animtree["greece_sniper_tower_des_03"] = #animtree;
    level.scr_model["greece_sniper_tower_des_03"] = "greece_sniper_tower_des_03";
    level.scr_anim["greece_sniper_tower_des_03"]["windmill_explode"] = %sniper_tower_seg_03;
    level.scr_animtree["greece_sniper_tower_des_04"] = #animtree;
    level.scr_model["greece_sniper_tower_des_04"] = "greece_sniper_tower_des_04";
    level.scr_anim["greece_sniper_tower_des_04"]["windmill_explode"] = %sniper_tower_seg_04;
    level.scr_animtree["greece_sniper_tower_des_05"] = #animtree;
    level.scr_model["greece_sniper_tower_des_05"] = "greece_sniper_tower_des_05";
    level.scr_anim["greece_sniper_tower_des_05"]["windmill_explode"] = %sniper_tower_seg_05;
    level.scr_animtree["greece_sniper_tower_des_06"] = #animtree;
    level.scr_model["greece_sniper_tower_des_06"] = "greece_sniper_tower_des_06";
    level.scr_anim["greece_sniper_tower_des_06"]["windmill_explode"] = %sniper_tower_seg_06;
    level.scr_animtree["greece_sniper_tower_des_07"] = #animtree;
    level.scr_model["greece_sniper_tower_des_07"] = "greece_sniper_tower_des_07";
    level.scr_anim["greece_sniper_tower_des_07"]["windmill_explode"] = %sniper_tower_seg_07;
}

sniperscramblefishanimations()
{
    level.scr_animtree["fish_a_01"] = #animtree;
    level.scr_animtree["fish_a_02"] = #animtree;
    level.scr_animtree["fish_a_03"] = #animtree;
    level.scr_animtree["fish_a_04"] = #animtree;
    level.scr_animtree["fish_a_05"] = #animtree;
    level.scr_animtree["fish_a_06"] = #animtree;
    level.scr_animtree["fish_b_01"] = #animtree;
    level.scr_animtree["fish_b_02"] = #animtree;
    level.scr_animtree["fish_b_03"] = #animtree;
    level.scr_model["fish_a_01"] = "fish_a";
    level.scr_model["fish_a_02"] = "fish_a";
    level.scr_model["fish_a_03"] = "fish_a";
    level.scr_model["fish_a_04"] = "fish_a";
    level.scr_model["fish_a_05"] = "fish_a";
    level.scr_model["fish_a_06"] = "fish_a";
    level.scr_model["fish_b_01"] = "fish_b";
    level.scr_model["fish_b_02"] = "fish_b";
    level.scr_model["fish_b_03"] = "fish_b";
    level.scr_anim["fish_a_01"]["fish_a_swimming"][0] = %fish_a_swimmingtrack_01;
    level.scr_anim["fish_a_02"]["fish_a_swimming"][0] = %fish_a_swimmingtrack_02;
    level.scr_anim["fish_a_03"]["fish_a_swimming"][0] = %fish_a_swimmingtrack_03;
    level.scr_anim["fish_a_04"]["fish_a_swimming"][0] = %fish_a_swimmingtrack_04;
    level.scr_anim["fish_a_05"]["fish_a_swimming"][0] = %fish_a_swimmingtrack_05;
    level.scr_anim["fish_a_06"]["fish_a_swimming"][0] = %fish_a_swimmingtrack_06;
    level.scr_anim["fish_b_01"]["fish_b_swimming"][0] = %fish_b_swimmingtrack_01;
    level.scr_anim["fish_b_02"]["fish_b_swimming"][0] = %fish_b_swimmingtrack_02;
    level.scr_anim["fish_b_03"]["fish_b_swimming"][0] = %fish_b_swimmingtrack_03;
    level.scr_anim["fish_a_01"]["fish_falling"] = %fish_a_tankfall_01;
    level.scr_anim["fish_a_02"]["fish_falling"] = %fish_a_tankfall_02;
    level.scr_anim["fish_a_03"]["fish_falling"] = %fish_a_tankfall_03;
    level.scr_anim["fish_a_04"]["fish_falling"] = %fish_a_tankfall_01;
    level.scr_anim["fish_a_05"]["fish_falling"] = %fish_a_tankfall_02;
    level.scr_anim["fish_a_06"]["fish_falling"] = %fish_a_tankfall_03;
    level.scr_anim["fish_b_01"]["fish_falling"] = %fish_a_tankfall_01;
    level.scr_anim["fish_b_02"]["fish_falling"] = %fish_a_tankfall_02;
    level.scr_anim["fish_b_03"]["fish_falling"] = %fish_a_tankfall_03;
    level.scr_anim["fish_a_01"]["fish_deathflop_a"][0] = %fish_a_deathflop;
    level.scr_anim["fish_a_02"]["fish_deathflop_a"][0] = %fish_a_deathflop;
    level.scr_anim["fish_a_03"]["fish_deathflop_a"][0] = %fish_a_deathflop;
    level.scr_anim["fish_a_04"]["fish_deathflop_a"][0] = %fish_a_deathflop;
    level.scr_anim["fish_a_05"]["fish_deathflop_a"][0] = %fish_a_deathflop;
    level.scr_anim["fish_a_06"]["fish_deathflop_a"][0] = %fish_a_deathflop;
    level.scr_anim["fish_b_01"]["fish_deathflop_b"][0] = %fish_b_deathflop;
    level.scr_anim["fish_b_02"]["fish_deathflop_b"][0] = %fish_b_deathflop;
    level.scr_anim["fish_b_03"]["fish_deathflop_b"][0] = %fish_b_deathflop;
}

sniperscrambleintrodooranimations()
{
    level.scr_animtree["sniper_intro_door"] = #animtree;
    level.scr_anim["sniper_intro_door"]["scramble_intro_door_out"] = %hms_greece_sniperscramble_intro_door_out;
    maps\_anim::addnotetrack_customfunction( "sniper_intro_door", "fx_tag_hole1", maps\greece_sniper_scramble_fx::sniperdoorhitfx1 );
    maps\_anim::addnotetrack_customfunction( "sniper_intro_door", "fx_tag_hole2", maps\greece_sniper_scramble_fx::sniperdoorhitfx2 );
    level.scr_model["smoke_grenade"] = "npc_variable_grenade_nonlethal";
    level.scr_animtree["smoke_grenade"] = #animtree;
    level.scr_anim["smoke_grenade"]["scramble_intro_door_out"] = %hms_greece_sniperscramble_intro_grenade_out;
    level.scr_animtree["sniper_restaurant_door"] = #animtree;
    level.scr_anim["sniper_restaurant_door"]["RestaurantOpenDoor"] = %hms_greece_sni_scram_civ_cafe_exit_doors;
    level.scr_animtree["visitorgate"] = #animtree;
    level.scr_anim["visitorgate"]["alleys_gate_rip"] = %hms_greece_alleys_gate_rip_gate;
}

sniperscramblegondolaanimations()
{
    level.scr_animtree["gondola_01"] = #animtree;
    level.scr_model["gondola_01"] = "greece_cable_car_rigged";
    level.scr_anim["gondola_01"]["gondola_loop"][0] = %hms_greece_sniperscramble_gondola_cablecar_01;
    level.scr_animtree["gondola_02"] = #animtree;
    level.scr_model["gondola_02"] = "greece_cable_car_rigged";
    level.scr_anim["gondola_02"]["gondola_loop"][0] = %hms_greece_sniperscramble_gondola_cablecar_02;
    level.scr_animtree["gondola_03"] = #animtree;
    level.scr_model["gondola_03"] = "greece_cable_car_rigged";
    level.scr_anim["gondola_03"]["gondola_loop"][0] = %hms_greece_sniperscramble_gondola_cablecar_03;
    level.scr_animtree["gondola_04"] = #animtree;
    level.scr_model["gondola_04"] = "greece_cable_car_rigged";
    level.scr_anim["gondola_04"]["gondola_loop"][0] = %hms_greece_sniperscramble_gondola_cablecar_04;
}

scramblejumprumblelight( var_0 )
{
    earthquake( 0.1, 0.1, level.player.origin, 128 );
    level.player playrumbleonentity( "damage_light" );
}

scramblejumprumbleheavy( var_0 )
{
    earthquake( 0.5, 0.5, level.player.origin, 128 );
    level.player playrumbleonentity( "damage_heavy" );
}

scrambletruckpushrumbleheavy( var_0 )
{
    earthquake( 0.5, 0.5, level.player.origin, 128 );
    level.player playrumbleonentity( "damage_heavy" );
}
