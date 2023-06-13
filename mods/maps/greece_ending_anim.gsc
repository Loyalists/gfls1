// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    playerendinganimations();
    ilanaendinganimations();
    civilianendinganimations();
    enemyendinganimations();
    vehicleendinganimations();
    propsendinganimations();
}

#using_animtree("player");

playerendinganimations()
{
    level.scr_animtree["player_ending_rig"] = #animtree;
    level.scr_model["player_ending_rig"] = "s1_gfl_ump45_viewbody";
    level.scr_anim["player_ending_rig"]["ied_enter"] = %hms_greece_finale_player_ied_placement;
    maps\_anim::addnotetrack_notify( "player_ending_rig", "ilana_vo_start", "EndingAmbushGetToCover", "ied_enter" );
    maps\_anim::addnotetrack_notify( "player_ending_rig", "vehicle_start", "EndingAmbushStartConvoy", "ied_enter" );
    maps\_anim::addnotetrack_notify( "player_ending_rig", "start_slowmotion", "EndingAmbushSlowMotion", "ied_enter" );
    maps\_anim::addnotetrack_notify( "player_ending_rig", "start_success", "EndingAmbushWindowStart", "ied_enter" );
    maps\_anim::addnotetrack_notify( "player_ending_rig", "fs_ied_left", "vm_ied_footstep_left", "ied_enter" );
    maps\_anim::addnotetrack_notify( "player_ending_rig", "fs_ied_right", "vm_ied_footstep_right", "ied_enter" );
    maps\_anim::addnotetrack_customfunction( "player_ending_rig", "rumble_1", ::placeiedrumblelight, "ied_enter" );
    level.scr_anim["player_ending_rig"]["ied_success"] = %hms_greece_finale_player_ied_detonation;
    level.scr_anim["player_ending_rig"]["ied_fail"] = %hms_greece_finale_player_ied_detonation_fail;
    level.scr_anim["player_ending_rig"]["start_action"] = %hms_greece_finale_start_vm;
    maps\_anim::addnotetrack_customfunction( "player_ending_rig", "ps_mhunt_hades_suv_door_ripoff", ::bigfinaleplayerripdoor, "start_action" );
    level.scr_anim["player_ending_rig"]["fight_action"] = %hms_greece_finale_fight_vm;
    maps\_anim::addnotetrack_notify( "player_ending_rig", "hide_weapon_gun", "EndingFinaleHidePlayerGun", "fight_action" );
    maps\_anim::addnotetrack_notify( "player_ending_rig", "hit_by_veh", "EndingFinalePlayerHit", "fight_action" );
    maps\_anim::addnotetrack_customfunction( "player_ending_rig", "hit_by_veh", ::bigfinaleplayerhitbyveh, "fight_action" );
    maps\_anim::addnotetrack_customfunction( "player_ending_rig", "hit_wall", ::bigfinaleplayerhitwall, "fight_action" );
    maps\_anim::addnotetrack_notify( "player_ending_rig", "window_exo_stun_start", "EndingFinaleGrabGunWindowStart", "fight_action" );
    maps\_anim::addnotetrack_notify( "player_ending_rig", "window_exo_stun_end", "EndingFinaleGrabGunWindowEnd", "fight_action" );
    level.scr_anim["player_ending_rig"]["fight_action_reach"] = %hms_greece_finale_fight_interact_vm;
    maps\_anim::addnotetrack_notify( "player_ending_rig", "start_slomo", "EndingFinaleStabSlomoStart", "fight_action_reach" );
    maps\_anim::addnotetrack_notify( "player_ending_rig", "fail", "EndingFinaleStabSlomoEnd", "fight_action_reach" );
    level.scr_anim["player_ending_rig"]["fight_action_noreach"] = %hms_greece_finale_fight2_vm;
    maps\_anim::addnotetrack_notify( "player_ending_rig", "start_slomo", "EndingFinaleStabSlomoStart", "fight_action_noreach" );
    maps\_anim::addnotetrack_notify( "player_ending_rig", "fail", "EndingFinaleStabSlomoEnd", "fight_action_noreach" );
    level.scr_anim["player_ending_rig"]["fight_success"] = %hms_greece_finale_fight_success_vm;
    maps\_anim::addnotetrack_customfunction( "player_ending_rig", "vm_block_knife", ::bigfinaleblockknife, "fight_success" );
    maps\_anim::addnotetrack_customfunction( "player_ending_rig", "vm_punch_hades", ::bigfinalepunchhades, "fight_success" );
    maps\_anim::addnotetrack_notify( "player_ending_rig", "unhide_weapon_knife", "EndingFinalePlayerShowKnife", "fight_success" );
    maps\_anim::addnotetrack_customfunction( "player_ending_rig", "vm_block_knife", maps\greece_ending_fx::vmknifeblockfx, "fight_success" );
    level.scr_anim["player_ending_rig"]["fight_fail"] = %hms_greece_finale_fight_fail_vm;
    maps\_anim::addnotetrack_notify( "player_ending_rig", "vm_stabbed", "EndingFinaleStabbed", "fight_fail" );
    level.scr_anim["player_ending_rig"]["end_sequence"] = %hms_greece_finale_end_vm;
    maps\_anim::addnotetrack_notify( "player_ending_rig", "fade_out", "EndingFadeOut", "end_sequence" );
    level.scr_animtree["player_ending_hands"] = #animtree;
    level.scr_model["player_ending_hands"] = "s1_gfl_ump45_viewhands";
    level.scr_anim["player_ending_hands"]["grab_gun"] = %vm_equipment_exo_stun;
}

