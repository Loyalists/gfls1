// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    // level.start_point = "van";
    level.transient_zone = "";

    if ( level.currentgen )
    {
        if ( istransientloaded( "sanfran_intro_tr" ) )
            level.transient_zone = "intro";
        else if ( istransientloaded( "sanfran_bigm_tr" ) )
            level.transient_zone = "bigm";
        else if ( istransientloaded( "sanfran_outro_tr" ) )
            level.transient_zone = "outro";
    }

    if ( level.nextgen )
        anim.forced_s1_motionset = 1;

    load_player_anims();
    load_actor_anims();
    load_vehicle_anims();
    load_prop_anims();

    if ( level.currentgen )
    {
        thread transient_notetracks_intro();
        thread transient_notetracks_bigm();
    }
}

transient_notetracks_intro()
{
    if ( level.transient_zone == "intro" )
        return;

    level waittill( "tff_transition_outro_to_intro" );
    notetracks_player_pitbull_intro();
    notetracks_player_pitbull_crash();
    notetracks_burke_pitbull_intro();
}

transient_notetracks_bigm()
{
    if ( level.transient_zone == "bigm" )
        return;

    level waittill( "tff_transition_outro_to_bigm" );
    notetracks_player_rig_collapse();
    notetracks_burke_collapse();
    notetracks_bridge_collapse();
}

#using_animtree("player");

load_player_anims()
{
    level.scr_animtree["player_rig"] = #animtree;
    level.scr_model["player_rig"] = "s1_gfl_ump45_viewbody";
    level.scr_anim["player_rig"]["pitbull_intro"] = %sanfran_bridge_pitbull_intro_vm;

    if ( level.nextgen || level.transient_zone == "intro" )
        notetracks_player_pitbull_intro();

    level.scr_anim["player_rig"]["oncoming_hit"] = %sanfran_bridge_pitbull_sideswipe_init_vm;
    level.scr_anim["player_rig"]["oncoming_crash"] = %sanfran_bridge_pitbull_sideswipe_vm;
    level.scr_anim["player_rig"]["pitbull_crash"] = %sanfran_bridge_crash_pt2_vm;
    level.scr_anim["player_rig"]["pitbull_crawl"] = %sanfran_bridge_crash_pt3_vm;

    if ( level.nextgen || level.transient_zone == "intro" )
        notetracks_player_pitbull_crash();

    level.scr_anim["player_rig"]["deploy_scene"] = %sf_goldengate_deploy_vm;
    level.scr_anim["player_rig"]["collapse_scene"] = %sf_goldengate_collapse_vm;

    if ( level.nextgen || level.transient_zone == "bigm" )
        notetracks_player_rig_collapse();
}

notetracks_player_pitbull_intro()
{
    maps\_anim::addnotetrack_lui_notify( "player_rig", "start_fade", &"pitbull_fade_video" );
    maps\_anim::addnotetrack_set_omnvar( "player_rig", "screenslide_1_start", "ui_pitbull_video_state", 2 );
    maps\_anim::addnotetrack_lui_notify( "player_rig", "screenslide_1_stop", &"pitbull_stop_movie" );
    maps\_anim::addnotetrack_set_omnvar( "player_rig", "screenslide_2_start", "ui_pitbull_video_state", 3 );
    maps\_anim::addnotetrack_lui_notify( "player_rig", "screenslide_2_stop", &"pitbull_stop" );
}

notetracks_player_pitbull_crash()
{
    maps\_anim::addnotetrack_customfunction( "player_rig", "player_start_blackout", maps\sanfran_code::crash_blackout );
    maps\_anim::addnotetrack_customfunction( "player_rig", "player_end_blackout", maps\sanfran_code::crash_wakeup );
}

notetracks_player_rig_collapse()
{
    maps\_anim::addnotetrack_customfunction( "player_rig", "vfx_player_hit_windshield", maps\sanfran_fx::vfx_player_hit_windshield );
    maps\_anim::addnotetrack_customfunction( "player_rig", "vfx_rolling_pebbles", maps\sanfran_fx::vfx_player_rolling_pebbles );
    maps\_anim::addnotetrack_customfunction( "player_rig", "slomo_start", maps\sanfran_code::start_slow_mo );
    maps\_anim::addnotetrack_customfunction( "player_rig", "slomo_end", maps\sanfran_code::stop_slow_mo );
    maps\_anim::addnotetrack_customfunction( "player_rig", "change_fov_to_50_over_3sec", ::collapse_fov, "collapse_scene" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "fade_to_black", ::fade_to_black, "collapse_scene" );
}

#using_animtree("generic_human");

