// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    confcenterprecache();
    confcenterflaginit();
    confcenterglobalvars();
    confcenterglobalsetup();
    maps\greece_conf_center_anim::main();
    maps\greece_conf_center_vo::main();
    maps\greece_conf_center_fx::main();
    animscripts\traverse\boost::precache_boost_fx_npc();
    maps\_stealth::main();
    maps\_patrol_extended::main();
    deliverytrucksetup();

    if ( level.currentgen )
        thread tff_spawn_vehicles_conf_center();
}

confcenterprecache()
{
    precacheshellshock( "rpg_player" );
    precacheshellshock( "stinger" );
    precacheshellshock( "hms_kamikazedrone" );
    precachemodel( "vehicle_civ_full_size_technical_turret" );
    precacheturret( "50cal_turret_technical_lagos" );
    precachemodel( "viewhands_atlas_military" );
    precachemodel( "vb_civilian_mitchell" );
    // precacheshellshock( "greece_drone_slowview" );
    // precacheshellshock( "greece_drone_destroyed" );
    // precacheshellshock( "iw5_bal27_sp" );
    // precacheshellshock( "iw5_bal27_sp_silencer01" );
    // precacheshellshock( "iw5_hmr9_sp" );
    // precacheshellshock( "iw5_hmr9_sp_variablereddot" );
    // precacheshellshock( "iw5_sn6_sp" );
    // precacheshellshock( "iw5_sn6_sp_silencer01" );
    // precacheshellshock( "iw5_uts19_sp" );
    // precacheshellshock( "iw5_titan45_sp" );
    // precacheshellshock( "iw5_titan45_sp_opticsreddot_silencerpistol" );
    // precacheshellshock( "fraggrenade" );
    // precacheshellshock( "flash_grenade" );
    precachemodel( "weapon_parabolic_knife" );
    precachemodel( "npc_bal27_nocamo" );
    precachemodel( "greece_drone_control_pad" );
    precachemodel( "greece_drone_control_pad_touched" );
    precachemodel( "civ_urban_male_body_f" );
    precachemodel( "civ_urban_male_body_g" );
    precachemodel( "body_civ_sf_male_a" );
    precachemodel( "head_m_act_cau_bedrosian_base" );
    precachemodel( "head_m_act_asi_chang_base" );
    precachemodel( "head_male_mp_manasi" );
    precacherumble( "silencer_fire" );
    precacherumble( "heavygun_fire" );
    precacherumble( "subtle_tank_rumble" );
    precacherumble( "damage_light" );
    precacherumble( "damage_heavy" );
    precacheshader( "hud_icon_remoteturret" );
    precacheshader( "veh_hud_target_offscreen" );
    precacheshader( "veh_hud_missile_offscreen" );
    precacheshader( "ac130_hud_friendly_ai_offscreen" );
    maps\_controlled_sniperdrone::precacheassets();
    maps\_hms_door_interact::precachedooranimations();
    precachestring( &"GREECE_OBJ_DRONE" );
    precachestring( &"GREECE_OBJ_DRONE_POINTER" );
    precachestring( &"GREECE_OBJ_POSITION_POINTER" );
    precachestring( &"GREECE_OBJ_HADES_POINTER" );
    precachestring( &"GREECE_OBJ_ATRIUM_POINTER" );
    precachestring( &"GREECE_HINT_DRONE_USE" );
    precachestring( &"GREECE_HINT_DRONE_USE_KB" );
    maps\_utility::add_hint_string( "courtyard_overwatch", &"GREECE_HINT_COURTYARD_OVERWATCH", ::hintcourtyardoverwatchoff );
    maps\_utility::add_hint_string( "atrium_view", &"GREECE_HINT_ATRIUM", ::hintatriumviewoff );
    maps\_utility::add_hint_string( "car_alarm", &"GREECE_HINT_CAR_ALARM", ::hintcaralarmoff );
    maps\_utility::add_hint_string( "hades_zoom", &"GREECE_HINT_HADES_ZOOM", ::hinthadeszoomoff );
    maps\_utility::add_control_based_hint_strings( "mute_breach", &"GREECE_HINT_MUTE_BREACH", ::hintmutebreachoff );
    maps\_utility::add_control_based_hint_strings( "drone_zoom", &"GREECE_HINT_DRONE_ZOOM", ::hintdronezoomoff, &"GREECE_HINT_DRONE_ZOOM_KB" );
    maps\_utility::add_hint_string( "support_allies", &"GREECE_HINT_SUPPORT_ALLIES", ::hintsupportalliesoff );
    maps\_utility::add_hint_string( "look_at_truck", &"GREECE_HINT_LOOK_AT_TRUCK", ::hintlookattruckoff );
    precachestring( &"GREECE_DRONE_ALERT_FAIL" );
    precachestring( &"GREECE_DRONE_KILLHADES_FAIL" );
    precachestring( &"GREECE_DRONE_NOKILLHADES_FAIL" );
    precachestring( &"GREECE_DRONE_BURKEKILLED_FAIL" );
    precachestring( &"GREECE_DRONE_TIMEREXPIRE_FAIL" );
    precachestring( &"GREECE_DRONE_INVALIDTARGET_FAIL" );
    precachestring( &"GREECE_ATRIUM_TIMER_LABEL" );
}

confcenterflaginit()
{
    common_scripts\utility::flag_init( "FlagSetObjDroneSupport" );

    if ( !common_scripts\utility::flag_exist( "FlagAlarmMissionEnd" ) )
        common_scripts\utility::flag_init( "FlagAlarmMissionEnd" );

    common_scripts\utility::flag_init( "FlagPlayerStartDroneInteract" );
    common_scripts\utility::flag_init( "FlagPlayerStartDroneFlight" );
    common_scripts\utility::flag_init( "FlagPlayerEndDroneFlight" );
    common_scripts\utility::flag_init( "FlagPlayerStartDroneControl" );
    common_scripts\utility::flag_init( "FlagPlayerEndDroneStatic" );
    common_scripts\utility::flag_init( "FlagPlayerEndDroneControl" );
    common_scripts\utility::flag_init( "FlagSniperDroneFlinch" );
    common_scripts\utility::flag_init( "FlagSniperDroneHit" );
    common_scripts\utility::flag_init( "FlagSniperDroneAnimating" );
    common_scripts\utility::flag_init( "FlagSniperDroneLookAt" );
    common_scripts\utility::flag_init( "FlagBeginConfCenterSupportA" );
    common_scripts\utility::flag_init( "FlagBeginConfCenterSupportB" );
    common_scripts\utility::flag_init( "FlagBeginConfCenterSupportC" );
    common_scripts\utility::flag_init( "FlagBeginConfCenterKill" );
    common_scripts\utility::flag_init( "FlagBeginConfCenterCombat" );
    common_scripts\utility::flag_init( "FlagBeginConfCenterOutro" );
    common_scripts\utility::flag_init( "FlagBeginGateSetup" );
    common_scripts\utility::flag_init( "FlagBeginCourtyardSetup" );
    common_scripts\utility::flag_init( "FlagBeginWalkwaySetup" );
    common_scripts\utility::flag_init( "FlagBeginPoolSetup" );
    common_scripts\utility::flag_init( "FlagBeginStruggleSetup" );
    common_scripts\utility::flag_init( "FlagBeginAtriumSetup" );
    common_scripts\utility::flag_init( "FlagBeginRooftopSetup" );
    common_scripts\utility::flag_init( "FlagBeginParkingSetup" );
    common_scripts\utility::flag_init( "FlagEndGateSetup" );
    common_scripts\utility::flag_init( "FlagEndCourtyardSetup" );
    common_scripts\utility::flag_init( "FlagEndWalkwaySetup" );
    common_scripts\utility::flag_init( "FlagEndPoolSetup" );
    common_scripts\utility::flag_init( "FlagEndStruggleSetup" );
    common_scripts\utility::flag_init( "FlagEndAtriumSetup" );
    common_scripts\utility::flag_init( "FlagEndRooftopSetup" );
    common_scripts\utility::flag_init( "FlagEndParkingSetup" );
    common_scripts\utility::flag_init( "FlagMonitorZoomOnHades" );
    common_scripts\utility::flag_init( "FlagPlayerZoomOnHades1" );
    common_scripts\utility::flag_init( "FlagPlayerZoomOnHades2" );
    common_scripts\utility::flag_init( "FlagContinueDroneFlyin" );
    common_scripts\utility::flag_init( "FlagForcePlayerADS" );
    common_scripts\utility::flag_init( "FlagForcePlayerSlowMovement" );
    common_scripts\utility::flag_init( "FlagGateBreachComplete" );
    common_scripts\utility::flag_init( "FlagConfCenterAlliesVulnerable" );
    common_scripts\utility::flag_init( "FlagAllyVehicleDriveBy" );
    common_scripts\utility::flag_init( "FlagGateGuardsApproachingAllyVehicle" );
    common_scripts\utility::flag_init( "FlagGateGuardsAtAllyVehicle" );
    common_scripts\utility::flag_init( "FlagAllyShootGateGuard" );
    common_scripts\utility::flag_init( "FlagCourtyardGuardNearGate" );
    common_scripts\utility::flag_init( "FlagCourtyardAlliesBreachGate" );
    common_scripts\utility::flag_init( "FlagCourtyardAlliesBreachGateAlt" );
    common_scripts\utility::flag_init( "FlagCourtyardAnyOverwatchDead" );
    common_scripts\utility::flag_init( "FlagCourtyardAllOverwatchDead" );
    common_scripts\utility::flag_init( "FlagWalkwayAlliesPerformKill" );
    common_scripts\utility::flag_init( "FlagPlayerKillPoolGuard" );
    common_scripts\utility::flag_init( "FlagStopPoolWater" );
    common_scripts\utility::flag_init( "FlagPoolKillReady" );
    common_scripts\utility::flag_init( "FlagPoolKillBegin" );
    common_scripts\utility::flag_init( "FlagPoolKillSpecial" );
    common_scripts\utility::flag_init( "FlagCourtyardBurkeJumpCompleted" );
    common_scripts\utility::flag_init( "FlagStruggleBurkeApproaches" );
    common_scripts\utility::flag_init( "FlagStruggleGuardAttacks" );
    common_scripts\utility::flag_init( "FlagStruggleBurkeRecovers" );
    common_scripts\utility::flag_init( "FlagPlayerLookingAtAtrium" );
    common_scripts\utility::flag_init( "FlagPlayerSignalAtriumBreach" );
    common_scripts\utility::flag_init( "FlagPlayerShootFirstAtrium" );
    common_scripts\utility::flag_init( "FlagAtriumAlliesReadyToBreach" );
    common_scripts\utility::flag_init( "FlagAtriumEnemiesReactToBreach" );
    common_scripts\utility::flag_init( "FlagAtriumEnemiesAllMarked" );
    common_scripts\utility::flag_init( "FlagAtriumAlliesPerformBreach" );
    common_scripts\utility::flag_init( "FlagAtriumEnemiesAlmostAllDead" );
    common_scripts\utility::flag_init( "FlagParkingCarAlarmActivated" );
    common_scripts\utility::flag_init( "FlagParkingCarAlarmDisableAutosave" );
    common_scripts\utility::flag_init( "FlagUnMarkParkingCars" );
    common_scripts\utility::flag_init( "FlagParkingGuardsMovingToCar" );
    common_scripts\utility::flag_init( "FlagParkingAlliesOnStairs" );
    common_scripts\utility::flag_init( "FlagParkingAlliesOrderedToKill" );
    common_scripts\utility::flag_init( "FlagParkingAlliesPerformKill" );
    common_scripts\utility::flag_init( "FlagParkingPlayerStealKill" );
    common_scripts\utility::flag_init( "FlagParkingGuardsNearCar" );
    common_scripts\utility::flag_init( "FlagAtriumAlliesExit" );
    common_scripts\utility::flag_init( "FlagConfRoomAlliesReadyToBreach" );
    common_scripts\utility::flag_init( "FlagOkayToKillHades" );
    common_scripts\utility::flag_init( "FlagHadesSpeechStarted" );
    common_scripts\utility::flag_init( "FlagConfRoomAlliesBodyScan" );
    common_scripts\utility::flag_init( "FlagConfRoomExplosion" );
    common_scripts\utility::flag_init( "FlagConfRoomAlliesRecover" );
    common_scripts\utility::flag_init( "FlagConfRoomAlliesExit" );
    common_scripts\utility::flag_init( "FlagEnemyVehiclePathEnd" );
    common_scripts\utility::flag_init( "FlagEnemyVehicleActivateTurret" );
    common_scripts\utility::flag_init( "FlagEnemyVehicleTurretDisabled" );
    common_scripts\utility::flag_init( "FlagSpawnEnemyReinforcements" );
    common_scripts\utility::flag_init( "FlagEnemyReinforcementsDriveEnd" );
    common_scripts\utility::flag_init( "FlagHadesVehicleDriveStart" );
    common_scripts\utility::flag_init( "FlagAllGateGuardsDead" );
    common_scripts\utility::flag_init( "FlagAllCourtyardGuardsDead" );
    common_scripts\utility::flag_init( "FlagAllWalkwayGuardsDead" );
    common_scripts\utility::flag_init( "FlagAllPoolGuardsDead" );
    common_scripts\utility::flag_init( "FlagAllAtriumGuardsDead" );
    common_scripts\utility::flag_init( "FlagAllRooftopGuardsDead" );
    common_scripts\utility::flag_init( "FlagAllParkingGuardsDead" );
    common_scripts\utility::flag_init( "FlagAnyParkingGuardsDead" );
    common_scripts\utility::flag_init( "FlagSomeAmbushSouthGuardsDead" );
    common_scripts\utility::flag_init( "FlagAllAmbushSouthGuardsDead" );
    common_scripts\utility::flag_init( "FlagAllAmbushEastGuardsDead" );
    common_scripts\utility::flag_init( "FlagAllAmbushVehicleGuardsDead" );
    common_scripts\utility::flag_init( "FlagAllAmbushGuardsDead" );
    common_scripts\utility::flag_init( "FlagHadesVehicleDroneLaunch" );
    common_scripts\utility::flag_init( "FlagPlayerShotConfRoomWindows" );
    common_scripts\utility::flag_init( "FlagDisableAutosave" );
    common_scripts\utility::flag_init( "FlagBodyStashGuard1Killed" );
    common_scripts\utility::flag_init( "FlagBodyStashGuard2Killed" );
    common_scripts\utility::flag_init( "FlagBodyStashGuardsAlerted" );
    common_scripts\utility::flag_init( "FlagShowTruckBlood" );
    common_scripts\utility::flag_init( "FlagOkayToShootDrone" );
    common_scripts\utility::flag_init( "FlagUnMarkAtrium" );
    common_scripts\utility::flag_init( "FlagStopPoolWater" );
    common_scripts\utility::flag_init( "FlagSniperDroneCloakOff" );
    common_scripts\utility::flag_init( "FlagGreeceTripleKillAchievement" );
}

confcenterglobalvars()
{
    setdvarifuninitialized( "mission_fail_enabled", 1 );
    setdvarifuninitialized( "level_debug", 1 );
    setdvarifuninitialized( "stealth_debug_prints", 0 );
    level.showdebugtoggle = 0;
    level.dialogtable = "sp/greece_dialog.csv";
    level.breachactors = [];
    level.confhades = undefined;
    level.allyinfiltrators = [];
    level.infiltratorburke = undefined;
    level.ialliesatgate = 0;
    level.atriumtimer = undefined;
    level.playertargets = [];
    level.allenemypatrollers = [];
    level.allenemyambushers = [];
    level.allenemyvehicles = [];
    level.alerttimedelay = 0;
    level.alertedenemies = [];
    level.bmarkallies = 0;
    level.triplekillcount = 0;
    level.allieswarningtime = undefined;
    level.alliesvulnerabletime = undefined;
    level.hudalerttimer = undefined;
    level.parkingalarmcar = undefined;
    level.bsaveinprogress = undefined;
    level.patrol_scriptedanims = [];
    level.patrol_scriptedanims["casual"] = "casual_stand_idle";
    level.patrol_scriptedanims["bored"] = "patrol_bored_idle";
    level.patrol_scriptedanims["search"] = "so_hijack_search_gear_check_loop";
    level.patrol_scriptedanims["lookdown"] = "prague_sniper_lookout_idle";
    level.patrol_scriptedanims["react"] = "patrol_bored_react_look";
    level.patrol_scriptedanims["shortidle"] = "patrolstand_idle";
    level.patrol_scriptedanims["ready"] = "readystand_idle";
}

confcenterglobalsetup()
{
    maps\_utility::battlechatter_on( "allies" );
    maps\_utility::battlechatter_on( "axis" );
    maps\_patrol_anims::main();
    maps\_idle::idle_main();
    maps\_idle_smoke::main();
    maps\_idle_phone::main();
    thread confcenterbegin();
}

confcenterstartpoints()
{
    maps\_utility::add_start( "start_conf_center_intro", ::initconfcenterintro );
    maps\_utility::add_start( "start_conf_center_support1", ::initconfcentersupporta );
    maps\_utility::add_start( "start_conf_center_support2", ::initconfcentersupportb );
    maps\_utility::add_start( "start_conf_center_support3", ::initconfcentersupportc );
    maps\_utility::add_start( "start_conf_center_kill", ::initconfcenterkill );
    maps\_utility::add_start( "start_conf_center_combat", ::initconfcentercombat );
    maps\_utility::add_start( "start_conf_center_outro", ::initconfcenteroutro );
    maps\greece_starts::add_greece_starts( "conference_center" );
}

initconfcenterintro()
{
    maps\_utility::teleport_player( common_scripts\utility::getstruct( "PlayerStartConfCenterIntro", "targetname" ) );
    maps\_hms_utility::setupplayerinventory( "iw5_titan45_sp_opticsreddot_silencerpistol", "iw5_hmr9_sp_variablereddot", "fraggrenade", "flash_grenade", "iw5_hmr9_sp_variablereddot" );
    thread maps\greece_code::blimp_animation( "ConfBlimpOrg", "cc_blimp" );
    maps\_hms_utility::spawnandinitnamedally( "Ilona", "IlanaStartConfCenter", 1, 1, "IlanaConfCenter" );
    level.allies["Ilona"] maps\_utility::forceuseweapon( "iw5_titan45_sp_opticsreddot_silencerpistol", "primary" );
    thread maps\greece_safehouse::safehousesetupsniperdroneilana();
    maps\greece_safehouse::safehouseforceopensafehousedoor();
    thread maps\greece_safehouse::safehouseremoveplayerblocker();
    thread maps\greece_safehouse::safehousetranstoalleygatesetup();
    thread maps\greece_conf_center_fx::confcenterlightglowfx();
    maps\greece_safehouse_fx::ambientcloudsloadin();
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );
    common_scripts\utility::flag_set( "FlagSniperDroneLaunched" );
    common_scripts\utility::flag_set( "FlagConfCenterStart" );
    soundscripts\_snd::snd_message( "start_conf_center_intro_checkpoint" );
}

initconfcentersupporta()
{
    confcenterobjectivesetup();
    maps\_utility::teleport_player( common_scripts\utility::getstruct( "PlayerStartConfCenter", "targetname" ) );
    maps\_hms_utility::setupplayerinventory( "iw5_titan45_sp_opticsreddot_silencerpistol", "iw5_hmr9_sp_variablereddot", "fraggrenade", "flash_grenade", "iw5_hmr9_sp_variablereddot" );
    thread monitorstartdronecontrol( 0, 0 );
    thread maps\greece_code::blimp_animation( "ConfBlimpOrg", "cc_blimp" );
    maps\_hms_utility::spawnandinitnamedally( "Ilona", "IlanaStartConfCenter", 1, 1, "IlanaConfCenter" );
    thread maps\greece_safehouse::safehousesetupsniperdroneilana();
    maps\greece_safehouse::safehouseforceopensafehousedoor();
    thread maps\greece_safehouse::safehouseremoveplayerblocker();
    thread maps\greece_safehouse::safehousetranstoalleygatesetup();
    thread maps\greece_conf_center_fx::confcenterlightglowfx();
    maps\greece_safehouse_fx::ambientcloudsloadin();
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );
    maps\_utility::add_extra_autosave_check( "ConfCenterAutosaveStealthCheck", ::autosaveconfcenterstealthcheck, "Can't autosave during sniperdrone stealth!" );
    common_scripts\utility::flag_set( "FlagPlayerStartDroneControl" );
    common_scripts\utility::flag_set( "FlagBeginConfCenterSupportA" );
    common_scripts\utility::flag_set( "init_begin_confcenter_support_a_lighting" );
    soundscripts\_snd::snd_message( "start_conf_center_support1_checkpoint" );
}

initconfcentersupportb()
{
    confcenterobjectivesetup();
    maps\_utility::teleport_player( common_scripts\utility::getstruct( "PlayerStartConfCenter", "targetname" ) );
    maps\_hms_utility::setupplayerinventory( "iw5_titan45_sp_opticsreddot_silencerpistol", "iw5_hmr9_sp_variablereddot", "fraggrenade", "flash_grenade", "iw5_hmr9_sp_variablereddot" );
    thread monitorstartdronecontrol();
    thread maps\greece_code::blimp_animation( "ConfBlimpOrg", "cc_blimp" );
    maps\_hms_utility::spawnandinitnamedally( "Ilona", "IlanaStartConfCenter", 1, 1, "IlanaConfCenter" );
    thread maps\greece_safehouse::safehousesetupsniperdroneilana();
    maps\greece_safehouse::safehouseforceopensafehousedoor();
    thread maps\greece_safehouse::safehouseremoveplayerblocker();
    thread maps\greece_safehouse::safehousetranstoalleygatesetup();
    thread maps\greece_conf_center_fx::confcenterlightglowfx();
    maps\greece_safehouse_fx::ambientcloudsloadin();
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );
    maps\_utility::add_extra_autosave_check( "ConfCenterAutosaveStealthCheck", ::autosaveconfcenterstealthcheck, "Can't autosave during sniperdrone stealth!" );
    common_scripts\utility::flag_set( "FlagPlayerStartDroneControl" );
    common_scripts\utility::flag_set( "FlagBeginConfCenterSupportB" );
    common_scripts\utility::flag_set( "init_begin_confcenter_support_b_lighting" );
    soundscripts\_snd::snd_message( "start_conf_center_support2_checkpoint" );
}

initconfcentersupportc()
{
    confcenterobjectivesetup();
    maps\_utility::teleport_player( common_scripts\utility::getstruct( "PlayerStartConfCenter", "targetname" ) );
    maps\_hms_utility::setupplayerinventory( "iw5_titan45_sp_opticsreddot_silencerpistol", "iw5_hmr9_sp_variablereddot", "fraggrenade", "flash_grenade", "iw5_hmr9_sp_variablereddot" );
    thread monitorstartdronecontrol();
    thread maps\greece_code::blimp_animation( "ConfBlimpOrg", "cc_blimp" );
    maps\_hms_utility::spawnandinitnamedally( "Ilona", "IlanaStartConfCenter", 1, 1, "IlanaConfCenter" );
    thread maps\greece_safehouse::safehousesetupsniperdroneilana();
    maps\greece_safehouse::safehouseforceopensafehousedoor();
    thread maps\greece_safehouse::safehouseremoveplayerblocker();
    thread maps\greece_safehouse::safehousetranstoalleygatesetup();
    thread maps\greece_conf_center_fx::confcenterlightglowfx();
    maps\greece_safehouse_fx::ambientcloudsloadin();
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );
    maps\_utility::add_extra_autosave_check( "ConfCenterAutosaveStealthCheck", ::autosaveconfcenterstealthcheck, "Can't autosave during sniperdrone stealth!" );
    common_scripts\utility::flag_set( "FlagPlayerStartDroneControl" );
    common_scripts\utility::flag_set( "FlagBeginConfCenterSupportC" );
    common_scripts\utility::flag_set( "init_begin_confcenter_support_c_lighting" );
    soundscripts\_snd::snd_message( "start_conf_center_support3_checkpoint" );
}

initconfcenterkill()
{
    confcenterobjectivesetup();
    maps\_utility::teleport_player( common_scripts\utility::getstruct( "PlayerStartConfCenter", "targetname" ) );
    maps\_hms_utility::setupplayerinventory( "iw5_titan45_sp_opticsreddot_silencerpistol", "iw5_hmr9_sp_variablereddot", "fraggrenade", "flash_grenade", "iw5_hmr9_sp_variablereddot" );
    thread monitorstartdronecontrol();
    thread maps\greece_code::blimp_animation( "ConfBlimpOrg", "cc_blimp" );
    maps\_hms_utility::spawnandinitnamedally( "Ilona", "IlanaStartConfCenter", 1, 1, "IlanaConfCenter" );
    thread maps\greece_safehouse::safehousesetupsniperdroneilana();
    maps\greece_safehouse::safehouseforceopensafehousedoor();
    thread maps\greece_safehouse::safehouseremoveplayerblocker();
    thread maps\greece_safehouse::safehousetranstoalleygatesetup();
    thread maps\greece_conf_center_fx::confcenterlightglowfx();
    maps\greece_safehouse_fx::ambientcloudsloadin();
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );
    maps\_utility::add_extra_autosave_check( "ConfCenterAutosaveStealthCheck", ::autosaveconfcenterstealthcheck, "Can't autosave during sniperdrone stealth!" );
    common_scripts\utility::flag_set( "FlagPlayerStartDroneControl" );
    common_scripts\utility::flag_set( "FlagBeginConfCenterKill" );
    common_scripts\utility::flag_set( "init_begin_confcenter_kill_lighting" );
    soundscripts\_snd::snd_message( "start_conf_center_kill_checkpoint" );
}

initconfcentercombat()
{
    confcenterobjectivesetup();
    maps\_utility::teleport_player( common_scripts\utility::getstruct( "PlayerStartConfCenter", "targetname" ) );
    maps\_hms_utility::setupplayerinventory( "iw5_titan45_sp_opticsreddot_silencerpistol", "iw5_hmr9_sp_variablereddot", "fraggrenade", "flash_grenade", "iw5_hmr9_sp_variablereddot" );
    thread monitorstartdronecontrol();
    thread maps\greece_code::blimp_animation( "ConfBlimpOrg", "cc_blimp" );
    maps\_hms_utility::spawnandinitnamedally( "Ilona", "IlanaStartConfCenter", 1, 1, "IlanaConfCenter" );
    thread maps\greece_safehouse::safehousesetupsniperdroneilana();
    maps\greece_safehouse::safehouseforceopensafehousedoor();
    thread maps\greece_safehouse::safehouseremoveplayerblocker();
    thread maps\greece_safehouse::safehousetranstoalleygatesetup();
    maps\greece_safehouse_fx::ambientcloudsloadin();
    common_scripts\utility::flag_set( "FlagPlayerStartDroneControl" );
    common_scripts\utility::flag_set( "FlagBeginConfCenterCombat" );
    common_scripts\utility::flag_set( "FlagConfRoomAlliesRecover" );
    common_scripts\utility::flag_set( "FlagSniperDroneFlinch" );
    common_scripts\utility::flag_set( "init_begin_confcenter_combat_lighting" );
    common_scripts\utility::flag_set( "FlagSniperDroneCloakOff" );
    soundscripts\_snd::snd_message( "start_conf_center_combat_checkpoint" );
}

initconfcenteroutro()
{
    confcenterobjectivesetup();
    maps\_utility::teleport_player( common_scripts\utility::getstruct( "PlayerStartConfCenter", "targetname" ) );
    maps\_hms_utility::setupplayerinventory( "iw5_titan45_sp_opticsreddot_silencerpistol", "iw5_hmr9_sp_variablereddot", "fraggrenade", "flash_grenade", "iw5_hmr9_sp_variablereddot" );
    thread monitorstartdronecontrol();
    thread maps\greece_code::blimp_animation( "ConfBlimpOrg", "cc_blimp" );
    maps\_hms_utility::spawnandinitnamedally( "Ilona", "IlanaStartConfCenter", 1, 1, "IlanaConfCenter" );
    thread maps\greece_safehouse::safehousesetupsniperdroneilana();
    maps\greece_safehouse::safehouseforceopensafehousedoor();
    thread maps\greece_safehouse::safehouseremoveplayerblocker();
    thread maps\greece_safehouse::safehousetranstoalleygatesetup();
    maps\greece_safehouse_fx::ambientcloudsloadin();
    common_scripts\utility::flag_set( "FlagAllAmbushGuardsDead" );
    common_scripts\utility::flag_set( "FlagAllAmbushEastGuardsDead" );
    common_scripts\utility::flag_set( "FlagEnemyVehicleTurretDisabled" );
    common_scripts\utility::flag_set( "FlagPlayerStartDroneControl" );
    common_scripts\utility::flag_set( "FlagBeginConfCenterOutro" );
    common_scripts\utility::flag_set( "FlagSniperDroneFlinch" );
    common_scripts\utility::flag_set( "init_begin_confcenter_outro_lighting" );
    common_scripts\utility::flag_set( "FlagSniperDroneCloakOff" );
    soundscripts\_snd::snd_message( "start_conf_center_outro_checkpoint" );
}

confcenterobjectivesetup()
{
    waittillframeend;
    confcentersetcompletedobjflags();
    thread setobjsniperdronesupport();
}

