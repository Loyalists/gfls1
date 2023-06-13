// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

spawn_allies()
{
    level.burke = getent( "burke", "targetname" ) maps\_utility::spawn_ai( 1 );
    level.cormack = getent( "cormack", "targetname" ) maps\_utility::spawn_ai( 1 );
    level.maddox = getent( "maddox", "targetname" ) maps\_utility::spawn_ai( 1 );
    level.burke setup_hero( "burke" );
    level.cormack setup_hero( "cormack" );
    level.maddox setup_hero( "maddox" );
}

setup_hero( var_0 )
{
    maps\_utility::magic_bullet_shield();
    self.animname = var_0;

    if ( !isdefined( level.heroes ) )
        level.heroes = [];

    level.heroes[level.heroes.size] = self;
}

bridge_idle_anims()
{
    var_0 = maps\_utility::spawn_anim_model( "bridge_part_a" );
    var_1 = maps\_utility::spawn_anim_model( "bridge_part_b" );
    var_2 = maps\_utility::spawn_anim_model( "bridge_part_c" );
    var_3 = maps\_utility::spawn_anim_model( "bridge_part_d" );
    var_4 = common_scripts\utility::getstruct( "org_bridge_parts", "targetname" );
    var_5 = [ var_0, var_1, var_2, var_3 ];
    var_4 thread maps\_anim::anim_loop( var_5, "bridge_parts_idle" );
}

tilt_boat( var_0 )
{
    common_scripts\utility::flag_wait( "intro_anim_finished" );
    var_1 = common_scripts\utility::spawn_tag_origin();

    if ( !isdefined( var_0 ) || !var_0 )
    {
        var_1.angles = ( 0, 0, 0 );
        var_1 rotateto( ( -5, 0, 5 ), 2 );
    }
    else
        var_1.angles = ( -5, 0, 5 );

    level.player playersetgroundreferenceent( var_1 );
    level.ground_ref_ent = var_1;
    thread adjust_gravity();
    level.waves = 0;
}

adjust_gravity()
{
    var_0 = level.ground_ref_ent.angles;
    var_1 = -1 * anglestoup( level.ground_ref_ent.angles );
    setphysicsgravitydir( var_1 );
    var_2 = var_1;

    for (;;)
    {
        var_3 = -1 * anglestoup( var_0 );
        var_1 = -1 * anglestoup( level.ground_ref_ent.angles );
        var_4 = vectornormalize( var_1 + ( var_1 - var_3 ) * 100 );

        if ( var_4 != var_2 )
        {
            setphysicsgravitydir( var_4 );
            var_2 = var_4;
        }

        level.physics_gravity_vector = var_1;
        var_0 = level.ground_ref_ent.angles;
        wait 0.05;
    }
}

close_interior_door()
{
    var_0 = getent( "interior_exit_clip", "targetname" );
    var_0 disconnectpaths();
    level.interior_door = maps\_utility::spawn_anim_model( "interior_bulkhead" );
    var_1 = common_scripts\utility::getstruct( "org_squad_enter_mob", "targetname" );
    var_1 maps\_anim::anim_first_frame_solo( level.interior_door, "ripopen_bulkhead" );
}

mob_enter_player_clip()
{
    var_0 = getent( "player_enter_mob_clip", "targetname" );
    var_0.old_origin = var_0.origin;
    var_0.origin = ( 0, 0, 0 );
    var_0 disconnectpaths();
    common_scripts\utility::flag_wait( "flag_obj_marker_enter_ship" );
    var_0.origin = var_0.old_origin;
    common_scripts\utility::flag_wait( "flag_player_entered_interior" );
    var_0 common_scripts\utility::delaycall( 0.5, ::delete );
    var_0 common_scripts\utility::delaycall( 0.55, ::connectpaths );
}

intro_scene()
{
    soundscripts\_snd::snd_message( "intro_scene" );
    thread maps\sanfran_b_lighting::play_flickering_fire_light();

    if ( level.nextgen )
    {
        thread maps\_utility::vision_set_fog_changes( "sfb_neutral", 0 );
        setsunlight( 0, 0, 0 );
        maps\_lighting::set_spot_color( "fire_rim", ( 1, 0.8, 0.83 ) );
        maps\_lighting::set_spot_intensity( "fire_rim", 300000 );
    }
    else
        thread maps\_utility::vision_set_fog_changes( "sanfran_b_exterior_dark", 0 );

    common_scripts\_exploder::exploder( 4225 );

    if ( level.nextgen )
    {
        maps\_utility::delaythread( 2, maps\_utility::fog_set_changes, "sanfran_b_exterior_dark_fog", 2 );
        maps\_utility::delaythread( 4, maps\_utility::fog_set_changes, "sanfran_b_exterior_dark_nofog", 1 );
        maps\_utility::delaythread( 3.5, maps\_lighting::set_spot_intensity, "fire_rim", 0 );
        maps\_utility::delaythread( 6, maps\_utility::fog_set_changes, "sanfran_b_exterior_dark_fog", 5 );
        maps\_utility::delaythread( 6, maps\_lighting::lerp_spot_intensity, "fire_rim", 0.5, 300000 );
    }
    else
    {
        maps\_utility::delaythread( 2, maps\_utility::vision_set_fog_changes, "sanfran_b_exterior_dark_fog", 2 );
        maps\_utility::delaythread( 4, maps\_utility::vision_set_fog_changes, "sanfran_b_exterior_dark_nofog", 1 );
        maps\_utility::delaythread( 6, maps\_utility::vision_set_fog_changes, "sanfran_b_exterior_dark_fog", 1 );
    }

    level.player allowcrouch( 0 );
    level.player allowprone( 0 );
    level.player disableweapons();
    soundscripts\_snd::snd_message( "sfb_intro_burke_foley" );
    soundscripts\_snd::snd_message( "sfb_intro_car_explode" );
    var_0 = maps\_utility::spawn_anim_model( "player_arms" );
    level.player playerlinktodelta( var_0, "tag_player", 1, 8, 8, 4, 4 );
    level.player common_scripts\utility::delaycall( 0.1, ::playerlinktodelta, var_0, "tag_player", 1, 12, 12, 10, 4 );
    level.player enableslowaim();
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname( "littlebird_intro" );
    var_1.animname = "littlebird";

    if ( level.nextgen )
        setsaveddvar( "r_dynamicSpotLightShadows", 0 );

    maps\_utility::delaythread( 8, common_scripts\_exploder::exploder, 4222 );
    maps\_utility::delaythread( 8, common_scripts\_exploder::exploder, 1999 );
    maps\_utility::delaythread( 11, maps\_utility::stop_exploder, 4223 );
    var_2 = maps\_utility::spawn_anim_model( "pickup_truck" );
    var_3 = maps\_utility::spawn_anim_model( "domestic_mini" );
    var_4 = [ level.burke, level.cormack, level.maddox, var_0, var_1, var_2, var_3 ];
    var_5 = common_scripts\utility::getstruct( "org_intro_anim", "targetname" );
    var_5 maps\_anim::anim_first_frame( var_4, "intro" );

    foreach ( var_7 in level.heroes )
    {
        var_7 thread maps\sanfran_b_util::hide_friendname_until_flag_or_notify( "player_control_enabled" );
        var_7 maps\sanfran_b_util::disable_awareness();
    }

    thread maps\_utility::flag_set_delayed( "intro_dialogue", 23 );
    maps\_utility::delaythread( 22.5, maps\_utility::stop_exploder, 1999 );
    maps\_utility::delaythread( 21, common_scripts\_exploder::exploder, 4443 );
    level.burke soundscripts\_snd::snd_message( "pcap_vo_sf_b_intro", "burke" );
    level.cormack soundscripts\_snd::snd_message( "pcap_vo_sf_b_intro", "cormack" );
    var_5 thread maps\_anim::anim_single( var_4, "intro" );
    level waittill( "intro_scene_artillery_rumble" );
    level.player playrumbleonentity( "artillery_rumble" );
    common_scripts\utility::flag_wait( "intro_anim_finished" );
    soundscripts\_snd::snd_message( "intro_scene_done" );
    level notify( "player_control_enabled" );
    maps\_utility::battlechatter_on( "allies" );
    maps\_utility::battlechatter_on( "axis" );
    level.player unlink();
    level.player allowcrouch( 1 );
    level.player allowprone( 1 );
    level.player disableslowaim();
    setsaveddvar( "ammoCounterHide", "0" );

    if ( level.currentgen )
        maps\_utility::vision_set_fog_changes( "sanfran_b_exterior_dark_fog", 1 );

    if ( level.nextgen )
        maps\_utility::fog_set_changes( "sanfran_b", 4 );

    thread maps\sanfran_b_lighting::stop_flickering_fire_light();
    thread maps\_shg_fx::vfx_sunflare( "sanfran_sunflare_a" );
    common_scripts\_exploder::exploder( 4444 );
    maps\_utility::pauseexploder( 4445 );
    common_scripts\utility::flag_clear( "msg_vfx_zone1000_disable" );
    var_0 delete();
    var_1 delete();
    maps\_utility::stop_exploder( 4222 );
    maps\_utility::stop_exploder( 4225 );
    setsaveddvar( "r_dynamicSpotLightShadows", 1 );
    setsaveddvar( "r_fog_ev_adjust", 1.5 );

    if ( level.nextgen )
    {

    }

    maps\_utility::autosave_by_name();
    thread squad_becomes_aware_after_intro();
    maps\_utility::activate_trigger_with_targetname( "trig_squad_move_001" );
}

squad_becomes_aware_after_intro()
{
    maps\_utility::trigger_wait_targetname( "trig_heli_takeoff_pod_1" );

    foreach ( var_1 in level.heroes )
        var_1 maps\sanfran_b_util::enable_awareness();
}

ambient_deck()
{
    level waittill( "player_control_enabled" );
    thread warbird_strafe_run();
    thread ambient_shrike_flyby();
    var_0 = getent( "refl_probe_heli_open", "targetname" );
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "ambient_warbird_1" );
    var_1 soundscripts\_snd::snd_message( "warbird_circling_perimeter" );
    waittillframeend;
    var_1 maps\_vehicle::godon();
    var_1 overridereflectionprobe( var_0.origin );
    var_1 thread maps\sanfran_b_util::ambient_warbird_shooting_think( 0 );
    var_1 thread maps\sanfran_b_util::ambient_warbird_wait_to_fire();
    var_1 thread delete_ambient();
    var_1 setmaxpitchroll( 10, 60 );
    var_1.ignoreme = 1;
    var_2 = getentarray( "ambient_drone_swarm_1", "script_noteworthy" );

    if ( !isdefined( level.ambient_drones ) )
        level.ambient_drones = [];

    foreach ( var_4 in var_2 )
    {
        var_5 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( var_4.targetname );
        var_5.ignoreme = 1;
        var_5 maps\_utility::ent_flag_set( "fire_disabled" );
        var_5 thread delete_ambient();
        level.ambient_drones[level.ambient_drones.size] = var_5;
    }
}

warbird_strafe_run()
{
    maps\_utility::trigger_wait_targetname( "trig_warbird_strafe" );
    var_0 = getent( "refl_probe_heli_open", "targetname" );
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "warbird_strafe_1" );
    var_1 soundscripts\_snd::snd_message( "warbird_strafe_01" );
    var_1 overridereflectionprobe( var_0.origin );
    waittillframeend;
    var_1 thread maps\sanfran_b_util::ambient_warbird_shooting_think( 0 );
    var_1 thread maps\sanfran_b_util::ambient_warbird_wait_to_fire();
    var_1 setmaxpitchroll( 10, 60 );
}

ambient_shrike_flyby()
{
    maps\_utility::trigger_wait_targetname( "trig_heli_takeoff_pod_1" );
    var_0 = getent( "refl_probe_heli_open", "targetname" );
    var_1 = maps\_utility::array_spawn_targetname( "flyby_shrikes" );
    var_1 soundscripts\_snd::snd_message( "shrike_flyby_pair_01" );

    foreach ( var_3 in var_1 )
        var_3 overridereflectionprobe( var_0.origin );

    common_scripts\utility::array_thread( var_1, maps\_vehicle::gopath );
}

ambient_explosions()
{
    level endon( "jammer_2_deactivated" );
    maps\_utility::trigger_wait_targetname( "trig_heli_takeoff_pod_1" );
    wait 5;

    for (;;)
    {
        var_0 = anglestoforward( level.player.angles );
        var_1 = randomintrange( 512, 800 );
        var_2 = anglestoright( level.player.angles );
        var_3 = randomintrange( -400, 400 );
        var_4 = level.player.origin + var_0 * var_1 + var_2 * var_3;
        var_5 = var_4;
        var_6 = var_4 - ( 0, 0, 150 );
        var_7 = bullettrace( var_5, var_6, 0, undefined );

        if ( isdefined( var_7 ) )
        {
            var_5 = var_7["position"];
            var_8 = vectortoangles( var_7["normal"] );
            var_8 += ( 90, 0, 0 );
            var_0 = anglestoforward( var_8 );
            var_9 = anglestoup( var_8 );
            playfx( common_scripts\utility::getfx( "ambient_explosion" ), var_5, var_9, var_0 );
            radiusdamage( var_5, 100, 200, 20 );
            physicsexplosionsphere( var_5, 100, 50, 2 );
        }

        wait(randomfloatrange( 5.0, 10.0 ));
    }
}

enemy_reinforcements()
{
    level endon( "all_jammers_deactivated" );

    for (;;)
    {
        var_0 = getaiarray( "axis" );

        if ( var_0.size <= 2 )
        {
            var_1 = enemy_reinforcements_think();

            if ( isdefined( var_1 ) )
            {
                var_1 thread deck_reinforcement_modify_accuracy();
                var_2 = randomint( 100 );

                if ( var_2 >= 0 && var_2 < 50 )
                    var_1 maps\_utility::set_goal_entity( level.burke );
                else
                    var_1 maps\_utility::set_goal_entity( level.cormack );
            }
        }

        wait 0.05;
    }
}

enemy_reinforcements_think()
{
    var_0 = getent( "enemy_reinforcement_spawner", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "enemy_reinforce_loc", "targetname" );
    var_2 = getdvarint( "cg_fov" );
    var_3 = cos( var_2 );
    var_1 = sortbydistance( var_1, level.player.origin );
    var_1 = common_scripts\utility::array_reverse( var_1 );

    foreach ( var_5 in var_1 )
    {
        var_6 = anglestoforward( level.player getangles() );
        var_7 = vectornormalize( var_5.origin - level.player.origin );

        if ( vectordot( var_6, var_7 ) < var_3 )
        {
            var_0.origin = var_5.origin;
            var_0.count++;
            var_8 = var_0 maps\_utility::spawn_ai();
            return var_8;
        }

        wait 0.05;
    }
}

deck_reinforcement_modify_accuracy()
{
    self endon( "death" );
    var_0 = getdvarint( "cg_fov" );
    var_1 = cos( var_0 );
    thread maps\sanfran_b_util::equip_microwave_grenade();
    createthreatbiasgroup( "deck_reinforcements_behind_player" );
    createthreatbiasgroup( "deck_reinforcements_in_front_of_player" );
    setthreatbias( "player", "deck_reinforcements_behind_player", -20000 );
    setthreatbias( "player", "deck_reinforcements_in_front_of_player", 0 );
    self setthreatbiasgroup( "deck_reinforcements_behind_player" );

    for (;;)
    {
        var_2 = anglestoforward( level.player.angles );
        var_3 = vectornormalize( self.origin - level.player.origin );

        if ( vectordot( var_2, var_3 ) < var_1 )
            self setthreatbiasgroup( "deck_reinforcements_behind_player" );
        else
            self setthreatbiasgroup( "deck_reinforcements_in_front_of_player" );

        wait 0.05;
    }
}

delete_ambient()
{
    self endon( "death" );
    common_scripts\utility::flag_wait( "flag_information_center" );
    self delete();
}

