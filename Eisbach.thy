theory Eisbach (* clone of ~~/src/HOL/Eisbach/Eisbach *)
imports Pure
keywords
  "method" :: thy_decl and
  "conclusion"
  "premises"
  "declares"
  "methods"
  "\<bar>" "\<Rightarrow>"
  "uses"
begin

ML_file "~~/src/HOL/Eisbach/parse_tools.ML"
ML_file "~~/src/HOL/Eisbach/method_closure.ML"
ML_file "~~/src/HOL/Eisbach/eisbach_rule_insts.ML"
ML_file "~~/src/HOL/Eisbach/eisbach_antiquotations.ML"

(* FIXME reform Isabelle/Pure attributes to make this work by default *)
setup \<open>
  fold (Method_Closure.wrap_attribute {handle_all_errs = true, declaration = true})
    [@{binding intro}, @{binding elim}, @{binding dest}, @{binding simp}] #>
  fold (Method_Closure.wrap_attribute {handle_all_errs = false, declaration = false})
    [@{binding THEN}, @{binding OF}, @{binding rotated}, @{binding simplified}]
\<close>

method solves methods m = (m; fail)

end
