// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    precachefx();
    maps\createfx\detroit_fx::main();

    if ( !isdefined( level.createfxent ) )
        level.createfxent = [];

    set_lighting_values();
    maps\_shg_fx::setup_shg_fx();
    common_scripts\utility::flag_init( "vfx_rain_splat_on_lens_intro" );
    common_scripts\utility::flag_init( "vfx_garage_under_entrance" );
    common_scripts\utility::flag_init( "vfx_exit_garage_door" );
    common_scripts\utility::flag_init( "vfx_giant_gate" );
    common_scripts\utility::flag_init( "vfx_before_giant_gate" );
    common_scripts\utility::flag_init( "vfx_front_school_sneak_approach" );
    common_scripts\utility::flag_init( "vfx_front_school_sneak_approach_2" );
    common_scripts\utility::flag_init( "vfx_school_main_entrance" );
    common_scripts\utility::flag_init( "vfx_school_hallway_1_enter" );
    common_scripts\utility::flag_init( "vfx_school_hallway_1_crater_lookat" );
    common_scripts\utility::flag_init( "vfx_school_room_1_enter" );
    common_scripts\utility::flag_init( "vfx_school_room_1b_exit" );
    common_scripts\utility::flag_init( "vfx_school_stairs_2_floor" );
    common_scripts\utility::flag_init( "vfx_school_hallway_3_enter" );
    common_scripts\utility::flag_init( "vfx_school_basement_fall_floor" );
    common_scripts\utility::flag_init( "vfx_school_basement_hallway_enter" );
    common_scripts\utility::flag_init( "vfx_school_hallway_2_enter_lookat" );
    common_scripts\utility::flag_init( "vfx_school_hallway_2_bench_lookat" );
    common_scripts\utility::flag_init( "vfx_school_hallway_2b_enter" );
    common_scripts\utility::flag_init( "vfx_school_hallway_2c_enter" );
    common_scripts\utility::flag_init( "vfx_school_basement_splash" );
    common_scripts\utility::flag_init( "level_intro_cinematic_complete" );
    common_scripts\utility::flag_init( "vfx_vehicle_wall_sparks" );
    common_scripts\utility::flag_init( "flag_water_crash_1" );
    common_scripts\utility::flag_init( "flag_water_crash_2" );
    thread maps\_shg_fx::fx_zone_watcher( 1000, "msg_vfx_zone1000_intro_ext" );
    thread maps\_shg_fx::fx_zone_watcher( 1010, "msg_vfx_zone1010_intro_ext" );
    thread maps\_shg_fx::fx_zone_watcher( 1500, "msg_vfx_zone1500_intro_ext" );
    thread maps\_shg_fx::fx_zone_watcher( 1510, "msg_vfx_zone1510_intro_ext" );
    thread maps\_shg_fx::fx_zone_watcher( 2000, "msg_vfx_zone2000_jetski" );
    thread maps\_shg_fx::fx_zone_watcher( 2500, "msg_vfx_zone2500_jetski" );
    thread maps\_shg_fx::fx_zone_watcher( 3000, "msg_vfx_zonrage" );
    thread maps\_shg_fx::fx_zone_watcher( 4000, "msg_vfx_zone4000_split_sneaky", "msg_vfx_zone4010_split_sneaky" );
    thread maps\_shg_fx::fx_zone_watcher( 5000, "msg_vfx_zone5000_school_fall_int" );
    thread maps\_shg_fx::fx_zone_watcher( 5100, "msg_vfx_zone5100_school_1st_floor" );
    thread maps\_shg_fx::fx_zone_watcher( 5200, "msg_vfx_zone5200_school_2nd_floor" );
    thread maps\_shg_fx::fx_zone_watcher( 5300, "msg_vfx_zone5300_school_3rd_floor" );
    thread maps\_shg_fx::fx_zone_watcher( 5400, "msg_vfx_zone5400_school_basement" );
    thread maps\_shg_fx::fx_zone_watcher( 6000, "msg_vfx_zone6000_street_fight1", "msg_vfx_zone6000_street_fight2" );
    thread maps\_shg_fx::fx_zone_watcher( 7000, "msg_vfx_zone7000_office" );
    thread maps\_shg_fx::fx_zone_watcher( 8000, "msg_vfx_zone8000_exocourtyard", "msg_vfx_zone8001_exocourtyard" );
    thread maps\_shg_fx::fx_zone_watcher( 8500, "msg_vfx_zone8500_exopush", "msg_vfx_zone8600_hospitaltransition" );
    thread maps\_shg_fx::fx_zone_watcher( 9000, "msg_vfx_zone9000_hospital" );
    thread maps\_shg_fx::fx_zone_watcher( 9200, "msg_vfx_zone9200_hospital", "msg_vfx_zone9201_hospital" );
    thread maps\_shg_fx::fx_zone_watcher( 9500, "msg_vfx_zone9500_hospital_exit" );
    thread maps\_shg_fx::fx_zone_watcher( 10000, "msg_vfx_zone10000_reveal" );
    thread maps\_shg_fx::fx_zone_watcher( 11000, "msg_vfx_zone11000_exitdrive_start" );
    thread maps\_shg_fx::fx_zone_watcher( 12000, "msg_vfx_zone12000_exitdrive_tireshop" );
    thread maps\_shg_fx::fx_zone_watcher( 13000, "msg_vfx_zone13000_exitdrive_park", "msg_vfx_zone13500_exitdrive_building" );
    thread maps\_shg_fx::fx_zone_watcher( 14000, "msg_vfx_zone14000_exitdrive_tracks", "msg_vfx_zone14001_exitdrive_tracks" );
    thread maps\_shg_fx::fx_zone_watcher( 15000, "msg_vfx_zone15000_exitdrive_street_a" );
    thread maps\_shg_fx::fx_zone_watcher( 16000, "msg_vfx_zone16000_exitdrive_street_b" );
    thread maps\_shg_fx::fx_zone_watcher( 125, "msg_vfx_zone_splatonlens_01", "msg_vfx_zone_splatonlens_02" );
    thread maps\_shg_fx::fx_zone_watcher( 130, "msg_vfx_zone_splatonlens_03", "msg_vfx_zone_splatonlens_04" );
    thread treadfx_override();
    thread hoverbike_smk_push_garage();
    thread rain_attach_player_drizzle();
    thread rain_attach_player_medium();
    thread rain_attach_player_heavy_speedy();
    thread rain_attach_player_heavy();
    thread det_water_crash_jeep_1();
    thread det_water_crash_jeep_2();
    thread exitdrive_buttress();
    thread smoke_clear_basement_bones();
}

set_lighting_values()
{
    if ( isusinghdr() )
    {
        setsaveddvar( "r_tonemap", 2 );

        if ( level.nextgen )
            setsaveddvar( "fx_cast_shadow", 0 );
    }
}

