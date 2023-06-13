// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_suomi::main();
		return;
	}

	character\gfl\_utility::detach_all_attachments();
	self.charactername = "Suomi";
	self setmodel("h2_gfl_suomi_body");
	self.headmodel = "h2_gfl_suomi_head";
	self.accessorymodels = [ "h2_gfl_suomi_hair" ];
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_suomi::precache();
		return;
	}

	precachemodel("h2_gfl_suomi_body");
	precachemodel("h2_gfl_suomi_head");
	precachemodel("h2_gfl_suomi_hair");
}
