// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

teleport_to_scriptstruct( var_0 )
{
    var_1 = common_scripts\utility::getstruct( var_0, "script_noteworthy" );
    level.player setorigin( var_1.origin );

    if ( isdefined( var_1.angles ) )
        level.player setangles( var_1.angles );

    var_2 = getentarray( "hero", "script_noteworthy" );

    foreach ( var_4 in var_2 )
    {
        if ( isspawner( var_4 ) )
            var_2 = common_scripts\utility::array_remove( var_2, var_4 );
    }

    var_6 = common_scripts\utility::getstructarray( var_1.target, "targetname" );

    for ( var_7 = 0; var_7 < var_2.size; var_7++ )
    {
        if ( var_7 < var_6.size )
        {
            var_2[var_7] forceteleport( var_6[var_7].origin, var_6[var_7].angles );
            var_2[var_7] setgoalpos( var_6[var_7].origin );
            continue;
        }

        var_2[var_7] forceteleport( level.player.origin, level.player.angles );
        var_2[var_7] setgoalpos( level.player.origin );
    }
}

equip_microwave_grenade()
{
    self.grenadeweapon = "microwave_grenade";
    self.grenadeammo = 2;
}

add_to_threat_bias( var_0 )
{
    if ( self.classname == "script_model" )
        return;

    createthreatbiasgroup( var_0 );
    self setthreatbiasgroup( var_0 );
}

set_flag_when_in_volume( var_0, var_1 )
{
    self endon( "death" );

    while ( !self istouching( var_0 ) )
        wait 0.05;

    common_scripts\utility::flag_set( var_1 );
}

bloody_death( var_0 )
{
    self endon( "death" );

    if ( !issentient( self ) || !isalive( self ) )
        return;

    if ( isdefined( self.bloody_death ) && self.bloody_death )
        return;

    self.bloody_death = 1;

    if ( isdefined( var_0 ) )
        wait(randomfloat( var_0 ));

    var_1 = [];
    var_1[0] = "j_hip_le";
    var_1[1] = "j_hip_ri";
    var_1[2] = "j_head";
    var_1[3] = "j_spine4";
    var_1[4] = "j_elbow_le";
    var_1[5] = "j_elbow_ri";
    var_1[6] = "j_clavicle_le";
    var_1[7] = "j_clavicle_ri";

    for ( var_2 = 0; var_2 < 3 + randomint( 5 ); var_2++ )
    {
        var_3 = randomintrange( 0, var_1.size );
        thread bloody_death_fx( var_1[var_3], undefined );
        wait(randomfloat( 0.1 ));
    }

    self dodamage( self.health + 50, self.origin );
}

bloody_death_fx( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = level._effect["flesh_hit"];

    playfxontag( var_1, self, var_0 );
}

wait_for_number_enemies_alive( var_0 )
{
    level.player endon( "death" );

    while ( getaicount( "axis" ) > var_0 )
        wait 0.05;
}

temp_subtitle( var_0, var_1 )
{
    var_2 = newhudelem();
    var_2.x = 0;
    var_2.y = -42;
    var_2 settext( var_0 );
    var_2.fontscale = 1.46;
    var_2.alignx = "center";
    var_2.aligny = "middle";
    var_2.horzalign = "center";
    var_2.vertalign = "bottom";
    var_2.sort = 1;
    wait(var_1);
    var_2 destroy();
}

setup_level_rumble_ent()
{
    if ( !isdefined( level.rumble_ent ) )
        level.rumble_ent = maps\_utility::get_rumble_ent( "steady_rumble", 0.0 );

    level.rumble_ent.intensity = 0.0;
}

rumble_set_ent_rumble_intensity_for_time( var_0, var_1, var_2 )
{
    var_0.intensity = var_1;
    wait(var_2);
    var_0.intensity = 0.0;
}

enemy_is_in_vehicle()
{
    return isdefined( self.ridingvehicle );
}