precachefx()
{
    level._effect["point_amber"] = loadfx( "vfx/lights/light_point_amber" );
    level._effect["point_amber_dim"] = loadfx( "vfx/lights/light_point_amber_dim" );
    level._effect["point_blue"] = loadfx( "vfx/lights/detroit/light_point_blue_med2" );
    level._effect["point_white_med"] = loadfx( "vfx/lights/detroit/light_point_white_med" );
    level._effect["point_blue_med"] = loadfx( "vfx/lights/detroit/light_point_blue_med" );
    level._effect["player_light"] = loadfx( "vfx/lights/detroit/flashlight_spotlight_player" );
    level._effect["player_light2"] = loadfx( "vfx/lights/detroit/flashlight_spotlight_player2" );
    level._effect["player_light_bright"] = loadfx( "vfx/lights/detroit/flashlight_spotlight_player_bright" );
    level._effect["player_light_med"] = loadfx( "vfx/lights/detroit/flashlight_spotlight_player_med" );
    level._effect["player_light_light"] = loadfx( "vfx/lights/detroit/flashlight_spotlight_player_light" );
    level._effect["player_light_med2"] = loadfx( "vfx/lights/detroit/flashlight_spotlight_player_med2" );
    level._effect["flashlight0"] = loadfx( "vfx/lights/detroit/flashlight_subtle_ng" );
    level._effect["flashlight_enemy"] = loadfx( "vfx/lights/detroit/det_enemy_flashlight" );
    level._effect["caution_light_01"] = loadfx( "fx/lights/warning_light_rotating" );
    level._effect["det_debris_falling"] = loadfx( "vfx/map/detroit/det_debris_falling" );
    level._effect["flesh_hit"] = loadfx( "vfx/weaponimpact/flesh_impact_body_fatal_exit" );
    level._effect["leaves_blowing"] = loadfx( "vfx/wind/leaves_blowing" );
    level._effect["trash_blowing"] = loadfx( "vfx/wind/trash_blowing" );
    level._effect["fog_low_lying_dlight"] = loadfx( "vfx/fog/fog_low_lying_dlight" );
    level._effect["fog_wispy_sheeting"] = loadfx( "vfx/map/detroit/fog_wispy_sheeting" );
    level._effect["fog_ambient_night_nonlit"] = loadfx( "vfx/fog/fog_ambient_night_nonlit" );
    level._effect["det_fog_ground_dense_mid_nonlit"] = loadfx( "vfx/map/detroit/det_fog_ground_dense_mid_nonlit" );
    level._effect["fog_ground_night"] = loadfx( "vfx/lights/detroit/det_fog_ground_night" );
    level._effect["dust_ground_slow"] = loadfx( "vfx/map/detroit/dust_ground_slow" );
    level._effect["footstep_water"] = loadfx( "vfx/treadfx/footstep_water" );
    level._effect["cloak_scare_papers"] = loadfx( "vfx/props/cloak_scare_papers" );
    level._effect["falling_dust_subtle"] = loadfx( "vfx/dust/falling_dust_subtle" );
    level._effect["fog_rising_patch_low"] = loadfx( "vfx/map/detroit/det_fog_rising_patch_low" );
    level._effect["spider_web_mesh"] = loadfx( "vfx/unique/spider_web_mesh" );
    level._effect["floating_trash_runner_lp"] = loadfx( "vfx/water/floating_trash_runner_lp" );
    level._effect["floating_foam_runner_lp"] = loadfx( "vfx/water/floating_foam_runner_lp" );
    level._effect["floating_foam_slow_runner_lp"] = loadfx( "vfx/water/floating_foam_slow_runner_lp" );
    level._effect["floating_bottles_runner_lp"] = loadfx( "vfx/water/floating_bottles_runner_lp" );
    level._effect["smoke_white_slow"] = loadfx( "vfx/smoke/smoke_white_slow" );
    level._effect["floating_trash_barrel_foam_runner"] = loadfx( "vfx/water/floating_trash_barrel_foam_runner" );
    level._effect["floating_trash_pallet_foam_runner"] = loadfx( "vfx/water/floating_trash_pallet_foam_runner" );
    level._effect["water_splash_wall_sm"] = loadfx( "vfx/water/water_splash_wall_sm" );
    level._effect["det_gate_open_smk_clear"] = loadfx( "vfx/map/detroit/det_gate_open_smk_clear" );
    level._effect["falling_dust_subtle01"] = loadfx( "vfx/dust/falling_dust_subtle01" );
    level._effect["dripping_ledges_heavy_splash"] = loadfx( "vfx/rain/dripping_ledges_heavy_splash" );
    level._effect["rain_splash_sm_25x25_infrequent_lp"] = loadfx( "vfx/rain/rain_splash_sm_25x25_infrequent_lp" );
    level._effect["leaves_blowing01"] = loadfx( "vfx/wind/leaves_blowing01" );
    level._effect["dripping_ledges_heavy"] = loadfx( "vfx/rain/dripping_ledges_heavy" );
    level._effect["dripping_ledges_heavy_short"] = loadfx( "vfx/rain/dripping_ledges_heavy_short" );
    level._effect["dripping_ledges_heavy_splash_short"] = loadfx( "vfx/rain/dripping_ledges_heavy_splash_short" );
    level._effect["det_track_water_splash"] = loadfx( "vfx/map/detroit/det_track_water_splash" );
    level._effect["rain_attach_player_drizzle"] = loadfx( "vfx/rain/rain_attach_player_drizzle" );
    level._effect["rain_attach_player_steady"] = loadfx( "vfx/rain/rain_attach_player_steady" );
    level._effect["rain_attach_player_hvy"] = loadfx( "vfx/rain/rain_attach_player_hvy" );
    level._effect["rain_attach_player_hvy_speedy"] = loadfx( "vfx/rain/rain_attach_player_hvy_speedy" );
    level._effect["rain_hvy_windy_01"] = loadfx( "vfx/rain/rain_hvy_windy_01" );
    level._effect["rain_hvy_windy_02"] = loadfx( "vfx/rain/rain_hvy_windy_02" );
    level._effect["rain_hvy_windy_window_view_nonlit"] = loadfx( "vfx/rain/rain_hvy_windy_window_view_nonlit" );
    level._effect["rain_hvy_ceiling_hole_nonlit"] = loadfx( "vfx/rain/rain_hvy_ceiling_hole_nonlit" );
    level._effect["water_drips_med"] = loadfx( "vfx/rain/water_drips_med" );
    level._effect["raindrop_rings_area"] = loadfx( "vfx/rain/raindrop_rings_area" );
    level._effect["water_drips_fat_splash"] = loadfx( "vfx/rain/water_drips_fat_splash" );
    level._effect["dripping_ledges_med"] = loadfx( "vfx/rain/dripping_ledges_med" );
    level._effect["dripping_ledges_lrg"] = loadfx( "vfx/rain/dripping_ledges_lrg" );
    level._effect["water_curtain_01"] = loadfx( "vfx/rain/water_curtain_01" );
    level._effect["water_stream_sml"] = loadfx( "vfx/rain/water_stream_sml" );
    level._effect["water_stream_med"] = loadfx( "vfx/rain/water_stream_med" );
    level._effect["water_stream_lrg"] = loadfx( "vfx/rain/water_stream_lrg" );
    level._effect["dripping_ceiling_hole"] = loadfx( "vfx/rain/dripping_ceiling_hole" );
    level._effect["dripping_ceiling_hole_2"] = loadfx( "vfx/rain/dripping_ceiling_hole_2" );
    level._effect["rain_splash_hvy_400x400_lp_runner"] = loadfx( "vfx/rain/rain_splash_hvy_400x400_lp_runner" );
    level._effect["rain_splat_on_lens_sml_rnr_night"] = loadfx( "vfx/rain/rain_splat_on_lens_sml_rnr_night" );
    level._effect["rain_splat_on_lens_med_rnr_night"] = loadfx( "vfx/rain/rain_splat_on_lens_med_rnr_night" );
    level._effect["rain_splat_on_lens_hvy_rnr_night"] = loadfx( "vfx/rain/rain_splat_on_lens_hvy_rnr_night" );
    level._effect["raindrop_rings_area_sm"] = loadfx( "vfx/rain/raindrop_rings_area_sm" );
    level._effect["raindrop_rings_area_med"] = loadfx( "vfx/rain/raindrop_rings_area_med" );
    level._effect["intro_point_rim"] = loadfx( "vfx/lights/detroit/intro_point_rim" );
    level._effect["godray_sm"] = loadfx( "vfx/lights/detroit/det_godray_sm" );
    level._effect["godray_sm_grp"] = loadfx( "vfx/lights/detroit/det_godray_sm_grp" );
    level._effect["godray_med_grp"] = loadfx( "vfx/lights/detroit/det_godray_med_grp" );
    level._effect["godray_med_tracks"] = loadfx( "vfx/lights/detroit/det_godray_med_tracks" );
    level._effect["godray_dancefloor"] = loadfx( "vfx/lights/detroit/det_godray_dancefloor" );
    level._effect["godray_dancefloor2"] = loadfx( "vfx/lights/detroit/det_godray_dancefloor2" );
    level._effect["fluorescent_smoke_dim"] = loadfx( "vfx/lights/detroit/det_fluorescent_smoke_dim" );
    level._effect["fluorescent_smoke_dim_sm"] = loadfx( "vfx/lights/detroit/det_fluorescent_smoke_dim_sm" );
    level._effect["light_white_radiosity_sim"] = loadfx( "vfx/lights/light_white_radiosity_sim" );
    level._effect["light_white_radiosity_sim_dim"] = loadfx( "vfx/lights/light_white_radiosity_sim_dim" );
    level._effect["light_white_radiosity_sim_dim_sm"] = loadfx( "vfx/lights/light_white_radiosity_sim_dim_sm" );
    level._effect["light_white_radiosity_sim_fade_out"] = loadfx( "vfx/lights/light_white_radiosity_sim_fade_out" );
    level._effect["light_white_radiosity_fade_slow"] = loadfx( "vfx/lights/light_white_radiosity_fade_slow" );
    level._effect["light_fluorescent_smoke_dimmer"] = loadfx( "vfx/lights/light_fluorescent_smoke_dimmer" );
    level._effect["det_dyn_spotlight_train"] = loadfx( "vfx/lights/detroit/det_dyn_spotlight_train" );
    level._effect["det_dyn_spotlight_train_lrg"] = loadfx( "vfx/lights/detroit/det_dyn_spotlight_train_lrg" );
    level._effect["det_dyn_spotlight_train_nolight"] = loadfx( "vfx/lights/detroit/det_dyn_spotlight_train_nolight" );
    level._effect["det_dyn_spotlight_jetbike"] = loadfx( "vfx/lights/detroit/det_dyn_spotlight_jetbike" );
    level._effect["det_dyn_spotlight_jetbike_dim"] = loadfx( "vfx/lights/detroit/det_dyn_spotlight_jetbike_dim" );
    level._effect["jetbike_lights"] = loadfx( "vfx/lights/detroit/det_spotlight_jetbike" );
    level._effect["jetbike_lights_dim"] = loadfx( "vfx/lights/detroit/det_spotlight_jetbike_dim" );
    level._effect["light_white_rotate"] = loadfx( "vfx/lights/light_white_rotate" );
    level._effect["aircraft_light_wingtip_red"] = loadfx( "vfx/lights/aircraft_light_wingtip_red" );
    level._effect["aircraft_light_red_blink"] = loadfx( "vfx/lights/aircraft_light_red_blink" );
    level._effect["aircraft_light_wingtip_red_med"] = loadfx( "vfx/lights/aircraft_light_wingtip_red_med" );
    level._effect["light_wingtip_red_med_point"] = loadfx( "vfx/lights/light_wingtip_red_med_point" );
    level._effect["det_point_blue_intro"] = loadfx( "vfx/lights/detroit/det_point_blue_intro" );
    level._effect["light_stadium"] = loadfx( "vfx/lights/detroit/det_light_stadium" );
    level._effect["light_stadium_behind"] = loadfx( "vfx/lights/detroit/det_light_stadium_behind" );
    level._effect["det_light_fog_blue"] = loadfx( "vfx/lights/detroit/det_light_fog_blue" );
    level._effect["light_stadium_nolens"] = loadfx( "vfx/lights/detroit/det_light_stadium_nolens" );
    level._effect["light_stadium_nolens_sm"] = loadfx( "vfx/lights/detroit/det_light_stadium_nolens_sm" );
    level._effect["light_stadium_nolens_blue"] = loadfx( "vfx/lights/detroit/det_light_stadium_nolens_blue" );
    level._effect["light_stadium_nolens_blue_sm"] = loadfx( "vfx/lights/detroit/det_light_stadium_nolens_blue_sm" );
    level._effect["light_trailer"] = loadfx( "vfx/lights/detroit/det_light_trailer" );
    level._effect["det_fire_horizon_glow"] = loadfx( "vfx/lights/detroit/det_fire_horizon_glow" );
    level._effect["light_spotlight_cone_haze"] = loadfx( "vfx/lights/detroit/det_light_spotlight_cone_haze" );
    level._effect["light_haze_distant_single"] = loadfx( "vfx/lights/detroit/det_light_haze_distant_single" );
    level._effect["light_point_gold"] = loadfx( "vfx/lights/detroit/det_light_point_gold" );
    level._effect["spotlight_occluder_train"] = loadfx( "vfx/lights/detroit/spotlight_occluder_train" );
    level._effect["det_steam_spray"] = loadfx( "vfx/map/detroit/det_steam_spray" );
    level._effect["det_steam_linger"] = loadfx( "vfx/map/detroit/det_steam_linger" );
    level._effect["heli_spot_flare"] = loadfx( "vfx/lights/detroit/det_heli_spot_flare" );
    level._effect["heli_spotlight"] = loadfx( "vfx/lights/detroit/det_heli_spotlight" );
    level._effect["heli_spotlight_god"] = loadfx( "vfx/lights/detroit/det_heli_spotlight_god" );
    level._effect["red_point"] = loadfx( "vfx/lights/detroit/det_red_point" );
    level._effect["open_door_point"] = loadfx( "vfx/lights/detroit/det_open_door_point" );
    level._effect["red_point_dim"] = loadfx( "vfx/lights/detroit/det_red_point_dim" );
    level._effect["red_point_med"] = loadfx( "vfx/lights/detroit/det_red_point_med" );
    level._effect["orange_point_med"] = loadfx( "vfx/lights/detroit/det_orange_point_med" );
    level._effect["red_spot_jetbike"] = loadfx( "vfx/lights/detroit/det_red_spot_jetbike" );
    level._effect["fog_golden_fade"] = loadfx( "vfx/lights/detroit/det_fog_golden_fade" );
    level._effect["godray_camp_blue"] = loadfx( "vfx/lights/detroit/det_godray_camp_blue" );
    level._effect["godray_camp_blue_large"] = loadfx( "vfx/lights/detroit/det_godray_camp_blue_large" );
    level._effect["soft_blue_omni_glow"] = loadfx( "vfx/lights/detroit/det_soft_blue_omni_glow" );
    level._effect["soft_blue_omni_glow_flip"] = loadfx( "vfx/lights/detroit/det_soft_blue_omni_glow_flip" );
    level._effect["soft_blue_omni_glow_lrg"] = loadfx( "vfx/lights/detroit/det_soft_blue_omni_glow_lrg" );
    level._effect["godray_fluorescent_flicker"] = loadfx( "vfx/lights/detroit/det_godray_fluorescent_flicker" );
    level._effect["lights_conelight_yellow"] = loadfx( "vfx/lights/detroit/det_lights_conelight_yellow" );
    level._effect["det_point_rim_lrg"] = loadfx( "vfx/lights/detroit/det_point_rim_lrg" );
    level._effect["fx_flare_med_white"] = loadfx( "vfx/lensflare/detroit/fx_flare_med_white" );
    level._effect["fx_flare_med_blue"] = loadfx( "vfx/lensflare/detroit/fx_flare_med_blue" );
    level._effect["fx_flare_med_blue_bright"] = loadfx( "vfx/map/detroit/fx_flare_med_blue_bright" );
    level._effect["fx_flare_med_blue_dim"] = loadfx( "vfx/map/detroit/fx_flare_med_blue_dim" );
    level._effect["lightning_bounce"] = loadfx( "vfx/lights/lightning_bounce" );
    level._effect["headlight_gaz_yellow"] = loadfx( "vfx/lights/detroit/headlight_gaz_yellow" );
    level._effect["sunflare"] = loadfx( "vfx/lights/detroit/sunflare" );
    level._effect["car_fog_med"] = loadfx( "vfx/lights/detroit/car_fog_med" );
    level._effect["godray_track_binders"] = loadfx( "vfx/lights/detroit/godray_track_binders" );
    level._effect["light_streetlight_flare"] = loadfx( "vfx/lights/detroit/light_streetlight_flare" );
    level._effect["red_utilitylight_flare"] = loadfx( "vfx/lights/detroit/det_red_utilitylight_flare" );
    level._effect["yellow_utilitylight_flare"] = loadfx( "vfx/lights/detroit/det_yellow_utilitylight_flare" );
    level._effect["det_godray_fluorescent"] = loadfx( "vfx/lights/detroit/det_godray_fluorescent" );
    level._effect["det_godray_fluorescent_flash"] = loadfx( "vfx/lights/detroit/det_godray_fluorescent_flash" );
    level._effect["det_greenflare_flare"] = loadfx( "vfx/map/detroit/det_greenflare_flare" );
    level._effect["det_barlight_flare"] = loadfx( "vfx/lights/detroit/det_barlight_flare" );
    level._effect["det_emergency_light_flare"] = loadfx( "vfx/lights/detroit/det_emergency_light_flare" );
    level._effect["det_warm_can_sm"] = loadfx( "vfx/lights/detroit/det_warm_can_sm" );
    level._effect["fx_flare_med_blue_strong"] = loadfx( "vfx/map/detroit/fx_flare_med_blue_strong" );
    level._effect["det_light_area_dim_med"] = loadfx( "vfx/lights/detroit/light_area_dim_med" );
    level._effect["det_light_area_intro"] = loadfx( "vfx/lights/detroit/light_area_intro" );
    level._effect["cg_light_intro_red_blink"] = loadfx( "vfx/map/detroit/det_fill_light_red_blink_cg" );
    level._effect["cg_light_gate_orange"] = loadfx( "vfx/map/detroit/det_fill_light_orange_cg" );
    level._effect["point_white_reveal_cg"] = loadfx( "vfx/lights/detroit/light_point_white_reveal_cg" );
    level._effect["dust_falling_02"] = loadfx( "vfx/map/detroit/det_dust_falling_02" );
    level._effect["amb_ground_dust_blue"] = loadfx( "vfx/map/detroit/det_amb_ground_dust_blue" );
    level._effect["amb_ground_dust_green"] = loadfx( "vfx/map/detroit/det_amb_ground_dust_green" );
    level._effect["amb_ground_dust_blue_dark"] = loadfx( "vfx/map/detroit/det_amb_ground_dust_blue_dark" );
    level._effect["amb_ground_dust_blue_med"] = loadfx( "vfx/map/detroit/det_amb_ground_dust_blue_med" );
    level._effect["amb_ground_dust_blue_light"] = loadfx( "vfx/map/detroit/det_amb_ground_dust_blue_light" );
    level._effect["amb_ground_dust_blue_shot"] = loadfx( "vfx/map/detroit/det_amb_ground_dust_blue_shot" );
    level._effect["light_dust_particles"] = loadfx( "vfx/map/detroit/det_light_dust_particles" );
    level._effect["light_dust_particles_gold"] = loadfx( "vfx/map/detroit/det_light_dust_particles_gold" );
    level._effect["det_fog_ground_hoverbike_clear"] = loadfx( "vfx/map/detroit/det_fog_ground_hoverbike_clear" );
    level._effect["det_fog_ground_hoverbike_static"] = loadfx( "vfx/map/detroit/det_fog_ground_hoverbike_static" );
    level._effect["fog_ground_static"] = loadfx( "vfx/fog/fog_ground_static" );
    level._effect["godray_golden_window"] = loadfx( "vfx/lights/detroit/det_godray_golden_window" );
    level._effect["godray_golden_dim"] = loadfx( "vfx/lights/detroit/det_godray_golden_dim" );
    level._effect["godray_golden_dimmer"] = loadfx( "vfx/lights/detroit/det_godray_golden_dimmer" );
    level._effect["godray_golden_basement"] = loadfx( "vfx/lights/detroit/det_godray_golden_basement" );
    level._effect["godray_blue_window"] = loadfx( "vfx/lights/detroit/det_godray_blue_window" );
    level._effect["godray_blue_blinders"] = loadfx( "vfx/lights/detroit/det_godray_blue_blinders" );
    level._effect["godray_golden_large"] = loadfx( "vfx/lights/detroit/det_godray_golden_large" );
    level._effect["det_white_godray"] = loadfx( "vfx/lights/detroit/det_white_godray" );
    level._effect["det_godray_blue_stairwell"] = loadfx( "vfx/lights/detroit/det_godray_blue_stairwell" );
    level._effect["godray_blue_rain"] = loadfx( "vfx/lights/detroit/det_godray_blue_rain" );
    level._effect["mosquitos"] = loadfx( "vfx/animal/insects_mosquitos_flying" );
    level._effect["moths"] = loadfx( "vfx/animal/insects_moths" );
    level._effect["moths_area_sml"] = loadfx( "vfx/animal/insects_moths_area_sml" );
    level._effect["flies_landing"] = loadfx( "vfx/animal/insects_flies_landing" );
    level._effect["flies_wall"] = loadfx( "vfx/animal/insects_flies_wall" );
    level._effect["heli_water_default"] = loadfx( "vfx/treadfx/heli_water_default" );
    level._effect["heli_dust_warbird"] = loadfx( "vfx/treadfx/heli_dust_warbird" );
    level._effect["no_fx"] = loadfx( "vfx/unique/no_fx" );
    level._effect["fluorecent_bulb_pop"] = loadfx( "vfx/glass/fluorecent_bulb_pop" );
    level._effect["det_fall_through_ceiling_1"] = loadfx( "vfx/map/detroit/det_fall_through_ceiling_1" );
    level._effect["det_fall_through_ceiling_2"] = loadfx( "vfx/map/detroit/det_fall_through_ceiling_2" );
    level._effect["det_fall_impact_1"] = loadfx( "vfx/map/detroit/det_fall_impact_1" );
    level._effect["det_fall_impact_2"] = loadfx( "vfx/map/detroit/det_fall_impact_2" );
    level._effect["det_screen_splash_distort_child"] = loadfx( "vfx/map/detroit/det_screen_splash_distort_child" );
    level._effect["det_screen_splash_distort"] = loadfx( "vfx/map/detroit/det_screen_splash_distort" );
    level._effect["det_screen_splash_distort_fast"] = loadfx( "vfx/map/detroit/det_screen_splash_distort_fast" );
    level._effect["det_helmet_smash"] = loadfx( "vfx/map/detroit/det_helmet_smash" );
    level._effect["det_brick_pull_dust"] = loadfx( "vfx/map/detroit/det_brick_pull_dust" );
    level._effect["det_helmet_smash"] = loadfx( "vfx/map/detroit/det_helmet_smash" );
    level._effect["det_school_stabs"] = loadfx( "vfx/map/detroit/det_school_stabs" );
    level._effect["det_blood_pool"] = loadfx( "vfx/map/detroit/det_blood_pool" );
    level._effect["det_body_scanner_beam"] = loadfx( "vfx/map/detroit/det_body_scanner_beam" );
    level._effect["det_scanner_pannel_glow"] = loadfx( "vfx/map/detroit/det_scanner_pannel_glow" );
    level._effect["det_mech_scanner_beam"] = loadfx( "vfx/map/detroit/det_mech_scanner_beam" );
    level._effect["paper_burst"] = loadfx( "vfx/props/paper_burst" );
    level._effect["det_shelf_dust"] = loadfx( "vfx/map/detroit/det_shelf_dust" );
    level._effect["det_exo_push_sparks_child"] = loadfx( "vfx/map/detroit/det_exo_push_sparks_child" );
    level._effect["det_exo_push_sparks"] = loadfx( "vfx/map/detroit/det_exo_push_sparks" );
    level._effect["det_buttress_collapse"] = loadfx( "vfx/map/detroit/det_buttress_collapse" );
    level._effect["det_buttress_wall_sparks"] = loadfx( "vfx/map/detroit/det_buttress_wall_sparks" );
    level._effect["det_buttress_joint_sparks"] = loadfx( "vfx/map/detroit/det_buttress_joint_sparks" );
    level._effect["det_heli_shot_rnr"] = loadfx( "vfx/map/detroit/det_heli_shot_rnr" );
    level._effect["det_heli_explosion_rnr"] = loadfx( "vfx/map/detroit/det_heli_explosion_rnr" );
    level._effect["det_heli_explosion_rnr_2"] = loadfx( "vfx/map/detroit/det_heli_explosion_rnr_2" );
    level._effect["det_heli_debris_spurt"] = loadfx( "vfx/map/detroit/det_heli_debris_spurt" );
    level._effect["det_heli_fire_spurt"] = loadfx( "vfx/map/detroit/det_heli_fire_spurt" );
    level._effect["det_heli_rotor_impact"] = loadfx( "vfx/map/detroit/det_heli_rotor_impact" );
    level._effect["det_water_car_impact"] = loadfx( "vfx/map/detroit/det_water_car_impact" );
    level._effect["det_water_heli_impact"] = loadfx( "vfx/map/detroit/det_water_heli_impact" );
    level._effect["det_hoverbike_startup"] = loadfx( "vfx/map/detroit/det_hoverbike_startup" );
    level._effect["det_hoverbike_startup_vm"] = loadfx( "vfx/map/detroit/det_hoverbike_startup_vm" );
    level._effect["det_blood_impact_burst"] = loadfx( "vfx/map/detroit/det_blood_impact_burst" );
    level._effect["bloody_knife_pull"] = loadfx( "vfx/map/detroit/det_bloody_knife_pull" );
    level._effect["generic_assault_flash_view_tracer"] = loadfx( "vfx/muzzleflash/generic_assault_flash_view_tracer" );
    level._effect["det_intro_warbird_rotorwash_idle"] = loadfx( "vfx/map/detroit/det_intro_warbird_rotorwash_idle" );
    level._effect["det_intro_warbird_rotorwash_fly"] = loadfx( "vfx/map/detroit/det_intro_warbird_rotorwash_fly" );
    level._effect["trash_tornado_s_parent_motion"] = loadfx( "vfx/wind/trash_tornado_s_parent_motion" );
    level._effect["det_intro_warbird_rotor_rainstreak"] = loadfx( "vfx/map/detroit/det_intro_warbird_rotor_rainstreak" );
    level._effect["car_contact_spark_lrg"] = loadfx( "vfx/vehiclecollision/veh_collision_sparks" );
    level._effect["car_contact_asphalt_lrg"] = loadfx( "vfx/vehiclecollision/veh_collision_asphalt" );
    level._effect["car_contact_asphalt_a"] = loadfx( "vfx/vehiclecollision/veh_collision_asphalt_a" );
    level._effect["car_contact_concrete_lrg"] = loadfx( "vfx/vehiclecollision/veh_collision_concrete" );
    level._effect["car_contact_dirt_lrg"] = loadfx( "vfx/vehiclecollision/veh_collision_dirt" );
    level._effect["car_contact_spark_med"] = loadfx( "vfx/vehiclecollision/veh_collision_sparks_med" );
    level._effect["car_contact_asphalt_med"] = loadfx( "vfx/vehiclecollision/veh_collision_asphalt_med" );
    level._effect["car_contact_concrete_med"] = loadfx( "vfx/vehiclecollision/veh_collision_concrete_med" );
    level._effect["car_contact_dirt_med"] = loadfx( "vfx/vehiclecollision/veh_collision_dirt_med" );
    level._effect["car_contact_asphalt_sml"] = loadfx( "vfx/vehiclecollision/veh_collision_asphalt_sml" );
    level._effect["car_contact_concrete_sml"] = loadfx( "vfx/vehiclecollision/veh_collision_concrete_sml" );
    level._effect["car_contact_dirt_sml"] = loadfx( "vfx/vehiclecollision/veh_collision_dirt_sml" );
    level._effect["car_contact_spark_sml"] = loadfx( "vfx/vehiclecollision/veh_collision_sparks_sml" );
    level._effect["veh_collision_wet_asphalt"] = loadfx( "vfx/vehiclecollision/veh_collision_wet_asphalt" );
    level._effect["veh_collision_water"] = loadfx( "vfx/vehiclecollision/veh_collision_water" );
}

