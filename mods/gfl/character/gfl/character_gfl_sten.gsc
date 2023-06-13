// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_sten::main();
		return;
	}

	character\gfl\_utility::detach_all_attachments();
	self.charactername = "Sten MkII";
	self setmodel("h2_gfl_sten_body");
	self.headmodel = "h2_gfl_sten_head";
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_sten::precache();
		return;
	}

	precachemodel("h2_gfl_sten_body");
	precachemodel("h2_gfl_sten_head");
}