cargo_ship_missiles()
{
    level endon( "jammer_2_deactivated" );
    maps\_utility::trigger_wait_targetname( "trig_heli_takeoff_pod_1" );
    var_0 = common_scripts\utility::getstructarray( "cargo_missile_orgs", "targetname" );
    var_1 = getentarray( "cargo_missile_targets", "targetname" );

    for (;;)
    {
        var_2 = var_0[randomint( var_0.size )];
        var_3 = var_1[randomint( var_1.size )];
        var_4 = common_scripts\utility::getstruct( var_2.target, "targetname" ).origin;
        var_5 = vectortoangles( var_3.origin - var_2.origin );
        var_6 = magicbullet( "cargo_ship_missile", var_2.origin, var_4 );
        var_6 missile_settargetent( var_3 );
        var_6 missile_setflightmodedirect();
        playfx( common_scripts\utility::getfx( "missile_launch_smoke" ), var_2.origin, anglestoforward( var_5 ), anglestoup( var_5 ) );
        wait(randomfloatrange( 5, 10 ));
    }
}

shrike_flyby()
{
    maps\_utility::trigger_wait_targetname( "trig_shrike_flyby_1" );

    if ( level.nextgen )
    {
        var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "shrike_flyby_1" );
        var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "shrike_flyby_2" );
        soundscripts\_snd::snd_message( "shrike_flyby_pair_02", var_0, var_1 );
    }
    else
    {
        var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "shrike_flyby_2" );
        soundscripts\_snd::snd_message( "shrike_flyby_pair_02", undefined, var_1 );
    }
}

initial_combat()
{
    level.deck_navy_guys = maps\_utility::array_spawn_noteworthy( "navy_deck_guys_initial", 1 );
    maps\_utility::trigger_wait_targetname( "trig_heli_takeoff_pod_1" );
    level.enemy_deck_guys = maps\_utility::array_spawn_noteworthy( "enemy_deck_guys_initial", 1 );
    common_scripts\utility::array_thread( level.enemy_deck_guys, maps\_utility::set_grenadeammo, 0 );
    level notify( "spawned_jammer_guards" );
}

shrike_takeoff()
{
    level.player endon( "death" );
    var_0 = getent( "refl_probe_heli_open", "targetname" );
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname( "heli_takeoff_pod_1" );
    var_1.animname = "shrike_1";
    var_1 maps\_vehicle::godon();
    var_2 = maps\_vehicle::spawn_vehicle_from_targetname( "heli_takeoff_pod_2" );
    var_2.animname = "shrike_2";
    var_2 maps\_vehicle::godon();
    var_2 vehicle_removebrushmodelcollision();
    var_3 = common_scripts\utility::getstruct( "org_shrike_takeoff", "targetname" );
    var_4 = [ var_2, var_1 ];
    var_3 thread maps\_anim::anim_first_frame( var_4, "shrike_takeoff" );
    maps\_utility::trigger_wait_targetname( "trig_heli_takeoff_pod_1" );
    soundscripts\_snd::snd_message( "shrike_takeoff", var_2, var_1 );
    var_3 maps\_anim::anim_single( var_4, "shrike_takeoff" );

    foreach ( var_6 in var_4 )
        var_6 delete();
}

shrike_takeoff_cg()
{
    maps\_utility::trigger_wait_targetname( "trig_heli_takeoff_pod_1" );
    wait 5;
    common_scripts\utility::flag_set( "useyourboosters_vo" );
}

initial_deck_guys_invuln()
{
    self endon( "death" );
    maps\_utility::magic_bullet_shield();
    thread maps\_utility::set_grenadeammo( 0 );
    wait(randomfloatrange( 1.0, 3.0 ));
    maps\_utility::stop_magic_bullet_shield();
    self.noragdoll = undefined;
}

move_initial_enemies()
{
    var_0 = getent( "trig_warbird_strafe", "targetname" );

    for (;;)
    {
        var_0 waittill( "trigger", var_1 );

        if ( isdefined( var_1 ) && ( isplayer( var_1 ) || maps\_utility::is_in_array( level.heroes, var_1 ) ) )
            break;
    }

    var_2 = getent( "vol_first_helipad", "targetname" );
    var_3 = getent( "vol_second_helipad", "targetname" );
    var_4 = getent( "vol_tall_helipad", "targetname" );
    var_5 = getaiarray( "axis" );
    var_6 = var_3;

    if ( isdefined( var_5 ) && var_5.size > 0 )
    {
        foreach ( var_1 in var_5 )
        {
            if ( !var_1 istouching( var_2 ) )
                continue;

            var_1 maps\sanfran_b_util::disable_awareness();
            var_1 thread become_aware_on_goal();
            var_1 thread become_aware_when_player_is_in_volume();
            var_1 setgoalvolumeauto( var_6 );
            var_1 thread detect_when_player_is_in_volume( var_6 );

            if ( var_6 == var_3 )
            {
                var_6 = var_4;
                continue;
            }

            var_6 = var_3;
        }
    }
}

deck_reinforcement_ally_think()
{
    maps\_utility::pathrandompercent_set( 500 );
}

become_aware_on_goal()
{
    self endon( "death" );
    self endon( "player_touching_volume" );
    self waittill( "goal" );
    maps\sanfran_b_util::enable_awareness();
    self cleargoalvolume();
    self notify( "guys_aware_on_goal" );
}

become_aware_when_player_is_in_volume()
{
    self endon( "death" );
    self endon( "guys_aware_on_goal" );
    self waittill( "player_touching_volume" );
    maps\sanfran_b_util::enable_awareness();
    self cleargoalvolume();
}

detect_when_player_is_in_volume( var_0 )
{
    level.player endon( "death" );

    while ( !level.player istouching( var_0 ) )
        wait 0.05;

    self notify( "player_touching_volume" );
}

manage_deck_combat()
{
    level.player endon( "death" );
    maps\_utility::trigger_wait_targetname( "trig_deck_combat_first_wave" );
    level.burke maps\_utility::enable_careful();
    level.cormack maps\_utility::enable_careful();
    level.maddox maps\_utility::enable_careful();
    resetsunlight();
    maps\_lighting::set_spot_intensity( "fire_rim", 0.0 );
    thread thin_out_navy_guys( 2 );
    thread deck_jammers();

    if ( level.currentgen )
    {
        var_0 = getentarray( "deck_combat_first_wave_guys", "targetname" );

        foreach ( var_2 in var_0 )
        {
            var_3 = var_2 maps\_utility::spawn_ai();
            waitframe();
        }
    }
    else
        maps\_utility::array_spawn_targetname( "deck_combat_first_wave_guys" );

    thread check_player_deck_position_1();
    maps\_utility::trigger_wait_targetname( "trig_shrike_flyby_1" );
    var_5 = maps\_utility::array_spawn_noteworthy( "jammer_1_defenders", 0, 1 );
    common_scripts\utility::array_thread( var_5, ::jammer_1_defenders_logic );
    common_scripts\utility::array_thread( var_5, ::deck_reinforcement_modify_accuracy );
    maps\sanfran_b_util::wait_for_number_enemies_alive( 5 );
    thread deck_drones( "left" );
    common_scripts\utility::flag_wait( "jammer_1_deactivated" );
    thread check_player_deck_position_2();
    level.burke maps\_utility::disable_careful();
    level.cormack maps\_utility::disable_careful();
    level.maddox maps\_utility::disable_careful();

    foreach ( var_7 in level.deck_drones )
    {
        if ( isdefined( var_7 ) && isalive( var_7 ) )
        {
            var_7 maps\_vehicle::vehicle_set_health( 1 );
            var_7 dodamage( 9999, var_7.origin );
        }
    }

    maps\_utility::autosave_by_name();
    thread thin_out_navy_guys( 1 );
    thread on_the_way_to_jammer_2();
    maps\_utility::activate_trigger_with_targetname( "trig_ally_move_jammer_2" );
    var_9 = getent( "refl_probe_heli_open", "targetname" );
    var_10 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "heli_left_1" );
    var_10 soundscripts\_snd::snd_message( "warbird_dropoff_01" );
    var_10 setmaxpitchroll( 15, 60 );
    var_10 thread setup_deck_deploy_warbird();
    var_10 maps\_utility::ent_flag_init( "dont_shoot_player" );
    var_10 maps\_utility::ent_flag_set( "dont_shoot_player" );
    var_10 overridereflectionprobe( var_9.origin );
    wait 1;
    var_11 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "heli_left_2" );
    var_11 soundscripts\_snd::snd_message( "warbird_dropoff_02" );
    var_11 setmaxpitchroll( 15, 60 );
    var_11 thread setup_deck_deploy_warbird();
    var_11 maps\_utility::ent_flag_init( "dont_shoot_player" );
    var_11 maps\_utility::ent_flag_set( "dont_shoot_player" );
    var_11 overridereflectionprobe( var_9.origin );
    common_scripts\utility::flag_set( "deck_warbird_vo" );
    maps\_utility::trigger_wait_targetname( "trig_jammer_2_drones" );
    var_12 = deck_drones( "right" );
    thread friendly_airstrike( var_12 );
    maps\_utility::activate_trigger_with_targetname( "trig_post_jammer_2_squad_move" );
    thread maps\_utility::flag_set_delayed( "jammer_2_vo", 3 );
    common_scripts\utility::flag_wait( "jammer_2_deactivated" );
    common_scripts\utility::flag_set( "flag_move_gideon_into_interior" );
    thread thin_out_navy_guys( 0 );

    foreach ( var_7 in level.deck_drones )
    {
        if ( isdefined( var_7 ) && isalive( var_7 ) )
        {
            var_7 maps\_vehicle::vehicle_set_health( 1 );
            var_7 dodamage( 9999, var_7.origin );
        }
    }

    maps\_utility::autosave_by_name();
    level.cormack maps\_utility::teleport_ai( getnode( "cormack_deck_end_cover", "targetname" ) );
    level.maddox maps\_utility::teleport_ai( getnode( "maddox_deck_end_cover", "targetname" ) );
    level.burke maps\_utility::teleport_ai( getnode( "burke_deck_end_cover", "targetname" ) );
    maps\_utility::activate_trigger_with_targetname( "trig_move_squad_to_pre_mob_enter" );
    thread move_squad_into_ship();
    thread jammer_3_navy_drone_combat();
    maps\_utility::delaythread( 3, ::deck_enemies_cleared );
    var_15 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "heli_back_2" );
    var_15 soundscripts\_snd::snd_message( "warbird_dropoff_03" );
    var_15 setmaxpitchroll( 10, 60 );
    var_15 thread setup_deck_deploy_warbird();
    var_15 overridereflectionprobe( var_9.origin );
    var_16 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "heli_back_1" );
    var_16 soundscripts\_snd::snd_message( "warbird_dropoff_04" );
    var_16 setmaxpitchroll( 10, 60 );
    var_16 thread setup_deck_deploy_warbird();
    var_16 overridereflectionprobe( var_9.origin );
    var_17 = getent( "warbird_slide_trigger", "targetname" );
    var_17 enablelinkto();
    var_17 linkto( var_16 );
    thread wait_for_all_deck_warbirds_to_unload();
    var_15 thread hangar_heli_wait_for_unload( "deck_warbird_3_unloaded" );
    var_16 thread hangar_heli_wait_for_unload( "deck_warbird_4_unloaded" );
    thread jammer_3_shrike_flyby( var_16 );
    common_scripts\utility::flag_wait( "all_deck_warbirds_deployed" );
    var_18 = getaiarray( "axis" );

    while ( var_18.size > 2 )
    {
        var_18 = maps\_utility::remove_dead_from_array( var_18 );
        wait 0.5;
    }

    if ( common_scripts\utility::flag( "player_near_mob_entrance" ) == 0 )
    {
        common_scripts\utility::flag_set( "rail_guns_secure_vo" );
        maps\_utility::activate_trigger_with_targetname( "trig_squad_move_into_boat" );
        common_scripts\utility::flag_set( "show_enter_ship_obj_marker" );

        foreach ( var_3 in level.heroes )
        {
            var_3 cleargoalvolume();
            var_3.fixednode = 1;
        }

        common_scripts\utility::flag_wait( "all_jammers_deactivated" );
        wait 0.25;
        var_18 = getaiarray( "axis" );

        if ( var_18.size > 0 )
        {
            foreach ( var_3 in var_18 )
                var_3 thread maps\sanfran_b_util::bloody_death( randomfloatrange( 0.0, 2.0 ) );
        }

        common_scripts\utility::flag_set( "flag_obj_marker_enter_ship" );
        common_scripts\utility::array_thread( level.heroes, maps\_utility::set_ignoreme, 1 );
        common_scripts\utility::array_thread( level.heroes, maps\_utility::set_ignoreall, 1 );
        common_scripts\utility::array_thread( level.heroes, maps\_utility::disable_pain );
        maps\_utility::autosave_by_name();
        slow_player_inside();
    }
}

check_player_deck_position_1()
{
    level endon( "jammer_1_deactivated" );
    maps\_utility::array_spawn_function_targetname( "deck_top_combat_first_wave_guys", maps\sanfran_b_util::equip_microwave_grenade );
    common_scripts\utility::flag_wait( "flag_deck_top_combat_first_wave_guys" );
    maps\_utility::array_spawn_targetname( "deck_top_combat_first_wave_guys" );
}

check_player_deck_position_2()
{
    level endon( "jammer_2_deactivated" );
    maps\_utility::array_spawn_function_targetname( "deck_top_combat_second_wave_guys", maps\sanfran_b_util::equip_microwave_grenade );
    common_scripts\utility::flag_wait( "flag_deck_top_combat_second_wave_guys" );
    maps\_utility::array_spawn_targetname( "deck_top_combat_second_wave_guys" );
}

move_squad_into_ship()
{
    common_scripts\utility::flag_wait( "player_near_mob_entrance" );

    if ( common_scripts\utility::flag( "flag_obj_marker_enter_ship" ) == 0 )
    {
        common_scripts\utility::flag_set( "show_enter_ship_obj_marker" );
        common_scripts\utility::flag_set( "flag_obj_marker_enter_ship" );
        common_scripts\utility::flag_set( "rail_guns_secure_vo" );
        common_scripts\utility::array_thread( level.heroes, maps\_utility::set_ignoreme, 1 );
        common_scripts\utility::array_thread( level.heroes, maps\_utility::set_ignoreall, 1 );
        common_scripts\utility::array_thread( level.heroes, maps\_utility::disable_pain );
        var_0 = getaiarray( "axis" );

        if ( var_0.size > 0 )
        {
            foreach ( var_2 in var_0 )
                var_2 thread maps\sanfran_b_util::bloody_death( randomfloatrange( 0.0, 2.0 ) );
        }

        maps\_utility::autosave_by_name();
        slow_player_inside();
        common_scripts\utility::flag_wait( "boosters_off_anim_finished" );
        common_scripts\utility::array_thread( level.heroes, maps\_utility::set_ignoreme, 0 );
        common_scripts\utility::array_thread( level.heroes, maps\_utility::set_ignoreall, 0 );
        common_scripts\utility::array_thread( level.heroes, maps\_utility::enable_pain );
    }
}

thin_out_navy_guys( var_0 )
{
    while ( level.deck_navy_guys.size > var_0 )
    {
        level.deck_navy_guys[randomint( level.deck_navy_guys.size )] maps\sanfran_b_util::bloody_death( randomfloatrange( 0.5, 2.0 ) );
        level.deck_navy_guys = maps\_utility::remove_dead_from_array( level.deck_navy_guys );
        wait 0.05;
    }
}

deck_jammers()
{
    var_0 = getentarray( "deck_jammers", "script_noteworthy" );
    common_scripts\utility::array_call( var_0, ::hide );
    common_scripts\utility::array_thread( var_0, ::turn_off_jammer_triggers );
    common_scripts\utility::array_thread( var_0, ::jammer_think );
}

turn_off_jammer_triggers()
{
    var_0 = getent( self.target, "targetname" );
    var_0 common_scripts\utility::trigger_off();
}

jammer_enemies_hint()
{
    level endon( "jammer_guards_dead" );
    var_0 = getent( self.target, "targetname" );
    var_0 common_scripts\utility::trigger_on();
    var_0 usetriggerrequirelookat();
    var_0 sethintstring( &"SANFRAN_B_GUARD_HINT" );
}

