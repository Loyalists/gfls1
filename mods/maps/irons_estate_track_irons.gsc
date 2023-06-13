// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

track_irons_start()
{
    level.start_point_scripted = "hangar";
    maps\irons_estate::irons_estate_objectives();
    maps\irons_estate_code::spawn_player_checkpoint();
    maps\irons_estate_code::spawn_allies();
    thread handle_doctor();
    soundscripts\_snd::snd_message( "start_track_irons" );
}

track_irons_main()
{
    level.start_point_scripted = "hangar";
    thread track_irons_begin();
    common_scripts\utility::flag_wait( "track_irons_end" );
    stopcinematicingame();
    setsaveddvar( "cg_cinematicCanPause", "0" );
    setsaveddvar( "cg_cinematicFullScreen", "1" );
    thread maps\_utility::autosave_by_name();
}

track_irons_begin()
{
    common_scripts\utility::flag_set( "track_irons_start" );
    level.player.grapple["dist_max"] = 800;

    if ( !isdefined( level.allies[0] ) )
    {
        level.allies[0] = maps\irons_estate_code::spawn_ally( "cormack" );
        level.allies[0].animname = "cormack";
        level.allies[0] thread maps\irons_estate_code::set_helmet_open();
    }

    level.allies[0] maps\_utility::enable_cqbwalk();
    level.allies[0] maps\_utility::set_forcegoal();
    level.allies[0] maps\_utility::set_fixednode_true();
    level.allies[0] maps\_utility::set_ignoreall( 1 );
    level.allies[0] maps\_utility::set_ignoreme( 1 );
    level.allies[0] allowedstances( "crouch" );
    level.allies[0] thread crouch_watcher();

    if ( !isdefined( level.listening_org ) )
        level.listening_org = common_scripts\utility::getstruct( "listening_org", "targetname" );

    if ( !isdefined( level.hangar_ents ) )
        level.hangar_ents = [];

    level.hangar_ents[level.hangar_ents.size] = level.allies[0];
    thread handle_player();
    thread handle_cormack();
    thread handle_irons();
    thread handle_lift_worker_01();
    thread handle_lift_worker_02();
    thread hangar_cargo_crate();
    thread hangar_lift();
    thread handle_gaz();
    thread handle_gaz2();
    thread hangar_ambient_worker_setup();
    thread forklift_setup();
    thread hangar_pa();
    thread ambient_hangar_workers();
    thread maps\irons_estate_plant_tracker::stairwell_doors();
    thread ambient_hangar_fan_blades_setup();
    thread hangar_vials();
    thread hangar_visor_bink();
    thread maps\irons_estate_plant_tracker::landing_pad_lift_upper_static_setup();
    level notify( "stealth_alerted_drone_monitor" );
    level notify( "stop_stealth_spotted_drone_monitor" );
}

hangar_vials()
{
    var_0 = maps\_utility::spawn_anim_model( "genericprop_x5" );
    level.hangar_ents[level.hangar_ents.size] = var_0;
    level.listening_org maps\_anim::anim_first_frame_solo( var_0, "hangar" );
    wait 0.05;
    var_0 attach( "atlas_stabilize_vial_static", "j_prop_1" );
    var_0 attach( "atlas_stabilize_vial_static", "j_prop_2" );
    var_0 attach( "atlas_stabilize_vial_static", "j_prop_3" );
    var_0 attach( "atlas_stabilize_vial_static", "j_prop_4" );
    var_0 attach( "atlas_stabilize_vial_static", "j_prop_5" );
    var_0 waittillmatch( "single anim", "end" );
    var_0 delete();
}

crouch_watcher()
{
    level endon( "track_irons_end" );
    self endon( "death" );

    for (;;)
    {
        self waittill( "traverse_finish" );
        wait 0.05;
        self allowedstances( "crouch" );
    }
}

