// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	character\gfl\_utility::detach_all_attachments();
	self.charactername = "Destroyer";
	self setmodel("h1_gfl_destroyer_body_nolod");
	self.headmodel = "h1_gfl_destroyer_head_nolod";
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	precachemodel("h1_gfl_destroyer_body_nolod");
	precachemodel("h1_gfl_destroyer_head_nolod");
}
