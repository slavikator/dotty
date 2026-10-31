# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles for macOS, organized with a GNU Stow-compatible layout. Each tool lives in its own top-level directory mirroring the path relative to `$HOME`, so configs can be symlinked with `stow <tool>`.

| Directory   | Tool                        |
|-------------|-----------------------------|
| `nvim/`     | Neovim (LazyVim-based)      |
| `zsh/`      | Zsh shell                   |
| `ghostty/`  | Ghostty terminal            |
| `alacritty/`| Alacritty terminal          |
| `yazi/`     | Yazi file manager           |

## Neovim Architecture

Built on [LazyVim](https://lazyvim.github.io/) — all LazyVim defaults are inherited unless explicitly overridden.

**Entry point:** `nvim/.config/nvim/init.lua` → `config.lazy`

**Config files** (`lua/config/`):
- `lazy.lua` — lazy.nvim bootstrap and plugin spec
- `nvim/.config/nvim/lazyvim.json` (config root, not in `lua/config/`) — enabled LazyVim extras (prettier, mini-surround, luasnip, docker, json, markdown, terraform, yaml); manage with `:LazyExtras`, TypeScript extra is toggleable via `<leader>ut`
- `options.lua` — Neovim options; autoformat disabled for Lua files
- `keymaps.lua` — custom keybindings (see below)
- `autocmds.lua` — Emmet LSP auto-start for HTML/CSS/JSX filetypes

**Custom plugins** (`lua/plugins/`):
- `colorscheme.lua` / `catppuccin.lua` — Catppuccin Mocha, transparent background
- `mason.lua` — ensures `emmet-language-server` and `tailwindcss-language-server` are installed
- `bufferline.lua` — ordinal buffer numbers shown in tab bar
- `lualine.lua` + `lualine_custom/layout.lua` — adds keyboard layout indicator (🇺🇦/🇺🇸) to statusline, polled every 0.5s via macOS `defaults` or Linux `setxkbmap`
- `snacks.lua` — file explorer auto-closes after picking a file
- `whichkey.lua` — registers `<leader>z` group ("custom"), `<leader>zc` group ("copy") and `<leader>zcp` group ("path")
- `wrap.lua` — `<C-y>` (or `<leader>zl`) in visual mode wraps selection in `<ul><li>` tags; also exposes `:WrapUL` command
- `custom-snippets.lua` — LuaSnip snippet `rafceuc` for React client component with `"use client"`

**Custom keymaps** (beyond LazyVim defaults):
| Key | Mode | Action |
|-----|------|--------|
| `<leader>za` | n | Select whole file |
| `<leader>zca` | n | Copy all text (whole file) to clipboard |
| `J` / `K` | v | Move selected lines down/up |
| `<leader>1`–`9` | n | Jump to buffer by ordinal number |
| `<leader>zcpr` | n | Copy relative file path |
| `<leader>zcpa` | n | Copy absolute file path |
| `<leader>zcpf` | n | Copy filename |
| `<leader>zcpn` | n | Copy filename without extension |
| `<leader>zcpd` | n | Copy file directory (relative) |
| `<leader>zcpl` | n | Copy `path:line` |
| `<leader>zce` | n | Copy diagnostic message under cursor |
| `<leader>zr` | n | Restart LSP server |
| `<leader>zx` | n | Make current file executable |
| `<leader>ut` | n | Toggle TypeScript LazyVim extra |
| `<leader>ue` | n | Toggle Emmet LSP |
| `<Esc>` | n | Clear search highlight |
| `<C-y>` / `<leader>zl` | v | Wrap in `<ul><li>` |
| `<leader>zu` | v | Capitalize first letter of each line (skips list markers, `<li>`, checkboxes; `:CapitalizeLines`) |
| `<leader>zf` | v | Strip HTML/Markdown formatting, keep text, line breaks and relative indent (`:StripFormatting`) |
| `<leader>a…` | n/v | Claude Code (`ai.claudecode` extra defaults): `ac` toggle, `af` focus, `ab` add buffer, `as` send selection, `aa`/`ad` accept/deny diff |

## Lua Formatting

StyLua is configured in `nvim/.config/nvim/stylua.toml`:
- Spaces, indent width 2, column width 120
- Autoformat is **disabled** for Lua files inside Neovim (to avoid conflicts with StyLua run externally)

## Theme Consistency

Catppuccin Mocha is used across all tools. MesloLGL Nerd Font at size 14 is used in both Ghostty and Alacritty.
