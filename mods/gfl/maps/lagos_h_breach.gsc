// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

precacheharmonicbreach()
{
    precacheharmonicbreachfx();
    precacheharmonicbreachitems();
    precacheharmonicbreachplayerrig();
    precacheharmonicbreachanimations();
}

startharmonicbreach( var_0 )
{
    initplayerforharmonicbreach();
    initallysquad( var_0 );
    thread initdistortionfx();

    foreach ( var_2 in level.allysquad )
        var_2.ignoreall = 1;

    thread breachtargetarraymonitor();
    thread breachtrigger();
    thread breachfailstate();
    thread breachdialogreminders();
    thread locktargets();
    thread hostagecorner();
    thread hostagebeatup();
    thread hostagepm();
    thread hostageexecution();
    thread h_breach_timer();
}

precacheharmonicbreachitems()
{
    precacheshellshock( "ak47" );
    precacheshellshock( "glock" );
    precachemodel( "viewhands_sentinel" );
    precacheshader( "nightvision_overlay_goggles" );
    precacheshader( "line_vertical" );
    precacheshader( "remote_chopper_hud_target_hit" );
}

precacheharmonicbreachfx()
{
    level._effect["distortion"] = loadfx( "vfx/distortion/distortion_harmonic_breach" );
    level._effect["pulse"] = loadfx( "vfx/weaponimpact/charged_shot_impact_3" );
    level._effect["execution_blood"] = loadfx( "fx/maps/warlord/execution_blood_fx" );
}

#using_animtree("player");

precacheharmonicbreachplayerrig()
{
    level.scr_anim["player_hbreach_wrist"]["h_breach_on"] = %vm_turn_on_cloak;
    level.scr_animtree["player_hbreach_wrist"] = #animtree;
    level.scr_model["player_hbreach_wrist"] = "s1_gfl_ump45_viewhands_player";
}

#using_animtree("generic_human");

precacheharmonicbreachanimations()
{
    level.scr_animtree["generic"] = #animtree;
    level.scr_anim["kva_guard_corner"]["hostage_corner"][0] = %prague_interrogate_1_soldier_idle;
    level.scr_anim["kva_hostage_corner"]["flythrough_hostage_corner_idle"][0] = %paris_ac130_hostage_cover_idle;
    level.scr_anim["kva_guard_corner"]["flythrough_hostage_corner_idle"][0] = %prague_interrogate_2_soldier_idle;
    level.scr_anim["kva_pm_guard"]["hostage_drag_idle"][0] = %prague_interrogate_2_soldier_idle;
    level.scr_anim["kva_pm_guard"]["execution_onknees_loop"][0] = %prague_interrogate_3_soldier_idle;
    level.scr_anim["kva_guard_beatup"]["flythrough_hostage_beatup_idle"][0] = %prague_interrogate_2_soldier_idle;
    level.scr_anim["kva_hostage_beatup"]["flythrough_hostage_beatup_idle"][0] = %paris_ac130_hostage_cover_idle;
    level.scr_anim["kva_hostage_execution_1"]["execution_onknees_loop"][0] = %africa_execution_prisoner_1_loop;
    level.scr_anim["kva_hostage_execution_2"]["execution_onknees_loop"][0] = %africa_execution_prisoner_2_loop;
    level.scr_anim["kva_hostage_execution_3"]["execution_onknees_loop"][0] = %africa_execution_prisoner_3_loop;
    level.scr_anim["kva_hostage_leader"]["civilian_smoking_A"][0] = %civilian_smoking_a;
    level.scr_anim["kva_hostage_leader"]["civilian_smoking_B"][0] = %civilian_smoking_b;
    level.scr_anim["kva_hostage_leader"]["civilian_hurried_walk"][0] = %civilian_walk_hurried_1;
    level.scr_anim["kva_hostage_leader"]["civilian_hurried_walk"][1] = %civilian_walk_hurried_2;
    level.scr_anim["kva_pm_guard"]["h_breach_marking"][0] = %lag_gov_hostage_room_breach_idle_kva_01;
    level.scr_anim["kva_hostage_leader"]["h_breach_marking"][0] = %lag_gov_hostage_room_breach_idle_kva_02;
    level.scr_anim["kva_guard_beatup"]["h_breach_marking"][0] = %lag_gov_hostage_room_breach_idle_kva_03;
    level.scr_anim["kva_guard_corner"]["h_breach_marking"][0] = %lag_gov_hostage_room_breach_idle_kva_04;
    level.scr_anim["kva_hostage_execution_1"]["h_breach_marking"][0] = %lag_gov_hostage_room_breach_idle_hostage_01;
    level.scr_anim["kva_hostage_execution_2"]["h_breach_marking"][0] = %lag_gov_hostage_room_breach_idle_hostage_02;
    level.scr_anim["kva_hostage_execution_3"]["h_breach_marking"][0] = %lag_gov_hostage_room_breach_idle_hostage_03;
    level.scr_anim["kva_hostage_minister"]["h_breach_marking"][0] = %lag_gov_hostage_room_breach_idle_hostage_04;
    level.scr_anim["kva_hostage_beatup"]["h_breach_marking"][0] = %lag_gov_hostage_room_breach_idle_hostage_05;
    level.scr_anim["kva_hostage_execution_3"]["h_breach_execution"] = %lag_gov_hostage_room_breach_execute_hostage_03;
    level.scr_anim["kva_guard_corner"]["h_breach_execution"] = %lag_gov_hostage_room_breach_execute_kva_04;
    maps\_anim::addnotetrack_customfunction( "kva_guard_corner", "fire", ::hostageexecutionseqvfx, "h_breach_execution" );
    maps\_anim::addnotetrack_customfunction( "kva_guard_corner", "execute", ::hostageexecutionseq, "h_breach_execution" );
}