handle_player()
{
    var_0 = common_scripts\utility::getstruct( "monitor_irons_obj_xprompt", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "player_rig" );
    var_1.origin = level.listening_org.origin;
    var_1.angles = level.listening_org.angles;
    var_1 hide();
    level.hangar_ents[level.hangar_ents.size] = var_1;
    level.listening_org maps\_anim::anim_first_frame_solo( var_1, "hangar" );
    common_scripts\utility::flag_wait( "cormack_in_hangar_position" );
    objective_setpointertextoverride( maps\_utility::obj( "monitor_irons" ), &"IRONS_ESTATE_RECORD" );
    objective_position( maps\_utility::obj( "monitor_irons" ), var_0.origin );
    var_2 = getent( "at_listening_position_trigger", "targetname" );
    var_2 thread maps\_utility::addhinttrigger( &"IRONS_ESTATE_RECORD_INTEL", &"IRONS_ESTATE_RECORD_INTEL_PC" );
    thread maps\irons_estate_code::handle_objective_marker( var_0, var_0, "at_listening_position", 80 );
    var_2 waittill( "trigger" );
    soundscripts\_snd::snd_message( "aud_monitor_irons" );
    level.irons thread maps\irons_estate_code::hide_friendname_until_flag_or_notify( "track_irons_end" );
    level.allies[0] thread maps\_utility::smart_dialogue( "ie_crmk_rolling" );
    objective_position( maps\_utility::obj( "monitor_irons" ), ( 0, 0, 0 ) );
    var_2 delete();
    common_scripts\utility::flag_set( "at_listening_position" );

    if ( level.nextgen )
        setsaveddvar( "r_adaptivesubdiv", 0 );

    level.player freezecontrols( 1 );
    common_scripts\utility::flag_clear( "_stealth_enabled" );
    level.player maps\_grapple::grapple_take();
    level.player allowsprint( 0 );
    level.player thread maps\_shg_utility::disable_features_entering_cinema( 1 );
    level.player thread maps\irons_estate_stealth::irons_estate_whistle( 0 );
    level.player thread maps\_tagging::tagging_set_binocs_enabled( 0 );
    level.player thread maps\_tagging::tagging_set_enabled( 0 );
    thread maps\_stealth_display::stealth_display_off();
    level.player disableweapons();
    level.player disableweaponswitch();
    level.player allowmelee( 0 );
    level.player disableoffhandweapons();
    level.player disableoffhandsecondaryweapons();
    level.player allowprone( 0 );
    level.player allowcrouch( 0 );
    level.player playerlinkto( var_1 );
    level.player setstance( "stand" );
    level.player playerlinktoblend( var_1, "tag_player", 0.6 );
    level.listening_org thread maps\_anim::anim_single( level.hangar_ents, "hangar" );
    var_1 thread player_hangar_waits();
    wait 0.55;
    level.listening_org notify( "stop_loop" );
    wait 0.05;
    var_1 show();
}

hangar_visor_bink()
{
    setsaveddvar( "cg_cinematicCanPause", "1" );
    setsaveddvar( "cg_cinematicFullScreen", "0" );
    var_0 = newclienthudelem( level.player );
    var_0 setshader( "cinematic_screen_add", 640, 480 );
    var_0.horzalign = "fullscreen";
    var_0.vertalign = "fullscreen";
    cinematicingame( "hangar_visor_hud", 1 );
    level waittill( "start_hangar_visor_hud_bink" );
    pausecinematicingame( 0 );
    wait 0.05;

    while ( iscinematicplaying() )
        wait 0.05;

    stopcinematicingame();
    var_0 destroy();
    setsaveddvar( "cg_cinematicCanPause", "0" );
    setsaveddvar( "cg_cinematicFullScreen", "1" );
}

