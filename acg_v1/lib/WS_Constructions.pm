#!/usr/bin/env perl

package WS_Constructions;

use strict;
use warnings;

#_! EXPORTING WORD, PHRASE, SENTENCE CONSTRUCTIONS AND ANAPHORA RESOLUTION RULES:

use Exporter qw(import);
our @EXPORT = qw(@w_constr @phr_constr @s_constr @rules);

####### ####### ####### ####### #######　#######　####### ####### ####### ####### ####### #######　#######　#######

#___WORD CONSTRUCTIONS

#___a___

my %a_w;

$a_w{'CONSTRUCTION'} = 'a_w';

$a_w{'SEM_POLE'} = {
    
    'meaning' => 'indefiniteness',
    'match_by_this_and_ID' => 'yes',
    'sem_ID' => 'specifier',
};

$a_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'a',
    'syn_ID' => 'determiner',
};

#___advocated___

my %advocated_w;

$advocated_w{'CONSTRUCTION'} = 'advocated_w';

$advocated_w{'SEM_POLE'} = {
    
    'implies' => 'approval',
    'match_by_this_and_ID' => 'yes',
    'sem_ID' => 'event',
	'tense' => 'past',
};

$advocated_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'advocated',
    'syn_ID' => 'verb',
};

#___all___

my %all_w;

$all_w{'CONSTRUCTION'} = 'all_w';

$all_w{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'sem_ID' => 'specifier',
};

$all_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'all',
    'syn_ID' => 'adjective',
};

#___at___

my %at_w;

$at_w{'CONSTRUCTION'} = 'at_w';

$at_w{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'meaning' => 'at',
    'sem_ID' => 'specifier',
};

$at_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'at',
    'syn_ID' => 'preposition',
};

#___available___

my %available_adj;

$available_adj{'CONSTRUCTION'} = 'available_adj';

$available_adj{'SEM_POLE'} = {
    
    'implies' => 'presence',
    'match_by_this_and_ID' => 'yes',
    'sem_ID' => 'selector',
};

$available_adj{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'available',
    'syn_ID' => 'adjective',
};

#___because___

my %because_w;

$because_w{'CONSTRUCTION'} = 'because_w';

$because_w{'SEM_POLE'} = {
	
	'main_clause' => 'undef',
	'match_by_this_and_ID' => 'yes',
	'sem_ID' => 'subordinator',
	'subordinate_clause' => 'undef',
};
	
	$because_w{'SYN_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'string' => 'because',
	'syn_ID' => 'conjunction',
};
	
#___Billy___

my %billy_w;

$billy_w{'CONSTRUCTION'} = 'billy_w';

$billy_w{'SEM_POLE'} = {
    
    'is' =>  'undef',
	'match_by_this_and_ID' => 'yes',
    'nominal' => 'yes',
    'sem_ID' => 'identifier',
	'used_as_agent' =>  'undef',
	'used_as_patient' =>  'undef',
};

$billy_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'billy',
    'syn_ID' => 'noun',
};

#___brown___

my %brown_w;

$brown_w{'CONSTRUCTION'} = 'brown_w';

$brown_w{'SEM_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'meaning' => 'brown',
	'sem_ID' => 'selector',
};

$brown_w{'SYN_POLE'} = {
  
	'match_by_this_and_ID' => 'yes',
	'string' => 'brown',
	'syn_ID' => 'adjective',
};

#___but___

my %but_c;

$but_c{'CONSTRUCTION'} = 'but_c';

$but_c{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'sem_ID' => 'coordinator',
};

$but_c{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'but',
    'syn_ID' => 'conjunction',
};

#___call___

my %call_v;

$call_v{'CONSTRUCTION'} = 'call_v';

$call_v{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'sem_ID' => 'event',
};

$call_v{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'call',
    'syn_ID' => 'verb',
};

#___city___

my %city_w;

$city_w{'CONSTRUCTION'} = 'city_w';

$city_w{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'sem_ID' => 'selector',
};

$city_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'city',
    'syn_ID' => 'adjective',
};

#___comforted___

my %comforted_w;

$comforted_w{'CONSTRUCTION'} = 'comforted_w';

$comforted_w{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'meaning_category' => 'consolation',
    'sem_ID' => 'event',
};

$comforted_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'comforted',
    'syn_ID' => 'verb',
};

#___couldn't___

my %couldn_t_w;

$couldn_t_w{'CONSTRUCTION'} = "couldn't_w";

$couldn_t_w{'SEM_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'meaning' => "couldn't",
	'modality_type' => 'impossibility',
	'sem_ID' => 'modal',
};

$couldn_t_w{'SYN_POLE'} = {
  
	'match_by_this_and_ID' => 'yes',
	'string' => 'couldn\'t',
	'syn_ID' => 'auxiliary',
};

#___councilmen___

my %councilmen_w;

$councilmen_w{'CONSTRUCTION'} = 'councilmen_w';

$councilmen_w{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'sem_ID' => 'identifier',
};

$councilmen_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
	'number' => 'plural',
    'string' => 'councilmen',
    'syn_ID' => 'noun',
};

#___demonstrators___

my %demonstrators_w;

$demonstrators_w{'CONSTRUCTION'} = 'demonstrators_w';

$demonstrators_w{'SEM_POLE'} = {
    
    'animate' => 'yes',
    'match_by_this_and_ID' => 'yes',
    'sem_ID' => 'identifier',
};

$demonstrators_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'demonstrators',
    'number' => 'plural',
    'syn_ID' => 'noun',
};

#___doesn't___

my %doesn_t_w;

$doesn_t_w{'CONSTRUCTION'} = "doesn_t_w";

$doesn_t_w{'SEM_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'sem_ID' => 'auxil',
	'tense' => "present",
};

$doesn_t_w{'SYN_POLE'} = {
  
	'match_by_this_and_ID' => 'yes',
	'string' => 'doesn\'t',
	'syn_ID' => 'verb',
};

#___feared___

my %feared_w;

$feared_w{'CONSTRUCTION'} = 'feared_w';

$feared_w{'SEM_POLE'} = {
    
    'implies' => 'concern',
    'match_by_this_and_ID' => 'yes',
    'sem_ID' => 'event',
	'tense' => 'past',
};

$feared_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'feared',
    'syn_ID' => 'verb',
};

#___fit___

my %fit_w;

$fit_w{'CONSTRUCTION'} = 'fit_w';

$fit_w{'SEM_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'meaning' => 'fit',
	'sem_ID' => 'event',
};

$fit_w{'SYN_POLE'} = {
  
	'match_by_this_and_ID' => 'yes',
	'string' => 'fit',
	'syn_ID' => 'verb',
};

#___for___

my %for_w;

$for_w{'CONSTRUCTION'} = 'for_w';

$for_w{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'sem_ID' => 'funct',
};

$for_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'for',
    'syn_ID' => 'preposition',
};

#___front___

my %front_w;

$front_w{'CONSTRUCTION'} = 'front_w';

$front_w{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'sem_ID' =>  'identifier',
};

$front_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'front',
    'syn_ID' => 'noun',
};

#___George___

my %george_n;

$george_n{'CONSTRUCTION'} = 'george_n';

$george_n{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'nominal' => 'yes',
    'sem_ID' => 'identifier',
	'used_as_agent' =>  'undef',
	'used_as_patient' =>  'undef',
};

$george_n{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'george',
    'syn_ID' => 'noun',
};

#___given___

my %given_w;

$given_w{'CONSTRUCTION'} = 'given_w';

$given_w{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
	'sem_ID' => 'event_and_specifier',
	'subject_thematic_relation' => 'agent',
};

$given_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
	'string' => 'given',
    'syn_ID' => 'participle',
	'tense' => 'past',
};

#___had_auxiliary___

my %had_auxiliary_w;

$had_auxiliary_w{'CONSTRUCTION'} = 'had_auxiliary_w';

$had_auxiliary_w{'SEM_POLE'} = {
    
    'sem_ID' => 'auxiliary',
	'tense' => 'past_perfect',
};

$had_auxiliary_w{'SYN_POLE'} = {
    
    'string' => 'had',
    'syn_ID' => 'verb',
};

#___he___

my %he_w;

$he_w{'CONSTRUCTION'} = 'he_w';

$he_w{'SEM_POLE'} = {
	
	'case' => 'nominative',
	'match_by_this_and_ID' => 'yes',
	'modified_by' => 'undef',
	'pronoun_type' => 'personal',
	'sem_ID' => 'identifier',
};

$he_w{'SYN_POLE'} = {
  
	'match_by_this_and_ID' => 'yes',
	'string' => 'he',
	'syn_ID' => 'pronoun',
};

#___heavy___

