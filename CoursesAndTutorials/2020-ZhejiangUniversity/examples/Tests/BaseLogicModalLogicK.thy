theory BaseLogicModalLogicK imports Main                      
begin      

(*Type declarations and type abbreviations*)
typedecl i (*Possible worlds*)  
typedecl e (*Individuals*)      
type_synonym \<sigma> = "i\<Rightarrow>bool" (*World-lifted propositions*)
type_synonym \<tau> = "i\<Rightarrow>i\<Rightarrow>bool" (*Lifted predicates*)
type_synonym \<gamma> = "e\<Rightarrow>\<sigma>" (*Lifted predicates*)
type_synonym \<mu> = "\<sigma>\<Rightarrow>\<sigma>" (*Unary modal connectives*)
type_synonym \<nu> = "\<sigma>\<Rightarrow>\<sigma>\<Rightarrow>\<sigma>" (*Binary modal connectives*)


(***********************************************************************************
 ******************  Modal Logic Connectives ***************************************
 ***********************************************************************************)

(*Modal logic connectives (operating on truth-sets)*)
abbreviation MFalse::\<sigma> ("\<^bold>\<bottom>") where "\<^bold>\<bottom> \<equiv> \<lambda>w. False"
abbreviation MTrue::\<sigma> ("\<^bold>\<top>") where "\<^bold>\<top> \<equiv> \<lambda>w. True"
abbreviation MNeg::\<mu> ("\<^bold>\<not>_") where "\<^bold>\<not>\<phi> \<equiv> \<lambda>w.\<not>(\<phi> w)"
abbreviation MOr::\<nu> ("_\<^bold>\<and>_") where "\<phi>\<^bold>\<and>\<psi> \<equiv> \<lambda>w.(\<phi> w)\<and>(\<psi> w)"   
abbreviation MAnd::\<nu> ("_\<^bold>\<or>_") where "\<phi>\<^bold>\<or>\<psi> \<equiv> \<lambda>w.(\<phi> w)\<or>(\<psi> w)"
abbreviation MImp::\<nu> ("_\<^bold>\<rightarrow>_") where "\<phi>\<^bold>\<rightarrow>\<psi> \<equiv> \<lambda>w.(\<phi> w)\<longrightarrow>(\<psi> w)"  
abbreviation MEquiv::\<nu> ("_\<^bold>\<leftrightarrow>_") where "\<phi>\<^bold>\<leftrightarrow>\<psi> \<equiv> \<lambda>w.(\<phi> w)\<longleftrightarrow>(\<psi> w)"

abbreviation MBox::"\<tau>\<Rightarrow>\<mu>" ("\<^bold>[_\<^bold>] _") where "\<^bold>[r\<^bold>] \<phi> \<equiv> \<lambda>w.\<forall>v.(r w v)\<longrightarrow>(\<phi> v)"
abbreviation MDia::"\<tau>\<Rightarrow>\<mu>" ("\<^bold><_\<^bold>> _") where "\<^bold><r\<^bold>> \<phi> \<equiv> \<lambda>w.\<exists>v.(r w v)\<and>(\<phi> v)"

(*Polymorphic possibilist quantification*)
abbreviation MAllPoss ("\<^bold>\<forall>") where "\<^bold>\<forall>\<Phi> \<equiv> \<lambda>w.\<forall>x.(\<Phi> x w)"
abbreviation MAllPossB (binder"\<^bold>\<forall>"[8]9) where "\<^bold>\<forall>x. \<phi>(x) \<equiv> \<^bold>\<forall>\<phi>"  
abbreviation MExPoss ("\<^bold>\<exists>") where "\<^bold>\<exists>\<Phi> \<equiv> \<lambda>w.\<exists>x.(\<Phi> x w)"   
abbreviation MExPossB (binder"\<^bold>\<exists>"[8]9) where "\<^bold>\<exists>x. \<phi>(x) \<equiv> \<^bold>\<exists>\<phi>" 

(*Actualist quantification for individuals*)
consts existsAt::\<gamma> ("_\<^bold>@_")  
abbreviation MAllAct::"\<gamma>\<Rightarrow>\<sigma>" ("\<^bold>\<forall>\<^sup>E") where "\<^bold>\<forall>\<^sup>E\<Phi> \<equiv> \<lambda>w.\<forall>x.(x\<^bold>@w)\<longrightarrow>(\<Phi> x w)"
abbreviation MAllActB (binder"\<^bold>\<forall>\<^sup>E"[8]9) where "\<^bold>\<forall>\<^sup>Ex. \<phi>(x) \<equiv> \<^bold>\<forall>\<^sup>E\<phi>"     
abbreviation MExAct::"\<gamma>\<Rightarrow>\<sigma>" ("\<^bold>\<exists>\<^sup>E") where "\<^bold>\<exists>\<^sup>E\<Phi> \<equiv> \<lambda>w.\<exists>x.(x\<^bold>@w)\<and>(\<Phi> x w)"
abbreviation MExActB (binder"\<^bold>\<exists>\<^sup>E"[8]9) where "\<^bold>\<exists>\<^sup>Ex. \<phi>(x) \<equiv> \<^bold>\<exists>\<^sup>E\<phi>"

(*Meta-logical predicate for global validity*)
abbreviation g1::"\<sigma>\<Rightarrow>bool" ("\<lfloor>_\<rfloor>") where "\<lfloor>\<psi>\<rfloor> \<equiv>  \<forall>w. \<psi> w"

