// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    safehouseprecache();
    safehouseflaginit();
    safehouseglobalvars();
    safehouseglobalsetup();
    setdvar( "debug_character_count", "on" );
    thread openingsplashscreen();
    maps\greece_safehouse_anim::main();
    maps\greece_safehouse_vo::main();
    maps\greece_safehouse_fx::main();
    maps\_hms_door_interact::precachedooranimations();
    maps\_drone_civilian::init();
    safehousedoorinit();
    thread safehousetvdestructible();
}

openingsplashscreen()
{
    var_0 = level.start_point;

    if ( var_0 == "start_safehouse_intro" || var_0 == "default" )
    {
        level.player disableweapons();
        level.player freezecontrols( 1 );
        thread maps\_shg_utility::play_chyron_video( "chyron_text_greece", 1, 2 );
        common_scripts\utility::flag_wait( "chyron_video_done" );
        level.player enableweapons();
        level.player freezecontrols( 0 );
        common_scripts\utility::flag_set( "FlagSafeHouseIntro" );
        common_scripts\utility::flag_set( "introscreen_complete" );
        common_scripts\utility::flag_set( "FlagIntroScreenComplete" );
    }
}

safehouseprecache()
{
    // precacheshellshock( "iw5_hmr9_sp" );
    // precacheshellshock( "iw5_hmr9_sp_variablereddot" );
    // precacheshellshock( "iw5_bal27_sp" );
    // precacheshellshock( "iw5_bal27_sp_silencer01_variablereddot" );
    // precacheshellshock( "iw5_sn6_sp" );
    // precacheshellshock( "iw5_sn6_sp_silencer01" );
    // precacheshellshock( "fraggrenade" );
    // precacheshellshock( "flash_grenade" );
    // precacheshellshock( "paint_grenade_var" );
    // precacheshellshock( "iw5_titan45_sp" );
    // precacheshellshock( "iw5_titan45_sp_opticsreddot_silencerpistol" );
    // precacheshellshock( "iw5_kf5_sp" );
    // precacheshellshock( "iw5_kf5_sp_silencer01" );
    // precacheshellshock( "hms_security_camera" );
    precacherumble( "silencer_fire" );
    precacherumble( "tank_rumble" );
    precacherumble( "steady_rumble" );
    precacherumble( "grenade_rumble" );
    precachemodel( "viewhands_atlas_military" );
    precachemodel( "vb_civilian_mitchell" );
    precachemodel( "vm_civilian_mitchell" );
    precachemodel( "kva_civilian_a_head" );
    precachemodel( "kva_civilian_b_head" );
    precachemodel( "kva_civilian_c_head" );
    precachemodel( "kva_civilian_d" );
    precachemodel( "civ_urban_male_waiter_body" );
    precachemodel( "kva_civilian_d_keyman" );
    precachemodel( "head_m_gen_cau_clark" );
    precachemodel( "kva_civilian_a_ambusher" );
    precachemodel( "head_civ_sf_male_a" );
    precachemodel( "head_civ_sf_male_b" );
    precachemodel( "head_civ_sf_male_c" );
    precachemodel( "head_civ_sf_male_d" );
    precachemodel( "head_london_male_b_drone" );
    precachemodel( "head_m_gen_mde_smith" );
    precachemodel( "head_m_gen_cau_young" );
    precachemodel( "head_m_gen_asi_pease" );
    precachemodel( "head_m_act_cau_kanik_base" );
    precachemodel( "head_m_act_afr_adams_base" );
    precachemodel( "head_hero_ilana_blend" );
    precachemodel( "head_f_gen_cau_coyle" );
    precachemodel( "head_m_gen_afr_davis" );
    precachemodel( "head_m_act_afr_adams_base" );
    precachemodel( "head_f_gen_afr_rice" );
    precachemodel( "weapon_parabolic_knife" );
    precachemodel( "viewbody_atlas_military" );
    precachemodel( "body_ilana_civilian_backpack" );
    precachemodel( "cafe_chair_02_anim" );
    precachemodel( "greece_cafe_chair_03_anim" );
    precachemodel( "greece_cafe_gps_pad" );
    precachemodel( "backpack_drone_small" );
    precachemodel( "backpack_drone_large" );
    precachemodel( "backpack_drone_flat" );
    precachemodel( "greece_duffelbag_rigged" );
    precachemodel( "greece_duffelbag_rigged_empty" );
    precachemodel( "vehicle_sniper_drone" );
    precachemodel( "vehicle_sniper_drone_cloak" );
    precachemodel( "coffee_cup" );
    precachemodel( "lag_umbrella_01_b" );
    precachemodel( "npc_titan45_base_loot" );
    precachemodel( "npc_kf5_base_loot" );
    precachemodel( "body_complete_civilian_suit_male_1" );
    precachemodel( "greece_blimp_rigged" );
    precachemodel( "goose" );
    precachestring( &"GREECE_OBJ_SAFEHOUSE_FOLLOW" );
    precachestring( &"GREECE_OBJ_SAFEHOUSE_KILL" );
    precachestring( &"GREECE_OBJ_MARKET_FOLLOW" );
    precachestring( &"GREECE_OBJ_SAFEHOUSE_JUMP" );
    precachestring( &"GREECE_OBJ_SAFEHOUSE_SUITUP" );
    precachestring( &"GREECE_MARKET_TARGETESCAPE1_FAIL" );
    precachestring( &"GREECE_MARKET_TARGETESCAPE2_FAIL" );
    precachestring( &"GREECE_SAFEHOUSE_EXECUTE_PROMPT" );
    precachestring( &"GREECE_HINT_DRONE_ZOOM_KB" );
    precachestring( &"GREECE_SAFEHOUSE_SUIT_UP" );
    precachestring( &"GREECE_SAFEHOUSE_SUIT_UP_KB" );
    maps\_utility::add_control_based_hint_strings( "cafe_scan", &"GREECE_CAFE_SCAN_PROMPT", ::hintcamerascanoff, &"GREECE_CAFE_SCAN_PROMPT_KB" );
    maps\_utility::add_control_based_hint_strings( "sonic_ready", &"SONICAOE_READY", ::hintsafehouseexitsonicoff );
    maps\_utility::add_control_based_hint_strings( "camera_zoom", &"GREECE_HINT_DRONE_ZOOM", ::hintcamerazoomoff, &"GREECE_HINT_DRONE_ZOOM_KB" );
    maps\_hms_greece_civilian::precachecivilian();
    maps\_hms_door_interact::precachedooranimations();
    maps\greece_security_camera::precachesecuritycamera();
}

safehouseflaginit()
{
    common_scripts\utility::flag_init( "FlagIntroScreenComplete" );
    common_scripts\utility::flag_init( "FlagSetObjScanTarget" );
    common_scripts\utility::flag_init( "FlagSetObjFollowTarget" );
    common_scripts\utility::flag_init( "FlagChangeObjFollowTarget" );
    common_scripts\utility::flag_init( "FlagClearObjFollowTarget" );
    common_scripts\utility::flag_init( "FlagSetObjClearSafehouse" );
    common_scripts\utility::flag_init( "FlagSetObjComputerInteract" );
    common_scripts\utility::flag_init( "FlagSetObjSafehouseGapJump" );
    common_scripts\utility::flag_init( "FlagSafeHouseIntro" );
    common_scripts\utility::flag_init( "FlagSafeHouseFollowStart" );
    common_scripts\utility::flag_init( "FlagSafeHouseKillStart" );
    common_scripts\utility::flag_init( "FlagSafeHouseClearStart" );
    common_scripts\utility::flag_init( "FlagSafeHouseTransitionStart" );
    common_scripts\utility::flag_init( "FlagSafeHouseOutroStart" );
    common_scripts\utility::flag_init( "FlagFollowTargetMarked" );
    common_scripts\utility::flag_init( "FlagFollowTargetUnmarked" );
    common_scripts\utility::flag_init( "FlagFollowTargetTeleport" );
    common_scripts\utility::flag_init( "FlagSafehouseMeleeKillInitiated" );
    common_scripts\utility::flag_init( "FlagFollowTargetKilled" );
    common_scripts\utility::flag_init( "FlagSafehouseKeyCardCatch" );
    common_scripts\utility::flag_init( "FlagFollowTargetReachedFirstStop" );
    common_scripts\utility::flag_init( "FlagFollowTargetReachedSecondStop" );
    common_scripts\utility::flag_init( "FlagFollowTargetReachedFinalStop" );
    common_scripts\utility::flag_init( "FlagScanRemoveHint" );
    common_scripts\utility::flag_init( "FlagCatchKillCompleted" );
    common_scripts\utility::flag_init( "FlagFirstFloorSafehouseKVAkilled" );
    common_scripts\utility::flag_init( "FlagSecondFloorSafehouseKVAkilled" );
    common_scripts\utility::flag_init( "FlagPacingGuardAlerted" );
    common_scripts\utility::flag_init( "FlagSafehouseIlanaTransitionReachStarted" );
    common_scripts\utility::flag_init( "FlagSafehouseIlanaTransitionIdleStarted" );
    common_scripts\utility::flag_init( "FlagIlanaMidMarketStartMoving" );
    common_scripts\utility::flag_init( "FlagCameraScanUnlockVoHints" );
    common_scripts\utility::flag_init( "FlagSafeHouseCloseSafehouseGates" );
    common_scripts\utility::flag_init( "FlagPlayerUsedSafehouseComputer" );
    common_scripts\utility::flag_init( "FlagSafehouseVideoChatEnded" );
    common_scripts\utility::flag_init( "FlagSafehouseIlanaAtStairs" );
    common_scripts\utility::flag_init( "FlagMarketCoupleAtGoal" );
    common_scripts\utility::flag_init( "FlagStartMarketCouple" );
    common_scripts\utility::flag_init( "FlagSafehouseIlanaTeleportToBack" );
    common_scripts\utility::flag_init( "FlagIlanaMoveToBackDoor" );
    common_scripts\utility::flag_init( "FlagIlanaEnterSafehouse" );
    common_scripts\utility::flag_init( "FlagIlanaMoveToLaunchPos" );
    common_scripts\utility::flag_init( "FlagScanTargetEnable" );
    common_scripts\utility::flag_init( "FlagScanTargetBegin" );
    common_scripts\utility::flag_init( "FlagScanTargetComplete" );
    common_scripts\utility::flag_init( "FlagKillTargetComplete" );
    common_scripts\utility::flag_init( "FlagClearSafehouseComplete" );
    common_scripts\utility::flag_init( "FlagComputerInteractComplete" );
    common_scripts\utility::flag_init( "FlagWindowShootersBreakOut" );
    common_scripts\utility::flag_init( "FlagSafehouseExitKVADead" );
    common_scripts\utility::flag_init( "FlagSafehouseStairKVADead" );
    common_scripts\utility::flag_init( "FlagKickSafehouseExitGate" );
    common_scripts\utility::flag_init( "FlagEnableSafehouseGapJump" );
    common_scripts\utility::flag_init( "FlagPlayerJumping" );
    common_scripts\utility::flag_init( "FlagPlayerJumpWatcherStop" );
    common_scripts\utility::flag_init( "FlagSafehouseGapJumpStarted" );
    common_scripts\utility::flag_init( "FlagSafehouseGapJumpCompleted" );
    common_scripts\utility::flag_init( "FlagSafehousePlayerGapJumpCompleted" );
    common_scripts\utility::flag_init( "FlagSafehouseExitGateOpen" );
    common_scripts\utility::flag_init( "FlagTriggerExitPlayerComingDownStairs" );
    common_scripts\utility::flag_init( "FlagTriggerExitPlayerLeavingBuilding" );
    common_scripts\utility::flag_init( "FlagKVATargetInAlley" );
    common_scripts\utility::flag_init( "FlagDeleteSafehouseCivilians" );
    common_scripts\utility::flag_init( "FlagPacingGuardDamaged" );
    common_scripts\utility::flag_init( "FlagPacingNpcDeath" );
    common_scripts\utility::flag_init( "IlanaSafehouseDoorIdleStart" );
    common_scripts\utility::flag_init( "FlagSniperDroneLaunched" );
    common_scripts\utility::flag_init( "FlagIlanaSafehouseExitAtSecondFloorWait" );
    common_scripts\utility::flag_init( "FlagKVAsafehouseGuardDeath" );
    common_scripts\utility::flag_init( "FlagCafeCameraUnlockSwitching" );
    common_scripts\utility::flag_init( "FlagCameraScanUnlockZoom" );
    common_scripts\utility::flag_init( "FlagKVATargetWaitTimerExpired" );
    common_scripts\utility::flag_init( "FlagKVASafehousePatrollerDeath" );
    common_scripts\utility::flag_init( "FlagSafehouseThreatGrenadeDetonated" );
    common_scripts\utility::flag_init( "FlagSafehouseCourtyardTakedownComplete" );
    common_scripts\utility::flag_init( "FlagDeleteMarketFirstWalkers" );
    common_scripts\utility::flag_init( "FlagSonicAoEActivated" );
    common_scripts\utility::flag_init( "FlagFXPlayed" );
    common_scripts\utility::flag_init( "SonicIntroCheckActivated" );
    common_scripts\utility::flag_init( "FlagSafehouseHideHint" );
    common_scripts\utility::flag_init( "FlagMarketCameraSwitched" );
    common_scripts\utility::flag_init( "FlagSafehousePlanningGuardsAlerted" );
    common_scripts\utility::flag_init( "FlagPopulateMarket" );
    common_scripts\utility::flag_init( "FlagCafeVideologComplete" );
    common_scripts\utility::flag_init( "FlagStartCafeVideoLog" );
    common_scripts\utility::flag_init( "FlagSafehouseBackyardFail" );
    common_scripts\utility::flag_init( "FlagConfCenterVOStart" );
}

safehouseglobalvars()
{
    level.showdebugtoggle = 0;
    level.dialogtable = "sp/greece_dialog.csv";
    level.potentialscantargets = [];
    level.kvafollowtarget = undefined;
    level.kvasafehouseguardarray = [];
    level.bplayerscanon = 0;
    setsaveddvar( "r_hudoutlineenable", 1 );
    common_scripts\utility::create_dvar( "display_placeholderdialog", 0 );
}

safehouseglobalsetup()
{
    thread safehousebeginentrance();
    thread safehousebeginexit();
}

safehousestartpoints()
{
    maps\_utility::add_start( "start_safehouse_intro", ::initsafehouseintro );
    maps\_utility::add_start( "start_safehouse_follow", ::initsafehousefollow );
    maps\_utility::add_start( "start_safehouse_xslice", ::initsafehousekill );
    maps\_utility::add_start( "start_safehouse_clear", ::initsafehouseclear );
    maps\_utility::add_start( "start_safehouse_transition", ::initsafehousetransition );
    maps\greece_starts::add_greece_starts( "safehouse" );
}

safehousestartpointsfinal()
{
    maps\_utility::add_start( "start_safehouse_exit", ::initsafehouseoutro );
    maps\greece_starts::add_greece_starts( "safehouse_final" );
}

initsafehouseintro()
{
    maps\_utility::teleport_player( common_scripts\utility::getstruct( "PlayerStartSafehouseIntro", "targetname" ) );
    maps\_hms_utility::setupplayerinventory( "iw5_titan45_sp_opticsreddot_silencerpistol", undefined, undefined, undefined, "iw5_titan45_sp_opticsreddot_silencerpistol" );
    maps\_variable_grenade::give_player_variable_grenade();

    foreach ( var_1 in level.player getweaponslistoffhands() )
        level.player setweaponammostock( var_1, 0 );

    // level.player setviewmodel( "vm_civilian_mitchell" );
    common_scripts\utility::flag_wait( "FlagSafeHouseIntro" );
    soundscripts\_snd::snd_message( "start_safehouse_intro_checkpoint" );
    common_scripts\_exploder::exploder( 666 );
    thread animatedpalmtrees();
    maps\_hms_utility::spawnandinitnamedally( "Ilona", "IlanaStartSafehouseIntro", 1, 1, "IlanaSafehouse" );
    level.allies["Ilona"] maps\_utility::forceuseweapon( "iw5_titan45_sp_opticsreddot_silencerpistol", "primary" );
    level.allies["Ilona"] thread maps\greece_code::disableawareness();
    thread cafeilanaseat();
    safehousetoggleexitflagtriggers( 0 );
    level.player playerchangemode( "no_combat_slow" );
    level.player thread playerrubberbandmovespeedscale( level.allies["Ilona"], 0.2, 0.6, 50, 500 );
    thread safehousetranstoalleygatesetup();
    thread cafeinitvendorgate();
    thread maps\greece_code::blimp_animation( "blimpOrg", "market_intro_blimp" );
    thread cafegeeseflyinganimation();
    common_scripts\utility::flag_set( "FlagSafeHouseStart" );
    common_scripts\utility::flag_set( "init_safehouse_intro_lighting" );
}

initsafehousefollow()
{
    safehouseobjectivesetup();
    maps\_utility::teleport_player( common_scripts\utility::getstruct( "PlayerStartSafehouseFollow", "targetname" ) );
    maps\_hms_utility::setupplayerinventory( "iw5_titan45_sp_opticsreddot_silencerpistol", undefined, undefined, undefined, "iw5_titan45_sp_opticsreddot_silencerpistol" );
    maps\_variable_grenade::give_player_variable_grenade();

    foreach ( var_1 in level.player getweaponslistoffhands() )
        level.player setweaponammostock( var_1, 0 );

    // level.player setviewmodel( "vm_civilian_mitchell" );
    soundscripts\_snd::snd_message( "start_safehouse_follow_checkpoint" );
    thread cafecameraumbrella();
    thread cafeinitvendorgate();
    common_scripts\_exploder::exploder( 666 );
    thread animatedpalmtrees();
    thread maps\greece_code::blimp_animation( "blimpOrg", "market_intro_blimp" );
    maps\_hms_utility::spawnandinitnamedally( "Ilona", "IlanaStartSafehouseFollow", 1, 1, "IlanaSafehouse" );
    level.allies["Ilona"] maps\_utility::forceuseweapon( "iw5_titan45_sp_opticsreddot_silencerpistol", "primary" );
    level.allies["Ilona"] thread maps\greece_code::disableawareness();
    cafesetuptouristilana();
    thread cafeendcamerascan( undefined );
    thread cafemarketmoveilana( undefined, undefined );
    thread spawnkvafollowtarget();
    thread cafeinitvendorgate();
    safehousetoggleexitflagtriggers( 0 );
    level.player playerchangemode( "no_combat_slow" );
    level.player thread playerrubberbandmovespeedscale( level.allies["Ilona"], 0.2, 0.6, 50, 500 );
    thread safehousetranstoalleygatesetup();
    common_scripts\utility::flag_set( "FlagScanTargetComplete" );
    common_scripts\utility::flag_set( "FlagFollowTargetMarked" );
    common_scripts\utility::flag_set( "FlagSafeHouseStart" );
    common_scripts\utility::flag_set( "init_safehouse_follow_lighting" );
}

initsafehousekill()
{
    common_scripts\utility::flag_set( "init_safehouse_xslice" );
    safehouseobjectivesetup();
    maps\_utility::teleport_player( common_scripts\utility::getstruct( "PlayerStartSafehouseKill", "targetname" ) );
    maps\_hms_utility::setupplayerinventory( "iw5_titan45_sp_opticsreddot_silencerpistol", undefined, undefined, undefined, "iw5_titan45_sp_opticsreddot_silencerpistol" );
    maps\_variable_grenade::give_player_variable_grenade();

    foreach ( var_1 in level.player getweaponslistoffhands() )
        level.player setweaponammostock( var_1, 0 );

    // level.player setviewmodel( "vm_civilian_mitchell" );
    common_scripts\_exploder::exploder( 666 );
    thread animatedpalmtrees();
    thread maps\greece_code::blimp_animation( "blimpOrg", "market_intro_blimp" );
    soundscripts\_snd::snd_message( "start_safehouse_xslice_checkpoint" );
    maps\_hms_utility::spawnandinitnamedally( "Ilona", "IlanaStartSafehouseKill", 1, 1, "IlanaSafehouse" );
    level.allies["Ilona"] maps\_utility::forceuseweapon( "iw5_titan45_sp_opticsreddot_silencerpistol", "primary" );
    level.allies["Ilona"] thread maps\greece_code::disableawareness();
    safehousetoggleexitflagtriggers( 0 );
    thread safehouseexittogglegates( "open" );
    thread cafeinitvendorgate();
    spawncivilians();
    thread spawnkvafollowtarget();
    cafesetuptouristilana();
    thread safehouseilanaclearsafehouse();
    thread safehousedoorplayerblocker();
    level.player playerchangemode( "no_combat_fast" );
    level.player thread playerrubberbandmovespeedscale( level.kvafollowtarget, 0.2, 0.5, 200, 500 );
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );
    thread maps\greece_safehouse_vo::xslicestartdialogue();
    thread xslicefade();
    thread safehousetranstoalleygatesetup();
    common_scripts\utility::flag_set( "FlagSetObjClearSafehouse" );
    common_scripts\utility::flag_set( "FlagSafeHouseKillStart" );
    common_scripts\utility::flag_set( "FlagFollowTargetReachedFinalStop" );
}