my %heavy_w;

$heavy_w{'CONSTRUCTION'} = 'heavy_w';

$heavy_w{'SEM_POLE'} = {
	
	'implies' => 'hindrance',
	'match_by_this_and_ID' => 'yes',
	'meaning' => 'heavy',
	'sem_ID' => 'selector',
};

$heavy_w{'SYN_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'string' => 'heavy',
	'syn_ID' => 'adjective',
};

#___help___

my %help_w;

$help_w{'CONSTRUCTION'} = 'help_w';

$help_w{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'sem_ID' => 'identifier',
};

$help_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'help',
    'syn_ID' => 'noun',
};

#___him___

my %him_w;

$him_w{'CONSTRUCTION'} = 'him_w';

$him_w{'SEM_POLE'} = {
	
	'case' => 'accusative',
	'match_by_this_and_ID' => 'yes',
	'pronoun_type' => 'personal',
	'sem_ID' => 'identifier',
};

$him_w{'SYN_POLE'} = {
  
	'match_by_this_and_ID' => 'yes',
	'string' => 'him',
	'syn_ID' => 'pronoun',
};

#___his___

my %his_w;

$his_w{'CONSTRUCTION'} = 'his_w';

$his_w{'SEM_POLE'} = {
	
	'meaning' => 'masculine_entity_associated',
	'match_by_this_and_ID' => 'yes',
	'sem_ID' => 'specifier',
};

$his_w{'SYN_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'string' => 'his',
	'syn_ID' => 'determiner',
};

#___in___

my %in_w;

$in_w{'CONSTRUCTION'} = 'in_w';

$in_w{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'sem_ID' => 'specifier',
};

$in_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'in',
    'syn_ID' => 'preposition',
};

#___into___

my %into_w;

$into_w{'CONSTRUCTION'} = 'into_w';

$into_w{'SEM_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'meaning' => 'into',
	'sem_ID' => 'specifier',
};

$into_w{'SYN_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'string' => 'into',
	'syn_ID' => 'preposition',
};

#___is___

my %is_w;

$is_w{'CONSTRUCTION'} = 'is_w';

$is_w{'SEM_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'meaning' => 'is',
	'sem_ID' => 'stative',
};

$is_w{'SYN_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'string' => "is|'s", #_! alternative forms MUST be | separated
	'syn_ID' => 'copula',
};

#___it___

my %it_w;

$it_w{'CONSTRUCTION'} = 'it_w';

$it_w{'SEM_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'modified_by' => 'undef',
	'pronoun_type' => 'personal',
	'sem_ID' => 'identifier',
};

$it_w{'SYN_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'string' => 'it',
	'syn_ID' => 'pronoun',
};

#___Jim___

my %jim_w;

$jim_w{'CONSTRUCTION'} = 'jim_w';

$jim_w{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
	'meaning_category' => 'human',
	'nominal' => 'yes',
    'sem_ID' => 'identifier',
	'used_as_agent' =>  'undef',
	'used_as_patient' =>  'undef',
};

$jim_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'jim',
    'syn_ID' => 'noun',
};

#___Joan___

my %joan_w;

$joan_w{'CONSTRUCTION'} = 'joan_w';

$joan_w{'SEM_POLE'} = {
    
    'is' =>  'undef',
	'match_by_this_and_ID' => 'yes',
    'nominal' => 'yes',
    'sem_ID' => 'identifier',
	'used_as_agent' =>  'undef',
	'used_as_patient' =>  'undef',
};

$joan_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'joan',
    'syn_ID' => 'noun',
};

#___Jonh___

my %john_w;

$john_w{'CONSTRUCTION'} = 'john_w';

$john_w{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'nominal' => 'yes',
    'sem_ID' => 'identifier',
	'used_as_agent' =>  'undef',
	'used_as_patient' =>  'undef',
};

$john_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'john',
    'syn_ID' => 'noun',
};

#___Kevin___

my %kevin_w;

$kevin_w{'CONSTRUCTION'} = 'kevin_w';

$kevin_w{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'nominal' => 'yes',
    'sem_ID' => 'identifier',
	'used_as_agent' =>  'undef',
	'used_as_patient' =>  'undef',
};

$kevin_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'kevin',
    'syn_ID' => 'noun',
};

#___large___

my %large_w;

$large_w{'CONSTRUCTION'} = 'large_w';

$large_w{'SEM_POLE'} = {
	
	'implies' => 'obstacle',
	'match_by_this_and_ID' => 'yes',
	'sem_ID' => 'selector',
};

$large_w{'SYN_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'string' => 'large',
	'syn_ID' => 'adjective',
};

#___lift___

my %lift_w;

$lift_w{'CONSTRUCTION'} = 'lift_w';

$lift_w{'SEM_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'meaning' => 'lift',
	'sem_ID' => 'event',
};

$lift_w{'SYN_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'string' => 'lift',
	'syn_ID' => 'verb',
};

my %made_w;

$made_w{'CONSTRUCTION'} = 'made_w';

$made_w{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'sem_ID' => 'event',
	'tense' => 'past',
};

$made_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'made',
    'syn_ID' => 'verb',
};

#___man___

my %man_w;

$man_w{'CONSTRUCTION'} = 'man_w';

$man_w{'SEM_POLE'} = {
	
	'animate' => 'yes',
	'match_by_this_and_ID' => 'yes',
	'meaning' => 'man',
	'sem_ID' => 'identifier',
};

$man_w{'SYN_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'number' => 'sg',
	'phrase_head' => 'undef',
	'string' => 'man',
	'syn_ID' => 'noun',
};

#___not___

my %not_adv;

$not_adv{'CONSTRUCTION'} = 'not_adv';

$not_adv{'SEM_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'sem_ID' =>  'negative',
};

$not_adv{'SYN_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'string' => 'not',
	'syn_ID' => 'adverb',
};

#___of___

my %of_w;

$of_w{'CONSTRUCTION'} = 'of_w';

$of_w{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'sem_ID' => 'specifier',
};

$of_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'of',
    'syn_ID' => 'preposition',
};

#___on___

my %on_pre;

$on_pre{'CONSTRUCTION'} = 'on_pre';

$on_pre{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'sem_ID' => 'specifier',
};

$on_pre{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'on',
    'syn_ID' => 'preposition',
};

#___Paul___

my %paul_w;

$paul_w{'CONSTRUCTION'} = 'paul_w';

$paul_w{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'sem_ID' => 'identifier',
	'used_as_agent' =>  'undef',
	'used_as_patient' =>  'undef',
	'nominal' => 'yes',
};

$paul_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'paul',
    'syn_ID' => 'noun',
};

#___permit___

my %permit_w;

$permit_w{'CONSTRUCTION'} = 'permit_w';

$permit_w{'SEM_POLE'} = {
    
    'animate' => 'no',
    'match_by_this_and_ID' => 'yes',
    'sem_ID' => 'identifier',
};

$permit_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'permit',
    'syn_ID' => 'noun',
};

#___phone___

my %phone_n;

$phone_n{'CONSTRUCTION'} = 'phone_n';

$phone_n{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'sem_ID' => 'identifier',
};

$phone_n{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'phone',
    'syn_ID' => 'noun',
};

#___received_participle____

my %received_participle_w;

$received_participle_w{'CONSTRUCTION'} = 'received_participle_w';

$received_participle_w{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
	'sem_ID' => 'event_and_specifier',
	'subject_thematic_relation' => 'beneficiary',
};

$received_participle_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
	'string' => 'received',
    'syn_ID' => 'participle',
	'tense' => 'past',
};

#___refused___

my %refused_w;

$refused_w{'CONSTRUCTION'} = 'refused_w';

$refused_w{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'sem_ID' => 'event',
	'tense' => 'past',
};

$refused_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'refused',
    'syn_ID' => 'verb',
};

#___'s (possessive)___

my %possessive_apostrophe_s_w;

$possessive_apostrophe_s_w{'CONSTRUCTION'} = 'possessive_\'s_w';

$possessive_apostrophe_s_w{'SEM_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'sem_ID' => 'possessive',
};

$possessive_apostrophe_s_w{'SYN_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'string' => '\'s',
	'syn_ID' => 'ending',
};

#___see___

my %see_w;

$see_w{'CONSTRUCTION'} = 'see_w';

$see_w{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'meaning' => 'see',
    'sem_ID' => 'event',
};

$see_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'see',
    'syn_ID' => 'verb',
};

#___she___

my %she_w;

$she_w{'CONSTRUCTION'} = 'she_w';

$she_w{'SEM_POLE'} = {
	
	'case' => 'nominative',
	'match_by_this_and_ID' => 'yes',
	'pronoun_type' => 'personal',
	'sem_ID' => 'identifier',
};