jammer_enemies_spawn()
{
    var_0 = getent( "jammer_guard_1", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_0 thread maps\sanfran_b_util::equip_microwave_grenade();
    var_0 thread jammer_enemy_1_think();
    var_1 = getent( "jammer_guard_2", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_1 thread maps\sanfran_b_util::equip_microwave_grenade();
    var_1 thread jammer_enemy_2_think();
}

jammer_enemy_1_think()
{
    var_0 = getent( "trigger_jammer_enemy_touch1", "targetname" );

    while ( isalive( self ) )
    {
        if ( !self istouching( var_0 ) )
            break;

        wait 0.5;
    }

    level.jammer_guards += 1;
}

jammer_enemy_2_think()
{
    var_0 = getent( "trigger_jammer_enemy_touch2", "targetname" );

    while ( isalive( self ) )
    {
        if ( !self istouching( var_0 ) )
            break;

        wait 0.5;
    }

    level.jammer_guards += 1;
}

jammer_think()
{
    level.jammer_objective = self;

    if ( self.targetname == "jammer_1" )
    {
        level.jammer_guards = 0;
        thread jammer_enemies_hint();
        thread jammer_enemies_spawn();

        while ( level.jammer_guards < 2 )
            wait 0.15;

        level notify( "jammer_guards_dead" );
        var_0 = getent( self.target, "targetname" );
        var_0 common_scripts\utility::trigger_on();
        var_0 usetriggerrequirelookat();
        var_0 sethintstring( &"SANFRAN_B_DEACTIVATE_JAMMER" );
        var_1 = var_0 maps\_shg_utility::hint_button_trigger( "x", 512 );
        self setmodel( "vm_jamming_device_obj" );
        self show();
        var_0 waittill( "trigger" );
        var_0 common_scripts\utility::trigger_off();
        var_1 maps\_shg_utility::hint_button_clear();
        common_scripts\utility::flag_set( "planting_jammer_1" );
        self hide();
        play_jammer_1_anim();
    }
    else
    {
        common_scripts\utility::flag_wait( "planting_jammer_1" );
        var_0 = getent( self.target, "targetname" );
        var_0 common_scripts\utility::trigger_on();
        var_0 usetriggerrequirelookat();
        var_0 sethintstring( &"SANFRAN_B_DEACTIVATE_JAMMER" );
        var_1 = var_0 maps\_shg_utility::hint_button_trigger( "x", 512 );
        self setmodel( "vm_jamming_device_obj" );
        self show();
        var_0 waittill( "trigger" );
        var_0 common_scripts\utility::trigger_off();
        var_1 maps\_shg_utility::hint_button_clear();
        common_scripts\utility::flag_set( "planting_jammer_2" );
        self hide();
        play_jammer_2_anim();
    }

    var_2 = self.script_parameters + "_deactivated";
    common_scripts\utility::flag_set( var_2 );
}

play_jammer_1_anim()
{
    var_0 = common_scripts\utility::getstruct( "org_jammer_1", "targetname" );
    var_1 = getaiarray( "axis" );

    foreach ( var_3 in var_1 )
        var_3 thread maps\sanfran_b_util::bloody_death();

    level.player maps\_shg_utility::setup_player_for_scene( 1 );
    var_5 = maps\_utility::spawn_anim_model( "player_arms" );
    var_5 hide();

    if ( level.nextgen )
        maps\_utility::delaythread( 1.15, ::player_jammer_movie );

    var_0 maps\_anim::anim_first_frame_solo( var_5, "jammerplant_1" );
    var_6 = maps\_utility::spawn_anim_model( "jammer" );
    var_6 soundscripts\_snd::snd_message( "jammer_plant" );
    var_1 = [ var_5, var_6 ];
    level.player playerlinktoblend( var_5, "tag_player", 0.4 );
    wait 0.4;
    var_5 show();
    level.player enableinvulnerability();
    maps\_utility::delaythread( 0.5, common_scripts\utility::flag_set, "boost_incoming_vo" );
    thread deck_jammer_rumbles();
    var_0 maps\_anim::anim_single( var_1, "jammerplant_1" );
    level.player disableinvulnerability();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    var_5 delete();
    level.player unlink();
}

play_jammer_2_anim()
{
    soundscripts\_snd::snd_message( "jammer_plant" );
    var_0 = common_scripts\utility::getstruct( "org_jammer_2", "targetname" );
    var_1 = getaiarray( "axis" );

    foreach ( var_3 in var_1 )
        var_3 thread maps\sanfran_b_util::bloody_death();

    level.player maps\_shg_utility::setup_player_for_scene( 1 );
    level notify( "stop_jammer_movie" );
    var_5 = maps\_utility::spawn_anim_model( "player_arms" );
    var_5 hide();

    if ( level.nextgen )
        maps\_utility::delaythread( 1.15, ::player_jammer_movie );

    var_0 maps\_anim::anim_first_frame_solo( var_5, "jammerplant_2" );
    var_6 = maps\_utility::spawn_anim_model( "jammer" );
    var_1 = [ var_5, var_6 ];
    level.player playerlinktoblend( var_5, "tag_player", 0.4 );
    wait 0.4;
    var_5 show();
    level.player enableinvulnerability();
    thread deck_jammer_rumbles();
    var_0 maps\_anim::anim_single( var_1, "jammerplant_2" );
    level.player disableinvulnerability();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    var_5 delete();
    level.player unlink();
}

deck_jammer_rumbles()
{
    maps\sanfran_b_util::setup_level_rumble_ent();
    wait 0.5;
    thread maps\sanfran_b_util::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.2, 0.2 );
    wait 0.5;
    thread maps\sanfran_b_util::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.2, 0.3 );
    wait 0.5;
    thread maps\sanfran_b_util::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.5, 0.2 );
}

player_jammer_movie()
{
    level endon( "stop_jammer_movie" );
    level endon( "boosters_off_anim_finished" );
    setsaveddvar( "cg_cinematicFullScreen", "0" );
    cinematicingame( "jammer_UI_loop", 0, 1, 1 );
    thread stop_jammer_movie();
}

stop_jammer_movie()
{
    level endon( "boosters_off_anim_finished" );
    level waittill( "stop_jammer_movie" );
    stopcinematicingame();
}

jammer_1_defenders_logic()
{
    maps\_utility::ent_flag_init( "player_damaged_me" );
    maps\_utility::add_damage_function( ::defender_damage_func );
    thread track_player();
    thread unlock_on_death();
    thread maps\sanfran_b_util::equip_microwave_grenade();
}

mob_entrance_defenders_logic()
{
    maps\_utility::ent_flag_init( "player_damaged_me" );
    maps\_utility::add_damage_function( ::defender_damage_func );
}

track_player()
{
    self endon( "death" );

    if ( !isdefined( level.guy_tracking_player ) )
        level.guy_tracking_player = 0;

    for (;;)
    {
        if ( common_scripts\utility::cointoss() && !level.guy_tracking_player )
        {
            maps\_utility::set_goal_entity( level.player );
            level.guy_tracking_player = 1;
        }

        wait 0.05;
    }
}

unlock_on_death()
{
    self waittill( "death" );
    level.guy_tracking_player = 0;
}

defender_damage_func( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( isdefined( var_1 ) )
    {
        if ( !isplayer( var_1 ) )
        {
            if ( !maps\_utility::ent_flag( "player_damaged_me" ) )
                return var_0 / 20;
            else
                return var_0;
        }
        else
        {
            if ( !maps\_utility::ent_flag( "player_damaged_me" ) )
                maps\_utility::ent_flag_set( "player_damaged_me" );

            return var_0;
        }
    }
}

on_the_way_to_jammer_2()
{
    var_0 = maps\_utility::array_spawn_noteworthy( "jammer_2_enemies", 1, 1 );
    common_scripts\utility::array_thread( var_0, ::track_player );
    common_scripts\utility::array_thread( var_0, ::unlock_on_death );
    common_scripts\utility::array_thread( var_0, ::deck_reinforcement_modify_accuracy );
    maps\_utility::trigger_wait_targetname( "trig_jammer_2_wave_2" );
    var_0 = maps\_utility::array_spawn_noteworthy( "jammer_2_enemies_wave_2", 1, 1 );
    common_scripts\utility::array_thread( var_0, ::track_player );
    common_scripts\utility::array_thread( var_0, ::unlock_on_death );
    common_scripts\utility::array_thread( var_0, ::deck_reinforcement_modify_accuracy );
}

mobile_cover_anim()
{
    var_0 = common_scripts\utility::getstruct( "org_mobile_cover", "targetname" );
    var_1 = getent( "mobile_cover_guy1", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_1.animname = "guy1";
    var_1 maps\_utility::deletable_magic_bullet_shield();
    var_2 = getent( "mobile_cover_guy2", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_2.animname = "guy2";
    var_2 maps\_utility::deletable_magic_bullet_shield();
    var_3 = spawn( "script_model", var_0.origin );
    var_3 setmodel( "vehicle_mobile_cover" );
    var_3.animname = "mobile_cover";
    var_3 maps\_utility::assign_animtree( "mobile_cover" );
    var_3 thread mobile_cover_badplace();
    var_4 = [ var_1, var_2, var_3 ];
    var_0 maps\_anim::anim_single_run( var_4, "deck_mobile_cover" );
    var_2 maps\_utility::stop_magic_bullet_shield();
    var_2 kill();
    var_2 startragdoll();
    var_5 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_5.origin = var_3.origin;
    var_6 = var_3.angles + ( -90, 90, 0 );
    var_3 setmodel( "vehicle_mobile_cover_dstrypv" );
    var_3 notify( "stop_mobile_cover_badplace" );
    earthquake( 1, 1.6, var_5.origin, 625 );
    radiusdamage( var_5.origin, 200, 200, 100, undefined, "MOD_EXPLOSIVE" );
    physicsexplosionsphere( var_5.origin, 200, 10, 1 );
}

mobile_cover_badplace()
{
    self endon( "stop_mobile_cover_badplace" );

    for (;;)
    {
        badplace_cylinder( "mobile_cover_badplace", 0.25, self.origin, 96, 96, "axis", "allies" );
        wait 0.25;
    }
}

setup_deck_deploy_warbird()
{
    maps\_vehicle::godon();
    thread warbird_turret_off_after_deploy();
    thread maps\sanfran_b_util::warbird_shooting_think( 1 );
    waittillframeend;
    self notify( "warbird_fire" );
    var_0 = maps\sanfran_b_util::get_passengers();
    var_0 thread maps\sanfran_b_util::ignore_until_unloaded();

    foreach ( var_2 in var_0 )
    {
        if ( var_2.vehicle_position == 0 )
            var_2 maps\_utility::gun_remove();
    }
}

warbird_turret_off_after_deploy()
{
    self endon( "death" );
    self waittill( "unloaded" );
    self notify( "warbird_stop_firing" );
}

friendly_airstrike( var_0 )
{
    level.airstrike_drones = var_0;
    level.airstrike_drones common_scripts\utility::array_thread( var_0, ::remove_from_array_when_dead );
    maps\_utility::trigger_wait_targetname( "trig_friendly_airstrike" );
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname( "friendly_air_strike" );
    var_1 soundscripts\_snd::snd_message( "shrike_flyby_03" );
    var_1 maps\_utility::ent_flag_init( "airstrike_fire" );
    var_1 thread maps\_vehicle::gopath();
    var_1 maps\_utility::ent_flag_wait( "airstrike_fire" );
}

remove_from_array_when_dead()
{
    self waittill( "death" );
    level.airstrike_drones = common_scripts\utility::array_remove( level.airstrike_drones, self );
}

deck_drones( var_0 )
{
    var_1 = undefined;
    thread vehicle_scripts\_pdrone_tactical_picker::main();

    if ( var_0 == "left" )
        var_1 = vehicle_scripts\_pdrone::start_flying_attack_drones( "deck_reinforcement_drones_left" );

    if ( var_0 == "right" )
        var_1 = vehicle_scripts\_pdrone::start_flying_attack_drones( "deck_reinforcement_drones_right" );

    if ( isdefined( var_1 ) )
    {
        common_scripts\utility::array_thread( var_1, maps\sanfran_b_util::setup_atlas_drone, "flag_cleanup_deck_drones" );
        return var_1;
    }
}

jammer_3_navy_drone_combat()
{
    var_0 = maps\_utility::array_spawn_noteworthy( "jammer_3_navy_drone_guys", 0, 1 );
    level.jammer_3_navy_guys = [];
    level.jammer_3_navy_guys = var_0;
    common_scripts\utility::array_thread( var_0, ::jammer_3_navy_drone_guy_setup );
    common_scripts\utility::array_thread( var_0, ::jammer_3_remove_from_array_when_dead, "navy" );
    maps\_utility::activate_trigger_with_targetname( "trig_jammer_3_navy_drone_movement" );
    thread vehicle_scripts\_pdrone_tactical_picker::main();
    var_1 = vehicle_scripts\_pdrone::start_flying_attack_drones( "jammer_3_navy_drone_drones" );
    level.jammer_3_drones = [];
    level.jammer_3_drones = var_1;
    common_scripts\utility::array_thread( var_1, maps\sanfran_b_util::setup_atlas_drone, "flag_cleanup_deck_drones" );
    common_scripts\utility::array_thread( var_1, ::jammer_3_remove_from_array_when_dead, "drones" );
    common_scripts\utility::array_thread( var_1, ::jammer_3_navy_drone_drones_setup );
}

jammer_3_remove_from_array_when_dead( var_0 )
{
    var_1 = undefined;
    self waittill( "death" );

    if ( var_0 == "navy" )
        var_1 = level.jammer_3_navy_guys;
    else
        var_1 = level.jammer_3_drones;

    var_1 = common_scripts\utility::array_remove( var_1, self );
}

jammer_3_navy_drone_guy_setup()
{
    self endon( "death" );
    maps\_utility::add_damage_function( ::navy_drone_guys_damage_func );
}

deck_enemies_cleared()
{
    for (;;)
    {
        var_0 = getaiarray( "axis" );
        level.deck_drones = maps\_utility::array_removedead( level.deck_drones );

        if ( var_0.size == 0 && level.deck_drones.size == 0 )
            break;

        waitframe();
    }

    var_0 = getaiarray( "allies" );

    foreach ( var_2 in var_0 )
    {
        if ( var_2 == level.cormack || var_2 == level.burke || var_2 == level.maddox )
            continue;
        else
            var_2 thread maps\_utility::set_fixednode_true();
    }
}

navy_drone_guys_damage_func( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( isdefined( var_1 ) && var_1.classname == "script_vehicle_pdrone_atlas" )
        return var_0 * 2;
}

jammer_3_navy_drone_drones_setup()
{
    maps\_utility::add_damage_function( ::navy_drone_drones_damage_func );
}

navy_drone_drones_damage_func( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( isdefined( var_1 ) && maps\_utility::is_in_array( level.jammer_3_navy_guys, var_1 ) )
        return var_0 / 4;
}

jammer_3_shrike_flyby( var_0 )
{
    var_0 waittill( "unloaded" );
    wait 3;
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "jammer_3_shrike_1" );
    var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "jammer_3_shrike_2" );
    soundscripts\_snd::snd_message( "shrike_flyby_pair_04", var_1, var_2 );
}

wait_for_all_deck_warbirds_to_unload()
{
    common_scripts\utility::flag_wait_all( "deck_warbird_3_unloaded", "deck_warbird_4_unloaded" );
    common_scripts\utility::flag_set( "all_deck_warbirds_deployed" );
}

missile_turrets_on()
{
    common_scripts\utility::flag_wait( "all_deck_warbirds_deployed" );
    wait 3;
    var_0 = getentarray( "missile_launcher_1", "targetname" );

    if ( !isdefined( var_0 ) )
        return;

    foreach ( var_2 in var_0 )
    {
        var_2.missile_starts = getentarray( var_2.target, "targetname" );

        if ( !isdefined( var_2.missile_starts ) )
            return;

        foreach ( var_4 in var_2.missile_starts )
            var_4 linkto( var_2 );

        var_2 thread missile_turret_think();
    }
}

missile_turret_think()
{
    level endon( "stop_ship_weapons" );

    for (;;)
    {
        self rotateto( ( 0, randomintrange( 180, 360 ), 0 ), 1.5, 0.25, 0.25 );
        wait 1.5;

        foreach ( var_1 in self.missile_starts )
        {
            var_2 = anglestoforward( var_1.angles );
            var_2 *= 5000;
            var_2 += ( randomintrange( 500, 1000 ), randomintrange( 500, 1000 ), randomintrange( 1000, 2000 ) );
            magicbullet( "mob_missile", var_1.origin, var_1.origin + var_2 );

            if ( distance( self.origin, level.player.origin ) <= 512 )
            {
                earthquake( 0.3, 1, self.origin, 1024 );
                level.player playrumbleonentity( "heavy_1s" );
            }
        }

        wait(randomfloatrange( 10.0, 20.0 ));
    }
}

