// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    endingprecache();
    endingflaginit();
    endingglobalvars();
    endingglobalsetup();
    maps\greece_ending_fx::main();
    maps\greece_ending_anim::main();
    maps\greece_ending_vo::main();
}

endingprecache()
{
    maps\_microdronelauncher::init();
    precachemodel( "viewhands_atlas_military" );
    precachemodel( "vb_civilian_mitchell" );
    precachemodel( "viewbody_atlas_military" );
    precachemodel( "greece_finale_truck" );
    // precacheshellshock( "iw5_hmr9_sp" );
    // precacheshellshock( "iw5_hmr9_sp_variablereddot" );
    // precacheshellshock( "iw5_bal27_sp" );
    // precacheshellshock( "iw5_bal27_sp_silencer01_variablereddot" );
    // precacheshellshock( "iw5_sn6_sp" );
    // precacheshellshock( "fraggrenade" );
    // precacheshellshock( "flash_grenade" );
    // precacheshellshock( "iw5_titan45_sp" );
    // precacheshellshock( "iw5_titan45_sp_opticsreddot_silencerpistol" );
    // precacheshellshock( "iw5_arx160_sp" );
    // precacheshellshock( "iw5_uts19_sp" );
    // precacheshellshock( "rpg_player" );
    precacheshader( "fullscreen_lit_bloodsplat_01" );
    precacheshader( "waypoint_threat_tagged" );
    precachemodel( "breach_charge" );
    precachemodel( "breach_charge_obj" );
    precachemodel( "npc_titan45_base_loot" );
    precachemodel( "weapon_parabolic_knife" );
    precachemodel( "npc_mp_tactical_knife" );
    precachemodel( "npc_bal27_nocamo" );
    precachemodel( "kva_leader_head_cut_throat" );
    // precacheshellshock( "greece_finale_car_impact" );
    // precacheshellshock( "greece_finale_car_recovery" );
    // precacheshellshock( "iw5_microdronelauncher_sp" );
    precacherumble( "grenade_rumble" );
    precacherumble( "artillery_rumble" );
    precachestring( &"GREECE_HINT_ENDING_PLACE_CHARGE" );
    precachestring( &"GREECE_HINT_ENDING_PLACE_CHARGE_KB" );
    precachestring( &"GREECE_HINT_ENDING_OPEN_DOOR" );
    precachestring( &"GREECE_HINT_ENDING_OPEN_DOOR_KB" );
    precachestring( &"GREECE_FAIL_ENDING_KILL_HADES" );
    precachestring( &"GREECE_FAIL_ENDING_PLACE_EXPLOSIVE" );
    precachestring( &"GREECE_FAIL_ENDING_LEFT_MISSION" );
    precachestring( &"GREECE_FAIL_ENDING_LATE_TRIGGER" );
    precachestring( &"GREECE_OBJ_SAFEHOUSE_FOLLOW" );
    precachestring( &"GREECE_OBJ_INTERCEPT_HADES" );
    precachestring( &"GREECE_ENDING_AMBUSH_TIMER" );
    precachestring( &"GREECE_OBJ_ENDING_PLACEBREACH" );
    precachestring( &"GREECE_OBJ_ENDING_HADESVEHICLE" );
    maps\_utility::add_hint_string( "leaving_area", &"GREECE_HINT_ENDING_LEAVING_AREA", ::hintleavingareaoff );
    maps\_utility::add_control_based_hint_strings( "detonate_charge", &"GREECE_HINT_ENDING_DETONATE_CHARGE", ::hintdetonateambushoff );
    maps\_utility::add_control_based_hint_strings( "player_stab", &"GREECE_HINT_ENDING_MELEE_HADES", ::hintplayerstaboff );
    maps\_utility::add_control_based_hint_strings( "player_grab_gun", &"GREECE_HINT_ENDING_GRAB_GUN", ::hintgrabgunoff, &"GREECE_HINT_ENDING_GRAB_GUN_KB" );
    precachemodel( "kva_heavy_head" );
    precachemodel( "kva_heavy_body" );
    // precacheshellshock( "iw5_maul_sp" );
    precachemodel( "datachit_greece" );
    maps\_hms_door_interact::precachedooranimations();
}

endingflaginit()
{
    common_scripts\utility::flag_init( "FlagEndingStart" );
    common_scripts\utility::flag_init( "FlagEndingAmbushStart" );
    common_scripts\utility::flag_init( "FlagEndingFightStart" );
    common_scripts\utility::flag_init( "FlagEndingHadesStart" );
    common_scripts\utility::flag_init( "FlagEndingIlanaShootIntoAir" );
    common_scripts\utility::flag_init( "FlagEndingTooFarWarn" );
    common_scripts\utility::flag_init( "FlagEndingTruckExplode" );
    common_scripts\utility::flag_init( "FlagEndingStoreFrontDestruction" );
    common_scripts\utility::flag_init( "FlagEndingSetAmbushInteractBegin" );
    common_scripts\utility::flag_init( "FlagEndingSetAmbushInteractGetToCover" );
    common_scripts\utility::flag_init( "FlagEndingSetAmbushInteractNow" );
    common_scripts\utility::flag_init( "FlagEndingSetAmbushInteractSuccess" );
    common_scripts\utility::flag_init( "FlagEndingSetAmbushInteractFail" );
    common_scripts\utility::flag_init( "FlagEndingSetAmbushInteractComplete" );
    common_scripts\utility::flag_init( "FlagEndingForceShotgunSpawn" );
    common_scripts\utility::flag_init( "FlagEndingSpecialEnemiesDead" );
    common_scripts\utility::flag_init( "FlagGrabGunHintOff" );
    common_scripts\utility::flag_init( "FlagGrabGunSuccess" );
    common_scripts\utility::flag_init( "FlagEndingHadesVehicleInteractBegin" );
    common_scripts\utility::flag_init( "FlagEndingHadesVehicleInteractComplete" );
    common_scripts\utility::flag_init( "FlagEndingHadesStabInteractSuccess" );
    common_scripts\utility::flag_init( "FlagEndingHadesStabInteractFail" );
    common_scripts\utility::flag_init( "FlagEndingSetObjInterceptHades" );
    common_scripts\utility::flag_init( "FlagEndingMarkObjSetAmbush" );
    common_scripts\utility::flag_init( "FlagEndingUnMarkObjSetAmbush" );
    common_scripts\utility::flag_init( "FlagEndingMarkObjHadesVehicle" );
    common_scripts\utility::flag_init( "FlagEndingClearObjInterceptHades" );
    common_scripts\utility::flag_init( "FlagEndingIlanaWaitingAtAmbushPoint" );
    common_scripts\utility::flag_init( "FlagEndingLeavingAreaHintOff" );
}

endingglobalvars()
{
    level.showdebugtoggle = 0;
    level.dialogtable = "sp/greece_dialog.csv";
}

endingglobalsetup()
{
    maps\_utility::battlechatter_on( "allies" );
    maps\_utility::battlechatter_on( "axis" );
    level.endinghades = undefined;
    level.ambushtimer = undefined;
    thread endingbegin();
    thread endingobjectivesetup();
}

endingstartpoints()
{
    maps\_utility::add_start( "start_ending_ambush", ::initendingambush );
    maps\_utility::add_start( "start_ending_fight", ::initendingfight );
    maps\_utility::add_start( "start_ending_hades", ::initendinghades );
    maps\greece_starts::add_greece_starts( "ending" );
}

