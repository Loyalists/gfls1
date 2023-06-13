// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

pre_load()
{
    maps\captured_mech_code::pre_load();
    level.player maps\_playermech_code::playermech_init();
    common_scripts\utility::flag_init( "flag_mech_enabled" );
    common_scripts\utility::flag_init( "flag_getting_into_mech" );
    common_scripts\utility::flag_init( "flag_mb1_start" );
    common_scripts\utility::flag_init( "flag_mb1_jump_done" );
    common_scripts\utility::flag_init( "flag_fallback_1" );
    common_scripts\utility::flag_init( "flag_fallback_2" );
    common_scripts\utility::flag_init( "hint_weap_swarm_hold" );
    common_scripts\utility::flag_init( "hint_weap_swarm_release" );
    common_scripts\utility::flag_init( "flag_mb2_end" );
    common_scripts\utility::flag_init( "flag_mb2_mech_stencil_on" );
    common_scripts\utility::flag_init( "flag_mb2_mech_smashing_doors" );
    common_scripts\utility::flag_init( "flag_mb2_mechs_dead" );
    common_scripts\utility::flag_init( "lgt_flag_mech_entered" );
    common_scripts\utility::flag_init( "flag_final_vo" );
    maps\_utility::add_hint_string( "hint_mech_start", "Press ^3[{+activate}]^7 to Enter Mech", ::hint_mech_start );
    maps\_utility::add_hint_string( "hint_mech_grab", "Press ^3[{+activate}]^7 to Grab Object", ::hint_mech_grab );
    maps\_utility::add_hint_string( "hint_weap_swarm_hold", "Hold ^3[{+smoke}]^7 lock targets.", ::hint_weap_swarm_hold );
    maps\_utility::add_hint_string( "hint_weap_swarm_release", "Release ^3[{+smoke}]^7 to fire swarm missiles.", ::hint_weap_swarm_release );
    maps\_utility::add_hint_string( "hint_weap_rocket", "Press ^3[{+frag}]^7 to fire rockets", ::hint_weap );
    maps\_utility::add_hint_string( "hint_weap_gun", "Press ^3[{+attack}]^7 to fire main gun", ::hint_weap );
}

post_load()
{
    level._mb = spawnstruct();
    level._mb.civilians = [];
    level._mb.enemies = [];
    level._mb.trigs = [];
    level._mb.nodes = [];
    level.enemy_run_nodes = [];
    level.civ_run_nodes = [];
    level.vehicle_death_fx_override["script_vehicle_vrap"] = 1;
    level.vehicle_death_fx["script_vehicle_vrap"] = [];
    level.vehicle_death_fx["script_vehicle_vrap"][0] = maps\_vehicle::build_fx( "vfx/map/captured/cap_vrap_destro", "TAG_DEATH_FX" );

    if ( isdefined( common_scripts\utility::getstruct( "struct_playerstart_mb1", "targetname" ) ) )
    {
        spawnfunc_mb();
        level._mb.run_nodes1 = getnodearray( "node_mb1_run", "script_noteworthy" );
        level._mb.exit_run_nodes1 = getnodearray( "node_exit_run1", "script_noteworthy" );
        level._mb.exit_run_nodes2 = getnodearray( "node_exit_run2", "script_noteworthy" );
        level._mb.exit_run_nodes_enemy = getnodearray( "node_mb2_run_enemy", "script_noteworthy" );
        level.enemy_run_nodes = level._mb.run_nodes1;
        level.civ_run_nodes = level._mb.run_nodes1;
        level._mb.intro_node = common_scripts\utility::getstruct( "struct_mb1_introwall_smash", "targetname" ) common_scripts\utility::spawn_tag_origin();
        level._mb.slide_gate_right = getent( "brush_mb2_gate_right", "targetname" );
        level._mb.slide_gate_left = getent( "brush_mb2_gate_left", "targetname" );
        level._mb.slide_gate_destroyed = getentarray( "brush_mb2_gate_destroyed", "targetname" );
        common_scripts\utility::array_call( level._mb.slide_gate_destroyed, ::hide );
        level._mb.lifts = sortbydistance( getentarray( "origin_mb2_lift", "script_noteworthy" ), common_scripts\utility::getstruct( "struct_mb2_lift_order", "targetname" ).origin );

        foreach ( var_1 in level._mb.lifts )
        {
            common_scripts\utility::array_call( getentarray( var_1.target, "targetname" ), ::linkto, var_1 );
            var_1.fx = [];

            foreach ( var_3 in common_scripts\utility::getstructarray( var_1.target, "targetname" ) )
            {
                if ( var_3.script_parameters == "top" )
                {
                    var_1.goal = var_3;
                    continue;
                }

                if ( var_3.script_parameters == "fx" )
                    var_1.fx = common_scripts\utility::array_add( var_1.fx, var_3 );
            }
        }
    }
    else
        iprintln( "Warning: Mech Battle start point missing.  Compiled out?" );

    setignoremegroup( "team3", "allies" );
    setignoremegroup( "allies", "team3" );
}

hint_mech_start()
{
    return !common_scripts\utility::flag( "hint_mech_start" );
}

hint_mech_grab()
{
    return !common_scripts\utility::flag( "hint_mech_grab" );
}

hint_weap()
{
    return 0;
}

hint_weap_swarm_hold()
{
    return common_scripts\utility::flag( "hint_weap_swarm_hold" );
}

hint_weap_swarm_release()
{
    return common_scripts\utility::flag( "hint_weap_swarm_release" );
}

start( var_0, var_1 )
{
    level.player maps\captured_util::warp_to_start( var_0 );
    level.allies maps\captured_util::warp_allies( var_1, 1 );
    thread maps\_utility::battlechatter_off( "allies" );
    thread maps\_utility::battlechatter_off( "axis" );

    if ( level.start_point != "mb1_intro" )
    {
        mb_setup();
        level.allies[0] hudoutlineenable( 3, 1 );
    }

    if ( level.start_point == "mb1_jump" )
        thread maps\_playermech_code::playermech_start( "base_noweap" );
    else if ( level.start_point == "mb1" )
    {
        common_scripts\utility::flag_set( "flag_mb1_start" );
        common_scripts\utility::flag_set( "flag_mb1_jump_done" );
        level._mb.intro_node maps\_utility::delaythread( 0.05, ::ai_mb1_jumpdown_guards, 1 );
    }
    else if ( issubstr( level.start_point, "mb2" ) )
    {
        common_scripts\utility::array_call( getentarray( "trig_mb1", "script_noteworthy" ), ::delete );

        if ( issubstr( level.start_point, "mb2_gatesmash" ) )
            thread maps\_playermech_code::playermech_start( "base" );
        else
        {
            thread ambient_mb2_cranes();
            level._mb.slide_gate_right connectpaths();
            level._mb.slide_gate_left connectpaths();
            level._mb.slide_gate_right delete();
            level._mb.slide_gate_left delete();
            common_scripts\utility::array_call( level._mb.slide_gate_destroyed, ::show );
            level.allies maps\captured_util::warp_allies( "struct_allystart_mb2_gate", 1 );
            maps\_utility::activate_trigger_with_targetname( "trig_mb2_ally_1_half" );
            thread maps\_playermech_code::playermech_start( "base" );
        }
    }

    common_scripts\utility::flag_set( "flag_battle_to_heli_end" );
}

mb_setup()
{
    if ( isdefined( level._mb.mb_setup ) )
        return;

    level.player thread maps\captured_mech_code::init_mech_actions();
    level._mb.mb_setup = 1;

    if ( maps\captured_util::start_point_is_before( "mb1_mech", 1 ) )
    {
        level._mb.node = common_scripts\utility::getstruct( "struct_exfil_mechstart", "targetname" );
        level._mb.suit["top"] = maps\_utility::spawn_anim_model( "mech_suit_top" );
        level._mb.suit["bottom"] = maps\_utility::spawn_anim_model( "mech_suit_bottom" );
        level._mb.suit["handle"] = maps\_utility::spawn_anim_model( "mech_handle" );
        level._mb.debris = maps\_utility::spawn_anim_model( "debris" );
        level._mb.rocks = maps\_utility::spawn_anim_model( "rocks" );
        level._mb.dead_mech_enemy = getent( "actor_player_mech", "targetname" );
        // level._mb.dead_mech_enemy attach( "npc_exo_armor_atlas_head_captured" );
        level._mb.dead_mech_enemy character\gfl\randomizer_atlas::main();
        level._mb.dead_mech_enemy maps\_utility::assign_animtree( "mech_opfor" );
    }
    else if ( maps\captured_util::start_point_is_after( "mb1", 1 ) )
    {
        getent( "actor_player_mech", "targetname" ) delete();
        common_scripts\utility::flag_set( "flag_mech_vo_active" );
    }

    var_0 = [];

    foreach ( var_2 in getentarray( "mb1_nostencil", "script_noteworthy" ) )
        var_0 = common_scripts\utility::array_add( var_0, var_2 maps\_utility::spawn_vehicle() );

    if ( maps\captured_util::start_point_is_before( "mb1_jump", 1 ) )
        level.player maps\_playermech_code::disable_stencil( var_0 );

    common_scripts\utility::create_dvar( "quickmech", "0" );

    if ( maps\captured_util::start_point_is_before( "mb1", 1 ) )
    {
        level.player enableinvulnerability();
        level.allies maps\captured_util::warp_allies( "struct_allystart_mb1", 1 );
        level.ally maps\captured_util::ignore_everything();
        maps\_utility::activate_trigger_with_targetname( "trig_mb_ally_1" );
        setup_vols( getentarray( "vol_mb1", "script_noteworthy" ) );
    }

    wait 0.05;

    if ( !isdefined( level.ally.magic_bullet_shield ) || !level.ally.magic_bullet_shield )
        level.ally maps\_utility::magic_bullet_shield();
}

