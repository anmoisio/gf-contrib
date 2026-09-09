


# 100 nouns, picked from the MacArthur Communicative Development Inventory and the BNC top frequent nouns
# BNC freq rank: http://ucrel.lancs.ac.uk/bncfreq/flists.html
animate_nouns = [
    'girl', 'boy', 'cat', 'dog', 'baby', 'child', 'teacher', 'frog', 'chicken', 'mouse',
    'lion', 'monkey', 'bear', 'giraffe', 'horse', 'bird', 'duck', 'bunny', 'butterfly', 'penguin',
    'student', 'professor', 'monster', 'hero', 'sailor', 'lawyer', 'customer', 'scientist', 'princess', 'president',
    'cow', 'crocodile', 'goose', 'hen', 'deer', 'donkey', 'bee', 'fly', 'kitty', 'tiger',
    'wolf', 'zebra', 'mother', 'father', 'patient', 'manager', 'director', 'king', 'queen', 'kid',
    'fish', 'moose',  'pig', 'pony', 'puppy', 'sheep', 'squirrel', 'lamb', 'turkey', 'turtle', 
    'doctor', 'pupil', 'prince', 'driver', 'consumer', 'writer', 'farmer', 'friend', 'judge', 'visitor',
    'guest', 'servant', 'chief', 'citizen', 'champion', 'prisoner', 'captain', 'soldier', 'passenger', 'tenant',
    'politician', 'resident', 'buyer', 'spokesman', 'governor', 'guard', 'creature', 'coach', 'producer', 'researcher',
    'guy', 'dealer', 'duke', 'tourist', 'landlord', 'human', 'host', 'priest', 'journalist', 'poet'
]
assert len(set(animate_nouns)) == 100
# missing
animate_nouns += ['cobra', 'cockroach', 'hedgehog', 'hippo', 'shark']

inanimate_nouns = [
    'cake', 'donut', 'cookie', 'box', 'rose', 'drink', 'raisin', 'melon', 'sandwich', 'strawberry', 
    'ball', 'balloon', 'bat', 'block', 'book', 'crayon', 'chalk', 'doll', 'game', 'glue',
    'lollipop', 'hamburger', 'banana', 'biscuit', 'muffin', 'pancake', 'pizza', 'potato', 'pretzel', 'pumpkin',
    'sweetcorn', 'yogurt', 'pickle', 'jigsaw', 'pen', 'pencil', 'present', 'toy', 'cracker', 'brush',
    'radio', 'cloud', 'mandarin', 'hat', 'basket', 'plant', 'flower', 'chair', 'spoon', 'pillow',
    'gumball', 'scarf', 'shoe', 'jacket', 'hammer', 'bucket', 'knife', 'cup', 'plate', 'towel',
    'bottle', 'bowl', 'can', 'clock', 'jar', 'penny', 'purse', 'soap', 'toothbrush', 'watch',
    'newspaper', 'fig', 'bag', 'wine', 'key', 'weapon', 'brain', 'tool', 'crown', 'ring',
    'leaf', 'fruit', 'mirror', 'beer', 'shirt', 'guitar', 'chemical', 'seed', 'shell', 'brick',
    'bell', 'coin', 'button', 'needle', 'molecule', 'crystal', 'flag', 'nail', 'bean', 'liver'
]

assert len(set(inanimate_nouns)) == 100

# 100 names, picked from https://www.ssa.gov/OACT/babynames/
proper_nouns = [
    'Emma', 'Liam', 'Olivia', 'Noah', 'Ava', 'William', 'Isabella', 'James', 'Sophia', 'Oliver', 
    'Charlotte', 'Benjamin', 'Mia', 'Elijah', 'Amelia', 'Lucas', 'Harper', 'Mason', 'Evelyn', 'Logan',
    'Abigail', 'Alexander', 'Emily', 'Ethan', 'Elizabeth', 'Jacob', 'Mila', 'Michael', 'Ella', 'Daniel',
    'Avery', 'Henry', 'Sofia', 'Jackson', 'Camila', 'Sebastian', 'Aria', 'Aiden', 'Scarlett', 'Matthew',
    'Victoria', 'Samuel', 'Madison', 'David', 'Luna', 'Joseph', 'Grace', 'Carter', 'Chloe', 'Owen',
    'Penelope', 'Wyatt', 'Layla', 'John', 'Riley', 'Jack', 'Zoey', 'Luke', 'Nora', 'Jayden',
    'Lily', 'Dylan', 'Eleanor', 'Grayson', 'Hannah', 'Levi', 'Lillian', 'Isaac', 'Addison', 'Gabriel',
    'Aubrey', 'Julian', 'Ellie', 'Mateo', 'Stella', 'Anthony', 'Natalie', 'Jaxon', 'Zoe', 'Lincoln',
    'Leah', 'Joshua', 'Hazel', 'Christopher', 'Violet', 'Andrew', 'Aurora', 'Theodore', 'Savannah', 'Caleb',
    'Audrey', 'Ryan', 'Brooklyn', 'Asher', 'Bella', 'Nathan', 'Claire', 'Thomas', 'Skylar', 'Leo'
]

assert len(set(proper_nouns)) == 100
# missing 
proper_nouns += ['Charlie', 'Lina', 'Paula']

# P + N: N from BNC + COCA

