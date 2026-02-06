return {
	"JuanZoran/Trans.nvim",
	build = function() require 'Trans'.install() end,
	keys = {
		{ 'mm', mode = { 'n', 'x' }, '<Cmd>Translate<CR>', desc = '󰊿 翻译' },
		{ 'mk', mode = { 'n', 'x' }, '<Cmd>TransPlay<CR>', desc = ' 自动播放' },
		{ 'mi', '<Cmd>TranslateInput<CR>', desc = '󰊿 从输入翻译' },
	},
	dependencies = { 'kkharji/sqlite.lua', },
	opts = {
	}
}