main_mb1_intro()
{
    mb_setup();
    var_0 = level._mb.node common_scripts\utility::spawn_tag_origin();
    level.ally.anim_node = level._mb.node common_scripts\utility::spawn_tag_origin();
    level.player.rig = maps\_utility::spawn_anim_model( "player_rig" );
    level.player freezecontrols( 1 );
    level.player disableweapons();
    level.player allowprone( 0 );
    level.player allowcrouch( 0 );
    level.player playerlinktoabsolute( level.player.rig, "tag_player" );
    level.player.rig show();
    soundscripts\_snd::snd_message( "aud_wakeup_mix" );
    thread maps\captured_fx::fx_heli_crash_godrays_on();
    level.player common_scripts\utility::delaycall( 17.5, ::playrumbleonentity, "heavy_1s" );
    level.player common_scripts\utility::delaycall( 18.4, ::playrumbleonentity, "heavy_1s" );
    level.player common_scripts\utility::delaycall( 19.3, ::playrumbleonentity, "heavy_1s" );
    level.player common_scripts\utility::delaycall( 20.6, ::playrumbleonentity, "heavy_1s" );
    level.player common_scripts\utility::delaycall( 21.5, ::playrumbleonentity, "heavy_1s" );
    var_1 = getent( "mech_intro_feet", "targetname" );
    var_1 hide();
    level notify( "anim_mech_wakeup" );
    level.ally.anim_node thread ai_ally_mb_intro_anim();
    var_2 = getent( "model_warbird_rotor", "targetname" );
    var_2 maps\_utility::assign_animtree( "warbird_rotor" );
    level._mb.node thread maps\_anim::anim_single( common_scripts\utility::array_combine( level._mb.suit, [ level._mb.dead_mech_enemy, level._mb.debris, level._mb.rocks, var_2 ] ), "anim_mech_wakeup" );
    var_0 maps\_anim::anim_single_solo( level.player.rig, "anim_mech_wakeup" );
    thread maps\captured_fx::fx_heli_crash_godrays_off();
    var_1 show();
    soundscripts\_snd::snd_message( "aud_wakeup_mech_cooldown_pings" );
    setsaveddvar( "g_friendlyNameDist", level.friendlynamedist );
    level.player freezecontrols( 0 );
    level.player.rig hide();
    level.player maps\_utility::blend_movespeedscale( 0.2 );
    level.player maps\_utility::blend_movespeedscale( 0.5, 6 );
    level.player allowjump( 1 );
    level.player allowmelee( 1 );
    level.player allowsprint( 1 );
    level.player unlink();
    level.player.rig delete();
    var_0 delete();
}

main_mb1_mech()
{
    level.player.rig = maps\_utility::spawn_anim_model( "player_rig_temp" );
    level.player.rig hide();
    level._mb.node maps\_anim::anim_first_frame( common_scripts\utility::array_combine( level._mb.suit, [ level._mb.dead_mech_enemy, level.player.rig ] ), "mech_enter" );
    var_0 = common_scripts\utility::getstruct( "struct_prompt_mechenter", "targetname" );
    var_1 = spawn( "script_origin", var_0.origin );
    var_1 makeusable();
    thread dialogue_mb1_intro();
    thread maps\captured_actions::mech_entry_action();
    level notify( "objective_player_can_get_into_mech" );
    var_2 = getdvar( "mechCrouchtime" );
    setsaveddvar( "mechCrouchtime", 3000 );
    var_1 maps\_utility::addhinttrigger( &"CAPTURED_HINT_ENTER_CONSOLE", &"CAPTURED_HINT_ENTER_PC" );
    var_1 thread maps\captured_actions::prompt_show_hide( "flag_waittill_entity_activate_looking_at", "captured_action_complete" );
    maps\captured_util::waittill_entity_activate_looking_at( level._mb.dead_mech_enemy, undefined, undefined, 72, 0.4, 0 );
    common_scripts\utility::flag_set( "flag_getting_into_mech" );
    var_3 = getent( "mech_intro_feet", "targetname" );
    var_3 hide();
    level.player common_scripts\utility::delaycall( 17.5, ::playrumbleonentity, "heavy_1s" );
    level.player common_scripts\utility::delaycall( 19.55, ::playrumbleonentity, "heavy_1s" );
    level.player common_scripts\utility::delaycall( 21.05, ::playrumbleonentity, "heavy_1s" );
    level.player common_scripts\utility::delaycall( 22.75, ::playrumbleonentity, "heavy_1s" );
    level notify( "captured_action_complete" );
    level.player setstance( "stand" );
    var_1 delete();

    if ( isdefined( level.ally.anim_node ) )
    {
        level.ally.anim_node maps\_utility::anim_stopanimscripted();
        level.ally.anim_node delete();
    }

    level.player maps\_utility::blend_movespeedscale( 1.0 );
    level.player notify( "stop_one_handed_gunplay" );
    common_scripts\utility::array_call( getentarray( "opfor_bh_helo", "targetname" ), ::delete );
    common_scripts\utility::array_call( getaiarray( "axis", "neutral", "team3" ), ::delete );
    level.player event_mb1_climb_in_mech();
    level.player.rig delete();
    setsaveddvar( "mechCrouchtime", var_2 );
    var_4 = getent( "mech_intro_blocker", "targetname" );
    var_4 delete();
    var_3 delete();
    common_scripts\utility::flag_set( "lgt_flag_mech_entered" );
}

main_mb1_jump()
{
    level.player allowmelee( 0 );

    if ( isdefined( level._mb.suit ) )
    {
        foreach ( var_2, var_1 in level._mb.suit )
            var_1 delete();
    }

    thread dialogue_mb1_jumpdown();
    level.player event_mb1_jumpdown();
}

main_mb1()
{
    common_scripts\utility::flag_wait( "flag_mb1_start" );
    thread ai_mb1();
    thread ambient_mb1_crane();
    thread dialogue_mb1();
    level.player thread event_mb1_weapons_come_online();
    common_scripts\utility::flag_wait( "flag_mb1_end" );
}

main_mb2_gatesmash()
{
    thread ai_mb2_gate();
    thread dialogue_mb2_gatesmash();
    level.player thread event_mb2_gatesmash();
    common_scripts\utility::flag_wait( "flag_mb2_mech_smashing_doors" );
    thread ambient_mb2_cranes();

    if ( distance( level.ally.origin, level.player.origin ) > 512 )
        level.ally maps\captured_util::warp_to_start( "struct_allywarp_mb2" );
}

main_mb2()
{
    thread ai_mb2();
    thread dialogue_mb2();
    thread ambient_mb2_tanks();
    common_scripts\utility::flag_wait( "flag_mb2_gateclose" );
    level._exit.gate_inner.col disconnectpaths();
    soundscripts\_snd::snd_message( "scn_cap_mech_door_closes" );
    level._exit.node maps\_anim::anim_single( [ level._exit.gate_inner, level._exit.lock ], "anim_exit_gateclose" );
    common_scripts\utility::flag_wait( "flag_mb2_end" );
}

ai_ally_mb_intro_anim()
{
    level endon( "captured_action_complete" );
    maps\_anim::anim_single_solo( level.ally, "anim_mech_wakeup" );
    thread maps\_anim::anim_loop_solo( level.ally, "anim_mech_wakeup_exit_loop" );
}