confcentersetcompletedobjflags()
{
    var_0 = level.start_point;

    if ( !common_scripts\utility::string_starts_with( var_0, "start_conf_center_" ) )
        return;

    if ( var_0 == "start_conf_center_intro" )
        return;

    common_scripts\utility::flag_set( "FlagSetObjDroneSupport" );

    if ( var_0 == "start_conf_center_support1" )
        return;

    if ( var_0 == "start_conf_center_support2" )
        return;

    if ( var_0 == "start_conf_center_support3" )
        return;

    if ( var_0 == "start_conf_center_kill" )
        return;

    if ( var_0 == "start_conf_center_combat" )
        return;

    if ( var_0 == "start_conf_center_outro" )
        return;
}

setobjsniperdronesupport()
{
    common_scripts\utility::flag_wait( "FlagSetObjDroneSupport" );
    objective_add( maps\_utility::obj( "DroneSupport" ), "active", &"GREECE_OBJ_DRONE", ( 0, 0, 0 ) );
    objective_current( maps\_utility::obj( "DroneSupport" ) );
    common_scripts\utility::flag_wait( "FlagPlayerEndDroneControl" );
    maps\_utility::objective_complete( maps\_utility::obj( "DroneSupport" ) );
}

confcenterbegin()
{
    thread maps\greece_code::blimp_animation( "blimpOrg", "market_intro_blimp" );
    common_scripts\utility::flag_wait( "FlagConfCenterStart" );

    if ( level.currentgen )
        setsaveddvar( "r_znear", 30 );

    confcenterobjectivesetup();
}

playerinteractdronecontrol()
{
    var_0 = getent( "InteractDroneControl", "targetname" );
    thread droneusetrigger();
    common_scripts\utility::flag_wait( "FlagPlayerStartDroneInteract" );
    objective_position( maps\_utility::obj( "DroneSupport" ), ( 0, 0, 0 ) );
    level.player disableweapons();
    level.player allowcrouch( 0 );
    level.player allowprone( 0 );
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1.origin = level.player.origin;
    var_1.angles = level.player.angles;
    wait 0.5;
    var_2 = maps\_utility::spawn_anim_model( "player_safehouse_rig", level.player.origin );
    var_3 = maps\_utility::spawn_anim_model( "drone_control_pad", level.player.origin );
    level.player playerlinkto( var_2, "tag_player", 0, 0, 0, 0, 0 );
    var_2.drone_control_pad = var_3;
    var_4 = [ var_2, var_3 ];
    var_1 thread maps\_anim::anim_single( var_4, "drone_launch_control_pad" );
    wait 1.25;
    level.player lerpfov( 40, 0.5 );
    level.player setblurforplayer( 10, 0.5 );
    wait 0.25;
    maps\_hud_util::fade_out( 0.25, "white" );

    if ( level.currentgen )
    {
        level notify( "tff_pre_intro_to_confcenter" );
        unloadtransient( "greece_intro_tr" );
        loadtransient( "greece_confcenter_tr" );

        while ( !istransientloaded( "greece_confcenter_tr" ) )
            wait 0.05;

        level notify( "tff_post_intro_to_confcenter" );
    }

    soundscripts\_snd::snd_message( "drone_control_pad_end" );
    common_scripts\utility::flag_set( "FlagPlayerStartDroneFlight" );
    thread monitorstartdronecontrol( 1, 0 );
    wait 4.0;
    common_scripts\utility::flag_set( "FlagPlayerStartDroneControl" );
    common_scripts\utility::flag_set( "init_begin_confcenter_support_a_lighting" );
    var_2 delete();
    var_1 delete();
    var_3 delete();
    thread maps\greece_code::blimp_animation( "ConfBlimpOrg", "cc_blimp" );
}

droneusetrigger()
{
    level endon( "SafehouseAlerted" );
    var_0 = getent( "UseTriggerDroneControl", "targetname" );
    var_0 makeusable();
    var_0 setcursorhint( "HINT_NOICON" );
    var_0 maps\_utility::addhinttrigger( &"GREECE_HINT_DRONE_USE", &"GREECE_HINT_DRONE_USE_KB" );
    var_0 waittill( "trigger", var_1 );
    var_0 delete();
    common_scripts\utility::flag_set( "FlagPlayerStartDroneInteract" );
}

hintdroneusetriggeroff()
{
    return common_scripts\utility::flag( "FlagPlayerStartDroneInteract" );
}

dronecontrolobjdisplay()
{
    var_0 = getent( "UseTriggerDroneControl", "targetname" );

    while ( !common_scripts\utility::flag( "FlagPlayerStartDroneInteract" ) )
    {
        if ( level.player istouching( var_0 ) )
            objective_position( maps\_utility::obj( "DroneSupport" ), ( 0, 0, 0 ) );
        else
            objective_position( maps\_utility::obj( "DroneSupport" ), var_0.origin );

        wait 0.05;
    }
}

dronecontrolpadscreentouch( var_0 )
{
    var_0.drone_control_pad setmodel( "greece_drone_control_pad_touched" );
    level.player playrumbleonentity( "damage_light" );
}

monitorstartdronecontrol( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    spawnconfcenterai();

    if ( !isdefined( level.player._stealth ) )
        level.player maps\_stealth_utility::stealth_default();

    level.player enemiesignoreplayerdrone( 1 );
    var_2 = getent( "PlayerDroneTargetpoint", "targetname" );

    switch ( level.start_point )
    {
        case "start_conf_center_support2":
            var_3 = getent( "PlayerDroneStartpoint2", "targetname" );
            var_4 = getent( "PlayerDroneLookAt2", "targetname" );
            break;
        case "start_conf_center_support3":
            var_3 = getent( "PlayerDroneStartpoint3", "targetname" );
            var_4 = getent( "PlayerDroneLookAt3", "targetname" );
            break;
        case "start_conf_center_kill":
            var_3 = getent( "PlayerDroneStartpoint4", "targetname" );
            var_4 = getent( "PlayerDroneLookAt4", "targetname" );
            break;
        case "start_conf_center_outro":
        case "start_conf_center_combat":
            var_3 = getent( "PlayerDroneStartpoint5", "targetname" );
            var_4 = getent( "PlayerDroneLookAt5", "targetname" );
            break;
        default:
            var_3 = getent( "PlayerDroneStartpoint1", "targetname" );
            var_4 = getent( "PlayerDroneLookAt1", "targetname" );
            break;
    }

    var_5 = [];
    var_5[var_5.size] = getent( "SniperDroneBottomNW", "targetname" );
    var_5[var_5.size] = getent( "SniperDroneBottomNE", "targetname" );
    var_5[var_5.size] = getent( "SniperDroneBottomSW", "targetname" );
    var_5[var_5.size] = getent( "SniperDroneBottomSE", "targetname" );
    level.player thread maps\_controlled_sniperdrone::startdronecontrol( var_2, var_3, var_4, var_0, var_1, var_5 );
    maps\_compass::setupminimap( "compass_map_greece_alt" );

    if ( var_0 == 1 )
    {
        wait 0.25;
        level.player setblurforplayer( 0, 1.0 );
        wait 0.25;
        maps\_hud_util::fade_in( 0.5, "white" );
        common_scripts\utility::flag_set( "init_confcenter_start_lighting" );
    }

    thread monitorparkingcars();
    thread monitorenddronecontrol();
    thread sniperdronedeathwatch();
    thread truckblood();
}

monitorenddronecontrol()
{
    common_scripts\utility::flag_wait( "FlagPlayerEndDroneControl" );
    maps\_controlled_sniperdrone::enddronecontrol();
    level notify( "end_sniper_drone" );
    level.player enemiesignoreplayerdrone( 0 );
    level.allyinfiltrators = maps\_utility::remove_dead_from_array( level.allyinfiltrators );
    maps\_utility::array_notify( level.allyinfiltrators, "remove_outline" );
    maps\_utility::array_notify( level.allyinfiltrators, "bloodless" );
    maps\_utility::array_delete( level.allyinfiltrators );
    level.allenemypatrollers = maps\_utility::remove_dead_from_array( level.allenemypatrollers );
    maps\_utility::array_notify( level.allenemypatrollers, "remove_outline" );
    maps\_utility::array_notify( level.allenemypatrollers, "bloodless" );
    maps\_utility::array_delete( level.allenemypatrollers );
    level.allenemyambushers = maps\_utility::remove_dead_from_array( level.allenemyambushers );
    maps\_utility::array_notify( level.allenemyambushers, "remove_outline" );
    maps\_utility::array_notify( level.allenemyambushers, "bloodless" );
    maps\_utility::array_delete( level.allenemyambushers );
    thread maps\_utility::autosave_by_name( "end_drone_control" );
    wait 1.0;

    if ( level.nextgen )
        maps\_utility::array_delete( level.allenemyvehicles );
}

sniperdronedeathwatch( var_0 )
{
    common_scripts\utility::flag_wait( "FlagSniperDroneHit" );
    common_scripts\utility::flag_set( "FlagSniperDroneAnimating" );
    soundscripts\_snd::snd_message( "start_wasp_death_explo" );
    thread maps\_controlled_sniperdrone::disabledronefiringduringcrash();
    level.player disableweapons();
    level.player shellshock( "greece_drone_destroyed", 1.0 );
    var_1 = "death";
    var_0 = level.player.sniperdronelink;
    var_0.animname = "sniper_drone_flight";
    var_0 maps\_utility::assign_animtree( "sniper_drone_flight" );
    playfxontag( common_scripts\utility::getfx( "sniperdrone_cc_death_fx" ), level.player.sniperdronedata.barrelviewmodel, "TAG_ORIGIN" );
    maps\greece_conf_center_fx::confcenterresidualsmoke();
    var_0.frameviewmodel.animname = "sniperdrone_outerparts";
    var_0.frameviewmodel maps\_utility::assign_animtree( "sniperdrone_outerparts" );
    var_0.barrelviewmodel.animname = "sniperdrone_barrel";
    var_0.barrelviewmodel maps\_utility::assign_animtree( "sniperdrone_barrel" );
    var_0.frameviewmodel setanim( var_0.frameviewmodel maps\_utility::getanim( var_1 ) );
    var_0.barrelviewmodel setanim( var_0.barrelviewmodel maps\_utility::getanim( var_1 ) );
    var_2 = getanimlength( var_0 maps\_utility::getanim( var_1 ) );
    var_2 -= 1.0;
    thread sniperdronedeathshowstatic( var_2 );
    var_0 maps\_anim::anim_single_solo( var_0, var_1 );
    common_scripts\utility::flag_clear( "FlagSniperDroneAnimating" );

    if ( level.currentgen )
    {
        setsaveddvar( "r_znear", 4 );
        level notify( "tff_pre_confcenter_to_intro" );
        unloadtransient( "greece_confcenter_tr" );
        loadtransient( "greece_intro_tr" );

        while ( !istransientloaded( "greece_intro_tr" ) )
            wait 0.05;

        level notify( "tff_post_confcenter_to_intro" );
    }

    level notify( "EndDroneControl" );
    common_scripts\utility::flag_set( "FlagPlayerEndDroneControl" );
}

sniperdronedeathshowstatic( var_0 )
{
    wait(var_0);
    common_scripts\utility::flag_set( "FlagPlayerEndDroneStatic" );
    level notify( "StartDroneStatic" );
    soundscripts\_snd::snd_message( "start_drone_death_static" );
}

sniperdroneflyin( var_0 )
{
    common_scripts\utility::flag_set( "FlagSniperDroneAnimating" );
    var_1 = "flyin";
    var_2 = "flyin_idle";
    var_3 = "flyin_end";
    var_4 = common_scripts\utility::getstruct( "DroneFlyInOrg", "targetname" );
    var_0.animname = "sniper_drone_flight";
    var_0 maps\_utility::assign_animtree( "sniper_drone_flight" );
    var_5 = [ var_0 ];
    var_4 maps\_anim::anim_first_frame_solo( var_0, "flyin" );
    level.player setangles( var_0.angles * ( 1, 1, 0 ) );
    level.player playerlinktodelta( var_0, "tag_origin", 1, 10, 10, 5, 5, 1 );
    var_0.frameviewmodel.animname = "sniperdrone_outerparts";
    var_0.frameviewmodel maps\_utility::assign_animtree( "sniperdrone_outerparts" );
    var_0.barrelviewmodel.animname = "sniperdrone_barrel";
    var_0.barrelviewmodel maps\_utility::assign_animtree( "sniperdrone_barrel" );

    if ( level.currentgen )
    {
        if ( istransientloaded( "greece_intro_tr" ) )
            maps\_utility::transient_unload( "greece_intro_tr" );
    }

    thread maps\greece_conf_center_fx::confcenterlightglowfx();
    var_0.frameviewmodel setanim( var_0.frameviewmodel maps\_utility::getanim( var_1 ) );
    var_0.barrelviewmodel setanim( var_0.barrelviewmodel maps\_utility::getanim( var_1 ) );
    var_4 maps\_anim::anim_single( var_5, var_1 );
    common_scripts\utility::flag_set( "FlagMonitorZoomOnHades" );
    thread monitorzoomonhades1();
    var_6 = getanimlength( level.scr_anim["sniper_drone_flight"][var_2][0] );
    var_4 thread maps\_anim::anim_loop( var_5, var_2, "end_loop" );

    while ( !common_scripts\utility::flag( "FlagContinueDroneFlyin" ) )
        wait(var_6);

    var_4 notify( "end_loop" );
    var_0 stopanimscripted();
    soundscripts\_snd::snd_message( "unmute_wasp_oneshots" );
    level notify( "audio_resume_moving_truck" );
    wait 0.05;
    var_0.frameviewmodel setanim( var_0.frameviewmodel maps\_utility::getanim( var_3 ) );
    var_0.barrelviewmodel setanim( var_0.barrelviewmodel maps\_utility::getanim( var_3 ) );
    var_4 maps\_anim::anim_single( var_5, var_3 );
    var_0 stopanimscripted();
    common_scripts\utility::flag_set( "FlagPlayerEndDroneFlight" );
    thread autosavesniperdronestealth( "conf_center_fly_in" );
    maps\_utility::add_extra_autosave_check( "ConfCenterAutosaveStealthCheck", ::autosaveconfcenterstealthcheck, "Can't autosave during sniperdrone stealth!" );
    common_scripts\utility::flag_clear( "FlagSniperDroneAnimating" );
}

truckdrivein( var_0 )
{
    var_1 = "flyin";
    var_2 = "flyin_end";
    var_3 = common_scripts\utility::getstruct( "DroneFlyInOrg", "targetname" );
    var_4 = getent( "BodyStashOrg", "targetname" );
    var_5 = getent( "delivery_truck", "targetname" );
    soundscripts\_snd::snd_message( "start_veh_moving_truck", var_5 );
    var_6 = maps\_utility::get_living_ai( "InfiltratorBurke", "script_noteworthy" );
    var_7 = [ var_5 ];
    var_5 hudoutlineenable( 2 );

    if ( var_0 == 0 )
    {
        var_3 maps\_anim::anim_single( var_7, var_1 );
        common_scripts\utility::flag_wait( "FlagContinueDroneFlyin" );
    }

    var_3 maps\_anim::anim_single( var_7, var_2 );
    var_8 = maps\_utility::get_living_ai( "Infiltrator1", "script_noteworthy" );
    var_9 = maps\_utility::get_living_ai( "Infiltrator2", "script_noteworthy" );
    var_8 show();
    var_9 show();
    var_6 show();
    var_10 = "bodystash_idle";
    var_4 thread maps\_anim::anim_loop_solo( var_6, var_10, "endBodystashIdle" );
    common_scripts\utility::flag_wait_any( "FlagBodyStashGuard1Killed", "FlagBodyStashGuard2Killed", "FlagBodyStashGuardsAlerted" );
    var_5 hudoutlinedisable();
}

sniperdroneflyintogglezoomnotetrack( var_0 )
{
    if ( common_scripts\utility::flag( "FlagForcePlayerADS" ) )
        common_scripts\utility::flag_clear( "FlagForcePlayerADS" );
    else
        common_scripts\utility::flag_set( "FlagForcePlayerADS" );

    level.confhades hudoutlineenable( 5, 0 );
    wait 3.0;
    level.confhades hudoutlinedisable();
}

truckstartwalknotetrack( var_0 )
{
    common_scripts\utility::flag_set( "FlagAllyVehicleDriveBy" );
}

progressionsupportphase1()
{
    level endon( "alarm_mission_end" );
    common_scripts\utility::flag_wait( "FlagBeginGateSetup" );
    maps\_hms_utility::printlnscreenandconsole( "--- Begin GATE ---" );
    setupvalidtargetsbyname( "EnemyPatrolGate" );
    common_scripts\utility::flag_wait_any( "FlagBodyStashGuard1Killed", "FlagBodyStashGuard2Killed", "FlagBodyStashGuardsAlerted" );
    level notify( "disableCourtyardCorpseDetection" );
    thread courtyardspecialdetection();

    if ( !common_scripts\utility::flag( "FlagCourtyardAnyOverwatchDead" ) )
        thread autosavesniperdronestealth( "conf_center_gate_start" );

    common_scripts\utility::flag_wait( "FlagAllGateGuardsDead" );

    if ( !common_scripts\utility::flag( "FlagCourtyardAnyOverwatchDead" ) )
        thread autosavesniperdronestealth( "conf_center_gate_end" );

    maps\_hms_utility::printlnscreenandconsole( "--- End GATE ---" );
    common_scripts\utility::flag_set( "FlagEndGateSetup" );
    maps\_hms_utility::printlnscreenandconsole( "Allies at GateExt!" );

    if ( !common_scripts\utility::flag( "FlagAllCourtyardGuardsDead" ) )
    {
        common_scripts\utility::flag_wait( "FlagBeginCourtyardSetup" );
        maps\_hms_utility::printlnscreenandconsole( "--- Begin COURTYARD ---" );
        thread setupplayertargets( "CourtyardPlayerTarget" );
        common_scripts\utility::flag_wait( "FlagAllCourtyardGuardsDead" );
    }

    common_scripts\utility::flag_wait( "FlagGateBreachComplete" );
    common_scripts\utility::flag_set( "FlagEndCourtyardSetup" );
    thread autosavesniperdronestealth( "conf_center_courtyard_end" );
    maps\_hms_utility::printlnscreenandconsole( "--- End COURTYARD ---" );
}

progressionsupportphase2()
{
    level endon( "alarm_mission_end" );
    level endon( "burke_killed" );
    common_scripts\utility::flag_wait( "FlagBeginWalkwaySetup" );
    thread atriumdoorsopenonalarm();
    maps\_hms_utility::printlnscreenandconsole( "--- Begin WALKWAY ---" );
    thread burkecourtyardboostjump();
    thread allywalkwaykill();
    thread allypoolsetup();
    thread atriumbreachmonitoralliesinposition();
    common_scripts\utility::flag_wait_either( "FlagAllWalkwayGuardsDead", "FlagWalkwayAlliesPerformKill" );
    thread autosavesniperdronestealth( "conf_center_walkway_end" );
    maps\_hms_utility::printlnscreenandconsole( "--- End WALKWAY ---" );
    common_scripts\utility::flag_set( "FlagEndWalkwaySetup" );
    common_scripts\utility::flag_wait( "FlagBeginStruggleSetup" );
    thread autosavesniperdronestealth( "conf_center_struggle_start" );
    maps\_hms_utility::printlnscreenandconsole( "--- Begin STRUGGLE ---" );
    thread allysetupstruggle();
    common_scripts\utility::flag_wait( "FlagStruggleGuardAttacks" );
    wait 2.0;
    thread setupplayertargets( "StrugglePlayerTarget", 1, 0 );
    maps\_utility::waittill_dead( level.playertargets );
    common_scripts\utility::flag_wait( "FlagStruggleBurkeRecovers" );
    thread autosavesniperdronestealth( "conf_center_struggle_end" );
    maps\_hms_utility::printlnscreenandconsole( "--- End STRUGGLE ---" );
    common_scripts\utility::flag_set( "FlagEndStruggleSetup" );

    if ( !common_scripts\utility::flag( "FlagAllPoolGuardsDead" ) )
    {
        thread allyredirectnoteworthy( "InfiltratorBurke", "Pool" );
        common_scripts\utility::flag_wait( "FlagBeginPoolSetup" );
        maps\_hms_utility::printlnscreenandconsole( "--- Begin POOL ---" );
        level notify( "disablePoolCorpseDetection" );
        thread setupplayertargets( "PoolPlayerTarget" );
        thread setuppoolallytargets();
        common_scripts\utility::flag_wait( "FlagAllPoolGuardsDead" );
        thread autosavesniperdronestealth( "conf_center_pool_end" );
        maps\_hms_utility::printlnscreenandconsole( "--- End POOL ---" );
    }

    common_scripts\utility::flag_set( "FlagEndPoolSetup" );
    atriumbreachidleburke( 0 );
    atriumbreachidleinfiltrators( 0 );
}

progressionsupportphase3()
{
    level endon( "alarm_mission_end" );
    common_scripts\utility::flag_wait( "FlagAtriumAlliesReadyToBreach" );
    common_scripts\utility::flag_wait( "FlagBeginAtriumSetup" );
    maps\_hms_utility::printlnscreenandconsole( "--- Begin ATRIUM ---" );
    setupvalidtargetsbyname( "EnemyPatrolAtrium" );
    thread setobjatrium();
    thread monitorplayershootfirstatrium();
    thread monitorplayerlookingatatrium();
    thread monitoratriumfighttimer();
    thread alliesbreachatriumonalarm();
    common_scripts\utility::flag_wait( "FlagAtriumAlliesPerformBreach" );
    soundscripts\_snd::snd_message( "start_atrium_breach_music" );
    thread alliesbreachatrium();
    common_scripts\utility::flag_wait( "FlagAtriumEnemiesAllMarked" );
    monitoratriumenemieskilled();
    thread autosavesniperdronestealth( "conf_center_atrium_start" );
    maps\_hms_utility::printlnscreenandconsole( "--- End ATRIUM  ---" );
    common_scripts\utility::flag_set( "FlagEndAtriumSetup" );
    thread alliesexitatrium();

    if ( !common_scripts\utility::flag( "FlagAllRooftopGuardsDead" ) )
    {
        common_scripts\utility::flag_wait( "FlagBeginRooftopSetup" );
        maps\_hms_utility::printlnscreenandconsole( "--- Begin ROOFTOP ---" );
        thread setupplayertargets( "RooftopPlayerTarget" );
        maps\_utility::waittill_dead( level.playertargets );
        thread autosavesniperdronestealth( "conf_center_rooftop_end" );
        maps\_hms_utility::printlnscreenandconsole( "--- End ROOFTOP ---" );
    }

    common_scripts\utility::flag_set( "FlagEndRooftopSetup" );

    if ( !common_scripts\utility::flag( "FlagAllParkingGuardsDead" ) )
    {
        common_scripts\utility::flag_wait( "FlagBeginParkingSetup" );
        maps\_hms_utility::printlnscreenandconsole( "--- Begin PARKING ---" );
        thread alliesparkingkillalt();
        markparkingcars();
        common_scripts\utility::flag_wait( "FlagAllParkingGuardsDead" );
        _caralarmstop();
        thread autosavesniperdronestealth( "conf_center_parking_end" );
        maps\_hms_utility::printlnscreenandconsole( "--- End PARKING ---" );
    }

    common_scripts\utility::flag_set( "FlagEndParkingSetup" );
}

alliesbreachatriumonalarm()
{
    level waittill( "alarm_mission_end" );

    if ( common_scripts\utility::flag( "FlagAtriumAlliesReadyToBreach" ) && !common_scripts\utility::flag( "FlagAtriumAlliesPerformBreach" ) )
        thread alliesbreachatrium();
}

setobjatrium()
{
    level endon( "alarm_mission_end" );
    var_0 = getent( "PlayerDroneLookAt3", "targetname" );
    objective_position( maps\_utility::obj( "DroneSupport" ), var_0.origin );
    objective_setpointertextoverride( maps\_utility::obj( "DroneSupport" ), &"GREECE_OBJ_ATRIUM_POINTER" );
    common_scripts\utility::flag_wait_either( "FlagPlayerLookingAtAtrium", "FlagPlayerShootFirstAtrium" );
    objective_position( maps\_utility::obj( "DroneSupport" ), ( 0, 0, 0 ) );
    objective_setpointertextoverride( maps\_utility::obj( "DroneSupport" ), " " );
}

alliesexitatrium()
{
    thread allyredirectnoteworthy( "InfiltratorBurke", "AtriumExit" );
    thread atriumboostjump();
    maps\greece_code::waittillaiarrayneargoal( level.allyinfiltrators );
    thread burkeopenatriumexitdoor();
    common_scripts\utility::flag_wait( "FlagAtriumAlliesExit" );

    if ( !common_scripts\utility::flag( "FlagAnyParkingGuardsDead" ) )
        thread autosavesniperdronestealth( "conf_center_atrium_end" );

    thread alliesparkingsetup();
}

burkeopenatriumexitdoor()
{
    var_0 = level.infiltratorburke thread maps\_hms_door_interact::opendoor( "AtriumExitDoorStruct", "slow" );
    var_1 = getent( "AtriumExitDoorClip", "targetname" );
    var_1 delete();
    var_0 waittill( "Open" );
    common_scripts\utility::flag_set( "FlagAtriumAlliesExit" );
    thread allyburkeparkingsetup();
}

monitorplayerlookingatatrium()
{
    level endon( "SniperdroneAtriumPlayerFirstShot" );
    level endon( "alarm_mission_end" );
    var_0 = getent( "AtriumPlayerLookAtTarget", "targetname" );
    waittillplayerlookattargetintrigger( var_0, "TriggerAtriumPlayer", 30, 0 );
    common_scripts\utility::flag_set( "FlagPlayerLookingAtAtrium" );
}

monitorplayershootfirstatrium()
{
    level endon( "SniperdroneAtriumPlayerSignalBreach" );
    level endon( "alarm_mission_end" );
    var_0 = maps\_utility::get_living_ai_array( "EnemyPatrolAtrium_AI", "targetname" );

    foreach ( var_2 in var_0 )
        var_2.noalarm = 1;

    waittillaiarraydeadoralerted( var_0, 1 );
    level notify( "SniperdroneAtriumPlayerFirstShot" );
    common_scripts\utility::flag_set( "FlagPlayerShootFirstAtrium" );
}

waittillaiarraydeadoralerted( var_0, var_1, var_2 )
{
    var_3 = [];

    foreach ( var_5 in var_0 )
    {
        if ( isalive( var_5 ) && !var_5.ignoreforfixednodesafecheck )
            var_3[var_3.size] = var_5;
    }

    var_0 = var_3;
    var_7 = spawnstruct();

    if ( isdefined( var_2 ) )
    {
        var_7 endon( "thread_timed_out" );
        var_7 thread maps\_utility::waittill_dead_timeout( var_2 );
    }

    var_7.count = var_0.size;

    if ( isdefined( var_1 ) && var_1 < var_7.count )
        var_7.count = var_1;

    common_scripts\utility::array_thread( var_0, ::waittilldeadoralertedthread, var_7 );

    while ( var_7.count > 0 )
        var_7 waittill( "waittill_dead_guy_dead_or_alerted" );
}

waittilldeadoralertedthread( var_0 )
{
    common_scripts\utility::waittill_any( "death", "pain_death", "guy_alerted" );
    var_0.count--;
    var_0 notify( "waittill_dead_guy_dead_or_alerted" );
}

disablealliescolor()
{
    foreach ( var_1 in level.allyinfiltrators )
        var_1 maps\_utility::disable_ai_color();
}

enablealliescolor()
{
    foreach ( var_1 in level.allyinfiltrators )
        var_1 maps\_utility::enable_ai_color();
}

atriumboostjump()
{
    var_0 = common_scripts\utility::getstruct( "Infiltrator1AtriumBoostJumpOrg", "targetname" );
    var_1 = common_scripts\utility::getstruct( "Infiltrator2AtriumBoostJumpOrg", "targetname" );
    var_2 = maps\_utility::get_living_ai( "Infiltrator1", "script_noteworthy" );
    var_3 = maps\_utility::get_living_ai( "Infiltrator2", "script_noteworthy" );
    thread atriumboostjumpguy( var_2, var_0 );
    thread atriumboostjumpguy( var_3, var_1 );
}

atriumboostjumpguy( var_0, var_1 )
{
    var_0 maps\greece_code::clear_set_goal();
    waitframe();
    var_2 = "atrium_boost_jump";
    var_1 maps\_anim::anim_reach_solo( var_0, var_2 );
    var_1 maps\_anim::anim_single_solo_run( var_0, var_2 );
    thread allyredirectnoteworthy( var_0.script_noteworthy, "AtriumExit" );
}

progressionkillhades()
{
    common_scripts\utility::flag_wait( "FlagBeginConfCenterKill" );
    level.confhades hudoutlineenable( 5, 0 );
    alliesbreachconfroom();
    common_scripts\utility::flag_set( "FlagConfRoomAlliesExit" );
}

progressioncombat()
{
    common_scripts\utility::flag_wait_either( "FlagBeginConfCenterCombat", "FlagConfRoomAlliesRecover" );
    maps\_utility::battlechatter_on( "allies" );
    maps\_utility::battlechatter_on( "axis" );
    thread monitorplayeractivity();
    thread spawnenemiesambusherssouth();
    level.player maps\_utility::set_ignoreme( 1 );
    maps\_utility::remove_extra_autosave_check( "ConfCenterAutosaveStealthCheck" );
    thread confcentervehiclesvulnerable();
    waitframe();
    thread maps\_utility::autosave_by_name( "conf_center_combat" );
    maps\_utility::add_extra_autosave_check( "ConfCenterAutosaveCombatCheck", ::autosaveconfcentercombatcheck, "Can't autosave during sniperdrone combat!" );
    common_scripts\utility::flag_wait( "FlagConfRoomAlliesRecover" );
    thread alliesparkingdefend();
    common_scripts\utility::flag_wait( "FlagSomeAmbushSouthGuardsDead" );
    resetvulnerabletimers();
    thread spawnenemiesambusherseast();
    thread spawnenemyambushvehicle();
}

