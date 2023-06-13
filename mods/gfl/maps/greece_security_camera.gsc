// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

precachesecuritycamera()
{
    precacheshader( "line_vertical" );
    precachestring( &"GREECE_CAMERA_ZOOM" );
    precachestring( &"GREECE_CAMERA_CYCLE" );
    precachestring( &"GREECE_CAMERA_POTENTIAL_TARGET" );
    precachestring( &"GREECE_CAMERA_TARGET_POS" );
    precachestring( &"GREECE_CAMERA_TARGET_NEG" );
    precachestring( &"GREECE_CAMERA_TARGET_FREQ" );
    precachestring( &"GREECE_CAMERA_SOURCE_FREQ" );
    precachestring( &"GREECE_CAMERA_GHZ" );
    precachestring( &"GREECE_CAMERA_SAT_CONNECT" );
    precachemodel( "tag_player" );
    precachestring( &"add_hudelement_gsc" );
    precachestring( &"manhuntTabletHud" );
    precachestring( &"remove_hudelement_gsc" );
    precachestring( &"updateTargetReticule" );
    precachestring( &"updateCurrentCamera" );
    precachestring( &"updateProgressBarVisibility" );
    precachestring( &"updateProgressBar" );
    precachestring( &"updateTargetDetails" );
    precachestring( &"displayScanResults" );
    precachestring( &"initTabletHUD" );
    level.player setclientomnvar( "ui_manhunttablet", 1 );
}

securitycameraenable( var_0 )
{
    self endon( "DisableScanning" );
    level.securitycamerahud = [];
    level.securitycamerascanhud = [];
    level.activetarget = undefined;
    level.marketcamiszoomed = 0;
    self disableoffhandweapons();
    self disableweaponswitch();
    self allowcrouch( 0 );
    // self enableweapons();
    self disableslowaim();
    self giveweapon( "hms_security_camera" );
    self switchtoweaponimmediate( "hms_security_camera" );
    self hideviewmodel();
    setsaveddvar( "r_hudoutlineenable", 1 );
    setsaveddvar( "r_hudoutlinewidth", 3 );
    _adjustcamerayawpitchrate( "Zoom Out" );
    var_1 = getent( "MarketCameraCliffView", "targetname" );
    var_2 = getent( "MarketCameraCafe", "targetname" );
    var_3 = getent( "MarketCameraExit", "targetname" );

    if ( !isdefined( var_0 ) )
        var_0 = [ var_1, var_2, var_3 ];

    var_4 = undefined;
    var_5 = 0;

    foreach ( var_7 in var_0 )
    {
        if ( isdefined( var_7.script_noteworthy ) && var_7.script_noteworthy == "default_security_camera" )
        {
            var_4 = var_7;
            var_5 = getindex( var_0, var_7 );
        }
    }

    if ( !isdefined( var_4 ) )
        var_4 = var_0[var_5];

    securitycameraviewlink( var_4 );
    wait 0.25;
    level.player setblurforplayer( 0, 1.0 );
    wait 0.25;
    common_scripts\utility::flag_set( "init_tablet_overlay" );
    level.player thread maps\_hud_util::fade_in( 0.25, "white" );
    wait 0.15;
    setsaveddvar( "cg_cinematicfullscreen", "1" );
    cinematicingame( "greece_match_search_scene_intro" );
    maps\_utility::lerp_fov_overtime( 0.35, 70 );
    thread securitycamerahud();
    thread securitycameraminimapangles();
    thread securitycameratargetfrequency();
    thread securitycamerapotentialsignalmatch();
    thread securitycamerascantrace();
    level.player thread securitycameraadsmonitor();
    thread securitycamerareturndistancetotarget();
    thread securitycameraswitching( var_0, var_5 );
    level.player notify( "CafeScanFirstCameraActive" );
}