$she_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'she',
    'syn_ID' => 'pronoun',
};

#___short___

my %short_w;

$short_w{'CONSTRUCTION'} = 'short_w';

$short_w{'SEM_POLE'} = {
	
	'implies' => 'ability_lack',
	'match_by_this_and_ID' => 'yes',
	'sem_ID' => 'selector',
};

$short_w{'SYN_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'string' => 'short',
	'syn_ID' => 'adjective',
};

#___small___

my %small_w;

$small_w{'CONSTRUCTION'} = 'small_w';

$small_w{'SEM_POLE'} = {
	
	'implies' => 'space_lack',
	'match_by_this_and_ID' => 'yes',
	'meaning' => 'small',
	'sem_ID' => 'selector',
};

$small_w{'SYN_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'string' => 'small',
	'syn_ID' => 'adjective',
};

#___so___

my %so_w;

$so_w{'CONSTRUCTION'} = 'so_w';

$so_w{'SEM_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'meaning' => 'so',
	'sem_ID' =>  'intensifier',
};

$so_w{'SYN_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'string' => 'so',
	'syn_ID' => 'adverb',
};

#___son___

my %son_w;

$son_w{'CONSTRUCTION'} = 'son_w';

$son_w{'SEM_POLE'} = {
	
	'animate' => 'yes',
	'match_by_this_and_ID' => 'yes',
	'meaning' => 'son',
	'sem_ID' => 'identifier',
};

$son_w{'SYN_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'number' => 'sg',
	'phrase_head' => 'undef',
	'string' => 'son',
	'syn_ID' => 'noun',
};

#___stage___

my %stage_w;

$stage_w{'CONSTRUCTION'} = 'stage_w';

$stage_w{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'meaning' => 'stage',
    'sem_ID' => 'identifier',
};

$stage_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'stage',
    'syn_ID' => 'noun',
};

#___successful___

my %successful_adj;

$successful_adj{'CONSTRUCTION'} = 'successful_adj';

$successful_adj{'SEM_POLE'} = {
    
    'implies' => 'accomplishment',
    'match_by_this_and_ID' => 'yes',
    'sem_ID' => 'selector',
};

$successful_adj{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'successful',
    'syn_ID' => 'adjective',
};

#___suitcase___

my %suitcase_w;

$suitcase_w{'CONSTRUCTION'} = 'suitcase_w';

$suitcase_w{'SEM_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'meaning' => 'suitcase',
	'sem_ID' => 'identifier',
};

$suitcase_w{'SYN_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'string' => 'suitcase',
	'syn_ID' => 'noun',
};

#___sure___

my %sure_w;

$sure_w{'CONSTRUCTION'} = 'sure_w';

$sure_w{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'sem_ID' => 'ev_spec',
};

$sure_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'sure',
    'syn_ID' => 'adverb',
};

#___Susan___

my %susan_w;

$susan_w{'CONSTRUCTION'} = 'susan_w';

$susan_w{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
	'nominal' => 'yes',
    'sem_ID' => 'identifier',
	'used_as_agent' =>  'undef',
	'used_as_patient' =>  'undef',
};

$susan_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'susan',
    'syn_ID' => 'noun',
};

#___tall___

my %tall_w;

$tall_w{'CONSTRUCTION'} = 'tall_w';

$tall_w{'SEM_POLE'} = {
	
	'implies' => 'obstruction',
	'match_by_this_and_ID' => 'yes',
	'sem_ID' => 'selector',
};

$tall_w{'SYN_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'string' => 'tall',
	'syn_ID' => 'adjective',
};

#___thank___

my %thank_w;

$thank_w{'CONSTRUCTION'} = 'thank_w';

$thank_w{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'sem_ID' => 'event',
};

$thank_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'thank',
    'syn_ID' => 'verb',
};

#___the___

my %the_w;

$the_w{'CONSTRUCTION'} = 'the_w';

$the_w{'SEM_POLE'} = {
	
	'meaning' => 'definiteness',
	'match_by_this_and_ID' => 'yes',
	'sem_ID' => 'specifier',
};

$the_w{'SYN_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'string' => 'the',
	'syn_ID' => 'determiner',
};

#___they___

my %they_w;

$they_w{'CONSTRUCTION'} = 'they_w';

$they_w{'SEM_POLE'} = {
    
    'case' => 'nominative',
	'match_by_this_and_ID' => 'yes',
	'pronoun_type' => 'personal',
	'sem_ID' => 'identifier',
};

$they_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'they',
    'syn_ID' => 'pronoun',
};

#___to___

my %to_w;

$to_w{'CONSTRUCTION'} = 'to_w';

$to_w{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'sem_ID' => 'funct',
};

$to_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'to',
    'syn_ID' => 'particle',
};

#___too___

my %too_w;

$too_w{'CONSTRUCTION'} = 'too_w';

$too_w{'SEM_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'meaning' => 'too',
	'sem_ID' =>  'intensifier',
};

$too_w{'SYN_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'string' => 'too',
	'syn_ID' => 'adverb',
};

#___try___

my %try_v;

$try_v{'CONSTRUCTION'} = 'try_v';

$try_v{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'sem_ID' => 'event',
	'tense' => 'present|past',
};

$try_v{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'try|tries|tried',
    'syn_ID' => 'verb',
};

#___trophy___

my %trophy_w;

$trophy_w{'CONSTRUCTION'} = 'trophy_w';

$trophy_w{'SEM_POLE'} = {
	
	'animate' => 'no',
	'match_by_this_and_ID' => 'yes',
	'meaning' => 'trophy',
	'sem_ID' => 'identifier',
};

$trophy_w{'SYN_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'string' => 'trophy',
	'syn_ID' => 'noun',
};

#___upset___

my %upset_w;

$upset_w{'CONSTRUCTION'} = 'upset_w';

$upset_w{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'similar_to' => 'agitated',
    'meaning' => 'upset',
    'sem_ID' =>  'selector',
};

$upset_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'upset',
    'syn_ID' => 'adjective',
};

#___violence___

my %violence_w;

$violence_w{'CONSTRUCTION'} = 'violence_w';

$violence_w{'SEM_POLE'} = {
    
    'is' => 'aggression',
    'match_by_this_and_ID' => 'yes',
    'sem_ID' => 'identifier',
};

$violence_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'violence',
    'syn_ID' => 'noun',
};

#___was___

my %was_w;

$was_w{'CONSTRUCTION'} = 'was_w';

$was_w{'SEM_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'sem_ID' => 'stative',
};

$was_w{'SYN_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'string' => 'was',
	'syn_ID' => 'copula',
};

#___wasn't___

my %wasn_t_v;

$wasn_t_v{'CONSTRUCTION'} = "wasn_t_v";

$wasn_t_v{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
	'negated' => 'yes',
    'sem_ID' => 'stative_neg',
};

$wasn_t_v{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'wasn\'t',
    'syn_ID' => 'copula_neg',
};

#___weak___

my %weak_w;

$weak_w{'CONSTRUCTION'} = 'weak_w';

$weak_w{'SEM_POLE'} = {
	
	'implies' => 'ability_lack',
	'match_by_this_and_ID' => 'yes',
	'sem_ID' => 'selector',
};

$weak_w{'SYN_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'string' => 'weak',
	'syn_ID' => 'adjective',
};

#___what___

my %what_w;

$what_w{'CONSTRUCTION'} = 'what_w';

$what_w{'SEM_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'meaning' => 'what',
	'sem_ID' => 'interrogative',
};

$what_w{'SYN_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'string' => 'what',
	'syn_ID' => 'pronoun',
};

#___who___

my %who_w;

$who_w{'CONSTRUCTION'} = 'who_w';

$who_w{'SEM_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'meaning' => 'who',
	'sem_ID' => 'interrogative',
};

$who_w{'SYN_POLE'} = {
	
	'match_by_this_and_ID' => 'yes',
	'string' => 'who',
	'syn_ID' => 'pronoun',
};

#___with___

my %with_w;

$with_w{'CONSTRUCTION'} = 'with_w';

$with_w{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'meaning' => 'with',
    'sem_ID' => 'specifier',
};

$with_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'with',
    'syn_ID' => 'preposition',
};

#___yelled___

my %yelled_w;

$yelled_w{'CONSTRUCTION'} = 'yelled_w';

$yelled_w{'SEM_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
	'meaning_category' => 'reproaching',
    'sem_ID' => 'event',
};

$yelled_w{'SYN_POLE'} = {
    
    'match_by_this_and_ID' => 'yes',
    'string' => 'yelled',
    'syn_ID' => 'verb',
};

####### ####### ####### ####### #######　#######　####### ####### ####### ####### ####### #######　#######　#######