progressionoutro()
{
    common_scripts\utility::flag_wait( "FlagBeginConfCenterOutro" );
    resetvulnerabletimers();
    wait 10.0;
    var_0 = getent( "HadesEscapePlayerLookAtTarget", "targetname" );
    thread maps\_utility::autosave_by_name( "conf_center_outro" );
    waittillplayerlookattargetintrigger( var_0, "TriggerHadesEscapePlayer", 30, 0, 20 );
    level.player maps\_utility::set_ignoreme( 0 );
    level notify( "HadesVehicleDriveStart" );
    maps\_utility::remove_extra_autosave_check( "ConfCenterAutosaveCombatCheck" );
    common_scripts\utility::flag_set( "FlagHadesVehicleDriveStart" );

    foreach ( var_2 in level.allyinfiltrators )
    {
        if ( isdefined( var_2 ) )
        {
            if ( !isdefined( var_2.magic_bullet_shield ) || var_2.magic_bullet_shield == 0 )
                var_2 thread maps\_utility::magic_bullet_shield( 1 );
        }
    }
}

setupplayertargets( var_0, var_1, var_2 )
{
    var_3 = [];
    var_4 = [];
    var_4 = getaiarray( "axis" );

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( !isdefined( var_2 ) )
        var_2 = 1;

    foreach ( var_6 in var_4 )
    {
        if ( isalive( var_6 ) && isdefined( var_6.script_noteworthy ) )
        {
            if ( common_scripts\utility::string_starts_with( var_6.script_noteworthy, var_0 ) )
                var_3 = common_scripts\utility::add_to_array( var_3, var_6 );
        }
    }

    level.playertargets = maps\_utility::array_removedead( level.playertargets );
    level.playertargets = maps\_utility::array_merge( var_3, level.playertargets );

    foreach ( var_9 in var_3 )
    {
        if ( isalive( var_9 ) )
            var_9 thread markplayertarget( var_1, var_2 );
    }
}

markplayertarget( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    if ( var_0 == 1 )
        maps\greece_code::setalertoutline();
    else
        maps\greece_code::settargetoutline();

    var_2 = undefined;

    for ( var_3 = 0; var_3 < level.playertargets.size; var_3++ )
    {
        if ( self == level.playertargets[var_3] )
            var_2 = var_3;
    }

    var_4 = var_2 + 1;

    if ( var_1 == 1 )
        thread objmarkerplayertarget( var_4 );
}

monitormarkedplayertarget( var_0, var_1 )
{
    level endon( "end_sniper_drone" );
    self endon( "death" );
    self endon( "dying" );
    self endon( "guy_alerted" );
    self endon( "removeTargetObj" );
    wait 0.1;

    if ( var_1 == 1 )
        thread objmarkerplayertarget( var_0 );
}

objmarkerplayertarget( var_0 )
{
    objective_setpointertextoverride( maps\_utility::obj( "DroneSupport" ), " " );
    wait 0.05;
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1 linkto( self, "TAG_EYE", ( 0, 0, 12 ), ( 0, 0, 0 ) );
    objective_additionalentity( maps\_utility::obj( "DroneSupport" ), var_0, var_1 );
    common_scripts\utility::waittill_any( "death", "dying", "removeTargetObj" );
    objective_additionalposition( maps\_utility::obj( "DroneSupport" ), var_0, ( 0, 0, 0 ) );
    var_1 delete();
}

removeplayertarget()
{
    self notify( "removeTargetObj" );
    level.playertargets common_scripts\utility::array_remove( level.playertargets, self );

    if ( target_istarget( self ) )
        target_remove( self );

    self hudoutlineenable( 1, 1 );
}

clearplayertargetlist()
{
    level.playertargets = maps\_utility::array_removedead( level.playertargets );

    foreach ( var_1 in level.playertargets )
        level.playertargets = common_scripts\utility::array_remove( level.playertargets, var_1 );
}

objmarkervehicle( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( var_1 == 1 )
    {
        objective_onentity( maps\_utility::obj( "DroneSupport" ), self, ( 0, 0, 64 ) );
        objective_setpointertextoverride( maps\_utility::obj( "DroneSupport" ), &"GREECE_OBJ_HADES_POINTER" );
    }

    thread objoutlinevehicle( var_2, var_0 );
    common_scripts\utility::flag_wait( var_0 );
    level notify( var_0 );
    self hudoutlinedisable();

    if ( var_1 == 1 )
        objective_position( maps\_utility::obj( "DroneSupport" ), ( 0, 0, 0 ) );
}

objoutlinevehicle( var_0, var_1 )
{
    level endon( var_1 );

    if ( var_0 == 1 )
        wait 20.0;

    if ( level.nextgen )
        self hudoutlineenable( 1, 1 );
    else
    {
        foreach ( var_3 in level.sniper_marked_cars )
            var_3 hudoutlineenable( 1, 1 );
    }
}

spawnconfcenterai()
{
    setsaveddvar( "r_hudoutlineenable", 1 );
    spawnallyinfiltrators();
    thread spawnhadesescapevehicle();
    var_0 = level.start_point;

    if ( !common_scripts\utility::string_starts_with( var_0, "start_conf_center_" ) || var_0 == "start_conf_center_intro" || var_0 == "start_conf_center_support1" || var_0 == "start_conf_center_support2" || var_0 == "start_conf_center_support3" || var_0 == "start_conf_center_kill" || var_0 == "start_conf_center_combat" )
    {
        if ( var_0 != "start_conf_center_support2" && var_0 != "start_conf_center_support3" && var_0 != "start_conf_center_kill" && var_0 != "start_conf_center_combat" )
        {
            spawnenemiespatrollersa();
            thread progressionsupportphase1();
        }

        if ( var_0 != "start_conf_center_support3" && var_0 != "start_conf_center_kill" && var_0 != "start_conf_center_combat" )
        {
            spawnenemiespatrollersb();
            thread progressionsupportphase2();
        }

        if ( var_0 != "start_conf_center_kill" && var_0 != "start_conf_center_combat" )
        {
            spawnenemiespatrollersc();
            thread progressionsupportphase3();
        }

        if ( var_0 != "start_conf_center_combat" )
        {
            thread monitorlevelalarm();
            thread monitorconfroomwindows();
            thread confroomsetup();
        }

        thread progressioncombat();
    }

    thread spawnenemiesextra();
    thread progressionoutro();
    initconfcenterstealthsettings();
    initalerttime();
}

spawnallyinfiltrators()
{
    maps\_utility::array_spawn_function_targetname( "AllyInfiltrator", ::thinkallyinfiltrator );
    level.allyinfiltrators = maps\_utility::array_spawn_targetname( "AllyInfiltrator" );
    level.allyinfiltrators = maps\_utility::array_index_by_script_index( level.allyinfiltrators );
    level.infiltratorburke = level.allyinfiltrators[0];
    level.infiltratorburke.name = "Gideon";
    level.infiltratorburke.animname = "infiltratorburke";
    level.infiltratorburke.script_parameters = "Gideon";
    level.infiltratorburke maps\_utility::forceuseweapon( "iw5_bal27_sp_silencer01", "primary" );
    level.allyinfiltrators[1] maps\_utility::forceuseweapon( "iw5_bal27_sp_silencer01", "primary" );
    level.allyinfiltrators[1].name = "Drelick";
    level.allyinfiltrators[1].animname = "infiltrator1";
    level.allyinfiltrators[1].script_parameters = "Drelick";
    level.allyinfiltrators[2] maps\_utility::forceuseweapon( "iw5_bal27_sp_silencer01", "primary" );
    level.allyinfiltrators[2].name = "Baron";
    level.allyinfiltrators[2].animname = "infiltrator2";
    level.allyinfiltrators[2].script_parameters = "Baron";
    wait 0.05;
    var_0 = level.start_point;

    if ( var_0 == "start_conf_center_support1" )
        alliesdrivein( 0, 1 );
    else if ( var_0 == "start_conf_center_support2" )
    {
        thread alliesredirect( "GateInt", 0, 1 );
        markallies();
        wait 0.05;
        alliesdrivein( 1, 0 );
    }
    else if ( var_0 == "start_conf_center_support3" )
    {
        atriumbreachidleinfiltrators( 1 );
        atriumbreachidleburke( 1 );
        markallies();
        wait 0.05;
        common_scripts\utility::flag_set( "FlagAtriumAlliesReadyToBreach" );
        alliesdrivein( 1, 0 );
    }
    else if ( var_0 == "start_conf_center_kill" )
    {
        thread alliesredirect( "ParkingStairs1", 0, 1 );
        markallies();
        alliesdrivein( 1, 0 );
    }
    else if ( var_0 == "start_conf_center_combat" )
    {
        allyconfroomdeath( 1 );
        thread alliesredirect( "ConfRoomExit", 0, 1 );
        markallies();
        alliesdrivein( 1, 0 );
    }
    else if ( var_0 == "start_conf_center_outro" )
    {
        allyconfroomdeath( 1 );
        thread alliesredirect( "ParkingEnd", 0, 1 );
        maps\_utility::activate_trigger_with_targetname( "TrigBurke107" );
        maps\_utility::activate_trigger_with_targetname( "TrigAllies107" );
        markallies();
        alliesdrivein( 1, 0 );
    }
    else
        thread alliesdrivein( 0, 0 );
}

spawnenemiespatrollersa()
{
    maps\_utility::array_spawn_function_targetname( "EnemyPatrolGate", ::thinkpatrolenemy );
    var_0 = maps\_utility::array_spawn_targetname( "EnemyPatrolGate" );
    level.allenemypatrollers = maps\_utility::array_merge( var_0, level.allenemypatrollers );
    thread enemypatrolgatethread( var_0 );
    maps\_utility::array_spawn_function_targetname( "EnemyPatrolCourtyard", ::thinkpatrolenemy );
    var_1 = maps\_utility::array_spawn_targetname( "EnemyPatrolCourtyard" );
    level.allenemypatrollers = maps\_utility::array_merge( var_1, level.allenemypatrollers );
    thread enemypatrolcourtyardthread( var_1 );
    setupvalidtargetsbyarray( var_1 );
}

spawnenemiespatrollersb()
{
    maps\_utility::array_spawn_function_targetname( "EnemyPatrolWalkway", ::thinkpatrolenemy );
    var_0 = maps\_utility::array_spawn_targetname( "EnemyPatrolWalkway" );
    level.allenemypatrollers = maps\_utility::array_merge( var_0, level.allenemypatrollers );
    thread enemypatrolwalkwaythread( var_0 );
    setupvalidtargetsbyarray( var_0 );
    maps\_utility::array_spawn_function_targetname( "EnemyPatrolPool", ::thinkpatrolenemy );
    var_1 = maps\_utility::array_spawn_targetname( "EnemyPatrolPool" );
    level.allenemypatrollers = maps\_utility::array_merge( var_1, level.allenemypatrollers );
    thread enemypatrolpoolthread( var_1 );
    setupvalidtargetsbyarray( var_1 );
}

spawnenemiespatrollersc()
{
    maps\_utility::array_spawn_function_targetname( "EnemyPatrolAtrium", ::thinkpatrolenemy );
    var_0 = maps\_utility::array_spawn_targetname( "EnemyPatrolAtrium" );
    level.allenemypatrollers = maps\_utility::array_merge( var_0, level.allenemypatrollers );
    thread enemypatrolatriumthread( var_0 );
    maps\_utility::array_spawn_function_targetname( "EnemyPatrolRooftop", ::thinkpatrolenemy );
    var_1 = maps\_utility::array_spawn_targetname( "EnemyPatrolRooftop" );
    level.allenemypatrollers = maps\_utility::array_merge( var_1, level.allenemypatrollers );
    thread enemypatrolrooftopthread( var_1 );
    setupvalidtargetsbyarray( var_1 );
    maps\_utility::array_spawn_function_targetname( "EnemyPatrolParking", ::thinkpatrolenemy );
    var_2 = maps\_utility::array_spawn_targetname( "EnemyPatrolParking" );
    level.allenemypatrollers = maps\_utility::array_merge( var_2, level.allenemypatrollers );
    thread enemypatrolparkingthread( var_2 );
    setupvalidtargetsbyarray( var_2 );
}

spawnenemiesextra()
{
    maps\_utility::array_spawn_function_targetname( "EnemyPatrolExtra", ::thinkpatrolenemy );
    var_0 = maps\_utility::array_spawn_targetname( "EnemyPatrolExtra" );
    level.allenemypatrollers = maps\_utility::array_merge( var_0, level.allenemypatrollers );
    setupvalidtargetsbyarray( var_0 );
    thread maps\greece_code::aiarrayidleloop( var_0 );

    foreach ( var_2 in var_0 )
    {
        var_2 maps\_utility::set_ignoreall( 1 );
        var_2 maps\_utility::set_ignoreme( 1 );
    }

    common_scripts\utility::flag_wait_either( "FlagConfRoomExplosion", "FlagBeginConfCenterCombat" );
    var_0 = maps\_utility::array_removedead_or_dying( var_0 );
    level.allenemyambushers = maps\_utility::array_merge( var_0, level.allenemyambushers );

    foreach ( var_2 in var_0 )
    {
        if ( var_2.script_noteworthy == "ExtraPlayerTarget3" )
        {
            var_2 kill();
            continue;
        }

        var_2 thread extraenemiescombat();
    }
}

extraenemiescombat()
{
    self endon( "death" );
    maps\_utility::enable_arrivals();
    maps\_utility::enable_exits();
    maps\greece_code::enableawareness();
    maps\_utility::clear_run_anim();
    maps\_stealth_utility::disable_stealth_for_ai();
    self notify( "end_patrol" );
    self notify( "new_anim_reach" );
    disableenemyalert();
    thread notifyonplayerkill();
    self notify( "guy_alerted" );
    waitframe();
    maps\_utility::set_ignoreall( 0 );
    maps\_utility::set_ignoreme( 0 );
    self.enemyteam = "allies";
    self.alertlevel = "combat";
    self.combatmode = "cover";
    aiidleloopdisable( 1 );
    thread maps\_utility::set_battlechatter( 1 );
    var_0 = maps\_utility::get_closest_ai( self.origin, self.enemyteam );

    if ( isdefined( var_0 ) )
        maps\_utility::set_favoriteenemy( var_0 );

    var_1 = getent( "EnemyAmbushParkingVol", "targetname" );
    self setgoalvolumeauto( var_1 );
    common_scripts\utility::flag_wait_either( "FlagBeginConfCenterCombat", "FlagConfRoomAlliesRecover" );
    maps\greece_code::setalertoutline();
    markdronetargetenemy();
    thread maps\greece_code::clearalertoutline();
    common_scripts\utility::flag_wait( "FlagSomeAmbushSouthGuardsDead" );
    var_1 = getent( "EnemyAmbushEastFallbackVol", "targetname" );
    self setgoalvolumeauto( var_1 );
}

spawnenemystruggle()
{
    var_0 = getent( "EnemyPatrolStruggle", "targetname" );
    var_0 maps\_utility::add_spawn_function( ::thinkpatrolenemy );
    var_1 = var_0 maps\_utility::spawn_ai( 1 );
    var_1 maps\_utility::set_ignoreme( 1 );
    var_1.no_stopanimscripted = 1;
    var_1 maps\_stealth_utility::disable_stealth_for_ai();
    var_1 maps\_utility::disable_danger_react();
    var_1 maps\_utility::disable_bulletwhizbyreaction();
    var_1 maps\_utility::forceuseweapon( "iw5_uts19_sp", "primary" );
    level.allenemypatrollers = common_scripts\utility::add_to_array( level.allenemypatrollers, var_1 );
    return var_1;
}

spawnenemiesambusherssouth()
{
    wait 3.0;
    maps\_utility::array_spawn_function_targetname( "EnemyAmbushSouth", ::thinkambushenemy );
    var_0 = maps\_utility::array_spawn_targetname( "EnemyAmbushSouth" );
    thread enemyambushsouthopendoors();
    var_1 = maps\_utility::get_living_ai_array( "EnemyPatrolExtra_AI", "targetname" );
    var_0 = maps\_utility::array_merge( var_1, var_0 );
    level.allenemyambushers = maps\_utility::array_merge( var_0, level.allenemyambushers );

    foreach ( var_3 in var_0 )
    {
        var_3.oldfightdist = var_3.pathenemyfightdist;
        var_3.pathenemyfightdist = 8;
    }

    var_0 = maps\_utility::array_removedead_or_dying( var_0 );
    waittillenemiesreducedto( 3, var_0 );
    common_scripts\utility::flag_set( "FlagSomeAmbushSouthGuardsDead" );
    var_0 = maps\_utility::array_removedead_or_dying( var_0 );

    foreach ( var_3 in var_0 )
    {
        var_3.pathenemyfightdist = var_3.oldfightdist;
        var_3 thread enemyambushsouthshiftvol();
    }
}

enemyambushsouthopendoors()
{
    var_0 = getentarray( "SouthDoorClip", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 delete();

    var_4 = getentarray( "EnemyAmbushSouthDoor", "targetname" );

    foreach ( var_6 in var_4 )
    {
        if ( var_6.script_noteworthy == "SouthDoor1" )
            var_7 = 120;
        else
            var_7 = -120;

        var_8 = randomfloatrange( 0.25, 0.45 );
        var_6 rotateto( var_6.angles + ( 0, var_7, 0 ), var_8, 0, 0.2 );
    }
}

enemyambushsouthshiftvol()
{
    self endon( "death" );

    if ( self.script_noteworthy == "Low" )
    {
        var_0 = getent( "EnemyAmbushEastFallbackVol", "targetname" );
        self setgoalvolumeauto( var_0 );
    }
    else if ( self.script_noteworthy == "Stairs" )
    {
        var_0 = getent( "EnemyAmbushBridgeVol", "targetname" );
        self setgoalvolumeauto( var_0 );
    }
    else if ( self.script_noteworthy == "High" )
    {
        var_0 = getent( "EnemyAmbushSouthHighVol1", "targetname" );
        self setgoalvolumeauto( var_0 );
    }

    self.health = 1;
}

spawnenemiesambusherseast()
{
    maps\_utility::array_spawn_function_targetname( "EnemyAmbushEast", ::thinkambushenemy );
    var_0 = maps\_utility::array_spawn_targetname( "EnemyAmbushEast" );
    level.allenemyambushers = maps\_utility::array_merge( var_0, level.allenemyambushers );
    thread enemyambusheastopendoors();
    wait 1;
    var_1 = [];
    var_2 = maps\_utility::get_living_ai_array( "EnemyAmbushVehicleOperators", "script_noteworthy" );
    var_1 = maps\_utility::array_merge( var_1, var_2 );
    var_3 = maps\_utility::get_living_ai_array( "EnemyAmbushEast_AI", "targetname" );
    var_1 = maps\_utility::array_merge( var_1, var_3 );
    waittillenemiesreducedto( 3, var_1 );
    common_scripts\utility::flag_set( "FlagAllAmbushGuardsDead" );
    common_scripts\utility::flag_wait( "FlagSpawnEnemyReinforcements" );
    var_0 = maps\_utility::array_removedead_or_dying( var_0 );
    var_4 = maps\_utility::get_living_ai_array( "EnemyAmbushVehicleOperators", "script_noteworthy" );
    var_5 = maps\_utility::array_merge( var_0, var_4 );
    var_6 = getent( "EnemyAmbushEastFallbackVol", "targetname" );

    foreach ( var_8 in var_5 )
    {
        var_8 setgoalvolumeauto( var_6 );
        var_8.health = 1;
    }
}

enemyambusheastopendoors()
{
    var_0 = getent( "EastDoorStartClip", "targetname" );
    var_0 delete();
    var_1 = getentarray( "EastDoorEndClip", "targetname" );

    foreach ( var_3 in var_1 )
    {
        var_3 movez( 1024, 0.1 );
        var_3 disconnectpaths();
    }

    var_5 = getentarray( "EnemyAmbushEastDoor", "targetname" );

    foreach ( var_7 in var_5 )
    {
        if ( var_7.script_noteworthy == "EastDoor1" )
            var_8 = -150;
        else
            var_8 = 100;

        var_9 = randomfloatrange( 0.25, 0.45 );
        var_7 rotateto( var_7.angles + ( 0, var_8, 0 ), var_9, 0, 0.2 );
    }
}

spawnenemyambushvehicle()
{
    var_0 = "EnemyAmbushVehicleOperators";
    maps\_utility::array_spawn_function_noteworthy( var_0, ::thinkambushenemy );
    thread enemyambushvehiclebadplace();
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "EnemyAmbushVehicle" );
    var_1 soundscripts\_snd::snd_message( "mhunt_cc_assault_veh_01_approach" );
    var_1.veh_pathtype = "constrained";
    level.allenemyvehicles = common_scripts\utility::add_to_array( level.allenemyvehicles, var_1 );
    var_1 markdronetargetvehicle();

    if ( level.currentgen )
        var_1 thread maps\greece_code::tff_cleanup_vehicle( "confcenter" );

    var_2 = [];

    foreach ( var_4 in var_1.riders )
    {
        level.allenemyambushers = common_scripts\utility::add_to_array( level.allenemyambushers, var_4 );
        var_2 = common_scripts\utility::add_to_array( var_2, var_4 );
        var_4 markdronetargetenemy();
        var_4 thread enemyvehicleguyfallback();
    }

    var_1 enemyvehicleturretthread();
    common_scripts\utility::flag_set( "FlagEnemyVehicleTurretDisabled" );

    if ( isdefined( var_1 ) )
        var_1 unmarkandremoveoutline( 0.0 );
}

enemyvehicleguyfallback()
{
    self endon( "death" );
    common_scripts\utility::flag_wait( "FlagSpawnEnemyReinforcements" );
    var_0 = getent( "EnemyAmbushEastFallbackVol", "targetname" );
    self setgoalvolumeauto( var_0 );
    self.health = 1;
}

waittillenemiesreducedto( var_0, var_1 )
{
    for (;;)
    {
        maps\_utility::waittill_dead_or_dying( var_1, 1 );
        var_1 = maps\_utility::array_removedead_or_dying( var_1 );

        if ( var_1.size <= var_0 )
            break;

        wait 0.1;
    }
}

enemyvehicleturretthread()
{
    self endon( "death" );
    level endon( "FlagAllAmbushEastGuardsDead" );
    var_0 = self.mgturret[0];
    var_0 setturretteam( "axis" );
    soundscripts\_snd::snd_message( "cc_technical_turret_fire", var_0 );
    var_1 = undefined;

    foreach ( var_3 in self.riders )
    {
        if ( var_3.vehicle_position == 1 )
            var_1 = var_3;
    }

    var_1 endon( "death" );
    var_1.ignoreall = 1;
    var_0 turretfiredisable();
    var_5 = undefined;
    var_6 = getentarray( "ParkingAlarmCar", "targetname" );

    foreach ( var_8 in var_6 )
    {
        if ( isdefined( var_8.script_parameters ) && var_8.script_parameters == "BlowUp" )
            var_5 = var_8;
    }

    var_10 = getent( "AmbushVehicleTarget", "targetname" );
    common_scripts\utility::flag_wait( "FlagEnemyVehicleActivateTurret" );
    var_1.ignoreall = 0;
    var_0 turretfireenable();
    var_0 setaispread( 2 );
    var_0 setconvergencetime( 2 );
    var_5 thread enemyturrettargetcar( var_0, var_10 );
    maps\_hms_utility::printlnscreenandconsole( "Enemy vehicle turret is now using normal AI" );
    thread enemyturretfire( var_0, var_1 );
    var_11 = [];
    var_11 = level.allyinfiltrators;

    for (;;)
    {
        var_12 = common_scripts\utility::array_randomize( var_11 );

        if ( isdefined( var_12[0] ) )
        {
            var_1 maps\_utility::set_favoriteenemy( var_12[0] );
            var_0 settargetentity( var_12[0] );
        }

        wait(randomfloatrange( 3.0, 8.0 ));
    }
}

enemyturretfire( var_0, var_1 )
{
    var_1 endon( "death" );
    self endon( "death" );
    level endon( "StartDroneStatic" );
    var_2 = "tag_flash2";

    for (;;)
    {
        var_0 waittill( "turret_fire" );
        waitframe();
        var_3 = var_0 gettagorigin( var_2 );
        magicbullet( "50cal_turret_technical_lagos", var_3, var_3 + anglestoforward( var_0 gettagangles( var_2 ) ) * 100 );
        playfx( common_scripts\utility::getfx( "technical_muzzle_flash" ), var_3, anglestoforward( var_0 gettagangles( var_2 ) ) );
    }
}

enemyturrettargetcar( var_0, var_1 )
{
    if ( isdefined( self ) )
    {
        self endon( "death" );
        self waittill( "damage" );
        wait(randomfloatrange( 2.0, 3.0 ));
        maps\_hms_utility::printlnscreenandconsole( "Force destruction of turret target car" );
        maps\_vehicle::vehicle_set_health( 1 );
        wait 0.05;
        soundscripts\_snd::snd_message( "mhunt_cc_parked_car_expl" );
        radiusdamage( var_1.origin, 100, 10, 1 );
        physicsexplosionsphere( var_1.origin, 100, 80, 1 );
    }
}

enemyambushvehiclebadplace()
{
    var_0 = getent( "AmbushVehicleBadPlaceVol", "targetname" );
    badplace_brush( "AmbushVehicleBadPlaceVol", -1, var_0, "axis" );
    common_scripts\utility::flag_wait( "FlagEnemyVehiclePathEnd" );
    badplace_delete( "AmbushVehicleBadPlaceVol" );
}

hadesvehiclebadplace()
{
    var_0 = getent( "HadesVehicleBadPlaceVol", "targetname" );
    badplace_brush( "HadesVehicleBadPlaceVol", -1, var_0, "axis" );
    common_scripts\utility::flag_wait( "FlagPlayerEndDroneStatic" );
    badplace_delete( "HadesVehicleBadPlaceVol" );
}

spawnenemyreinforcementsvehicles()
{
    var_0 = "EnemyReinforcements1VehicleOperators";
    maps\_utility::array_spawn_function_noteworthy( var_0, ::thinkambushenemy );
    var_1 = "EnemyReinforcements2VehicleOperators";
    maps\_utility::array_spawn_function_noteworthy( var_1, ::thinkambushenemy );
    common_scripts\utility::flag_wait_either( "FlagSpawnEnemyReinforcements", "FlagBeginConfCenterOutro" );
    wait 1;
    var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "EnemyReinforcements1Vehicle" );
    var_2 soundscripts\_snd::snd_message( "mhunt_cc_assault_veh_02_approach" );
    var_2.veh_pathtype = "constrained";
    level.allenemyvehicles = common_scripts\utility::add_to_array( level.allenemyvehicles, var_2 );
    var_2 thread enemyreinforcementsvehicleturretthread();
    var_2 markdronetargetvehicle();
    var_3 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "EnemyReinforcements2Vehicle" );
    var_2 soundscripts\_snd::snd_message( "mhunt_cc_assault_veh_03_approach" );
    var_3.veh_pathtype = "constrained";
    level.allenemyvehicles = common_scripts\utility::add_to_array( level.allenemyvehicles, var_3 );
    var_3 thread enemyreinforcementsvehicleturretthread();
    var_3 markdronetargetvehicle();

    if ( level.currentgen )
    {
        var_2 thread maps\greece_code::tff_cleanup_vehicle( "confcenter" );
        var_3 thread maps\greece_code::tff_cleanup_vehicle( "confcenter" );
    }
}

enemyreinforcementsvehicleturretthread()
{
    level endon( "end_sniper_drone" );
    level endon( "StartDroneStatic" );
    self endon( "death" );

    foreach ( var_1 in self.riders )
        level.allenemyambushers = common_scripts\utility::add_to_array( level.allenemyambushers, var_1 );

    var_3 = self.mgturret[0];
    var_3 setturretteam( "axis" );
    var_3 turretfiredisable();
    soundscripts\_snd::snd_message( "cc_technical_turret_fire", var_3 );
    var_4 = undefined;

    foreach ( var_1 in self.riders )
    {
        if ( var_1.vehicle_position == 1 )
            var_4 = var_1;
    }

    var_4 endon( "death" );
    var_4.ignoreall = 1;
    var_4.battlechatter = 0;
    maps\_utility::ent_flag_wait( "unloaded" );
    var_4.ignoreall = 0;
    var_3 turretfireenable();
    var_3 setaispread( 10 );
    var_3 setconvergencetime( 2 );
    thread enemyturretfire( var_3, var_4 );
    var_7 = [];
    var_7 = level.allyinfiltrators;

    for (;;)
    {
        var_8 = common_scripts\utility::array_randomize( var_7 );

        if ( isdefined( var_8[0] ) )
        {
            var_4 maps\_utility::set_favoriteenemy( var_8[0] );
            var_3 settargetentity( var_8[0] );
        }

        wait(randomfloatrange( 3.0, 8.0 ));
    }
}

