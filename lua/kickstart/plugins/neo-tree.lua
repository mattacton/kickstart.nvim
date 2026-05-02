-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

---@module 'lazy'
---@type LazySpec
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  ---@module 'neo-tree'
  ---@type neotree.Config
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        never_show = { 'node_modules' },
      },
      find_args = function(cmd, _, _, args)
        if cmd == 'fd' or cmd == 'fdfind' then
          table.insert(args, '--exclude')
          table.insert(args, 'node_modules')
        elseif cmd == 'find' then
          for i = #args, 1, -1 do
            if args[i] == '-print' then
              table.insert(args, i, '*/node_modules/*')
              table.insert(args, i, '-path')
              table.insert(args, i, '-not')
              break
            end
          end
        end
        return args
      end,
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
      use_libuv_file_watcher = true,
    },
  },
}
