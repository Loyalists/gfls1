// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    allystealthanimations();
    enemypatrolanimations();
    enemyreactanimations();
    poolkillanimations();
    walkwaystruggleanimations();
    conferenceroomanimations();
    gatebreachanimations();
    precachescriptmodelanims();
    sniperdronelaunchanims();
    atriumanimations();
    truckbodystashanimations();
    setupvehicleanims();
    flyinanimations();
    garagedooranimations();
}

#using_animtree("player");

sniperdronelaunchanims()
{
    level.scr_animtree["player_safehouse_rig"] = #animtree;
    level.scr_anim["player_safehouse_rig"]["drone_launch_control_pad"] = %hms_greece_safehouse_dronelaunch_pad_vm;
}

#using_animtree("generic_human");

allystealthanimations()
{
    level.scr_anim["generic"]["flash_open_door"] = %door_kick_in;
}

enemypatrolanimations()
{
    level.scr_anim["generic"]["hms_greece_cc_talking_guards_1"][0] = %hms_greece_cc_talking_guards_1;
    level.scr_anim["generic"]["hms_greece_cc_talking_guards_1_react"] = %patrol_bored_react_look_v2;
    level.scr_anim["generic"]["hms_greece_cc_talking_guards_2"][0] = %hms_greece_cc_talking_guards_2;
    level.scr_anim["generic"]["hms_greece_cc_talking_guards_2_react"] = %patrol_bored_react_look_v1;
    level.scr_anim["generic"]["oilrig_balcony_smoke_idle"][0] = %oilrig_balcony_smoke_idle;
    level.scr_anim["generic"]["prague_sniper_pacing"][0] = %prague_sniper_pacing;
    level.scr_anim["generic"]["parabolic_phoneguy_idle"][0] = %parabolic_phoneguy_idle;
    level.scr_anim["generic"]["hms_greece_cc_gate_breach_guard_aprch"] = %hms_greece_cc_gate_breach_guard_aprch;
    maps\_anim::addnotetrack_notify( "generic", "vo_start_1", "GateGuardDialog1", "hms_greece_cc_gate_breach_guard_aprch" );
    maps\_anim::addnotetrack_notify( "generic", "vo_start_2", "GateGuardDialog2", "hms_greece_cc_gate_breach_guard_aprch" );
    level.scr_anim["generic"]["parabolic_leaning_guy_idle"][0] = %parabolic_leaning_guy_idle;
    level.scr_anim["generic"]["parabolic_leaning_guy_idle"][1] = %parabolic_leaning_guy_twitch;
    level.scr_anim["generic"]["casual_stand_idle"][0] = %casual_stand_idle;
    level.scr_anim["generic"]["casual_stand_idle"][1] = %casual_stand_idle_twitch;
    level.scr_anim["generic"]["casual_stand_idle"][2] = %casual_stand_idle_twitchb;
    level.scr_anim["generic"]["readystand_idle"][1] = %readystand_idle_twitch_1;
    level.scr_anim["generic"]["readystand_idle"][2] = %readystand_idle_twitch_2;
    level.scr_anim["generic"]["readystand_idle"][3] = %readystand_idle_twitch_3;
    level.scr_anim["generic"]["readystand_idle"][4] = %readystand_idle_twitch_4;
    level.scr_anim["generic"]["patrol_bored_idle"][0] = %patrol_bored_idle;
    level.scr_anim["generic"]["prague_sniper_lookout_idle"][0] = %prague_sniper_lookout_idle;
    level.scr_anim["generic"]["patrolstand_idle"][0] = %patrolstand_idle;
    level.scr_anim["generic"]["patrolstand_idle"][1] = %patrolstand_twitch;
    level.scr_anim["generic"]["patrolstand_idle"][2] = %patrolstand_look;
    level.scr_anim["generic"]["patrol_bored_react_look"][0] = %patrol_bored_react_look_v1;
    level.scr_anim["generic"]["patrol_bored_react_look"][1] = %patrol_bored_react_look_v2;
    level.scr_anim["generic"]["so_hijack_search_gear_check_loop"][0] = %so_hijack_search_gear_check_loop;
    level.scr_anim["generic"]["so_hijack_search_gear_check_loop_react"] = %so_hijack_search_gear_check_reaction;
    level.scr_anim["generic"]["patrol_bored_duckandrun_b"] = %patrol_bored_duckandrun_b;
    level.scr_anim["generic"]["so_hijack_search_gear_check_reaction"] = %so_hijack_search_gear_check_reaction;
    level.scr_anim["generic"]["hms_greece_cc_car_alarm_idle_01"][0] = %hms_greece_cc_car_alarm_idle_01;
    level.scr_anim["generic"]["hms_greece_cc_car_alarm_idle_01_react"] = %patrol_bored_react_look_v1;
    level.scr_anim["generic"]["hms_greece_cc_car_alarm_idle_02_in"] = %hms_greece_cc_car_alarm_walk_stop_02;
    level.scr_anim["generic"]["hms_greece_cc_car_alarm_idle_02"][0] = %hms_greece_cc_car_alarm_idle_02;
    level.scr_anim["generic"]["hms_greece_cc_car_alarm_idle_02_react"] = %patrol_bored_react_look_v2;
    level.scr_anim["generic"]["prague_intro_dock_guard_searchwater_center"][0] = %prague_intro_dock_guard_searchwater_center;
    level.scr_anim["generic"]["active_patrolwalk"] = %active_patrolwalk_v1;
    level.scr_anim["generic"]["active_patrolwalk_gundown"] = %active_patrolwalk_gundown;
    level.scr_anim["generic"]["patrolwalk_tired"] = %patrolwalk_tired;
    level.scr_anim["generic"]["patrol_bored_patrolwalk"] = %patrol_bored_patrolwalk;
    level.scr_anim["generic"]["run_pain"] = %run_pain_stomach_stumble;
    level.scr_anim["generic"]["creepwalk_f"] = %creepwalk_f;
}