spawnhadesescapevehicle()
{
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname( "HadesEscapeVehicle" );
    var_0.escapevehicle = 1;
    maps\_hms_utility::printlnscreenandconsole( "Spawning Hades escape vehicle" );

    if ( level.currentgen )
        var_0 thread maps\greece_code::tff_cleanup_vehicle( "confcenter" );

    foreach ( var_2 in var_0.riders )
        level.allenemyambushers = common_scripts\utility::add_to_array( level.allenemyambushers, var_2 );

    level.allenemyvehicles = common_scripts\utility::add_to_array( level.allenemyvehicles, var_0 );
    thread setupgaragedoor();
    thread spawnenemyreinforcementsvehicles();
    common_scripts\utility::flag_wait( "FlagHadesVehicleDriveStart" );
    wait 1;
    thread hadesvehiclebadplace();
    var_4 = "HadesEscapeVehicleStart";
    var_0 soundscripts\_snd::snd_message( "mhunt_cc_hades_veh_escape" );
    maps\_hms_utility::printlnscreenandconsole( "Hades is escaping!!!" );
    var_0 thread objmarkervehicle( "FlagSniperDroneHit", 1, 0 );
    var_0 markdronetargetvehicle();
    var_5 = getvehiclenode( var_4, "targetname" );
    var_0 attachpath( var_5 );
    var_0 startpath( var_5 );
    var_0 thread maps\_vehicle::vehicle_paths( var_5 );
    var_0 vehicle_setspeed( 20, 10, 15 );
    common_scripts\utility::flag_wait( "FlagHadesVehicleDroneLaunch" );
    firekamikazedrones( var_0 );
}

firekamikazedrones( var_0 )
{
    var_1 = 7;
    var_2 = var_0.origin;
    var_3 = 4;
    var_4 = length( level.player.origin - var_0.origin );
    var_3 = maps\_utility::linear_interpolate( min( max( var_4 - 1500, 0 ) / 2000, 1 ), 2.5, 4 );
    var_5 = 0;

    for ( var_6 = 0; var_6 < var_1; var_6++ )
    {
        var_7 = common_scripts\utility::mod( var_6 * 360 / var_1, 360 );
        var_8 = var_3 - var_5;
        var_9 = randomfloatrange( 3.6, 6.0 );
        var_10 = randomfloatrange( 50, 80 );
        var_11 = 0;

        if ( var_6 == 0 )
            var_11 = 1;

        var_12 = 0;

        if ( var_6 == 6 )
            var_12 = 1;

        thread mangarocketparentupdate( var_0, var_2, var_11, var_8, var_7, var_9, var_10, var_12 );
        var_13 = 0.15;
        var_5 += ( var_13 + 0.05 );
        wait(var_13);
    }
}

mangarocketparentupdate( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    var_8 = level.player geteye() - var_1;
    var_9 = vectornormalize( anglestoforward( level.player getangles() ) );
    var_10 = level.player geteye() - level.player.origin;
    var_10 /= 2;
    var_9 = common_scripts\utility::randomvectorincone( var_9, 30 ) * 100;
    var_11 = var_0.origin + ( 16, 0, 96 );
    var_12 = level.player geteye() + var_9;
    var_13 = ( var_1[0], var_1[1], var_12[2] ) + ( 0, 0, 100 );
    var_14 = common_scripts\utility::spawn_tag_origin();
    var_14.origin = var_11;
    var_14.parentorigin = var_11;
    var_14.droneviewmodel = spawn( "script_model", var_11 );
    var_14.droneviewmodel setmodel( "vehicle_atlas_assault_drone" );
    playfx( common_scripts\utility::getfx( "kamikaze_drone_launch" ), var_11 );
    soundscripts\_snd::snd_message( "start_kdrone_launch", var_0 );
    playfxontag( common_scripts\utility::getfx( "kamikaze_drone_trail" ), var_14, "tag_origin" );
    soundscripts\_snd::snd_message( "start_kdrone_loop", var_14 );
    thread mangarocketupdate( var_1, level.player, var_14, var_4, var_5, var_6 );
    var_15 = 0;
    var_16 = 1 / var_3 * 20;
    var_17 = 0;
    var_18 = 0;

    while ( var_17 <= 1 )
    {
        wait 0.05;
        var_12 = level.player geteye() + var_9;
        var_13 = ( var_1[0], var_1[1], var_12[2] ) + ( 0, 0, 100 );
        var_19 = squared( 1 - var_15 ) * var_11 + 2 * var_15 * ( 1 - var_15 ) * var_13 + squared( var_15 ) * var_12;
        var_14.parentorigin = var_19;
        var_20 = 2 * ( 1 - var_15 ) * ( var_13 - var_11 ) + 2 * var_15 * ( var_12 - var_13 );
        var_14.tangent = vectornormalize( var_20 );
        var_14.angles = vectortoangles( var_14.tangent );
        var_14.droneviewmodel.angles = vectortoangles( var_8 * ( 1, 1, 0 ) );
        var_17 += var_16;

        if ( var_2 )
            var_15 = pow( var_17, 3 );
        else
            var_15 = squared( var_17 );

        if ( var_18 )
            break;

        if ( var_17 > 1 )
        {
            var_17 = 1;
            var_18 = 1;
        }
    }

    stopfxontag( common_scripts\utility::getfx( "kamikaze_drone_trail" ), var_14, "tag_origin" );
    var_21 = anglestoforward( level.player getangles() ) * -1;
    playfx( common_scripts\utility::getfx( "kamikaze_drone_explosion" ), var_14.origin, var_21, ( 0, 0, 1 ) );
    soundscripts\_snd::snd_message( "kamikaze_drone_explo", var_14 );
    soundscripts\_snd::snd_message( "start_sniper_drone_death" );
    var_22 = randomfloatrange( 0.8, 1.6 );
    earthquake( var_22, 0.2, var_14.origin, 512 );
    var_14 notify( "MangaRocketUpdate" );
    var_14.droneviewmodel delete();
    var_14 delete();

    if ( var_7 )
    {
        wait 0.3;
        level.player notify( "kamikaze_damaged_lens" );
        common_scripts\utility::flag_set( "FlagSniperDroneHit" );
    }
}

mangarocketupdate( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_2 endon( "MangaRocketUpdate" );
    var_6 = vectortoangles( var_1.origin - var_0 );
    var_7 = var_3;
    var_8 = ( 0, 0, 0 );

    if ( common_scripts\utility::cointoss() )
        var_4 *= -1;

    var_9 = var_5 / 5;
    var_10 = 0;

    for (;;)
    {
        wait 0.05;
        var_7 += var_4;
        var_8 = ( 1, 0, 0 ) * var_10;

        if ( isdefined( var_2.tangent ) )
            var_6 = vectortoangles( var_2.tangent );

        var_8 = ( 0, 0, 1 ) * var_10;
        var_11 = transformmove( var_2.parentorigin, var_6, ( 0, 0, 0 ), ( 0, 0, var_7 ), var_8, ( 0, 0, 0 ) );
        var_8 = var_11["origin"];
        var_2.origin = vectorlerp( var_2.origin, var_8, 0.5 );
        var_2.droneviewmodel.origin = var_2.origin;
        var_10 += var_9;
        var_10 = clamp( var_10, 0, var_5 );
    }
}

confroomsetup()
{
    var_0 = common_scripts\utility::getstruct( "CC_Breach", "targetname" );
    var_1 = getent( "ConfHades", "targetname" );
    level.confhades = var_1 maps\_utility::spawn_ai();
    level.confhades.name = "Hades";
    level.confhades.animname = "Hades";
    level.confhades.health = 1;
    level.confhades.no_friendly_fire_penalty = 1;
    level.confhades.noragdoll = 1;
    level.confhades.disablearrivals = 1;
    level.confhades.disableexits = 1;
    level.confhades.neverenablecqb = 1;
    level.confhades.alwaysrunforward = 1;
    level.confhades orientmode( "face default" );
    level.confhades.combatmode = "no_cover";
    level.confhades maps\_utility::gun_remove();
    level.confhades.grenadeammo = 0;
    level.confhades maps\_utility::set_run_anim( "run_hunched_combat", 1 );
    level.confhades.run_override_weights = level.scr_anim["Hades"]["run_hunched_weights"];
    level.confhades maps\_utility::set_ignoreall( 1 );
    level.confhades.allowdeath = 1;
    level.confhades.team = "axis";
    level.allenemypatrollers = common_scripts\utility::array_add( level.allenemypatrollers, level.confhades );
    level.confhades thread maps\greece_code::clearalertoutline();
    thread monitorhadesdeath();
    thread monitorhadesalert();
    thread progressionkillhades();
    level.confhades thread maps\greece_code::bloodsprayexitwoundtrace( 3000, level.player, "TAG_WEAPON_CHEST", 1 );
    level.confhades thread monitorsniperdronetriplekill();
    var_0 thread maps\_anim::anim_loop_solo( level.confhades, "pacing_idle", "stopPacingIdles" );
    maps\_utility::array_spawn_function_targetname( "EnemyPatrolMeeting", ::thinkpatrolenemy, 0 );
    var_2 = maps\_utility::array_spawn_targetname( "EnemyPatrolMeeting" );
    var_3 = 1;

    foreach ( var_5 in var_2 )
    {
        var_5.allowdeath = 1;
        var_5.animname = "BodyGuard" + var_3;
        var_3++;
        var_0 thread maps\_anim::anim_loop_solo( var_5, "pacing_idle", "stopPacingIdles" );
        var_5.idlepoint = var_0;
        var_5 thread disablestealthonhadesdeath();
    }

    var_7 = [ "kva_civilian_a", "kva_civilian_b", "kva_civilian_c", "kva_civilian_d" ];
    var_8 = [ "kva_civilian_a_head", "kva_civilian_b_head", "kva_civilian_c_head" ];
    maps\greece_code::aiarrayoverridemodelrandom( var_2, var_7, var_8 );
    level.breachactors = maps\_utility::array_merge( var_2, level.breachactors );
    level.allenemypatrollers = maps\_utility::array_merge( var_2, level.allenemypatrollers );
    thread setupmeetingcivilians();
    thread confroomstandingidles( var_0, var_2, level.confhades );
    var_9 = getent( "conf_room_door", "targetname" );
    var_9 maps\_utility::assign_animtree( "conf_room_door" );
    level.breachactors = common_scripts\utility::array_insert( level.breachactors, var_9, 0 );
    soundscripts\_snd::snd_message( "start_hades_breach_door", var_9 );
}

setupmeetingcivilians()
{
    var_0 = common_scripts\utility::getstruct( "CC_Breach", "targetname" );
    var_1 = maps\_utility::array_spawn_targetname( "ConfRoomVip", 1 );
    var_2 = "vip_idle";
    var_3 = [ "civ_urban_male_body_f", "civ_urban_male_body_g", "body_civ_sf_male_a" ];
    var_4 = [ "head_m_act_cau_bedrosian_base", "head_m_act_asi_chang_base", "head_male_mp_manasi" ];
    maps\greece_code::aiarrayoverridemodelrandom( var_1, var_3, var_4 );

    foreach ( var_6 in var_1 )
    {
        var_6.animname = var_6.script_noteworthy;
        var_7 = "Breach";

        if ( var_6.animname == "Vip3" )
            var_7 = "speech";

        var_0 thread maps\_anim::anim_loop_solo( var_6, var_2, var_7 );
        var_6.allowdeath = 1;
        var_6 thread maps\greece_code::setragdolldeath();
    }

    level.breachactors = maps\_utility::array_merge( level.breachactors, var_1 );
}

monitorhadesdeath()
{
    level endon( "end_sniper_drone" );
    level.confhades endon( "guy_alerted" );
    var_0 = common_scripts\utility::getstruct( "CC_Breach", "targetname" );
    var_1 = "cc_breach";
    level.confhades waittill( "damage" );
    var_0 notify( "stopPacingIdles" );
    var_0 notify( "speech" );
    var_0 notify( "Breach" );
    level.confhades.ignoreall = 1;
    level.confhades maps\_stealth_utility::disable_stealth_for_ai();
    level.confhades disableenemyalert();
    common_scripts\utility::flag_set( "FlagConfHadesDead" );
    level notify( "stop_hades_speech" );
    level.confhades notify( "removeTargetObj" );
    level.confhades notify( "stop_talking" );
    maps\_utility::radio_dialogue_overlap_stop();

    if ( common_scripts\utility::flag( "FlagOkayToKillHades" ) )
    {
        common_scripts\utility::flag_set( "FlagForcePlayerSlowMovement" );
        thread hadesscriptedanimdeath( var_0, var_1 );
        wait 0.5;
        thread maps\_controlled_sniperdrone::disabledronefiringafterkill();
        common_scripts\utility::flag_wait( "FlagConfRoomExplosion" );
        level.confhades thread unmarkandremoveoutline( 0.1 );
        wait 3.0;
        common_scripts\utility::flag_clear( "FlagForcePlayerSlowMovement" );
    }
    else
        thread failkillhadessoon();
}

failkillhadessoon()
{
    common_scripts\utility::flag_set( "disable_autosaves" );
    common_scripts\utility::flag_set( "FlagDisableAutosave" );
    level notify( "alarm_mission_end" );
    wait 0.05;
    maps\_hms_utility::printlnscreenandconsole( "MISSION FAIL - PLAYER KILLED HADES TOO SOON!!!" );
    confcentertotalcombat( 1 );
    maps\greece_conf_center_vo::confcenterfailhadeskilledearlydialogue();
    wait 1;
    setdvar( "ui_deadquote", &"GREECE_DRONE_KILLHADES_FAIL" );
    maps\_utility::missionfailedwrapper();
}

failkillhadeslate()
{
    common_scripts\utility::flag_set( "disable_autosaves" );
    common_scripts\utility::flag_set( "FlagDisableAutosave" );
    level notify( "alarm_mission_end" );
    wait 0.05;
    maps\_hms_utility::printlnscreenandconsole( "MISSION FAIL - PLAYER TOOK TOO LONG TO KILL HADES!!!" );
    maps\greece_conf_center_vo::confcenterfailtimeoutdialogue();
    wait 1;
    setdvar( "ui_deadquote", &"GREECE_DRONE_NOKILLHADES_FAIL" );
    maps\_utility::missionfailedwrapper();
}

hadesscriptedanimdeath( var_0, var_1 )
{
    level.confhades maps\greece_code::giveplayerchallengekillpoint();
    level.confhades notify( "scripted_death" );
    level.confhades.bscripteddeath = 1;
    level.confhades maps\_utility::anim_stopanimscripted();
    wait 0.05;
    var_0 maps\_anim::anim_single_solo( level.confhades, var_1 );
    level.confhades maps\greece_code::kill_no_react( 0 );
}

monitorhadesalert( var_0 )
{
    level.confhades endon( "death" );
    level.confhades endon( "damage" );
    level.confhades waittill( "guy_alerted" );
    var_1 = common_scripts\utility::getstruct( "CC_Breach", "targetname" );
    var_2 = "cc_breach";
    var_1 notify( "stopPacingIdles" );
    var_1 notify( "speech" );
    var_1 notify( "Breach" );

    if ( isdefined( level.confhades ) )
    {
        level.confhades maps\_utility::anim_stopanimscripted();
        level.confhades maps\_utility::gun_remove();
        level.confhades.sidearm = "none";
        level.confhades maps\_utility::forceuseweapon( "iw5_sn6_sp", "primary" );
        var_3 = getnodearray( "ConfRoomHadesCover", "targetname" );
        var_4 = common_scripts\utility::random( var_3 );

        if ( isdefined( var_4 ) )
            level.confhades maps\_utility::set_goal_node( var_4 );
    }
}

disablestealthonhadesdeath()
{
    self endon( "death" );
    common_scripts\utility::flag_wait( "FlagConfHadesDead" );

    if ( common_scripts\utility::flag( "FlagOkayToKillHades" ) )
    {
        maps\_stealth_utility::disable_stealth_for_ai();
        self.disablebulletwhizbyreaction = 1;
        maps\_utility::disable_danger_react();
        self.ignoreall = 1;
        self.ignoreme = 1;
    }
}

alliesbreachconfroom()
{
    level endon( "alarm_mission_end" );
    level notify( "ConfRoomSetupBreach" );
    var_0 = common_scripts\utility::getstruct( "CC_Breach", "targetname" );

    foreach ( var_2 in level.allyinfiltrators )
    {
        var_2 maps\_stealth_utility::disable_stealth_for_ai();
        var_2 thread allysetupconfroom( var_0 );
    }

    maps\_hms_utility::printlnscreenandconsole( "Allies at ConfRoomBreach!" );
    common_scripts\utility::flag_wait( "FlagHadesSpeechStarted" );
    var_4 = maps\_utility::get_living_ai_array( "EnemyPatrolMeeting_AI", "targetname" );

    if ( isdefined( level.confhades ) )
        level.confhades thread confroombreachhadesspeech( var_0 );

    var_5 = maps\_utility::get_living_ai( "Vip3", "script_noteworthy" );

    if ( isdefined( var_5 ) )
        var_5 thread confroombreachhadesspeech( var_0 );

    common_scripts\utility::flag_wait( "FlagOkayToKillHades" );
    thread setupplayertargets( "ConfRoomPlayerTarget", 1, 1 );
    thread monitorconfroomenemies();
    common_scripts\utility::flag_wait( "FlagConfHadesDead" );
    soundscripts\_snd::snd_message( "hades_is_dead" );
    var_6 = level.breachactors[0];
    level.breachactors = common_scripts\utility::array_remove( level.breachactors, level.breachactors[0] );
    var_0 notify( "Breach" );
    soundscripts\_snd::snd_message( "start_hades_breach" );
    thread alliesexitconfroom();
    var_7 = getent( "conf_room_door_clip", "targetname" );
    var_7 delete();
    var_0 thread maps\_anim::anim_single_solo( var_6, "cc_breach" );
    thread allybreachconfroomanddie( var_0 );
    level.breachactors = maps\_utility::array_removedead_or_dying( level.breachactors );

    foreach ( var_9 in level.breachactors )
        var_9 maps\_utility::anim_stopanimscripted();

    var_0 thread maps\_anim::anim_single( level.breachactors, "cc_breach" );
    var_0 maps\_anim::anim_single_run( level.allyinfiltrators, "cc_breach" );
}

monitorconfroomenemies()
{
    level endon( "alarm_mission_end" );
    setupvalidtargetsbyname( "EnemyPatrolMeeting" );
    var_0 = maps\_utility::get_living_ai_array( "EnemyPatrolMeeting_AI", "targetname" );
    maps\_utility::waittill_dead_or_dying( var_0, 1 );
    wait 0.05;

    if ( !common_scripts\utility::flag( "FlagConfHadesDead" ) )
    {
        level.confhades notify( "stop_talking" );
        common_scripts\utility::flag_set( "FlagAlarmMissionEnd" );
        destroyatriumfighttimer();
        level notify( "alarm_mission_end" );
    }
}

allybreachconfroomanddie( var_0 )
{
    var_1 = maps\_utility::get_living_ai( "Infiltrator1", "script_noteworthy" );
    level.allyinfiltrators = common_scripts\utility::array_remove( level.allyinfiltrators, var_1 );
    var_0 maps\_anim::anim_single_solo( var_1, "cc_breach" );
    allyconfroomdeath( 0 );
}

allyconfroomdeath( var_0 )
{
    var_1 = maps\_utility::get_living_ai( "Infiltrator1", "script_noteworthy" );

    if ( isdefined( var_1 ) )
    {
        if ( maps\_utility::is_in_array( level.allyinfiltrators, var_1 ) )
            level.allyinfiltrators = common_scripts\utility::array_remove( level.allyinfiltrators, var_1 );

        var_1 unmarkandremoveoutline();
        var_1 maps\_utility::stop_magic_bullet_shield();

        if ( var_0 )
            var_1 delete();
        else
            var_1 maps\greece_code::kill_no_react();
    }
}

allysetupconfroom( var_0 )
{
    if ( self.animname == "infiltratorburke" )
    {
        common_scripts\utility::flag_wait_either( "FlagParkingAlliesOnStairs", "FlagBeginConfCenterKill" );
        var_1 = getent( "StairwayTakedownOrg", "targetname" );
        var_1 notify( "stop_stairway_idle" );
        wait 0.05;
    }

    maps\greece_code::clear_set_goal();
    waitframe();
    var_0 maps\_anim::anim_reach_solo( self, "breach_stairs" );
    var_0 maps\_anim::anim_single_solo_run( self, "breach_stairs" );
    var_0 maps\_anim::anim_reach_solo( self, "squad_setup_in" );
    var_0 maps\_anim::anim_single_solo( self, "squad_setup_in" );
    var_0 thread maps\_anim::anim_loop_solo( self, "squad_setup", "Breach" );
}

confroombreachbodyguarddeath( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "blood_impact_splat" ), var_0, "TAG_EYE" );
    var_0 maps\greece_code::kill_no_react();
}

confroomstandingidles( var_0, var_1, var_2 )
{
    var_3 = "standing_idle";
    common_scripts\utility::flag_wait_any( "FlagParkingCarAlarmActivated", "FlagBeginConfCenterKill" );
    var_0 notify( "stopPacingIdles" );
    var_0 thread maps\_anim::anim_loop_solo( var_2, var_3, "speech" );

    foreach ( var_5 in var_1 )
        var_0 thread maps\_anim::anim_loop_solo( var_5, var_3, "Breach" );
}

confroombreachhadesspeech( var_0 )
{
    self endon( "death" );
    level endon( "alarm_mission_end" );
    level endon( "stop_hades_speech" );
    var_0 notify( "speech" );
    var_0 maps\_anim::anim_single_solo( self, "speech" );
    var_1 = "vip_idle";

    if ( self == level.confhades )
        var_1 = "post_speech_idle";

    if ( !common_scripts\utility::flag( "FlagConfHadesDead" ) )
        var_0 thread maps\_anim::anim_loop_solo( self, var_1, "Breach" );
}

confroomragdoll( var_0 )
{
    if ( isalive( var_0 ) )
        var_0 maps\greece_code::kill_no_react();

    var_0 startragdoll();
}

confroomexplosiondronereaction()
{
    var_0 = level.player.sniperdronelink;
    var_0.animname = "sniper_drone_flight";
    var_0 maps\_utility::assign_animtree( "sniper_drone_flight" );
    var_1 = "explosion_reaction";
    var_2 = [ var_0 ];
    var_0.frameviewmodel.animname = "sniperdrone_outerparts";
    var_0.frameviewmodel maps\_utility::assign_animtree( "sniperdrone_outerparts" );
    var_0.barrelviewmodel.animname = "sniperdrone_barrel";
    var_0.barrelviewmodel maps\_utility::assign_animtree( "sniperdrone_barrel" );
    var_0.frameviewmodel setanim( var_0.frameviewmodel maps\_utility::getanim( var_1 ) );
    var_0.barrelviewmodel setanim( var_0.barrelviewmodel maps\_utility::getanim( var_1 ) );
    common_scripts\utility::flag_set( "FlagSniperDroneAnimating" );
    common_scripts\utility::flag_set( "FlagSniperDroneCloakOff" );
    soundscripts\_snd::snd_message( "wasp_cloak_off" );
    var_0 maps\_anim::anim_single( var_2, var_1 );
    common_scripts\utility::flag_clear( "FlagSniperDroneAnimating" );
}

alliesexitconfroom()
{
    level waittill( "ConfRoomExplosion" );
    var_0 = maps\_utility::get_living_ai( "Infiltrator1", "script_noteworthy" );

    if ( isdefined( var_0 ) && maps\_utility::is_in_array( level.allyinfiltrators, var_0 ) )
        level.allyinfiltrators = common_scripts\utility::array_remove( level.allyinfiltrators, var_0 );

    thread alliesredirect( "ConfRoomExit" );
}

thinkallyinfiltrator()
{
    self endon( "death" );
    maps\_utility::forceuseweapon( "iw5_bal27_sp_silencer01_variablereddot", "primary" );
    thread maps\_utility::magic_bullet_shield( 1 );
    thread maps\_utility::set_battlechatter( 0 );
    self.dontmelee = 1;
    self.meleealwayswin = 1;
    maps\_utility::enable_cqbwalk();
    maps\_utility::set_goal_radius( 64 );
    maps\_utility::disable_surprise();
    maps\_utility::disable_danger_react();
    maps\_utility::enable_dontevershoot();
    self.grenadeammo = 0;
    maps\_stealth_accuracy_friendly::friendly_acc_hidden();
    self.canjumppath = 1;

    if ( self.script_noteworthy == "InfiltratorBurke" )
        maps\_utility::set_force_color( "p" );
    else
        maps\_utility::set_force_color( "c" );
}

initthinkpatrolenemy( var_0 )
{
    self endon( "death" );

    if ( !isdefined( var_0 ) )
        var_0 = 1;

    if ( var_0 == 1 )
        self.animname = "generic";

    self.grenadeammo = 0;
    self.fovcosine = cos( 45 );
    maps\_utility::set_goal_radius( 64 );
    self.diequietly = 1;
    self clearenemy();
    thread maps\_utility::set_battlechatter( 0 );
    thread maps\greece_code::clearalertoutline();
    thread maps\_sniper_setup_ai::waitforplayerbulletwhizby();
    thread monitorisenemyvalidtarget();
    thread maps\greece_code::bloodsprayexitwoundtrace( 1500, level.player );
    thread monitorsniperdronetriplekill();
}

thinkpatrolenemy( var_0 )
{
    self endon( "death" );
    initthinkpatrolenemy( var_0 );

    if ( !isdefined( self._stealth ) )
        maps\_stealth_utility::stealth_default();

    maps\_stealth_utility::stealth_disable_seek_player_on_spotted();
    var_1 = [];
    var_1["saw"] = maps\_sniper_setup_ai::sawcorpse;
    maps\_stealth_utility::stealth_corpse_behavior_custom( var_1 );
}

thinkmeetingcivilian()
{
    self endon( "death" );
    maps\_utility::set_ignoreall( 1 );
    maps\_utility::set_ignoreme( 1 );
    var_0 = common_scripts\utility::getstruct( self.target, "targetname" );
    self forceteleport( var_0.origin, var_0.angles );
    self.animname = "generic";
    var_1 = var_0.animation;
    var_0 thread maps\_anim::anim_generic_loop( self, var_1 );
    self.allowdeath = 1;
}

thinkambushenemy()
{
    self endon( "death" );
    maps\_utility::disable_long_death();
    maps\_utility::disable_bulletwhizbyreaction();
    self.grenadeammo = 0;
    thread maps\greece_code::bloodsprayexitwoundtrace( 1500, level.player );
    thread monitorsniperdronetriplekill();
    common_scripts\utility::flag_wait_either( "FlagBeginConfCenterCombat", "FlagConfRoomAlliesRecover" );
    maps\greece_code::setalertoutline( 1 );
    markdronetargetenemy();
    thread maps\greece_code::clearalertoutline();
    thread notifyonplayerkill();
    var_0 = level.player maps\_utility::get_player_gameskill();

    if ( var_0 <= 2 )
    {
        if ( self.classname == "actor_enemy_kva_civ_lmg" || self.classname == "actor_enemy_kva_civ_rpg" )
        {
            maps\_utility::disable_surprise();
            self.disablebulletwhizbyreaction = 1;
            self.grenadeammo = 0;
            self.health = 500;
            self.minpaindamage = 75;
            self.a.disablelongdeath = 1;
            self.a.disablelongpain = 1;
            self.ignoresuppression = 1;
            self.disablereactionanims = 1;
            self.no_pistol_switch = 1;
            self.dontmelee = 1;
            // self setmodel( "kva_heavy_body" );
            // thread codescripts\character::setheadmodel( "kva_heavy_head" );
            self character\gfl\randomizer_sf_lmg::main();
        }
    }
}

