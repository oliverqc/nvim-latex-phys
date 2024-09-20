local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

-- Custom function to check if we're in a math zone in Markdown
local function in_mathzone()
	-- Get the content of the current line
	local line = vim.api.nvim_get_current_line()
	-- Get the cursor position
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))

	-- Check if we're inside inline math delimiters
	local in_inline = line:sub(1, col):match("%(?%$[^%$]*$") and line:sub(col + 1):match("^[^%$]*%$%)?")

	-- Check if we're inside display math delimiters
	local in_display = false
	if not in_inline then
		local prev_lines = vim.api.nvim_buf_get_lines(0, math.max(0, row - 10), row, false)
		local next_lines = vim.api.nvim_buf_get_lines(0, row, row + 10, false)
		local before_math = false
		local after_math = false
		for _, l in ipairs(prev_lines) do
			if l:match("^%s*%$%$") then
				before_math = true
				break
			end
		end
		for _, l in ipairs(next_lines) do
			if l:match("^%s*%$%$") then
				after_math = true
				break
			end
		end
		in_display = before_math and after_math
	end

	return in_inline or in_display
end
-- When adding snippets make sure to specify file type ie markdown
-- If you want to create a snippet that jumps locating use fmt
return {
	ls.add_snippets("markdown", {
		-- Math mode inline (works everywhere)
		s({ trig = "mk", snippetType = "autosnippet", regTrig = false }, fmt("${}$", { i(1) })),

		-- Math mode display (works everywhere)
		s({ trig = "dm", snippetType = "autosnippet", regTrig = false }, fmt("$$\n{}\n$$", { i(1) })),

		-- Alpha (only in math mode)
		s({ trig = "@a", snippetType = "autosnippet", regTrig = false }, { t("\\alpha") }, { condition = in_mathzone }),

		-- Beta (only in math mode)
		s({ trig = "@b", snippetType = "autosnippet", regTrig = false }, { t("\\beta") }, { condition = in_mathzone }),

		-- Fraction (only in math mode)
		s(
			{ trig = "frac", snippetType = "autosnippet", regTrig = false },
			fmt("\\frac{{{}}}{{{}}}", { i(1), i(2) }),
			{ condition = in_mathzone }
		),
		s({ trig = "@A", snippetType = "autosnippet", regTrig = false }, { t("\\Alpha") }, { condition = in_mathzone }),
		s(
			{ trig = "alpha", snippetType = "autosnippet", regTrig = false },
			{ t("\\alpha") },
			{ condition = in_mathzone }
		),
		s(
			{ trig = "beta", snippetType = "autosnippet", regTrig = false },
			{ t("\\beta") },
			{ condition = in_mathzone }
		),
		s(
			{ trig = "gamma", snippetType = "autosnippet", regTrig = false },
			{ t("\\gamma") },
			{ condition = in_mathzone }
		),
		s({ trig = "@B", snippetType = "autosnippet", regTrig = false }, { t("\\Beta") }, { condition = in_mathzone }),
		s({ trig = "@d", snippetType = "autosnippet", regTrig = false }, { t("\\delta") }, { condition = in_mathzone }),
		s({ trig = "@D", snippetType = "autosnippet", regTrig = false }, { t("\\Delta") }, { condition = in_mathzone }),
		s({ trig = "@c", snippetType = "autosnippet", regTrig = false }, { t("\\chi") }, { condition = in_mathzone }),
		s({ trig = "@C", snippetType = "autosnippet", regTrig = false }, { t("\\Chi") }, { condition = in_mathzone }),
		s({ trig = "@g", snippetType = "autosnippet", regTrig = false }, { t("\\gamma") }, { condition = in_mathzone }),
		s({ trig = "@G", snippetType = "autosnippet", regTrig = false }, { t("\\Gamma") }, { condition = in_mathzone }),
		s({ trig = "@p", snippetType = "autosnippet", regTrig = false }, { t("\\psi") }, { condition = in_mathzone }),
		s({ trig = "psi", snippetType = "autosnippet", regTrig = false }, { t("\\psi") }, { condition = in_mathzone }),
		s(
			{ trig = "omega", snippetType = "autosnippet", regTrig = false },
			{ t("\\omega") },
			{ condition = in_mathzone }
		),
		s(
			{ trig = "epsi", snippetType = "autosnippet", regTrig = false },
			{ t("\\espsilon") },
			{ condition = in_mathzone }
		),
		s(
			{ trig = "@e", snippetType = "autosnippet", regTrig = false },
			{ t("\\epsilon") },
			{ condition = in_mathzone }
		),
		s(
			{ trig = "@E", snippetType = "autosnippet", regTrig = false },
			{ t("\\Epsilon") },
			{ condition = in_mathzone }
		),
		s(
			{ trig = "hat", snippetType = "autosnippet", regTrig = false },
			fmt("\\hat{{{}}}", { i(1) }),
			{ condition = in_mathzone }
		),
		s(
			{ trig = "dot", snippetType = "autosnippet", regTrig = false },
			fmt("\\dot{{{}}}", { i(1) }),
			{ condition = in_mathzone }
		),
		s(
			{ trig = "bar", snippetType = "autosnippet", regTrig = false },
			fmt("\\bar{{{}}}", { i(1) }),
			{ condition = in_mathzone }
		),
		s(
			{ trig = "vec", snippetType = "autosnippet", regTrig = false },
			fmt("\\vec{{{}}}", { i(1) }),
			{ condition = in_mathzone }
		),
		s(
			{ trig = "tilde", snippetType = "autosnippet", regTrig = false },
			fmt("\\tilde{{{}}}", { i(1) }),
			{ condition = in_mathzone }
		),
		s(
			{ trig = "quad", snippetType = "autosnippet", regTrig = false },
			{ t("\\quad") },
			{ condition = in_mathzone }
		),
		s(
			{ trig = "te", snippetType = "autosnippet", regTrig = false },
			fmt("\\text{{{}}}", { i(1) }),
			{ condition = in_mathzone }
		),
		s({ trig = "sr", snippetType = "autosnippet", regTrig = false }, { t("^{2}") }, { condition = in_mathzone }),
		s(
			{ trig = "rd", snippetType = "autosnippet", regTrig = false },
			fmt("^{{{}}}", { i(1) }),
			{ condition = in_mathzone }
		),
		s({ trig = "cb", snippetType = "autosnippet", regTrig = false }, { t("^{3}") }, { condition = in_mathzone }),
		s(
			{ trig = "sq", snippetType = "autosnippet", regTrig = false },
			fmt("\\sqrt{{{}}}", { i(1) }),
			{ condition = in_mathzone }
		),
		s(
			{ trig = "ee", snippetType = "autosnippet", regTrig = false },
			fmt("e^{{{}}}", { i(1) }),
			{ condition = in_mathzone }
		),
		s({ trig = "conj", snippetType = "autosnippet", regTrig = false }, { t("^{*}") }, { condition = in_mathzone }),
		s({ trig = "det", snippetType = "autosnippet", regTrig = false }, { t("\\det") }, { condition = in_mathzone }),
		s(
			{ trig = "equiv", snippetType = "autosnippet", regTrig = false },
			{ t("\\equiv") },
			{ condition = in_mathzone }
		),
		s(
			{ trig = "approx", snippetType = "autosnippet", regTrig = false },
			{ t("\\approx") },
			{ condition = in_mathzone }
		),
		s(
			{ trig = "times", snippetType = "autosnippet", regTrig = false },
			{ t("\\times") },
			{ condition = in_mathzone }
		),
		s(
			{ trig = "rang", snippetType = "autosnippet", regTrig = false },
			{ t("\\rangle") },
			{ condition = in_mathzone }
		),
		s(
			{ trig = "lang", snippetType = "autosnippet", regTrig = false },
			{ t("\\langle") },
			{ condition = in_mathzone }
		),
		s(
			{ trig = "ddot", snippetType = "autosnippet", regTrig = false },
			{ t("\\ddot") },
			{ condition = in_mathzone }
		),
		s(
			{ trig = "cdot", snippetType = "autosnippet", regTrig = false },
			{ t("\\cdot") },
			{ condition = in_mathzone }
		),
		s(
			{ trig = "sum", snippetType = "autosnippet", regTrig = false },
			fmt("\\sum_{{{}}}^{{{}}}", { i(1), i(2) }),
			{ condition = in_mathzone }
		),
		s(
			{ trig = "prod", snippetType = "autosnippet", regTrig = false },
			{ t("\\prod") },
			{ condition = in_mathzone }
		),
		s(
			{ trig = "lim", snippetType = "autosnippet", regTrig = false },
			fmt("\\lim_{{{}}}^{{{}}}", { i(1), i(2) }),
			{ condition = in_mathzone }
		),
		s(
			{ trig = "_", snippetType = "autosnippet", regTrig = false },
			fmt("_{{{}}}", { i(1) }),
			{ condition = in_mathzone }
		),
		s(
			{ trig = "nabl", snippetType = "autosnippet", regTrig = false },
			{ t("\\nabla") },
			{ condition = in_mathzone }
		),
		s(
			{ trig = "del", snippetType = "autosnippet", regTrig = false },
			{ t("\\nabla") },
			{ condition = in_mathzone }
		),
		s(
			{ trig = "mcal", snippetType = "autosnippet", regTrig = false },
			fmt("\\mathcal{{{}}}", { i(1) }),
			{ condition = in_mathzone }
		),
		s(
			{ trig = "par", snippetType = "autosnippet", regTrig = false },
			{ t("\\partial") },
			{ condition = in_mathzone }
		),
		s({ trig = "int", snippetType = "autosnippet", regTrig = false }, { t("\\int") }, { condition = in_mathzone }),
		s(
			{ trig = "iint", snippetType = "autosnippet", regTrig = false },
			{ t("\\iint") },
			{ condition = in_mathzone }
		),
		s(
			{ trig = "oint", snippetType = "autosnippet", regTrig = false },
			{ t("\\oint") },
			{ condition = in_mathzone }
		),
		s({ trig = "hba", snippetType = "autosnippet", regTrig = false }, { t("\\hbar") }, { condition = in_mathzone }),
		s(
			{ trig = "bra", snippetType = "autosnippet", regTrig = false },
			fmt("\\bra{{{}}}", { i(1) }),
			{ condition = in_mathzone }
		),
		s(
			{ trig = "ket", snippetType = "autosnippet", regTrig = false },
			fmt("\\ket{{{}}}", { i(1) }),
			{ condition = in_mathzone }
		),
		s(
			{ trig = "brk", snippetType = "autosnippet", regTrig = false },
			fmt("\\braket{{{} | {}}}", { i(1), i(2) }),
			{ condition = in_mathzone }
		),
		s(
			{ trig = "pa2", snippetType = "autosnippet" },
			{ t("\\frac{ \\partial^{2} "), i(1, "y"), t(" }{ \\partial "), i(2, "x"), t("^{2} } "), i(3) }
		),
		s(
			{ trig = "pa1", snippetType = "autosnippet" },
			{ t("\\frac{ \\partial "), i(1, "y"), t(" }{ \\partial "), i(2, "x"), t(" } "), i(3) }
		),
	}),
}
