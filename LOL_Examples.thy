theory LOL_Examples
imports LOLogic
begin

load_data "ontology"

lemma "Alice, is_friend_of, Bob" by solver

lemma "Bob, is_friend_of, Eve" by solver

end