securitycameraswitching( var_0, var_1 )
{
    level.player endon( "DisableScanning" );
    level waittill( "SafehouseCafeFeedSwitch" );

    for (;;)
    {
        if ( self fragbuttonpressed() )
        {
            if ( var_1 < var_0.size - 1 )
                var_1++;
            else if ( var_1 == var_0.size - 1 )
                var_1 = 0;

            thread securitycameratransitionblur( var_0[var_1], var_0 );
            wait 0.5;
        }
        else if ( self secondaryoffhandbuttonpressed() )
        {
            if ( var_1 > 0 )
                var_1--;
            else if ( var_1 == 0 )
                var_1 = var_0.size - 1;

            thread securitycameratransitionblur( var_0[var_1], var_0 );
            wait 0.5;
        }

        wait 0.05;
    }
}

getindex( var_0, var_1 )
{
    var_2 = 0;

    foreach ( var_4 in var_0 )
    {
        if ( var_4 == var_1 )
            return var_2;

        var_2++;
    }
}

securitycameraviewlink( var_0 )
{
    self unlink();
    wait 0.05;

    if ( isdefined( var_0.script_parameters ) )
        var_1 = lookupcameraconstraints( var_0.script_parameters );
    else
        var_1 = [ 0, 75, 75, 25, 60, 70 ];

    self playerlinktodelta( var_0, "tag_player", 0, var_1[1], var_1[2], var_1[3], var_1[4], 0, 0 );
    self setangles( var_0.angles );
    level.cameralinkpoint = var_0;
    maps\_utility::lerp_fov_overtime( 0.5, var_1[5] );
}

lookupcameraconstraints( var_0 )
{
    switch ( var_0 )
    {
        case "Camera1":
            var_1 = [ 0, 110, 70, 30, 35, 80 ];
            soundscripts\_snd::snd_message( "mhunt_cafe_cam1_switch" );
            return var_1;
        case "Camera2":
            var_1 = [ 0, 135, 25, 30, 45, 65 ];
            soundscripts\_snd::snd_message( "mhunt_cafe_cam2_switch" );
            return var_1;
        case "Camera3":
            var_1 = [ 0, 35, 45, 45, 60, 60 ];
            soundscripts\_snd::snd_message( "mhunt_cafe_cam3_switch" );
            return var_1;
        case "Camera4":
            var_1 = [ 0, 45, 55, 30, 40, 90 ];
            soundscripts\_snd::snd_message( "mhunt_cafe_cam4_switch" );
            return var_1;
    }
}

securitycameratransitionblur( var_0, var_1 )
{
    soundscripts\_snd::snd_message( "mhunt_cafe_cam_switch" );
    var_2 = getindex( var_1, var_0 );
    level.player maps\_hud_util::fade_out( 0.15, "black" );
    level.player notify( "Zoom_Out" );
    level notify( "MarketCameraSwitch" );
    common_scripts\utility::flag_set( "FlagMarketCameraSwitched" );
    wait 0.15;
    thread securitycameraviewlink( var_0 );
    level.player maps\_hud_util::fade_in( 0.15, "black" );
    luinotifyevent( &"updateCurrentCamera", 1, var_2 );
}

securitycameratargetfrequency()
{
    level.player endon( "DisableSecurityCameras" );
    level.frequencytarget = 1500;
    level.frequencysource = 0;
    var_0 = maps\_hud_util::createclientfontstring( "default", 1.5 );
    var_0 maps\_hud_util::setpoint( "TOP", undefined, 0, 30 );
    level.securitycamerascanhud = common_scripts\utility::array_add( level.securitycamerascanhud, var_0 );
    var_1 = maps\_hud_util::createclientfontstring( "default", 1.5 );
    var_1 maps\_hud_util::setpoint( "TOP", undefined, 0, 60 );
    level.securitycamerascanhud = common_scripts\utility::array_add( level.securitycamerascanhud, var_1 );
    var_2 = &"GREECE_CAMERA_TARGET_FREQ";
    var_3 = &"GREECE_CAMERA_SOURCE_FREQ";
    var_4 = &"GREECE_CAMERA_GHZ";

    for (;;)
    {
        if ( isdefined( level.activetarget ) && isdefined( level.activetarget.frequency ) )
            level.frequencysource = level.activetarget.frequency;
        else if ( !isdefined( level.activetarget ) )
            level.frequencysource = 0;

        level.player common_scripts\utility::waittill_any( "target_active", "target_lost" );
        wait 0.05;
    }
}