# 100 nouns that can appear with "on" 
on_nouns = [
    'table', 'stage', 'bed', 'chair', 'stool', 'road', 'tree', 'box', 'surface', 'seat',
    'speaker', 'computer', 'rock', 'boat', 'cabinet', 'TV', 'plate', 'desk', 'bowl', 'bench',
    'shelf', 'cloth', 'piano', 'bible', 'leaflet', 'sheet', 'cupboard', 'truck', 'tray', 'notebook',
    'blanket', 'deck', 'coffin', 'log', 'ladder', 'barrel', 'rug', 'canvas', 'tiger', 'towel',
    'throne', 'booklet', 'sock', 'corpse', 'sofa', 'keyboard', 'book', 'pillow', 'pad', 'train',
    'couch', 'bike', 'pedestal', 'platter', 'paper', 'rack', 'board', 'panel', 'tripod', 'branch',
    'machine', 'floor', 'napkin', 'cookie', 'block', 'cot', 'device', 'yacht', 'dog', 'mattress',
    'ball', 'stand', 'stack', 'windowsill', 'counter', 'cushion', 'hanger', 'trampoline', 'gravel', 'cake',
    'carpet', 'plaque', 'boulder', 'leaf', 'mound', 'bun', 'dish', 'cat', 'podium', 'tabletop',
    'beach', 'bag', 'glacier', 'brick', 'crack', 'vessel', 'futon', 'turntable', 'rag', 'chessboard'
]

# 100 nouns that can appear with "in"
in_nouns = [
    'house', 'room', 'car', 'garden', 'box', 'cup', 'glass', 'bag', 'vehicle', 'hole',
    'cabinet', 'bottle', 'shoe', 'storage', 'cot', 'vessel', 'pot', 'pit', 'tin', 'can',
    'cupboard', 'envelope', 'nest', 'bush', 'coffin', 'drawer', 'container', 'basin', 'tent', 'soup',
    'well', 'barrel', 'bucket', 'cage', 'sink', 'cylinder', 'parcel', 'cart', 'sack', 'trunk',
    'wardrobe', 'basket', 'bin', 'fridge', 'mug', 'jar', 'corner', 'pool', 'blender', 'closet',
    'pile', 'van', 'trailer', 'saucepan', 'truck', 'taxi', 'haystack', 'dumpster', 'puddle', 'bathtub',
    'pod', 'tub', 'trap', 'bun', 'microwave', 'bookstore', 'package', 'cafe', 'train', 'castle',
    'bunker', 'vase', 'backpack', 'tube', 'hammock', 'stadium', 'backyard', 'swamp', 'monastery', 'refrigerator',
    'palace', 'cubicle', 'crib', 'condo', 'tower', 'crate', 'dungeon', 'teapot', 'tomb', 'casket',
    'jeep', 'shoebox', 'wagon', 'bakery', 'fishbowl', 'kennel', 'china', 'spaceship', 'penthouse', 'pyramid'
] 

# 100 nouns that can appear with "beside"
beside_nouns = [
    'table', 'stage', 'bed', 'chair', 'book', 'road', 'tree', 'machine', 'house', 'seat',
    'speaker', 'computer', 'rock', 'car', 'box', 'cup', 'glass', 'bag', 'flower', 'boat',
    'vehicle', 'key', 'painting', 'cabinet', 'TV', 'bottle', 'cat', 'desk', 'shoe', 'mirror',
    'clock', 'bench', 'bike', 'lamp', 'lion', 'piano', 'crystal', 'toy', 'duck', 'sword',
    'sculpture', 'rod', 'truck', 'basket', 'bear', 'nest', 'sphere', 'bush', 'surgeon', 'poster',
    'throne', 'giant', 'trophy', 'hedge', 'log', 'tent', 'ladder', 'helicopter', 'barrel', 'yacht',
    'statue', 'bucket', 'skull', 'beast', 'lemon', 'whale', 'cage', 'gardner', 'fox', 'sink',
    'trainee', 'dragon', 'cylinder', 'monk', 'bat', 'headmaster', 'philosopher', 'foreigner', 'worm', 'chemist',
    'corpse', 'wolf', 'torch', 'sailor', 'valve', 'hammer', 'doll', 'genius', 'baron', 'murderer',
    'bicycle', 'keyboard', 'stool', 'pepper', 'warrior', 'pillar', 'monkey', 'cassette', 'broker', 'bin'
    
]

assert len(set(on_nouns)) == len(set(in_nouns)) == len(set(beside_nouns)) == 100
noun_list = animate_nouns + inanimate_nouns + proper_nouns + on_nouns + in_nouns + beside_nouns
# print(len(set(noun_list)))

# Levin, '1.2.1 Unspecified Object Alternation'
# And some intuition-based selection. 
V_trans_omissible = [
  'ate', 'painted', 'drew', 'cleaned', 'cooked', 
  'dusted', 'hunted', 'nursed', 'sketched', 'juggled',
  'called', 'heard', 'packed', 'saw', 'noticed',
  'studied', 'examined', 'observed', 'knew', 'investigated'
]
V_trans_omissible_pp = [
  'eaten', 'painted', 'drawn', 'cleaned', 'cooked',
  'dusted', 'hunted', 'nursed', 'sketched', 'juggled',
  'called', 'heard', 'packed', 'seen', 'noticed',
  'studied', 'examined', 'observed', 'known', 'investigated'
]

