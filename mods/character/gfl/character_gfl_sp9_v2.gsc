// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_sp9_v2::main();
		return;
	}

	character\gfl\_utility::detach_all_attachments();
	self.charactername = "SP9";
	self setmodel("h1_gfl_sp9_v2_body");
	self.headmodel = "h1_gfl_sp9_v2_head";
	self.accessorymodels = [ "h1_gfl_sp9_v2_hair" ];
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_sp9_v2::precache();
		return;
	}

	precachemodel("h1_gfl_sp9_v2_body");
	precachemodel("h1_gfl_sp9_v2_head");
	precachemodel("h1_gfl_sp9_v2_hair");
}