treadfx_override()
{
    waittillframeend;
    var_0[0] = "script_vehicle_xh9_warbird";
    var_1[0] = "script_vehicle_littlebird_kva_armed";
    level.treadfx_maxheight = 2000;
    var_2 = "vfx/treadfx/heli_dust_warbird";
    var_3 = "vfx/treadfx/heli_water_default";
    var_4 = "vfx/unique/no_fx";

    foreach ( var_6 in var_0 )
    {
        maps\_vehicle::set_vehicle_effect( var_6, "brick", var_3 );
        maps\_vehicle::set_vehicle_effect( var_6, "bark", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "carpet", var_3 );
        maps\_vehicle::set_vehicle_effect( var_6, "cloth", var_3 );
        maps\_vehicle::set_vehicle_effect( var_6, "concrete", var_3 );
        maps\_vehicle::set_vehicle_effect( var_6, "dirt", var_3 );
        maps\_vehicle::set_vehicle_effect( var_6, "flesh", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "foliage", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "glass", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "grass", var_3 );
        maps\_vehicle::set_vehicle_effect( var_6, "gravel", var_3 );
        maps\_vehicle::set_vehicle_effect( var_6, "ice", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "metal", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "mud", var_3 );
        maps\_vehicle::set_vehicle_effect( var_6, "paper", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "plaster", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "rock", var_3 );
        maps\_vehicle::set_vehicle_effect( var_6, "sand", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "snow", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "water", var_3 );
        maps\_vehicle::set_vehicle_effect( var_6, "wood", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "asphalt", var_3 );
        maps\_vehicle::set_vehicle_effect( var_6, "ceramic", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "plastic", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "rubber", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "cushion", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "fruit", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "paintedmetal", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "riotshield", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "slush", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "default", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "none" );
    }

    foreach ( var_6 in var_1 )
    {
        maps\_vehicle::set_vehicle_effect( var_6, "brick", var_3 );
        maps\_vehicle::set_vehicle_effect( var_6, "bark", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "carpet", var_3 );
        maps\_vehicle::set_vehicle_effect( var_6, "cloth", var_3 );
        maps\_vehicle::set_vehicle_effect( var_6, "concrete", var_3 );
        maps\_vehicle::set_vehicle_effect( var_6, "dirt", var_3 );
        maps\_vehicle::set_vehicle_effect( var_6, "flesh", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "foliage", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "glass", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "grass", var_3 );
        maps\_vehicle::set_vehicle_effect( var_6, "gravel", var_3 );
        maps\_vehicle::set_vehicle_effect( var_6, "ice", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "metal", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "mud", var_3 );
        maps\_vehicle::set_vehicle_effect( var_6, "paper", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "plaster", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "rock", var_3 );
        maps\_vehicle::set_vehicle_effect( var_6, "sand", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "snow", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "water", var_3 );
        maps\_vehicle::set_vehicle_effect( var_6, "wood", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "asphalt", var_3 );
        maps\_vehicle::set_vehicle_effect( var_6, "ceramic", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "plastic", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "rubber", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "cushion", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "fruit", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "paintedmetal", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "riotshield", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "slush", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "default", var_4 );
        maps\_vehicle::set_vehicle_effect( var_6, "none" );
    }
}