assert len(set(V_trans_omissible)) == len(set(V_trans_omissible_pp)) == 20 

# Levin class 30. Verbs of Perception, 31.2 Admire Verbs, VerbNet poke-19, throw-17.1.1
V_trans_not_omissible = [
  'liked', 'helped', 'found', 'loved', 'poked',
  'admired', 'adored', 'appreciated', 'missed', 'respected',
  'threw', 'tolerated', 'valued', 'worshipped', 'discovered', 
  'held', 'stabbed', 'touched', 'pierced', 'tossed'
]
V_trans_not_omissible_pp = [
  'liked', 'helped', 'found', 'loved', 'poked', 
  'admired', 'adored', 'appreciated', 'missed', 'respected', 
  'thrown', 'tolerated', 'valued', 'worshipped', 'discovered', 
  'held', 'stabbed', 'touched', 'pierced', 'tossed'
]

assert set(V_trans_omissible).isdisjoint(set(V_trans_not_omissible))
assert set(V_trans_omissible_pp).isdisjoint(set(V_trans_not_omissible_pp))

assert len(set(V_trans_not_omissible)) == len(set(V_trans_not_omissible_pp)) == 20 

# Levin 29.4 Declare verbs, Levin 30. Verbs of Perception, VerbNet admire-31.2, VerbNet wish-62
V_cp_taking = [
  'liked', 'hoped', 'said', 'noticed', 'believed',
  'confessed', 'declared', 'proved', 'thought', 'admired',
  'appreciated', 'respected', 'supported', 'tolerated', 'valued',
  'wished', 'dreamed', 'expected', 'imagined', 'meant'
]

assert len(set(V_cp_taking)) == 20
 
# VerbNet want-32.1, VerbNet try-61, VerbNet wish-62, VerbNet long-32.2, VerbNet admire-31.2-1
V_inf_taking = [
  'wanted', 'preferred', 'needed', 'intended', 'tried',
  'attempted', 'planned', 'expected', 'hoped', 'wished', 
  'craved', 'liked', 'hated', 'loved', 'enjoyed',
  'dreamed', 'meant', 'longed', 'yearned', 'itched'
]
assert len(set(V_inf_taking)) == 20

# 1.1.2.1 Causative-Inchoative Alternation
V_unacc = [
  'rolled', 'froze', 'burned', 'shortened', 'floated', 
  'grew', 'slid', 'broke', 'crumpled', 'split', 
  'changed', 'snapped', 'disintegrated', 'collapsed', 'decomposed',
  'doubled', 'improved', 'inflated', 'enlarged', 'reddened', 
]
V_unacc_pp = [
  'rolled', 'frozen', 'burned', 'shortened', 'floated',
  'grown', 'slid', 'broken', 'crumpled', 'split',
  'changed', 'snapped', 'disintegrated', 'collapsed', 'decomposed', 
  'doubled', 'improved', 'inflated', 'enlarged', 'reddened'
]
assert len(set(V_unacc)) == len(set(V_unacc_pp)) == 20

V_unerg = [
  'slept', 'smiled', 'laughed', 'sneezed', 'cried', 
  'talked', 'danced', 'jogged', 'walked', 'ran', 
  'napped', 'snoozed', 'screamed', 'stuttered', 'frowned', 
  'giggled', 'scoffed', 'snored', 'smirked', 'gasped'
]
assert len(set(V_unerg)) == 20

# 10 DO omissible transitives, 10 unergatives
V_inf = [
  'walk', 'run', 'sleep', 'sneeze', 'nap',
  'eat', 'read', 'cook', 'hunt', 'paint',
  'talk', 'dance', 'giggle', 'jog', 'smirk',
  'call', 'sketch', 'dust', 'clean', 'investigate'
]
assert len(set(V_inf)) == 20

V_dat = [
  'gave', 'lent', 'sold', 'offered', 'fed',
  'passed', 'sent', 'rented', 'served', 'awarded', 
  'brought', 'handed', 'forwarded', 'promised', 'mailed',
  'loaned', 'posted', 'returned', 'slipped', 'wired'
]
V_dat_pp = [
  'given', 'lent', 'sold', 'offered', 'fed', 
  'passed', 'sent', 'rented', 'served', 'awarded',
  'brought', 'handed', 'forwarded', 'promised', 'mailed', 
  'loaned', 'posted', 'returned', 'slipped', 'wired'
]

assert len(set(V_dat)) == len(set(V_dat_pp)) == 20


# missing
V_inf += ['crawl']
V_unacc += ['shattered']
V_trans_not_omissible += ['blessed', 'squeezed']
V_dat += ['teleported', 'shipped']


# print(len(set(V_trans_omissible + V_trans_not_omissible + V_cp_taking + V_unacc + V_unerg + V_dat)))