load_actor_anims()
{
    level.scr_anim["Burke"]["pitbull_intro"] = %sanfran_bridge_pitbull_intro_burke;

    if ( level.nextgen || level.transient_zone == "intro" )
        notetracks_burke_pitbull_intro();

    level.scr_anim["boost_jump_kick_01_atk"]["boost_jump_kick_01"] = %sanfran_boost_takedown_a_guy1;
    level.scr_anim["boost_jump_kick_01_def"]["boost_jump_kick_01"] = %sanfran_boost_takedown_a_guy2;
    level.scr_anim["boost_jump_kick_02_atk"]["boost_jump_kick_02"] = %sanfran_boost_takedown_b_guy1;
    level.scr_anim["boost_jump_kick_02_def"]["boost_jump_kick_02"] = %sanfran_boost_takedown_b_guy2;
    level.scr_anim["Burke"]["pitbull_crash"] = %sanfran_bridge_crash_pt2_burke;
    level.scr_anim["Burke"]["pitbull_crawl"] = %sanfran_bridge_crash_pt3_burke;
    level.scr_anim["atlas_1"]["pitbull_crash"] = %sanfran_bridge_crash_pt2_guy1;
    level.scr_anim["atlas_2"]["pitbull_crash"] = %sanfran_bridge_crash_pt2_guy2;
    level.scr_anim["atlas_3"]["pitbull_crash"] = %sanfran_bridge_crash_pt2_guy3;
    level.scr_anim["Burke"]["collapse_scene"] = %sf_goldengate_collapse_burke;

    if ( level.nextgen || level.transient_zone == "bigm" )
        notetracks_burke_collapse();

    level.scr_anim["human_atlas_1"]["approach_scene"] = %sf_goldengate_collapse_guy01;
    level.scr_anim["human_atlas_1"]["approach_idle"][0] = %sf_goldengate_collapse_guy01_idle;
    level.scr_anim["human_atlas_1"]["deploy_scene"] = %sf_goldengate_deploy_guy01;
    level.scr_anim["human_atlas_1"]["collapse_scene"] = %sf_goldengate_collapse_guy01_c;
    level.scr_anim["human_atlas_2"]["barrier_scene"][0] = %sf_goldengate_collapse_guy02_idle;
    level.scr_anim["human_atlas_2"]["approach_scene"] = %sf_goldengate_collapse_guy02;
    level.scr_anim["human_atlas_2"]["approach_idle"][0] = %sf_goldengate_collapse_guy02_idle;
    level.scr_anim["human_atlas_2"]["deploy_scene"] = %sf_goldengate_deploy_guy02;
    level.scr_anim["human_atlas_2"]["collapse_scene"] = %sf_goldengate_collapse_guy02_c;
    level.scr_anim["human_atlas_3"]["approach_idle"][0] = %sf_goldengate_collapse_guy21;
    level.scr_anim["human_atlas_3"]["deploy_scene"] = %sf_goldengate_deploy_guy21;
    level.scr_anim["human_atlas_4"]["approach_idle"][0] = %sf_goldengate_collapse_guy22;
    level.scr_anim["human_atlas_4"]["deploy_scene"] = %sf_goldengate_deploy_guy22;
    level.scr_anim["human_atlas_5"]["approach_scene"] = %sf_goldengate_collapse_guy04;
    level.scr_anim["human_atlas_5"]["approach_idle"][0] = %sf_goldengate_deploy_guy04;
    level.scr_anim["human_sentinel_1"]["barrier_scene"][0] = %sf_goldengate_collapse_guy03_idle;
    level.scr_anim["human_sentinel_1"]["approach_scene"] = %sf_goldengate_collapse_guy03;
    level.scr_anim["human_sentinel_1"]["approach_idle"][0] = %sf_goldengate_collapse_guy03_idle;
    level.scr_anim["human_sentinel_1"]["deploy_scene"] = %sf_goldengate_deploy_guy03;
    level.scr_anim["human_sentinel_2"]["barrier_scene"][0] = %sf_goldengate_collapse_guy05_idle;
    level.scr_anim["human_sentinel_2"]["approach_scene"] = %sf_goldengate_collapse_guy05;
    level.scr_anim["human_sentinel_2"]["approach_idle"][0] = %sf_goldengate_collapse_guy05_idle;
    level.scr_anim["human_sentinel_2"]["deploy_scene"] = %sf_goldengate_deploy_guy05;
    level.scr_anim["human_sentinel_2"]["collapse_scene"] = %sf_goldengate_collapse_guy05_c;
    level.scr_anim["human_sentinel_3"]["barrier_scene"][0] = %sf_goldengate_collapse_guy06_idle;
    level.scr_anim["human_sentinel_3"]["approach_scene"] = %sf_goldengate_collapse_guy06;
    level.scr_anim["human_sentinel_3"]["approach_idle"][0] = %sf_goldengate_collapse_guy06_idle;
    level.scr_anim["human_sentinel_3"]["deploy_scene"] = %sf_goldengate_deploy_guy06;
    level.scr_anim["human_sentinel_4"]["barrier_scene"][0] = %sf_goldengate_collapse_guy07_idle;
    level.scr_anim["human_sentinel_4"]["approach_scene"] = %sf_goldengate_collapse_guy07;
    level.scr_anim["human_sentinel_4"]["approach_idle"][0] = %sf_goldengate_collapse_guy07_idle;
    level.scr_anim["human_sentinel_4"]["deploy_scene"] = %sf_goldengate_deploy_guy07;
    level.scr_anim["human_sentinel_4"]["collapse_scene"] = %sf_goldengate_collapse_guy07_c;
    level.scr_anim["human_sentinel_5"]["barrier_scene"][0] = %sf_goldengate_collapse_guy08_idle;
    level.scr_anim["human_sentinel_5"]["approach_scene"] = %sf_goldengate_collapse_guy08;
    level.scr_anim["human_sentinel_5"]["approach_idle"][0] = %sf_goldengate_collapse_guy08_idle;
    level.scr_anim["human_sentinel_5"]["deploy_scene"] = %sf_goldengate_deploy_guy08;
    level.scr_anim["human_sentinel_5"]["collapse_scene"] = %sf_goldengate_collapse_guy08_c;
    level.scr_anim["human_sentinel_6"]["barrier_scene"][0] = %sf_goldengate_collapse_guy09_idle;
    level.scr_anim["human_sentinel_6"]["approach_scene"] = %sf_goldengate_collapse_guy09;
    level.scr_anim["human_sentinel_6"]["approach_idle"][0] = %sf_goldengate_collapse_guy09_idle;
    level.scr_anim["human_sentinel_6"]["deploy_scene"] = %sf_goldengate_deploy_guy09;
    level.scr_anim["human_sentinel_7"]["barrier_scene"][0] = %sf_goldengate_collapse_guy10_idle;
    level.scr_anim["human_sentinel_7"]["approach_scene"] = %sf_goldengate_collapse_guy10;
    level.scr_anim["human_sentinel_7"]["approach_idle"][0] = %sf_goldengate_deploy_guy10_idle2;
    level.scr_anim["human_sentinel_7"]["deploy_scene"] = %sf_goldengate_deploy_guy10;
    level.scr_anim["human_sentinel_7"]["collapse_scene"] = %sf_goldengate_collapse_guy10_c;
    level.scr_anim["human_sentinel_8"]["barrier_scene"][0] = %sf_goldengate_collapse_guy11_idle;
    level.scr_anim["human_sentinel_8"]["approach_scene"] = %sf_goldengate_collapse_guy11;
    level.scr_anim["human_sentinel_8"]["approach_idle"][0] = %sf_goldengate_collapse_guy11_idle;
    level.scr_anim["human_sentinel_8"]["deploy_scene"] = %sf_goldengate_deploy_guy11;
    level.scr_anim["human_sentinel_9"]["barrier_scene"][0] = %sf_goldengate_collapse_guy12_idle;
    level.scr_anim["human_sentinel_9"]["approach_scene"] = %sf_goldengate_collapse_guy12;
    level.scr_anim["human_sentinel_9"]["approach_idle"][0] = %sf_goldengate_collapse_guy12_idle;
    level.scr_anim["human_sentinel_9"]["deploy_scene"] = %sf_goldengate_deploy_guy12;
    level.scr_anim["human_sentinel_9"]["collapse_scene"] = %sf_goldengate_collapse_guy12_c;
    level.scr_anim["human_sentinel_10"]["approach_scene"] = %sf_goldengate_collapse_guy15;
    level.scr_anim["human_sentinel_10"]["deploy_scene"] = %sf_goldengate_deploy_guy15;
    level.scr_anim["human_sentinel_10"]["collapse_scene"] = %sf_goldengate_collapse_guy15_c;
    level.scr_anim["human_sentinel_11"]["approach_scene"] = %sf_goldengate_collapse_guy16;
    level.scr_anim["human_sentinel_11"]["deploy_scene"] = %sf_goldengate_deploy_guy16;
    level.scr_anim["human_sentinel_11"]["collapse_scene"] = %sf_goldengate_collapse_guy16_c;
    level.scr_anim["human_sentinel_12"]["approach_scene"] = %sf_goldengate_collapse_guy17;
    level.scr_anim["human_sentinel_12"]["deploy_scene"] = %sf_goldengate_deploy_guy17;
    level.scr_anim["human_sentinel_13"]["approach_scene"] = %sf_goldengate_collapse_guy18;
    level.scr_anim["human_sentinel_13"]["deploy_scene"] = %sf_goldengate_deploy_guy18;
    level.scr_anim["human_sentinel_14"]["approach_scene"] = %sf_goldengate_collapse_guy19;
    level.scr_anim["human_sentinel_14"]["deploy_scene"] = %sf_goldengate_deploy_guy19;
    level.scr_anim["human_sentinel_15"]["approach_scene"] = %sf_goldengate_collapse_guy20;
    level.scr_anim["human_sentinel_15"]["deploy_scene"] = %sf_goldengate_deploy_guy20;
    level.scr_anim["human_civilian_1"]["collapse_scene"] = %sf_goldengate_collapse_guy21_c;
    level.scr_anim["human_police_1"]["barrier_scene"][0] = %sf_goldengate_collapse_guy13_idle;
    level.scr_anim["human_police_1"]["approach_scene"] = %sf_goldengate_collapse_guy13;
    level.scr_anim["human_police_1"]["approach_idle"][0] = %sf_goldengate_collapse_guy13_idle2;
    level.scr_anim["human_police_1"]["deploy_scene"] = %sf_goldengate_deploy_guy13;
    level.scr_anim["human_police_1"]["collapse_scene"] = %sf_goldengate_collapse_guy13_b;
    level.scr_anim["human_police_2"]["always_loop_scene"][0] = %sf_goldengate_deploy_guy14_idle;
    level.scr_anim["human_police_2"]["collapse_scene"] = %sf_goldengate_collapse_guy14_c;
    level.scr_anim["Burke"]["boost_go"] = %sf_b_hallway_wave_navy_guy;
    level.scr_anim["generic"]["deployable_cover_deploy"] = %fusion_lift_deploy_cover_carter_enter;
    level.scr_anim["generic"]["deployable_cover_deploy_idle"][0] = %fusion_lift_deploy_cover_carter_idle;
    level.scr_anim["sedan_driver"]["run_01"][0] = %sf_a_civillian_pedestrian_run_exit_01;
    level.scr_anim["sedan_driver"]["run_02"][0] = %sf_a_civillian_pedestrian_run_exit_02;
    level.scr_anim["sedan_driver"]["run_03"][0] = %sf_a_civillian_pedestrian_run_exit_03;
    level.scr_anim["sedan_driver"]["run_04"][0] = %sf_a_civillian_pedestrian_run_exit_04;
    level.scr_anim["sedan_driver"]["run_05"][0] = %sf_a_civillian_pedestrian_run_exit_05;
    level.scr_anim["sedan_driver"]["run_06"][0] = %sf_a_civillian_pedestrian_run_exit_06;
    level.scr_anim["sedan_driver"]["run_07"][0] = %sf_a_civillian_pedestrian_run_exit_07;
    level.scr_anim["compact_driver"]["run_01"][0] = %sf_a_civillian_pedestrian_run_exit_01;
    level.scr_anim["compact_driver"]["run_02"][0] = %sf_a_civillian_pedestrian_run_exit_02;
    level.scr_anim["compact_driver"]["run_03"][0] = %sf_a_civillian_pedestrian_run_exit_03;
    level.scr_anim["compact_driver"]["run_04"][0] = %sf_a_civillian_pedestrian_run_exit_04;
    level.scr_anim["compact_driver"]["run_05"][0] = %sf_a_civillian_pedestrian_run_exit_05;
    level.scr_anim["compact_driver"]["run_06"][0] = %sf_a_civillian_pedestrian_run_exit_06;
    level.scr_anim["compact_driver"]["run_07"][0] = %sf_a_civillian_pedestrian_run_exit_07;
    level.scr_anim["truck_driver"]["run_01"][0] = %sf_a_civillian_pedestrian_run_exit_01;
    level.scr_anim["truck_driver"]["run_02"][0] = %sf_a_civillian_pedestrian_run_exit_02;
    level.scr_anim["truck_driver"]["run_03"][0] = %sf_a_civillian_pedestrian_run_exit_03;
    level.scr_anim["truck_driver"]["run_04"][0] = %sf_a_civillian_pedestrian_run_exit_04;
    level.scr_anim["truck_driver"]["run_05"][0] = %sf_a_civillian_pedestrian_run_exit_05;
    level.scr_anim["truck_driver"]["run_06"][0] = %sf_a_civillian_pedestrian_run_exit_06;
    level.scr_anim["truck_driver"]["run_07"][0] = %sf_a_civillian_pedestrian_run_exit_07;
    level.scr_anim["drone"]["run_01"][0] = %sf_a_civillian_pedestrian_run_exit_01_relative;
    level.scr_anim["drone"]["run_02"][0] = %sf_a_civillian_pedestrian_run_exit_02_relative;
    level.scr_anim["drone"]["run_03"][0] = %sf_a_civillian_pedestrian_run_exit_03_relative;
    level.scr_anim["drone"]["run_04"][0] = %sf_a_civillian_pedestrian_run_exit_04_relative;
    level.scr_anim["drone"]["run_05"][0] = %sf_a_civillian_pedestrian_run_exit_05_relative;
    level.scr_anim["drone"]["run_06"][0] = %sf_a_civillian_pedestrian_run_exit_06_relative;
    level.scr_anim["drone"]["run_07"][0] = %sf_a_civillian_pedestrian_run_exit_07_relative;
    level.scr_anim["sedan_driver"]["loop_01"][0] = %sf_a_civillian_civ_sedan_loop_01;
    level.scr_anim["sedan_driver"]["loop_02"][0] = %sf_a_civillian_civ_sedan_loop_02;
    level.scr_anim["sedan_driver"]["loop_03"][0] = %sf_a_civillian_civ_sedan_loop_03;
    level.scr_anim["sedan_driver"]["loop_04"][0] = %sf_a_civillian_civ_sedan_loop_04;
    level.scr_anim["sedan_driver"]["loop_05"][0] = %sf_a_civillian_civ_sedan_loop_05;
    level.scr_anim["sedan_driver"]["loop_06"][0] = %sf_a_civillian_civ_sedan_loop_06;
    level.scr_anim["sedan_driver"]["loop_07"][0] = %sf_a_civillian_civ_sedan_loop_07;
    level.scr_anim["sedan_driver"]["get_out_01"] = %sf_a_civillian_civ_sedan_exit_01;
    level.scr_anim["sedan_driver"]["get_out_02"] = %sf_a_civillian_civ_sedan_exit_02;
    level.scr_anim["sedan_driver"]["get_out_03"] = %sf_a_civillian_civ_sedan_exit_03;
    level.scr_anim["sedan_driver"]["get_out_04"] = %sf_a_civillian_civ_sedan_exit_04;
    level.scr_anim["sedan_driver"]["get_out_05"] = %sf_a_civillian_civ_sedan_exit_05;
    level.scr_anim["sedan_driver"]["get_out_06"] = %sf_a_civillian_civ_sedan_exit_06;
    level.scr_anim["sedan_driver"]["get_out_07"] = %sf_a_civillian_civ_sedan_exit_07;
    level.scr_anim["compact_driver"]["loop_01"][0] = %sf_a_civillian_compactcar_loop_01;
    level.scr_anim["compact_driver"]["loop_02"][0] = %sf_a_civillian_compactcar_loop_02;
    level.scr_anim["compact_driver"]["loop_03"][0] = %sf_a_civillian_compactcar_loop_03;
    level.scr_anim["compact_driver"]["loop_04"][0] = %sf_a_civillian_compactcar_loop_04;
    level.scr_anim["compact_driver"]["loop_05"][0] = %sf_a_civillian_compactcar_loop_05;
    level.scr_anim["compact_driver"]["loop_06"][0] = %sf_a_civillian_compactcar_loop_06;
    level.scr_anim["compact_driver"]["loop_07"][0] = %sf_a_civillian_compactcar_loop_07;
    level.scr_anim["compact_driver"]["get_out_01"] = %sf_a_civillian_compactcar_exit_01;
    level.scr_anim["compact_driver"]["get_out_02"] = %sf_a_civillian_compactcar_exit_02;
    level.scr_anim["compact_driver"]["get_out_03"] = %sf_a_civillian_compactcar_exit_03;
    level.scr_anim["compact_driver"]["get_out_04"] = %sf_a_civillian_compactcar_exit_04;
    level.scr_anim["compact_driver"]["get_out_05"] = %sf_a_civillian_compactcar_exit_05;
    level.scr_anim["compact_driver"]["get_out_06"] = %sf_a_civillian_compactcar_exit_06;
    level.scr_anim["compact_driver"]["get_out_07"] = %sf_a_civillian_compactcar_exit_07;
    level.scr_anim["truck_driver"]["loop_01"][0] = %sf_a_civillian_civ_truck_loop_01;
    level.scr_anim["truck_driver"]["loop_02"][0] = %sf_a_civillian_civ_truck_loop_02;
    level.scr_anim["truck_driver"]["loop_03"][0] = %sf_a_civillian_civ_truck_loop_03;
    level.scr_anim["truck_driver"]["loop_04"][0] = %sf_a_civillian_civ_truck_loop_04;
    level.scr_anim["truck_driver"]["loop_05"][0] = %sf_a_civillian_civ_truck_loop_05;
    level.scr_anim["truck_driver"]["loop_06"][0] = %sf_a_civillian_civ_truck_loop_06;
    level.scr_anim["truck_driver"]["loop_07"][0] = %sf_a_civillian_civ_truck_loop_07;
    level.scr_anim["truck_driver"]["get_out_01"] = %sf_a_civillian_civ_truck_exit_01;
    level.scr_anim["truck_driver"]["get_out_02"] = %sf_a_civillian_civ_truck_exit_02;
    level.scr_anim["truck_driver"]["get_out_03"] = %sf_a_civillian_civ_truck_exit_03;
    level.scr_anim["truck_driver"]["get_out_04"] = %sf_a_civillian_civ_truck_exit_04;
    level.scr_anim["truck_driver"]["get_out_05"] = %sf_a_civillian_civ_truck_exit_05;
    level.scr_anim["truck_driver"]["get_out_06"] = %sf_a_civillian_civ_truck_exit_06;
    level.scr_anim["truck_driver"]["get_out_07"] = %sf_a_civillian_civ_truck_exit_07;
    level.scr_anim["civilian"]["laying_1"][0] = %sf_a_civ_injured_laying_agony_a;
    level.scr_anim["civilian"]["laying_2"][0] = %sf_a_civ_injured_laying_agony_b;
    level.scr_anim["civilian"]["seated_1"][0] = %sf_a_civ_injured_seated_crying;
    level.scr_anim["civilian"]["seated_2"][0] = %sf_a_civ_injured_seated_face;
    level.scr_anim["civilian"]["seated_3"][0] = %sf_a_civ_injured_seated_neck;
    level.scr_anim["civilian"]["paired_1"][0] = %sf_a_civ_injured_seated_mourned;
    level.scr_anim["civilian_b"]["paired_1"][0] = %sf_a_civ_injured_seated_mourner;
    level.scr_anim["civilian"]["paired_2"][0] = %sf_a_civ_injured_seated_helped;
    level.scr_anim["civilian_b"]["paired_2"][0] = %sf_a_civ_injured_seated_helper;
    level.scr_anim["civilian"]["civilian_cower"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["sedan_driver"]["civilian_cower"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["compact_driver"]["civilian_cower"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["truck_driver"]["civilian_cower"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["drone"]["civilian_cower"][0] = %unarmed_cowercrouch_idle;
    level.scr_anim["generic"]["balcony_death"] = [];
    level.scr_anim["generic"]["balcony_death"][0] = %death_rooftop_a;
    level.scr_anim["generic"]["balcony_death"][1] = %death_rooftop_b;
    level.scr_anim["generic"]["balcony_death"][2] = %death_rooftop_c;
    level.scr_anim["generic"]["balcony_death"][3] = %death_rooftop_d;
    level.scr_anim["generic"]["container_death"] = %exposed_death_blowback;
}

notetracks_burke_pitbull_intro()
{
    maps\_anim::addnotetrack_lui_notify( "Burke", "burke_screentap_1", &"pitbull_ui_tap" );
    maps\_anim::addnotetrack_lui_notify( "Burke", "burke_screentap_2", &"pitbull_ui_tap" );
    maps\_anim::addnotetrack_lui_notify( "Burke", "burke_screentap_3", &"pitbull_ui_tap" );
    maps\_anim::addnotetrack_lui_notify( "Burke", "burke_screentap_4", &"pitbull_ui_tap" );
    maps\_anim::addnotetrack_lui_notify( "Burke", "burke_screentap_5", &"pitbull_ui_tap" );
}

notetracks_burke_collapse()
{
    maps\_anim::addnotetrack_customfunction( "Burke", "boost_begin", maps\sanfran_fx::vfx_start_boost_fx );
    maps\_anim::addnotetrack_customfunction( "Burke", "boost_end", maps\sanfran_fx::vfx_stop_boost_fx );
}

#using_animtree("vehicles");

load_vehicle_anims()
{
    level.scr_anim["atlas_van"]["pitbull_intro"] = %sanfran_bridge_pitbull_intro_van;
    level.scr_anim["bus"]["bus_crash"] = %sf_bus_crash;
    level.scr_anim["tanker"]["tanker_crash"] = %sf_oiltanker_crash;
    thread setup_tanker_crash_notetrack();
    level.scr_anim["atlas_suv"]["oncoming_crash"] = %sanfran_bridge_pitbull_sideswipe_atlas_suv;
    maps\_anim::addnotetrack_customfunction( "atlas_suv", "vfx_atlas_suv_barrier_impact", maps\sanfran_fx::atlas_suv_impact_fx, "oncoming_crash" );
    maps\_anim::addnotetrack_customfunction( "atlas_suv", "vfx_atlas_suv_barrier_impact", maps\sanfran_fx::pitbull_impact_fx, "oncoming_crash" );
    level.scr_anim["work_van"]["pitbull_crash"] = %sanfran_bridge_crash_pt2_civ_workvan;
    level.scr_anim["atlas_suv"]["pitbull_crash"] = %sanfran_bridge_crash_pt2_suv;
    maps\_anim::addnotetrack_customfunction( "atlas_suv", "vfx_pitbull_impact_sparks", maps\sanfran_fx::pitbull_crash_impact_fx, "pitbull_crash" );
    level.scr_anim["atlas_suv"]["pitbull_crawl"] = %sanfran_bridge_crash_pt3_suv;
    level.scr_anim["after_pitbull"]["pitbull_wreck"] = %sanfran_bridge_crash_wrecked_pitbull;
    level.scr_anim["compact"]["open_door_both"] = %civ_domestic_economy_open_door_both;
    level.scr_anim["compact"]["open_door_left"] = %civ_domestic_economy_open_door_left;
    level.scr_anim["compact"]["open_door_right"] = %civ_domestic_economy_open_door_right;
    level.scr_anim["truck"]["open_door_both"] = %civ_domestic_truck_open_door_both;
    level.scr_anim["truck"]["open_door_left"] = %civ_domestic_truck_open_door_left;
    level.scr_anim["truck"]["open_door_right"] = %civ_domestic_truck_open_door_right;
    level.scr_anim["atlas_suv"]["open_door_both"] = %atlas_suv_dismount_front_l_r_doors_opened;
    level.scr_anim["atlas_suv"]["open_door_left"] = %atlas_suv_dismount_frontl_door_opened;
    level.scr_anim["atlas_suv"]["open_door_right"] = %atlas_suv_dismount_frontr_door_opened;
    level.scr_anim["sedan"]["open_door_both"] = %civ_domestic_sedan_doors_open_fl_fr;
    level.scr_anim["sedan"]["open_door_left"] = %civ_domestic_sedan_doors_open_fl;
    level.scr_anim["sedan"]["open_door_right"] = %civ_domestic_sedan_doors_open_fr;
    level.scr_anim["van"]["approach_scene"] = %sf_goldengate_collapse_van_b;
    level.scr_anim["van"]["deploy_scene"] = %sf_goldengate_deploy_van_b;
    level.scr_anim["van"]["collapse_scene"] = %sf_goldengate_collapse_van_c;
    maps\_anim::addnotetrack_customfunction( "van", "vfx_van_passenger_door_open", maps\sanfran_fx::vfx_van_passenger_door_open );
    maps\_anim::addnotetrack_customfunction( "van", "vfx_van_back_door_open", maps\sanfran_fx::vfx_van_back_door_open );
    maps\_anim::addnotetrack_customfunction( "van", "vfx_van_explosion_start", maps\sanfran_fx::vfx_van_explosion_start );
    level.scr_anim["drone_1"]["deploy_scene"] = %sf_goldengate_deploy_drone01;
    maps\_anim::addnotetrack_customfunction( "drone_1", "vfx_drone_fan_start_01", maps\sanfran_fx::vfx_drone_fan_start );
    maps\_anim::addnotetrack_customfunction( "drone_1", "vfx_drone01_explo_sp", maps\sanfran_fx::vfx_drone_explo_regularfx );
    level.scr_anim["drone_2"]["deploy_scene"] = %sf_goldengate_deploy_drone02;
    maps\_anim::addnotetrack_customfunction( "drone_2", "vfx_drone_fan_start_02", maps\sanfran_fx::vfx_drone_fan_start );
    maps\_anim::addnotetrack_customfunction( "drone_2", "vfx_drone02_explo", maps\sanfran_fx::vfx_drone_explo );
    level.scr_anim["drone_3"]["deploy_scene"] = %sf_goldengate_deploy_drone03;
    maps\_anim::addnotetrack_customfunction( "drone_3", "vfx_drone_fan_start_03", maps\sanfran_fx::vfx_drone_fan_start );
    maps\_anim::addnotetrack_customfunction( "drone_3", "vfx_drone03_explo", maps\sanfran_fx::vfx_drone_explo );
    level.scr_anim["drone_4"]["deploy_scene"] = %sf_goldengate_deploy_drone04;
    maps\_anim::addnotetrack_customfunction( "drone_4", "vfx_drone_fan_start_04", maps\sanfran_fx::vfx_drone_fan_start );
    maps\_anim::addnotetrack_customfunction( "drone_4", "vfx_drone04_explo", maps\sanfran_fx::vfx_drone_explo );
    level.scr_anim["drone_5"]["deploy_scene"] = %sf_goldengate_deploy_drone05;
    maps\_anim::addnotetrack_customfunction( "drone_5", "vfx_drone_fan_start_05", maps\sanfran_fx::vfx_drone_fan_start );
    maps\_anim::addnotetrack_customfunction( "drone_5", "vfx_drone05_explo", maps\sanfran_fx::vfx_drone_explo );
    level.scr_anim["drone_6"]["deploy_scene"] = %sf_goldengate_deploy_drone06;
    maps\_anim::addnotetrack_customfunction( "drone_6", "vfx_drone_fan_start_06", maps\sanfran_fx::vfx_drone_fan_start );
    maps\_anim::addnotetrack_customfunction( "drone_6", "vfx_drone06_explo", maps\sanfran_fx::vfx_drone_explo );
    level.scr_anim["drone_7"]["deploy_scene"] = %sf_goldengate_deploy_drone07;
    maps\_anim::addnotetrack_customfunction( "drone_7", "vfx_drone_fan_start_07", maps\sanfran_fx::vfx_drone_fan_start );
    maps\_anim::addnotetrack_customfunction( "drone_7", "vfx_drone07_explo", maps\sanfran_fx::vfx_drone_explo );
    level.scr_anim["drone_8"]["deploy_scene"] = %sf_goldengate_deploy_drone08;
    maps\_anim::addnotetrack_customfunction( "drone_8", "vfx_drone_fan_start_08", maps\sanfran_fx::vfx_drone_fan_start );
    maps\_anim::addnotetrack_customfunction( "drone_8", "vfx_drone08_explo", maps\sanfran_fx::vfx_drone_explo );
    level.scr_anim["drone_9"]["deploy_scene"] = %sf_goldengate_deploy_drone09;
    maps\_anim::addnotetrack_customfunction( "drone_9", "vfx_drone_fan_start_09", maps\sanfran_fx::vfx_drone_fan_start );
    maps\_anim::addnotetrack_customfunction( "drone_9", "vfx_drone09_explo", maps\sanfran_fx::vfx_drone_explo );
    level.scr_anim["drone_10"]["deploy_scene"] = %sf_goldengate_deploy_drone10;
    maps\_anim::addnotetrack_customfunction( "drone_10", "vfx_drone_fan_start_10", maps\sanfran_fx::vfx_drone_fan_start );
    maps\_anim::addnotetrack_customfunction( "drone_10", "vfx_drone10_explo", maps\sanfran_fx::vfx_drone_explo );
    level.scr_anim["drone_11"]["deploy_scene"] = %sf_goldengate_deploy_drone11;
    maps\_anim::addnotetrack_customfunction( "drone_11", "vfx_drone_fan_start_11", maps\sanfran_fx::vfx_drone_fan_start );
    maps\_anim::addnotetrack_customfunction( "drone_11", "vfx_drone11_explo_sp", maps\sanfran_fx::vfx_drone_explo_regularfx );
    level.scr_anim["drone_12"]["deploy_scene"] = %sf_goldengate_deploy_drone12;
    maps\_anim::addnotetrack_customfunction( "drone_12", "vfx_drone_fan_start_12", maps\sanfran_fx::vfx_drone_fan_start );
    maps\_anim::addnotetrack_customfunction( "drone_12", "vfx_drone12_explo", maps\sanfran_fx::vfx_drone_explo );
    level.scr_anim["large_drone"]["deploy_scene"] = %sf_goldengate_deploy_large_drone;
    maps\_anim::addnotetrack_customfunction( "large_drone", "vfx_drone_fan_start_large", maps\sanfran_fx::vfx_drone_large_fan_start );
    level.scr_anim["chopper_1"]["approach_scene"] = %sf_goldengate_collapse_chopper02_b;
    level.scr_anim["chopper_1"]["idle_scene"][0] = %sf_goldengate_collapse_chopper02_b_loop;
    level.scr_anim["broken_helo"]["collapse_scene"] = %sf_goldengate_collapse_chopper01_c;
    level.scr_anim["truck01"]["collapse_scene"] = %sf_goldengate_collapse_truck_c;
    level.scr_anim["truck02"]["collapse_scene"] = %sf_goldengate_collapse_truck01_c;
    maps\_anim::addnotetrack_customfunction( "truck02", "windshield swap", maps\sanfran_code::cracked_windshield_swap );
    maps\_anim::addnotetrack_customfunction( "truck02", "vfx_copcar_left_hitspark1", maps\sanfran_fx::vfx_copcar_left_hitspark1 );
    level.scr_anim["copcar_1"]["approach_scene"] = %sf_goldengate_barricade_copcar01;
    maps\_anim::addnotetrack_customfunction( "copcar_1", "vfx_copcar01_hitspark1", maps\sanfran_fx::vfx_copcar01_hitspark1 );
    level.scr_anim["copcar_1"]["deploy_scene"] = %sf_goldengate_deploy_copcar01;
    level.scr_anim["copcar_1"]["collapse_scene"] = %sf_goldengate_collapse_copcar01;
    level.scr_anim["copcar_2"]["approach_scene"] = %sf_goldengate_barricade_copcar02;
    level.scr_anim["copcar_2"]["deploy_scene"] = %sf_goldengate_deploy_copcar02;
    level.scr_anim["copcar_2"]["collapse_scene"] = %sf_goldengate_collapse_copcar02;
    level.scr_anim["copcar_3"]["approach_scene"] = %sf_goldengate_barricade_copcar03;
    level.scr_anim["copcar_3"]["deploy_scene"] = %sf_goldengate_deploy_copcar03;
    level.scr_anim["copcar_3"]["collapse_scene"] = %sf_goldengate_collapse_copcar03;
    level.scr_anim["copcar_4"]["approach_scene"] = %sf_goldengate_barricade_copcar04;
    level.scr_anim["copcar_4"]["deploy_scene"] = %sf_goldengate_deploy_copcar04;
    level.scr_anim["copcar_4"]["collapse_scene"] = %sf_goldengate_collapse_copcar04;
    level.scr_anim["copcar_5"]["approach_scene"] = %sf_goldengate_barricade_copcar05;
    level.scr_anim["copcar_5"]["deploy_scene"] = %sf_goldengate_deploy_copcar05;
    level.scr_anim["copcar_5"]["collapse_scene"] = %sf_goldengate_collapse_copcar05;
    level.scr_anim["copcar_6"]["approach_scene"] = %sf_goldengate_barricade_copcar06;
    level.scr_anim["copcar_6"]["deploy_scene"] = %sf_goldengate_deploy_copcar06;
    level.scr_anim["copcar_6"]["collapse_scene"] = %sf_goldengate_collapse_copcar06;
    level.scr_anim["copcar_7"]["approach_scene"] = %sf_goldengate_barricade_copcar07;
    level.scr_anim["copcar_7"]["deploy_scene"] = %sf_goldengate_deploy_copcar07;
    level.scr_anim["copcar_7"]["collapse_scene"] = %sf_goldengate_collapse_copcar07;
    level.scr_anim["copcar_8"]["approach_scene"] = %sf_goldengate_barricade_copcar08;
    level.scr_anim["copcar_8"]["deploy_scene"] = %sf_goldengate_deploy_copcar08;
    level.scr_anim["copcar_8"]["collapse_scene"] = %sf_goldengate_collapse_copcar08;
    level.scr_anim["copcar_9"]["approach_scene"] = %sf_goldengate_barricade_copcar09;
    level.scr_anim["copcar_9"]["deploy_scene"] = %sf_goldengate_deploy_copcar09;
    level.scr_anim["copcar_9"]["collapse_scene"] = %sf_goldengate_collapse_copcar09;
    level.scr_anim["copcar_10"]["approach_scene"] = %sf_goldengate_barricade_copcar10;
    level.scr_anim["copcar_10"]["deploy_scene"] = %sf_goldengate_deploy_copcar10;
    level.scr_anim["copcar_10"]["collapse_scene"] = %sf_goldengate_collapse_copcar10;
    level.scr_anim["copcar_11"]["approach_scene"] = %sf_goldengate_barricade_copcar11;
    level.scr_anim["atlas_suv"]["approach_scene"] = %sf_goldengate_collapse_suv;
    level.scr_anim["bus"]["collapse_scene"] = %sf_goldengate_collapse_bus_c;
    maps\_anim::addnotetrack_customfunction( "bus", "vfx_bus_slide_spark", maps\sanfran_fx::vfx_bus_slide_spark );
    level.scr_anim["compact"]["collapse_scene"] = %sf_goldengate_collapse_compact_c;
    level.scr_anim["sedan"]["get_out_01"] = %sf_a_civillian_civ_sedan_veh_01;
    level.scr_anim["sedan"]["get_out_02"] = %sf_a_civillian_civ_sedan_veh_02;
    level.scr_anim["sedan"]["get_out_03"] = %sf_a_civillian_civ_sedan_veh_03;
    level.scr_anim["sedan"]["get_out_04"] = %sf_a_civillian_civ_sedan_veh_04;
    level.scr_anim["sedan"]["get_out_05"] = %sf_a_civillian_civ_sedan_veh_05;
    level.scr_anim["sedan"]["get_out_06"] = %sf_a_civillian_civ_sedan_veh_06;
    level.scr_anim["sedan"]["get_out_07"] = %sf_a_civillian_civ_sedan_veh_07;
    level.scr_anim["compact"]["get_out_01"] = %sf_a_civillian_compactcar_veh_01;
    level.scr_anim["compact"]["get_out_02"] = %sf_a_civillian_compactcar_veh_02;
    level.scr_anim["compact"]["get_out_03"] = %sf_a_civillian_compactcar_veh_03;
    level.scr_anim["compact"]["get_out_04"] = %sf_a_civillian_compactcar_veh_04;
    level.scr_anim["compact"]["get_out_05"] = %sf_a_civillian_compactcar_veh_05;
    level.scr_anim["compact"]["get_out_06"] = %sf_a_civillian_compactcar_veh_06;
    level.scr_anim["compact"]["get_out_07"] = %sf_a_civillian_compactcar_veh_07;
    level.scr_anim["truck"]["get_out_01"] = %sf_a_civillian_civ_truck_veh_01;
    level.scr_anim["truck"]["get_out_02"] = %sf_a_civillian_civ_truck_veh_02;
    level.scr_anim["truck"]["get_out_03"] = %sf_a_civillian_civ_truck_veh_03;
    level.scr_anim["truck"]["get_out_04"] = %sf_a_civillian_civ_truck_veh_04;
    level.scr_anim["truck"]["get_out_05"] = %sf_a_civillian_civ_truck_veh_05;
    level.scr_anim["truck"]["get_out_06"] = %sf_a_civillian_civ_truck_veh_06;
    level.scr_anim["truck"]["get_out_07"] = %sf_a_civillian_civ_truck_veh_07;
}

setup_tanker_crash_notetrack()
{
    if ( level.currentgen )
    {
        if ( istransientloaded( "sanfran_outro_tr" ) )
            level waittill( "tff_transition_outro_to_intro" );
    }

    maps\_anim::addnotetrack_customfunction( "tanker", "vehicle_collision_impacts", maps\sanfran_fx::tanker_skid_impacts, "tanker_crash" );
}

#using_animtree("script_model");

load_prop_anims()
{
    level.scr_anim["_pitbull"]["pitbull_intro"] = %sanfran_bridge_pitbull_intro_pitbull;
    level.scr_anim["_pitbull"]["oncoming_crash"] = %sanfran_bridge_pitbull_sideswipe_pitbull;
    level.scr_anim["_pitbull"]["pitbull_crash"] = %sanfran_bridge_crash_pt2_pitbull_vm;
    maps\_anim::addnotetrack_customfunction( "_pitbull", "fx_pitbull_atlas_impact", maps\sanfran_fx::vfx_pitbull_atlas_impact );
    maps\_anim::addnotetrack_customfunction( "_pitbull", "fx_pitbull_crash_jump_start", maps\sanfran_fx::vfx_pitbull_crash_jump_start );
    maps\_anim::addnotetrack_customfunction( "_pitbull", "fx_pitbull_roof_impact", maps\sanfran_fx::vfx_pitbull_roof_impact );
    maps\_anim::addnotetrack_customfunction( "_pitbull", "fx_pitbull_slide_sparks_start", maps\sanfran_fx::vfx_pitbull_slide_sparks_start );
    maps\_anim::addnotetrack_customfunction( "_pitbull", "fx_pitbull_slide_sparks_stop", maps\sanfran_fx::vfx_pitbull_slide_sparks_stop );
    maps\_anim::addnotetrack_customfunction( "atlas_suv", "vfx_pitbull_impact_sparks", maps\sanfran_lighting::pitbull_atlas_impact_initial );
    maps\_anim::addnotetrack_customfunction( "_pitbull", "fx_pitbull_atlas_impact", maps\sanfran_lighting::pitbull_atlas_impact );
    maps\_anim::addnotetrack_customfunction( "_pitbull", "fx_pitbull_crash_jump_start", maps\sanfran_lighting::pitbull_crash_jump_start );
    maps\_anim::addnotetrack_customfunction( "_pitbull", "fx_pitbull_roof_impact", maps\sanfran_lighting::pitbull_roof_impact );
    level.scr_anim["_pitbull"]["pitbull_crawl"] = %sanfran_bridge_crash_pt3_pitbull_vm;
    maps\_anim::addnotetrack_customfunction( "_pitbull", "swap_to_real_pitbull", maps\sanfran_code::pitbull_crash_swap_to_real_model );
    level.scr_animtree["deployable_cover"] = #animtree;
    level.scr_model["deployable_cover"] = "deployable_cover";
    level.scr_anim["deployable_cover"]["deployable_cover_deploy"] = %fusion_lift_deploy_cover_deployable_cover_prop_enter;
    level.scr_anim["deployable_cover"]["deployable_cover_closed_idle"] = %fusion_lift_deploy_cover_idle_closed;
    level.scr_anim["deployable_cover"]["deployable_cover_open_idle"] = %fusion_lift_deploy_cover_idle_opened;
    level.scr_anim["bridge01"]["approach_scene"] = %sf_goldengate_barricade_chunk_a;
    level.scr_anim["bridge01"]["deploy_scene"] = %sf_goldengate_deploy_chunk_a;
    level.scr_anim["bridge01"]["collapse_scene"] = %sf_goldengate_collapse_chunk_a_pt2;
    level.scr_anim["bridge01"]["after_collapse_idle"][0] = %sf_goldengate_collapse_chunk_a_idle;
    level.scr_anim["bridge02"]["approach_scene"] = %sf_goldengate_barricade_chunk_b;
    level.scr_anim["bridge02"]["deploy_scene"] = %sf_goldengate_deploy_chunk_b;
    level.scr_anim["bridge02"]["collapse_scene"] = %sf_goldengate_collapse_chunk_b_pt2;
    level.scr_anim["bridge02"]["after_collapse_idle"][0] = %sf_goldengate_collapse_chunk_b_idle;
    level.scr_anim["bridge03"]["approach_scene"] = %sf_goldengate_barricade_chunk_c;
    level.scr_anim["bridge03"]["deploy_scene"] = %sf_goldengate_deploy_chunk_c;
    level.scr_anim["bridge03"]["collapse_scene"] = %sf_goldengate_collapse_chunk_c_pt2;
    level.scr_anim["bridge03"]["after_collapse_idle"][0] = %sf_goldengate_collapse_chunk_c_idle;
    level.scr_anim["bridge04"]["approach_scene"] = %sf_goldengate_barricade_chunk_d;
    level.scr_anim["bridge04"]["deploy_scene"] = %sf_goldengate_deploy_chunk_d;
    level.scr_anim["bridge04"]["collapse_scene"] = %sf_goldengate_collapse_chunk_d_pt2;
    level.scr_anim["bridge04"]["after_collapse_idle"][0] = %sf_goldengate_collapse_chunk_d_idle;
    level.scr_anim["bridge05"]["collapse_scene"] = %sf_goldengate_collapse_chunk_e_pt2;
    level.scr_anim["bridge06"]["collapse_scene"] = %sf_goldengate_collapse_chunk_f_pt2;
    level.scr_anim["bridge07"]["deploy_scene"] = %sf_goldengate_deploy_chunk_g;
    level.scr_anim["bridge07"]["collapse_scene"] = %sf_goldengate_collapse_chunk_g_pt2;
    level.scr_anim["rope_1"]["deploy_scene"] = %sf_goldengate_deploy_hero_rope01;
    maps\_anim::addnotetrack_customfunction( "rope_1", "vfx_cable_spark", maps\sanfran_fx::vfx_cable_spark_hero );
    level.scr_anim["rope_2"]["deploy_scene"] = %sf_goldengate_deploy_hero_rope02;
    level.scr_anim["gun"]["deploy_scene"] = %sf_goldengate_deploy_bal;
    level.scr_anim["sn6_01"]["approach_scene"] = %sf_goldengate_barricade_sn6;
    level.scr_anim["sn6_02"]["approach_scene"] = %sf_goldengate_collapse_sn6;
    level.scr_anim["sn6_02"]["approach_idle"][0] = %sf_goldengate_deploy_sn6_idle;
    level.scr_anim["cover"]["approach_scene"] = %sf_goldengate_deploy_cover;
    level.scr_anim["cutter"]["deploy_scene"] = %sf_goldengate_deploy_cutter;
    maps\_anim::addnotetrack_customfunction( "cutter", "vfx_cutter_spark", maps\sanfran_fx::vfx_cutter_spark );
    maps\_anim::addnotetrack_customfunction( "cutter", "vfx_cutter_ignite", maps\sanfran_fx::vfx_cutter_ignite );
    level.scr_anim["MOB"]["mob_sway"] = %sf_goldengate_collapse_mob_sway;
    level.scr_anim["MOB"]["mob_sway_stop"] = %sf_goldengate_collapse_mob_sway_stop;

    if ( level.nextgen || level.transient_zone == "bigm" )
        notetracks_bridge_collapse();
}

notetracks_bridge_collapse()
{
    maps\_anim::addnotetrack_customfunction( "bridge01", "vfx_bridge_shake_left", maps\sanfran_fx::vfx_bridge_shake_left );
    maps\_anim::addnotetrack_customfunction( "bridge01", "vfx_bridge_shake_right", maps\sanfran_fx::vfx_bridge_shake_right );
    maps\_anim::addnotetrack_customfunction( "bridge01", "VFX_Bridge_Snap", maps\sanfran_fx::vfx_bridge_snap );
    maps\_anim::addnotetrack_customfunction( "bridge01", "bridge_swap", maps\sanfran_code::swap_brigde_anim_to_real );
    maps\_anim::addnotetrack_customfunction( "bridge01", "bridge_swap_far", maps\sanfran_code::swap_brigde_anim_to_real_far );
    maps\_anim::addnotetrack_customfunction( "bridge03", "vfx_cable_break", maps\sanfran_fx::vfx_cable_break );
    maps\_anim::addnotetrack_customfunction( "bridge05", "vfx_bridge_crack_start", maps\sanfran_fx::vfx_bridge_crack_start );
    maps\_anim::addnotetrack_customfunction( "bridge06", "vfx_burst_right_close", maps\sanfran_fx::vfx_burst_right_close );
    maps\_anim::addnotetrack_customfunction( "bridge06", "vfx_burst_left_close", maps\sanfran_fx::vfx_burst_left_close );
    maps\_anim::addnotetrack_customfunction( "bridge07", "vfx_bridge_chunk_f_piece5_fall", maps\sanfran_fx::vfx_bridge_chunk_f_piece5_fall );
}

collapse_fov( var_0 )
{
    maps\_utility::lerp_fov_overtime( 3, 50 );
}

fade_to_black( var_0 )
{
    maps\_loadout_code::saveplayerweaponstatepersistent( "sanfran", 1 );
    maps\_utility::nextmission();
}