cg_helipad_red_fx_lights()
{
    common_scripts\_exploder::exploder( "cg_helipad_red_light" );
}

rain_attach_player_drizzle()
{
    level waittill( "vfx_rain_intro" );
    wait 5;
    common_scripts\_exploder::exploder( 121 );
    soundscripts\_snd::snd_message( "weather_report", "drizzle" );
    level waittill( "med_rain_start" );
    wait 2;
    maps\_utility::pauseexploder( 121 );
}

rain_attach_player_medium()
{
    common_scripts\utility::flag_wait( "vfx_before_giant_gate" );
    wait 5;
    level notify( "med_rain_start" );
    common_scripts\_exploder::exploder( 122 );
    soundscripts\_snd::snd_message( "weather_report", "med_rain" );
    common_scripts\utility::flag_wait( "vfx_garage_under_entrance" );
    maps\_utility::pauseexploder( 122 );
}

rain_attach_player_heavy_speedy()
{
    common_scripts\utility::flag_wait( "vfx_exit_garage_door" );
    level waittill( "vfx_exit_drive_start" );
    wait 2;
    common_scripts\_exploder::exploder( 124 );
    soundscripts\_snd::snd_message( "weather_report", "heavy_speedy_rain" );
    level waittill( "vfx_player_jetbike_stops" );
    maps\_utility::pauseexploder( 124 );
}