ai_mb1()
{
    setignoremegroup( "team3", "axis" );
    setignoremegroup( "team3", "allies" );
    setignoremegroup( "allies", "team3" );
    maps\_utility::delaythread( 1, common_scripts\utility::array_thread, getentarray( "vehicle_mb1_truck_1", "targetname" ), maps\_vehicle::spawn_vehicle_and_gopath );
    thread ai_mb1_drones();
    common_scripts\utility::array_thread( getentarray( "trig_mb1_retreat", "script_noteworthy" ), ::ai_special_retreat_watcher, "enemy_mb1_foot", "flag_mb1_end" );
    level thread retreat_watcher( "enemy_mb1_foot", "flag_mb1_fallback_idx0", "flag_mb1_end", 0, 1 );
    level thread retreat_watcher( "enemy_mb1_foot", "flag_mb1_fallback_idx1", "flag_mb1_end", 1, 2, "trig_mb_ally_2" );
    level thread retreat_watcher( "enemy_mb1_foot", "flag_mb1_fallback_idx2", "flag_mb1_end", 2, 3 );
    level thread retreat_watcher( "enemy_mb1_foot", "flag_mb1_fallback_idx3", "flag_mb1_end", 3, 4, "trig_mb_ally_3" );
    level thread retreat_watcher( "enemy_mb1_foot", "flag_mb1_fallback_idx4", "flag_mb1_end", 4, undefined, "trig_mb_ally_4" );
    common_scripts\utility::flag_wait( "flag_mb1_mech_closemove" );
    retreat_group( "enemy_mb1_close" );

    foreach ( var_1 in level._mb.enemies["enemy_mb1_close"] )
        var_1 add_to_group_enemy( "enemy_mb1_foot" );

    level._mb.enemies["enemy_mb1_close"] = [];
    level.ally maps\_utility::enable_ai_color();
    level.ally maps\captured_util::unignore_everything();
    level.ally.ignoreme = 1;
    level.ally.badplaceawareness = 0;
    maps\_utility::delaythread( 1, maps\_utility::activate_trigger_with_noteworthy, "trig_mb1_enemyflood" );
    common_scripts\utility::flag_wait( "flag_mb1_fallback_idx0" );
    maps\_utility::activate_trigger_with_noteworthy( "trig_mb2_civflood_1" );
    common_scripts\utility::flag_wait( "flag_mb1_fallback_idx1" );
    thread ai_mb1_allywarp();
    maps\_utility::activate_trigger_with_targetname( "trig_mb_enemy_towers" );
    common_scripts\utility::flag_wait( "flag_mb1_fallback_idx3" );
    thread ai_mb1_script_end();
    common_scripts\utility::flag_wait( "flag_mb1_end" );
    level.enemy_run_nodes = level._mb.run_nodes1;
    level.civ_run_nodes = level._mb.run_nodes1;

    if ( isdefined( level._mb.enemies["enemy_mb1_tower"] ) )
    {
        foreach ( var_4 in level._mb.enemies["enemy_mb1_tower"] )
        {
            if ( !isalive( var_4 ) )
                continue;

            var_4 setengagementmindist( 512, 512 );
            var_4 maps\_utility::set_baseaccuracy( 0.7 );
            var_4 thread maps\captured_mech_code::spawnfunc_mech_crush();
        }
    }

    var_6 = getent( "vol_mb2_civrun", "targetname" );

    foreach ( var_8 in level._mb.civilians )
    {
        foreach ( var_4 in var_8 )
        {
            if ( isalive( var_4 ) && var_4 istouching( var_6 ) )
                var_4 mb_run_to_goal();
        }
    }

    thread maps\_spawner::killspawner( 50 );
    thread maps\_spawner::killspawner( 51 );

    if ( isdefined( level._mb.enemies["enemy_mb1_foot"] ) )
        common_scripts\utility::array_thread( level._mb.enemies["enemy_mb1_foot"], ::mb_run_to_goal );

    if ( isdefined( level._mb.enemies["enemy_mb1_tower"] ) )
        common_scripts\utility::array_thread( level._mb.enemies["enemy_mb1_tower"], ::mb_run_to_goal );

    thread maps\_utility::ai_delete_when_out_of_sight( level._mb.enemies["enemy_mb1_foot"], 768 );
}

ai_special_retreat_watcher( var_0, var_1 )
{
    level endon( var_1 );
    self endon( "stop_special_retreat_watcher" );
    var_2 = getentarray( self.target, "targetname" );
    self waittill( "trigger" );

    if ( isdefined( var_2 ) )
    {
        var_2 = common_scripts\utility::array_removeundefined( var_2 );

        foreach ( var_4 in var_2 )
        {
            if ( var_4.disabled )
            {
                var_4 enable_vol();
                continue;
            }

            var_4 disable_vol();
        }
    }

    if ( isdefined( self.radius ) )
        badplace_cylinder( "temp_badplace", 10, self.origin, self.radius, 128, "axis" );

    retreat_group( var_0 );
}

ai_mb1_script_end()
{
    level endon( "flag_mb1_end" );

    while ( !isdefined( level._mb.enemies["enemy_mb1_foot"] ) || maps\_utility::remove_dead_from_array( level._mb.enemies["enemy_mb1_foot"] ).size > 0 )
        wait 0.05;

    common_scripts\utility::flag_set( "flag_mb1_end" );
}

ai_mb1_allywarp()
{
    level endon( "flag_mb2_mech_smashing_doors" );
    var_0 = common_scripts\utility::getstruct( "struct_playerstart_mb1", "targetname" );

    while ( level.player player_can_see( level.ally, var_0.origin, 0.5 ) )
        wait 1;

    level.ally maps\captured_util::warp_to_start( "struct_playerstart_mb1" );
}

ai_mb1_jumpdown_guards( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    var_1 = getentarray( "enemy_mb1_wallsmash_intro", "targetname" );
    var_2 = [];

    for ( var_3 = 0; var_3 < var_1.size; var_3++ )
    {
        var_2[var_3] = var_1[var_3] maps\_utility::spawn_ai();
        var_2[var_3].animname = "mb1_introwall_guard" + ( var_3 + 1 );
        var_2[var_3] maps\captured_util::ignore_everything();
        var_2[var_3] thread ai_mb1_first_guard_fallback( self );
    }

    if ( !var_0 )
        wait 5;

    maps\_utility::activate_trigger_with_targetname( "trig_mb1_enemyspawn_1" );
    wait 0.05;
    common_scripts\utility::array_thread( level._mb.enemies["enemy_mb1_foot"], ::go_to_vol, 1 );

    if ( !var_0 )
        self waittill( "mech_anim_done" );
    else
    {
        wait 0.1;
        maps\_utility::anim_stopanimscripted();
        common_scripts\utility::array_thread( var_2, maps\_utility::anim_stopanimscripted );
    }
}

ai_mb1_first_guard_fallback( var_0 )
{
    self endon( "death" );
    var_0 maps\_anim::anim_single_solo( self, "anim_mb1_introwall_smash" );
    add_to_group_enemy( "enemy_mb1_foot" );

    if ( self.script_parameters != "intro_runner" )
    {
        maps\captured_util::unignore_everything( 1 );
        common_scripts\utility::flag_wait_or_timeout( "flag_mb1_mech_firstmove", randomfloatrange( 1, 3 ) );
    }

    self.script_parameters = undefined;
    go_to_vol( 1 );
    self waittill( "goal" );
    maps\captured_util::unignore_everything( 1 );
}

ai_mb1_drones()
{
    var_0 = 2;
    level._mb.drone_paths = "struct_mb1_drone2";
    common_scripts\utility::flag_wait( "flag_mb1_mech_closemove" );
    level._mb.drone_paths = "struct_mb1_drone3";
    level notify( "drone_retreat" );
    var_1 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive( "vehicle_mb1_drone1" );
    common_scripts\utility::flag_wait( "flag_mb1_fallback_idx1" );
    level._mb.drone_paths = "struct_mb1_drone4";
    level notify( "drone_retreat" );
    var_1 = maps\_utility::remove_dead_from_array( var_1 );
    var_2 = getentarray( "vehicle_mb1_drone3", "targetname" );

    if ( var_1.size < var_0 )
    {
        for ( var_3 = var_1.size; var_3 < var_0; var_3++ )
            var_1 = common_scripts\utility::array_add( var_1, var_2[var_3] maps\_vehicle::spawn_vehicle_and_gopath() );
    }

    common_scripts\utility::flag_wait( "flag_mb1_fallback_idx3" );
    level._mb.drone_paths = "struct_mb1_drone5";
    level notify( "drone_retreat" );
    common_scripts\utility::flag_wait( "flag_mb1_end" );
    level notify( "drone_retreat_final" );
    var_1 = maps\_utility::remove_dead_from_array( var_1 );

    foreach ( var_5 in var_1 )
    {
        var_5.script_vehicle_selfremove = 1;
        var_5 dronepath( "struct_mb1_drone_exit" );
    }
}

ai_mb2_drones()
{
    level._mb.drone_paths = "struct_mb2_drone1";
    var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive( "vehicle_mb2_drone" );
    common_scripts\utility::flag_wait( "flag_mb2_fallback_idx5" );
    level._mb.drone_paths = "struct_mb2_drone2";
    level notify( "drone_retreat" );
    common_scripts\utility::flag_wait( "flag_mb2_end" );
    var_0 = maps\_utility::remove_dead_from_array( var_0 );
    common_scripts\utility::array_thread( var_0, ::drone_exit );
}

drone_exit()
{
    self endon( "death" );

    while ( !self.at_start )
        wait 0.05;

    self.script_vehicle_selfremove = 1;
    dronepath( "struct_mb2_drone_exit" );
}

ai_mb2_gate()
{
    level.ally maps\_utility::enable_ai_color();
    maps\_utility::activate_trigger_with_targetname( "trig_mb2_ally_1" );
    level.player waittill( "intro_anim_start" );
    level.ally maps\captured_util::ignore_everything();
    level.ally.badplaceawareness = 0;
    thread maps\_spawner::killspawner( 52 );

    if ( isdefined( level._mb.enemies["enemy_mb1_foot"] ) )
        common_scripts\utility::array_call( maps\_utility::remove_dead_from_array( level._mb.enemies["enemy_mb1_foot"] ), ::delete );

    foreach ( var_1 in level._mb.civilians )
        common_scripts\utility::array_call( maps\_utility::remove_dead_from_array( var_1 ), ::delete );

    level.player waittill( "exit_anim_done" );
    level.ally maps\captured_util::unignore_everything();
}

