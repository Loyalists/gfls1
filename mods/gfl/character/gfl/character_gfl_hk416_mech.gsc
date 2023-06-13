// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	character\gfl\_utility::detach_all_attachments();
	self.charactername = "HK416";
	self setmodel("s1_gfl_hk416_mech_body");
	self.headmodel = "h2_gfl_hk416_head";
	character\gfl\_utility::attach_all_attachments();
	self.voice = "xslice";
	self setclothtype( "vestlight" );
}

precache()
{
	precachemodel("s1_gfl_hk416_mech_body");
	precachemodel("h2_gfl_hk416_head");
}
