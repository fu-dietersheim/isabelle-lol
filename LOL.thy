theory LOL
imports Pure
begin

typedecl bool

judgment
  Trueprop :: "bool => prop" ("(_)" 5)

axiomatization
  conj :: "[bool, bool] => bool" (infixr "\<and>" 35) and
  True :: bool
where
  TrueI: "True" and
  conjI: "P \<Longrightarrow> Q \<Longrightarrow> P \<and> Q"

method_setup solver = \<open>
  let
    fun solve_tac ctxt =
      Simplifier.simp_tac ctxt THEN_ALL_NEW
        (REPEAT_ALL_NEW (resolve_tac ctxt @{thms TrueI conjI}))
  in
    Scan.succeed (SIMPLE_METHOD' o solve_tac)
  end
\<close>

end