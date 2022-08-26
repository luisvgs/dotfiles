
local builtin = require("el.builtin")
local extensions = require("el.extensions")
local helper = require("el.helper")
local lsp_statusline = require("el.plugins.lsp_status")
local sections = require("el.sections")
local subscribe = require("el.subscribe")
local has_lsp_extensions, ws_diagnostics = pcall(require, 'lsp_extensions.workspace.diagnostic')
local diagnostic = require "el.diagnostic"

local git_branch = subscribe.buf_autocmd(
    "el_git_branch",
    "BufEnter",
    function(window, buffer)
        local branch = extensions.git_branch(window, buffer)
        if branch then
            return '  '.. branch ..''
        end
    end
)

local lsp_current_status = function(win, _)
    local status = require('lsp-status').status()
    if type(status) == 'string' then
        if win.is_active then
            local result, _ = string.gsub(status, '\240\159\135\187', '')
            return result
        end
    else
        return ' '
    end
end

local file_icon = subscribe.buf_autocmd(
    "el_file_icon",
    "BufRead",
    function(_, buffer)
        return extensions.file_icon(_, buffer)
    end
)

local git_changes = subscribe.buf_autocmd("el_git_changes", "BufWritePost", function(window, buffer)
  return extensions.git_changes(window, buffer)
end)

local diagnostic_display = diagnostic.make_buffer()

local function icon(_, buf)
    local filename = buf.name
    local extension = buf.extension
    local icon_str, _ = require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
    return icon_str
end

local generator = function(win_id, _)
    return {
        extensions.gen_mode { format_string = '[%s]' },
        git_branch,
        git_changes,
        sections.split,
        -- icon,
        sections.maximum_width(
            builtin.make_responsive_file(140, 90),
            0.30
        ),
        sections.collapse_builtin {
            ' ',
            builtin.modified_flag
        },
        sections.split,
        -- lsp_statusline.server_progress,
        -- ws_diagnostic_counts,
        lsp_current_status,
        -- diagnostic_display,
        '[', builtin.line_with_width(3), ':',  builtin.column_with_width(2), ']',
        sections.collapse_builtin {
            '[',
            builtin.help_list,
            builtin.readonly_list,
            ']',
        },
        builtin.filetype,
    }
end

require('el').setup { generator = generator }
