// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_p90::main();
		return;
	}

	character\gfl\_utility::detach_all_attachments();
	self.charactername = "P90";
	self setmodel("h2_gfl_p90_body");
	self.headmodel = "h2_gfl_p90_head";
	self.accessorymodels = [ "h2_gfl_p90_clothes" ];
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_p90::precache();
		return;
	}

	precachemodel("h2_gfl_p90_body");
	precachemodel("h2_gfl_p90_head");
	precachemodel("h2_gfl_p90_clothes");
}
