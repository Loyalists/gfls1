// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level.transient_zone = "";

    if ( level.currentgen )
    {
        if ( istransientloaded( "sanfran_b_intro_tr" ) )
            level.transient_zone = "intro";
        else if ( istransientloaded( "sanfran_b_outro_tr" ) )
            level.transient_zone = "outro";
    }

    if ( level.nextgen )
        anim.forced_s1_motionset = 1;

    thread load_player_anims();
    thread load_actor_anims();
    thread load_vehicle_anims();
    thread load_script_model_anims();
}

#using_animtree("player");

load_player_anims()
{
    level.scr_animtree["player_rig"] = #animtree;
    level.scr_model["player_rig"] = "s1_gfl_ump45_viewbody";
    level.scr_animtree["player_arms"] = #animtree;
    level.scr_model["player_arms"] = "s1_gfl_ump45_viewhands_player";
    level.scr_anim["player_arms"]["intro"] = %sanfran_b_intro_vm;

    if ( level.nextgen || level.transient_zone == "intro" )
    {
        maps\_anim::addnotetrack_customfunction( "player_arms", "vm_gun_up", ::intro_enable_weapons, "intro" );
        maps\_anim::addnotetrack_customfunction( "player_arms", "vm_anim_end", ::intro_end_anim, "intro" );
        maps\_anim::addnotetrack_customfunction( "player_arms", "shake_cam", ::intro_shake_cam, "intro" );
    }

    level.scr_anim["player_arms"]["jammerplant_1"] = %sf_b_jammerplant_1_vm;
    level.scr_anim["player_arms"]["jammerplant_2"] = %sf_b_jammerplant_2_vm;
    level.scr_anim["player_rig"]["sf_b_bridge_dialog"] = %sf_b_bridge_dialog_vm;
    maps\_anim::addnotetrack_customfunction( "player_rig", "fade_out", ::end_level, "sf_b_bridge_dialog" );
}

#using_animtree("generic_human");