rain_attach_player_heavy()
{
    level waittill( "vfx_player_jetbike_stops" );
    common_scripts\_exploder::exploder( 123 );
    common_scripts\_exploder::exploder( 119 );
    soundscripts\_snd::snd_message( "weather_report", "heavy_rain" );
    level waittill( "detroit_level_fadeout" );
    wait 5;
    maps\_utility::pauseexploder( 123 );
}

waribird_intro_vfx( var_0 )
{
    thread intro_warbird_rotorwash_ground();
    thread intro_warbird_wind_debris();
    thread intro_warbird_rotor_rainstreak( var_0 );
    thread intro_rain_splat_onlens();
    wait 4;
    thread intro_warbird_rotorwash_fly( var_0 );
}

intro_warbird_rotorwash_ground()
{
    common_scripts\_exploder::exploder( "det_intro_warbird_rotorwash_idle" );
    wait 8.5;
    maps\_utility::pauseexploder( "det_intro_warbird_rotorwash_idle" );
}

intro_rain_splat_onlens()
{
    common_scripts\_exploder::exploder( 47 );
    wait 10;
    maps\_utility::pauseexploder( 47 );
}

intro_warbird_rotorwash_fly( var_0 )
{
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1 linkto( var_0, "tag_origin", ( 0, 0, -300 ), ( -90, 0, 0 ) );
    playfxontag( common_scripts\utility::getfx( "det_intro_warbird_rotorwash_fly" ), var_1, "tag_origin" );
    common_scripts\utility::flag_wait( "level_intro_cinematic_complete" );
    stopfxontag( common_scripts\utility::getfx( "det_intro_warbird_rotorwash_fly" ), var_1, "tag_origin" );
    wait 0.05;
    var_1 delete();
}

