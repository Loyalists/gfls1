// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init_player_swim( var_0 )
{
    if ( isdefined( level.swim_arms_model ) )
        return;

    if ( isdefined( var_0 ) )
        level.swim_arms_model = var_0;
    else
        level.swim_arms_model = "s1_gfl_ump45_viewhands_player";

    level.swim_end_hide_viewarms = undefined;
    precachemodel( level.swim_arms_model );
    setdvar( "underwater_aim_speed_scale", 0.5 );
    setdvar( "underwater_walk_speed_scale", 0.45 );
    setdvar( "underwater_gravity_scale", 0.6 );
    common_scripts\utility::flag_init( "pause_dynamic_dof" );
    common_scripts\utility::flag_init( "player_swimming_drown" );
}

get_underwater_walk_speed_scale_default()
{
    return 0.45;
}

enable_player_underwater_walk( var_0, var_1, var_2 )
{
    player_set_swimming( "underwater", var_0, var_1, var_2, 1 );
    self notify( "kill_barrel_vfx" );
}

disable_player_underwater_walk( var_0, var_1, var_2 )
{
    player_set_swimming( "none", undefined, undefined, undefined, 1 );
}

enable_player_swim( var_0, var_1, var_2 )
{
    player_set_swimming( "underwater", var_0, var_1, var_2 );
}

disable_player_swim()
{
    player_set_swimming( "none" );
}

player_set_swimming( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_4 ) )
        var_4 = 0;

    switch ( var_0 )
    {
        case "underwater":
            if ( !var_4 )
            {
                self.swimming = var_0;
                maps\_underwater::underwater_hud_enable( 1 );
                maps\_underwater::player_underwater_start( var_1 );
            }
            else
                self.underwater_walk = var_0;

            if ( !isdefined( var_2 ) || var_2 )
                thread player_dynamic_dof( 250 );
        case "surface":
            if ( !var_4 )
            {
                self.swimming = var_0;
                setsaveddvar( "cg_footsteps", 0 );
                setsaveddvar( "cg_equipmentSounds", 0 );
                setsaveddvar( "cg_landingSounds", 0 );
                thread viewmodel_swim_animations( "swimming_end", 0, var_0 == "surface" );
                self allowswim( 1 );

                if ( isdefined( var_3 ) )
                {
                    setsaveddvar( "player_swimWaterSurfaceEnabled", 1 );
                    setsaveddvar( "player_swimWaterSurface", var_3 );
                }
                else
                {
                    setsaveddvar( "player_swimWaterSurfaceEnabled", 0 );
                    setsaveddvar( "player_swimWaterSurface", 0 );
                }
            }

            var_5 = getdvarfloat( "underwater_aim_speed_scale" );
            self enableslowaim( var_5, var_5 );

            if ( !var_4 )
            {
                level.water_current = ( 0, 0, 0 );
                thread player_swimming_moving_water();
                self setstance( "stand" );
            }
            else
            {
                self setmovespeedscale( getdvarfloat( "underwater_walk_speed_scale" ) );

                if ( !isdefined( level.origgravity ) )
                    level.origgravity = self getgravity();

                var_6 = getdvarfloat( "underwater_gravity_scale" ) * level.origgravity;
                self setgravityoverride( int( var_6 ) );

                if ( !isdefined( level.origacceleration ) )
                    level.origacceleration = getdvarfloat( "mechAcceleration" );

                if ( 100.0 != level.origacceleration )
                {
                    if ( isdefined( self.mechdata ) && self.mechdata.active )
                        setsaveddvar( "mechAcceleration", 100.0 );
                    else
                    {

                    }
                }

                if ( !isdefined( level.origairacceleration ) )
                    level.origairacceleration = getdvarfloat( "mechAirAcceleration", 0.6 );

                if ( 0.1 != level.origairacceleration )
                {
                    if ( isdefined( self.mechdata ) && self.mechdata.active )
                        setsaveddvar( "mechAirAcceleration", 0.1 );
                    else
                    {

                    }
                }

                disable_fall_damage();
            }

            break;
        default:
            if ( !var_4 )
            {
                self.swimming = undefined;
                level notify( "stop_player_swimming" );
                setsaveddvar( "cg_footsteps", 1 );
                setsaveddvar( "cg_equipmentSounds", 1 );
                setsaveddvar( "cg_landingSounds", 1 );
                setsaveddvar( "player_swimWaterCurrent", ( 0, 0, 0 ) );
                self notify( "swimming_end" );
                self allowswim( 0 );
            }
            else
            {
                self.underwater_walk = undefined;
                self setmovespeedscale( 1.0 );
                self enableslowaim( 1.0, 1.0 );
                self resetgravityoverride();
                level.origgravity = undefined;
                setsaveddvar( "mechAcceleration", level.origacceleration );
                level.origacceleration = undefined;
                setsaveddvar( "mechAirAcceleration", level.origairacceleration );
                level.origairacceleration = undefined;
                enable_fall_damage();
            }

            self disableslowaim();
            level.water_current = ( 0, 0, 0 );
            break;
    }

    if ( var_0 != "underwater" )
    {
        if ( !var_4 )
        {
            maps\_underwater::underwater_hud_enable( 0 );
            maps\_underwater::player_underwater_end();
        }

        self notify( "stop_dynamic_dof" );
    }
}

