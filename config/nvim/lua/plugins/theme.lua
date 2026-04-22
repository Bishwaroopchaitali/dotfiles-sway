return {
  -- The plugin installation from step 2
  { "RedsXDD/neopywal.nvim", name = "neopywal", priority = 1000 },

  -- Configure LazyVim to use it
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "neopywal",
    },
  },
}