intro_warbird_camshake()
{
    self endon( "level_intro_cinematic_complete" );
    var_0 = maps\_shg_fx::get_exploder_ent( "det_intro_warbird_rotorwash_idle" );
    var_1 = var_0.v["origin"];
    var_2 = 0.001;

    for (;;)
    {
        var_3 = distance2d( var_1, level.player.origin );
        var_4 = 0.125 * clamp( 1.0 - var_3 / 3000.0, 0.01, 1.0 ) * var_2 / 2.0;
        var_5 = randomfloat( 1.0 ) * 8.0 + 1.0;
        earthquake( var_4, var_5 * 2, var_1, 500 );
        var_2 = clamp( var_2 + var_5 / 20.0, 0.01, 2.0 );
        wait(var_5 / 20.0);
    }
}

intro_warbird_wind_debris()
{
    common_scripts\_exploder::exploder( 45 );
    wait 6.5;
    common_scripts\_exploder::exploder( 46 );
    maps\_utility::pauseexploder( 45 );
}

intro_warbird_rotor_rainstreak( var_0 )
{
    wait 0.1;
    playfxontag( common_scripts\utility::getfx( "det_intro_warbird_rotor_rainstreak" ), var_0, "TAG_SPIN_MAIN_ROTOR_R" );
    playfxontag( common_scripts\utility::getfx( "det_intro_warbird_rotor_rainstreak" ), var_0, "TAG_SPIN_MAIN_ROTOR_L" );
    common_scripts\utility::flag_wait( "level_intro_cinematic_complete" );
    stopfxontag( common_scripts\utility::getfx( "det_intro_warbird_rotor_rainstreak" ), var_0, "TAG_SPIN_MAIN_ROTOR_R" );
    stopfxontag( common_scripts\utility::getfx( "det_intro_warbird_rotor_rainstreak" ), var_0, "TAG_SPIN_MAIN_ROTOR_L" );
}