enemyreactanimations()
{
    level.scr_anim["generic"]["prague_sniper_lookout_idle"][0] = %prague_sniper_lookout_idle;
    level.scr_anim["generic"]["car_alarm_idle_02_in"] = %hms_greece_cc_car_alarm_walk_stop_02;
    level.scr_anim["generic"]["car_alarm_idle_01"][0] = %hms_greece_cc_car_alarm_idle_01;
    level.scr_anim["generic"]["car_alarm_idle_02"][0] = %hms_greece_cc_car_alarm_idle_02;
    level.scr_anim["generic"]["balconykill_idle"][0] = %hms_greece_cc_balconykill_idle;
    level.scr_anim["generic"]["balconykill_react_advance"] = %patrol_bored_react_look_advance;
    level.scr_anim["generic"]["balconykill_death_forward"] = %exposed_death_falltoknees;
    level.scr_anim["generic"]["balconykill_death_back"] = %exposed_death_blowback;
    level.scr_anim["generic"]["npc_alert_radio_call"] = %npc_alert_radio_call;
    level.scr_anim["generic"]["breach_react_blowback_v2"] = %breach_react_blowback_v2;
}

poolkillanimations()
{
    level.scr_anim["victim"]["parabolic_phoneguy_idle"][0] = %parabolic_phoneguy_idle;
    level.scr_anim["infiltrator2"]["parabolic_knifekill"] = %parabolic_knifekill_mark;
    level.scr_anim["victim"]["parabolic_knifekill"] = %parabolic_knifekill_phoneguy;
    maps\_anim::addnotetrack_customfunction( "victim", "end_reaction", ::walkwayguardstoptalking, "parabolic_knifekill" );
    maps\_anim::addnotetrack_customfunction( "victim", "struggle", ::stealthkillvictim, "parabolic_knifekill" );
    maps\_anim::addnotetrack_notify( "victim", "struggle", "WalkwayGuyStruggle", "parabolic_knifekill" );
    level.scr_anim["infiltrator1"]["pool_traverse_in"] = %hms_greece_cc_pool_traverse_wall_in_npc1;
    level.scr_anim["infiltrator2"]["pool_traverse_in"] = %hms_greece_cc_pool_traverse_wall_in_npc2;
    level.scr_anim["infiltrator1"]["pool_traverse_idle"][0] = %hms_greece_cc_pool_traverse_wall_idle_npc1;
    level.scr_anim["infiltrator2"]["pool_traverse_idle"][0] = %hms_greece_cc_pool_traverse_wall_idle_npc2;
    level.scr_anim["infiltrator1"]["pool_traverse_out"] = %hms_greece_cc_pool_traverse_wall_out_npc1;
    level.scr_anim["infiltrator2"]["pool_traverse_out"] = %hms_greece_cc_pool_traverse_wall_out_npc2;
    level.scr_anim["infiltrator1"]["hms_greece_cc_takedown_idle"][0] = %hms_greece_cc_takedown_idle_npc1;
    level.scr_anim["infiltrator2"]["hms_greece_cc_takedown_idle"][0] = %hms_greece_cc_takedown_idle_npc2;
    level.scr_anim["infiltrator3"]["hms_greece_cc_takedown_idle"][0] = %hms_greece_cc_takedown_idle_npc3;
    level.scr_anim["infiltrator4"]["hms_greece_cc_takedown_idle"][0] = %hms_greece_cc_takedown_idle_npc4;
    level.scr_anim["victim"]["hms_greece_cc_takedown_idle"][0] = %hms_greece_cc_takedown_idle_target;
    level.scr_anim["victim"]["hms_greece_cc_takedown_react"] = %hms_greece_cc_takedown_alert_target;
    level.scr_anim["victim"]["hms_greece_cc_takedown_fail_death"] = %stand_death_guts;
    level.scr_anim["infiltrator1"]["hms_greece_cc_takedown"] = %hms_greece_cc_takedown_npc1;
    maps\_anim::addnotetrack_customfunction( "infiltrator1", "Knife_Equip", ::knifeequip, "hms_greece_cc_takedown" );
    maps\_anim::addnotetrack_customfunction( "infiltrator1", "Knife_Detach", ::knifedetach, "hms_greece_cc_takedown" );
    level.scr_anim["infiltrator2"]["hms_greece_cc_takedown"] = %hms_greece_cc_takedown_npc2;
    level.scr_anim["infiltrator3"]["hms_greece_cc_takedown"] = %hms_greece_cc_takedown_npc3;
    level.scr_anim["infiltrator4"]["hms_greece_cc_takedown"] = %hms_greece_cc_takedown_npc4;
    level.scr_anim["victim"]["hms_greece_cc_takedown"] = %hms_greece_cc_takedown_target;
    level.scr_anim["victim"]["hms_greece_cc_takedown_death"] = %hms_greece_cc_takedown_death_target;
    level.scr_anim["infiltrator1"]["hms_greece_cc_takedown_fail"] = %hms_greece_cc_takedown_fail_npc1;
    level.scr_anim["infiltrator2"]["hms_greece_cc_takedown_fail"] = %hms_greece_cc_takedown_fail_npc2;
    level.scr_anim["infiltratorburke"]["stairway_takedown"] = %hms_greece_stairway_takedown_ally;
    level.scr_anim["victim"]["stairway_takedown"] = %hms_greece_stairway_takedown_enemy;
    level.scr_anim["infiltratorburke"]["stairway_takedown_idle"][0] = %hms_greece_stairway_takedown_idle_ally;
}

