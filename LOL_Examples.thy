theory LOL_Examples
imports LOL
begin

definition [simp]: "Alice \<equiv> True"
definition [simp]: "Bob \<equiv> True"

lemma "Alice \<and> Bob"
by solver


end