// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	character\gfl\_utility::detach_all_attachments();
	self.charactername = "HK416";
	self setmodel("h2_gfl_hk416_body_nolod");
	self.headmodel = "h2_gfl_hk416_head_nolod";
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	precachemodel("h2_gfl_hk416_body_nolod");
	precachemodel("h2_gfl_hk416_head_nolod");
}