verbs_lemmas = { 
  'ate':'eat', 'painted':'paint', 'drew':'draw', 'cleaned':'clean',
  'cooked':'cook', 'dusted':'dust', 'hunted':'hunt', 'nursed':'nurse',
  'sketched':'sketch', 'washed':'wash', 'juggled':'juggle', 'called':'call',
  'eaten':'eat', 'drawn':'draw', 'baked':'bake', 'liked':'like', 'knew':'know', 
  'helped':'help', 'saw':'see', 'found':'find', 'heard':'hear', 'noticed':'notice',
  'loved':'love', 'admired':'admire', 'adored':'adore', 'appreciated':'appreciate',
  'missed':'miss', 'respected':'respect', 'tolerated':'tolerate', 'valued':'value', 
  'worshipped':'worship', 'observed':'observe', 'discovered':'discover', 'held':'hold',
  'stabbed':'stab', 'touched':'touch', 'pierced':'pierce', 'poked':'poke',
  'known':'know', 'seen':'see', 'hit':'hit', 'hoped':'hope', 'said':'say',
  'believed':'believe', 'confessed':'confess', 'declared':'declare', 'proved':'prove',
  'thought':'think', 'supported':'support', 'wished':'wish', 'dreamed':'dream', 
  'expected':'expect', 'imagined':'imagine', 'envied':'envy', 'wanted':'want', 
  'preferred':'prefer', 'needed':'need', 'intended':'intend', 'tried':'try',
  'attempted':'attempt', 'planned':'plan','craved':'crave','hated':'hate',
  'enjoyed':'enjoy', 'rolled':'roll', 'froze':'freeze', 'burned':'burn', 'shortened':'shorten',
  'floated':'float', 'grew':'grow', 'slid':'slide', 'broke':'break', 'crumpled':'crumple',
  'split':'split', 'changed':'change', 'snapped':'snap', 'tore':'tear', 'collapsed':'collapse',
  'decomposed':'decompose', 'doubled':'double', 'improved':'improve', 'inflated':'inflate',
  'enlarged':'enlarge', 'reddened':'redden', 'popped':'pop', 'disintegrated':'disintegrate',
  'expanded':'expand', 'cooled':'cool', 'soaked':'soak', 'frozen':'freeze', 'grown':'grow',
  'broken':'break', 'torn':'tear', 'slept':'sleep', 'smiled':'smile', 'laughed':'laugh',
  'sneezed':'sneeze', 'cried':'cry', 'talked':'talk', 'danced':'dance', 'jogged':'jog',
  'walked':'walk', 'ran':'run', 'napped':'nap', 'snoozed':'snooze', 'screamed':'scream',
  'stuttered':'stutter', 'frowned':'frown', 'giggled':'giggle', 'scoffed':'scoff',
  'snored':'snore', 'snorted':'snort', 'smirked':'smirk', 'gasped':'gasp',
  'gave':'give', 'lent':'lend', 'sold':'sell', 'offered':'offer', 'fed':'feed', 
  'passed':'pass', 'rented':'rent', 'served':'serve','awarded':'award', 'promised':'promise',
  'brought':'bring', 'sent':'send', 'handed':'hand', 'forwarded':'forward', 'mailed':'mail',
  'posted':'post','given':'give', 'shipped':'ship', 'packed':'pack', 'studied':'study', 
  'examined':'examine', 'investigated':'investigate', 'thrown':'throw', 'threw':'throw',
  'tossed':'toss', 'meant':'mean', 'longed':'long', 'yearned':'yearn', 'itched':'itch',
  'loaned':'loan', 'returned':'return', 'slipped':'slip', 'wired':'wire', 'crawled':'crawl',
  'shattered':'shatter', 'bought':'buy', 'squeezed':'squeeze', 'teleported':'teleport',
  'melted':'melt', 'blessed':'bless'
}

pos_d = {
    'a': 'DET',
    'the': 'DET',
    'to': 'ADP',
    'on': 'ADP',
    'in': 'ADP',
    'beside': 'ADP',
    'that': 'SCONJ',
    'was': 'AUX',
    'by': 'ADP'
}

lexicon = {"animate_nouns" : animate_nouns,
           "inanimate_nouns" : inanimate_nouns,
           "proper_nouns" : proper_nouns,
           "on_nouns" : on_nouns,
           "in_nouns" : in_nouns,
           "beside_nouns" : beside_nouns,
           "V_trans_omissible" : V_trans_omissible,
           "V_trans_not_omissible" : V_trans_not_omissible,
           "V_trans_omissible_pp" : V_trans_omissible_pp,
           "V_trans_not_omissible_pp" : V_trans_not_omissible_pp,
           "V_cp_taking" : V_cp_taking,
           "V_unacc" : V_unacc,
           "V_unacc_pp" : V_unacc_pp,
           "V_unerg" : V_unerg,
           "V_dat" : V_dat,
           "V_inf_taking" : V_inf_taking,
           "V_inf" : V_inf,
           "V_dat_pp" : V_dat_pp,
}



