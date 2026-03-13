return {
  cmd = {
    "fortls",
    "--lowercase_intrinsics",
    "--hover_signature",
    "--hover_language=fortran",
    "--use_signature_help",
    "--enable_code_actions" },
  filetypes = { 'fortran' },
  root_markers = { '.fortls', '.fortlsrc', '.fortls.json', '.git' },
  settings = {},
}