initsafehouseclear()
{
    safehouseobjectivesetup();
    maps\_utility::teleport_player( common_scripts\utility::getstruct( "PlayerStartSafehouseClear", "targetname" ) );
    maps\_hms_utility::setupplayerinventory( "iw5_titan45_sp_opticsreddot_silencerpistol", undefined, undefined, undefined, "iw5_titan45_sp_opticsreddot_silencerpistol" );
    maps\_variable_grenade::give_player_variable_grenade();

    foreach ( var_1 in level.player getweaponslistoffhands() )
        level.player setweaponammostock( var_1, 0 );

    // level.player setviewmodel( "vm_civilian_mitchell" );
    common_scripts\_exploder::exploder( 666 );
    thread animatedpalmtrees();
    thread maps\greece_code::blimp_animation( "blimpOrg", "market_intro_blimp" );
    soundscripts\_snd::snd_message( "start_safehouse_clear_checkpoint" );
    maps\_hms_utility::spawnandinitnamedally( "Ilona", "IlanaStartSafehouseClear", 1, 1, "IlanaSafehouse" );
    level.allies["Ilona"] thread maps\greece_code::disableawareness();
    level.allies["Ilona"] thread cafesetupilanabackpack();
    level.allies["Ilona"] maps\_utility::forceuseweapon( "iw5_titan45_sp_opticsreddot_silencerpistol", "primary" );
    level.allies["Ilona"] maps\_utility::enable_cqbwalk();
    thread safehouseilanaopendooridle();
    safehousetoggleexitflagtriggers( 0 );
    level.player playerchangemode( "stealth_combat" );
    level.player thread playerrubberbandmovespeedscale( level.allies["Ilona"], 0.3, 1, 50, 300 );
    thread safehouseexittogglegates( "closed" );
    thread safehousebackyarddamagetriggers();
    thread safehousebackyarddamagetriggerstoggle();
    thread safehouseilanaclearsafehouse();
    thread safehousedoorplayerblocker();
    spawncivilians();
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );
    thread safehousetranstoalleygatesetup();
    common_scripts\utility::flag_set( "FlagSetObjClearSafehouse" );
    common_scripts\utility::flag_set( "FlagSafeHouseClearStart" );
    common_scripts\utility::flag_set( "init_safehouse_clear_start_lighting" );
}

initsafehousetransition()
{
    safehouseobjectivesetup();
    maps\_utility::teleport_player( common_scripts\utility::getstruct( "PlayerStartSafehouseTransition", "targetname" ) );
    maps\_hms_utility::setupplayerinventory( "iw5_titan45_sp_opticsreddot_silencerpistol", undefined, undefined, undefined, "iw5_titan45_sp_opticsreddot_silencerpistol" );
    maps\_variable_grenade::give_player_variable_grenade();

    foreach ( var_1 in level.player getweaponslistoffhands() )
        level.player setweaponammostock( var_1, 0 );

    // level.player setviewmodel( "vm_civilian_mitchell" );
    common_scripts\_exploder::exploder( 666 );
    thread animatedpalmtrees();
    thread maps\greece_code::blimp_animation( "blimpOrg", "market_intro_blimp" );
    maps\_hms_utility::spawnandinitnamedally( "Ilona", "IlanaStartSafehouseTransition", 1, 1, "IlanaSafehouse" );
    level.allies["Ilona"] maps\_utility::forceuseweapon( "iw5_titan45_sp_opticsreddot_silencerpistol", "primary" );
    level.allies["Ilona"] thread cafesetupilanabackpack();
    safehouseforceopensafehousedoor();
    safehousetoggleexitflagtriggers( 0 );
    thread safehouseexittogglegates( "closed" );
    thread safehouseremoveplayerblocker();
    thread safehouseilanabagdropwait();
    thread safehousebackyarddamagetriggers();
    thread safehousebackyarddamagetriggerstoggle();
    common_scripts\utility::trigger_off( "SafehousePlayerNearBackDoorTrig1", "targetname" );
    common_scripts\utility::trigger_off( "SafehousePlayerNearBackDoorTrig2", "targetname" );
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );
    thread safehousetranstoalleygatesetup();
    common_scripts\utility::flag_set( "FlagSetObjClearSafehouse" );
    common_scripts\utility::flag_set( "FlagSafeHouseTransitionStart" );
    common_scripts\utility::flag_set( "init_safehouse_transition_start_lighting" );
    common_scripts\utility::flag_set( "FlagPacingNpcDeath" );
    soundscripts\_snd::snd_message( "start_safehouse_transition_checkpoint" );
}

initsafehouseoutro()
{
    safehouseobjectivesetup();
    maps\_utility::teleport_player( common_scripts\utility::getstruct( "PlayerStartSafehouseOutro", "targetname" ) );
    maps\_hms_utility::setupplayerinventory( "iw5_titan45_sp_opticsreddot_silencerpistol", "iw5_hmr9_sp_variablereddot", "fraggrenade", "flash_grenade", "iw5_hmr9_sp_variablereddot" );
    maps\_variable_grenade::give_player_variable_grenade();
    maps\_hms_utility::spawnandinitnamedally( "Ilona", "IlanaStartSafehouseOutro", 1, 1, "IlanaSafehouseExoSuit" );
    common_scripts\_exploder::exploder( 666 );
    thread animatedpalmtrees();
    thread maps\greece_code::blimp_animation( "blimpOrg", "market_intro_blimp" );
    maps\greece_conf_center_fx::confcenterresidualsmoke();
    maps\greece_safehouse_fx::ambientcloudskill();
    thread safehouseexittogglegates( "closed" );
    thread safehouseremoveplayerblocker();
    safehouseforceopensafehousedoor();
    common_scripts\utility::trigger_off( "SafehousePlayerNearBackDoorTrig1", "targetname" );
    common_scripts\utility::trigger_off( "SafehousePlayerNearBackDoorTrig2", "targetname" );
    thread safehousetranstoalleygatesetup();
    thread safehouseexitdeadbodysetupcouchguard();
    thread safehouseexitdeadbodysetuppacingguard();
    maps\_hud_util::fade_out( 0.25, "white" );
    common_scripts\utility::flag_set( "FlagSafeHouseOutroStart" );
    maps\_utility::delete_exploder( 666 );
    common_scripts\utility::flag_set( "init_safehouse_outro_start_lighting" );
    soundscripts\_snd::snd_message( "start_safehouse_exit_checkpoint" );
}

safehouseobjectivesetup()
{
    waittillframeend;
    safehousesetcompletedobjflags();
    thread setobjmarketscan();
    thread setobjfollowtarget();
    thread setobjinfilsafehouse();
    thread setobjintercepthades();
}

safehousesetcompletedobjflags()
{
    var_0 = level.start_point;

    if ( !common_scripts\utility::string_starts_with( var_0, "start_safehouse_" ) )
        return;

    if ( var_0 == "start_safehouse_intro" )
        return;

    if ( var_0 == "start_safehouse_follow" )
        return;

    if ( var_0 == "start_safehouse_xslice" )
        return;

    if ( var_0 == "start_safehouse_clear" )
        return;

    if ( var_0 == "start_safehouse_transition" )
        return;

    if ( var_0 == "start_safehouse_outro" )
        return;
}

setobjmarketscan()
{
    common_scripts\utility::flag_wait( "FlagSetObjScanTarget" );
    objective_add( maps\_utility::obj( "ScanKeyman" ), "active", &"GREECE_OBJ_SAFEHOUSE_SCAN", ( 0, 0, 0 ) );
    objective_current( maps\_utility::obj( "ScanKeyman" ) );
    common_scripts\utility::flag_wait( "FlagScanTargetComplete" );
    maps\_utility::objective_complete( maps\_utility::obj( "ScanKeyman" ) );
}

setobjfollowtarget()
{
    common_scripts\utility::flag_wait( "FlagSetObjFollowTarget" );

    if ( isdefined( level.kvafollowtarget ) )
    {
        objective_add( maps\_utility::obj( "InfilSafehouse" ), "active", &"GREECE_OBJ_SAFEHOUSE_INFIL", ( 0, 0, 0 ) );
        objective_current( maps\_utility::obj( "InfilSafehouse" ) );
        objective_onentity( maps\_utility::obj( "InfilSafehouse" ), level.kvafollowtarget );
        objective_setpointertextoverride( maps\_utility::obj( "InfilSafehouse" ), &"GREECE_OBJ_SAFEHOUSE_FOLLOW" );
        common_scripts\utility::flag_wait( "FlagClearObjFollowTarget" );
        objective_position( maps\_utility::obj( "InfilSafehouse" ), ( 0, 0, 0 ) );
    }
}

setobjinfilsafehouse()
{
    common_scripts\utility::flag_wait( "FlagSetObjClearSafehouse" );
    objective_onentity( maps\_utility::obj( "InfilSafehouse" ), level.allies["Ilona"] );
    objective_setpointertextoverride( maps\_utility::obj( "InfilSafehouse" ), &"GREECE_OBJ_SAFEHOUSE_FOLLOW" );
    common_scripts\utility::flag_wait_either( "FlagPacingNpcDeath", "FlagTriggerPlayerOnInsideStairway" );
    objective_position( maps\_utility::obj( "InfilSafehouse" ), ( 0, 0, 0 ) );
    objective_setpointertextoverride( maps\_utility::obj( "InfilSafehouse" ), "" );
    common_scripts\utility::flag_wait( "FlagSetObjComputerInteract" );
    var_0 = getent( "ComputerInteractObj", "targetname" );
    objective_position( maps\_utility::obj( "InfilSafehouse" ), var_0.origin );
    objective_setpointertextoverride( maps\_utility::obj( "InfilSafehouse" ), &"GREECE_OBJ_SAFEHOUSE_SUITUP" );
    common_scripts\utility::flag_wait( "FlagComputerInteractComplete" );
    maps\_utility::objective_complete( maps\_utility::obj( "InfilSafehouse" ) );
}

setobjintercepthades()
{
    common_scripts\utility::flag_wait( "FlagSetObjSafehouseGapJump" );
    objective_add( maps\_utility::obj( "InterceptHades" ), "active", &"GREECE_OBJ_INTERCEPT_HADES", ( 0, 0, 0 ) );
    objective_onentity( maps\_utility::obj( "InterceptHades" ), level.allies["Ilona"] );
    objective_setpointertextoverride( maps\_utility::obj( "InterceptHades" ), &"GREECE_OBJ_SAFEHOUSE_FOLLOW" );
    objective_current( maps\_utility::obj( "InterceptHades" ) );
}

levelintroscreen()
{
    maps\_utility::intro_screen_create( &"GREECE_INTRO_LINE1", &"GREECE_INTRO_LINE2", &"GREECE_INTRO_LINE3" );
    maps\_utility::intro_screen_custom_func( maps\greece_code::manhuntintroscreen );
}

setupaiforanimsequence()
{
    self.goalradius = 8;
    self.ignoreall = 1;
    self.ignoreme = 1;
    self.battlechatter = 0;
}

safehousebeginentrance()
{
    common_scripts\utility::flag_wait( "FlagSafeHouseStart" );
    safehouseobjectivesetup();
    thread safehouseexittogglegates( "open" );
    thread cafesetupplayerseat();
    thread cafemarketplayerfollowtarget();
    thread safehousefollowplayernotifies();
    cafesetuptouristilana();
    thread safehousetranstoalleygatesetup();
    thread safehousedoorplayerblocker();
    spawncivilians();
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );
}

animatedpalmtrees()
{
    var_0 = getentarray( "palmtree", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_2.animname = "palm_tree";
        var_2 maps\_utility::assign_animtree();
        var_3 = "light_sway";
        var_4 = randomfloatrange( 0.5, 0.7 );
        var_2 setanimrestart( level.scr_anim[var_2.animname][var_3][0], 1, 0, var_4 );
    }
}

marketscancomplete()
{
    self waittill( "target_scanned" );
    common_scripts\utility::flag_set( "FlagFollowTargetMarked" );
}

spawnkvasafehouseguards()
{
    thread spawnsafehousepatroller();
    maps\_utility::array_spawn_function_targetname( "KVAsafehouseGuard", ::safehouseenemyinit, 0 );
    level.kvasafehouseguardarray = maps\_utility::array_spawn_targetname( "KVAsafehouseGuard" );

    foreach ( var_1 in level.kvasafehouseguardarray )
    {
        var_1.dropweapon = 0;

        if ( !isdefined( var_1.target ) )
            continue;

        var_1.allowdeath = 1;

        if ( var_1.target == "safehouse_pacing_npc" )
        {
            var_2 = common_scripts\utility::getstruct( var_1.target, "targetname" );
            var_1 forceteleport( var_2.origin, var_2.angles );
            var_1.animname = "generic";
            var_3 = var_2.targetname;
            var_4 = var_2.script_noteworthy;
            var_1 thread safehousepacingguard( var_2 );
            var_1 thread maps\greece_code::bloodsprayexitwoundtrace( undefined, undefined, undefined, 1 );
        }

        if ( var_1.script_noteworthy == "SafehouseSleepingGuard" )
        {
            var_1 thread safehousesleepingguard();
            var_1 thread sleepingguardcustombloodspray();
        }
    }

    thread safehouseplanningguards();
}

sleepingguardcustombloodspray()
{
    self endon( "delete" );
    self waittill( "damage", var_0, var_1, var_2, var_3 );

    if ( var_1 == level.allies["Ilona"] )
        var_4 = self geteye();
    else
        var_4 = var_3;

    playfx( common_scripts\utility::getfx( "blood_impact_splat_sm" ), var_4 );
}

spawnkvafollowtarget()
{
    maps\_utility::array_spawn_function_targetname( "KVAfollowTarget", ::marketenemyinit );
    maps\_utility::array_spawn_function_targetname( "KVAfollowTarget", ::marketscancomplete );
    level.kvafollowtarget = maps\_utility::spawn_targetname( "KVAfollowTarget" );
    level.kvafollowtarget thread initscanvariables();
    var_0 = [ "kva_civilian_d_keyman" ];
    var_1 = [ "head_m_gen_cau_young" ];
    level.kvafollowtarget character\gfl\randomizer_sf::main();
    // level.kvafollowtarget maps\greece_code::aioverridemodelrandom( var_0, var_1 );
    thread marketmovekvafollowtarget();
}

spawnsafehousepatroller()
{
    var_0 = getent( "KVAsafehousePatroller", "targetname" );
    var_1 = var_0 maps\_utility::spawn_ai( 1 );
    var_1.health = 1;
    var_1.dropweapon = 0;
    var_1.battlechatter = 0;
    var_1.animname = "Victim";
    var_1.script_parameters = "Victim";
    var_1.ragdoll_immediate = 1;
    var_1.diequietly = 1;
    var_1.fovcosine = cos( 45 );
    var_1.grenadeawareness = 0;
    var_1 thread safehousepatrolleralertwatch();
    common_scripts\utility::flag_wait( "FlagKVASafehousePatrollerDeath" );
    level notify( "SafehousePatrollerDead" );
}

safehousepatrolleralertwatch()
{
    level endon( "SafehousePatrollerDead" );
    maps\_stealth_utility::stealth_enemy_waittill_alert();
    wait 1.0;
    var_0 = getent( "SafehousePlanningOrg", "targetname" );
    var_0 notify( "fail_left" );
    var_0 notify( "fail_right" );
    thread maps\greece_safehouse_vo::safehousefailkvaalerted();
    wait 1;
    common_scripts\utility::flag_set( "FlagSafehouseHideHint" );
    maps\_hms_utility::printlnscreenandconsole( "MISSION FAIL - KVA ALERTED!!!" );
    setdvar( "ui_deadquote", &"GREECE_DRONE_ALERT_FAIL" );
    maps\_utility::missionfailedwrapper();
}

safehousesleepingguard()
{
    var_0 = common_scripts\utility::getstruct( "safehousekill", "targetname" );
    var_1 = "safehouse_sleeping_guard_idle";
    var_2 = "safehouse_sleeping_guard_kill";
    self.animname = "generic";
    maps\_utility::gun_remove();
    self.health = 100000;
    self.diequietly = 1;
    var_3 = getent( "safehouse_pillow", "targetname" );
    var_3.animname = "safehouse_pillow";
    var_3 maps\_utility::assign_animtree( "safehouse_pillow" );
    var_0 thread maps\_anim::anim_first_frame_solo( var_3, "safehouse_enter2" );
    var_0 thread maps\_anim::anim_loop_solo( self, var_1, "StopSleepLoop" );
    thread safehousesleepingguarddeath( var_0 );
}

safehousesleepingguarddeath( var_0 )
{
    self endon( "SafehouseSleepingGuardCancelDeath" );
    var_1 = "safehouse_sleeping_guard_death";
    self waittill( "damage", var_2, var_3 );

    if ( isdefined( var_3 ) && var_3 == level.player )
        maps\greece_code::giveplayerchallengekillpoint();

    common_scripts\utility::flag_set( "FlagSafehouseSleepingGuardKilled" );
    var_0 notify( "StopSleepLoop" );
    maps\_utility::anim_stopanimscripted();
    var_0 maps\_anim::anim_single_solo( self, var_1 );
    maps\greece_code::kill_no_react();
}

safehousesleepingguardanimcheck( var_0 )
{
    var_1 = level.allies["Ilona"];
    var_2 = getent( "safehouse_pillow", "targetname" );
    var_2.animname = "safehouse_pillow";
    var_2 maps\_utility::assign_animtree( "safehouse_pillow" );
    var_3 = maps\_utility::get_living_ai( "SafehouseSleepingGuard", "script_noteworthy" );

    if ( common_scripts\utility::flag( "FlagSafehouseSleepingGuardKilled" ) )
    {
        var_0 thread maps\_anim::anim_single_solo( var_2, "safehouse_sleeping_guard_kill_alt" );
        var_0 maps\_anim::anim_single_solo( var_1, "safehouse_sleeping_guard_kill_alt" );
        thread safehouseexitdeadbodysetupcouchguard( var_0, "safehouse_sleeping_guard_kill", var_2, 1 );
    }
    else
    {
        var_3 notify( "SafehouseSleepingGuardCancelDeath" );
        var_4 = [ var_3, var_1, var_2 ];
        var_0 notify( "StopSleepLoop" );
        var_3 maps\_utility::anim_stopanimscripted();
        var_0 maps\_anim::anim_single( var_4, "safehouse_sleeping_guard_kill" );
        thread safehouseexitdeadbodysetupcouchguard( var_0, "safehouse_sleeping_guard_kill", var_2, 0 );
        var_3 maps\greece_code::kill_no_react();
    }
}

safehouseexitdeadbodysetupcouchguard( var_0, var_1, var_2, var_3 )
{
    common_scripts\utility::flag_wait( "FlagSafeHouseOutroStart" );

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( !isdefined( var_0 ) )
        var_0 = common_scripts\utility::getstruct( "safehousekill", "targetname" );

    if ( !isdefined( var_1 ) )
        var_1 = "safehouse_sleeping_guard_kill";

    if ( !isdefined( var_2 ) )
    {
        var_2 = getent( "safehouse_pillow", "targetname" );
        var_2.animname = "safehouse_pillow";
        var_2 maps\_utility::assign_animtree( "safehouse_pillow" );
    }

    if ( var_3 == 1 )
        var_0 thread maps\_anim::anim_single_solo( var_2, var_1 + "_alt" );
    else if ( var_3 == 0 )
        var_0 thread maps\_anim::anim_single_solo( var_2, var_1 );

    var_4 = getent( "SafehouseSleepingGuard", "script_noteworthy" );
    var_4.count = 1;
    var_5 = var_4 maps\_utility::spawn_ai();
    var_5.animname = "generic";
    var_5 maps\_utility::gun_remove();
    var_5.dropweapon = 0;

    if ( var_3 == 1 )
        var_1 = "safehouse_sleeping_guard_death";

    var_0 maps\_anim::anim_single_solo( var_5, var_1 );
    var_5 maps\greece_code::kill_no_react();
}

safehousepacingguard( var_0 )
{
    var_1 = "safehouse_videochat_01";
    var_2 = "safehouse_videochat_idle";
    var_3 = "safehouse_videochat_alert";
    self.animname = "pacing_guard";
    self.script_parameters = "pacing_guard";
    maps\_utility::gun_remove();
    self.health = 100000;
    self.ragdoll_immediate = 1;
    thread safehousevideochatmovie();
    var_0 thread maps\_anim::anim_loop_solo( self, var_2, "PacingGuard" );
    level waittill( "SafehouseVideoChatConversationStarted" );
    var_0 notify( "PacingGuard" );
    thread safehousepacingguardalertmonitor( var_0 );
    thread safehousepacingguarddeath( var_0 );
    var_0 maps\_anim::anim_single_solo( self, var_1 );

    if ( isalive( self ) && !common_scripts\utility::flag( "FlagPacingGuardAlerted" ) && !common_scripts\utility::flag( "FlagPacingGuardDamaged" ) )
        var_0 thread maps\_anim::anim_loop_solo( self, var_2, "PacingGuard" );
}