securitycamerareturndistancetotarget()
{
    level.player endon( "DisableScanning" );

    for (;;)
    {
        if ( isdefined( level.activetarget ) )
            var_0 = distance( level.cameralinkpoint.origin, level.activetarget.origin );

        wait 0.05;
    }
}

comparescreenpos( var_0, var_1 )
{
    return length2d( var_0.screenpos ) < length2d( var_1.screenpos );
}

updaterumble()
{
    level.player endon( "DisableScanning" );
    var_0 = level.player maps\_utility::get_rumble_ent( "steady_rumble" );
    var_1 = maps\_sarray::sarray_spawn();

    for (;;)
    {
        wait 0.05;
        var_1 maps\_sarray::sarray_clear();

        if ( !level.marketcamiszoomed )
        {
            var_0 maps\_utility::set_rumble_intensity( 0 );
            level.intensity = 0;
            continue;
        }

        foreach ( var_3 in level.potentialscantargets )
        {
            if ( !isalive( var_3 ) || !var_3.potentialtarget )
                continue;

            var_4 = 70;

            if ( level.marketcamiszoomed )
                var_4 = 20;

            var_3.screenpos = level.player worldpointtoscreenpos( var_3 getpointinbounds( 0, 0, 0.5 ), var_4 );

            if ( !isdefined( var_3.screenpos ) )
                continue;

            var_1 maps\_sarray::sarray_push( var_3 );
        }

        level.intensity = 0;

        if ( var_1.array.size > 0 )
        {
            maps\_sarray::sarray_sort_by_handler( var_1, maps\_sarray::sarray_create_func_obj( ::comparescreenpos ) );
            var_6 = length2d( var_1.array[0].screenpos );
            level.intensity = 1 - clamp( var_6 / 500, 0, 1 );
            level.intensity = squared( level.intensity );
        }

        var_0.rumble_base_entity = level.cameralinkpoint;
        var_7 = maps\_utility::linear_interpolate( level.intensity, 0, 0.2 );
        var_0 maps\_utility::set_rumble_intensity( var_7 );
    }
}

rumblemonitor()
{
    level.player endon( "DisableScanning" );

    for (;;)
    {
        if ( isdefined( level.intensity ) && level.intensity == 0 )
            level notify( "NotRumbling" );
        else if ( isdefined( level.intensity ) && level.intensity > 0 )
            level notify( "Rumbling" );

        wait 0.05;
    }
}

updatevisualmarker()
{
    level.player endon( "DisableScanning" );

    for (;;)
    {
        level waittill( "Rumbling" );
        playfxontag( common_scripts\utility::getfx( "na45_beacon" ), self, "tag_eye" );
        level waittill( "NotRumbling" );
        stopfxontag( common_scripts\utility::getfx( "na45_beacon" ), self, "tag_eye" );
    }
}

securitycamerapotentialsignalmatch()
{
    level.player endon( "DisableScanning" );
    thread updaterumble();

    for (;;)
    {
        level.player common_scripts\utility::waittill_any( "target_active", "target_lost", "target_scanned" );

        if ( isdefined( level.activetarget ) && isdefined( level.activetarget.potentialtarget ) && level.activetarget.potentialtarget == 1 && level.marketcamiszoomed == 1 )
        {
            luinotifyevent( &"updateProgressBarVisibility", 2, 1, int( level.activetarget.frequency ) );

            if ( !isdefined( level.activetarget.scanprogress ) )
                level.activetarget.scanprogress = 0;

            soundscripts\_snd::snd_message( "mhunt_cafe_cam_scan_target" );
            thread updatescanbar();
            thread maps\greece_safehouse_vo::scancamerafoundpotentialtarget();
        }
        else if ( !isdefined( level.activetarget ) || !isdefined( level.activetarget.potentialtarget ) || level.activetarget.potentialtarget == 0 || level.marketcamiszoomed == 0 )
        {
            luinotifyevent( &"updateProgressBarVisibility", 1, 0 );
            soundscripts\_snd::snd_message( "mhunt_cafe_cam_scan_stop" );
        }

        wait 0.05;
    }
}