drone_intro_conf_flythrough_actors( var_0 )
{
    level.kva_guard_beatup = maps\_utility::spawn_targetname( "kva_guard_beatup" );
    level.kva_guard_beatup.animname = "kva_guard_beatup";
    level.kva_guard_corner = maps\_utility::spawn_targetname( "kva_guard_corner" );
    level.kva_guard_corner.animname = "kva_guard_corner";
    level.kva_pm_guard = maps\_utility::spawn_targetname( "kva_pm_guard" );
    level.kva_pm_guard.animname = "kva_pm_guard";
    level.kva_hostage_beatup = maps\_utility::spawn_targetname( "kva_hostage_beatup" );
    level.kva_hostage_beatup.animname = "kva_hostage_beatup";
    var_0 thread maps\_anim::anim_single_solo( level.kva_guard_beatup, "drone_opening" );
    var_0 thread maps\_anim::anim_single_solo( level.kva_guard_corner, "drone_opening" );
    var_0 thread maps\_anim::anim_single_solo( level.kva_pm_guard, "drone_opening" );
    var_0 thread maps\_anim::anim_single_solo( level.kva_hostage_beatup, "drone_opening" );
    level.intro_actors = [ level.kva_guard_beatup, level.kva_guard_corner, level.kva_hostage_beatup, level.kva_pm_guard ];
    level.kva_hostage_execution_array = maps\_utility::array_spawn_targetname( "kva_hostage_execution" );
    var_1 = 1;

    foreach ( var_3 in level.kva_hostage_execution_array )
    {
        var_3.animname = "kva_hostage_execution_" + var_1;
        var_1++;
        level.intro_actors = common_scripts\utility::array_add( level.intro_actors, var_3 );
        var_0 thread maps\_anim::anim_single_solo( var_3, "drone_opening" );
    }

    level waittill( "drone_opening_finished" );

    foreach ( var_6 in level.intro_actors )
        var_6 delete();
}

swapwalldelayed()
{
    level thread maps\lagos_fx::harmonic_breach_turn_on();
    wait 1;
    level.xraywall_static = getentarray( "xraywall_static", "targetname" );
    level.xraywall_on = getentarray( "xraywall_on", "targetname" );
    common_scripts\utility::array_call( level.xraywall_static, ::hide );
    common_scripts\utility::array_call( level.xraywall_static, ::notsolid );
    common_scripts\utility::array_call( level.xraywall_on, ::show );
}

initdistortionfx()
{
    var_0 = common_scripts\utility::getstruct( "XrayPulse", "targetname" );
    thread swapwalldelayed();
    var_1 = [];
    var_2 = common_scripts\utility::getstructarray( "distortionfx", "targetname" );

    foreach ( var_4 in var_2 )
    {
        var_5 = var_4 common_scripts\utility::spawn_tag_origin();
        var_1 = common_scripts\utility::array_add( var_1, var_5 );
    }

    foreach ( var_5 in var_1 )
        var_8 = playfxontag( common_scripts\utility::getfx( "distortion" ), var_5, "tag_origin" );

    var_10 = newclienthudelem( level.player );
    var_10.color = ( 1, 0, 1 );
    var_10.alpha = 1;
    var_11 = 200;
    var_12 = 25;

    if ( level.currentgen )
    {
        var_11 = 175;
        var_12 = 3;
    }

    var_10 setharmonicbreach( 2, var_12, var_11, 2, 1 );
    maps\_player_exo::setharmonicbreachhudoutlinestyle();
    level waittill( "BreachComplete" );

    foreach ( var_5 in var_1 )
        var_8 = stopfxontag( common_scripts\utility::getfx( "distortion" ), var_5, "tag_origin" );

    level waittill( "kill_lcd_material" );
    maps\_player_exo::setdefaulthudoutlinestyle();
    var_10 destroy();
}

distortionfxtoggle()
{

}

