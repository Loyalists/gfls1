// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level.intro_hades_video_length = 5.0;
    
    var_0 = "none";

    if ( level.currentgen )
    {
        if ( istransientloaded( "fusion_intro_tr" ) )
            var_0 = "intro";
        else if ( istransientloaded( "fusion_middle_tr" ) )
            var_0 = "middle";
        else if ( istransientloaded( "fusion_outro_tr" ) )
            var_0 = "outro";
    }

    if ( level.nextgen )
        anim.forced_s1_motionset = 1;

    thread load_anims( var_0 );
    thread load_actor_anims( var_0 );
    thread load_script_model_anims( var_0 );
    thread load_vehicle_anims( var_0 );
    interior_setup_anims( var_0 );

    if ( level.currentgen )
    {
        if ( var_0 == "intro" )
            thread notetrack_setup_middle();

        if ( var_0 == "intro" || var_0 == "middle" )
            thread notetrack_setup_outro();
    }
}

interior_setup_anims( var_0 )
{
    interior_player_anims( var_0 );
    interior_npc_anims( var_0 );
}

#using_animtree("player");

load_anims( var_0 )
{
    level.scr_animtree["player_rig"] = #animtree;
    level.scr_model["player_rig"] = "s1_gfl_ump45_viewbody";
    level.scr_animtree["player_arms"] = #animtree;
    level.scr_model["player_arms"] = "s1_gfl_ump45_viewhands_player";
    level.scr_anim["player_rig"]["fly_in_intro"] = %fusion_fly_in_intro_view_model;
    level.scr_anim["player_rig"]["fly_in_part2"] = %fusion_fly_in_pt2_view_model;
    level.scr_anim["player_rig"]["enter_left"] = %x4walker_wheels_cockpit_in_l_vm;
    level.scr_anim["player_rig"]["enter_right"] = %x4walker_wheels_cockpit_in_r_vm;
    level.scr_anim["player_rig"]["exit_left"] = %x4walker_wheels_cockpit_out_l_vm;
    level.scr_anim["player_rig"]["exit_right"] = %x4walker_wheels_cockpit_out_r_vm;
    level.scr_anim["player_arms"]["elevator_button_scene"] = %fusion_elevator_button_push_vm;
    maps\_anim::addnotetrack_notify( "player_arms", "button_push", "flag_anim_elevator_button_pressed", "elevator_button_scene" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "cockpit_swap", ::swap_cockpit_model );
    level.scr_anim["player_rig"]["fusion_silo_collapse_vm_pt01"] = %fusion_silo_collapse_vm_pt01;
    level.scr_anim["player_rig"]["fusion_silo_collapse_vm_pt02"] = %fusion_silo_collapse_vm_pt02;
    level.scr_anim["player_rig"]["fusion_silo_collapse_finale"] = %fusion_silo_collapse_vm_pt03;
    maps\_anim::addnotetrack_customfunction( "player_rig", "fov_55", ::fov_snap_to_55, "fusion_silo_collapse_vm_pt02" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "fov_45", ::fov_set_to_35, "fusion_silo_collapse_finale" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "rumble_small", ::rumble_small, "fusion_silo_collapse_vm_pt01" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "rumble_small", ::rumble_small, "fusion_silo_collapse_vm_pt02" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "rumble_small", ::rumble_small, "fusion_silo_collapse_finale" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "rumble_medium", ::rumble_medium, "fusion_silo_collapse_vm_pt01" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "rumble_medium", ::rumble_medium, "fusion_silo_collapse_vm_pt02" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "rumble_medium", ::rumble_medium, "fusion_silo_collapse_finale" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "rumble_large", ::rumble_large, "fusion_silo_collapse_vm_pt01" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "rumble_large", ::rumble_large, "fusion_silo_collapse_vm_pt02" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "rumble_large", ::rumble_large, "fusion_silo_collapse_finale" );
    maps\_anim::addnotetrack_flag( "player_rig", "fade_out", "play_ending" );

    if ( level.nextgen || var_0 == "outro" )
        maps\_anim::addnotetrack_customfunction( "player_rig", "drag_sand_begin", ::end_drag_dust, "fusion_silo_collapse_finale" );

    level.scr_animtree["player_dismembered_arm"] = #animtree;
    level.scr_model["player_dismembered_arm"] = "vb_pmc_dismember";
    level.scr_anim["player_dismembered_arm"]["fusion_silo_collapse_finale"] = %fusion_silo_collapse_vm_arm;
}

fov_snap_to_55( var_0 )
{
    var_0 maps\_utility::lerp_fov_overtime( 0.5, 55 );
}

fov_set_to_35( var_0 )
{
    var_0 maps\_utility::lerp_fov_overtime( 8, 35 );
}

rumble_small( var_0 )
{
    level.player playrumbleonentity( "damage_light" );
}

rumble_medium( var_0 )
{
    level.player playrumbleonentity( "damage_heavy" );
}

rumble_large( var_0 )
{
    level.player playrumbleonentity( "artillery_rumble" );
}

fov_lerp_to_50_blendtime( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 1;

    var_0 maps\_utility::lerp_fov_overtime( var_1, 50 );
}

fov_reset_previous( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 65;

    var_0 maps\_utility::lerp_fov_overtime( 1, var_1 );
}

interior_player_anims( var_0 )
{
    level.scr_animtree["player_arms"] = #animtree;
    level.scr_model["player_arms"] = "s1_gfl_ump45_viewhands_player";
    level.scr_animtree["player_rig"] = #animtree;
    level.scr_model["player_rig"] = "s1_gfl_ump45_viewbody";
    level.scr_anim["player_rig"]["elevator_descent"] = %fusion_elevator_shaft_vm;
    maps\_anim::addnotetrack_notify( "player_rig", "burke_elevator_landing", "burke_elevator_landing", "elevator_descent" );
    level.scr_anim["player_rig"]["control_room_scene"] = %fusion_control_room_vm;
}

clear_player_anim( var_0 )
{
    self clearanim( %root, var_0 );
}

#using_animtree("generic_human");