disable_fall_damage()
{
    self.bg_falldamageminheight_orig = getdvarint( "bg_fallDamageMinHeight" );
    self.bg_falldamagemaxheight_orig = getdvarint( "bg_fallDamageMaxHeight" );
    setsaveddvar( "bg_fallDamageMinHeight", 2000 );
    setsaveddvar( "bg_fallDamageMaxHeight", 3500 );
}

enable_fall_damage()
{
    setsaveddvar( "bg_fallDamageMinHeight", self.bg_falldamageminheight_orig );
    setsaveddvar( "bg_fallDamageMaxHeight", self.bg_falldamagemaxheight_orig );
}

viewmodel_swim_handle_notetracks()
{
    for (;;)
    {
        self waittill( "swim_notes", var_0 );

        switch ( var_0 )
        {
            case "lagos_swimming_into_stroke":
            case "lagos_swimming_stroke":
                soundscripts\_snd_playsound::snd_play_2d( "underwater_swim_stroke" );
                break;
            case "lagos_swimming_drowning_start":
                soundscripts\_snd_playsound::snd_play_2d( "underwater_drowning" );
                break;
        }
    }
}

#using_animtree("script_model");

viewmodel_swim_animations_loop( var_0, var_1, var_2 )
{
    self endon( "viewmodel_swim_animations" );

    if ( isdefined( var_1 ) )
        self endon( var_1 );

    if ( !isdefined( var_0 ) )
    {
        for (;;)
        {
            var_3 = self getnormalizedmovement();

            if ( abs( var_3[0] ) > 0.25 || abs( var_3[1] ) > 0.25 )
            {
                if ( common_scripts\utility::cointoss() )
                    soundscripts\_snd_playsound::snd_play_2d( "step_walk_plr_water_knee_l" );
                else
                    soundscripts\_snd_playsound::snd_play_2d( "step_walk_plr_water_knee_r" );

                wait 0.5;
            }

            wait 0.05;
        }
    }

    var_0 childthread viewmodel_swim_handle_notetracks();
    var_4 = %wm_unarmed_underwater_swim_idle_loop;

    if ( isdefined( level.swim_anim_idle_loop ) )
        var_4 = level.swim_anim_idle_loop;

    var_5 = %wm_unarmed_underwater_swim_loop_into;

    if ( isdefined( level.swim_anim_loop_into ) )
        var_5 = level.swim_anim_loop_into;

    var_6 = %wm_unarmed_underwater_swim_loop;

    if ( isdefined( level.swim_anim_loop ) )
        var_6 = level.swim_anim_loop;

    var_7 = %wm_unarmed_underwater_swim_drown;

    if ( isdefined( level.swim_anim_drown ) )
        var_7 = level.swim_anim_drown;

    var_8 = %wm_unarmed_underwater_swim_arms_off_screen;

    if ( isdefined( level.swim_anim_offscreen ) )
        var_8 = level.swim_anim_offscreen;

    var_9 = getnotetracktimes( var_6, "anim_interupt" );
    var_10 = getanimlength( var_4 );
    var_11 = getanimlength( var_5 );
    var_12 = getanimlength( var_6 );
    var_13 = 1;
    var_14 = 2;
    var_15 = 3;
    var_16 = 4;
    var_17 = var_13;
    var_0 setflaggedanimknob( "swim_notes", var_8, 1, 0.0 );
    var_0 setflaggedanimknob( "swim_notes", var_4, 1, 0.5 );
    self.swimming_gravity_vel = ( 0, 0, 0 );
    var_18 = 0.0;

    if ( !isdefined( self.ent_flag ) || !isdefined( self.ent_flag["water_trigger_paused"] ) )
        maps\_utility::ent_flag_init( "water_trigger_paused" );

    for (;;)
    {
        if ( self ismantling() )
            return;

        var_19 = self getnormalizedmovement();
        var_20 = self getnormalizedcameramovements();

        if ( maps\_utility::ent_flag( "water_trigger_paused" ) )
        {
            var_19 = ( 0, 0, 0 );
            var_20 = ( 0, 0, 0 );
        }

        var_21 = 0;

        if ( var_19[0] > 0.2 )
            var_21 = 1;

        var_22 = var_17;
        var_23 = ( 0, 0, 0 );

        if ( !var_21 && var_2 )
        {
            var_23 = ( 0, 0, -10 );
            self.swimming_gravity_vel += var_23 * 0.05;
            self.swimming_gravity_vel = ( self.swimming_gravity_vel[0], self.swimming_gravity_vel[1], max( -50, self.swimming_gravity_vel[2] ) );
            var_24 = self.origin + self.swimming_gravity_vel * 0.05;
            var_24 = playerphysicstrace( self.origin, var_24, self );
            self setorigin( var_24 );
        }
        else
            self.swimming_gravity_vel = ( 0, 0, 0 );

        if ( common_scripts\utility::flag( "player_swimming_drown" ) )
        {
            if ( var_17 == var_15 )
            {
                var_25 = var_0 getanimtime( var_6 );

                foreach ( var_27 in var_9 )
                {
                    if ( var_25 > var_27 - 0.1 && var_25 < var_27 + 0.1 )
                        var_17 = var_16;
                }
            }
            else
                var_17 = var_16;
        }

        if ( var_17 == var_13 )
        {
            if ( var_21 )
                var_17 = var_14;
            else if ( var_18 >= var_10 )
                var_22 = 0;
        }
        else if ( var_17 == var_14 )
        {
            if ( var_18 >= var_11 )
            {
                if ( var_21 )
                    var_17 = var_15;
                else
                    var_17 = var_13;
            }
        }
        else if ( var_17 == var_15 )
        {
            if ( var_21 )
            {
                if ( var_18 >= var_12 )
                    var_22 = 0;
            }
            else
            {
                var_25 = var_0 getanimtime( var_6 );

                foreach ( var_27 in var_9 )
                {
                    if ( var_25 > var_27 - 0.1 && var_25 < var_27 + 0.1 )
                        var_17 = var_13;
                }
            }
        }

        if ( var_22 != var_17 )
        {
            if ( var_17 == var_13 )
            {
                if ( var_22 == var_15 || var_22 == var_14 )
                    var_0 setflaggedanimknobrestart( "swim_notes", var_4, 1, 1.0 );
                else
                    var_0 setflaggedanimknobrestart( "swim_notes", var_4 );
            }
            else if ( var_17 == var_14 )
            {
                var_0 notify( "swim_notes", "lagos_swimming_into_stroke" );
                var_0 setflaggedanimknobrestart( "swim_notes", var_5 );
            }
            else if ( var_17 == var_15 )
                var_0 setflaggedanimknobrestart( "swim_notes", var_6 );
            else if ( var_17 == var_16 )
                var_0 setflaggedanimknobrestart( "swim_notes", var_7, 1, 0.75 );

            var_18 = 0.05;
        }

        wait 0.05;
        var_18 += 0.05;
    }
}

