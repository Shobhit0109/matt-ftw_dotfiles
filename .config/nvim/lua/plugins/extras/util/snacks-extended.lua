return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        header = [[
                                                                   
      ████ ██████           █████      ██                    
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████
        ]],
      },
    },
    lazygit = {
      configure = false,
    },
    notifier = {
      style = "fancy",
    },
    terminal = {
      win = {
        position = "float",
      },
    },
    scroll = {
      animate = {
        duration = { step = 10, total = 150 },
      },
    },
  },
}