hide_friendname_until_flag_or_notify( var_0 )
{
    if ( !isdefined( self.name ) )
        return;

    level.player endon( "death" );
    self endon( "death" );
    self.old_name = self.name;
    self.name = " ";

    if ( common_scripts\utility::flag_exist( var_0 ) )
        common_scripts\utility::flag_wait( var_0 );
    else
        level waittill( var_0 );

    self.name = self.old_name;
}

kill_no_react()
{
    if ( !isalive( self ) )
        return;

    self.allowdeath = 1;
    self.a.nodeath = 1;
    thread maps\_utility::set_battlechatter( 0 );
    self kill();
}

drone_track_player()
{
    self endon( "death" );

    for (;;)
    {
        var_0 = anglestoforward( level.player getangles() ) * 512;
        var_0 += ( randomintrange( -300, 300 ), randomintrange( -300, 300 ), randomintrange( 96, 164 ) );
        var_1 = level.player geteye() + var_0;
        var_2 = 3;

        if ( bullettracepassed( self gettagorigin( "tag_flash" ), var_1, 0, self ) )
        {
            self vehicle_setspeedimmediate( 40 );
            self setvehgoalpos( var_1 );
            self waittill( "goal" );
            self vehicle_setspeedimmediate( 0 );
        }
        else
        {
            wait(randomfloatrange( 2.0, 5.0 ));
            continue;
        }

        wait(randomfloatrange( 5.0, 10.0 ));
    }
}

drone_fire_timing()
{
    self endon( "death" );

    for (;;)
    {
        maps\_utility::ent_flag_set( "fire_disabled" );
        wait(randomfloatrange( 3.0, 5.0 ));
        maps\_utility::ent_flag_clear( "fire_disabled" );
        wait(randomfloatrange( 1.0, 3.0 ));
    }
}

init_bobbing_boats()
{
    level.bobbing_objects = [];
    var_0 = maps\_bobbing_boats::createdefaultbobsettings();
    var_1 = getentarray( "bobbing_ship", "script_noteworthy" );
    maps\_bobbing_boats::prep_bobbing( var_1, maps\_bobbing_boats::bobbingobject, var_0, 0 );
    level.bobbing_objects = maps\_shg_utility::array_combine_unique( level.bobbing_objects, var_1 );
    var_2 = maps\_bobbing_boats::createdefaultbobsettings();
    var_2.max_pitch = 1.0;
    var_3 = getentarray( "bobbing_ship_big", "script_noteworthy" );
    maps\_bobbing_boats::prep_bobbing( var_3, maps\_bobbing_boats::bobbingobject, var_2, 0 );
    level.bobbing_objects = maps\_shg_utility::array_combine_unique( level.bobbing_objects, var_3 );
    maps\_bobbing_boats::start_bobbing( level.bobbing_objects );
}

warbird_shooting_think( var_0 )
{
    level.player endon( "death" );
    self endon( "death" );
    self.mgturret[0] setmode( "manual" );
    self.mgturret[1] setmode( "manual" );

    if ( !maps\_utility::ent_flag_exist( "fire_turrets" ) )
        maps\_utility::ent_flag_init( "fire_turrets" );

    maps\_utility::ent_flag_set( "fire_turrets" );
    thread warbird_fire_monitor();

    for (;;)
    {
        self waittill( "warbird_fire" );
        thread warbird_fire( var_0 );
    }
}