safehousepacingguarddeath( var_0 )
{
    level endon( "SafehouseAbortVideoChat" );
    var_1 = "safehouse_videochat_death";
    self waittill( "damage", var_2, var_3 );

    if ( isdefined( var_3 ) && var_3 == level.player )
        maps\greece_code::giveplayerchallengekillpoint();

    self notify( "PacingGuardDamaged" );
    common_scripts\utility::flag_set( "FlagPacingGuardDamaged" );
    common_scripts\utility::flag_set( "FlagPacingNpcDeath" );
    common_scripts\utility::flag_set( "FlagClearSafehouseComplete" );
    thread safehouseexitdeadbodysetuppacingguard( var_0, var_1 );
    var_0 notify( "PacingGuard" );
    maps\_utility::anim_stopanimscripted();
    var_0 maps\_anim::anim_single_solo( self, var_1 );
    maps\greece_code::kill_no_react();
}

safehouseexitdeadbodysetuppacingguard( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = common_scripts\utility::getstruct( "safehouse_pacing_npc", "targetname" );

    if ( !isdefined( var_1 ) )
        var_1 = "safehouse_videochat_death";

    common_scripts\utility::flag_wait( "FlagSafeHouseOutroStart" );
    var_2 = getent( "PacingGuard", "script_noteworthy" );
    var_2.count = 1;
    var_3 = var_2 maps\_utility::spawn_ai();
    var_3.animname = "pacing_guard";
    var_3 maps\_utility::gun_remove();
    var_3.dropweapon = 0;
    var_0 maps\_anim::anim_single_solo( var_3, var_1 );
    var_3 maps\greece_code::kill_no_react();
}

safehousepacingguardalertmonitor( var_0 )
{
    self endon( "PacingGuardDamaged" );
    thread safehouseguardsightwatch( var_0, "PacingGuard" );
    thread safehouseguardalertwatch( var_0, "PacingGuard" );
    thread safehouseguardtriggerwatch( "TriggerSafehouseForceAlertPacingGuard", var_0, "PacingGuard", 0 );
    thread safehousepacingguardtriggerwatch( var_0 );
    thread safehousepacingguardconversationmonitor();
    maps\_utility::disable_surprise();
    self notify( "guy_alerted" );
    var_1 = "safehouse_videochat_alert";
    var_0 waittill( "PacingGuard" );

    if ( isalive( self ) )
    {
        common_scripts\utility::flag_set( "FlagPacingGuardAlerted" );
        level notify( "SafehouseAbortVideoChat" );
        maps\_utility::anim_stopanimscripted();
        self.allowdeath = 1;
        self.ignoreall = 0;
        self.health = 1;
        maps\_utility::disable_dontevershoot();
        maps\_utility::gun_recall();
        var_0 thread maps\_anim::anim_single_solo( self, var_1 );

        if ( common_scripts\utility::flag( "FlagSafehouseVideoChatEnded" ) )
        {
            self endon( "death" );
            thread maps\greece_safehouse_vo::safehousefailkvaalerted();
            wait 1;
            common_scripts\utility::flag_set( "FlagSafehouseHideHint" );
            maps\_hms_utility::printlnscreenandconsole( "MISSION FAIL - KVA ALERTED!!!" );
            setdvar( "ui_deadquote", &"GREECE_DRONE_ALERT_FAIL" );
            maps\_utility::missionfailedwrapper();
        }
    }
}

safehousepacingguardconversationmonitor()
{
    level endon( "HadesTalkReallyFinished" );
    common_scripts\utility::flag_wait_either( "FlagPacingNpcDeath", "FlagPacingGuardAlerted" );
    thread maps\greece_safehouse_vo::safehousefailkvaalerted();
    wait 1;
    common_scripts\utility::flag_set( "FlagSafehouseHideHint" );
    maps\_hms_utility::printlnscreenandconsole( "MISSION FAIL - KVA ALERTED!!!" );
    setdvar( "ui_deadquote", &"GREECE_DRONE_ALERT_FAIL" );
    maps\_utility::missionfailedwrapper();
}

safehousevideochatmovie()
{
    var_0 = getentarray( "SafehousePostCallScreen", "targetname" );
    level waittill( "SafehouseVideoChatConversationStarted" );
    thread videochatpostscreenhide( var_0, 1 );
    soundscripts\_snd::snd_message( "start_videochat_screen_turn_on" );
    setsaveddvar( "cg_cinematicfullscreen", "0" );
    cinematicingameloop( "manhunt_vidchat" );
    level common_scripts\utility::waittill_either( "HadesTalkFinished", "SafehouseAbortVideoChat" );
    soundscripts\_snd::snd_message( "start_videochat_screen_turn_off" );
    wait 1;
    stopcinematicingame();
    setsaveddvar( "cg_cinematicfullscreen", "1" );
    common_scripts\utility::flag_set( "FlagSafehouseVideoChatEnded" );
    wait 0.1;
    level notify( "HadesTalkReallyFinished" );
    thread videochatpostscreenhide( var_0, 0 );
    common_scripts\utility::flag_wait( "FlagPlayerUsedSafehouseComputer" );
    maps\_utility::array_delete( var_0 );
}

videochatpostscreenhide( var_0, var_1 )
{
    foreach ( var_3 in var_0 )
    {
        if ( var_1 == 1 )
        {
            var_3 hide();
            continue;
        }

        var_3 show();
    }
}

playerchangemode( var_0 )
{
    switch ( var_0 )
    {
        case "no_combat_slow":
            self disableweapons();
            self allowmelee( 0 );
            self allowcrouch( 0 );
            self allowprone( 0 );
            self allowsprint( 0 );
            self allowdodge( 0 );
            self allowjump( 0 );
            self allowstand( 1 );
            self setmovespeedscale( 0.3 );
            break;
        case "no_combat_fast":
            self disableweapons();
            self allowmelee( 0 );
            self allowcrouch( 0 );
            self allowprone( 0 );
            self allowsprint( 0 );
            self allowdodge( 0 );
            self allowjump( 0 );
            self allowstand( 1 );
            self setmovespeedscale( 0.5 );
            break;
        case "stealth_combat":
            self enableweapons();
            self allowmelee( 1 );
            maps\_utility::playerallowalternatemelee( 1 );
            self allowcrouch( 1 );
            self allowprone( 1 );
            self allowsprint( 0 );
            self allowdodge( 0 );
            self allowjump( 1 );
            self allowstand( 1 );
            self setmovespeedscale( 0.8 );

            if ( !isdefined( self._stealth ) )
                maps\_stealth_utility::stealth_default();

            break;
        case "full_combat":
            self enableweapons();
            self allowmelee( 1 );
            self allowcrouch( 1 );
            self allowprone( 1 );
            self allowsprint( 1 );
            self allowdodge( 1 );
            self allowjump( 1 );
            self allowstand( 1 );
            self setmovespeedscale( 1.0 );
            break;
    }
}

playerrubberbandmovespeedscale( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "CancelMoveSpeedScale" );

    for (;;)
    {
        if ( isdefined( var_0 ) )
            break;

        waitframe();
    }

    for (;;)
    {
        var_5 = distance( self.origin, var_0.origin );

        if ( var_5 >= var_4 )
            var_6 = var_2;
        else if ( var_5 <= var_3 )
            var_6 = var_1;
        else
        {
            var_7 = var_4 - var_3;
            var_8 = var_2 - var_1;
            var_9 = var_5 - var_3;
            var_10 = var_9 / var_7;
            var_11 = var_10 * var_8;
            var_6 = var_1 + var_11;
        }

        self setmovespeedscale( var_6 );
        wait 0.5;
    }
}

spawncivilians()
{
    thread spawnmalecivilians();
    thread spawnmalecivilianswithface();
    thread spawnfemalecivilians();
    thread cafewaiter();
    thread cafesittingreader();
    thread cafecivilianmeetandgreet();
    thread marketvendor();
    thread markethost();
    thread cafeteasipper();
    thread fountaincivilians();
    thread spawnposttakedowncivilians();
    thread spawnpotentialtargets();
}

spawnposttakedowncivilians()
{
    common_scripts\utility::flag_wait( "FlagDeleteSafehouseCivilians" );
    wait 1;

    if ( level.nextgen )
    {
        var_0 = getent( "civilian_male", "targetname" );
        var_1 = getent( "civilian_female", "targetname" );
        var_2 = common_scripts\utility::getstructarray( "male_standing_round2_nodes", "script_noteworthy" );
        var_3 = common_scripts\utility::getstructarray( "male_sitting_round2_nodes", "script_noteworthy" );
        var_4 = common_scripts\utility::getstructarray( "female_standing_round2_nodes", "script_noteworthy" );
        var_5 = common_scripts\utility::getstructarray( "female_sitting_round2_nodes", "script_noteworthy" );
        var_6 = maps\_utility::array_merge( var_2, var_3 );
        var_7 = maps\_utility::array_merge( var_4, var_5 );
        var_8 = maps\_hms_greece_civilian::populatedronecivilians( var_0, var_6 );
        var_9 = maps\_hms_greece_civilian::populatedronecivilians( var_1, var_7 );
        common_scripts\utility::flag_wait( "FlagPlayerStartDroneControl" );
        maps\_utility::array_delete( var_8 );
        maps\_utility::array_delete( var_9 );
    }
}

fountaincivilians()
{
    var_0 = common_scripts\utility::getstruct( "fountainOrg", "targetname" );
    var_1 = maps\_utility::spawn_targetname( "fountain_civ1", 1 );
    var_1 thread initscanvariables();
    var_1.animname = "civ1";
    var_2 = maps\_utility::spawn_targetname( "fountain_civ2", 1 );
    var_2.script_noteworthy = "PotentialTarget";
    var_2 thread initscanvariables();
    var_2.animname = "civ2";
    var_3 = [ var_1, var_2 ];
    var_0 thread maps\_anim::anim_loop( var_3, "market_fntn_civ_talk" );
    common_scripts\utility::flag_wait( "FlagDeleteSafehouseCivilians" );
    maps\_utility::array_delete( var_3 );
}

spawnmalecivilians()
{
    var_0 = getent( "civilian_male", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "male_standing_idle_nodes", "targetname" );
    var_2 = common_scripts\utility::getstructarray( "male_sitting_idle_nodes", "targetname" );
    var_3 = maps\_utility::array_merge( var_1, var_2 );
    var_4 = [];

    if ( level.nextgen )
        var_5 = 1.25;
    else
        var_5 = 4;

    for ( var_6 = 0; var_6 < var_3.size / var_5; var_6++ )
        var_4 = common_scripts\utility::add_to_array( var_4, var_3[var_6] );

    var_3 = common_scripts\utility::array_remove_array( var_3, var_4 );
    var_7 = maps\_hms_greece_civilian::populatedronecivilians( var_0, var_3 );
    common_scripts\utility::array_thread( var_7, ::initscanvariables );
    common_scripts\utility::flag_wait( "FlagPopulateMarket" );
    var_8 = maps\_hms_greece_civilian::populatedronecivilians( var_0, var_4 );
    common_scripts\utility::array_thread( var_8, ::initscanvariables );
    common_scripts\utility::flag_wait( "init_safehouse_follow_lighting" );
    maps\_utility::array_delete( var_8 );
    common_scripts\utility::flag_wait( "FlagDeleteSafehouseCivilians" );
    maps\_utility::array_delete( var_7 );
}

spawnmalecivilianswithface()
{
    var_0 = getent( "civilian_male_w_face", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "male_standing_idle_nodes_w_face", "targetname" );
    var_2 = common_scripts\utility::getstructarray( "male_sitting_idle_nodes_w_face", "targetname" );
    var_3 = maps\_utility::array_merge( var_1, var_2 );
    var_4 = maps\_hms_greece_civilian::populatedronecivilians( var_0, var_3 );
    common_scripts\utility::array_thread( var_4, ::initscanvariables );
    common_scripts\utility::flag_wait( "FlagDeleteSafehouseCivilians" );
    maps\_utility::array_delete( var_4 );
}

spawnfemalecivilians()
{
    var_0 = getent( "civilian_female", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "female_standing_idle_nodes", "targetname" );
    var_2 = common_scripts\utility::getstructarray( "female_sitting_idle_nodes", "targetname" );
    var_3 = maps\_utility::array_merge( var_1, var_2 );
    var_4 = [];

    for ( var_5 = 0; var_5 < var_3.size / 1.25; var_5++ )
        var_4 = common_scripts\utility::add_to_array( var_4, var_3[var_5] );

    var_3 = common_scripts\utility::array_remove_array( var_3, var_4 );
    var_6 = maps\_hms_greece_civilian::populatedronecivilians( var_0, var_3 );
    common_scripts\utility::array_thread( var_6, ::initscanvariables );
    var_7 = [ "civ_urban_female_body_b_yellow", "civ_urban_female_body_b_olive", "civ_urban_female_body_e_gold", "civ_urban_female_body_b_blue", "civ_urban_female_body_d" ];
    var_8 = [ "head_f_gen_cau_peterson", "head_f_act_cau_hamilton_base", "head_f_gen_cau_giovanni", "head_f_gen_cau_withers", "head_f_gen_cau_coyle" ];

    foreach ( var_10 in var_6 )
    {
        if ( isdefined( var_10.script_noteworthy ) && var_10.script_noteworthy == "casual" )
        {
            var_11 = common_scripts\utility::random( var_8 );
            var_12 = common_scripts\utility::random( var_7 );
            var_10 thread codescripts\character::setheadmodel( var_11 );
            var_10 setmodel( var_12 );
        }
    }

    common_scripts\utility::flag_wait( "FlagPopulateMarket" );
    var_14 = maps\_hms_greece_civilian::populatedronecivilians( var_0, var_4 );
    common_scripts\utility::array_thread( var_14, ::initscanvariables );
    common_scripts\utility::flag_wait( "init_safehouse_follow_lighting" );
    maps\_utility::array_delete( var_14 );
    common_scripts\utility::flag_wait( "FlagDeleteSafehouseCivilians" );
    maps\_utility::array_delete( var_6 );
}

spawnpotentialtargets()
{
    var_0 = getent( "civilian_male", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "potential_target_node", "targetname" );
    var_2 = [];

    foreach ( var_4 in var_1 )
    {
        var_5 = var_0 maps\_utility::dronespawn();
        var_5.animname = "generic";
        var_2 = common_scripts\utility::add_to_array( var_2, var_5 );
        var_0.count = 1;
        var_5.origin = var_4.origin;
        var_5.angles = var_4.angles;

        if ( isdefined( var_4.script_noteworthy ) )
            var_5.script_noteworthy = var_4.script_noteworthy;

        wait 0.05;
        var_5 thread initscanvariables();
        var_5 thread potentialtargetanimations( var_4 );
    }

    common_scripts\utility::flag_wait( "FlagDeleteSafehouseCivilians" );
    maps\_utility::array_delete( var_2 );
}

potentialtargetanimations( var_0 )
{
    var_1 = var_0.animation;
    maps\_anim::anim_loop_solo( self, var_1 );
}

spawntempcivilians( var_0 )
{
    var_1 = getent( "civilian_temp", "targetname" );
    var_2 = common_scripts\utility::getstructarray( "civ_temp_idle_nodes", "targetname" );
    var_3 = maps\_hms_greece_civilian::populatedronecivilians( var_1, var_2 );
    common_scripts\utility::flag_wait( var_0 );
    maps\_utility::array_delete( var_3 );
}

spawndecoycivilians()
{
    var_0 = common_scripts\utility::getstruct( "KVAtargetWalkOrg", "targetname" );

    for ( var_1 = 1; var_1 < 9; var_1++ )
    {
        var_2 = "MarketDecoy" + var_1;
        var_3 = getent( var_2, "targetname" );

        if ( isdefined( var_3 ) )
        {
            thread marketdecoywalk( var_2, var_0, var_3 );
            continue;
        }

        break;
    }
}

marketdecoywalk( var_0, var_1, var_2 )
{
    if ( var_0 == "MarketDecoy3" )
        level waittill( "MarketStartWalker03" );
    else if ( var_0 == "MarketDecoy7" )
        return;
    else if ( var_0 == "MarketDecoy8" )
        level waittill( "MarketStartWalker08" );

    var_3 = var_2 maps\_utility::spawn_ai( 1 );
    var_3 thread initscanvariables();
    var_3 maps\_utility::set_ignoreall( 1 );
    var_3.animname = var_0;
    thread maps\_hms_utility::debugprint3dcontinuous( var_0, var_3, "blue", 1.0, 600000, var_3, "death" );
    var_1 maps\_anim::anim_single_solo( var_3, "hms_greece_market_decoy_walker" );
    waitframe();

    switch ( var_0 )
    {
        case "MarketDecoy8":
        case "MarketDecoy6":
        case "MarketDecoy5":
        case "MarketDecoy4":
        case "MarketDecoy1":
            var_4 = getnodearray( "MarketDecoyWalkerDeleteNode", "targetname" );
            var_5 = common_scripts\utility::getclosest( var_3.origin, var_4 );
            var_3 maps\_utility::set_run_anim( "civilian_slow_walk_male" );
            var_3 maps\_utility::set_goal_node( var_5 );
            var_3 maps\_utility::set_goal_radius( 32 );
            var_3 waittill( "goal" );
            var_3 delete();
            break;
        case "MarketDecoy7":
        case "MarketDecoy3":
        case "MarketDecoy2":
            var_3.animname = "generic";
            var_3 thread maps\_anim::anim_loop_solo( var_3, "london_civ_idle" );
            common_scripts\utility::flag_wait( "FlagSafeHouseFollowStart" );
            var_3 delete();
            break;
    }
}

spawnwalkingcivilians( var_0, var_1 )
{
    var_2 = [];
    var_3 = getentarray( "WalkingCivilian", "targetname" );

    if ( var_1 == 1 )
    {
        var_4 = getentarray( "FirstWalkingCivilian", "targetname" );
        var_5 = maps\_utility::array_spawn( var_4, 1 );

        foreach ( var_7 in var_5 )
        {
            var_2 = common_scripts\utility::add_to_array( var_2, var_7 );
            var_7 thread initscanvariables();
            var_7 thread deletewalkingcivilians( var_0 );
        }

        var_3 = maps\_utility::array_merge( var_3, var_4 );
        wait 1;
    }

    while ( !common_scripts\utility::flag( var_0 ) )
    {
        var_9 = common_scripts\utility::random( var_3 );

        if ( isdefined( level.cameralinkpoint ) )
            var_10 = level.cameralinkpoint.origin;
        else
            var_10 = level.player geteye();

        var_11 = level.player getangles();

        if ( !common_scripts\utility::within_fov( var_10, var_11, var_9.origin, cos( 15 ) ) )
        {
            var_12 = var_9 maps\_utility::spawn_ai();

            if ( isdefined( var_12 ) )
            {
                var_9.count = 1;
                var_2 = common_scripts\utility::add_to_array( var_2, var_12 );
                var_12 thread initscanvariables();
                var_12 thread deletewalkingcivilians( var_0 );

                if ( !common_scripts\utility::flag( var_0 ) )
                    wait(randomfloatrange( 6, 10 ));
            }
        }

        waitframe();
    }

    var_2 = maps\_utility::array_removedead_or_dying( var_2 );
    maps\_utility::array_delete( var_2 );
}

deletewalkingcivilians( var_0 )
{
    waittill_notify_or_flag( var_0, "goal" );
    self delete();
}

waittill_notify_or_flag( var_0, var_1 )
{
    self endon( var_1 );
    common_scripts\utility::flag_wait( var_0 );
}

spawnaddwalkers()
{
    thread spawnaddwalker( "MarketAmbWalker1", "MarketStartAmbWalker01", "back", "front", 0.0 );
    thread spawnaddwalker( "MarketAmbWalker2", "MarketStartAmbWalker02", "left", "left", 0.0 );
    thread spawnaddwalker( "MarketAmbWalker3", "MarketStartAmbWalker03", "back", "right", 0.0 );
    thread spawnaddwalker( "MarketAmbWalker4", "MarketStartAmbWalker04", "left", "front", 0.1 );
    thread spawnaddwalker( "MarketAmbWalker5", "MarketStartAmbWalker05", "back", "front", 0.0 );

    if ( level.nextgen )
    {
        thread spawnaddwalker( "MarketAmbWalker7", "MarketStartAmbWalker07", "right", "front", 0.0 );
        thread spawnaddwalker( "MarketAmbWalker8", "MarketStartAmbWalker08", "back", "front", 0.0 );
        thread spawnaddwalker( "MarketAmbWalker9", "MarketStartAmbWalker09", "left", "right", 0.0 );
        thread spawnaddwalker( "MarketAmbWalker10", "MarketStartAmbWalker10", "back", "right", 0.0 );
        thread spawnaddwalker( "MarketAmbWalker11", "MarketStartAmbWalker11", "right", "right", 0.0 );
    }
}