initendingambush()
{
    maps\_utility::teleport_player( common_scripts\utility::getstruct( "PlayerStartEnding", "targetname" ) );
    maps\_hms_utility::setupplayerinventory( "iw5_titan45_sp_opticsreddot_silencerpistol", "iw5_hmr9_sp_variablereddot", "fraggrenade", "flash_grenade", "iw5_hmr9_sp_variablereddot" );
    maps\_variable_grenade::give_player_variable_grenade();
    thread maps\_player_exo::player_exo_activate();
    thread setupfinalebarrier();
    thread maps\greece_code::sunflareswap( "sunflare_dim" );
    thread endingburningsniper();

    if ( !isdefined( level.map_without_loadout ) || level.map_without_loadout == 0 )
    {
        thread maps\greece_code::blimp_animation( "blimpOrg", "market_intro_blimp" );
        maps\greece_conf_center_fx::confcenterresidualsmoke();
        maps\greece_safehouse_fx::ambientcloudskill();
    }

    thread maps\greece_sniper_scramble_fx::snipertowerresidualfx();
    maps\_hms_utility::spawnandinitnamedally( "Ilona", "AllyStartEnding", 1, 1, "IlanaEnding" );
    thread maps\_hms_utility::allyredirectgotonode( "Ilona", "AllyEndingAmbush1Cover" );
    var_0 = getentarray( "EndingPreCrashTrigger", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 common_scripts\utility::trigger_on();

    var_4 = getentarray( "EndingPostCrashTrigger", "script_noteworthy" );

    foreach ( var_2 in var_4 )
        var_2 common_scripts\utility::trigger_off();

    var_7 = getent( "UseTriggerEndingHadesVehicleInteract", "targetname" );
    var_7 common_scripts\utility::trigger_off();
    common_scripts\utility::flag_set( "FlagEndingStart" );
    soundscripts\_snd::snd_message( "start_ending_ambush_checkpoint" );

    if ( level.currentgen )
        thread maps\greece_sniper_scramble::closeendinggates();
}

initendingfight()
{
    maps\_utility::teleport_player( common_scripts\utility::getstruct( "PlayerStartEndingFight", "targetname" ) );
    maps\_hms_utility::setupplayerinventory( "iw5_titan45_sp_opticsreddot_silencerpistol", "iw5_hmr9_sp_variablereddot", "fraggrenade", "flash_grenade", "iw5_hmr9_sp_variablereddot" );
    maps\_variable_grenade::give_player_variable_grenade();
    thread maps\_player_exo::player_exo_activate();
    thread maps\greece_code::sunflareswap( "sunflare_dim" );

    if ( !isdefined( level.map_without_loadout ) || level.map_without_loadout == 0 )
    {
        thread maps\greece_code::blimp_animation( "blimpOrg", "market_intro_blimp" );
        maps\greece_conf_center_fx::confcenterresidualsmoke();
        maps\greece_safehouse_fx::ambientcloudskill();
    }

    thread maps\greece_sniper_scramble_fx::snipertowerresidualfx();
    thread maps\greece_ending_fx::endingfirehydrantfx();
    thread maps\greece_ending_fx::endingvehicledamageresidualfx();
    maps\_hms_utility::spawnandinitnamedally( "Ilona", "AllyStartEndingFight", 1, 1, "IlanaEnding" );
    thread maps\_hms_utility::allyredirectgotonode( "Ilona", "AllyEndingFightStartCover" );
    var_0 = getentarray( "EndingPreCrashTrigger", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 common_scripts\utility::trigger_off();

    var_4 = getentarray( "EndingPostCrashTrigger", "script_noteworthy" );

    foreach ( var_2 in var_4 )
        var_2 common_scripts\utility::trigger_on();

    thread endingsetupvehicles();
    thread endingstorefrontdestroyedsetup();
    thread fruit_table_impact();
    thread setupfinalebarrier();
    thread spawnendingheli();
    var_7 = getent( "UseTriggerEndingHadesVehicleInteract", "targetname" );
    var_7 common_scripts\utility::trigger_off();
    thread endingcrashglaunchercorpse( undefined, undefined, 0 );
    thread endingfightstart();
    level.allies["Ilona"] thread ilanaendingmovement();
    level notify( "storefront_crash_veh3" );
    common_scripts\utility::flag_set( "FlagEndingFightStart" );
    soundscripts\_snd::snd_message( "start_ending_fight_checkpoint" );
}

initendinghades()
{
    maps\_utility::teleport_player( common_scripts\utility::getstruct( "PlayerStartEndingHades", "targetname" ) );
    maps\_hms_utility::setupplayerinventory( "iw5_titan45_sp_opticsreddot_silencerpistol", "iw5_hmr9_sp_variablereddot", "fraggrenade", "flash_grenade", "iw5_hmr9_sp_variablereddot" );
    maps\_variable_grenade::give_player_variable_grenade();
    thread maps\_player_exo::player_exo_activate();
    thread maps\greece_code::sunflareswap( "sunflare_dim" );

    if ( !isdefined( level.map_without_loadout ) || level.map_without_loadout == 0 )
    {
        thread maps\greece_code::blimp_animation( "blimpOrg", "market_intro_blimp" );
        maps\greece_conf_center_fx::confcenterresidualsmoke();
        maps\greece_safehouse_fx::ambientcloudskill();
    }

    thread maps\greece_sniper_scramble_fx::snipertowerresidualfx();
    thread maps\greece_ending_fx::endingfirehydrantfx();
    thread maps\greece_ending_fx::endingvehicledamageresidualfx();
    maps\_hms_utility::spawnandinitnamedally( "Ilona", "AllyStartEndingHades", 1, 1, "IlanaEnding" );
    thread maps\_hms_utility::allyredirectgotonode( "Ilona", "AllyEndingHadesStartCover" );
    var_0 = getentarray( "EndingPreCrashTrigger", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 common_scripts\utility::trigger_off();

    var_4 = getentarray( "EndingPostCrashTrigger", "script_noteworthy" );

    foreach ( var_2 in var_4 )
        var_2 common_scripts\utility::trigger_off();

    thread endingsetupvehicles();
    thread endingstorefrontdestroyedsetup();
    thread fruit_table_impact();
    thread setupfinalebarrier();
    thread spawnendingheli();
    var_7 = getent( "UseTriggerEndingHadesVehicleInteract", "targetname" );
    var_7 common_scripts\utility::trigger_on();
    level.allies["Ilona"] thread ilanaendingmovement();
    level notify( "storefront_crash_veh3" );
    common_scripts\utility::flag_set( "FlagEndingHadesStart" );
    soundscripts\_snd::snd_message( "start_ending_hades_checkpoint" );
}

endingobjectivesetup()
{
    waittillframeend;
    thread objintercepthades();
    endingsetcompletedobjflags();
}

endingsetcompletedobjflags()
{
    var_0 = level.start_point;

    if ( !common_scripts\utility::string_starts_with( var_0, "start_ending_" ) )
        return;

    common_scripts\utility::flag_set( "FlagEndingSetObjInterceptHades" );

    if ( var_0 == "start_ending_ambush" )
        return;

    common_scripts\utility::flag_set( "FlagEndingMarkObjSetAmbush" );
    common_scripts\utility::flag_set( "FlagEndingUnMarkObjSetAmbush" );

    if ( var_0 == "start_ending_fight" )
        return;

    common_scripts\utility::flag_set( "FlagEndingMarkObjHadesVehicle" );

    if ( var_0 == "start_ending_hades" )
        return;
}

objintercepthades()
{
    common_scripts\utility::flag_wait( "FlagEndingSetObjInterceptHades" );
    var_0 = getent( "EndingPlayerIED", "targetname" );
    var_0 hide();
    objective_add( maps\_utility::obj( "InterceptHades" ), "active", &"GREECE_OBJ_INTERCEPT_HADES", ( 0, 0, 0 ) );
    objective_current( maps\_utility::obj( "InterceptHades" ) );

    while ( !isdefined( level.allies ) )
        waitframe();

    objective_onentity( maps\_utility::obj( "InterceptHades" ), level.allies["Ilona"] );
    objective_setpointertextoverride( maps\_utility::obj( "InterceptHades" ), &"GREECE_OBJ_SAFEHOUSE_FOLLOW" );
    common_scripts\utility::flag_wait( "FlagEndingMarkObjSetAmbush" );
    var_1 = getent( "EndingDetpackObj", "targetname" );
    objective_position( maps\_utility::obj( "InterceptHades" ), var_1.origin );
    objective_setpointertextoverride( maps\_utility::obj( "InterceptHades" ), &"GREECE_OBJ_ENDING_PLACEBREACH" );
    var_0 show();
    var_0 maps\_utility::glow();
    common_scripts\utility::flag_wait( "FlagEndingUnMarkObjSetAmbush" );
    objective_position( maps\_utility::obj( "InterceptHades" ), ( 0, 0, 0 ) );
    var_0 maps\_utility::stopglow();
    var_0 delete();
    common_scripts\utility::flag_wait( "FlagEndingMarkObjHadesVehicle" );
    var_2 = getent( "EndingHadesVehicleObj", "targetname" );
    objective_position( maps\_utility::obj( "InterceptHades" ), var_2.origin );
    objective_setpointertextoverride( maps\_utility::obj( "InterceptHades" ), &"GREECE_OBJ_ENDING_HADESVEHICLE" );
    var_3 = getent( "hades_vehicle", "targetname" );
    var_3 hudoutlineenable( 3, 1, 0 );
    common_scripts\utility::flag_wait( "FlagEndingClearObjInterceptHades" );
    maps\_utility::objective_complete( maps\_utility::obj( "InterceptHades" ) );
    var_3 hudoutlinedisable();
}

endingbegin()
{
    common_scripts\utility::flag_wait_either( "FlagEndingStart", "FlagTriggerEndingStart" );
    common_scripts\utility::flag_set( "FlagEndingAmbushStart" );
    common_scripts\utility::flag_set( "FlagEndingSetObjInterceptHades" );
    level.allies["Ilona"] thread ilanaendingmovement();
    thread endinghideprecrashents();
    thread endingsetupcivilians();
    thread endingsetupvehicles();
    thread endingstorefrontdestroyedsetup();
    thread fruit_table_impact();
    thread setupfinalebarrier();
    thread spawnendingheli();
    thread monitorendingplayerentrancemantle();
    thread monitorendingilanaentrancemantle();

    if ( !isdefined( level.map_without_loadout ) || level.map_without_loadout == 0 )
        thread maps\greece_code::blimp_animation( "blimpOrg", "market_intro_blimp" );
}

monitorendingplayerentrancemantle()
{
    while ( !common_scripts\utility::flag( "FlagTriggerEndingJumpDown" ) )
    {
        if ( level.player ismantling() )
        {
            physicsexplosionsphere( level.player.origin, 200, 0, 0.5 );
            break;
        }

        waitframe();
    }
}

monitorendingilanaentrancemantle()
{
    var_0 = maps\_hms_utility::getnamedally( "Ilona" );
    maps\_utility::trigger_wait_targetname( "EndingIlanaEntranceMantle" );
    physicsexplosionsphere( var_0.origin, 200, 0, 0.5 );
}

endinghideprecrashents()
{
    var_0 = getentarray( "EndingCrashGlauncherPickup", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 hide();
}

endinghidebigfinaleents()
{
    var_0 = getentarray( "EndingCrashGlauncherPickup", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 hide();
}

endingcomplete()
{
    level waittill( "EndingFadeOut" );
    soundscripts\_snd::snd_message( "mhunt_level_end" );
    level.player maps\_hud_util::fade_out( 0.5 );
    wait 2.0;
    maps\_utility::nextmission();
}

failhadesstabplayer( var_0 )
{
    wait(var_0);
    maps\_hms_utility::printlnscreenandconsole( "MISSION FAIL - HADES KILLED PLAYER!!!" );
    setdvar( "ui_deadquote", " " );
    maps\_utility::missionfailedwrapper();
}

ilanaendingmovement()
{
    var_0 = level.start_point;
    waitframe();

    if ( var_0 == "start_ending_fight" )
        thread ilanaendingfight();
    else if ( var_0 == "start_ending_hades" )
        thread ilanaendinghades();
    else
        thread ilanaendingambush();
}

ilanaendingambush()
{
    var_0 = getentarray( "EndingPreCrashTrigger", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 common_scripts\utility::trigger_on();

    var_4 = getentarray( "EndingPostCrashTrigger", "script_noteworthy" );

    foreach ( var_2 in var_4 )
        var_2 common_scripts\utility::trigger_off();

    var_7 = getent( "UseTriggerEndingHadesVehicleInteract", "targetname" );
    var_7 common_scripts\utility::trigger_off();
    endingtruckclip( 0 );
    common_scripts\utility::flag_wait_either( "FlagEndingStart", "FlagTriggerEndingStart" );
    var_8 = common_scripts\utility::getstruct( "EndingIlanaGunfireOrg", "targetname" );
    var_8 maps\_anim::anim_reach_solo( level.allies["Ilona"], "ilana_shoot_into_air" );
    var_8 thread maps\_anim::anim_single_solo( level.allies["Ilona"], "ilana_shoot_into_air" );
    level waittill( "EndingFinaleCivsFlee" );
    common_scripts\utility::flag_set( "FlagEndingIlanaShootIntoAir" );
    thread maps\_hms_utility::allyredirectgotonode( "Ilona", "AllyEndingAmbush1Cover" );
    common_scripts\utility::flag_wait( "FlagEndingSetAmbushInteractGetToCover" );
    thread maps\_hms_utility::allyredirectgotonode( "Ilona", "AllyEndingAmbush2Cover" );
    common_scripts\utility::flag_wait( "FlagEndingFightStart" );
    thread ilanaendingfight();
    endingtruckclip( 1 );
}

ilanaendingfight()
{
    thread endingautosavetacticalthread();
    level.player thread maps\_hms_ai_utility::assistplayer();
    var_0 = maps\_hms_utility::getnamedally( "Ilona" );
    var_1 = getnode( "AllyEndingFightStartCover", "targetname" );
    var_0 thread maps\_hms_ai_utility::gototogoal( var_1, "default", 1 );
    common_scripts\utility::flag_wait_all( "FlagEndingPlayerAdvanceFight1", "FlagEndingTruckExplode" );

    if ( isdefined( var_0.bestcovernode ) )
        var_0.bestcovernode = undefined;

    var_0 thread maps\_hms_ai_utility::playerleashbehavior();
    thread monitorplayerleftlowerpassage();
    common_scripts\utility::flag_wait_all( "FlagEndingEnemiesAllDead", "FlagEndingSpecialEnemiesDead" );
    level notify( "EndingEndAutosaveThread" );
    thread maps\_utility::autosave_by_name();
    var_2 = getnode( "AllyEndingHadesStartCover", "targetname" );
    var_0 maps\_hms_ai_utility::playerleashdisable();
    waitframe();
    var_0 thread maps\_hms_ai_utility::gototogoal( var_2, "cqb", 1 );
    thread ilanaendinghades();
}

ilanaendinghades()
{
    soundscripts\_snd::snd_music_message( "start_finale_streets_fight_end_music" );
}

monitorsetupambushtimer()
{
    level endon( "AmbushTimerFreeze" );
    level endon( "AmbushLeaveMission" );
    var_0 = 20.0;
    level.ambushtimer = maps\_hud_util::get_countdown_hud();
    level.ambushtimer.label = &"GREECE_ENDING_AMBUSH_TIMER";
    level.ambushtimer.x = -110;
    level.ambushtimer.y = 45;
    level.ambushtimer.alignx = "left";
    level.ambushtimer.horzalign = "center";
    level.ambushtimer.color = ( 0.95, 0.95, 1 );
    level.ambushtimer settenthstimer( var_0 );
    level.ambushtimer setpulsefx( 30, 900000, 700 );
    soundscripts\_snd::snd_music_message( "start_finale_ied_setup_music" );
    thread successsetupambushtimer( level.ambushtimer );
    var_1 = common_scripts\utility::waittill_notify_or_timeout_return( "AmbushLeaveMission", var_0 );
    wait 0.1;
    destroysetupambushtimer( level.ambushtimer );
    common_scripts\utility::flag_set( "FlagEndingUnMarkObjSetAmbush" );

    if ( isdefined( var_1 ) && var_1 == "AmbushLeaveMission" )
        return;

    var_2 = getent( "UseTriggerEndingSetupAmbushInteract", "targetname" );
    var_2 makeunusable();
    level notify( "AmbushTimerExpire" );
    maps\_hms_utility::printlnscreenandconsole( "TIMER EXPIRED!!!" );
    thread failsetupambushtimerexpire();
    thread endinghadesconvoyenter();
    thread maps\_hms_utility::allyredirectgotonode( "Ilona", "AllyEndingAmbush2Cover" );
    var_3 = getent( "hades_vehicle", "targetname" );
    level.allies["Ilona"] setentitytarget( var_3 );
}

failsetupambushtimerexpire()
{
    maps\_hms_utility::printlnscreenandconsole( "MISSION FAIL - TIMER EXPIRED!!!" );
    thread maps\_utility::hint_fade();
    wait 1;
    maps\greece_ending_vo::endingfailtimerexpiredialogue();
    wait 0.5;
    setdvar( "ui_deadquote", &"GREECE_FAIL_ENDING_PLACE_EXPLOSIVE" );
    maps\_utility::missionfailedwrapper();
}

failsetupambushleavemission()
{
    maps\_hms_utility::printlnscreenandconsole( "MISSION FAIL - LEFT MISSION AREA!!!" );
    thread maps\_utility::hint_fade();
    destroysetupambushtimer( level.ambushtimer );
    wait 0.1;
    setdvar( "ui_deadquote", &"GREECE_FAIL_ENDING_LEFT_MISSION" );
    maps\_utility::missionfailedwrapper();
}

successsetupambushtimer( var_0 )
{
    level endon( "AmbushTimerExpire" );
    level endon( "AmbushLeaveMission" );
    level waittill( "AmbushTimerFreeze" );
    destroysetupambushtimer( var_0 );
}

destroysetupambushtimer( var_0 )
{
    if ( isdefined( var_0 ) )
        var_0 destroy();
}

monitorleaveareawarning()
{
    var_0 = [];
    var_1 = getent( "TriggerEndingSetupAmbushWarning1", "targetname" );
    var_0 = common_scripts\utility::add_to_array( var_0, var_1 );
    var_2 = getent( "TriggerEndingSetupAmbushWarning2", "targetname" );
    var_0 = common_scripts\utility::add_to_array( var_0, var_2 );
    var_3 = 0;
    maps\greece_code::waittillplayeristouchinganytrigger( var_0 );
    thread maps\_utility::display_hint( "leaving_area" );
    common_scripts\utility::flag_set( "FlagEndingTooFarWarn" );

    while ( !common_scripts\utility::flag( "FlagEndingUnMarkObjSetAmbush" ) )
    {
        waitframe();

        if ( level.player istouching( var_1 ) == 1 || level.player istouching( var_2 ) == 1 )
        {
            if ( var_3 == 1 )
            {
                common_scripts\utility::flag_clear( "FlagEndingLeavingAreaHintOff" );
                waitframe();
                thread maps\_utility::display_hint( "leaving_area" );
                var_3 = 0;
                continue;
            }
            else
                continue;

            continue;
        }

        if ( level.player istouching( var_1 ) == 0 && level.player istouching( var_2 ) == 0 )
        {
            var_3 = 1;
            common_scripts\utility::flag_set( "FlagEndingLeavingAreaHintOff" );
        }
    }

    common_scripts\utility::flag_set( "FlagEndingLeavingAreaHintOff" );
    var_1 common_scripts\utility::trigger_off();
    var_2 common_scripts\utility::trigger_off();
}

hintleavingareaoff()
{
    return common_scripts\utility::flag( "FlagEndingLeavingAreaHintOff" );
}

monitorplaceambushinteract()
{
    level endon( "AmbushTimerExpire" );
    level endon( "AmbushLeaveMission" );
    common_scripts\utility::flag_wait( "FlagTriggerEndingJumpDown" );
    level notify( "audio_stop_restaurant_think" );
    thread monitorleaveareawarning();
    var_0 = getent( "UseTriggerEndingSetupAmbushInteract", "targetname" );
    var_0 makeusable();
    var_0 setcursorhint( "HINT_NOICON" );
    var_0 maps\_utility::addhinttrigger( &"GREECE_HINT_ENDING_PLACE_CHARGE", &"GREECE_HINT_ENDING_PLACE_CHARGE_KB" );
    thread monitorplacebreachhint();
    var_0 waittill( "trigger", var_1 );
    var_0 delete();
    level notify( "AmbushTimerFreeze" );
    thread maps\_player_exo::player_exo_deactivate();
    level.player maps\_shg_utility::setup_player_for_scene( 1 );
    thread maps\_utility::autosave_by_name( "ending_ambush_start" );
    common_scripts\utility::flag_set( "FlagEndingSetAmbushInteractBegin" );
    common_scripts\utility::flag_set( "init_ending_ambush_interact_lighting_level" );
    common_scripts\utility::flag_set( "FlagEndingUnMarkObjSetAmbush" );
    var_2 = common_scripts\utility::getstruct( "EndingPlayerSetAmbushOrg", "targetname" );
    var_3 = maps\_utility::spawn_anim_model( "player_ending_rig", var_2.origin, var_2.angles );
    var_3 hide();
    var_2 maps\_anim::anim_first_frame_solo( var_3, "ied_enter" );
    var_4 = maps\_utility::spawn_anim_model( "ied_device", var_2.origin );
    var_4.animname = "ied_device";
    var_4 maps\_anim::setanimtree();
    var_4 hide();
    var_2 maps\_anim::anim_first_frame_solo( var_4, "ied_enter" );
    var_5 = [ var_3, var_4 ];
    level.player playerlinktoblend( var_3, "tag_player", 0.3 );
    soundscripts\_snd::snd_message( "player_place_ied_foley" );
    wait 0.3;
    var_3 show();
    var_4 show();
    thread monitordetonateambushinteract();
    var_6 = spawn( "script_model", var_3.origin );
    // var_6 setmodel( "kva_leader_head_cut_throat" );
    var_7 = var_3 gettagorigin( "TAG_WEAPON_RIGHT" );
    var_8 = var_3 gettagangles( "TAG_WEAPON_RIGHT" );
    var_6.origin = var_7;
    var_6.angles = var_8;
    var_6 linkto( var_3, "TAG_WEAPON_RIGHT", ( -15, 7, -3 ), ( 0, -20, 180 ) );
    var_2 maps\_anim::anim_single( var_5, "ied_enter" );
    var_6 delete();
    level notify( "EndingAmbushWindowEnd" );

    if ( common_scripts\utility::flag( "FlagEndingSetAmbushInteractSuccess" ) )
        thread successdetonateambushinteract( var_2, var_5, var_4, var_3 );
    else
        thread faildetonateambushinteract( var_2, var_5, var_4, var_3 );
}

monitorplacebreachhint()
{
    var_0 = getent( "EndingDetpackObj", "targetname" );
    var_1 = maps\_shg_utility::hint_button_position( "use", var_0.origin, 128 );
    common_scripts\utility::flag_wait_either( "FlagEndingSetAmbushInteractBegin", "FlagEndingUnMarkObjSetAmbush" );
    var_1 maps\_shg_utility::hint_button_clear();
}

monitordetonateambushinteract()
{
    level waittill( "EndingAmbushGetToCover" );
    common_scripts\utility::flag_set( "FlagEndingSetAmbushInteractGetToCover" );
    level waittill( "EndingAmbushStartConvoy" );
    thread endinghadesconvoyenter();
    level waittill( "EndingAmbushSlowMotion" );
    common_scripts\utility::flag_set( "FlagEndingSetAmbushInteractNow" );
    thread convoydetonateambushinteract();
}

successdetonateambushinteract( var_0, var_1, var_2, var_3 )
{
    var_0 notify( "player_detonate_ied" );
    common_scripts\utility::flag_set( "Init_FlagEndingSetAmbushInteractBeginLighting" );
    thread maps\greece_ending_fx::endingambushbreachexplosionfx();
    var_0 maps\_anim::anim_single( var_1, "ied_success" );
    level.player unlink();
    level.player thread maps\_shg_utility::setup_player_for_gameplay();
    var_2 delete();
    var_3 delete();
    common_scripts\utility::flag_set( "FlagEndingSetAmbushInteractComplete" );
    thread maps\_utility::autosave_by_name( "ending_ambush_end" );
    thread maps\_player_exo::player_exo_activate();
}

faildetonateambushinteract( var_0, var_1, var_2, var_3 )
{
    maps\_hms_utility::printlnscreenandconsole( "MISSION FAIL - CONVOY ESCAPED!!!" );
    var_0 thread maps\_anim::anim_single( var_1, "ied_fail" );
    wait 1;
    maps\greece_ending_vo::endingfailtimerexpiredialogue();
    wait 1;
    setdvar( "ui_deadquote", &"GREECE_FAIL_ENDING_LATE_TRIGGER" );
    maps\_utility::missionfailedwrapper();
}

convoydetonateambushinteract()
{
    var_0 = undefined;
    wait 0.4;
    thread monitordetonateambushsuccess();
    level.hint_nofadein = 1;
    thread maps\_utility::hintdisplayhandler( "detonate_charge" );
    wait 0.25;

    if ( !common_scripts\utility::flag( "FlagEndingSetAmbushInteractSuccess" ) )
    {
        var_0 = 1;
        setslowmotion( 1.0, 0.1, 0.1 );
        wait 0.2;
    }

    thread monitordetonateambushfail();
    var_1 = common_scripts\utility::flag_wait_any_return( "FlagEndingSetAmbushInteractSuccess", "FlagEndingSetAmbushInteractFail" );
    level.hint_nofadein = undefined;

    if ( isdefined( var_0 ) )
    {
        if ( var_1 == "FlagEndingSetAmbushInteractSuccess" )
            setslowmotion( 0.1, 1.0, 0.25 );
        else
            setslowmotion( 0.1, 1.0, 0.25 );
    }
}

hintdetonateambushoff()
{
    if ( common_scripts\utility::flag( "FlagEndingSetAmbushInteractSuccess" ) || common_scripts\utility::flag( "FlagEndingSetAmbushInteractFail" ) )
        return 1;

    return 0;
}

monitordetonateambushsuccess()
{
    level endon( "EndingAmbushWindowEnd" );
    soundscripts\_snd::snd_message( "start_ied_convoy_ambush_expl" );
    thread monitordetonateambushbuttonpress();
    level.player waittill( "detonate_ied" );
    common_scripts\utility::flag_set( "FlagEndingSetAmbushInteractSuccess" );
    level notify( "EndingAmbushWindowEnd" );
    soundscripts\_snd::snd_message( "start_ied_convoy_slomo_end" );
}

monitordetonateambushbuttonpress()
{
    level endon( "EndingAmbushWindowEnd" );

    while ( !common_scripts\utility::flag( "FlagEndingSetAmbushInteractSuccess" ) )
    {
        if ( level.player adsbuttonpressed() || level.player attackbuttonpressed() )
            level.player notify( "detonate_ied" );

        waitframe();
    }
}

monitordetonateambushfail()
{
    level waittill( "EndingAmbushWindowEnd" );
    soundscripts\_snd::snd_message( "stop_ied_convoy_ambush_expl" );

    if ( !common_scripts\utility::flag( "FlagEndingSetAmbushInteractSuccess" ) )
        common_scripts\utility::flag_set( "FlagEndingSetAmbushInteractFail" );
}

endinghadesconvoyenter()
{
    wait 0.1;
    var_0 = getent( "EndingPlayerHadesVehicleOrg", "targetname" );
    var_1 = getent( "hades_vehicle", "targetname" );
    var_2 = getent( "hades_vehicle_clip", "targetname" );
    var_2 linkto( var_1 );
    var_3 = getent( "convoy_vehicle_2", "targetname" );
    var_4 = getent( "convoy_vehicle_2_clip", "targetname" );
    var_4 linkto( var_3 );
    var_5 = getent( "convoy_vehicle_3", "targetname" );
    var_6 = getent( "convoy_vehicle_3_clip", "targetname" );
    var_6 linkto( var_5 );
    var_7 = getent( "convoy_vehicle_4", "targetname" );
    var_8 = getent( "convoy_vehicle_4_clip", "targetname" );
    var_8 linkto( var_7 );
    var_9 = [ var_1, var_3, var_5, var_7 ];
    thread endinghadesconvoyhitplayer();
    var_0 maps\_anim::anim_single( var_9, "convoy_enter" );

    if ( common_scripts\utility::flag( "FlagEndingSetAmbushInteractSuccess" ) )
        thread endinghadesconvoycrash();
    else
        thread endinghadesconvoyfail();
}

endinghadesconvoycrash()
{
    thread endinghadesconvoycrashslomo();
    var_0 = getent( "EndingPlayerHadesVehicleOrg", "targetname" );
    var_1 = getent( "hades_vehicle", "targetname" );
    var_2 = getent( "convoy_vehicle_2", "targetname" );
    var_3 = getent( "convoy_vehicle_3", "targetname" );
    var_4 = [ var_1, var_2, var_3 ];
    thread endingcrashglaunchercorpse( var_0, "convoy_crash", 1 );
    thread maps\greece_ending_fx::endingvehicledamagefx();
    thread maps\greece_ending_fx::endingshopcrashfx();
    thread maps\greece_ending_fx::endingfirehydrantfx();
    common_scripts\utility::flag_set( "FlagEndingStoreFrontDestruction" );
    soundscripts\_snd::snd_message( "convoy_crash_emitters" );

    foreach ( var_6 in var_4 )
        var_6 maps\_utility::anim_stopanimscripted();

    var_0 maps\_anim::anim_single( var_4, "convoy_crash" );
    thread setuphadescrashedvehicle();
    level notify( "EndingDeleteVehicleClip" );
    var_8 = getentarray( "HadesConvoyVehicleVol", "script_noteworthy" );

    foreach ( var_10 in var_8 )
        var_10 delete();
}

endinghadesconvoycrashslomo()
{
    setslowmotion( 1.0, 0.75, 0.5 );
    level waittill( "EndingDeleteVehicleClip" );
    setslowmotion( 0.75, 1.0, 0.5 );
}

endinghadesconvoyfail()
{
    var_0 = getent( "EndingPlayerHadesVehicleOrg", "targetname" );
    thread endingcrashglaunchercorpse( var_0, "convoy_fail", 1 );
    var_1 = getent( "hades_vehicle", "targetname" );
    var_2 = getent( "convoy_vehicle_2", "targetname" );
    var_3 = getent( "convoy_vehicle_3", "targetname" );
    var_4 = [ var_1, var_2, var_3 ];
    var_0 maps\_anim::anim_single( var_4, "convoy_fail" );
}

endinghadesconvoyhitplayer()
{
    level endon( "AmbushTimerFreeze" );
    level endon( "EndingDeleteVehicleClip" );
    var_0 = getentarray( "HadesConvoyVehicleVol", "script_noteworthy" );

    for (;;)
    {
        foreach ( var_2 in var_0 )
        {
            if ( level.player istouching( var_2 ) )
                level.player kill();
        }

        waitframe();
    }
}

endingfightstart()
{
    thread spawnendingenemies();
    var_0 = getentarray( "EndingPostCrashTrigger", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 common_scripts\utility::trigger_on();
}

spawnendingenemies()
{
    if ( level.currentgen )
        thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor( "FlagEndingSpecialEnemiesDead", undefined, 15, 0 );

    soundscripts\_snd::snd_music_message( "start_finale_streets_fight_music" );
    thread spawnendingenemies01();
    thread spawnendingenemies02();
    thread spawnendingenemies03();
    thread spawnendingenemies04();
    thread spawnendingenemies05();
    thread spawnendingenemies06();
    thread spawnendingshotguna();
    thread spawnendingshotgunb();
}

monitorendingenemies( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 1;

    var_3 = var_0.size - var_2;
    maps\_utility::waittill_dead_or_dying( var_0, var_3 );
    common_scripts\utility::flag_set( var_1 );
}

spawnendingenemies01()
{
    var_0 = getent( "EndingPlayerHadesVehicleOrg", "targetname" );
    maps\_utility::array_spawn_function_targetname( "EndingEnemy01", ::endingcombatenemysetup );
    var_1 = maps\_utility::array_spawn_targetname( "EndingEnemy01", 1 );
    thread spawnendingenemies01flood();

    foreach ( var_3 in var_1 )
    {
        if ( var_3.script_noteworthy == "Truck3crawl" )
        {
            var_3 thread maps\greece_ending_fx::stumbleonfirefx();
            var_3 thread endingenemycrawlthread( "payback_pmc_sandstorm_stumble_1", "run_death_flop" );
            continue;
        }

        if ( var_3.script_noteworthy == "Truck3stumble" )
        {
            var_3 thread maps\greece_ending_fx::stumbleonfirefx();
            var_3 thread endingenemystumblethread( "hms_greece_finale_exit_veh3_npc" );
            continue;
        }

        var_3.animname = "veh3_guy2_exit";
        var_3 thread endingenemytruckexitthread( var_0 );
    }

    thread maps\_hms_utility::aiarrayfallbackonflag( var_1, "FlagEndingPlayerAdvanceFight2", "EndingEnemyVolCenter01" );
    thread maps\_hms_utility::aiarraydeleteonflag( var_1, "FlagEndingPlayerAdvanceFight4" );
    var_5 = getent( "convoy_vehicle_3", "targetname" );
    var_0 thread maps\_anim::anim_single_solo( var_5, "enemy_exit" );
}

spawnendingenemies01flood()
{
    maps\_utility::array_spawn_function_targetname( "EndingEnemy01flood", ::endingcombatenemysetup );
    var_0 = getentarray( "EndingEnemy01flood", "targetname" );
    thread maps\_utility::flood_spawn( var_0 );
    thread maps\greece_code::killfloodspawnersonflag( 3001, "FlagEndingPlayerAdvanceFight2" );
    common_scripts\utility::flag_wait_either( "FlagEndingPlayerAdvanceFight3", "FlagTriggerEndingEnemy02Left" );
    var_1 = maps\_utility::get_living_ai_array( "EndingEnemy01flood_AI", "targetname" );
    var_2 = getent( "EndingEnemyVolLowerRight01", "targetname" );

    foreach ( var_4 in var_1 )
        var_4 setgoalvolumeauto( var_2 );

    common_scripts\utility::flag_wait( "FlagEndingPlayerAdvanceFight4" );
    var_1 = maps\_utility::get_living_ai_array( "EndingEnemy01flood_AI", "targetname" );
    var_6 = getent( "EndingEnemyVolCenter03", "targetname" );

    foreach ( var_4 in var_1 )
        var_4 setgoalvolumeauto( var_6 );

    thread maps\_utility::ai_delete_when_out_of_sight( var_1, 256 );
}

spawnendingenemies02()
{
    var_0 = common_scripts\utility::flag_wait_any_return( "FlagTriggerEndingEnemy02Right", "FlagTriggerEndingEnemy02Left" );
    var_1 = getent( "convoy_vehicle_3", "targetname" );
    var_1 notify( "force_explosion" );
    thread spawnendingenemies02flood();
    maps\_utility::array_spawn_function_targetname( "EndingEnemy02", ::endingcombatenemysetup );
    var_2 = maps\_utility::array_spawn_targetname( "EndingEnemy02", 1 );
    var_3 = maps\_utility::get_living_ai_array( "EndingEnemy02Floater", "script_noteworthy" );
    var_4 = [];

    switch ( var_0 )
    {
        case "FlagTriggerEndingEnemy02Right":
            var_4 = common_scripts\utility::getstructarray( "EndingEnemy02TeleportRight", "targetname" );
            break;
        case "FlagTriggerEndingEnemy02Left":
            var_4 = common_scripts\utility::getstructarray( "EndingEnemy02TeleportLeft", "targetname" );
            break;
    }

    endingenemyfloatersteleport( var_3, var_4 );

    switch ( var_0 )
    {
        case "FlagTriggerEndingEnemy02Right":
            thread maps\_hms_utility::aiarrayfallbackonflag( var_2, "FlagEndingPlayerAdvanceFight3", "EndingEnemyVolCenter02" );
            thread maps\_hms_utility::aiarrayfallbackonflag( var_2, "FlagTriggerEndingShotgunALeft", "EndingEnemyVolCenter02" );
            break;
        case "FlagTriggerEndingEnemy02Left":
            thread maps\_hms_utility::aiarrayfallbackonflag( var_2, "FlagEndingPlayerAdvanceFight3", "EndingEnemyVolCenter02" );
            thread maps\_hms_utility::aiarrayfallbackonflag( var_2, "FlagTriggerEndingShotgunARight", "EndingEnemyVolCenter02" );
            break;
    }

    thread maps\_hms_utility::aiarraydeleteonflag( var_2, "FlagEndingPlayerAdvanceFight5" );
}

spawnendingenemies02flood()
{
    maps\_utility::array_spawn_function_targetname( "EndingEnemy02flood", ::endingcombatenemysetup );
    var_0 = getentarray( "EndingEnemy02flood", "targetname" );
    thread maps\_utility::flood_spawn( var_0 );
    thread maps\greece_code::killfloodspawnersonflag( 3002, "FlagEndingPlayerAdvanceFight3" );
    common_scripts\utility::flag_wait( "FlagEndingPlayerAdvanceFight3" );
    wait 1.0;
    var_1 = maps\_utility::get_living_ai_array( "EndingEnemy02flood_AI", "targetname" );
    var_2 = getent( "EndingEnemyVolUpperLeft02", "targetname" );

    foreach ( var_4 in var_1 )
        var_4 setgoalvolumeauto( var_2 );

    common_scripts\utility::flag_wait( "FlagEndingPlayerAdvanceFight4" );
    var_1 = maps\_utility::get_living_ai_array( "EndingEnemy02flood_AI", "targetname" );
    var_6 = getent( "EndingEnemyVolCenter02", "targetname" );

    foreach ( var_4 in var_1 )
        var_4 setgoalvolumeauto( var_6 );

    thread maps\_utility::ai_delete_when_out_of_sight( var_1, 256 );
}

spawnendingenemies03()
{
    common_scripts\utility::flag_wait( "FlagEndingPlayerAdvanceFight2" );
    var_0 = getent( "EndingPlayerHadesVehicleOrg", "targetname" );
    maps\_utility::array_spawn_function_targetname( "EndingEnemy03", ::endingcombatenemysetup );
    var_1 = maps\_utility::array_spawn_targetname( "EndingEnemy03", 1 );

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3.script_noteworthy ) && var_3.script_noteworthy == "Truck2smg" )
        {
            var_3.animname = "veh2_guy_exit";
            var_3 thread endingenemytruckexitthread( var_0 );
        }

        if ( isdefined( var_3.script_noteworthy ) && var_3.script_noteworthy == "EndingUpperLeft" )
            var_3 thread maps\_hms_utility::aifallbackonflag( "FlagEndingPlayerAdvanceFight3", "EndingEnemyVolUpperLeft02" );
    }

    thread maps\_hms_utility::aiarrayfallbackonflag( var_1, "FlagEndingPlayerAdvanceFight4", "EndingEnemyVolCenter03" );
    thread maps\_hms_utility::aiarraydeleteonflag( var_1, "FlagEndingPlayerAdvanceFight6" );
    var_5 = getent( "convoy_vehicle_2", "targetname" );
    var_0 thread maps\_anim::anim_single_solo( var_5, "enemy_exit" );
}

spawnendingenemies04()
{
    var_0 = common_scripts\utility::flag_wait_any_return( "FlagTriggerEndingEnemy04Right", "FlagTriggerEndingEnemy04Left" );
    thread spawnendingenemies04flood();
    maps\_utility::array_spawn_function_targetname( "EndingEnemy04", ::endingcombatenemysetup );
    var_1 = maps\_utility::array_spawn_targetname( "EndingEnemy04", 1 );
    var_2 = maps\_utility::get_living_ai_array( "EndingEnemy04Floater", "script_noteworthy" );
    var_3 = [];

    switch ( var_0 )
    {
        case "FlagTriggerEndingEnemy04Right":
            var_3 = common_scripts\utility::getstructarray( "EndingEnemy04TeleportRight", "targetname" );
            break;
        case "FlagTriggerEndingEnemy04Left":
            var_3 = common_scripts\utility::getstructarray( "EndingEnemy04TeleportLeft", "targetname" );
            break;
    }

    endingenemyfloatersteleport( var_2, var_3 );

    foreach ( var_5 in var_1 )
    {
        if ( isdefined( var_5.script_noteworthy ) )
        {
            if ( var_5.script_noteworthy == "Truck2crawl" )
            {
                var_1 = common_scripts\utility::array_remove( var_1, var_5 );
                var_5 thread endingenemycrawlthread( "civilian_crawl_1", "civilian_crawl_1_death_A" );
                continue;
            }

            if ( var_5.script_noteworthy == "Truck1rpg" )
            {
                var_1 = common_scripts\utility::array_remove( var_1, var_5 );
                var_5 thread endingenemysetupsuperguy();
            }
        }
    }

    thread maps\_hms_utility::aiarrayfallbackonflag( var_1, "FlagEndingPlayerAdvanceFight6", "EndingEnemyVolCenter03" );
}

spawnendingenemies04flood()
{
    maps\_utility::array_spawn_function_targetname( "EndingEnemy04flood", ::endingcombatenemysetup );
    var_0 = getentarray( "EndingEnemy04flood", "targetname" );
    thread maps\_utility::flood_spawn( var_0 );
    thread maps\greece_code::killfloodspawnersonflag( 3004, "FlagEndingPlayerAdvanceFight5" );
    common_scripts\utility::flag_wait( "FlagEndingPlayerAdvanceFight5" );
    wait 1.0;
    var_1 = maps\_utility::get_living_ai_array( "EndingEnemy04flood_AI", "targetname" );
    var_2 = getent( "EndingEnemyVolCenter03", "targetname" );

    foreach ( var_4 in var_1 )
        var_4 setgoalvolumeauto( var_2 );

    thread maps\_utility::ai_delete_when_out_of_sight( var_1, 256 );
}

spawnendingenemies05()
{
    var_0 = common_scripts\utility::flag_wait_any_return( "FlagTriggerEndingEnemy05Right", "FlagTriggerEndingEnemy05Left" );
    maps\_utility::array_spawn_function_targetname( "EndingEnemy05", ::endingcombatenemysetup );
    var_1 = maps\_utility::array_spawn_targetname( "EndingEnemy05", 1 );
    var_2 = maps\_utility::get_living_ai_array( "EndingEnemy05Floater", "script_noteworthy" );
    var_3 = [];

    switch ( var_0 )
    {
        case "FlagTriggerEndingEnemy05Right":
            var_3 = common_scripts\utility::getstructarray( "EndingEnemy05TeleportRight", "targetname" );
            break;
        case "FlagTriggerEndingEnemy05Left":
            var_3 = common_scripts\utility::getstructarray( "EndingEnemy05TeleportLeft", "targetname" );
            break;
    }

    endingenemyfloatersteleport( var_2, var_3 );
    thread maps\_hms_utility::aiarrayfallbackonflag( var_1, "FlagEndingPlayerAdvanceFight6", "EndingEnemyVolCenter03" );
}

spawnendingenemies06()
{
    common_scripts\utility::flag_wait( "FlagEndingPlayerAdvanceFight5" );
    maps\_utility::array_spawn_function_targetname( "EndingEnemy06", ::endingcombatenemysetup );
    var_0 = maps\_utility::array_spawn_targetname( "EndingEnemy06", 1 );
    thread monitorforceshotgunspawn();
}

spawnendingshotguna()
{
    var_0 = common_scripts\utility::flag_wait_any_return( "FlagTriggerEndingShotgunALeft", "FlagTriggerEndingShotgunAMid", "FlagTriggerEndingShotgunARight" );
    maps\_utility::array_spawn_function_targetname( "EndingShotgunA", ::endingcombatenemysetup );
    var_1 = maps\_utility::array_spawn_targetname( "EndingShotgunA", 1 );
    var_2 = maps\_utility::get_living_ai_array( "EndingShotgunAFloater", "script_noteworthy" );
    var_3 = [];

    switch ( var_0 )
    {
        case "FlagTriggerEndingShotgunALeft":
            var_3 = common_scripts\utility::getstructarray( "EndingShotgunATeleportLeft", "targetname" );
            break;
        case "FlagTriggerEndingShotgunAMid":
            var_3 = common_scripts\utility::getstructarray( "EndingShotgunATeleportMid", "targetname" );
            break;
        case "FlagTriggerEndingShotgunARight":
            var_3 = common_scripts\utility::getstructarray( "EndingShotgunATeleportRight", "targetname" );
            break;
    }

    endingenemyshotgunnersteleport( var_2, var_3, "FlagEndingPlayerAdvanceFight3" );
    thread maps\_hms_utility::aiarraydeleteonflag( var_1, "FlagEndingPlayerAdvanceFight6" );
}

spawnendingshotgunb()
{
    var_0 = common_scripts\utility::flag_wait_any_return( "FlagTriggerEndingShotgunBLeft", "FlagTriggerEndingShotgunBMid", "FlagTriggerEndingShotgunBRight", "FlagEndingForceShotgunSpawn" );
    var_1 = "EndingShotgunB";

    if ( var_0 == "FlagEndingForceShotgunSpawn" )
        var_1 = "EndingAltShotgunB";

    maps\_utility::array_spawn_function_targetname( var_1, ::endingcombatenemysetup );
    var_2 = maps\_utility::array_spawn_targetname( var_1, 1 );
    var_3 = maps\_utility::get_living_ai_array( "EndingShotgunBFloater", "script_noteworthy" );
    var_4 = [];

    switch ( var_0 )
    {
        case "FlagTriggerEndingShotgunBLeft":
            var_4 = common_scripts\utility::getstructarray( "EndingShotgunBTeleportLeft", "targetname" );
            break;
        case "FlagTriggerEndingShotgunBMid":
            var_4 = common_scripts\utility::getstructarray( "EndingShotgunBTeleportMid", "targetname" );
            break;
        case "FlagTriggerEndingShotgunBRight":
            var_4 = common_scripts\utility::getstructarray( "EndingShotgunBTeleportRight", "targetname" );
            break;
        case "FlagEndingForceShotgunSpawn":
            var_4 = common_scripts\utility::getstructarray( "EndingShotgunBTeleportAlt", "targetname" );
            break;
    }

    if ( var_0 == "FlagEndingForceShotgunSpawn" )
    {
        foreach ( var_6 in var_2 )
            var_6 thread endingenemysetupsuperguy();
    }
    else
    {
        var_8 = maps\_utility::get_living_ai( "EndingShotgunBNonFloater", "script_noteworthy" );
        var_9 = getnode( "EndingShotgunBCenterGoal", "targetname" );
        var_8 thread maps\_hms_ai_utility::setupshotgunkva( level.player, var_9 );
        var_8 thread shotgunabortdefendgoalonflag( "FlagEndingPlayerAdvanceFight6" );
    }

    endingenemyshotgunnersteleport( var_3, var_4, "FlagEndingPlayerAdvanceFight6" );
    maps\_utility::waittill_dead_or_dying( var_2 );
    common_scripts\utility::flag_set( "FlagEndingSpecialEnemiesDead" );
}

shotgunabortdefendgoalonflag( var_0, var_1, var_2 )
{
    self endon( "death" );

    if ( isdefined( var_1 ) && isdefined( var_2 ) )
        common_scripts\utility::flag_wait_any( var_0, var_1, var_2 );
    else if ( isdefined( var_1 ) )
        common_scripts\utility::flag_wait_either( var_0, var_1 );
    else
        common_scripts\utility::flag_wait( var_0 );

    self notify( "Abort_Defend_Goal" );
}

monitorforceshotgunspawn()
{
    wait 1;
    var_0 = getaiarray( "axis" );
    var_1 = maps\_utility::get_living_ai_array( "EndingCineKVA_AI", "targetname" );
    var_0 = common_scripts\utility::array_remove_array( var_0, var_1 );
    var_0 = maps\_utility::array_removedead_or_dying( var_0 );
    monitorendingenemies( var_0, "FlagEndingForceShotgunSpawn", 1 );
}

endingenemytruckexitthread( var_0 )
{
    self endon( "death" );
    var_0 thread maps\_anim::anim_single_solo_run( self, "enemy_exit" );
    self.allowdeath = 1;
    thread explosiveragdolldeath();
    var_0 waittill( "enemy_exit" );
}

endingenemystumblethread( var_0 )
{
    self endon( "death" );
    self.ignoresonicaoe = 1;
    self.health = 1;
    self.allowdeath = 1;
    thread maps\greece_code::setragdolldeath();
    thread explosiveragdolldeath();
    self.animname = "generic";
    maps\_utility::gun_remove();
    maps\_utility::set_ignoreall( 1 );
    maps\_utility::disable_arrivals();
    maps\_utility::disable_exits();
    var_1 = self.script_noteworthy + "Org";
    var_2 = common_scripts\utility::getstruct( var_1, "script_noteworthy" );
    var_2 maps\_anim::anim_single_solo( self, var_0 );

    if ( isdefined( self ) )
        self kill( self.origin, level.player );
}

endingenemycrawlthread( var_0, var_1 )
{
    self endon( "death" );
    self.iscrawling = 1;
    self.ignoresonicaoe = 1;
    self.health = 1;
    maps\_utility::set_goal_radius( 32 );
    self.allowdeath = 1;
    self.animname = "generic";
    maps\_utility::gun_remove();
    maps\_utility::set_ignoreall( 1 );
    maps\_utility::disable_arrivals();
    maps\_utility::disable_exits();
    maps\_utility::set_deathanim( var_1 );
    maps\_utility::set_run_anim( var_0, 1 );
    var_2 = self.script_noteworthy + "Org";
    var_3 = common_scripts\utility::getstruct( var_2, "script_noteworthy" );
    self forceteleport( var_3.origin, var_3.angles );
    var_4 = self.script_noteworthy + "Goal";
    var_5 = common_scripts\utility::getstruct( var_4, "script_noteworthy" );
    maps\_utility::set_goal_pos( var_5.origin );
    thread monitorenemycrawlplayerdist();
    common_scripts\utility::waittill_either( "goal", "player_near" );
    maps\_anim::anim_single_solo( self, var_1 );

    if ( isdefined( self ) )
        self kill( self.origin, level.player );
}

monitorenemycrawlplayerdist()
{
    self endon( "death" );

    for (;;)
    {
        if ( maps\_utility::players_within_distance( 64.0, self.origin ) )
            self notify( "player_near" );

        wait 0.1;
    }
}

endingenemyfloatersteleport( var_0, var_1 )
{
    var_0 = common_scripts\utility::array_randomize( var_0 );

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        var_3 = var_1[var_2];
        var_0[var_2] forceteleport( var_3.origin, var_3.angles );

        if ( isdefined( var_3.target ) )
        {
            var_4 = var_3.target;
            var_5 = getent( var_4, "targetname" );

            if ( isdefined( var_5 ) )
                var_0[var_2] setgoalvolumeauto( var_5 );
            else
            {
                var_6 = common_scripts\utility::getstruct( var_4, "targetname" );
                var_0[var_2] maps\_utility::set_goal_pos( var_6.origin );
            }
        }
    }
}

endingenemyshotgunnersteleport( var_0, var_1, var_2 )
{
    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
    {
        var_4 = var_1[var_3];
        var_0[var_3] forceteleport( var_4.origin, var_4.angles );

        if ( isdefined( var_4.target ) )
        {
            var_5 = var_4.target;
            var_6 = getnode( var_5, "targetname" );
            var_0[var_3] thread maps\_hms_ai_utility::setupshotgunkva( level.player, var_6 );
            var_0[var_3] thread shotgunabortdefendgoalonflag( var_2 );
        }
    }
}

endingcombatenemysetup()
{
    maps\_utility::disable_surprise();
    maps\_utility::disable_long_death();
    thread explosiveragdolldeath();
    thread explosivedamagemonitor();
}

explosiveragdolldeath()
{
    self.ragdoll_immediate = 1;
    self waittill( "death", var_0, var_1, var_2 );

    if ( !isdefined( self ) )
        return;

    self stopanimscripted();

    if ( isdefined( var_1 ) && var_1 == "MOD_MELEE" || var_1 == "MOD_RIFLE_BULLET" || var_1 == "MOD_PISTOL_BULLET" )
        self.ragdoll_immediate = undefined;
    else
        animscripts\shared::dropallaiweapons();
}

explosivedamagemonitor()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4 );

        if ( var_1 != level.player )
            continue;

        var_5 = 0;

        if ( var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE" || var_4 == "MOD_PROJECTILE" )
            var_5 = var_0 * 1.0;
        else if ( var_4 == "MOD_EXPLOSIVE_SPLASH" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE_SPLASH" )
            var_5 = var_0 * 0.5;

        if ( var_5 > 0 )
            self dodamage( var_5, self.origin, level.player );
    }
}

explosiveimpulse()
{
    self endon( "death" );
    var_0 = 128;

    for (;;)
    {
        self waittill( "missile_fire", var_1, var_2 );

        if ( var_2 == "iw5_microdronelauncher_sp" )
        {
            var_1 waittill( "explode" );
            var_3 = var_1.origin;

            if ( !isdefined( var_3 ) )
                continue;

            earthquake( 0.4, 0.35, var_3, 1024 );
            wait 0.1;
            physicsexplosionsphere( var_3, var_0, 0, randomfloatrange( 2, 3 ) );
        }
    }
}

endingenemysetupsuperguy()
{
    maps\_utility::disable_surprise();
    self.disablebulletwhizbyreaction = 1;
    self.grenadeammo = 0;
    self.health = 1000;
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
    maps\_utility::set_battlechatter( 0 );
    thread maps\_hms_ai_utility::painmanagement();
    thread explosivedamagemonitor();
    thread maps\_hms_ai_utility::_shotgunnerambience();
    self waittill( "death" );

    if ( soundexists( "shotgunner_death_fx" ) )
    {
        var_0 = spawn( "script_origin", self.origin );
        var_0 thread maps\_utility::play_sound_on_entity( "shotgunner_death_fx", "deathsfx_ended" );
        var_0 waittill( "deathsfx_ended" );
        var_0 delete();
    }
}

endingcrashglaunchercorpse( var_0, var_1, var_2 )
{
    var_3 = maps\_utility::spawn_targetname( "EndingEnemyGlauncherCorpse", 1 );
    var_3 maps\_utility::gun_remove();
    var_3.health = 9999999;
    var_3.animname = "generic";
    var_3 maps\_utility::set_ignoreall( 1 );
    var_3 maps\_utility::set_ignoreme( 1 );

    if ( var_2 == 1 )
    {
        var_0 maps\_anim::anim_single_solo( var_3, var_1 );
        var_3 maps\greece_code::kill_no_react( 0 );
    }
    else
        var_3 kill();

    var_4 = getentarray( "EndingCrashGlauncherPickup", "targetname" );

    foreach ( var_6 in var_4 )
    {
        var_6 show();
        var_6 hudoutlineenable( 2 );
        var_6 thread monitorplayerpickupglauncher();
        var_6 thread glaunchericonthink();
    }

    level.player thread explosiveimpulse();
}

monitorplayerpickupglauncher( var_0 )
{
    for (;;)
    {
        if ( level.player hasweapon( "iw5_microdronelauncher_sp" ) )
        {
            self notify( "remove_glauncher_icon" );
            break;
        }

        waitframe();
    }

    level.player givemaxammo( "iw5_microdronelauncher_sp" );
    level.player setweaponammoclip( "iw5_microdronelauncher_sp", weaponclipsize( "iw5_microdronelauncher_sp" ) );
}

glaunchericonthink()
{
    self endon( "remove_glauncher_icon" );
    common_scripts\utility::flag_wait( "FlagEndingFightStart" );
    var_0 = spawn( "trigger_radius", self.origin, 0, 320, 72 );
    var_1 = newhudelem();
    var_1 setshader( "waypoint_threat_tagged", 1, 1 );
    var_1.alpha = 0;
    var_1.color = ( 1, 1, 1 );
    var_1.x = self.origin[0];
    var_1.y = self.origin[1];
    var_1.z = self.origin[2] + 16;
    var_1 setwaypoint( 1, 1 );
    self.glauncher_icon = var_1;
    self.glauncher_icon_trig = var_0;

    if ( isdefined( self.icon_always_show ) && self.icon_always_show )
    {
        glauncher_icon_fade_in( var_1 );
        return;
    }

    wait 0.05;

    while ( isdefined( self ) )
    {
        var_0 waittill( "trigger", var_2 );

        if ( !isplayer( var_2 ) )
            continue;

        while ( var_2 istouching( var_0 ) )
        {
            var_3 = 1;

            if ( level.player hasweapon( "iw5_microdronelauncher_sp" ) )
                var_3 = 0;

            if ( isdefined( self ) && maps\_utility::player_looking_at( self.origin, 0.8, 1 ) && var_3 )
                glauncher_icon_fade_in( var_1 );
            else
                glauncher_icon_fade_out( var_1 );

            wait 0.25;
        }

        glauncher_icon_fade_out( var_1 );
    }
}

glauncher_icon_fade_in( var_0 )
{
    if ( var_0.alpha != 0 )
        return;

    var_0 fadeovertime( 0.2 );
    var_0.alpha = 0.3;
    wait 0.2;
}

glauncher_icon_fade_out( var_0 )
{
    if ( var_0.alpha == 0 )
        return;

    var_0 fadeovertime( 0.2 );
    var_0.alpha = 0;
    wait 0.2;
}

monitorplayerleftlowerpassage()
{
    maps\_utility::trigger_wait_targetname( "EndingLeftLowerVol" );
    thread sendallenemiesintriggertogoalvol( "EndingLeftUpperVol", "EndingEnemyVolCenter03" );
}

sendallenemiesintriggertogoalvol( var_0, var_1 )
{
    var_2 = getaiarray( "axis" );
    var_3 = getent( var_0, "targetname" );
    var_4 = getent( var_1, "targetname" );
    var_5 = [];
    var_2 = maps\_utility::array_removedead_or_dying( var_2 );

    foreach ( var_7 in var_2 )
    {
        if ( isdefined( var_7 ) && var_7 istouching( var_3 ) )
        {
            var_5 = common_scripts\utility::add_to_array( var_5, var_7 );
            var_7 setgoalvolumeauto( var_4 );
            var_7.favoriteenemy = level.player;
        }
    }

    maps\_hms_utility::printlnscreenandconsole( "Sending " + var_5.size + " enemies to volume " + var_1 );
}

endingsetupvehicles()
{
    var_0 = getent( "hades_vehicle", "targetname" );
    var_0 maps\_utility::assign_animtree( "hades_vehicle" );
    var_0.animname = "hades_vehicle";
    var_1 = getent( "enemy_vehicle", "targetname" );
    var_1 maps\_utility::assign_animtree( "enemy_vehicle" );
    var_1.animname = "enemy_vehicle";
    var_2 = getent( "convoy_vehicle_2", "targetname" );
    var_2 maps\_utility::assign_animtree( "convoy_vehicle_2" );
    var_2.animname = "convoy_vehicle_2";
    var_3 = getent( "convoy_vehicle_3", "targetname" );
    var_3 maps\_utility::assign_animtree( "convoy_vehicle_3" );
    var_3.animname = "convoy_vehicle_3";
    thread monitorconvoyvehicle3();
    var_4 = getent( "convoy_vehicle_4", "targetname" );
    var_4 maps\_utility::assign_animtree( "convoy_vehicle_4" );
    var_4.animname = "convoy_vehicle_4";
    var_5 = level.start_point;

    if ( var_5 == "start_ending_fight" || var_5 == "start_ending_hades" )
    {
        thread setuphadescrashedvehicle();
        thread setupconvoycrashedvehicles();
    }
}

setuphadescrashedvehicle()
{
    level.endinghades = maps\_utility::spawn_script_noteworthy( "EndingHades", 1 );
    level.endinghades.animname = "Hades";
    level.endinghades.script_parameters = "Hades";
    level.endinghades.neverdelete = 1;
    level.endinghades setupaiforendinganim( 1 );
    var_0 = getent( "EndingPlayerHadesVehicleOrg", "targetname" );
    var_0 thread maps\_anim::anim_loop_solo( level.endinghades, "start_idle", "stop_loop" );
    var_1 = maps\_utility::spawn_script_noteworthy( "EndingNPC1", 1 );
    var_1.animname = "npc1";
    var_1.neverdelete = 1;
    var_1 setupaiforendinganim( 1 );
    var_0 maps\_anim::anim_first_frame_solo( var_1, "start_idle" );
}

setupconvoycrashedvehicles()
{
    var_0 = getent( "EndingPlayerHadesVehicleOrg", "targetname" );
    var_1 = getent( "convoy_vehicle_2", "targetname" );
    var_2 = getent( "convoy_vehicle_3", "targetname" );
    var_3 = [ var_1, var_2 ];
    var_0 thread maps\_anim::anim_first_frame( var_3, "enemy_exit" );
    var_4 = getent( "convoy_vehicle_4", "targetname" );
    var_0 thread maps\_anim::anim_last_frame_solo( var_4, "convoy_enter" );
    var_5 = getent( "hades_vehicle", "targetname" );
    var_0 maps\_anim::anim_first_frame_solo( var_5, "enemy_exit" );
}

setupfinalebarrier()
{
    var_0 = getent( "EndingPlayerHadesVehicleOrg", "targetname" );
    var_1 = getent( "greece_finale_barrier", "targetname" );
    var_1 maps\_utility::assign_animtree( "finale_barrier" );
    var_1.animname = "finale_barrier";
    var_0 thread maps\_anim::anim_first_frame_solo( var_1, "start_action" );
}

monitorhadesvehicleinteract()
{
    var_0 = getent( "UseTriggerEndingHadesVehicleInteract", "targetname" );
    var_0 common_scripts\utility::trigger_on();
    var_0 makeusable();
    var_0 setcursorhint( "HINT_NOICON" );
    var_0 maps\_utility::addhinttrigger( &"GREECE_HINT_ENDING_OPEN_DOOR", &"GREECE_HINT_ENDING_OPEN_DOOR_KB" );
    thread monitorhadesvehiclehint();
    var_0 waittill( "trigger", var_1 );
    var_0 delete();
    common_scripts\utility::flag_set( "FlagEndingHadesVehicleInteractBegin" );
    common_scripts\utility::flag_set( "FlagEndingClearObjInterceptHades" );
    thread bigfinale();
}

monitorhadesvehiclehint()
{
    var_0 = getent( "EndingHadesVehicleObj", "targetname" );
    var_1 = maps\_shg_utility::hint_button_position( "use", var_0.origin, 128 );
    common_scripts\utility::flag_wait( "FlagEndingHadesVehicleInteractBegin" );
    var_1 maps\_shg_utility::hint_button_clear();
}

bigfinale()
{
    thread maps\_player_exo::player_exo_deactivate();
    level.player maps\_shg_utility::setup_player_for_scene( 1 );
    thread maps\_utility::autosave_by_name( "ending_finale_start" );
    soundscripts\_snd::snd_music_message( "start_finale_hades_extraction_music" );
    maps\_utility::battlechatter_off( "axis" );
    maps\_utility::battlechatter_off( "allies" );
    thread endinghidebigfinaleents();
    level.endinghades setthreatdetection( "disable" );
    var_0 = maps\_utility::get_living_ai( "EndingNPC1", "script_noteworthy" );
    var_0 setthreatdetection( "disable" );
    level notify( "EndingStartBigFinale" );
    var_1 = getent( "EndingPlayerHadesVehicleOrg", "targetname" );
    var_2 = maps\_utility::spawn_anim_model( "player_ending_rig", var_1.origin, var_1.angles );
    var_2 hide();
    var_1 maps\_anim::anim_first_frame_solo( var_2, "start_action" );
    level.player playerlinktoblend( var_2, "tag_player", 0.3 );
    wait 0.3;
    var_2 show();
    var_3 = getent( "hades_vehicle", "targetname" );
    var_4 = getent( "enemy_vehicle", "targetname" );
    var_5 = getent( "greece_finale_barrier", "targetname" );
    var_6 = maps\_hms_utility::getnamedally( "Ilona" );
    var_6 setupaiforendinganim();
    thread setupbigfinaleguys();
    thread setupfinalebarrier();
    thread bigfinaleenemytruckdamagesetup( var_4 );
    var_1 notify( "hades_vehicle_interact" );
    thread maps\greece_ending_fx::endingplayercarpinnedfx();
    thread bigfinaleplayershoot( var_1, var_2 );
    var_7 = [ var_3, var_4, level.endinghades, var_6, var_5 ];
    var_1 maps\_anim::anim_single( var_7, "start_action" );
    level notify( "EndingFinalePlayerHit" );
    soundscripts\_snd::snd_message( "start_finale_suv_damage" );
    thread maps\_utility::autosave_by_name( "ending_finale_player_hit" );
    thread bigfinaleplayerstab();
    thread bigfinaleplayergrabgun( var_1, var_2 );
    var_6 maps\_utility::anim_stopanimscripted();
    var_8 = [ var_4, var_6, level.endinghades ];
    var_1 maps\_anim::anim_single( var_8, "fight_action" );
    level notify( "EndingFinaleStabSlomoEnd" );
    var_9 = [ var_2, var_4, var_6, level.endinghades ];

    if ( common_scripts\utility::flag( "FlagEndingHadesStabInteractSuccess" ) )
        var_1 maps\_anim::anim_single( var_9, "fight_success" );
    else
    {
        var_10 = [ var_4, var_6, level.endinghades ];
        bigfinaleplayerstabfail( var_1, var_10, var_2 );
        return;
    }

    var_11 = maps\_utility::spawn_anim_model( "finale_data" );
    level notify( "EndingFinalePlayerHideKnife" );
    var_12 = [ var_4, var_6, level.endinghades, var_11 ];
    var_1 thread maps\_anim::anim_single_solo( var_2, "end_sequence" );
    thread endingcomplete();
    var_6.disablefacialfilleranims = 1;
    var_1 maps\_anim::anim_single( var_12, "end_sequence" );
}

setupbigfinaleguys()
{
    var_0 = getent( "enemy_vehicle", "targetname" );
    var_1 = var_0 gettagorigin( "TAG_DRIVER" );
    var_2 = var_0 gettagangles( "TAG_DRIVER" );
    var_3 = var_0 gettagorigin( "TAG_PASSENGER" );
    var_4 = var_0 gettagangles( "TAG_PASSENGER" );
    var_5 = ( -3, -8, -44.5 );
    var_6 = maps\_utility::spawn_script_noteworthy( "EndingNPC2", 1 );
    var_6.animname = "npc2";
    var_6.health = 999999999;
    var_6 setupaiforendinganim();
    var_6 linkto( var_0, "TAG_DRIVER", var_5, ( 0, 0, 0 ) );
    var_6 forceteleport( var_1 + var_5, var_2 );
    var_6 maps\_utility::forceuseweapon( "iw5_titan45_sp", "primary" );
    var_6 thread maps\_anim::anim_single_solo( var_6, "veh_idle" );
    var_7 = maps\_utility::spawn_script_noteworthy( "EndingNPC3", 1 );
    var_7.animname = "npc3";
    var_7.health = 999999999;
    var_7 setupaiforendinganim();
    var_7 linkto( var_0, "TAG_PASSENGER", var_5, ( 0, 0, 0 ) );
    var_7 forceteleport( var_3 + var_5, var_4 );
    var_7 thread maps\_anim::anim_single_solo( var_7, "veh_idle" );
    level waittill( "EndingFinalePlayerHit" );
    var_6 thread maps\_anim::anim_single_solo( var_6, "veh_death" );
    var_7 thread maps\_anim::anim_single_solo( var_7, "veh_death" );
}

bigfinaleplayershoot( var_0, var_1 )
{
    var_0 thread maps\_anim::anim_single_solo( var_1, "start_action" );
    level waittill( "EndingFinaleShootSlomoStart" );
    level.player takeallweapons();
    level.player disableweaponswitch();
    level.player playerlinktodelta( var_1, "tag_player", 0, 30, 30, 15, 15, 0, 0 );
    level.player enableslowaim( 0.75, 0.75 );
    level.player enableweapons();
    level.player giveweapon( "iw5_titan45_sp_opticsreddot_silencerpistol" );
    level.player switchtoweaponimmediate( "iw5_titan45_sp_opticsreddot_silencerpistol" );
    soundscripts\_snd::snd_message( "start_hades_suv_extraction" );
    setslowmotion( 1.0, 0.25, 0.25 );
    level waittill( "EndingFinaleShootSlomoEnd" );
    soundscripts\_snd::snd_message( "stop_hades_suv_extraction" );
    setslowmotion( 0.25, 1.0, 0.25 );
    level waittill( "EndingFinalePlayerHit" );
    level.player playerlinktoblend( var_1, "tag_player", 0.0 );
    thread bigfinalehadesknife();
    thread bigfinalehitflash();
    level.player disableweapons();
    level.player takeallweapons();
    level.player shellshock( "greece_finale_car_impact", 0.5 );
    earthquake( 0.65, 0.6, level.player.origin, 128 );
    level.player playrumbleonentity( "damage_heavy" );
    level.player dodamage( level.player.health - 1, ( 0, 0, 0 ) );
    wait 0.5;
    level.player shellshock( "greece_finale_car_recovery", 10.0 );
}

bigfinalehitflash()
{
    var_0 = maps\_hud_util::get_optional_overlay( "white" );
    var_0.alpha = 1;
    wait 0.05;
    maps\_hud_util::fade_in( 0.1, "white" );
}

bigfinaleplayerlosegun( var_0 )
{
    var_1 = spawn( "script_model", var_0.origin );
    var_1 setmodel( "npc_titan45_base_loot" );
    var_2 = var_0 gettagorigin( "TAG_WEAPON_RIGHT" );
    var_3 = var_0 gettagangles( "TAG_WEAPON_RIGHT" );
    var_1.origin = var_2;
    var_1.angles = var_3;
    var_1 linkto( var_0, "TAG_WEAPON_RIGHT" );
    level waittill( "EndingFinaleHidePlayerGun" );
    var_1 delete();
}

bigfinaleilanashoot()
{
    var_0 = maps\_hms_utility::getnamedally( "Ilona" );
    var_1 = getnode( "AllyEndingHadesTruckCover1", "targetname" );
    var_0 thread maps\_hms_ai_utility::gototogoal( var_1, "cqb", 1 );
    level waittill( "EndingIlanaShootTruck" );
    var_2 = getent( "enemy_vehicle", "targetname" );
    var_3 = maps\_utility::get_living_ai( "EndingNPC2", "script_noteworthy" );
    var_0.favoriteenemy = var_3;
    var_0 setentitytarget( var_2 );
    var_0 thread bigfinaleilanamagicshoot( var_3 );
    level waittill( "EndingFinaleVehCrashGate" );
    waitframe();
    var_0.favoriteenemy = undefined;
    var_0 clearentitytarget( var_2 );
    var_4 = getnode( "AllyEndingHadesTruckCover2", "targetname" );
    var_0 thread maps\_hms_ai_utility::gototogoal( var_4, "default", 1 );
}

bigfinaleilanamagicshoot( var_0 )
{
    level endon( "EndingFinaleVehCrashGate" );
    var_1 = self geteye();

    for (;;)
    {
        var_2 = var_0 geteye();
        self shoot();
        wait(randomfloatrange( 0.1, 0.2 ));
    }
}

bigfinaleplayerknife( var_0 )
{
    level waittill( "EndingFinalePlayerShowKnife" );
    var_1 = spawn( "script_model", var_0.origin );
    var_1 setmodel( "npc_mp_tactical_knife" );
    var_2 = var_0 gettagorigin( "TAG_WEAPON_LEFT" );
    var_3 = var_0 gettagangles( "TAG_WEAPON_LEFT" );
    var_1.origin = var_2;
    var_1.angles = var_3;
    var_1 linkto( var_0, "TAG_WEAPON_LEFT" );
    level waittill( "EndingFinalePlayerHideKnife" );
    var_0 notify( "EndingFinaleCheckGun" );
    var_1 delete();
}

bigfinalehadesknife()
{
    var_0 = spawn( "script_model", level.endinghades.origin );
    var_0 setmodel( "npc_mp_tactical_knife" );
    var_1 = level.endinghades gettagorigin( "tag_weapon_right" );
    var_2 = level.endinghades gettagangles( "tag_weapon_right" );
    var_0.origin = var_1;
    var_0.angles = var_2;
    var_0 linkto( level.endinghades, "TAG_WEAPON_RIGHT" );
    level waittill( "EndingFinalePlayerHideKnife" );
    var_0 delete();
}

bigfinaleplayerstab()
{
    var_0 = undefined;
    level waittill( "EndingFinaleStabSlomoStart" );
    level notify( "EndingFinaleHidePlayerGun" );
    thread monitorhadesstabsuccess();
    level.hint_nofadein = 1;
    thread maps\_utility::hintdisplayhandler( "player_stab", undefined, undefined, undefined, undefined, 200 );
    wait 0.25;

    if ( !common_scripts\utility::flag( "FlagEndingHadesStabInteractSuccess" ) )
    {
        var_0 = 1;
        setslowmotion( 1.0, 0.25, 0.25 );
        wait 0.25;
    }

    thread monitorhadesstabfail();
    common_scripts\utility::flag_wait_either( "FlagEndingHadesStabInteractSuccess", "FlagEndingHadesStabInteractFail" );
    level.hint_nofadein = undefined;

    if ( isdefined( var_0 ) )
        setslowmotion( 0.25, 1.0, 0.25 );

    level notify( "EndingFinaleStabSlomoEnd" );
}

hintplayerstaboff()
{
    if ( common_scripts\utility::flag( "FlagEndingHadesStabInteractSuccess" ) || common_scripts\utility::flag( "FlagEndingHadesStabInteractFail" ) )
        return 1;

    return 0;
}

monitorhadesstabsuccess()
{
    level endon( "EndingFinaleStabSlomoEnd" );
    thread monitorhadesstabbuttonpress();
    level.player waittill( "stab_hades" );
    common_scripts\utility::flag_set( "FlagEndingHadesStabInteractSuccess" );
    level notify( "EndingFinaleStabSlomoEnd" );
}

monitorhadesstabbuttonpress()
{
    level endon( "EndingFinaleStabSlomoEnd" );

    while ( !common_scripts\utility::flag( "FlagEndingHadesStabInteractSuccess" ) )
    {
        if ( level.player meleebuttonpressed() || level.player attackbuttonpressed() )
            level.player notify( "stab_hades" );

        waitframe();
    }
}

monitorhadesstabfail()
{
    level waittill( "EndingFinaleStabSlomoEnd" );

    if ( !common_scripts\utility::flag( "FlagEndingHadesStabInteractSuccess" ) )
        common_scripts\utility::flag_set( "FlagEndingHadesStabInteractFail" );
}

bigfinaleplayerstabfail( var_0, var_1, var_2 )
{
    var_3 = getanimlength( var_2 maps\_utility::getanim( "fight_fail" ) ) - 1.5;
    soundscripts\_snd::snd_message( "start_hades_kill_interact_fail" );
    level notify( "failBloodDrips" );
    earthquake( 0.65, 0.6, level.player.origin, 128 );
    level.player playrumbleonentity( "damage_heavy" );
    level.player dodamage( level.player.health - 1, ( 0, 0, 0 ) );
    thread endingfinalebloodsplat( var_3, 0.05, 1, 1 );
    var_0 thread maps\_anim::anim_single_solo( var_2, "fight_fail" );
    thread failhadesstabplayer( var_3 );
    var_0 maps\_anim::anim_single( var_1, "fight_fail" );
}

setupaiforendinganim( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    maps\_utility::set_ignoreall( 1 );
    maps\_utility::set_ignoreme( 1 );
    maps\_utility::set_battlechatter( 0 );
    maps\_utility::disable_surprise();
    maps\_utility::disable_danger_react();
    maps\_utility::disable_pain();
    self.ignoresonicaoe = 1;
    self.name = " ";

    if ( var_0 == 1 )
        thread maps\_utility::deletable_magic_bullet_shield();
}

endingsetupcivilians()
{
    maps\_utility::array_spawn_function_targetname( "EndingCivFlee", ::endingcivfleesetup );
    var_0 = maps\_utility::array_spawn_targetname( "EndingCivFlee", 1 );

    foreach ( var_2 in var_0 )
        var_2 thread endingcivilianflee();
}

endingcivfleesetup()
{
    self pushplayer( 0 );
    maps\_utility::set_ignoreall( 1 );
    maps\_utility::set_ignoreme( 1 );
    self.allowdeath = 1;
    self.allowpain = 0;
}

endingcivilianflee( var_0 )
{
    self endon( "death" );
    self.animname = "generic";
    self.ignoresonicaoe = 1;
    var_1 = self.script_noteworthy + "Org";
    var_2 = common_scripts\utility::getstruct( var_1, "script_noteworthy" );
    var_3 = self.script_noteworthy;
    var_4 = var_3 + "_idle";
    var_5 = var_3 + "_end";
    var_6 = var_3 + "_goal";
    var_7 = common_scripts\utility::getstruct( var_6, "targetname" );

    if ( isdefined( var_4 ) && maps\_utility::hasanim( var_4 ) )
        var_2 thread maps\_anim::anim_loop_solo( self, var_4, var_5 );

    common_scripts\utility::flag_wait_either( "FlagEndingIlanaShootIntoAir", "FlagTriggerEndingJumpDown" );
    waitframe();

    if ( isdefined( self ) )
    {
        if ( isdefined( var_4 ) && maps\_utility::hasanim( var_4 ) )
        {
            self notify( var_5 );
            var_2 notify( var_5 );
            maps\_utility::anim_stopanimscripted();
            var_8 = var_3 + "_react";

            if ( self.script_noteworthy == "EndingCiv05" )
            {
                var_2 maps\_anim::anim_single_solo( self, var_8 );
                self.ignoresonicaoe = undefined;
                maps\_utility::set_goal_pos( self.origin );
                wait(randomfloatrange( 1.0, 3.0 ));
            }
            else
                var_2 maps\_anim::anim_single_solo_run( self, var_8 );
        }
    }

    if ( isdefined( self ) )
    {
        self.ignoresonicaoe = undefined;
        maps\_utility::set_goal_pos( var_7.origin );
    }

    thread maps\_hms_utility::aideleteonflag( "FlagEndingSetAmbushInteractBegin", 256, 0 );
}

delete_on_goal()
{
    self endon( "death" );
    self waittill( "goal" );

    while ( self cansee( level.player ) )
        wait 1;

    self delete();
}

monitorconvoyvehicle3()
{
    var_0 = getent( "convoy_vehicle_3", "targetname" );
    var_0 setcandamage( 1 );
    var_0 setcanradiusdamage( 1 );
    var_0 thread monitorconvoyvehicle3damage();
    var_0 common_scripts\utility::waittill_either( "player_damage", "force_explosion" );
    maps\greece_ending_fx::endingcrashtruckexplosionfx();
}

monitorconvoyvehicle3damage()
{
    self endon( "force_explosion" );

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4 );

        if ( var_1 != level.player )
            continue;

        if ( var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE" || var_4 == "MOD_PROJECTILE" || var_4 == "MOD_EXPLOSIVE_SPLASH" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE_SPLASH" )
            break;
    }

    self notify( "player_damage" );
}

