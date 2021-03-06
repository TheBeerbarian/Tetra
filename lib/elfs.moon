socket = require "socket"

module "elfs", package.seeall

export ^

math.randomseed socket.gettime!*10000

names = {  "SEED",  "GRASS",  "FLOWE",  "SHAD",  "CABR",  "SNAKE",  "GOLD",  "COW",  "GUIKI",
   "PEDAL",  "DELAN",  "B-FLY",  "BIDE",  "KEYU",  "FORK",  "LAP",  "PIGE",  "PIJIA",
   "CAML",  "LAT",  "BIRD",  "BABOO",  "VIV",  "ABOKE",  "PIKAQ",  "RYE",  "SAN",
   "BREAD",  "LIDEL",  "LIDE",  "PIP",  "PIKEX",  "ROK",  "JUGEN",  "PUD",  "BUDE",
   "ZHIB",  "GELU",  "GRAS",  "FLOW",  "LAFUL",  "ATH",  "BALA",  "CORN",  "MOLUF",
   "DESP",  "DAKED",  "MIMI",  "BOLUX",  "KODA",  "GELUD",  "MONK",  "SUMOY",  "GEDI",
   "WENDI",  "NILEM",  "NILE",  "NILEC",  "KEZI",  "YONGL",  "HUDE",  "WANLI",  "GELI",
   "GUAIL",  "MADAQ",  "WUCI",  "WUCI",  "MUJEF",  "JELLY",  "SICIB",  "GELU",  "NELUO",
   "BOLI",  "JIALE",  "YED",  "YEDE",  "CLO",  "SCARE",  "AOCO",  "DEDE",  "DEDEI",
   "BAWU",  "JIUG",  "BADEB",  "BADEB",  "HOLE",  "BALUX",  "GES",  "FANT",  "QUAR",
   "YIHE",  "SWAB",  "SLIPP",  "CLU",  "DEPOS",  "BILIY",  "YUANO",  "SOME",  "NO",
   "YELA",  "EMPT",  "ZECUN",  "XIAHE",  "BOLEL",  "DEJI",  "MACID",  "XIHON",
   "XITO",  "LUCK",  "MENJI",  "GELU",  "DECI",  "XIDE",  "DASAJ",  "DONGN",  "RICUL",
   "MINXI",  "BALIY",  "ZENDA",  "LUZEL",  "HELE5",  "0FENB",  "KAIL",  "JIAND",
   "CARP",  "JINDE",  "LAPU",  "MUDE",  "YIFU",  "LINLI",  "SANDI",  "HUSI",  "JINC",
   "OUMU",  "OUMUX",  "CAP",  "KUIZA",  "PUD",  "TIAO",  "FRMAN",  "CLAU",  "SPARK",
   "DRAGO",  "BOLIU",  "GUAIL",  "MIYOU",  "MIY",  "QIAOK",  "BEIL",  "MUKEI",  "RIDED",
   "MADAM",  "BAGEP",  "CROC",  "ALIGE",  "OUDAL",  "OUD",  "DADA",  "HEHE",  "YEDEA",
   "NUXI",  "NUXIN",  "ROUY",  "ALIAD",  "STICK",  "QIANG",  "LAAND",  "PIQI",  "PI",
   "PUPI",  "DEKE",  "DEKEJ",  "NADI",  "NADIO",  "MALI",  "PEA",  "ELECT",  "FLOWE",
   "MAL",  "MALI",  "HUSHU",  "NILEE",  "YUZI",  "POPOZ",  "DUZI",  "HEBA",  "XIAN",
   "SHAN",  "YEYEA",  "WUY",  "LUO",  "KEFE",  "HULA",  "CROW",  "YADEH",  "MOW",
   "ANNAN",  "SUONI",  "KYLI",  "HULU",  "HUDEL",  "YEHE",  "GULAE",  "YEHE",
   "BLU",  "GELAN",  "BOAT",  "NIP",  "POIT",  "HELAK",  "XINL",  "BEAR",  "LINB",
   "MAGEH",  "MAGEJ",  "WULI",  "YIDE",  "RIVE",  "FISH",  "AOGU",  "DELIE",
   "MANTE",  "KONMU",  "DELU",  "HELU",  "HUAN",  "HUMA",  "DONGF",  "JINCA",
   "HEDE",  "DEFU",  "LIBY",  "JIAPA",  "MEJI",  "HELE",  "BUHU",  "MILK",
   "HABI",  "THUN",  "GARD",  "DON",  "YANGQ",  "SANAQ",  "BANQ",  "LUJ",
   "PHIX",  "SIEI",  "EGG"
}
moves = { "ABLE", "ABNORMA", "AGAIN", "AIREXPL", "ANG", "ANGER",
  "ASAIL", "ATTACK", "AURORA", "AWL", "BAN", "BAND", "BARE",
  "BEAT", "BEATED", "BELLY", "BIND", "BITE", "BLOC", "BLOOD",
  "BODY", "BOOK", "BREATH", "BUMP", "CAST", "CHAM", "CLAMP",
  "CLAP", "CLAW", "CLEAR", "CLI", "CLIP", "CLOUD", "CONTRO",
  "CONVY", "COOLHIT", "CRASH", "CRY", "CUT", "DESCRI", "D-FIGHT",
  "DIG", "DITCH", "DIV", "DOZ", "DRE", "DUL", "DU-PIN", "DYE",
  "EARTH", "EDU", "EG-BOMB", "EGG", "ELEGY", "ELE-HIT", "EMBODY",
  "EMPLI", "ENGL", "ERUPT", "EVENS", "EXPLOR", "EYES", "FALL",
  "FAST", "F-CAR", "F-DANCE", "FEARS", "F-FIGHT", "FIGHT", "FIR",
  "FIRE", "FIREHIT", "FLAME", "FLAP", "FLASH", "FLEW", "FORCE",
  "FRA", "FREEZE", "FROG", "G-BIRD", "GENKISS", "GIFT", "G-KISS",
  "G-MOUSE", "GRADE", "GROW", "HAMMER", "HARD", "HAT", "HATE",
  "H-BOMB", "HELL-R", "HEMP", "HINT", "HIT", "HU", "HUNT", "HYPNOSI",
  "INHA", "IRO", "IRONBAR", "IR-WING", "J-GUN", "KEE", "KICK",
  "KNIF", "KNIFE", "KNOCK", "LEVEL", "LIGH", "LIGHHIT", "LIGHT",
  "LIVE", "L-WALL", "MAD", "MAJUS", "MEL", "MELO", "MESS", "MILK",
  "MIMI", "MISS", "MIXING", "MOVE", "MUD", "NI-BED", "NOISY",
  "NOONLI", "NULL", "N-WAVE", "PAT", "PEACE", "PIN", "PLAN",
  "PLANE", "POIS", "POL", "POWDE", "POWE", "POWER", "PRIZE",
  "PROTECT", "PROUD", "RAGE", "RECOR", "REFLAC", "REFREC", "REGR",
  "RELIV", "RENEW", "R-FIGHT", "RING", "RKICK", "ROCK", "ROUND",
  "RUS", "RUSH", "SAND", "SAW", "SCISSOR", "SCRA", "SCRIPT", "SEEN",
  "SERVER", "SHADOW", "SHELL", "SHINE", "SHO", "SIGHT", "SIN",
  "SMALL", "SMELT", "SMOK", "SNAKE", "SNO", "SNOW", "SOU", "SO-WAVE",
  "SPAR", "SPEC", "SPID", "S-PIN", "SPRA", "STAM", "STARE", "STEA",
  "STONE", "STORM", "STRU", "STRUG", "STUDEN", "SUBS", "SUCID",
  "SUN-LIG", "SUNRIS", "SUPLY", "S-WAVE", "TAILS", "TANGL", "TASTE",
  "TELLI", "THANK", "TONKICK", "TOOTH", "TORL", "TRAIN", "TRIKICK",
  "TUNGE", "VOLT", "WA-GUN", "WATCH", "WAVE", "W-BOMB", "WFALL",
  "WFING", "WHIP", "WHIRL", "WIND", "WOLF", "WOOD", "WOR", "YUJA"
}

getElement = (list) ->
  list[math.random(#list)]\lower!\gsub "-", ""

--- GenName returns a heroku style app name from pokemon vietnamese crystal seeds.
GenName = ->
  "#{getElement moves}-#{getElement moves}-#{getElement names}"