#___PHRASE CONSTRUCTIONS

my %all_idp_p;

$all_idp_p{'CONSTRUCTION'} = 'all_idp_p';
    
$all_idp_p{'CONSTRUCTION_COMPONENTS'} = 'undef';

$all_idp_p{'DESCRIPTION'} = 'for phrases like "all the help"';
    
$all_idp_p{'SEM_POLE'} = {

    '1_spec' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'specifier',
    },  
    '2_ident_p' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'ident_p',
    },  
    '3_PU_all_idp_p' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'spec_idp_p',
    },
};
    
$all_idp_p{'SYN_POLE'} = {

    '1_adj' =>
    {
        'string' =>  'all',
        'syn_ID' =>  'adjective',
    },  
    '2_np' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'np',
    },  
    '3_PU_adj_np_p' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'all_np_p',
    },
};

#___ ___ ___

my %auxil_pastpart_phr;

$auxil_pastpart_phr{'CONSTRUCTION'} = 'auxil_pastpart_phr';
    
$auxil_pastpart_phr{'CONSTRUCTION_COMPONENTS'} = 'undef';

$auxil_pastpart_phr{'DESCRIPTION'} = 'for past perfect phrases like "had given"';
    
$auxil_pastpart_phr{'SEM_POLE'} = {

    '1_aux' =>
    {
        'tense' =>  'past_perfect',
        'sem_ID' =>  'auxiliary',
    },  
    '2_evandsp' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'event_and_specifier',
    },  
    '3_PU_auxil_evandsp_phr' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'auxil_evandsp_phr',
    },
};
    
$auxil_pastpart_phr{'SYN_POLE'} = {

    '1_v' =>
    {
        'string' => 'had',
        'syn_ID' =>  'verb',
    },  
    '2_part' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'participle',
    },  
    '3_PU_auxil_pastpart_phr' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'auxil_pastpart_phr',
    },
};

#___ ___ ___

my %auxil_verb_phr;

$auxil_verb_phr{'CONSTRUCTION'} = 'auxil_verb_phr';

$auxil_verb_phr{'CONSTRUCTION_COMPONENTS'} = 'undef';

$auxil_verb_phr{'SEM_POLE'} = {
    
    '1_function_w' =>
    {
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  'auxil',
    },
   
    '2_event' =>
    {
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  'event',
    },
    '3_PU_funct_ev_p' =>
    {
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  'funct_ev_p',
    },
};

$auxil_verb_phr{'SYN_POLE'} = {
    
    '1_auxiliary' =>
    {
		'match_by_this_and_ID' => 'yes',
		'syn_ID' => 'verb',
    },
    '2_verb' =>
    {
		'match_by_this_and_ID' => 'yes',
		'syn_ID' => 'verb',
    },
    '3_PU_auxil_verb_p' =>
    {
		'match_by_this_and_ID' => 'yes',
		'syn_ID' => 'auxil_verb_p',
    },
};

#___ ___ ___

my %det_adj_n_phr;

$det_adj_n_phr{'CONSTRUCTION'} = 'det_adj_n_phr';

$det_adj_n_phr{'CONSTRUCTION_COMPONENTS'} = 'undef';

$det_adj_n_phr{'SEM_POLE'} = {
	
	'1_specifier' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  'specifier',
	},
	'2_selector' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' => 'selector',
	},
	'3_identifier' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  'identifier',
	},
	'4_PU_sp_sel_id_p' =>
	{
		'match_by_this_and_ID' => 'yes',
		'nominal' => 'yes',
		'sem_ID' =>  'sp_sel_id_p',
		'used_as_agent' =>  'undef',
		'used_as_patient' =>  'undef',
	},
};

$det_adj_n_phr{'SYN_POLE'} = {
	
	'1_determiner' =>
	{
	  'match_by_this_and_ID' => 'yes',
	  'syn_ID' => 'determiner',
	},
	'2_adjective' =>
	{
	  'match_by_this_and_ID' => 'yes',
	  'syn_ID' => 'adjective',
	},
	'3_noun' =>
	{
	  'match_by_this_and_ID' => 'yes',
	  'syn_ID' => 'noun',
	  'phrase_head' => 'yes',
	},
	'4_PU_np' =>
	{
	  'match_by_this_and_ID' => 'yes',
	  'syn_ID' => 'det_adj_n_p',
	},
};

#___ ___ ___

my %det_n_phr;

$det_n_phr{'CONSTRUCTION'} = 'det_n_phr';

$det_n_phr{'CONSTRUCTION_COMPONENTS'} = 'undef';

$det_n_phr{'SEM_POLE'} = {
	
	'1_specifier' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  'specifier',
	},
	'2_identifier' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  'identifier',
	},
	'3_PU_ident_p' =>
	{
		'animate' => 'undef',
		'match_by_this_and_ID' => 'yes',
		'nominal' => 'yes',
		'sem_ID' =>  'ident_p',
		'used_as_agent' =>  'undef',
		'used_as_patient' =>  'undef',
	},
};

$det_n_phr{'SYN_POLE'} = {
	
	'1_determiner' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' => 'determiner',
	},
	'2_noun' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' => 'noun',
		'phrase_head' => 'yes',
	},
	'3_PU_np' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' => 'np',
	},
};

#___ ___ ___

my %ev_functevpp_p;

$ev_functevpp_p{'CONSTRUCTION'} = 'ev_functevpp_p';
    
$ev_functevpp_p{'CONSTRUCTION_COMPONENTS'} = 'undef';

$ev_functevpp_p{'DESCRIPTION'} = 'for phrases like "tried to call George on the phone"';
    
$ev_functevpp_p{'SEM_POLE'} = {

    '1_ev' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'event',
    },  
    '2_functevpp' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'funct_evidentphr_specidentphr_p',
    },  
    '3_PU_ev_functevpp_p' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'ev_functevpp_p',
    },
};
    
$ev_functevpp_p{'SYN_POLE'} = {

    '1_v' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'verb',
    },  
    '2_functvpp' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'particle_vnphr_prepnpp_p',
    },  
    '3_PU_v_functvpp_p' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'v_functvpp_p',
    },
};

#___ ___ ___

my %ev_ident_phr;

$ev_ident_phr{'CONSTRUCTION'} = 'ev_ident_phr';
    
$ev_ident_phr{'CONSTRUCTION_COMPONENTS'} = 'undef';

$ev_ident_phr{'DESCRIPTION'} = 'for phrases like "comforted Kevin"';
    
$ev_ident_phr{'SEM_POLE'} = {

    '1_ev' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'event|auxil_evandsp_phr',
    },  
    '2_ident' =>
    {
        'match_by_this_and_ID' => 'yes',
		'used_as_patient' =>  'yes',
        'sem_ID' =>  'identifier',
    },  
    '3_PU_ev_ident_phr' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'ev_ident_phr',
    },
};
    
$ev_ident_phr{'SYN_POLE'} = {

    '1_v' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'verb|auxil_pastpart_phr',
    },  
    '2_n' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'noun',
    },  
    '3_PU_v_n_phr' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'v_n_phr',
    },
};

#___ ___ ___

#___for phrases like "couldn't lift his son"___

my %evp_identp_p;

$evp_identp_p{'CONSTRUCTION'} = 'evp_identp_p';

$evp_identp_p{'CONSTRUCTION_COMPONENTS'} = 'undef';

$evp_identp_p{'SEM_POLE'} = {

	'1_evp' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  'mod_v_p',
	},  
	'2_identp' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  'ident_p',
		'used_as_patient' => 'yes',
	},  
	'3_PU_evp_identp_p' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  'evp_identp_p',
	},
};
	
$evp_identp_p{'SYN_POLE'} = {

	'1_vp' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' =>  'aux_v_p',
	},  
	'2_np' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' =>  'np',
	},  
	'3_PU_vp_np_p' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' =>  'vp_np_p',
	},
};

#___ ___ ___

my %ev_not_phr;

$ev_not_phr{'CONSTRUCTION'} = 'ev_not_phr';
    
$ev_not_phr{'CONSTRUCTION_COMPONENTS'} = 'undef';
    
$ev_not_phr{'SEM_POLE'} = {

    '1_ev' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'stative',
    },  
    '2_negative' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'negative',
    },  
    '3_PU_ev_not_phr' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'ev_not_phr',
    },
};
    
$ev_not_phr{'SYN_POLE'} = {

    '1_v' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'copula',
    },  
    '2_not' =>
    {
        'string' => 'not',
        'syn_ID' =>  'adverb',
    },  
    '3_PU_v_not_phr' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'v_not_phr',
    },
};

#___ ___ ___

my %ev_spec_ident_phr;