enemypatrolgatethread( var_0 )
{
    level endon( "alarm_mission_end" );
    var_1 = getent( "BodyStashOrg", "targetname" );
    var_2 = "bodystash_in";
    var_3 = "bodystash_idle";
    var_4 = "bodystash_start_idle";
    var_5 = maps\_utility::get_living_ai( "GatePlayerTarget1", "script_noteworthy" );
    var_5.animname = "guard1";
    var_5.health = 999999;
    var_5 maps\_utility::set_run_anim( "active_patrolwalk_gundown" );
    var_5 maps\_utility::forceuseweapon( "iw5_bal27_sp", "primary" );
    var_6 = maps\_utility::get_living_ai( "GatePlayerTarget2", "script_noteworthy" );
    var_6.animname = "guard2";
    var_6.health = 999999;
    var_6 maps\_utility::set_run_anim( "casual_killer_walk_F" );
    var_6 maps\_utility::forceuseweapon( "iw5_bal27_sp", "primary" );
    var_1 thread maps\_anim::anim_loop_solo( var_5, var_4, "stopIdleLoop" );
    var_1 thread maps\_anim::anim_loop_solo( var_6, var_4, "stopIdleLoop" );
    common_scripts\utility::flag_wait( "FlagAllyVehicleDriveBy" );
    var_7 = getent( "delivery_truck", "targetname" );
    var_8 = level.infiltratorburke;
    var_8.ignoreall = 1;
    var_9 = maps\_utility::get_living_ai( "Infiltrator1", "script_noteworthy" );
    var_9.ignoreall = 1;
    var_10 = maps\_utility::get_living_ai( "Infiltrator2", "script_noteworthy" );
    var_10.ignoreall = 1;
    common_scripts\utility::flag_set( "FlagGateGuardsApproachingAllyVehicle" );
    thread monitorplayerlookatgateguards();
    var_6 thread bodystashguardapproach( var_1, 1, "casual_killer_walk_start", 0.0 );
    var_5 bodystashguardapproach( var_1, 1, "active_patrolwalk_gundown_point_r", 1.0 );
    common_scripts\utility::flag_set( "FlagGateGuardsAtAllyVehicle" );
    thread setupplayertargets( "GatePlayerTarget" );
    var_5 maps\_stealth_utility::disable_stealth_for_ai();
    var_5.ignoreall = 1;
    var_5.dropweapon = 0;
    var_6 maps\_stealth_utility::disable_stealth_for_ai();
    var_6.ignoreall = 1;
    var_6.dropweapon = 0;
    var_5 thread bodystashguardalertwatch();
    var_6 thread bodystashguardalertwatch();
    var_5 thread bodystashguardkillwatch();
    var_6 thread bodystashguardkillwatch();
    var_11 = common_scripts\utility::flag_wait_any_return( "FlagBodyStashGuard1Killed", "FlagBodyStashGuard2Killed", "FlagBodyStashGuardsAlerted" );
    soundscripts\_snd::snd_message( "start_tower_bells" );
    level notify( "GateGuardsDead" );

    if ( var_11 == "FlagBodyStashGuard2Killed" )
        thread markallies( 1 );
    else
        thread markallies( 0 );

    var_1 notify( "endBodystashIdle" );

    if ( common_scripts\utility::flag( "FlagBodyStashGuard1Killed" ) )
        var_5 thread bodystashguarddeath( var_1, "bodystash_alt" );
    else
        var_5 thread bodystashguarddeath( var_1, "bodystash" );

    if ( common_scripts\utility::flag( "FlagBodyStashGuard2Killed" ) )
        var_6 thread bodystashguarddeath( var_1, "bodystash" );
    else
        var_6 thread bodystashguarddeath( var_1, "bodystash_alt" );

    thread alliesexittruck( var_1, var_7, var_9, var_10, var_8 );
}

bodystashguarddeath( var_0, var_1 )
{
    if ( isdefined( self ) )
    {
        self endon( "death" );
        disableenemyalert();
        self notify( "removeTargetObj" );
        self notify( "bloodless" );

        if ( self.script_noteworthy == "GatePlayerTarget1" )
        {
            animscripts\shared::dropallaiweapons();
            self notify( "stop_talking" );
            maps\_utility::radio_dialogue_stop();

            if ( var_1 == "bodystash_alt" )
            {
                self hudoutlinedisable();

                if ( target_istarget( self ) )
                    target_remove( self );
            }
        }
        else
        {
            self hudoutlinedisable();

            if ( target_istarget( self ) )
                target_remove( self );
        }

        maps\_utility::set_ignoreme( 1 );
        var_2 = maps\_utility::getanim( var_1 );
        maps\_hms_utility::printlnscreenandconsole( self.script_noteworthy + " is playing anime " + var_1 + " with animname " + self.animname );
        thread bodystashguardnofeedback();

        if ( self.script_noteworthy == "GatePlayerTarget1" )
        {
            if ( var_1 == "bodystash_alt" )
            {
                maps\greece_code::giveplayerchallengekillpoint();
                self notify( "scripted_death" );
            }

            self.bscripteddeath = 1;
            var_0 maps\_anim::anim_single_solo( self, var_1 );
            self.allowdeath = 1;
            self.a.nodeath = 1;
            animscripts\notetracks::notetrackstartragdoll( "ragdoll" );
            self stopanimscripted();
            self kill();
        }
        else if ( self.script_noteworthy == "GatePlayerTarget2" )
        {
            if ( var_1 == "bodystash" )
            {
                maps\greece_code::giveplayerchallengekillpoint();
                self notify( "scripted_death" );
            }

            self.bscripteddeath = 1;
            var_0 maps\_anim::anim_single_solo( self, var_1 );
            self hide();
            self.a.nodeath = 1;
            animscripts\notetracks::notetrackstartragdoll( "ragdoll" );
            self kill();
        }
    }
}

bodystashguardnofeedback()
{
    self endon( "death" );
    wait 0.1;
    maps\_utility::remove_damagefeedback();
}

alliesexittruck( var_0, var_1, var_2, var_3, var_4 )
{
    thread gatebreach();

    if ( common_scripts\utility::flag( "FlagBodyStashGuard2Killed" ) )
    {
        var_0 thread maps\_anim::anim_single_solo( var_1, "bodystash" );
        var_2 thread allyexittruck( var_0, "bodystash" );
        var_3 thread allyexittruck( var_0, "bodystash" );
    }
    else
    {
        var_0 thread maps\_anim::anim_single_solo( var_1, "bodystash_alt" );
        var_2 thread allyexittruck( var_0, "bodystash_alt" );
        var_3 thread allyexittruck( var_0, "bodystash_alt" );
    }

    if ( common_scripts\utility::flag( "FlagBodyStashGuard1Killed" ) )
        var_4 allyexittruck( var_0, "bodystash_alt" );
    else
        var_4 allyexittruck( var_0, "bodystash" );
}

allyexittruck( var_0, var_1 )
{
    var_0 maps\_anim::anim_single_solo_run( self, var_1 );
    self.ignoreall = 0;

    if ( self.script_noteworthy == "InfiltratorBurke" )
    {
        level notify( "AlliesExitTruck" );
        level.balliesintruck = 0;
    }

    common_scripts\utility::flag_set( "FlagAllGateGuardsDead" );
    gatebreachallyreachandidle();
}

deliverytrucksetup()
{
    var_0 = getent( "delivery_truck", "targetname" );
    var_0.animname = "truck";
    var_0 maps\_utility::assign_animtree( "truck" );
    var_1 = getent( "delivery_truck_collision", "targetname" );
    var_1 linkto( var_0, "tag_origin" );
    soundscripts\_snd::snd_message( "veh_moving_truck_chkpt", var_0 );
}

guyragdollnotetrack( var_0 )
{
    var_0 animscripts\shared::dropallaiweapons();
    var_0 maps\greece_code::kill_no_react();
    var_1 = ( 0.5, 0.5, 1 );
    var_2 = 100000;
    var_0 startragdollfromimpact( var_0.origin, var_1 * var_2 );
    var_0 startragdoll();
}

guyextrabloodnotetrack( var_0 )
{
    if ( var_0.script_noteworthy == "InfiltratorBurke" )
        var_1 = maps\_utility::get_living_ai( "GatePlayerTarget1", "script_noteworthy" );
    else
        var_1 = maps\_utility::get_living_ai( "GatePlayerTarget2", "script_noteworthy" );

    if ( isdefined( var_1 ) )
    {
        playfxontag( common_scripts\utility::getfx( "blood_impact_splat" ), var_1, "TAG_EYE" );
        var_1 notify( "bloodless" );
    }

    common_scripts\utility::flag_set( "FlagAllyShootGateGuard" );
}

bodystashguardalertwatch()
{
    level endon( "alarm_mission_end" );
    self endon( "death" );
    self endon( "damage" );
    self waittill( "guy_alerted" );

    if ( self.script_noteworthy == "GatePlayerTarget1" )
        var_0 = maps\_utility::get_living_ai( "GatePlayerTarget2", "script_noteworthy" );
    else
        var_0 = maps\_utility::get_living_ai( "GatePlayerTarget1", "script_noteworthy" );

    if ( isdefined( var_0 ) )
        var_0 disableenemyalert();

    wait 0.1;
    common_scripts\utility::flag_set( "FlagBodyStashGuardsAlerted" );
    var_1 = getent( "delivery_truck", "targetname" );
    self setentitytarget( var_1 );
}

bodystashguardkillwatch()
{
    level endon( "alarm_mission_end" );
    self endon( "death" );
    self endon( "disableAlert" );
    thread maps\greece_code::bloodsprayexitwoundtrace( 1000, level.player, "TAG_WEAPON_CHEST", 1 );
    self waittill( "damage" );

    if ( self.script_noteworthy == "GatePlayerTarget1" )
        common_scripts\utility::flag_set( "FlagBodyStashGuard1Killed" );
    else
        common_scripts\utility::flag_set( "FlagBodyStashGuard2Killed" );
}

bodystashguardapproach( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    self endon( "damage" );
    wait(var_3);
    var_4 = "bodystash_in";
    var_5 = "bodystash_idle";
    var_0 notify( "stopIdleLoop" );

    if ( var_1 )
        var_0 maps\_anim::anim_single_solo( self, var_4 );
    else
        var_0 maps\_anim::anim_reach_solo( self, var_5 );

    var_0 thread maps\_anim::anim_loop_solo( self, var_5, "endBodystashIdle" );
}

monitorplayerlookatgateguards()
{
    common_scripts\utility::flag_wait( "FlagGateGuardsAtAllyVehicle" );
    var_0 = getent( "delivery_truck", "targetname" );
    waittillplayerlookattarget( var_0, 15, 0 );
    common_scripts\utility::flag_set( "FlagOkayToShootDrone" );
}

gatebreachallyreachandidle()
{
    self endon( "death" );
    var_0 = common_scripts\utility::getstruct( "conf_center_org", "targetname" );
    var_1 = "gate_breach_in";
    var_2 = "gate_breach_idle";
    var_0 maps\_anim::anim_reach_solo( self, var_1 );
    var_0 maps\_anim::anim_single_solo( self, var_1 );
    maps\_utility::set_goal_pos( self.origin );
    level.ialliesatgate++;

    if ( !common_scripts\utility::flag( "FlagAllCourtyardGuardsDead" ) )
        var_0 thread maps\_anim::anim_loop_solo( self, var_2, "stop_loop" );
}

gatebreach()
{
    for (;;)
    {
        if ( level.ialliesatgate == 3 )
            break;

        waitframe();
    }

    var_0 = common_scripts\utility::flag_wait_any_return( "FlagCourtyardAlliesBreachGate", "FlagCourtyardAlliesBreachGateAlt" );
    var_1 = common_scripts\utility::getstruct( "conf_center_org", "targetname" );
    var_2 = "gate_breach";

    if ( var_0 == "FlagCourtyardAlliesBreachGateAlt" )
        var_2 = "gate_breach_alt";

    var_3 = getent( "conf_center_gate", "targetname" );
    var_3.animname = "gate";
    var_3 maps\_utility::assign_animtree( "gate" );
    var_4 = level.infiltratorburke;
    var_5 = maps\_utility::get_living_ai( "Infiltrator1", "script_noteworthy" );
    var_6 = maps\_utility::get_living_ai( "Infiltrator2", "script_noteworthy" );
    var_7 = maps\_utility::get_living_ai( "CourtyardAllyTarget1", "script_noteworthy" );
    var_8 = maps\_utility::get_living_ai( "CourtyardAllyTarget2", "script_noteworthy" );
    var_9 = maps\_utility::get_living_ai( "CourtyardAllyTarget3", "script_noteworthy" );
    var_1 notify( "stop_loop" );
    thread gatebreachandclear( var_1, var_4, var_2, var_0 );
    thread gatebreachandclear( var_1, var_5, var_2, var_0 );
    thread gatebreachandclear( var_1, var_6, var_2, var_0 );

    if ( isdefined( var_7 ) )
        thread gatebreachvictimdie( var_1, var_7, var_2, 0, var_0 );

    if ( isdefined( var_8 ) )
        thread gatebreachotherguysdie( var_8.idlepoint, var_8, "so_hijack_search_gear_check_reaction", 0, var_0 );

    if ( isdefined( var_9 ) )
        thread gatebreachotherguysdie( var_9.idlepoint, var_9, "patrol_bored_duckandrun_b", 1, var_0 );

    var_1 maps\_anim::anim_single_solo( var_3, "gate_breach" );
    common_scripts\utility::flag_set( "FlagGateBreachComplete" );
}

gatebreachandclear( var_0, var_1, var_2, var_3 )
{
    var_1.no_stopanimscripted = 1;
    var_0 maps\_anim::anim_single_solo_run( var_1, var_2 );
    var_1.no_stopanimscripted = undefined;

    if ( var_3 == "FlagCourtyardAlliesBreachGate" )
        allyredirectnoteworthy( var_1.script_noteworthy, "GateInt" );
}

gatebreachvictimdie( var_0, var_1, var_2, var_3, var_4 )
{
    var_1 endon( "death" );
    var_1 maps\_utility::set_ignoreme( 1 );

    if ( var_4 == "FlagCourtyardAlliesBreachGate" )
    {
        var_1.animname = "victim";
        var_1.health = 999999;
        var_1.no_stopanimscripted = 1;
        var_1 thread gatebreachoutlineguard();
        var_1 disableenemyalert();
        var_1.bscripteddeath = 1;
        var_0 maps\_anim::anim_single_solo( var_1, var_2 );
        var_1 maps\greece_code::kill_no_react( 0.0 );
        var_1 animscripts\notetracks::notetrackstartragdoll( "ragdoll" );
    }
    else
    {
        var_1 maps\_utility::anim_stopanimscripted();
        var_1 thread maps\_sniper_setup_ai::alertai();
        var_1 maps\_utility::clear_generic_idle_anim();
        var_1 maps\_utility::clear_generic_run_anim();

        if ( common_scripts\utility::flag( "FlagCourtyardGuardNearGate" ) )
        {
            waitframe();
            var_1 maps\_anim::anim_single_solo( var_1, "breach_react_blowback_v2" );
        }

        var_1.favoriteenemy = level.infiltratorburke;
        var_1 maps\_utility::set_ignoreme( 0 );
        var_1 findnearbycovernode( 512 );
        var_1.combatmode = "cover";
    }
}

gatebreachotherguysdie( var_0, var_1, var_2, var_3, var_4 )
{
    var_1 endon( "death" );

    if ( var_3 == 1 )
        var_1 thread maps\greece_code::setragdolldeath();

    if ( var_4 == "FlagCourtyardAlliesBreachGate" )
    {
        level waittill( "ConfCenterGateBreach" );
        wait 0.1;
    }

    var_1 maps\greece_code::setalertoutline();
    var_1 maps\_utility::set_ignoreme( 0 );

    if ( isdefined( var_0 ) )
        var_0 maps\_anim::anim_single_solo( var_1, var_2 );
}

gatebreachoutlineguard()
{
    self endon( "death" );
    level waittill( "ConfCenterGateBreach" );
    wait 0.1;
    maps\greece_code::setalertoutline();
}

gatebreachvictimapproach()
{
    level endon( "alarm_mission_end" );
    self endon( "damage" );
    self endon( "death" );
    self endon( "corpse" );
    self endon( "bulletwhizby" );
    self endon( "guy_alerted" );
    common_scripts\utility::flag_wait( "FlagAllyShootGateGuard" );
    wait 3.0;
    self.script_animation = "gundown";
    maps\_patrol::set_patrol_run_anim_array();
    aiidleloopdisable( 0 );
    var_0 = common_scripts\utility::getstruct( "Goal1CourtyardAllyTarget1", "script_noteworthy" );
    var_1 = var_0.animation;
    var_0 maps\_anim::anim_reach_solo( self, var_1 );
    common_scripts\utility::flag_set( "FlagCourtyardGuardNearGate" );
    thread markallytargets( "Courtyard" );
    var_0 maps\_anim::anim_single_solo( self, var_1 );
    level notify( "CourtyardGuardAtGate" );
    common_scripts\utility::flag_set( "FlagCourtyardAlliesBreachGate" );
}

monitorcourtyardplayertargets()
{
    level endon( "alarm_mission_end" );
    var_0 = [];
    var_1 = maps\_utility::get_living_ai_array( "EnemyPatrolCourtyard_AI", "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( var_3.script_noteworthy == "CourtyardPlayerTarget1" || var_3.script_noteworthy == "CourtyardPlayerTarget2" )
            var_0 = common_scripts\utility::array_add( var_0, var_3 );
    }

    maps\_utility::waittill_dead_or_dying( var_1, 1 );
    common_scripts\utility::flag_set( "FlagCourtyardAnyOverwatchDead" );
    var_5 = [];
    var_5["sight_dist"] = 400;
    var_5["detect_dist"] = 100;
    maps\_stealth_utility::stealth_corpse_ranges_custom( var_5 );
    maps\_utility::waittill_dead_or_dying( var_1 );
    common_scripts\utility::flag_set( "FlagCourtyardAllOverwatchDead" );
    common_scripts\utility::flag_wait( "FlagAllCourtyardGuardsDead" );
    var_5["sight_dist"] = 800;
    var_5["detect_dist"] = 200;
    maps\_stealth_utility::stealth_corpse_ranges_custom( var_5 );
}

monitorcourtyardallytargets()
{
    var_0 = [];
    common_scripts\utility::flag_wait( "FlagBeginCourtyardSetup" );
    var_1 = maps\_utility::get_living_ai( "CourtyardAllyTarget1", "script_noteworthy" );

    if ( isdefined( var_1 ) )
        var_0 = common_scripts\utility::add_to_array( var_0, var_1 );

    var_2 = maps\_utility::get_living_ai( "CourtyardAllyTarget2", "script_noteworthy" );

    if ( isdefined( var_2 ) )
        var_0 = common_scripts\utility::add_to_array( var_0, var_2 );

    var_3 = maps\_utility::get_living_ai( "CourtyardAllyTarget3", "script_noteworthy" );

    if ( isdefined( var_3 ) )
        var_0 = common_scripts\utility::add_to_array( var_0, var_3 );

    if ( var_0.size > 0 )
    {
        foreach ( var_5 in var_0 )
        {
            var_5 maps\greece_code::settargetoutline();
            var_5 thread monitorcourtyardallytargetdeath();
        }
    }
    else
        common_scripts\utility::flag_set( "FlagCourtyardAlliesBreachGateAlt" );
}

monitorcourtyardallytargetdeath()
{
    level endon( "CourtyardGuardAtGate" );
    common_scripts\utility::waittill_any( "death", "corpse", "bulletwhizby" );
    common_scripts\utility::flag_set( "FlagCourtyardAlliesBreachGateAlt" );
}

gatebreachdoorsexplode( var_0 )
{
    thread maps\greece_conf_center_fx::confcentergatecharge();
    level notify( "ConfCenterGateBreach" );
    maps\_utility::radio_dialogue_stop();
    soundscripts\_snd::snd_message( "start_gate_breach_music" );
    wait 0.5;
}

enemypatrolcourtyardthread( var_0 )
{
    level endon( "alarm_mission_end" );
    thread maps\greece_code::aiarrayidleloop( var_0 );
    thread enemygroupcorpsedetection( var_0, "disableCourtyardCorpseDetection" );
    thread monitorcourtyardplayertargets();
    thread monitorcourtyardallytargets();

    foreach ( var_2 in var_0 )
    {
        if ( var_2.script_noteworthy == "CourtyardPlayerTarget1" || var_2.script_noteworthy != "CourtyardPlayerTarget2" )
            var_2.dropweapon = 0;
    }

    var_2 = maps\_utility::get_living_ai( "CourtyardAllyTarget1", "script_noteworthy" );
    var_2 thread gatebreachvictimapproach();
    level waittill( "ConfCenterGateBreach" );
    wait 0.1;
    maps\_hms_utility::printlnscreenandconsole( "Courtyard enemies are alerted!!!" );
    var_4 = maps\_utility::get_living_ai_array( "EnemyPatrolCourtyard_AI", "targetname" );

    foreach ( var_2 in var_4 )
    {
        if ( var_2.script_noteworthy != "CourtyardAllyTarget1" && var_2.script_noteworthy != "CourtyardAllyTarget2" && var_2.script_noteworthy != "CourtyardAllyTarget3" )
            var_2 thread maps\_sniper_setup_ai::alertai();
    }
}

courtyardspecialdetection()
{
    level endon( "alarm_mission_end" );
    level endon( "disableCourtyardSpecialDetection" );
    var_0 = [];
    var_1 = maps\_utility::get_living_ai( "CourtyardAllyTarget1", "script_noteworthy" );

    if ( isdefined( var_1 ) && isalive( var_1 ) )
        var_0 = common_scripts\utility::add_to_array( var_0, var_1 );

    var_2 = maps\_utility::get_living_ai( "CourtyardAllyTarget2", "script_noteworthy" );

    if ( isdefined( var_2 ) && isalive( var_2 ) )
        var_0 = common_scripts\utility::add_to_array( var_0, var_2 );

    var_3 = maps\_utility::get_living_ai( "CourtyardAllyTarget3", "script_noteworthy" );

    if ( isdefined( var_3 ) && isalive( var_3 ) )
        var_0 = common_scripts\utility::add_to_array( var_0, var_3 );

    maps\_utility::waittill_dead_or_dying( var_0, 1 );

    foreach ( var_5 in var_0 )
    {
        wait(randomfloat( 0.1 ));

        if ( isdefined( var_5 ) && isalive( var_5 ) )
            var_5 thread maps\_sniper_setup_ai::alertai( 0 );
    }
}

enemygroupcorpsedetection( var_0, var_1 )
{
    level endon( "alarm_mission_end" );
    level endon( var_1 );
    var_0 = maps\_utility::array_removedead_or_dying( var_0 );

    if ( isdefined( var_0[0].script_stealthgroup ) )
    {
        var_2 = maps\_stealth_shared_utilities::group_get_ai_in_group( var_0[0].script_stealthgroup );
        maps\_utility::waittill_dead_or_dying( var_2, 1 );

        foreach ( var_4 in var_2 )
        {
            if ( var_4 != self )
            {
                wait(randomfloat( 0.1 ));

                if ( isdefined( var_4 ) && isalive( var_4 ) )
                    var_4 thread maps\_sniper_setup_ai::alertai( 0 );
            }
        }
    }
}

rooftopwatchparkingguards()
{
    level endon( "alarm_mission_end" );
    var_0 = maps\_utility::get_living_ai( "RooftopPlayerTarget1", "script_noteworthy" );
    var_0 endon( "death" );
    var_1 = maps\_utility::get_living_ai( "RooftopPlayerTarget2", "script_noteworthy" );
    var_1 endon( "death" );
    waitframe();
    var_2 = maps\_utility::get_living_ai_array( "EnemyPatrolParking_AI", "targetname" );
    var_2 = maps\_utility::array_removedead_or_dying( var_2 );
    maps\_utility::waittill_dead_or_dying( var_2, 1 );

    if ( isdefined( var_0 ) && isalive( var_0 ) )
        var_0 thread maps\_sniper_setup_ai::alertai( 0 );

    if ( isdefined( var_1 ) && isalive( var_1 ) )
        var_1 thread maps\_sniper_setup_ai::alertai( 0 );
}

enemypatrolwalkwaythread( var_0 )
{
    level endon( "alarm_mission_end" );
    thread maps\greece_code::aiarrayidleloop( var_0 );
}

enemypatrolpoolthread( var_0 )
{
    level endon( "alarm_mission_end" );
    thread maps\greece_code::aiarrayidleloop( var_0 );
    thread enemygroupcorpsedetection( var_0, "disablePoolCorpseDetection" );
    var_1 = maps\_utility::get_living_ai( "PoolAllyTarget1", "script_noteworthy" );

    if ( isdefined( var_1 ) )
        var_1 thread setuppoolkillvictim();

    foreach ( var_3 in var_0 )
        var_3 thread monitorpoolguard();
}

monitorpoolguard()
{
    level endon( "alarm_mission_end" );
    self endon( "disablePoolAlert" );
    common_scripts\utility::waittill_any( "death", "guy_alerted" );
    common_scripts\utility::flag_set( "FlagPoolKillBegin" );
}

setuppoolkillvictim()
{
    level endon( "alarm_mission_end" );
    self.animname = "victim";
    self.idlepoint = common_scripts\utility::getstruct( "OrgPoolKill", "script_noteworthy" );
    self.idlepoint thread maps\_anim::anim_loop_solo( self, "hms_greece_cc_takedown_idle", "stop_loop" );
    maps\_utility::gun_remove();
    self attach( "prop_cigarette", "tag_inhand", 1 );
    self.allowdeath = 1;
    self.customreactanime = "hms_greece_cc_takedown_react";
    thread monitorpoolkillvictim();
    thread monitorpoolkillvictimdeath();
    thread monitorpoolkillvictimalert();
}

monitorpoolkillvictim()
{
    level endon( "alarm_mission_end" );
    self endon( "death" );
    common_scripts\utility::flag_wait( "FlagPoolKillReady" );
    self notify( "disablePoolAlert" );
    disableenemyalert();
    maps\_stealth_utility::stealth_set_group_default();
    self.disablecorpsealert = 1;
    maps\_stealth_utility::disable_stealth_for_ai();
    self.no_stopanimscripted = 1;
    maps\_utility::set_ignoreme( 1 );
    maps\_utility::set_ignoreall( 1 );
    common_scripts\utility::waittill_any( "guy_alerted", "bulletwhizby", "projectile_impact", "damage" );
    common_scripts\utility::flag_set( "FlagPoolKillBegin" );
}

monitorpoolkillvictimalert()
{
    var_0 = common_scripts\utility::getstruct( "OrgPoolKill", "script_noteworthy" );
    level endon( "alarm_mission_end" );
    self endon( "disableAlert" );
    self endon( "allyPoolKill" );
    self endon( "death" );
    self waittill( "guy_alerted" );
    waitframe();

    if ( isdefined( self.damagelocation ) )
        return;

    self notify( "poolGuy_alerted" );
    var_0 notify( "stop_loop" );
    self detach( "prop_cigarette", "tag_inhand" );
    maps\_utility::forceuseweapon( "iw5_sn6_sp", "primary" );

    if ( self.health == 999999 )
        self.health = self.default_health;

    maps\_utility::set_ignoreme( 0 );
    maps\_utility::set_ignoreall( 0 );
    var_1 = getnode( "PoolEnemyCover", "script_noteworthy" );
    maps\_utility::set_goal_node( var_1 );
    self.combatmode = "cover";
    self.allyclaimedtarget = 0;
    self waittill( "goal" );
    self.allyclaimedtarget = 0;
    wait(level.alerttimedelay);
    common_scripts\utility::flag_set( "FlagAlarmMissionEnd" );
}

monitorpoolkillvictimdeath()
{
    var_0 = common_scripts\utility::getstruct( "OrgPoolKill", "script_noteworthy" );
    var_1 = "hms_greece_cc_takedown_death";
    level endon( "alarm_mission_end" );
    self endon( "death" );
    self endon( "poolGuy_alerted" );
    self endon( "allyPoolKill" );
    common_scripts\utility::flag_wait( "FlagPoolKillReady" );
    self.default_health = self.health;
    self.health = 999999;
    self waittill( "damage" );
    common_scripts\utility::flag_set( "FlagPlayerKillPoolGuard" );
    waitframe();
    var_0 notify( "stop_loop" );
    self.ignoreall = 1;
    maps\_stealth_utility::disable_stealth_for_ai();
    disableenemyalert();
    maps\greece_code::giveplayerchallengekillpoint();
    self notify( "scripted_death" );
    self.bscripteddeath = 1;
    thread unmarkandremoveoutline( 0.5 );
    var_0 maps\_anim::anim_single_solo( self, var_1 );
    maps\greece_code::kill_no_react( 0, level.player );
}

enemypatrolatriumthread( var_0 )
{
    level endon( "alarm_mission_end" );
    thread maps\greece_code::aiarrayidleloop( var_0 );
    thread enemygroupcorpsedetection( var_0, "disableAtriumCorpseDetection" );
    common_scripts\utility::flag_wait( "FlagAtriumEnemiesReactToBreach" );
    var_0 = maps\_utility::array_removedead_or_dying( var_0 );
    var_1 = getent( "OrgAtriumMuteCharge", "targetname" );
    var_2 = 750;
    var_3 = common_scripts\utility::get_array_of_closest( var_1.origin, var_0 );

    foreach ( var_5 in var_3 )
    {
        if ( isalive( var_5 ) )
        {
            var_5 thread enemyatriumflashbang( var_1 );
            var_6 = distancesquared( var_5.origin, var_1.origin );
            var_7 = var_6 * 0.0000005;
            wait(var_7);
        }
    }

    common_scripts\utility::flag_set( "FlagAtriumEnemiesAllMarked" );
    common_scripts\utility::flag_wait( "FlagAtriumEnemiesAlmostAllDead" );
    var_9 = getent( "AtriumFallbackVol", "targetname" );
    var_0 = maps\_utility::array_removedead_or_dying( var_0 );

    foreach ( var_5 in var_0 )
    {
        wait(randomfloatrange( 0.5, 1.5 ));

        if ( isdefined( var_5 ) )
        {
            var_11 = "FallbackVol" + var_5.script_noteworthy;
            var_12 = getent( var_11, "script_noteworthy" );

            if ( isdefined( var_12 ) )
                var_5 setgoalvolumeauto( var_12 );
        }
    }
}

enemyatriumflashbang( var_0 )
{
    self endon( "death" );
    self endon( "dying" );
    self notify( "end_patrol" );
    self notify( "new_anim_reach" );
    disableenemyalert();
    maps\_stealth_utility::disable_stealth_for_ai();
    aiidleloopdisable( 0 );
    wait 0.05;

    if ( !maps\_utility::is_in_array( level.alertedenemies, self ) )
        level.alertedenemies = common_scripts\utility::add_to_array( level.alertedenemies, self );

    level.playertargets = common_scripts\utility::add_to_array( level.playertargets, self );

    if ( distancesquared( var_0.origin, self.origin ) < 850000 )
    {
        var_1 = 5;

        if ( isdefined( self ) && isalive( self ) )
        {
            self stopanimscripted();
            thread markplayertarget( 1, 0 );
            maps\_utility::flashbangstart( var_1 );
        }

        wait(var_1);
    }

    aienablestealthcombat();
}

