// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_super_sass::main();
		return;
	}

	character\gfl\_utility::detach_all_attachments();
	self.charactername = "Super SASS";
	self setmodel("h1_gfl_super_sass_body");
	self.headmodel = "h1_gfl_super_sass_head";
	self.accessorymodels = [ "h1_gfl_super_sass_clothes" ];
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_super_sass::precache();
		return;
	}

	precachemodel("h1_gfl_super_sass_body");
	precachemodel("h1_gfl_super_sass_head");
	precachemodel("h1_gfl_super_sass_clothes");
}