warbird_fire( var_0 )
{
    self endon( "death" );
    var_1 = self.mgturret[0];
    var_2 = self.mgturret[1];
    var_3 = 3;

    while ( maps\_utility::ent_flag( "fire_turrets" ) )
    {
        var_4 = getaiarray( "allies" );

        if ( !maps\_utility::ent_flag_exist( "dont_shoot_player" ) || !maps\_utility::ent_flag( "dont_shoot_player" ) )
        {
            var_5 = 33;

            if ( randomint( 100 ) <= var_5 )
                var_4 = common_scripts\utility::array_add( var_4, level.player );
        }

        var_6 = [];

        foreach ( var_8 in var_4 )
        {
            if ( isdefined( var_8.ignoreme ) && var_8.ignoreme )
                continue;
            else
                var_6[var_6.size] = var_8;
        }

        var_6 = sortbydistance( var_6, self.origin );
        var_10 = undefined;

        foreach ( var_8 in var_6 )
        {
            if ( !isdefined( var_8 ) )
                continue;

            if ( !isalive( var_8 ) )
                continue;

            if ( isdefined( var_0 ) && var_0 )
            {
                var_12 = self.mgturret[0] gettagorigin( "tag_flash" );
                var_13 = var_8 geteye();
                var_14 = vectornormalize( var_13 - var_12 );
                var_15 = var_13 + var_14 * 20;

                if ( !sighttracepassed( var_15, var_13, 0, var_8, self.mgturret[0] ) )
                    continue;
            }

            var_10 = var_8;
            break;
        }

        if ( isdefined( var_10 ) )
        {
            var_1 settargetentity( var_10 );
            var_2 settargetentity( var_10 );
            var_1 turretfireenable();
            var_2 turretfireenable();
            var_1 startfiring();
            var_2 startfiring();
            wait_for_warbird_fire_target_done( var_10, var_0 );
            var_1 cleartargetentity();
            var_2 cleartargetentity();
            var_1 turretfiredisable();
            var_2 turretfiredisable();
        }

        wait(var_3);
    }

    var_1 turretfiredisable();
    var_2 turretfiredisable();
}

wait_for_warbird_fire_target_done( var_0, var_1 )
{
    var_0 endon( "death" );

    if ( !maps\_utility::ent_flag( "fire_turrets" ) )
        return;

    self endon( "fire_turrets" );

    if ( var_0 == level.player )
        var_2 = 0.6;
    else
        var_2 = 3;

    var_3 = 0;

    while ( var_3 < var_2 )
    {
        if ( isdefined( var_1 ) && var_1 )
        {
            var_4 = self.mgturret[0] gettagorigin( "tag_flash" );
            var_5 = var_0 geteye();
            var_6 = vectornormalize( var_5 - var_4 );
            var_7 = var_4 + var_6 * 20;

            if ( !sighttracepassed( var_7, var_5, 0, var_0, self.mgturret[0] ) )
                return;
        }

        var_3 += 0.3;
        wait 0.3;
    }
}

warbird_fire_monitor()
{
    self endon( "death" );
    self waittill( "warbird_stop_firing" );
    maps\_utility::ent_flag_clear( "fire_turrets" );
}

ambient_warbird_wait_to_fire()
{
    self endon( "death" );
    level endon( "stop_ambient_warbird_firing" );

    if ( !maps\_utility::ent_flag_exist( "ambient_warbird_fire" ) )
        maps\_utility::ent_flag_init( "ambient_warbird_fire" );

    for (;;)
    {
        maps\_utility::ent_flag_wait( "ambient_warbird_fire" );
        self notify( "fire_turrets" );
        maps\_utility::ent_flag_set( "fire_turrets" );
        self notify( "warbird_fire" );
        maps\_utility::ent_flag_waitopen( "ambient_warbird_fire" );
        self notify( "warbird_stop_firing" );
        maps\_utility::ent_flag_clear( "fire_turrets" );
    }
}

ambient_warbird_shooting_think( var_0 )
{
    self endon( "death" );
    self.mgturret[0] setmode( "manual" );
    self.mgturret[1] setmode( "manual" );

    if ( !maps\_utility::ent_flag_exist( "fire_turrets" ) )
        maps\_utility::ent_flag_init( "fire_turrets" );

    maps\_utility::ent_flag_set( "fire_turrets" );

    for (;;)
    {
        self waittill( "warbird_fire" );
        thread ambient_warbird_fire();
    }
}