monitoratriumenemieskilled()
{
    level endon( "AtriumTimerExpire" );
    level.playertargets = maps\_utility::array_removedead_or_dying( level.playertargets );
    var_0 = level.playertargets.size - 3;
    maps\_utility::waittill_dead( level.playertargets, var_0 );
    maps\_hms_utility::printlnscreenandconsole( "Atrium enemies falling back..." );
    common_scripts\utility::flag_set( "FlagAtriumEnemiesAlmostAllDead" );
    common_scripts\utility::flag_wait( "FlagAllAtriumGuardsDead" );
    level notify( "AtriumTimerFreeze" );
    var_1 = [];
    var_1["sight_dist"] = 800;
    var_1["detect_dist"] = 200;
    maps\_stealth_utility::stealth_corpse_ranges_custom( var_1 );
}

enemypatrolrooftopthread( var_0 )
{
    thread maps\greece_code::aiarrayidleloop( var_0 );
    thread enemygroupcorpsedetection( var_0, "disableRooftopCorpseDetection" );
    thread rooftopwatchparkingguards();

    foreach ( var_2 in var_0 )
        var_2.dropweapon = 0;
}

enemypatrolparkingthread( var_0 )
{
    level endon( "alarm_mission_end" );
    thread maps\greece_code::aiarrayidleloop( var_0 );
    thread enemygroupcorpsedetection( var_0, "disableParkingCorpseDetection" );
    thread monitorparkingguards( var_0 );
    thread setupparkinginvestigators();
}

monitorparkingguards( var_0 )
{
    thread monitorparkingguardsdead( var_0 );
    common_scripts\utility::flag_wait( "FlagUnMarkParkingCars" );
    thread setupplayertargets( "ParkingPlayerTarget" );
}

monitorparkingguardsdead( var_0 )
{
    maps\_utility::waittill_dead_or_dying( var_0, 1 );
    common_scripts\utility::flag_set( "FlagAnyParkingGuardsDead" );
}

setupparkinginvestigators()
{
    var_0 = [];
    var_1 = maps\_utility::get_living_ai( "ParkingPlayerTarget1", "script_noteworthy" );

    if ( isdefined( var_1 ) )
        var_0 = common_scripts\utility::add_to_array( var_0, var_1 );

    var_2 = maps\_utility::get_living_ai( "ParkingPlayerTarget2", "script_noteworthy" );

    if ( isdefined( var_2 ) )
        var_0 = common_scripts\utility::add_to_array( var_0, var_2 );

    var_3 = maps\_utility::get_living_ai( "ParkingPlayerTarget3", "script_noteworthy" );

    if ( isdefined( var_3 ) )
        var_0 = common_scripts\utility::add_to_array( var_0, var_3 );

    thread monitorparkinginvestigatorsneargoal( var_0 );
    thread monitorparkinginvestigatorsdead( var_0 );
    common_scripts\utility::flag_wait( "FlagParkingCarAlarmActivated" );
    var_0 = maps\_utility::array_removedead_or_dying( var_0 );
    var_4 = level.parkingalarmcar.script_noteworthy;

    foreach ( var_6 in var_0 )
    {
        var_6 notify( "end_patrol" );
        var_6.alertgroup = 0;
    }

    thread aiarraymovetonewidlepos( var_0, var_4 );
    common_scripts\utility::flag_set( "FlagParkingGuardsMovingToCar" );
}

monitorparkinginvestigatorsdead( var_0 )
{
    level endon( "parking_guard_shot" );
    maps\_utility::waittill_dead_or_dying( var_0, 1 );
    common_scripts\utility::flag_set( "FlagUnMarkParkingCars" );
    level notify( "parking_guard_shot" );
}

monitorparkinginvestigatorsneargoal( var_0 )
{
    var_1 = 0;
    var_2 = [];
    var_2 = maps\_utility::array_merge( var_0, var_2 );
    var_3 = getent( "ParkingGuardsNearCar", "targetname" );
    var_4 = var_0.size - 1;

    for (;;)
    {
        var_2 = maps\_utility::array_removedead_or_dying( var_2 );

        foreach ( var_6 in var_2 )
        {
            if ( var_6 istouching( var_3 ) )
            {
                var_2 = common_scripts\utility::array_remove( var_2, var_6 );
                var_1++;
                maps\_hms_utility::printlnscreenandconsole( "Number " + var_1 + " guy hit trigger: " + var_6.script_noteworthy );
            }
        }

        if ( var_1 == var_4 )
            break;

        wait 0.05;
    }

    common_scripts\utility::flag_set( "FlagParkingGuardsNearCar" );
    wait 5.0;
    _caralarmstop();
}

aiarraymovetonewidlepos( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( !isdefined( var_2 ) )
        var_2 = "walk";

    var_0 = maps\_utility::array_removedead_or_dying( var_0 );

    foreach ( var_5 in var_0 )
        var_5 thread aimovetonewidlepos( var_1, var_2, var_3 );
}

aimovetonewidlepos( var_0, var_1, var_2 )
{
    level endon( "end_sniper_drone" );
    level endon( "alarm_mission_end" );
    self endon( "damage" );
    self endon( "death" );
    self endon( "enemy" );
    self endon( "corpse" );
    self endon( "bulletwhizby" );
    self endon( "brokenglass" );
    self endon( "guy_alerted" );
    self notify( "end_patrol" );
    self notify( "new_anim_reach" );
    waittillframeend;
    self.idlepointreached = 0;
    var_3 = var_0 + self.script_noteworthy;
    var_4 = common_scripts\utility::getstruct( var_3, "script_noteworthy" );

    if ( isdefined( var_4 ) )
    {
        if ( !isdefined( var_2 ) )
            var_2 = 0;

        if ( !isdefined( var_1 ) )
            var_1 = "walk";

        if ( isdefined( var_4.script_animation ) )
        {
            var_5 = var_4.script_animation;
            self.script_animation = var_5;
            maps\_patrol::set_patrol_run_anim_array();
        }

        aiidleloopdisable( var_2 );
        self.idlepoint = var_4;
        var_6 = self.idlepoint.animation;

        if ( var_1 == "teleport" )
            self forceteleport( self.idlepoint.origin, self.idlepoint.angles );
        else
        {
            var_7 = var_6 + "_in";

            if ( maps\_utility::hasanim( var_7 ) )
            {
                self.idlepoint maps\_anim::anim_reach_solo( self, var_7 );
                self.idlepoint maps\_anim::anim_single_solo( self, var_7 );
            }
            else
                self.idlepoint maps\_anim::anim_reach_solo( self, var_6 );
        }

        self.idlepointreached = 1;
        self notify( "goal" );
        self.idlepoint thread maps\_anim::anim_loop_solo( self, self.idlepoint.animation, "stop_loop" );
    }
}

chooseidlepointreactanimation( var_0 )
{
    self endon( "damage" );
    self endon( "death" );
    self endon( "dying" );

    if ( isdefined( self ) && isalive( self ) )
    {
        if ( self.animname == "generic" && isdefined( level.scr_anim["generic"][var_0] ) )
            self.idlepoint maps\_anim::anim_single_solo( self, var_0 );
        else if ( maps\_utility::hasanim( var_0 ) )
            self.idlepoint maps\_anim::anim_single_solo( self, var_0 );
    }
}

aiidleloopdisable( var_0 )
{
    self endon( "damage" );
    self endon( "death" );
    self endon( "dying" );

    if ( !isdefined( var_0 ) )
        var_0 = 0;

    if ( isdefined( self ) && isalive( self ) )
    {
        if ( !isdefined( self.no_stopanimscripted ) )
            maps\_utility::anim_stopanimscripted();

        if ( var_0 == 1 )
        {
            var_1 = self.customreactanime;

            if ( isdefined( var_1 ) )
            {
                if ( maps\_utility::hasanim( var_1 ) )
                    thread maps\_anim::anim_single_solo_run( self, var_1 );
            }
        }

        if ( isdefined( self.idlepoint ) )
        {
            self.idlepoint notify( "stop_loop" );
            var_2 = self.idlepoint.animation;

            if ( isdefined( self.idlepointreached ) && self.idlepointreached == 1 && isdefined( var_2 ) )
            {
                if ( var_0 == 1 )
                    chooseidlepointreactanimation( var_2 + "_react" );
                else
                    chooseidlepointreactanimation( var_2 + "_out" );
            }

            self.idlepoint = undefined;
        }
    }
}

aienabletotalcombat( var_0 )
{
    self endon( "death" );

    if ( isdefined( self.bscripteddeath ) && self.bscripteddeath == 1 )
        return;

    if ( isdefined( self.no_stopanimscripted ) && self.no_stopanimscripted == 1 )
    {
        for (;;)
        {
            if ( !isdefined( self.no_stopanimscripted ) )
                break;

            if ( self.no_stopanimscripted == 0 )
                break;

            wait 0.05;
        }
    }

    if ( isdefined( self.default_health ) )
    {
        self.health = self.default_health;
        self.default_health = undefined;
    }

    if ( !isdefined( var_0 ) )
        var_0 = 1;

    maps\_utility::enable_arrivals();
    maps\_utility::enable_exits();
    maps\greece_code::enableawareness();
    maps\_utility::clear_run_anim();
    maps\_stealth_utility::disable_stealth_for_ai();
    self notify( "end_patrol" );
    self notify( "new_anim_reach" );
    disableenemyalert();
    self notify( "guy_alerted" );
    waittillframeend;

    switch ( self.team )
    {
        case "allies":
            if ( level.balliesintruck == 0 )
            {
                self notify( "stop_loop" );
                thread maps\_utility::set_battlechatter( 1 );
                maps\_utility::enable_danger_react( 10 );
                maps\_stealth_accuracy_friendly::friendly_acc_spotted();
                self.enemyteam = "axis";
            }

            break;
        case "axis":
            aiidleloopdisable( var_0 );
            thread maps\_utility::set_battlechatter( 1 );
            maps\greece_code::setalertoutline();
            thread maps\greece_code::clearalertoutline();
            self notify( "removeTargetObj" );
            self.enemyteam = "allies";
            self.alertlevel = "combat";
            self.combatmode = "cover";
            maps\_utility::clear_generic_idle_anim();
            maps\_utility::clear_generic_run_anim();
            break;
    }

    var_1 = maps\_utility::get_closest_ai( self.origin, self.enemyteam );

    if ( isdefined( var_1 ) )
        maps\_utility::set_favoriteenemy( var_1 );

    var_2 = self findbestcovernode();

    if ( isdefined( var_2 ) )
    {
        maps\_utility::set_goal_radius( 64 );
        maps\_utility::set_forcegoal();
        maps\_utility::set_goal_node( var_2 );
        self waittill( "goal" );
        maps\_utility::unset_forcegoal();
    }
}

aienablestealthcombat()
{
    maps\_stealth_utility::disable_stealth_for_ai();
    maps\_utility::enable_arrivals();
    maps\_utility::enable_exits();

    switch ( self.team )
    {
        case "allies":
            self.enemyteam = "axis";
            self.ignoreall = 0;
            self.ignoreme = 0;
            maps\_utility::disable_dontevershoot();
            maps\_stealth_accuracy_friendly::friendly_acc_spotted();
            break;
        case "axis":
            maps\_utility::clear_generic_idle_anim();
            maps\_utility::clear_run_anim();
            self allowedstances( "stand", "crouch", "prone" );
            self.enemyteam = "allies";
            maps\_utility::disable_long_death();
            thread aistealthcombatenemygotocover();
            break;
    }

    var_0 = get_closest_ai_flat( self.origin, self.enemyteam );

    if ( isdefined( var_0 ) )
        maps\_utility::set_favoriteenemy( var_0 );
}

aistealthcombatenemygotocover()
{
    self endon( "death" );
    self endon( "dying" );
    var_0 = "Vol" + self.script_noteworthy;
    var_1 = getentarray( var_0, "script_noteworthy" );

    if ( var_1.size > 0 )
    {
        if ( var_1.size > 1 )
            var_1 = common_scripts\utility::array_randomize( var_1 );

        self setgoalvolumeauto( var_1[0] );
    }
    else
    {
        var_2 = self findbestcovernode();

        if ( isdefined( var_2 ) )
            maps\_utility::set_goal_node( var_2 );
    }
}

aidisablestealthcombat()
{
    maps\_stealth_utility::enable_stealth_for_ai();
    maps\_utility::enable_dontevershoot();
    maps\_stealth_accuracy_friendly::friendly_acc_hidden();

    if ( isdefined( self.enemy ) )
    {
        var_0 = self.enemy;

        if ( isdefined( var_0.script_noteworthy ) )
            maps\_hms_utility::printlnscreenandconsole( self.script_noteworthy + " has enemy " + var_0.script_noteworthy );

        self clearenemy();
    }

    maps\_utility::enable_cqbwalk();
    self.ignoreall = 1;
    self.ignoreme = 1;
}

monitorallyenemy()
{
    self endon( "death" );

    for (;;)
    {
        if ( isdefined( self.enemy ) )
        {
            var_0 = self.enemy;

            if ( isdefined( var_0.script_noteworthy ) )
                maps\_hms_utility::printlnscreenandconsole( self.script_noteworthy + " has enemy " + var_0.script_noteworthy );
        }

        wait 0.05;
    }
}

alliesredirect( var_0, var_1, var_2 )
{
    level endon( "end_sniper_drone" );

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    level.allyinfiltrators = maps\_utility::array_removedead_or_dying( level.allyinfiltrators );

    foreach ( var_4 in level.allyinfiltrators )
        var_4 allyredirect( var_0, var_1, var_2 );

    maps\_hms_utility::printlnscreenandconsole( "Allies moving to " + var_0 );
}

allyredirectnoteworthy( var_0, var_1, var_2, var_3 )
{
    level endon( "end_sniper_drone" );

    if ( !isdefined( var_2 ) )
        var_2 = 1;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    var_4 = maps\_utility::get_living_ai( var_0, "script_noteworthy" );
    var_4 allyredirect( var_1, var_2, var_3 );
    maps\_hms_utility::printlnscreenandconsole( var_0 + "ally moving to " + var_1 );
}

allyredirect( var_0, var_1, var_2 )
{
    maps\_utility::set_goal_radius( 64 );

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( var_1 )
    {
        maps\_utility::set_forcegoal();
        thread allyclearforcegoalonend();
    }

    var_3 = getnode( var_0 + self.script_noteworthy, "targetname" );

    if ( var_2 == 1 )
    {
        maps\_utility::teleport_ai( var_3 );
        self notify( "goal" );
    }
    else
        maps\_utility::set_goal_node( var_3 );

    if ( level.showdebugtoggle == 1 )
        thread maps\_utility::draw_line_from_ent_to_ent_until_notify( self, var_3, 1, 1, 1, self, "goal" );
}

allyclearforcegoalonend()
{
    self endon( "death" );
    self waittill( "goal" );
    maps\_utility::unset_forcegoal();
}

alliesdrivein( var_0, var_1 )
{
    var_2 = "bodystash_idle";
    var_3 = "bodystash";
    var_4 = getent( "BodyStashOrg", "targetname" );
    var_5 = getent( "delivery_truck", "targetname" );
    var_5 maps\_utility::assign_animtree( "truck" );
    var_5.animname = "truck";
    var_6 = maps\_utility::get_living_ai( "InfiltratorBurke", "script_noteworthy" );
    var_7 = maps\_utility::get_living_ai( "Infiltrator1", "script_noteworthy" );
    var_8 = maps\_utility::get_living_ai( "Infiltrator2", "script_noteworthy" );

    if ( var_0 )
    {
        var_4 maps\_anim::anim_last_frame_solo( var_5, var_3 );
        level.balliesintruck = 0;
    }
    else
    {
        var_9 = [ var_5, var_7, var_8, var_6 ];
        var_7 hide();
        var_8 hide();
        var_6 hide();
        var_4 maps\_anim::anim_first_frame( var_9, var_3 );
        level.balliesintruck = 1;
        thread truckdrivein( var_1 );
    }
}

allywalkwaykill()
{
    level endon( "alarm_mission_end" );
    var_0 = maps\_utility::get_living_ai( "Infiltrator2", "script_noteworthy" );
    var_0.animname = "infiltrator2";
    var_1 = common_scripts\utility::getstruct( "IdleWalkwayAllyTarget1", "script_noteworthy" );
    monitorallywalkwaykillvictim( var_1, var_0 );
    var_0 maps\greece_code::clear_set_goal();
    thread allyredirectnoteworthy( "Infiltrator2", "Walkway" );
}

monitorallywalkwaykillvictim( var_0, var_1 )
{
    var_2 = maps\_utility::get_living_ai( "WalkwayAllyTarget1", "script_noteworthy" );

    if ( isdefined( var_2 ) )
    {
        var_2 endon( "death" );
        var_2 markalliesenemytarget();
        var_2 maps\greece_code::settargetoutline();
    }

    var_0 maps\_anim::anim_reach_solo( var_1, "parabolic_knifekill" );
    common_scripts\utility::flag_set( "FlagWalkwayAlliesPerformKill" );
    thread maps\greece_conf_center_vo::walkwayguarddialogue();
    maps\_hms_utility::printlnscreenandconsole( "Allies at Walkway!" );

    if ( isdefined( var_2 ) )
    {
        if ( maps\_utility::is_in_array( level.alertedenemies, var_2 ) )
            var_1 allyshootwalkwaytarget();
        else
        {
            var_1.no_stopanimscripted = 1;
            var_2 thread allywalkwaykillvictim( var_0 );
            var_0 maps\_anim::anim_single_solo_run( var_1, "parabolic_knifekill" );
            var_1.no_stopanimscripted = undefined;
        }
    }
}

allyshootwalkwaytarget()
{
    level endon( "alarm_mission_end" );
    var_0 = maps\_utility::get_living_ai( "WalkwayAllyTarget1", "script_noteworthy" );
    var_0 endon( "death" );

    while ( !common_scripts\utility::flag( "FlagAllWalkwayGuardsDead" ) )
    {
        if ( isdefined( var_0 ) )
        {
            var_0 disableenemyalert();
            maps\greece_code::shootguy( var_0 );
            soundscripts\_snd::snd_message( "npc_shoots_pool_enemy" );
        }

        wait 0.2;
    }
}

allywalkwaykillvictim( var_0 )
{
    self endon( "death" );
    var_0 notify( "stop_loop" );
    maps\_stealth_utility::disable_stealth_for_ai();
    self.no_stopanimscripted = 1;
    disableenemyalert();
    thread monitorwalkwaykillvictim();
    self.health = 10;
    maps\_utility::set_ignoreall( 1 );
    maps\_utility::disable_bulletwhizbyreaction();
    maps\_stealth_utility::disable_stealth_for_ai();
    self.animname = "victim";
    var_0 thread maps\_anim::anim_single_solo( self, "parabolic_knifekill" );
    self.allowdeath = 1;
    level waittill( "WalkwayGuyStruggle" );
    self.health = 1000000;
    self.bscripteddeath = 1;
    level notify( "WalkwayAllyKill" );
    maps\_utility::radio_dialogue_stop();
    var_0 waittill( "parabolic_knifekill" );
    maps\greece_code::kill_no_react();
}

monitorwalkwaykillvictim()
{
    level endon( "WalkwayAllyKill" );
    self waittill( "death" );
    maps\_utility::radio_dialogue_stop();
    thread maps\greece_conf_center_vo::walkwayplayerkilldialogue();
    waitframe();
    var_0 = maps\_utility::get_living_ai( "Infiltrator2", "script_noteworthy" );
    var_0 maps\_utility::anim_stopanimscripted();
}

allypoolsetup()
{
    level endon( "alarm_mission_end" );
    var_0 = maps\_utility::get_living_ai( "Infiltrator1", "script_noteworthy" );
    var_0.animname = "infiltrator1";
    var_0.ignoreall = 1;
    var_0 thread maps\_utility::waterfx( "FlagStopPoolWater" );
    var_1 = common_scripts\utility::getstruct( "OrgPoolKill", "script_noteworthy" );
    var_1 maps\_anim::anim_reach_solo( var_0, "pool_traverse_in" );
    var_1 maps\_anim::anim_single_solo( var_0, "pool_traverse_in" );
    var_1 thread maps\_anim::anim_loop_solo( var_0, "pool_traverse_idle", "stop_traverse_loop" );
    var_0 thread allypoolkill();
}

allypoolkill()
{
    level endon( "alarm_mission_end" );
    common_scripts\utility::flag_wait( "FlagBeginStruggleSetup" );
    var_0 = common_scripts\utility::getstruct( "OrgPoolKill", "script_noteworthy" );
    self.ignoreall = 0;
    var_0 notify( "stop_traverse_loop" );
    var_0 maps\_anim::anim_single_solo( self, "pool_traverse_out" );
    common_scripts\utility::flag_set( "FlagPoolKillReady" );

    if ( !common_scripts\utility::flag( "FlagPoolKillBegin" ) && !common_scripts\utility::flag( "FlagEndPoolSetup" ) )
        var_0 thread maps\_anim::anim_loop_solo( self, "hms_greece_cc_takedown_idle", "stop_loop" );

    common_scripts\utility::flag_wait_either( "FlagPoolKillBegin", "FlagEndPoolSetup" );
    var_1 = "hms_greece_cc_takedown";
    var_2 = maps\_utility::get_living_ai( "PoolAllyTarget1", "script_noteworthy" );

    if ( !isdefined( var_2 ) || maps\_utility::is_in_array( level.alertedenemies, var_2 ) || isdefined( var_2.damagelocation ) )
        var_1 = "hms_greece_cc_takedown_fail";

    var_0 notify( "stop_loop" );
    waitframe();

    if ( var_1 == "hms_greece_cc_takedown" )
        common_scripts\utility::flag_set( "FlagPoolKillSpecial" );

    thread allyexitpool( var_0, var_1 );
    thread allyexithandlevictim( var_2, var_0, var_1 );
    thread poolalliesadvance();
}

victimpoolkill( var_0, var_1 )
{
    self notify( "allyPoolKill" );
    self.bscripteddeath = 1;
    self.health = 99999;
    maps\_utility::set_allowdeath( 0 );
    maps\greece_conf_center_fx::confcenterpoolsplash();
    maps\greece_conf_center_fx::confcenterpoolallywaterdrip();
    maps\_utility::clear_deathanim();
    maps\greece_conf_center_anim::stealthkillvictim( self );
    self.no_stopanimscripted = 1;
    maps\_utility::set_ignoreall( 1 );
    var_0 maps\_anim::anim_single_solo( self, var_1 );
    maps\_utility::set_allowdeath( 1 );
    maps\greece_code::kill_no_react();
}

poolalliesadvance()
{
    for (;;)
    {
        var_0 = maps\_utility::get_living_ai_array( "EnemyPatrolPool_AI", "targetname" );

        if ( common_scripts\utility::flag( "FlagPoolKillSpecial" ) && var_0.size == 1 )
            break;
        else if ( var_0.size == 0 )
            break;

        wait 0.1;
    }

    common_scripts\utility::flag_set( "FlagAllPoolGuardsDead" );
}

setuppoolallytargets()
{
    thread alliesshootpooltargets();
    var_0 = maps\_utility::get_living_ai( "PoolAllyTarget1", "script_noteworthy" );

    if ( isdefined( var_0 ) )
    {
        var_0 markalliesenemytarget();
        var_0 maps\greece_code::settargetoutline();
    }
}

alliesshootpooltargets()
{
    common_scripts\utility::flag_wait( "FlagPoolKillBegin" );
    var_0 = maps\_utility::get_living_ai( "InfiltratorBurke", "script_noteworthy" );
    var_1 = maps\_utility::get_living_ai( "Infiltrator2", "script_noteworthy" );
    wait 0.2;
    var_1 thread allyshootpooltarget( common_scripts\utility::flag( "FlagPoolKillSpecial" ) );
    wait 0.1;
    var_0 thread allyshootpooltarget( common_scripts\utility::flag( "FlagPoolKillSpecial" ) );
}

allyshootpooltarget( var_0 )
{
    level endon( "alarm_mission_end" );

    if ( !isdefined( var_0 ) )
        var_0 = 1;

    var_1 = maps\_utility::get_living_ai_array( "EnemyPatrolPool_AI", "targetname" );

    if ( var_0 == 1 )
    {
        var_2 = maps\_utility::get_living_ai( "PoolAllyTarget1", "script_noteworthy" );

        if ( isdefined( var_2 ) )
            var_1 = common_scripts\utility::array_remove( var_1, var_2 );
    }

    while ( !common_scripts\utility::flag( "FlagAllPoolGuardsDead" ) )
    {
        var_1 = array_removeclaimedtargets( var_1 );

        if ( self.script_noteworthy == "InfiltratorBurke" )
            var_3 = maps\greece_code::get_farthest_living( self.origin, var_1 );
        else
            var_3 = maps\_utility::get_closest_living( self.origin, var_1 );

        if ( isdefined( var_3 ) )
        {
            var_3.allyclaimedtarget = 1;
            var_3 disableenemyalert();

            if ( var_3.script_noteworthy == "PoolAllyTarget1" )
                var_3.favoriteenemy = self;

            maps\greece_code::shootguy( var_3, 1 );
            soundscripts\_snd::snd_message( "npc_shoots_pool_enemy" );
            thread alertallpoolguards();
        }

        wait 0.5;

        if ( var_1.size == 0 )
            break;
    }
}

alertallpoolguards()
{
    var_0 = maps\_utility::get_living_ai_array( "EnemyPatrolPool_AI", "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( var_2.script_noteworthy == "PoolAllyTarget1" && common_scripts\utility::flag( "FlagPoolKillReady" ) )
            continue;

        var_2 maps\_utility::anim_stopanimscripted();
        var_2 thread maps\_sniper_setup_ai::alertai();
        var_2 maps\_utility::clear_generic_idle_anim();
        var_2 maps\_utility::clear_generic_run_anim();
        var_2 maps\_utility::set_ignoreme( 0 );
        var_2 findnearbycovernode( 512 );
        var_2.combatmode = "cover";
    }
}

array_removeclaimedtargets( var_0 )
{
    var_0 = maps\_utility::array_removedead_or_dying( var_0 );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2.allyclaimedtarget ) )
            var_0 = common_scripts\utility::array_remove( var_0, var_2 );
    }

    return var_0;
}

allypoolclimb()
{
    level endon( "alarm_mission_end" );
    var_0 = getent( "OrgPoolKill", "script_noteworthy" );
    self.ignoreall = 0;
    var_0 maps\_anim::anim_single_solo( self, "pool_traverse_out" );
    var_1 = "hms_greece_cc_takedown";

    if ( common_scripts\utility::flag( "FlagPlayerKillPoolGuard" ) )
        var_1 = "hms_greece_cc_takedown_fail";

    var_0 = getent( "OrgPoolKill", "script_noteworthy" );
    thread allyexitpool( var_0, var_1 );
}

allyexitpool( var_0, var_1 )
{
    level endon( "alarm_mission_end" );
    self.no_stopanimscripted = 1;
    var_0 maps\_anim::anim_single_solo_run( self, var_1 );
    var_2 = maps\_utility::get_living_ai_array( "EnemyPatrolPool_AI", "targetname" );
    var_3 = 0;

    if ( var_1 == "hms_greece_cc_takedown" )
        var_3 = 1;

    if ( var_2.size > var_3 )
    {
        maps\_utility::set_goal_pos( self.origin );
        var_4 = maps\_utility::get_living_ai( "PoolAllyTarget1", "script_noteworthy" );

        if ( isdefined( var_4 ) && var_1 != "hms_greece_cc_takedown" )
            thread maps\greece_code::shootguy( var_4, 1 );
        else
            thread allyshootpooltarget( 0 );
    }

    wait 1.0;
    common_scripts\utility::flag_set( "FlagStopPoolWater" );
    self.no_stopanimscripted = undefined;
}

allyexithandlevictim( var_0, var_1, var_2 )
{
    level endon( "alarm_mission_end" );

    if ( isdefined( var_0 ) )
    {
        var_0 endon( "death" );

        if ( !common_scripts\utility::flag( "FlagPlayerKillPoolGuard" ) && var_2 == "hms_greece_cc_takedown" )
            var_0 victimpoolkill( var_1, var_2 );
    }
}

alliesparkingsetup()
{
    foreach ( var_1 in level.allyinfiltrators )
        var_1 clearenemy();

    level endon( "ConfRoomSetupBreach" );
    wait 1.0;
    thread allyredirectnoteworthy( "Infiltrator1", "ParkingStairs1" );
    wait 2.0;
    allyredirectnoteworthy( "Infiltrator2", "ParkingStairs1" );
    var_3 = maps\_utility::get_living_ai( "Infiltrator2", "script_noteworthy" );
    var_3 maps\greece_code::waittillaineargoal();
    common_scripts\utility::flag_set( "FlagParkingAlliesOnStairs" );
    maps\_hms_utility::printlnscreenandconsole( "Allies at ParkingStairs!" );
}

allyburkeparkingsetup()
{
    level endon( "ConfRoomSetupBreach" );
    thread allyredirectnoteworthy( "InfiltratorBurke", "ParkingStairs1" );
    level.infiltratorburke maps\greece_code::waittillaineargoal();
}