player_hangar_waits()
{
    self waittillmatch( "single anim", "device_up" );
    var_0 = level.player getcurrentweapon();
    var_1 = level.player getweaponslistall();
    level.player takeallweapons();
    level notify( "start_hangar_visor_hud_bink" );
    self waittillmatch( "single anim", "zoom_in" );
    level.player lerpfov( 10, 0.5 );

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3 ) && var_3 == "iw5_kf5singleshot_sp_opticsreddot_silencer01" )
            level.player giveweapon( "iw5_kf5fullauto_sp_opticsreddot_silencer01" );

        if ( isdefined( var_3 ) && var_3 == "iw5_kf5fullauto_sp_opticsreddot_silencer01" )
            level.player giveweapon( "iw5_kf5fullauto_sp_opticsreddot_silencer01" );

        if ( isdefined( var_3 ) && var_3 == "iw5_sn6_sp_opticsreddot_silencer01" )
            level.player giveweapon( "iw5_sn6_sp_opticsreddot_silencer01" );

        if ( isdefined( var_3 ) && var_3 == "iw5_pbwsingleshot_sp_silencerpistol" )
            level.player giveweapon( "iw5_pbwsingleshot_sp_silencerpistol" );
    }

    self waittillmatch( "single anim", "zoom_in" );
    level.player lerpfov( 5, 0.5 );
    self waittillmatch( "single anim", "zoom_out" );
    level.player lerpfov( 20, 0.5 );

    if ( isdefined( var_0 ) && var_0 == "iw5_kf5singleshot_sp_opticsreddot_silencer01" || var_0 == "iw5_kf5fullauto_sp_opticsreddot_silencer01" )
        level.player switchtoweapon( "iw5_kf5fullauto_sp_opticsreddot_silencer01" );
    else if ( isdefined( var_0 ) && var_0 == "iw5_sn6_sp_opticsreddot_silencer01" || var_0 == "iw5_pbwsingleshot_sp_silencerpistol" )
        level.player switchtoweapon( "iw5_sn6_sp_opticsreddot_silencer01" );

    self waittillmatch( "single anim", "zoom_out" );
    level.player lerpfov( 65, 0.5 );
    self waittillmatch( "single anim", "device_down" );
    self waittillmatch( "single anim", "end" );

    if ( level.nextgen )
        setsaveddvar( "r_adaptivesubdiv", 1 );

    level.player unlink();
    level.player allowprone( 1 );
    level.player allowcrouch( 1 );
    level.player allowmelee( 1 );
    level.player freezecontrols( 0 );
    level.player allowsprint( 1 );
    level.player thread maps\_shg_utility::enable_features_exiting_cinema( 1 );
    level.player thread maps\irons_estate_stealth::irons_estate_whistle( 1 );
    level.player thread maps\_tagging::tagging_set_binocs_enabled( 1 );
    level.player thread maps\_tagging::tagging_set_enabled( 1 );
    thread maps\_stealth_display::stealth_display_on();
    level.player maps\_grapple::grapple_give();

    while ( !level.player common_scripts\utility::isweaponenabled() )
        level.player common_scripts\utility::_enableweapon();

    level.player enableweapons();
    level.player enableweaponswitch();
    level.player enableoffhandweapons();
    level.player enableoffhandsecondaryweapons();
    self delete();
    common_scripts\utility::flag_set( "_stealth_enabled" );
    objective_state_nomessage( maps\_utility::obj( "monitor_irons" ), "done" );
    common_scripts\utility::flag_set( "track_irons_end" );
}

handle_cormack()
{
    objective_add( maps\_utility::obj( "monitor_irons" ), "current", &"IRONS_ESTATE_OBJ_MONITOR_IRONS" );
    objective_onentity( maps\_utility::obj( "monitor_irons" ), level.allies[0] );
    level.allies[0] allowedstances( "crouch" );
    level.allies[0] maps\_utility::smart_dialogue( "ie_crmk_onme5" );
    var_0 = getnode( "cormack_girder_node_01", "targetname" );
    level.allies[0] maps\_utility::set_goalradius( 16 );
    level.allies[0] setgoalnode( var_0 );
    common_scripts\utility::flag_wait( "at_girders" );
    level.allies[0] allowedstances( "crouch" );
    level.listening_org maps\_anim::anim_reach_solo( level.allies[0], "hangar_enter_run" );
    level.listening_org maps\_anim::anim_single_solo( level.allies[0], "hangar_enter_run" );
    level.listening_org thread maps\_anim::anim_loop_solo( level.allies[0], "hangar_enter_loop", "stop_hangar_enter_loop" );
    wait 0.05;
    common_scripts\utility::flag_set( "cormack_drop_down_ready" );
    common_scripts\utility::flag_wait( "cormack_drop_down" );
    level.listening_org notify( "stop_hangar_enter_loop" );
    wait 0.05;
    level.listening_org maps\_anim::anim_single_solo( level.allies[0], "hangar_enter" );
    level.listening_org thread maps\_anim::anim_loop_solo( level.allies[0], "hangar_loop", "stop_loop" );
    wait 0.05;
    common_scripts\utility::flag_set( "cormack_in_hangar_position" );
    level.allies[0] allowedstances( "stand" );
}