endingstorefrontdestroyedsetup()
{
    var_0 = getentarray( "store_front_clean", "targetname" );
    var_1 = getentarray( "store_front_destroyed", "targetname" );

    foreach ( var_3 in var_1 )
        var_3 hide();

    level waittill( "storefront_crash_veh3" );

    foreach ( var_3 in var_1 )
        var_3 show();

    foreach ( var_3 in var_0 )
        var_3 delete();

    var_9 = getent( "storefront_glass_shatter_org", "targetname" );
    glassradiusdamage( var_9.origin, 300, 100, 0 );
}

fruit_table_impact()
{
    var_0 = getent( "fruit_table_des_org", "targetname" );
    var_1 = getent( "fruit_table_impact_org", "targetname" );
    var_2 = getentarray( "fruit_table_stuff", "targetname" );
    var_3 = anglestoforward( var_0.angles );
    level waittill( "Planter_crash_veh3" );

    foreach ( var_5 in var_2 )
    {
        if ( isdefined( var_5 ) )
            var_5 delete();
    }

    physicsexplosionsphere( var_1.origin, 300, 0, 3 );
    playfx( level._effect["fruit_table_impact_lrg_x"], var_0.origin, var_3 );
}

endingfinalebloodsplat( var_0, var_1, var_2, var_3 )
{
    level endon( "noHealthOverlay" );
    var_4 = newhudelem();
    var_4.x = 0;
    var_4.y = 0;
    var_4 setshader( "fullscreen_lit_bloodsplat_01", 640, 480 );
    var_4.splatter = 1;
    var_4.alignx = "left";
    var_4.aligny = "top";
    var_4.sort = 1;
    var_4.foreground = 0;
    var_4.horzalign = "fullscreen";
    var_4.vertalign = "fullscreen";
    var_4.enablehudlighting = 1;
    var_4.color = ( 0, 0, 0 );
    thread endingfinalebloodremove( var_4 );
    thread endingfinaleblooddrips( var_4 );
    var_5 = 0.0;
    var_6 = 0.05;
    var_7 = 0.3;
    wait(var_6);
    var_8 = 1.0 - level.player.health / level.player.maxhealth;
    var_9 = var_8 * var_8 * 1.2;
    var_9 = clamp( var_9, 0, 1 );

    if ( var_5 > var_9 )
        var_5 -= var_7 * var_6;

    if ( var_5 < var_9 )
        var_5 = var_9;

    var_4.color = ( var_5, 0, 0 );
}