#using_animtree("generic_human");

ilanaendinganimations()
{
    level.scr_anim["Ilona"]["ilana_shoot_into_air"] = %hms_greece_finale_end_streets_civilian_ilana;
    maps\_anim::addnotetrack_notify( "Ilona", "start_flee_anims", "EndingFinaleCivsFlee", "ilana_shoot_into_air" );
    level.scr_anim["Ilona"]["start_action"] = %hms_greece_finale_start_ilana;
    level.scr_anim["Ilona"]["fight_action"] = %hms_greece_finale_fight_ilana;
    maps\_anim::addnotetrack_customfunction( "Ilona", "ilana_hit_wall", maps\greece_ending_fx::ilanahitwallfx, "fight_action" );
    maps\_anim::addnotetrack_notify( "Ilona", "ilana_punched_face", "EndingFinaleIlanaPunchFace", "fight_action" );
    maps\_anim::addnotetrack_customfunction( "Ilona", "ilana_punch_car", ::bigfinaleilanapunchcar, "fight_action" );
    maps\_anim::addnotetrack_customfunction( "Ilona", "ilana_slammed_car", ::bigfinaleilanaslamcar, "fight_action" );
    maps\_anim::addnotetrack_customfunction( "Ilona", "ilana_slammed_car", maps\greece_ending_fx::ilanahitcarfx, "fight_action" );
    maps\_anim::addnotetrack_customfunction( "Ilona", "ilana_kicked_car", ::bigfinaleilanakickcar, "fight_action" );
    maps\_anim::addnotetrack_customfunction( "Ilona", "toggle_gun_vis_r", ::bigfinaleilanagun, "fight_action" );
    level.scr_anim["Ilona"]["fight_success"] = %hms_greece_finale_fight_success_ilana;
    level.scr_anim["Ilona"]["fight_fail"] = %hms_greece_finale_fight_fail_ilana;
    maps\_anim::addnotetrack_customfunction( "Ilona", "ilana_throat_cut", maps\greece_ending_fx::ilanathroatslashfx, "fight_fail" );
    maps\_anim::addnotetrack_customfunction( "Ilona", "ilana_stabbed", maps\greece_ending_fx::ilanastabbedfx, "fight_fail" );
    maps\_anim::addnotetrack_customfunction( "Ilona", "ilana_stabbed_take_out", maps\greece_ending_fx::ilanastabbedtakeoutfx, "fight_fail" );
    level.scr_anim["Ilona"]["end_sequence"] = %hms_greece_finale_end_ilana;
}