$ev_spec_ident_phr{'CONSTRUCTION'} = 'ev_spec_ident_phr';
    
$ev_spec_ident_phr{'CONSTRUCTION_COMPONENTS'} = 'undef';

$ev_spec_ident_phr{'DESCRIPTION'} = 'for phrases like "yelled at Kevin"';
    
$ev_spec_ident_phr{'SEM_POLE'} = {

    '1_ev' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'event',
    },  
    '2_spec' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'specifier',
    },  
    '3_ident' =>
    {
        'match_by_this_and_ID' => 'yes',
		'used_as_patient' =>  'yes',
        'sem_ID' =>  'identifier',
    },  
    '4_PU_ev_spec_ident_phr' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'ev_spec_ident_phr',
    },
};
    
$ev_spec_ident_phr{'SYN_POLE'} = {

    '1_v' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'verb',
    },  
    '2_prep' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'preposition',
    },  
    '3_n' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'noun',
    },  
    '4_PU_v_prep_n_phr' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'v_prep_n_phr',
    },
};

#___ ___ ___

my %evp_spec_identp_p;

$evp_spec_identp_p{'CONSTRUCTION'} = 'evp_spec_identp_p';

$evp_spec_identp_p{'CONSTRUCTION_COMPONENTS'} = 'undef';

$evp_spec_identp_p{'DESCRIPTION'} = 'for phrases like "doesn\'t fit into the brown suitcase"';

$evp_spec_identp_p{'SEM_POLE'} = {

	'1_funct_ev_p' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  'funct_ev_p',
	},  
	'2_specifier' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' => 'specifier',
	},  
	'3_sp_sel_id_p' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  'sp_sel_id_p',
		'used_as_patient' =>  'yes',
	},  
	'4_PU_evp_spec_identp_p' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  'ev_locat_p',
	},
};
	
$evp_spec_identp_p{'SYN_POLE'} = {

	'1_auxil_verb_p' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' => 'auxil_verb_p',
	},  
	'2_preposition' =>
	{
		'match_by_this_and_ID' => 'yes',
		'string' => 'into',
		'syn_ID' => 'preposition',
	},  
	'3_det_adj_n_p' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' => 'det_adj_n_p',
	},  
	'4_PU_vp_prep_detadjnp_p' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' =>  'vp_prp_p',
	},
};

#___ ___ ___

my %funct_evidentphr_specidentphr_p;

$funct_evidentphr_specidentphr_p{'CONSTRUCTION'} = 'funct_evidentphr_specidentphr_p';
    
$funct_evidentphr_specidentphr_p{'CONSTRUCTION_COMPONENTS'} = 'undef';

$funct_evidentphr_specidentphr_p{'DESCRIPTION'} = 'for phrases like "to call George on the phone"';
    
$funct_evidentphr_specidentphr_p{'SEM_POLE'} = {

    '1_funct' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'funct',
    },  
    '2_evidentphr' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'ev_ident_phr',
    },  
    '3_specidentphr' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'spec_identp_p',
    },  
    '4_PU_funct_evidentphr_specidentphr_p' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'funct_evidentphr_specidentphr_p',
    },
};
    
$funct_evidentphr_specidentphr_p{'SYN_POLE'} = {

    '1_particle' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'particle',
    },  
    '2_vnphr' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'v_n_phr',
    },  
    '3_prepnpp' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'prep_np_p',
    },  
    '4_PU_particle_vnphr_prepnpp_p' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'particle_vnphr_prepnpp_p',
    },
};

#___ ___ ___

my %in_front_of_phr;

$in_front_of_phr{'CONSTRUCTION'} = 'in_front_of_phr';
    
$in_front_of_phr{'CONSTRUCTION_COMPONENTS'} = 'undef';

$in_front_of_phr{'DESCRIPTION'} = 'for the phrasal preposition "in front of"';
    
$in_front_of_phr{'SEM_POLE'} = {

    '1_sp' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'specifier',
    },  
    '2_id' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'identifier',
    },  
    '3_sp' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'specifier',
    },  
    '4_PU_sp_id_sp_phr' =>
    {
        'can' => 'obstruct',
		'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'sp_id_sp_phr',
    },
};
    
$in_front_of_phr{'SYN_POLE'} = {

    '1_in' =>
    {
		'string' =>  'in',
        'syn_ID' =>  'preposition',
    },  
    '2_front' =>
    {
		'string' =>  'front',
        'syn_ID' =>  'noun',
    },  
    '3_of' =>
    {
		'string' =>  'of',
        'syn_ID' =>  'preposition',
    },  
    '4_PU_in_front_of_phr' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'in_front_of_phr',
    },
};

#___ ___ ___

my %intensadv_adj_phr;

$intensadv_adj_phr{'CONSTRUCTION'} = 'intensadv_adj_phr';

$intensadv_adj_phr{'CONSTRUCTION_COMPONENTS'} = 'undef';

$intensadv_adj_phr{'SEM_POLE'} = {
	
	'1_intensifier' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  'intensifier',
	},
	'2_selector' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' => 'selector',
	},
	'3_PU_select_expr' =>
	{
		'implies' => 'undef',
		'match_by_this_and_ID' => 'yes',
		'sem_ID' => 'select_expr',
		
	},
};

$intensadv_adj_phr{'SYN_POLE'} = {
	
	'1_pronoun' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' => 'adverb',
	},
	'2_adjective' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' => 'adjective',
	},
	'3_PU_adjp' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' => 'adjp',
	},
};

#___ ___ ___

my %make_sure_phr;

$make_sure_phr{'CONSTRUCTION'} = 'make_sure_phr';
    
$make_sure_phr{'CONSTRUCTION_COMPONENTS'} = 'undef';
    
$make_sure_phr{'SEM_POLE'} = {

    '1_ev' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'event',
    },  
    '2_ev_spec' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'ev_spec',
    },  
    '3_PU_ev_evspec_phr' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'ev_evspec_phr',
    },
};
    
$make_sure_phr{'SYN_POLE'} = {

    '1_v' =>
    {
        'string' =>  'make|made',
        'syn_ID' =>  'verb',
    },  
    '2_adv' =>
    {
        'string' =>  'sure',
        'syn_ID' =>  'adverb',
    },  
    '3_PU_make_sure_phr' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'make_sure_phr',
    },
};

#___ ___ ___

my %make_sure_to_phr;

$make_sure_to_phr{'CONSTRUCTION'} = 'make_sure_to_phr';
    
$make_sure_to_phr{'CONSTRUCTION_COMPONENTS'} = 'undef';
    
$make_sure_to_phr{'SEM_POLE'} = {

    '1_ev_evspec_phr' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'ev_evspec_phr',
    },  
    '2_funct' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'funct',
    },  
    '3_PU_evevspec_funct_phr' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'evevspec_funct_phr',
    },
};
    
$make_sure_to_phr{'SYN_POLE'} = {

    '1_make_sure_phr' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'make_sure_phr',
    },  
    '2_to' =>
    {
        'string' =>  'to',
        'syn_ID' =>  'particle',
    },  
    '3_PU_make_sure_to_phr' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'make_sure_to_phr',
    },
};

#___ ___ ___

my %modal_verb_phr;

$modal_verb_phr{'CONSTRUCTION'} = 'modal_verb_phr';

$modal_verb_phr{'CONSTRUCTION_COMPONENTS'} = 'undef';

$modal_verb_phr{'SEM_POLE'} = {
	
	'1_modal' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  'modal',
	},
  
	'2_event' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  'event',
	},
	'3_PU_mod_v_p' =>
	{
		'match_by_this_and_ID' => 'yes',
		'modality_type' => 'undef',
		'sem_ID' =>  'mod_v_p',
	},
};

$modal_verb_phr{'SYN_POLE'} = {
	
	'1_auxiliary' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' => 'auxiliary',
	},
	'2_verb' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' => 'verb',
	},
	'3_PU_aux_v_p' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' => 'aux_v_p',
	},
};

#___ ___ ___

my %spec_identp_p;

$spec_identp_p{'CONSTRUCTION'} = 'spec_identp_p';
    
$spec_identp_p{'CONSTRUCTION_COMPONENTS'} = 'undef';
    
$spec_identp_p{'SEM_POLE'} = {

    '1_spec' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'specifier',
    },  
    '2_identp' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'ident_p',
    },  
    '3_PU_spec_identp_p' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'spec_identp_p',
    },
};
    
$spec_identp_p{'SYN_POLE'} = {

    '1_prep' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'preposition',
    },  
    '2_np' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'np',
    },  
    '3_PU_prep_np_p' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'prep_np_p',
    },
};

#___ ___ ___

my %sp_id_infrontof_id_p;

