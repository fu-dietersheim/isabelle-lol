theory LOL_Examples
imports LOLogic
begin

load_data "ontology"

lemma "Alice \<and> is_friend_of \<and> Bob" by solver

lemma "Bob \<and> is_friend_of \<and> Eve" by solver

end