knifeequip( var_0 )
{
    var_0.knife_attached = 1;
    var_0 attach( "weapon_parabolic_knife", "TAG_INHAND", 1 );
    maps\_utility::waittill_notetrack_or_damage( "Knife_Stab" );
    playfxontag( common_scripts\utility::getfx( "knife_kill_fx" ), var_0, "tag_knife_fx" );
}

knifedetach( var_0 )
{
    if ( isdefined( var_0.knife_attached ) && var_0.knife_attached )
    {
        var_0 detach( "weapon_parabolic_knife", "TAG_INHAND", 1 );
        var_0.knife_attached = undefined;
    }
}

walkwaystruggleanimations()
{
    level.scr_anim["infiltratorburke"]["burkeambush"] = %hms_greece_cc_burkeambush_burke_live;
    maps\_anim::addnotetrack_customfunction( "infiltratorburke", "burke_gets_hit", maps\greece_conf_center::burkeambushnohitnotetrack, "burkeambush" );
    level.scr_anim["infiltratorburke"]["burkeambush_death"] = %hms_greece_cc_burkeambush_burke_death;
    level.scr_anim["infiltratorburke"]["burkeambush_nohit"] = %hms_greece_cc_burkeambush_burke_nohit;
    level.scr_anim["attacker"]["burkeambush"] = %hms_greece_cc_burkeambush_guard;
}

truckbodystashanimations()
{
    level.scr_anim["guard1"]["bodystash_in"] = %hms_greece_cc_truck_bodystash_trans_in_guard1;
    level.scr_anim["guard2"]["bodystash_in"] = %hms_greece_cc_truck_bodystash_trans_in_guard2;
    level.scr_anim["guard1"]["bodystash_react"] = %payback_sstorm_guard_shoot_reaction_1;
    level.scr_anim["guard2"]["bodystash_react"] = %payback_sstorm_guard_shoot_reaction_2;
    level.scr_anim["infiltratorburke"]["bodystash_idle"][0] = %hms_greece_cc_truck_bodystash_idle_burke;
    level.scr_anim["guard1"]["bodystash_idle"][0] = %hms_greece_cc_truck_bodystash_idle_guard1;
    level.scr_anim["guard2"]["bodystash_idle"][0] = %hms_greece_cc_truck_bodystash_idle_guard2;
    level.scr_anim["guard1"]["bodystash_start_idle"][0] = %hms_greece_cc_truck_bodystash_start_idle_guard1;
    level.scr_anim["guard2"]["bodystash_start_idle"][0] = %hms_greece_cc_truck_bodystash_start_idle_guard2;
    level.scr_anim["guard1"]["bodystash"] = %hms_greece_cc_truck_bodystash_trans_out_guard1;
    maps\_anim::addnotetrack_customfunction( "guard1", "ps_moving_truck_npc_bodyfall", ::stealthkillvictim, "bodystash" );
    level.scr_anim["guard1"]["bodystash_alt"] = %hms_greece_cc_truck_bodystash_trans_out_guard2_alt;
    level.scr_anim["guard2"]["bodystash"] = %hms_greece_cc_truck_bodystash_trans_out_guard2;
    maps\_anim::addnotetrack_customfunction( "guard2", "start_ragdoll_custom", maps\greece_conf_center::guytruckbloodnotetrack, "bodystash" );
    maps\_anim::addnotetrack_notify( "guard2", "start_ragdoll_custom", "guard2_ragdoll", "bodystash" );
    maps\_anim::addnotetrack_customfunction( "guard2", "weapon_swap", ::truckstashweaponswap, "bodystash" );
    level.scr_anim["guard2"]["bodystash_alt"] = %hms_greece_cc_truck_bodystash_trans_out_guard1_alt;
    maps\_anim::addnotetrack_customfunction( "guard2", "start_ragdoll_custom", maps\greece_conf_center::guytruckbloodnotetrack, "bodystash_alt" );
    maps\_anim::addnotetrack_notify( "guard2", "start_ragdoll_custom", "guard2_ragdoll", "bodystash_alt" );
    maps\_anim::addnotetrack_customfunction( "guard2", "weapon_swap", ::truckstashweaponswap, "bodystash_alt" );
    level.scr_anim["infiltratorburke"]["bodystash"] = %hms_greece_cc_truck_bodystash_trans_out_burke;
    maps\_anim::addnotetrack_customfunction( "infiltratorburke", "fire", maps\greece_conf_center::guyextrabloodnotetrack, "bodystash" );
    maps\_anim::addnotetrack_customfunction( "infiltratorburke", "fire", ::removetruckguardoutline, "bodystash" );
    level.scr_anim["infiltratorburke"]["bodystash_alt"] = %hms_greece_cc_truck_bodystash_trans_out_burke_alt;
    level.scr_anim["infiltrator1"]["bodystash"] = %hms_greece_cc_truck_bodystash_trans_out_npc1;
    maps\_anim::addnotetrack_notify( "infiltrator1", "OutlineMode_initiate", "outline_allies", "bodystash" );
    level.scr_anim["infiltrator1"]["bodystash_alt"] = %hms_greece_cc_truck_bodystash_trans_out_npc1_alt;
    level.scr_anim["infiltrator2"]["bodystash"] = %hms_greece_cc_truck_bodystash_trans_out_npc2;
    maps\_anim::addnotetrack_notify( "infiltrator2", "OutlineMode_initiate", "outline_allies", "bodystash" );
    level.scr_anim["infiltrator2"]["bodystash_alt"] = %hms_greece_cc_truck_bodystash_trans_out_npc2_alt;
    maps\_anim::addnotetrack_customfunction( "infiltrator2", "ps_moving_truck_npc_shoot_alt", maps\greece_conf_center::guyextrabloodnotetrack, "bodystash_alt" );
    maps\_anim::addnotetrack_customfunction( "infiltrator2", "ps_moving_truck_npc_shoot_alt", ::removetruckguardoutline, "bodystash_alt" );
    level.scr_anim["guard1"]["active_patrolwalk_gundown"] = %active_patrolwalk_gundown;
    level.scr_anim["guard2"]["casual_killer_walk_F"] = %casual_killer_walk_f;
}

