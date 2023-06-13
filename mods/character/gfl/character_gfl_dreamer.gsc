// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_dreamer::main();
		return;
	}

	character\gfl\_utility::detach_all_attachments();
	self.charactername = "Dreamer";
	self setmodel("h1_gfl_dreamer_body");
	self.headmodel = "h1_gfl_dreamer_head";
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_dreamer::precache();
		return;
	}

	precachemodel("h1_gfl_dreamer_body");
	precachemodel("h1_gfl_dreamer_head");
}
