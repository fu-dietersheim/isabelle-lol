theory LOL
imports Eisbach
begin

typedecl bool

judgment
  Trueprop :: "bool \<Rightarrow> prop" ("(_)" 5)

axiomatization
  conj :: "bool \<Rightarrow> bool \<Rightarrow> bool" (infixr "," 35) and
  True :: bool
where
  TrueI: "True" and
  conjI: "P \<Longrightarrow> Q \<Longrightarrow> P, Q"

method_setup simp = \<open>Scan.succeed (SIMPLE_METHOD' o Simplifier.simp_tac)\<close>

method solver = (simp; (rule TrueI conjI)+)

end