spawnaddwalker( var_0, var_1, var_2, var_3, var_4 )
{
    level endon( "FlagDeltaSafehouseCivilians" );
    var_5 = getent( var_0, "targetname" );
    var_6 = var_0 + "_start";
    var_7 = common_scripts\utility::getstruct( var_6, "targetname" );
    var_8 = var_0 + "_end";
    var_9 = common_scripts\utility::getstruct( var_8, "targetname" );
    var_10 = var_5 maps\_utility::spawn_ai( 1 );
    var_10.animname = "generic";
    var_10 maps\_utility::set_ignoreall( 1 );
    var_10.walk_override_weights = [];
    var_10.walk_override_weights[0] = 1;
    var_10.run_override_weights = [];
    var_10.run_override_weights[0] = 1;
    var_10 maps\_utility::set_run_anim( "civilian_slow_walk_male", 1 );
    var_10 thread initscanvariables();
    var_10 thread waitforwalkerdelete();
    thread maps\_hms_utility::debugprint3dcontinuous( var_0, var_10, "green", 1.0, 600000, var_10, "anim_reach_complete" );
    var_7 thread maps\_anim::anim_loop_solo( var_10, "london_civ_idle" );
    level waittill( var_1 );
    wait(var_4);
    var_7 notify( "stop_loop" );
    var_10 maps\_utility::anim_stopanimscripted();
    var_11 = undefined;

    switch ( var_2 )
    {
        case "back":
            var_11 = "civ_idletrans_out_b";
            break;
        case "left":
            var_11 = "civ_idletrans_out_l";
            break;
        case "right":
            var_11 = "civ_idletrans_out_r";
            break;
    }

    var_7 maps\_anim::anim_single_solo_run( var_10, var_11 );
    var_12 = undefined;

    switch ( var_3 )
    {
        case "front":
            var_12 = "civ_idletrans_in_f";
            break;
        case "left":
            var_12 = "civ_idletrans_in_l";
            break;
        case "right":
            var_12 = "civ_idletrans_in_r";
            break;
    }

    if ( isalive( var_10 ) )
    {
        var_9 maps\_anim::anim_reach_solo( var_10, var_12 );
        var_9 maps\_anim::anim_single_solo( var_10, var_12 );
        var_9 thread maps\_anim::anim_loop_solo( var_10, "london_civ_idle" );
    }
}

waitforwalkerdelete()
{
    common_scripts\utility::flag_wait( "FlagDeleteSafehouseCivilians" );
    self delete();
}

initscanvariables()
{
    var_0 = 1000;
    var_1 = 2000;
    self.marked = 0;
    self.frequency = randomintrange( var_0, var_1 );
    self.potentialtarget = 0;

    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "PotentialTarget" )
    {
        self.potentialtarget = 1;
        level.potentialscantargets = common_scripts\utility::add_to_array( level.potentialscantargets, self );
    }
}

cafewaiter()
{
    var_0 = getent( "ilana_tea_cup", "targetname" );
    var_0.animname = "tea_cup";
    var_0 maps\_utility::assign_animtree( "tea_cup" );
    var_0 hide();
    common_scripts\utility::flag_wait( "FlagSafeHouseIntro" );
    var_1 = common_scripts\utility::getstruct( "CafeWaiterOrg", "targetname" );
    var_2 = maps\_utility::spawn_targetname( "IntroCafeWaiter", 1 );
    var_2 setmodel( "civ_urban_male_waiter_body" );
    var_2 thread codescripts\character::setheadmodel( "head_m_act_afr_adams_base" );
    var_2.animname = "waiter";
    var_0 show();
    var_1 thread maps\_anim::anim_single_solo( var_0, "hms_greece_market_intro" );

    if ( level.nextgen )
        playfxontag( common_scripts\utility::getfx( "steam_coffee" ), var_0, "jnt_cup" );

    var_1 maps\_anim::anim_single_solo( var_2, "hms_greece_market_intro" );
    var_2 delete();
}

markethost()
{
    common_scripts\utility::flag_wait( "FlagSafeHouseFollowStart" );
    var_0 = common_scripts\utility::getstruct( "CafeWaiterOrg", "targetname" );
    var_1 = maps\_utility::spawn_targetname( "marketHost", 1 );
    var_1 setmodel( "civ_urban_male_body_f" );
    var_1 thread codescripts\character::setheadmodel( "head_m_gen_mde_smith" );
    var_1.animname = "Host";
    wait 0.4;
    var_0 maps\_anim::anim_single_solo( var_1, "market_host_in" );
    var_0 thread maps\_anim::anim_loop_solo( var_1, "market_host_loop" );
    common_scripts\utility::flag_wait( "FlagDeleteSafehouseCivilians" );
    var_1 delete();
}

cafeteasipper()
{
    var_0 = getent( "tea_time_org", "targetname" );
    var_1 = maps\_utility::spawn_targetname( "TeaGuy", 1 );
    var_1 setmodel( "civ_urban_male_body_b" );
    var_1 thread codescripts\character::setheadmodel( "head_m_gen_cau_young" );
    var_1.animname = "TeaGuy";
    var_2 = getent( "tea_cup", "targetname" );
    var_2.animname = "tea_cup";
    var_2 maps\_utility::assign_animtree( "tea_cup" );
    var_3 = var_1 gettagorigin( "TAG_WEAPON_RIGHT" );
    var_4 = var_1 gettagangles( "TAG_WEAPON_RIGHT" );
    var_5 = ( 0, 0, 0 );
    var_2.origin = var_3;
    var_2.angles = var_4;
    var_2 linkto( var_1, "TAG_WEAPON_RIGHT" );
    var_6 = [ var_1, var_2 ];
    var_2 thread maps\_anim::anim_loop_solo( var_2, "cafe_tea_time" );
    var_0 thread maps\_anim::anim_loop_solo( var_1, "cafe_tea_time" );
    common_scripts\utility::flag_wait( "FlagDeleteSafehouseCivilians" );
    maps\_utility::array_delete( var_6 );
}

marketvendor()
{
    common_scripts\utility::flag_wait( "FlagSafeHouseFollowStart" );
    var_0 = common_scripts\utility::getstruct( "sweeperOrg", "targetname" );
    var_1 = maps\_utility::spawn_targetname( "MarketSweeper", 1 );
    var_1 setmodel( "civ_urban_female_body_b" );
    var_1 thread codescripts\character::setheadmodel( "head_f_gen_cau_coyle" );
    var_1.animname = "market_sweeper";
    var_2 = getent( "market_broom", "targetname" );
    var_2.animname = "broom";
    var_2 maps\_utility::assign_animtree( "broom" );
    var_3 = [ var_1, var_2 ];
    var_0 thread maps\_anim::anim_loop_solo( var_1, "market_vendor_sweep_loop" );
    var_0 thread maps\_anim::anim_loop_solo( var_2, "market_vendor_sweep_loop" );
    var_4 = common_scripts\utility::getstruct( "MarketVendorOrg", "targetname" );
    var_5 = maps\_utility::spawn_targetname( "MarketVendor", 1 );
    var_5.animname = "market_vendor";
    var_5 setmodel( "civ_african_male_body_d" );
    var_5 thread codescripts\character::setheadmodel( "head_m_act_afr_adams_base" );
    var_6 = maps\_utility::spawn_anim_model( "lemon01" );
    var_7 = maps\_utility::spawn_anim_model( "lemon02" );
    var_8 = maps\_utility::spawn_anim_model( "lemon03" );
    var_9 = maps\_utility::spawn_anim_model( "lemon04" );
    var_10 = maps\_utility::spawn_anim_model( "lemon05" );
    var_11 = [ var_6, var_7, var_8, var_9, var_10 ];
    var_4 thread maps\_anim::anim_loop_solo( var_5, "market_vendor_loop" );
    var_4 thread maps\_anim::anim_loop( var_11, "market_vendor_lemons_loop" );
    common_scripts\utility::flag_wait_either( "FlagTriggerPlayerAtCafeWindow", "FlagStartMarketCouple" );
    var_12 = maps\_utility::spawn_targetname( "MarketVendorMale", 1 );
    var_12.animname = "market_male";
    var_13 = maps\_utility::spawn_targetname( "MarketVendorFemale", 1 );
    var_13.animname = "market_female";
    var_14 = maps\_utility::spawn_anim_model( "lemon" );
    var_15 = [ var_12, var_13 ];
    var_4 maps\_anim::anim_single( var_15, "market_vendor_in" );
    var_4 thread maps\_anim::anim_loop( var_15, "market_shopper_loop" );
    var_4 thread maps\_anim::anim_loop_solo( var_14, "market_shopper_loop" );
    common_scripts\utility::flag_wait( "FlagDeleteSafehouseCivilians" );
    var_5 delete();
    var_12 delete();
    var_13 delete();
    maps\_utility::array_delete( var_11 );
    maps\_utility::array_delete( var_3 );
}

cafesittingreader()
{
    var_0 = common_scripts\utility::getstructarray( "CafeSittingReader", "targetname" );
    var_1 = getent( "civilian_male", "targetname" );

    foreach ( var_3 in var_0 )
    {
        var_4 = var_1 maps\_utility::dronespawn();
        var_1.count = 1;
        var_4.animname = "generic";
        var_4.origin = var_3.origin;
        var_4.angles = var_3.angles;
        var_4 attach( "greece_cafe_gps_pad", "tag_inhand", 1 );
        var_4 thread cafesittingreaderplaynextanim( "cafe_civ_sit_read_idle_01" );
        var_4 thread waitforreaderdelete();
    }
}

waitforreaderdelete()
{
    common_scripts\utility::flag_wait( "FlagDeleteSafehouseCivilians" );
    self delete();
}

cafesittingreaderchoosenextanim( var_0 )
{
    level endon( "FlagDeleteSafehouseCivilians" );

    switch ( var_0 )
    {
        case "cafe_civ_sit_read_idle_01":
            self waittill( "CurrentReadingAnimDone" );
            cafesittingreaderplaynextanim( "cafe_civ_sit_read_trans2crossed_01" );
            break;
        case "cafe_civ_sit_read_trans2crossed_01":
            self waittill( "CurrentReadingAnimDone" );
            cafesittingreaderplaynextanim( "cafe_civ_sit_read_idlecrossed_01" );
            break;
        case "cafe_civ_sit_read_idlecrossed_01":
            if ( common_scripts\utility::cointoss() )
            {
                self waittill( "CurrentReadingAnimDone" );
                cafesittingreaderplaynextanim( "cafe_civ_sit_read_trans2sit_01" );
            }
            else
            {
                self waittill( "CurrentReadingAnimDone" );
                cafesittingreaderplaynextanim( "cafe_civ_sit_read_trans2sit_long_01" );
            }

            break;
        case "cafe_civ_sit_read_trans2sit_01":
            self waittill( "CurrentReadingAnimDone" );
            cafesittingreaderplaynextanim( "cafe_civ_sit_read_idle_01" );
            break;
        case "cafe_civ_sit_read_trans2sit_long_01":
            if ( common_scripts\utility::cointoss() )
            {
                self waittill( "CurrentReadingAnimDone" );
                cafesittingreaderplaynextanim( "cafe_civ_sit_read_trans2crossed_01" );
            }
            else
            {
                self waittill( "CurrentReadingAnimDone" );
                cafesittingreaderplaynextanim( "cafe_civ_sit_read_idle_01" );
            }

            break;
    }
}

cafesittingreaderplaynextanim( var_0 )
{
    thread cafesittingreaderchoosenextanim( var_0 );
    maps\_anim::anim_single_solo( self, var_0 );
    self notify( "CurrentReadingAnimDone" );
}

cafecivilianmeetandgreet()
{
    var_0 = maps\_utility::spawn_targetname( "MaleGreet", 1 );
    var_0 setmodel( "civ_urban_male_body_c" );
    var_0 thread codescripts\character::setheadmodel( "head_m_gen_asi_pease" );
    var_0.animname = "greet_male";
    var_1 = maps\_utility::spawn_targetname( "FemaleGreet", 1 );
    var_1 setmodel( "civ_urban_female_body_b_blue_afr_light" );
    var_1 thread codescripts\character::setheadmodel( "head_f_gen_afr_rice" );
    var_1.animname = "greet_female";
    var_2 = getent( "Menu1", "targetname" );
    var_3 = getent( "Menu2", "targetname" );
    var_2 maps\_utility::assign_animtree( "market_menu1" );
    var_3 maps\_utility::assign_animtree( "market_menu2" );
    var_2.animname = "market_menu1";
    var_3.animname = "market_menu2";
    var_4 = [ var_0, var_2 ];
    var_5 = [ var_1, var_3 ];
    var_6 = "cafe_meet_02_trans_in_guy1";
    var_7 = "cafe_meet_02_trans_in_fem";
    var_8 = "cafe_meet_02_loop_guy1";
    var_9 = "cafe_meet_02_loop_fem";
    var_10 = getent( "CafeMeet02AnimOrg", "targetname" );
    var_10 thread maps\_anim::anim_first_frame_solo( var_2, "cafe_meet_02_trans_in_guy1" );
    var_10 thread maps\_anim::anim_loop( var_5, var_9, "Guy2StopLoopAndGreet" );
    var_0 hide();
    common_scripts\utility::flag_wait( "FlagSafeHouseFollowStart" );
    var_0 show();
    wait 6;
    var_10 maps\_anim::anim_reach_solo( var_0, var_6 );
    var_10 notify( "Guy2StopLoopAndGreet" );
    var_10 thread maps\_anim::anim_single( var_4, var_6 );
    var_10 maps\_anim::anim_single( var_5, var_7 );
    var_10 thread maps\_anim::anim_loop( var_4, var_8 );
    var_10 thread maps\_anim::anim_loop( var_5, var_9 );
    common_scripts\utility::flag_wait( "FlagDeleteSafehouseCivilians" );
    maps\_utility::array_delete( var_4 );
    maps\_utility::array_delete( var_5 );
}

cafesetupplayerseat()
{
    level endon( "lazy_mission_end" );
    common_scripts\utility::flag_wait( "FlagSafeHouseIntro" );
    thread cafeinitvendorgate();
    level.player lerpfov( 50, 0 );
    var_0 = common_scripts\utility::getstruct( "PlayerVBCafeStruct", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "player_cafe_rig", level.player.origin, level.player.angles );
    var_2 = maps\_utility::spawn_anim_model( "cafe_control_pad", var_0.origin );
    var_3 = maps\_utility::spawn_anim_model( "backpack_drone_large", var_0.origin );
    var_0 thread maps\_anim::anim_first_frame_solo( var_3, "hms_greece_market_intro" );
    var_0 thread maps\_anim::anim_single_solo( var_3, "hms_greece_market_intro" );
    var_4 = maps\_utility::spawn_anim_model( "player_chair", var_0.origin );
    var_0 thread maps\_anim::anim_single_solo( var_4, "hms_greece_market_intro" );
    level.player playerlinktoblend( var_1, "tag_player", 0.1 );
    thread cafeplayercameralook( var_1 );
    var_5 = [ var_1, var_2 ];
    var_0 maps\_anim::anim_single( var_5, "hms_greece_market_intro" );
    level notify( "MarketIntroExpandCamControl" );
    var_0 thread maps\_anim::anim_loop( var_5, "hms_greece_market_intro_loop", "PlayerCafeSittingEnder" );
    common_scripts\utility::flag_set( "FlagSetObjScanTarget" );
    common_scripts\utility::flag_set( "FlagScanTargetEnable" );
    thread maps\greece_safehouse_vo::scaninitremindermonitor();
    thread maps\_utility::hintdisplayhandler( "cafe_scan", undefined, undefined, undefined, undefined, 200 );

    for (;;)
    {
        if ( level.player usebuttonpressed() )
            break;

        waitframe();
    }

    level notify( "PlayerInitiateScan" );
    common_scripts\utility::flag_set( "FlagScanRemoveHint" );
    thread maps\_utility::autosave_by_name( "safehouse_market_scan_begin" );
    level.player playerlinktoblend( var_1, "tag_player", 1 );
    var_0 notify( "PlayerCafeSittingEnder" );
    var_1 maps\_utility::anim_stopanimscripted();
    var_0 thread maps\_anim::anim_single( var_5, "hms_greece_market_intro_activate" );
    wait 3.15;
    level.player disableslowaim();
    common_scripts\utility::flag_set( "FlagPopulateMarket" );
    maps\greece_security_camera::scanfadeintro();
    wait 1;
    common_scripts\utility::flag_set( "FlagScanTargetBegin" );
    thread cafecameraumbrella();
    thread spawnkvafollowtarget();
    thread spawnwalkingcivilians( "FlagDeleteMarketFirstWalkers", 1 );
    level.player thread maps\greece_security_camera::securitycameraenable();
    level.bplayerscanon = 1;
    soundscripts\_snd::snd_message( "mhunt_cafe_cam_enter_front" );
    thread cafecamerascancounter();
    thread marketkvafollowtargettimer();
    var_6 = common_scripts\utility::getstruct( "mitchellOrg", "targetname" );
    var_7 = maps\_utility::spawn_anim_model( "Mitchell", var_0.origin );
    var_7 maps\_utility::assign_animtree( "Mitchell" );
    var_7 setmodel( "civ_urban_male_body_b" );
    var_7 thread codescripts\character::setheadmodel( "head_civ_sf_male_c" );
    var_7.animname = "Mitchell";
    var_6 thread maps\_anim::anim_loop_solo( var_7, "Mitchell_scanning" );
    common_scripts\utility::flag_wait( "FlagScanTargetComplete" );
    var_7 delete();
    var_1 delete();
    var_2 delete();
    var_3 delete();
    thread cafeendcamerascan( var_4 );
}

hintcamerascanoff()
{
    return common_scripts\utility::flag( "FlagScanRemoveHint" );
}

hintcamerazoomoff()
{
    return common_scripts\utility::flag( "FlagFollowTargetMarked" );
}

cafeplayercameralook( var_0 )
{
    level waittill( "MarketIntroUnlockCamControl" );
    level.player playerlinktoblend( var_0, "tag_player", 0.1 );
    level.player playerlinktodelta( var_0, "tag_player", 0, 10, 10, 10, 10, 0, 0 );
    level.player enableslowaim( 0.1, 0.1 );
    level waittill( "MarketIntroExpandCamControl" );
    level.player playerlinktodelta( var_0, "tag_player", 0, 45, 40, 30, 25, 0, 0 );
    level.player enableslowaim( 0.2, 0.2 );
}

cafecamerascancounter()
{
    var_0 = 0;
    level.player endon( "DisableScanning" );

    for (;;)
    {
        if ( var_0 == 1 )
            common_scripts\utility::flag_set( "FlagCafeCameraUnlockSwitching" );
        else if ( var_0 < 1 )
        {
            level.player waittill( "CafeScanResultsNegative" );
            var_0++;
        }

        wait 0.05;
    }
}

cafeendcamerascan( var_0 )
{
    common_scripts\utility::flag_wait( "FlagScanTargetComplete" );
    level.bplayerscanon = 0;
    level.player maps\greece_security_camera::securitycameradisable();
    soundscripts\_snd::snd_message( "mhunt_cafe_cam_exit_front" );
    maps\greece_code::setdefaulthudoutlinedvars();
    common_scripts\utility::flag_set( "FlagSafeHouseFollowStart" );
    level.player lerpfov( 50, 0 );

    if ( !common_scripts\utility::flag( "FlagFollowTargetReachedFirstStop" ) )
    {
        level notify( "market_target_teleport" );
        waitframe();
        level.kvafollowtarget maps\_utility::anim_stopanimscripted();
        thread marketkvafollowtargetwalk2();
    }

    var_1 = common_scripts\utility::getstruct( "PlayerVBCafeStruct", "targetname" );
    var_2 = maps\_utility::spawn_anim_model( "player_cafe_rig", var_1.origin );
    var_3 = maps\_utility::spawn_anim_model( "cafe_control_pad", var_1.origin );
    var_4 = maps\_utility::spawn_anim_model( "backpack_drone_large", var_1.origin );

    if ( !isdefined( var_0 ) )
        var_0 = maps\_utility::spawn_anim_model( "player_chair", var_1.origin );

    var_5 = [ var_2, var_3, var_4 ];
    var_1 thread maps\_anim::anim_first_frame_solo( var_0, "hms_greece_market_outro" );
    var_1 maps\_anim::anim_first_frame( var_5, "hms_greece_market_outro" );
    level.player unlink();
    waitframe();
    level.player playerlinktoblend( var_2, "tag_player", 0.1 );
    thread maps\greece_security_camera::scanfadeoutro();
    wait 0.4;
    thread cafeintrofov();
    thread cafevideolog();
    var_1 thread maps\_anim::anim_single_solo( var_0, "hms_greece_market_outro" );
    var_1 maps\_anim::anim_single( var_5, "hms_greece_market_outro" );
    level.player unlink();
    var_2 delete();
    var_3 delete();
    var_4 delete();
    thread maps\_utility::autosave_by_name( "safehouse_market_follow" );
    common_scripts\utility::flag_set( "FlagSetObjFollowTarget" );
    common_scripts\utility::flag_set( "FlagStartCafeVideoLog" );
}