gatebreachanimations()
{
    level.scr_anim["infiltratorburke"]["gate_breach"] = %hms_greece_cc_gate_breach_burke;
    level.scr_anim["infiltratorburke"]["gate_breach_alt"] = %hms_greece_cc_gate_breach_burke_alt;
    maps\_anim::addnotetrack_customfunction( "infiltratorburke", "fire", ::gatebreachkillburke, "gate_breach_alt" );
    level.scr_anim["infiltrator1"]["gate_breach"] = %hms_greece_cc_gate_breach_npc1;
    maps\_anim::addnotetrack_customfunction( "infiltrator1", "fire", ::gatebreachkill1, "gate_breach" );
    level.scr_anim["infiltrator1"]["gate_breach_alt"] = %hms_greece_cc_gate_breach_npc1_alt;
    maps\_anim::addnotetrack_customfunction( "infiltrator1", "fire", ::gatebreachkill1, "gate_breach_alt" );
    level.scr_anim["infiltrator2"]["gate_breach"] = %hms_greece_cc_gate_breach_npc2;
    maps\_anim::addnotetrack_customfunction( "infiltrator2", "fire", ::gatebreachkill2, "gate_breach" );
    level.scr_anim["infiltrator2"]["gate_breach_alt"] = %hms_greece_cc_gate_breach_npc2_alt;
    maps\_anim::addnotetrack_customfunction( "infiltrator2", "fire", ::gatebreachkill2, "gate_breach_alt" );
    level.scr_anim["victim"]["gate_breach"] = %hms_greece_cc_gate_breach_guard;
    level.scr_anim["infiltratorburke"]["gate_breach_idle"][0] = %hms_greece_cc_gate_breach_idle_burke;
    level.scr_anim["infiltrator1"]["gate_breach_idle"][0] = %hms_greece_cc_gate_breach_idle_npc1;
    level.scr_anim["infiltrator2"]["gate_breach_idle"][0] = %hms_greece_cc_gate_breach_idle_npc2;
    level.scr_anim["victim"]["gate_breach_idle"][0] = %hms_greece_cc_gate_breach_idle_guard;
    level.scr_goaltime["victim"]["gate_breach_idle"] = 1.0;
    level.scr_anim["infiltratorburke"]["gate_breach_in"] = %hms_greece_cc_gate_breach_trans_in_burke;
    level.scr_anim["infiltrator1"]["gate_breach_in"] = %hms_greece_cc_gate_breach_trans_in_npc1;
    level.scr_anim["infiltrator2"]["gate_breach_in"] = %hms_greece_cc_gate_breach_trans_in_npc2;
    level.scr_anim["infiltratorburke"]["courtyard_boostjump"] = %hms_greece_cc_courtyard_boost_jump_npc;
    level.scr_anim["infiltratorburke"]["parking_boostjump"] = %hms_greece_boost_jump_down_npc;
}