viewmodel_swim_animations( var_0, var_1, var_2 )
{
    self notify( "viewmodel_swim_animations" );
    self endon( "viewmodel_swim_animations" );
    self disableweapons();
    self hideviewmodel();

    if ( isdefined( self.swimming_arms ) )
        self.swimming_arms hide();

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !var_2 )
    {
        if ( !isdefined( self.swimming_arms ) || self.swimming_arms.model != level.swim_arms_model )
        {
            var_3 = spawn( "script_model", self.origin );
            var_3 setmodel( level.swim_arms_model );
            var_3 dontcastshadows();
            var_3 setcontents( 0 );
            var_3 useanimtree( #animtree );
            var_3 linktoplayerview( self, "tag_origin", ( 0, 0, -60 ), ( 0, 0, 0 ), 1 );
            self.swimming_arms = var_3;
        }

        if ( isdefined( self.swimming_arms ) )
            self.swimming_arms show();
    }

    if ( isdefined( self.swimming_arms ) )
        viewmodel_swim_animations_loop( self.swimming_arms, var_0, var_1 && !var_2 );

    if ( !common_scripts\utility::flag( "missionfailed" ) && isdefined( self.swimming_arms ) && !self ismantling() )
    {
        self.swimming_arms setflaggedanimknobrestart( "swim_notes", %wm_unarmed_underwater_swim_arms_off_screen );
        var_4 = getanimlength( %wm_unarmed_underwater_swim_arms_off_screen );

        if ( !isdefined( level.swim_end_hide_viewarms ) )
            wait(var_4);
    }

    if ( isdefined( self.swimming_arms ) )
        self.swimming_arms hide();

    self notify( "viewmodel_swim_animations_loop" );
    self enableweapons();

    if ( !isdefined( level.swim_end_hide_viewarms ) )
        self showviewmodel();
}