cafevideolog()
{
    // thread maps\greece_vo::cafe_irons_speech_bink();
    common_scripts\utility::flag_wait( "FlagStartCafeVideoLog" );
    // maps\_shg_utility::play_videolog( "manhunt_videolog_02", "screen_add" );
    thread soundscripts\_snd::snd_message( "start_kva_follow_music" );
    common_scripts\utility::flag_set( "FlagCafeVideologComplete" );
}

cafeintrofov()
{
    level waittill( "CafeTransitionBackFOV" );
    level.player lerpfov( 65, 0.5 );
}

cafesetuptouristilana()
{
    level.allies["Ilona"] maps\_utility::set_run_anim( "civilian_hurried_walk", 1 );
    level.allies["Ilona"] maps\_utility::set_idle_anim( "london_station_civ1_idle" );
    level.allies["Ilona"] maps\_utility::gun_remove();
    level.allies["Ilona"].disablefacialfilleranims = 1;
    level.allies["Ilona"] thread safehouseilanaweaponshot();
}

cafesetupilanabackpack()
{
    // self setmodel( "body_ilana_civilian_backpack" );
    self waittill( "DeleteIlanaBackpack" );
    // self setmodel( "body_ilana_civilian" );
}

cafeilanaseat()
{
    var_0 = common_scripts\utility::getstruct( "IlanaCafeMove1Struct", "targetname" );
    var_1 = getent( "ilana_tea_cup", "targetname" );
    var_1.animname = "tea_cup";
    var_1 maps\_utility::assign_animtree( "tea_cup" );
    var_2 = level.allies["Ilona"];
    var_3 = maps\_utility::spawn_anim_model( "backpack_drone_small", var_0.origin );
    var_0 thread maps\_anim::anim_first_frame_solo( var_3, "hms_greece_market_intro" );
    var_0 thread maps\_anim::anim_single_solo( var_3, "hms_greece_market_intro" );
    var_4 = maps\_utility::spawn_anim_model( "ilana_chair", var_0.origin );
    var_0 thread maps\_anim::anim_first_frame_solo( var_4, "hms_greece_market_intro" );
    var_0 thread maps\_anim::anim_single_solo( var_4, "hms_greece_market_intro" );
    var_2.disablefacialfilleranims = 1;
    var_0 maps\_anim::anim_single_solo( var_2, "hms_greece_market_intro" );
    var_0 thread maps\_anim::anim_loop_solo( var_2, "hms_greece_market_intro_loop", "IlanaMarketEnder1" );
    var_0 thread maps\_anim::anim_loop_solo( var_1, "hms_greece_market_intro_loop", "IlanaMarketEnder1" );
    common_scripts\utility::flag_wait( "FlagSafeHouseFollowStart" );
    var_0 notify( "IlanaMarketEnder1" );
    var_2 maps\_utility::anim_stopanimscripted();
    thread cafemarketmoveilana( var_3, var_4 );
}

cafeinitvendorgate()
{
    var_0 = common_scripts\utility::getstruct( "IlanaCafeMove4Struct", "targetname" );
    var_1 = getent( "MarketIlanaExitGate", "targetname" );
    var_1.animname = "vendorgate";
    var_1 maps\_utility::assign_animtree( "vendorgate" );
    var_0 thread maps\_anim::anim_first_frame_solo( var_1, "hms_greece_market_vendor_exit" );
}

cafemarketmoveilana( var_0, var_1, var_2 )
{
    var_3 = common_scripts\utility::getstruct( "IlanaCafeMove1Struct", "targetname" );
    var_4 = common_scripts\utility::getstruct( "IlanaCafeMove2Struct", "targetname" );
    var_5 = common_scripts\utility::getstruct( "IlanaCafeMove3Struct", "targetname" );
    var_6 = common_scripts\utility::getstruct( "IlanaCafeMove4Struct", "targetname" );
    var_7 = common_scripts\utility::getstruct( "CafeWaiterOrg", "targetname" );
    var_8 = level.allies["Ilona"];

    if ( !isdefined( var_0 ) )
        var_0 = maps\_utility::spawn_anim_model( "backpack_drone_small", var_3.origin );

    if ( !isdefined( var_1 ) )
        var_1 = maps\_utility::spawn_anim_model( "ilana_chair", var_3.origin );

    if ( !isdefined( var_2 ) )
    {
        var_2 = getent( "ilana_tea_cup", "targetname" );
        var_2.animname = "tea_cup";
        var_2 maps\_utility::assign_animtree( "tea_cup" );
    }

    var_9 = getent( "MarketIlanaExitGate", "targetname" );
    var_10 = [ var_8, var_0 ];
    var_4 maps\_anim::anim_first_frame( var_10, "hms_greece_market_outro" );
    wait 0.4;
    thread cafeoutrositter();
    var_8.disablefacialfilleranims = 0;
    var_2 show();
    var_7 thread maps\_anim::anim_single_solo( var_2, "hms_greece_market_outro" );
    var_4 thread maps\_anim::anim_single_solo( var_1, "hms_greece_market_outro" );
    var_4 maps\_anim::anim_single( var_10, "hms_greece_market_outro" );
    var_5 thread maps\_anim::anim_loop( var_10, "hms_greece_market_vendor_loop", "IlanaMarketEnder3" );
    common_scripts\utility::flag_wait_all( "FlagTriggerPlayerMidMarket", "FlagMarketCoupleAtGoal", "FlagCafeVideologComplete" );
    common_scripts\utility::flag_set( "FlagIlanaMidMarketStartMoving" );
    thread cafemarketslowdownplayermore();
    var_5 notify( "IlanaMarketEnder3" );
    var_8.disablefacialfilleranims = 0;
    var_6 thread maps\_anim::anim_single_solo( var_9, "hms_greece_market_vendor_exit" );
    var_6 maps\_anim::anim_single( var_10, "hms_greece_market_vendor_exit" );
    level.allies["Ilona"] notify( "IlanaExitMarket" );
    var_11 = level.allies["Ilona"].goalradius;
    level.allies["Ilona"].goalradius = 16;
    level.allies["Ilona"] maps\_utility::set_goal_node_targetname( "MarketIlanaDisappearNode" );
    level.allies["Ilona"] maps\_utility::anim_stopanimscripted();
    var_0 delete();
    level.allies["Ilona"] waittill( "goal" );
    var_12 = getnode( "MarketIlanaBackAlleyWait", "targetname" );
    level.allies["Ilona"] maps\_utility::teleport_ai( var_12 );
    common_scripts\utility::flag_set( "FlagSafehouseIlanaTeleportToBack" );
    waitframe();
    level.allies["Ilona"].goalradius = var_11;
    level.allies["Ilona"] thread cafesetupilanabackpack();
    common_scripts\utility::flag_wait( "FlagFollowTargetKilled" );
    thread safehouseilanaclearsafehouse();
}

cafemarketslowdownplayermore()
{
    if ( !common_scripts\utility::flag( "FlagKVATargetInAlley" ) )
    {
        level.player notify( "CancelMoveSpeedScale" );
        waitframe();
        level.player thread playerrubberbandmovespeedscale( level.kvafollowtarget, 0.1, 0.5, 400, 1000 );
        common_scripts\utility::flag_wait( "FlagKVATargetInAlley" );
        wait 1.0;
    }

    common_scripts\utility::flag_wait( "FlagSafehouseIlanaTeleportToBack" );
    level.player notify( "CancelMoveSpeedScale" );
    waitframe();
    level.player playerchangemode( "no_combat_fast" );
    level.player thread playerrubberbandmovespeedscale( level.kvafollowtarget, 0.2, 0.5, 200, 800 );
}

cafeoutrositter()
{
    var_0 = common_scripts\utility::getstruct( "CafeSitterOrg", "targetname" );
    var_1 = maps\_utility::spawn_targetname( "OutroCafeSitter", 1 );
    var_1 setmodel( "civ_urban_male_body_e" );
    var_1 thread codescripts\character::setheadmodel( "head_m_act_cau_kanik_base" );
    var_1.animname = "sitter";
    var_2 = maps\_utility::spawn_anim_model( "sitter_chair", var_0.origin );
    var_3 = common_scripts\utility::getstruct( "CafeSitterPartnerOrg", "targetname" );
    var_4 = getent( "civilian_female", "targetname" );
    var_5 = var_4 maps\_utility::dronespawn();
    var_4.count = 1;
    var_5.origin = var_3.origin;
    var_5.angles = var_3.angles;
    var_6 = [ "civ_urban_female_body_b_yellow", "civ_urban_female_body_b_olive", "civ_urban_female_body_e_gold", "civ_urban_female_body_b_blue", "civ_urban_female_body_d" ];
    var_7 = [ "head_f_gen_cau_peterson", "head_f_act_cau_hamilton_base", "head_f_gen_cau_giovanni", "head_f_gen_cau_withers", "head_f_gen_cau_coyle" ];
    var_8 = common_scripts\utility::random( var_7 );
    var_9 = common_scripts\utility::random( var_6 );
    var_5 thread codescripts\character::setheadmodel( var_8 );
    var_5 setmodel( var_9 );
    var_5.animname = "generic";
    var_10 = var_3.animation;
    var_3 thread maps\_anim::anim_generic_loop( var_5, var_10 );
    var_0 thread maps\_anim::anim_single_solo( var_2, "hms_greece_market_outro" );
    var_0 maps\_anim::anim_single_solo( var_1, "hms_greece_market_outro" );
    var_0 thread maps\_anim::anim_loop_solo( var_1, "hms_greece_market_outro_loop" );
    common_scripts\utility::flag_wait( "FlagDeleteSafehouseCivilians" );
    var_1 delete();
    var_5 delete();
}

cafemarketilanabackyardwait()
{
    var_0 = common_scripts\utility::getstruct( "IlanaBackCourtyardWait", "targetname" );
    var_1 = "london_guard_idle1";
    var_0 maps\_anim::anim_reach_solo( self, var_1 );
    var_0 thread maps\_anim::anim_loop_solo( self, var_1, "IlanaStopBackyardWait" );
    common_scripts\utility::flag_wait( "FlagSafehouseMeleeKillInitiated" );
    var_0 notify( "IlanaStopBackyardWait" );
    maps\_utility::anim_stopanimscripted();
}

cafemarketplayerfollowtarget()
{
    common_scripts\utility::flag_wait( "FlagFollowTargetReachedFinalStop" );
    common_scripts\utility::flag_set( "FlagSafeHouseKillStart" );
}

marketenemyinit()
{
    self.maxvisibledist = 0.1;
    self.health = 1;
    self.fovcosine = cos( 80 );
    maps\_utility::set_goalradius( 32 );
    maps\_utility::gun_remove();
    maps\_utility::set_ignoreall( 1 );
    self.animname = "KeyMan";
    self.script_parameters = "KeyMan";
    maps\_utility::disable_exits();
    maps\_utility::disable_arrivals();
    maps\_utility::set_idle_anim( "civilian_stand_idle" );
    maps\_utility::set_run_anim( "civilian_cool_walk", 1 );
    maps\_utility::disable_surprise();
    self.battlechatter = 0;
    thread maps\greece_code::clearalertoutline();
}

safehousetranstoalleygatesetup()
{
    var_0 = common_scripts\utility::getstruct( "gateOrg", "targetname" );
    var_1 = getent( "greece_alley_gate", "targetname" );
    var_1 maps\_utility::assign_animtree( "alley_gate" );
    var_1.animname = "alley_gate";
    var_0 thread maps\_anim::anim_first_frame_solo( var_1, "safehouse_gate_bash" );
}

marketmovekvafollowtarget()
{
    self endon( "death" );
    var_0 = level.start_point;

    if ( var_0 == "start_safehouse_follow" )
    {
        var_1 = getent( "KVAFollowTargetTeleport1", "targetname" );
        level.kvafollowtarget forceteleport( var_1.origin, var_1.angles );
    }
    else if ( var_0 == "start_safehouse_xslice" )
    {
        var_1 = getent( "KVAFollowTargetTeleport2", "targetname" );
        level.kvafollowtarget forceteleport( var_1.origin, var_1.angles );
        thread marketkvafollowtargetkill();
    }
    else
        thread marketkvafollowtargetwalk1();
}

failtargetescaped1()
{
    maps\_hms_utility::printlnscreenandconsole( "MISSION FAIL - TARGET ESCAPED!!!" );
    level notify( "lazy_mission_end" );
    common_scripts\utility::flag_set( "FlagScanRemoveHint" );
    maps\greece_safehouse_vo::safehousefailtargetescaped();
    wait 1;
    setdvar( "ui_deadquote", &"GREECE_MARKET_TARGETESCAPE1_FAIL" );
    maps\_utility::missionfailedwrapper();
}

failtargetescaped2()
{
    maps\_hms_utility::printlnscreenandconsole( "MISSION FAIL - TARGET ESCAPED!!!" );
    level notify( "lazy_mission_end" );
    maps\greece_safehouse_vo::safehousefailtargetescaped();
    wait 1;
    setdvar( "ui_deadquote", &"GREECE_MARKET_TARGETESCAPE2_FAIL" );
    maps\_utility::missionfailedwrapper();
}

failtargetescaped3()
{
    maps\_hms_utility::printlnscreenandconsole( "MISSION FAIL - TARGET ESCAPED!!!" );
    level notify( "lazy_mission_end" );
    maps\greece_safehouse_vo::safehousefailtargetescaped();
    wait 1;
    setdvar( "ui_deadquote", &"GREECE_MARKET_TARGETESCAPE3_FAIL" );
    maps\_utility::missionfailedwrapper();
}

marketkvafollowtargetwalk1()
{
    level endon( "market_target_teleport" );
    var_0 = common_scripts\utility::getstruct( "KVAtargetWalkOrg", "targetname" );
    level waittill( "MarketCameraSwitch" );
    thread spawnaddwalkers();
    thread spawndecoycivilians();
    common_scripts\utility::flag_set( "FlagDeleteMarketFirstWalkers" );
    var_0 maps\_anim::anim_single_solo( level.kvafollowtarget, "hms_greece_market_target_walk" );
    common_scripts\utility::flag_set( "FlagFollowTargetReachedFirstStop" );
    thread marketkvafollowtargetwalk2();
}

marketkvafollowtargetwalk2()
{
    var_0 = common_scripts\utility::getstruct( "KVAtargetWalkOrg", "targetname" );
    var_0 thread maps\_anim::anim_loop_solo( level.kvafollowtarget, "hms_greece_market_target_idle", "KVAFollowTargetStopIdle" );
    common_scripts\utility::flag_wait_either( "FlagTriggerStartKVATargetWalkExit", "FlagKVATargetWaitTimerExpired" );
    var_0 notify( "KVAFollowTargetStopIdle" );
    level.kvafollowtarget maps\_utility::anim_stopanimscripted();
    thread monitorkvatargetinalley();
    thread marketkvafollowtargetgate();
    var_0 maps\_anim::anim_single_solo( level.kvafollowtarget, "hms_greece_market_target_exit" );
    level.kvafollowtarget notify( "badplace_end" );
    common_scripts\utility::flag_set( "FlagFollowTargetReachedSecondStop" );
    thread marketkvafollowtargetkill();
}

marketkvafollowtargetgate()
{
    var_0 = common_scripts\utility::getstruct( "marketgateOrg", "targetname" );
    var_1 = getent( "market_gate", "targetname" );
    var_1.animname = "marketgate";
    var_1 maps\_utility::assign_animtree( "marketgate" );
    var_0 maps\_anim::anim_single_solo( var_1, "hms_greece_market_target_exit" );
}

monitorkvatargetinalley()
{
    var_0 = getent( "TrigKVATargetInAlley", "targetname" );

    for (;;)
    {
        if ( level.kvafollowtarget istouching( var_0 ) )
            break;

        waitframe();
    }

    common_scripts\utility::flag_set( "FlagKVATargetInAlley" );
}

marketkvafollowtargettimer()
{
    var_0 = [];
    var_0[0] = 180;
    var_0[1] = 120;
    var_0[2] = 90;
    var_0[3] = 45;
    level.markettimewindow = var_0[level.gameskill];
    var_1 = maps\_hud_util::get_countdown_hud();
    var_1.label = &"GREECE_MARKET_TIMER_LABEL_CAPS";
    var_1.x = -110;
    var_1.y = 45;
    var_1.alignx = "left";
    var_1.horzalign = "center";
    var_1.color = ( 0.95, 0.95, 1 );
    var_1 setpulsefx( 30, 900000, 700 );
    var_1 settenthstimer( level.markettimewindow );
    thread freezemarkettimer( var_1 );
    thread maps\greece_safehouse_vo::scantakestoolongmonitor();
    thread marketscanautohighlight();
    thread monitorfollowtargetescape();
    wait(level.markettimewindow + 3);

    if ( !common_scripts\utility::flag( "FlagFollowTargetMarked" ) )
    {
        common_scripts\utility::flag_set( "FlagKVATargetWaitTimerExpired" );
        level notify( "MarketTimerExpired" );
        level.player notify( "DisableScanning" );
        wait 3;
        destroymarkettimer( var_1 );
    }
}

freezemarkettimer( var_0 )
{
    level endon( "MarketTimerExpired" );
    var_1 = gettime();
    common_scripts\utility::flag_wait( "FlagFollowTargetMarked" );
    var_2 = gettime();
    var_3 = ( var_2 - var_1 ) * 0.001;
    var_4 = level.markettimewindow - var_3;

    if ( var_4 <= 0 )
        var_4 = 0.01;

    var_0 settenthstimerstatic( var_4 );
    wait 3;
    destroymarkettimer( var_0 );
}

destroymarkettimer( var_0 )
{
    if ( isdefined( var_0 ) )
        var_0 destroy();
}

marketscanautohighlight()
{
    if ( level.gameskill <= 1 )
    {
        wait(level.markettimewindow - level.markettimewindow / 4);

        if ( !common_scripts\utility::flag( "FlagFollowTargetMarked" ) )
        {
            foreach ( var_1 in level.potentialscantargets )
                var_1 hudoutlineenable( 5, 0 );
        }
    }
}

monitorfollowtargetescape()
{
    level waittill( "MarketTimerExpired" );

    if ( !common_scripts\utility::flag( "FlagFollowTargetMarked" ) )
        thread failtargetescaped1();
}

marketguybadplace()
{
    level endon( "lazy_mission_end" );

    if ( !isdefined( self.hasbadplace ) || self.hasbadplace == 0 )
    {
        self.hasbadplace = 1;
        createmovingbadplace();
    }
}

createmovingbadplace()
{
    level endon( "lazy_mission_end" );
    self endon( "badplace_end" );
    var_0 = 1.0;
    var_1 = 128;

    for (;;)
    {
        var_2 = anglestoforward( self.angles );
        badplace_arc( self.script_noteworthy + "arc", var_0, self.origin, 64, var_1, var_2, 15, 15, "neutral", "allies" );
        badplace_cylinder( self.script_noteworthy + "cyl", var_0, self.origin, 32, var_1, "neutral", "allies" );
        wait(var_0 + 0.05);
    }
}

