local wezterm = require("wezterm")

local custom = wezterm.color.get_builtin_schemes()["nordfox"]
custom.background = "hsl(237, 11%, 16%)"
custom.cursor_bg = "hsl(115, 94%, 72%)"
custom.ansi = {
	"#3b4252",
	"#bf616a",
	"#a3be8c",
	"#ebcb8b",
	"#81a1c1",
	"hsl(267, 78%, 82%)",
	"#88c0d0",
	"#e5e9f0",
}

local TAB_BAR_BG = custom.tab_bar.background
local ACTIVE_TAB_BG = "hsl(267, 78%, 82%)"
local ACTIVE_TAB_FG = "Black"
local HOVER_TAB_BG = "hsl(230, 14%, 41%)"
local HOVER_TAB_FG = "hsl(0, 59%, 88%)"
local NORMAL_TAB_BG = "hsl(240, 21%, 12%)"
local NORMAL_TAB_FG = "hsl(332, 65%, 77%)"

local HALF_BLOCK_SLANTED = ""
local SOLID_RIGHT_ARROW = ""
-- local SOLID_RIGHT_ARROW = "a"

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	panes = panes
	config = config
	max_width = max_width
	print(tab.active_pane.foreground_process_name)
	local background = NORMAL_TAB_BG
	local foreground = NORMAL_TAB_FG

	if tab.is_active then
		background = ACTIVE_TAB_BG
		foreground = ACTIVE_TAB_FG
	elseif hover then
		background = HOVER_TAB_BG
		foreground = HOVER_TAB_FG
	end

	local leading_fg = NORMAL_TAB_FG
	local leading_bg = background

	local trailing_fg = background
	local trailing_bg = NORMAL_TAB_BG
	local trailing_sb = HALF_BLOCK_SLANTED

	if tab.tab_index == 0 and tab.is_active then
		leading_fg = ACTIVE_TAB_BG
	else
		leading_fg = NORMAL_TAB_BG
	end

	if tab.tab_index == #tabs - 1 then
		trailing_sb = SOLID_RIGHT_ARROW .. (tab.is_active and "" or "")
		trailing_bg = TAB_BAR_BG
	end

	local sub_idx = utf8.char(0x2080 + ((tab.tab_index + 1) % 10))

	local proc_icons = {
		["nvim"] = "e",
	}

	local target_width = max_width
	if #tabs > 4 then
		target_width = tab.is_active and max_width or 8
	end

	local text = wezterm.truncate_right(tab.active_pane.title, target_width - 4 - utf8.len(trailing_sb))
	local title = " " .. text .. " "

	return {
		{ Attribute = { Italic = false } },
		{ Attribute = { Intensity = hover and "Bold" or "Normal" } },
		{ Background = { Color = leading_bg } },
		{ Foreground = { Color = leading_fg } },
		{ Text = HALF_BLOCK_SLANTED },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = sub_idx },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = trailing_bg } },
		{ Foreground = { Color = trailing_fg } },
		{ Text = trailing_sb },
	}
end)

return {
	--font = wezterm.font("ComicCode Nerd Font"),
	font = wezterm.font("ComicCode Nerd Font Mono"),
	font_size = 12.0,
	-- line_height = 0.9,
	color_schemes = { ["custom"] = custom },
	color_scheme = "custom",

	initial_cols = 128,
	initial_rows = 28,

	use_fancy_tab_bar = false,
	show_new_tab_button_in_tab_bar = false,
	tab_bar_at_bottom = true,
	tab_max_width = 30,

	default_cursor_style = "BlinkingUnderline",
	cursor_blink_rate = 360,
	underline_thickness = "1pt",

	keys = {
		{
			key = "E",
			mods = "CTRL",
			action = wezterm.action_callback(function(window, pane)
				local ansi = window:get_selection_escapes_for_pane(pane)
				window:copy_to_clipboard(ansi)
			end),
		},
	},
}
