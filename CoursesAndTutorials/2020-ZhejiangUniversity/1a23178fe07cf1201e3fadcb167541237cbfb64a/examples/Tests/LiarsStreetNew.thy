theory LiarsStreetNew        (*Christoph Benzmüller, 2020*)
  imports  BaseLogicClassical

begin          
(*unimportant*) nitpick_params [user_axioms,format=2,show_all]


(***********************************************************************************
 ******************  Controlled Natural Language Library ***************************
 ******************  PART 1: Logic and Modalities             ***************************
 ***********************************************************************************)

(*** NL phrases: standard logical connectives; examples ***)
abbreviation And ("_ and _") where "X and Y \<equiv> X \<^bold>\<and> Y"
abbreviation Or ("_ or _") where "X or Y \<equiv> X \<^bold>\<or> Y"
abbreviation Not ("not _") where "not X \<equiv> \<^bold>\<not>X"
abbreviation If_then ("If _ then _") where "If X then Y \<equiv> X \<^bold>\<rightarrow> Y"

abbreviation Forall (binder"Forall" [8] 9) where "Forall x. \<phi>(x) \<equiv> \<^bold>\<forall>\<phi>"  
abbreviation Exists (binder"Exists" [8] 9) where "Exists x. \<phi>(x) \<equiv> \<^bold>\<exists>\<phi>"  

(*** NL phrases: modal connectives; examples ***)

(* Entities have different modal accessibility relations for "Says" "Knows" "Belief" "Obligation", etc.;
    a technical  solution that is not relevant for the 'normal' reader *)
consts SaysAccessibilityRel::"'a\<Rightarrow>\<tau>"
consts KnowsAccessibilityRel::"'a\<Rightarrow>\<tau>"
consts BeliefAccessibilityRel::"'a\<Rightarrow>\<tau>"
consts ObligationAccessibilityRel::"'a\<Rightarrow>\<tau>"

(* We can introduce modal NL phrases *)
definition  Says::"'a\<Rightarrow>\<sigma>\<Rightarrow>\<sigma>"  ("_ says _")  where "X says \<phi> \<equiv> \<^bold>[SaysAccessibilityRel X\<^bold>] \<phi> "    
definition  Knows::"'a\<Rightarrow>\<sigma>\<Rightarrow>\<sigma>"  ("_ knows _") where "X knows \<phi> \<equiv> \<^bold>[KnowsAccessibilityRel X\<^bold>] \<phi> "   
definition  Beliefs::"'a\<Rightarrow>\<sigma>\<Rightarrow>\<sigma>"  ("_ believes _") where "X believes \<phi> \<equiv> \<^bold>[BeliefAccessibilityRel X\<^bold>] \<phi> "   
definition  Obligation::"'a\<Rightarrow>\<sigma>\<Rightarrow>\<sigma>"  ("_ must-do _") where "X must-do \<phi> \<equiv> \<^bold>[ObligationAccessibilityRel X\<^bold>] \<phi> "

(* We can introduce some further derived modal NL phrases *)
definition Lies ("lies _") where "lies X \<equiv> \<^bold>\<forall>Y. If (X says Y) then not Y"
definition Says_the_truth ("says-the-truth _") where "says-the-truth X \<equiv> \<^bold>\<forall>Y. If (X says Y) then Y" 


(***********************************************************************************
 ******************  Controlled Natural Language Library ***************************
 ******************  PART 2: TBOX                                    ***************************
 ***********************************************************************************)

(* Uninterpreted predicate: Lives_in *)
consts Lives_in::"'a\<Rightarrow>'b\<Rightarrow>\<sigma>" ("_ lives-in _") 

(* Further derived NL phrases that concern "Lives_in" *)
definition Lives_not_in ("_ lives-not-in _")
  where "X lives-not-in G \<equiv> not (X lives-in G)"
definition Neither_nor_live_in ("neither _ nor _ live-in _") 
  where "neither X nor Y live-in G \<equiv> (not (X lives-in G)) and (not (Y lives-in G))"
definition Both_live_in ("both _ and _ live-in _") 
  where "both X and Y live-in G \<equiv> (X lives-in G) and (Y lives-in G)"


(* There are some kids, could be many more *)
datatype Kids = Nilda | Carla | Chris | Max   

(* There are two roads, could be many more *)
datatype Streets = LiarsStreet | TruthtellersRoad  | Bahnhofstrasse
   