det_scanner_fx( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    var_0 endon( "death" );
    playfxontag( common_scripts\utility::getfx( "det_body_scanner_beam" ), var_0, "scanner_FR" );
    playfxontag( common_scripts\utility::getfx( "det_body_scanner_beam" ), var_0, "scanner_KR" );
    playfxontag( common_scripts\utility::getfx( "det_scanner_pannel_glow" ), var_0, "scanner_FR" );
    playfxontag( common_scripts\utility::getfx( "det_scanner_pannel_glow" ), var_0, "scanner_KR" );
    maps\_utility::vision_set_fog_changes( "detroit_camp_scan", 1 );
    wait 7;
    maps\_utility::vision_set_fog_changes( "detroit_camp", 1 );
    stopfxontag( common_scripts\utility::getfx( "det_body_scanner_beam" ), var_0, "scanner_FR" );
    stopfxontag( common_scripts\utility::getfx( "det_body_scanner_beam" ), var_0, "scanner_KR" );
    wait 1;
    stopfxontag( common_scripts\utility::getfx( "det_scanner_pannel_glow" ), var_0, "scanner_FR" );
    stopfxontag( common_scripts\utility::getfx( "det_scanner_pannel_glow" ), var_0, "scanner_KR" );
}

det_scanner_fx_bg( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    var_0 endon( "death" );
    playfxontag( common_scripts\utility::getfx( "det_body_scanner_beam" ), var_0, "scanner_FR" );
    playfxontag( common_scripts\utility::getfx( "det_body_scanner_beam" ), var_0, "scanner_KR" );
    playfxontag( common_scripts\utility::getfx( "det_scanner_pannel_glow" ), var_0, "scanner_FR" );
    playfxontag( common_scripts\utility::getfx( "det_scanner_pannel_glow" ), var_0, "scanner_KR" );
    wait 10;
    stopfxontag( common_scripts\utility::getfx( "det_body_scanner_beam" ), var_0, "scanner_FR" );
    stopfxontag( common_scripts\utility::getfx( "det_body_scanner_beam" ), var_0, "scanner_KR" );
    wait 1.5;
    stopfxontag( common_scripts\utility::getfx( "det_scanner_pannel_glow" ), var_0, "scanner_FR" );
    stopfxontag( common_scripts\utility::getfx( "det_scanner_pannel_glow" ), var_0, "scanner_KR" );
}

det_hoverbike_mount_burke( var_0 )
{
    wait 0.5;
    common_scripts\_exploder::exploder( 1511 );
    wait 4.0;
    common_scripts\_exploder::exploder( 1512 );
}

det_hoverbike_shutdown_burke( var_0 )
{
    wait 0.5;
    common_scripts\_exploder::exploder( 1513 );
    wait 1.5;
    common_scripts\_exploder::exploder( 1514 );
}

det_hoverbike_startup_burke( var_0 )
{
    common_scripts\_exploder::exploder( 1513 );
    wait 1.0;
    common_scripts\_exploder::exploder( 1514 );
}

det_mech_scanner_fx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "det_mech_scanner_beam" ), var_0, "J2_WristTwist_LE" );
}

gate_open_rain_fall_fx( var_0 )
{
    wait 2;
    common_scripts\_exploder::exploder( 1165 );
    wait 3.9;
    common_scripts\_exploder::exploder( 1166 );
}

smoke_clear_basement_bones()
{
    common_scripts\utility::flag_wait( "vfx_garage_under_entrance" );
    var_0 = common_scripts\utility::spawn_tag_origin();
    var_1 = common_scripts\utility::spawn_tag_origin();

    if ( isdefined( level.burke_bike ) )
        var_0 linkto( level.burke_bike, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 180 ) );

    if ( isdefined( level.joker_bike ) )
        var_1 linkto( level.joker_bike, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 180 ) );

    playfxontag( common_scripts\utility::getfx( "det_fog_ground_hoverbike_clear" ), var_0, "TAG_ORIGIN" );
    playfxontag( common_scripts\utility::getfx( "det_fog_ground_hoverbike_clear" ), var_1, "TAG_ORIGIN" );
    wait 22;
    stopfxontag( common_scripts\utility::getfx( "det_fog_ground_hoverbike_clear" ), var_0, "TAG_ORIGIN" );
    stopfxontag( common_scripts\utility::getfx( "det_fog_ground_hoverbike_clear" ), var_1, "TAG_ORIGIN" );
    wait 0.05;
    var_0 delete();
    var_1 delete();
}