conferenceroomanimations()
{
    level.scr_anim["Hades"]["run_hunched_combat"][0] = %civilian_run_hunched_a;
    level.scr_anim["Hades"]["run_hunched_combat"][1] = %civilian_run_hunched_c;
    level.scr_anim["Hades"]["run_hunched_combat"][2] = %civilian_run_hunched_flinch;
    var_0 = [];
    var_0[0] = 3;
    var_0[1] = 3;
    var_0[2] = 1;
    level.scr_anim["Hades"]["run_hunched_weights"] = common_scripts\utility::get_cumulative_weights( var_0 );
    level.scr_anim["Hades"]["pacing_idle"][0] = %hms_greece_cc_breach_meeting_target_idle_pacing;
    level.scr_anim["Hades"]["standing_idle"][0] = %hms_greece_cc_breach_meeting_target_idle_hold;
    level.scr_anim["Hades"]["post_speech_idle"][0] = %hms_greece_cc_breach_meeting_target_idle;
    level.scr_anim["Hades"]["cc_breach"] = %hms_greece_cc_breach_meeting_target;
    level.scr_anim["Hades"]["speech"] = %hms_greece_cc_breach_meeting_target_speech;
    level.scr_anim["infiltrator1"]["squad_setup_in"] = %hms_greece_cc_breach_meeting_npc_idle_in;
    level.scr_anim["infiltrator1"]["squad_setup"][0] = %hms_greece_cc_breach_meeting_npc_idle;
    level.scr_anim["infiltrator2"]["squad_setup_in"] = %hms_greece_cc_breach_meeting_npc1_idle_in;
    level.scr_anim["infiltrator2"]["squad_setup"][0] = %hms_greece_cc_breach_meeting_npc1_idle;
    level.scr_anim["infiltratorburke"]["squad_setup_in"] = %hms_greece_cc_breach_meeting_npc2_idle_in;
    level.scr_anim["infiltratorburke"]["squad_setup"][0] = %hms_greece_cc_breach_meeting_npc2_idle;
    level.scr_anim["infiltrator1"]["cc_breach"] = %hms_greece_cc_breach_meeting_npc;
    level.scr_anim["infiltrator2"]["cc_breach"] = %hms_greece_cc_breach_meeting_npc1;
    maps\_anim::addnotetrack_customfunction( "infiltrator2", "flashbang_start", ::confroomflashbang, "cc_breach" );
    maps\_anim::addnotetrack_customfunction( "infiltrator2", "dialog", ::confroomrecovery, "cc_breach" );
    level.scr_anim["infiltratorburke"]["cc_breach"] = %hms_greece_cc_breach_meeting_npc2;
    maps\_anim::addnotetrack_customfunction( "infiltratorburke", "body_scan", ::confroombodyscan, "cc_breach" );
    maps\_anim::addnotetrack_customfunction( "infiltratorburke", "body_scan", maps\greece_conf_center_fx::hadesbodyscanfx, "cc_breach" );
    maps\_anim::addnotetrack_customfunction( "infiltratorburke", "body_bomb_explode", ::confroomexplosivetrap, "cc_breach" );
    level.scr_anim["BodyGuard1"]["standing_idle"][0] = %hms_greece_cc_breach_meeting_guard1_idle;
    level.scr_anim["BodyGuard1"]["pacing_idle"][0] = %hms_greece_cc_breach_meeting_guard1_pacing;
    level.scr_anim["BodyGuard2"]["standing_idle"][0] = %hms_greece_cc_breach_meeting_guard2_idle;
    level.scr_anim["BodyGuard2"]["pacing_idle"][0] = %hms_greece_cc_breach_meeting_guard2_pacing;
    level.scr_anim["BodyGuard1"]["cc_breach"] = %hms_greece_cc_breach_meeting_guard1;
    maps\_anim::addnotetrack_customfunction( "BodyGuard1", "death", maps\greece_conf_center::confroombreachbodyguarddeath, "cc_breach" );
    level.scr_anim["BodyGuard2"]["cc_breach"] = %hms_greece_cc_breach_meeting_guard2;
    maps\_anim::addnotetrack_customfunction( "BodyGuard2", "death", maps\greece_conf_center::confroombreachbodyguarddeath, "cc_breach" );
    level.scr_anim["Vip1"]["vip_idle"][0] = %hms_greece_cc_breach_meeting_guest1_idle;
    level.scr_anim["Vip2"]["vip_idle"][0] = %hms_greece_cc_breach_meeting_guest2_idle;
    level.scr_anim["Vip3"]["vip_idle"][0] = %hms_greece_cc_breach_meeting_guest3_idle;
    level.scr_anim["Vip3"]["speech"] = %hms_greece_cc_breach_meeting_guest3_speech;
    level.scr_anim["Vip1"]["cc_breach"] = %hms_greece_cc_breach_meeting_guest1;
    maps\_anim::addnotetrack_customfunction( "Vip1", "start_ragdoll_custom", maps\greece_conf_center::confroomragdoll, "cc_breach" );
    level.scr_anim["Vip2"]["cc_breach"] = %hms_greece_cc_breach_meeting_guest2;
    maps\_anim::addnotetrack_customfunction( "Vip2", "start_ragdoll_custom", maps\greece_conf_center::confroomragdoll, "cc_breach" );
    level.scr_anim["Vip3"]["cc_breach"] = %hms_greece_cc_breach_meeting_guest3;
    maps\_anim::addnotetrack_customfunction( "Vip3", "start_ragdoll_custom", maps\greece_conf_center::confroomragdoll, "cc_breach" );
    level.scr_anim["infiltrator1"]["breach_stairs"] = %hms_greece_cc_stairs_2flights2breach_npc;
    level.scr_anim["infiltrator2"]["breach_stairs"] = %hms_greece_cc_stairs_2flights2breach_npc;
    level.scr_anim["infiltratorburke"]["breach_stairs"] = %hms_greece_cc_stairs_breach_npc;
}

