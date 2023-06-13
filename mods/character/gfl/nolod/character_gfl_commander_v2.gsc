// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	character\gfl\_utility::detach_all_attachments();
	self.charactername = "Commander";
	self setmodel("s1_gfl_commander_v2_body_nolod");
	self.headmodel = "s1_gfl_commander_v2_head_nolod";
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	precachemodel("s1_gfl_commander_v2_body_nolod");
	precachemodel("s1_gfl_commander_v2_head_nolod");
}