updatescanbar()
{
    self endon( "death" );
    level endon( "KVATargetFound" );

    while ( isdefined( level.activetarget ) && isdefined( level.activetarget.scanprogress ) )
    {
        if ( level.player attackbuttonpressed() && level.activetarget.scanprogress != 60 )
        {
            soundscripts\_snd::snd_message( "mhunt_cafe_cam_scan_start" );
            level.activetarget.scanprogress++;

            if ( !iscinematicplaying() )
                cinematicingameloop( "greece_match_search" );
        }
        else if ( !level.player attackbuttonpressed() )
        {
            soundscripts\_snd::snd_message( "mhunt_cafe_cam_scan_stop" );
            stopcinematicingame();
        }
        else if ( level.activetarget.scanprogress == 60 )
        {
            soundscripts\_snd::snd_message( "mhunt_cafe_cam_scan_stop" );
            stopcinematicingame();
            level.activetarget.potentialtarget = 0;
            level.player notify( "target_scanned" );
            level.activetarget notify( "target_scanned" );
            level.activetarget thread displayscanresults();
            break;
        }

        luinotifyevent( &"updateProgressBar", 2, int( level.activetarget.scanprogress ), int( 60 ) );
        wait 0.05;
    }
}

securitycamerahud()
{
    thread securitycamerazoomincontrols();
    thread securitycamerazoomoutcontrols();
    thread securitycamerazoommodifier();
    luinotifyevent( &"updateCurrentCamera", 1, 0 );
    luinotifyevent( &"initTabletHUD", 0 );
}

securitycameraminimapangles()
{
    self endon( "DisableSecurityCameras" );

    for (;;)
    {
        var_0 = level.player getangles();
        level.player setclientomnvar( "ui_greece_camera_angle", int( var_0[1] ) );
        waitframe();
    }
}

displayscanresults()
{
    level.player endon( "DisableScanning" );

    if ( self.team == "axis" && !common_scripts\utility::flag( "FlagKVATargetWaitTimerExpired" ) )
    {
        luinotifyevent( &"displayScanResults", 2, 1, int( level.activetarget.frequency ) );
        soundscripts\_snd::snd_message( "mhunt_cafe_cam_scan_get" );
        level notify( "KVATargetFound" );
        level notify( "CancelMarketScanDialog" );
        thread securitycameramarktargets( 2 );
        thread maps\greece_safehouse_vo::scancameratargetdialogue();
    }
    else if ( self.team != "axis" && !common_scripts\utility::flag( "FlagKVATargetWaitTimerExpired" ) )
    {
        luinotifyevent( &"displayScanResults", 2, 0, int( level.activetarget.frequency ) );
        soundscripts\_snd::snd_message( "mhunt_cafe_cam_scan_fail" );
        thread securitycameramarktargets( 1 );
        thread maps\greece_safehouse_vo::scancameratargetdialogue();
        level.player notify( "CafeScanResultsNegative" );
    }

    wait 2;
}

securitycameramarktargets( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 1;

    self hudoutlineenable( var_0, 1 );
    thread securitycameraclearscannedtarget();
}

securitycameraclearscannedtarget()
{
    level.player endon( "DisableSecurityCameras" );
    self waittill( "death" );

    if ( isdefined( self.team ) && self.team != "axis" )
    {
        if ( target_istarget( self ) )
            target_remove( self );

        self hudoutlinedisable();
    }
}

securitycameraclearalltargets()
{
    level.potentialscantargets = common_scripts\utility::array_removeundefined( level.potentialscantargets );

    foreach ( var_1 in level.potentialscantargets )
    {
        if ( target_istarget( var_1 ) )
            target_remove( var_1 );
    }
}