alliesparkingkill()
{
    common_scripts\utility::flag_wait( "FlagParkingCarAlarmActivated" );
    var_0 = maps\_utility::get_living_ai( "ParkingAllyTarget1", "script_noteworthy" );
    var_1 = getent( "StairwayTakedownOrg", "targetname" );
    var_2 = "stairway_takedown";
    var_3 = maps\_utility::get_living_ai( "InfiltratorBurke", "script_noteworthy" );

    if ( isdefined( var_0 ) )
        var_0 maps\greece_code::settargetoutline();

    common_scripts\utility::flag_wait_all( "FlagParkingAlliesOnStairs", "FlagParkingGuardsMovingToCar" );
    wait 1;

    if ( !common_scripts\utility::flag( "FlagAllParkingGuardsDead" ) )
    {
        if ( isdefined( var_0 ) )
        {
            maps\_hms_utility::printlnscreenandconsole( "Gideon is now moving toward parking stairs kill..." );
            var_1 maps\_anim::anim_reach_solo( var_3, var_2 );

            if ( isdefined( var_0 ) && isalive( var_0 ) )
            {
                var_0 thread alliesparkingkillvictim( var_1, var_2 );
                maps\_hms_utility::printlnscreenandconsole( "Gideon is now performing parking stairs kill..." );
                var_1 maps\_anim::anim_single_solo( var_3, var_2 );
                var_0 notify( "ParkingAllyKill" );

                if ( !common_scripts\utility::flag( "FlagParkingPlayerStealKill" ) )
                    var_1 thread maps\_anim::anim_loop_solo( var_3, "stairway_takedown_idle", "stop_stairway_idle" );
            }
            else if ( !common_scripts\utility::flag( "FlagAllParkingGuardsDead" ) )
                thread allyredirectnoteworthy( "InfiltratorBurke", "ParkingStairs2" );
        }
        else
            thread allyredirectnoteworthy( "InfiltratorBurke", "ParkingStairs2" );
    }

    common_scripts\utility::flag_set( "FlagParkingAlliesPerformKill" );
}

alliesparkingkillvictim( var_0, var_1 )
{
    self endon( "death" );
    thread monitorparkingkillvictim();
    self.health = 10;
    maps\_utility::set_ignoreall( 1 );
    self notify( "end_patrol" );
    self.animname = "victim";

    if ( isdefined( self.idlepoint ) )
        self.idlepoint notify( "stop_loop" );

    disableenemyalert();
    maps\_utility::disable_bulletwhizbyreaction();
    maps\_stealth_utility::disable_stealth_for_ai();
    self.bscripteddeath = 1;
    var_0 thread maps\_anim::anim_single_solo( self, var_1 );
    self.allowdeath = 1;
    var_0 waittill( var_1 );
    maps\greece_code::kill_no_react( 0 );
}

monitorparkingkillvictim()
{
    self waittill( "death" );
    self endon( "ParkingAllyKill" );
    common_scripts\utility::flag_set( "FlagParkingPlayerStealKill" );
    waitframe();
    level.infiltratorburke maps\_utility::anim_stopanimscripted();
    thread allyredirectnoteworthy( "InfiltratorBurke", "ParkingStairs2" );
    common_scripts\utility::flag_set( "FlagParkingAlliesPerformKill" );
}

alliesparkingkillalt()
{
    level endon( "parking_alarm_activated" );
    level endon( "alarm_mission_end" );
    level endon( "ConfRoomSetupBreach" );
    common_scripts\utility::flag_wait_all( "FlagParkingAlliesOnStairs", "FlagAnyParkingGuardsDead" );
    wait 1;
    var_0 = maps\_utility::get_living_ai( "ParkingAllyTarget1", "script_noteworthy" );

    while ( !common_scripts\utility::flag( "FlagAllParkingGuardsDead" ) )
    {
        if ( isdefined( var_0 ) )
        {
            var_0 disableenemyalert();
            level.infiltratorburke maps\greece_code::shootguy( var_0 );
            level.infiltratorburke soundscripts\_snd::snd_message( "npc_shoots_pool_enemy" );
        }

        wait 0.2;
    }

    wait 1;
    thread allyredirectnoteworthy( "InfiltratorBurke", "ParkingStairs2" );
}

allysetupstruggle()
{
    var_0 = [];
    var_1 = getent( "burkeambush_door", "targetname" );
    var_1.animname = "burkeambush_door";
    var_1 maps\_utility::assign_animtree( "burkeambush_door" );
    var_0 = common_scripts\utility::add_to_array( var_0, var_1 );
    level.infiltratorburke maps\_utility::disable_pain();
    var_2 = getent( "BurkeAmbushOrg", "targetname" );
    common_scripts\utility::flag_wait( "FlagCourtyardBurkeJumpCompleted" );
    common_scripts\utility::flag_set( "FlagStruggleBurkeApproaches" );
    var_2 maps\_anim::anim_reach_solo( level.infiltratorburke, "burkeambush" );
    var_3 = spawnenemystruggle();
    var_3.animname = "attacker";
    var_3.allowdeath = 1;
    level.enemystruggler = var_3;
    var_0 = common_scripts\utility::add_to_array( var_0, var_3 );
    setupvalidtargetsbyname( "EnemyPatrolStruggle" );
    common_scripts\utility::flag_set( "FlagStruggleGuardAttacks" );
    thread allystruggleslomo( var_3 );
    thread allystrugglesuccess( var_3, var_1 );
    thread monitorallystrugglefailure( var_2, var_3, level.infiltratorburke );
    level.infiltratorburke.hasbeenhit = 0;
    var_2 thread maps\_anim::anim_single_solo_run( level.infiltratorburke, "burkeambush" );
    var_2 maps\_anim::anim_single( var_0, "burkeambush" );
    var_3 notify( "AttackComplete" );
}

burkeambushnohitnotetrack( var_0 )
{
    var_1 = getent( "BurkeAmbushOrg", "targetname" );
    var_2 = "burkeambush_nohit";

    if ( !isalive( level.enemystruggler ) )
    {
        level.infiltratorburke maps\_utility::anim_stopanimscripted();
        waitframe();
        level.infiltratorburke maps\_utility::set_ignoreall( 1 );
        var_3 = maps\_utility::get_living_ai( "PoolPlayerTarget3", "script_noteworthy" );

        if ( isdefined( var_3 ) )
            level.infiltratorburke maps\_utility::set_favoriteenemy( var_3 );

        var_1 maps\_anim::anim_single_solo_run( level.infiltratorburke, var_2 );
        level.infiltratorburke maps\_utility::set_ignoreall( 0 );
    }
    else
        level.infiltratorburke.hasbeenhit = 1;
}

allystruggleslomo( var_0 )
{
    wait 2.0;

    if ( isdefined( var_0 ) )
    {
        level notify( "BeginGideonKillWatch" );
        var_0 thread objmarkerplayertarget( 1 );
        setslowmotion( 1.0, 0.5, 0.5 );
        soundscripts\_snd::snd_message( "start_burke_ambush_slomo" );
        var_0 common_scripts\utility::waittill_any( "death", "AttackComplete" );
        setslowmotion( 0.5, 1.0, 0.5 );
        soundscripts\_snd::snd_message( "stop_burke_ambush_slomo" );
    }
}

allystrugglesuccess( var_0, var_1 )
{
    level endon( "alarm_mission_end" );
    var_2 = level.infiltratorburke.weapon;
    var_3 = getent( "BurkeAmbushOrg", "targetname" );
    var_0 waittill( "death" );

    if ( isalive( level.infiltratorburke ) )
    {
        common_scripts\utility::flag_set( "FlagStruggleBurkeRecovers" );

        if ( level.infiltratorburke.hasbeenhit )
            var_3 waittill( "burkeambush" );
        else
            var_3 waittill( "burkeambush_nohit" );

        if ( level.infiltratorburke.weapon == "none" )
        {
            level.infiltratorburke.weapon = var_2;
            level.infiltratorburke maps\_utility::forceuseweapon( level.infiltratorburke.weapon, "primary" );
            level.infiltratorburke maps\_utility::enable_pain();
        }
    }
}

monitorallystrugglefailure( var_0, var_1, var_2 )
{
    var_1 endon( "death" );
    level waittill( "BeginGideonKillWatch" );
    var_2 waittill( "damage", var_3, var_4 );
    var_5 = 0;

    if ( isdefined( var_4 ) && var_4 == level.player )
        var_5 = 1;

    thread failburkekilled( var_0, var_1, var_2, var_5 );
}

failburkekilled( var_0, var_1, var_2, var_3 )
{
    common_scripts\utility::flag_set( "disable_autosaves" );
    common_scripts\utility::flag_set( "FlagDisableAutosave" );
    var_1 notify( "AttackComplete" );
    thread burkestruggledeath();
    level notify( "burke_killed" );
    level notify( "alarm_mission_end" );
    wait 0.05;
    maps\_hms_utility::printlnscreenandconsole( "MISSION FAIL - BURKE KILLED!!!" );
    confcentertotalcombat( 0 );
    maps\greece_conf_center_vo::confcenterfailburkekilleddialogue( var_3 );
    wait 1;

    if ( var_3 == 0 )
        setdvar( "ui_deadquote", &"GREECE_DRONE_BURKEKILLED_FAIL" );

    maps\_utility::missionfailedwrapper();
}

burkestruggledeath()
{
    var_0 = getent( "BurkeAmbushOrg", "targetname" );
    level.infiltratorburke.no_stopanimscripted = 1;
    var_1 = level.infiltratorburke.origin + ( -40, 10, 32 );
    playfx( common_scripts\utility::getfx( "blood_impact_splat" ), var_1 );
    var_0 maps\_anim::anim_single_solo( level.infiltratorburke, "burkeambush_death" );
    level.infiltratorburke maps\_utility::stop_magic_bullet_shield();
    level.infiltratorburke maps\greece_code::kill_no_react();
    level.infiltratorburke unmarkandremoveoutline( 0 );
}

atriumbreachidleinfiltrators( var_0 )
{
    var_1 = common_scripts\utility::getstruct( "atrium_breach_org", "targetname" );
    level.mute_charge = maps\_utility::spawn_anim_model( "mute_charge" );
    level.mute_charge hide();
    level.breach_charge = maps\_utility::spawn_anim_model( "breach_charge" );
    level.breach_charge hide();
    level.breach_charge.include_in_idle = 1;
    var_2 = maps\_utility::get_living_ai( "Infiltrator1", "script_noteworthy" );
    var_3 = maps\_utility::get_living_ai( "Infiltrator2", "script_noteworthy" );

    if ( var_0 )
    {
        var_4 = getent( "AtriumBreachTeleport_Infiltrator1", "targetname" );
        var_5 = getent( "AtriumBreachTeleport_Infiltrator2", "targetname" );
        var_2 forceteleport( var_4.origin, var_4.angles );
        var_3 forceteleport( var_5.origin, var_5.angles );
    }

    thread atriumbreachidle( var_1, var_2, level.breach_charge, var_0 );
    thread atriumbreachidle( var_1, var_3, level.mute_charge, var_0 );
}

atriumbreachidleburke( var_0 )
{
    var_1 = common_scripts\utility::getstruct( "atrium_breach_org", "targetname" );
    level.breach_charge_2 = maps\_utility::spawn_anim_model( "breach_charge" );
    level.breach_charge_2.animname = "breach_charge_2";
    level.breach_charge_2.include_in_idle = 1;
    var_2 = maps\_utility::get_living_ai( "InfiltratorBurke", "script_noteworthy" );

    if ( var_0 )
    {
        var_3 = getent( "AtriumBreachTeleport_InfiltratorBurke", "targetname" );
        var_2 forceteleport( var_3.origin, var_3.angles );
    }

    thread atriumbreachidle( var_1, var_2, level.breach_charge_2, var_0 );
}

atriumbreachidle( var_0, var_1, var_2, var_3 )
{
    var_4 = "mutebreach_setup";
    var_5 = "mutebreach_idle";
    var_1 clearenemy();
    var_6 = [];
    var_6[0] = var_1;
    var_7 = [];
    var_7[0] = var_1;

    if ( isdefined( var_2 ) )
    {
        var_6[1] = var_2;

        if ( isdefined( var_2.include_in_idle ) )
            var_7[1] = var_2;
    }

    if ( var_3 == 0 )
    {
        var_0 maps\_anim::anim_reach_solo( var_1, var_4 );
        var_1.readyforatriumbreach = 1;
        var_0 maps\_anim::anim_single( var_6, var_4 );
    }

    var_1.readyforatriumbreach = 1;

    if ( !common_scripts\utility::flag( "FlagAtriumAlliesPerformBreach" ) )
        var_0 thread maps\_anim::anim_loop( var_7, var_5, "EndAtriumBreachIdle" );
}

atriumbreachmonitoralliesinposition()
{
    var_0 = level.allyinfiltrators;
    var_1 = 0;

    while ( !common_scripts\utility::flag( "FlagAtriumAlliesReadyToBreach" ) )
    {
        foreach ( var_3 in var_0 )
        {
            if ( isdefined( var_3.readyforatriumbreach ) && var_3.readyforatriumbreach == 1 )
            {
                var_1++;
                maps\_hms_utility::printlnscreenandconsole( var_1 + " allies are ready to breach Atrium!" );
                var_0 = common_scripts\utility::array_remove( var_0, var_3 );
            }
        }

        if ( var_1 == 3 )
            break;

        wait 0.05;
    }

    common_scripts\utility::flag_set( "FlagAtriumAlliesReadyToBreach" );
    maps\_hms_utility::printlnscreenandconsole( "Allies at AtriumBreach!" );
}

atriumbreachexplosionnotetrack( var_0 )
{
    maps\greece_conf_center_fx::confcenteratriumflashcharge();
    soundscripts\_snd::snd_message( "start_atrium_fight" );
    level.breach_charge stopanimscripted();
    level.breach_charge_2 stopanimscripted();
    level.breach_charge delete();
    level.breach_charge_2 delete();
    wait 1;
    common_scripts\utility::flag_set( "FlagAtriumEnemiesReactToBreach" );
    rumbleatriumbreach();
}

showentnotetrack( var_0 )
{
    var_0 show();
}

alliesbreachatrium()
{
    var_0 = common_scripts\utility::getstruct( "atrium_breach_org", "targetname" );
    var_1 = "mutebreach";
    var_2 = getent( "atrium_door_bottom", "targetname" );
    var_3 = getent( "atrium_door_bottom_clip", "targetname" );
    var_2 maps\_utility::assign_animtree( "atrium_door" );
    var_2.animname = "atrium_door_bottom";
    var_4 = getent( "atrium_door_top", "targetname" );
    var_5 = getent( "atrium_door_top_clip", "targetname" );
    var_4 maps\_utility::assign_animtree( "atrium_door" );
    var_4.animname = "atrium_door_top";
    var_6 = level.breach_charge;
    var_7 = level.breach_charge_2;
    var_8 = maps\_utility::get_living_ai( "Infiltrator1", "script_noteworthy" );
    var_9 = maps\_utility::get_living_ai( "Infiltrator2", "script_noteworthy" );
    var_10 = maps\_utility::get_living_ai( "InfiltratorBurke", "script_noteworthy" );
    var_11 = [ var_8, var_9, var_10 ];
    var_12 = [ var_2, var_4, var_6, var_7 ];
    var_0 notify( "EndAtriumBreachIdle" );
    waitframe();
    var_13 = getdvarfloat( "ai_eventDistGunshot" );
    var_14 = getdvarfloat( "ai_eventDistGunshotTeam" );
    setsaveddvar( "ai_eventDistGunshot", 50 );
    setsaveddvar( "ai_eventDistGunshotTeam", 50 );
    var_5 delete();
    var_3 delete();
    var_15 = [];
    var_15["sight_dist"] = 400;
    var_15["detect_dist"] = 100;
    maps\_stealth_utility::stealth_corpse_ranges_custom( var_15 );
    thread atriumdoorbreachdamage();
    var_0 thread maps\_anim::anim_single( var_12, var_1 );
    var_0 maps\_anim::anim_single_run( var_11, var_1 );
    thread alliesredirect( "AtriumFight1" );

    foreach ( var_17 in level.allyinfiltrators )
        var_17 aienablestealthcombat();

    enablealliescolor();
    maps\_utility::activate_trigger_with_targetname( "TrigBurke101" );
    maps\_utility::activate_trigger_with_targetname( "TrigAllies101" );
    common_scripts\utility::flag_wait( "FlagAtriumEnemiesAlmostAllDead" );
    wait(randomfloatrange( 1, 3 ));

    if ( !common_scripts\utility::flag( "FlagAllAtriumGuardsDead" ) )
    {
        thread alliesredirect( "AtriumFight2" );
        maps\_utility::activate_trigger_with_targetname( "TrigBurke102" );
        maps\_utility::activate_trigger_with_targetname( "TrigAllies102" );
    }

    common_scripts\utility::flag_wait( "FlagEndAtriumSetup" );
    setsaveddvar( "ai_eventDistGunshot", var_13 );
    setsaveddvar( "ai_eventDistGunshotTeam", var_14 );
    disablealliescolor();

    foreach ( var_20 in level.allyinfiltrators )
    {
        var_20 aidisablestealthcombat();
        var_20 maps\greece_code::disableawareness();
    }

    var_15 = [];
    var_15["sight_dist"] = 800;
    var_15["detect_dist"] = 200;
    maps\_stealth_utility::stealth_corpse_ranges_custom( var_15 );
}

atriumdoorbreachdamage()
{
    wait 0.5;
    var_0 = getent( "AtriumDoorBreachDamageVol", "targetname" );
    var_1 = var_0 maps\_utility::get_ai_touching_volume( "axis" );
    var_1 = maps\_utility::array_removedead_or_dying( var_1 );

    foreach ( var_3 in var_1 )
        var_3 kill();
}

atriumdoorsopenonalarm()
{
    level waittill( "alarm_mission_end" );

    while ( !common_scripts\utility::flag( "FlagEndStruggleSetup" ) )
    {
        if ( common_scripts\utility::flag( "FlagAlarmMissionEnd" ) )
        {
            atriumdoorsopen();
            break;
        }

        wait 0.05;
    }
}

atriumdoorsopen()
{
    var_0 = maps\_utility::get_living_ai_array( "EnemyPatrolAtrium_AI", "targetname" );
    var_1 = getent( "atrium_door_top", "targetname" );
    var_2 = getent( "atrium_door_top_clip", "targetname" );
    var_3 = getent( "atrium_door_top_org", "targetname" );
    var_2 delete();
    var_1 linkto( var_3 );
    var_3 rotateto( var_3.angles + ( 0, 120, 0 ), 0.35, 0, 0.35 );
    var_4 = maps\_utility::get_closest_index( var_1.origin, var_0 );

    if ( isdefined( var_0[var_4] ) )
    {
        var_5 = var_0[var_4];
        var_0 = common_scripts\utility::array_remove( var_0, var_5 );
        var_6 = getent( "WalkwayTopVol", "targetname" );
        var_5 setgoalvolumeauto( var_6 );
    }

    var_7 = getent( "atrium_door_bottom", "targetname" );
    var_8 = getent( "atrium_door_bottom_clip", "targetname" );
    var_9 = getent( "atrium_door_bottom_org", "targetname" );
    var_8 delete();
    var_7 linkto( var_9 );
    var_9 rotateto( var_9.angles + ( 0, 120, 0 ), 0.35, 0, 0.35 );
    var_10 = getent( "WalkwayBottomVol", "targetname" );
    var_11 = common_scripts\utility::get_array_of_closest( var_7.origin, var_0 );

    if ( isdefined( var_11[0] ) )
        var_11[0] setgoalvolumeauto( var_10 );

    if ( isdefined( var_11[1] ) )
        var_11[1] setgoalvolumeauto( var_10 );
}

alliesparkingdefend()
{
    level endon( "AlliesWillAllDie" );

    foreach ( var_1 in level.allyinfiltrators )
        var_1 thread aienabletotalcombat( 0 );

    enablealliescolor();
    maps\_utility::activate_trigger_with_targetname( "TrigBurke103" );
    maps\_utility::activate_trigger_with_targetname( "TrigAllies103" );
    common_scripts\utility::flag_wait( "FlagSomeAmbushSouthGuardsDead" );
    thread alliesredirect( "ParkingDefend1" );
    maps\_utility::activate_trigger_with_targetname( "TrigBurke105" );
    maps\_utility::activate_trigger_with_targetname( "TrigAllies105" );
    common_scripts\utility::flag_wait_all( "FlagAllAmbushGuardsDead", "FlagEnemyVehicleTurretDisabled" );
    thread alliesredirect( "ParkingDefend2" );
    maps\_utility::activate_trigger_with_targetname( "TrigBurke106" );
    maps\_utility::activate_trigger_with_targetname( "TrigAllies106" );
    common_scripts\utility::flag_set( "FlagSpawnEnemyReinforcements" );
    common_scripts\utility::flag_wait( "FlagBeginConfCenterOutro" );
    wait 0.5;
    thread parkingburkejumpdown();
    wait 0.5;
    thread allyredirectnoteworthy( "Infiltrator2", "ParkingEnd" );
    maps\_utility::activate_trigger_with_targetname( "TrigAllies107" );
}

parkingburkejumpdown()
{
    var_0 = common_scripts\utility::getstruct( "BurkeParkingBoostJumpOrg", "targetname" );
    var_1 = "parking_boostjump";
    level.infiltratorburke maps\_utility::set_ignoreall( 1 );
    waitframe();
    var_0 maps\_anim::anim_reach_solo( level.infiltratorburke, var_1 );
    var_0 maps\_anim::anim_single_solo_run( level.infiltratorburke, var_1 );
    level.infiltratorburke maps\_utility::set_ignoreall( 0 );
    thread allyredirectnoteworthy( "InfiltratorBurke", "ParkingEnd" );
    maps\_utility::activate_trigger_with_targetname( "TrigBurke107" );
}

monitorzoomonburke()
{
    common_scripts\utility::flag_wait( "FlagBeginZoomOnBurke" );
    waittillplayerlookattarget( level.infiltratorburke );
    common_scripts\utility::flag_set( "FlagEndZoomOnBurke" );
}

monitorzoomonhades1()
{
    level.confhades hudoutlineenable( 5, 0 );
    level.player allowads( 1 );
    thread maps\_utility::hintdisplayhandler( "drone_zoom" );
    waittillplayerlookattarget( level.confhades, 5, 1 );
    common_scripts\utility::flag_set( "FlagPlayerZoomOnHades1" );
    wait 3.0;
    common_scripts\utility::flag_set( "FlagContinueDroneFlyin" );
    level.confhades hudoutlinedisable();
    thread autosavesniperdronestealth( "conf_center_hades_zoom_1" );
}

hintdronezoomoff()
{
    return level.player adsbuttonpressed( 1 );
}

hintlookattruckoff()
{
    if ( common_scripts\utility::flag( "FlagOkayToShootDrone" ) || common_scripts\utility::flag( "FlagAlarmMissionEnd" ) )
        return 1;

    return 0;
}

monitorzoomonhades2()
{
    waittillplayerlookattargetintrigger( level.confhades, "TriggerConfRoomPlayer", 15, 1 );
    thread autosavesniperdronestealth( "conf_center_hades_zoom_2" );
    common_scripts\utility::flag_set( "FlagPlayerZoomOnHades2" );
}

waittillplayerlookattarget( var_0, var_1, var_2 )
{
    var_0 endon( "death" );
    level endon( "alarm_mission_end" );

    if ( !isdefined( var_2 ) )
        var_2 = 1;

    if ( !isdefined( var_1 ) )
        var_1 = 10;

    var_0 thread monitorplayerlookat( var_1, var_2 );
    var_0 waittill( "PlayerLookAt" );

    if ( isdefined( var_0.name ) )
        maps\_hms_utility::printlnscreenandconsole( "Player has successfully looked at target" + var_0.name );
    else
        maps\_hms_utility::printlnscreenandconsole( "Player has successfully looked at target" );
}

drawplayerlookatdebug( var_0, var_1, var_2, var_3 )
{
    var_4 = level.player getgunangles();
    var_1 = level.player getangles();
    var_5 = anglestoforward( var_1 + ( 0, var_3, 0 ) );
    var_6 = anglestoforward( var_1 + ( 0, var_3 * -1, 0 ) );
    var_7 = anglestoforward( var_1 + ( var_3, 0, 0 ) );
    var_8 = anglestoforward( var_1 + ( var_3 * -1, 0, 0 ) );
    thread maps\_utility::draw_circle_for_time( var_2, 50, 1, 0, 0, 0.05 );
}

monitorplayerlookat( var_0, var_1 )
{
    self endon( "death" );

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    var_2 = undefined;
    var_3 = cos( var_0 );

    for (;;)
    {
        wait 0.05;

        if ( issentient( self ) )
            var_2 = self geteye();
        else
            var_2 = self.origin;

        if ( level.showdebugtoggle == 1 )
            drawplayerlookatdebug( level.player geteye(), level.player getgunangles(), var_2, var_0 );

        if ( var_1 == 1 && !level.player adsbuttonpressed() )
            continue;

        if ( common_scripts\utility::within_fov( level.player geteye(), level.player getgunangles(), var_2, var_3 ) == 1 )
        {
            self notify( "PlayerLookAt" );
            return;
        }
    }
}

waittillplayerlookattargetintrigger( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 30;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    var_5 = getent( var_1, "targetname" );
    thread waittillplayerlookattarget( var_0, var_2, var_3 );
    var_6 = spawnstruct();
    var_6.threads = 0;
    var_0 childthread common_scripts\utility::waittill_string( "PlayerLookAt", var_6 );
    var_6.threads++;
    var_5 childthread common_scripts\utility::waittill_string( "trigger", var_6 );

    for ( var_6.threads++; var_6.threads; var_6.threads-- )
    {
        if ( isdefined( var_4 ) )
        {
            var_6 common_scripts\utility::waittill_notify_or_timeout( "returned", var_4 );
            continue;
        }

        var_6 waittill( "returned" );
    }
}

waittillplayerlookatescapevehicle()
{
    var_0 = getent( "TriggerEscapeVehiclePlayer", "targetname" );
    var_1 = getent( "HadesEscapeVehicle", "targetname" );
    thread waittillplayerlookattarget( var_1, 15, 1 );
    var_2 = spawnstruct();
    var_2.threads = 0;
    var_1 childthread common_scripts\utility::waittill_string( "PlayerLookAt", var_2 );
    var_2.threads++;
    var_0 childthread common_scripts\utility::waittill_string( "trigger", var_2 );

    for ( var_2.threads++; var_2.threads; var_2.threads-- )
        var_2 waittill( "returned" );
}

initconfcenterstealthsettings()
{
    var_0 = [];
    var_0["ai_eventDistNewEnemy"] = [];
    var_0["ai_eventDistNewEnemy"]["spotted"] = 256;
    var_0["ai_eventDistNewEnemy"]["hidden"] = 128;
    var_0["ai_eventDistExplosion"] = [];
    var_0["ai_eventDistExplosion"]["spotted"] = 512;
    var_0["ai_eventDistExplosion"]["hidden"] = 512;
    var_0["ai_eventDistDeath"] = [];
    var_0["ai_eventDistDeath"]["spotted"] = 512;
    var_0["ai_eventDistDeath"]["hidden"] = 512;
    var_0["ai_eventDistPain"] = [];
    var_0["ai_eventDistPain"]["spotted"] = 256;
    var_0["ai_eventDistPain"]["hidden"] = 256;
    var_0["ai_eventDistBullet"] = [];
    var_0["ai_eventDistBullet"]["spotted"] = 96;
    var_0["ai_eventDistBullet"]["hidden"] = 96;
    var_0["ai_eventDistFootstep"] = [];
    var_0["ai_eventDistFootstep"]["spotted"] = 256;
    var_0["ai_eventDistFootstep"]["hidden"] = 256;
    var_0["ai_eventDistFootstepWalk"] = [];
    var_0["ai_eventDistFootstepWalk"]["spotted"] = 128;
    var_0["ai_eventDistFootstepWalk"]["hidden"] = 128;
    var_0["ai_eventDistFootstepSprint"] = [];
    var_0["ai_eventDistFootstepSprint"]["spotted"] = 512;
    var_0["ai_eventDistFootstepSprint"]["hidden"] = 512;
    maps\_stealth_utility::stealth_ai_event_dist_custom( var_0 );
    var_1 = [];
    var_1["sight_dist"] = 800;
    var_1["detect_dist"] = 200;
    maps\_stealth_utility::stealth_corpse_ranges_custom( var_1 );
}

initalerttime()
{
    var_0 = [];
    var_0[0] = 4.5;
    var_0[1] = 3.0;
    var_0[2] = 2.0;
    var_0[3] = 1.0;
    level.alerttimedelay = var_0[level.gameskill];
}

monitoratriumfighttimer()
{
    level endon( "AtriumTimerFreeze" );
    level endon( "alarm_mission_end" );
    var_0 = [];
    var_0[0] = 40;
    var_0[1] = 30;
    var_0[2] = 20;
    var_0[3] = 15;
    level.atriumtimewindow = var_0[level.gameskill];
    var_1 = [];
    var_1[0] = 15;
    var_1[1] = 10;
    var_1[2] = 5;
    var_1[3] = 0;
    var_2 = var_1[level.gameskill];
    wait 3.0;
    level.atriumtimer = maps\_hud_util::get_countdown_hud();
    level.atriumtimer.label = &"GREECE_ATRIUM_TIMER_LABEL";
    level.atriumtimer.x = -110;
    level.atriumtimer.y = 45;
    level.atriumtimer.alignx = "left";
    level.atriumtimer.horzalign = "center";
    level.atriumtimer.color = ( 0.95, 0.95, 1 );
    level.atriumtimer settenthstimerstatic( level.atriumtimewindow );
    level.atriumtimer setpulsefx( 30, 900000, 700 );
    common_scripts\utility::flag_wait( "FlagAtriumEnemiesAllMarked" );
    level.atriumtimer settenthstimer( level.atriumtimewindow );
    thread freezeatriumfighttimer();
    thread markatriumenemiesatwarning( var_2 );
    wait(level.atriumtimewindow);
    level notify( "AtriumTimerExpire" );
    destroyatriumfighttimer();
    maps\_hms_utility::printlnscreenandconsole( "TIMER EXPIRED!!!" );
    soundscripts\_snd::snd_message( "atrium_timer_expire" );
    thread failatriumfighttimerexpire();
}

