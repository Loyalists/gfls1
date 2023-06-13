// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_ro635::main();
		return;
	}

	character\gfl\_utility::detach_all_attachments();
	self.charactername = "RO635";
	self setmodel("h2_gfl_ro635_body");
	self.headmodel = "h2_gfl_ro635_head";
	self.accessorymodels = [ "h2_gfl_ro635_hair" ];
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_ro635::precache();
		return;
	}

	precachemodel("h2_gfl_ro635_body");
	precachemodel("h2_gfl_ro635_head");
	precachemodel("h2_gfl_ro635_hair");
}