ai_mb2()
{
    level.ally maps\_utility::enable_ai_color();
    level.ally.ignoreme = 1;
    level.ally.badplaceawareness = 0;
    setup_vols( getentarray( "vol_mb2", "script_noteworthy" ) );
    level thread retreat_watcher( "enemy_mb2_foot", "flag_mb2_fallback_idx0", "flag_mb2_mech_spawn" );
    level thread retreat_watcher( "enemy_mb2_foot", "flag_mb2_fallback_idx1", "flag_mb2_mech_spawn", 0, 1 );
    level thread retreat_watcher( "enemy_mb2_foot", "flag_mb2_fallback_idx2", "flag_mb2_end", 1, 2, "trig_mb2_ally_1_half" );
    level thread retreat_watcher( "enemy_mb2_foot", "flag_mb2_fallback_idx3", "flag_mb2_end", 2, undefined, "trig_mb2_ally_2" );
    level thread retreat_watcher( undefined, "flag_mb2_fallback_idx4", "flag_mb2_end", undefined, undefined, "trig_mb2_ally_3" );
    level thread retreat_watcher( undefined, "flag_mb2_fallback_idx5", "flag_mb2_end", undefined, undefined, "trig_mb2_ally_4" );
    maps\_utility::activate_trigger_with_targetname( "trig_mb2_ally_1_half" );
    level._mb.mb2_max_enemies = 20;
    maps\_utility::activate_trigger_with_noteworthy( "trig_mb2_enemyflood" );
    maps\_utility::activate_trigger_with_targetname( "trig_mb2_enemy_start" );
    level.civ_run_nodes = level._mb.exit_run_nodes1;
    level.enemy_run_nodes = level._mb.exit_run_nodes_enemy;
    maps\_utility::activate_trigger_with_noteworthy( "trig_mb2_civflood_2" );
    common_scripts\utility::flag_wait_or_timeout( "flag_mb2_fallback_idx0", 2 );
    common_scripts\utility::flag_set( "flag_mb2_fallback_idx0" );
    maps\_utility::delaythread( 0.05, common_scripts\utility::flag_clear, "flag_mb2_fallback_idx0" );
    common_scripts\utility::flag_wait( "flag_mb2_fallback_idx2" );
    level._mb.mb2_max_enemies = 10;
    common_scripts\utility::flag_wait_or_timeout( "flag_mb2_mech_spawn", 8 );
    maps\_utility::activate_trigger_with_targetname( "trig_mb2_enemy_mechs" );
    thread soundscripts\_snd::snd_message( "aud_warehouse_mech_lift_alarm" );
    thread soundscripts\_snd::snd_message( "aud_warehouse_mech_lift_vo" );
    thread ai_mb2_remove_stencils();
    thread ai_mb2_mech_watcher();
    thread ai_mb2_enemies_run();
    common_scripts\utility::flag_wait_either( "flag_mb2_fallback_idx4", "flag_mb2_mechs_dead" );
    maps\_utility::activate_trigger_with_targetname( "trig_mb2_enemy_drivein" );
    thread ai_mb2_drones();
    thread ai_mb2_script_end();
    common_scripts\utility::flag_wait( "flag_mb2_gateclose" );
    level.civ_run_nodes = level._mb.exit_run_nodes_enemy;

    foreach ( var_1 in level._mb.civilians )
        common_scripts\utility::array_thread( var_1, ::mb_run_to_goal );
}

ai_mb2_enemies_run()
{
    common_scripts\utility::flag_wait_either( "flag_mb2_mechs_dead", "flag_mb2_fallback_idx5" );
    common_scripts\utility::array_thread( maps\_utility::remove_dead_from_array( level._mb.enemies["enemy_mb2_foot"] ), ::ai_mb2_enemyrun );
    thread maps\_utility::ai_delete_when_out_of_sight( level._mb.enemies["enemy_mb2_foot"], 768 );
}

ai_mb2_script_end()
{
    while ( !isdefined( level._mb.enemies["enemy_mb2_mech"] ) || maps\_utility::remove_dead_from_array( level._mb.enemies["enemy_mb2_mech"] ).size > 0 )
        wait 0.05;

    while ( !isdefined( level._mb.enemies["enemy_mb2_foot"] ) || maps\_utility::remove_dead_from_array( level._mb.enemies["enemy_mb2_foot"] ).size > 0 )
        wait 0.05;

    while ( !isdefined( level._mb.enemies["enemy_mb2_final"] ) || maps\_utility::remove_dead_from_array( level._mb.enemies["enemy_mb2_final"] ).size > 2 )
        wait 0.05;

    common_scripts\utility::array_thread( maps\_utility::remove_dead_from_array( level._mb.enemies["enemy_mb2_final"] ), ::ai_mb2_enemyrun, 1, 1 );
    thread maps\_utility::ai_delete_when_out_of_sight( level._mb.enemies["enemy_mb2_final"], 768 );
    wait 3;
    common_scripts\utility::flag_set( "flag_mb2_gateclose" );
    common_scripts\utility::flag_set( "flag_mb2_end" );
}

ai_mb2_mech_watcher()
{
    var_0 = 1;
    var_1 = [];

    while ( !isdefined( level._mb.enemies["enemy_mb2_mech"] ) || level._mb.enemies["enemy_mb2_mech"].size < 4 )
        wait 0.05;

    for (;;)
    {
        while ( maps\_utility::remove_dead_from_array( var_1 ).size == var_0 )
            wait 1;

        var_2 = maps\_utility::remove_dead_from_array( level._mb.enemies["enemy_mb2_mech"] );

        if ( var_2.size == 0 )
            break;

        foreach ( var_4 in sortbydistance( var_2, level.player.origin ) )
        {
            if ( isalive( var_4 ) && !isdefined( common_scripts\utility::array_find( var_1, var_4 ) ) )
            {
                var_1 = common_scripts\utility::array_add( var_1, var_4 );
                var_4 maps\_utility::set_fixednode_false();
                var_4 maps\_mech::mech_start_hunting();
                break;
            }
        }
    }

    common_scripts\utility::flag_set( "flag_mb2_mechs_dead" );
}

ai_mb2_remove_stencils()
{
    common_scripts\utility::flag_wait( "flag_mb2_mech_stencil_on" );
    level.player maps\_playermech_code::disable_stencil( maps\_utility::remove_dead_from_array( level._mb.enemies["enemy_mb2_foot"] ) );
}

ai_mb2_enemyrun( var_0, var_1 )
{
    if ( isdefined( var_1 ) && var_1 )
        self.nounignore = 1;

    self endon( "death" );
    wait(randomfloatrange( 0, 4 ));
    mb_run_to_goal();

    if ( isdefined( var_0 ) && var_0 )
        maps\_utility::delaythread( randomfloatrange( 0, 3 ), maps\captured_util::ignore_everything );
}

spawnfunc_mb()
{
    maps\_utility::array_spawn_function_noteworthy( "civ_mb1_foot", ::spawnfunc_mb_civilians );
    maps\_utility::array_spawn_function_noteworthy( "enemy_mb1_close", ::spawnfunc_mb_enemies );
    maps\_utility::array_spawn_function_noteworthy( "enemy_mb1_intro", ::spawnfunc_mb_enemies );
    maps\_utility::array_spawn_function_noteworthy( "enemy_mb1_foot", ::spawnfunc_mb_enemies );
    maps\_utility::array_spawn_function_noteworthy( "enemy_mb1_tower", ::spawnfunc_mb1_tower );
    maps\_utility::array_spawn_function_noteworthy( "vehicle_mb1_drone", ::spawnfunc_mb_drone );
    maps\_utility::array_spawn_function_noteworthy( "vehicle_mb1_vrap", ::spawnfunc_mb1_vrap );
    maps\_utility::array_spawn_function_noteworthy( "civ_mb2_foot", ::spawnfunc_mb_civilians );
    maps\_utility::array_spawn_function_noteworthy( "enemy_mb2_foot", ::spawnfunc_mb_enemies );
    maps\_utility::array_spawn_function_noteworthy( "enemy_mb2_final", ::spawnfunc_mb2_final );
    maps\_utility::array_spawn_function_noteworthy( "enemy_mb2_mech", ::spawnfunc_mb2_mech );
    maps\_utility::array_spawn_function_noteworthy( "vehicle_mb2_drone", ::spawnfunc_mb_drone );
    maps\_utility::array_spawn_function_noteworthy( "vehicle_mb2_vrap", ::spawnfunc_mb2_vrap );
}

spawnfunc_mb_civilians( var_0 )
{
    add_to_group_civilian( self.script_noteworthy );
    self hudoutlineenable( 3, 1 );
    self setthreatbiasgroup( "team3" );
    self.no_friendly_fire_penalty = 1;
    self.a.disablelongdeath = 1;
    thread maps\captured_mech_code::spawnfunc_mech_crush();

    if ( !isdefined( self.script_parameters ) || self.script_parameters != "nogoal" )
        thread mb_run_to_goal( var_0 );
}

spawnfunc_mb_enemies()
{
    self endon( "death" );
    add_to_group_enemy( self.script_noteworthy );

    if ( common_scripts\utility::flag( "flag_mb2_mech_spawn" ) )
        level.player maps\_playermech_code::disable_stencil( self );

    if ( isdefined( self.ridingvehicle ) )
        self.ridingvehicle waittill( "unloaded" );

    if ( issubstr( self.classname, "jet" ) )
        self.canjumppath = 1;

    self setengagementmindist( 512, 512 );
    maps\_utility::set_baseaccuracy( 0.7 );
    self.a.disablelongdeath = 1;
    thread maps\captured_mech_code::spawnfunc_mech_crush();

    if ( !isdefined( level._mb.glass_broken ) )
    {
        level._mb.glass_broken["glass_mb2_R_2"] = 0;
        level._mb.glass_broken["glass_mb2_L_2"] = 0;
    }

    if ( isdefined( self.script_parameters ) && issubstr( self.script_parameters, "glass" ) && !level._mb.glass_broken[self.script_parameters] )
    {
        foreach ( var_1 in common_scripts\utility::getstructarray( self.script_parameters, "targetname" ) )
            magicbullet( "iw5_titan45_sp", self.origin + ( 0, 0, 32 ), var_1.origin );

        foreach ( var_4 in getglassarray( self.script_parameters ) )
            destroyglass( var_4 );

        level._mb.glass_broken[self.script_parameters] = 1;
    }

    if ( isdefined( self.script_parameters ) && issubstr( self.script_parameters, "intro" ) )
        return;

    if ( isdefined( self.script_parameters ) && self.script_parameters == "run_to_goal" )
    {
        mb_run_to_goal( 1, self.target );
        return;
    }

    go_to_vol();
    maps\captured_util::unignore_everything( 1 );
}