axiomatization where
A1:  "\<lfloor>Forall X. If (X lives-in LiarsStreet) then (lies X)\<rfloor>"  and
A2:  "\<lfloor>Forall X. If (X lives-in TruthtellersRoad) then (says-the-truth X)\<rfloor>" 

lemma Question1:
  assumes
   "\<lfloor>Nilda says (Carla lives-in TruthtellersRoad)\<rfloor>" 
   "\<lfloor>Carla says (Nilda lives-in TruthtellersRoad)\<rfloor>"
 shows
   "\<lfloor>((Nilda lives-in S1) and (Carla lives-in S2))\<rfloor>"       
  nitpick[satisfy] oops 


lemma Question1a:
  assumes
   "\<lfloor>Nilda says (Carla lives-in TruthtellersRoad)\<rfloor>" 
   "\<lfloor>Carla says (Nilda lives-in TruthtellersRoad)\<rfloor>"
 shows "\<exists> S1 S2. (((Nilda lives-in S1) and (Carla lives-in S2)) and (not (S1 = TruthtellersRoad)))" 
  nitpick[satisfy] oops

lemma Question1b:
  assumes
   "\<lfloor>Nilda says (Carla lives-in TruthtellersRoad)\<rfloor>" 
   "\<lfloor>Carla says (Nilda lives-in TruthtellersRoad)\<rfloor>"
 shows  
  "(both Nilda and Carla live-in TruthtellersRoad)"
  nitpick[satisfy, show_all] oops


lemma Question2:
  assumes
   "\<lfloor>Nilda says (Carla lives-in LiarsStreet)\<rfloor>"  
   "\<lfloor>Carla says (neither Nilda nor Carla live-in LiarsStreet)\<rfloor>"
  shows
   "\<lfloor>((Nilda lives-in S1) and (Carla lives-in S2))\<rfloor>"              
  nitpick[satisfy] oops


lemma Question3:
  assumes
   "\<lfloor>Nilda says (Carla lives-in LiarsStreet)\<rfloor>" 
   "\<lfloor>Carla says (Carla lives-in LiarsStreet)\<rfloor>" 
 shows
   "\<lfloor>((Nilda lives-in S1) and (Carla lives-in S2))\<rfloor>"    
  nitpick[satisfy] oops

lemma Question4:
  assumes
   "\<lfloor>Nilda says (Nilda says (Nilda lives-in LiarsStreet))\<rfloor>" 
 shows
   "\<lfloor>(Nilda lives-in S1)\<rfloor>"    
  nitpick[satisfy] oops

lemma Question5:
  assumes
   "\<lfloor>Nilda says (Nilda says (Nilda lives-not-in LiarsStreet))\<rfloor>" 
 shows
   "\<lfloor>(Nilda lives-in S1)\<rfloor>"    
  nitpick[satisfy] oops

lemma Question6:
  assumes
   "\<lfloor>Nilda says (Nilda says ((Nilda lives-in LiarsStreet) and (Nilda lives-in TruthtellersRoad)))\<rfloor>" 
 shows
   "\<lfloor>(Nilda lives-in S1)\<rfloor>"    
  nitpick[satisfy] oops

lemma Question7:
  assumes
   "\<lfloor>Nilda says (Carla says ((Nilda lives-in LiarsStreet) and (Nilda lives-in TruthtellersRoad)))\<rfloor>" 
 shows
   "\<lfloor>((Nilda lives-in S1) and (Carla lives-in S2))\<rfloor>"    
  nitpick[satisfy] oops

consts A::\<sigma> B::\<sigma>
lemma Question4:
  assumes
   "\<lfloor>A\<rfloor>" 
   "\<lfloor>B\<rfloor>" 
   "\<lfloor>Carla says A\<rfloor>"
  shows
   "\<lfloor>Carla says B\<rfloor>"  
  sledgehammer[verbose](assms)
  using assms(1) assms(2) assms(3) by auto
  nitpick[card i = 6] oops


consts Knows::"Kids\<Rightarrow>\<sigma>\<Rightarrow>\<sigma>"  ("_ knows _") 

lemma Question5:
  assumes
   "\<lfloor>A\<rfloor>"
   "\<lfloor>B\<rfloor>" 
   "\<lfloor>Carla knows A\<rfloor>"
  shows
   "\<lfloor>Carla knows B\<rfloor>"  
   sledgehammer[verbose](assms)
  using assms(1) assms(2) assms(3) by auto
end