pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
#include object.lua

#include constants.lua
#include layer.lua
#include collision.lua

#include bullet.lua
#include enemy.lua
#include explosion.lua
#include player.lua
#include starfield.lua

#include main.lua
__gfx__
00000000000000000001100000200200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000005500002222220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000066660002822820000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000066660022822822000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000008077770822222222000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000007676676720222202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000007676676720200202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000007077770700200200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100003405029050240501b030140200e0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001000000073103702b3740837019375106500e6530c6430b6400964008644076300663505630046230462003623026100261401610016150061000613006130061000610006140061000615006100061400615
000100000c00018001180002100121000220000000021000210001d0001d0021d0021d0050000000000000000100019001190001f0011f00020000000001f0001f0001b0001b0001900019000160001600015000
00100000154100c410114100c410154100c410114100c410164100a410134100a410164100a410134100a41018410084101441008410184100841014410084101b4100a410134100a4101b4100a410134100a410
00100000150501d0511d0501d0521d0421d0321d0221d014000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
01 01020344
02 01040344