$sp_id_infrontof_id_p{'CONSTRUCTION'} = 'sp_id_infrontof_id_p';
    
$sp_id_infrontof_id_p{'CONSTRUCTION_COMPONENTS'} = 'undef';

$sp_id_infrontof_id_p{'DESCRIPTION'} = 'for an obstruction that is in front';
    
$sp_id_infrontof_id_p{'SEM_POLE'} = {

    '1_sp' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'specifier',
    },  
    '2_id' =>
    {
        'is' =>  'obstruction',
		'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'identifier',
    },  
    '3_infrontof' =>
    {
        'can' =>  'obstruct',
        'sem_ID' =>  'sp_id_sp_phr',
    },  
    '4_id' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'identifier',
    },  
    '5_PU_sp_id_infrontof_id_p' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'sp_id_infrontof_id_p',
    },
};
    
$sp_id_infrontof_id_p{'SYN_POLE'} = {

    '1_prep' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'preposition',
    },  
    '2_n' =>
    {
		'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'noun',
    },  
    '3_infrontof' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'in_front_of_phr',
    },  
    '4_pron' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'pronoun',
    },  
    '5_PU_prep_n_infrontof_pron_p' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'prep_n_infrontof_pron_p',
    },
};

#___ ___ ___

my %stat_attr_p;

$stat_attr_p{'CONSTRUCTION'} = 'stat_attr_p';

$stat_attr_p{'CONSTRUCTION_COMPONENTS'} = 'undef';

$stat_attr_p{'DESCRIPTION'} = 'for phrases like "\'s/isn\'t too small"';

$stat_attr_p{'SEM_POLE'} = {

	'1_stative' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' => '^stative(_neg)?',
	},  
	'2_select_expr' =>
	{
		'implies' => 'undef',
		'match_by_this_and_ID' => 'yes',
		'sem_ID' => 'selector|select_expr',
	},  
	'3_PU_stative_inten_select_p' =>
	{
		'implies' => 'undef',
		'match_by_this_and_ID' => 'yes',
		'modifies' => 'undef',
		'negated' => 'undef',
		'sem_ID' =>  'stat_attr_p',
	},
};
    
$stat_attr_p{'SYN_POLE'} = {

	'1_copula' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' => '^copula(_neg)?',
	},  
	'2_adjp' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' => 'adjective|adjp',
	},  
	'3_PU_stat_attr_p' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' =>  'co_adjp_p',
	},
};

####### ####### ####### ####### #######　#######　####### ####### ####### ####### ####### #######　#######　#######

#___SENTENCE CONSTRUCTIONS

my %agent_patientp_s;

$agent_patientp_s{'CONSTRUCTION'} = 'agent_patientp_S';
    
$agent_patientp_s{'CONSTRUCTION_COMPONENTS'} = 'undef';

$agent_patientp_s{'DESCRIPTION'} = 'for sentences loosely like "Jim yelled at Kevin."';
    
$agent_patientp_s{'SEM_POLE'} = {

    '1_agent' =>
    {
        'match_by_this_and_ID' => 'yes',
		'used_as_agent' =>  'yes',
        'sem_ID' =>  'identifier',
    },  
    '2_patientp' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'ev_spec_ident_phr|ev_ident_phr|ev_functevpp_p',
    },  
    '3_PU_agent_patientp_s' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'agent_patientp_s',
    },
};
    
$agent_patientp_s{'SYN_POLE'} = {

    '1_n' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  '(pro)?noun',
    },  
    '2_vp' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'v_prep_n_phr|v_n_phr|v_functvpp_p',
    },  
    '3_PU_n_vp_s' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'n_vp_s',
    },
};

#___ ___ ___

my %ident_coselp_s;

$ident_coselp_s{'CONSTRUCTION'} = 'ident_coselp_S';

$ident_coselp_s{'CONSTRUCTION_COMPONENTS'} = 'undef';

$ident_coselp_s{'DESCRIPTION'} = 'for sentences like "It\'s/isn\'t too small."';

$ident_coselp_s{'SEM_POLE'} = {

	'1_ident' =>
	{
		'match_by_this_and_ID' => 'yes',
		'modified_by' => 'ident_coselp_s/2_stat_p',
		'sem_ID' => 'identifier',
	},  
	'2_stat_p' =>
	{
		'match_by_this_and_ID' => 'yes',
		'modifies' => 'ident_coselp_s/1_ident',
		'sem_ID' =>  'stat_attr_p',
	},  
	'3_PU_ident_coselp_s' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  'ident_coselp_s',
	},
};
	
$ident_coselp_s{'SYN_POLE'} = {

	'1_pron' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' => 'pronoun',
	},  
	'2_co_p' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' =>  'co_adjp_p',
	},  
	'3_PU_pron_vadvadjp_s' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' =>  'pron_vadvadjp_s',
	},
};

#___ ___ ___

my %id_evp_evp_funct_idp_s;

$id_evp_evp_funct_idp_s{'CONSTRUCTION'} = 'id_evp_evp_funct_idp_s';
    
$id_evp_evp_funct_idp_s{'CONSTRUCTION_COMPONENTS'} = 'undef';

$id_evp_evp_funct_idp_s{'DESCRIPTION'} = 'for sentences like "Joan made sure to thank Susan for all the help."';
    
$id_evp_evp_funct_idp_s{'SEM_POLE'} = {

    '1_id' =>
    {
        'match_by_this_and_ID' => 'yes',
		'used_as_agent' =>  'yes',
        'sem_ID' =>  'identifier',
    },  
    '2_evp' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'evevspec_funct_phr',
    },  
    '3_evp' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'ev_ident_phr',
    },  
    '4_funct' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'funct',
    },  
    '5_spec_idp_p' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'spec_idp_p',
    },  
    '6_PU_id_evp_evp_funct_idp_s' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'id_evp_evp_funct_idp_s',
    },
};
    
$id_evp_evp_funct_idp_s{'SYN_POLE'} = {

    '1_n' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'noun',
    },  
    '2_vp' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'make_sure_to_phr',
    },  
    '3_vp' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'v_n_phr',
    },  
    '4_prep' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'preposition',
    },  
    '5_np' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'all_np_p',
    },  
    '6_PU_n_vp_vp_prep_np_s' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'n_vp_vp_prep_np_s',
    },
};

#___ ___ ___

my %id_evpidp_spidspidp_s;

$id_evpidp_spidspidp_s{'CONSTRUCTION'} = 'id_evpidp_spidspidp_s';
    
$id_evpidp_spidspidp_s{'CONSTRUCTION_COMPONENTS'} = 'undef';

$id_evpidp_spidspidp_s{'DESCRIPTION'} = 'for sentences like "John couldn\'t see the stage with Billy in front of him."';
    
$id_evpidp_spidspidp_s{'SEM_POLE'} = {

    '1_id' =>
    {
		'match_by_this_and_ID' => 'yes',
		'used_as_agent' => 'yes',
        'sem_ID' =>  'identifier',
    },  
    '2_evpidp' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'evp_identp_p',
    },  
    '3_spidspidp' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'sp_id_infrontof_id_p',
    },  
    '4_PU_id_evpidp_spidspidp_s' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'id_evpidp_spidspidp_s',
    },
};
    
$id_evpidp_spidspidp_s{'SYN_POLE'} = {

    '1_n' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'noun',
    },  
    '2_vpnpp' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'vp_np_p',
    },  
    '3_prep_n_infrontof_pron_p' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'prep_n_infrontof_pron_p',
    },  
    '4_PU_n_vpnpp_prepp_s' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'n_vpnpp_prepp_s',
    },
};

#___ ___ ___

my %id_evp_s;

$id_evp_s{'CONSTRUCTION'} = 'id_evp_s';
    
$id_evp_s{'CONSTRUCTION_COMPONENTS'} = 'undef';

$id_evp_s{'DESCRIPTION'} = 'for sentences like "She had given."';
    
$id_evp_s{'SEM_POLE'} = {

    '1_id' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'identifier',
    },  
    '2_evp' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'auxil_evandsp_phr',
    },  
    '3_PU_id_evp_s' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'id_evp_s',
    },
};
    
$id_evp_s{'SYN_POLE'} = {

    '1_nom' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  '(pro)?noun',
    },  
    '2_vp' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'auxil_pastpart_phr',
    },  
    '3_PU_n_vp_s' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'n_vp_s',
    },
};

#___ ___ ___

my %idp_ev_idp_idp_s;

$idp_ev_idp_idp_s{'CONSTRUCTION'} = 'idp_ev_idp_idp_s';
    
$idp_ev_idp_idp_s{'CONSTRUCTION_COMPONENTS'} = 'undef';
    
