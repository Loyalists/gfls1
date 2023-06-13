// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	character\gfl\_utility::detach_all_attachments();
	self.charactername = "SPAS-12";
	self setmodel("s1_gfl_spas12_body_nolod");
	self.headmodel = "s1_gfl_spas12_head_nolod";
	self.accessorymodels = [ "s1_gfl_spas12_hair", "s1_gfl_spas12_outline" ];
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	precachemodel("s1_gfl_spas12_body_nolod");
	precachemodel("s1_gfl_spas12_head_nolod");
	precachemodel("s1_gfl_spas12_hair");
	precachemodel("s1_gfl_spas12_outline");
}
