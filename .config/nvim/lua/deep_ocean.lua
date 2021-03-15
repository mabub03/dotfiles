--require("colorbuddy").setup()
local Color, colors, Group, groups, styles = require("colorbuddy").setup()

--vim.api.nvim_exec([[hi!clear]],true)

Color.new('bg', '#0f111a')
Color.new('fg', '#8f93a2')
Color.new('white', '#FFFFFF')
Color.new('black', '#000000')
Color.new('red', '#FF5370')
Color.new('green', '#C3E88D')
Color.new('yellow', '#FFCB6B')
Color.new('blue', '#82AAFF')
Color.new('cyan', '#89DDFF')
Color.new('purple','#C792EA')
Color.new('gray', '#464B5D')

--Group.new('Function', colors.blue, nil, s.bold)
Group.new('Function', colors.blue, colors.bg, styles.NONE)