hoverbike_smk_push_garage()
{
    maps\_utility::wait_for_targetname_trigger( "vfx_hover_bike_smk_clear_start" );
    wait 0.01;
    common_scripts\_exploder::exploder( 3001 );
    common_scripts\_exploder::exploder( 3002 );
    common_scripts\_exploder::exploder( 3003 );
    common_scripts\_exploder::exploder( 3004 );
    wait 2;
    maps\_utility::pauseexploder( 3001 );
    common_scripts\_exploder::exploder( 3005 );
    wait 1.25;
    common_scripts\_exploder::exploder( 3006 );
    maps\_utility::pauseexploder( 3002 );
    common_scripts\_exploder::kill_exploder( 3001 );
    wait 1.25;
    common_scripts\_exploder::exploder( 3007 );
    maps\_utility::pauseexploder( 3003 );
    common_scripts\_exploder::kill_exploder( 3002 );
    wait 0.5;
    common_scripts\_exploder::exploder( 3008 );
    common_scripts\_exploder::exploder( 3009 );
    maps\_utility::pauseexploder( 3004 );
    common_scripts\_exploder::kill_exploder( 3003 );
    wait 2;
    maps\_utility::pauseexploder( 3005 );
    common_scripts\_exploder::kill_exploder( 3004 );
    wait 2;
    maps\_utility::pauseexploder( 3006 );
    common_scripts\_exploder::kill_exploder( 3005 );
    wait 2.5;
    maps\_utility::pauseexploder( 3007 );
    common_scripts\_exploder::kill_exploder( 3006 );
    wait 1;
    maps\_utility::pauseexploder( 3008 );
    common_scripts\_exploder::kill_exploder( 3007 );
    wait 1;
    maps\_utility::pauseexploder( 3009 );
    common_scripts\_exploder::kill_exploder( 3008 );
    wait 3;
    common_scripts\_exploder::kill_exploder( 3009 );
}

exitdrive_buttress()
{
    maps\_utility::wait_for_targetname_trigger( "final_straightaway_missile_02" );
    maps\_utility::delaythread( 0.35, common_scripts\_exploder::exploder, "1601" );
    maps\_utility::wait_for_targetname_trigger( "final_straightaway_missile_04" );
    maps\_utility::delaythread( 0.35, common_scripts\_exploder::exploder, "1602" );
    maps\_utility::wait_for_targetname_trigger( "final_straightaway_missile_07" );
    maps\_utility::delaythread( 0.35, common_scripts\_exploder::exploder, "1603" );
}

steam_spray_custom_function()
{
    level endon( "stop_valve_animation" );
    wait 11.5;

    if ( common_scripts\utility::flag( "kill_the_valve_anim" ) )
        return;

    maps\_utility::stop_exploder( 1759 );
    common_scripts\_exploder::exploder( 1760 );
}

det_fall_through_ceiling( var_0 )
{
    wait 0.05;
    common_scripts\_exploder::exploder( 5001 );
    wait 0.7;
    common_scripts\_exploder::exploder( 5002 );
    wait 10.5;
    common_scripts\_exploder::exploder( 5003 );
    wait 2.6;
    common_scripts\_exploder::exploder( 5004 );
    wait 1.2;
    maps\_trigger::spawneffectonplayerview( "det_screen_splash_distort", ( 12, 0, 0 ), ( 0, 0, 0 ) );
}

det_brick_pull_fx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "det_brick_pull_dust" ), var_0, "tag_origin" );
    common_scripts\_exploder::exploder( 5302 );
}

det_helmet_smash_fx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "det_helmet_smash" ), var_0, "TAG_EYE" );
    wait 2.5;
    common_scripts\_exploder::exploder( 5301 );
}

det_knife_stab_fx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "det_school_stabs" ), var_0, "J_Clavicle_RI" );
    // var_0 setmodel( "kva_hazmat_body_a_stabbed" );
}

det_knife_pull( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "bloody_knife_pull" ), var_0, "J_knife" );
}

det_shelf_papers_fx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "paper_burst" ), var_0, "TAG_ORIGIN" );
    wait 0.1;
    common_scripts\_exploder::exploder( 9201 );
}

cg_sentinel_fx_light()
{
    common_scripts\_exploder::exploder( "cg_sentinel_reveal_light" );
}

det_blood_impact_burst01( var_0 )
{
    wait 0.9;
    common_scripts\_exploder::exploder( "det_blood_impact_burst01" );
}

det_blood_impact_burst02( var_0 )
{
    wait 0.9;
    common_scripts\_exploder::exploder( "det_blood_impact_burst02" );
}

det_blood_impact_burst03( var_0 )
{
    wait 0.9;
    common_scripts\_exploder::exploder( "det_blood_impact_burst03" );
}

det_water_crash_jeep_1()
{
    common_scripts\utility::flag_wait( "flag_water_crash_1" );
    wait 0.45;
    common_scripts\_exploder::exploder( 15001 );
    wait 0.4;
    maps\_trigger::spawneffectonplayerview( "det_screen_splash_distort_fast", ( 12, 0, 0 ), ( 0, 0, 0 ) );
}

det_water_crash_jeep_2()
{
    common_scripts\utility::flag_wait( "flag_water_crash_2" );
    wait 0.3;
    common_scripts\_exploder::exploder( 15002 );
}

det_joker_bike_end_fx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "hoverbike_pads_fast" ), var_0, "tag_pad_br" );
    playfxontag( common_scripts\utility::getfx( "hoverbike_pads_fast" ), var_0, "tag_pad_fr" );
    playfxontag( common_scripts\utility::getfx( "hoverbike_pads_fast" ), var_0, "tag_pad_fl" );
    waitframe();
    playfxontag( common_scripts\utility::getfx( "hoverbike_exhaust_fast" ), var_0, "tag_exhaust" );
    playfxontag( common_scripts\utility::getfx( "det_fog_ground_hoverbike_clear" ), var_0, "TAG_FX_WAKE" );
}

det_bones_bike_end_fx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "hoverbike_pads_fast" ), var_0, "tag_pad_br" );
    playfxontag( common_scripts\utility::getfx( "hoverbike_pads_fast" ), var_0, "tag_pad_fr" );
    playfxontag( common_scripts\utility::getfx( "hoverbike_pads_fast" ), var_0, "tag_pad_fl" );
    waitframe();
    playfxontag( common_scripts\utility::getfx( "hoverbike_exhaust_fast" ), var_0, "tag_exhaust" );
    playfxontag( common_scripts\utility::getfx( "det_fog_ground_hoverbike_clear" ), var_0, "TAG_FX_WAKE" );
}

det_helicopter_shot( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "det_heli_shot_rnr" ), var_0, "TAG_BODY" );
}

det_helicopter_explo( var_0 )
{
    common_scripts\_exploder::exploder( 16001 );
    stopfxontag( common_scripts\utility::getfx( "det_heli_shot_rnr" ), var_0, "TAG_BODY" );
    wait 0.2;
    playfxontag( common_scripts\utility::getfx( "det_heli_explosion_rnr" ), var_0, "TAG_ORIGIN" );
    var_0 hidepart( "main_rotor_jnt" );
    var_0 hidepart( "main_rotor2_jnt" );
    wait 1.9;
    common_scripts\_exploder::exploder( 16002 );
    wait 0.7;
    common_scripts\_exploder::exploder( 16006 );
    wait 0.2;
    common_scripts\_exploder::exploder( 16007 );
    wait 0.4;
    common_scripts\_exploder::exploder( 16003 );
    soundscripts\_snd::snd_message( "chopper_final_explo" );
    earthquake( 0.1, 7.0, level.player.origin, 1600 );
}