securitycamerazoominstructions()
{
    level.player waittill( "Zoom_Out" );
    level.player setclientomnvar( "ui_greece_camera_zoom_instructions", 1 );
}

securitycamerazoomincontrols()
{
    self endon( "DisableSecurityCameras" );
    common_scripts\utility::flag_wait( "FlagCameraScanUnlockZoom" );
    setsaveddvar( "cg_cinematicfullscreen", "0" );

    for (;;)
    {
        level.player waittill( "Zoom_In" );
        level.marketcamiszoomed = 1;
        soundscripts\_snd::snd_message( "mhunt_cafe_cam_zoom_in" );
        luinotifyevent( &"updateTargetReticule", 1, 1 );
        maps\_utility::lerp_fov_overtime( 0.35, 20 );
        _adjustcamerayawpitchrate( "Zoom In" );
        level.player waittill( "Zoom_Out" );
    }
}

securitycamerazoomoutcontrols()
{
    self endon( "DisableSecurityCameras" );
    common_scripts\utility::flag_wait( "FlagCameraScanUnlockZoom" );
    thread securitycamerazoominstructions();

    for (;;)
    {
        level.player waittill( "Zoom_Out" );
        level.marketcamiszoomed = 0;
        soundscripts\_snd::snd_message( "mhunt_cafe_cam_zoom_out" );
        luinotifyevent( &"updateTargetReticule", 1, 0 );
        maps\_utility::lerp_fov_overtime( 0.35, 70 );
        _adjustcamerayawpitchrate( "Zoom Out" );
        level.player waittill( "Zoom_In" );
    }
}

securitycameraadsmonitor()
{
    self endon( "DisableSecurityCameras" );

    for (;;)
    {
        if ( level.player adsbuttonpressed() )
            level.player notify( "Zoom_In" );
        else
            level.player notify( "Zoom_Out" );

        wait 0.05;
    }
}

securitycamerazoommodifier()
{
    self endon( "DisableSecurityCameras" );

    for (;;)
    {
        while ( level.marketcamiszoomed )
        {
            if ( isdefined( level.activetarget ) && isdefined( level.activetarget.potentialtarget ) && level.activetarget.potentialtarget == 1 )
                maps\_utility::lerp_fov_overtime( 0.15, 15 );
            else
                maps\_utility::lerp_fov_overtime( 0.15, 20 );

            wait 0.05;
        }

        wait 0.05;
    }
}

_adjustcamerayawpitchrate( var_0 )
{
    switch ( var_0 )
    {
        case "Zoom In":
            setsaveddvar( "aim_turnrate_pitch", 35 );
            setsaveddvar( "aim_turnrate_yaw", 35 );
            setsaveddvar( "aim_accel_turnrate_lerp", 35 );
            break;
        case "Zoom Out":
            setsaveddvar( "aim_turnrate_pitch", 50 );
            setsaveddvar( "aim_turnrate_yaw", 50 );
            setsaveddvar( "aim_accel_turnrate_lerp", 75 );
            break;
    }
}

securitycameradisable()
{
    if ( !isdefined( level.securitycamerascanhud ) )
        return;

    self notify( "DisableScanning" );
    stopallrumbles();
    thread securitycameraclearalltargets();

    foreach ( var_1 in level.securitycamerascanhud )
    {
        if ( isdefined( var_1 ) )
            var_1 maps\_hud_util::destroyelem();
    }

    self waittill( "DisableSecurityCameras" );
    wait 0.25;
    level.player setblurforplayer( 10, 0.5 );
    level.player maps\_hud_util::fade_out( 0.25, "white" );
    level.player setclientomnvar( "ui_manhunttablet", 0 );
    common_scripts\utility::flag_set( "init_safehouse_follow_lighting" );

    if ( isdefined( level.activetarget ) )
        level.activetarget hudoutlinedisable();

    foreach ( var_4 in level.potentialscantargets )
    {
        if ( isalive( var_4 ) )
            var_4 hudoutlinedisable();
    }

    foreach ( var_1 in level.securitycamerahud )
    {
        if ( isdefined( var_1 ) )
            var_1 maps\_hud_util::destroyelem();
    }

    level.player takeweapon( "hms_security_camera" );
    maps\_utility::lerp_fov_overtime( 0.1, 65 );
    setsaveddvar( "aim_turnrate_pitch", 90 );
    setsaveddvar( "aim_turnrate_pitch_ads", 55 );
    setsaveddvar( "aim_turnrate_yaw", 260 );
    setsaveddvar( "aim_turnrate_yaw_ads", 90 );
    setsaveddvar( "aim_accel_turnrate_lerp", 1200 );
    setsaveddvar( "cg_cinematicfullscreen", "1" );
}

