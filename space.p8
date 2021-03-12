pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- untitled space game
-- by isogash and pikmyn

-->8
-- util
#include src/util/class.lua
#include src/util/collision.lua
#include src/util/script.lua
#include src/util/vec.lua

-->8
-- common
#include src/layers.lua
#include src/constants.lua
#include src/achieve.lua
#include src/entity.lua
#include src/text.lua
#include src/starfield.lua

-->8
-- fx
#include src/fx/explosion.lua
#include src/fx/shielding.lua

-->8
-- entities
#include src/bullet.lua
#include src/enemy.lua
#include src/player.lua
#include src/powerup.lua

-->8
-- enemies
#include src/enemies/big.lua
#include src/enemies/green.lua
#include src/enemies/hunter.lua
#include src/enemies/normal.lua
#include src/enemies/shielder.lua

-->8
-- game
#include src/level.lua
#include src/game.lua

-->8
-- main
#include src/main.lua

-->8
-- debug
#include src/debug.lua
#include src/test.lua
__gfx__
0000000000000000000110000020020000bbbb0000099000001cc100000000000000000000000000000000000000000000000000000000000000058558500000
00000000000000000005500002222220033bb3304499994401cccc10000000000000000000000000000000000000000000000000000000000005555555555000
00700700000000000066660002822820003003004a9999a41c7cc7c1000000000000000000000000000000000000000000000000000000000085566666655800
00077000000000000066660022822822033333300aa99aa0ff7777ff000000000000000000000000000000000000000000000000000000000555666886665550
00077000000000008077770822222222bbb00bbb04a99a40fc7777cf000000000000000000000000000000000000000000000000000000000556562222656550
0070070000000000767667672022220203333330009999001cc77cc1000000000000000000000000000000000000000000000000000000008566666666666658
00000000000000007676676720200202bb3003bb0049940001cccc10000000000000000000000000000000000000000000000000000000005565655555565655
000000000000000070777707002002000b0000b000044000001cc100000000000000000000000000000000000000000000000000000000005566655665566655
800a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005562665665662655
70a0a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005562865555682655
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001562865115682651
700a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000552865005682550
70a0a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000152865005682510
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000015865005685100
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001155005511000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011001100000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07000000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70000000000700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70000000000700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70000000000700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70000000000700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70000000000700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70000000000700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07000000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00001100000001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000007770700077700777077707770
00005500000005500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000070700070000007070007070
00066660000066660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000070777077700777077707070
00066660000066660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000070707000700700000707070
08077770808077770800000000000000000000000000000000000000000000000000000000000000000000000000000000000000070777077700777077707770
07676676707676676700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07676676707676676700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07077770707077770700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000770077707770
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000070070707070
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000070070707070
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000070070707070
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000777077707770
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000001000000000005000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000
00000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007aaa7000aaa000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000005000000000a0a0a0a0a0a0a00000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000007aaaaaaaaaaaaaa0000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000001000000000000000000070a0a0a0a0a0a0a0a000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000077aaaaaaaaaaaaaaaa000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000500000000770a0a0a0a0a0a0a0a000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000777aaaaaaaaaaaaaa0000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000777a0a0a0a0a0a0a00000000000000000005000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000077777aaa7777aaa000000000000000000100000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000777777777777000000000000000000000000000000
00000000000000000000000000010000000000000000000000000000000000001000000000000000000000007777777770000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000500000000000000000000000777777700000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000005000077777000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000500000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000600000000000000000005000000000000000000000
00000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000005000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000100000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000500000000000000000000000000000000000000000000000000000000000
00000000000000000000050000000000000000006000000000000000000000000000000000100000000000000600000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000500000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000011000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000011000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000033000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000033000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000bb000000000000000000000000000000000000000
000000000000000000000000500000000000000000000000000000000000000000006000000000000000000bb000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000
00000000000000000000000000000000500000000000000000000000000000000000000000000000005000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000006000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050000000000000010000
00000000000000000050000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000500000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000500000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000010000000000000000000000000000000000000000000000050000100000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000050000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000100000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005000000000
00000000000010000000000010000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000001000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000600000000000
00000000000000000000000000000000000000000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10000000000006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000600000000000000000000500000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000
00000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000500000000000
00000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000006000000000000000000000000000000000000000000000000000000000000000500000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00010001000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005010
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000100000000000000
00000000000000000000000000000000000000000000100000000000000000000000600000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000600000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000500000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000055000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000666600000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000666600000000000000000000000000000
00000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000080777708000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000076766767000000000000000000000000000
00000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000076766767000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000070777707060000000000000000000000000

__sfx__
010100003402029010240101b010140100e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001000000073103702b374083700e6530c6430b64009640086440763006635056300462304620036230261002614016100161500610006130061300610006100061400610006150061000614006150000000000
000200000552108521005012100121001220010000121001210011d0011d0011d0011d0010000100001000010100119001190011f0011f00120001000011f0011f0011b0011b0011900119001160011600115001
00010000094100c4100f41012410144100c400114000c400164000a400134000a400164000a400134000a40018400084001440008400184000840014400084001b4000a400134000a4001b4000a400134000a400
00010000367303f731367303f732367323f732367321d004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000c00000e33411334173341833400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400004
000600000c235102351323510225132251822513215182151c21531205342053a2050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005
00080000016511465108651166510d6511465108651196511265119651186511e65112651096510965112651126411c641106411d6410d631086310e631076210262103621016110060100001000010000100001
000400001d04124041290412e041320411d04124041290412e001320011d00124001290012e001320010000100001000010000100001000010000100001000010000100001000010000100001000010000100001
000300001e010240102a01031020380203a0103701037000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000a00002833032330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001000028220222201a2201622000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01010004007100b710007100b71003700067000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700
01050000000400c0401004013040180401c0401f04024040240402403024020240100010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000000
010600080741407455000000000006414064550000000000134000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011e000011550000000c53013530000000c530000001853000000155301353015530135301153000000105300f53000000135300000016530000000f5300d53000000115301453018530000001b5301653013530
011e000005130000000c1300013000000000000c1300013005130000000c130001300913005130041300013003130000000a1300313300000000000a130000000113000000051300000003130071300a13003130
0107000039735357353573533735337353073530735397353a73535735357353173538735307353a73537735397353c7353c73539735397353573535735307353a7353f7353c7353a735387353c7353a73537735
__music__
03 20216244
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
00 41444344

