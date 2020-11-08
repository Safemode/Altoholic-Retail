local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

-- category ids
local CAT_GENERAL		= 92
local CAT_QUESTS		= 96
local CAT_QUESTS_WOW		= 14861
local CAT_QUESTS_KALIMDOR	= 15081
local CAT_QUESTS_BC		= 14862
local CAT_QUESTS_WOTLK		= 14863
local CAT_QUESTS_CATACLYSM	= 15070
local CAT_QUESTS_PANDA		= 15110
local CAT_QUESTS_DRAENOR	= 15220
local CAT_QUESTS_LEGION		= 15252
local CAT_QUESTS_BFA			= 15284
local CAT_EXPLORATION_OUTLAND	= 14779
local CAT_EXPLORATION_NORTHREND	= 14780
local CAT_EXPLORATION_CATA	= 15069
local CAT_EXPLORATION_PANDA	= 15113
local CAT_EXPLORATION_DRAENOR	= 15235
local CAT_EXPLORATION_LEGION	= 15257
local CAT_PVP			= 95
local CAT_PVP_ARENA		= 165
local CAT_PVP_ALTERAC		= 14801
local CAT_PVP_ARATHI		= 14802
local CAT_PVP_EOTS		= 14803
local CAT_PVP_WARSONG		= 14804
local CAT_PVP_CONQUEST		= 15003
local CAT_PVP_GILNEAS		= 15073
local CAT_PVP_TWINPEAKS		= 15074
local CAT_PVP_RATEDBG		= 15092
local CAT_PVP_SILVERSHARD	= 15162
local CAT_PVP_KOTMOGU		= 15163
local CAT_PVP_GORGE		= 15218
local CAT_PVP_HONOR     = 15266
local CAT_DUNGEONS		= 168
local CAT_DUNGEONS_CLASSIC	= 14808
local CAT_DUNGEONS_BC		= 14805
local CAT_DUNGEONS_WOTLK	= 14806
local CAT_DUNGEONS_RAID_WOTLK	= 14922
local CAT_DUNGEONS_CATA		= 15067
local CAT_DUNGEONS_RAID_CATA	= 15068
local CAT_DUNGEONS_PANDA	= 15106
local CAT_DUNGEONS_RAID_PANDA	= 15107
local CAT_DUNGEONS_DRAENOR	= 15228
local CAT_DUNGEONS_RAID_DRAENOR	= 15231
local CAT_DUNGEONS_LEGION	= 15254
local CAT_DUNGEONS_RAID_LEGION	= 15255
local CAT_DUNGEONS_CHALLENGES	= 15115
local CAT_PROFESSIONS		= 169
local CAT_PROFESSIONS_COOKING	= 170
local CAT_PROFESSIONS_FISHING	= 171
local CAT_PROFESSIONS_ARCHA	= 15071
local CAT_REPUTATIONS		= 201
local CAT_REPUTATIONS_BC	= 14865
local CAT_REPUTATIONS_WOTLK	= 14866
local CAT_REPUTATIONS_CATA	= 15072
local CAT_REPUTATIONS_MOP	= 15114
local CAT_REPUTATIONS_WOD	= 15232
local CAT_REPUTATIONS_LEGION	= 15258
local CAT_EVENTS		= 155
local CAT_EVENTS_LUNARFESTIVAL	= 160
local CAT_EVENTS_LOVEISINTHEAIR	= 187
local CAT_EVENTS_NOBLEGARDEN	= 159
local CAT_EVENTS_MIDSUMMER	= 161
local CAT_EVENTS_BREWFEST	= 162
local CAT_EVENTS_HALLOWSEND	= 158
local CAT_EVENTS_PILGRIMSBOUNTY	= 14981
local CAT_EVENTS_WINTERVEIL	= 156
local CAT_EVENTS_ARGENTTOURNAMENT = 14941
local CAT_EVENTS_DARKMOON	= 15101
local CAT_EVENTS_BRAWLER	= 15282
local CAT_PET_BATTLES		= 15117
local CAT_PET_BATTLES_COLLECT	= 15118
local CAT_PET_BATTLES_BATTLE	= 15119
local CAT_PET_BATTLES_LEVEL	= 15120
local CAT_COLLECTIONS		= 15246
local CAT_COLLECTIONS_TOYBOX	= 15247
local CAT_COLLECTIONS_MOUNTS	= 15248
local CAT_EXP_FEAT  = 15301
local CAT_EXP_FEAT_WINTERGRASP	= 14901
local CAT_EXP_FEAT_TOLBARAD		= 15075
local CAT_EXP_FEAT_PANDA  = 15302
local CAT_EXP_FEAT_PROVING  = 15222
local CAT_EXP_FEAT_GARRISON  = 15303
local CAT_EXP_FEAT_CLASSHALL  = 15304
local CAT_EXP_FEAT_ISLAND    = 15307
local CAT_EXP_FEAT_WAR    = 15308
local CAT_EXP_FEAT_VISIONS = 15426
local CAT_LEGACY		= 15234
local CAT_LEGACY_DUNGEON		= 15277
local CAT_LEGACY_RAIDS		= 15278
local CAT_LEGACY_PROFESSIONS	= 172
local CAT_LEGACY_PVP		= 15279
local CAT_LEGACY_CURRENCY		= 15280
local CAT_LEGACY_EXP_FEAT		= 15411
local CAT_FEATS			= 81
local CAT_FEATS_EVENTS	= 15274