atriumanimations()
{
    level.scr_anim["infiltrator1"]["mutebreach_setup"] = %hms_greece_cc_mutebreach_setup_npc;
    level.scr_anim["infiltrator2"]["mutebreach_setup"] = %hms_greece_cc_mutebreach_setup_npc1;
    level.scr_anim["infiltratorburke"]["mutebreach_setup"] = %hms_greece_cc_mutebreach_setup_burke;
    level.scr_anim["infiltrator1"]["mutebreach_idle"][0] = %hms_greece_cc_mutebreach_idle_npc;
    level.scr_anim["infiltrator2"]["mutebreach_idle"][0] = %hms_greece_cc_mutebreach_idle_npc1;
    level.scr_anim["infiltratorburke"]["mutebreach_idle"][0] = %hms_greece_cc_mutebreach_idle_burke;
    level.scr_anim["infiltrator1"]["mutebreach"] = %hms_greece_cc_mutebreach_out_npc;
    level.scr_anim["infiltrator2"]["mutebreach"] = %hms_greece_cc_mutebreach_out_npc1;
    level.scr_anim["infiltratorburke"]["mutebreach"] = %hms_greece_cc_mutebreach_out_burke;
    level.scr_anim["infiltrator1"]["atrium_boost_jump"] = %hms_greece_cc_courtyard_boost_jump_npc;
    level.scr_anim["infiltrator2"]["atrium_boost_jump"] = %hms_greece_cc_courtyard_boost_jump_npc;
}

flyinanimations()
{
    level.scr_anim["infiltratorburke"]["flyin"] = %hms_greece_cc_droneflyin_burke;
    level.scr_anim["infiltratorburke"]["flyin_end"] = %hms_greece_cc_droneflyin_burke_end;
}

#using_animtree("animated_props");

precachescriptmodelanims()
{
    level.scr_animtree["conf_room_door"] = #animtree;
    level.scr_anim["conf_room_door"]["cc_breach"] = %hms_greece_cc_breach_meeting_door;
    level.scr_animtree["drone_control_pad"] = #animtree;
    level.scr_model["drone_control_pad"] = "greece_drone_control_pad";
    level.scr_anim["drone_control_pad"]["drone_launch_control_pad"] = %hms_greece_safehouse_dronelaunch_pad;
    maps\_anim::addnotetrack_customfunction( "drone_control_pad", "tablet_touch_fx", maps\greece_safehouse_fx::intro_drone_tablet_touch_fx );
    level.scr_animtree["gate"] = #animtree;
    level.scr_anim["gate"]["gate_breach"] = %hms_greece_cc_gate_breach_gatedoors;
    maps\_anim::addnotetrack_customfunction( "gate", "gateEffect", maps\greece_conf_center::gatebreachdoorsexplode, "gate_breach" );
    level.scr_animtree["atrium_door"] = #animtree;
    level.scr_anim["atrium_door_bottom"]["mutebreach"] = %hms_greece_cc_mutebreach_out_door1;
    level.scr_anim["atrium_door_top"]["mutebreach"] = %hms_greece_cc_mutebreach_out_door2;
    level.scr_animtree["breach_charge"] = #animtree;
    level.scr_model["breach_charge"] = "breach_charge";
    level.scr_anim["breach_charge"]["mutebreach_setup"] = %hms_greece_cc_mutebreach_setup_brchchrg;
    maps\_anim::addnotetrack_customfunction( "breach_charge", "show_brchchrg", maps\greece_conf_center::showentnotetrack, "mutebreach_setup" );
    level.scr_anim["breach_charge"]["mutebreach_idle"][0] = %hms_greece_cc_mutebreach_idle_brchchrg;
    level.scr_anim["breach_charge"]["mutebreach"] = %hms_greece_cc_mutebreach_out_brchchrg;
    maps\_anim::addnotetrack_customfunction( "breach_charge", "doorchrg_bang", maps\greece_conf_center::atriumbreachexplosionnotetrack, "mutebreach" );
    level.scr_anim["breach_charge_2"]["mutebreach_setup"] = %hms_greece_cc_mutebreach_setup_brchchrg_2;
    level.scr_anim["breach_charge_2"]["mutebreach_idle"][0] = %hms_greece_cc_mutebreach_idle_brchchrg_2;
    level.scr_anim["breach_charge_2"]["mutebreach"] = %hms_greece_cc_mutebreach_out_brchchrg_2;
    level.scr_animtree["mute_charge"] = #animtree;
    level.scr_model["mute_charge"] = "mutecharge";
    level.scr_anim["mute_charge"]["mutebreach_setup"] = %hms_greece_cc_mutebreach_setup_mutechrg;
    maps\_anim::addnotetrack_customfunction( "mute_charge", "show_mutechrg", maps\greece_conf_center::showentnotetrack, "mutebreach_setup" );
    level.scr_animtree["sniper_drone_flight"] = #animtree;
    level.scr_anim["sniper_drone_flight"]["death"] = %hms_greece_sniper_drone_death;
    level.scr_anim["sniper_drone_flight"]["flyin"] = %hms_greece_cc_droneflyin;
    level.scr_anim["sniper_drone_flight"]["flyin_idle"][0] = %hms_greece_cc_droneflyin_idle;
    level.scr_anim["sniper_drone_flight"]["flyin_end"] = %hms_greece_cc_droneflyin_end;
    level.scr_anim["sniper_drone_flight"]["explosion_reaction"] = %hms_greece_cc_drone_reaction;
    level.scr_animtree["burkeambush_door"] = #animtree;
    level.scr_anim["burkeambush_door"]["burkeambush"] = %hms_greece_cc_burkeambush_door;
    level.scr_animtree["greece_blimp"] = #animtree;
    level.scr_model["greece_blimp"] = "greece_blimp_rigged";
    level.scr_anim["greece_blimp"]["cc_blimp"][0] = %hms_greece_cc_blimp;
}