ambient_warbird_fire()
{
    self endon( "death" );
    level endon( "stop_ambient_warbird_firing" );
    var_0 = self.mgturret[0];
    var_1 = self.mgturret[1];
    var_2 = 2;

    while ( maps\_utility::ent_flag( "fire_turrets" ) )
    {
        var_3 = getentarray( "ambient_warbird_targets", "script_noteworthy" );
        var_3 = sortbydistance( var_3, self.origin );
        var_4 = var_3[0];

        if ( isdefined( var_4 ) )
        {
            var_0 settargetentity( var_4 );
            var_1 settargetentity( var_4 );
            var_0 turretfireenable();
            var_1 turretfireenable();
            var_0 startfiring();
            var_1 startfiring();
            wait(var_2);
            var_0 cleartargetentity();
            var_1 cleartargetentity();
            var_0 turretfiredisable();
            var_1 turretfiredisable();
        }

        wait 0.05;
    }
}

wait_to_stop_firing()
{
    self endon( "death" );
    self waittill( "warbird_stop_firing" );
}

dynamic_boost_jump()
{
    for (;;)
    {
        common_scripts\utility::flag_wait( "player_can_boost_jump" );

        if ( !isdefined( level.player.high_jump_enabled ) || !level.player.high_jump_enabled )
            level.player maps\_player_high_jump::enable_high_jump();

        common_scripts\utility::flag_waitopen( "player_can_boost_jump" );

        if ( isdefined( level.player.high_jump_enabled ) && level.player.high_jump_enabled )
            level.player maps\_player_high_jump::disable_high_jump();
    }
}

warbird_wait_for_unload()
{
    self endon( "death" );
    self waittill( "unloaded" );
    maps\_utility::ent_flag_set( "unloaded" );
}

get_passengers()
{
    var_0 = self.riders;
    var_0 = common_scripts\utility::array_remove( var_0, var_0[0] );
    return var_0;
}

ignore_until_unloaded()
{
    foreach ( var_1 in self )
    {
        var_1.ignoreme = 1;
        var_1 thread wait_until_unloaded();
    }
}

wait_until_unloaded()
{
    self endon( "death" );
    self waittill( "jumpedout" );
    self.ignoreme = 0;
}

heli_wait_for_unload()
{
    self endon( "death" );
    self waittill( "unloaded" );
}

setup_atlas_drone( var_0 )
{
    self endon( "death" );
    thread maps\_shg_utility::make_emp_vulnerable();
    self laseron();
    thread drone_fire_timing();
    maps\_utility::add_damage_function( ::atlas_drone_damage_function );
    soundscripts\_snd::snd_message( "attack_drone_audio_handler" );

    if ( !isdefined( level.deck_drones ) )
        level.deck_drones = [];

    level.deck_drones = common_scripts\utility::array_add( level.deck_drones, self );
    common_scripts\utility::flag_wait( var_0 );
    level.deck_drones = common_scripts\utility::array_remove( level.deck_drones, self );
    self kill();
}

atlas_drone_damage_function( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    self endon( "death" );

    if ( isdefined( var_1 ) && isplayer( var_1 ) && isdefined( var_4 ) && ( var_4 == "MOD_IMPACT" || var_4 == "MOD_PROJECTILE" ) )
    {
        var_7 = var_1 getcurrentweapon();

        if ( isdefined( var_7 ) && issubstr( var_7, "microdronelauncher" ) )
        {
            maps\_vehicle::vehicle_set_health( 1 );
            level.deck_drones = common_scripts\utility::array_remove( level.deck_drones, self );
            self dodamage( 99999, self.origin, var_1 );
        }
    }
}

setup_corpses( var_0 )
{
    if ( !isdefined( var_0 ) || !var_0 )
    {
        var_1 = common_scripts\utility::getstructarray( "org_corpse", "script_noteworthy" );
        var_2 = getent( "corpse_spawner", "targetname" );
    }
    else
    {
        var_1 = common_scripts\utility::getstructarray( "org_civ_corpse", "script_noteworthy" );
        var_2 = getent( "civ_corpse_spawner", "targetname" );
    }

    foreach ( var_4 in var_1 )
    {
        var_2.count++;
        var_5 = var_2 maps\_utility::spawn_ai( 1 );
        var_5.ignoreme = 1;
        var_5 thread maps\_utility::set_battlechatter( 0 );
        var_5.allowdeath = 0;
        var_5.animname = "generic";
        var_5.name = " ";
        var_5 notsolid();
        var_5 character\gfl\randomizer_sentinel::main();

        if ( isdefined( var_5.weapon ) && var_5.weapon != "none" )
            var_5 maps\_utility::gun_remove();

        var_5 thermaldrawdisable();

        if ( issubstr( var_4.script_parameters, "death" ) )
        {
            var_4 thread maps\_anim::anim_single_solo( var_5, var_4.script_parameters );
            var_6 = var_5 maps\_utility::getanim( var_4.script_parameters );
            var_5 common_scripts\utility::delaycall( 0.05, ::setanimtime, var_6, 1.0 );
            continue;
        }

        var_4 thread maps\_anim::anim_generic_loop( var_5, var_4.script_parameters );
    }
}