spawnfunc_mb2_final()
{
    self endon( "death" );
    add_to_group_enemy( self.script_noteworthy );

    if ( isdefined( self.ridingvehicle ) )
        self.ridingvehicle waittill( "unloaded" );

    if ( issubstr( self.classname, "jet" ) )
        self.canjumppath = 1;

    self setengagementmindist( 512, 512 );
    self.a.disablelongdeath = 1;
    thread maps\captured_mech_code::spawnfunc_mech_crush();
    self.noclosemechrun = 1;
    maps\captured_util::unignore_everything( 1 );
}

spawnfunc_mb1_tower()
{
    add_to_group_enemy( self.script_noteworthy );

    if ( issubstr( self.classname, "jet" ) )
        self.canjumppath = 1;

    self.a.disablelongdeath = 1;
}

spawnfunc_mb_drone()
{
    self endon( "death" );
    self.at_start = 0;

    if ( isdefined( self.target ) )
        self waittill( "reached_dynamic_path_end" );

    self.at_start = 1;
    self vehicle_setspeedimmediate( 15 );
    self laseron();
    dronepath( level._mb.drone_paths );

    for (;;)
    {
        level waittill( "drone_retreat" );
        dronepath( level._mb.drone_paths );
    }
}

dronepath( var_0 )
{
    self.path_chosen = undefined;
    var_1 = common_scripts\utility::getstructarray( var_0, "script_noteworthy" );

    foreach ( var_3 in var_1 )
    {
        if ( !isdefined( var_3.chosen ) )
        {
            var_3.chosen = 1;
            self.path_chosen = var_3;
            break;
        }
    }

    if ( !isdefined( self.path_chosen ) )
        self.path_chosen = common_scripts\utility::random( var_1 );

    maps\_utility::vehicle_detachfrompath();
    thread maps\_utility::vehicle_dynamicpath( self.path_chosen );
    self vehicle_setspeedimmediate( 15 );
}

spawnfunc_mb1_vrap()
{
    self endon( "death" );
    soundscripts\_snd::snd_message( "aud_mech_trucks_enter", self.script_index );
}

spawnfunc_mb2_vrap()
{
    self endon( "death" );
    soundscripts\_snd::snd_message( "aud_mech_trucks_enter", self.script_index );
    maps\_vehicle::godon();
    wait 5;
    maps\_vehicle::godoff();
}

spawnfunc_mb2_mech()
{
    add_to_group_enemy( self.script_noteworthy );
    maps\captured_util::ignore_everything();
    level.player maps\_playermech_code::disable_stencil( self );
    self.a.disablelongdeath = 1;
    self.favoriteenemy = level.player;
    self.badplaceawareness = 0;
    self.script_forcegoal = 1;
    self.health = 6000;
    maps\_utility::set_baseaccuracy( 3 );
    var_0 = level._mb.lifts[self.script_index];
    self linkto( var_0 );
    var_0 thread mb2_lift( self );
    self endon( "death" );
    common_scripts\utility::flag_wait( "flag_mb2_mech_stencil_on" );
    maps\captured_util::unignore_everything();
    level.player maps\_playermech_code::enable_stencil( self );
    var_0 waittill( "lift_up" );
    maps\captured_util::ignore_everything();
    self unlink();
    wait(randomintrange( 1, 3 ));
    maps\captured_util::unignore_everything();
    wait(randomintrange( 1, 5 ));
    maps\_mech::mech_start_rockets();
}

two_mech_hunt()
{
    self endon( "death" );
    self endon( "stop_hunting" );
    self.usechokepoints = 0;

    for (;;)
    {
        wait 0.5;

        if ( isdefined( self.enemy ) )
        {
            var_0 = undefined;

            if ( isdefined( self._mech_node ) )
                var_0 = self._mech_node;

            var_1 = getnodesinradiussorted( self.enemy.origin, 512, 0, 256, "Path" );
            var_2 = undefined;

            if ( !isdefined( var_1[0]._mech_occupied ) || var_1[0]._mech_occupied == self )
                self._mech_node = var_1[0];
            else
                self._mech_node = var_1[var_1.size - 1];

            self._mech_node._mech_occupied = self;
            self setgoalpos( self._mech_node.origin );
            self.goalradius = 200;
            self.goalheight = 81;

            if ( isdefined( var_0 ) && var_0 != self._mech_node )
                var_0._mech_occupied = undefined;
        }
    }
}

mb2_lift( var_0 )
{
    self endon( "stop_lift" );
    thread mb2_lift_steam();
    thread soundscripts\_snd::snd_message( "aud_warehouse_mech_lift" );

    if ( isdefined( var_0 ) )
        thread mb2_lift_enemydeath( var_0 );

    var_1 = self.origin;
    self moveto( var_1 + ( 0, 0, 32 ), 0.5, 0, 0.5 );
    wait 0.5;
    self moveto( self.goal.origin, 3 );
    wait 2;
    common_scripts\utility::flag_set( "flag_mb2_mech_stencil_on" );
    wait 1;
    self notify( "lift_up" );
    wait 3;
    self moveto( var_1, 3 );
    wait 3;
    self notify( "lift_down" );
}

mb2_lift_enemydeath( var_0 )
{
    self endon( "lift_down" );
    self waittill( "lift_up" );

    if ( !isalive( var_0 ) )
    {
        self notify( "stop_lift" );
        return;
    }

    var_0 waittill( "death" );
    self notify( "stop_lift" );
}

mb2_lift_steam()
{
    self endon( "stop_lift" );

    foreach ( var_1 in self.fx )
        playfx( common_scripts\utility::getfx( "fx_lift_steam" ), var_1.origin, anglestoforward( var_1.angles ), anglestoup( var_1.angles ) );

    wait 0.5;

    foreach ( var_1 in self.fx )
        playfx( common_scripts\utility::getfx( "fx_lift_steam" ), var_1.origin, anglestoforward( var_1.angles ), anglestoup( var_1.angles ) );

    wait 0.25;

    foreach ( var_1 in self.fx )
        playfx( common_scripts\utility::getfx( "fx_lift_steam" ), var_1.origin, anglestoforward( var_1.angles ), anglestoup( var_1.angles ) );
}

deathfunc_vrap()
{
    self endon( "unloaded" );
    self waittill( "death" );

    foreach ( var_1 in self.riders )
    {
        if ( !isalive( var_1 ) )
            continue;

        var_1 delete();
    }
}

deathfunc_vol()
{
    self notify( "stop_deathfunc_vol" );
    self endon( "stop_deathfunc_vol" );
    self.deathfunc_vol = 1;
    common_scripts\utility::waittill_either( "death", "pain_death" );

    if ( isdefined( self._vol ) && isdefined( self._vol.counter ) )
    {
        self._vol.counter--;
        self._vol.ai = common_scripts\utility::array_remove( self._vol.ai, self );
    }
}

mb_run_to_goal( var_0, var_1, var_2 )
{
    if ( !isalive( self ) )
        return;

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    var_3 = level.civ_run_nodes;

    if ( issubstr( self.classname, "enemy" ) )
        var_3 = level.enemy_run_nodes;

    self notify( "stop_go_to_vol" );
    self notify( "stop_mb_run_to_goal" );
    self endon( "stop_mb_run_to_goal" );
    self endon( "death" );
    self cleargoalvolume();
    self.running_to_goal = 1;
    self.goalradius = 256;

    if ( isdefined( self.nounignore ) && self.nounignore )
        maps\captured_util::unignore_everything( 1 );

    var_4 = undefined;

    if ( isdefined( var_1 ) )
    {
        var_5 = [];
        var_5 = getnodearray( var_1, "targetname" );

        if ( var_5.size == 0 )
        {
            var_5 = getentarray( var_1, "targetname" );

            if ( !isdefined( var_5 ) )
            {

            }

            var_4 = undefined;

            if ( var_2 )
                var_4 = sortbydistance( var_5, self.origin )[0];
            else
                var_4 = common_scripts\utility::random( var_5 );

            self setgoalvolumeauto( var_4 );
        }
        else
        {
            var_4 = undefined;

            if ( var_2 )
                var_4 = sortbydistance( var_5, self.origin )[0];
            else
                var_4 = common_scripts\utility::random( var_5 );

            maps\_utility::follow_path( var_4 );
        }
    }
    else
    {
        var_4 = undefined;

        if ( var_2 )
            var_4 = sortbydistance( var_3, self.origin )[0];
        else
            var_4 = common_scripts\utility::random( var_3 );

        maps\_utility::follow_path( var_4 );
    }

    self.running_to_goal = undefined;

    if ( isdefined( var_0 ) && var_0 )
    {
        if ( isdefined( self.nounignore ) && self.nounignore )
            maps\captured_util::unignore_everything();

        return;
    }

    self delete();
}

add_to_group_civilian( var_0 )
{
    if ( !isdefined( level._mb.civilians[var_0] ) )
        level._mb.civilians[var_0] = [];

    level._mb.civilians[var_0] = common_scripts\utility::array_add( maps\_utility::remove_dead_from_array( level._mb.civilians[var_0] ), self );
    self._group = var_0;
}

add_to_group_enemy( var_0 )
{
    if ( !isalive( self ) )
        return;

    if ( !isdefined( level._mb.enemies[var_0] ) )
        level._mb.enemies[var_0] = [];

    level._mb.enemies[var_0] = common_scripts\utility::array_add( maps\_utility::remove_dead_from_array( level._mb.enemies[var_0] ), self );
    self._group = var_0;
}