endingfinaleblooddrips( var_0 )
{
    level endon( "noHealthOverlay" );
    level waittill( "failBloodDrips" );
    var_1 = 0;
    var_2 = 0.0;

    for ( var_1 = 0; var_1 < 80; var_1++ )
    {
        var_3 = var_2 / 80.0;
        var_0.color = ( 255.0, var_3, 0 );
        var_2 += 1.0;
        waitframe();
    }
}

endingfinalebloodremove( var_0 )
{
    level waittill( "noHealthOverlay" );
    var_0 destroy();
}

endingtruckclip( var_0 )
{
    var_1 = getentarray( "EndingTruckClip", "targetname" );

    if ( var_0 == 1 )
        var_2 = 1024;
    else
        var_2 = -1024;

    foreach ( var_4 in var_1 )
    {
        var_5 = var_4.origin;
        var_6 = var_5 + ( 0, 0, var_2 );
        var_4 moveto( var_6, 0.1 );
    }
}

bigfinaleplayergrabgun( var_0, var_1 )
{
    thread monitorplayergrabgun();
    var_0 maps\_anim::anim_first_frame_solo( var_1, "fight_action" );
    var_0 maps\_anim::anim_single_solo( var_1, "fight_action" );
    level notify( "EndingFinaleGrabGunWindowEnd" );

    if ( common_scripts\utility::flag( "FlagGrabGunSuccess" ) )
        var_0 maps\_anim::anim_single_solo( var_1, "fight_action_reach" );
    else
        var_0 maps\_anim::anim_single_solo( var_1, "fight_action_noreach" );
}