load_actor_anims( var_0 )
{
    level.scr_anim["burke"]["reactor_talk"] = %fusion_controlroom_guy3;
    level.scr_anim["burke"]["fly_in_intro"] = %fusion_fly_in_intro_burke;
    level.scr_anim["joker"]["fly_in_intro"] = %fusion_fly_in_intro_npc_a;
    level.scr_anim["carter"]["fly_in_intro"] = %fusion_fly_in_intro_npc_a2;
    level.scr_anim["npc_f"]["fly_in_intro"] = %fusion_fly_in_intro_npc_f;
    level.scr_anim["npc_g"]["fly_in_intro"] = %fusion_fly_in_intro_npc_g;
    level.scr_anim["npc_h"]["fly_in_intro"] = %fusion_fly_in_intro_npc_h;
    level.scr_anim["burke"]["fly_in_part2"] = %fusion_fly_in_pt2_burke;
    level.scr_anim["joker"]["fly_in_part2"] = %fusion_fly_in_pt2_npc_a;
    level.scr_anim["carter"]["fly_in_part2"] = %fusion_fly_in_pt2_npc_a;
    level.scr_anim["npc_b"]["fly_in_part2"] = %fusion_fly_in_pt2_npc_b;
    level.scr_anim["npc_c"]["fly_in_part2"] = %fusion_fly_in_pt2_npc_c;
    level.scr_anim["npc_d"]["fly_in_part2"] = %fusion_fly_in_pt2_npc_d;
    level.scr_anim["npc_e"]["fly_in_part2"] = %fusion_fly_in_pt2_npc_e;
    level.scr_anim["npc_f"]["fly_in_part2"] = %fusion_fly_in_pt2_npc_f;
    level.scr_anim["npc_g"]["fly_in_part2"] = %fusion_fly_in_pt2_npc_g;
    level.scr_anim["npc_h"]["fly_in_part2"] = %fusion_fly_in_intro_npc_h_2;
    level.scr_anim["burke"]["fly_in_end_idle"][0] = %fusion_fly_in_pt2_burke_idle;
    level.scr_anim["burke"]["burke_rooftop_shoot_enter"] = %fusion_fly_in_intro_zip_burke_shoot_enter;
    level.scr_anim["burke"]["burke_intro_zip"] = %fusion_fly_in_intro_zip_burke;
    level.scr_anim["npc_zip_1"]["npc_zip"] = %fusion_zipline_guy1;
    level.scr_anim["npc_zip_2"]["npc_zip"] = %fusion_zipline_guy2;
    level.scr_anim["npc_zip_3"]["npc_zip"] = %fusion_zipline_guy3;
    level.scr_anim["npc_zip_4"]["npc_zip"] = %fusion_zipline_guy4;
    level.scr_anim["burke"]["street_burke_rally"] = %fusion_burke_run_rally_up_guy1;
    level.scr_anim["joker"]["street_burke_rally_in"] = %fusion_burke_run_rally_up_runup_guy2;
    level.scr_anim["joker"]["street_burke_rally_idle"] = [ %fusion_burke_run_rally_up_idle_guy2 ];
    level.scr_anim["joker"]["street_burke_rally_out"] = %fusion_burke_run_rally_up_runout_guy2;
    level.scr_anim["joker"]["reactor_entrance_st"] = %paris_bookstore_exit_guy1_st;
    level.scr_anim["joker"]["reactor_entrance_idle"] = [ %paris_bookstore_exit_guy1_idle ];
    level.scr_anim["burke"]["reactor_entrance_st"] = %paris_bookstore_exit_guy2_st;
    level.scr_anim["burke"]["reactor_entrance_idle"] = [ %paris_bookstore_exit_guy2_idle ];
    level.scr_anim["burke"]["fusion_silo_stumble_npc"] = %fusion_silo_stumble_npc;
    level.scr_anim["burke"]["fusion_silo_collapse_finale"] = %fusion_silo_collapse_npc;
    level.scr_anim["guy1"]["fusion_mobile_cover"] = %fusion_mobile_cover_fire_guy1;
    level.scr_anim["guy2"]["fusion_mobile_cover"] = %fusion_mobile_cover_fire_guy2;
    level.scr_anim["guy1"]["fusion_mobile_cover_2"] = %mobile_cover_crouch_walk_guy1;
    level.scr_anim["guy2"]["fusion_mobile_cover_2"] = %mobile_cover_crouch_walk_guy2;
    level.scr_anim["guy1"]["fusion_rooftop_slide"] = %fusion_rubble_slide_guy1;
    level.scr_anim["guy2"]["fusion_rooftop_slide"] = %fusion_rubble_slide_guy2;
    level.scr_anim["guy1"]["guy_enter_mobile_turret"] = %x4walker_wheels_enter_right_npc;
    level.scr_anim["carter"]["fus_control_room_in"] = %fusion_controlroom_guy1_a;
    level.scr_anim["carter"]["fus_control_room_loop"][0] = %fusion_controlroom_guy1_b;
    level.scr_anim["carter"]["fus_control_room_out"] = %fusion_controlroom_guy1_c;
    level.scr_anim["joker"]["fus_control_room_in"] = %fusion_controlroom_guy2_a;
    level.scr_anim["joker"]["fus_control_room_loop"][0] = %fusion_controlroom_guy2_b;
    level.scr_anim["joker"]["fus_control_room_out"] = %fusion_controlroom_guy2_c;
    level.scr_anim["pickup_event_guy1"]["fusion_reaction_pickup_event"] = %fusion_vehicle_explode_guy1;
    level.scr_anim["pickup_event_guy2"]["fusion_reaction_pickup_event"] = %fusion_vehicle_explode_guy2;

    if ( level.nextgen || var_0 == "outro" )
        maps\_anim::addnotetrack_customfunction( "pickup_event_guy1", "dead", ::ai_kill, "fusion_reaction_pickup_event" );

    level.scr_anim["generic"]["payback_comp_balcony_kick_enemy"] = %payback_comp_balcony_kick_enemy;
    level.scr_anim["civilian"]["dubai_restaurant_rolling_soldier"] = %dubai_restaurant_rolling_soldier;
    level.scr_anim["generic"]["corner_standR_deathA"] = %corner_standr_deatha;
    level.scr_anim["generic"]["corner_standR_deathB"] = %corner_standr_deathb;
    level.scr_anim["generic"]["coverstand_death_left"] = %coverstand_death_left;
    level.scr_anim["generic"]["coverstand_death_right"] = %coverstand_death_right;
    level.scr_anim["generic"]["covercrouch_death_1"] = %covercrouch_death_1;
    level.scr_anim["generic"]["prone_death_quickdeath"] = %prone_death_quickdeath;
    level.scr_anim["generic"]["death_shotgun_back_v1"] = %death_shotgun_back_v1;
    level.scr_anim["generic"]["arcadia_ending_sceneA_dead_civilian"] = %arcadia_ending_scenea_dead_civilian;
    level.scr_anim["generic"]["civilian_leaning_death"] = %civilian_leaning_death;
    level.scr_anim["generic"]["dcburning_elevator_corpse_idle_A"] = %dcburning_elevator_corpse_idle_a;
}