water_sheeting()
{
    var_0 = getentarray( "trig_water_sheeting", "targetname" );
    common_scripts\utility::array_thread( var_0, ::water_sheeting_think );
}

water_sheeting_think()
{
    self waittill( "trigger" );

    for (;;)
    {
        if ( level.player istouching( self ) )
        {
            level.player setwatersheeting( 1, 1.5 );
            wait 0.5;
            continue;
        }

        wait 0.05;
    }
}

disable_awareness( var_0 )
{
    self.dontmelee = 1;
    self.ignoresuppression = 1;
    self.suppressionwait_old = self.suppressionwait;
    self.suppressionwait = 0;
    maps\_utility::disable_surprise();
    self.ignorerandombulletdamage = 1;
    maps\_utility::disable_bulletwhizbyreaction();
    maps\_utility::disable_pain();
    self.grenadeawareness = 0;
    self.disablefriendlyfirereaction = 1;
    self.dodangerreact = 0;
    maps\_utility::enable_dontevershoot();
    self.ignoreall = 1;
    self.ignoreme = 1;
}

enable_awareness()
{
    self.ignoreall = 0;
    self.dontmelee = undefined;
    self.ignoresuppression = 0;
    self.suppressionwait = self.suppressionwait_old;
    self.suppressionwait_old = undefined;
    maps\_utility::enable_surprise();
    self.ignorerandombulletdamage = 0;
    maps\_utility::enable_bulletwhizbyreaction();
    maps\_utility::enable_pain();
    self.grenadeawareness = 1;
    self.ignoreme = 0;
    maps\_utility::disable_dontevershoot();
    self.disablefriendlyfirereaction = undefined;
    self.dodangerreact = 1;
}

disable_awareness_limited()
{
    self.ignoresuppression = 1;
    self.suppressionwait = 0;
    maps\_utility::disable_surprise();
    self.ignorerandombulletdamage = 1;
    maps\_utility::disable_bulletwhizbyreaction();
    maps\_utility::disable_pain();
    self.grenadeawareness = 0;
    self.disablefriendlyfirereaction = 1;
    self.dodangerreact = 0;
}

hanger_reinforcements_think()
{
    self endon( "death" );
    thread equip_microwave_grenade();
    self.ignoreall = 1;
    maps\_utility::set_goal_radius( 16 );
    self waittill( "goal" );

    if ( isdefined( self ) && isalive( self ) )
        self.ignoreall = 0;
}