markatriumenemiesatwarning( var_0 )
{
    level endon( "AtriumTimerFreeze" );

    if ( var_0 > 0 )
    {
        var_1 = level.atriumtimewindow - var_0;
        wait(var_1);
        thread setupplayertargets( "AtriumPlayerTarget", 1, 1 );
        var_2 = maps\_utility::get_living_ai_array( "EnemyPatrolAtrium_AI", "targetname" );
        level waittill( "AtriumTimerExpire" );
        var_2 = maps\_utility::array_removedead_or_dying( var_2 );

        foreach ( var_4 in var_2 )
            var_4 setthreatdetection( "enhanceable" );
    }
}

failatriumfighttimerexpire()
{
    common_scripts\utility::flag_set( "disable_autosaves" );
    common_scripts\utility::flag_set( "FlagDisableAutosave" );
    level notify( "alarm_mission_end" );
    wait 0.05;
    maps\_hms_utility::printlnscreenandconsole( "MISSION FAIL - TIMER EXPIRED!!!" );
    confcentertotalcombat( 0 );
    maps\greece_conf_center_vo::confcenterfailtimerexpiredialogue();
    wait 1;
    setdvar( "ui_deadquote", &"GREECE_DRONE_TIMEREXPIRE_FAIL" );
    maps\_utility::missionfailedwrapper();
}

freezeatriumfighttimer()
{
    level endon( "AtriumTimerExpire" );
    var_0 = gettime();
    level waittill( "AtriumTimerFreeze" );
    var_1 = gettime();
    var_2 = ( var_1 - var_0 ) * 0.001;
    var_3 = level.atriumtimewindow - var_2;
    level.atriumtimer settenthstimerstatic( var_3 );
    wait 5.0;
    destroyatriumfighttimer();
}

destroyatriumfighttimer()
{
    if ( isdefined( level.atriumtimer ) )
        level.atriumtimer destroy();
}

monitorparkingcars()
{
    level endon( "end_sniper_drone" );
    level endon( "alarm_mission_end" );
    level endon( "ConfRoomExplosion" );

    if ( level.currentgen )
    {
        if ( !istransientloaded( "greece_confcenter_tr" ) )
            level waittill( "tff_post_intro_to_confcenter" );

        var_0 = level.sniper_marked_cars;
    }
    else
        var_0 = getentarray( "ParkingAlarmCar", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_2 thread monitorparkingcaralarm();
        var_2 thread monitorparkingcarexplode();
    }

    common_scripts\utility::flag_wait( "FlagParkingCarAlarmActivated" );
    maps\_hms_utility::printlnscreenandconsole( "Parking car alarm is on!" );

    if ( common_scripts\utility::flag( "FlagBeginParkingSetup" ) || common_scripts\utility::flag( "FlagAllRooftopGuardsDead" ) )
        thread alliesparkingkill();
    else
    {
        var_4 = level.start_point;

        if ( var_4 != "start_conf_center_combat" && var_4 != "start_conf_center_outro" )
            thread failinvalidtarget();
    }
}

markparkingcars()
{
    var_0 = getentarray( "ParkingAlarmCar", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 thread objmarkervehicle( "FlagUnMarkParkingCars", 0, 0 );
}

monitorparkingcarexplode()
{
    level endon( "end_sniper_drone" );
    level endon( "alarm_mission_end" );
    level endon( "parking_car_explode" );
    level endon( "ConfRoomExplosion" );
    var_0 = level.start_point;

    if ( var_0 != "start_conf_center_combat" && var_0 != "start_conf_center_outro" )
    {
        self waittill( "death" );
        thread failinvalidtarget();
        level notify( "parking_car_explode" );
    }
}

monitorparkingcaralarm()
{
    level endon( "end_sniper_drone" );
    level endon( "alarm_mission_end" );
    level endon( "parking_alarm_activated" );
    level endon( "parking_guard_shot" );
    var_0 = level.start_point;

    if ( var_0 != "start_conf_center_kill" && var_0 != "start_conf_center_combat" && var_0 != "start_conf_center_outro" )
    {
        self waittill( "damage" );
        soundscripts\_snd::snd_message( "start_car_alarm", self );
        level.parkingalarmcar = self;
        level.parkingalarmcar.balarmon = 1;
        common_scripts\utility::flag_set( "FlagParkingCarAlarmActivated" );
        common_scripts\utility::flag_set( "FlagParkingCarAlarmDisableAutosave" );
        common_scripts\utility::flag_set( "disable_autosaves" );
        common_scripts\utility::flag_set( "FlagUnMarkParkingCars" );
        level notify( "disableParkingCorpseDetection" );
        level notify( "parking_alarm_activated" );
        thread _caralarmfx();
    }
}

_caralarmfx()
{
    self endon( "death" );
    level endon( "parking_alarm_deactivated" );
    var_0 = self.classname;

    for ( var_1 = 0; var_1 < 15; var_1++ )
    {
        if ( !isdefined( level.vehicle_lights_group[var_0] ) )
            continue;

        foreach ( var_4, var_3 in level.vehicle_lights_group[var_0] )
        {
            if ( var_4 == "all" || var_4 == "frontlights" )
                continue;

            thread maps\_vehicle::vehicle_lights_on( var_4 );
        }

        wait 1;

        foreach ( var_4, var_3 in level.vehicle_lights_group[var_0] )
        {
            if ( var_4 == "all" || var_4 == "frontlights" )
                continue;

            thread maps\_vehicle::vehicle_lights_off( var_4 );
        }

        wait 1;
    }

    _caralarmstop();
}

_caralarmstop()
{
    if ( isdefined( level.parkingalarmcar ) && level.parkingalarmcar.balarmon == 1 )
    {
        level.parkingalarmcar soundscripts\_snd::snd_message( "stop_car_alarm" );
        level notify( "parking_alarm_deactivated" );
        level.parkingalarmcar.balarmon = 0;
    }

    common_scripts\utility::flag_clear( "FlagParkingCarAlarmDisableAutosave" );
    common_scripts\utility::flag_clear( "disable_autosaves" );
}

enemiesignoreplayerdrone( var_0 )
{
    if ( var_0 == 1 )
    {
        createthreatbiasgroup( "player_drone" );
        self setthreatbiasgroup( "player_drone" );
        setignoremegroup( "player_drone", "axis" );
    }
    else
        self setthreatbiasgroup();
}

monitorlevelalarm()
{
    level endon( "end_sniper_drone" );
    maps\_hms_utility::printlnscreenandconsole( "Now monitoring level alarm..." );
    common_scripts\utility::flag_wait( "FlagAlarmMissionEnd" );
    thread faillevelalarm();
}

faillevelalarm()
{
    common_scripts\utility::flag_set( "disable_autosaves" );
    common_scripts\utility::flag_set( "FlagDisableAutosave" );
    soundscripts\_snd::snd_message( "cc_kva_alerted_walla" );
    wait 0.05;
    maps\_hms_utility::printlnscreenandconsole( "MISSION FAIL - ALARM SOUNDED!!!" );
    confcentertotalcombat( 0 );
    maps\greece_conf_center_vo::confcenterfailalarmsoundeddialogue();
    wait 1;
    setdvar( "ui_deadquote", &"GREECE_DRONE_ALERT_FAIL" );
    maps\_utility::missionfailedwrapper();
}

setupvalidtargetsbyname( var_0 )
{
    var_1 = var_0 + "_AI";
    var_2 = maps\_utility::get_living_ai_array( var_1, "targetname" );
    setupvalidtargetsbyarray( var_2 );
    maps\_hms_utility::printlnscreenandconsole( var_0 + " enemies have been designated as valid targets" );
}

setupvalidtargetsbyarray( var_0 )
{
    foreach ( var_2 in var_0 )
        var_2 notify( "valid_target" );
}

monitorisenemyvalidtarget()
{
    level endon( "end_sniper_drone" );
    level endon( "alarm_mission_end" );
    self endon( "valid_target" );
    self waittill( "death" );
    thread failinvalidtarget();
}

failinvalidtarget()
{
    common_scripts\utility::flag_set( "disable_autosaves" );
    common_scripts\utility::flag_set( "FlagDisableAutosave" );
    level notify( "alarm_mission_end" );
    wait 0.05;
    maps\_hms_utility::printlnscreenandconsole( "MISSION FAIL - PLAYER KILLED INVALID TARGET!!!" );
    maps\greece_conf_center_vo::confcenterfailinvalidtargetdialogue();
    confcentertotalcombat( 0 );
    wait 1;
    setdvar( "ui_deadquote", &"GREECE_DRONE_INVALIDTARGET_FAIL" );
    maps\_utility::missionfailedwrapper();
}

confcentertotalcombat( var_0 )
{
    maps\_hms_utility::printlnscreenandconsole( "TOTAL COMBAT!!!" );
    level.allyinfiltrators = maps\_utility::array_removedead( level.allyinfiltrators );
    level.allenemypatrollers = maps\_utility::array_removedead( level.allenemypatrollers );
    common_scripts\utility::flag_set( "disable_autosaves" );
    common_scripts\utility::flag_set( "FlagDisableAutosave" );
    thread releasemeetingcivilians();
    level.player enemiesignoreplayerdrone( 0 );
    var_1 = maps\_utility::array_merge( level.allyinfiltrators, level.allenemypatrollers );

    foreach ( var_3 in var_1 )
        var_3 thread aienabletotalcombat( var_0 );
}

releasemeetingcivilians()
{
    var_0 = common_scripts\utility::getstruct( "CC_Breach", "targetname" );
    var_1 = "cc_breach";

    if ( !common_scripts\utility::flag( "FlagOkayToKillHades" ) )
    {
        maps\_hms_utility::printlnscreenandconsole( "MEETING CIVILIANS FREAK OUT!!!" );
        var_0 notify( "stopPacingIdles" );
        var_0 notify( "speech" );
        var_0 notify( "Breach" );
        var_2 = maps\_utility::get_living_ai_array( "ConfRoomVip_AI", "targetname" );

        foreach ( var_4 in var_2 )
            var_4 maps\_utility::anim_stopanimscripted();

        wait 0.05;
        var_0 thread maps\_anim::anim_single( var_2, var_1 );
    }
}

autosavesniperdronestealth( var_0 )
{
    var_1 = undefined;

    if ( isdefined( level.curautosave ) )
        var_1 = level.curautosave;

    waitframe();
    thread maps\_utility::autosave_by_name( var_0 );
    wait 5.0;

    if ( isdefined( var_1 ) )
    {
        if ( var_1 != level.curautosave )
            maps\_hms_utility::printlnscreenandconsole( "*** Sniperdrone stealth autosave " + var_0 + " SUCCESS! ***" );
        else
            maps\_hms_utility::printlnscreenandconsole( "*** Sniperdrone stealth autosave " + var_0 + " FAILED! ***" );
    }
}

autosaveconfcenterstealthcheck()
{
    if ( isdefined( level.alertedenemies ) )
    {
        level.alertedenemies = maps\_utility::array_removedead_or_dying( level.alertedenemies );

        if ( !common_scripts\utility::flag( "FlagAlarmMissionEnd" ) && level.alertedenemies.size == 0 )
            common_scripts\utility::flag_clear( "FlagDisableAutosave" );

        common_scripts\utility::flag_clear( "disable_autosaves" );

        if ( level.alertedenemies.size > 0 )
        {
            maps\_hms_utility::printlnscreenandconsole( "Tried to autosave but there are " + level.alertedenemies.size + " enemies alerted!!!" );

            foreach ( var_1 in level.alertedenemies )
            {
                if ( isdefined( var_1.script_noteworthy ) )
                {
                    maps\_hms_utility::printlnscreenandconsole( "This guy is alerted... " + var_1.script_noteworthy );
                    continue;
                }

                maps\_hms_utility::printlnscreenandconsole( "A nameless guy is alerted... " );
            }

            return 0;
        }
    }

    if ( common_scripts\utility::flag( "FlagConfHadesDead" ) && !common_scripts\utility::flag( "FlagOkayToKillHades" ) )
    {
        maps\_hms_utility::printlnscreenandconsole( "Tried to autosave but player killed Hades too early" );
        return 0;
    }

    if ( common_scripts\utility::flag( "FlagPlayerShotConfRoomWindows" ) && !common_scripts\utility::flag( "FlagOkayToKillHades" ) )
    {
        maps\_hms_utility::printlnscreenandconsole( "Tried to autosave but FlagPlayerShotConfRoomWindows is set to TRUE!!!" );
        return 0;
    }

    if ( common_scripts\utility::flag( "FlagDisableAutosave" ) )
    {
        maps\_hms_utility::printlnscreenandconsole( "Tried to autosave but FlagDisableAutosave is set to TRUE!!!" );
        return 0;
    }

    if ( common_scripts\utility::flag( "FlagParkingCarAlarmDisableAutosave" ) )
    {
        maps\_hms_utility::printlnscreenandconsole( "Tried to autosave but FlagParkingCarAlarmDisableAutosave is set to TRUE!!!" );
        return 0;
    }

    if ( common_scripts\utility::flag( "FlagAlarmMissionEnd" ) )
    {
        maps\_hms_utility::printlnscreenandconsole( "Tried to autosave but FlagAlarmMissionEnd is set to TRUE!!!" );
        return 0;
    }

    return 1;
}

autosaveconfcentercombatcheck()
{
    if ( common_scripts\utility::flag( "FlagConfCenterAlliesVulnerable" ) )
        return 0;

    return 1;
}

monitorconfroomwindows()
{
    level endon( "end_sniper_drone" );
    level endon( "alarm_mission_end" );
    var_0 = getent( "ConfRoomWindows", "targetname" );

    for (;;)
    {
        var_1 = var_0 common_scripts\utility::waittill_any_return( "damage", "bullethit" );
        common_scripts\utility::flag_set( "FlagPlayerShotConfRoomWindows" );
        waitframe();

        if ( !common_scripts\utility::flag( "FlagConfHadesDead" ) )
        {
            common_scripts\utility::flag_set( "FlagAlarmMissionEnd" );
            destroyatriumfighttimer();
            level notify( "alarm_mission_end" );
        }

        waitframe();
    }
}

confcentervehiclesvulnerable()
{
    var_0 = getentarray( "ParkingAlarmCar", "targetname" );
    var_1 = getentarray( "ConfCenterCombatCar", "targetname" );
    var_0 = maps\_utility::array_merge( var_0, var_1 );

    foreach ( var_3 in var_0 )
    {
        if ( isdefined( var_3.script_mp_style_helicopter ) )
        {
            var_3.script_mp_style_helicopter = 0;
            var_3 maps\_vehicle::vehicle_set_health( 900 );
            var_3 thread vehicleexplodeondeath();
        }
    }
}

vehicleexplodeondeath()
{
    level endon( "end_sniper_drone" );
    level endon( "alarm_mission_end" );
    self waittill( "death" );
    radiusdamage( self.origin, 400, 400, 10 );
    physicsexplosionsphere( self.origin, 300, 100, 1.5 );
}

monitorplayeractivity()
{
    level endon( "end_sniper_drone" );
    level endon( "alarm_mission_end" );
    level endon( "HadesVehicleDriveStart" );
    wait 5.0;
    resetvulnerabletimers();
    var_0 = 0;

    for (;;)
    {
        waitframe();
        var_1 = maps\_utility::array_removedead_or_dying( level.allenemyambushers );
        var_2 = gettime();

        if ( var_1.size < 3 )
        {
            resetvulnerabletimers();
            continue;
        }

        if ( var_0 == 0 && level.allieswarningtime <= var_2 )
        {
            if ( !common_scripts\utility::flag( "FlagSomeAmbushSouthGuardsDead" ) )
            {
                maps\_hms_utility::printlnscreenandconsole( "*** WARNING *** - Player has been idle for too long" );
                thread maps\_utility::display_hint_timeout_mintime( "support_allies", 5.0, 3.0 );
            }

            var_0 = 1;
        }

        if ( level.alliesvulnerabletime <= var_2 )
        {
            common_scripts\utility::flag_set( "FlagConfCenterAlliesVulnerable" );

            foreach ( var_4 in level.allyinfiltrators )
            {
                if ( isdefined( var_4.magic_bullet_shield ) && var_4.magic_bullet_shield == 1 )
                    var_4 thread maps\_utility::stop_magic_bullet_shield();

                var_5 = level.player maps\_utility::get_player_gameskill();

                if ( var_5 >= 3 )
                    var_4.health = 1;

                var_4 thread monitorallydeath();
            }

            maps\_hms_utility::printlnscreenandconsole( "*** ALLIES ARE NOW VULNERABLE ***" );
            break;
        }
    }
}

getallyassisttime()
{
    var_0 = level.player maps\_utility::get_player_gameskill();
    var_1[0] = 30.0;
    var_1[1] = 20.0;
    var_1[2] = 15.0;
    var_1[3] = 10.0;
    return var_1[var_0];
}

resetvulnerabletimers()
{
    var_0 = getallyassisttime();
    maps\_hms_utility::printlnscreenandconsole( "Ally assist time = " + var_0 );
    var_1 = gettime();
    level.alliesvulnerabletime = var_1 + var_0 * 1000;
    var_2 = var_0 * 0.5;
    maps\_hms_utility::printlnscreenandconsole( "Ally warning time = " + var_2 );
    level.allieswarningtime = var_1 + var_2 * 1000;
}

notifyonplayerkill()
{
    level endon( "end_sniper_drone" );
    level endon( "alarm_mission_end" );
    level endon( "HadesVehicleDriveStart" );
    self waittill( "death", var_0, var_1, var_2 );

    if ( isdefined( var_2 ) && var_2 == "hms_sniperdrone" )
        resetvulnerabletimers();
    else if ( isdefined( var_1 ) && var_1 == "MOD_EXPLOSIVE" )
        resetvulnerabletimers();
}

monitorallydeath()
{
    level endon( "end_sniper_drone" );
    level endon( "alarm_mission_end" );
    level endon( "HadesVehicleDriveStart" );
    self waittill( "death" );
    maps\_hms_utility::printlnscreenandconsole( self.script_noteworthy + " has DIED!!!" );
    thread killallallies();

    if ( self.script_noteworthy == "InfiltratorBurke" )
        thread failallydeath();
}

killallallies()
{
    level notify( "AlliesWillAllDie" );
    wait(randomfloatrange( 1.0, 3.0 ));
    var_0 = maps\_utility::array_removedead_or_dying( level.allyinfiltrators );

    foreach ( var_2 in var_0 )
    {
        if ( var_2.script_noteworthy == "InfiltratorBurke" )
            thread failallydeath();

        var_2 kill();
    }
}

failallydeath()
{
    common_scripts\utility::flag_set( "FlagDisableAutosave" );
    level notify( "alarm_mission_end" );
    wait 0.05;
    maps\_hms_utility::printlnscreenandconsole( "MISSION FAIL - PLAYER DID NOT PROTECT ALLIES!!!" );
    maps\greece_conf_center_vo::confcenterfailburkekilleddialogue( 0 );
    wait 1;
    setdvar( "ui_deadquote", &"GREECE_DRONE_BURKEKILLED_FAIL" );
    maps\_utility::missionfailedwrapper();
}

hintsupportalliesoff()
{
    return common_scripts\utility::flag( "FlagHadesVehicleDriveStart" );
}

markallies( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    if ( var_0 == 1 )
        level waittill( "outline_allies" );

    level.bmarkallies = 1;

    foreach ( var_2 in level.allyinfiltrators )
    {
        var_2 thread markdronetargetally();
        var_2 hudoutlineenable( 2 );
    }
}

unmarkallies()
{
    level.bmarkallies = 0;

    foreach ( var_1 in level.allyinfiltrators )
        var_1 unmarkandremoveoutline( 0.0 );
}

markdronetargetally()
{
    self endon( "death" );
    self endon( "dying" );
    thread unmarkdronetarget();

    while ( !common_scripts\utility::flag( "FlagSniperDroneHit" ) )
    {
        if ( level.bmarkallies == 1 )
            maps\greece_code::settargetandshader( self, "hud_icon_remoteturret", "ac130_hud_friendly_ai_offscreen" );

        wait 0.1;
    }
}

markalliesenemytarget()
{

}

markallytargets( var_0 )
{
    var_1 = [];
    var_2 = [];
    var_2 = getaiarray( "axis" );
    var_3 = var_0 + "AllyTarget";

    foreach ( var_5 in var_2 )
    {
        if ( isalive( var_5 ) && isdefined( var_5.script_noteworthy ) )
        {
            if ( common_scripts\utility::string_starts_with( var_5.script_noteworthy, var_3 ) )
                var_1 = common_scripts\utility::add_to_array( var_1, var_5 );
        }
    }

    foreach ( var_8 in var_1 )
    {
        if ( isalive( var_8 ) )
            var_8 thread markalliesenemytarget();
    }
}

markdronetargetenemy()
{
    maps\greece_code::settargetandshader( self, "hud_icon_remoteturret", "veh_hud_target_offscreen" );
    thread unmarkdronetarget();
}

markdronetargetvehicle()
{
    maps\greece_code::settargetandshader( self, "hud_icon_remoteturret", "veh_hud_missile_offscreen" );
    thread unmarkdronetarget();
}

unmarkdronetarget()
{
    self endon( "death" );
    self endon( "dying" );
    common_scripts\utility::flag_wait( "FlagSniperDroneHit" );

    if ( target_istarget( self ) )
        target_remove( self );
}

unmarkandremoveoutline( var_0 )
{
    if ( isdefined( self ) )
    {
        if ( isdefined( var_0 ) )
            wait(var_0);

        self hudoutlinedisable();

        if ( target_istarget( self ) )
            target_remove( self );
    }
}

rumbleatriumbreach()
{
    level.player playrumbleonentity( "damage_light" );
    earthquake( 0.1, 0.2, level.player.origin, 100 );
}

rumblesniperdronenearexplosion()
{
    level.player playrumbleonentity( "damage_heavy" );
    earthquake( 0.3, 1.5, level.player.origin, 100 );
}

rumbleplayerdistantexplosion()
{
    level.player playrumbleonentity( "subtle_tank_rumble" );
    earthquake( 0.2, 0.5, level.player.origin, 100 );
}

setupgaragedoor()
{
    var_0 = common_scripts\utility::getstruct( "HadesGarageDoor", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "rolling_door", ( 0, 0, 0 ) );
    var_0 maps\_anim::anim_first_frame_solo( var_1, "intro_weapon_cache_rollingdoor" );
    common_scripts\utility::flag_wait( "FlagHadesVehicleDriveStart" );
    var_0 maps\_anim::anim_single_solo( var_1, "intro_weapon_cache_rollingdoor" );
}

guytruckbloodnotetrack( var_0 )
{
    common_scripts\utility::flag_set( "FlagShowTruckBlood" );
}

truckblood()
{
    var_0 = getent( "TruckBlood", "targetname" );
    var_0 hide();
    common_scripts\utility::flag_wait( "FlagShowTruckBlood" );
    var_0 show();
    common_scripts\utility::flag_wait( "FlagPlayerEndDroneControl" );
    var_0 delete();
}

getclosestflat( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 500000;

    if ( !isdefined( var_3 ) )
        var_3 = 200;

    var_4 = undefined;

    foreach ( var_6 in var_1 )
    {
        var_7 = var_0[2] - var_6.origin[2];

        if ( var_7 >= var_3 * -1 && var_7 <= var_3 )
        {
            var_8 = distance( var_6.origin, var_0 );

            if ( var_8 <= var_2 )
            {
                var_4 = var_6;
                var_2 = var_8;
            }
        }
    }

    if ( isdefined( var_4 ) )
        return var_4;
    else
    {
        var_10 = sortbydistance( var_1, var_0 );
        return var_1[0];
    }
}

get_closest_ai_flat( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( var_1 ) )
        var_5 = getaiarray( var_1 );
    else
        var_5 = getaiarray();

    if ( var_5.size == 0 )
        return undefined;

    if ( isdefined( var_2 ) )
        var_5 = common_scripts\utility::array_remove_array( var_5, var_2 );

    return getclosestflat( var_0, var_5, var_3, var_4 );
}

disableenemyalert()
{
    self notify( "disableAlert" );
    self.disable_alert = 1;

    if ( maps\_utility::is_in_array( level.alertedenemies, self ) )
        level.alertedenemies common_scripts\utility::array_remove( level.alertedenemies, self );
}

monitorplayersignalatriumbreach()
{
    thread maps\_utility::hintdisplayhandler( "mute_breach" );
    thread waittillplayersignalatriumbreach();
}

hintmutebreachoff()
{
    if ( common_scripts\utility::flag( "FlagPlayerSignalAtriumBreach" ) || common_scripts\utility::flag( "FlagPlayerShootFirstAtrium" ) || common_scripts\utility::flag( "FlagAlarmMissionEnd" ) || common_scripts\utility::flag( "FlagParkingCarAlarmActivated" ) )
        return 1;

    return 0;
}

waittillplayersignalatriumbreach()
{
    level endon( "SniperdroneAtriumPlayerFirstShot" );
    level endon( "alarm_mission_end" );

    for (;;)
    {
        if ( level.player usebuttonpressed() )
        {
            soundscripts\_snd::snd_message( "atrium_breach_signal_start" );
            common_scripts\utility::flag_set( "FlagPlayerSignalAtriumBreach" );
            break;
        }

        waitframe();
    }
}

burkecourtyardboostjump()
{
    var_0 = common_scripts\utility::getstruct( "BurkeCourtyardBoostJumpOrg", "targetname" );
    var_1 = "courtyard_boostjump";
    var_2 = maps\_utility::get_living_ai( "InfiltratorBurke", "script_noteworthy" );
    var_0 maps\_anim::anim_reach_solo( var_2, var_1 );
    var_0 maps\_anim::anim_single_solo_run( var_2, var_1 );
    common_scripts\utility::flag_set( "FlagCourtyardBurkeJumpCompleted" );

    if ( !common_scripts\utility::flag( "FlagStruggleBurkeApproaches" ) )
        thread allyredirectnoteworthy( "InfiltratorBurke", "Walkway" );
}

tff_spawn_vehicles_conf_center()
{
    if ( !istransientloaded( "greece_confcenter_tr" ) )
        level waittill( "tff_post_intro_to_confcenter" );

    var_0 = getentarray( "ParkingAlarmCar", "targetname" );
    var_1 = getentarray( "ConfCenterCombatCar", "targetname" );
    level.sniper_marked_cars = [];

    foreach ( var_3 in var_0 )
    {
        var_4 = var_3 maps\_utility::spawn_vehicle();
        level.sniper_marked_cars[level.sniper_marked_cars.size] = var_4;
        var_4 thread maps\greece_code::tff_cleanup_vehicle( "confcenter" );
    }

    foreach ( var_3 in var_1 )
    {
        var_4 = var_3 maps\_utility::spawn_vehicle();
        var_4 thread maps\greece_code::tff_cleanup_vehicle( "confcenter" );
    }

    common_scripts\utility::flag_wait( "FlagUnMarkParkingCars" );

    foreach ( var_4 in level.sniper_marked_cars )
        var_4 hudoutlinedisable();
}

hinthadeszoomoff()
{
    if ( common_scripts\utility::flag( "FlagPlayerZoomOnHades2" ) || common_scripts\utility::flag( "FlagAlarmMissionEnd" ) )
        return 1;

    return 0;
}

hintcaralarmoff()
{
    if ( common_scripts\utility::flag( "FlagUnMarkParkingCars" ) || common_scripts\utility::flag( "FlagAlarmMissionEnd" ) )
        return 1;

    return 0;
}

hintatriumviewoff()
{
    if ( common_scripts\utility::flag( "FlagUnMarkAtrium" ) || common_scripts\utility::flag( "FlagAlarmMissionEnd" ) )
        return 1;

    return 0;
}

hintcourtyardoverwatchoff()
{
    if ( common_scripts\utility::flag( "FlagCourtyardAnyOverwatchDead" ) || common_scripts\utility::flag( "FlagAlarmMissionEnd" ) )
        return 1;

    return 0;
}

monitorsniperdronetriplekill()
{
    level endon( "alarm_mission_end" );
    level endon( "end_sniper_drone" );
    common_scripts\utility::waittill_any( "death", "scripted_death" );
    level.triplekillcount++;

    if ( level.triplekillcount == 1 )
        thread achievementsniperdronetriplekill();
}

achievementsniperdronetriplekill()
{
    level endon( "alarm_mission_end" );
    level endon( "end_sniper_drone" );
    wait 0.2;

    if ( level.triplekillcount >= 3 )
    {
        common_scripts\utility::flag_set( "FlagGreeceTripleKillAchievement" );
        maps\_utility::giveachievement_wrapper( "LEVEL_6A" );
    }

    level.triplekillcount = 0;
}
