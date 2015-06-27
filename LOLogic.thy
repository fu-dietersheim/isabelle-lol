theory LOLogic
imports LOL
  keywords "load_data"::thy_decl
begin

ML{*
local
  local
    local
      fun load_file (thy: theory) (path: string list) =
          let val p =  File.full_path (Resources.master_directory thy) (Path.make path); in
          let val _ = "loading file "^File.platform_path p |> writeln; in
            if not (File.exists p) orelse (File.is_dir p) then raise Fail "File not found" else File.read_lines p
          end end;
    
      fun writenumloaded l =
        let val _ = "Loaded "^ Int.toString (length l) ^" lines" |> writeln; in
          l
        end;
    in
      fun load_data thy = load_file thy #> writenumloaded;
    end;
    local
      val scan_whitespace = Scan.many (fn x => x = " ");
      
      fun is_identifier x = Symbol.is_ascii x andalso
        (Symbol.is_ascii_letter x orelse Symbol.is_ascii_digit x  orelse x = "_")
    
      val parse_identifier = scan_whitespace |-- (Scan.many1 is_identifier >> implode) --| scan_whitespace
    in
      fun parse s = let val (a,b) = Scan.finite Symbol.stopper (parse_identifier ::: (Scan.repeat ($$ "," |-- parse_identifier))) s
              in if b <> [] then raise Fail "unparsed" else a end
    end
  in
    fun openf (thy: theory) (path: string list) = path |> load_data thy |> map (parse o raw_explode) |> List.concat |> map Binding.name
  end
  local
    fun define_const (t: term) (name: binding) (lthy: local_theory) : local_theory = let
          val _ = writeln ("Defining constant `"^Binding.name_of name^"' ("^Binding.name_of name^"_def')");
          val ((_, (_, thm)), lthy) = Local_Theory.define ((name, NoSyn), ((Binding.empty, []), t)) lthy;
          val (_, lthy) = Local_Theory.note ((Binding.suffix_name "_def" name, [Attrib.internal (K Simplifier.simp_add)]), [thm]) lthy;
         in
           lthy
         end
  in
    val define_fact = define_const @{term "True"}
  end
in
  fun load_data (path: string list) = fn lthy =>  fold (fn d => fn t => define_fact d t) (distinct op = (openf (Proof_Context.theory_of lthy) path)) lthy
end
*}


ML{*
Outer_Syntax.local_theory @{command_keyword load_data} "Load data" (Parse.string >> (fn x => load_data [x]))
*}


end