boosters_off_anim( var_0 )
{
    common_scripts\utility::flag_wait( "flag_move_gideon_into_interior" );
    var_1 = common_scripts\utility::getstruct( "org_squad_enter_mob", "targetname" );
    level.burke maps\_utility::ent_flag_init( "at_boosters_off" );

    if ( !isdefined( var_0 ) || !var_0 )
        level.burke thread go_to_boosters_off_and_first_frame( var_1 );

    common_scripts\utility::flag_wait( "flag_obj_marker_enter_ship" );
    level.cormack maps\_utility::ent_flag_init( "at_boosters_off" );
    level.maddox maps\_utility::ent_flag_init( "at_boosters_off" );
    var_2 = [ level.cormack, level.burke, level.maddox ];

    if ( !isdefined( var_0 ) || !var_0 )
    {
        level.cormack thread go_to_boosters_off_and_first_frame( var_1 );
        level.maddox thread go_to_boosters_off_and_first_frame( var_1 );
    }
    else
    {
        level.cormack maps\_utility::ent_flag_set( "at_boosters_off" );
        level.burke maps\_utility::ent_flag_set( "at_boosters_off" );
        level.maddox maps\_utility::ent_flag_set( "at_boosters_off" );
        var_1 maps\_anim::anim_first_frame( var_2, "boosters_off" );
    }

    level.cormack maps\_utility::ent_flag_wait( "at_boosters_off" );
    level.burke maps\_utility::ent_flag_wait( "at_boosters_off" );
    level.maddox maps\_utility::ent_flag_wait( "at_boosters_off" );
    common_scripts\utility::flag_wait( "flag_player_entered_interior" );
    common_scripts\utility::flag_set( "flag_cleanup_deck_drones" );
    var_2 = getaiarray( "axis" );

    if ( var_2.size > 0 )
    {
        foreach ( var_4 in var_2 )
            var_4 thread maps\sanfran_b_util::bloody_death( randomfloatrange( 0.0, 2.0 ) );
    }

    soundscripts\_snd::snd_message( "enter_ship" );
    common_scripts\utility::flag_set( "boosters_off_anim_started" );
    level.idle_org = var_1;
    var_1 notify( "stop_wait_idle" );
    level.burke thread play_boosters_off_anim( var_1 );
    level.maddox thread play_boosters_off_anim( var_1 );
    var_1 maps\_anim::anim_single_solo( level.cormack, "boosters_off" );
    common_scripts\utility::flag_set( "boosters_off_anim_finished" );

    foreach ( var_4 in var_2 )
    {
        var_4 maps\_utility::enable_cqbwalk();
        var_4 maps\_utility::enable_ai_color();
        var_4.ignoreall = 0;
    }

    thread squad_move_interior();
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );
}

play_boosters_off_anim( var_0 )
{
    var_0 maps\_anim::anim_single_solo( self, "boosters_off" );
    var_0 thread maps\_anim::anim_loop_solo( self, "boosters_off_idle", "stop_idle" );
}

go_to_boosters_off_and_first_frame( var_0 )
{
    var_0 maps\_anim::anim_reach_solo( self, "boosters_off" );
    maps\_utility::ent_flag_set( "at_boosters_off" );
    var_0 maps\_anim::anim_first_frame_solo( self, "boosters_off" );
    var_0 maps\_anim::anim_loop_solo( self, "boosters_off_wait_idle", "stop_wait_idle" );
}

squad_move_interior()
{
    foreach ( var_1 in level.heroes )
    {
        var_1 maps\_utility::enable_ai_color_dontmove();
        var_1.fixednode = 1;
    }
}

crouch_until_door_open()
{
    self waittill( "goal" );
    self allowedstances( "crouch" );
    self waittill( "door_open" );
    self allowedstances( "stand", "crouch", "prone" );
}

crouch_until_path_to_door( var_0 )
{
    var_0 waittill( "boosters_off" );
    self allowedstances( "crouch" );
    self waittill( "path_to_door" );
    self allowedstances( "stand", "crouch", "prone" );
}

cqb_test()
{
    level.player endon( "end_cqb" );
    level.player giveweapon( "iw5_m160cqb_sp_cqbreddot" );
    level.player giveweapon( "iw5_m160_sp_deam160_variablereddot" );
    level.player switchtoweaponimmediate( "iw5_m160cqb_sp_cqbreddot" );
    level.player setstance( "crouch" );
    thread player_cqb_on();
    level.player notifyonplayercommand( "stance_switched", "+stance" );

    for (;;)
    {
        level.player waittill( "stance_switched" );
        wait 0.5;

        if ( level.player getstance() == "crouch" )
        {
            thread player_cqb_on();
            continue;
        }

        thread player_cqb_off();
    }
}

rock_the_boat()
{
    thread boat_rock_check_triggers();
    var_0 = 3;

    for (;;)
    {
        while ( level.waves == 1 )
        {
            var_1 = getdvar( "phys_gravityChangeWakeupRadius" );
            setsaveddvar( "phys_gravityChangeWakeupRadius", 2000 );
            level.ground_ref_ent rotateto( ( -1, 0, 0 ), var_0, 1, 1 );
            soundscripts\_snd::snd_message( "if_the_boat_is_a_rockin_dont_come_a_knockin", "interior" );
            wait 3.1;
            level.ground_ref_ent rotateto( ( -5, 0, 5 ), var_0, 1, 1 );
            soundscripts\_snd::snd_message( "if_the_boat_is_a_rockin_dont_come_a_knockin", "interior" );
            wait 3.3;
            setsaveddvar( "phys_gravityChangeWakeupRadius", var_1 );
        }

        wait 0.05;
    }
}

boat_rock_check_triggers()
{
    thread wait_for_true();
    thread wait_for_true2();
    thread wait_for_true3();
    thread wait_for_true4();
    thread wait_for_true5();
    thread wait_for_false();
    thread wait_for_false2();
    thread wait_for_false3();
    thread wait_for_false4();
    thread wait_for_false5();
    thread wait_for_false6();
}

wait_for_false()
{
    for (;;)
    {
        maps\_utility::trigger_wait_targetname( "waves_off" );
        level.waves = 0;
        wait 0.05;
    }

    wait 0.05;
}

wait_for_false2()
{
    for (;;)
    {
        maps\_utility::trigger_wait_targetname( "waves_off2" );
        level.waves = 0;
        wait 0.05;
    }

    wait 0.05;
}

wait_for_false3()
{
    for (;;)
    {
        maps\_utility::trigger_wait_targetname( "waves_off3" );
        level.waves = 0;
        wait 0.05;
    }

    wait 0.05;
}

wait_for_false4()
{
    for (;;)
    {
        maps\_utility::trigger_wait_targetname( "waves_off4" );
        level.waves = 0;
        wait 0.05;
    }

    wait 0.05;
}

wait_for_false5()
{
    for (;;)
    {
        maps\_utility::trigger_wait_targetname( "waves_off5" );
        level.waves = 0;
        wait 0.05;
    }

    wait 0.05;
}

wait_for_false6()
{
    for (;;)
    {
        maps\_utility::trigger_wait_targetname( "waves_off6" );
        level.waves = 0;
        wait 0.05;
    }

    wait 0.05;
}

wait_for_true()
{
    for (;;)
    {
        maps\_utility::trigger_wait_targetname( "waves_on" );
        level.waves = 1;
        wait 0.05;
    }

    wait 0.05;
}

wait_for_true2()
{
    for (;;)
    {
        maps\_utility::trigger_wait_targetname( "waves_on2" );
        level.waves = 1;
        wait 0.05;
    }

    wait 0.05;
}

wait_for_true3()
{
    for (;;)
    {
        maps\_utility::trigger_wait_targetname( "waves_on3" );
        level.waves = 1;
        wait 0.05;
    }

    wait 0.05;
}

wait_for_true4()
{
    for (;;)
    {
        maps\_utility::trigger_wait_targetname( "waves_on4" );
        level.waves = 1;
        wait 0.05;
    }

    wait 0.05;
}

wait_for_true5()
{
    for (;;)
    {
        maps\_utility::trigger_wait_targetname( "waves_on5" );
        level.waves = 1;
        wait 0.05;
    }

    wait 0.05;
}

end_cqb()
{
    level.player endon( "death" );
    maps\_utility::trigger_wait_targetname( "trig_spawn_navy_allies_hangar" );
    thread player_cqb_off();
    level.player notify( "end_cqb" );
    level.player takeweapon( "iw5_m160cqb_sp_cqbreddot" );
    level.player switchtoweaponimmediate( "iw5_m160_sp_deam160_variablereddot" );
}

player_cqb_on()
{
    level.player notify( "cqb_mode_toggled" );
    level.player.cqb_mode = 1;
    level.player setmovespeedscale( 1.25 );
    thread maps\_utility::lerp_fov_overtime( 0.15, 60 );

    if ( level.nextgen )
        thread cqb_dof_on();
}

player_cqb_off()
{
    level.player notify( "cqb_mode_toggled" );
    level.player.cqb_mode = undefined;
    level.player setmovespeedscale( 1 );
    thread maps\_utility::lerp_fov_overtime( 0.15, 65 );

    if ( level.nextgen )
        thread cqb_dof_off();
}

cqb_dof_on()
{
    if ( level.nextgen )
        maps\_lighting::create_dof_preset( "cqb_dof", 10, 250, 10, 3000, 9000, 3, 0.5 );
}

cqb_dof_off()
{
    if ( level.nextgen )
        return;
}

handle_enemy_when_player_is_in_cqb()
{
    self endon( "death" );

    for (;;)
    {
        level.player waittill( "cqb_mode_toggled" );

        if ( isdefined( level.player.cqb_mode ) && level.player.cqb_mode )
        {
            self.moveplaybackrate = 0.8;
            continue;
        }

        self.moveplaybackrate = 1;
    }
}

open_door_anim()
{
    level.player endon( "death" );
    common_scripts\utility::flag_wait( "boosters_off_anim_finished" );
    var_0 = common_scripts\utility::getstruct( "org_squad_enter_mob", "targetname" );
    var_0 thread maps\_anim::anim_loop_solo( level.cormack, "boosters_off_idle", "stop_loop" );
    maps\_utility::trigger_wait_targetname( "trig_open_initial_door_anim" );

    if ( level.currentgen )
        thread transient_intro_to_middle();

    var_1 = [ level.interior_door, level.cormack ];
    level.cormack notify( "path_to_door" );
    var_0 notify( "stop_loop" );
    var_0 maps\_anim::anim_reach_solo( level.cormack, "ripopen_bulkhead" );
    level.cormack soundscripts\_snd::snd_message( "aud_burke_open_door" );
    var_2 = getent( "door_open_clip", "targetname" );
    var_2 linkto( level.interior_door, "doorhinge" );
    var_0 thread maps\_anim::anim_single_solo_run( level.cormack, "ripopen_bulkhead" );
    maps\_utility::activate_trigger_with_targetname( "trig_cormack_move_interior_post_door" );

    if ( level.currentgen )
        thread maps\_utility::tff_sync( 11 );

    var_0 maps\_anim::anim_single_solo( level.interior_door, "ripopen_bulkhead" );
    soundscripts\_snd::snd_message( "interior_door1_done" );
    var_3 = getent( "interior_exit_clip", "targetname" );
    var_3 connectpaths();
    var_3 delete();
    var_2 connectpaths();
    maps\_utility::autosave_by_name();
}

transient_intro_to_middle()
{
    level notify( "tff_pre_transition_intro_to_outro" );
    loadtransient( "sanfran_b_outro_tr" );

    while ( !istransientloaded( "sanfran_b_outro_tr" ) )
        wait 0.05;

    level notify( "tff_post_transition_intro_to_outro" );
    maps\_utility::trigger_wait_targetname( "unload_intro_transient" );
    unloadtransient( "sanfran_b_intro_tr" );
    level.interior_door clearanim( level.interior_door maps\_utility::getanim( "ripopen_bulkhead" ), 1.0 );
}

exo_takedown()
{
    maps\_utility::trigger_wait_targetname( "trig_squad_move_interior_post_door" );
    level.idle_org notify( "stop_idle" );
    level.burke maps\_utility::anim_stopanimscripted();
    level.maddox maps\_utility::anim_stopanimscripted();
    level.burke notify( "door_open" );
    level.maddox notify( "door_open" );
    level.cormack notify( "door_open" );
    var_0 = common_scripts\utility::getstruct( "org_exo_takedown", "targetname" );
    var_1 = getent( "exo_takedown_guy2", "targetname" );
    var_0 maps\_anim::anim_reach_solo( level.cormack, "exo_takedown" );
    var_2 = var_1 maps\_utility::spawn_ai();

    if ( isdefined( var_2 ) )
    {
        level.takedownenemy1 = var_2;
        var_2.animname = "guy2";
        var_2.ignoreme = 1;
        var_2.ignoreall = 1;
        var_2.ignoresonicaoe = 1;
        var_2 soundscripts\_snd::snd_message( "aud_burke_takedown" );
        var_3 = [ level.cormack, var_2 ];
        common_scripts\utility::flag_set( "exo_takedown_started" );
        var_0 maps\_anim::anim_single_run( var_3, "exo_takedown" );
    }
    else
    {
        common_scripts\utility::flag_set( "exo_takedown_started" );
        level.cormack maps\_utility::enable_ai_color_dontmove();
        maps\_utility::activate_trigger_with_targetname( "trig_post_exo_takedown_move" );
    }

    level.cormack thread hand_signal_to_cafeteria();
    var_3 = getaiarray( "allies" );

    foreach ( var_5 in var_3 )
    {
        if ( maps\_utility::is_in_array( level.heroes, var_5 ) )
            continue;
        else
            var_5 delete();
    }

    maps\_utility::battlechatter_on( "allies" );
    maps\_utility::battlechatter_on( "axis" );
    thread rock_the_boat();
}

interior_shake_1()
{
    var_0 = getdvar( "phys_gravityChangeWakeupRadius" );
    setsaveddvar( "phys_gravityChangeWakeupRadius", 2000 );
    maps\_utility::trigger_wait_targetname( "trig_interior_shake_1" );
    soundscripts\_snd::snd_message( "if_the_boat_is_a_rockin_dont_come_a_knockin", "interior" );
    soundscripts\_snd::snd_message( "power_outage_audio" );
    level.player playrumbleonentity( "heavy_2s" );
    earthquake( 0.3, 2, level.player.origin, 1024 );
    wait 2.5;
    soundscripts\_snd::snd_message( "if_the_boat_is_a_rockin_dont_come_a_knockin", "interior" );
    level.player playrumbleonentity( "heavy_2s" );
    earthquake( 0.3, 2, level.player.origin, 1024 );
    wait 3;
    setsaveddvar( "phys_gravityChangeWakeupRadius", var_0 );
}

hangar_jet_flyby()
{
    level.player endon( "death" );
    maps\_utility::trigger_wait_targetname( "trig_hangar_jet_flyby" );
    level notify( "stop_ship_weapons" );
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "hangar_jet_flyby_1" );
    wait 0.5;
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "hangar_jet_flyby_2" );
}

give_night_vision()
{
    level endon( "flag_end_sonar_vision" );
    level.player setweaponhudiconoverride( "actionslot1", "dpad_icon_nvg" );
    level.player notifyonplayercommand( "sonar_vision", "+actionslot 1" );
    level.player thread thermal_with_nvg();
}

hand_signal_to_cafeteria()
{
    self endon( "end_hand_signal_to_caf" );
    thread end_hand_signal_to_caf();
    self waittill( "goal" );
    maps\_utility::trigger_wait_targetname( "trig_burke_hand_signal_to_caf" );
    maps\_anim::anim_single_solo( self, "signal_moveout_coverL" );
    maps\_utility::activate_trigger_with_targetname( "trig_move_maddox_past_hand_signal" );
    self notify( "hand_signal_to_caf_finished" );
}

end_hand_signal_to_caf()
{
    self endon( "hand_signal_to_caf_finished" );
    maps\_utility::trigger_wait_targetname( "trig_interior_vo_1" );
    self notify( "end_hand_signal_to_caf" );
    maps\_utility::activate_trigger_with_targetname( "trig_move_maddox_past_hand_signal" );
}

