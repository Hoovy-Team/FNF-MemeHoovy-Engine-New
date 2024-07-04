# Friday Night Funkin' - MemeHoovy Engine (Deprecated)

This engine has since been deprecated, but I will occasionally work on it for fun and out of boredom, and to fix bugs. But, I will not be updating the gamebanana page, and it will stay that way. btw if you wanna revive the engine or something, go ahead, it's apache licensed so it's alright. --Moxie

Btw, I might consider making a sequel based on Psych or something if I ever feel like it.

I have an engine based off myself now, watch me fail.

This is a WIP rewrite of Ninjamuffin99s Friday night Funkin.

![Repo Size](https://img.shields.io/github/repo-size/Hoovy-Team/FNF-MemeHoovy-Engine-New)

<b>`THIS ENGINE IS STILL A WORK IN PROGRESS, REPORT BUGS IN ISSUES.`</b>

### Special Credits:
- [Moxie](https://github.com/moxie-coder) - Main Programmer.

- [504brandon](https://github.com/504brandon) - Former Assistant Programmer. (And shit I took from Dike/Lite engine lol.)

- [Wither362](https://github.com/Wither362) - Contributor, Assistant Programmer.

- [GamerPablito](https://github.com/GamerPablito) - Contributor, Gamejolt Support, Assistant Programmer.

- [Starmapo](https://github.com/Starmapo) - Inspiration & Hscript things. (And also being a cool person)

- [Angel Bot](https://github.com/AngelDTF) - Inspiration & Week 7 Shit. (Reverse engineered it)

- [LeviXD](https://github.com/LEVIXDDLMAO) - HTML5 Handler.

- [M&M](https://github.com/ActualMandM) - Week 7 Code.

- [MtH](https://github.com/PrincessMtH) - Week 7 Code.

- [Stilic](https://github.com/Stilic) - Polymod Fix, Extra Inspiration & Flaty Engine code, and in general, an cool person (Ily stilic, platonically).

- [NeeEoo](https://github.com/NeeEoo) - Cool person. ;)

Original repo: https://github.com/MemeHoovy/FNF-MemeHoovy-Engine-Public-Legacy

Also check out these engines (codename is far more better then this piece of junk):
- [Chocolate Engine (Deprecated)](https://github.com/Joalor64GH/Chocolate-Engine)
- [Denpa Engine](https://github.com/UmbratheUmbreon/PublicDenpaEngine)
- [Joalor64Engine-Rewritten](https://github.com/Joalor64GH/Joalor64-Engine-Rewrite)
- [Screwed engine](https://github.com/miksel1/FNF-ScrewedEngine)
- [Codename engine](https://github.com/FNF-CNE-Devs/CodenameEngine)
- [Psych Engine](https://github.com/ShadowMario/FNF-PsychEngine)
- [Forever Engine](https://github.com/some-fnf-archives/Forever-Engine-Legacy)
- [Dave Engine](https://github.com/Erizur/FNF-DaveEngine)
- [Troll Engine](https://github.com/riconuts/troll-engine)

### If you know any other good engines, make a PR please :)

# Original FNF description:
This is the repository for Friday Night Funkin, a game originally made for Ludum Dare 47 "Stuck In a Loop".

Play the Ludum Dare prototype here: https://ninja-muffin24.itch.io/friday-night-funkin
Play the Newgrounds one here: https://www.newgrounds.com/portal/view/770371
Support the project on the itch.io page: https://ninja-muffin24.itch.io/funkin

IF YOU MAKE A MOD AND DISTRIBUTE A MODIFIED / RECOMPILED VERSION, YOU MUST OPEN SOURCE YOUR MOD AS WELL

## Credits / shoutouts

- [ninjamuffin99](https://twitter.com/ninja_muffin99) - Programmer
- [PhantomArcade3K](https://twitter.com/phantomarcade3k) and [Evilsk8r](https://twitter.com/evilsk8r) - Art
- [Kawaisprite](https://twitter.com/kawaisprite) - Musician

This game was made with love to Newgrounds and its community. Extra love to Tom Fulp.

## Build instructions

THESE INSTRUCTIONS ARE FOR COMPILING THE GAME'S SOURCE CODE!!!

IF YOU WANT TO JUST DOWNLOAD AND INSTALL AND PLAY THE GAME NORMALLY, GO TO ITCH.IO TO DOWNLOAD THE GAME FOR PC, MAC, AND LINUX!!

https://ninja-muffin24.itch.io/funkin

IF YOU WANT TO COMPILE THE GAME YOURSELF, CONTINUE READING!!!

### Installing the Required Programs

First, you need to install Haxe and HaxeFlixel. I'm too lazy to write and keep updated with that setup (which is pretty simple). 
1. [Install Haxe 4.2.5](https://haxe.org/download/version/4.2.5/)
2. [Install HaxeFlixel (4.11.0)](https://haxeflixel.com/documentation/install-haxeflixel/) after downloading Haxe

Other installations you'd need are the additional libraries, a fully updated list will be in `Project.xml` in the project root. Currently, these are all of the things you need to install:
```
flixel 4.11.0
flixel-addons 2.11.0
flixel-ui
hscript
```
So for each of those type `haxelib install [library]` so shit like `haxelib install hscript`

You'll also need to install a couple things that involve Gits. To do this, you need to do a few things first.
1. Download [git-scm](https://git-scm.com/downloads). Works for Windows, Mac, and Linux, just select your build.
2. Follow instructions to install the application properly.
3. Run `haxelib git polymod https://github.com/larsiusprime/polymod.git` to install Polymod.
4. Run `haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc` to install Discord RPC.

You should have everything ready for compiling the game! Follow the guide below to continue!

At the moment, you can optionally fix the transition bug in songs with zoomed-out cameras.
- Run `haxelib git flixel-addons https://github.com/HaxeFlixel/flixel-addons` in the terminal/command-prompt.

### Compiling game
NOTE: If you see any messages relating to deprecated packages, ignore them. They're just warnings that don't affect compiling

Once you have all those installed, it's pretty easy to compile the game. You just need to run `lime test html5 -debug` in the root of the project to build and run the HTML5 version. (command prompt navigation guide can be found here: [https://ninjamuffin99.newgrounds.com/news/post/1090480](https://ninjamuffin99.newgrounds.com/news/post/1090480))
To run it from your desktop (Windows, Mac, Linux) it can be a bit more involved. For Linux, you only need to open a terminal in the project directory and run `lime test linux -debug` and then run the executable file in export/release/linux/bin. For Windows, you need to install Visual Studio Community 2019. While installing VSC, don't click on any of the options to install workloads. Instead, go to the individual components tab and choose the following:
* MSVC v142 - VS 2019 C++ x64/x86 build tools
* Windows SDK (10.0.17763.0)

Once that is done you can open up a command line in the project's directory and run `lime test windows -debug`. Once that command finishes (it takes forever even on a higher end PC), you can run FNF from the .exe file under export\release\windows\bin
As for Mac, 'lime test mac -debug' should work, if not the internet surely has a guide on how to compile Haxe stuff for Mac.

### Additional guides

- [Command line basics](https://ninjamuffin99.newgrounds.com/news/post/1090480)