animate_nouns_translate_fin = {
    'girl' : 'tyttö',
    'boy' : 'poika',
    'lion': 'leijona', 'monkey': 'apina', 'bear': 'karhu', 'giraffe': 'kirahvi', 'horse': 'hevonen', 'bird': 'lintu', 'duck': 'ankka', 'bunny': 'kani', 'butterfly': 'perhonen', 'penguin': 'pingviini',
    'student': 'opiskelija', 'professor': 'professori', 'monster': 'hirviö', 'hero': 'sankari', 'sailor': 'merimies', 'lawyer': 'asianajaja', 'customer': 'asiakas', 'scientist': 'tutkija', 'princess': 'prinsessa', 'president': 'presidentti',
    'cow': 'lehmä', 'crocodile': 'krokotiili', 'goose': 'hanhi', 'hen': 'kana', 'deer': 'peura', 'donkey': 'aasi', 'bee': 'mehiläinen', 'fly': 'kärpänen', 'kitty': 'kissa', 'tiger': 'tiikeri',
    'wolf': 'susi', 'zebra': 'seepra', 'mother': 'äiti', 'father': 'isä', 'patient': 'potilas', 'manager': 'päällikkö', 'director': 'johtaja', 'king': 'kuningas', 'queen': 'kuningatar', 'kid': 'lapsi',
    'fish': 'kala', 'moose':  'hirvi', 'pig': 'sika', 'pony': 'poni', 'puppy': 'pennut', 'sheep': 'lammas', 'squirrel': 'orava', 'lamb': 'karitsa', 'turkey': 'kalkkuna', 'turtle': 'kilpikonna',
    'doctor': 'lääkäri', 'pupil': 'oppilas', 'prince': 'prinssi', 'driver': 'kuljettaja', 'consumer': 'kuluttaja', 'writer': 'kirjailija', 'farmer': 'viljelijä', 'friend': 'ystävä', 'judge': 'tuomari', 'visitor': 'vierailija',
    'guest': 'vieras', 'servant': 'palvelija', 'chief': 'päällikkö', 'citizen': 'kansalainen', 'champion': 'mestari', 'prisoner': 'vangittu', 'captain': 'kapteeni', 'soldier': 'sotilas', 'passenger': 'matkustaja', 'tenant': 'vuokralainen',
    'politician': 'poliitikko', 'resident': 'asukas', 'buyer': 'ostaja', 'spokesman': 'puhemies', 'governor': 'kuvernööri', 'guard': 'vartija', 'creature': 'olento', 'coach': 'valmentaja', 'producer': 'tuottaja', 'researcher': 'tutkija',
    'guy': 'kaveri', 'dealer': 'kauppias', 'duke': 'herttua', 'tourist': 'turisti', 'landlord': 'isäntä', 'human': 'ihminen', 'host': 'isäntä', 'priest': 'pappi', 'journalist': 'journalisti', 'poet': 'runoilija'
}

inanimate_nouns_translate_fin = {
    'cake': 'kakku', 'donut': 'donitsi', 'cookie': 'keksi', 'box': 'laatikko', 'rose': 'ruusu', 'drink': 'juoma', 'raisin': 'rusina', 'melon': 'meloni', 'sandwich': 'voileipä', 'strawberry': 'mansikka',
    'ball': 'pallo', 'balloon': 'ilmapallo', 'bat': 'maila', 'block': 'palikka', 'book': 'kirja', 'crayon': 'väreliitu', 'chalk': 'liitu', 'doll': 'nukke', 'game': 'peli', 'glue': 'liima',
    'lollipop': 'tikkari', 'hamburger': 'hampurilainen', 'banana': 'banaani', 'biscuit': 'keksi', 'muffin': 'muffinssi', 'pancake': 'pannukakku', 'pizza': 'pizza', 'potato': 'peruna', 'pretzel': 'rinkeli', 'pumpkin': 'kurpitsa',
    'sweetcorn': 'maissi', 'yogurt': 'jogurtti', 'pickle': 'suolakurkku', 'jigsaw': 'palapeli', 'pen': 'kynä', 'pencil': 'lyijykynä', 'present': 'lahja', 'toy': 'lelu', 'cracker': 'suolakeksi', 'brush': 'harja',
    'radio': 'radio', 'cloud': 'pilvi', 'mandarin': 'mandariini', 'hat': 'hattu', 'basket': 'kori', 'plant': 'kasvi', 'flower': 'kukka', 'chair': 'tuoli', 'spoon': 'lusikka', 'pillow': 'tyyny',
    'gumball': 'purukumi', 'scarf': 'huivi', 'shoe': 'kenkä', 'jacket': 'takki', 'hammer': 'vasara', 'bucket': 'ämpäri', 'knife': 'veitsi', 'cup': 'kuppi', 'plate': 'lautanen', 'towel': 'pyyhe',
    'bottle': 'pullo', 'bowl': 'kulho', 'can': 'tölkki', 'clock': 'kello', 'jar': 'purkki', 'penny': 'penni', 'purse': 'käsilaukku', 'soap': 'saippua', 'toothbrush': 'hammasharja', 'watch': 'rannekello',
    'newspaper': 'sanomalehti', 'fig': 'viikuna', 'bag': 'kassi', 'wine': 'viini', 'key': 'avain', 'weapon': 'ase', 'brain': 'aivot', 'tool': 'työkalu', 'crown': 'kruunu', 'ring': 'sormus',
    'leaf': 'lehti', 'fruit': 'hedelmä', 'mirror': 'peili', 'beer': 'olut', 'shirt': 'paita', 'guitar': 'kitara', 'chemical': 'kemikaali', 'seed': 'siemen', 'shell': 'kuori', 'brick': 'tiili',
    'bell': 'kello', 'coin': 'kolikko', 'button': 'nappi', 'needle': 'neula', 'molecule': 'molekyyli', 'crystal': 'kristalli', 'flag': 'lippu', 'nail': 'naula', 'bean': 'papu', 'liver': 'maksa'
}