(*Consistency, Barcan and converse Barcan formula*)
lemma True nitpick[satisfy] oops  (*Model found by Nitpick*)
lemma "\<lfloor>(\<^bold>\<forall>\<^sup>Ex.\<^bold>[r\<^bold>](\<phi> x)) \<^bold>\<rightarrow> \<^bold>[r\<^bold>](\<^bold>\<forall>\<^sup>Ex.(\<phi> x))\<rfloor>" nitpick oops (*Ctm*)
lemma "\<lfloor>(\<^bold>[r\<^bold>](\<^bold>\<forall>\<^sup>Ex.(\<phi> x))) \<^bold>\<rightarrow> \<^bold>\<forall>\<^sup>Ex.\<^bold>[r\<^bold>](\<phi> x)\<rfloor>" nitpick oops (*Ctm*)
lemma "\<lfloor>(\<^bold>\<forall>x.\<^bold>[r\<^bold>](\<phi> x)) \<^bold>\<rightarrow> \<^bold>[r\<^bold>](\<^bold>\<forall>x. \<phi> x)\<rfloor>" by simp 
lemma "\<lfloor>(\<^bold>[r\<^bold>](\<^bold>\<forall>x.(\<phi> x))) \<^bold>\<rightarrow> \<^bold>\<forall>x.\<^bold>[r\<^bold>](\<phi> x)\<rfloor>" by simp

(***********************************************************************************
 ******************  Some Basic Types of our Ontology ******************************
 ***********************************************************************************)

(* There are some kids, could be many more *)
datatype Entity = Nilda | Carla  

(* There are some roads, could be many more *)
datatype Street = LiarsStreet | TruthtellersRoad  


(***********************************************************************************
 ******************  Controlled Natural Language Library ***************************
 ******************  Logic and Modalities ******************************************
 ***********************************************************************************)

(*** NL phrases: standard logical connectives; examples ***)
abbreviation And ("_ and _") where "X and Y \<equiv> X \<^bold>\<and> Y"
abbreviation Or ("_ or _") where "X or Y \<equiv> X \<^bold>\<or> Y"
abbreviation Not ("not _") where "not X \<equiv> \<^bold>\<not>X"
abbreviation If_then ("If _ then _") where "If X then Y \<equiv> X \<^bold>\<rightarrow> Y"

(*** NL phrases: modal connectives; examples ***)

(* Entities have different modal accessibility relations for "Says" "Knows" "Belief" "Obligation", etc.;
    a technical  solution that is not relevant for the 'normal' reader *)
consts SaysAccessibilityRel::"Entity\<Rightarrow>\<tau>"    KnowsAccessibilityRel::"Entity\<Rightarrow>\<tau>"
       BeliefAccessibilityRel::"Entity\<Rightarrow>\<tau>"  ObligationAccessibilityRel::"Entity\<Rightarrow>\<tau>"

(* We can introduce modal NL phrases *)
definition  Says::"Entity\<Rightarrow>\<sigma>\<Rightarrow>\<sigma>"  ("_ says _")  where "X says \<phi> \<equiv> \<^bold>[SaysAccessibilityRel X\<^bold>] \<phi> "    
definition  Knows::"Entity\<Rightarrow>\<sigma>\<Rightarrow>\<sigma>"  ("_ knows _") where "X knows \<phi> \<equiv> \<^bold>[KnowsAccessibilityRel X\<^bold>] \<phi> "   
definition  Believes::"Entity\<Rightarrow>\<sigma>\<Rightarrow>\<sigma>"  ("_ believes _") where "X believes \<phi> \<equiv> \<^bold>[BeliefAccessibilityRel X\<^bold>] \<phi> "   
definition  Obligation::"Entity\<Rightarrow>\<sigma>\<Rightarrow>\<sigma>"  ("_ must-do _") where "X must-do \<phi> \<equiv> \<^bold>[ObligationAccessibilityRel X\<^bold>] \<phi> "

(* We can introduce some further derived modal NL phrases *)
definition Lies ("lies _") where "lies X \<equiv> \<^bold>\<forall>Y. If (X says Y) then not Y"
definition Says_the_truth ("says-the-truth _") 
  where "says-the-truth X \<equiv> \<^bold>\<forall>Y. If (X says Y) then Y" 

(* We add the above defintions to our "bag" called "Defs" — Unimportant *)
named_theorems Defs
declare Says_def [Defs] Knows_def [Defs] Believes_def [Defs] Obligation_def [Defs] 
 Lies_def [Defs] Says_the_truth_def [Defs] 

(***********************************************************************************
 ****************** Controlled Natural Language Library ****************************
 ****************** Domain specific concepts ***************************************
 ***********************************************************************************)

(* Uninterpreted predicate: Lives_in *)
consts Lives_in::"Entity\<Rightarrow>Street\<Rightarrow>\<sigma>" ("_ lives-in _") 

(* Further derived NL phrases that concern "Lives_in" *)
definition Lives_not_in ("_ lives-not-in _")
  where "X lives-not-in G \<equiv> not (X lives-in G)"
definition Neither_nor_live_in ("neither _ nor _ live-in _") 
  where "neither X nor Y live-in G \<equiv> (not (X lives-in G)) and (not (Y lives-in G))"
definition Both_live_in ("both _ and _ live-in _") 
  where "both X and Y live-in G \<equiv> (X lives-in G) and (Y lives-in G)"

(* We add the above defintions to our "bag" called "Defs" — Unimportant *)
declare Lives_not_in_def [Defs] Neither_nor_live_in_def [Defs] Both_live_in_def [Defs] 

end
