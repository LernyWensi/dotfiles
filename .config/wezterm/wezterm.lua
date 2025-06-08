local wezterm = require('wezterm')
local config = wezterm.config_builder()

-- Environment
config.default_domain = 'WSL:Ubuntu'

-- Bells
config.audible_bell = "Disabled"

config.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 150,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 150,
}

-- Front-end
config.front_end = 'WebGpu'
webgpu_power_preference = 'HighPerformance'

config.max_fps = 144
config.animation_fps = 144

-- Theme
config.colors = require("themes.ornament")

-- Font
config.font = wezterm.font_with_fallback {
    { family = 'Iosevka Term', harfbuzz_features = { 'calt=1' }, weight = 'Regular' } ,
    { family = 'Symbols Nerd Font Mono', scale = 0.7 },
}

config.font_size = 16
config.line_height = 1

config.underline_thickness = 2
config.underline_position = -4

config.command_palette_font = wezterm.font('Iosevka Term')
config.command_palette_font_size = 16

-- Window
config.window_decorations = 'RESIZE'
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

-- Bar
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false
config.tab_max_width = 500

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    return {
        { Foreground = { Color = '#a88aa6' } },
        { Text = ' ' .. (tab.tab_index + 1) },

        { Foreground = { Color = '#b5b2b0' } },
        { Text = ':' },

        'ResetAttributes',
        { Text = (tab.tab_title == '' and 'tab' or tab.tab_title) .. ' ' },
    }
end)

wezterm.on('update-right-status', function(window, pane)
    window:set_right_status(wezterm.format {
        { Foreground = { Color = '#a88aa6' } },
        { Text = window:active_workspace() },

        'ResetAttributes',
        { Text = ' :: ' },

        { Foreground = { Color = '#a8968a' } },
        { Text = wezterm.strftime '%H:%M:%S'  },

        'ResetAttributes',
        { Text = ' :: ' },

        { Foreground = { Color = '#a8968a' } },
        { Text = wezterm.strftime '%A,%e %B, %Y '  },
    })
end)

-- Pane
config.inactive_pane_hsb = { saturation = 1, brightness = 0.7 }

-- Cursor
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_ease_in = 'EaseOut'
config.cursor_blink_ease_out = 'EaseOut'

