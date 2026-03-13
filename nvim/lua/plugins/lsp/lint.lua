return {
  "mfussenegger/nvim-lint",
  event = { "BufWritePost", "InsertLeave" },
  config = function()
    local lint = require("lint")

    local gfortran_diagnostic_args = {
      "-fsyntax-only",
      "-Wall",
      "-Wextra",
      "-Wimplicit-interface",
      "-fimplicit-none",
      "-fmax-errors=0"
    }

    lint.linters_by_ft = {
      fortran = {
        "gfortran",
      },
    }

    local pattern = "^([^:]+):(%d+):(%d+):%s+([^:]+):%s+(.*)$"
    local groups = { "file", "lnum", "col", "severity", "message" }
    local severity_map = {
      ["Error"] = vim.diagnostic.severity.ERROR,
      ["Warning"] = vim.diagnostic.severity.WARN,
    }
    local defaults = { ["source"] = "gfortran" }

    local required_args = { "-fsyntax-only", "-fdiagnostics-plain-output" }
    local args = vim.list_extend(required_args, gfortran_diagnostic_args)

    lint.linters.gfortran = {
      cmd = "gfortran",
      stdin = false,
      append_fname = true,
      stream = "stderr",
      env = nil,
      args = args,
      ignore_exitcode = true,
      parser = require("lint.parser").from_pattern(pattern, groups, severity_map, defaults),
    }
  end
}