-- list of achievements, per category. The list is obviously comma-separated, and faction specific achievements are under the form "alliance:horde"
-- note: if the achievement name is different (eg: "for the alliance!" & "for the horde") do NOT treat them as combined achievements: they should appear on different lines in the UI.
-- [new: unless they're account-wide]
local sortedAchievements = {
	-- To improve readability, these categories will be pre-sorted, even partially, in order to list achievements
	-- in a meaningful order (regardless of localization), as a pure alphabetical order is not always relevant, ex: 10, 100, 1000, 25, 250..etc 
	-- these arrays will thus be used as the first lines in the view, and the complement will be sorted alphabetically.
	
	-- levels, got my mind on my money, riding skill, mounts, pets, tabards, superior items
	[CAT_GENERAL] = "6,7,8,9,14782,14783,7382,7383,7384,7380,1176,1177,1178,1180,1181,5455,5456,6753,891,889,890,5180,14796,14797",
	[CAT_QUESTS] = "503,504,505,506,507,508,32,978,973,974,975,976,977,5751,7410,7411,4956,4957,1576,4958,1182,5752",		-- quests completed,  daily quests completed, dungeon, fight club
	[CAT_QUESTS_WOW] = "1676,4896,4900,4909,4901,4905,4892,4908,4895,4897,4899,4906,4902,4910,4894,4904,4893,4903",
	[CAT_QUESTS_KALIMDOR] = "1678,4925:4976,4927,4926,4928,4930,4929:4978,4931,4932:4979,4933,4934,4937:4981,4936:4980,4935,4938,4939,4940",
	[CAT_QUESTS_BC] = "1262,1189:1271,1190,1191:1272,1192:1273,1193,1194,1195",
	[CAT_QUESTS_WOTLK] = "41,33:1358,34:1356,35:1359,37:1357,36,39,38,40",
	[CAT_QUESTS_CATACLYSM] = "4875,4870,4869:4982,4871,4872,4873:5501",
	[CAT_QUESTS_PANDA] = "6541,6300:6534,6301,6535:6536,6537:6538,6539,6540,7929,7928,8121,8099",
	[CAT_QUESTS_DRAENOR] = "8921:8922,9833:9923,8671,8845,8923:8924,8920:8919,8925:8926,8927:8928,9491:9492,10067:10074,9825:9836,9606,9602,9607,9674,9605,9615,9564:9562,10068:10075",
	[CAT_QUESTS_LEGION] = "10763,10698,10059,10790,10617,11124,11340,11544,11846,11546,11157,11189,11731,11732,11735,11736,11737,11738,12073,12066",
	[CAT_QUESTS_BFA] = "12582,12473,12497,12496,12593,12997,12891," ..	-- alliance
							"12555,12478,11868,11861,12479,12510:12509,12480,12481,"..				-- horde
							"13144,13512",
	[CAT_EXPLORATION_OUTLAND] = "862,863,867,866,865,843,864,1311,1312",
	[CAT_EXPLORATION_NORTHREND] = "1254,1263,1264,1265,1266,1267,1457,1268,1269,1270,1956,2256,2257,2557",
	[CAT_EXPLORATION_CATA] = "4863,4825,4864,4865,4866,4975,5518,5548,5754,4827,5753",
	[CAT_EXPLORATION_PANDA] = "6350,6351,6969,6975,6976,6977,6978,6979,7437,7438,7439,7994,7995,7996,7997,7281,7282,7283,7284,8723,8784",
	[CAT_EXPLORATION_DRAENOR] = "10018,8937,8938,8939,8940,8941,8942,10260,9726,9727,10348,9728,10261,10262,9400,10061,10259,10070",
	[CAT_EXPLORATION_LEGION] = "11190,11446,10665,10666,10667,10668,10669,11543,11256,11258,11257,11259,11260,11261,11262,11264,11263,11265,12101,12102,12103,12104,12077,12078,12026,12028,12074,12083,12084",
	[CAT_PVP] = "238,513,515,516,512,509,239,869,870,5363,230:1175,8052:8055,714,907,616,618,619,613,614,14815,14817",
	[CAT_PVP_ARENA] = "397,398,875,876,2090,2093,2092,2091",
	[CAT_PVP_ALTERAC] = "218,219,1167",
	[CAT_PVP_ARATHI] = "154,155,1169",
	[CAT_PVP_EOTS] = "208,209,1171",
	[CAT_PVP_WARSONG] = "166,167,1172",
	[CAT_PVP_CONQUEST] = "3776,3777,3857:3957",
	[CAT_PVP_GILNEAS] = "5245,5246,5258",
	[CAT_PVP_TWINPEAKS] = "5208,5209,5223",
	[CAT_PVP_RATEDBG] = "5269,5323,5324,5325,5824,5326,5345,5346,5347,5348,5349,5350,5351,5352,5338,5353,5354,5355,5342,5356,6941,5268,5322,5327,5328,5823,5329,5330,5331,5332,5333,5334,5335,5336,5337,5359,5339,5340,5341,5357,5343,6942",
	[CAT_PVP_SILVERSHARD] = "6739,6883,7106",
	[CAT_PVP_KOTMOGU] = "6740,6882,6981",
	[CAT_PVP_GORGE] = "8331,8332",
	[CAT_PVP_HONOR] = "12893,12894,12895,12900,12901,12902,12903,12904,12905,12906,12907,12908,12909,12910,12911,12912,12913,12914,12915,12916,13702,13701,13703",
	[CAT_DUNGEONS] = "1283,1285,1284,1287,1286,1288,1289,2136,2137,2138,1658,4602,4603,4844,4845,4853,5506,5828,6169,6925,6927,6932,8124,6926,8454,9391,9396,8985,9619,10149,4476,4477,4478,14146,13687,13315,12812,12806,12807,11987,11163,11162,11763,11180,11164,12401,14418,14322,14355,11183,11184,11185,",
	[CAT_DUNGEONS_CLASSIC] = "629,628,630,631,632,633,635,634,636,637,7413,638,639,640,641,642,643,644,645,646,689,686,685,687",
	[CAT_DUNGEONS_BC] = "647,667,648,668,649,669,650,670,651,671,666,672,652,673,653,674,654,675,655,676,656,677,657,678,658,679,659,680,660,681,661,682,690,692,693,694,696,695,697,698",
	[CAT_DUNGEONS_WOTLK] = "477,489,478,490,480,491,481,492,482,493,483,494,484,495,485,496,486,497,487,498,488,499,479,500,4296:3778,4298:4297,4516,4519,4517,4520,4518,4521",
	[CAT_DUNGEONS_RAID_WOTLK] = "562,563,564,565,566,567,568,569,572,573,574,575,576,577,1876,625,622,623,3917,3916,3918,3812,4396,4397,4531,4604,4528,4605,4529,4606,4527,4607,4530,4597,4532,4608,4628,4632,4629,4633,4630,4634,4631,4635,4583,4584,4636,4637,4817,4815,4818,4816",
	[CAT_DUNGEONS_CATA] = "4833,5060,4839,5061,4846,5063,4847,5064,4840,5062,4841,5065,4848,5066,5083,5093,5769,5768,6117,6118,6119",
	[CAT_DUNGEONS_RAID_CATA] = "4842,5094,5107,5108,5109,5115,5116,4850,5118,5117,5119,5120,5121,4851,5122,5123,5802,5807,5808,5809,5806,5805,5804,5803,6106,6107,6177,6109,6110,6111,6112,6113,6114,6115,6116",
	[CAT_DUNGEONS_PANDA] = "6757,6758,6457,6456,6469,6470,6755,6756,10010,6759,6760,6761,6762,10011,6763",
	[CAT_DUNGEONS_RAID_PANDA] = "6480,6517,8028,8123,8535,6458,6844,6718,6845,6689,8069,8070,8071,8072,8458,8459,8461,8462,8679,8680,6719,6720,6721,6722,6723,6724,6725,6726,6727,6728,6729,6730,6731,6732,6733,6734,8056,8057,8058,8059,8060,8061,8062,8063,8064,8065,8066,8067,8068,8463,8465,8466,8467,8468,8469,8470,8471,8472,8478,8479,8480,8481,8482",
	[CAT_DUNGEONS_DRAENOR] = "9037,9046,10076,9038,9047,10079,9039,9049,10080,8843,8844,10081,9043,9052,10082,9041,9054,10084,9044,9053,10083,9042,9055,10085",
	[CAT_DUNGEONS_RAID_DRAENOR] = "9423,9425,10071,8986,8987,8988,8989,8990,8991,8992,10023,10024,10025,10020,10019,8949,8960,8961,8962,8963,8964,8965,8966,8967,8968,8956,8932,8969,8970,8971,8972,8973,10027,10032,10033,10034,10035,10253,10037,10040,10041,10038,10039,10042,10043",
	[CAT_DUNGEONS_LEGION] = "10780,10781,10782,10456,10458,10457,".. -- Eye of Azshara
                          "10783,10784,10785,10769,10766,".. -- Darkheart Thicket
                          "10786,10788,10789,10542,10544,10543,".. -- Halls of Valor
                          "10795,10796,10797,10875,10996,".. -- Neltharion's Lair
                          "10798,10799,10800,10554,10553,".. -- Assault on Violet Hold
                          "10801,10802,10803,10707,10679,10680,".. -- Vault of the Wardens
                          "10804,10805,10806,10710,10711,10709,".. -- Blackrook Hold
                          "10807,10808,10809,10411,10413,10412,".. -- Maw of Souls
                          "10813,10773,10775,10776,".. -- Arcway
                          "10816,10611,10610,".. -- Court of Stars
                          "11929,11429,11433,11338,11430,11432,11335,11431,".. -- Return to Karazhan
                          "11700,11701,11702,11769,11768,11703,".. -- Cathedral of Eternal Night
                          "12007,12008,12009,12005,12004,".. -- Seat of the Triumvirate
                          "11181", -- Keystones
	[CAT_DUNGEONS_RAID_LEGION] = "10818,10819,10820,10821,10822,10823,10824,10825,10826,10827,10555,10771,10753,10830,10663,10772,10755,".. -- Emerald Nightmare
  "11394,11426,11337,11386,11377,11396,11397,11398,".. -- Trial of Valor,
  "10829,10837,10838,10839,10840,10842,10843,10844,10845,10846,10847,10848,10849,10850,10678,10697,10742,10817,10851,10754,10704,10575,10699,10696,".. -- The Nighthold,
  "11787,11788,11789,11790,11767,11774,11775,11776,11777,11778,11779,11780,11781,11724,11696,11683,11676,11675,11674,11773,11770,11699,".. -- Tomb of Sargeras,
  "11988,11989,11990,11991,11992,11993,11994,11995,11996,11997,11998,11999,12000,12001,12002,11949,11948,11930,11928,11915,12065,12129,12067,12030,12046,12257", -- Antorus, the Burning Throne
	[CAT_PROFESSIONS] = "116,731,732,733,734,4924,6830,9464,735,4914,6835,9507,7378,7379,9087,9071,9454,9453,12737,13516,12735,12740,12733,13056,10583,10581,10586,10587,10582,10585,10761,10588,12736,12741,12734,12731,14328,14329,14330",		-- professional journeyman, etc..
	[CAT_PROFESSIONS_COOKING] = "121,122,123,124,125,4916,5779,6365,7300,7301,7302,7303,7304,7305,7306,9500,1999,2000,2001,2002,1795,1796,1797,1798,1799,5471,7328,1800,1777,1778,1779,5472,5473,7326,7327,9501",			-- level, dalaran awards, num recipes, gourmet
	[CAT_PROFESSIONS_FISHING] = "126,127,128,129,130,4917,6839,9503,10594,1556,1557,1558,1559,1560,1561,2094,2095,1957,2096,9456,9457,9458,9459,9455,9460,9461,9462,9547",						-- level, num fishes, dalaran coins
	[CAT_PROFESSIONS_ARCHA] = "4857,4919,4920,4921,4922,4923,6837,9409,5315,5469,5470,4854,4855,4856,9422,8222,8223,7345,7365,8220,8221,7343,7363,7349,7369,7353,7373,7342,7362,7344,7364,8226,8227,7354,7374,8234,8235,7348,7368,8230,8231,7356,7376,7339,7359,7338,7358,7346,7366,7351,7371,8232,8233,8224,8225,8228,8229,7347,7367,7350,7370,7352,7372,7340,7360,7341,7361,7355,7375,7357,7377,",
	[CAT_REPUTATIONS] = "522,523,524,521,520,519,518,1014,1015,5374,5723,6826,6742,11177",		-- exalted reputations
	[CAT_REPUTATIONS_WOD] = "9469,9470,9471,9472,9476,9475,9478:9477,9072,10350:10349",
	[CAT_EVENTS] = "9426,9427,9428",
	[CAT_EVENTS_MIDSUMMER] = "1028:1031,1029:1032,1030:1033,6007:6010,6013:6014,8042:8043,11276:11277,11278:11279,1037:1035,1022:1025,1023:1026,1024:1027,6008:6009,6011:6012,8045:8044,11283:11284,11280:11282,1034:1036",
	[CAT_EVENTS_LOVEISINTHEAIR] = "9389,9392,9393,9394",
	[CAT_EVENTS_LUNARFESTIVAL] = "605,606,607,608,609",				-- coins of ancestry
	[CAT_EVENTS_ARGENTTOURNAMENT] = "2756,2758,2777,2760,2779,2762,2780,2763,2781,2764,2778,2761,2782:2788,2770:2771,2817:2816,2783,2765,2784,2766,2785,2767,2786,2768,2787,2769",
	[CAT_EVENTS_DARKMOON] = "9250,9251,9252,9983",
	[CAT_EVENTS_BRAWLER] = "13194,13191:13192,11567,11573,11570",
	[CAT_PET_BATTLES] = "7482,7483,6600,7521,6601,7498,7499,6603,6602,6604,6605,7525,6606,6607,9724,7908,7936,8080,8348,9712,14021,14020,13695,13627,13269,12927,11856,11765",
	[CAT_PET_BATTLES_COLLECT] = "1017,15,1248,1250,2516,5876,5877,5875,7500,7501,9643,6554,6555,6556,6557,7436,6585,6586,6587,6588,6589,6590,9685,6612,6613,6614,6615,6616,6611,7465,7462,7463,7464,6608,6571,7934,8293,9824,8519,8397,13715,13693,13694,12958,13469,12930,12079,11233,11320",
	[CAT_PET_BATTLES_BATTLE] = "6594,6593,6462,6591,6592,9463,6595,6596,6597,6598,6599,8297,8298,8300,8301,6618,6619,6558,6559,6560,6584,6621,6622,10052",
	[CAT_PET_BATTLES_LEVEL] = "7433,6566,6567,6568,6569,6570,6579,6580,6583,6578,6581,6582,6609,6610,9070",
	[CAT_COLLECTIONS] = "9911,9906,9908,9909,621,1020,1021,5755",
	[CAT_COLLECTIONS_TOYBOX] = "9670,9671,9672,9673,13708,12996",
	[CAT_COLLECTIONS_MOUNTS] = "2141,2142,2143,2536:2537,7860:7862,8302:8304,9598:9599,12933:12934",
	[CAT_EXP_FEAT_WINTERGRASP] = "1717,1718,1752,1722,1721,3136,3137,3836,3837,4585,4586",
	[CAT_EXP_FEAT_TOLBARAD] = "5412,5417:5418,5489:5490,5416,6045,6108",
	[CAT_EXP_FEAT_PANDA] = "6943,7252,8310,7988,7271,8016,8314:8315,8364:8366,8316,8312,6923,7522,8311,8009,8317,8318,8013,7265,8010,8294,8327,7523:7524,7249",
	[CAT_EXP_FEAT_PROVING] = "9572,9573,9574,9575,9576,9577,9578,9579,9580,9581,9582,9583,9584,9585,9586,9587,9588,9589,9590",
	[CAT_EXP_FEAT_GARRISON] = "9100:9545,9101:9546,9210:9132,9828:9897,9912:9914,10015:10016,9928:9901,8933,9099,9098,9095,9096,9097,9125,9126,9128,9094,9405,9406,9407,9429,9076,9077,9078:9080,9450,9565,9451,9452,9495,9497,9498,9499,9538,9526,9539:9705,9540:9706,9468,9703,9527,9517,9520,9518,9519,9516,9521,9522,9509,9510,9511,9512,9513,9514,9515,9639,9738:9508,9107,9108,9109,9494,9130,9131,9110,9111,9129,9211,9212,9213,9243,9152,9167,9543,9244,9162,9164,9165,9826,9181,9208,9207,9205,9204,9203,9206,9209,9827,9858,9133,9134,9138,9139,9140,9141,9142,9143,9150,9900,9146,9523,9145,9524,9147,10177,10169,10168,10166,10165,10170,10172:10255,10173:10275,10174:10276,10256:10258,10167:10307,10164,10156,10154,10162,10163,10159,10160,10017,10036,10161,10155",
	[CAT_EXP_FEAT_CLASSHALL] = "11298,11223,10994,11135,11136,10746,10459,10460,10461,10747,10748,10749:11173,10743:10745,10706,11212,11213,11214,11215,11216,11217,11219,11220,11221,11222,10750,11171",
  [CAT_EXP_FEAT_ISLAND] = "12590,12589,12591,12592,".. -- Un'gol Ruins
                          "13095,13096,13097,13098,".. -- Dread Chain
                          "13103,13104,13105,13106,".. -- Rotting Mire
                          "13099,13100,13101,13102,".. -- Molten Cay
                          "13111,13112,13113,13114,".. -- Verdant Mire
                          "13107,13108,13109,13110,".. -- Skittering Hollow
                          "13119,13118,13116,13115,".. -- Whispering Reef
                          "13577,13578,13579,13580,".. -- Crestfall
                          "13396,13397,13398,13400,".. -- Havenswood
                          "13389,13394,13395,13399,".. -- Jorundall
                          "13581,13582,13583,13584,".. -- Snowblossom Village
                          "13142,13122,13141,".. -- Miscellaneous
                          "12596,12594,12595,".. -- Win Normal/Heroic/Mythic
                          "12597,13120,13121,".. -- Win PvP
                          "13129,".. -- Sucker Punch
                          "13123,13124,".. -- Loot Dubloons
                          "13125,13126,13127,13128,13133:13135,13134,".. -- More Miscellaneous
                          "13132",
  [CAT_EXP_FEAT_WAR] = "12896:12867,12898:12869,12899:12870,12872,12881:12873,12888:12877,12889:12876,12884:12878,12886:12879,12874,13739:13738,14150:14149,13737:13735,13309,13305:13306,13308:13307,13297:13296,13310",
  [CAT_EXP_FEAT_VISIONS] = "14170,14171,14172,14173,14063,14065,14067,14064,14066,14143,13994,14162,14165,14166,14167,14168,14169,14060,14061",
	[CAT_LEGACY_DUNGEON] =  "2188,1307,"..           -- Leeeeeeeeeeeeeroy! and Classic UBRS
                          "6894,6905,6906,6907,".. -- Gate of the Setting Sun
                          "6892,6899,6900,6901,".. -- Mogu'shan Palace
                          "6895,6908,6909,6910,".. -- Scarlet Halls
                          "6896,6911,6912,6913,".. -- Scarlet Monastery
                          "6897,6914,6915,6916,".. -- Scholomance
                          "6893,6902,6903,6904,".. -- Shado-Pan Monastery
                          "6898,6917,6918,6919,".. -- Siege of Niuzao Temple
                          "6888,6889,6890,6891,".. -- Stormstout Brewery
                          "6884,6885,6886,6887,".. -- Temple of the Jade Serpent
                          "6920,6374,6375,6378,".. -- Complete Pandaria Challenge Modes
                          "8879,8880,8881,8882,".. -- Auchindoun
                          "8875,8876,8877,8878,".. -- Bloodmaul Slag Mines
                          "8887,8888,8889,8890,".. -- Grimrail Depot
                          "8997,8998,8999,9000,".. -- Iron Docks
                          "8883,8884,8885,8886,".. -- Shadowmoon Burial Grounds
                          "8871,8872,8873,8874,".. -- Skyreach
                          "9001,9002,9003,9004,".. -- The Everbloom
                          "8891,8892,8893,8894,".. -- Upper Blackrock Spire
                          "8895,8897,8898,8899,".. -- Complete Warlords Challenge Modes
                          "11218,",                -- There's a Boss In There
	[CAT_LEGACY_PROFESSIONS] = "131,132,133,134,135,4918,6838,9505",					-- journeyman, expert, artisan, master, grand master
}

local unsortedAchievements = {
	[CAT_GENERAL] = "545,546",
	[CAT_QUESTS] = "31,941,7520,11132,14222",
	[CAT_QUESTS_WOW] = "5442,5444,940,12429,12430",
	[CAT_QUESTS_KALIMDOR] = "5443,5453,5448,5546,5547,5454",
	[CAT_QUESTS_BC] = "1275,939,1276",
	[CAT_QUESTS_WOTLK] = "547,561,938,961,962,1277,1428,1596",
	[CAT_QUESTS_CATACLYSM] = "4874,5318:5319,4959,5483,5451,5482,5450,5445,5317,4961,5447,5449,4960,5446,5452,5481,5320:5321,5859,5860,5861,5862,5864,5865,5866,5867,5868,5869,5870,5871,5872,5873,5874,5879",
	[CAT_QUESTS_PANDA] = "7318,7294,7296,7312,7287,7323,7310,7320,7285,7286,7309,7298,7292,7290,7291,7308,7295,7299,7317,7324,7316,7297,7319,7322,7502,7289,7307,7321,7313,7314,7293,7288,8112,8118,8120,8117,8101,8119,8100,8114,8107,8115,8105,8109,8110,8111,8104,8108,8116,8212",
	[CAT_QUESTS_DRAENOR] = "9437,9433,9678,9635,9533,9571,9548,9667,9537,9634,9633,9534,9612,9655,9613,9486,9638,9610,9483,9656,9659,9436,9601,9617,9654,9600,9528:9529,9434,9663,9658,9711,9710,9637,9536,9435,9535,9632,9541,9636,9432,9530:9531,9479,9481,10072:10265",
	[CAT_QUESTS_LEGION] = "12431,12416,11607,11681,11427,12439,10398,11240,10774,10756,11232,11125,10877,11186,10793,11133,10626",
	[CAT_QUESTS_BFA] = "13021,13042,13009,13050,13020,13035,13017,13047,13053,13059,13045,13030,13041,13023,13060,13062,13048,12614,13038,13039,13022,13054,13011,13049,12087,13037,13046,13014,13025,14154,14157,14153,14161,13924,13790,13542,13700,13791,13573,13709,13435,13517,13294,13437,13263,13284,13466,13441,12719,13285,13467,13384,13251,13553,13710,13283,13440,13426,13925,13026",
	
--	[CAT_EXPLORATION_OUTLAND] = fully sorted
--	[CAT_EXPLORATION_NORTHREND] = fully sorted
--	[CAT_EXPLORATION_CATA] = fully sorted
	[CAT_EXPLORATION_PANDA] = "8078,8743,8727,8729,8722,8714,7932,8103,6856,6716,6846,6857,6850,7230,7381,6754,6855,6847,7518,6858,8051,8050,8049,8726,8725,8712,8724,8730,8717,8718,8719,8720,8721,8716,7330,7329",
	[CAT_EXPLORATION_DRAENOR] = "9402,9401,10069,9502,14728",
	[CAT_EXPLORATION_LEGION] = "10627,11175,11066,11802,11841,12069,11178,14729",
	[CAT_PVP] = "727,909:908,388:1006,227,1157,2016:2017,396,389,246:1005,247,245,229,604,603,231,10561",
	[CAT_PVP_ARENA] = "408,1162,399,400,401,1159,402,403,405,1160,5266,5267,699,14618",
	[CAT_PVP_ALTERAC] = "221,582,225:1164,706,873,708,709,1151:224,707,220,226,223,1166,222,13928:13930",
	[CAT_PVP_ARATHI] = "583,584,165,73,711,159,158,1153,161,156,710,157,162",
	[CAT_PVP_EOTS] = "233,216,784,214,212,211,213,587,1258,783",
	[CAT_PVP_WARSONG] = "199,872,204,203:1251,1259,200,202:1502,207,713,206:1252,201,168,712",
--	[CAT_PVP_SOTA] = "2191,1766,2189,1763,1757:2200,2190,1764,2193,1762:2192,1765,1310,1761",
	[CAT_PVP_CONQUEST] = "3848,3849,3853,3854,3852,3856:4256,3847,3855,3845,3851:4177,3850,3846:4176",
	[CAT_PVP_GILNEAS] = "5256,5257,5247,5248,5252,5262,5253,5255,5254,5251,5249,5250",
	[CAT_PVP_TWINPEAKS] = "5226:5227,5231:5552,5229,5221:5222,5220,5219,5216,5213:5214,5211,5230,5215,5210,5228",
--	[CAT_PVP_RATEDBG] = fully sorted
	[CAT_PVP_SILVERSHARD] = "7057,7102,7099,7103,7049,7062,7100,7039",
	[CAT_PVP_KOTMOGU] = "6970,6973,6947,6971,6950,6980,6972",
	[CAT_PVP_GORGE] = "8333,14186,14188,14187,14175",
--	[CAT_PVP_ASHRAN] = "9104:9103,9222,9228,9214,9215,9216,9106,9408:9217,9256:9257,9473,9225:9224,9714:9715,9105",
	[CAT_DUNGEONS_WOTLK] = "1296,1297,1816,1817,1834,1860,1862,1864,1865,1866,1867,1868,1871,1872,1873,1919,2036,2037,2038,2039,2040,2041,2042,2043,2044,2045,2046,2056,2057,2058,2150,2151,2152,2153,2154,2155,2156,2157,3802,3803,3804,4522,4523,4524,4525,4526",
	[CAT_DUNGEONS_RAID_WOTLK] = "1869,1870,4580,4620,2176,2177,1858,1859,4601,4621,4534,4610,4538,4614,2148,2149,4016,4017,4577,4615,4535,4611,2047,2048,4536,4612,4537,4613,2184,2185,624,1877,1856,1857,4403,4406,1997,2140,4402,4405,4578,4616,4581,4622,3936,3937,4539,4618,4579,4619,3798,3799,3815,4404,4407,2178,2179,2182,2183,2180,2181,578,579,2146,2147,4582,4617,1996,2139,3800,3816,2051,2054,3996,3997,2049,2052,2050,2053,3797,3813,1874,1875,12388,12340,12327,12396,12398,12397,12372,12367,12345,12339,12362,12400,12368,12395,12363,12350,12342,12333,12352,12360,12337,12336,12335,12332,12323,12399,12311,12310,12384,12369,12309,12361,12348,12312,12373,12343,12346,12338,12325,12366,12349,12351,12347,12344,12341,12302,12334,12329,12328,12321,12313,12314,12316,12297,12322,12324,12330,12326,12320,12315",
	[CAT_DUNGEONS_CATA] = "5858,5291,5282,5284,5505,5281,5298,5289,5296,5292,5293,5370,5369,5290,5288,5285,5503,5286,5368,5367,5366,5287,5294,5295,5504,5283,5297,5371,5744,5765,5761,5743,5762,5760,5759,5750,6132,6127,5995,6130,6070",
	[CAT_DUNGEONS_RAID_CATA] = "5310,5307,5829,6180,5821,6105,5813,6174,4852,5311,5305,5309,6175,4849,6133,6084,5810,5799,5306,6128,5855,5830,5308,5304,6129,5312,5300",
	[CAT_DUNGEONS_PANDA] = "6929,6531,6479,6928,6475,6476,6946,6478,6471,6420,6400,6684,6460,6089,6402,6945,6427,6715,6713,6394,6477,6485,6822,6396,6821,6671,6472,6736,6688",
	[CAT_DUNGEONS_RAID_PANDA] = "8090,7933,6674,8073,8087,6936,8038,8529,6824,8520,8086,8448,8037,6687,8527,8528,8082,6518,8543,6683,8094,6553,6823,8536,8532,8531,8077,6937,6717,8453,8081,6455,8097,7056,6686,8521,8530,6825,6922,8538,6933,8098,8537",
	[CAT_DUNGEONS_DRAENOR] = "9023,8993,9056,9005,9551,9057,9081,9035,9025,9008,9058,9045,9034,9083,9036,9552,9007,9033,9026,9082,9493,9024,9017,9223,9018",
	[CAT_DUNGEONS_RAID_DRAENOR] = "8975,8952,8984,8958,8981,8948,8979,8947,8977,8974,8976,8980,8978,8929,8982,8983,8930,9972,10030,10054,10073,9979,10086,10026,9989,9988,10012,10057,10013,10087",
--  [CAT_DUNGEONS_LEGION] = fully sorted
  [CAT_DUNGEONS_RAID_LEGION] = "11786,11160",
--	[CAT_PROFESSIONS] = fully sorted
	[CAT_PROFESSIONS_COOKING] = "877,906,1563:1784,1780,1781,1782:1783,1785,1801,1998,3296,5474,5475,5845:5846,5842,5841,5843,5844,7325,12747,12743,12746,10762,10593,10589,10592,10591,12742,12744,14332",
	[CAT_PROFESSIONS_FISHING] = "144,150,153,306,726,878,905,1225,1243,1257,1516,1517,1836,1837,1958,3217,3218,5476,5477,5478,5479,5848,5847,5849,5850,5851,7611,7274,7614,10595,10596,10597,10598,10722,13489,12754,12755,12756,12757,12759,11725,13502,12990,12753,12758,14333",
	[CAT_PROFESSIONS_ARCHA] = "5193,5511,4859,4858,5301,5192,5191,7331,7332,7333,7334,7335,7336,7337,7612,8219,9412,9419,9411,9414,9415,9413,9410,12765,10609,10604,10603,10606,10605,10600,12761,12764,12769,12760,12762",
	[CAT_REPUTATIONS] = "762,942:943,945,948,953,5794,14013,13206,13503,12415,13163,12515,12866,12518,12243,12242,12244,14014,12414,12291,13076,12413,13077,14002,13504",
	[CAT_REPUTATIONS_BC] = "896,893,902,894,901,899,898,903,1638,958,764:763,900,959,960,897",
	[CAT_REPUTATIONS_WOTLK] = "950,2083,2082,1009,952,1010,947,4598,1008,951,1012:1011,1007,949",
	[CAT_REPUTATIONS_CATA] = "5375,4886,5376,4884,4881,4882,4883,4885,5827",	
	[CAT_REPUTATIONS_MOP] = "6366,6543,6544,6545,6546,6547,6548,6550,6551,6552,6828:6827,7479,8208,8206,8205,8209,8210,8715,8023",	
	[CAT_EVENTS] = "1683,3456,1693,1793,1656,1691,2798,3478,3457,1039,1038,913,2144",
	[CAT_EVENTS_LUNARFESTIVAL] = "626,910,911,912,914,915,937,1281,1396,1552,6006",
	[CAT_EVENTS_LOVEISINTHEAIR] = "1701,260,1695,1699,1279:1280,1704,1291,1694,1703,1697:1698,1700,1188,1702,1696,4624",
	[CAT_EVENTS_NOBLEGARDEN] = "2576,2418,2417,2436,249,2416,2676,2421:2420,2422,2419:2497,248",
	[CAT_EVENTS_MIDSUMMER] = "271,263,1145,272,13342,13340,13341,13343",
	[CAT_EVENTS_BREWFEST] = "2796,1183,295,293,1936,1260,303,1184:1203,1185",
	[CAT_EVENTS_HALLOWSEND] = "284,255,291,1261,288,1040:1041,292,981,979,283,289,972,971,966:967,963:965,969:968,5836:5835,5837:5838,7601:7602",
	[CAT_EVENTS_PILGRIMSBOUNTY] = "3579,3576:3577,3556:3557,3580:3581,3596:3597,3558,3582,3578,3559",
	[CAT_EVENTS_WINTERVEIL] = "277,1690,4436:4437,1686:1685,1295,1282,1689,1687,273,1255:259,279,1688,252,5853:5854,8699",
	[CAT_EVENTS_ARGENTTOURNAMENT] = "3676,2773,2836,3736,3677,4596,2772",
	[CAT_EVENTS_DARKMOON] = "6019,6020,6021,6022,6023,6024,6025,6026,6027,6028,6029,6030:6031,6032,6332,9885,9894,11919,11920,11921,11918,9817,9799,9805,9811,9785,9764,9792,9819,9761,9755",
--	[CAT_PET_BATTLES_COLLECT] = fully sorted
	[CAT_PET_BATTLES_BATTLE] = "6620,8518,9069,8410,12286,12282,13766,12280,13626,13625,13279,13271,13270,13272,13273,12279,13274,13281,13275,13277,13280,12283,13278,12936,12100,12098,12089,12091,12094,12097,12092,12099,12095,12093,12096,12088,9696,9690,9691,9693,9689,9695,9694,9692,9687,9686,9688,10876,6851,12281,12284,12285,12287,12289,12290,14625",
	[CAT_COLLECTIONS] = "8728,1165,2084,10053,10770,9838",
--	[CAT_COLLECTIONS_TOYBOX] = fully sorted
	[CAT_COLLECTIONS_MOUNTS] = "2076,2077,2078,2097,4888,5749,7386,9713,13513",
	[CAT_EXP_FEAT_WINTERGRASP] = "2080,1737:2476,1751,1727,1723,2199,1755",
	[CAT_EXP_FEAT_TOLBARAD] = "5718:5719,5486,5487,5415,5488",
	[CAT_EXP_FEAT_PANDA] = "8319,7273,6931,7989,7990,7257,7276,8368,8017,8329,8330,7992,7272,7275,8347,7526:7529,7239,7248,7987,7527:7530,8011:8014,7258,7267,7385,7266,6874:7509,7231,8295,7232,7261,8012:8015,7984,7993,7991,6930,7986",
	[CAT_EXP_FEAT_GARRISON] = "9630:9248,9264,9246,9265,9631:9255,9487",
	[CAT_LEGACY_PROFESSIONS] = "137,141,5480,11139,10599,10580",
}

local achievementsByCategory = {}

local function SortByName(a, b)
	if type(a) == "string" then
		a = strsplit(":", a)
		a = tonumber(a)
	end
	if type(b) == "string" then
		b = strsplit(":", b)
		b = tonumber(b)
	end

	local nameA = select(2, GetAchievementInfo(a)) or ""
	local nameB = select(2, GetAchievementInfo(b)) or ""
	return nameA < nameB
end

local function AddAchievementToCategory(categoryID, achievement)
	-- if the achievement is a number or a string that can be converted to a number, add it as a number
	-- else add it as a string . This will be the case for faction specific achievements. 
	--	ex: "122:123" would mean that 122 is the alliance version of the achievement, and 123 the horde version
	table.insert(achievementsByCategory[categoryID], tonumber(achievement) or achievement)
end

local function BuildCategoryList(categoryID)
	-- each category is a sub-table of the reference table.
	achievementsByCategory[categoryID] = {}

	--	if this category does not contain series or faction specific achievements : use the game's list
	if not sortedAchievements[categoryID] and not unsortedAchievements[categoryID] then
		local id
		for i = 1, GetCategoryNumAchievements(categoryID) do
			id = GetAchievementInfo(categoryID, i)
			AddAchievementToCategory(categoryID, id)
		end
		table.sort(achievementsByCategory[categoryID], SortByName)
		return
	end
	
	--	otherwise : use the list of sorted achievements .. 
	if sortedAchievements[categoryID] then
		for achievement in sortedAchievements[categoryID]:gmatch("([^,]+)") do
			AddAchievementToCategory(categoryID, achievement)
		end
	end
	
	-- .. then add the unsorted ones after they've been sorted alphabetically.
	if unsortedAchievements[categoryID] then
		local remaining = {}
		for achievement in unsortedAchievements[categoryID]:gmatch("([^,]+)") do
			table.insert(remaining, tonumber(achievement) or achievement)
		end
		table.sort(remaining, SortByName)	-- sort remaining achievements by name ..
		
		for _, achievement in pairs(remaining) do		
			AddAchievementToCategory(categoryID, achievement)
		end
	end
end

local function BuildReferenceTable()
	-- based on the list of achievements that should be sorted in a predefined order, and the remaining achievements (ordered alphabetically, with the influence of localized named), create a reference table
	-- that will allow easy use of categories/lists which support both factions.
	
	local cats = GetCategoryList()
	for _, categoryID in ipairs(cats) do
		local _, parentID = GetCategoryInfo(categoryID)
		
		if parentID == -1 then		-- add categories, followed by their respective sub-categories
			BuildCategoryList(categoryID)
			
			for _, subCatID in ipairs(cats) do
				local _, subCatParentID = GetCategoryInfo(subCatID)
				if subCatParentID == categoryID then
					BuildCategoryList(subCatID)
				end
			end
		end
	end
end

-- Code added 27/05/2020 - 8.3-010
-- debug code to be used when the game is patched, to get a list of achievements that are missing
--[[local function AltoholicAchievementsTestMissing()
    for categoryID,_ in pairs(sortedAchievements) do
        local output = "missing: "..categoryID..": "
        local f = false
        for i = 1, GetCategoryNumAchievements(categoryID) do
            local id = GetAchievementInfo(categoryID, i)
            local found = false
            if string.find(sortedAchievements[categoryID], id) then
                found = true
            end
		    if unsortedAchievements[categoryID] then
                if string.find(unsortedAchievements[categoryID], id) then
                    found = true
                end
            end            
            if not found then
                output = output..id..","
                f = true
            end 
        end
        if f then
            print(output)
        end
    end
end
AltoholicAchievementsTestMissing()]]--

-- Warning: this function is incredibly slow and inefficient
--[[function AltoholicAchievementsTestDuplicates()
    for categoryID,achievements in pairs(sortedAchievements) do
        for achievementGroup in achievements:gmatch("([^,]+)") do
            for achievement in achievementGroup:gmatch("([^:]+)") do
              local count = 0
              for _, a in pairs(sortedAchievements) do
              	for b in a:gmatch("([^,]+)") do
                      for c in b:gmatch("([^:]+)") do                
                          if c == achievement then
                              count = count + 1
                          end
                      end
                  end
              end
              for _, a in pairs(unsortedAchievements) do
                  for b in a:gmatch("([^,]+)") do
                      for c in b:gmatch("([^:]+)") do
                          if c == achievement then
                              count = count + 1
                          end
                      end
                  end    
              end
              if count > 1 then
                  print("Duplicate achievement: "..achievement)
              end
            end
        end
    end
end
AltoholicAchievementsTestDuplicates()]]--

--[[function AltoholicAchievementsTestRemoved()
    local referenceDB = {}
    for _, categoryID in pairs(GetCategoryList()) do
        referenceDB[categoryID] = {}
        for i = 1, GetCategoryNumAchievements(categoryID) do
            local id = GetAchievementInfo(categoryID, i)
            referenceDB[categoryID][id] = true
            local nextAchievement = GetNextAchievement(id)
            while(nextAchievement) do
                referenceDB[categoryID][nextAchievement] = true
                nextAchievement = GetNextAchievement(nextAchievement)
            end
            nextAchievement = GetPreviousAchievement(id)
            while(nextAchievement) do
                referenceDB[categoryID][nextAchievement] = true
                nextAchievement = GetPreviousAchievement(nextAchievement)
            end
        end
    end
    
    for _, group in pairs({sortedAchievements, unsortedAchievements}) do
        for categoryID, achievements in pairs(group) do
            for achievementGroup in achievements:gmatch("([^,]+)") do
                local allianceID, hordeID = strsplit(":", achievementGroup)
                local achievementID = tonumber(allianceID)
                if hordeID and UnitFactionGroup("player") == "Horde" then
                    achievementID = tonumber(hordeID)
                end
                if not referenceDB[categoryID] then
                    print("removed category: ", categoryID)
                elseif select(4, GetAchievementInfo(achievementID)) and (not referenceDB[categoryID][achievementID]) then 
                    -- first part of the if filters out other-faction exclusive achievements, at the expense of it needing to be earned already
                    print("removed achievement: ", achievementID)
                end
            end
        end
    end
end
AltoholicAchievementsTestRemoved()]]--
        
-- now that this part of the UI is LoD, this can be called here
BuildReferenceTable()

sortedAchievements = nil
unsortedAchievements = nil
BuildReferenceTable = nil
BuildCategoryList = nil
AddAchievementToCategory = nil
SortByName = nil


local function GetCategorySize(categoryID)
	if type(achievementsByCategory[categoryID]) == "table" then
        return #achievementsByCategory[categoryID]
	end
	return 0
end

local function GetAchievementFactionInfo(categoryID, index)
	if type(achievementsByCategory[categoryID]) ~= "table" then return end
	
	local achievement = achievementsByCategory[categoryID][index]
	
	if type(achievement) == "number" then
		return achievement								-- return achievement ID
	elseif type(achievement) == "string" then
		local ally, horde = strsplit(":", achievement)
		return tonumber(ally), tonumber(horde)		-- return alliance ach id, horde ach id
	end
end

local currentCategoryID

-- 8.3.003: adding these to expand past 12 characters via scrolling
local current_start_col = 1
local start_char_index = 1
function addon:GetAchievementsCurrentColumnScrollInfo()
    return current_start_col, start_char_index
end

addon:Controller("AltoholicUI.Achievements", {
	SetCategory = function(frame, categoryID)
		-- for debug only
		-- print(categoryID)
		currentCategoryID = categoryID
	end,
    OnBind = function(frame)
        AltoholicFrame:RegisterResizeEvent("AltoholicTabAchievementsAchievements", 8, AltoholicTabAchievements.Achievements, 12)
    end,
	Update = function(frame)
		local scrollFrame = frame.ScrollFrame
		local numRows = scrollFrame.numRows
        local numCols = scrollFrame.numCols
		local offset = scrollFrame:GetOffset()
		
		local categorySize = GetCategorySize(currentCategoryID)
		local account, realm = frame:GetParent():GetAccount()
		
		AltoholicTabAchievements.Status:SetText(format("%s: %s%s", ACHIEVEMENTS, colors.green, categorySize ))
		
        local classIcons = AltoholicTabAchievements.ClassIcons
        -- Update which class icons are shown
        for i = 1, 50 do
            local icon = classIcons["Icon"..i]
            icon:ClearAllPoints()
            if (i < current_start_col) or (i >= (current_start_col + numCols)) then
                icon:SetShown(false)
            else
                if (i == current_start_col) then
                    icon:SetPoint("TOPLEFT", icon:GetParent())
                else
                    icon:SetPoint("BOTTOMLEFT", classIcons["Icon"..(i-1)], "BOTTOMLEFT", 35, 0)
                end
                icon:SetShown(true)
                icon:Show()
            end
        end
        
		for rowIndex = 1, numRows do
			local rowFrame = scrollFrame:GetRow(rowIndex)
			local line = rowIndex + offset
			
			if line <= categorySize then	-- if the line is visible
				local allianceID, hordeID = GetAchievementFactionInfo(currentCategoryID, line)
				
				rowFrame:Update(account, realm, allianceID, hordeID)
				rowFrame:Show()
			else
				rowFrame:Hide()
			end
		end

        for rowIndex = numRows + 1, 20 do
            scrollFrame:GetRow(rowIndex):Hide()
        end

		scrollFrame:Update(categorySize)
		frame:Show()
	end,
})

function addon:OnTabAchievementsRightButtonClick()
    if current_start_col == 50 then return end
    current_start_col = current_start_col + 1
    AltoholicTabAchievements.Achievements.Update(AltoholicTabAchievements.Achievements)    
end

function addon:OnTabAchievementsLeftButtonClick()
    if current_start_col == 1 then return end
    current_start_col = current_start_col - 1
    AltoholicTabAchievements.Achievements.Update(AltoholicTabAchievements.Achievements)
end