postspawn_rpg_vehicle()
{
    self setmodel( "projectile_rpg7" );
    var_0 = common_scripts\utility::getfx( "rpg_trail" );
    playfxontag( var_0, self, "tag_origin" );
    var_0 = common_scripts\utility::getfx( "rpg_muzzle" );
    playfxontag( var_0, self, "tag_origin" );
    self playsound( "weap_rpg_fire_npc" );

    if ( isdefined( self.script_sound ) )
    {
        if ( isdefined( self.script_wait ) )
            common_scripts\utility::delaycall( self.script_wait, ::playsound, self.script_sound );
        else
            self playsound( self.script_sound );
    }
    else
        self playloopsound( "weap_rpg_loop" );

    self waittill( "reached_end_node" );
    self notify( "explode", self.origin );
    var_1 = 0;

    if ( isdefined( self.script_exploder ) )
    {
        common_scripts\_exploder::exploder( self.script_exploder );
        var_1 = 1;
    }
    else if ( isdefined( self.currentnode ) )
    {
        var_2 = undefined;

        for ( var_3 = self.currentnode; isdefined( var_3 ); var_3 = getvehiclenode( var_3.target, "targetname" ) )
        {
            var_2 = var_3;

            if ( !isdefined( var_3.target ) )
                break;
        }

        if ( isdefined( var_2.target ) )
        {
            var_4 = common_scripts\utility::getstruct( var_2.target, "targetname" );

            if ( isdefined( var_4 ) )
            {
                level thread rpg_explosion( var_4.origin, var_4.angles );
                var_1 = 1;
            }
        }
    }

    if ( !var_1 )
    {
        var_4 = spawnstruct();
        var_4.origin = self.origin;
        var_4.angles = ( -90, 0, 0 );
        level thread rpg_explosion( var_4.origin, var_4.angles );
    }

    self delete();
}

rpg_explosion( var_0, var_1 )
{
    var_2 = common_scripts\utility::getfx( "rpg_explode" );
    playfx( var_2, var_0, anglestoforward( var_1 ), anglestoup( var_1 ) );
    radiusdamage( var_0, 200, 150, 50 );
    thread common_scripts\utility::play_sound_in_space( "null", var_0 );
}

hide_navy_boats()
{
    var_0 = getentarray( "navy_ship", "targetname" );
    var_1 = getentarray( "navy_ship_right", "targetname" );
    var_2 = common_scripts\utility::array_combine( var_0, var_1 );

    foreach ( var_4 in var_2 )
        var_4 hide();
}

show_navy_boats()
{
    var_0 = getentarray( "navy_ship", "targetname" );
    var_1 = getentarray( "navy_ship_right", "targetname" );
    var_2 = common_scripts\utility::array_combine( var_0, var_1 );

    foreach ( var_4 in var_2 )
        var_4 show();
}

hanger_bad_path()
{
    var_0 = getent( "hanger_stairs_bad_place", "targetname" );
    badplace_brush( "bad_place", -1, var_0, "axis" );
}

prep_cinematic( var_0 )
{
    setsaveddvar( "cg_cinematicFullScreen", "0" );
    cinematicingame( var_0, 1 );
    level.current_cinematic = var_0;
}

ending_fade_out( var_0 )
{
    setblur( 10, var_0 );
    var_1 = newhudelem();
    var_1.x = 0;
    var_1.y = 0;
    var_1.horzalign = "fullscreen";
    var_1.vertalign = "fullscreen";
    var_1 setshader( "black", 640, 480 );

    if ( isdefined( var_0 ) && var_0 > 0 )
    {
        var_1.alpha = 0;
        var_1 fadeovertime( var_0 );
        var_1.alpha = 1;
        wait(var_0);
    }

    waittillframeend;
    var_1 destroy();
}

fall_fail()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "trigger", var_0 );

        if ( var_0 == level.player )
        {
            setdvar( "ui_deadquote", "" );
            setblur( 30, 2 );
            maps\_utility::missionfailedwrapper();
        }
    }
}

warbird_heavy_shooting_think( var_0 )
{
    level.player endon( "death" );
    self endon( "death" );
    self.mgturret[0] setmode( "manual" );
    self.mgturret[1] setmode( "manual" );

    if ( !maps\_utility::ent_flag_exist( "fire_turrets" ) )
        maps\_utility::ent_flag_init( "fire_turrets" );

    maps\_utility::ent_flag_set( "fire_turrets" );

    for (;;)
    {
        self waittill( "warbird_fire" );
        maps\_utility::ent_flag_set( "fire_turrets" );
        thread warbird_heavy_fire( var_0 );
        self waittill( "warbird_stop_firing" );
        maps\_utility::ent_flag_clear( "fire_turrets" );
    }
}