#using_animtree("vehicles");

setupvehicleanims()
{
    level.scr_animtree["truck"] = #animtree;
    level.scr_anim["truck"]["bodystash"] = %hms_greece_cc_truck_bodystash_boxtruck;
    level.scr_anim["truck"]["bodystash_alt"] = %hms_greece_cc_truck_bodystash_boxtruck_alt;
    level.scr_anim["truck"]["flyin"] = %hms_greece_cc_droneflyin_truck;
    level.scr_anim["truck"]["flyin_end"] = %hms_greece_cc_droneflyin_truck_end;
    maps\_anim::addnotetrack_customfunction( "truck", "start_truck_walkto", maps\greece_conf_center::truckstartwalknotetrack, "flyin_end" );
    maps\_anim::addnotetrack_customfunction( "truck", "brake_start", ::truckbrakelights, "flyin_end" );
    level.scr_animtree["sniperdrone_barrel"] = #animtree;
    level.scr_animtree["sniperdrone_outerparts"] = #animtree;
    level.scr_anim["sniperdrone_barrel"]["flyin"] = %hms_greece_cc_droneflyin_barrel;
    level.scr_anim["sniperdrone_barrel"]["flyin_idle"][0] = %hms_greece_cc_droneflyin_barrel_idle;
    level.scr_anim["sniperdrone_barrel"]["flyin_end"] = %hms_greece_cc_droneflyin_barrel_end;
    level.scr_anim["sniperdrone_outerparts"]["flyin"] = %hms_greece_cc_droneflyin_frame;
    level.scr_anim["sniperdrone_outerparts"]["flyin_idle"][0] = %hms_greece_cc_droneflyin_frame_idle;
    level.scr_anim["sniperdrone_outerparts"]["flyin_end"] = %hms_greece_cc_droneflyin_frame_end;
    level.scr_anim["sniperdrone_barrel"]["explosion_reaction"] = %hms_greece_cc_drone_reaction_barrel;
    level.scr_anim["sniperdrone_outerparts"]["explosion_reaction"] = %hms_greece_cc_drone_reaction_frame;
    level.scr_anim["sniperdrone_barrel"]["death"] = %hms_greece_sniper_drone_death_barrel;
    level.scr_anim["sniperdrone_outerparts"]["death"] = %hms_greece_sniper_drone_death_frame;
}

#using_animtree("script_model");

garagedooranimations()
{
    level.scr_anim["rolling_door"]["intro_weapon_cache_rollingdoor"] = %intro_weapon_cache_rollingdoor;
    level.scr_animtree["rolling_door"] = #animtree;
    level.scr_model["rolling_door"] = "intro_rollingdoor_01";
}

truckbrakelights( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "truck_brakelight" ), var_0, "TAG_ORIGIN" );
}

confroomhadessweep( var_0 )
{
    var_1 = common_scripts\utility::getstruct( "hadessweepimpulse", "targetname" );
    physicsexplosionsphere( var_1.origin, 96, 0, 0.75 );
}

confroomflashbang( var_0 )
{
    var_1 = common_scripts\utility::getstruct( "cc_flashbang", "targetname" );
    playfx( common_scripts\utility::getfx( "cc_flashbang" ), var_1.origin );
    soundscripts\_snd::snd_message( "start_hades_flashbang", var_0 );
    level.confhades notify( "stop_talking" );
}

confroombodyscan( var_0 )
{
    common_scripts\utility::flag_set( "FlagConfRoomAlliesBodyScan" );
}

confroomexplosivetrap( var_0 )
{
    common_scripts\utility::flag_set( "FlagConfRoomExplosion" );
    level.player allowads( 0 );
    var_1 = maps\_utility::get_living_ai( "Infiltrator1", "script_noteworthy" );

    if ( isdefined( var_1 ) )
    {
        var_1 notify( "stop_talking" );
        maps\_utility::radio_dialogue_stop();
        var_1 maps\greece_conf_center::unmarkandremoveoutline( 0 );
    }

    maps\greece_conf_center::unmarkallies();
    var_2 = common_scripts\utility::getstruct( "cc_glassimpulse", "targetname" );
    var_3 = common_scripts\utility::getstruct( "cc_explosion", "targetname" );
    playfx( common_scripts\utility::getfx( "cc_explosion" ), var_3.origin );
    maps\greece_conf_center_fx::confcenterbossexplode();
    wait 0.2;
    level.confhades delete();
    var_1 delete();
    playfxontag( common_scripts\utility::getfx( "sniperdrone_cc_explosion_debris_view" ), level.player.sniperdronedata.barrelviewmodel, "TAG_ORIGIN" );
    var_4 = getent( "ConfRoomWindows", "targetname" );
    var_4 delete();
    physicsexplosionsphere( var_2.origin, 300, 10, 2 );
    var_5 = distance( var_2.origin, level.player.origin );
    var_6 = common_scripts\utility::getstructarray( "cc_fire", "targetname" );

    foreach ( var_8 in var_6 )
        playfx( common_scripts\utility::getfx( "cc_fire_small" ), var_8.origin );

    var_10 = common_scripts\utility::getstructarray( "cc_alarm", "targetname" );

    foreach ( var_8 in var_10 )
        playfx( common_scripts\utility::getfx( "cc_room_fire_alarm" ), var_8.origin );

    level notify( "ConfRoomExplosion" );
    soundscripts\_snd::snd_message( "hades_explosion_slowmo_start" );
    setslowmotion( 1.0, 0.125, 0.25 );
    wait 0.5;
    setslowmotion( 0.125, 1.0, 0.5 );
    soundscripts\_snd::snd_message( "hades_explosion_slowmo_end" );
    common_scripts\utility::flag_set( "FlagSniperDroneFlinch" );
    level.player shellshock( "greece_drone_slowview", 0.5 );
    maps\greece_conf_center::rumblesniperdronenearexplosion();
    maps\greece_conf_center::confroomexplosiondronereaction();
    level.player allowads( 1 );
    common_scripts\utility::flag_clear( "FlagConfRoomExplosion" );
}