marketkvafollowtargetkill()
{
    var_0 = level.allies["Ilona"];
    var_1 = level.kvafollowtarget;
    var_2 = getent( "SafehouseKVAAmbusher", "targetname" );
    var_3 = var_2 maps\_utility::spawn_ai( 1 );
    var_3 character\gfl\randomizer_sf::main();
    // var_3 setmodel( "kva_civilian_a_ambusher" );
    var_3.animname = "Victim";
    var_3.script_parameters = "Victim";
    var_3.fovcosine = cos( 60 );
    var_3 maps\_utility::gun_remove();
    var_0.disablefacialfilleranims = 0;
    var_4 = "courtyard_takedown_enter";
    var_5 = "courtyard_takedown_idle";
    var_6 = "courtyard_takedown";
    var_7 = getent( "safehouse_pillow", "targetname" );
    var_7 hide();
    var_8 = [ var_3, var_1 ];
    var_9 = common_scripts\utility::getstruct( "SafehouseCourtyardTakedownOrg", "targetname" );
    var_1 thread setupaiforanimsequence();
    var_3 thread setupaiforanimsequence();
    level.kvafollowtarget attach( "weapon_parabolic_knife", "TAG_WEAPON_RIGHT", 1 );
    var_9 thread maps\_anim::anim_loop_solo( var_3, var_5, "StartSafehouseTakedown" );
    common_scripts\utility::flag_set( "FlagChangeObjFollowTarget" );
    var_1 thread safehousecourtyardtakedownknifenpc( var_9, var_4, var_5 );
    common_scripts\utility::flag_wait( "FlagTriggerStartIlanaTakedownEnter" );
    var_9 maps\_anim::anim_single_solo( var_0, var_4 );
    var_9 thread maps\_anim::anim_loop_solo( var_0, var_5, "StartSafehouseTakedown" );
    level.player thread marketkvafollowtargetbuttoncapture( var_9 );
    var_1 thread maps\greece_safehouse_vo::safehousekillreminder();
    var_1 thread marketkvafollowtargetstopidle( var_9 );
    var_3 thread marketkvaambusherstopidle( var_9 );
    var_0 thread safehousecourtyardtakedownilonafail( var_9 );

    foreach ( var_11 in var_8 )
    {
        var_11 thread marketkvafollowtargetalertmonitor();
        var_11 thread safehousecourtyardsightwatch();
    }

    common_scripts\utility::flag_wait( "FlagSafehouseMeleeKillInitiated" );
    level notify( "PlayerInitiateKeyManKill" );
    level notify( "CourtyardDistractionDialogInterrupt" );
    level.player notify( "CancelMoveSpeedScale" );
    level.kvafollowtarget notify( "remove_outline" );
    common_scripts\utility::flag_set( "FlagClearObjFollowTarget" );
    level.player hideviewmodel();
    var_13 = maps\_utility::spawn_anim_model( "player_cafe_rig", level.player.origin );
    var_13 hide();
    maps\greece_safehouse_fx::guarddustdrag();
    var_9 maps\_anim::anim_first_frame_solo( var_13, var_6 );
    level.player playerlinktoblend( var_13, "tag_player", 0.4 );
    wait 0.4;
    var_13 show();

    if ( level.currentgen )
    {
        if ( istransientloaded( "greece_market_audio_tr" ) )
        {
            level notify( "tff_unload_market_audio" );
            unloadtransient( "greece_market_audio_tr" );
        }
    }

    var_9 thread maps\_anim::anim_single( var_8, var_6 );
    var_9 thread maps\_anim::anim_single_solo( var_13, var_6 );
    thread safehousetakedownreturnplayercontrol( getanimlength( var_13 maps\_utility::getanim( var_6 ) ), var_13 );
    level.kvafollowtarget thread safehousekvafollowtargetdeath( getanimlength( level.kvafollowtarget maps\_utility::getanim( var_6 ) ) );
    var_3 thread safehousekvafollowtargetdeath( getanimlength( var_3 maps\_utility::getanim( var_6 ) ) );
    thread safehousecourtyardtakedownprops();
    soundscripts\_snd::snd_message( "start_safehouse_stealth_music" );
    var_9 maps\_anim::anim_single_solo( var_0, var_6 );
    thread safehouseilanaopendooridle();
    common_scripts\utility::flag_set( "FlagFollowTargetUnmarked" );
}

safehousecourtyardtakedownknifenpc( var_0, var_1, var_2 )
{
    var_0 thread maps\_anim::anim_loop_solo( self, var_2, "StopKnifeNPCLoop" );
    common_scripts\utility::flag_wait( "FlagTriggerStartIlanaTakedownEnter" );
    wait 0.1;
    var_0 notify( "StopKnifeNPCLoop" );
    maps\_utility::anim_stopanimscripted();
    var_0 maps\_anim::anim_single_solo( self, var_1 );
    var_0 thread maps\_anim::anim_loop_solo( self, var_2, "StartSafehouseTakedown" );
}

safehousecourtyardtakedownilonafail( var_0 )
{
    common_scripts\utility::flag_wait( "FlagTriggerStartTakedownTimer" );
    level common_scripts\utility::waittill_either( "CourtyardDistractionDialogComplete", "SafehouseTakedownAlert" );
    wait 0.1;

    if ( common_scripts\utility::flag( "FlagSafehouseMeleeKillInitiated" ) )
        return;

    var_0 notify( "StartSafehouseTakedown" );
    self notify( "stop_talking" );
    waitframe();
    var_0 maps\_anim::anim_single_solo( self, "courtyard_takedown_fail" );
}

safehousecourtyardtakedownprops()
{
    level waittill( "CourtyardTakedownUnholsterWeapon" );
    level.allies["Ilona"] maps\_utility::forceuseweapon( "iw5_titan45_sp_opticsreddot_silencerpistol", "primary" );
    level.allies["Ilona"] maps\_utility::gun_recall();
}

marketkvafollowtargetstopidle( var_0 )
{
    common_scripts\utility::flag_wait( "FlagTriggerStartTakedownTimer" );
    level common_scripts\utility::waittill_either( "CourtyardDistractionDialogComplete", "SafehouseTakedownAlert" );
    level notify( "CourtyardDistractionDialogInterrupt" );
    wait 0.1;

    if ( common_scripts\utility::flag( "FlagSafehouseMeleeKillInitiated" ) )
        return;

    if ( common_scripts\utility::flag( "FlagFollowTargetUnmarked" ) )
        return;

    var_0 notify( "StartSafehouseTakedown" );
    thread marketkvafollowtargetalerted( var_0 );
    common_scripts\utility::flag_set( "FlagClearObjFollowTarget" );
    common_scripts\utility::flag_set( "FlagFollowTargetUnmarked" );
    common_scripts\utility::trigger_off( "UseTriggerKillKVAfollowTarget", "targetname" );
}

marketkvaambusherstopidle( var_0 )
{
    level common_scripts\utility::waittill_either( "CourtyardDistractionDialogComplete", "SafehouseTakedownAlert" );
    level notify( "CourtyardDistractionDialogInterrupt" );
    wait 0.1;

    if ( common_scripts\utility::flag( "FlagSafehouseMeleeKillInitiated" ) )
        return;

    var_0 notify( "StartSafehouseTakedown" );
    self notify( "stop_talking" );
    waitframe();
    var_0 maps\_anim::anim_single_solo( self, "courtyard_takedown_fail" );
    self.surprisedbymedistsq = 1;
    self stopanimscripted();
    self.combatmode = "no_cover";
    maps\_utility::set_goalradius( 512 );
    self.battlechatter = 1;
    self.allowdeath = 1;
    self.maxvisibledist = 1;
    self.health = 100;
    maps\_utility::set_favoriteenemy( level.allies["Ilona"] );
    maps\_utility::enable_arrivals();
    maps\_utility::clear_generic_idle_anim();
    maps\_utility::clear_generic_run_anim();
}

marketkvafollowtargetnecksnaprumble( var_0 )
{
    level.player playrumbleonentity( "damage_heavy" );
    wait 1;
    level.player maps\_upgrade_challenge::give_player_challenge_kill( 1 );
}

marketkvafollowtargetalerted( var_0 )
{
    level notify( "KVAFollowTargetAlerted" );
    self notify( "remove_outline" );
    common_scripts\utility::flag_set( "FlagFollowTargetUnmarked" );
    common_scripts\utility::trigger_off( "UseTriggerKillKVAfollowTarget", "targetname" );
    self notify( "stop_talking" );
    var_0 maps\_anim::anim_single_solo( self, "courtyard_takedown_fail" );
    self.surprisedbymedistsq = 1;
    self stopanimscripted();
    maps\_utility::disable_dontevershoot();
    self.combatmode = "no_cover";
    maps\_utility::set_goalradius( 512 );
    self.battlechatter = 1;
    self.allowdeath = 1;
    self.ignoreall = 0;
    self.maxvisibledist = 1;
    self.health = 100;
    maps\_utility::enable_arrivals();
    maps\_utility::clear_generic_idle_anim();
    maps\_utility::clear_generic_run_anim();

    if ( !common_scripts\utility::flag( "FlagSafehouseMeleeKillInitiated" ) )
    {
        maps\_hms_utility::printlnscreenandconsole( "MISSION FAIL - KVA ALERTED!!!" );
        thread maps\greece_safehouse_vo::safehousefailkvaalerted();
        wait 1;
        common_scripts\utility::flag_set( "FlagSafehouseHideHint" );
        setdvar( "ui_deadquote", &"GREECE_DRONE_ALERT_FAIL" );
        maps\_utility::missionfailedwrapper();
    }
}

marketkvafollowtargetalertmonitor()
{
    self endon( "death" );
    level endon( "SafehouseTakedownAlert" );
    level endon( "PlayerInitiateKeyManKill" );

    for (;;)
    {
        if ( level.player istouching( self ) )
            break;

        waitframe();
    }

    level notify( "SafehouseTakedownAlert" );
}

safehousecourtyardsightwatch()
{
    self endon( "death" );
    level endon( "SafehouseTakedownAlert" );
    level endon( "PlayerInitiateKeyManKill" );
    var_0 = getent( "TrigKVACourtyardAlert", "targetname" );

    for (;;)
    {
        if ( self cansee( level.player ) )
            break;

        if ( level.player istouching( var_0 ) )
            break;

        waitframe();
    }

    level notify( "SafehouseTakedownAlert" );
}

safehousefollowplayernotifies()
{
    level endon( "lazy_mission_end" );
    common_scripts\utility::flag_wait( "FlagTriggerPlayerMidMarket" );
    level.player notify( "NotifyPlayerReachedMidMarket" );
    common_scripts\utility::flag_wait( "FlagTriggerPlayerEnterAlley" );
    level.player notify( "NotifyPlayerReachedAlley" );
    wait 1.0;
    thread maps\_utility::autosave_by_name( "safehouse_market_alley" );
    common_scripts\utility::flag_wait( "FlagTriggerStartTakedownTimer" );
    level.player notify( "NotifyPlayerReachedCourtyard" );
}

safehousebackyarddamagetriggers()
{
    var_0 = getentarray( "SafehouseBackyardDamageDetectionTrig", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_2 thread safehousebackyardalertmonitoron();
        var_2 thread safehousebackyardalertmonitoroff();
    }
}

safehousebackyarddamagetriggerstoggle()
{
    level.bplayerisinsidesafehouse = 0;
    var_0 = getentarray( "SafehousePlayerIsInsideTrigger", "targetname" );
    var_1 = getentarray( "SafehousePlayerIsOutsideTrigger", "targetname" );

    foreach ( var_3 in var_1 )
        var_3 common_scripts\utility::trigger_off();

    common_scripts\utility::array_thread( var_0, ::safehousebackyarddamagetriggerwaits, 1, var_1 );
    common_scripts\utility::array_thread( var_1, ::safehousebackyarddamagetriggerwaits, 0, var_0 );
}

safehousebackyarddamagetriggerwaits( var_0, var_1 )
{
    for (;;)
    {
        self waittill( "trigger", var_2 );
        level.bplayerisinsidesafehouse = var_0;

        foreach ( var_4 in var_1 )
            var_4 common_scripts\utility::trigger_on();

        waitframe();
    }
}

safehousebackyardalertmonitoron()
{
    for (;;)
    {
        self waittill( "trigger" );

        if ( level.bplayerisinsidesafehouse == 0 )
        {
            common_scripts\utility::flag_set( "FlagSafehouseBackyardFail" );
            thread maps\greece_safehouse_vo::safehousefailcoverblown();
            wait 1;
            maps\_hms_utility::printlnscreenandconsole( "MISSION FAIL - AUTHORITIES ALERTED!!!" );

            if ( common_scripts\utility::flag( "FlagClearSafehouseComplete" ) || common_scripts\utility::flag( "FlagSafeHouseTransitionStart" ) )
            {
                setdvar( "ui_deadquote", &"GREECE_SAFEHOUSE_POLICE_FAIL" );
                maps\_utility::missionfailedwrapper();
            }
            else
                setdvar( "ui_deadquote", &"GREECE_DRONE_ALERT_FAIL" );

            maps\_utility::missionfailedwrapper();
        }

        waitframe();
    }
}

safehousebackyardalertmonitoroff()
{
    common_scripts\utility::flag_wait( "FlagSafeHouseOutroStart" );
    common_scripts\utility::trigger_off();
}

safehousetakedownreturnplayercontrol( var_0, var_1 )
{
    wait(var_0);
    level.player unlink();
    var_1 delete();
    level.player showviewmodel();
    level.player giveweapon( "iw5_titan45_sp_opticsreddot_silencerpistol" );
    level.player switchtoweaponimmediate( "iw5_titan45_sp_opticsreddot_silencerpistol" );
    level.player enableweaponswitch();
    thread maps\_utility::autosave_by_name( "safehouse_courtyard_takedown" );
    common_scripts\utility::flag_set( "FlagSafehouseCourtyardTakedownComplete" );
    wait 0.5;
    common_scripts\utility::flag_set( "FlagSetObjClearSafehouse" );
    level.player notify( "CancelMoveSpeedScale" );
    waitframe();
    level.player playerchangemode( "stealth_combat" );
    level.player thread playerrubberbandmovespeedscale( level.allies["Ilona"], 0.3, 1, 50, 300 );
    thread safehousebackyarddamagetriggers();
    thread safehousebackyarddamagetriggerstoggle();
}

safehousekvafollowtargetdeath( var_0 )
{
    wait(var_0);
    maps\greece_code::kill_no_react();
    common_scripts\utility::flag_set( "FlagFollowTargetKilled" );
}

marketkvafollowtargetbuttoncapture( var_0 )
{
    self endon( "death" );
    level endon( "KVAFollowTargetAlerted" );
    var_1 = getent( "UseTriggerKillKVAfollowTarget", "targetname" );
    thread marketkvafollowtargetbuttonhint( var_1 );
    var_1 sethintstring( &"GREECE_SAFEHOUSE_EXECUTE_PROMPT" );
    thread marketkvafollowtargetmeleecheck( var_1 );
    common_scripts\utility::flag_wait( "FlagSafehouseMeleeKillInitiated" );
    var_0 notify( "StartSafehouseTakedown" );
    var_1 delete();
}

marketkvafollowtargetmeleecheck( var_0 )
{
    level endon( "KVAFollowTargetAlerted" );

    for (;;)
    {
        var_1 = distance2d( level.player.origin, var_0.origin );

        if ( var_1 <= 72.0 && level.player meleebuttonpressed() )
            break;

        waitframe();
    }

    common_scripts\utility::flag_set( "FlagSafehouseMeleeKillInitiated" );
    common_scripts\utility::flag_set( "init_safehouse_melee_kill_initiated_post" );
}

marketkvafollowtargetbuttonhint( var_0 )
{
    self endon( "death" );
    var_1 = level.kvafollowtarget maps\_shg_utility::hint_button_tag( "melee", "j_spine4", 70, 200, undefined, var_0 );
    common_scripts\utility::flag_wait_either( "FlagSafehouseMeleeKillInitiated", "FlagClearObjFollowTarget" );
    var_1 maps\_shg_utility::hint_button_clear();
}

safehouseenemyinit( var_0 )
{
    self.maxvisibledist = 0.1;
    self.health = 1;
    maps\_utility::set_goalradius( 32 );
    maps\_utility::enable_cqbwalk();
    maps\_utility::enable_dontevershoot();
    self.battlechatter = 0;
    maps\_utility::set_ignoreall( 1 );

    if ( var_0 == 1 )
        maps\_utility::gun_remove();

    self.grenadeammo = 0;
}

safehouseenemiesignoreplayer( var_0 )
{
    if ( var_0 == 1 )
    {
        createthreatbiasgroup( "player_safehouse" );
        self setthreatbiasgroup( "player_safehouse" );
        setignoremegroup( "player_safehouse", "axis" );
    }
    else
        self setthreatbiasgroup();
}

safehousetvdestructible()
{
    var_0 = getent( "safehouse_tv_screen", "targetname" );
    var_1 = getent( "safehouse_tv_glass", "targetname" );
    var_1 soundscripts\_snd::snd_message( "mhunt_tv_broadcast" );
    var_2 = getent( "safehouse_tv_light_primary", "script_noteworthy" );
    var_3 = getent( "safehouse_tv_light_secondary", "script_noteworthy" );
    var_4 = "greece_safehouse_tv_destroyed_glass";
    var_5 = "greece_safehouse_tv_screen_static";
    precachemodel( var_4 );
    precachemodel( var_5 );
    var_1 setcandamage( 1 );
    var_1 common_scripts\utility::waittill_any( "damage", "SonicAoEDamage" );
    var_1 setmodel( var_4 );
    var_0 setmodel( var_5 );
    var_3 setlightintensity( 0 );
    var_2 setlightintensity( 0.25 );
    var_1 soundscripts\_snd::snd_message( "mhunt_tv_dest_expl" );
    var_6 = getent( "SafehousePlanningOrg", "targetname" );
    var_6 notify( "fail_left" );
    var_6 notify( "fail_right" );
    level notify( "SafehousePlanningGuardsAlerted" );
}

safehouseilanaweaponshot()
{
    common_scripts\utility::flag_wait( "FlagFollowTargetUnmarked" );
    maps\_utility::clear_run_anim();
    maps\_utility::clear_generic_idle_anim();
    maps\_utility::enable_cqbwalk();
}

safehouseilanaopendooridle()
{
    var_0 = "keycard_door_open_in";
    var_1 = "keycard_door_open_idle";
    var_2 = common_scripts\utility::getstruct( "safehousekill", "targetname" );
    var_3 = level.allies["Ilona"];
    var_4 = maps\_utility::spawn_anim_model( "keycard", var_2.origin );
    var_3.keycard = var_4;
    var_5 = [ var_3, var_4 ];
    var_4 hide();
    var_2 maps\_anim::anim_single( var_5, var_0 );
    var_2 thread maps\_anim::anim_loop( var_5, var_1, "EndKeycardIdle" );
    common_scripts\utility::flag_wait( "FlagTriggerPlayerNearBackDoor" );
    level notify( "SafehousePlayerNearEntrance" );
    common_scripts\utility::flag_set( "IlanaSafehouseDoorIdleStart" );

    if ( !common_scripts\utility::flag( "FlagSafehouseBackyardFail" ) )
        thread maps\_utility::autosave_by_name( "safehouse_door_entry" );
}

safehouseilanaopensafehousedoor()
{
    common_scripts\utility::flag_wait( "IlanaSafehouseDoorIdleStart" );
    var_0 = "keycard_door_open";
    var_1 = "keycard_wall_idle";
    var_2 = "safehouse_enter";
    var_3 = common_scripts\utility::getstruct( "safehousekill", "targetname" );
    var_4 = level.allies["Ilona"];
    var_5 = var_4.keycard;
    var_6 = getent( "safehouse_door", "targetname" );
    var_7 = getent( "safehouse_door_collision", "targetname" );
    var_8 = [ var_6, var_5 ];
    var_3 notify( "EndKeycardIdle" );
    var_3 thread maps\_anim::anim_single( var_8, var_0 );
    var_3 maps\_anim::anim_single_solo( var_4, var_0 );
    var_3 thread maps\_anim::anim_loop_solo( var_4, var_1, "stopIdleLoop" );
    var_7 connectpaths();
    var_9 = getaiarray( "axis" );

    foreach ( var_11 in var_9 )
        var_11 thread maps\_variable_grenade::handle_detection();

    common_scripts\utility::flag_wait( "FlagTriggerPlayerEnterSafehouse" );
    thread safehouseplayermovespeedscale1stfloor();
    var_3 notify( "stopIdleLoop" );
    var_13 = maps\_utility::spawn_anim_model( "threat_grenade" );
    var_13 hide();
    wait 0.1;
    var_3 thread maps\_anim::anim_single_solo( var_4, "threat_grenade_npc" );
    var_14 = getent( "IlanathreatGrenadeOrg", "targetname" );
    var_14 thread maps\_variable_grenade::detection_grenade_think( level.player, 3000, undefined, 15 );
    soundscripts\_snd::snd_message( "start_threat_grenade_mixer" );
    var_3 maps\_anim::anim_single_solo( var_13, "threat_grenade_npc" );
    var_3 thread maps\_anim::anim_loop_solo( var_4, var_1, "stopIdleLoop" );
    thread safehouseremovethreatgrenade( var_13 );
    common_scripts\utility::flag_set( "FlagSafehouseThreatGrenadeDetonated" );
    common_scripts\utility::flag_wait( "FlagKVASafehousePatrollerDeath" );
    soundscripts\_snd::snd_message( "start_safehouse_guard_01_music" );
    thread safehouseilanaplanningguardsearlykill();
    var_3 notify( "stopIdleLoop" );
    var_3 maps\_anim::anim_single_solo( var_4, var_2 );

    if ( !common_scripts\utility::flag( "FlagSafehousePlanningGuardRightKilled" ) && !common_scripts\utility::flag( "FlagSafehousePlanningGuardLeftKilled" ) )
    {
        var_3 thread maps\_anim::anim_loop_solo( var_4, "safehouse_enter_idle", "stopEnterIdleLoop" );
        level notify( "SafehouseIlanaStartedPlanningGuardsIdle" );
        common_scripts\utility::flag_wait_either( "FlagSafehousePlanningGuardRightKilled", "FlagSafehousePlanningGuardLeftKilled" );
        thread safehouseilanastairway();
    }
}

