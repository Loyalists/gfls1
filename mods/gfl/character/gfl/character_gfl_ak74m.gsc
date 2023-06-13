// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_ak74m::main();
		return;
	}

	character\gfl\_utility::detach_all_attachments();
	self.charactername = "AK-74M";
	self setmodel("h2_gfl_ak74m_body");
	self.headmodel = "h2_gfl_ak74m_head";
	self.accessorymodels = [ "h2_gfl_ak74m_hair", "h2_gfl_ak74m_outline" ];
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	if ( character\gfl\_utility::is_nolod_enabled() )
	{
		character\gfl\nolod\character_gfl_ak74m::precache();
		return;
	}

	precachemodel("h2_gfl_ak74m_body");
	precachemodel("h2_gfl_ak74m_head");
	precachemodel("h2_gfl_ak74m_hair");
	precachemodel("h2_gfl_ak74m_outline");
}