interior_npc_anims( var_0 )
{
    level.scr_anim["carter"]["fusion_security_doors_approach"] = %fusion_security_doors_approach_guy1;
    level.scr_anim["burke"]["fusion_security_doors_approach"] = %fusion_security_doors_approach_guy2;
    level.scr_anim["carter"]["fusion_security_doors_idle"][0] = %fusion_security_doors_idle_guy1;
    level.scr_anim["burke"]["fusion_security_doors_idle"][0] = %fusion_security_doors_idle_guy2;
    level.scr_anim["carter"]["fusion_security_doors_open"] = %fusion_security_doors_open_guy1;
    level.scr_anim["burke"]["fusion_security_doors_open"] = %fusion_security_doors_open_guy2;
    maps\_anim::addnotetrack_customfunction( "burke", "vfx_door_open_rt", maps\fusion_fx::control_room_door_open_rt, "fusion_security_doors_open" );
    maps\_anim::addnotetrack_customfunction( "burke", "vfx_door_open_lt", maps\fusion_fx::control_room_door_open_lt, "fusion_security_doors_open" );
    level.scr_anim["burke"]["security_room_check_corpse"] = %fusion_security_room_corpse_fall_npc_burke;
    level.scr_anim["generic"]["security_room_check_corpse"] = %fusion_security_room_corpse_fall_npc;
    level.scr_anim["burke"]["security_room_check_corpse_idle"][0] = %fusion_security_room_corpse_fall_npc_burke_idle;
    level.scr_anim["burke"]["security_room_turn_to_elevator"] = %fusion_security_room_corpse_fall_2_burke_idle;
    level.scr_anim["joker"]["security_room_approach_elevator"] = %fusion_elevator_door_open_guy1;
    level.scr_anim["carter"]["security_room_approach_elevator"] = %fusion_elevator_door_open_guy2;
    level.scr_anim["joker"]["security_room_open_elevator_idle"][0] = %fusion_elevator_door_open_guy1_idle;
    level.scr_anim["carter"]["security_room_open_elevator_idle"][0] = %fusion_elevator_door_open_guy2_idle;
    level.scr_anim["joker"]["security_room_open_elevator"] = %fusion_elevator_door_open_guy1_open;
    level.scr_anim["carter"]["security_room_open_elevator"] = %fusion_elevator_door_open_guy2_open;
    level.scr_anim["joker"]["security_room_elevator_opened_idle"][0] = %fusion_elevator_door_open_guy1_open_idle;
    level.scr_anim["carter"]["security_room_elevator_opened_idle"][0] = %fusion_elevator_door_open_guy2_open_idle;
    maps\_anim::addnotetrack_notify( "joker", "elevator_attach", "elevator_attach_joker", "security_room_open_elevator" );
    maps\_anim::addnotetrack_notify( "carter", "elevator_attach", "elevator_attach_carter", "security_room_open_elevator" );
    maps\_anim::addnotetrack_notify( "joker", "elevator_detach", "elevator_detach_joker", "security_room_open_elevator" );
    maps\_anim::addnotetrack_notify( "carter", "elevator_detach", "elevator_detach_carter", "security_room_open_elevator" );
    level.scr_anim["burke"]["elevator_descent_start_idle"][0] = %fusion_elevator_shaft_npc_burke_idle;
    level.scr_anim["burke"]["elevator_descent"] = %fusion_elevator_shaft_burke;
    maps\_anim::addnotetrack_customfunction( "burke", "elevator_slide", maps\fusion_fx::fx_elevator_descent_burke, "elevator_descent" );
    level.scr_anim["joker"]["elevator_descent"] = %fusion_elevator_shaft_npc1;
    level.scr_anim["carter"]["elevator_descent"] = %fusion_elevator_shaft_npc2;
    level.scr_anim["burke"]["elevator_descent_exit"] = %fusion_elevator_shaft_burke_exit;
    level.scr_anim["burke"]["elevator_descent_end_idle"][0] = %fusion_elevator_shaft_npc_burke_exit_idle;
    level.scr_anim["burke"]["elevator_descent_end_idle_2_cqb"] = %fusion_elevator_shaft_npc_burke_exit_idle_2_cqb;
    level.scr_anim["joker"]["elevator_descent_end_idle"][0] = %fusion_elevator_shaft_npc1_exit_idle;
    level.scr_anim["carter"]["elevator_descent_end_idle"][0] = %fusion_elevator_shaft_npc2_exit_idle;
    level.scr_anim["joker"]["elevator_descent_end_idle_2_cqb"] = %fusion_elevator_shaft_npc1_exit_idle_2_cqb;
    level.scr_anim["carter"]["elevator_descent_end_idle_2_cqb"] = %fusion_elevator_shaft_npc2_exit_idle_2_cqb;
    level.scr_anim["joker"]["negotiation_elevator_to_hall"] = %fusion_movingf_checkl_turnr;
    level.scr_anim["burke"]["negotiation_hall_to_lab"] = %fusion_movingf_checkr_continuef;
    level.scr_anim["burke"]["negotiation_curved_hall"] = %fusion_movingf_checkf_checkl_turnr;
    level.scr_anim["carter"]["negotiation_locker_room_entrance"] = %fusion_movingf_crouch_checkl_turnl;
    level.scr_anim["burke"]["fusion_airlock_opening_approach"] = %fusion_airlock_opening_burke;
    level.scr_anim["carter"]["fusion_airlock_opening_approach"] = %fusion_airlock_opening_guy2;
    level.scr_anim["burke"]["fusion_airlock_opening_idle"][0] = %fusion_airlock_opening_idle_burke;
    level.scr_anim["carter"]["fusion_airlock_opening_idle"][0] = %fusion_airlock_opening_idle_guy2;
    level.scr_anim["burke"]["fusion_airlock_opening"] = %fusion_airlock_opening_pt2_burke;
    level.scr_anim["generic"]["fusion_airlock_opening"] = %fusion_airlock_opening_pt2_guy1;
    level.scr_anim["carter"]["fusion_airlock_opening"] = %fusion_airlock_opening_pt2_guy2;

    if ( level.nextgen || var_0 == "middle" )
        maps\_anim::addnotetrack_customfunction( "generic", "start_ragdoll", ::ai_kill_no_ragdoll, "fusion_airlock_opening" );

    level.scr_anim["generic"]["reactor_room_catwalk_death"] = %ny_harbor_davora_side_fall_death;
    level.scr_anim["burke"]["turbine_elevator_enter"] = %fusion_lift_deploy_cover_right_enter;
    level.scr_anim["joker"]["turbine_elevator_enter"] = %fusion_lift_deploy_cover_carter_enter;
    level.scr_anim["carter"]["turbine_elevator_enter"] = %fusion_lift_deploy_cover_left_enter;
    level.scr_anim["burke"]["turbine_elevator_idle"][0] = %fusion_lift_deploy_cover_right_idle;
    level.scr_anim["joker"]["turbine_elevator_idle"][0] = %fusion_lift_deploy_cover_carter_idle;
    level.scr_anim["carter"]["turbine_elevator_idle"][0] = %fusion_lift_deploy_cover_left_idle;
    level.scr_anim["burke"]["turbine_elevator_exit"] = %fusion_lift_deploy_cover_right_exit;
    level.scr_anim["joker"]["turbine_elevator_exit"] = %fusion_lift_deploy_cover_carter_exit;
    level.scr_anim["carter"]["turbine_elevator_exit"] = %fusion_lift_deploy_cover_left_exit;
    level.scr_anim["burke"]["fusion_door_explosion_postup"] = %fusion_door_open_postup_burke;
    level.scr_anim["carter"]["fusion_door_explosion_postup"] = %fusion_door_open_postup_npc_a;
    level.scr_anim["burke"]["fusion_door_explosion_postup_loop"][0] = %fusion_door_open_postup_loop_burke;
    level.scr_anim["carter"]["fusion_door_explosion_postup_loop"][0] = %fusion_door_open_postup_loop_npc_a;
    level.scr_anim["burke"]["fusion_door_explosion"] = %fusion_door_explosion_burke;
    level.scr_anim["carter"]["fusion_door_explosion"] = %fusion_door_explosion_npc_a;
    level.scr_anim["joker"]["fusion_door_explosion"] = %fusion_door_explosion_npc_b;
    level.scr_anim["burke"]["control_room_idle"][0] = %fusion_control_room_idle_burke;
    level.scr_anim["carter"]["control_room_idle"][0] = %fusion_control_room_idle_npc_a;
    level.scr_anim["joker"]["control_room_idle"][0] = %fusion_control_room_idle_npc_b;
    level.scr_anim["burke"]["control_room_scene"] = %fusion_control_room_burke;
    level.scr_anim["carter"]["control_room_scene"] = %fusion_control_room_npc_a;
    level.scr_anim["joker"]["control_room_scene"] = %fusion_control_room_npc_b;
    level.scr_anim["generic"]["paris_npc_dead_poses_v02"] = %paris_npc_dead_poses_v02;
    level.scr_anim["generic"]["paris_npc_dead_poses_v03"] = %paris_npc_dead_poses_v03;
    level.scr_anim["generic"]["paris_npc_dead_poses_v09"] = %paris_npc_dead_poses_v09;
    level.scr_anim["generic"]["paris_npc_dead_poses_v11"] = %paris_npc_dead_poses_v11;
    level.scr_anim["generic"]["paris_npc_dead_poses_v15"] = %paris_npc_dead_poses_v15;
    level.scr_anim["generic"]["paris_npc_dead_poses_v16"] = %paris_npc_dead_poses_v16;
    level.scr_anim["generic"]["paris_npc_dead_poses_v18"] = %paris_npc_dead_poses_v18;
    level.scr_anim["generic"]["paris_npc_dead_poses_v20"] = %paris_npc_dead_poses_v20;
    level.scr_anim["generic"]["paris_npc_dead_poses_v21"] = %paris_npc_dead_poses_v21;
    level.scr_anim["generic"]["paris_npc_dead_poses_v22"] = %paris_npc_dead_poses_v22;
    level.scr_anim["generic"]["dead_body_floating_1"][0] = %dead_body_floating_1;
    level.scr_anim["generic"]["dead_body_floating_2"][0] = %dead_body_floating_2;
    level.scr_anim["generic"]["dead_body_floating_3"][0] = %dead_body_floating_3;
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

ai_kill_no_ragdoll( var_0 )
{
    var_0.allowdeath = 1;
    var_0.skipdeathanim = 1;
    var_0.noragdoll = 1;
    var_0.a.nodeath = 1;
    wait 0.05;
    var_0 kill();
}

clear_npc_anim( var_0 )
{
    self clearanim( %root, var_0 );
}

#using_animtree("vehicles");

load_vehicle_anims( var_0 )
{
    level.scr_anim["warbird_a"]["fly_in_intro"] = %fusion_fly_in_intro_warbird_a;
    maps\_anim::addnotetrack_flag( "warbird_a", "map_open", "fusion_map_open" );
    maps\_anim::addnotetrack_flag( "warbird_a", "map_anim_start", "fusion_start_map_anim" );
    maps\_anim::addnotetrack_flag( "warbird_a", "map_anim_end", "fusion_stop_map_anim" );
    maps\_anim::addnotetrack_flag( "warbird_a", "map_target_01", "fusion_map_target_01" );
    maps\_anim::addnotetrack_flag( "warbird_a", "map_target_02", "fusion_map_target_02" );
    level.scr_anim["warbird_a"]["fly_in_part2"] = %fusion_fly_in_pt2_warbird_a;

    if ( level.nextgen || var_0 == "intro" )
    {
        maps\_anim::addnotetrack_customfunction( "warbird_a", "VFX_missile_launch_00", ::spawn_fly_in_missile_00, "fly_in_part2" );
        maps\_anim::addnotetrack_customfunction( "warbird_a", "VFX_missile_launch_01", ::spawn_fly_in_missile_01, "fly_in_part2" );
        maps\_anim::addnotetrack_customfunction( "warbird_a", "VFX_missile_launch_02", ::spawn_fly_in_missile_02, "fly_in_part2" );
        maps\_anim::addnotetrack_customfunction( "warbird_a", "VFX_missile_launch_03", ::spawn_fly_in_missile_03, "fly_in_part2" );
        maps\_anim::addnotetrack_customfunction( "warbird_a", "VFX_missile_launch_04", ::spawn_fly_in_missile_04, "fly_in_part2" );
        maps\_anim::addnotetrack_customfunction( "warbird_a", "VFX_missile_launch_05", ::spawn_fly_in_missile_05, "fly_in_part2" );
        maps\_anim::addnotetrack_customfunction( "warbird_a", "VFX_missile_launch_06", ::spawn_fly_in_missile_06, "fly_in_part2" );
    }

    level.scr_anim["warbird_b"]["fly_in_part2"] = %fusion_fly_in_pt2_warbird_b;

    if ( level.nextgen || var_0 == "intro" )
    {
        maps\_anim::addnotetrack_customfunction( "warbird_b", "VFX_missile_hit", maps\fusion_fx::intro_fly_in_missile_hit_warbird );
        maps\_anim::addnotetrack_customfunction( "warbird_b", "VFX_missile_hit", maps\fusion_code::intro_missile_hit );
        maps\_anim::addnotetrack_customfunction( "warbird_b", "VFX_heli_crash_tower", maps\fusion_fx::intro_fly_in_missile_hit_warbird_tower );
        maps\_anim::addnotetrack_customfunction( "warbird_b", "VFX_rotorsmoke_start", maps\fusion_fx::intro_fly_in_missile_hit_warbird_rotorsmoke );
        maps\_anim::addnotetrack_customfunction( "warbird_b", "VFX_rotorsmoke_stop", maps\fusion_fx::intro_fly_in_missile_hit_warbird_rotorsmoke_stop );
    }

    level.scr_anim["warbird_c"]["fly_in_part2"] = %fusion_fly_in_pt2_warbird_c;
    level.scr_anim["warbird_d"]["fly_in_part2"] = %fusion_fly_in_pt2_warbird_d;
    level.scr_anim["warbird_e"]["fly_in_part2"] = %fusion_fly_in_pt2_warbird_e;
    level.scr_anim["warbird_a"]["hatch_door_veil"] = %fusion_fly_in_intro_warbird_a;

    if ( level.nextgen || var_0 == "intro" )
    {
        maps\_anim::addnotetrack_customfunction( "warbird_a", "open_door", maps\fusion_lighting::hatch_door_veil );
        maps\_anim::addnotetrack_customfunction( "warbird_a", "open_door", maps\fusion_lighting::hatch_door_vision );
        maps\_anim::addnotetrack_customfunction( "warbird_a", "open_door", maps\fusion_lighting::hatch_door_lightgrid_off );
        maps\_anim::addnotetrack_customfunction( "warbird_a", "open_door", maps\fusion_code::play_dust );
        maps\_anim::addnotetrack_customfunction( "warbird_a", "open_door", maps\fusion_lighting::hatch_door_push_fog_out );
    }

    level.scr_anim["warbird_a"]["fusion_fly_in_warbird_a_idle"] = %fusion_fly_in_warbird_a_idle;
    level.scr_anim["npc_zip_warbird"]["npc_zip"] = %fusion_zipline_warbird;
    level.scr_anim["warbird_a"]["burke_intro_zip"] = %fusion_fly_in_intro_zip_warbird_a;
    level.scr_anim["warbird_a"]["burke_intro_zip_loop"][0] = %fusion_fly_in_intro_zip_warbird_a_loop;
    level.scr_animtree["mobile_cover"] = #animtree;
    level.scr_model["mobile_cover"] = "vehicle_mobile_cover";
    level.scr_anim["mobile_cover"]["fusion_mobile_cover"] = %fusion_mobile_cover;
    level.scr_anim["mobile_cover"]["fusion_mobile_cover_2"] = %mobile_cover_crouch_walk;
    level.scr_animtree["cart"] = #animtree;
    level.scr_anim["cart"]["fusion_utility_cart_explode_cart"] = %fusion_utility_cart_explode_cart;
    level.scr_animtree["pickup"] = #animtree;
    level.scr_anim["pickup"]["fusion_reaction_pickup_event"] = %fusion_vehicle_explode_truck;
    level.scr_anim["warbird_deploy"]["mobile_turret_deploy"] = %mobile_turret_deploy_warbird;
    level.scr_anim["mobile_turret"]["guy_enter_mobile_turret"] = %x4walker_wheels_enter_right;
    level.scr_anim["walker_tank"]["fusion_walker_tank_enter"] = %fusion_walker_tank_enter;
    level.scr_anim["walker_tank"]["fusion_walker_tank_fwd_2_left"] = %fusion_walker_tank_fwd_2_left;
    level.scr_anim["walker_tank"]["fusion_walker_tank_fwd_2_right"] = %fusion_walker_tank_fwd_2_right;
    level.scr_anim["walker_tank"]["fusion_walker_tank_fwd_idle"][0] = %fusion_walker_tank_fwd_idle;
    level.scr_anim["walker_tank"]["fusion_walker_tank_left_2_fwd"] = %fusion_walker_tank_left_2_fwd;
    level.scr_anim["walker_tank"]["fusion_walker_tank_left_idle"][0] = %fusion_walker_tank_left_idle;
    level.scr_anim["walker_tank"]["fusion_walker_tank_right_2_fwd"] = %fusion_walker_tank_right_2_fwd;
    level.scr_anim["walker_tank"]["fusion_walker_tank_right_idle"][0] = %fusion_walker_tank_right_idle;
    level.scr_anim["walker_tank"]["fusion_walker_tank_fwd_idle_death"] = %fusion_walker_tank_fwd_idle_death;
    maps\_anim::addnotetrack_customfunction( "walker_tank", "walker_death", maps\fusion_code::destroy_walker_tank, "fusion_walker_tank_fwd_idle_death" );
    level.scr_anim["walker_tank"]["fusion_walker_tank_left_idle_death"] = %fusion_walker_tank_left_idle_death;
    maps\_anim::addnotetrack_customfunction( "walker_tank", "walker_death", maps\fusion_code::destroy_walker_tank, "fusion_walker_tank_left_idle_death" );
    level.scr_anim["walker_tank"]["fusion_walker_tank_right_idle_death"] = %fusion_walker_tank_right_idle_death;
    maps\_anim::addnotetrack_customfunction( "walker_tank", "walker_death", maps\fusion_code::destroy_walker_tank, "fusion_walker_tank_right_idle_death" );
    maps\_anim::addnotetrack_customfunction( "walker_tank", "footstep_left_large", maps\fusion_fx::walker_tank_footstep_left );
    maps\_anim::addnotetrack_customfunction( "walker_tank", "footstep_right_large", maps\fusion_fx::walker_tank_footstep_right );
    maps\_anim::addnotetrack_customfunction( "walker_tank", "footstep_left_rear_large", maps\fusion_fx::walker_tank_footstep_left_rear );
    maps\_anim::addnotetrack_customfunction( "walker_tank", "footstep_right_rear_large", maps\fusion_fx::walker_tank_footstep_right_rear );
    level.scr_animtree["vehicle_xh9_warbird"] = #animtree;
    level.scr_model["vehicle_xh9_warbird"] = "vehicle_xh9_warbird";
    level.scr_anim["vehicle_xh9_warbird"]["fusion_silo_collapse_warbird"] = %fusion_silo_collapse_warbird;
}

clear_vehicle_anim( var_0 )
{
    self clearanim( %root, var_0 );
}

#using_animtree("script_model");

load_script_model_anims( var_0 )
{
    level.scr_animtree["ar_map"] = #animtree;
    level.scr_anim["ar_map"]["fly_in_intro"] = %fusion_fly_in_armap;
    level.scr_animtree["missile_0"] = #animtree;
    level.scr_model["missile_0"] = "projectile_missile_javelin";
    level.scr_anim["missile_0"]["fly_in_part2"] = %fusion_fly_in_pt2_missile_00;
    level.scr_animtree["missile_1"] = #animtree;
    level.scr_model["missile_1"] = "projectile_missile_stinger";
    level.scr_anim["missile_1"]["fly_in_part2"] = %fusion_fly_in_pt2_missile_01;
    level.scr_animtree["missile_2"] = #animtree;
    level.scr_model["missile_2"] = "projectile_missile_stinger";
    level.scr_anim["missile_2"]["fly_in_part2"] = %fusion_fly_in_pt2_missile_02;
    level.scr_animtree["missile_3"] = #animtree;
    level.scr_model["missile_3"] = "projectile_missile_stinger";
    level.scr_anim["missile_3"]["fly_in_part2"] = %fusion_fly_in_pt2_missile_03;
    level.scr_animtree["missile_4"] = #animtree;
    level.scr_model["missile_4"] = "projectile_missile_stinger";
    level.scr_anim["missile_4"]["fly_in_part2"] = %fusion_fly_in_pt2_missile_04;
    level.scr_animtree["missile_5"] = #animtree;
    level.scr_model["missile_5"] = "projectile_missile_stinger";
    level.scr_anim["missile_5"]["fly_in_part2"] = %fusion_fly_in_pt2_missile_05;
    level.scr_animtree["missile_6"] = #animtree;
    level.scr_model["missile_6"] = "projectile_missile_stinger";
    level.scr_anim["missile_6"]["fly_in_part2"] = %fusion_fly_in_pt2_missile_06;
    level.scr_animtree["warbird_pulley_c"] = #animtree;
    level.scr_model["warbird_pulley_c"] = "vehicle_xh9_warbird_pulley";
    level.scr_anim["warbird_pulley_c"]["fly_in_part2"] = %fusion_fly_in_pt2_warbird_pulley_c;
    level.scr_animtree["warbird_pulley_d"] = #animtree;
    level.scr_model["warbird_pulley_d"] = "vehicle_xh9_warbird_pulley";
    level.scr_anim["warbird_pulley_d"]["fly_in_part2"] = %fusion_fly_in_pt2_warbird_pulley_d;
    level.scr_animtree["warbird_pulley_e"] = #animtree;
    level.scr_model["warbird_pulley_e"] = "vehicle_xh9_warbird_pulley";
    level.scr_anim["warbird_pulley_e"]["fly_in_part2"] = %fusion_fly_in_pt2_warbird_pulley_e;
    level.scr_animtree["warbird_walker_c"] = #animtree;
    level.scr_model["warbird_walker_c"] = "vehicle_x4walker_wheels";
    level.scr_anim["warbird_walker_c"]["fly_in_part2"] = %fusion_fly_in_pt2_warbird_x4walker_c;
    level.scr_animtree["warbird_walker_d"] = #animtree;
    level.scr_model["warbird_walker_d"] = "vehicle_x4walker_wheels";
    level.scr_anim["warbird_walker_d"]["fly_in_part2"] = %fusion_fly_in_pt2_warbird_x4walker_d;
    level.scr_animtree["warbird_walker_e"] = #animtree;
    level.scr_model["warbird_walker_e"] = "vehicle_x4walker_wheels";
    level.scr_anim["warbird_walker_e"]["fly_in_part2"] = %fusion_fly_in_pt2_warbird_x4walker_e;
    level.scr_animtree["zipline_1"] = #animtree;
    level.scr_model["zipline_1"] = "npc_zipline101ft";
    level.scr_anim["zipline_1"]["npc_zip"] = %zipline_rope1;
    level.scr_animtree["zipline_2"] = #animtree;
    level.scr_model["zipline_2"] = "npc_zipline101ft";
    level.scr_anim["zipline_2"]["npc_zip"] = %zipline_rope2;
    level.scr_animtree["zipline_3"] = #animtree;
    level.scr_model["zipline_3"] = "npc_zipline101ft";
    level.scr_anim["zipline_3"]["npc_zip"] = %zipline_rope3;
    level.scr_animtree["zipline_4"] = #animtree;
    level.scr_model["zipline_4"] = "npc_zipline101ft";
    level.scr_anim["zipline_4"]["npc_zip"] = %zipline_rope4;
    level.scr_anim["_zipline_gun_fl"]["burke_intro_zip"] = %fusion_fly_in_intro_zip_zipgun;
    level.scr_anim["_zipline_gun_fl"]["burke_intro_zip_loop"][0] = %fusion_fly_in_intro_zip_zipgun_loop;
    maps\_anim::addnotetrack_customfunction( "_zipline_gun_fl", "VFX_burke_zipline_fire", maps\fusion_fx::vfx_zipgun_fire );
    level.scr_animtree["zip_debris_01"] = #animtree;
    level.scr_model["zip_debris_01"] = "fus_arch_pipe_piece_01";
    level.scr_anim["zip_debris_01"]["zip_falling_debris"] = %fusion_zip_falling_pipes_piece_01;
    level.scr_animtree["zip_debris_02"] = #animtree;
    level.scr_model["zip_debris_02"] = "fus_arch_pipe_piece_02";
    level.scr_anim["zip_debris_02"]["zip_falling_debris"] = %fusion_zip_falling_pipes_piece_02;
    level.scr_animtree["street_pipes_01"] = #animtree;
    level.scr_model["street_pipes_01"] = "fus_pipes_elec_set_01_piece_01";
    level.scr_anim["street_pipes_01"]["street_hanging_pipes"][0] = %fusion_arch_pipes_elec_set;
    level.scr_animtree["pulley_deploy"] = #animtree;
    level.scr_model["pulley_deploy"] = "vehicle_xh9_warbird_pulley";
    level.scr_anim["pulley_deploy"]["mobile_turret_deploy"] = %mobile_turret_deploy_pulley;
    level.scr_animtree["walker_deploy"] = #animtree;
    level.scr_model["walker_deploy"] = "vehicle_x4walker_wheels";
    level.scr_anim["walker_deploy"]["mobile_turret_deploy"] = %mobile_turret_deploy_mobileturret;
    maps\_anim::addnotetrack_customfunction( "walker_deploy", "vfx_mobile_turret_landing", maps\fusion_fx::mobile_turret_landing );
    level.scr_animtree["security_door_left"] = #animtree;
    level.scr_model["security_door_left"] = "genericProp";
    level.scr_anim["security_door_left"]["fusion_security_doors_open"] = %fusion_security_doors_open_left;
    level.scr_animtree["security_door_right"] = #animtree;
    level.scr_model["security_door_right"] = "genericProp";
    level.scr_anim["security_door_right"]["fusion_security_doors_open"] = %fusion_security_doors_open_right;
    level.scr_animtree["tower_debris"] = #animtree;
    level.scr_model["tower_debris"] = "fus_cooling_tower_b_vista_dmg";
    level.scr_anim["tower_debris"]["tower_debris_collision"] = %fusion_fly_in_pt2_tower_debris;
    level.scr_animtree["security_room_elevator_doors"] = #animtree;
    level.scr_anim["security_room_elevator_doors"]["security_room_open_elevator"] = %fusion_elevator_doors_opening;
    level.scr_animtree["reactor_crane"] = #animtree;
    level.scr_anim["reactor_crane"]["crane_grab"] = %fusion_bridge_crane_pickup;
    level.scr_anim["reactor_crane"]["crane_closed"] = %fusion_bridge_crane_closed_loop;
    level.scr_anim["reactor_crane"]["crane_opened"] = %fusion_bridge_crane_open_loop;
    level.scr_animtree["fusion_airlock_door"] = #animtree;
    level.scr_anim["fusion_airlock_door"]["fusion_airlock_opening"] = %fusion_airlock_opening_door;
    level.scr_animtree["deployable_cover"] = #animtree;
    level.scr_model["deployable_cover"] = "deployable_cover";
    level.scr_anim["deployable_cover"]["deployable_cover_deploy"] = %fusion_lift_deploy_cover_deployable_cover_prop_enter;
    level.scr_anim["deployable_cover"]["deployable_cover_closed_idle"] = %fusion_lift_deploy_cover_idle_closed;
    level.scr_anim["deployable_cover"]["deployable_cover_open_idle"] = %fusion_lift_deploy_cover_idle_opened;
    level.scr_animtree["fusion_door_open_postup_doors"] = #animtree;
    level.scr_anim["fusion_door_open_postup_doors"]["fusion_door_explosion"] = %fusion_door_open_postup_doors;
    level.scr_animtree["fusion_door_explosion_door_a"] = #animtree;
    level.scr_model["fusion_door_explosion_door_a"] = "door_controlroom_01_rig";
    level.scr_anim["fusion_door_explosion_door_a"]["fusion_door_explosion"] = %fusion_door_explosion_door_a;
    maps\_anim::addnotetrack_notify( "fusion_door_explosion_door_a", "doors_explode", "doors_explode", "fusion_door_explosion" );
    maps\_anim::addnotetrack_customfunction( "fusion_door_explosion_door_a", "doors_explode", ::fusion_door_explosion_swap, "fusion_door_explosion" );
    level.scr_animtree["fusion_door_explosion_door_b"] = #animtree;
    level.scr_model["fusion_door_explosion_door_b"] = "door_controlroom_01_rig";
    level.scr_anim["fusion_door_explosion_door_b"]["fusion_door_explosion"] = %fusion_door_explosion_door_a;
    level.scr_animtree["fus_cooling_tower_collapse_chunks"] = #animtree;
    level.scr_anim["fus_cooling_tower_collapse_chunks"]["fusion_collapse_ground_tower"] = %fus_cooling_tower_collapse_chunks;
    maps\_anim::addnotetrack_flag( "fus_cooling_tower_collapse_chunks", "knockback", "tower_knockback", "fusion_collapse_ground_tower" );
    maps\_anim::addnotetrack_flag( "fus_cooling_tower_collapse_chunks", "debris", "tower_debris", "fusion_collapse_ground_tower" );
    maps\_anim::addnotetrack_flag( "fus_cooling_tower_collapse_chunks", "drag_begin", "drag_begin", "fusion_collapse_ground_tower" );
    level.scr_animtree["fus_cooling_tower_collapse_concrete_shattered"] = #animtree;
    level.scr_anim["fus_cooling_tower_collapse_concrete_shattered"]["fusion_collapse_ground_tower"] = %fus_cooling_tower_collapse_concrete_shattered;
    level.scr_animtree["fus_cooling_tower_collapse_concrete_shattered2"] = #animtree;
    level.scr_anim["fus_cooling_tower_collapse_concrete_shattered2"]["fusion_collapse_ground_tower"] = %fus_cooling_tower_collapse_concrete_shattered2;
    level.scr_animtree["fus_cooling_tower_collapse_street_collapse"] = #animtree;
    level.scr_anim["fus_cooling_tower_collapse_street_collapse"]["fusion_collapse_ground_tower"] = %fus_cooling_tower_collapse_street_collapse;
    level.scr_animtree["collapse_debris_arm"] = #animtree;
    level.scr_anim["collapse_debris_arm"]["fusion_silo_collapse_finale"] = %fusion_sever_debris;
    level.scr_animtree["fus_sever_debris_02"] = #animtree;
    level.scr_model["fus_sever_debris_02"] = "fus_sever_debris_02";
    level.scr_anim["fus_sever_debris_02"]["fusion_silo_collapse_finale"] = %fusion_sever_debris_02;
    level.scr_animtree["fus_end_scene_rubble"] = #animtree;
    level.scr_anim["fus_end_scene_rubble"]["fusion_silo_collapse_finale"] = %fusion_silo_burke_debris;
    level.scr_animtree["fusion_chunk_combo"] = #animtree;
    level.scr_model["fusion_chunk_combo"] = "rubble_combo_01";
    level.scr_anim["fusion_chunk_combo"]["fusion_silo_collapse_finale"] = %fusion_chunk_combo;
    level.scr_animtree["fusion_rock_chunk01"] = #animtree;
    level.scr_model["fusion_rock_chunk01"] = "rubble_rock_chunk_01";
    level.scr_anim["fusion_rock_chunk01"]["fusion_silo_collapse_finale"] = %fusion_rock_chunk01;
    level.scr_animtree["fusion_rock_chunk02"] = #animtree;
    level.scr_model["fusion_rock_chunk02"] = "rubble_rock_chunk_01";
    level.scr_anim["fusion_rock_chunk02"]["fusion_silo_collapse_finale"] = %fusion_rock_chunk02;
    level.scr_animtree["fusion_silo_lamp01"] = #animtree;
    level.scr_model["fusion_silo_lamp01"] = "ind_streetlight_single_off_rig";
    level.scr_anim["fusion_silo_lamp01"]["fusion_collapse_ground_tower"] = %fusion_silo_lamp01;
    level.scr_animtree["fusion_silo_lamp02"] = #animtree;
    level.scr_model["fusion_silo_lamp02"] = "ind_streetlight_single_off_rig";
    level.scr_anim["fusion_silo_lamp02"]["fusion_collapse_ground_tower"] = %fusion_silo_lamp02;
    level.scr_animtree["fusion_silo_lamp03"] = #animtree;
    level.scr_model["fusion_silo_lamp03"] = "ind_streetlight_single_off_rig";
    level.scr_anim["fusion_silo_lamp03"]["fusion_collapse_ground_tower"] = %fusion_silo_lamp03;
    level.scr_animtree["fusion_silo_lamp04"] = #animtree;
    level.scr_model["fusion_silo_lamp04"] = "ind_streetlight_single_off_rig";
    level.scr_anim["fusion_silo_lamp04"]["fusion_collapse_ground_tower"] = %fusion_silo_lamp04;
    level.scr_animtree["fusion_silo_lamp05"] = #animtree;
    level.scr_model["fusion_silo_lamp05"] = "ind_streetlight_single_off_rig";
    level.scr_anim["fusion_silo_lamp05"]["fusion_collapse_ground_tower"] = %fusion_silo_lamp05;
    level.scr_animtree["fusion_silo_lamp06"] = #animtree;
    level.scr_model["fusion_silo_lamp06"] = "ind_streetlight_single_off_rig";
    level.scr_anim["fusion_silo_lamp06"]["fusion_collapse_ground_tower"] = %fusion_silo_lamp06;
    level.scr_animtree["fusion_silo_lamp07"] = #animtree;
    level.scr_model["fusion_silo_lamp07"] = "ind_streetlight_single_off_rig";
    level.scr_anim["fusion_silo_lamp07"]["fusion_collapse_ground_tower"] = %fusion_silo_lamp07;
    level.scr_animtree["fusion_silo_lamp08"] = #animtree;
    level.scr_model["fusion_silo_lamp08"] = "ind_streetlight_single_off_rig";
    level.scr_anim["fusion_silo_lamp08"]["fusion_collapse_ground_tower"] = %fusion_silo_lamp08;
    level.scr_animtree["fusion_silo_lamp09"] = #animtree;
    level.scr_model["fusion_silo_lamp09"] = "ind_streetlight_single_off_rig";
    level.scr_anim["fusion_silo_lamp09"]["fusion_collapse_ground_tower"] = %fusion_silo_lamp09;
    level.scr_animtree["fusion_silo_lamp10"] = #animtree;
    level.scr_model["fusion_silo_lamp10"] = "ind_streetlight_single_off_rig";
    level.scr_anim["fusion_silo_lamp10"]["fusion_collapse_ground_tower"] = %fusion_silo_lamp10;
    level.scr_animtree["fusion_silo_lamp11"] = #animtree;
    level.scr_model["fusion_silo_lamp11"] = "ind_streetlight_single_off_rig";
    level.scr_anim["fusion_silo_lamp11"]["fusion_collapse_ground_tower"] = %fusion_silo_lamp11;
    level.scr_animtree["fusion_silo_lamp12"] = #animtree;
    level.scr_model["fusion_silo_lamp12"] = "ind_streetlight_single_off_rig";
    level.scr_anim["fusion_silo_lamp12"]["fusion_collapse_ground_tower"] = %fusion_silo_lamp12;
    level.scr_animtree["fusion_silo_lamp13"] = #animtree;
    level.scr_model["fusion_silo_lamp13"] = "ind_streetlight_single_off_rig";
    level.scr_anim["fusion_silo_lamp13"]["fusion_collapse_ground_tower"] = %fusion_silo_lamp13;
    level.scr_animtree["fusion_silo_lamp14"] = #animtree;
    level.scr_model["fusion_silo_lamp14"] = "ind_streetlight_single_off_rig";
    level.scr_anim["fusion_silo_lamp14"]["fusion_collapse_ground_tower"] = %fusion_silo_lamp14;
    level.scr_animtree["fusion_silo_lamp15"] = #animtree;
    level.scr_model["fusion_silo_lamp15"] = "ind_streetlight_single_off_rig";
    level.scr_anim["fusion_silo_lamp15"]["fusion_collapse_ground_tower"] = %fusion_silo_lamp15;
}

swap_cockpit_model( var_0 )
{
    if ( isdefined( var_0 ) && isdefined( var_0.vehicle_to_swap ) )
        var_0.vehicle_to_swap setmodel( "vehicle_vm_x4walker_wheels" );
}

notetrack_setup_middle()
{
    level waittill( "tff_post_transition_intro_to_middle" );
    maps\_anim::addnotetrack_customfunction( "generic", "start_ragdoll", ::ai_kill_no_ragdoll, "fusion_airlock_opening" );
}

notetrack_setup_outro()
{
    level waittill( "tff_post_transition_middle_to_outro" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "drag_sand_begin", ::end_drag_dust, "fusion_silo_collapse_finale" );
    maps\_anim::addnotetrack_customfunction( "pickup_event_guy1", "dead", ::ai_kill, "fusion_reaction_pickup_event" );
}

spawn_fly_in_missile_00( var_0 )
{
    if ( isdefined( var_0.missile_org ) )
    {
        var_1 = var_0.missile_org thread maps\fusion_code::launch_missile( "missile_0" );
        soundscripts\_snd::snd_message( "intro_flight_missiles_fire" );
        wait 0.1;
        common_scripts\_exploder::exploder( 1080 );
    }
}

spawn_fly_in_missile_01( var_0 )
{
    spawn_fly_in_missile( var_0, "missile_1" );
}

spawn_fly_in_missile_02( var_0 )
{
    spawn_fly_in_missile( var_0, "missile_2" );
}

spawn_fly_in_missile_03( var_0 )
{
    spawn_fly_in_missile( var_0, "missile_3" );
}

spawn_fly_in_missile_04( var_0 )
{
    spawn_fly_in_missile( var_0, "missile_4" );
}

spawn_fly_in_missile_05( var_0 )
{
    spawn_fly_in_missile( var_0, "missile_5" );
}

spawn_fly_in_missile_06( var_0 )
{
    spawn_fly_in_missile( var_0, "missile_6" );
    level notify( "fly_in_missiles_scene_end" );
}

spawn_fly_in_missile( var_0, var_1 )
{
    if ( isdefined( var_0.missile_org ) )
    {
        var_2 = var_0.missile_org thread maps\fusion_code::launch_missile( var_1 );
        playfxontag( common_scripts\utility::getfx( "missile_launch_smoke" ), var_2, "tag_origin" );
    }
}

end_drag_dust( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "fusion_drag_dust" ), level.player_rig, "J_Ankle_LE" );
    playfxontag( common_scripts\utility::getfx( "fusion_drag_dust" ), level.player_rig, "J_Ankle_RI" );
}

fusion_door_explosion_swap( var_0 )
{
    var_0 setmodel( "door_controlroom_01_damage_rig" );
}
