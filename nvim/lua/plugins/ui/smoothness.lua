return {
  {
    "declancm/cinnamon.nvim",
    enabled = false,
    version = "*", -- use latest release
    opts = {
      -- change default options here
    },
  },
  {
    "sphamba/smear-cursor.nvim",
    -- enabled = false,
    opts = {
      smear_between_buffers = false,
      stiffness = 0.8,
      trailing_stiffness = 0.8,
      stiffness_insert_mode = 0.7,
      trailing_stiffness_insert_mode = 0.7,
      damping = 0.95,
      damping_insert_mode = 0.95,
      distance_stop_animating = 0.5,
      time_interval = 7,
    },
  }
}