handle_irons()
{
    level endon( "stop_irons_and_doctor_handlers" );
    level.irons = maps\_utility::spawn_targetname( "irons", 1 );
    level.irons.animname = "irons";

    if ( !isdefined( level.irons.magic_bullet_shield ) )
        level.irons maps\_utility::magic_bullet_shield( 1 );

    level.irons maps\_utility::gun_remove();
    level.irons maps\_utility::set_allowdeath( 1 );
    level.irons.grapple_magnets = [];
    level.hangar_ents[level.hangar_ents.size] = level.irons;
    level.irons.scripted_node = level.listening_org;
    level.listening_org thread maps\_anim::anim_loop_solo( level.irons, "hangar_loop", "stop_loop" );
    wait 0.05;
    level.irons thread maps\irons_estate_civilians::civilian_alert_watcher();
    level.irons thread maps\irons_estate_civilians::civilian_alert_behavior_hangar();
    level.irons thread irons_hangar_waits();
}

irons_hangar_waits()
{
    self waittillmatch( "single anim", "end" );
    self delete();
}

handle_doctor()
{
    if ( !isdefined( level.listening_org ) )
        level.listening_org = common_scripts\utility::getstruct( "listening_org", "targetname" );

    if ( !isdefined( level.hangar_ents ) )
        level.hangar_ents = [];

    level endon( "stop_irons_and_doctor_handlers" );

    if ( !isdefined( level.doctor ) )
        level.doctor = maps\_utility::spawn_targetname( "kva_doctor", 1 );

    level.doctor.tagged = undefined;
    level.doctor.animname = "doctor";

    if ( !isdefined( level.doctor.magic_bullet_shield ) )
        level.doctor maps\_utility::magic_bullet_shield( 1 );

    level.doctor maps\_utility::gun_remove();
    level.doctor attach( "npc_dronelaunchpad", "tag_weapon_right" );
    level.doctor.grapple_magnets = [];
    level.hangar_ents[level.hangar_ents.size] = level.doctor;
    level.doctor maps\_utility::set_allowdeath( 1 );
    level.doctor thread doctor_pad_watcher();
    level.doctor.scripted_node = level.listening_org;
    level.doctor maps\_utility::disable_arrivals();
    level.doctor maps\_utility::disable_exits();
    level.doctor maps\_utility::set_run_anim( "doctor_walk", 1 );
    level.listening_org thread maps\_anim::anim_reach_solo( level.doctor, "hangar" );
    common_scripts\utility::flag_wait( "track_irons_start" );
    level.doctor notify( "new_anim_reach" );
    level.listening_org thread maps\_anim::anim_loop_solo( level.doctor, "hangar_loop", "stop_loop" );
    wait 0.05;
    level.doctor thread maps\irons_estate_civilians::civilian_alert_watcher();
    level.doctor thread maps\irons_estate_civilians::civilian_alert_behavior_hangar();
    level.doctor thread doctor_hangar_waits();
}

doctor_pad_watcher()
{
    common_scripts\utility::waittill_any( "alerted", "death" );

    if ( isdefined( self ) )
        level.doctor detach( "npc_dronelaunchpad", "tag_weapon_right" );
}

doctor_hangar_waits()
{
    self waittillmatch( "single anim", "end" );
    self delete();
}

hangar_lift()
{
    var_0 = maps\_utility::spawn_anim_model( "generic_prop_raven" );
    level.hangar_ents[level.hangar_ents.size] = var_0;
    level.listening_org maps\_anim::anim_first_frame_solo( var_0, "hangar" );
    wait 0.05;
    var_1 = getent( "landing_pad_lift", "targetname" );
    var_1 linkto( var_0, "j_prop_1" );
}

hangar_cargo_crate()
{
    var_0 = maps\_utility::spawn_anim_model( "cargo_crate" );
    var_0 hidepart( "TAG_STATIC_CASE" );
    var_0 hidepart( "TAG_STATIC_VIALS" );
    level.hangar_ents[level.hangar_ents.size] = var_0;
    level.listening_org maps\_anim::anim_first_frame_solo( var_0, "hangar" );
    wait 0.05;
    var_0 waittillmatch( "single anim", "end" );
    var_0 delete();
    var_1 = getent( "manticore_crate_clip", "targetname" );

    if ( isdefined( var_1 ) )
        var_1 delete();
}