table_pulldown()
{
    maps\_utility::trigger_wait_targetname( "trig_spawn_table_guy" );
    var_0 = getent( "table_pulldown_guy", "targetname" );
    var_1 = var_0 maps\_utility::spawn_ai( 1 );
    var_1.animname = "guy";
    var_1.allowdeath = 1;
    var_1 endon( "death" );
    var_2 = maps\_utility::spawn_anim_model( "cafeteria_table" );
    var_3 = [ var_1, var_2 ];
    var_4 = common_scripts\utility::getstruct( "org_table_pulldown", "targetname" );

    if ( isdefined( var_1 ) && isalive( var_1 ) )
    {
        var_4 maps\_anim::anim_first_frame( var_3, "table_pulldown" );
        common_scripts\utility::flag_wait( "start_table_anim" );

        if ( isdefined( var_1 ) && isalive( var_1 ) )
        {
            var_1.allowdeath = 0;
            var_2 soundscripts\_snd::snd_message( "aud_table_pulldown" );
            var_4 maps\_anim::anim_single( var_3, "table_pulldown" );
            var_1.allowdeath = 1;
            var_4 thread maps\_anim::anim_loop_solo( var_1, "table_pulldown_fire_loop" );
            var_1 thread table_pulldown_distance_check();
            var_1 maps\_utility::set_deathanim( "table_pullddown_death" );
        }
    }
}

table_pulldown_distance_check()
{
    self endon( "death" );

    for (;;)
    {
        if ( distancesquared( self.origin, level.player.origin ) < 250000 )
        {
            self kill();
            return;
        }

        wait 0.1;
    }
}

cafeteria_reinforcements()
{
    level endon( "cafeteria_reinforcement_spawn" );
    common_scripts\utility::flag_wait( "start_table_anim" );
    disable_cormack_obj();

    for (;;)
    {
        var_0 = getaicount( "axis" );

        if ( var_0 > 4 )
        {
            wait 0.05;
            continue;
        }

        maps\_utility::array_spawn_targetname( "cafeteria_reinforcements", 0, 1 );
        break;
    }

    thread cafeteria_squad_pressure();
}

cafeteria_squad_pressure()
{
    var_0 = getaicount( "axis" );
    var_1 = 0;

    while ( var_1 == 0 )
    {
        var_2 = getaicount( "axis" );
        var_3 = getnode( "red6ix", "targetname" );
        var_4 = getnode( "macros", "targetname" );
        var_5 = level.cormack;

        if ( var_0 <= 4 )
        {
            level.burke maps\_utility::set_goal_node( var_4 );
            level.cormack maps\_utility::set_goal_node( var_3 );
            var_1 = 1;
            break;
        }

        wait 0.05;
    }
}

end_squad_cqb()
{
    maps\_utility::trigger_wait_targetname( "trig_interior_vo_1" );
    thread maps\_utility::blend_movespeedscale( 1, 3 );

    foreach ( var_1 in level.heroes )
        var_1 maps\_utility::disable_cqbwalk();
}

move_to_hangar()
{
    maps\_utility::trigger_wait_targetname( "trig_interior_vo_3" );
    common_scripts\utility::flag_set( "player_exit_cafeteria" );
    maps\_utility::trigger_wait_targetname( "trig_cleanup_cafe" );
    var_0 = getaiarray( "axis" );

    foreach ( var_2 in var_0 )
    {
        var_2 maps\sanfran_b_util::bloody_death();
        wait 0.4;
    }
}

hand_signal_to_hangar()
{
    level.cormack endon( "end_hand_signal_to_hangar" );
    level.cormack thread end_hand_signal_to_hangar();
    maps\_utility::trigger_wait_targetname( "trig_interior_vo_2" );
    thread enable_cormack_obj();
    level.cormack waittill( "goal" );
    maps\_utility::trigger_wait_targetname( "trig_interior_vo_3" );
    thread maps\sanfran_b_util::hanger_bad_path();
    level.cormack maps\_anim::anim_single_solo( level.cormack, "signal_moveout_coverL" );
    level.cormack notify( "hand_signal_to_hangar_finished" );
    maps\_utility::activate_trigger_with_targetname( "trig_caf_to_hangar" );
    common_scripts\utility::flag_set( "flag_obj_leave_cafeteria" );
}

end_hand_signal_to_hangar()
{
    level.cormack endon( "hand_signal_to_hangar_finished" );
    maps\_utility::trigger_wait_targetname( "trig_initial_hangar_fight" );
    level.cormack notify( "end_hand_signal_to_hangar" );
    maps\_utility::activate_trigger_with_targetname( "trig_caf_to_hangar" );
    common_scripts\utility::flag_set( "flag_obj_leave_cafeteria" );
}

get_fov_for_player( var_0 )
{
    var_1 = getdvarint( "cg_fov" );
    var_2 = getdvarfloat( "cg_playerFovScale0" );

    if ( isdefined( level.player2 ) && var_0 == level.player2 )
        var_2 = getdvarfloat( "cg_playerFovScale1" );

    return var_1 * var_2;
}

mark_enemies()
{
    level.player endon( "sonar_vision_off" );

    for (;;)
    {
        foreach ( var_1 in getaiarray( "axis" ) )
        {
            var_1 hudoutlineenable( 1, 1, 0 );
            var_1.hudoutlineenabledbysonarvision = 1;
        }

        foreach ( var_4 in getaiarray( "allies" ) )
        {
            var_4 hudoutlineenable( 2, 1, 0 );
            var_4.hudoutlineenabledbysonarvision = 1;
        }

        wait 0.1;
    }
}

is_sonar_vision_allowed()
{
    var_0 = level.player getcurrentweapon();

    if ( weaponhasthermalscope( var_0 ) && level.player playerads() > 0 )
        return 0;

    return 1;
}

disable_sonar_when_not_allowed()
{
    level.player endon( "sonar_vision_off" );

    for (;;)
    {
        if ( !is_sonar_vision_allowed() )
            break;

        waitframe();
    }

    sonar_off();
}

thermal_with_nvg()
{
    level endon( "flag_end_sonar_vision" );
    var_0 = undefined;
    var_1 = undefined;
    var_2 = undefined;

    for (;;)
    {
        self waittill( "sonar_vision" );

        if ( !is_sonar_vision_allowed() )
            continue;

        if ( !isdefined( level.player.sonar_vision ) || !level.player.sonar_vision )
        {
            sonar_on();
            childthread disable_sonar_when_not_allowed();
            continue;
        }

        sonar_off();
    }
}

sonar_save_and_set_dvars()
{
    if ( !isdefined( level.player.sonarvisionsaveddvars ) )
        level.player.sonarvisionsaveddvars = [];

    level.player.sonarvisionsaveddvars["r_hudoutlineenable"] = getdvarint( "r_hudoutlineenable", 1 );
    level.player.sonarvisionsaveddvars["r_hudoutlinepostmode"] = getdvar( "r_hudoutlinepostmode", 0 );
    level.player.sonarvisionsaveddvars["r_hudoutlinehaloblurradius"] = getdvarfloat( "r_hudoutlinehaloblurradius", 1 );
    level.player.sonarvisionsaveddvars["r_hudoutlinehalolumscale"] = getdvarfloat( "r_hudoutlinehalolumscale", 1 );
    level.player.sonarvisionsaveddvars["r_hudoutlinehalowhen"] = getdvar( "r_hudoutlinehalowhen", 1 );
    setsaveddvar( "r_hudoutlineenable", 1 );
    setsaveddvar( "r_hudoutlinepostmode", 2 );
    setsaveddvar( "r_hudoutlinehaloblurradius", 0.7 );
    setsaveddvar( "r_hudoutlinehalolumscale", 2 );
    setsaveddvar( "r_hudoutlinehalowhen", 0 );
    level.player.sonarvisionsaveddvars["r_ssrBlendScale"] = getdvarfloat( "r_ssrBlendScale", 1.0 );
    setsaveddvar( "r_ssrBlendScale", 0.0 );
}

sonar_reset_dvars()
{
    if ( isdefined( level.player.sonarvisionsaveddvars ) )
    {
        setsaveddvar( "r_hudoutlineenable", level.player.sonarvisionsaveddvars["r_hudoutlineenable"] );
        setsaveddvar( "r_hudoutlinepostmode", level.player.sonarvisionsaveddvars["r_hudoutlinepostmode"] );
        setsaveddvar( "r_hudoutlinehaloblurradius", level.player.sonarvisionsaveddvars["r_hudoutlinehaloblurradius"] );
        setsaveddvar( "r_hudoutlinehalolumscale", level.player.sonarvisionsaveddvars["r_hudoutlinehalolumscale"] );
        setsaveddvar( "r_hudoutlinehalowhen", level.player.sonarvisionsaveddvars["r_hudoutlinehalowhen"] );
        setsaveddvar( "r_ssrBlendScale", level.player.sonarvisionsaveddvars["r_ssrBlendScale"] );
    }
}

sonar_on()
{
    level.overlaysonar = create_hud_sonar_overlay( 0, 1 );
    sonar_save_and_set_dvars();
    thread mark_enemies();
    var_0 = 0.05;

    if ( level.currentgen )
        var_0 = 0;

    // level.player lightsetoverrideenableforplayer( "sanfran_b_sonar_vision", var_0 );
    level.player setclutoverrideenableforplayer( "clut_sonar", var_0 );
    soundscripts\_snd::snd_message( "aud_sonar_vision_on" );
    level.player.sonar_vision = 1;
    level notify( "sonar_update" );
}

sonar_off()
{
    var_0 = 0.05;

    if ( level.currentgen )
        var_0 = 0;

    // level.player lightsetoverrideenableforplayer( var_0 );
    level.player setclutoverridedisableforplayer( var_0 );
    soundscripts\_snd::snd_message( "aud_sonar_vision_off" );
    level.player.sonar_vision = 0;
    level notify( "sonar_update" );

    if ( isdefined( level.overlay ) )
        level.overlay destroy();

    if ( isdefined( level.overlaythreat ) )
        level.overlaythreat destroy();

    if ( isdefined( level.overlaysonar ) )
        level.overlaysonar destroy();

    sonar_reset_dvars();

    foreach ( var_2 in getaiarray( "axis", "allies" ) )
    {
        if ( isdefined( var_2.hudoutlineenabledbysonarvision ) )
        {
            var_2 hudoutlinedisable();
            var_2.hudoutlineenabledbysonarvision = undefined;
        }
    }

    level.player notify( "sonar_vision_off" );
}

create_hud_nvg_overlay( var_0, var_1, var_2 )
{
    var_3 = newhudelem();
    var_3.x = 0;
    var_3.y = 0;
    var_3.sort = var_1;
    var_3.horzalign = "fullscreen";
    var_3.vertalign = "fullscreen";
    var_3.alpha = var_2;
    var_3 setshader( var_0, 640, 480 );
    return var_3;
}

create_hud_sonar_overlay( var_0, var_1 )
{
    var_2 = newhudelem();
    var_2.x = 0;
    var_2.y = 0;

    if ( level.currentgen )
        var_2.color = ( 1, 0.6, 0.2 );
    else
        var_2.color = ( 0.1, 0.1, 1 );

    var_2.sort = var_0;
    var_2.horzalign = "fullscreen";
    var_2.vertalign = "fullscreen";
    var_2.alpha = var_1;
    var_2 setsonarvision( 10 );
    return var_2;
}

create_hud_threat_overlay( var_0, var_1 )
{
    var_2 = newhudelem();
    var_2.x = 0;
    var_2.y = 0;
    var_2.color = ( 1, 0.1, 0.1 );
    var_2.sort = var_0;
    var_2.horzalign = "fullscreen";
    var_2.vertalign = "fullscreen";
    var_2.alpha = var_1;
    var_2 setradarhighlight( -1 );
    return var_2;
}

boat_rocking_hangar()
{
    maps\_utility::trigger_wait_targetname( "trig_boat_rock_to_hangar" );
    thread maps\sanfran_b_lighting::lerp_sun_01();
    var_0 = getdvar( "phys_gravityChangeWakeupRadius" );
    setsaveddvar( "phys_gravityChangeWakeupRadius", 2000 );
    level.player playrumbleonentity( "heavy_2s" );
    earthquake( 0.3, 2, level.player.origin, 1024 );
    soundscripts\_snd::snd_message( "pre_hangar_hall_explosion" );
    wait 2.5;
    level.player playrumbleonentity( "heavy_2s" );
    earthquake( 0.3, 2, level.player.origin, 1024 );
    soundscripts\_snd::snd_message( "pre_hangar_hall_explosion" );
    wait 3;
    setsaveddvar( "phys_gravityChangeWakeupRadius", var_0 );
}

boat_rocking_jet_moment()
{

}

jet_moment( var_0, var_1, var_2 )
{
    var_1 thread jet_badplace();
    var_0 maps\_anim::anim_single_solo( var_1, "shrike_slide" );
    var_2 connectpaths();
    var_2 delete();
}

jet_badplace()
{
    thread maps\_vehicle_code::disconnect_paths_whenstopped();
}

ambient_hangar()
{
    common_scripts\utility::flag_wait( "trig_hangar_vo_1" );
    wait 3;
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "hangar_ambient_shrike" );
    var_0 soundscripts\_snd::snd_message( "shrike_hanger_flyby" );
    wait 1;
    var_1 = getentarray( "hangar_ambient_drone_swarm", "script_noteworthy" );

    foreach ( var_3 in var_1 )
    {
        var_4 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( var_3.targetname );
        var_4 maps\_utility::ent_flag_set( "fire_disabled" );
    }
}

initial_hangar_setup()
{
    level.player endon( "death" );
    maps\_utility::trigger_wait_targetname( "trig_initial_hangar_fight" );
    maps\_utility::array_spawn_noteworthy( "initial_hangar_enemies" );
    maps\_utility::disable_trigger_with_targetname( "cine_copter_trigger" );
}

initial_hangar_guys_invuln()
{
    self endon( "death" );
    maps\_utility::magic_bullet_shield();
    maps\_utility::trigger_wait_targetname( "trig_spawn_navy_allies_hangar" );
    wait(randomfloatrange( 0.5, 1.5 ));
    maps\_utility::stop_magic_bullet_shield();

    if ( self.team == "allies" )
    {
        wait(randomfloatrange( 2, 7 ));
        maps\sanfran_b_util::bloody_death();
    }
}

hangar_combat()
{
    level.player endon( "death" );
    maps\_utility::trigger_wait_targetname( "trig_spawn_navy_allies_hangar" );
    level.burke maps\_utility::disable_cqbwalk();
    level.cormack maps\_utility::disable_cqbwalk();
    level.maddox maps\_utility::disable_cqbwalk();
    var_0 = getent( "refl_probe_heli_open", "targetname" );
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "mi17_hangar_1" );
    var_1 soundscripts\_snd::snd_message( "warbird_hanger_dropoff" );
    var_1 setmaxpitchroll( 25, 60 );
    var_1 overridereflectionprobe( var_0.origin );
    var_1 thread maps\sanfran_b_util::warbird_shooting_think( 1 );
    var_1 maps\_vehicle::godon();
    var_1 thread hangar_heli_wait_for_unload( "hangar_fastzip_1" );
    var_1 thread hangar_heli_wait_for_death( "hangar_fastzip_1" );
    thread hanger_warbird_clip_think( "hangar_fastzip_1" );
    waittillframeend;
    var_1 thread hanger_warbird_think();
    var_1 notify( "warbird_fire" );
    var_1 vehicle_removebrushmodelcollision();
    common_scripts\utility::flag_wait( "hangar_fastzip_1" );
    var_1 notify( "warbird_stop_firing" );
    maps\_utility::trigger_wait_targetname( "trig_move_to_hangar_exit_door" );
    var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "littlebird_overwatch" );
    var_2 soundscripts\_snd::snd_message( "littlebird_hanger_flyby" );
    var_2.ignoreme = 1;
    var_2 maps\_vehicle::godon();

    foreach ( var_4 in var_2.riders )
    {
        var_4.ignoreme = 1;

        if ( isalive( var_4 ) )
            var_4 maps\_utility::deletable_magic_bullet_shield();

        if ( var_4.vehicle_position == 6 || var_4.vehicle_position == 5 )
            var_4 laseron();
    }
}

hanger_warbird_clip_think( var_0 )
{
    var_1 = getent( "hanger_warbird_clip", "targetname" );
    common_scripts\utility::flag_wait( var_0 );
    wait 2;
    var_1 notsolid();
}

hanger_warbird_think()
{
    foreach ( var_1 in self.riders )
    {
        if ( var_1.vehicle_position == 0 )
            var_1 maps\_utility::gun_remove();
    }
}

