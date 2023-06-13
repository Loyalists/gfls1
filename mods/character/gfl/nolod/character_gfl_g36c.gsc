// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	character\gfl\_utility::detach_all_attachments();
	self.charactername = "G36C";
	self setmodel("s1_gfl_g36c_body_nolod");
	self.headmodel = "s1_gfl_g36c_head_nolod";
	self.accessorymodels = [ "s1_gfl_g36c_vest" ];
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	precachemodel("s1_gfl_g36c_body_nolod");
	precachemodel("s1_gfl_g36c_head_nolod");
	precachemodel("s1_gfl_g36c_vest");
}
