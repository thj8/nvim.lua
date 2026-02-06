return {
	"kdheepak/lazygit.nvim",
	lazy = true,
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	-- 可选，用于浮动窗口边框装饰
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	-- 建议使用 'keys' 设置 LazyGit 的键位映射
	-- 以便在第一次运行命令时加载插件
	keys = {
		{ "<C-g>", "<cmd>LazyGit<cr>", desc = "LazyGit" }
	}
}