initplayerforharmonicbreach()
{
    setupplayerhud();
    level.kva = [];
    level.hostages = [];
    level.breachtargets = [];
    setsaveddvar( "r_hudoutlineenable", 1 );
    setsaveddvar( "r_hudoutlinepostmode", 2 );
    setsaveddvar( "r_hudoutlinehaloblurradius", 0.5 );
    level.player.primaryweapon = "iw5_bal27_sp_variablereddot";
    thread playerhbreachwristequipment();
    level.player disableweapons();
    level.player allowjump( 0 );
    level.player allowcrouch( 0 );
    level.player allowprone( 0 );
    level.player disableweaponswitch();
    thread hostagemarktargetstext();
    level.player notifyonplayercommand( "MarkTarget", "+attack" );
    level.player notifyonplayercommand( "MarkTarget", "+attack_akimbo_accessible" );
    level.player thread tracelocation();
    level.player thread restoreplayeractions();
}

restoreplayeractions()
{
    level waittill( "BreachComplete" );
    level.player allowjump( 1 );
    level.player allowcrouch( 1 );
    level.player allowprone( 1 );
    level.player enableweaponswitch();
    level.player enableoffhandweapons();
}

initallysquad( var_0 )
{
    level.allysquad = var_0;
}

setupplayerhud()
{
    level.bpm = level.player maps\_hud_util::createclientfontstring( "default", 1.5 );
    level.bpm maps\_hud_util::setpoint( "CENTER", undefined, 0, 60 );
    level.bpm settext( "" );
    thread biometrichud();
}

biometrichud()
{
    level endon( "BreachFailed" );
    level endon( "LockTargets" );
    level endon( "Breach_Actor_Dead" );

    for (;;)
    {
        if ( isdefined( level.currenttarget ) && isai( level.currenttarget ) && level.currenttarget.team != "allies" )
        {
            var_0 = level.currenttarget.script_parameters;
            var_0 = int( var_0 );
            var_0 += randomintrange( -2, 2 );

            if ( isdefined( var_0 ) )
            {
                if ( !isdefined( level.hudelem_lagos_heart_rate ) )
                {
                    level.hudelem_lagos_heart_rate = get_heart_rate_hud( -505, 300 );
                    level.hudelem_lagos_heart_rate.label = &"LAGOS_HEART_RATE";
                    level.hudelem_lagos_heart_rate.fontscale = 1.5;
                    level.hudelem_lagos_heart_rate.color = ( 1, 1, 1 );
                    level.hudelem_lagos_heart_rate.alignx = "left";
                }

                if ( !isdefined( level.hudelem_lagos_heart_rate_bpmvar ) )
                {
                    level.hudelem_lagos_heart_rate_bpmvar = get_heart_rate_hud( -395, 300 );
                    level.hudelem_lagos_heart_rate_bpmvar.label = var_0;
                    level.hudelem_lagos_heart_rate_bpmvar.fontscale = 1.5;
                    level.hudelem_lagos_heart_rate_bpmvar.color = ( 1, 1, 1 );
                }

                if ( isdefined( level.hudelem_lagos_heart_rate_bpmvar ) )
                    level.hudelem_lagos_heart_rate_bpmvar.label = var_0;

                if ( !isdefined( level.hudelem_lagos_heart_rate_bpm ) )
                {
                    level.hudelem_lagos_heart_rate_bpm = get_heart_rate_hud( -355, 300 );
                    level.hudelem_lagos_heart_rate_bpm.label = &"LAGOS_BEATS_PER_MINUTE";
                    level.hudelem_lagos_heart_rate_bpm.fontscale = 1.5;
                    level.hudelem_lagos_heart_rate_bpm.color = ( 1, 1, 1 );
                    level.hudelem_lagos_heart_rate_bpm.alignx = "right";
                }
            }
        }
        else
            delete_heartrate_hud();

        wait 0.5;
    }
}

get_heart_rate_hud( var_0, var_1, var_2, var_3 )
{
    var_4 = var_0;
    var_5 = var_1;

    if ( isdefined( var_2 ) )
        var_6 = newclienthudelem( var_2 );
    else
        var_6 = newhudelem();

    var_6.alignx = "right";
    var_6.aligny = "middle";
    var_6.horzalign = "right";
    var_6.vertalign = "top";
    var_6.x = var_4;
    var_6.y = var_5;
    var_6.fontscale = 1.6;
    var_6.color = ( 0.8, 1, 0.8 );
    var_6.font = "objective";
    var_6.glowcolor = ( 0.3, 0.6, 0.3 );
    var_6.glowalpha = 1;
    var_6.foreground = 1;
    var_6.hidewheninmenu = 1;
    var_6.hidewhendead = 1;
    return var_6;
}

delete_heartrate_hud()
{
    if ( isdefined( level.hudelem_lagos_heart_rate ) )
        level.hudelem_lagos_heart_rate destroy();

    if ( isdefined( level.hudelem_lagos_heart_rate_bpmvar ) )
        level.hudelem_lagos_heart_rate_bpmvar destroy();

    if ( isdefined( level.hudelem_lagos_heart_rate_bpm ) )
        level.hudelem_lagos_heart_rate_bpm destroy();
}

