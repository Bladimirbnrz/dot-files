return {
  cmd = { "texlab" },
  filetypes = { "tex", "bib" },
  settings = {
    texlab = {
      diagnostics = {
        ignoredPatterns = {
          "Undefined reference"
        }
      },
    },
  },
}
-- only detects some errors such as unclosed environments or quotes that do not exist
