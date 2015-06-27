theory LOL_Examples
imports LOLogic
begin

definition [simp]: "Alice' \<equiv> True"
definition [simp]: "Bob' \<equiv> True"

lemma "Alice' \<and> Bob'"
by solver


local_setup \<open> 
  load_data ["ontology"]
 \<close>

lemma "Alice \<and> is_friend_of \<and> Bob" by solver

end