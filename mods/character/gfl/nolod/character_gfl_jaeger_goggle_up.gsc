// H2 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
	character\gfl\_utility::detach_all_attachments();
	self.charactername = "Jaeger";
	self setmodel("h2_gfl_jaeger_fb_nolod");
	self.accessorymodels = [ "h2_gfl_jaeger_goggle_up" ];
	character\gfl\_utility::attach_all_attachments();
	self.voice = "russian";
	self setclothtype( "vestlight" );
}

precache()
{
	precachemodel("h2_gfl_jaeger_fb_nolod");
	precachemodel("h2_gfl_jaeger_goggle_up");
}