hangar_heli_wait_for_unload( var_0 )
{
    self endon( "death" );
    self waittill( "unloaded" );

    if ( isdefined( var_0 ) )
        common_scripts\utility::flag_set( var_0 );
}

hangar_heli_wait_for_death( var_0 )
{
    self endon( "unloaded" );
    self waittill( "death" );

    if ( isdefined( var_0 ) )
        common_scripts\utility::flag_set( var_0 );
}

hangar_combat_reinforcements()
{
    level.player endon( "death" );
    common_scripts\utility::flag_wait( "hangar_fastzip_1" );
    maps\sanfran_b_util::wait_for_number_enemies_alive( 3 );
    common_scripts\utility::flag_set( "hangar_reinforcements" );
    var_0 = getent( "hangar_door_left", "targetname" );
    var_1 = getent( "clip_hangar_door_left", "targetname" );
    var_2 = common_scripts\utility::getstruct( "org_hangar_door_close_left", "targetname" );
    var_3 = getent( "hangar_door_right", "targetname" );
    var_4 = getent( "clip_hangar_door_right", "targetname" );
    var_5 = common_scripts\utility::getstruct( "org_hangar_door_close_right", "targetname" );
    var_6 = 4;
    var_7 = [ var_0, var_3 ];
    var_8 = var_3.origin;
    soundscripts\_snd::snd_message( "hangar_doors_open", var_7, var_6, var_8 );
    var_0 moveto( var_2.origin, var_6, 0.05, 0.15 );
    var_1 moveto( var_2.origin, var_6, 0.05, 0.15 );
    var_3 moveto( var_5.origin, var_6, 0.05, 0.15 );
    var_4 moveto( var_5.origin, var_6, 0.05, 0.15 );
    maps\_utility::activate_trigger_with_targetname( "trig_move_allies_for_hangar_reinforcements" );
    maps\_utility::array_spawn_noteworthy( "hangar_enemy_reinforcements_1", 1, 1 );
    var_9 = getent( "hangar_enemy_reinforcements_1_mech", "script_noteworthy" ) maps\_utility::spawn_ai( 1 );
    var_9 thread hanger_mech_think();
    level notify( "hangar_reinforcements_spawned" );
    maps\_utility::enable_trigger_with_targetname( "cine_copter_trigger" );
    wait 2;
    var_1 connectpaths();
    var_4 connectpaths();
    wait 5;
    common_scripts\utility::flag_set( "ast_vo" );
}

hanger_mech_think()
{
    self endon( "death" );
    maps\_mech::mech_start_reduced_nonplayer_damage();
    self setgoalentity( level.player );
    self.favoriteenemy = level.player;
    createthreatbiasgroup( "player" );
    createthreatbiasgroup( "mech" );
    level.player setthreatbiasgroup( "player" );
    self setthreatbiasgroup( "mech" );
    setthreatbias( "player", "mech", 900000 );
    maps\_mech::mech_start_rockets();
    maps\_mech::mech_start_hunting();
}

wait_for_mech_distance()
{
    self endon( "death" );
    var_0 = getent( "obj_defend_01", "targetname" );
    var_1 = 600;
    var_2 = var_1 * var_1;

    while ( distancesquared( self.origin, var_0.origin ) < var_2 )
        wait 0.1;
}

hangar_exit_door()
{
    level.player endon( "death" );
    var_0 = common_scripts\utility::getstruct( "org_hangar_exit_door", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "hangar_exit_door" );
    var_0 maps\_anim::anim_first_frame_solo( var_1, "hangar_exit" );
    level waittill( "hangar_reinforcements_spawned" );
    maps\sanfran_b_util::wait_for_number_enemies_alive( 2 );
    var_2 = getaiarray( "axis" );

    foreach ( var_4 in var_2 )
    {
        wait(randomfloatrange( 0.25, 1.25 ));
        var_4 thread maps\_utility::player_seek_enable();
    }

    maps\sanfran_b_util::wait_for_number_enemies_alive( 0 );
    maps\_utility::activate_trigger_with_targetname( "trig_move_to_hangar_exit_door" );
    common_scripts\utility::flag_set( "flag_obj_leave_hanger" );
    maps\_utility::trigger_wait_targetname( "trig_cormack_to_hangar_door" );
    var_2 = [ var_1, level.burke ];
    var_0 maps\_anim::anim_reach_solo( level.burke, "hangar_exit" );
    var_1 soundscripts\_snd::snd_message( "aud_hangar_door_exit" );
    thread send_cormack();
    var_0 maps\_anim::anim_single( var_2, "hangar_exit" );
    level.cormack maps\_utility::enable_ai_color_dontmove();
    level.cormack maps\_utility::enable_sprint();
    maps\_utility::activate_trigger_with_targetname( "trig_post_hangar_move" );
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );
}

send_cormack()
{
    wait 3.24;
    var_0 = getent( "hangar_door_clip", "targetname" );
    var_0 connectpaths();
    var_0 delete();
    maps\_utility::activate_trigger_with_targetname( "cormack_move_fast" );
    common_scripts\utility::flag_set( "through_door_vo" );
}

hand_signal_after_hangar()
{
    maps\_utility::trigger_wait_targetname( "cormack_move_fast" );
    wait 1.5;
    level.maddox.goalradius = 8;
    var_0 = getnode( "maddoxnode", "targetname" );
    level.maddox maps\_utility::set_goal_node( var_0 );
    level.maddox waittill( "goal" );
    wait 2.4;
    level.maddox maps\_anim::anim_single_solo( level.maddox, "signal_moveout_coverL" );
    wait 0.1;
    level.maddox.goalradius = 1024;
    level.maddox maps\_utility::enable_ai_color_dontmove();
    maps\_utility::activate_trigger_with_targetname( "maddox_move" );
}

sf_b_videolog()
{
    common_scripts\utility::flag_wait( "trig_hangar_ambient_naval_combat" );
    maps\_shg_utility::play_videolog( "sanfran_b_videolog", "screen_add" );
}

door_takedown_door()
{
    var_0 = maps\_utility::spawn_anim_model( "takedown_door" );
    var_1 = common_scripts\utility::getstruct( "org_bulkhead_takedown", "targetname" );
    level.takedown_door = var_0;
    var_1 maps\_anim::anim_first_frame_solo( var_0, "door_takedown" );
}

ambient_combat()
{
    level.player endon( "death" );
    thread maps\sanfran_b_lighting::play_flickering_info_hallway_light();
    common_scripts\utility::flag_wait( "trig_hangar_ambient_naval_combat" );
}

delete_hangar_allies_on_goal()
{
    if ( !isdefined( self.script_parameters ) )
        return;

    if ( self.script_parameters == "delete_on_goal" )
    {
        self endon( "death" );
        self waittill( "goal" );
        self delete();
    }
}

destroy_cine_helicopter()
{
    var_0 = getent( "missile_launcher_special", "targetname" );
    var_0.missle_starts = getentarray( var_0.target, "targetname" );

    foreach ( var_2 in var_0.missle_starts )
        var_2 linkto( var_0 );

    thread beginning_idle_cine_turret();
    common_scripts\utility::flag_wait( "DestroyCineCopter" );
    level.spawncopter = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "CineWarbird" );
    level.spawncopter soundscripts\_snd::snd_message( "warbird_flyover_shootdown" );
    wait 2;
    var_0 thread turret_targeting();
    wait 1.5;
    shootcineturrets();
}

turret_targeting()
{
    level endon( "stop_ship_weapons" );

    while ( isdefined( level.spawncopter ) )
    {
        var_0 = vectornormalize( level.spawncopter.origin - self.origin );
        var_1 = anglestoforward( self.angles );
        var_2 = vectortoangles( var_0 );
        var_3 = vectortoangles( var_1 );

        if ( var_3[1] > var_2[1] )
        {
            var_4 = var_3[1] - var_2[1];
            maps\_utility::_rotateyaw( ( var_3[1] - var_2[1] ) * -1, 0.5, 0.05, 0.05 );
        }
        else if ( var_3[1] < var_2[1] )
        {
            var_4 = var_2[1] - var_3[1];
            maps\_utility::_rotateyaw( var_2[1] - var_3[1], 0.5, 0.05, 0.05 );
        }
        else
            wait 0.05;

        wait 0.05;
    }

    var_5 = common_scripts\utility::getstruct( "helicopter_crash_location", "targetname" );
    earthquake( 0.5, 1.5, level.player.origin, 1024 );
    level.player playrumbleonentity( "heavy_2s" );
    start_idle_shooting();
}

shootcineturrets()
{
    var_0 = getent( "missile_launcher_special", "targetname" );
    var_0.missle_starts = getentarray( var_0.target, "targetname" );

    foreach ( var_2 in var_0.missle_starts )
    {
        var_3 = magicbullet( "mob_missile", var_2.origin, level.spawncopter.origin );
        var_3 missile_settargetent( level.spawncopter );
        wait 0.05;
    }

    earthquake( 0.3, 1.5, level.player.origin, 1024 );
    level.player playrumbleonentity( "heavy_2s" );
}

start_idle_shooting()
{
    level endon( "stop_ship_weapons" );
    var_0 = getent( "missile_launcher_special", "targetname" );
    var_0.missle_starts = getentarray( var_0.target, "targetname" );

    for (;;)
    {
        var_0 rotateto( ( 0, randomintrange( 180, 360 ), 0 ), 1.5, 0.25, 0.25 );
        wait 1.5;

        foreach ( var_2 in var_0.missle_starts )
        {
            var_3 = anglestoforward( var_2.angles );
            var_3 *= 5000;
            var_3 += ( randomintrange( 500, 1000 ), randomintrange( 500, 1000 ), randomintrange( 1000, 2000 ) );
            magicbullet( "mob_missile", var_2.origin, var_2.origin + var_3 );
        }

        wait(randomfloatrange( 10.0, 20.0 ));
    }
}

beginning_idle_cine_turret()
{
    level endon( "DestroyCineCopter" );
    var_0 = getent( "missile_launcher_special", "targetname" );
    var_0.missle_starts = getentarray( var_0.target, "targetname" );

    for (;;)
    {
        var_0 rotateto( ( 0, randomintrange( 180, 360 ), 0 ), 1.5, 0.25, 0.25 );
        wait 1.5;

        foreach ( var_2 in var_0.missle_starts )
        {
            var_3 = anglestoforward( var_2.angles );
            var_3 *= 5000;
            var_3 += ( randomintrange( 500, 1000 ), randomintrange( 500, 1000 ), randomintrange( 1000, 2000 ) );
            magicbullet( "mob_missile", var_2.origin, var_2.origin + var_3 );
        }

        wait(randomfloatrange( 10.0, 20.0 ));
    }
}

door_takedown()
{
    common_scripts\utility::flag_wait( "flag_door_takedown" );
    var_0 = getent( "door_takedown_corner_clip", "targetname" );
    var_1 = getent( "door_takedown_initial_clip", "targetname" );
    var_1 linkto( level.takedown_door, "doorhinge" );
    var_2 = common_scripts\utility::getstruct( "org_bulkhead_takedown", "targetname" );
    var_3 = getent( "door_takedown_guy2", "targetname" );

    if ( level.currentgen )
        loadtransient( "sanfran_b_intro_tr" );

    if ( common_scripts\utility::flag( "flag_door_takedown_cormack_ahead" ) == 1 )
    {
        level.cormack maps\_utility::disable_sprint();
        level.cormack.moveplaybackrate = 1.1;
        level.cormack maps\_utility::place_weapon_on( level.cormack.primaryweapon, "chest" );
        var_2 maps\_anim::anim_reach_solo( level.cormack, "door_takedown" );
        level.cormack soundscripts\_snd::snd_message( "aud_door_takedown_mix_handler" );
        var_4 = var_3 maps\_utility::spawn_ai( 1 );
        var_4 thread maps\_utility::deletable_magic_bullet_shield();
        var_4.animname = "guy";
        var_4.ignoreme = 1;
        var_4.ignoreall = 1;
        var_4.ignoresonicaoe = 1;
        var_4 disableaimassist();
        var_4 soundscripts\_snd::snd_message( "aud_door_takedown_scream" );
        var_5 = [ level.takedown_door, var_4 ];
        var_2 thread maps\_anim::anim_single_solo_run( level.cormack, "door_takedown" );
        maps\_utility::activate_trigger_with_targetname( "trig_move_cormack_after_takedown" );
        var_2 maps\_anim::anim_single( var_5, "door_takedown" );
        var_4 maps\_utility::stop_magic_bullet_shield();
        var_4 kill();
        var_4 startragdoll();
        var_1 connectpaths();
        var_0 connectpaths();
        var_0 delete();
        level.cormack thread maps\_utility::place_weapon_on( level.cormack.primaryweapon, "right" );
        level.cormack.moveplaybackrate = 1;
        level.cormack maps\sanfran_b_util::disable_awareness();
        maps\_utility::activate_trigger_with_targetname( "trig_information_center_vo_1" );
        common_scripts\utility::flag_set( "flag_information_center_vo_1" );
        common_scripts\utility::flag_wait( "CormackSafe" );
        level.cormack maps\sanfran_b_util::enable_awareness();
        maps\_utility::battlechatter_on( "allies" );
        maps\_utility::battlechatter_on( "axis" );
    }
    else
    {
        var_4 = var_3 maps\_utility::spawn_ai( 1 );
        var_4.animname = "guy";
        var_4.ignoreme = 1;
        var_4.ignoresonicaoe = 1;
        var_4 thread enemy_door_ambush_monitor_health();
        var_5 = [ level.takedown_door, var_4 ];
        var_2 maps\_anim::anim_single( var_5, "door_ambush" );
        var_4.ignoreme = 0;
        var_1 connectpaths();
        var_0 connectpaths();
        var_0 delete();
        level waittill( "surprise_enemy_dead" );
        maps\_utility::activate_trigger_with_targetname( "trig_move_cormack_after_takedown" );
        maps\_utility::activate_trigger_with_targetname( "trig_information_center_vo_1" );
        common_scripts\utility::flag_set( "flag_information_center_vo_1" );
        maps\_utility::battlechatter_on( "allies" );
        maps\_utility::battlechatter_on( "axis" );
    }
}

enemy_door_ambush_monitor_health()
{
    self waittill( "death" );
    level notify( "surprise_enemy_dead" );
}

player_entering_server_room()
{
    common_scripts\utility::flag_wait( "entering_server_room" );
    common_scripts\utility::flag_clear( "sonar_threat_detection_off" );
    soundscripts\_snd::snd_message( "enter_server_room" );
}

