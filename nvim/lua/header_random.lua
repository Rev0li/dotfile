-- ════════════════════════════════════════
-- 🎨 header_random.lua : Un seul emoji centré + phrase stylée
-- ════════════════════════════════════════
local utils = require("utils")
local M = {}

local emojis = {
  chill = {
    "(｡♥‿♥｡)", "(づ｡◕‿‿◕｡)づ", "(っ◔◡◔)っ", "(◕‿◕✿)",
    "(✿◠‿◠)", "(⌒‿⌒)", "(∩^o^)⊃━☆", "(˘︶˘).｡*♡", "(｡•̀ᴗ-)✧",
    "( ^_^)／", "(￣▽￣)ノ", "(ﾉ◕ヮ◕)ﾉ*:･ﾟ✧",
  },
  hacker = {
    "(⌐■_■)", "(▀̿Ĺ̯▀̿ ̿)", "(ง ͠° ͟ل͜ ͡°)ง", "༼ つ ◕_◕ ༽つ",
    "(¬‿¬)", "(° ͜ʖ °)", "(╯°□°）╯︵ ┻━┻", "( ͡° ͜ʖ ͡°)",
    "ᕙ(⇀‸↼‶)ᕗ", "(☞ ͡° ͜ʖ ͡°)☞", "(ง'̀-'́)ง",
  },
  troll = {
    "(ಥ﹏ಥ)", "(ノಠ益ಠ)ノ彡┻━┻", "(¬_¬\")", "(ಠ_ಠ)", "(☞ﾟ∀ﾟ)☞",
    "(ಠ‿ಠ)", "(ノ-_-)ノ~┻━┻", "( ͡° ʖ̯ ͡°)", "(╬ ಠ益ಠ)", "(°ロ°)☝",
    "(ಠ‿ಠ)つ──☆*:・ﾟ",
  },
  motivation = {
    "ʕ•̀ω•́ʔ✧", "(ง •̀_•́)ง", "(๑•̀ㅂ•́)و✧", "ᕦ(ò_óˇ)ᕤ", "(•̀ᴗ•́)و ̑̑",
    "(งツ)ว", "(ﾉಥ益ಥ）ﾉ", "o(｀・ω・´)○", "＼（〇_ｏ）／", "( ͡°益 ͡°)",
  },
  cute = {
    "(=^･ω･^=)", "(＾• ω •＾)", "(｡•́‿•̀｡)", "(•ө•)♡", "(=^･ｪ･^=)",
    "(≧◡≦)", "(ʘ‿ʘ)", "(・⊝・)", "(・`ω´・)", "(❍ᴥ❍ʋ)",
  },
  ai = {
    "[◕‿◕✿]", "( •_•)>⌐■-■", "(⌐■_■)",
    "( ⚆ _ ⚆ )", "{•̃_•̃}",
  },
  weird = {
    "¯\\_(ツ)_/¯", "(ノ・∀・)ノ", "乁( •_• )ㄏ", "ヽ(´▽｀)ノ", "(＠_＠;)",
    "(」°ロ°)」", "(ʘᗩʘ’)", "(☞ﾟヮﾟ)☞", "ヽ༼ຈل͜ຈ༽ﾉ", "ಠಿ_ಠ",
  },
}

local phrases = {
  "👾 In case of fire: git commit, git push, leave building.",
  "🐛 It's not a bug, it's a feature... you haven't understood yet.",
  "💾 Save early, save often. Then save again.",
  "🔥 rm -rf / --force is a valid emotional response.",
  "🎉 Works on my machine™.",
  "⛓️ Semicolons are just decoration. Right?",
  "🌐 localhost is where the heart is.",
  "🧠 AI is just autocomplete with an attitude.",
  "📎 It looks like you're writing code. Need help?",
  "🎭 Tabs vs Spaces: the eternal war.",
  "💤 Debugging: like being the detective in a crime movie where you're also the murderer.",
  "🤡 Commit message: 'final_final_FINAL_really_final2.c'",
  "☠️ Never underestimate the power of a forgotten semicolon.",
  "❤️ 🔥 Coding is love. Coding is pain.",
  "💀 Segfault? More like lifefault.",
  "🎩 I don't always test my code, but when I do, it's in production.",
  "🔮 The compiler giveth, the runtime taketh away.",
  "🥲 No one: ... Me: `:wq` and `:q!` in alternance for 10min",
  "📀 42 reasons why your code compiles but still fails.",
  "🗿 Neovim is not a text editor. It’s a lifestyle.",
  "💔 Your crush doesn’t use Neovim.",
  "🌙 Night owl certified dev.",
  "🚪 One does not simply quit Vim.",
  "💘 :wq is my love language.",

}

function M.generate()
  math.randomseed(os.time())
  local keys = {}
  for k, _ in pairs(emojis) do table.insert(keys, k) end

  -- Sélection aléatoire d’un emoji et d’une phrase
  local key = keys[math.random(#keys)]
  local emoji = emojis[key][math.random(#emojis[key])]
  local phrase = phrases[math.random(#phrases)]

  return {
    "",
  utils.center_text(emoji),
    "",
  utils.center_text(phrase),
  }
end

return M