-- Keybindigs
config.disable_default_key_bindings = true
config.leader = { key = 'Space', mods = 'CTRL' }
config.keys = {
    -- Debug
    { key = 'l', mods = 'LEADER', action = wezterm.action.ShowDebugOverlay },

    -- Launcher
    { key = 'Space', mods = 'LEADER', action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|DOMAINS|COMMANDS' , fuzzy_help_text = '> ' } },

    -- Workspace
    { key = 'w', mods = 'LEADER', action = wezterm.action.ShowLauncherArgs { flags = 'WORKSPACES', help_text = 'Select a workspace' } },

    { key = 'w', mods = 'LEADER|SHIFT', action = wezterm.action.PromptInputLine {
            description = 'Enter name for new workspace',
            action = wezterm.action_callback(function(window, pane, line)
                if line then
                    window:perform_action(wezterm.action.SwitchToWorkspace { name = line }, pane)
                end
            end),
        },
    },

    { key = 'r', mods = 'LEADER|SHIFT', action = wezterm.action.PromptInputLine {
            description = 'Enter new name for workspace',
            action = wezterm.action_callback(function(window, pane, line)
                if line then
                    wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
                end
            end),
        },
    },

    -- Modes
    { key = 'f', mods = 'LEADER', action = wezterm.action.Search 'CurrentSelectionOrEmptyString' },
    { key = 'c', mods = 'LEADER', action = wezterm.action.ActivateCopyMode },

    -- Selections
    { key = 'g', mods = 'LEADER', action = wezterm.action.QuickSelect },
    { key = 'u', mods = 'LEADER', action = wezterm.action.QuickSelectArgs {
            label = 'Open URL',
            patterns = { 'https?://\\S+' },
            skip_action_on_paste = true,
            action = wezterm.action_callback(function(window, pane)
                local url = window:get_selection_text_for_pane(pane)
                wezterm.open_with(url)
            end),
        },
    },

    -- Window
    { key = 'Enter', mods = 'ALT', action = wezterm.action.ToggleFullScreen },

    { key = '0', mods = 'CTRL', action = wezterm.action.ResetFontSize },
    { key = '=', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
    { key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },

    -- Tab
    { key = 't', mods = 'LEADER', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
    { key = 'q', mods = 'LEADER|SHIFT', action = wezterm.action.CloseCurrentTab { confirm = true } },

    { key = '[', mods = 'ALT', action = wezterm.action.MoveTabRelative(-1) },
    { key = ']', mods = 'ALT', action = wezterm.action.MoveTabRelative(1) },

    { key = 'n', mods = 'LEADER', action = wezterm.action.ShowTabNavigator },
    { key = 'a', mods = 'ALT', action = wezterm.action.ActivateLastTab },

    { key = 'PageUp', mods = 'ALT', action = wezterm.action.ActivateTabRelativeNoWrap(-1) },
    { key = 'PageDown', mods = 'ALT', action = wezterm.action.ActivateTabRelativeNoWrap(1) },

    { key = '1', mods = 'ALT', action = wezterm.action.ActivateTab(0) },
    { key = '2', mods = 'ALT', action = wezterm.action.ActivateTab(1) },
    { key = '3', mods = 'ALT', action = wezterm.action.ActivateTab(2) },
    { key = '4', mods = 'ALT', action = wezterm.action.ActivateTab(3) },
    { key = '5', mods = 'ALT', action = wezterm.action.ActivateTab(4) },
    { key = '6', mods = 'ALT', action = wezterm.action.ActivateTab(5) },
    { key = '7', mods = 'ALT', action = wezterm.action.ActivateTab(6) },
    { key = '8', mods = 'ALT', action = wezterm.action.ActivateTab(7) },
    { key = '9', mods = 'ALT', action = wezterm.action.ActivateTab(8) },

    { key = 'r', mods = 'LEADER', action = wezterm.action.PromptInputLine {
            description = 'Enter new name for tab',
            action = wezterm.action_callback(function(window, pane, line)
                if line then
                    window:active_tab():set_title(line)
                end
            end),
        },
    },

    -- Pane
    { key = 's', mods = 'LEADER', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 'v', mods = 'LEADER', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = 'q', mods = 'LEADER', action = wezterm.action.CloseCurrentPane { confirm = false } },

    { key = 'z', mods = 'ALT', action = wezterm.action.TogglePaneZoomState },
    { key = 'b', mods = 'LEADER', action = wezterm.action.PaneSelect { mode = 'MoveToNewTab' } },
    { key = '/', mods = 'LEADER', action = wezterm.action.RotatePanes 'Clockwise' },

    { key = '\'', mods = 'ALT', action = wezterm.action_callback(function(_, pane)
            local tab = pane:tab()
            local panes = tab:panes_with_info()
            if #panes == 1 then
                pane:split { direction = 'Bottom', top_level = true }
            elseif not panes[1].is_zoomed then
                panes[1].pane:activate()
                tab:set_zoomed(true)
            elseif panes[1].is_zoomed then
                tab:set_zoomed(false)
                panes[2].pane:activate()
            end
        end),
    },

    { key = 'j', mods = 'LEADER', action = wezterm.action.PaneSelect },
    { key = 'j', mods = 'LEADER|SHIFT', action = wezterm.action.PaneSelect { mode = 'SwapWithActive' } },

    { key = 'LeftArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Left' },
    { key = 'RightArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Right' },
    { key = 'UpArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Up' },
    { key = 'DownArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Down' },

    { key = 'LeftArrow', mods = 'ALT|CTRL', action = wezterm.action.AdjustPaneSize { 'Left', 3 } },
    { key = 'RightArrow', mods = 'ALT|CTRL', action = wezterm.action.AdjustPaneSize { 'Right', 3 } },
    { key = 'DownArrow', mods = 'ALT|CTRL', action = wezterm.action.AdjustPaneSize { 'Down', 3 } },
    { key = 'UpArrow', mods = 'ALT|CTRL', action = wezterm.action.AdjustPaneSize { 'Up', 3 } },

    -- Scroll
    { key = 'UpArrow', mods = 'SHIFT', action = wezterm.action.ScrollByLine(-1) },
    { key = 'DownArrow', mods = 'SHIFT', action = wezterm.action.ScrollByLine(1) },

    { key = 'PageUp', mods = 'SHIFT', action = wezterm.action.ScrollByPage(-0.5) },
    { key = 'PageDown', mods = 'SHIFT', action = wezterm.action.ScrollByPage(0.5) },

    -- Copy / Paste
    { key = 'c', mods = 'CTRL', action = wezterm.action_callback(function(window, pane)
            local has_selection = window:get_selection_text_for_pane(pane) ~= ''
            if has_selection then
                window:perform_action(wezterm.action.CopyTo 'Clipboard', pane)
                window:perform_action(wezterm.action.ClearSelection, pane)
            else
                window:perform_action(wezterm.action.SendKey { key = 'c', mods = 'CTRL' }, pane)
            end
        end),
    },
    { key = 'v', mods = 'CTRL', action = wezterm.action.PasteFrom 'Clipboard' },

    -- Shell
    { key = 'c', mods = 'CTRL|SHIFT', action = wezterm.action_callback(function(window, pane)
            window:perform_action(wezterm.action.SendKey { key = 'x', mods = 'CTRL' }, pane)
        end),
    },
}

config.key_tables = {
    search_mode = {
        { key = 'Escape', mods = 'NONE', action = wezterm.action.CopyMode 'Close' },

        { key = 'r', mods = 'CTRL', action = wezterm.action.CopyMode 'CycleMatchType' },
        { key = 'u', mods = 'CTRL', action = wezterm.action.CopyMode 'ClearPattern' },

        { key = 'n', mods = 'CTRL', action = wezterm.action.CopyMode 'NextMatch' },
        { key = 'p', mods = 'CTRL', action = wezterm.action.CopyMode 'PriorMatch' },

        { key = 'PageUp', mods = 'NONE', action = wezterm.action.CopyMode 'PriorMatchPage' },
        { key = 'PageDown', mods = 'NONE', action = wezterm.action.CopyMode 'NextMatchPage' },
    },

    copy_mode = {
        { key = 'Escape', mods = 'NONE', action = wezterm.action.Multiple { 'ScrollToBottom', { CopyMode = 'Close' } } },

        { key = 'Space', mods = 'NONE', action = wezterm.action.CopyMode { SetSelectionMode = 'Cell' } },
        { key = 'v', mods = 'NONE', action = wezterm.action.CopyMode { SetSelectionMode = 'Cell' } },
        { key = 'v', mods = 'CTRL', action = wezterm.action.CopyMode { SetSelectionMode = 'Block' } },
        { key = 'v', mods = 'SHIFT', action = wezterm.action.CopyMode { SetSelectionMode = 'Line' } },

        { key = 'o', mods = 'NONE', action = wezterm.action.CopyMode 'MoveToSelectionOtherEnd' },
        { key = 'o', mods = 'SHIFT', action = wezterm.action.CopyMode 'MoveToSelectionOtherEndHoriz' },

        { key = 'Enter', mods = 'NONE', action = wezterm.action.CopyMode 'MoveToStartOfNextLine' },
        { key = '0', mods = 'NONE', action = wezterm.action.CopyMode 'MoveToStartOfLine' },
        { key = '^', mods = 'NONE', action = wezterm.action.CopyMode 'MoveToStartOfLineContent' },
        { key = '$', mods = 'NONE', action = wezterm.action.CopyMode 'MoveToEndOfLineContent' },
        { key = 'End', mods = 'NONE', action = wezterm.action.CopyMode 'MoveToEndOfLineContent' },
        { key = 'Home', mods = 'NONE', action = wezterm.action.CopyMode 'MoveToStartOfLine' },

        { key = ',', mods = 'NONE', action = wezterm.action.CopyMode 'JumpReverse' },
        { key = ';', mods = 'NONE', action = wezterm.action.CopyMode 'JumpAgain' },

        { key = 'f', mods = 'NONE', action = wezterm.action.CopyMode { JumpForward = { prev_char = false } } },
        { key = 'f', mods = 'SHIFT', action = wezterm.action.CopyMode { JumpBackward = { prev_char = false } } },
        { key = 't', mods = 'NONE', action = wezterm.action.CopyMode { JumpForward = { prev_char = true } } },
        { key = 't', mods = 'SHIFT', action = wezterm.action.CopyMode { JumpBackward = { prev_char = true } } },

        { key = 'g', mods = 'NONE', action = wezterm.action.CopyMode 'MoveToScrollbackTop' },
        { key = 'g', mods = 'SHIFT', action = wezterm.action.CopyMode 'MoveToScrollbackBottom' },

        { key = 'h', mods = 'SHIFT', action = wezterm.action.CopyMode 'MoveToViewportTop' },
        { key = 'l', mods = 'SHIFT', action = wezterm.action.CopyMode 'MoveToViewportBottom' },
        { key = 'm', mods = 'SHIFT', action = wezterm.action.CopyMode 'MoveToViewportMiddle' },

        { key = 'd', mods = 'CTRL', action = wezterm.action.CopyMode { MoveByPage = (0.5) } },
        { key = 'u', mods = 'CTRL', action = wezterm.action.CopyMode { MoveByPage = (-0.5) } },
        { key = 'PageUp', mods = 'NONE', action = wezterm.action.CopyMode 'PageUp' },
        { key = 'PageDown', mods = 'NONE', action = wezterm.action.CopyMode 'PageDown' },

        { key = 'LeftArrow', mods = 'NONE', action = wezterm.action.CopyMode 'MoveLeft' },
        { key = 'RightArrow', mods = 'NONE', action = wezterm.action.CopyMode 'MoveRight' },
        { key = 'UpArrow', mods = 'NONE', action = wezterm.action.CopyMode 'MoveUp' },
        { key = 'DownArrow', mods = 'NONE', action = wezterm.action.CopyMode 'MoveDown' },

        { key = 'b', mods = 'NONE', action = wezterm.action.CopyMode 'MoveBackwardWord' },
        { key = 'w', mods = 'NONE', action = wezterm.action.CopyMode 'MoveForwardWord' },
        { key = 'e', mods = 'NONE', action = wezterm.action.CopyMode 'MoveForwardWordEnd' },

        { key = 'y', mods = 'NONE', action = wezterm.action.Multiple {
                { CopyTo = 'ClipboardAndPrimarySelection' },
                { Multiple = { 'ScrollToBottom', { CopyMode = 'Close' } } }
            },
        },
    },
}

config.disable_default_mouse_bindings = true
config.mouse_bindings = {
    -- Copying
    { event = { Down = { streak = 1, button = 'Left' } }, mods = 'NONE', action = wezterm.action.SelectTextAtMouseCursor('Cell') },
    { event = { Drag = { streak = 1, button = 'Left' } }, mods = 'NONE', action = wezterm.action.ExtendSelectionToMouseCursor('Cell') },
    { event = { Up = { streak = 1, button = 'Left' } }, mods = 'NONE', action = wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor('Clipboard') },

    -- Scrolling
    { event = { Down = { streak = 1, button = { WheelUp = 1 } } }, mods = 'NONE', action = wezterm.action.ScrollByCurrentEventWheelDelta },
    { event = { Down = { streak = 1, button = { WheelDown = 1 } } }, mods = 'NONE', action = wezterm.action.ScrollByCurrentEventWheelDelta },
}

return config