setupaitargetmarkingvariables()
{
    self.currenttarget = 0;
    self.targetmarked = 0;
    self.health = 1;
}

disableaicombatreactions()
{
    maps\_utility::enable_dontevershoot();
    self.alertlevel = "noncombat";
    self.ignoreall = 1;
    self.favoriteenemy = undefined;
}

enableragdolldeath()
{
    level endon( "BreachComplete" );
    level endon( "BreachFailed" );
    self waittill( "death" );
    self.a.nodeath = 1;
    animscripts\notetracks::notetrackstartragdoll( "ragdoll" );
}

deathcleanup()
{
    level endon( "BreachComplete" );
    level endon( "BreachFailed" );
    self waittill( "death" );
    self hudoutlinedisable();

    if ( maps\_utility::is_in_array( level.breachtargets, self ) )
        level.breachtargets = common_scripts\utility::array_remove( level.breachtargets, self );

    level notify( "Breach_Actor_Dead" );
}

hostagepm()
{
    var_0 = getent( "anim_org_drone_opening", "targetname" );
    level.kva_hostage_leader = maps\_utility::spawn_targetname( "kva_hostage_leader_post_pcap" );
    level.kva_hostage_leader setthreatdetection( "disable" );
    level.kva = common_scripts\utility::array_add( level.kva, level.kva_hostage_leader );
    level.kva_hostage_leader.animname = "kva_hostage_leader";
    level.kva_hostage_leader.maxhealth = 1;
    level.kva_hostage_leader.health = 1;
    level.kva_hostage_minister = maps\_utility::spawn_targetname( "kva_hostage_minister" );
    level.hostages = common_scripts\utility::array_add( level.hostages, level.kva_hostage_minister );
    level.kva_hostage_minister.animname = "kva_hostage_minister";
    level.kva_hostage_minister maps\_utility::add_damage_function( ::hostagedeathdetection );
    level.kva_hostage_minister.name = "";
    var_1 = [ level.kva_hostage_leader, level.kva_hostage_minister ];
    common_scripts\utility::array_thread( var_1, ::setupaitargetmarkingvariables );
    common_scripts\utility::array_thread( var_1, ::deathcleanup );

    if ( isalive( level.kva_hostage_leader ) && isalive( level.kva_hostage_minister ) )
    {
        var_0 thread maps\_anim::anim_loop( var_1, "h_breach_marking" );

        foreach ( var_3 in var_1 )
            var_3 maps\_utility::set_allowdeath( 1 );
    }
}

hostagebeatup()
{
    var_0 = getent( "anim_org_drone_opening", "targetname" );
    level.kva_guard_beatup = maps\_utility::spawn_targetname( "kva_guard_beatup" );
    level.kva_guard_beatup setthreatdetection( "disable" );
    level.kva = common_scripts\utility::array_add( level.kva, level.kva_guard_beatup );
    level.kva_guard_beatup.animname = "kva_guard_beatup";
    level.kva_guard_beatup maps\_utility::gun_remove();
    level.kva_guard_beatup.maxhealth = 1;
    level.kva_guard_beatup.health = 1;
    level.kva_hostage_beatup = maps\_utility::spawn_targetname( "kva_hostage_beatup" );
    level.hostages = common_scripts\utility::array_add( level.hostages, level.kva_hostage_beatup );
    level.kva_hostage_beatup.animname = "kva_hostage_beatup";
    level.kva_hostage_beatup thread enableragdolldeath();
    level.kva_hostage_beatup maps\_utility::add_damage_function( ::hostagedeathdetection );
    var_1 = [ level.kva_guard_beatup, level.kva_hostage_beatup ];
    common_scripts\utility::array_thread( var_1, ::setupaitargetmarkingvariables );
    common_scripts\utility::array_thread( var_1, ::deathcleanup );
    var_0 thread maps\_anim::anim_loop( var_1, "h_breach_marking" );

    foreach ( var_3 in var_1 )
        var_3 maps\_utility::set_allowdeath( 1 );
}

hostagecorner()
{
    var_0 = getent( "anim_org_drone_opening", "targetname" );
    level.kva_pm_guard = maps\_utility::spawn_targetname( "kva_pm_guard" );
    level.kva_pm_guard setthreatdetection( "disable" );
    level.kva = common_scripts\utility::array_add( level.kva, level.kva_pm_guard );
    level.kva_pm_guard.animname = "kva_pm_guard";
    level.kva_pm_guard.maxhealth = 1;
    level.kva_pm_guard.health = 1;
    var_1 = [ level.kva_pm_guard ];
    common_scripts\utility::array_thread( var_1, ::setupaitargetmarkingvariables );
    common_scripts\utility::array_thread( var_1, ::deathcleanup );
    var_0 thread maps\_anim::anim_loop( var_1, "h_breach_marking" );

    foreach ( var_3 in var_1 )
        var_3 maps\_utility::set_allowdeath( 1 );
}

