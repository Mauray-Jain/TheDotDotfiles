-- Setup
require'fzf-lua'.setup {
  winopts = {
    preview = {
      wrap           = 'wrap',          -- wrap|nowrap
    },
  },
  previewers = {
    man = {
      -- NOTE: remove the `-c` flag when using man-db
      cmd             = "man %s | col -bx",
    },
  },
  -- provider setup
  files = {
    prompt            = 'Files ❯ ',
  },
  git = {
    files = {
      prompt          = 'GitFiles ❯ ',
    },
    status = {
      prompt          = 'GitStatus ❯ ',
    },
    commits = {
      prompt          = 'Commits ❯ ',
    },
    bcommits = {
      prompt          = 'BCommits ❯ ',
    },
    branches = {
      prompt          = 'Branches ❯ ',
    },
    stash = {
      prompt          = 'Stash> ',
    },
  },
  grep = {
    prompt            = 'Rg ❯ ',
    input_prompt      = 'Grep For ❯ ',
  },
  args = {
    prompt            = 'Args ❯ ',
  },
  oldfiles = {
    prompt            = 'History ❯ ',
  },
  buffers = {
    prompt            = 'Buffers ❯ ',
  },
  tabs = {
    prompt            = 'Tabs ❯ ',
  },
  lines = {
    prompt            = 'Lines ❯ ',
  },
  blines = {
    prompt            = 'BLines ❯ ',
  },
  tags = {
    prompt                = 'Tags ❯ ',
  },
  btags = {
    prompt                = 'BTags ❯ ',
  },
  colorschemes = {
    prompt            = 'Colorschemes ❯ ',
  },
  lsp = {
    prompt_postfix    = ' ❯ ',       -- will be appended to the LSP label
                                    -- to override use 'prompt' instead
  },
}
