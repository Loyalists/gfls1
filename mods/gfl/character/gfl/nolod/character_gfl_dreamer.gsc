// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	character\gfl\_utility::detach_all_attachments();
	self.charactername = "Dreamer";
	self setmodel("h1_gfl_dreamer_body_nolod");
	self.headmodel = "h1_gfl_dreamer_head_nolod";
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	precachemodel("h1_gfl_dreamer_body_nolod");
	precachemodel("h1_gfl_dreamer_head_nolod");
}
