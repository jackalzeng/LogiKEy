theory E imports Main       (* Aqvist's System E: C. Benzmüller & X. Parent, 2019 *)
begin       
typedecl i (*Possible worlds.*) type_synonym \<sigma> = "(i\<Rightarrow>bool)" 
consts aw::i (*Actual world.*)  
abbreviation(input) etrue  :: "\<sigma>" ("\<^bold>\<top>") where "\<^bold>\<top> \<equiv> \<lambda>w. True" 
abbreviation(input) efalse :: "\<sigma>" ("\<^bold>\<bottom>")  where "\<^bold>\<bottom> \<equiv> \<lambda>w. False"   
abbreviation(input) enot :: "\<sigma>\<Rightarrow>\<sigma>" ("\<^bold>\<not>_"[52]53)  where "\<^bold>\<not>\<phi> \<equiv> \<lambda>w. \<not>\<phi>(w)" 
abbreviation(input) eand :: "\<sigma>\<Rightarrow>\<sigma>\<Rightarrow>\<sigma>" (infixr"\<^bold>\<and>"51) where "\<phi>\<^bold>\<and>\<psi> \<equiv> \<lambda>w. \<phi>(w)\<and>\<psi>(w)"   
abbreviation(input) eor  :: "\<sigma>\<Rightarrow>\<sigma>\<Rightarrow>\<sigma>" (infixr"\<^bold>\<or>"50) where "\<phi>\<^bold>\<or>\<psi> \<equiv> \<lambda>w. \<phi>(w)\<or>\<psi>(w)"   
abbreviation(input) eimp :: "\<sigma>\<Rightarrow>\<sigma>\<Rightarrow>\<sigma>" (infixr"\<^bold>\<rightarrow>"49) where "\<phi>\<^bold>\<rightarrow>\<psi> \<equiv> \<lambda>w. \<phi>(w)\<longrightarrow>\<psi>(w)"  
abbreviation(input) eequ :: "\<sigma>\<Rightarrow>\<sigma>\<Rightarrow>\<sigma>" (infixr"\<^bold>\<leftrightarrow>"48) where "\<phi>\<^bold>\<leftrightarrow>\<psi> \<equiv> \<lambda>w. \<phi>(w)\<longleftrightarrow>\<psi>(w)" 

(*Possibilist--constant domain--quantification.*)
abbreviation(input) eforall ("\<^bold>\<forall>") where "\<^bold>\<forall>\<Phi> \<equiv> \<lambda>w.\<forall>x. (\<Phi> x w)"
abbreviation(input) eforallB (binder"\<^bold>\<forall>"[8]9) where "\<^bold>\<forall>x. \<phi>(x) \<equiv> \<^bold>\<forall>\<phi>"  
abbreviation(input) eexists ("\<^bold>\<exists>") where "\<^bold>\<exists>\<Phi> \<equiv> \<lambda>w.\<exists>x. (\<Phi> x w)"   
abbreviation(input) eexistsB (binder"\<^bold>\<exists>"[8]9) where "\<^bold>\<exists>x. \<phi>(x) \<equiv> \<^bold>\<exists>\<phi>" 

abbreviation(input) ebox :: "\<sigma>\<Rightarrow>\<sigma>" ("\<box>") where "\<box> \<equiv> \<lambda>\<phi> w.  \<forall>v. \<phi>(v)"  
consts R :: "i\<Rightarrow>\<sigma>" (infixr "R" 70) (*Betterness relation, cf. def. of \<circle><_|_>.*) 
abbreviation(input) eopt  :: "\<sigma>\<Rightarrow>\<sigma>" ("opt<_>") 
  where "opt<\<phi>> \<equiv> (\<lambda>v. ( (\<phi>)(v) \<and> (\<forall>x. ((\<phi>)(x)  \<longrightarrow>  v R x) )) )" 
abbreviation(input) esubset :: "\<sigma>\<Rightarrow>\<sigma>\<Rightarrow>bool" (infix "\<^bold>\<subseteq>" 53)
  where "\<phi> \<^bold>\<subseteq> \<psi> \<equiv> \<forall>x. \<phi> x \<longrightarrow> \<psi> x"
abbreviation(input) econd  :: "\<sigma>\<Rightarrow>\<sigma>\<Rightarrow>\<sigma>" ("\<circle><_|_>")
  where "\<circle><\<psi>|\<phi>> \<equiv>  \<lambda>w. opt<\<phi>> \<^bold>\<subseteq> \<psi>"
abbreviation(input) euncobl :: "\<sigma>\<Rightarrow>\<sigma>" ("\<^bold>\<circle><_>")   
  where "\<^bold>\<circle><\<phi>> \<equiv> \<circle><\<phi>|\<^bold>\<top>>" 

abbreviation(input) evalid :: "\<sigma>\<Rightarrow>bool" ("\<lfloor>_\<rfloor>"[8]109)  (*Global validity.*)
  where "\<lfloor>p\<rfloor> \<equiv> \<forall>w. p w"
abbreviation ecjactual :: "\<sigma>\<Rightarrow>bool" ("\<lfloor>_\<rfloor>\<^sub>l"[7]105) (*Local validity — in world aw.*)  
  where "\<lfloor>p\<rfloor>\<^sub>l \<equiv> p(aw)"

lemma True nitpick [satisfy,user_axioms,expect=genuine] oops (*Consistency conf.*)

(*Correspondence theory.*)
lemma assumes "\<forall>x y z. x R y \<and> y R z \<longrightarrow> x R z" 
      shows "\<lfloor>((\<circle><\<psi>|\<phi>>) \<^bold>\<and> \<^bold>\<not>(\<circle><\<^bold>\<not>\<xi>|\<phi>>)) \<^bold>\<rightarrow> \<circle><\<psi>|\<phi>\<^bold>\<and>\<xi>>\<rfloor>" 
  using assms by blast

lemma assumes "\<lfloor>((\<circle><\<psi>|\<phi>>) \<^bold>\<and> \<^bold>\<not>(\<circle><\<^bold>\<not>\<xi>|\<phi>>)) \<^bold>\<rightarrow> \<circle><\<psi>|\<phi>\<^bold>\<and>\<xi>>\<rfloor>" 
      shows "\<forall>x y z. x R y \<and> y R z \<longrightarrow> x R z" 
  nitpick [show_all,format=2] oops (*Countermodel presented by Nitpick.*)
end