information_center_combat()
{
    maps\_utility::trigger_wait_targetname( "trig_initial_information_center_combat" );
    level.burke maps\_utility::disable_cqbwalk();
    level.cormack maps\_utility::disable_cqbwalk();
    level.maddox maps\_utility::disable_cqbwalk();
    common_scripts\utility::flag_wait( "BeginCheckingForLos" );
    var_0 = getentarray( "toplevelambush_ai", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 thread player_los_check();

    thread information_center_enemies_charge();
    common_scripts\utility::flag_wait_either( "information_center_cleared", "information_center_enemies_killed" );
    common_scripts\utility::flag_set( "flag_bridge" );
    soundscripts\_snd::snd_message( "enter_bridge" );
    thread maps\sanfran_b_lighting::play_flickering_info_light();
    thread maps\sanfran_b_lighting::play_flickering_info_hallway_light();
    thread maps\sanfran_b_lighting::lerp_sun_02();
}

information_center_enemies_charge()
{
    level endon( "information_center_cleared" );
    var_0 = getaiarray( "axis" );
    var_0 = maps\_utility::remove_dead_from_array( var_0 );

    while ( var_0.size > 2 )
    {
        var_0 = maps\_utility::remove_dead_from_array( var_0 );
        waitframe();
    }

    foreach ( var_2 in var_0 )
    {
        if ( isalive( var_2 ) )
            var_2 thread maps\_utility::player_seek_enable();
    }
}

spawn_last_two_guys()
{
    level endon( "dontspawntroops" );
    common_scripts\utility::flag_wait( "information_center_enemies_killed" );
    common_scripts\utility::flag_wait( "toptouched" );
    var_0 = getent( "lasttroop1", "targetname" ) maps\_utility::spawn_ai();
    var_1 = getent( "lasttroop2", "targetname" ) maps\_utility::spawn_ai();
}

player_los_check()
{
    self endon( "Death" );

    for (;;)
    {
        if ( self cansee( level.player ) )
        {
            wait 0.05;
            continue;
        }

        self findshufflecovernode();
        wait 0.05;
    }
}

straighten_ship()
{
    level.ground_ref_ent rotatepitch( 5, 2 );
    soundscripts\_snd::snd_message( "if_the_boat_is_a_rockin_dont_come_a_knockin", "interior" );
    wait 2;
    level.ground_ref_ent rotateroll( -7, 2 );
    soundscripts\_snd::snd_message( "if_the_boat_is_a_rockin_dont_come_a_knockin", "interior" );
}

delete_specific_navy_ships()
{
    var_0 = getentarray( "navy_ship", "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2.script_parameters ) && var_2.script_parameters == "delete_on_bridge" )
            var_2 delete();
    }
}

move_squad_to_bridge()
{
    maps\_utility::activate_trigger_with_targetname( "trig_move_squad_to_bridge" );
    wait 0.05;
    maps\_utility::autosave_by_name();

    foreach ( var_1 in level.heroes )
        var_1.baseaccuracy *= 10;
}

console_guy()
{
    soundscripts\_snd::snd_message( "cormack_shoots_bridge_guy" );
    maps\_utility::trigger_wait_targetname( "trig_spawn_console_guy" );
    common_scripts\_exploder::exploder( 5234 );
    thread maps\_shg_fx::vfx_sunflare( "sanfran_sunflare_a" );

    foreach ( var_1 in level.heroes )
        var_1 maps\sanfran_b_util::disable_awareness_limited();

    level notify( "console_guy_spawn" );
    var_1 = getent( "console_guy", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_1.animname = "guy";
    var_1 maps\_utility::battlechatter_off();
    var_1.allowdeath = 0;
    var_1 thread maps\_utility::deletable_magic_bullet_shield();
    var_1.ignoresonicaoe = 1;
    level.console_guy = var_1;
    var_3 = common_scripts\utility::getstruct( "org_burke_control_room", "targetname" );
    var_3 thread maps\_anim::anim_loop_solo( var_1, "guy_control_idle", "stop_console_loop" );
    maps\_utility::trigger_wait_targetname( "trig_console_guy_react" );
    var_3 notify( "stop_console_loop" );
    var_1 maps\_utility::anim_stopanimscripted();
    var_1 thread play_blood_fx_when_shot();
    var_3 maps\_anim::anim_single_solo( var_1, "guy_control_to_fire" );
    var_1 allowedstances( "stand" );
    var_1.goalradius = 4;
    var_1 maps\_utility::set_goal_pos( var_1.origin );
    var_1.dontmelee = 1;
    var_1.ignoresuppression = 1;
    var_1.suppressionwait_old = self.suppressionwait;
    var_1.suppressionwait = 0;
    var_1 maps\_utility::disable_surprise();
    var_1.ignorerandombulletdamage = 1;
    var_1 maps\_utility::disable_bulletwhizbyreaction();
    var_1 maps\_utility::disable_pain();
    var_1.grenadeawareness = 0;
    var_1.disablefriendlyfirereaction = 1;
    var_1.dodangerreact = 0;
    var_1 waittill( "damage" );
    var_1 notify( "stop_console_guy_impact_fx" );
    var_1.ignoreme = 1;
    var_1.ignoreall = 1;
    var_1 disableaimassist();
    var_1 maps\_utility::pretend_to_be_dead();
    var_3 maps\_anim::anim_single_solo( var_1, "guy_control_react" );
    level notify( "console_guy_dead" );
    var_3 thread maps\_anim::anim_loop_solo( var_1, "guy_control_shot_idle", "stop_shot_idle_loop" );
    var_4 = var_1 setcontents( 0 );
    maps\_utility::activate_trigger_with_targetname( "trig_control_room_anims" );
    common_scripts\utility::flag_set( "bridge_drones_dead" );
    level.consoleguy = var_1;
}

play_blood_fx_when_shot()
{
    self endon( "stop_console_guy_impact_fx" );

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4 );
        playfx( common_scripts\utility::getfx( "flesh_hit" ), var_3 );
        wait 0.05;
    }

    wait 2;
}

control_room_anims()
{
    maps\_utility::trigger_wait_targetname( "trig_control_room_anims" );

    foreach ( var_1 in level.heroes )
        var_1 thread maps\sanfran_b_util::hide_friendname_until_flag_or_notify( "forever" );

    var_3 = common_scripts\utility::getstruct( "org_burke_control_room", "targetname" );
    var_3 maps\_anim::anim_reach_solo( level.cormack, "control_room_pulloff" );
    var_3 notify( "stop_shot_idle_loop" );
    level.console_guy maps\_utility::anim_stopanimscripted();
    var_4 = [ level.cormack, level.console_guy ];
    common_scripts\utility::flag_set( "pulloff_anim_started" );
    thread maps\_utility::flag_set_delayed( "target_vo", 4 );
    var_3 maps\_anim::anim_single( var_4, "control_room_pulloff" );
    common_scripts\utility::flag_set( "cormack_on_console" );
    soundscripts\_snd::snd_message( "objective_complete" );
    var_5 = getent( "objective_console", "targetname" );
    var_6 = getent( "console_04a", "targetname" );
    var_7 = spawn( "script_model", var_5.origin );
    var_7.angles = var_5.angles;
    var_7 setmodel( "mob_bridge_console_04b_obj" );
    var_8 = spawn( "script_model", var_6.origin );
    var_8.angles = var_6.angles;
    var_8 setmodel( "mob_bridge_console_04a_obj" );
    var_3 thread maps\_anim::anim_loop_solo( level.console_guy, "guy_control_dead_idle", "never" );
    var_3 thread maps\_anim::anim_loop_solo( level.cormack, "console_idle", "stop_operate_loop" );
    level.player waittill( "laser_off" );
    clearallcorpses();
    level.consoleguy delete();

    foreach ( var_10 in level.heroes )
        var_10 maps\_utility::enable_dontevershoot();

    var_4 = getaiarray( "axis" );

    foreach ( var_13 in var_4 )
    {
        if ( !isdefined( var_13.magic_bullet_shield ) )
        {
            var_13.diequietly = 1;
            var_13 kill();
        }
    }

    if ( isdefined( level.ambient_drones ) )
    {
        foreach ( var_16 in level.ambient_drones )
        {
            if ( isdefined( var_16 ) && isalive( var_16 ) )
            {
                var_16 maps\_vehicle::vehicle_set_health( 1 );
                var_16 dodamage( 99999, var_16.origin );
            }
        }
    }

    soundscripts\_snd::snd_message( "rail_gun_done" );
    thread maps\_sonicaoe::enablesonicaoe();
    common_scripts\utility::flag_clear( "flag_end_sonar_vision" );
    give_night_vision();
    var_7 delete();
    var_8 delete();
    var_3 notify( "stop_operate_loop" );
    level.burke maps\_utility::anim_stopanimscripted();
    var_18 = maps\_utility::spawn_anim_model( "player_rig" );
    var_3 maps\_anim::anim_first_frame_solo( var_18, "sf_b_bridge_dialog" );
    level.player playerlinktodelta( var_18, "tag_player", 1, 0, 0, 0, 0 );
    var_4 = [ var_18, level.burke, level.cormack, level.maddox ];
    var_3 thread maps\_anim::anim_single( var_4, "sf_b_bridge_dialog" );
    var_18 common_scripts\utility::delaycall( 1.0, ::hide );
    common_scripts\utility::flag_wait( "outro_dialogue_finished" );
}

play_cinematic( var_0, var_1, var_2 )
{
    if ( isdefined( level.current_cinematic ) )
    {
        pausecinematicingame( 0 );
        setsaveddvar( "cg_cinematicFullScreen", "1" );
        level.current_cinematic = undefined;
    }
    else
        cinematicingame( var_0 );

    if ( !isdefined( var_2 ) || !var_2 )
        setsaveddvar( "cg_cinematicCanPause", "1" );

    wait 1;

    while ( iscinematicplaying() )
        wait 0.05;

    if ( !isdefined( var_2 ) || !var_2 )
        setsaveddvar( "cg_cinematicCanPause", "0" );
}

setup_mob_turret_targets()
{
    common_scripts\utility::flag_wait( "player_using_mob_turret" );
    common_scripts\_exploder::exploder( 3600 );
    var_0 = getent( "cargo_ship", "targetname" );
    var_1 = getent( "cargo_ship_2", "targetname" );
    var_2 = var_0 setcontents( 0 );
    var_0 setcontents( var_2 | 1 );
    var_3 = var_1 setcontents( 0 );
    var_1 setcontents( var_3 | 1 );
    level.mob_turret_targets = [ var_0, var_1 ];
    common_scripts\utility::array_thread( level.mob_turret_targets, ::detect_cargo_ship_damage );
    common_scripts\utility::array_thread( level.mob_turret_targets, ::detect_cargo_ship_death );

    foreach ( var_5 in level.mob_turret_targets )
        var_5 thread remove_from_target_array_on_death();

    thread wait_for_mob_turret_targets_to_be_destroyed();
}

cargo_ship_fights_back()
{
    common_scripts\utility::flag_wait( "first_cargo_ship_destroyed" );
    wait 2;
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "cargo2_to_player_1" );
    wait(randomfloatrange( 0.3, 1.3 ));
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "cargo2_to_player_2" );
    wait(randomfloatrange( 0.3, 1.3 ));
    var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "cargo2_to_player_3" );
    wait(randomfloatrange( 0.3, 1.3 ));
    var_3 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "cargo2_to_player_4" );
}

#using_animtree("script_model");

