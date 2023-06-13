// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	character\gfl\_utility::detach_all_attachments();
	self.charactername = "Sten MkII";
	self setmodel("h2_gfl_sten_body_nolod");
	self.headmodel = "h2_gfl_sten_head_nolod";
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	precachemodel("h2_gfl_sten_body_nolod");
	precachemodel("h2_gfl_sten_head_nolod");
}
