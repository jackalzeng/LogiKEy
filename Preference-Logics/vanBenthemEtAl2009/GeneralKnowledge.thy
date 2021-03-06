theory GeneralKnowledge (*Benzmüller, Fuenmayor & Lomfeld, 2020*)  
  imports ValueOntology 
begin (*** General Legal and World Knowledge (LWK) ***)

(*LWK: kinds of situations addressed*)
consts appObject::"\<sigma>"     (*appropriation of objects in general*)
consts appAnimal::"\<sigma>"     (*appropriation of animals in general*)
consts appWildAnimal::"\<sigma>" (*appropriation of wild animals*)
consts appDomAnimal::"\<sigma>"  (*appropriation of domestic animals*)

(*LWK: postulates for kinds of situations*)
axiomatization where 
 W1: "\<lfloor>(appWildAnimal \<^bold>\<or> appDomAnimal) \<^bold>\<leftrightarrow> appAnimal\<rfloor>" and 
 W2: "\<lfloor>appWildAnimal \<^bold>\<leftrightarrow> \<^bold>\<not>appDomAnimal\<rfloor>" and 
 W3: "\<lfloor>appWildAnimal \<^bold>\<rightarrow> appAnimal\<rfloor>"  and
 W4: "\<lfloor>appDomAnimal \<^bold>\<rightarrow> appAnimal\<rfloor>" and
 W5: "\<lfloor>appAnimal \<^bold>\<rightarrow> appObject\<rfloor>" 
(*\<dots>further situations regarding appropriation of objects, etc.*)

(*LWK: (prima facie) value preferences for kinds of situations*)
axiomatization where 
 R1: "\<lfloor>appAnimal \<^bold>\<rightarrow> (STAB\<^sup>p \<^bold>\<prec>\<^sub>v STAB\<^sup>d)\<rfloor>" and
 R2: "\<lfloor>appWildAnimal \<^bold>\<rightarrow> (WILL\<^sup>x\<inverse> \<^bold>\<prec>\<^sub>v STAB\<^sup>x)\<rfloor>" and         
 R3: "\<lfloor>appDomAnimal  \<^bold>\<rightarrow> (STAB\<^sup>x\<inverse> \<^bold>\<prec>\<^sub>v RELI\<^sup>x\<^bold>\<oplus>RESP\<^sup>x)\<rfloor>"
(*\<dots>further preferences\<dots>*)

(*LWK: domain vocabulary*)
typedecl e    (*declares new type for 'entities'*)
consts Animal::"e\<Rightarrow>\<sigma>" 
consts Domestic::"e\<Rightarrow>\<sigma>" 
consts Fox::"e\<Rightarrow>\<sigma>" 
consts Parrot::"e\<Rightarrow>\<sigma>" 
consts Pet::"e\<Rightarrow>\<sigma>" 
consts FreeRoaming::"e\<Rightarrow>\<sigma>" 

(*LWK: taxonomic (domain) knowledge*)
axiomatization where 
 W6: "\<lfloor>\<^bold>\<forall>a. Fox a \<^bold>\<rightarrow> Animal a\<rfloor>" and
 W7: "\<lfloor>\<^bold>\<forall>a. Parrot a \<^bold>\<rightarrow> Animal a\<rfloor>" and
 W8: "\<lfloor>\<^bold>\<forall>a. (Animal a \<^bold>\<and> FreeRoaming a \<^bold>\<and> \<^bold>\<not>Pet a) \<^bold>\<rightarrow> \<^bold>\<not>Domestic a\<rfloor>"
(*\<dots>others\<dots>*)

(*LWK: legally-relevant, situational 'factors'*)
consts Own::"c\<Rightarrow>\<sigma>"    (*object is owned by party c*)
consts Poss::"c\<Rightarrow>\<sigma>"   (*party c has actual possession of object*)
consts Intent::"c\<Rightarrow>\<sigma>" (*party c has intention to possess object*)
consts Mal::"c\<Rightarrow>\<sigma>" (*party c acts out of malice*)
consts Mtn::"c\<Rightarrow>\<sigma>" (*party c respons. for maintenance of object*)

(*LWK: meaning postulates for general notions*)
axiomatization where
 W9: "\<lfloor>Poss x \<^bold>\<rightarrow> (\<^bold>\<not>Poss x\<inverse>)\<rfloor>" and 
 W10: "\<lfloor>Own x \<^bold>\<rightarrow> (\<^bold>\<not>Own x\<inverse>)\<rfloor>"
 (*\<dots>others\<dots>*)

(*LWK: conditional value preferences, e.g. from precedents*)
axiomatization where 
 R4: "\<lfloor>(Mal x\<inverse> \<^bold>\<and> Own x)  \<^bold>\<rightarrow> (STAB\<^sup>x\<inverse> \<^bold>\<prec>\<^sub>v RESP\<^sup>x\<^bold>\<oplus>RELI\<^sup>x)\<rfloor>"
 (*\<dots>others\<dots>*)

(*LWK: relate values, outcomes and situational 'factors'*)
axiomatization where 
 F1: "\<lfloor>For x \<^bold>\<rightarrow> (Intent x \<^bold>\<leftrightarrow> \<^bold>\<box>\<^sup>\<preceq>[WILL\<^sup>x])\<rfloor>" and  
 F2: "\<lfloor>For x \<^bold>\<rightarrow> (Mal x\<inverse> \<^bold>\<leftrightarrow> \<^bold>\<box>\<^sup>\<preceq>[RESP\<^sup>x])\<rfloor>" and  
 F3: "\<lfloor>For x \<^bold>\<rightarrow> (Poss x \<^bold>\<leftrightarrow> \<^bold>\<box>\<^sup>\<preceq>[STAB\<^sup>x])\<rfloor>" and  
 F4: "\<lfloor>For x \<^bold>\<rightarrow> (Mtn x \<^bold>\<leftrightarrow> \<^bold>\<box>\<^sup>\<preceq>[RESP\<^sup>x])\<rfloor>" and  
 F5: "\<lfloor>For x \<^bold>\<rightarrow> (Own x \<^bold>\<leftrightarrow> \<^bold>\<box>\<^sup>\<preceq>[RELI\<^sup>x])\<rfloor>"

(*theory is consistent, (non-trivial) model found*)
lemma True nitpick[satisfy,card i=10] oops
end