safehouseilanaplanningguardsearlykill()
{
    level endon( "SafehouseIlanaStartedPlanningGuardsIdle" );
    var_0 = maps\_utility::get_living_ai( "PlanningGuard_left", "script_noteworthy" );
    var_1 = maps\_utility::get_living_ai( "PlanningGuard_right", "script_noteworthy" );
    common_scripts\utility::flag_wait_any( "FlagSafehousePlanningGuardRightKilled", "FlagSafehousePlanningGuardLeftKilled" );
    level.allies["Ilona"] maps\_utility::anim_stopanimscripted();
    waitframe();
    thread maps\_hms_utility::allyredirectgotonode( "Ilona", "IlanaSafehouseSecondRoomWait" );

    if ( common_scripts\utility::flag( "FlagSafehousePlanningGuardRightKilled" ) )
        level.allies["Ilona"] maps\greece_code::shootguy( var_0, 1, 1 );
    else if ( common_scripts\utility::flag( "FlagSafehousePlanningGuardLeftKilled" ) )
        level.allies["Ilona"] maps\greece_code::shootguy( var_1, 1, 1 );

    common_scripts\utility::flag_wait( "FlagFirstFloorSafehouseKVAkilled" );
    thread safehouseilanastairway();
}

safehouseplayermovespeedscale1stfloor()
{
    common_scripts\utility::flag_wait( "FlagTriggerPlayerEnterFirstRoom" );
    var_0 = maps\_utility::get_living_ai( "KVAsafehousePatroller_AI", "targetname" );

    if ( isdefined( var_0 ) && isalive( var_0 ) )
    {
        level.player notify( "CancelMoveSpeedScale" );
        waitframe();
        level.player thread playerrubberbandmovespeedscale( var_0, 0.3, 1.0, 100, 600 );
    }

    common_scripts\utility::flag_wait( "FlagKVASafehousePatrollerDeath" );
    var_1 = getent( "FirstFloorSpeedScaleOrg", "targetname" );
    level.player notify( "CancelMoveSpeedScale" );
    waitframe();
    level.player thread playerrubberbandmovespeedscale( var_1, 0.3, 1.0, 150, 900 );
    common_scripts\utility::flag_wait( "FlagSafehouseIlanaAtStairs" );
    level.player notify( "CancelMoveSpeedScale" );
    waitframe();
    level.player thread playerrubberbandmovespeedscale( level.allies["Ilona"], 0.3, 1.0, 50, 300 );
}

safehouseplayermovespeedscale2ndfloor()
{
    common_scripts\utility::flag_wait( "FlagTriggerSafehousePlayerPastCouch" );
    var_0 = getent( "SecondFloorSpeedScaleOrg", "targetname" );
    level.player notify( "CancelMoveSpeedScale" );
    waitframe();
    level.player thread playerrubberbandmovespeedscale( var_0, 0.3, 1.0, 150, 900 );
}

safehousedoorplayerblocker()
{
    var_0 = getent( "SafehouseDoorPlayerBlocker", "targetname" );
    level waittill( "SafehousePlayerBlockerDelete" );

    if ( isdefined( var_0 ) )
    {
        var_0 notsolid();
        var_0 delete();
    }
}

safehouseremovethreatgrenade( var_0 )
{

}

safehouseforceopensafehousedoor()
{
    var_0 = "keycard_door_open";
    var_1 = getent( "safehouse_door", "targetname" );
    var_2 = getent( "safehouse_door_collision", "targetname" );
    var_1 setanim( var_1 maps\_utility::getanim( var_0 ) );
    var_1 safehousedoorsetlocked( 0 );
    var_2 connectpaths();
}

safehousedoorinit()
{
    var_0 = getent( "safehouse_door", "targetname" );
    var_0.animname = "keycard_door";
    var_0 maps\_utility::assign_animtree( "keycard_door" );
    var_1 = getent( "safehouse_door_collision", "targetname" );
    var_1 linkto( var_0, "jo_door_l" );
    var_1 disconnectpaths();
    var_2 = common_scripts\utility::getstruct( "safehousekill", "targetname" );
    var_2 maps\_anim::anim_first_frame_solo( var_0, "keycard_door_open" );
    var_0 safehousedoorsetlocked( 1 );
}

safehousedoorsetlocked( var_0 )
{
    if ( var_0 )
    {
        self hidepart( "TAG_PANEL_UNLOCKED" );
        self showpart( "TAG_PANEL_LOCKED" );
    }
    else
    {
        self hidepart( "TAG_PANEL_LOCKED" );
        self showpart( "TAG_PANEL_UNLOCKED" );
    }
}

safehousedoorunlockednotetrack( var_0 )
{
    var_1 = getent( "safehouse_door", "targetname" );
    var_1 safehousedoorsetlocked( 0 );
}

safehouseilanaclearsafehouse()
{
    thread safehouseilanaopensafehousedoor();
    common_scripts\utility::flag_wait( "FlagTriggerSpawnSafehouseGuards" );
    thread spawnkvasafehouseguards();
    level.allies["Ilona"] maps\_utility::enable_cqbwalk();
    var_0 = level.allies["Ilona"].grenadeammo;
    level.allies["Ilona"].grenadeammo = 0;
    common_scripts\utility::flag_set( "FlagIlanaEnterSafehouse" );
    common_scripts\utility::flag_wait( "FlagClearSafehouseComplete" );
    thread safehouseilanatransition();
    level.player thread playerchangemode( "full_combat" );
    level.player notify( "CancelMoveSpeedScale" );
    level.allies["Ilona"] maps\_utility::disable_cqbwalk();
    level.allies["Ilona"].ignoreall = 0;
    level.allies["Ilona"].grenadeammo = var_0;
    common_scripts\utility::flag_wait( "FlagTriggerPlayerExitAfterBagdrop" );
}

safehouseilanastairway()
{
    var_0 = level.allies["Ilona"];
    var_1 = getent( "safehouse_pillow", "targetname" );
    var_1.animname = "safehouse_pillow";
    var_1 maps\_utility::assign_animtree( "safehouse_pillow" );
    var_1 show();
    var_2 = common_scripts\utility::getstruct( "safehousekill", "targetname" );
    thread safehouseplayermovespeedscale2ndfloor();

    if ( common_scripts\utility::flag( "FlagFirstFloorSafehouseKVAkilled" ) )
    {
        var_2 maps\_anim::anim_reach_solo( var_0, "safehouse_enter2_alt" );
        common_scripts\utility::flag_set( "FlagSafehouseIlanaAtStairs" );
        var_2 thread maps\_anim::anim_single_solo( var_1, "safehouse_enter2_alt" );
        var_2 maps\_anim::anim_single_solo( var_0, "safehouse_enter2_alt" );
    }
    else
    {
        common_scripts\utility::flag_set( "FlagSafehouseIlanaAtStairs" );
        var_2 notify( "stopEnterIdleLoop" );
        var_2 thread maps\_anim::anim_single_solo( var_1, "safehouse_enter2" );
        var_2 maps\_anim::anim_single_solo( var_0, "safehouse_enter2" );
    }

    safehousesleepingguardanimcheck( var_2 );
    var_2 thread maps\_anim::anim_loop_solo( var_0, "safehouse_enter2_idle", "StopIlanaEnter2Idle" );
    common_scripts\utility::flag_wait( "FlagPacingNpcDeath" );
    var_2 notify( "StopIlanaEnter2Idle" );
    var_2 maps\_anim::anim_single_solo( var_0, "safehouse_enter3" );

    if ( !common_scripts\utility::flag( "FlagPlayerUsedSafehouseComputer" ) )
        var_2 thread maps\_anim::anim_loop_solo( var_0, "safehouse_enter3_idle", "StopIlanaEnter3Idle" );
}

safehouseilanabagdropwait()
{
    common_scripts\utility::flag_wait( "FlagSafeHouseTransitionStart" );
    var_0 = level.allies["Ilona"];
    var_1 = common_scripts\utility::getstruct( "safehousekill", "targetname" );
    var_1 maps\_anim::anim_single_solo( var_0, "safehouse_enter3" );

    if ( !common_scripts\utility::flag( "FlagComputerInteractComplete" ) )
        var_1 thread maps\_anim::anim_loop_solo( var_0, "safehouse_enter3_idle", "StopIlanaEnter3Idle" );
}

safehouseilanaexitstairs()
{
    var_0 = getent( "IlanaStairsAnimOrg", "targetname" );
    var_1 = level.allies["Ilona"];
    var_0 maps\_anim::anim_reach_solo( var_1, "exit_stairs" );
    var_0 maps\_anim::anim_single_solo( var_1, "exit_stairs" );
    var_0 thread maps\_anim::anim_loop_solo( var_1, "exit_1stfloor_idle", "stop_1stfloor_idle" );
    common_scripts\utility::flag_wait( "FlagTriggerExitPlayerComingDownStairs" );
    level notify( "SafehousePlayerBlockerDelete" );
    var_0 notify( "stop_1stfloor_idle" );
    var_0 maps\_anim::anim_single_solo( var_1, "exit_1stfloor_all" );
    thread maps\_hms_utility::allyredirectgotonode( "Ilona", "IlanaSafehouseExitDoorwayWait" );
}

safehouseilanasonicexocheck( var_0 )
{
    level waittill( "SonicAoEStarted" );
    var_0 notify( "stop_arch_idle" );
    common_scripts\utility::flag_set( "SonicIntroCheckActivated" );
}

safehouseilanatransition()
{
    var_0 = getent( "IlanaTransitionAnimOrg", "targetname" );
    var_1 = "room3_transition_out";
    var_2 = level.allies["Ilona"];

    if ( common_scripts\utility::flag( "FlagSafehouseIlanaTransitionIdleStarted" ) )
    {
        var_0 notify( "stopIdleLoop" );
        var_0 maps\_anim::anim_single_solo( var_2, var_1 );
    }
}

safehouseremoveplayerblocker()
{
    var_0 = getent( "SafehouseHorribleCatchKillPlayerBlocker", "targetname" );
    var_0 movez( -128, 0.1 );
    var_0 delete();
}

safehouseplanningguards()
{
    thread safehouseplanningguard( "right" );
    thread safehouseplanningguard( "left" );
    thread safehouseilanasetupteamkill();
}

safehouseplanningguard( var_0, var_1 )
{
    if ( var_0 == "left" )
        var_2 = "right";
    else
        var_2 = "left";

    var_3 = "plan_idle";
    var_4 = "StopPlanningIdle_" + var_0;
    var_5 = getent( "SafehousePlanningOrg", "targetname" );
    var_6 = maps\_utility::get_living_ai( "PlanningGuard_" + var_0, "script_noteworthy" );
    var_6.animname = "planner_" + var_0;
    var_6.default_health = var_6.health;
    var_6.health = 100000;
    var_6.fail_success_allowed = 1;
    var_6.allowdeath = 1;
    var_6.script_parameters = "planner_" + var_0;
    var_6.fovcosine = cos( 45 );
    var_6.grenadeawareness = 0;
    var_6.ragdoll_immediate = 1;
    var_6.diequietly = 1;
    var_6 maps\_utility::forceuseweapon( "iw5_kf5_sp_silencer01", "primary" );
    waitframe();
    var_6 maps\_utility::gun_remove();
    var_6 endon( "plan_anims_done" );
    var_5 thread maps\_anim::anim_loop_solo( var_6, var_3, var_4 );

    if ( var_0 == "right" )
        var_6 thread safehouseplanningguardsweapons( "SafehousePlanningGuardRightPlanFail" );
    else
        var_6 thread safehouseplanningguardsweapons( "SafehousePlanningGuardLeftPlanFail" );

    thread safehouseplanningguardfailwatch( var_5, var_6, var_0, var_2 );
    var_6 maps\_utility::set_ignoreall( 1 );
    common_scripts\utility::flag_wait( "FlagTriggerPlayerEnterSafehouse2" );
    var_6 maps\_utility::set_ignoreall( 0 );
    var_6 waittill( "damage", var_7, var_8, var_9, var_10, var_11 );

    if ( isdefined( var_8 ) && var_8 == level.player )
        var_6 maps\greece_code::giveplayerchallengekillpoint();

    common_scripts\utility::flag_set( var_6.script_deathflag );
    var_6 setthreatdetection( "disable" );
    var_6 notify( "fail_watch_end" );
    var_5 notify( var_4 );
    var_5 notify( "fail_" + var_2 );
    var_9 *= -1;
    var_12 = vectordot( ( 1, 0, 0 ), var_9 );
    var_3 = "plan_success";

    if ( var_0 == "left" )
    {
        if ( var_12 <= 0.15 && var_12 >= -0.15 )
            var_3 = "plan_success_alt2";
        else if ( var_12 <= -0.15 )
            var_3 = "plan_success_alt";
    }
    else if ( var_12 >= 0 )
        var_3 = "plan_success_alt";

    var_5 maps\_anim::anim_single_solo( var_6, var_3 );
    var_6 maps\greece_code::kill_no_react();
}

safehouseplanningguardsweapons( var_0 )
{
    wait 1;
    var_1 = spawn( "script_model", self.origin );
    var_1 setmodel( "npc_kf5_base_loot" );
    var_1.origin = self gettagorigin( "tag_weapon_right" );
    var_1.angles = self gettagangles( "tag_weapon_right" );
    level waittill( var_0 );
    maps\_utility::gun_recall();
    var_1 delete();
}

safehouseplanningguardfailendnotetrack( var_0 )
{
    var_0.fail_success_allowed = 0;
    var_0.health = var_0.default_health;
    var_0.allowdeath = 1;
}

safehouseplanningguardfailwatch( var_0, var_1, var_2, var_3 )
{
    var_1 endon( "fail_watch_end" );
    var_4 = "plan_fail";
    var_5 = "StopPlanningIdle_" + var_2;
    var_6 = "fail_" + var_2;
    var_7 = "fail_" + var_3;
    var_1 thread safehouseguardsightwatch( var_0, var_6 );
    var_1 thread safehouseguardalertwatch( var_0, var_6, var_7 );
    var_1 thread safehouseguardtriggerwatch( "TriggerSafehouseForceAlertPlanningGuards", var_0, var_6, 0 );
    var_1 thread safehouseguardtriggerwatch( "TriggerSafehouseAlertPlanningGuards", var_0, var_6, 1 );
    var_1 maps\_utility::disable_surprise();
    var_0 waittill( var_6 );
    var_0 notify( var_5 );
    var_1.planning_fail = 1;
    var_1.health = var_1.default_health;
    var_1.allowdeath = 1;
    level notify( "SafehousePlanningGuardsAlerted" );
    common_scripts\utility::flag_set( "FlagSafehousePlanningGuardsAlerted" );
    var_0 maps\_anim::anim_single_solo( var_1, var_4 );
    var_1.ignoreall = 0;
    var_1 maps\_utility::disable_dontevershoot();
    var_1 notify( "plan_anims_done" );

    for (;;)
    {
        level endon( "SafehousePlanningGuardsKilled" );
        thread maps\greece_safehouse_vo::safehousefailkvaalerted();
        wait 1;
        common_scripts\utility::flag_set( "FlagSafehouseHideHint" );
        maps\_hms_utility::printlnscreenandconsole( "MISSION FAIL - KVA ALERTED!!!" );
        setdvar( "ui_deadquote", &"GREECE_DRONE_ALERT_FAIL" );
        maps\_utility::missionfailedwrapper();
    }
}

safehouseguardalertwatch( var_0, var_1, var_2 )
{
    self endon( "fail_watch_end" );
    self endon( "death" );
    common_scripts\utility::waittill_any( "bulletwhizby", "gunshot", "silenced_shot", "projectile_impact" );
    var_0 notify( var_1 );

    if ( isdefined( var_2 ) )
        var_0 notify( var_2 );
}

safehouseguardsightwatch( var_0, var_1 )
{
    self endon( "fail_watch_end" );
    self endon( "death" );

    for (;;)
    {
        if ( self cansee( level.player ) )
            break;

        waitframe();
    }

    var_0 notify( var_1 );
}

safehouseguardtriggerwatch( var_0, var_1, var_2, var_3 )
{
    self endon( "fail_watch_end" );
    self endon( "death" );
    var_4 = getent( var_0, "targetname" );

    for (;;)
    {
        if ( level.player istouching( var_4 ) )
        {
            if ( var_3 == 1 )
            {
                var_5 = level.player getstance();

                if ( var_5 != "crouch" && var_5 != "prone" )
                    break;
            }
            else
                break;
        }

        waitframe();
    }

    var_1 notify( var_2 );
}

safehousepacingguardtriggerwatch( var_0 )
{
    self endon( "fail_watch_end" );
    self endon( "death" );
    var_1 = getent( "TriggerSafehouseAlertPacingGuard", "targetname" );

    for (;;)
    {
        if ( level.player istouching( var_1 ) )
        {
            if ( common_scripts\utility::flag( "FlagSafehouseVideoChatEnded" ) )
            {
                var_2 = level.player getstance();

                if ( var_2 != "crouch" && var_2 != "prone" )
                    break;
            }
            else
                break;
        }

        waitframe();
    }

    var_0 notify( "PacingGuard" );
}

safehouseilanasetupteamkill()
{
    var_0 = maps\_utility::get_living_ai( "PlanningGuard_right", "script_noteworthy" );

    if ( isdefined( var_0 ) )
        var_0 thread maps\greece_code::bloodsprayexitwoundtrace( undefined, undefined, "tag_eye", 1 );

    var_1 = maps\_utility::get_living_ai( "PlanningGuard_left", "script_noteworthy" );

    if ( isdefined( var_1 ) )
        var_1 thread maps\greece_code::bloodsprayexitwoundtrace( undefined, undefined, undefined, 1 );

    thread safehouseplanningguarddeathcheck();
    common_scripts\utility::flag_wait( "FlagIlanaShootPlanningGuard" );

    if ( common_scripts\utility::flag( "FlagFirstFloorSafehouseKVAkilled" ) )
        return;
    else
    {
        var_2 = level.allies["Ilona"] gettagorigin( "TAG_WEAPON" );

        if ( common_scripts\utility::flag( "FlagSafehousePlanningGuardRightKilled" ) )
            magicbullet( "iw5_sn6_sp_silencer01", var_2, var_1 geteye() );
        else
            magicbullet( "iw5_sn6_sp_silencer01", var_2, var_0 geteye() );
    }

    common_scripts\utility::flag_wait_all( "FlagSafehousePlanningGuardRightKilled", "FlagSafehousePlanningGuardLeftKilled" );
    common_scripts\utility::flag_set( "FlagFirstFloorSafehouseKVAkilled" );
    level notify( "SafehousePlanningGuardsKilled" );
    thread maps\_utility::autosave_by_name( "safehouse_first_floor_clear" );
}

safehouseplanningguarddeathcheck()
{
    common_scripts\utility::flag_wait_all( "FlagSafehousePlanningGuardRightKilled", "FlagSafehousePlanningGuardLeftKilled" );
    common_scripts\utility::flag_set( "FlagFirstFloorSafehouseKVAkilled" );
    level notify( "SafehousePlanningGuardsKilled" );
}

safehousemonitorbagdropinteract()
{
    level endon( "SafehouseAlerted" );
    var_0 = getent( "UseTriggerSafehouseComputerInteract", "targetname" );
    var_0 makeusable();
    thread safehousemonitorbagdrophint();
    var_0 maps\_utility::addhinttrigger( &"GREECE_SAFEHOUSE_SUIT_UP", &"GREECE_SAFEHOUSE_SUIT_UP_KB" );
    var_0 waittill( "trigger", var_1 );
    level.player notify( "CancelMoveSpeedScale" );
    var_0 delete();
    common_scripts\utility::flag_set( "FlagPlayerUsedSafehouseComputer" );
}

safehousemonitorbagdrophint()
{
    var_0 = getent( "ComputerInteractObj", "targetname" );
    var_1 = maps\_shg_utility::hint_button_position( "use", var_0.origin, 128 );
    common_scripts\utility::flag_wait_either( "FlagPlayerUsedSafehouseComputer", "FlagSafehouseHideHint" );
    var_1 maps\_shg_utility::hint_button_clear();
}

safehouseilanacheckdeckweapon()
{
    level waittill( "SafehouseIlanaCheckDeckGunPlaced" );
    maps\_utility::gun_remove();
    var_0 = spawn( "script_model", self.origin );
    var_0 setmodel( "npc_titan45_base_loot" );
    var_0 attach( "weapon_silencer_01", "TAG_SILENCER" );
    var_0.origin = self gettagorigin( "tag_weapon_right" );
    var_0.angles = self gettagangles( "tag_weapon_right" );
}