hostageexecution()
{
    level endon( "BreachComplete" );
    level endon( "BreachFailed" );
    level.kva_guard_corner = maps\_utility::spawn_targetname( "kva_guard_corner" );
    level.kva_guard_corner setthreatdetection( "disable" );
    level.kva_guard_corner endon( "death" );
    level.kva_guard_corner.animname = "kva_guard_corner";
    level.kva_guard_corner.battlechatter = 0;
    level.kva_guard_corner.sidearm = "glock";
    level.kva_guard_corner thread deathcleanup();
    level.kva_guard_corner maps\_utility::set_allowdeath( 1 );
    level.kva_guard_corner.maxhealth = 1;
    level.kva_guard_corner.health = 1;
    level.kva = common_scripts\utility::array_add( level.kva, level.kva_guard_corner );
    level.executionhostages = maps\_utility::array_spawn_targetname( "kva_hostage_execution" );
    level.hostages = maps\_utility::array_merge( level.hostages, level.executionhostages );
    level.executionhostages[0] thread hostageexecutiondeath();
    level.executionhostages[1] thread hostageexecutiondeath();
    level.executionhostages[2] thread hostageexecutiondeath();
    var_0 = 1;

    foreach ( var_2 in level.executionhostages )
    {
        var_2.animname = "kva_hostage_execution_" + var_0;
        var_0++;
        var_2.team = "axis";
        var_2 thread enableragdolldeath();
        var_2 thread deathcleanup();
        var_2 maps\_utility::add_damage_function( ::hostagedeathdetection );
    }

    var_4 = common_scripts\utility::array_add( level.executionhostages, level.kva_guard_corner );
    common_scripts\utility::array_thread( var_4, ::setupaitargetmarkingvariables );
    var_5 = getent( "anim_org_drone_opening", "targetname" );
    var_5 thread maps\_anim::anim_loop( level.executionhostages, "h_breach_marking", "hostage_start_execution" );
    var_5 thread maps\_anim::anim_loop_solo( level.kva_guard_corner, "h_breach_marking", "guard_start_execution" );
    level waittill( "h_breach_timer_done" );
    var_5 notify( "guard_start_execution" );
    var_5 maps\_anim::anim_reach_solo( level.kva_guard_corner, "h_breach_execution" );
    var_5 thread maps\_anim::anim_single_solo( level.executionhostages[2], "h_breach_execution" );
    var_5 maps\_anim::anim_single_solo( level.kva_guard_corner, "h_breach_execution" );

    foreach ( var_7 in var_4 )
        var_7 maps\_utility::set_allowdeath( 1 );
}

h_breach_timer()
{
    level endon( "BreachComplete" );
    wait 23;
    level notify( "execution_start" );
    wait 5;
    level notify( "h_breach_timer_done" );
}

hostageexecutionseq( var_0 )
{
    level endon( "BreachComplete" );
    wait 0.5;
    level notify( "BreachFailed" );
}

hostageexecutionseqvfx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "execution_blood" ), level.executionhostages[2], "J_Head" );
}

hostageexecutiondeath()
{
    level endon( "BreachComplete" );
    level endon( "BreachFailed" );
    self waittill( "death" );
    wait 0.75;
    level notify( "BreachFailed" );
}

tracelocation()
{
    level endon( "Breach_Actor_Dead" );
    level endon( "BreachFailed" );
    level endon( "LockTargets" );

    for (;;)
    {
        var_0 = self geteye();
        var_1 = self getangles();
        var_2 = anglestoforward( var_1 );
        var_3 = var_0 + var_2 * 250000;
        var_4 = bullettrace( var_0, var_3, 1, self, 0, 1, 0, 0, 0 );
        var_5 = var_4["entity"];
        level.currenttarget = var_5;

        if ( isdefined( var_5 ) && isai( var_5 ) && var_5.team != "allies" )
        {
            if ( var_5.currenttarget == 0 )
                var_5 thread activetarget();
        }
        else if ( !isdefined( var_5 ) || !isai( var_5 ) )
            level.player notify( "TargetLostAll" );

        waitframe();
    }
}

activetarget()
{
    self endon( "death" );
    level endon( "BreachComplete" );
    level endon( "BreachFailed" );
    thread targetmonitor();
    thread tagtarget();

    if ( self.targetmarked == 0 )
    {
        soundscripts\_snd::snd_message( "hb_highlight_enable" );
        self hudoutlineenable( 3, 1 );
    }

    waittill_either_differnt_senders( level.player, "TargetLostAll", self, "TargetLost" );

    if ( self.targetmarked == 0 )
    {
        soundscripts\_snd::snd_message( "hb_highlight_disable" );
        self hudoutlinedisable();
    }
}

waittill_either_differnt_senders( var_0, var_1, var_2, var_3 )
{
    var_0 endon( var_1 );
    var_2 waittill( var_3 );
}

