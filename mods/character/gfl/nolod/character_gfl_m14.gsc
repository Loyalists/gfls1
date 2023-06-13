// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	character\gfl\_utility::detach_all_attachments();
	self.charactername = "M14";
	self setmodel("s1_gfl_m14_body_nolod");
	self.headmodel = "s1_gfl_m14_head_nolod";
	self.accessorymodels = [ "s1_gfl_m14_hair" ];
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	precachemodel("s1_gfl_m14_body_nolod");
	precachemodel("s1_gfl_m14_head_nolod");
	precachemodel("s1_gfl_m14_hair");
}
