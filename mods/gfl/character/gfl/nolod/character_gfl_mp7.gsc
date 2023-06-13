// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	character\gfl\_utility::detach_all_attachments();
	self.charactername = "MP7";
	self setmodel("s1_gfl_mp7_body_nolod");
	self.headmodel = "s1_gfl_mp7_head_nolod";
	self.accessorymodels = [ "s1_gfl_mp7_jacket_nolod", "s1_gfl_mp7_hat", "s1_gfl_mp7_headset" ];
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	precachemodel("s1_gfl_mp7_body_nolod");
	precachemodel("s1_gfl_mp7_head_nolod");
	precachemodel("s1_gfl_mp7_jacket_nolod");
	precachemodel("s1_gfl_mp7_hat");
	precachemodel("s1_gfl_mp7_headset");
}