on_nouns_translate_fin = {
    'table': 'pöytä', 'stage': 'lava', 'bed': 'sänky', 'chair': 'tuoli', 'stool': 'jakkara', 'road': 'tie', 'tree': 'puu', 'box': 'laatikko', 'surface': 'pinta', 'seat': 'istuin',
    'speaker': 'kaiutin', 'computer': 'tietokone', 'rock': 'kivi', 'boat': 'vene', 'cabinet': 'komero', 'TV': 'TV', 'plate': 'lautanen', 'desk': 'työpöytä', 'bowl': 'kulho', 'bench': 'penkki',
    'shelf': 'hylly', 'cloth': 'kangas', 'piano': 'piano', 'bible': 'raamattu', 'leaflet': 'esite', 'sheet': 'arkki', 'cupboard': 'kaappi', 'truck': 'kuorma-auto', 'tray': 'tarjotin', 'notebook': 'vihko',
    'blanket': 'peitto', 'deck': 'kansi', 'coffin': 'arkku', 'log': 'pölkky', 'ladder': 'tikkaat', 'barrel': 'tynnyri', 'rug': 'matto', 'canvas': 'kanvaasi', 'tiger': 'tiikeri', 'towel': 'pyyhe',
    'throne': 'valtaistuin', 'booklet': 'vihkonen', 'sock': 'sukka', 'corpse': 'ruumis', 'sofa': 'sohva', 'keyboard': 'näppäimistö', 'book': 'kirja', 'pillow': 'tyyny', 'pad': 'alusta', 'train': 'juna',
    'couch': 'sohva', 'bike': 'pyörä', 'pedestal': 'koroke', 'platter': 'vati', 'paper': 'paperi', 'rack': 'teline', 'board': 'lauta', 'panel': 'paneeli', 'tripod': 'kolmijalka', 'branch': 'oksa',
    'machine': 'kone', 'floor': 'lattia', 'napkin': 'servetti', 'cookie': 'keksi', 'block': 'palikka', 'cot': 'heteka', 'device': 'laite', 'yacht': 'jahti', 'dog': 'koira', 'mattress': 'patja',
    'ball': 'pallo', 'stand': 'jalusta', 'stack': 'pino', 'windowsill': 'ikkunalauta', 'counter': 'tiski', 'cushion': 'pehmuste', 'hanger': 'henkari', 'trampoline': 'trampoliini', 'gravel': 'sora', 'cake': 'kakku',
    'carpet': 'matto', 'plaque': 'plakaatti', 'boulder': 'lohkare', 'leaf': 'lehti', 'mound': 'kumpu', 'bun': 'pulla', 'dish': 'astia', 'cat': 'kissa', 'podium': 'palkintopalli', 'tabletop': 'pöytälevy',
    'beach': 'ranta', 'bag': 'kassi', 'glacier': 'jäätikkö', 'brick': 'tiili', 'crack': 'halkeama', 'vessel': 'alus', 'futon': 'futon', 'turntable': 'levysoitin', 'rag': 'rätti', 'chessboard': 'shakkilauta'
}

in_nouns_translate_fin = {
    'house': 'talo', 'room': 'huone', 'car': 'auto', 'garden': 'puutarha', 'box': 'laatikko', 'cup': 'kuppi', 'glass': 'lasi', 'bag': 'kassi', 'vehicle': 'ajoneuvo', 'hole': 'reikä',
    'cabinet': 'komero', 'bottle': 'pullo', 'shoe': 'kengät', 'storage': 'varasto', 'cot': 'heteka', 'vessel': 'alus', 'pot': 'pata', 'pit': 'kuoppa', 'tin': 'tina', 'can': 'purkki',
    'cupboard': 'kaappi', 'envelope': 'kirjekuori', 'nest': 'pesä', 'bush': 'pensaat', 'coffin': 'arkku', 'drawer': 'pöytälaatikko', 'container': 'säiliö', 'basin': 'lavuaari', 'tent': 'teltta', 'soup': 'keitto',
    'well': 'kaivo', 'barrel': 'tynnyri', 'bucket': 'ämpäri', 'cage': 'häkki', 'sink': 'allas', 'cylinder': 'sylinteri', 'parcel': 'paketti', 'cart': 'kärry', 'sack': 'säkki', 'trunk': 'takakontti',
    'wardrobe': 'vaatekaappi', 'basket': 'kori', 'bin': 'roskakori', 'fridge': 'jääkaappi', 'mug': 'muki', 'jar': 'purkki', 'corner': 'kulma', 'pool': 'uima-allas', 'blender': 'tehosekoitin', 'closet': 'kaappi',
    'pile': 'pino', 'van': 'pakettiauto', 'trailer': 'perävaunu', 'saucepan': 'kattila', 'truck': 'kuorma-auto', 'taxi': 'taksi', 'haystack': 'heinäseiväs', 'dumpster': 'roskalaatikko', 'puddle': 'lätäkkö', 'bathtub': 'kylpyamme',
    'pod': 'palko', 'tub': 'tynnyri', 'trap': 'ansa', 'bun': 'pulla', 'microwave': 'mikroaaltouuni', 'bookstore': 'kirjakauppa', 'package': 'paketti', 'cafe': 'kahvila', 'train': 'juna', 'castle': 'linna',
    'bunker': 'bunkkeri', 'vase': 'maljakko', 'backpack': 'reppu', 'tube': 'putki', 'hammock': 'riippumatto', 'stadium': 'stadion', 'backyard': 'takapiha', 'swamp': 'suo', 'monastery': 'luostari', 'refrigerator': 'jääkaappi',
    'palace': 'palatsi', 'cubicle': 'työhuone', 'crib': 'lastensänky', 'condo': 'kerrostalo', 'tower': 'torni', 'crate': 'kuljetuslaatikko', 'dungeon': 'selli', 'teapot': 'teekannu', 'tomb': 'hautakammio', 'casket': 'arkku',
    'jeep': 'jeeppi', 'shoebox': 'kenkälaatikko', 'wagon': 'vaunu', 'bakery': 'leipomo', 'fishbowl': 'akvaario', 'kennel': 'koirankoppi', 'china': 'posliini', 'spaceship': 'avaruusalus', 'penthouse': 'kattohuoneisto', 'pyramid': 'pyramidi'
}

