# Neovim validation

Validated on macOS arm64 with Neovim 0.11.5 (official release archive) and
0.12.5 (installed Homebrew binary). No Git commits were made by the validation.

## Installation findings and limits

An unattended first-run installation was **not clean on the first attempt**.
GitHub connection failures recovered on retry. Opening language buffers while
the initial asynchronous parser installation was running caused duplicate
Lua/Python parser builds and missing-source errors. Loading Tree-sitter without
opening language buffers and allowing installation to finish recovered these.

The system Tree-sitter CLI 0.27.0 failed to generate the LaTeX parser because it
rejects `--no-bindings`. The locked legacy plugin documents support only up to
CLI 0.25.x. An isolated CLI 0.25.10 successfully completed installation. The
normal system CLI was not changed.

Lazy's initial bootstrap used its current stable revision and rewrote its own
lock entry. Restoring the original lockfile again brought all 60 installed
plugin repositories to the submitted revisions. The two `cond = false` plugins
(mini.move and OneDark) were not installed. Both environments then had all 40
configured parsers available and passed all 120 highlights/injections/indents
query loads.

These results do not establish upstream support for Neovim 0.12 by the legacy
Tree-sitter branch. Authenticated AI completion, premium Intelephense features,
clipboard integration, real tmux-pane transitions, and visual rendering were
not tested. This was headless validation, not a full interactive acceptance run.
Mason installed the representative tools below; not every optional server in
the configuration was exercised.

## Workflow results

Every row passed on **both 0.11.5 and 0.12.5**, after installation recovery and
the local LSP precedence fix described below.

| Criterion | Evidence |
| --- | --- |
| Lua workflow | lua_ls attached, returned hover and completion responses; the format mapping changed the buffer through StyLua. |
| Python workflow | basedpyright and Ruff attached, diagnostics appeared, and the format mapping produced the expected Ruff output. |
| TypeScript workflow | vtsls attached, type diagnostics appeared, the source-action command existed, and Prettierd formatted through the mapping. |
| PHP workspace isolation | Two nested projects and a standalone file received distinct Intelephense clients with the expected roots; definition lookup returned a result. |
| JSON workflow | jsonls attached and the configured formatting mapping changed the document. |
| Shell dialects | none-ls formatted Bash indirect-array syntax, POSIX shell, and Zsh array syntax separately. |
| Nginx formatter | A freshly installed nginxfmt formatted a buffer through none-ls. The old normal-environment launcher was not repaired or used. |
| Elixir workflow | Expert attached to a temporary Mix project; none-ls invoked mix formatting successfully. |
| Autosave | A deferred write reached disk, InsertEnter cancelled the next pending write, FocusLost wrote immediately, and ASToggle disabled autosave. |
| Neorg | Metadata parsing returned the expected title; summary generation at a heading inserted the note title and description. |
| Telescope | Actual normal-picker results retained digital.ts and next.ts; the unrestricted picker included hidden, ignored, dependency, build, and Git-internal files. |
| Snippets | The loaded nvim-cmp mapping advanced through three LuaSnip fields and jumped backward in select mode; documentation inheritance was present. |
| Tree-sitter | All 40 configured parsers were present; 120 query loads passed per version, retaining the PHP and Markdown patches. |

Focused checks from steps 2 and 4 also passed on 0.11.5: snippet expansion,
configuration syntax, four-direction Vim split navigation after LSP attachment,
and autosave event/toggle registration. Live tmux transitions remain unverified.

## Fix found by integrated validation

The nvim-lspconfig upgrade introduced native runtime config files. Under actual
lazy.nvim runtime ordering, its PHP root function overrode the local root fix;
the earlier isolated source probe did not reproduce that ordering.
`lua/plugins/lsp/lspconfig.lua` now explicitly applies each local `lsp/*.lua`
configuration with `vim.lsp.config` before enabling servers. The live test then
confirmed distinct PHP roots and clients on both versions.

## Isolation and reproducibility

The harness lives at `/tmp/nvim-step5`. Each version has its own HOME and XDG
config/data/state/cache directories, copied configuration, fixture projects,
Mason installation, and plugin clones. Final runs also used separate temporary
directories. No normal Neovim plugin/tool installation was updated.

Test-only changes in the copied configurations:

- Disabled Copilot's authentication build hook and automatic start; suppressed
  Supermaven startup. No account authentication was performed.
- Removed the Intelephense licence path and redirected Neorg workspaces to
  temporary notes.
- Disabled update checking and limited clone concurrency.
- Cleared `wildignore` because `*/tmp/*` otherwise excluded the test installation
  itself and caused help-tag errors. The repository option is unchanged.
- Used the explicit local LSP config fix from this working tree.

The runner selects the binary and isolated environment. Representative commands:

```sh
python3 /tmp/nvim-step5/run.py 011 restore-locked '+Lazy! restore' '+qa!'
python3 /tmp/nvim-step5/run.py 011 parsers-final '+luafile /tmp/nvim-step5/parsers.lua'
python3 /tmp/nvim-step5/run.py 011 workflows-verified '+luafile /tmp/nvim-step5/workflows.lua'
python3 /tmp/nvim-step5/run.py 011 extras '+luafile /tmp/nvim-step5/extras.lua'
```

Repeat with `012` for Neovim 0.12.5. The scripts use temporary fixtures and may
install packages or write files in those environments. Logs and JSON results
are under `/tmp/nvim-step5/{011,012}/`; temporary artifacts are not durable.
The final `workflows-result.json`, `extras-result.json`, and
`parsers-result.json` contain passing results on both versions. Earlier logs
retain the initial failures and harness corrections for comparison.
