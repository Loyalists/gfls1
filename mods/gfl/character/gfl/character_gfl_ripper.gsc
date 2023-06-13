// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_ripper::main();
		return;
	}

	character\gfl\_utility::detach_all_attachments();
	self.charactername = "Ripper";
	self setmodel("h2_gfl_ripper_fb");
	character\gfl\_utility::attach_all_attachments();
	self.voice = "russian";
	self setclothtype( "vestlight" );
}

precache()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_ripper::precache();
		return;
	}

	precachemodel("h2_gfl_ripper_fb");
}