detect_cargo_ship_damage()
{
    self endon( "death" );
    self setcandamage( 1 );
    var_0 = undefined;
    var_1 = undefined;
    var_2 = 2000;
    var_3 = 3000;

    if ( level.currentgen )
    {
        var_2 *= 0.5;
        var_3 *= 0.5;
    }

    if ( isdefined( self.script_parameters ) )
    {
        if ( self.script_parameters == "1" )
        {
            var_0 = 1;
            self.animname = "cargo_ship_1";
            self useanimtree( #animtree );
            thread maps\_anim::anim_loop_solo( self, "cargo_ship_idle_large" );
        }

        if ( self.script_parameters == "2" )
        {
            var_0 = 2;
            self.animname = "cargo_ship_2";
            self useanimtree( #animtree );
            thread maps\_anim::anim_loop_solo( self, "cargo_ship_idle_large" );
        }
    }

    var_4 = 0;
    var_5 = undefined;

    while ( var_4 < 2 )
    {
        self.health = 99999;
        // self waittill( "damage", var_6, var_7, var_8, var_9, var_10 );
        var_7 = level.player;
        var_9 = self;
        var_10 = "projectile";

        if ( isdefined( var_7 ) && var_7 == level.player && isdefined( var_9 ) && isdefined( var_10 ) || var_10 == "projectile" )
        {
            // scripted kill because the railgun somehow doesn't do any damage
            wait 5;
            physicsexplosionsphere( var_9, 2048, 1024, var_2 );
            wakeupphysicssphere( var_9, 8000 );
            var_4++;

            if ( var_0 == 1 )
            {
                var_11 = common_scripts\utility::spawn_tag_origin();
                var_12 = level.mob_turret_right gettagorigin( "tag_flash" );
                var_13 = level.mob_turret_right gettagorigin( "tag_flash1" );
                var_14 = anglestoforward( level.mob_turret_right gettagangles( "tag_flash" ) );
                var_15 = anglestoforward( level.mob_turret_right gettagangles( "tag_flash1" ) );
                var_16 = var_12 + var_14 * 20000;
                var_17 = var_12 + var_15 * 20000;
                var_18 = bullettrace( var_12, var_16, 0, level.mob_turret_right, 1 );

                if ( var_18["fraction"] == 1 )
                    var_18 = bullettrace( var_13, var_17, 0, level.mob_turret_right, 1 );

                if ( isdefined( var_18["entity"] ) && var_18["entity"] == self )
                {
                    if ( isdefined( var_18["position"] ) )
                    {
                        var_11.origin = var_18["position"];
                        common_scripts\utility::noself_delaycall( 0.6, ::physicsexplosionsphere, var_11.origin, 1500, 1000, var_3 );
                    }

                    if ( isdefined( var_18["normal"] ) )
                    {
                        var_19 = vectornormalize( var_18["normal"] );
                        var_11.angles = vectortoangles( var_19 );
                        playfx( common_scripts\utility::getfx( "sfb_cargoship_impact_explosion" ), var_11.origin, var_19 + ( 180, 0, 0 ) );
                    }

                    var_20 = getent( "vol_crater_1", "targetname" );

                    if ( var_11 istouching( var_20 ) )
                        var_11 thread spawn_cargo_crater( self, 1 );
                }

                thread maps\_anim::anim_single_solo( self, "cargo_ship_hit_react" );
                soundscripts\_snd::snd_message( "cargo_ship_hit_react", 1 );

                if ( var_4 == 1 )
                    common_scripts\_exploder::exploder( 3200 );

                common_scripts\utility::flag_set( "first_cargo_ship_damaged" );
            }
            else
            {
                wait 5;
                var_11 = common_scripts\utility::spawn_tag_origin();
                var_12 = level.mob_turret_left gettagorigin( "tag_flash" );
                var_13 = level.mob_turret_left gettagorigin( "tag_flash1" );
                var_14 = anglestoforward( level.mob_turret_left gettagangles( "tag_flash" ) );
                var_15 = anglestoforward( level.mob_turret_left gettagangles( "tag_flash1" ) );
                var_16 = var_12 + var_14 * 20000;
                var_17 = var_12 + var_15 * 20000;
                var_18 = bullettrace( var_12, var_16, 0, level.mob_turret_left, 1 );

                if ( var_18["fraction"] == 1 )
                    var_18 = bullettrace( var_13, var_17, 0, level.mob_turret_left, 1 );

                if ( isdefined( var_18["entity"] ) && var_18["entity"] == self )
                {
                    if ( isdefined( var_18["position"] ) )
                    {
                        var_11.origin = var_18["position"];
                        common_scripts\utility::noself_delaycall( 0.6, ::physicsexplosionsphere, var_11.origin, 1500, 1000, var_3 );
                    }

                    if ( isdefined( var_18["normal"] ) )
                    {
                        var_19 = vectornormalize( var_18["normal"] );
                        var_11.angles = vectortoangles( var_19 );
                        playfx( common_scripts\utility::getfx( "sfb_cargoship_impact_explosion" ), var_11.origin, var_19 - ( 180, 0, 0 ) );
                    }

                    var_20 = getent( "vol_crater_2", "targetname" );

                    if ( var_11 istouching( var_20 ) )
                        var_11 thread spawn_cargo_crater( self, 0 );
                }

                thread maps\_anim::anim_single_solo( self, "cargo_ship_hit_react" );
                soundscripts\_snd::snd_message( "cargo_ship_hit_react", 2 );
                common_scripts\utility::flag_set( "second_cargo_ship_damaged" );

                if ( var_4 == 1 )
                    common_scripts\_exploder::exploder( 3300 );
            }
        }
    }

    if ( var_0 == 1 )
    {
        self notify( "ship_destroyed" );
        thread cargo_ship_death_fx( "cargo_ship_1_death" );
        common_scripts\utility::flag_set( "first_cargo_ship_destroyed" );
    }

    if ( var_0 == 2 )
    {
        self notify( "ship_destroyed" );
        thread cargo_ship_death_fx( "cargo_ship_2_death" );
        common_scripts\utility::flag_set( "second_cargo_ship_destroyed" );
    }

    thread deleteboat();
}

deleteboat()
{
    wait 16;
    self delete();
}

spawn_cargo_crater( var_0, var_1 )
{
    var_2 = spawn( "script_model", self.origin );
    var_2 setmodel( "vehicle_atlas_cargo_container_dmg_k" );
    var_2 linkto( var_0 );
    var_2.angles = self.angles;

    if ( isdefined( var_1 ) && var_1 )
        self.angles = ( 0, 180, 0 );

    self linkto( var_0 );
    playfxontag( common_scripts\utility::getfx( "fire_lp_l_blacksmk_thick_nonlit" ), self, "tag_origin" );
    var_0 waittill( "ship_destroyed" );
    wait 2;
    var_2 delete();
    stopfxontag( common_scripts\utility::getfx( "fire_lp_l_blacksmk_thick_nonlit" ), self, "tag_origin" );
}

cargo_ship_rocking( var_0, var_1 )
{
    if ( isdefined( self.rocking ) && self.rocking )
        return;

    self endon( "death" );
    var_2 = 0;

    if ( isdefined( var_1 ) && var_1 )
        self moveto( self.origin + ( 0, 0, -256 ), 2 );

    var_3 = 3;

    while ( isdefined( self ) )
    {
        self rotateroll( var_0, var_3, 0.05, 0.05 );
        wait(var_3);
        self rotateroll( var_0 * -1, var_3, 0.15, 1.5 );

        if ( isdefined( var_1 ) && var_1 && !var_2 )
        {
            self moveto( self.origin + ( 0, 0, 256 ), 4 );
            var_2 = 1;
        }

        wait(var_3);
    }
}

cargo_ship_death_fx( var_0 )
{
    maps\_utility::delaythread( 2.15, ::ship_explosion_rumble, 0.35 );
    maps\_utility::delaythread( 2.15, ::ship_explosion_screenblur );
    maps\_utility::delaythread( 2.4, ::ship_explosion_rumble, 0.35 );
    maps\_utility::delaythread( 2.9, ::ship_explosion_rumble, 0.35 );
    maps\_utility::delaythread( 4.25, ::ship_explosion_rumble, 0.2 );
    maps\_utility::delaythread( 4.9, ::ship_explosion_rumble, 0.3 );
}

ship_explosion_rumble( var_0 )
{
    level.player playrumbleonentity( "heavy_2s" );
    earthquake( var_0, 1.75, level.player.origin, 1024 );
}

ship_explosion_screenblur()
{
    wait 0.15;
    setblur( 1, 0.01 );
    wait 0.05;
    setblur( 0, 0.05 );
}

detect_cargo_ship_death()
{
    self waittill( "death" );

    if ( isdefined( self ) )
        self delete();

    common_scripts\utility::flag_set( "cargo_ship_destroyed" );
}

remove_from_target_array_on_death()
{
    level.player endon( "death" );
    self waittill( "death" );
    level.mob_turret_targets = common_scripts\utility::array_remove( level.mob_turret_targets, self );
}

update_trigger_pos( var_0, var_1 )
{
    var_0 endon( "death" );
    level.player endon( "death" );
    var_1 endon( "death" );
    var_2 = transformmove( ( 0, 0, 0 ), ( 0, 0, 0 ), var_0.origin, var_0.angles, var_1.origin, var_1.angles );

    for (;;)
    {
        var_3 = transformmove( var_0.origin, var_0.angles, ( 0, 0, 0 ), ( 0, 0, 0 ), var_2["origin"], var_2["angles"] );
        var_1.origin = var_3["origin"];
        var_1.angles = var_3["angles"];
        wait 0.05;
    }
}

wait_for_mob_turret_targets_to_be_destroyed()
{
    level.player endon( "death" );

    while ( level.mob_turret_targets.size > 0 )
        wait 0.2;

    common_scripts\utility::flag_set( "laser_targets_destroyed" );
}

handle_mob_turret()
{
    common_scripts\utility::flag_wait( "obj_console" );
    level.player endon( "death" );
    var_0 = getent( "trig_use_console", "targetname" ) maps\_shg_utility::hint_button_trigger( "use", 200 );
    maps\_utility::trigger_wait_targetname( "trig_use_console" );
    level.player maps\_shg_utility::setup_player_for_scene( 1 );
    var_0 maps\_shg_utility::hint_button_clear();
    thread maps\_sonicaoe::disablesonicaoe();
    maps\sanfran_b_sonar_vision::sonar_vision_off();
    sonar_off();
    common_scripts\utility::flag_set( "flag_end_sonar_vision" );
    common_scripts\utility::flag_set( "player_using_mob_turret" );
    soundscripts\_snd::snd_message( "rail_gun_start" );
    level.burke.ignoreme = 1;
    level.cormack.ignoreme = 1;
    level.maddox.ignoreme = 1;
    thread railgun_cargo_ship_missiles();
    thread railgun_minigun_1();
    level.player enableinvulnerability();
    maps\_utility::delaythread( 0.5, maps\_utility::autosave_by_name );
    thread maps\sanfran_b_mob_turret::setup_mob_turret();
    var_1 = getent( "trig_use_console", "targetname" );
    var_1 common_scripts\utility::trigger_off();
    thread water_explosions();
    thread railgun_ambient_air();
    thread railgun_enemies();
    thread static_overlay();
    wait 0.5;
    setsaveddvar( "cg_fov", "75" );
    setsaveddvar( "r_hudoutlineenable", 1 );
    setsaveddvar( "r_hudoutlinewidth", 1 );
    setsaveddvar( "r_hudoutlinepostmode", 2 );
    setsaveddvar( "r_hudoutlinehalolumscale", 0.75 );
    setsaveddvar( "r_hudoutlinehaloblurradius", 0.35 );
}

railgun_cargo_ship_missiles()
{
    while ( !common_scripts\utility::flag( "laser_targets_destroyed" ) )
    {
        if ( common_scripts\utility::flag( "cargo_ship_destroyed" ) )
        {
            wait 0.05;
            continue;
        }

        var_0 = [];
        var_1 = getent( "cargo_ship", "targetname" );

        if ( !common_scripts\utility::flag( "switching_cargo_ships" ) )
        {
            var_0[0] = getent( "railgun_cargo_ship_missiles_1", "targetname" );

            if ( isdefined( var_1 ) )
                var_0[0] linkto( var_1 );

            var_2 = getentarray( "railgun_cargo_missile_targets_1", "targetname" );
            var_0[1] = getent( "railgun_cargo_ship_missiles_2", "targetname" );

            if ( isdefined( var_1 ) )
                var_0[1] linkto( var_1 );

            var_2 = getentarray( "railgun_cargo_missile_targets_2", "targetname" );
        }
        else
        {
            var_0[1] = getent( "railgun_cargo_ship_missiles_2", "targetname" );

            if ( isdefined( var_1 ) )
                var_0[1] linkto( var_1 );

            var_2 = getentarray( "railgun_cargo_missile_targets_2", "targetname" );
        }

        var_3 = var_0[randomint( var_0.size )];
        var_4 = var_2[randomint( var_2.size )];
        var_5 = vectortoangles( var_4.origin - var_3.origin );
        var_6 = magicbullet( "cargo_ship_missile_railgun", var_3.origin, var_4.origin );
        var_6 missile_settargetent( var_4 );
        var_6 missile_setflightmodedirect();
        var_6 thread railgun_missile_impact();
        playfx( common_scripts\utility::getfx( "missile_launch_smoke" ), var_3.origin, anglestoforward( var_5 ), anglestoup( var_5 ) );
        wait(randomfloatrange( 4.0, 8.0 ));
    }

    level notify( "stop_cargo_ship_missiles" );
}

railgun_missile_impact()
{
    self waittill( "death" );
    level endon( "stop_cargo_ship_missiles" );

    if ( distance( level.player.origin, self.origin ) <= 2048 )
    {
        earthquake( 0.4, 1.0, self.origin, 2048 );
        playrumbleonposition( "heavy_1s", self.origin );
    }
}

water_explosions()
{
    level.player endon( "laser_off" );
    common_scripts\utility::flag_wait( "player_on_turret_1" );
    var_0 = randomfloatrange( 3.0, 6.0 );
    var_1 = getent( "water_clip", "targetname" );

    for (;;)
    {
        var_2 = anglestoforward( level.player.angles ) * randomintrange( 2048, 7000 );
        var_3 = anglestoup( level.player.angles ) * -1;
        var_4 = anglestoright( level.player.angles ) * randomintrange( -2048, 2048 );
        var_5 = level.player.origin + var_2 + var_4;
        var_6 = var_5;
        var_7 = var_5 + var_3 * 20000;
        var_8 = bullettrace( var_6, var_7, 0 );

        if ( var_8["fraction"] == 1 )
        {
            wait 0.05;
            continue;
        }

        if ( isdefined( var_8["surfacetype"] ) && var_8["surfacetype"] == "water" && isdefined( var_8["position"] ) || isdefined( var_1 ) && isdefined( var_8["position"] ) && isdefined( var_8["entity"] ) && var_8["entity"] == var_1 )
            playfx( common_scripts\utility::getfx( "water_impact" ), var_8["position"] );

        wait(var_0);
    }
}

railgun_ambient_air()
{
    level.player endon( "laser_off" );
    common_scripts\utility::flag_wait( "player_on_turret_1" );
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "railgun_jet_flyby_1" );
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "railgun_jet_flyby_2" );
    soundscripts\_snd::snd_message( "shrike_railgun_flyby_01", var_0, var_1 );
    common_scripts\utility::flag_wait( "first_cargo_ship_damaged" );
    wait 1;
    var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "railgun_jet_flyby_3" );
    var_3 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "railgun_jet_flyby_4" );
    soundscripts\_snd::snd_message( "shrike_railgun_flyby_02", var_2, var_3 );
    common_scripts\utility::flag_wait( "player_on_turret_2" );
    var_4 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "railgun_jet_flyby_5" );
    var_5 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "railgun_jet_flyby_6" );
    soundscripts\_snd::snd_message( "shrike_railgun_flyby_03", var_4, var_5 );
}

railgun_minigun_1()
{
    var_0 = getentarray( "org_cargo_ship_minigun_1", "targetname" );
    common_scripts\utility::array_thread( var_0, ::railgun_minigun_fire, 1 );
    common_scripts\utility::flag_wait( "player_on_turret_2" );
    var_0 = getentarray( "org_cargo_ship_minigun_2", "targetname" );
    common_scripts\utility::array_thread( var_0, ::railgun_minigun_fire, 2 );
}

railgun_enemies()
{
    maps\_utility::array_spawn_function_noteworthy( "rail_gun_warbird", ::railgun_warbird_think );
    var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive( "rail_gun_1_warbird" );
    common_scripts\utility::flag_wait( "player_switching_to_turret_2" );
    var_0 = maps\_utility::array_removedead( var_0 );
    common_scripts\utility::array_call( var_0, ::delete );
    var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive( "rail_gun_2_warbird" );
    common_scripts\utility::flag_wait( "second_cargo_ship_destroyed" );
    wait 7.75;
    var_0 = maps\_utility::array_removedead( var_0 );
    common_scripts\utility::array_call( var_0, ::delete );
}

railgun_warbird_think()
{
    self setmaxpitchroll( 20, 40 );
    self.emp_hits = 1;
    maps\_utility::add_damage_function( ::rail_gun_warbird_damage_function );
    thread maps\sanfran_b_util::warbird_heavy_shooting_think( 1 );
    self sethoverparams( 1000, 45, 45 );
    self hudoutlineenable( 1, 1 );

    if ( !isdefined( self.ent_flag["warbird_open_fire"] ) )
        maps\_utility::ent_flag_init( "warbird_open_fire" );

    maps\_utility::ent_flag_wait( "warbird_open_fire" );
    self notify( "warbird_fire" );
    maps\_utility::ent_flag_waitopen( "warbird_open_fire" );
    self notify( "warbird_stop_firing" );
}

rail_gun_warbird_damage_function( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( var_1 == level.player && var_4 == "MOD_PROJECTILE" )
    {
        self kill();
        wait 0.05;

        if ( isdefined( self ) )
        {
            self notify( "crash_done" );
            self notify( "in_air_explosion" );
        }
    }
}

railgun_minigun_fire( var_0 )
{
    var_1 = undefined;

    if ( var_0 == 1 )
        level endon( "first_cargo_ship_destroyed" );

    if ( var_0 == 2 )
        level endon( "second_cargo_ship_destroyed" );

    if ( var_0 == 1 )
        var_1 = getent( "cargo_ship", "targetname" );

    if ( var_0 == 2 )
        var_1 = getent( "cargo_ship_2", "targetname" );

    self linkto( var_1 );

    for (;;)
    {
        var_2 = randomfloatrange( 1.5, 3.0 );
        var_3 = randomfloatrange( 1.0, 2.0 );
        var_4 = 0;

        while ( var_4 < var_2 )
        {
            var_5 = randomintrange( -64, 64 );
            var_6 = level.player.origin + ( 0, 0, -120 ) + ( var_5, var_5, var_5 );
            magicbullet( "cargoship_turret", self.origin, var_6 );
            var_7 = var_6 - self.origin;
            playfx( common_scripts\utility::getfx( "cargoship_turret" ), self.origin, var_7 );
            var_4 += 0.05;
            wait 0.05;
        }

        wait(var_3);
    }
}

draw_crosshair()
{
    var_0 = create_hud_laser_crosshair();
    self waittill( "laser_off" );
    var_0 destroy();
}

create_hud_laser_crosshair()
{
    var_0 = newclienthudelem( self );
    var_0.x = 0;
    var_0.y = 0;
    var_0.sort = -5;
    var_0.horzalign = "center";
    var_0.vertalign = "middle";
    var_0 setshader( "reticle_center_cross", 32, 32 );
    var_0.alpha = 1;
    return var_0;
}

static_overlay( var_0 )
{
    create_hud_static_overlay();
    soundscripts\_snd::snd_message( "start_camera_static" );
}

create_hud_static_overlay()
{
    setsaveddvar( "cg_cinematicFullScreen", "1" );
    cinematicingame( "glitch_short" );
}

dismount_console()
{
    static_overlay( 1 );
    var_0 = getent( "trig_use_console", "targetname" );
    var_0 common_scripts\utility::trigger_off();
    setsaveddvar( "cg_fov", "65" );
    level.player unlink();
    level.player notify( "laser_off" );
}

drone_combat()
{
    maps\_utility::trigger_wait_targetname( "trig_spawn_bridge_drones" );
    wait 2.0;
    level.burke maps\_utility::set_grenadeammo( 0 );
    level.cormack maps\_utility::set_grenadeammo( 0 );
    level.maddox maps\_utility::set_grenadeammo( 0 );
    var_0 = maps\_utility::array_spawn_noteworthy( "bridge_drones" );
    common_scripts\utility::array_thread( var_0, maps\sanfran_b_util::setup_atlas_drone, "flag_cleanup_deck_drones" );
    disable_cormack_obj();
    wait 0.05;
    common_scripts\utility::flag_wait( "bridge_drones_dead" );
    maps\_utility::activate_trigger_with_targetname( "trig_control_room_anims" );
}

disable_cormack_obj()
{
    objective_position( maps\_utility::obj( "obj_bridge" ), ( 0, 0, 0 ) );
}

enable_cormack_obj()
{
    objective_onentity( maps\_utility::obj( "obj_bridge" ), level.cormack );
}

track_bridge_drone_deaths()
{
    if ( !isdefined( level.num_bridge_drones_destroyed ) )
        level.num_bridge_drones_destroyed = 0;

    self waittill( "death" );
    level.num_bridge_drones_destroyed++;
}

should_end_sonar_hint()
{
    return isdefined( level.player.sonar_vision ) && level.player.sonar_vision;
}

should_end_laser_hint()
{
    return maps\sanfran_b_laser::is_player_using_laser();
}

should_end_align_hint()
{
    return level.player attackbuttonpressed();
}

align_hint_think()
{
    level.player endon( "death" );
    level.player waittill( "use_laser" );
    maps\_utility::display_hint( "hint_align_laser" );
}

enable_jump_jet_pathing()
{
    if ( issubstr( self.classname, "jump" ) )
        self.canjumppath = 1;
}

handle_sonar_hint()
{
    level.player endon( "death" );
    maps\_utility::trigger_wait_targetname( "trig_display_sonar_hint" );
    common_scripts\utility::flag_wait( "flag_allow_night_vision_hint" );
    wait 0.75;
    maps\_utility::display_hint_timeout( "hint_use_sonar", 5 );
}

sonar_hint_2()
{
    level.player endon( "death" );
    common_scripts\utility::flag_wait( "flag_information_center_vo_2" );

    if ( !maps\_nightvision::nightvision_check( level.player ) )
        maps\_utility::display_hint_timeout( "hint_use_sonar", 3 );
}

disable_ir_in_nightvision()
{
    self.has_no_ir = 1;
}

server_room_lasers()
{
    self laseron();
}

enable_my_thermal()
{
    self thermaldrawenable();
}

disable_my_thermal()
{
    self thermaldrawdisable();
}

slow_player_inside()
{
    common_scripts\utility::flag_wait( "flag_player_entered_interior" );
    thread maps\_utility::blend_movespeedscale( 0.85, 3 );
}

missile_test()
{
    for (;;)
    {
        var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "cargo_to_player_1" );
        wait 3;
    }

    wait 0.05;
}
