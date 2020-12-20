pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
#include src/util/class.lua
#include src/util/layer.lua
#include src/util/collision.lua
#include src/util/draw.lua
#include src/util/script.lua
#include src/util/text.lua
#include src/util/update.lua
#include src/util/vec.lua

#include src/constants.lua

#include src/bullet.lua
#include src/enemy.lua
#include src/explosion.lua
#include src/player.lua
#include src/powerup.lua
#include src/starfield.lua

#include src/main.lua

__gfx__
0000000000000000000110000020020000bbbb000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000005500002222220033bb3300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000066660002822820003003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000066660022822822033333300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000008077770822222222bbb00bbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000007676676720222202033333300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000007676676720200202bb3003bb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000070777707002002000b0000b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
800a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70a0a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
700a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70a0a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100003402029010240101b010140100e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0116000011550000000c53013530000000c530000001853000000155301353015530135301153000000105300f53000000135300000016530000000f5300d53000000115301453018530000001b5301653013530
0116000005130000000c1300013000000000000c1300013005130000000c130001300913005130041300013003130000000a1300313300000000000a130000000113000000051300000003130071300a13003130
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