civilianendinganimations()
{
    level.scr_anim["generic"]["EndingCiv00_idle"][0] = %hms_greece_finale_end_streets_civilian_female_idle;
    level.scr_anim["generic"]["EndingCiv00_react"] = %hms_greece_finale_end_streets_civilian_female_flee;
    level.scr_anim["generic"]["EndingCiv01_idle"][0] = %hms_greece_finale_end_streets_civilian_01_idle;
    level.scr_anim["generic"]["EndingCiv01_react"] = %hms_greece_finale_end_streets_civilian_01_flee;
    level.scr_anim["generic"]["EndingCiv02_idle"][0] = %hms_greece_finale_end_streets_civilian_02_idle;
    level.scr_anim["generic"]["EndingCiv02_react"] = %hms_greece_finale_end_streets_civilian_02_flee;
    level.scr_anim["generic"]["EndingCiv03_idle"][0] = %hms_greece_finale_end_streets_civilian_03_idle;
    level.scr_anim["generic"]["EndingCiv03_react"] = %hms_greece_finale_end_streets_civilian_03_flee;
    level.scr_anim["generic"]["EndingCiv04_idle"][0] = %hms_greece_finale_end_streets_civilian_04_idle;
    level.scr_anim["generic"]["EndingCiv04_react"] = %hms_greece_finale_end_streets_civilian_04_flee;
    level.scr_anim["generic"]["EndingCiv05_idle"][0] = %unarmed_cowerstand_idle;
    level.scr_anim["generic"]["EndingCiv05_react"] = %unarmed_cowerstand_react_2_crouch;
}

enemyendinganimations()
{
    level.scr_anim["generic"]["civilian_crawl_1"] = %civilian_crawl_1;
    level.scr_anim["generic"]["civilian_crawl_1_death_A"] = %civilian_crawl_1_death_a;
    level.scr_anim["generic"]["payback_pmc_sandstorm_stumble_1"] = %payback_pmc_sandstorm_stumble_1;
    level.scr_anim["generic"]["run_death_flop"] = %run_death_flop;
    level.scr_anim["generic"]["convoy_crash"] = %hms_greece_finale_crash_veh2_flying_npc;
    maps\_anim::addnotetrack_notify( "generic", "start_ragdoll", "EndingGlauncherGuyRagdoll", "convoy_crash" );
    level.scr_anim["generic"]["convoy_fail"] = %hms_greece_finale_crash_veh2_flying_npc_fail;
    level.scr_anim["veh1_guy_exit"]["enemy_exit"] = %hms_greece_finale_exit_hades_veh1_npc;
    level.scr_anim["veh2_guy_exit"]["enemy_exit"] = %hms_greece_finale_exit_veh2_npc;
    level.scr_anim["veh3_guy2_exit"]["enemy_exit"] = %hms_greece_finale_exit_veh3_npc2;
    level.scr_anim["generic"]["hms_greece_finale_exit_veh3_npc"] = %hms_greece_finale_exit_veh3_npc;
    level.scr_anim["generic"]["burning_corpse"] = %dcburning_elevator_corpse_idle_a;
    level.scr_anim["Hades"]["start_idle"][0] = %hms_greece_finale_start_interact_idle_hades;
    level.scr_anim["Hades"]["start_action"] = %hms_greece_finale_start_hades;
    level.scr_anim["Hades"]["fight_action"] = %hms_greece_finale_fight_hades;
    level.scr_anim["Hades"]["fight_success"] = %hms_greece_finale_fight_success_hades;
    maps\_anim::addnotetrack_notify( "Hades", "hades_punched_vm", "EndingFinaleHadesPunched", "fight_success" );
    maps\_anim::addnotetrack_notify( "Hades", "hide_weapon_knife", "EndingFinaleHadesHideKnife", "fight_success" );
    maps\_anim::addnotetrack_customfunction( "Hades", "fx_throat_slash", maps\greece_ending_fx::hadesthroatslashfx, "fight_success" );
    maps\_anim::addnotetrack_customfunction( "Hades", "fx_throat_slash", ::bigfinaleswitchhadeshead, "fight_success" );
    level.scr_anim["Hades"]["fight_fail"] = %hms_greece_finale_fight_fail_hades;
    maps\_anim::addnotetrack_customfunction( "Hades", "Hades_stab_vm", maps\greece_ending_fx::vmstabbedfacefx, "fight_fail" );
    maps\_anim::addnotetrack_customfunction( "Hades", "Hades_stab_ilana_take_out", maps\greece_ending_fx::hadesstabbedtakeoutfx, "fight_fail" );
    level.scr_anim["Hades"]["end_sequence"] = %hms_greece_finale_end_hades;
    maps\_anim::addnotetrack_notify( "Hades", "audio_hades_awakes_music", "start_hades_awake_music", "end_sequence" );
    maps\_anim::addnotetrack_customfunction( "Hades", "audio_hades_awakes_music", ::endinghadeswakesrumblelight, "end_sequence" );
    level.scr_anim["npc1"]["start_idle"] = %hms_greece_finale_npc1_dead;
    level.scr_anim["npc2"]["veh_idle"] = %hms_greece_finale_npc2_veh_idle;
    level.scr_anim["npc2"]["veh_death"] = %hms_greece_finale_npc2_veh_death;
    level.scr_anim["npc3"]["veh_idle"] = %hms_greece_finale_npc3_veh_idle;
    level.scr_anim["npc3"]["veh_death"] = %hms_greece_finale_npc3_veh_death;
}

