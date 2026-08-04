return {
  cmd = { "texlab" },
  filetypes = { "tex", "bib" },
  settings = {
    texlab = {
      diagnostics = {
        ignoredPatterns = {
          "Undefined reference",
          "Mismatched environment",
          "Unused label"
        }
      },
    },
  },
}