handle_lift_worker_01()
{
    var_0 = maps\_utility::spawn_targetname( "lift_worker_01", 1 );
    var_0.animname = "lift_worker_01";
    var_0 maps\_utility::gun_remove();
    var_0.grapple_magnets = [];
    var_0 maps\_utility::set_allowdeath( 1 );
    var_0 character\gfl\randomizer_atlas::main();
    level.hangar_ents[level.hangar_ents.size] = var_0;
    var_0.scripted_node = level.listening_org;
    level.listening_org thread maps\_anim::anim_loop_solo( var_0, "hangar_loop", "stop_loop" );
    wait 0.05;
    var_0 thread maps\irons_estate_civilians::civilian_alert_watcher();
    var_0 thread maps\irons_estate_civilians::civilian_alert_behavior_hangar();
    var_0 thread lift_worker_01_waits();
}

lift_worker_01_waits()
{
    self waittillmatch( "single anim", "end" );
    self delete();
}

handle_lift_worker_02()
{
    var_0 = maps\_utility::spawn_targetname( "lift_worker_02", 1 );
    var_0.animname = "lift_worker_02";
    var_0 maps\_utility::gun_remove();
    var_0.grapple_magnets = [];
    var_0 maps\_utility::set_allowdeath( 1 );
    var_0 character\gfl\randomizer_atlas::main();
    level.hangar_ents[level.hangar_ents.size] = var_0;
    var_0.scripted_node = level.listening_org;
    level.listening_org thread maps\_anim::anim_loop_solo( var_0, "hangar_loop", "stop_loop" );
    wait 0.05;
    var_0 thread maps\irons_estate_civilians::civilian_alert_watcher();
    var_0 thread maps\irons_estate_civilians::civilian_alert_behavior_hangar();
    var_0 thread lift_worker_02_waits();
}

lift_worker_02_waits()
{
    self waittillmatch( "single anim", "end" );
    self delete();
}

handle_gaz()
{
    if ( !isdefined( level.listening_org ) )
        level.listening_org = common_scripts\utility::getstruct( "listening_org", "targetname" );

    if ( !isdefined( level.gaz ) )
        level.gaz = maps\_utility::spawn_anim_model( "gaz" );

    level.listening_org thread maps\_anim::anim_loop_solo( level.gaz, "hangar" );
}

handle_gaz2()
{
    if ( !isdefined( level.listening_org ) )
        level.listening_org = common_scripts\utility::getstruct( "listening_org", "targetname" );

    if ( !isdefined( level.gaz2 ) )
        level.gaz2 = maps\_utility::spawn_anim_model( "gaz2" );

    level.listening_org thread maps\_anim::anim_loop_solo( level.gaz2, "hangar" );
}

hangar_ambient_worker_setup()
{
    var_0 = maps\_utility::array_spawn_targetname( "hangar_ambient_worker", 1 );
    common_scripts\utility::array_thread( var_0, ::hangar_ambient_worker_setup_anim );
}