player_swimming_moving_water()
{
    var_0 = getentarray( "moving_water_flags", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        thread moving_water_flag( var_2 );

    thread move_swimming_player_with_current();
}

moving_water_flag( var_0 )
{
    level endon( "stop_player_swimming" );
    var_1 = getent( var_0.target, "targetname" );
    var_2 = var_1.origin - var_0.origin;

    for (;;)
    {
        common_scripts\utility::flag_wait( var_0.script_flag );
        level.water_current = var_2;
        common_scripts\utility::flag_waitopen( var_0.script_flag );
        level.water_current = ( 0, 0, 0 );
    }
}

move_swimming_player_with_current()
{
    level endon( "stop_player_swimming" );
    var_0 = undefined;

    for (;;)
    {
        if ( !isdefined( var_0 ) || level.water_current != var_0 )
        {
            setsaveddvar( "player_swimWaterCurrent", level.water_current );
            var_0 = level.water_current;
        }

        wait 0.05;
    }
}

player_dynamic_dof( var_0 )
{
    if ( !maps\_utility::is_gen4() )
        return;

    level endon( "stop_player_swimming" );
    self endon( "stop_dynamic_dof" );

    for (;;)
    {
        wait 0.05;

        if ( common_scripts\utility::flag( "pause_dynamic_dof" ) )
        {
            wait 0.05;
            continue;
        }

        var_1 = self playerads();

        if ( var_1 > 0.0 )
            continue;

        var_2 = getdvarfloat( "ads_dof_tracedist", 4096 );
        var_3 = getdvarfloat( "ads_dof_nearStartScale", 0.25 );
        var_4 = getdvarfloat( "ads_dof_nearEndScale", 0.85 );
        var_5 = getdvarfloat( "ads_dof_farStartScale", 1.15 );
        var_6 = getdvarfloat( "ads_dof_farEndScale", 3 );
        var_7 = getdvarfloat( "ads_dof_nearBlur", 4 );
        var_8 = getdvarfloat( "ads_dof_farBlur", 2.5 );
        var_9 = self geteye();
        var_10 = self getangles();

        if ( isdefined( self.dof_ref_ent ) )
            var_11 = combineangles( self.dof_ref_ent.angles, var_10 );
        else
            var_11 = var_10;

        var_12 = vectornormalize( anglestoforward( var_11 ) );
        var_13 = bullettrace( var_9, var_9 + var_12 * var_2, 1, self, 1 );
        var_14 = getaiarray( "axis" );

        if ( var_13["fraction"] == 1 )
        {
            var_2 = 2048;
            var_15 = 256;
            var_16 = var_2 * var_5 * 2;
        }
        else
        {
            var_2 = distance( var_9, var_13["position"] );

            if ( var_2 > var_0 )
            {
                maps\_art::dof_disable_script( 0.5 );
                continue;
            }

            var_15 = var_2 * var_3;
            var_16 = var_2 * var_5;
        }

        foreach ( var_18 in var_14 )
        {
            var_19 = vectornormalize( var_18.origin - var_9 );
            var_20 = vectordot( var_12, var_19 );

            if ( var_20 < 0.923 )
                continue;

            var_21 = distance( var_9, var_18.origin );

            if ( var_21 - 30 < var_15 )
                var_15 = var_21 - 30;

            if ( var_21 + 30 > var_16 )
                var_16 = var_21 + 30;
        }

        if ( var_15 > var_16 )
            var_15 = var_16 - 256;

        if ( var_15 > var_2 )
            var_15 = var_2 - 30;

        if ( var_15 < 1 )
            var_15 = 1;

        if ( var_16 < var_2 )
            var_16 = var_2;

        var_23 = var_15 * var_3;
        var_24 = var_16 * var_6;
        maps\_art::dof_enable_script( var_23, var_15, var_7, var_16, var_24, var_8, 0.5 );
    }

    wait 0.05;
}