#using_animtree("vehicles");

vehicleendinganimations()
{
    level.scr_animtree["hades_vehicle"] = #animtree;
    level.scr_anim["hades_vehicle"]["convoy_enter"] = %hms_greece_finale_crash_hades_veh1_enter;
    level.scr_anim["hades_vehicle"]["convoy_crash"] = %hms_greece_finale_crash_hades_veh1;
    level.scr_anim["hades_vehicle"]["enemy_exit"] = %hms_greece_finale_exit_hades_veh1;
    level.scr_anim["hades_vehicle"]["convoy_fail"] = %hms_greece_finale_crash_fail_hades_veh1;
    level.scr_anim["hades_vehicle"]["start_idle"][0] = %hms_greece_finale_start_interact_idle_suv1;
    level.scr_anim["hades_vehicle"]["start_action"] = %hms_greece_finale_start_suv1;
    level.scr_animtree["convoy_vehicle_2"] = #animtree;
    level.scr_anim["convoy_vehicle_2"]["convoy_enter"] = %hms_greece_finale_crash_veh2_enter;
    level.scr_anim["convoy_vehicle_2"]["convoy_crash"] = %hms_greece_finale_crash_veh2;
    level.scr_anim["convoy_vehicle_2"]["enemy_exit"] = %hms_greece_finale_exit_veh2;
    level.scr_anim["convoy_vehicle_2"]["convoy_fail"] = %hms_greece_finale_crash_fail_veh2;
    level.scr_animtree["convoy_vehicle_3"] = #animtree;
    level.scr_anim["convoy_vehicle_3"]["convoy_enter"] = %hms_greece_finale_crash_veh3_enter;
    level.scr_anim["convoy_vehicle_3"]["convoy_crash"] = %hms_greece_finale_crash_veh3;
    maps\_anim::addnotetrack_notify( "convoy_vehicle_3", "storefront_crash_veh3", "storefront_crash_veh3", "convoy_crash" );
    maps\_anim::addnotetrack_notify( "convoy_vehicle_3", "Planter_crash_veh3", "Planter_crash_veh3", "convoy_crash" );
    level.scr_anim["convoy_vehicle_3"]["enemy_exit"] = %hms_greece_finale_exit_veh3;
    level.scr_anim["convoy_vehicle_3"]["convoy_fail"] = %hms_greece_finale_crash_fail_veh3;
    level.scr_animtree["convoy_vehicle_4"] = #animtree;
    level.scr_anim["convoy_vehicle_4"]["convoy_enter"] = %hms_greece_finale_crash_veh4;
    level.scr_anim["convoy_vehicle_4"]["convoy_fail"] = %hms_greece_finale_crash_fail_veh4;
    level.scr_animtree["enemy_vehicle"] = #animtree;
    level.scr_anim["enemy_vehicle"]["start_action"] = %hms_greece_finale_start_suv2;
    maps\_anim::addnotetrack_notify( "enemy_vehicle", "veh_crash_gate", "EndingFinaleVehCrashGate", "start_action" );
    maps\_anim::addnotetrack_notify( "enemy_vehicle", "start_slomo", "EndingFinaleShootSlomoStart", "start_action" );
    maps\_anim::addnotetrack_notify( "enemy_vehicle", "end_slomo", "EndingFinaleShootSlomoEnd", "start_action" );
    level.scr_anim["enemy_vehicle"]["fight_action"] = %hms_greece_finale_fight_suv2;
    maps\_anim::addnotetrack_notify( "enemy_vehicle", "veh_damage1", "show_damage1", "fight_action" );
    maps\_anim::addnotetrack_notify( "enemy_vehicle", "veh_damage2", "show_damage2", "fight_action" );
    maps\_anim::addnotetrack_notify( "enemy_vehicle", "veh_damage3", "show_damage3", "fight_action" );
    level.scr_anim["enemy_vehicle"]["fight_success"] = %hms_greece_finale_fight_success_suv2;
    level.scr_anim["enemy_vehicle"]["fight_fail"] = %hms_greece_finale_fight_fail_suv2;
    level.scr_anim["enemy_vehicle"]["end_sequence"] = %hms_greece_finale_end_suv2;
}