targetmonitor()
{
    self endon( "death" );
    level endon( "BreachComplete" );
    level endon( "BreachFailed" );
    self.currenttarget = 1;

    if ( isdefined( level.currenttarget ) )
    {
        while ( isdefined( level.currenttarget ) && level.currenttarget == self )
            waitframe();
    }

    self.currenttarget = 0;
    self notify( "TargetLost" );
}

tagtarget()
{
    level endon( "BreachComplete" );
    level endon( "BreachFailed" );
    level endon( "LockTargets" );
    level.player endon( "TargetLostAll" );
    self endon( "TargetLost" );

    for (;;)
    {
        level.player waittill( "MarkTarget" );
        level notify( "player_marking_targets" );

        if ( self.targetmarked == 0 )
        {
            if ( level.breachtargets.size <= 4 )
            {
                level.breachtargets = common_scripts\utility::array_add( level.breachtargets, self );
                soundscripts\_snd::snd_message( "hb_target_tagged" );
                self.targetmarked = 1;
                self hudoutlineenable( 1, 1 );

                if ( self.script_noteworthy == "KVA" )
                    level notify( "check_target_confirm" );

                if ( self.script_noteworthy == "Hostage" )
                    level notify( "check_target_correction" );
            }
        }
        else if ( self.targetmarked == 1 )
        {
            self.targetmarked = 0;
            soundscripts\_snd::snd_message( "hb_target_untagged" );
            self hudoutlineenable( 3, 1 );
            level.breachtargets = common_scripts\utility::array_remove( level.breachtargets, self );
        }

        if ( self.targetmarked == 1 )
            waitframe();
    }
}

breachtargetarraymonitor()
{
    level endon( "BreachComplete" );
    level endon( "BreachFailed" );
    level endon( "LockTargets" );
    var_0 = 0;

    for (;;)
    {
        if ( level.breachtargets.size >= 4 )
        {
            if ( var_0 == 0 )
            {
                thread hostagelocktargetstext();
                var_0 = 1;
            }
        }
        else if ( var_0 == 1 )
        {
            thread hostagemarktargetstext();
            var_0 = 0;
        }

        waitframe();
    }
}

locktargets()
{
    for (;;)
    {
        for ( var_0 = 0; level.breachtargets.size >= 4; var_0 = 1 )
        {
            if ( level.player usebuttonpressed() )
            {
                level notify( "LockTargets" );
                soundscripts\_snd::snd_message( "hb_lock_targets" );
                thread hostageclearmarklocktext();
                level.bpm settext( "" );
                level waittill( "arms_down" );
                level.player enableweapons();
                level.player disableoffhandweapons();
                level.player switchtoweapon( level.player.primaryweapon );
                level.player thread h_breach_bullet_decals();
                return;
            }

            waitframe();
        }

        if ( !var_0 )
            waitframe();
    }
}

breachdialogreminders()
{
    level endon( "BreachFailed" );
    level endon( "Breach_Actor_Dead" );

    for (;;)
    {
        if ( level.breachtargets.size == 4 )
        {
            thread maps\lagos_vo::harmonic_breach_shoot_now_dialogue();
            wait(randomfloatrange( 5, 10 ));
        }

        waitframe();
    }
}

breachtrigger()
{
    level endon( "BreachFailed" );
    level waittill( "Breach_Actor_Dead" );
    thread hostageclearmarklocktext();
    level.bpm settext( "" );

    if ( level.breachtargets.size > 0 )
    {
        var_0 = getentarray( "NoSight", "targetname" );

        foreach ( var_2 in var_0 )
            var_2 delete();

        thread togglebreachslomo();
        waitframe();
        thread h_breach_hostile_elim();
        thread h_breach_multi_sync_kill_player_god();
        maps\_utility::waittill_dead_or_dying( level.breachtargets );
    }

    var_4 = returnfilterednoteworthyarray( "KVA" );

    if ( var_4.size == 0 )
    {
        soundscripts\_snd::snd_message( "hb_shots_fired" );
        level notify( "BreachComplete" );
        level notify( "player_god_off" );
        wait 1;
        level notify( "HostageMonitorOff" );
        soundscripts\_snd::snd_message( "hb_sensor_flash_off" );
        common_scripts\utility::array_call( level.xraywall_static, ::show );
        common_scripts\utility::array_call( level.xraywall_static, ::solid );
        common_scripts\utility::array_call( level.xraywall_on, ::hide );
        level notify( "h_breach_wall_solid" );
        thread remove_h_breach_hostages();
    }
    else
    {
        soundscripts\_snd::snd_message( "hb_shots_fired" );
        level notify( "BreachFailed" );
    }
}

remove_h_breach_hostages()
{
    if ( !common_scripts\utility::flag( "post_h_breach_playerstart" ) )
    {
        foreach ( var_1 in level.hostages )
        {
            if ( isdefined( var_1 ) )
            {
                var_1 notify( "internal_stop_magic_bullet_shield" );
                var_1 delete();
            }
        }

        foreach ( var_4 in level.kva )
        {
            if ( isdefined( var_4 ) )
                var_4 delete();
        }
    }
}