warbird_heavy_fire( var_0 )
{
    self endon( "death" );
    var_1 = self.mgturret[0];
    var_2 = self.mgturret[1];
    var_1 notify( "stop_burst_fire_unmanned" );
    var_2 notify( "stop_burst_fire_unmanned" );
    var_3 = 0.4;
    var_4 = var_3 / 2;
    var_1 thread burst_fire_warbird( var_3, 0 );
    var_2 thread burst_fire_warbird( var_3, var_4 );
    var_5 = common_scripts\utility::get_enemy_team( self.script_team );

    while ( maps\_utility::ent_flag( "fire_turrets" ) )
    {
        var_6 = getaiarray( var_5 );

        if ( isdefined( level.flying_attack_drones ) )
            var_7 = level.flying_attack_drones;
        else
            var_7 = [];

        if ( isdefined( level.drones ) && isdefined( level.drones[var_5].array ) )
            var_6 = common_scripts\utility::array_combine( var_6, level.drones[var_5].array );

        if ( var_5 == level.player.team )
            var_6 = common_scripts\utility::array_add( var_6, level.player );

        var_6 = common_scripts\utility::array_combine( var_6, var_7 );
        var_8 = [];

        foreach ( var_10 in var_6 )
        {
            if ( isdefined( var_10.ignoreme ) && var_10.ignoreme )
                continue;
            else
                var_8[var_8.size] = var_10;
        }

        var_8 = sortbydistance( var_8, self.origin );
        var_12 = undefined;

        foreach ( var_10 in var_8 )
        {
            if ( !isdefined( var_10 ) )
                continue;

            if ( !isalive( var_10 ) )
                continue;

            if ( isdefined( var_0 ) && var_0 )
            {
                var_14 = self.mgturret[0] gettagorigin( "tag_flash" );
                var_15 = var_10 geteye();
                var_16 = vectornormalize( var_15 - var_14 );
                var_17 = var_14 + var_16 * 20;

                if ( !sighttracepassed( var_17, var_15, 0, var_10, self.mgturret[0] ) )
                    continue;
            }

            var_12 = var_10;
            break;
        }

        if ( isdefined( var_12 ) )
        {
            var_1 settargetentity( var_12 );
            var_2 settargetentity( var_12 );
            var_1 turretfireenable();
            var_2 turretfireenable();
            var_1 startfiring();
            var_2 startfiring();
            wait_for_warbird_fire_target_done( var_12, var_0 );
            var_1 notify( "stop_firing" );
            var_2 notify( "stop_firing" );
            var_1 cleartargetentity();
            var_2 cleartargetentity();
            var_1 turretfiredisable();
            var_2 turretfiredisable();
        }

        wait 0.05;
    }

    var_1 turretfiredisable();
    var_2 turretfiredisable();
}

burst_fire_warbird( var_0, var_1 )
{
    self endon( "death" );
    self endon( "stop_burst_fire_warbird" );
    var_2 = 1;
    var_3 = 1;
    var_4 = 1;
    var_5 = 1;
    var_6 = gettime();
    var_7 = "start";

    for (;;)
    {
        var_8 = ( var_6 - gettime() ) * 0.001;

        if ( self isfiringturret() && var_8 <= 0 )
        {
            if ( var_7 != "fire" )
            {
                var_7 = "fire";
                thread doshoottuned( var_0, var_1 );
            }

            var_8 = var_4 + randomfloat( var_5 );
            thread turrettimer( var_8 );
            self waittill( "turretstatechange" );
            var_8 = var_2 + randomfloat( var_3 );
            var_6 = gettime() + int( var_8 * 1000 );
            continue;
        }

        if ( var_7 != "aim" )
            var_7 = "aim";

        thread turrettimer( var_8 );
        self waittill( "turretstatechange" );
    }
}

doshoottuned( var_0, var_1 )
{
    self endon( "death" );
    self endon( "turretstatechange" );

    if ( isdefined( var_1 ) && var_1 > 0 )
        wait(var_1);

    for (;;)
    {
        self shootturret();
        wait(var_0);
    }
}

turrettimer( var_0 )
{
    if ( var_0 <= 0 )
        return;

    self endon( "turretstatechange" );
    wait(var_0);

    if ( isdefined( self ) )
        self notify( "turretstatechange" );
}
