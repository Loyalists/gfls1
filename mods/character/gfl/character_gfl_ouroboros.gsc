// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	character\gfl\_utility::detach_all_attachments();
	self.charactername = "Ouroboros";
	self setmodel("h2_gfl_ouroboros_body");
	self.headmodel = "h2_gfl_ouroboros_head";
	character\gfl\_utility::attach_all_attachments();
	self.voice = "american";
	self setclothtype( "vestlight" );
}

precache()
{
	precachemodel("h2_gfl_ouroboros_body");
	precachemodel("h2_gfl_ouroboros_head");
}