retreat_watcher( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    self endon( var_2 );
    var_7 = getent( var_1, "targetname" );
    var_8 = [];

    if ( isdefined( var_7 ) && isdefined( var_7.target ) )
        var_8 = getentarray( var_7.target, "targetname" );

    var_9 = [];
    var_10 = [];

    foreach ( var_12 in level._mb.retreat_vols )
    {
        if ( isdefined( var_12.script_index ) )
        {
            if ( isdefined( var_3 ) && var_12.script_index == var_3 )
                var_9 = common_scripts\utility::array_add( var_9, var_12 );

            if ( isdefined( var_4 ) && var_12.script_index == var_4 )
                var_10 = common_scripts\utility::array_add( var_10, var_12 );
        }
    }

    for (;;)
    {
        common_scripts\utility::flag_wait( var_1 );

        if ( isdefined( var_5 ) )
            maps\_utility::activate_trigger_with_targetname( var_5 );

        foreach ( var_15 in var_8 )
            var_15 notify( "stop_special_retreat_watcher" );

        var_9 = common_scripts\utility::array_removeundefined( var_9 );
        common_scripts\utility::array_thread( var_9, ::disable_vol );
        var_10 = common_scripts\utility::array_removeundefined( var_10 );
        common_scripts\utility::array_thread( var_10, ::enable_vol );

        if ( isdefined( var_0 ) )
            retreat_group( var_0 );

        common_scripts\utility::flag_waitopen( var_1 );
    }
}

remove_vol_index( var_0 )
{
    foreach ( var_2 in level._mb.retreat_vols )
    {
        if ( isdefined( var_2.script_index ) && var_2.script_index == var_0 )
            var_2 delete();
    }
}

retreat_group( var_0, var_1 )
{
    var_2 = level._mb.enemies[var_0];

    foreach ( var_4 in level._mb.enemies[var_0] )
    {
        if ( !isdefined( var_4.running_to_goal ) )
            var_4 maps\_utility::delaythread( randomfloatrange( 0, 2 ), ::go_to_vol, 0, var_1 );
    }
}

go_to_vol( var_0, var_1 )
{
    self notify( "stop_go_to_vol" );
    self endon( "stop_go_to_vol" );
    self endon( "death" );

    if ( !isalive( self ) )
        return 0;

    if ( isdefined( var_1 ) )
    {
        var_2 = [];

        if ( isarray( var_1 ) )
            var_2 = var_1;
        else
            var_2[0] = var_1;

        foreach ( var_4 in var_2 )
        {
            if ( isdefined( self.script_index ) && int( self.script_index ) == var_4 )
                return;
        }
    }

    if ( !isdefined( var_0 ) )
        var_0 = 0;

    if ( !isdefined( self.deathfunc_vol ) )
        thread deathfunc_vol();

    if ( isdefined( self._vol ) && isdefined( self._vol.counter ) )
    {
        self._vol.counter--;
        self._vol = undefined;
        wait 0.05;
    }

    if ( isdefined( self.target ) )
    {
        self.target = undefined;
        return 0;
    }

    var_6 = [];
    var_7 = [];
    var_8 = [];
    var_6 = get_valid_vols( level._mb.priority_vols );

    if ( var_0 )
        var_6 = sortbydistance( var_6, self.origin );
    else
        var_6 = sortbydistance( var_6, level.player.origin );

    choose_vol( var_6 );

    if ( !isdefined( self._vol ) )
    {
        var_7 = get_valid_vols( level._mb.retreat_vols );

        if ( var_0 )
            var_7 = sortbydistance( var_7, self.origin );
        else
            var_7 = sortbydistance( var_7, level.player.origin );

        choose_vol( var_7 );
    }

    if ( !isdefined( self._vol ) )
    {
        var_8 = get_valid_vols( level._mb.overflow_vols );

        if ( var_0 )
            var_8 = sortbydistance( var_8, self.origin );
        else
            var_8 = sortbydistance( var_8, level.player.origin );

        choose_vol( var_8 );
    }

    maps\_utility::set_fixednode_false();

    if ( isdefined( self._vol ) )
    {
        self cleargoalvolume();
        maps\_spawner::go_to_node( self._vol, "entity" );
        return 1;
    }

    if ( isdefined( self.spawner ) )
        self.spawner delete();

    self notify( "stop_deathfunc_vol" );
    thread mb_run_to_goal();
    return 0;
}

choose_vol( var_0 )
{
    var_1 = distance( self.origin, level.player.origin );

    foreach ( var_3 in var_0 )
    {
        if ( isdefined( self.script_namenumber ) && isdefined( var_3.script_index ) )
        {
            var_4 = strtok( self.script_namenumber, " " );

            if ( !isdefined( common_scripts\utility::array_find( var_4, maps\_utility::string( var_3.script_index ) ) ) )
                continue;
        }

        if ( var_3.counter >= var_3.max_count )
            continue;

        var_3.ai = common_scripts\utility::array_add( var_3.ai, self );
        var_3.counter++;
        self._vol = var_3;
        break;
    }
}

setup_vols( var_0 )
{
    var_1 = getallnodes();
    var_2 = common_scripts\utility::spawn_tag_origin();

    if ( isdefined( level._mb.retreat_vols ) )
        common_scripts\utility::array_call( level._mb.retreat_vols, ::delete );

    level._mb.priority_vols = [];
    level._mb.retreat_vols = [];
    level._mb.overflow_vols = [];

    foreach ( var_4 in var_0 )
    {
        if ( !isdefined( var_4.counter ) )
        {
            var_4.counter = 0;
            var_4.max_count = int( var_4.script_parameters );
            var_4.ai = [];
        }

        if ( !isdefined( var_4.disabled ) )
        {
            if ( isdefined( var_4.script_nodestate ) && var_4.script_nodestate == "0" )
                var_4 disable_vol();
            else
                var_4 enable_vol();
        }

        var_4.nodes = [];

        foreach ( var_6 in var_1 )
        {
            var_2.origin = var_6.origin;

            if ( var_2 istouching( var_4 ) )
            {
                if ( issubstr( var_6.type, "Cover" ) || issubstr( var_6.type, "Conceal" ) || issubstr( var_6.type, "Exposed" ) )
                    var_4.nodes = common_scripts\utility::array_add( var_4.nodes, var_6 );
            }
        }

        var_4 thread vol_auto_disable();

        if ( isdefined( var_4.script_namenumber ) )
        {
            if ( issubstr( var_4.script_namenumber, "priority" ) )
            {
                level._mb.priority_vols = common_scripts\utility::array_add( level._mb.priority_vols, var_4 );
                continue;
            }

            if ( issubstr( var_4.script_namenumber, "overflow" ) )
            {
                level._mb.overflow_vols = common_scripts\utility::array_add( level._mb.overflow_vols, var_4 );
                continue;
            }
        }

        level._mb.retreat_vols = common_scripts\utility::array_add( level._mb.retreat_vols, var_4 );
    }
}

vol_auto_disable()
{
    self notify( "notify_stop_vol_auto_disable" );
    self endon( "notify_stop_vol_auto_disable" );

    while ( isdefined( self ) )
    {
        if ( !self.disabled )
        {
            self.nodes = common_scripts\utility::array_removeundefined( self.nodes );
            var_0 = 1;

            foreach ( var_2 in self.nodes )
            {
                if ( isdefined( var_2.state ) && ( var_2.state == "unlinked" || var_2.state == "disabled" ) )
                {
                    var_0 = 0;
                    break;
                }
            }

            if ( !var_0 )
                disable_vol();
        }
        else
        {
            common_scripts\utility::array_thread( maps\_utility::remove_dead_from_array( self.ai ), ::go_to_vol );
            self.ai = [];
        }

        wait 0.1;
    }
}

disable_vol()
{
    if ( !isdefined( self ) )
        return;

    self.disabled = 1;
}

enable_vol()
{
    if ( !isdefined( self ) )
        return;

    self.disabled = 0;
}

get_valid_vols( var_0 )
{
    var_1 = [];
    var_2 = [];

    foreach ( var_4 in var_0 )
    {
        if ( isdefined( var_4 ) && !var_4.disabled )
            var_1 = common_scripts\utility::array_add( var_1, var_4 );
    }

    return var_1;
}

playermech_start_waittill()
{
    self waittill( "notify_mech_enable" );
    self maps\_playermech_code::playermech_start( "base_noweap_bootup", undefined, undefined, "viewhands_playermech", "viewhands_playermech" );
}

event_mb1_climb_in_mech()
{
    thread dialogue_mb1_bootup();
    self freezecontrols( 1 );
    self disableweapons();
    self allowprone( 0 );
    self allowcrouch( 0 );
    soundscripts\_snd::snd_message( "start_mech" );
    self playerlinktoblend( self.rig, "tag_player", 0.5 );
    wait 0.5;
    self playerlinktodelta( self.rig, "tag_player", 0, 0, 0, 0, 0, 1 );
    self.rig show();
    thread take_weapon_delayed();
    level thread maps\captured_util::waittill_notify_func( "notify_mech_enable", maps\_playermech_code::playermech_start, "base_noweap_bootup" );
    thread event_mb1_climb_in_mech_gideon();
    level._mb.node maps\_anim::anim_single( common_scripts\utility::array_combine( level._mb.suit, [ level._mb.dead_mech_enemy, self.rig ] ), "mech_enter" );
    thread maps\_playermech_code::playermech_start( "base_noweap" );
    self lerpviewangleclamp( 0, 0, 0, 30, 30, 30, 30 );
    common_scripts\utility::flag_set( "flag_mech_enabled" );
}

