local ls = require("luasnip")
local s  = ls.snippet
local i  = ls.insert_node
local t  = ls.text_node
-- local rep = require("luasnip.extras").rep  -- función para repetir texto
require("luasnip").filetype_extend("tex", { "plaintex" })

return {
  s("frac", { t("\\frac{"), i(1, "numerador"), t("}{"), i(2, "denominador"), t("}") }),
  s("sum",  { t("\\sum_{"), i(1, "i=1"), t("}^{"), i(2, "n"), t("}") }),
  s("mil", {t("$"), i(1, "math in line"), t("$")}),
  s("mib", { t("\\["), 
    i(1, "math in block"),
     t("\\]") })
}
-- -- Definir snippets para LaTeX (filetype = "tex")
-- ls.add_snippets("tex", {
--   s("env", {  -- trigger = "env"
--     t("\\begin{"), i(1, "entorno"), t({"}", "\t"}),  -- comienza \begin{entorno}
--     i(2, "contenido"),                             -- zona de contenido
--     t({"", "\\end{"}), rep(1), t({"}"}),           -- cierra con \end{entorno}
--   }),
--   -- se pueden añadir más snippets aquí...
-- })