monitorplayergrabgun()
{
    level waittill( "EndingFinaleGrabGunWindowStart" );
    thread maps\_utility::hintdisplayhandler( "player_grab_gun", undefined, undefined, undefined, undefined, 200 );
    monitorgrabgunbuttonpress();
    common_scripts\utility::flag_set( "FlagGrabGunHintOff" );
}

hintgrabgunoff()
{
    return common_scripts\utility::flag( "FlagGrabGunHintOff" );
}

monitorgrabgunbuttonpress()
{
    level endon( "EndingFinaleGrabGunWindowEnd" );

    while ( !common_scripts\utility::flag( "FlagGrabGunHintOff" ) )
    {
        if ( level.player usebuttonpressed() )
        {
            common_scripts\utility::flag_set( "FlagGrabGunSuccess" );
            break;
        }

        waitframe();
    }
}

spawnendingheli()
{

}

endingtruckfiredamagevol()
{
    level endon( "EndingStartBigFinale" );
    var_0 = getent( "EndingTruckFire", "targetname" );

    for (;;)
    {
        var_0 waittill( "trigger", var_1 );
        var_1 dodamage( 5, var_0.origin, var_0, var_0, "MOD_CRUSH" );
        wait 0.1;
    }
}

endingburningsniper()
{
    var_0 = maps\_utility::spawn_targetname( "EndingBurningSniper", 1 );
    var_0 maps\_utility::gun_remove();
    var_0.animname = "generic";
    var_0 thread maps\greece_sniper_scramble_fx::ragdollonfirefx();
    var_1 = common_scripts\utility::getstruct( "EndingBurningSniperOrg", "targetname" );
    var_2 = "burning_corpse";
    var_1 maps\_anim::anim_single_solo( var_0, var_2 );
    var_0 maps\greece_code::kill_no_react( 0.0 );
    common_scripts\utility::flag_wait( "FlagTriggerEndingJumpDown" );

    if ( isdefined( var_0 ) )
        var_0 delete();
}