#using_animtree("animated_props");

propsendinganimations()
{
    level.scr_animtree["ied_device"] = #animtree;
    level.scr_model["ied_device"] = "breach_charge";
    level.scr_anim["ied_device"]["ied_enter"] = %hms_greece_finale_player_ied_detonatordevice;
    level.scr_anim["ied_device"]["ied_success"] = %hms_greece_finale_player_ied_detonatordevice_end;
    level.scr_anim["ied_device"]["ied_fail"] = %hms_greece_finale_player_ied_detonatordevice_end_fail;
    level.scr_animtree["finale_barrier"] = #animtree;
    level.scr_model["finale_barrier"] = "greece_finale_barrier";
    level.scr_anim["finale_barrier"]["start_action"] = %hms_greece_finale_barrier;
    level.scr_animtree["finale_data"] = #animtree;
    level.scr_model["finale_data"] = "datachit_greece";
    level.scr_anim["finale_data"]["end_sequence"] = %hms_greece_finale_end_data;
}

bigfinaleplayerhitbyveh( var_0 )
{
    earthquake( 0.5, 0.5, level.player.origin, 128 );
    level.player playrumbleonentity( "artillery_rumble" );
}

bigfinaleplayerhitwall( var_0 )
{
    earthquake( 0.5, 0.5, level.player.origin, 128 );
    level.player playrumbleonentity( "grenade_rumble" );
    thread maps\greece_ending::endingfinalebloodsplat( 20, 0.05, 5, 1 );
    soundscripts\_snd::snd_message( "start_finale_h2h_music" );
}

bigfinaleblockknife( var_0 )
{
    earthquake( 0.25, 0.25, level.player.origin, 128 );
    level.player playrumbleonentity( "damage_heavy" );
}

bigfinalepunchhades( var_0 )
{
    earthquake( 0.1, 0.1, level.player.origin, 128 );
    level.player playrumbleonentity( "damage_light" );
}

bigfinaleilanapunchcar( var_0 )
{
    earthquake( 0.1, 0.1, level.player.origin, 128 );
    level.player playrumbleonentity( "damage_light" );
}

bigfinaleilanaslamcar( var_0 )
{
    earthquake( 0.1, 0.1, level.player.origin, 128 );
    level.player playrumbleonentity( "damage_light" );
}

bigfinaleilanakickcar( var_0 )
{
    earthquake( 0.1, 0.1, level.player.origin, 128 );
    level.player playrumbleonentity( "damage_light" );
}

bigfinaleilanagun( var_0 )
{
    level.allies["Ilona"] maps\_utility::gun_remove();
    var_1 = spawn( "script_model", level.allies["Ilona"].origin );
    var_1 setmodel( "npc_bal27_nocamo" );
    var_2 = level.allies["Ilona"] gettagorigin( "tag_weapon_right" );
    var_3 = level.allies["Ilona"] gettagangles( "tag_weapon_right" );
    var_1.origin = var_2;
    var_1.angles = var_3;
}

bigfinaleswitchhadeshead( var_0 )
{
    // var_1 = "kva_leader_head_cut_throat";
    // var_0 thread codescripts\character::setheadmodel( var_1 );
    earthquake( 0.25, 0.25, level.player.origin, 128 );
    level.player playrumbleonentity( "damage_light" );
}

bigfinaleplayerripdoor( var_0 )
{
    wait 0.7;
    earthquake( 0.25, 0.25, level.player.origin, 128 );
    level.player playrumbleonentity( "damage_light" );
}

placeiedrumblelight( var_0 )
{
    earthquake( 0.1, 0.1, level.player.origin, 128 );
    level.player playrumbleonentity( "damage_light" );
}

endinghadeswakesrumblelight( var_0 )
{
    wait 0.25;
    earthquake( 0.25, 0.25, level.player.origin, 128 );
    level.player playrumbleonentity( "damage_heavy" );
}
