// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_destroyer::main();
		return;
	}

	character\gfl\_utility::detach_all_attachments();
	self.charactername = "Destroyer";
	self setmodel("h1_gfl_destroyer_body");
	self.headmodel = "h1_gfl_destroyer_head";
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_destroyer::precache();
		return;
	}

	precachemodel("h1_gfl_destroyer_body");
	precachemodel("h1_gfl_destroyer_head");
}