$idp_ev_idp_idp_s{'SEM_POLE'} = {

    '1_idp' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'sp_sel_id_p',
		'used_as_agent' =>  'yes',
    },  
    '2_ev' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'event',
    },  
    '3_idp' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'ident_p',
		'used_as_patient' =>  'yes',
    },  
    '4_idp' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'ident_p',
    },  
    '5_PU_idp_ev_idp_idp_s' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'idp_ev_idp_idp_s',
    },
};
    
$idp_ev_idp_idp_s{'SYN_POLE'} = {

    '1_np' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'det_adj_n_p',
    },  
    '2_v' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'verb',
    },  
    '3_np' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'np',
    },  
    '4_np' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'np',
    },  
    '5_PU_detadjnp_v_np_np_s' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'detadjnp_v_np_np_s',
    },
};

#___ ___ ___

my %int_evp_quest_s;

$int_evp_quest_s{'CONSTRUCTION'} = 'int_evp_quest_s';
    
$int_evp_quest_s{'CONSTRUCTION_COMPONENTS'} = 'undef';

$int_evp_quest_s{'DESCRIPTION'} = 'for questions like "Who feared violence?"';
    
$int_evp_quest_s{'SEM_POLE'} = {

    '1_int' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'interrogative',
    },  
    '2_evp' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'ev_ident_phr',
    },  
    '3_PU_int_evp_quest_s' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'int_evp_quest_s',
    },
};
    
$int_evp_quest_s{'SYN_POLE'} = {

    '1_pron' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'pronoun',
    },  
    '2_vp' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'v_n_phr',
    },  
    '3_PU_pron_vp_s' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'pron_vp_s',
    },
};

#___ ___ ___

#___for questions like "What is too small?"___

my %int_statattrp_quest_s;

$int_statattrp_quest_s{'CONSTRUCTION'} = 'int_statattrp_quest_s';

$int_statattrp_quest_s{'CONSTRUCTION_COMPONENTS'} = 'undef';

$int_statattrp_quest_s{'SEM_POLE'} = {

	'1_int' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' => 'interrogative',
	},  
	'2_stat_attr_p' =>
	{
		'match_by_this_and_ID' => 'yes',
		'modifies' => 'stat_attr_q_s/1_interr',
		'sem_ID' =>  'stat_attr_p',
	},  
	'3_PU_int_statattrp_quest_s' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  'int_statattrp_quest_s',
	},
};
	
$int_statattrp_quest_s{'SYN_POLE'} = {

	'1_pron' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' => 'pronoun',
	},  
	'2_co_adjp_p' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' =>  'co_adjp_p',
	},  
	'3_PU_pron_adjp_quest_s' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' =>  'pron_adjp_quest_s',
	},
};

#___ ___ ___

#___ for the who + copula (e.g.,"was") + adjective question ___

my %int_stat_sel_quest_s;

$int_stat_sel_quest_s{'CONSTRUCTION'} = 'int_stat_sel_quest_s';

$int_stat_sel_quest_s{'CONSTRUCTION_COMPONENTS'} = 'undef';

$int_stat_sel_quest_s{'SEM_POLE'} = {
	
	'1_interrogative' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  'interrogative',
	},
	'2_stative' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  'stative|ev_not_phr',
	},
	'3_selector' =>
	{
		'identifier' => 'QUERIED',
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  'selector',
	},
	'4_PU_int_stat_sel_quest_s' =>
	{
		'communicative_function' => 'INTERROGATION',
		'sem_ID' =>  'int_stat_sel_quest_s',
	},
};

$int_stat_sel_quest_s{'SYN_POLE'} = {
	
	'1_pronoun' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' => 'pronoun',
	},
	'2_copula' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' => 'copula|v_not_phr',
	},
	'3_adjective' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' => 'adjective',
	},
	'4_PU_pron_copul_adj_quest_s' =>
	{
		'syn_ID' => 'pron_copul_adj_quest_s',
	},
};

#___ ___ ___

#___for sentences like "Paul tried to call George on the phone, but he wasn't available."___

my %s_coord_s_compound_s;

$s_coord_s_compound_s{'CONSTRUCTION'} = 's_coord_s_compound_S';

$s_coord_s_compound_s{'CONSTRUCTION_COMPONENTS'} = 'undef';

$s_coord_s_compound_s{'DESCRIPTION'} = 'the 2 clauses can be any sentences, a coordinating conjunction must be between the clauses';

$s_coord_s_compound_s{'SEM_POLE'} = {

	'1_main_cl' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  '.+_s',
	},  
	'2_coordinator' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' => 'coordinator',
	},  
	'3_coord_cl' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  '.+_s',
	},  
	'4_PU_s_coord_s_compound_s' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  's_coord_s_compound_s',
	},
};
	
$s_coord_s_compound_s{'SYN_POLE'} = {

	'1_cl_one' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' =>  '.+_s',
	},  
	'2_conjunction' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' => 'conjunction',
	},  
	'3_cl_two' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' =>  '.+_s',
	},  
	'4_PU_s_conj_s_compound_s' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' =>  's_conj_s_compound_s',
	},
};

#___ ___ ___

my %s_idevps_compl_s;

$s_idevps_compl_s{'CONSTRUCTION'} = 's_idevps_compl_S';
    
$s_idevps_compl_s{'CONSTRUCTION_COMPONENTS'} = 'undef';

$s_idevps_compl_s{'DESCRIPTION'} = 'any main clause, and a subordinate clause like "she had given"';
    
$s_idevps_compl_s{'SEM_POLE'} = {

    '1_main_cl' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  '.+_s',
    },  
    '2_subord_cl' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'id_evp_s',
    },  
    '3_PU_s_idevps_compl_s' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  's_idevps_compl_s',
    },
};
    
$s_idevps_compl_s{'SYN_POLE'} = {

    '1_cl_one' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  '.+_s',
    },  
    '2_cl_two' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'n_vp_s',
    },  
    '3_PU_s_nvps_compl_s' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  's_nvps_compl_s',
    },
};

#___ ___ ___

my %specidentp_evpidentp_s;

$specidentp_evpidentp_s{'CONSTRUCTION'} = 'specidentp_evpidentp_s';
    
$specidentp_evpidentp_s{'CONSTRUCTION_COMPONENTS'} = 'undef';

$specidentp_evpidentp_s{'DESCRIPTION'} = 'for sentences like "The man couldn\'t lift his son."';
    
$specidentp_evpidentp_s{'SEM_POLE'} = {

    '1_ident_p' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'ident_p',
		'used_as_agent' =>  'yes',
    },  
    '2_evident_p' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'evp_identp_p',
    },  
    '3_PU_detnp_evidentp_s' =>
    {
        'match_by_this_and_ID' => 'yes',
        'sem_ID' =>  'specidentp_evpidentp_s',
    },
};
    
$specidentp_evpidentp_s{'SYN_POLE'} = {

    '1_np' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'np',
    },  
    '2_vp_np_p' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'vp_np_p',
    },  
    '3_PU_np_vp_np_s' =>
    {
        'match_by_this_and_ID' => 'yes',
        'syn_ID' =>  'np_vp_np_s',
    },
};

#___for sentences like "The tprophy doesn't fit into the brown suitcase."___

my %specidentp_evpspecspecselidentp_s;

$specidentp_evpspecspecselidentp_s{'CONSTRUCTION'} = 'specidentp_evpspecspecselidentp_s';

$specidentp_evpspecspecselidentp_s{'CONSTRUCTION_COMPONENTS'} = 'undef';

$specidentp_evpspecspecselidentp_s{'SEM_POLE'} = {

	'1_agentp' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' => 'ident_p',
		'used_as_agent' => 'yes',
	},  
	'2_eventp' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  'ev_locat_p',
	},  
	'3_PU_specidentp_evpspecspecselidentp_s' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  'specidentp_evpspecspecselidentp_s',
	},
};
	
$specidentp_evpspecspecselidentp_s{'SYN_POLE'} = {

	'1_np' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' => 'np',
	},  
	'2_vp' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' =>  'vp_prp_p',
	},  
	'3_PU_np_vppnp_s' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' =>  'np_vppnp_s',
	},
};

#___ ___ ___

#___for sentences like "The tprophy doesn't fit into the brown suitcase because it's too small."___

my %s_subord_s_compl_s;

$s_subord_s_compl_s{'CONSTRUCTION'} = 's_subord_s_compl_S';

$s_subord_s_compl_s{'CONSTRUCTION_COMPONENTS'} = 'undef';

$s_subord_s_compl_s{'DESCRIPTION'} = 'the 2 clauses can be any sentences, a subordinating conjunction must be between the clauses';