confroomrecovery( var_0 )
{
    common_scripts\utility::flag_set( "FlagConfRoomAlliesRecover" );
}

stealthkillvictim( var_0 )
{
    var_0 maps\greece_code::setalertoutline();

    if ( target_istarget( var_0 ) )
        target_remove( var_0 );
}

removetruckguardoutline( var_0 )
{
    if ( var_0.script_noteworthy == "InfiltratorBurke" )
        var_1 = maps\_utility::get_living_ai( "GatePlayerTarget1", "script_noteworthy" );
    else
        var_1 = maps\_utility::get_living_ai( "GatePlayerTarget2", "script_noteworthy" );

    if ( isdefined( var_1 ) )
        var_1 hudoutlinedisable();
}

gatebreachkill1( var_0 )
{
    var_1 = undefined;
    var_2 = var_0.script_noteworthy;
    wait 0.1;
    var_3 = maps\_utility::get_living_ai( "CourtyardAllyTarget1", "script_noteworthy" );
    var_4 = maps\_utility::get_living_ai( "CourtyardAllyTarget2", "script_noteworthy" );
    var_5 = maps\_utility::get_living_ai( "CourtyardAllyTarget3", "script_noteworthy" );

    if ( isdefined( var_5 ) && !isdefined( var_5.bistargeted ) )
        var_1 = var_5;
    else if ( isdefined( var_4 ) && !isdefined( var_4.bistargeted ) )
        var_1 = var_4;
    else if ( isdefined( var_3 ) && !isdefined( var_3.bistargeted ) && !common_scripts\utility::flag( "FlagCourtyardAlliesBreachGate" ) )
        var_1 = var_3;

    if ( isdefined( var_1 ) )
    {
        var_1.bistargeted = 1;
        var_1 kill();
    }
}

gatebreachkill2( var_0 )
{
    var_1 = undefined;
    var_2 = var_0.script_noteworthy;
    wait 0.1;
    var_3 = maps\_utility::get_living_ai( "CourtyardAllyTarget1", "script_noteworthy" );
    var_4 = maps\_utility::get_living_ai( "CourtyardAllyTarget2", "script_noteworthy" );
    var_5 = maps\_utility::get_living_ai( "CourtyardAllyTarget3", "script_noteworthy" );

    if ( isdefined( var_4 ) && !isdefined( var_4.bistargeted ) )
        var_1 = var_4;
    else if ( isdefined( var_5 ) && !isdefined( var_5.bistargeted ) )
        var_1 = var_5;
    else if ( isdefined( var_3 ) && !isdefined( var_3.bistargeted ) && !common_scripts\utility::flag( "FlagCourtyardAlliesBreachGate" ) )
        var_1 = var_3;

    if ( isdefined( var_1 ) )
    {
        var_1.bistargeted = 1;
        var_1 kill();
    }
}

gatebreachkillburke( var_0 )
{
    var_1 = undefined;
    var_2 = var_0.script_noteworthy;
    wait 0.1;
    var_3 = maps\_utility::get_living_ai( "CourtyardAllyTarget1", "script_noteworthy" );
    var_4 = maps\_utility::get_living_ai( "CourtyardAllyTarget2", "script_noteworthy" );
    var_5 = maps\_utility::get_living_ai( "CourtyardAllyTarget3", "script_noteworthy" );

    if ( isdefined( var_3 ) && !isdefined( var_3.bistargeted ) )
        var_1 = var_3;
    else if ( isdefined( var_4 ) && !isdefined( var_4.bistargeted ) )
        var_1 = var_4;
    else if ( isdefined( var_5 ) && !isdefined( var_5.bistargeted ) )
        var_1 = var_5;

    if ( isdefined( var_1 ) )
    {
        var_1.bistargeted = 1;
        var_1 kill();
    }
}

walkwayguardstoptalking( var_0 )
{
    var_1 = maps\_utility::get_living_ai( "WalkwayPlayerTarget2", "script_noteworthy" );

    if ( isdefined( var_1 ) )
        var_1 notify( "stop_talking" );

    maps\_utility::radio_dialogue_stop();
}

truckstashweaponswap( var_0 )
{
    var_1 = common_scripts\utility::getstruct( "gunSpot", "targetname" );
    var_2 = spawn( "script_model", var_1.origin );
    var_2 setmodel( "npc_bal27_nocamo" );
    var_2.origin = var_1.origin;
    var_2.angles = var_1.angles;
    var_0 = maps\_utility::get_living_ai( "GatePlayerTarget2", "script_noteworthy" );

    if ( isdefined( var_0 ) )
        var_0 maps\_utility::gun_remove();
}