scanfadeintro()
{
    wait 0.1;
    level.player lerpfov( 40, 0.5 );
    level.player setblurforplayer( 10, 0.5 );
    wait 0.25;
    level.player maps\_hud_util::fade_out( 0.1, "white" );
}

scanfadeoutro()
{
    wait 0.1;
    thread maps\_hud_util::fade_in( 0.25, "white" );
    wait 0.1;
    level.player setblurforplayer( 0, 0.1 );
}

securitycamerascantrace()
{
    self endon( "DisableScanning" );

    for (;;)
    {
        wait 0.05;

        if ( !level.marketcamiszoomed )
        {
            level.activetarget = undefined;
            continue;
        }

        level.player thread updatetraceentity();
        level.player thread updatetargetdetails();
    }
}

updatetargetdetails()
{
    var_0 = 0;

    if ( isdefined( level.activetarget ) && isdefined( level.activetarget.potentialtarget ) )
    {
        if ( level.activetarget.potentialtarget == 1 )
            var_0 = 2;
        else
            var_0 = 1;
    }

    luinotifyevent( &"updateTargetDetails", 2, var_0, int( level.intensity * 1000 ) );
}

updatetraceentity()
{
    self endon( "DisableScanning" );
    var_0 = level.player geteye();
    var_1 = self getangles();
    var_2 = anglestoforward( var_1 );
    var_3 = var_0 + var_2 * 7000;
    var_4 = bullettrace( var_0, var_3, 1, self, 0, 1 );
    var_5 = var_4["entity"];

    if ( isdefined( var_5 ) )
    {
        if ( !isdefined( level.activetarget ) || var_5 != level.activetarget )
        {
            level.activetarget = var_5;
            level.player notify( "target_active" );
            level.activetarget thread targetmonitor();

            if ( isdefined( level.activetarget.potentialtarget ) && level.activetarget.potentialtarget )
                level.activetarget hudoutlineenable( 5, 0 );
        }
    }
    else if ( !isdefined( var_5 ) )
        level.activetarget = undefined;
}

securitycamerafovcheck()
{
    level.player waittill( "CafeScanFirstCameraActive" );
    level.player endon( "DisableScanning" );
    self endon( "death" );
    var_0 = 0;

    if ( isalive( self ) )
    {
        for (;;)
        {
            var_1 = level.cameralinkpoint.origin;
            var_2 = level.player getangles();
            var_3 = self.origin + ( 0, 0, 48 );
            thread maps\_utility::draw_circle_for_time( var_3, 24, 1, 0, 0, 0.5 );
            var_4 = common_scripts\utility::within_fov( var_1, var_2, var_3, cos( 10 ) );

            if ( var_4 == 1 && level.marketcamiszoomed == 1 && var_0 == 0 )
                var_0 = 1;
            else if ( var_4 == 0 || level.marketcamiszoomed == 0 )
                var_0 = 0;

            wait 0.5;
        }
    }
}

targetmonitor()
{
    self endon( "death" );

    for (;;)
    {
        if ( !isdefined( level.activetarget ) || level.activetarget != self )
        {
            level.player notify( "target_lost" );
            return;
        }

        wait 0.05;
    }
}