load_actor_anims()
{
    level.scr_anim["burke"]["intro"] = %sanfran_b_intro_burke;
    level.scr_anim["cormack"]["intro"] = %sanfran_b_intro_cormack;
    level.scr_anim["maddox"]["intro"] = %sanfran_b_intro_maddox;

    if ( level.nextgen || level.transient_zone == "intro" )
    {
        maps\_anim::addnotetrack_customfunction( "burke", "boost_begin", maps\sanfran_b_fx::vfx_start_boost_fx );
        maps\_anim::addnotetrack_customfunction( "burke", "boost_end", maps\sanfran_b_fx::vfx_stop_boost_fx );
        maps\_anim::addnotetrack_customfunction( "cormack", "boost_begin", maps\sanfran_b_fx::vfx_start_boost_fx );
        maps\_anim::addnotetrack_customfunction( "cormack", "boost_end", maps\sanfran_b_fx::vfx_stop_boost_fx );
        maps\_anim::addnotetrack_customfunction( "maddox", "boost_begin", maps\sanfran_b_fx::vfx_start_boost_fx );
        maps\_anim::addnotetrack_customfunction( "maddox", "boost_end", maps\sanfran_b_fx::vfx_stop_boost_fx );
    }

    level.scr_anim["guy1"]["deck_mobile_cover"] = %fusion_mobile_cover_fire_guy1;
    level.scr_anim["guy2"]["deck_mobile_cover"] = %fusion_mobile_cover_fire_guy2;
    level.scr_anim["cormack"]["boosters_off_wait_idle"][0] = %sf_b_boost_off_guy2_wait_idle;
    level.scr_anim["burke"]["boosters_off_wait_idle"][0] = %sf_b_boost_off_guy1_wait_idle;
    level.scr_anim["maddox"]["boosters_off_wait_idle"][0] = %sf_b_boost_off_guy3_wait_idle;
    level.scr_anim["cormack"]["boosters_off"] = %sf_b_boost_off_guy2;
    level.scr_anim["maddox"]["boosters_off"] = %sf_b_boost_off_guy3;
    level.scr_anim["burke"]["boosters_off"] = %sf_b_boost_off_guy1;
    level.scr_anim["cormack"]["boosters_off_idle"][0] = %sf_b_boost_off_guy2_idle;
    level.scr_anim["burke"]["boosters_off_idle"][0] = %sf_b_boost_off_crouch_idle_guy1;
    level.scr_anim["maddox"]["boosters_off_idle"][0] = %sf_b_boost_off_crouch_idle_guy3;
    level.scr_anim["cormack"]["ripopen_bulkhead"] = %sf_b_boost_off_ripopen_guy2;
    level.scr_anim["generic"]["ny_harbor_doorway_headsmash_enemy_deadpose"][0] = %ny_harbor_doorway_headsmash_enemy_deadpose;
    level.scr_anim["generic"]["ch_castle_14_5_guard8_deadloop"][0] = %ch_castle_14_5_guard8_deadloop;
    level.scr_anim["generic"]["arcadia_ending_sceneA_dead_civilian"][0] = %arcadia_ending_scenea_dead_civilian;
    level.scr_anim["generic"]["corner_standR_deathA"] = %corner_standr_deatha;
    level.scr_anim["generic"]["prone_death_quickdeath"] = %prone_death_quickdeath;
    level.scr_anim["generic"]["death_shotgun_back_v1"] = %death_shotgun_back_v1;
    level.scr_anim["generic"]["covercrouch_death_1"] = %covercrouch_death_1;
    level.scr_anim["cormack"]["exo_takedown"] = %sanfran_b_exo_takedown_guy1;
    level.scr_anim["guy2"]["exo_takedown"] = %sanfran_b_exo_takedown_guy2;
    maps\_anim::addnotetrack_customfunction( "guy2", "exo_takedown_death", ::exo_takedown_death, "exo_takedown" );
    level.scr_anim["burke"]["signal_moveout_coverL"] = %corner_standl_signal_move;
    level.scr_anim["maddox"]["signal_moveout_coverL"] = %corner_standl_signal_move;
    level.scr_anim["cormack"]["signal_moveout_coverL"] = %corner_standl_signal_move;
    level.scr_anim["burke"]["hangar_exit"] = %sf_b_bulkhead_door_pullopen_guy;
    level.scr_anim["guy"]["table_pulldown"] = %sf_b_pulltable_slideover_guy;
    level.scr_anim["guy"]["table_pulldown_fire_loop"][0] = %sf_b_pulltable_fire_loop_guy;
    level.scr_anim["guy"]["table_pullddown_death"] = %sf_b_pulltable_death_guy;
    level.scr_anim["cormack"]["door_takedown"] = %sf_b_bulkhead_pullopen_takedown_guy1;
    level.scr_anim["guy"]["door_takedown"] = %sf_b_bulkhead_pullopen_takedown_guy2;
    level.scr_anim["guy"]["door_ambush"] = %sf_b_bulkhead_pullopen_takedown_2_guy2;
    level.scr_anim["guy"]["guy_control_idle"][0] = %sf_b_pullbody_control_idle_guy1;
    level.scr_anim["guy"]["guy_control_react"] = %sf_b_pullbody_react_guy1;
    level.scr_anim["guy"]["guy_control_to_fire"] = %sf_b_pullbody_control2fire_guy1;
    level.scr_anim["guy"]["guy_control_shot_idle"][0] = %sf_b_pullbody_shot_idle_guy1;
    level.scr_anim["guy"]["control_room_pulloff"] = %sf_b_pullbody_pull_guy1;
    level.scr_anim["cormack"]["control_room_pulloff"] = %sf_b_pullbody_pull_guy2;
    level.scr_anim["guy"]["guy_control_dead_idle"][0] = %sf_b_pullbody_dead_guy1;
    level.scr_anim["cormack"]["console_idle"][0] = %sf_b_bridge_dialog_loop_guy1;
    level.scr_anim["cormack"]["sf_b_bridge_dialog"] = %sf_b_bridge_dialog_guy1;
    level.scr_anim["maddox"]["sf_b_bridge_dialog"] = %sf_b_bridge_dialog_guy2;
    level.scr_anim["burke"]["sf_b_bridge_dialog"] = %sf_b_bridge_dialog_guy3;
}

#using_animtree("vehicles");

load_vehicle_anims()
{
    level.scr_anim["littlebird"]["intro"] = %sanfran_b_intro_littlebird;
    level.scr_anim["shrike_1"]["shrike_takeoff"] = %sf_b_shrike_takeoff1;
    level.scr_anim["shrike_2"]["shrike_takeoff"] = %sf_b_shrike_takeoff2;
    level.scr_animtree["mobile_cover"] = #animtree;
    level.scr_anim["mobile_cover"]["deck_mobile_cover"] = %fusion_mobile_cover;
    level.scr_anim["shrike"]["shrike_slide"] = %sf_b_shrike_slide;
    maps\_anim::addnotetrack_customfunction( "shrike", "shrike_contact", ::shrike_contact, "shrike_slide" );
}

#using_animtree("script_model");