shootenemy( var_0 )
{
    self endon( "death" );
    maps\_utility::disable_surprise();
    maps\_utility::disable_bulletwhizbyreaction();
    self.alertlevel = "combat";
    var_1 = self.baseaccuracy;
    maps\_utility::disable_dontevershoot();
    self.ignoreall = 0;
    self.baseaccuracy = 50000;

    if ( isdefined( var_0 ) && isalive( var_0 ) )
    {
        self.favoriteenemy = var_0;
        var_0 waittill( "death" );
    }

    self.baseaccuracy = var_1;
    self.favoriteenemy = undefined;
    self.ignoreall = 1;
    maps\_utility::enable_dontevershoot();
}

shootkva_enemyindexer( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        if ( var_0 == var_1[var_2] )
            return var_2;
    }
}

shootkva()
{
    self endon( "death" );
    maps\_utility::disable_surprise();
    maps\_utility::disable_bulletwhizbyreaction();
    self.alertlevel = "combat";
    self.old_accuracy = self.baseaccuracy;
    maps\_utility::disable_dontevershoot();
    self.ignoreall = 0;
    self.baseaccuracy = 50000;

    if ( self.animname == "burke" )
    {
        if ( isalive( level.kva[0] ) )
        {
            self.favoriteenemy = level.kva[0];
            level.kva[0] waittill( "death" );
            waitframe();
        }
    }

    if ( self.animname == "joker" )
    {
        if ( isalive( level.kva[1] ) )
        {
            self.favoriteenemy = level.kva[1];
            level.kva[1] waittill( "death" );
            waitframe();
        }
    }

    if ( self.animname == "ajani" )
    {
        if ( isalive( level.kva[2] ) )
        {
            self.favoriteenemy = level.kva[2];
            level.kva[2] waittill( "death" );
            waitframe();
        }
    }

    self.baseaccuracy = self.old_accuracy;
    self.favoriteenemy = undefined;
    self.ignoreall = 1;
    maps\_utility::enable_dontevershoot();
}

h_breach_hostile_elim()
{
    var_0 = common_scripts\utility::getstructarray( "magic_bullet_loc_h", "targetname" );
    var_0 = common_scripts\utility::array_randomize( var_0 );
    thread h_breach_multi_sync_kills( level.breachtargets, var_0 );
}

togglebreachslomo()
{
    setslowmotion( 1, 0.65, 0.45 );
    wait 2;
    setslowmotion( 0.45, 1, 0.65 );
}

breachfailstate()
{
    level endon( "BreachComplete" );
    level waittill( "BreachFailed" );
    level notify( "DisableBreachTrigger" );
    thread togglebreachslomo();
    level.player disableweapons();
    setsaveddvar( "r_hudoutlineenable", 0 );
    thread hostageclearmarklocktext();
    level.bpm settext( "" );
    common_scripts\utility::array_thread( level.hostages, ::teamswap, "allies" );
    common_scripts\utility::array_thread( level.allysquad, ::disableaicombatreactions );
    delete_heartrate_hud();
    setdvar( "ui_deadquote", &"LAGOS_HBREACH_FAILED" );
    maps\_utility::missionfailedwrapper();
}

removeharmonicbreachhostages()
{
    foreach ( var_1 in level.hostages )
        var_1 delete();
}

returnfilterednoteworthyarray( var_0 )
{
    var_1 = getentarray( var_0, "script_noteworthy" );
    var_1 = maps\_utility::array_removedead_or_dying( var_1 );
    var_1 = common_scripts\utility::array_removeundefined( var_1 );
    return var_1;
}

stopscriptedanimations()
{
    if ( isdefined( self ) && isalive( self ) )
        self stopanimscripted();
}

teamswap( var_0 )
{
    if ( isdefined( self ) && isalive( self ) )
        self.team = var_0;
}

hostagedeathdetection( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    delete_heartrate_hud();
    setdvar( "ui_deadquote", &"LAGOS_HBREACH_FAILED" );
    maps\_utility::missionfailedwrapper();
}

hostagemarktargetstext()
{
    maps\_utility::hint( &"LAGOS_HBREACH_TARGET" );
}

hostagelocktargetstext()
{
    maps\_utility::hint( &"LAGOS_HBREACH_LOCK" );
}

hostageclearmarklocktext()
{
    maps\_utility::hint( "" );
}

playerhbreachwristequipment()
{
    thread playerhudelements();
    thread playerwristmodelanim();
}

playerhudelements()
{
    var_0 = "remote_chopper_hud_target_hit";
    var_1 = newclienthudelem( level.player );
    var_1 setshader( var_0, 32, 32 );
    var_1.x = 0;
    var_1.y = 0;
    var_1.alignx = "center";
    var_1.aligny = "middle";
    var_1.horzalign = "center";
    var_1.vertalign = "middle";
    var_1.alpha = 1;
    level waittill( "LockTargets" );
    var_1 maps\_hud_util::destroyelem();
    delete_heartrate_hud();
}