event_mb1_climb_in_mech_gideon()
{
    var_0 = level._mb.node common_scripts\utility::spawn_tag_origin();
    var_0 maps\_anim::anim_single_solo( level.ally, "mech_enter" );
    var_0 thread maps\_anim::anim_loop_solo( level.ally, "mech_enter_loop" );
    common_scripts\utility::flag_wait( "flag_mb1_jump_done" );
    var_0 maps\_utility::anim_stopanimscripted();
    level.ally maps\_utility::anim_stopanimscripted();
    var_0 delete();
}

take_weapon_delayed()
{
    wait 1.0;
    var_0 = self getcurrentweapon();
    self takeweapon( var_0 );
}

event_mb1_jumpdown()
{
    var_0 = getent( "trig_mb1_introwall_smash", "targetname" );
    var_1 = level._mb.intro_node;

    for (;;)
    {
        var_0 waittill( "trigger", var_2 );

        if ( level.player maps\captured_mech_code::cansmash( var_1, anglestoright( var_1.angles ) * -1 ) )
            break;

        wait 0.05;
    }

    thread maps\captured_mech_code::spawn_mech_rig( 1, 0.2 );
    var_1 thread ai_mb1_jumpdown_guards();
    soundscripts\_snd::snd_message( "aud_mech_jump" );
    soundscripts\_snd::snd_message( "aud_mech_panic_walla_watcher" );
    common_scripts\utility::flag_set( "flag_force_hud_ready" );
    var_1 thread maps\captured_mech_code::anim_single_mech( [ self.rig ], "anim_mb1_introwall_smash", "cap_s1_escape_mech_jump_out_vm" );
    level.dopickyautosavechecks = 0;
    maps\_utility::autosave_by_name( "mb_jumpdown_start" );
    level.dopickyautosavechecks = 1;
    level.player common_scripts\utility::delaycall( 0.55, ::playrumbleonentity, "heavy_1s" );
    level.player common_scripts\utility::delaycall( 1.85, ::playrumbleonentity, "heavy_1s" );
    getscriptablearray( "intro_wall_scrtble", "targetname" )[0] setscriptablepartstate( 0, 1 );
    maps\_utility::delaythread( 1.75, common_scripts\_exploder::exploder, "mech_intro_land" );
    level.player maps\_utility::delaythread( 1.75, maps\_playermech_code::enable_stencil, getentarray( "mb1_nostencil", "script_noteworthy" ) );
    soundscripts\_snd::snd_music_message( "mus_captured_mech" );
    common_scripts\utility::flag_set( "flag_mb1_start" );
    var_1 waittill( "mech_anim_done" );
    common_scripts\utility::flag_clear( "flag_force_hud_ready" );
    self unlink();
    self.rig delete();
    var_1 delete();
    common_scripts\utility::flag_set( "flag_mb1_jump_done" );
}

event_mb1_weapons_come_online()
{
    common_scripts\utility::flag_wait( "flag_mb1_jump_done" );
    level.player disableinvulnerability();
    thread maps\_playermech_code::playermech_start( "base_transition" );

    while ( maps\_playermech_code::get_mech_state() != "base_transition" )
        wait 0.05;

    maps\_playermech_code::set_mech_state( "base" );
}

event_mb2_gatesmash()
{
    var_0 = common_scripts\utility::getstruct( "struct_mb2_gatesmash", "targetname" );

    for (;;)
    {
        common_scripts\utility::flag_wait( "flag_mb2_gatesmash" );

        if ( level.player maps\captured_mech_code::cansmash( var_0, anglestoforward( var_0.angles ) ) )
            break;

        wait 0.05;
    }

    thread maps\captured_mech_code::spawn_mech_rig( 1, 0.2 );
    soundscripts\_snd::snd_message( "mech_warehouse_door_smash" );
    playfx( level._effect["playermech_cannon_default"], ( 9041, -1195, 260 ), ( 0, 1, 0.5 ) );
    level._mb.slide_gate_right connectpaths();
    level._mb.slide_gate_left connectpaths();
    level._mb.slide_gate_right delete();
    level._mb.slide_gate_left delete();
    common_scripts\utility::flag_set( "flag_mb2_mech_smashing_doors" );
    common_scripts\utility::flag_set( "flag_force_hud_ready" );
    var_0 thread maps\captured_mech_code::anim_single_mech( [ self.rig ], "mech_run_through", "cap_playermech_run_through_mech_short_vm" );
    common_scripts\utility::array_call( level._mb.slide_gate_destroyed, ::show );
    self waittill( "mech_anim_done" );
    common_scripts\utility::flag_clear( "flag_force_hud_ready" );
    self unlink();
    self.rig delete();
}

ambient_mb1_crane()
{
    var_0 = getscriptablearray( "scriptable_mb1_crane", "targetname" )[0];
    var_1 = common_scripts\utility::getstruct( "struct_mb1_crane", "targetname" );
    var_2 = common_scripts\utility::getstruct( var_1.target, "targetname" );
    var_0 waittill( "death" );
    thread maps\captured_mech_code::smash_throw( var_1.origin, var_1.radius );
    common_scripts\utility::array_thread( getnodesinradius( var_1.origin, var_1.radius, 0, var_1.radius ), maps\captured_mech_code::disconnect_node );
    wait 0.4;
    radiusdamage( var_2.origin, var_2.radius, 500, 500, level.player );
}

ambient_mb2_claw_platform( var_0 )
{
    level endon( "flag_mb2_end" );
    var_1 = common_scripts\utility::getstructarray( var_0, "targetname" );
    var_2 = undefined;

    foreach ( var_4 in getentarray( var_0, "targetname" ) )
    {
        if ( issubstr( var_4.classname, "brushmodel" ) )
            var_2 = var_4;
    }

    var_2 setcandamage( 1 );
    var_2 setcanradiusdamage( 1 );
    var_6 = undefined;
    var_7 = undefined;

    foreach ( var_9 in var_1 )
    {
        if ( var_9.script_noteworthy == "struct_disconnect" )
        {
            var_6 = var_9;
            continue;
        }

        if ( var_9.script_noteworthy == "struct_damage" )
            var_7 = var_9;
    }

    for (;;)
    {
        var_2 waittill( "damage", var_11, var_12, var_13, var_14 );

        if ( var_12 != level.player )
        {
            wait 0.05;
            continue;
        }

        thread maps\captured_mech_code::smash_throw( var_14, 200 );
    }
}

ambient_mb2_cranes()
{
    thread soundscripts\_snd::snd_message( "aud_warehouse_roof_machines_line" );
    level._mb.cargo_total = 7;
    level._mb.cargo["A"] = 0;
    level._mb.cargo["B"] = 0;
    level._mb.cranes = [];

    for ( var_0 = 0; var_0 < 10; var_0++ )
        thread ambient_mb2_crane( "A", "model_mb2_craneA" + ( var_0 + 1 ), "struct_mb2_cranepath_A", 40 );

    for ( var_0 = 0; var_0 < 10; var_0++ )
        thread ambient_mb2_crane( "B", "model_mb2_craneB" + ( var_0 + 1 ), "struct_mb2_cranepath_B", 30 );

    thread ambient_mb2_claw_platform( "model_mb2_claw_platform1" );
    thread ambient_mb2_claw_platform( "model_mb2_claw_platform2" );
    thread ambient_mb2_claw_platform( "model_mb2_claw_platform3" );
}

ambient_mb2_crane( var_0, var_1, var_2, var_3 )
{
    level endon( "flag_exit_lock_broken" );
    var_4 = common_scripts\utility::getstruct( var_2, "targetname" );
    var_5 = common_scripts\utility::getstruct( var_4.target, "targetname" );
    var_6 = undefined;
    var_7 = undefined;
    var_8 = [];

    foreach ( var_10 in getentarray( var_1, "targetname" ) )
    {
        if ( issubstr( var_10.model, "crane" ) )
        {
            var_6 = var_10 common_scripts\utility::spawn_tag_origin();
            var_6.main_model = var_10;
            var_10 linkto( var_6 );
            continue;
        }
        else if ( issubstr( var_10.classname, "brushmodel" ) )
        {
            var_7 = var_10;
            continue;
        }

        var_8 = common_scripts\utility::array_add( var_8, var_10 );
    }

    level._mb.cranes = common_scripts\utility::array_add( level._mb.cranes, var_6 );
    var_6.tmodel = var_1;
    var_6._id_5763 = var_0;
    playfxontag( level._effect["cap_crane_light"], var_6.main_model, "crane_T" );
    var_6.templates = [];

    foreach ( var_10 in var_8 )
    {
        var_13 = spawnstruct();
        var_13.model = var_10.model;
        var_13.offset = var_10.origin - var_6.origin;
        var_6.templates = common_scripts\utility::array_add( var_6.templates, var_13 );
    }

    if ( isdefined( var_7 ) )
    {
        var_6.brush = var_7;
        var_7 linkto( var_6 );
        var_6 childthread tank_damage_detection( 1 );
    }

    var_6.parts = [];

    if ( common_scripts\utility::random( [ 0, 1 ] ) && level._mb.cargo[var_6._id_5763] < level._mb.cargo_total )
    {
        common_scripts\utility::array_call( var_8, ::linkto, var_6 );
        var_6.parts = var_8;
        level._mb.cargo[var_6._id_5763]++;
    }
    else
    {
        common_scripts\utility::array_call( var_8, ::delete );
        var_6.brush notsolid();
        var_6.parts = [];
    }

    var_15 = var_3 * distance2d( var_6.origin, var_5.origin ) / distance2d( var_4.origin, var_5.origin );
    var_6 thread soundscripts\_snd::snd_message( "aud_warehouse_roof_machines", var_15 );
    var_6 moveto( ( var_5.origin[0], var_6.origin[1], var_6.origin[2] ), var_15 );
    wait(var_15);

    for (;;)
    {
        if ( var_6.parts.size == 0 )
        {
            if ( common_scripts\utility::random( [ 0, 1 ] ) && level._mb.cargo[var_6._id_5763] < level._mb.cargo_total )
            {
                var_6.parts = [];

                foreach ( var_13 in var_6.templates )
                {
                    var_10 = spawn( "script_model", var_4.origin );
                    var_10 setmodel( var_13.model );
                    var_10 linkto( var_6, "tag_origin", var_13.offset, ( 0, 0, 0 ) );
                    var_6.parts = common_scripts\utility::array_add( var_6.parts, var_10 );
                }

                var_6.brush solid();
                level._mb.cargo[var_6._id_5763]++;
            }
        }

        var_6.parts = common_scripts\utility::array_removeundefined( var_6.parts );
        var_6.main_model hide();
        stopfxontag( level._effect["cap_crane_light"], var_6.main_model, "crane_T" );
        common_scripts\utility::array_call( var_6.parts, ::hide );
        var_6.origin = ( var_4.origin[0], var_6.origin[1], var_6.origin[2] );
        wait 0.05;
        var_6.main_model show();
        playfxontag( level._effect["cap_crane_light"], var_6.main_model, "crane_T" );
        common_scripts\utility::array_call( var_6.parts, ::show );
        var_6 thread soundscripts\_snd::snd_message( "aud_warehouse_roof_machines", var_3 );
        var_6 moveto( ( var_5.origin[0], var_6.origin[1], var_6.origin[2] ), var_3 );
        wait(var_3);
    }
}