bigfinaleenemytruckdamagesetup( var_0 )
{
    var_0 hidepart( "TAG_HOOD_damage1a", "greece_finale_truck" );
    var_0 hidepart( "TAG_HOOD_damage1b", "greece_finale_truck" );
    var_0 hidepart( "TAG_HOOD_damage1c", "greece_finale_truck" );
    var_0 hidepart( "TAG_HOOD_damage2", "greece_finale_truck" );
    var_0 hidepart( "TAG_HOOD_damage3", "greece_finale_truck" );
    var_0 hidepart( "TAG_GLASS_damage1", "greece_finale_truck" );
    var_0 hidepart( "TAG_GRILL_damage1", "greece_finale_truck" );
    var_0 hidepart( "TAG_GRILL_damage2", "greece_finale_truck" );
    level waittill( "show_damage1" );
    var_0 showpart( "TAG_HOOD_damage1a", "greece_finale_truck" );
    var_0 showpart( "TAG_HOOD_damage1b", "greece_finale_truck" );
    var_0 showpart( "TAG_HOOD_damage1c", "greece_finale_truck" );
    var_0 showpart( "TAG_GLASS_damage1", "greece_finale_truck" );
    var_0 showpart( "TAG_GRILL_damage1", "greece_finale_truck" );
    var_0 showpart( "TAG_GRILL_damage2", "greece_finale_truck" );
    var_0 hidepart( "TAG_HOOD_healthy", "greece_finale_truck" );
    var_0 hidepart( "TAG_GLASS_FRONT", "greece_finale_truck" );
    level waittill( "show_damage2" );
    var_0 showpart( "TAG_HOOD_damage2", "greece_finale_truck" );
    var_0 hidepart( "TAG_HOOD_damage1a", "greece_finale_truck" );
    var_0 hidepart( "TAG_HOOD_damage1b", "greece_finale_truck" );
    var_0 hidepart( "TAG_HOOD_damage1c", "greece_finale_truck" );
    level waittill( "show_damage3" );
    var_0 showpart( "TAG_HOOD_damage3", "greece_finale_truck" );
    var_0 hidepart( "TAG_HOOD_damage2", "greece_finale_truck" );
    var_0 hidepart( "left_wheel_01_jnt", "greece_finale_truck" );
}

endingautosavetacticalthread()
{
    level endon( "EndingEndAutosaveThread" );
    var_0 = undefined;

    for (;;)
    {
        if ( isdefined( level.curautosave ) )
            var_0 = level.curautosave;

        waitframe();
        thread maps\_utility::autosave_by_name_silent( "ending_fight_silent" );
        wait 5.0;

        if ( isdefined( var_0 ) )
        {
            if ( var_0 != level.curautosave )
            {
                maps\_hms_utility::printlnscreenandconsole( "*** Autosave success! ***" );
                wait 10;
            }
        }
    }
}