playerwristmodelanim()
{
    var_0 = maps\_utility::spawn_anim_model( "player_hbreach_wrist", level.player.origin );
    var_0 linktoplayerview( level.player, "tag_origin", ( 0, 0, -2 ), ( 0, 0, 0 ), 1 );
    level.player thread maps\_anim::anim_single_solo( var_0, "h_breach_on" );
    level waittill( "LockTargets" );
    level.player maps\_anim::anim_set_rate_single( var_0, "h_breach_on", 1 );
    wait 0.7;
    var_0 delete();
    level notify( "arms_down" );
}

h_breach_multi_sync_kills( var_0, var_1 )
{
    level.target_array = var_0;
    level.shoot_point_array = [];
    level.shoot_point_array[level.shoot_point_array.size] = level.burke gettagorigin( "tag_flash" );
    level.shoot_point_array[level.shoot_point_array.size] = level.joker gettagorigin( "tag_flash" );
    level.shoot_point_array[level.shoot_point_array.size] = level.ajani gettagorigin( "tag_flash" );
    thread h_breach_multi_sync_kills_timeout();

    while ( level.target_array.size > 0 )
    {
        level.target_array = maps\_utility::array_removedead_or_dying( level.target_array );

        if ( isalive( level.target_array[0] ) )
        {
            var_2 = level.target_array[0];
            var_3 = level.shoot_point_array[0];
            level.target_array = common_scripts\utility::array_remove( level.target_array, level.target_array[0] );
            level.shoot_point_array = common_scripts\utility::array_remove( level.shoot_point_array, level.shoot_point_array[0] );
            thread h_breach_multi_sync_kill_shooter( var_2, var_3 );
        }

        waitframe();
    }
}

h_breach_multi_sync_kills_timeout()
{
    wait 0.15;

    foreach ( var_1 in level.kva )
    {
        if ( isalive( var_1 ) )
            var_1 kill();
    }
}

h_breach_multi_sync_kill_shooter( var_0, var_1 )
{
    var_0.maxhealth = 1;
    var_0.health = 1;
    var_2 = var_0 gettagorigin( "TAG_EYE" );

    while ( isalive( var_0 ) )
    {
        if ( !isdefined( var_1 ) )
        {
            waitframe();
            continue;
        }

        magicbullet( "iw5_bal27_sp", var_1, var_2 );
        level notify( "h_breach_shot", var_1, var_2 );
        wait(randomfloatrange( 0.07, 0.1 ));
    }

    level.shoot_point_array = common_scripts\utility::array_add( level.shoot_point_array, var_1 );
    level.shoot_point_array = common_scripts\utility::array_randomize( level.shoot_point_array );
}

h_breach_multi_sync_kill_player_god()
{
    level.player enableinvulnerability();
    level waittill( "player_god_off" );
    level.player disableinvulnerability();
}

h_breach_bullet_decals()
{
    self waittill( "weapon_fired" );
    var_0 = [];
    var_0[var_0.size] = spawnstruct();
    var_1 = self geteye();
    var_2 = self geteye() + anglestoforward( self getgunangles() ) * 100;
    var_0[0].start = var_1;
    var_0[0].end = var_2;

    switch ( level.breachtargets.size )
    {
        case 3:
            level waittill( "h_breach_shot", var_1, var_2 );
            var_3 = var_0.size;
            var_0[var_3] = spawnstruct();
            var_0[var_3].start = var_1;
            var_0[var_3].end = var_2;
        case 2:
            level waittill( "h_breach_shot", var_1, var_2 );
            var_3 = var_0.size;
            var_0[var_3] = spawnstruct();
            var_0[var_3].start = var_1;
            var_0[var_3].end = var_2;
        case 1:
            level waittill( "h_breach_shot", var_1, var_2 );
            var_3 = var_0.size;
            var_0[var_3] = spawnstruct();
            var_0[var_3].start = var_1;
            var_0[var_3].end = var_2;
        default:
            break;
    }

    level waittill( "h_breach_wall_solid" );

    foreach ( var_5 in var_0 )
    {
        h_breach_bullet_spawn_decal( var_5.start, var_5.end );
        h_breach_bullet_spawn_decal( var_5.end, var_5.start );
    }
}

h_breach_bullet_spawn_decal( var_0, var_1 )
{
    var_2 = bullettrace( var_0, var_1, 0 );
    var_3 = var_2["position"];
    var_4 = var_2["normal"] * 360 + ( 0, 90, 0 );
    var_5 = var_2["normal"] * 360;

    if ( !isdefined( var_2["entity"] ) || isdefined( var_2["entity"].targetname ) && var_2["entity"].targetname == "xraywall_static" )
        playfx( common_scripts\utility::getfx( "lag_harmonic_breach_bullet_decal_" + ( randomint( 4 ) + 1 ) ), var_3, var_4, var_5 );
}