ambient_mb2_tanks()
{
    for ( var_0 = 2; var_0 < 8; var_0++ )
    {
        var_1 = getentarray( "model_mb2_crate_explode_" + var_0, "targetname" );
        var_2 = undefined;
        var_3 = [];

        foreach ( var_5 in var_1 )
        {
            if ( issubstr( var_5.classname, "brushmodel" ) )
            {
                var_2 = var_5;
                continue;
            }

            var_3 = common_scripts\utility::array_add( var_3, var_5 );
        }

        var_7 = common_scripts\utility::spawn_tag_origin();
        var_7.brush = var_2;
        var_7.parts = var_3;
        var_7 thread tank_damage_detection();
    }
}

tank_damage_detection( var_0 )
{
    level endon( "flag_exit_lock_broken" );
    self endon( "death" );
    self.brush setcandamage( 1 );
    self.brush setcanradiusdamage( 1 );

    if ( !isdefined( var_0 ) )
        var_0 = 0;

    for (;;)
    {
        self.brush waittill( "damage", var_1, var_2 );

        if ( var_2 != level.player )
            continue;

        if ( self.parts.size == 0 )
            continue;

        playfx( level._effect["fireball_explosion_cluster_parent_02"], self.origin, ( 0, 0, -1 ) );
        self radiusdamage( self.origin, 512, 300, 300, level.player );
        common_scripts\utility::array_call( self.parts, ::delete );

        if ( !isremovedentity( self ) )
            self.parts = [];

        if ( isdefined( self._id_5763 ) )
            level._mb.cargo[self._id_5763]--;

        self.brush notsolid();

        if ( !var_0 )
            break;
    }

    self.brush delete();
    self delete();
}

player_can_see( var_0, var_1, var_2 )
{
    if ( player_can_see_ai_bones( var_0, var_2 ) )
        return 1;

    if ( player_can_see_point( var_1, var_2 ) )
        return 1;

    if ( player_can_see_point( var_1 + ( 0, 0, 70 ), var_2 ) )
        return 1;

    return 0;
}

player_can_see_point( var_0, var_1 )
{
    var_2 = 0.342;

    if ( isdefined( var_1 ) )
        var_2 = var_1;

    var_3 = level.player getangles();

    if ( !common_scripts\utility::within_fov( level.player.origin, var_3, var_0, var_2 ) )
        return 0;

    var_4 = level.player geteye();

    if ( sighttracepassed( var_4, var_0, 1, level.player ) )
        return 1;

    return 0;
}

player_can_see_ai_bones( var_0, var_1 )
{
    var_2 = 0.342;

    if ( isdefined( var_1 ) )
        var_2 = var_1;

    if ( !common_scripts\utility::within_fov( level.player.origin, level.player.angles, var_0.origin, var_2 ) )
        return 0;

    var_3 = level.player geteye();
    var_4 = var_0 gettagorigin( "j_head" );

    if ( sighttracepassed( var_3, var_4, 1, level.player, var_0 ) )
        return 1;

    var_5 = var_0 gettagorigin( "j_mainroot" );

    if ( sighttracepassed( var_3, var_5, 1, level.player, var_0 ) )
        return 1;

    var_6 = var_0 gettagorigin( "j_wrist_le" );

    if ( sighttracepassed( var_3, var_6, 1, level.player, var_0 ) )
        return 1;

    var_6 = var_0 gettagorigin( "j_wrist_ri" );

    if ( sighttracepassed( var_3, var_6, 1, level.player, var_0 ) )
        return 1;

    var_7 = var_0 gettagorigin( "j_ankle_ri" );

    if ( sighttracepassed( var_3, var_7, 1, level.player, var_0 ) )
        return 1;

    var_7 = var_0 gettagorigin( "j_ankle_ri" );

    if ( sighttracepassed( var_3, var_7, 1, level.player, var_0 ) )
        return 1;

    return 0;
}

dialogue_mb1_intro()
{

}

dialogue_mb1_bootup()
{
    wait 11;
    wait 7;
    wait 1;
    wait 0.3;
    level.allies[0] hudoutlineenable( 3, 1 );
}

dialogue_mb1_jumpdown()
{
    maps\_utility::smart_radio_dialogue( "cap_gdn_smashthroughthatwall" );
    thread maps\_utility::smart_radio_dialogue( "cap_gdn_illhangbackyou" );
    level thread dialogue_wallsmash_nag( "flag_mb1_start" );
    common_scripts\utility::flag_wait( "flag_mb1_start" );
    wait 3;
    maps\_utility::smart_radio_dialogue( "cap_sri_calibratingweapons" );
}

dialogue_wallsmash_nag( var_0 )
{
    self endon( var_0 );
    wait 7;
    var_1 = [ "cap_gdn_bustthroughthatwall", "cap_gdn_sprintthroughthat" ];
    level.player maps\captured_util::radio_dialogue_nag_loop( var_1, var_0, undefined, undefined, undefined, undefined, "flag_mech_vo_active" );
}

dialogue_mb1()
{
    smart_radio_dialogue_mb( "cap_sri_allweaponssystems" );
    common_scripts\utility::flag_set( "flag_mech_vo_active" );
    common_scripts\utility::flag_wait( "flag_mb1_mech_firstmove" );
    smart_radio_dialogue_mb( "cap_gdn_tangosinthebuildings" );
    smart_radio_dialogue_mb( "cap_gdn_burstthroughthewalls" );
    common_scripts\utility::flag_wait( "flag_mb1_fallback_idx2" );
    thread smart_radio_dialogue_mb( "cap_gdn_headtowardsthatwarehouse" );
    common_scripts\utility::flag_wait( "flag_mb1_end" );
}

dialogue_gid_rocket_reminder()
{
    maps\_utility_code::add_to_radio( "cap_gdn_thatrocketpacksa" );
    smart_radio_dialogue_mb( "cap_gdn_thatrocketpacksa" );
}

dialogue_gid_swarm_reminder()
{

}

dialogue_mb2_gatesmash()
{
    level endon( "flag_mb2_mech_smashing_doors" );
    smart_radio_dialogue_mb( "cap_gdn_bustthroughmitchell" );
    level thread dialogue_wallsmash_nag( "flag_mb2_mech_smashing_doors" );
}

dialogue_mb2()
{
    common_scripts\utility::flag_clear( "flag_mech_vo_active" );
    wait 1.5;
    smart_radio_dialogue_mb( "cap_sri_warninghullintegrity" );
    smart_radio_dialogue_mb( "cap_gdn_lotsoftangoslock" );
    common_scripts\utility::flag_set( "flag_mech_vo_active" );
    common_scripts\utility::flag_wait( "flag_mb2_mech_stencil_on" );
    smart_radio_dialogue_mb( "cap_sri_enemymechdetected" );
    common_scripts\utility::flag_wait_either( "flag_mb2_fallback_idx4", "flag_mb2_mechs_dead" );
    thread dialogue_mb2_gid_il_convo();

    if ( !common_scripts\utility::flag( "flag_final_vo" ) )
        smart_radio_dialogue_mb( "cap_sri_enemyvehicledetected" );

    common_scripts\utility::flag_wait( "flag_mb2_gateclose" );
}

dialogue_mb2_gid_il_convo()
{
    common_scripts\utility::flag_set( "flag_final_vo" );
    smart_radio_dialogue_mb( "cap_gdn_ilonawereapproaching" );
    smart_radio_dialogue_mb( "cap_iln_justgethrough" );
    common_scripts\utility::flag_clear( "flag_final_vo" );
}

smart_radio_dialogue_mb( var_0 )
{
    common_scripts\utility::flag_clear( "flag_mech_vo_active" );
    maps\_utility::smart_radio_dialogue( var_0 );
    common_scripts\utility::flag_set( "flag_mech_vo_active" );
}