beside_nouns_translate_fin = {
    'table': 'pöytä', 'stage': 'lava', 'bed': 'sänky', 'chair': 'tuoli', 'book': 'kirja', 'road': 'tie', 'tree': 'puu', 'machine': 'kone', 'house': 'talo', 'seat': 'istuin',
    'speaker': 'kaiutin', 'computer': 'tietokone', 'rock': 'kivi', 'car': 'auto', 'box': 'laatikko', 'cup': 'kuppi', 'glass': 'lasi', 'bag': 'kassi', 'flower': 'kukka', 'boat': 'vene',
    'vehicle': 'ajoneuvo', 'key': 'avain', 'painting': 'maalaus', 'cabinet': 'kaappi', 'TV': 'televisio', 'bottle': 'pullo', 'cat': 'kissa', 'desk': 'pöytä', 'shoe': 'kengät', 'mirror': 'peili',
    'clock': 'kello', 'bench': 'penkki', 'bike': 'pyörä', 'lamp': 'lamppu', 'lion': 'leijona', 'piano': 'piano', 'crystal': 'kristalli', 'toy': 'lelu', 'duck': 'ankka', 'sword': 'miekka',
    'sculpture': 'veistos', 'rod': 'varsi', 'truck': 'kuorma-auto', 'basket': 'kori', 'bear': 'karhu', 'nest': 'pesä', 'sphere': 'pallo', 'bush': 'pensaat', 'surgeon': 'kirurgi', 'poster': 'juliste',
    'throne': 'valtaistuin', 'giant': 'jättiläinen', 'trophy': 'palkinto', 'hedge': 'aita', 'log': 'pölkky', 'tent': 'teltta', 'ladder': 'tikkaat', 'helicopter': 'helikopteri', 'barrel': 'tynnyri', 'yacht': 'jahti',
    'statue': 'patsas', 'bucket': 'ämpäri', 'skull': 'kallo', 'beast': 'peto', 'lemon': 'sitruuna', 'whale': 'valas', 'cage': 'häkki', 'gardner': 'puutarhuri', 'fox': 'kettu', 'sink': 'allas',
    'trainee': 'harjoittelija', 'dragon': 'lohikäärme', 'cylinder': 'sylinteri', 'monk': 'munkki', 'bat': 'lepakkopuku', 'headmaster': 'rehtori', 'philosopher': 'filosofi', 'foreigner': 'ulkomaalainen', 'worm': 'madot', 'chemist': 'kemisti',
    'corpse': 'ruumis', 'wolf': 'susi', 'torch': 'soihtu', 'sailor': 'merimies', 'valve': 'venttiili', 'hammer': 'vasara', 'doll': 'nukke', 'genius': 'nero', 'baron': 'baroni', 'murderer': 'murhaaja',
    'bicycle': 'polkupyörä', 'keyboard': 'näppäimistö', 'stool': 'jakkara', 'pepper': 'pippuri', 'warrior': 'soturi', 'pillar': 'pylväs', 'monkey': 'apina', 'cassette': 'kasetti', 'broker': 'välittäjä', 'bin': 'roskakori'
}