hangar_ambient_worker_setup_anim()
{
    self endon( "death" );
    thread maps\irons_estate_civilians::civilian_alert_watcher();
    thread maps\irons_estate_civilians::civilian_alert_behavior_hangar();
    maps\_utility::set_allowdeath( 1 );
    self.grapple_magnets = [];
    self.scripted_node = common_scripts\utility::getstruct( self.target, "targetname" );

    if ( isdefined( self.scripted_node.script_noteworthy ) && self.scripted_node.script_noteworthy == "ie_hangar_ambience_welder_loop" )
    {
        self.welder = 1;
        self.torch = spawn( "script_model", ( 0, 0, 0 ) );
        self.torch setmodel( "machinery_welder_handle" );
        self.torch linkto( self, "tag_inhand", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        self.scripted_node = level.listening_org;
        thread flashing_welding();
        thread flashing_welding_death_handler();
    }
    else
        self.scripted_node thread maps\_anim::anim_generic_loop( self, self.scripted_node.animation, "stop_loop" );
}

flashing_welding()
{
    self endon( "death" );
    self endon( "alerted" );
    self.scripted_node thread maps\_anim::anim_generic_loop( self, "ie_hangar_ambience_welder_loop", "stop_welder_loop" );

    for (;;)
    {
        self.torch soundscripts\_snd_playsound::snd_play_loop_linked( "irons_hangar_welding_loop", "aud_stop_welding_loop", 0.2, 0.2 );
        self waittillmatch( "looping anim", "spark_stop" );
        level notify( "aud_stop_welding_loop" );
        stopfxontag( level._effect["ie_welding_runner"], self.torch, "tag_tip_fx" );
        self waittillmatch( "looping anim", "spark_start" );
        playfxontag( level._effect["ie_welding_runner"], self.torch, "tag_tip_fx" );
    }
}

flashing_welding_death_handler()
{
    common_scripts\utility::waittill_either( "death", "alerted" );

    if ( isdefined( self.torch ) )
        level notify( "aud_stop_welder_loop" );
}

forklift_setup()
{
    var_0 = [];
    level.forklift = maps\_utility::spawn_anim_model( "forklift" );
    var_1 = getent( "forklift_clip", "targetname" );
    var_1 linkto( level.forklift, "tag_body", ( 0, 0, -32 ), ( 0, 90, 0 ) );
    var_0[var_0.size] = level.forklift;
    level.forklift_crate_prop = maps\_utility::spawn_anim_model( "generic_prop_raven" );
    var_0[var_0.size] = level.forklift_crate_prop;
    level.forklift_crate_prop attach( "lsr_mili_cargo_cage_atlas_07", "j_prop_1" );
    var_2 = getent( "forklift_cargo_clip", "targetname" );

    if ( isdefined( var_2 ) )
        var_2 linkto( level.forklift_crate_prop, "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );

    level.forklift_driver = maps\_utility::spawn_targetname( "forklift_driver", "targetname" );
    var_0[var_0.size] = level.forklift_driver;
    level.forklift_driver.animname = "forklift_driver";
    level.forklift_driver maps\_utility::set_allowdeath( 1 );
    level.forklift_driver.grapple_magnets = [];
    level.forklift_driver thread maps\_utility::set_ignoresonicaoe( 1 );
    level.forklift_driver thread forklift_stop_watcher();
    level.forklift_driver thread maps\irons_estate_civilians::civilian_alert_watcher();
    level.forklift_driver thread maps\irons_estate_civilians::civilian_alert_behavior_hangar();
    level.forklift_org = spawnstruct();
    level.forklift_org.origin = level.listening_org.origin;
    level.forklift_org.angles = level.listening_org.angles;
    level.forklift_driver.scripted_node = level.forklift_org;
    var_3 = getent( "forklift_fail_trigger", "targetname" );

    if ( isdefined( var_3 ) )
    {
        var_3 enablelinkto();
        var_3 linkto( level.forklift, "tag_body", ( 40, 0, 38 ), ( 0, 90, 0 ) );
        var_3 thread forklift_fail_trigger_setup();
    }

    level.forklift_door_prop = maps\_utility::spawn_anim_model( "generic_prop_raven_x3" );
    var_0[var_0.size] = level.forklift_door_prop;
    level.forklift_org thread maps\_anim::anim_loop( var_0, "forklift_loop", "stop_loop" );
    var_4 = getent( "forklift_door_left", "targetname" );
    var_4 linkto( level.forklift_door_prop, "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_5 = getent( "forklift_door_right", "targetname" );
    var_5 linkto( level.forklift_door_prop, "j_prop_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.forklift thread maps\irons_estate_aud::forklift_audio_loop();
}

forklift_fail_trigger_setup()
{
    self waittill( "trigger", var_0 );

    if ( isdefined( var_0 ) && var_0 == level.player )
        level.forklift_driver notify( "alerted" );
}

forklift_stop_watcher()
{
    common_scripts\utility::waittill_any( "alerted", "death" );
    level.forklift setflaggedanim( "looping anim", level.scr_anim[level.forklift.animname]["forklift_loop"][0], 1, 0, 0 );
    level.forklift_door_prop setflaggedanim( "looping anim", level.scr_anim[level.forklift_door_prop.animname]["forklift_loop"][0], 1, 0, 0 );
    level.forklift_crate_prop setflaggedanim( "looping anim", level.scr_anim[level.forklift_crate_prop.animname]["forklift_loop"][0], 1, 0, 0 );
}

hangar_pa()
{
    var_0 = getent( "hangar_pa", "targetname" );
    wait 6.0;
    var_0 maps\_utility::play_sound_on_entity( "ie_hpa_clearlift" );
    wait 6.0;
    var_0 maps\_utility::play_sound_on_entity( "ie_hpa_lowerlevel" );
    wait 6.0;
    var_0 maps\_utility::play_sound_on_entity( "ie_hpa_mainoffice" );
    wait 6.0;
    var_0 maps\_utility::play_sound_on_entity( "ie_hpa_idready" );
    wait 6.0;
    var_0 maps\_utility::play_sound_on_entity( "ie_hpa_inprogress" );
}

ambient_hangar_workers()
{
    var_0 = undefined;
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;
    maps\_utility::array_spawn_function_targetname( "ambient_hangar_workers", ::ambient_hangar_workers_spawn_settings );
    var_6 = maps\_utility::array_spawn_targetname( "ambient_hangar_workers", 1 );

    foreach ( var_8 in var_6 )
    {
        if ( isdefined( var_8.script_noteworthy ) && var_8.script_noteworthy == "fueled_up_vo_guy1" )
        {
            var_0 = var_8;
            var_0 thread maps\irons_estate_civilians::civilian_alert_watcher( undefined, "fueled_up_vo_guys" );
            var_0 thread maps\irons_estate_civilians::civilian_alert_behavior();
        }

        if ( isdefined( var_8.script_noteworthy ) && var_8.script_noteworthy == "fueled_up_vo_guy2" )
        {
            var_1 = var_8;
            var_1 thread maps\irons_estate_civilians::civilian_alert_watcher( undefined, "fueled_up_vo_guys" );
            var_1 thread maps\irons_estate_civilians::civilian_alert_behavior();
        }

        if ( isdefined( var_8.script_noteworthy ) && var_8.script_noteworthy == "storage_vo_guy1" )
        {
            var_2 = var_8;
            var_2 thread maps\irons_estate_civilians::civilian_alert_watcher( undefined, "storage_vo_guys" );
            var_2 thread maps\irons_estate_civilians::civilian_alert_behavior();
        }

        if ( isdefined( var_8.script_noteworthy ) && var_8.script_noteworthy == "storage_vo_guy2" )
        {
            var_3 = var_8;
            var_3 thread maps\irons_estate_civilians::civilian_alert_watcher( undefined, "storage_vo_guys" );
            var_3 thread maps\irons_estate_civilians::civilian_alert_behavior();
        }

        if ( isdefined( var_8.script_noteworthy ) && var_8.script_noteworthy == "preflight_vo_guy1" )
        {
            var_4 = var_8;
            var_4 thread maps\irons_estate_civilians::civilian_alert_watcher( undefined, "preflight_vo_guys" );
            var_4 thread maps\irons_estate_civilians::civilian_alert_behavior();
        }

        if ( isdefined( var_8.script_noteworthy ) && var_8.script_noteworthy == "preflight_vo_guy2" )
        {
            var_5 = var_8;
            var_5 thread maps\irons_estate_civilians::civilian_alert_watcher( undefined, "preflight_vo_guys" );
            var_5 thread maps\irons_estate_civilians::civilian_alert_behavior();
        }
    }

    thread fueled_up_vo( var_0, var_1 );
    thread storage_vo( var_2, var_3 );
    thread preflight_vo( var_4, var_5 );
}

ambient_hangar_workers_spawn_settings()
{
    self endon( "death" );
    self.animname = "generic";
}

fueled_up_vo( var_0, var_1 )
{
    var_0 endon( "death" );
    var_0 endon( "something_alerted_me" );
    var_1 endon( "death" );
    var_1 endon( "something_alerted_me" );
    var_0 thread maps\irons_estate_code::stopsounds_on_death();
    var_1 thread maps\irons_estate_code::stopsounds_on_death();
    common_scripts\utility::flag_wait( "fueled_up_vo_start" );
    var_0 maps\_utility::smart_dialogue_generic( "ie_hw3_taxi" );
    wait 0.5;
    var_1 maps\_utility::smart_dialogue_generic( "ie_hw1_fueling" );
    wait 0.5;
    var_0 maps\_utility::smart_dialogue_generic( "ie_hw3_clearasap" );
    wait 0.5;
    var_1 maps\_utility::smart_dialogue_generic( "ie_hw1_onit" );
    wait 0.5;
    var_0 maps\_utility::smart_dialogue_generic( "ie_hw3_aneta" );
    wait 0.5;
    var_1 maps\_utility::smart_dialogue_generic( "ie_hw1_onitnow" );
    wait 0.5;
    var_0 maps\_utility::smart_dialogue_generic( "ie_hw3_getaneta" );
    wait 0.5;
    var_1 maps\_utility::smart_dialogue_generic( "ie_hw1_alright3" );
}

storage_vo( var_0, var_1 )
{
    var_0 endon( "death" );
    var_0 endon( "something_alerted_me" );
    var_1 endon( "death" );
    var_1 endon( "something_alerted_me" );
    var_0 thread maps\irons_estate_code::stopsounds_on_death();
    var_1 thread maps\irons_estate_code::stopsounds_on_death();
    common_scripts\utility::flag_wait( "storage_vo_start" );
    var_0 maps\_utility::smart_dialogue_generic( "ie_hw1_storagenumber" );
    wait 0.5;
    var_1 maps\_utility::smart_dialogue_generic( "ie_hw2_25" );
    wait 0.5;
    var_0 maps\_utility::smart_dialogue_generic( "ie_hw1_gotit5" );
    wait 0.5;
    var_1 maps\_utility::smart_dialogue_generic( "ie_hw2_easyaccess" );
    wait 0.5;
    var_0 maps\_utility::smart_dialogue_generic( "ie_hw1_shipment" );
    wait 0.5;
    var_1 maps\_utility::smart_dialogue_generic( "ie_hw2_what" );
    wait 0.5;
    var_0 maps\_utility::smart_dialogue_generic( "ie_hw1_yesterdaysdrop" );
    wait 0.5;
    var_1 maps\_utility::smart_dialogue_generic( "ie_hw2_okyaokay" );
}

preflight_vo( var_0, var_1 )
{
    var_0 endon( "death" );
    var_0 endon( "something_alerted_me" );
    var_1 endon( "death" );
    var_1 endon( "something_alerted_me" );
    var_0 thread maps\irons_estate_code::stopsounds_on_death();
    var_1 thread maps\irons_estate_code::stopsounds_on_death();
    wait 2.0;
    var_0 maps\_utility::smart_dialogue_generic( "ie_hw2_uptop" );
    wait 0.5;
    var_1 maps\_utility::smart_dialogue_generic( "ie_hw3_continuewithout" );
    wait 0.5;
    var_0 maps\_utility::smart_dialogue_generic( "ie_hw2_keithsays" );
    wait 0.5;
    var_0 maps\_utility::smart_dialogue_generic( "ie_hw2_neednow" );
    wait 0.5;
    var_1 maps\_utility::smart_dialogue_generic( "ie_hw3_fuallast" );
    wait 0.5;
    var_0 maps\_utility::smart_dialogue_generic( "ie_hw2_protocol" );
    wait 0.5;
    var_1 maps\_utility::smart_dialogue_generic( "ie_hw3_toobad" );
    wait 0.5;
    var_0 maps\_utility::smart_dialogue_generic( "ie_hw2_tellthem" );
    wait 0.5;
    var_1 maps\_utility::smart_dialogue_generic( "ie_hw3_eff" );
    wait 0.5;
    var_0 maps\_utility::smart_dialogue_generic( "ie_hw2_shortly" );
}

ambient_hangar_fan_blades_setup()
{
    var_0 = getentarray( "ambient_hangar_fan_blade", "targetname" );

    if ( isdefined( var_0 ) )
    {
        foreach ( var_2 in var_0 )
            var_2 thread ambient_hangar_fan_blade_rotate( "player_grappled_to_vtol" );
    }
}

ambient_hangar_fan_blade_rotate( var_0 )
{
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1.angles = self.angles;
    self linkto( var_1, "tag_origin" );
    var_2 = ( 0, -180, 0 );

    while ( !common_scripts\utility::flag( var_0 ) )
    {
        self rotatebylinked( var_2, 0.25 );
        self waittill( "rotatedone" );
        self rotatebylinked( var_2, 0.25 );
        self waittill( "rotatedone" );
    }
}