load_script_model_anims()
{
    level.scr_animtree["bridge_part_a"] = #animtree;
    level.scr_model["bridge_part_a"] = "ggb_collapse_03_chunka";
    level.scr_anim["bridge_part_a"]["bridge_parts_idle"][0] = %sf_goldengate_collapse_chunk_a_idle;
    level.scr_animtree["bridge_part_b"] = #animtree;
    level.scr_model["bridge_part_b"] = "ggb_collapse_03_chunkb";
    level.scr_anim["bridge_part_b"]["bridge_parts_idle"][0] = %sf_goldengate_collapse_chunk_b_idle;
    level.scr_animtree["bridge_part_c"] = #animtree;
    level.scr_model["bridge_part_c"] = "ggb_collapse_03_chunkc";
    level.scr_anim["bridge_part_c"]["bridge_parts_idle"][0] = %sf_goldengate_collapse_chunk_c_idle;
    level.scr_animtree["bridge_part_d"] = #animtree;
    level.scr_model["bridge_part_d"] = "ggb_collapse_03_chunkd";
    level.scr_anim["bridge_part_d"]["bridge_parts_idle"][0] = %sf_goldengate_collapse_chunk_d_idle;
    level.scr_animtree["domestic_mini"] = #animtree;
    level.scr_model["domestic_mini"] = "civ_domestic_mini_dstrypv";
    level.scr_anim["domestic_mini"]["intro"] = %sf_b_intro_domestic_mini;
    level.scr_animtree["pickup_truck"] = #animtree;
    level.scr_model["pickup_truck"] = "vehicle_civ_pickup_truck_01_wrecked";
    level.scr_anim["pickup_truck"]["intro"] = %sf_b_intro_pickup_truck;
    level.scr_animtree["jammer"] = #animtree;
    level.scr_model["jammer"] = "vm_jamming_device";
    level.scr_anim["jammer"]["jammerplant_1"] = %sf_b_jammerplant_1_jammer;
    level.scr_anim["jammer"]["jammerplant_2"] = %sf_b_jammerplant_2_jammer;
    level.scr_animtree["interior_bulkhead"] = #animtree;
    level.scr_model["interior_bulkhead"] = "mob_door_interior_rigged";
    level.scr_anim["interior_bulkhead"]["ripopen_bulkhead"] = %sf_b_boost_off_ripopen_bulkhead;
    level.scr_animtree["hangar_exit_door"] = #animtree;
    level.scr_model["hangar_exit_door"] = "mob_door_interior_rigged";
    level.scr_anim["hangar_exit_door"]["hangar_exit"] = %sf_b_bulkhead_door_pullopen_door;
    level.scr_animtree["cafeteria_table"] = #animtree;
    level.scr_model["cafeteria_table"] = "mob_mess_hall_table_broken";
    level.scr_anim["cafeteria_table"]["table_pulldown"] = %sf_b_pulltable_slideover_table;
    level.scr_animtree["navy_wave_door"] = #animtree;
    level.scr_model["navy_wave_door"] = "mob_door_interior_rigged";
    level.scr_animtree["takedown_door"] = #animtree;
    level.scr_model["takedown_door"] = "mob_door_interior_mirrored";
    level.scr_anim["takedown_door"]["door_takedown"] = %sf_b_bulkhead_pullopen_takedown_door;
    level.scr_anim["takedown_door"]["door_ambush"] = %sf_b_bulkhead_pullopen_takedown_2_door;
    level.scr_animtree["mob_turret"] = #animtree;
    level.scr_anim["mob_turret"]["mob_turret_transform"] = %sf_b_mob_turret_transform;
    level.scr_anim["cargo_ship_1"]["cargo_ship_hit_react"] = %sf_b_cargo_ship_hit_react_1;
    level.scr_anim["cargo_ship_1"]["cargo_ship_idle_large"][0] = %sf_b_cargo_ship_idle_large;
    level.scr_anim["cargo_ship_2"]["cargo_ship_hit_react"] = %sf_b_cargo_ship_hit_react_2;
    level.scr_anim["cargo_ship_2"]["cargo_ship_idle_large"][0] = %sf_b_cargo_ship_idle_large;
}

intro_shake_cam( var_0 )
{
    earthquake( 0.3, 1, level.player.origin, 128 );
    level notify( "intro_scene_artillery_rumble" );
}

intro_enable_weapons( var_0 )
{
    level.player enableweapons();
}

intro_end_anim( var_0 )
{
    common_scripts\utility::flag_set( "intro_anim_finished" );
}

exo_takedown_death( var_0 )
{
    var_0 maps\sanfran_b_util::kill_no_react();
    level.cormack maps\_utility::enable_ai_color_dontmove();
    maps\_utility::activate_trigger_with_targetname( "trig_post_exo_takedown_move" );
}

shrike_contact( var_0 )
{
    var_1 = common_scripts\utility::getstruct( "org_shrike_contact", "targetname" );
    physicsexplosionsphere( var_1.origin, 512, 256, 1.5 );
}

end_level( var_0 )
{
    if ( isdefined( level.already_got_end_level_notetrack ) )
        return;
    else
        level.already_got_end_level_notetrack = 1;

    maps\_hud_util::fade_out( 2, "black" );
    maps\_utility::nextmission();
}
