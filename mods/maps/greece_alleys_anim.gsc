// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    ilanaanims();
    playeranims();
    civiliananims();
    alleysintroanims();
    alleyscafeanims();
    propanims();
}

#using_animtree("player");

playeranims()
{
    level.scr_animtree["player_alleys_rig"] = #animtree;
    level.scr_model["player_alleys_rig"] = "s1_gfl_ump45_viewbody";
    level.scr_anim["player_alleys_rig"]["alleys_gate_rip"] = %hms_greece_alleys_gate_rip_vm;
}

#using_animtree("generic_human");

ilanaanims()
{
    level.scr_anim["Ilona"]["safehouse_gate_bash"] = %hms_greece_safehouse_gate_bash_illana;
    maps\_anim::addnotetrack_notify( "Ilona", "Start_gate_anim", "GateAnimStart", "safehouse_gate_bash" );
    maps\_anim::addnotetrack_customfunction( "Ilona", "Start_gate_anim", ::alleysgatebashrumblelight, "safehouse_gate_bash" );
    level.scr_anim["Ilona"]["trans_alley_sprint_wpn_ilana"][0] = %hms_greece_trans_alley_sprint_wpn_ilana;
}

civiliananims()
{
    level.scr_anim["generic"]["trans_alley_civ_doors_peek_out"] = %hms_greece_trans_alley_civ_doors_peek_out;
    level.scr_anim["generic"]["trans_alley_civ_doors_peek_idle"][0] = %hms_greece_trans_alley_civ_doors_peek_idle;
    level.scr_anim["generic"]["trans_alley_civ_doors_peek_in"] = %hms_greece_trans_alley_civ_doors_peek_in;
    level.scr_anim["generic"]["trans_alley_civ_doors_runin"] = %hms_greece_trans_alley_civ_doors_runin;
    level.scr_anim["generic"]["hms_greece_trans_alley_sit_smoke_idle"][0] = %hms_greece_trans_alley_sit_smoke_idle;
    level.scr_anim["generic"]["hms_greece_trans_alley_sit_smoke_out"] = %hms_greece_trans_alley_sit_smoke_out;
    level.scr_anim["generic"]["hms_greece_trans_alley_sit_smoke_scared_loop"][0] = %hms_greece_trans_alley_sit_smoke_scared_loop;
    level.scr_anim["generic"]["hms_greece_trans_alley_civ_gawk_phone_mir"][0] = %hms_greece_trans_alley_civ_gawk_phone_mir;
    level.scr_anim["generic"]["unarmed_cowerstand_idle"][0] = %unarmed_cowerstand_idle;
    level.scr_anim["generic"]["unarmed_cowerstand_react_2_crouch"] = %unarmed_cowerstand_react_2_crouch;
    level.scr_anim["generic"]["unarmed_cowercrouch_idle"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["ch_pragueb_15_6_wounded_civ_02_loop"][0] = %ch_pragueb_15_6_wounded_civ_02_loop;
    level.scr_anim["generic"]["civilain_crouch_hide_idle_loop"][0] = %civilain_crouch_hide_idle_loop;
    level.scr_anim["generic"]["sf_a_civ_injured_seated_helper"][0] = %sf_a_civ_injured_seated_helper;
    level.scr_anim["generic"]["sf_a_civ_injured_seated_helped"][0] = %sf_a_civ_injured_seated_helped;
    level.scr_anim["generic"]["sf_a_civ_injured_seated_crying"][0] = %sf_a_civ_injured_seated_crying;
    level.scr_anim["generic"]["sf_a_civ_injured_seated_face"][0] = %sf_a_civ_injured_seated_face;
    level.scr_anim["generic"]["sf_a_civ_injured_seated_mourner"][0] = %sf_a_civ_injured_seated_mourner;
    level.scr_anim["generic"]["sf_a_civ_injured_seated_mourned"][0] = %sf_a_civ_injured_seated_mourned;
    level.scr_anim["generic"]["sf_a_civillian_pedestrian_run_exit_01"] = %sf_a_civillian_pedestrian_run_exit_01;
    level.scr_anim["generic"]["sf_a_civillian_pedestrian_run_exit_02"] = %sf_a_civillian_pedestrian_run_exit_02;
    level.scr_anim["generic"]["sf_a_civillian_pedestrian_run_exit_03"] = %sf_a_civillian_pedestrian_run_exit_03;
    level.scr_anim["generic"]["sf_a_civillian_pedestrian_run_exit_04"] = %sf_a_civillian_pedestrian_run_exit_04;
    level.scr_anim["generic"]["sf_a_civillian_pedestrian_run_exit_05"] = %sf_a_civillian_pedestrian_run_exit_05;
    level.scr_anim["generic"]["sf_a_civillian_pedestrian_run_exit_06"] = %sf_a_civillian_pedestrian_run_exit_06;
    level.scr_anim["generic"]["sf_a_civillian_pedestrian_run_exit_07"] = %sf_a_civillian_pedestrian_run_exit_07;
    level.scr_anim["Male_Panic"]["panic_pair_cov_loop"][0] = %hms_greece_trans_alley_civ_panic_pair_cov_loop_m;
    level.scr_anim["Female_Panic"]["panic_pair_cov_loop"][0] = %hms_greece_trans_alley_civ_panic_pair_cov_loop_f;
    level.scr_anim["backdoor_civ"]["backdoor_panic"] = %hms_greece_trans_alley_civ_panic_backdoor_npc;
    level.scr_anim["window_civ"]["window_peek_all"] = %hms_greece_trans_alley_civ_window_peek_all;
    level.scr_anim["generic"]["civilian_leaning_death"] = %civilian_leaning_death;
    level.scr_anim["generic"]["civilian_crawl_1_death_A"] = %civilian_crawl_1_death_a;
}

alleyscafeanims()
{
    level.scr_anim["cafe1"]["hms_greece_trans_alley_cafe_civ_idle"][0] = %hms_greece_trans_alley_cafe_civ_idle_01;
    level.scr_anim["cafe2"]["hms_greece_trans_alley_cafe_civ_idle"][0] = %hms_greece_trans_alley_cafe_civ_idle_02;
    level.scr_anim["cafe3"]["hms_greece_trans_alley_cafe_civ_idle"][0] = %hms_greece_trans_alley_cafe_civ_idle_03;
    level.scr_anim["cafe4"]["hms_greece_trans_alley_cafe_civ_idle"][0] = %hms_greece_trans_alley_cafe_civ_idle_04;
    level.scr_anim["cafe5"]["hms_greece_trans_alley_cafe_civ_idle"][0] = %hms_greece_trans_alley_cafe_civ_idle_05;
    level.scr_anim["cafe6"]["hms_greece_trans_alley_cafe_civ_idle"][0] = %hms_greece_trans_alley_cafe_civ_idle_06;
    level.scr_anim["cafe7"]["hms_greece_trans_alley_cafe_civ_idle"][0] = %hms_greece_trans_alley_cafe_civ_idle_07;
    level.scr_anim["cafe1"]["hms_greece_trans_alley_cafe_civ_sit2stand_01"] = %hms_greece_trans_alley_cafe_civ_sit2stand_01;
    level.scr_anim["cafe1"]["hms_greece_trans_alley_cafe_civ_stand_idle_01"][0] = %hms_greece_trans_alley_cafe_civ_stand_idle_01;
    level.scr_anim["cafe1"]["hms_greece_trans_alley_cafe_civ_exit"] = %hms_greece_trans_alley_cafe_civ_exit_01;
    level.scr_anim["cafe2"]["hms_greece_trans_alley_cafe_civ_exit"] = %hms_greece_trans_alley_cafe_civ_exit_02;
    level.scr_anim["cafe3"]["hms_greece_trans_alley_cafe_civ_exit"] = %hms_greece_trans_alley_cafe_civ_exit_03;
    level.scr_anim["cafe4"]["hms_greece_trans_alley_cafe_civ_exit"] = %hms_greece_trans_alley_cafe_civ_exit_04;
    level.scr_anim["cafe5"]["hms_greece_trans_alley_cafe_civ_exit"] = %hms_greece_trans_alley_cafe_civ_exit_05;
    level.scr_anim["cafe6"]["hms_greece_trans_alley_cafe_civ_exit"] = %hms_greece_trans_alley_cafe_civ_exit_06;
    level.scr_anim["cafe7"]["hms_greece_trans_alley_cafe_civ_exit"] = %hms_greece_trans_alley_cafe_civ_exit_07;
}

alleysintroanims()
{
    level.scr_anim["runner1"]["hms_greece_alleys_npc_civtd_civp1"] = %hms_greece_alleys_npc_civtd_civp1_01;
    level.scr_anim["runner3"]["hms_greece_alleys_npc_civtd_civp1"] = %hms_greece_alleys_npc_civtd_civp1_03;
    level.scr_anim["guard1"]["hms_greece_alleys_npc_civtd_civp2"] = %hms_greece_alleys_npc_civtd_guard_01;
    level.scr_anim["guard2"]["hms_greece_alleys_npc_civtd_civp2"] = %hms_greece_alleys_npc_civtd_guard_02;
    level.scr_anim["guard3"]["hms_greece_alleys_npc_civtd_civp2"] = %det_casual_stopstarts_walk_to_idle_burke;
    level.scr_anim["victim1"]["hms_greece_alleys_npc_civtd_civp2"] = %hms_greece_alleys_npc_civtd_civp2_01;
    level.scr_anim["victim2"]["hms_greece_alleys_npc_civtd_civp2"] = %hms_greece_alleys_npc_civtd_civp2_02;
    level.scr_anim["victim3"]["hms_greece_alleys_npc_civtd_civp2"] = %hms_greece_alleys_npc_civtd_civp2_03;
    level.scr_anim["victim4"]["hms_greece_alleys_npc_civtd_civp2"] = %hms_greece_alleys_npc_civtd_civp2_04;
    level.scr_anim["victim4"]["hms_greece_alleys_npc_civtd_civp2_04_idle"][0] = %hms_greece_alleys_npc_civtd_civp2_04_idle;
    level.scr_anim["victim5"]["hms_greece_alleys_npc_civtd_civp2"] = %hms_greece_alleys_npc_civtd_civp2_05;
    level.scr_anim["victim5"]["hms_greece_alleys_npc_civtd_civp2_05_idle"][0] = %hms_greece_alleys_npc_civtd_civp2_05_idle;
}

#using_animtree("animated_props");

propanims()
{
    level.scr_animtree["peek_door"] = #animtree;
    level.scr_anim["peek_door"]["trans_alley_civ_doors_peek_out"] = %hms_greece_trans_alley_civ_doors_peek_out_door;
    level.scr_anim["peek_door"]["trans_alley_civ_doors_peek_idle"][0] = %hms_greece_trans_alley_civ_doors_peek_idle_door;
    level.scr_anim["peek_door"]["trans_alley_civ_doors_peek_in"] = %hms_greece_trans_alley_civ_doors_peek_in_door;
    level.scr_animtree["runin_door"] = #animtree;
    level.scr_anim["runin_door"]["trans_alley_civ_doors_runin"] = %hms_greece_trans_alley_civ_doors_runin_door;
    level.scr_animtree["window_shutters"] = #animtree;
    level.scr_anim["window_shutters"]["window_peek_all"] = %hms_greece_trans_alley_civ_window_peek_all_window;
    level.scr_animtree["backdoor"] = #animtree;
    level.scr_anim["backdoor"]["backdoor_panic"] = %hms_greece_trans_alley_civ_panic_backdoor_door;
    level.scr_animtree["alley_gate"] = #animtree;
    level.scr_anim["alley_gate"]["safehouse_gate_bash"] = %hms_greece_safehouse_gate_bash_prop;
    level.scr_animtree["visitorgate"] = #animtree;
    level.scr_anim["visitorgate"]["alleys_gate_rip"] = %hms_greece_alleys_gate_rip_gate;
    maps\_anim::addnotetrack_customfunction( "visitorgate", "ps_gate_rip", ::alleysgateriprumbleheavy, "alleys_gate_rip" );
}

alleysgatebashrumblelight( var_0 )
{
    earthquake( 0.25, 0.25, var_0.origin, 256 );
    level.player playrumbleonentity( "damage_light" );
}

alleysgateriprumbleheavy( var_0 )
{
    thread maps\greece_alleys::alleysgateripunblockpath();
    earthquake( 0.5, 0.5, level.player.origin, 128 );
    level.player playrumbleonentity( "damage_heavy" );
}
