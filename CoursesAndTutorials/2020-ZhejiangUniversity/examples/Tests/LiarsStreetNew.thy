theory LiarsStreetNew        (*Christoph Benzmüller, 2020*)
  (* imports BaseKnowledgeClassical *)
  imports BaseKnowledgeModalLogic
begin          
(*unimportant*) nitpick_params [user_axioms,assms=true,format=2,box=false,show_all]
(*unimportant*) declare [[show_abbrevs=false]]

axiomatization where
A1:  "\<forall>X. \<lfloor>If (X lives-in LiarsStreet) then (lies X)\<rfloor>"  and
A2:  "\<forall>X. \<lfloor>If (X lives-in TruthtellersRoad) then (says-the-truth X)\<rfloor>" 

lemma Question1:
  assumes
   "\<lfloor>Nilda says (Carla lives-in TruthtellersRoad)\<rfloor>" 
   "\<lfloor>Carla says (Nilda lives-in TruthtellersRoad)\<rfloor>"
 shows
   "\<lfloor>((Nilda lives-in S1) and (Carla lives-in S2))\<rfloor>"       
  nitpick[satisfy,max_genuine=10] 
  oops

lemma Question1b:
  assumes
   "\<lfloor>Nilda says (Carla lives-in TruthtellersRoad)\<rfloor>" 
   "\<lfloor>Carla says (Nilda lives-in TruthtellersRoad)\<rfloor>"
 shows  
  "\<lfloor>(both Nilda and Carla live-in S1)\<rfloor>"
  nitpick[satisfy, show_all] oops

lemma Question1b:
  assumes
   "\<lfloor>Nilda says (Carla lives-in TruthtellersRoad)\<rfloor>\<^sub>c\<^sub>w" 
   "\<lfloor>Carla says (Nilda lives-in TruthtellersRoad)\<rfloor>\<^sub>c\<^sub>w"
 shows  
  "\<not>\<lfloor>(both Nilda and Carla live-in LiarsStreet)\<rfloor>\<^sub>c\<^sub>w"
  unfolding Defs sledgehammer
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
  nitpick[satisfy,show_all] oops

lemma Question4:
  assumes
   "\<lfloor>Nilda says (Nilda says (Nilda lives-in LiarsStreet))\<rfloor>" 
 shows
   "\<lfloor>(Nilda lives-in S1)\<rfloor>"    
  nitpick[satisfy,show_all] oops

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


(*** Do we run into Paradoxes with the modelling of modalities? ***)

consts It_holds_that_One_plus_One_Equals_Two::\<sigma> 
       It_holds_that_Fermats_last_Theorem_is_True::\<sigma>

lemma Question8:
  assumes
   "\<lfloor>It_holds_that_One_plus_One_Equals_Two\<rfloor>" 
   "\<lfloor>It_holds_that_Fermats_last_Theorem_is_True\<rfloor>" 
   "\<lfloor>Carla says It_holds_that_One_plus_One_Equals_Two\<rfloor>"
  shows
   "\<lfloor>Carla says It_holds_that_Fermats_last_Theorem_is_True\<rfloor>"  
  sledgehammer [verbose](assms)
  nitpick oops

lemma Question9:
  assumes
   "\<lfloor>It_holds_that_One_plus_One_Equals_Two\<rfloor>" 
   "\<lfloor>It_holds_that_Fermats_last_Theorem_is_True\<rfloor>" 
   "\<lfloor>Carla knows It_holds_that_One_plus_One_Equals_Two\<rfloor>"
  shows
   "\<lfloor>Carla knows It_holds_that_Fermats_last_Theorem_is_True\<rfloor>"  
  sledgehammer [verbose](assms)
  nitpick oops
end