safehousechangeclothes()
{
    var_0 = "bag_drop";
    var_1 = "drone_pre_launch";
    var_2 = "drone_launch";
    var_3 = "drone_post_launch";
    var_4 = [];
    var_5 = [];
    var_6 = [];
    var_7 = common_scripts\utility::getstruct( "BagDropOrg", "targetname" );
    var_8 = common_scripts\utility::getstruct( "BagDropOrg", "targetname" );
    var_9 = level.allies["Ilona"];
    var_5 = common_scripts\utility::array_add( var_5, var_9 );
    var_9 notify( "DeleteIlanaBackpack" );
    var_8 notify( "endCheckDeckIdle" );
    var_10 = maps\_utility::spawn_anim_model( "player_cafe_rig", var_7.origin );
    var_10 hide();
    var_4 = common_scripts\utility::array_add( var_4, var_10 );
    var_11 = maps\_utility::spawn_anim_model( "backpack_drone_large", var_7.origin );
    var_4 = common_scripts\utility::array_add( var_4, var_11 );
    var_12 = maps\_utility::spawn_anim_model( "backpack_drone_small", var_7.origin );
    var_5 = common_scripts\utility::array_add( var_5, var_12 );
    var_9 maps\_utility::gun_remove();
    level.player disableweapons();
    level.player allowcrouch( 0 );
    level.player allowprone( 0 );
    level.player givestartammo( "iw5_titan45_sp_opticsreddot_silencerpistol" );
    var_7 maps\_anim::anim_first_frame( var_4, var_0 );
    level.player playerlinktoblend( var_10, "tag_player", 0.4 );
    wait 0.4;
    var_10 show();
    common_scripts\utility::flag_set( "greece_safehouse_exso_dressup" );
    var_7 thread maps\_anim::anim_single( var_4, var_0 );
    var_8 thread maps\_anim::anim_single( var_5, var_0 );
    var_13 = common_scripts\utility::getstruct( "bagdropimpulse", "targetname" );
    wait 0.72;
    physicsexplosionsphere( var_13.origin, 96, 0, 1.25 );
    var_14 = getent( "greece_safehouse_penholder", "targetname" );
    var_15 = var_14.origin;
    var_16 = var_14.angles;
    var_17 = anglestoforward( var_16 );
    var_18 = anglestoup( var_16 );
    var_14 hide();
    playfx( level._effect["destp_penholder_dyndst"], var_15, var_17, var_18 );
    maps\greece_safehouse_fx::sniperdroneprep();
    soundscripts\_snd::snd_message( "safehouse_exo_trans_fade_out" );
    maps\_hud_util::fade_out( 1.75, "black" );
    var_11 delete();
    var_19 = common_scripts\utility::getstruct( "SafehouseSmallBackpackOrg", "targetname" );
    var_20 = spawn( "script_model", var_19.origin );
    var_20 setmodel( "greece_duffelbag_rigged_empty" );
    var_20.angles = var_19.angles;
    level.allies["Ilona"] stopanimscripted();
    level.allies["Ilona"] delete();
    maps\_hms_utility::spawnandinitnamedally( "Ilona", undefined, 1, 1, "IlanaSafehouseExoSuit" );
    var_9 = level.allies["Ilona"];
    var_9 maps\_utility::gun_remove();
    var_9 character\gfl\character_gfl_an94::main();
    level.player unlink();
    var_10 delete();
    waitframe();
    var_21 = maps\_utility::spawn_anim_model( "player_safehouse_rig", var_7.origin );
    level.player playerlinktoblend( var_21, "tag_player", 0.1 );
    wait 1.25;
    var_22 = common_scripts\utility::getstruct( "BagDropOrg2", "targetname" );
    var_23 = maps\_utility::spawn_anim_model( "sniper_drone", var_7.origin );
    var_6 = common_scripts\utility::array_add( var_6, var_23 );
    var_6 = common_scripts\utility::array_add( var_6, var_9 );
    var_12 delete();
    soundscripts\_snd::snd_message( "start_sniper_drone_deploy" );
    soundscripts\_snd::snd_message( "balcony_sniper_drone_idle", var_23 );
    var_9.disablefacialfilleranims = 0;
    var_22 thread maps\_anim::anim_single_solo( var_21, var_1 );
    var_22 thread maps\_anim::anim_loop( var_6, var_1, "StopDronePrelaunchIdle" );
    soundscripts\_snd::snd_message( "safehouse_exo_trans_fade_in" );
    maps\_hud_util::fade_in( 3, "black" );
    common_scripts\utility::flag_set( "greece_safehouse_exso_dressup_fadeout" );
    var_22 waittill( var_1 );
    common_scripts\utility::flag_set( "FlagConfCenterVOStart" );
    level.player unlink();
    var_21 delete();
    // level.player setviewmodel( "viewhands_atlas_military" );
    level.player giveweapon( "iw5_hmr9_sp_variablereddot" );
    level.player enableweapons();
    level.player allowcrouch( 1 );
    level.player allowprone( 1 );
    common_scripts\utility::flag_wait( "FlagTriggerPlayerExitAfterBagdrop" );
    playfxontag( common_scripts\utility::getfx( "sniper_drone_fan_distortion" ), var_23, "TAG_ORIGIN" );
    maps\greece_safehouse_fx::dronedraftplants();
    maps\greece_safehouse_fx::ambientcloudsloadin();
    var_22 notify( "StopDronePrelaunchIdle" );
    var_6 = common_scripts\utility::array_remove( var_6, var_23 );
    var_23 thread safehousesniperdronelaunch( var_22, var_2 );
    var_23 thread safehousesniperdronecloaking();
    var_22 maps\_anim::anim_single( var_6, var_2 );
    var_22 thread maps\_anim::anim_loop_solo( level.allies["Ilona"], var_3, "StopSniperDroneLaunchIdle" );
    thread safehouseenddronecontrolsetup( var_22, var_9, var_23 );
}

safehousesniperdronelaunch( var_0, var_1 )
{
    var_0 maps\_anim::anim_single_solo( self, var_1 );

    if ( level.currentgen )
        self delete();
}

safehousesniperdronecloaking()
{
    level waittill( "SafehouseDroneStartCloak" );
    soundscripts\_snd::snd_message( "wasp_cloak_on" );
    self setmodel( "vehicle_sniper_drone_cloak" );
    self drawpostresolve();
    self setmaterialscriptparam( 1.0, 0.05 );
    wait 0.05;
    self setmaterialscriptparam( 0.0, 3 );
}

safehouseenddronecontrolsetup( var_0, var_1, var_2 )
{
    common_scripts\utility::flag_wait( "FlagPlayerEndDroneControl" );
    var_0 notify( "StopSniperDroneLaunchIdle" );
    var_1 stopanimscripted();
    var_1.disablefacialfilleranims = 0;
    thread maps\_hms_utility::allyredirectgotonode( "Ilona", "IlanaSafehouseExitBalconyWait" );

    if ( isdefined( var_2 ) )
        var_2 delete();
}

safehousesetupsniperdroneilana()
{
    var_0 = "drone_post_launch";
    var_1 = [];
    var_2 = common_scripts\utility::getstruct( "BagDropOrg2", "targetname" );
    var_3 = level.allies["Ilona"];
    var_4 = maps\_utility::spawn_anim_model( "sniper_drone", var_2.origin );
    var_4 thread safehousesniperdronecloaking();
    var_1 = common_scripts\utility::array_add( var_1, var_4 );
    var_1 = common_scripts\utility::array_add( var_1, var_3 );
    var_2 thread maps\_anim::anim_loop( var_1, var_0, "StopSniperDroneLaunchIdle" );
    thread safehouseenddronecontrolsetup( var_2, var_3, var_4 );
    wait 2;
    level notify( "SafehouseDroneStartCloak" );
}

safehousebeginexit()
{
    common_scripts\utility::flag_wait( "FlagSafeHouseOutroStart" );
    maps\_utility::lerp_fov_overtime( 0.5, 65 );
    thread safehousespawnwindowshooters();
    thread safehousespawnbackalleykva();
    thread safehousespawnbackalleyrooftopkva();
    thread safehouseilanasafehouseexit();
    thread safehouseexitautosaves();
    thread maps\greece_code::sunflareswap( "sunflare_dim" );
    thread safehousedoorplayerblocker();
    safehousetoggleexitflagtriggers( 1 );
    maps\_utility::battlechatter_on( "allies" );
    maps\_utility::battlechatter_on( "axis" );
}

adsmonitor()
{
    for (;;)
    {
        if ( level.player adsbuttonpressed() )
            iprintln( "ADS" );

        wait 1;
    }
}

safehouseexitautosaves()
{
    common_scripts\utility::flag_wait( "FlagSafehouseExitKVADead" );
    wait 1;
    thread maps\_utility::autosave_now();
    common_scripts\utility::flag_wait_all( "FlagSafehouseStairKVADead", "FlagKickSafehouseExitGate" );
    wait 1;
    thread maps\_utility::autosave_now();
}

safehouseilanasafehouseexit()
{
    thread safehouseexit2floor();
    thread maps\_hms_utility::allyredirectgotonode( "Ilona", "IlanaSafehouseExitSecondFloorDoorwayWait" );
    common_scripts\utility::flag_wait( "FlagTriggerExitPlayerComingBackInside" );
    safehouseilanaexitstairs();
    common_scripts\utility::flag_wait( "FlagTriggerExitPlayerComingDownStairs" );
    common_scripts\utility::flag_wait_either( "FlagSpawnStairKVA", "FlagSafehouseExitKVADead" );
    thread maps\_hms_utility::allyredirectgotonode( "Ilona", "IlanaSafehouseExitOutsideWait" );
    level.player playerchangemode( "full_combat" );
    level.player notify( "CancelMoveSpeedScale" );
    common_scripts\utility::flag_wait_either( "FlagSpawnGateExitKVA", "FlagSafehouseStairKVADead" );
    thread maps\_hms_utility::allyredirectgotonode( "Ilona", "IlanaSafehouseExitAlleyWait" );
}

setflagaftertime( var_0, var_1 )
{
    wait(var_1);
    common_scripts\utility::flag_set( var_0 );
}

safehouseexit2floor()
{
    var_0 = common_scripts\utility::getstruct( "BagDropOrg2", "targetname" );
    var_1 = "exit_2floor";
    var_2 = level.allies["Ilona"];
    var_2.disablefacialfilleranims = 1;
    thread safehouseexit2floorviewmodel();
    var_0 thread maps\_anim::anim_first_frame_solo( var_2, var_1 );
    wait 0.65;
    var_0 thread maps\_anim::anim_single_solo_run( var_2, var_1 );
    level waittill( "NotifyIlonaExitGunShow" );
    var_2 maps\_utility::gun_recall();
    var_2.disablefacialfilleranims = 0;
}

safehouseexit2floorviewmodel()
{
    var_0 = common_scripts\utility::getstruct( "BagDropOrg2", "targetname" );
    var_1 = "exit_2floor";
    var_2 = maps\_utility::spawn_anim_model( "player_safehouse_rig" );
    var_3 = maps\_utility::spawn_anim_model( "drone_control_pad" );
    var_4 = [ var_2, var_3 ];
    level.player maps\_shg_utility::setup_player_for_scene( 1 );
    var_0 maps\_anim::anim_first_frame( var_4, var_1 );
    level.player playerlinktoblend( var_2, "tag_player", 0.4 );
    wait 0.4;
    maps\_hud_util::fade_in( 0.25, "white" );
    wait 0.25;
    level.player setblurforplayer( 0, 1.0 );
    var_0 maps\_anim::anim_single( var_4, var_1 );
    level.player unlink();
    var_2 delete();
    var_3 delete();
    level.player giveweapon( "iw5_hmr9_sp_variablereddot" );
    level.player switchtoweaponimmediate( "iw5_hmr9_sp_variablereddot" );
    maps\_variable_grenade::give_player_variable_grenade();

    foreach ( var_6 in level.player getweaponslistoffhands() )
        level.player setweaponammostock( var_6, 4 );

    level.player allowfire( 1 );
    level.player allowads( 1 );
    setsaveddvar( "ammoCounterHide", 0 );
    level.player allowsprint( 0 );
    level.player allowdodge( 0 );
    level.player allowprone( 1 );
    level.player allowcrouch( 1 );
    level.player allowstand( 1 );
    level.player allowjump( 1 );
    level.player enableoffhandweapons();
    level.player enableweapons();
    level.player allowmelee( 1 );
    thread maps\_player_exo::player_exo_activate();
    level.player notify( "CancelMoveSpeedScale" );
    waitframe();
    level.player thread playerrubberbandmovespeedscale( level.allies["Ilona"], 0.5, 1, 100, 300 );
    var_0 waittill( var_1 );
}

ilanaturn2exit()
{
    var_0 = getent( "SafehouseTurn2ExitOrg", "targetname" );
    var_1 = "turn2exit";
    var_2 = level.allies["Ilona"];
    var_0 maps\_anim::anim_reach_solo( var_2, var_1 );
    var_0 maps\_anim::anim_single_solo_run( var_2, var_1 );
    thread maps\_hms_utility::allyredirectgotonode( "Ilona", "IlanaSafehouseExitDoorwayWait" );
}

hintsafehouseexitsonicoff()
{
    return common_scripts\utility::flag( "FlagSonicAoEActivated" );
}

safehousetoggleexitflagtriggers( var_0 )
{
    var_1 = getentarray( "SafehouseExitFlagTrigger", "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( var_0 == 1 )
        {
            var_3 common_scripts\utility::trigger_on();
            continue;
        }

        var_3 common_scripts\utility::trigger_off();
    }
}

safehouseexittogglegates( var_0 )
{
    var_1 = getent( "SafehouseBackyardEntryGate", "targetname" );
    var_1.animname = "safehousegate";
    var_1 maps\_utility::assign_animtree( "safehousegate" );
    var_2 = getent( "SafehouseBackyardEntryGateCollision", "targetname" );
    var_2 linkto( var_1, "jo_gate_door" );

    switch ( var_0 )
    {
        case "open":
            var_1 thread maps\_anim::anim_first_frame_solo( var_1, "market_marketgate_open" );
            common_scripts\utility::flag_wait( "FlagSafehouseCourtyardTakedownComplete" );
            wait 0.5;
            var_1 thread maps\_anim::anim_first_frame_solo( var_1, "market_marketgate_closed" );
            common_scripts\utility::flag_set( "FlagDeleteSafehouseCivilians" );
            break;
        case "closed":
            var_1 thread maps\_anim::anim_first_frame_solo( var_1, "market_marketgate_closed" );
            break;
    }
}

safehousespawnwindowshooters()
{
    common_scripts\utility::flag_wait( "FlagTriggerExitPlayerComingDownStairs" );
    maps\_utility::array_spawn_function_targetname( "SafehouseWindowShooters", ::safehousewindowshooterthink );
    maps\_utility::array_spawn_function_targetname( "SafehouseWindowShooters", ::_initsafehouseexitkvabehavior );
    var_0 = maps\_utility::array_spawn_targetname( "SafehouseWindowShooters" );
    self endon( "CancelMoveSpeedScale" );
    waitframe();
    level.player allowsprint( 1 );
    level.player allowdodge( 1 );
    level.player setmovespeedscale( 1.0 );
}

safehousewindowshooterthink()
{
    self endon( "death" );
    var_0 = "Goal" + self.script_noteworthy;
    var_1 = getent( var_0, "targetname" );
    maps\_utility::set_goal_radius( 32 );
    maps\_utility::set_goal_pos( var_1.origin );
    var_2 = "Org" + self.script_noteworthy;
    var_3 = getent( var_2, "targetname" );
    self setentitytarget( var_3 );
    childthread safehousewindowshootermovetarget( var_3 );
    childthread safehousewindowshutterdestroy();
    childthread safehousewindowshootermonitor();
    common_scripts\utility::flag_wait_either( "FlagWindowShootersBreakOut", "FlagTriggerExitPlayerLeavingBuilding" );
    self clearentitytarget( var_3 );
    waitframe();
    var_4 = getent( "WindowShooterVol", "targetname" );
    self setgoalvolume( var_4 );
    maps\_utility::set_favoriteenemy( level.player );
    var_5 = "Goal" + self.script_noteworthy;
    var_1 = getnode( var_5, "targetname" );
    maps\_utility::set_goal_node( var_1 );
}

safehousewindowshootermovetarget( var_0 )
{
    var_1 = var_0.origin;

    for (;;)
    {
        var_2 = var_1 + ( 0, randomfloatrange( -16, 16 ), randomfloatrange( -8, 8 ) );
        var_0 moveto( var_2, randomfloatrange( 0.5, 2.0 ) );
        wait(randomfloatrange( 0.1, 0.5 ));
    }
}

safehousewindowshutterdestroy()
{
    wait(randomfloatrange( 0.1, 0.3 ));
    thread maps\greece_safehouse_fx::safehousesonicdustfx();
    var_0 = getent( "OrgWindowBlast", "targetname" );
    physicsexplosionsphere( var_0.origin, 200, 200, 1 );
    var_1 = getentarray( "SafehouseWindowShutter", "targetname" );
    maps\_utility::array_delete( var_1 );
}

safehousewindowshootermonitor()
{
    common_scripts\utility::waittill_either( "damage", "death" );
    common_scripts\utility::flag_set( "FlagWindowShootersBreakOut" );
}

safehousespawnbackalleyrooftopkva()
{
    common_scripts\utility::flag_wait( "FlagSpawnRooftopKVA" );
    var_0 = maps\_utility::spawn_targetname( "SafehouseRooftopKVA" );
    var_0 maps\_utility::disable_long_death();
    var_1 = getent( "RooftopKVAGoalVolume", "targetname" );
    var_0 maps\_utility::set_goal_radius( 64 );
    var_0.grenadeammo = 0;
}

safehousespawnbackalleykva()
{
    common_scripts\utility::flag_wait( "FlagSpawnStairKVA" );
    thread _spawntargetnamegotogoal( "SafehouseExitCornerKVA", "SafehouseExitCornerCover" );
    thread _spawntargetnamegotogoal( "SafehouseStairGuard", "StairCover" );
    common_scripts\utility::flag_wait( "FlagSpawnGateExitKVA" );
    thread _spawntargetnamegotogoal( "ExitGateKVA", "ExitGateCover" );
}

_spawntargetnamegotogoal( var_0, var_1 )
{
    var_2 = maps\_utility::spawn_targetname( var_0 );
    var_2 maps\_utility::set_goal_radius( 64 );
    var_3 = getnode( var_1, "targetname" );
    var_2 maps\_utility::set_goal_node( var_3 );
    var_2 thread _initsafehouseexitkvabehavior();
}

_initsafehouseexitkvabehavior()
{
    maps\_utility::disable_surprise();
    maps\_utility::set_ignoresuppression( 1 );
    self.grenadeammo = 0;
    maps\_utility::disable_long_death();
}

safehouseexitplayerjumpwatcher()
{
    level endon( "FlagPlayerJumpWatcherStop" );
    common_scripts\utility::flag_clear( "FlagPlayerJumping" );
    notifyoncommand( "playerjump", "+gostand" );
    notifyoncommand( "playerjump", "+moveup" );

    for (;;)
    {
        level.player waittill( "playerjump" );
        wait 0.1;

        if ( !level.player isonground() )
            common_scripts\utility::flag_set( "FlagPlayerJumping" );

        while ( !level.player isonground() )
            wait 0.05;

        common_scripts\utility::flag_clear( "FlagPlayerJumping" );
    }
}

safehouseexitplayerleaps( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 0.965;

    if ( !isdefined( var_3 ) )
        var_3 = 1;

    if ( !level.player istouching( var_0 ) )
        return 0;

    if ( level.player getstance() != "stand" )
        return 0;

    if ( var_3 && level.player isonground() )
        return 0;

    var_4 = level.player getangles();
    var_4 = ( 0, var_4[1], 0 );
    var_5 = anglestoforward( var_4 );
    var_6 = vectordot( var_5, var_1 );

    if ( var_6 < var_2 )
        return 0;

    var_7 = level.player getvelocity();
    var_8 = distance( ( var_7[0], var_7[1], 0 ), ( 0, 0, 0 ) );

    if ( var_8 < 162 )
        return 0;

    return 1;
}

xslicefade()
{
    maps\_hud_util::start_overlay( "black" );
    wait 0.1;
    maps\_hud_util::fade_in( 1, "black" );
}

cafegeeseflyinganimation()
{
    var_0 = getent( "CafeGooseOrg", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "goose_01" );
    var_2 = maps\_utility::spawn_anim_model( "goose_02" );
    var_3 = maps\_utility::spawn_anim_model( "goose_03" );
    var_4 = [ var_1, var_2, var_3 ];
    wait 2;
    var_0 maps\_anim::anim_single( var_4, "market_intro_geese" );
    maps\_utility::array_delete( var_4 );
}

cafecameraumbrella()
{
    var_0 = common_scripts\utility::getstruct( "mitchel_blocker", "targetname" );
    var_1 = spawn( "script_model", var_0.origin );
    var_1 setmodel( "lag_umbrella_01_b" );
    common_scripts\utility::flag_wait( "FlagSafeHouseFollowStart" );
    var_1 delete();
}