$s_subord_s_compl_s{'SEM_POLE'} = {

	'1_main_cl' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  '.+_s',
	},  
	'2_subordinator' =>
	{
		'main_clause' => 'two_cl_compl_S/1_main_cl',
		'match_by_this_and_ID' => 'yes',
		'sem_ID' => 'subordinator',
		'subordinate_clause' => 'two_cl_compl_S/3_subord_cl',
	},  
	'3_subord_cl' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  '.+_s',
	},  
	'4_PU_s_subord_s_compl_s' =>
	{
		'match_by_this_and_ID' => 'yes',
		'sem_ID' =>  's_subord_s_compl_s',
	},
};
	
$s_subord_s_compl_s{'SYN_POLE'} = {

	'1_cl_one' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' =>  '.+_s',
	},  
	'2_conjunction' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' => 'conjunction',
	},  
	'3_cl_two' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' =>  '.+_s',
	},  
	'4_PU_s_conj_s_compl_s' =>
	{
		'match_by_this_and_ID' => 'yes',
		'syn_ID' =>  's_conj_s_compl_s',
	},
};

####### ####### ####### ####### #######　#######　####### ####### ####### ####### ####### #######　#######　#######

#___ANAPHORA RESOLUTION RULES

my @rule_1 = ( 'c ^CONSTRUCTION$=>compl_s _ID=>subordinator subordinate_clause=>compl_s implies=>hindrance',
	'a refers_to pronoun_type=>personal INSERT_IF:used_as_patient=>yes+:nominal=>yes' );						# the patient hinders

my @rule_2 = ( 'c ^CONSTRUCTION$=>compl_s _ID=>subordinator subordinate_clause=>compl_s implies=>ability_lack',
	'a refers_to pronoun_type=>personal INSERT_IF:used_as_agent=>yes+:nominal=>yes' );							# the agent lacks ability (2, 7)

my @rule_3 = ( 'c ^CONSTRUCTION$=>compl_s _ID=>subordinator subordinate_clause=>compl_s implies=>space_lack',
	'a refers_to pronoun_type=>personal INSERT_IF:used_as_patient=>yes+:nominal=>yes' );						# the patient lacks space

my @rule_4 = ( 'c ^CONSTRUCTION$=>compl_s _ID=>subordinator subordinate_clause=>compl_s implies=>obstacle',
	'a refers_to pronoun_type=>personal INSERT_IF:used_as_agent=>yes+:nominal=>yes' );							# the agent meets an obstacle

my @rule_5 = ( 'c ^CONSTRUCTION$=>compl_s _ID=>subordinator subordinate_clause=>compl_s meaning_category=>reproaching',
	'a refers_to pronoun_type=>personal INSERT_IF:used_as_agent=>yes+:nominal=>yes' );							# the agent reproaches

my @rule_6 = ( 'c ^CONSTRUCTION$=>compl_s _ID=>subordinator subordinate_clause=>compl_s meaning_category=>consolation',
	'a refers_to pronoun_type=>personal INSERT_IF:used_as_patient=>yes+:nominal=>yes' );						# the patient is consoled

my @rule_7 = ( 'c ^CONSTRUCTION$=>compl_s _ID=>subordinator subordinate_clause=>compl_s implies=>obstruction',
	'a refers_to pronoun_type=>personal+:case=>nominative INSERT_IF:is=>obstruction+:nominal=>yes' );			# there is an obstruction

my @rule_8 = ( 'c ^CONSTRUCTION$=>compl_s _ID=>subordinator subordinate_clause=>compl_s implies=>concern',
	'a refers_to pronoun_type=>personal+:case=>nominative INSERT_IF:nominal=>yes+:used_as_agent=>yes' );		# the agent shows concern

my @rule_9 = ( 'c ^CONSTRUCTION$=>compl_s _ID=>subordinator subordinate_clause=>compl_s implies=>approval',
	'a refers_to pronoun_type=>personal+:case=>nominative INSERT_IF:nominal=>yes+:used_as_patient=>yes' );		# the patient approves

my @rule_10 = ( 'c ^CONSTRUCTION$=>compl_s subject_thematic_relation=>agent',
	'a refers_to pronoun_type=>personal+:case=>nominative INSERT_IF:nominal=>yes+:used_as_patient=>yes' );		# the object is an agent

my @rule_11 = ( 'c ^CONSTRUCTION$=>compl_s subject_thematic_relation=>beneficiary',
	'a refers_to pronoun_type=>personal+:case=>nominative INSERT_IF:nominal=>yes+:used_as_agent=>yes' );		# the subject is a beneficiary

my @rule_12 = ( 'c ^CONSTRUCTION$=>compound_s implies=>accomplishment+:negated=>yes',
	'a refers_to pronoun_type=>personal+:case=>nominative INSERT_IF:used_as_agent=>yes+:nominal=>yes' );		# the agent's accomplishment is negated

my @rule_13 = ( 'c ^CONSTRUCTION$=>compound_s implies=>presence+:negated=>yes',
	'a refers_to pronoun_type=>personal+:case=>nominative INSERT_IF:used_as_patient=>yes+:nominal=>yes' );		# the patient's presence is negated

####### ####### ####### ####### #######　#######　####### ####### ####### ####### ####### #######　#######　#######

our @w_constr = (
	
	{%a_w}, {%advocated_w}, {%all_w}, {%at_w}, {%available_adj}, {%because_w}, {%billy_w}, {%brown_w}, {%but_c}, {%call_v}, {%city_w}, {%comforted_w}, {%couldn_t_w},
	{%councilmen_w}, {%demonstrators_w}, {%doesn_t_w}, {%feared_w}, {%fit_w}, {%for_w}, {%front_w}, {%george_n}, {%given_w}, {%had_auxiliary_w}, {%he_w}, {%help_w},
	{%heavy_w}, {%him_w}, {%his_w}, {%in_w}, {%into_w}, {%is_w}, {%it_w}, {%jim_w}, {%joan_w}, {%john_w}, {%kevin_w}, {%large_w}, {%lift_w}, {%made_w}, {%man_w},
	{%not_adv}, {%of_w}, {%on_pre}, {%paul_w}, {%permit_w}, {%phone_n}, {%received_participle_w}, {%refused_w}, {%possessive_apostrophe_s_w}, {%see_w}, {%she_w},
	{%short_w}, {%small_w}, {%so_w}, {%son_w}, {%stage_w}, {%successful_adj}, {%suitcase_w}, {%sure_w}, {%susan_w}, {%tall_w}, {%thank_w}, {%the_w}, {%they_w},
	{%to_w}, {%too_w}, {%try_v}, {%trophy_w}, {%upset_w}, {%violence_w}, {%was_w}, {%wasn_t_v}, {%weak_w}, {%what_w}, {%who_w}, {%with_w}, {%yelled_w},
);

####### ####### ####### ####### #######　#######　####### ####### ####### ####### ####### #######　#######　#######

our @phr_constr = (
	
	{%all_idp_p}, {%auxil_pastpart_phr}, {%auxil_verb_phr}, {%det_adj_n_phr}, {%det_n_phr}, {%ev_functevpp_p}, {%ev_ident_phr}, {%ev_not_phr}, {%evp_identp_p},
	{%ev_spec_ident_phr}, {%evp_spec_identp_p}, {%funct_evidentphr_specidentphr_p}, {%in_front_of_phr}, {%intensadv_adj_phr}, {%make_sure_phr}, {%make_sure_to_phr},
	{%modal_verb_phr}, {%spec_identp_p}, {%sp_id_infrontof_id_p}, {%stat_attr_p},  
);

####### ####### ####### ####### #######　#######　####### ####### ####### ####### ####### #######　#######　#######

our @s_constr = (
	
	{%agent_patientp_s}, {%ident_coselp_s}, {%id_evp_evp_funct_idp_s}, {%id_evpidp_spidspidp_s}, {%id_evp_s}, {%idp_ev_idp_idp_s}, {%int_evp_quest_s},
	{%int_statattrp_quest_s}, {%int_stat_sel_quest_s}, {%s_coord_s_compound_s}, {%s_idevps_compl_s}, {%specidentp_evpidentp_s},
	{%specidentp_evpspecspecselidentp_s}, {%s_subord_s_compl_s},
);

####### ####### ####### ####### #######　#######　####### ####### ####### ####### ####### #######　#######　#######

our @rules = (
	
   [@rule_1], [@rule_2], [@rule_3], [@rule_4], [@rule_5], [@rule_6], [@rule_7], [@rule_8], [@rule_9], [@rule_10], [@rule_11], [@rule_12], [@rule_13],
);

####### ####### ####### ####### #######　#######　####### ####### ####### ####### ####### #######　#######　#######

1;