verbs_translate_fin = { 
  'syödä':'eat', 'maalata':'paint', 'piirtää':'draw', 'puhdistaa':'clean',
  'kokata':'cook', 'pölyttää':'dust', 'metsästää':'hunt', 'hoivata':'nurse',
  'luonnostella':'sketch', 'pestä':'wash', 'jonglöörata':'juggle', 'kutsua':'call',
  'piirtää':'draw', 'leipoa':'bake', 'tykätä':'like', 'tietää':'know',
  'auttaa':'help', 'nähdä':'see', 'löytää':'find', 'kuulla':'hear', 'huomata':'notice',
  'rakastaa':'love', 'ihailla':'admire', 'palvoa':'adore', 'arvostaa':'appreciate',
  'kaivata':'miss', 'kunnioittaa':'respect', 'sietää':'tolerate', 'arvostaa':'value',
  'palvoa':'worship', 'havainnoida':'observe', 'löytää':'discover', 'pitää':'hold',
  'pistää':'stab', 'koskettaa':'touch', 'lävistää':'pierce', 'tönäistä':'poke',
  'tietää':'know', 'nähdä':'see', 'lyödä':'hit', 'toivoa':'hope', 'sanoa':'say',
  'uskoa':'believe', 'myöntää':'confess', 'julistaa':'declare', 'todistaa':'prove',
  'ajatella':'think', 'tukea':'support', 'toivoa':'wish', 'unelmoida':'dream',
  'odottaa':'expect', 'kuvitella':'imagine', 'kadehtia':'envy', 'haluta':'want',
  'suosia':'prefer', 'tarvita':'need', 'aikoa':'intend', 'yrittää':'try',
  'yrittää':'attempt', 'suunnitella':'plan','himota':'crave','vihata':'hate',
  'nauttia':'enjoy', 'kääriä':'roll', 'jäätyä':'freeze', 'jäädyttää':'freeze', 'palaa':'burn',
  'polttaa':'burn', 'lyhentää':'shorten',
  'leijua':'float', 'kasvaa':'grow', 'liukua':'slide', 'särkeä':'break', 'sortua':'crumple',
#   'split':'split', 'muuttua':'change', 'snapped':'snap', 'tore':'tear', 'collapsed':'collapse',
#   'decomposed':'decompose', 'doubled':'double', 'improved':'improve', 'inflated':'inflate',
#   'enlarged':'enlarge', 'reddened':'redden', 'popped':'pop', 'disintegrated':'disintegrate',
#   'expanded':'expand', 'cooled':'cool', 'soaked':'soak', 'frozen':'freeze', 'grown':'grow',
#   'broken':'break', 'torn':'tear', 'slept':'sleep', 'smiled':'smile', 'laughed':'laugh',
#   'sneezed':'sneeze', 'cried':'cry', 'talked':'talk', 'danced':'dance', 'jogged':'jog',
#   'walked':'walk', 'ran':'run', 'napped':'nap', 'snoozed':'snooze', 'screamed':'scream',
#   'stuttered':'stutter', 'frowned':'frown', 'giggled':'giggle', 'scoffed':'scoff',
#   'snored':'snore', 'snorted':'snort', 'smirked':'smirk', 'gasped':'gasp',
#   'gave':'give', 'lent':'lend', 'sold':'sell', 'offered':'offer', 'fed':'feed', 
#   'passed':'pass', 'rented':'rent', 'served':'serve','awarded':'award', 'promised':'promise',
#   'brought':'bring', 'sent':'send', 'handed':'hand', 'forwarded':'forward', 'mailed':'mail',
#   'posted':'post','given':'give', 'shipped':'ship', 'packed':'pack', 'studied':'study', 
#   'examined':'examine', 'investigated':'investigate', 'thrown':'throw', 'threw':'throw',
#   'tossed':'toss', 'meant':'mean', 'longed':'long', 'yearned':'yearn', 'itched':'itch',
#   'loaned':'loan', 'returned':'return', 'slipped':'slip', 'wired':'wire', 'crawled':'crawl',
#   'shattered':'shatter', 'bought':'buy', 'squeezed':'squeeze', 'teleported':'teleport',
#   'melted':'melt', 'blessed':'bless'
}

V_unacc_translate_fin = {
  'roll': 'kieriä', 'freeze': 'jäätyä', 'burn': 'palaa', 'shorten': 'lyhentyä', 'float': 'leijua', 
  'grow': 'kasvaa', 'slide': 'liukua', 'break': 'särkeä', 'crumple': 'sortua', 'split': 'haljeta', 
  'change': 'muuttua', 'snap': 'katketa', 'disintegrate': 'hajota', 'collapse': 'romahtaa', 'decompose': 'maatua',
  'double': 'kaksinkertaistua', 'improve': 'parantua', 'inflate': 'laajentua', 'enlarge': 'suurentua', 'redden': 'punehtua', 
}
V_unacc_as_unerg_translate_fin = {
  'roll': 'kääriä', 'freeze': 'jäätyä', 'burn': 'palaa', 'shorten': 'lyhentyä', 'float': 'leijua', 
  'grow': 'kasvaa', 'slide': 'liukua', 'break': 'särkeä', 'crumple': 'sortua', 'split': 'haljeta', 
  'change': 'muuttua', 'snap': 'katketa', 'disintegrate': 'hajota', 'collapse': 'romahtaa', 'decompose': 'maatua',
  'double': 'kaksinkertaistua', 'improve': 'parantua', 'inflate': 'laajentua', 'enlarge': 'suurentua', 'redden': 'punehtua', 
}
V_unerg_translate_fin = {
  'sleep': 'nukkua', 'smile': 'hymyillä', 'laugh': 'nauraa', 'sneeze': 'aivastaa', 'cry': 'itkeä', 
  'talk': 'puhua', 'dance': 'tanssia', 'jog': 'hölkätä', 'walk': 'kävellä', 'run': 'juosta', 
  'nap': 'torkkua', 'snooze': 'nukkua', 'scream': 'huutaa', 'stutter': 'änkyttää', 'frown': 'kurtistaa kulmakarvoja',
  'giggle': 'kikattaa', 'scoff': 'ivata', 'snore': 'kuorsata', 'smirk': 'virnistää', 'gasp': 'haukkoa henkeä'
}
