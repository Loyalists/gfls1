# gfls1
[![Discord](https://img.shields.io/discord/725057886958387393?label=Discord&logo=discord)](https://discord.gg/yYQDxkUtkV)

# Requirements
[Call of Duty: Advanced Warfare](https://store.steampowered.com/app/209650/) (Steam - PC)  

# Installation
1. Prepare a copy of Call of Duty: Advanced Warfare.  
Cracked/Pirated copies of the game will not work properly with the mod. If anything wrong is spotted on your end double check if you are running a legal version before opening up an issue.

2. Download the latest [release](https://github.com/Loyalists/gfls1/releases/tag/1.0).  
**Do NOT download the repository as ZIP, that won't work, make sure you download the LATEST RELEASE.**

3. Extract the archive and copy the files from the latest release into root folder of the game, where s1_sp64_ship.exe is located.

4. Launch the game with s1x-gfl.bat.

# Known Issues
### FOV might be messed up after scripted events (cutscenes, etc)
Try using "cg_fov (number)" in the developer console (Press "~" key to enable it!) to revert the FOV to normal or desired value.  

### Game crashes upon starting up
1. Go to players2/config.cfg. Locate the parameters below.
```
seta r_preloadShaders "1"
seta r_preloadShadersAfterCinematic "0"
```
2. Change them into:
```
seta r_preloadShaders "0"
seta r_preloadShadersAfterCinematic "1"
```

### Game crashes when loading the level
This problem only occurs in **Induction** and **Utopia**. Follow the steps below before playing in the related levels.
1. Replace mod.ff with mod_nolod.ff.  
You may move the original mod.ff to elsewhere and rename the mod_nolod.ff to mod.ff, as the game only reads the fastfile named mod.ff.

2. Go to scripts/gfl.gsc, set the dvar to 1.
```
setdvar( "gfl_enable_nolod", 1 );
```

# Wiki   
[Credits](https://github.com/Loyalists/gfls1/wiki/Credits)   

# Showcase
[Gallery](https://github.com/Loyalists/gfls1/wiki/Gallery)  
[Playlist](https://www.youtube.com/playlist?list=PLHUTPjEfLLEKkzo7Bw1UAdDBTkm084g02)   

# Useful links
[s1-gsc-dump](https://github.com/mjkzy/s1-gsc-dump)   
[x64-zt](https://github.com/Joelrau/x64-zt)   
[zonetool](https://github.com/Joelrau/zonetool)   
[Greyhound](https://github.com/Scobalula/Greyhound)   
[Developer console](https://callofduty.fandom.com/wiki/Developer_console)   

# Disclaimer
The mod is provided as-is and the contributors are not liable for any damage resulting from it. USE IT AT YOUR OWN RISK.
