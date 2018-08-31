#!/usr/bin/env perl

use warnings;
use strict;

use Benchmark ':hireswallclock';

use lib '../lib';
use WS_Constructions;

use utf8;
binmode STDOUT, ':encoding(UTF-8)';



#___ Package variables:

    @main::part_name_and_hash_to_insert = ();
    %main::rule_checks = ();
    $main::construction_number = 0;
    $main::construction_to_insert_into = '';
    $main::rule_and_constr_match_count = 0;      #_! Used by multiple subroutines.
    $main::rule_and_constr_matches = '';
    $main::rule_checked_constr_name = '';



#___ ___ ___ CONTROLLER STARTS



#___ Benchmarking starts
my $starttime = Benchmark->new;
#___



my ($filtered_input_ref, $options_to_execute_ref) = input_filter ();

my $word_parses_ref = word_parser ($filtered_input_ref, [@w_constr]);

$options_to_execute_ref -> {'--show_word_parses'} and show_word_parses ($word_parses_ref);

#print_constr_network ($word_parses_ref);

my $phrase_parses_ref = phrase_parser ($word_parses_ref, [@phr_constr]);

#print_constr_network ($phrase_parses_ref);

my $sentence_parses_ref = phrase_parser ($phrase_parses_ref, [@s_constr]);

#print_constr_network ($sentence_parses_ref);

anaphora_resolver ( $sentence_parses_ref, [@rules] );

print_constr_network ($sentence_parses_ref);



#___ Benchmarking ends
$options_to_execute_ref -> {'--benchmark'} and prettified_benchmarking ($starttime);
#___



#___ ___ ___ CONTROLLER ENDS



#___ ___ ___ MAIN FUNCTIONS START

sub anaphora_resolver {
    
    #_Checks if conditions are met by constructions, based on the checking
    # results uses action instructions to insert anaphoric reference data.
    
    my $sentence_parses_ref = $_[0] if $_[0];
    my @all_rules = @{$_[1]} if $_[1];
    
    my $rule_counter = 0;
    
    for my $one_rule_ref (@all_rules) {
        
        # If conditions:
        
        $one_rule_ref->[0] =~ /^c\s+/i and rule_iterator ($one_rule_ref->[0], $sentence_parses_ref);
        
        # If actions:
        
        if ($one_rule_ref->[1] =~ /^a\s+/i ) {
            
            # Seeing if all conditions have been met:
            
            my @conditions = split " ", $one_rule_ref->[0];
            $conditions[0] =~ /c/i and shift @conditions;
            my $number_of_conditions = @conditions;
            
            my @condition_matches = keys %main::rule_checks;
            
            if ($#condition_matches + 1 == $number_of_conditions) {
                
                # Attaching a (unique for this sentence network only) number to each construction, if not attached before:
                
                !$rule_counter and construction_numberer ($sentence_parses_ref);
                $rule_counter++;
                
                # Finding constructions matching action rule parts (and saving needed construction data in a package variable):
                
                rule_iterator ($one_rule_ref->[1], $sentence_parses_ref);
                
                # Preparing the key (with anaphoric reference data) to insert:
                
                my @actions = split ' ', $one_rule_ref->[1];
                
                $actions[1] ? my $key_to_insert = $actions[1]
                :
                abort ( (caller(0))[1], ', ', (caller(0))[3], ":\nno second component (after \"a \") in the rule \"$one_rule_ref->[1]\"," );
               
                # Preparing the value (with anaphoric reference data) to insert:
                
                my $value_to_insert;
                my @tagged_for_insertion;
                
                for (keys %main::rule_checks) { /^insert_if:\S+?/i and push @tagged_for_insertion, @{ $main::rule_checks{$_} }; }
                
                $value_to_insert = "@tagged_for_insertion";
                
                # Preparing names for constructions; anaphoric reference data will be inserted into these constructions:
                
                $actions[2] ? my @insert_into = @{ $main::rule_checks{$actions[2]} }
                :
                abort ( (caller(0))[1], ', ', (caller(0))[3], ":\nno third component in the rule \"$one_rule_ref->[1]\"," );
                
                # Inserting anaphoric reference data:
                
                my $match_when_inserting = $actions[2];
                
                !$value_to_insert and $value_to_insert = 'UNABLE_TO_DETERMINE';
                
                anaph_reference_inserter ( $sentence_parses_ref, $key_to_insert, $value_to_insert, $match_when_inserting, [@insert_into] );
            }
        }
        
        $one_rule_ref->[0] !~ /^c\s+/i || $one_rule_ref->[1] !~ /^a\s+/i
        and
        abort ( (caller(0))[1], ', ', (caller(0))[3], ":\nthe rule part \"$one_rule_ref->[1]\" does NOT start with a specifier \"c\" or \"a\"," );
        
        #_! Emptying main::rule_checks (or else there will be errors when processing the next rule):
        
        %main::rule_checks = ();
    }
}



sub phrase_parser {
    
    #_Recursively finds all possible, e.g., phrase parses, returns
    # groups of found parses. The quantity of groups is set below.
    
    my @parses = @{$_[0]} if $_[0];
    my @database = @{$_[1]} if $_[1];
    
    my @parses_to_return;
    my %parses_to_compare;
    
    my $matched_counter = 0;
    
    for my $one_parse_ref (@parses) {
        
        my $processed = possible_phr_or_sent_parses (
            
            # $processed has a reference to an array with, e.g., all phrase parses for word constructions from $one_parse_ref.
            
            $one_parse_ref,
            [@database],
            [ ['SEM_POLE', 'sem_ID'], ['SYN_POLE', 'syn_ID'] ],
        );
        
        for (@$processed) {
            
            #_Removing 'MATCHED' and indexes (the indexes show the number of elements
            # in a parse) from each parse before feeding parses to this sub again.
            
            $_->[0] eq 'MATCHED' and $matched_counter++, shift @$_;
            
            if ($_->[$#$_] =~ /^\d+$/) { pop @$_; }
            else { my ($filename, $sub) = ( caller(0) )[1,3]; abort ( "$filename, $sub: parse index error," ); }
            
            #_Accummulating parses to return if no matches or to compare if there are matches.
            
            push @parses_to_return, $_;
            
            my $ttl = scalar @$_;
            !$parses_to_compare{$ttl} ? ( $parses_to_compare{$ttl} = [$_] ) : push @{ $parses_to_compare{$ttl} }, $_;
        }
    }
    
    #_Returning if NO matches:
    !$matched_counter and return ( [@parses_to_return] );
    
    #_If THERE ARE matches, comparing (numbers of elements in each parse) and recursing.
    
    @parses_to_return = ();
    
    my $number_keys_counter = 0;
    
    for (sort num_or_alph keys %parses_to_compare) {
        
        ++$number_keys_counter;
        
        push @parses_to_return, @{$parses_to_compare{$_}};
        
        #_The number to the right of == can be used to set the max quantity of parse groups to be output, each
        # group has parses with the same number of elements. The groups are sorted by the number of elements.
        # Use 1 to the right of == to output only the group with the smallest number of elements.
        
        $number_keys_counter == 1 and last;
    }
    
    #_Recursion:
    phrase_parser ( [@parses_to_return], [@database] );
}



sub word_parser {
    
    # Returns a reference to an array filled with references to other arrays.
    # Each other array is filled with a possible parse (constructions matching
    # the input word string).
    
    my @input_text = @{$_[0]} if $_[0];
    my $w_constr_array_ref = $_[1] if $_[1];
    
    my @all_matching_constr;
    
    for my $word_etc (@input_text) {
        
        @{ match_input_words($word_etc, $w_constr_array_ref) }
        ?
        push ( @all_matching_constr, match_input_words($word_etc, $w_constr_array_ref) )
        :
        abort ("Unknown string: $word_etc");
    }
    
    my $start_position = 0;
    possible_word_parses( [@all_matching_constr], $start_position );
}

#___ ___ ___ MAIN FUNCTIONS END



#___ ___ ___ AUXILIARY FUNCTIONS START

sub abort {
    
    # Stops the execution, can be passed a message to display upon stopping.
    
    my $message = join '', @_;
    
    $message
    ?
    die "\n$message\n___PROCESSING ABORTED___\n\n"
    :
    die "\n___PROCESSING ABORTED___\n\n";
}



sub anaph_data_into_constr_part {
    
    # Recursively traverses a construction and if matches are found inserts anaphora
    # reference data into a part (like SEM_POLE). Stores that part in a package variable.
    
    my %hash = %{$_[0]} if $_[0];               #_! May have the whole construction or just its part (e.g., a unit).
    my @one_or_more_alterns_to_match = @{$_[1]} if $_[1];
    my $key_to_insert = $_[2] if $_[2];
    my $value_to_insert = $_[3] if $_[3];
    my $sem_pole_etc_key = $_[4] if $_[4];
    
    # For the current constr. only setting the match counter to 0:
    
    $hash{CONSTRUCTION} and $main::rule_and_constr_match_count = 0;
    
    for my $orig_key (keys %hash) {
        
        if (ref $hash{$orig_key} eq "HASH") {
            
           anaph_data_into_constr_part ($hash{$orig_key}, [@one_or_more_alterns_to_match], $key_to_insert, $value_to_insert, $orig_key);
           
        } else {
            
            # Decoloring the original key and value that must match (like "anaphoric" and "yes"):
            
            my ($orig_key_no_color, $orig_value_no_color) = coloring ( 'decolor', [ $orig_key, $hash{$orig_key} ] );
            
            # Checking for matches:
            
            for (@one_or_more_alterns_to_match) {
                
                $_ =~ /^(\S+?)=>(\S+?)$/i
                or
                abort ( (caller(0))[1], ', ', (caller(0))[3], ":\n", "error in or near the rule part \"$_\"," );
                
                my ($key_to_match, $value_to_match) = ($1, $2);
                
                if ($orig_key_no_color =~ /^$key_to_match$/i and $orig_value_no_color =~ /^$value_to_match$/i) {
                    
                    $main::rule_and_constr_match_count++;
                }
            }
            
            # If all the alternatives match:
            
            if ($main::rule_and_constr_match_count == scalar @one_or_more_alterns_to_match) {
                
                # Decoloring the key and value to insert (like "refers_to" and "det_adj_n_phr #11") and coloring them blue:
                
                my ($key_to_insert_no_color, $value_to_insert_no_color) = coloring ( 'decolor', [$key_to_insert, $value_to_insert] );
                my ($key_to_insert_blue, $value_to_insert_blue) = coloring ( [ "\e[1;34m", "\e[m" ], [$key_to_insert_no_color, $value_to_insert_no_color] );
                
                # Inserting:
                
                $hash{$key_to_insert_blue} = $value_to_insert_blue;
                
                # Storing:
                
                @main::part_name_and_hash_to_insert = ( $sem_pole_etc_key, {%hash} );
                
                #_! Setting the matches counter to 0 and emptying the matches container, so following non-matches are not stored as matches:
                
                $main::rule_and_constr_match_count = 0;
            }
        } 
    }
}



sub anaph_reference_inserter {
    
    # Recursively traverses a network of constructions, checks if the currently processed construction name
    # matches that of the construction into which anaphora data needs to be inserted, BUT DOES NOT go into
    # construction parts (like SEM_POLE). Reassembles a construction after data insertion.
    
    my $constr_data_ref = $_[0] if $_[0];   # !_May be an array with constructions or just one construction.
    my $key_to_insert = $_[1] if $_[1];
    my $value_to_insert = $_[2] if $_[2];
    my $to_match = $_[3] if $_[3];          # !_Has a string like "anaphoric=>yes".
    my @insert_into = @{$_[4]} if $_[4];    # !_Has construction names like "it_w #17".
    
    # Storing the construction name to be used for anaphora data insertion:
    
    ref $constr_data_ref eq 'HASH' and $constr_data_ref->{CONSTRUCTION} and $main::construction_to_insert_into = $constr_data_ref->{CONSTRUCTION};
    
    if (ref $constr_data_ref eq 'ARRAY') {
        
        anaph_reference_inserter ( $_, $key_to_insert, $value_to_insert, $to_match, [@insert_into] ) for @{$constr_data_ref};
    }
    
    if (ref $constr_data_ref eq 'HASH') {
        
        my @one_or_more_alterns_to_match = split /\+:/, $to_match;      # $to_match has e.g., "used_as_patient=>yes+:person_name=>yes"
        
        for my $constr_name (@insert_into) {
            
            # Checking if decolored $constr_name matches that of the processed construction;
            # if matches anaphora reference data will be inserted into that construction:
            
            my ($constr_name_no_color) = coloring ( 'decolor', [$constr_name] );
            
            if ($main::construction_to_insert_into =~ /^$constr_name_no_color$/) {
                
                # Inserting anaphora reference data into a construction part (like SEM_POLE):
                
                anaph_data_into_constr_part ($constr_data_ref, [@one_or_more_alterns_to_match], $key_to_insert, $value_to_insert);
                
                # If data are inserted in a construction part (like SEM_POLE) (i.e. if the main::part_name_and_hash_to_insert
                # container is not empty), inserting that part into the construction (i.e. reassembling the construction):
                
                @main::part_name_and_hash_to_insert
                and
                $constr_data_ref->{$main::part_name_and_hash_to_insert[0]} = $main::part_name_and_hash_to_insert[1];
                
                # Emptying the container so a construction part is not inserted by mistake:
                
                @main::part_name_and_hash_to_insert = ();
            }
        }
    }
}



sub check_for_pu {
    
    # If a construction has one PU (parent unit) in each, e.g., form and
    # meaning part, returns the total number of PUs, else returns undef.
    
    my %construction = %{$_[0]} if $_[0];
    my @tags = @{$_[1]} if $_[1];                   # holds, e.g., ['SEM_POLE', 'sem_ID'], ['SYN_POLE', 'syn_ID']
    
    my $pu_matched = 0;
    
    for my $tag_set_ref (@tags) {
        
        $pu_matched += grep /_pu_/i, keys %{$construction{$tag_set_ref->[0]}};
    }
    
    $pu_matched == scalar @tags ? $pu_matched : return;
}



sub coloring {
    
    # Returns an array with elements colored or decolored; @color_code gets
    # two parts of the color code, e.g., \e[1;32m and \e[m for bold green.
    
    my @color_code =  @{$_[0]} if ref ($_[0]) eq 'ARRAY';   # $_[0] can also be 'decolor'
    my @to_do = @{$_[1]} if $_[1];
    
    my @done;
    
    $_[0] eq 'decolor' and @done = map { if ($_) {local $_ = $_; for my $reg ( ( qr(\e\[\d*?;\d\dm), qr(\e\[m) ) ) { s/$reg//g; }; $_} } @to_do;
    
    #_To prevent bugs, does not color empty strings or ones containing spaces only:
    
    @color_code and @done = map { $_ and $_ !~ /^\s*$/ and "$color_code[0]$_$color_code[1]" } @to_do;
    
    @done;
}



sub construction_components {
    
    # Enters or adds construction names form @slice as a value for CONSTRUCTION_COMPONENTS in %construction.
    
    my @slice = @{$_[0]};
    my %construction = %{$_[1]};
    
    my @components;
    
    push @components, $_->{CONSTRUCTION} for @slice;
    
    my @components_blue = coloring ( [ "\e[1;34m", "\e[m" ], [@components] );
    
    $construction{CONSTRUCTION_COMPONENTS} =~ /^(undef|\s*)$/i
    ?
    ($construction{CONSTRUCTION_COMPONENTS} = "@components_blue")
    :
    ($construction{CONSTRUCTION_COMPONENTS} = "$construction{CONSTRUCTION_COMPONENTS}" . " @components_blue");
    
    %construction;
}



sub construction_numberer {
    
    #_Recursively accesses all constructions in a network and puts a number after a construction name.
    
    if (ref ($_[0]) eq 'ARRAY') {
        
        construction_numberer ($_) for @{$_[0]};
    }
    
    if (ref ($_[0]) eq 'HASH') {
        
        my $current_number = ++$main::construction_number;
        
        my $constr_name_with_index = "$_->{CONSTRUCTION} #$current_number";
        
        $_->{CONSTRUCTION} = $constr_name_with_index;
    }
}



sub do_one_constr_and_slice {
    
    # Does matching or copying for one construction (e.g., one from the database) and an array
    # (or an array slice) containing one or more constructions (e.g., constructions that have
    # matched input words), returns the matching/copying results or undef.
    
    my %database = %{$_[0]} if $_[0];
    my @slice_input = @{$_[1]} if $_[1];
    my @tags = @{$_[2]} if $_[2];   # holds, e.g., ['SEM_POLE', 'sem_ID'], ['SYN_POLE', 'syn_ID']
    
    my @all_out;
    my @slice;
    
    my @arrays_in_slice_indexes;
    my $index = 0;
    
    #_Preparing the slice for processing:
    
    for (@slice_input) {
        
        $index++;
        
        if (ref $_ eq 'ARRAY') {
            
            #_If an array (e.g., a phrase constr. that had matched word ones) is found in the 
            # input slice, preparing a hash from that array and the array ordinal number:
            
            push @slice, $_->[0];
            push @arrays_in_slice_indexes, $index - 1;
        }
        else { push @slice, $_; }
    }
    
    #_Matching:
    
    my @datab_and_sl_hash_parts_matched = match_or_copy ( 'match', [@tags], {%database}, [@slice] );
    
    my @datab_hash_parts_matched = @{$datab_and_sl_hash_parts_matched[0]};
    my @sl_hash_parts_matched = @{$datab_and_sl_hash_parts_matched[1]};
    
    #_Counting database construction units to see later if all non-parent units match:
    
    my $datab_all_units_count;
    $datab_all_units_count += scalar keys %{$database{$_->[0]}} for @tags;
    my $datab_pu_units_count = check_for_pu ({%database}, [@tags]);
    my $datab_non_pu_units_count = $datab_all_units_count - $datab_pu_units_count;
    
    #_If there are matching constructions:
    
    if (@datab_hash_parts_matched and @sl_hash_parts_matched and $datab_non_pu_units_count == scalar @sl_hash_parts_matched) {
        
        #_Reassembling after matching:
        
        my %database_matched = insert_colored_parts ( [@datab_hash_parts_matched], [@tags], {%database} );
        
        %database_matched = construction_components ( [@slice], {%database_matched} );
        
        my @slice_matched = insert_colored_parts_loop ( [@slice], [@sl_hash_parts_matched], [@tags], 'insert_by_index' );
        
        #_Copying:
        
        my @copying_results = match_or_copy ( 'copy', [@tags], {%database_matched}, [@slice_matched] );
        
        if ( $copying_results[2] ) {
            
            #_If SOMETHING has been copied:
            
            my @datab_hash_parts_copied = @{$copying_results[0]};
            my @sl_hash_parts_copied = @{$copying_results[1]};
            
            #_Reassembling after copying:
            
            my %database_copied = insert_colored_parts ( [@datab_hash_parts_copied], [@tags], {%database_matched} );
            
            my @slice_copied = insert_colored_parts_loop ( [@slice_matched], [@sl_hash_parts_copied], [@tags], 'insert_by_index' );
            
            if (@arrays_in_slice_indexes) {
                
                #_If in the input slice there was an array (e.g., a phrase constr.
                # that had matched word ones), reassembling that array.
               
                $slice_copied[$_] = [ $slice_copied[$_], $slice_input[$_][1] ] for @arrays_in_slice_indexes;
            }
            
            @all_out = ( {%database_copied}, [@slice_copied] );
        }
        else {
            
            #_If NOTHING has been copied:
            
            if (@arrays_in_slice_indexes) {
                
                #_If in the input slice there was an array (e.g., a phrase constr.
                # that had matched word ones), reassembling that array.
               
                $slice_matched[$_] = [ $slice_matched[$_], $slice_input[$_][1] ] for @arrays_in_slice_indexes;
            }
            
            @all_out = ( {%database_matched}, [@slice_matched] );
        }
        
        return (@all_out);
    }
    
    #_If no matching constructions returning undef:
    
    return;
}



sub do_units {
    
    # Matches or copies and colors feature-value pairs in two construction units,
    # returns the units with the colored pairs; if no matching pairs returns undef,
    # if no copied pairs returns unchanged units.
    
    my %database_hash_unit =  %{$_[0]} if $_[0];
    my %slice_hash_unit =  %{$_[1]} if $_[1];
    my $match_or_copy_switch = $_[2] if $_[2];
    
    my %database_hash_unit_out =  %database_hash_unit;
    my %slice_hash_unit_out = %slice_hash_unit;
    
    my @matched;
    my @copied;
    
    for my $d_h_k_colored_or_not (keys %database_hash_unit) {
        
        for my $sl_h_k_colored_or_not (keys %slice_hash_unit) {
            
            my ($dat_h_key_no_color, $dat_h_value_no_color, $sl_h_key_no_color, $sl_h_value_no_color) = coloring (
                'decolor',
                [   $d_h_k_colored_or_not, $database_hash_unit{$d_h_k_colored_or_not},
                    $sl_h_k_colored_or_not, $slice_hash_unit{$sl_h_k_colored_or_not}
                ]
            );
            
            #_Matching:
            
            if ($match_or_copy_switch eq 'match' &&  $dat_h_key_no_color =~ /^$sl_h_key_no_color$/i && $dat_h_value_no_color !~ /^(\s*|undef)$/i) {
                
                #_! Matching every option (vertical-bar-separated alternative) in the hash values:
                
                my @dat_opt = split /\|/, $dat_h_value_no_color;
                my @sl_opt = split /\|/, $sl_h_value_no_color;
                
                for my $d_opt (@dat_opt) {
                    for my $s_opt (@sl_opt) {
                        
                        #_! Inside $dat_h_key_no_color and alike can be strings or Regex, so matching as strings or as Regex:
                        
                        if ($d_opt =~ /^$s_opt$/i or $s_opt =~ /^$d_opt$/i) {
                            
                            my ($d_k_gr, $d_opt_gr, $s_k_gr, $s_opt_gr) = coloring (
                                [ "\e[1;32m", "\e[m" ], [$dat_h_key_no_color, $d_opt, $sl_h_key_no_color, $s_opt] 
                            );
                            
                            #_! \Q is for matching Regex special characters literally, gets weird if not so:
                            
                            (my $d_v_gr = $dat_h_value_no_color) =~ s/\Q$d_opt/$d_opt_gr/;
                            (my $s_v_gr = $sl_h_value_no_color) =~ s/\Q$s_opt/$s_opt_gr/;
                            
                            push @matched, [$d_h_k_colored_or_not, $sl_h_k_colored_or_not, $d_k_gr, $d_v_gr, $s_v_gr];
                        }
                    }
                }
            }
            
            #_Copying
            
            #_to the database constr.:
            
            if ($match_or_copy_switch eq 'copy' && $dat_h_key_no_color =~ /^$sl_h_key_no_color$/i &&
                $dat_h_value_no_color =~ /^(\s*|undef)$/i && $sl_h_value_no_color !~ /^(\s*|undef)$/i) {
                
                my ($sl_h_key_green) = coloring ( [ "\e[1;32m", "\e[m" ], [$sl_h_key_no_color] );
                my ($sl_h_value_blue) = coloring ( [ "\e[1;34m", "\e[m" ], [$sl_h_value_no_color] );
                
                push @copied, ['to_dat', $d_h_k_colored_or_not, $sl_h_k_colored_or_not, $sl_h_key_green, $sl_h_value_blue];
            }
            
            #_to the input slice constr.:
            
            if ($match_or_copy_switch eq 'copy' && $dat_h_key_no_color =~ /^$sl_h_key_no_color$/i &&
                $dat_h_value_no_color !~ /^(\s*|undef)$/i && $sl_h_value_no_color =~ /^(\s*|undef)$/i) {
                
                my ($dat_h_key_green) = coloring ( [ "\e[1;32m", "\e[m" ], [$dat_h_key_no_color] );
                my ($dat_h_value_blue) = coloring ( [ "\e[1;34m", "\e[m" ], [$dat_h_value_no_color] );
                
                push @copied, ['to_sl', $sl_h_k_colored_or_not, $d_h_k_colored_or_not, $dat_h_key_green, $dat_h_value_blue];
            }
        }
    }
    
    #_Only IF at least TWO feature-value pairs matched:
    
    if (scalar @matched >= 2) {
        
        for my $one_matched_set_ref (@matched) {
            
            $database_hash_unit_out{$one_matched_set_ref->[0]} = $one_matched_set_ref->[3];
            $database_hash_unit_out{$one_matched_set_ref->[2]} = delete $database_hash_unit_out{$one_matched_set_ref->[0]};
            
            $slice_hash_unit_out{$one_matched_set_ref->[1]} = $one_matched_set_ref->[4];
            $slice_hash_unit_out{$one_matched_set_ref->[2]} = delete $slice_hash_unit_out{$one_matched_set_ref->[1]};
        }
        
        return ( {%database_hash_unit_out}, {%slice_hash_unit_out} );
    }
    
    #_If there are copied feature-value pairs:
    
    if (@copied) {
        
        for my $one_copied_set_ref (@copied) {
            
            if ($one_copied_set_ref->[0] eq 'to_dat') {
                
                #_@$one_copied_set_ref CONTENTS:
                # 0 -> 'to_dat', 1 -> $d_h_k_colored_or_not, 2 -> $sl_h_k_colored_or_not, 3 -> $sl_h_key_green, 4 -> $sl_h_value_blue
                
                $slice_hash_unit_out{$one_copied_set_ref->[3]} = delete $slice_hash_unit_out{$one_copied_set_ref->[2]};
                
                $database_hash_unit_out{$one_copied_set_ref->[1]} = $one_copied_set_ref->[4];
                $database_hash_unit_out{$one_copied_set_ref->[3]} = delete $database_hash_unit_out{$one_copied_set_ref->[1]};
            }
            
            if ($one_copied_set_ref->[0] eq 'to_sl') {
                
                #_@$one_copied_set_ref CONTENTS:
                # 0 -> 'to_sl', 1 -> $sl_h_k_colored_or_not, 2 -> $d_h_k_colored_or_not, 3 -> $dat_h_key_green, 4 -> $dat_h_value_blue
                
                $database_hash_unit_out{$one_copied_set_ref->[3]} = delete $database_hash_unit_out{$one_copied_set_ref->[2]};
                
                $slice_hash_unit_out{$one_copied_set_ref->[1]} = $one_copied_set_ref->[4];
                $slice_hash_unit_out{$one_copied_set_ref->[3]} = delete $slice_hash_unit_out{$one_copied_set_ref->[1]};
            }
        }
        
        #_The 1 returned at the list end shows that something has been copied:
        
        return ( {%database_hash_unit_out}, {%slice_hash_unit_out}, 1 );
    }
    
    #_If there are no copied feature-value pairs, and the match/copy switch was set to "copy":
    
    if (!@copied && $match_or_copy_switch eq 'copy') {
        
        #_The 0 returned at the list end shows that nothing has been copied:
        
        return ( {%database_hash_unit_out}, {%slice_hash_unit_out}, 0 );
    }
    
    #_Returning undef if no matches:
    
    return;
}



sub find_rule_part_in_constr {
    
    # Recursively traverses a construction, checks if it matches rule parts, depending
    # on the checking results stores needed construction data in package variables.
    
    my $hash_ref = $_[0] if $_[0];          #_! May have the whole construction or just its part (e.g., a unit).
    my $rule_entry = $_[1] if $_[1];
    my $condition_or_action = $_[2] if $_[2];
    
    # Storing the name for the current constr.; for this constr. only: setting
    # the match counter to 0 and emptying rule and constr. matches container:
    
    if ($hash_ref->{CONSTRUCTION}) {
        
        $main::rule_checked_constr_name = $hash_ref->{CONSTRUCTION};
        $main::rule_and_constr_match_count = 0;
        $main::rule_and_constr_matches = '';
    }
    
    # Recursing through the construction:
    
    for my $key (sort keys %$hash_ref) {
        
        if (ref $hash_ref->{$key} eq 'HASH') {
            
            find_rule_part_in_constr ($hash_ref->{$key}, $rule_entry, $condition_or_action);
            
        } else {
            
            $rule_entry =~/^(insert_if:)*(.+)$/i;
            
            my @one_or_more_alterns = split /\+:/, $2;      # $2 has e.g., "used_as_patient=>yes+:person_name=>yes"
            
            my ($key_no_color, $value_no_color) = coloring ( 'decolor', [ $key, $hash_ref->{$key} ] );
            
            # Matching construction parts with (one or more) alternatives extracted from rules:
            
            for my $one_altern_to_match (@one_or_more_alterns) {
                
                $one_altern_to_match =~ /^(\S+?)=>(\S+?)$/i
                or
                abort ( (caller(0))[1], ', ', (caller(0))[3], ":\n", "error in or near the rule part \"$rule_entry\"," );
                
                my ($match_with_key, $match_with_value) = ($1, $2);
                
                if ($key_no_color =~ /$match_with_key/i and $value_no_color =~ /$match_with_value/i) {
                    
                    $main::rule_and_constr_match_count++;
                    
                    $main::rule_and_constr_matches
                    ?
                    ($main::rule_and_constr_matches .= "; $key_no_color => $value_no_color")
                    :
                    ($main::rule_and_constr_matches = "$key_no_color => $value_no_color");  
                }
            }
            
            # If all the alternatives match:
            
            if (scalar @one_or_more_alterns == $main::rule_and_constr_match_count) {
                
                # If conditions:
                
                if ($condition_or_action =~ /^c$/i) {
                    
                    if ($main::rule_checks{"--C-> $rule_entry"}) {
                        
                        my @rule_checks_values = @{ $main::rule_checks{"--C-> $rule_entry"} };
                        $rule_checks_values[0] .= "; $main::rule_and_constr_matches";
                        $rule_checks_values[1] .= "; $main::rule_checked_constr_name";
                        
                        $main::rule_checks{"--C-> $rule_entry"} = [@rule_checks_values];
                        
                    } else {
                        
                        $main::rule_checks{"--C-> $rule_entry"} = ["MATCHED: $main::rule_and_constr_matches", "NAME(S): $main::rule_checked_constr_name"]
                    }
                }
                
                # If actions:
                
                if ($condition_or_action =~ /^a$/i) {
                    
                    $main::rule_checks{$rule_entry}
                    ?
                    (push @{ $main::rule_checks{$rule_entry} }, "$main::rule_checked_constr_name")
                    :
                    ($main::rule_checks{$rule_entry} = ["$main::rule_checked_constr_name"]);
                }
                
                #_! Setting the matches counter to 0 and emptying the matches container, so following non-matches are not stored as matches:
                
                $main::rule_and_constr_match_count = 0;
                $main::rule_and_constr_matches = '';
            }
        }
    }
}



sub get_unit_by_name {
    
    # Returns a reference to a construction unit (e.g., a parent unit or a form or meaning
    # pole), if the unit name matches $unit_name_regex; returns undef if no match.
    
    my $unit_name_regex = $_[0];
    my %hash = %{$_[1]};
    
    my ($unit_name) = grep /$unit_name_regex/, keys %hash;
    $unit_name and my %unit = %{$hash{$unit_name}};
    
    %unit ? {%unit} : return;
}



sub get_value {
    
    # From a PU (parent unit) returns the value for $string_etc_key. From a construction with no 
    # PU returns the value for $string_etc_key if it is found in the form or meaning inner hash.
    
    my %constr = %{$_[0]} if $_[0];
    my $form_or_meaning_key = $_[1] if $_[1];   # e.g., "SYN_POLE"
    my $string_etc_key = $_[2] if $_[2];        # e.g., "string"
    
    my @pu = grep /.*?_PU_.*/, keys %{$constr{$form_or_meaning_key}};
    abort ('Two or more parent units in a construction') if scalar @pu >= 2;
    
    my ($pu_value, $another_string);
    
    if (@pu) {
        
        !grep /^\d+?_PU_/,  keys %{$constr{$form_or_meaning_key}}
        and
        print_one_constr ({%constr}), abort ('Unacceptable parent unit naming in the above construction,');
        
        my %pu_hash = %{ $constr{$form_or_meaning_key}{$pu[0]} };
        
        my $pu_key_colored_or_not = hash_key_colored_or_not ( {%pu_hash}, $string_etc_key );
        
        !$pu_key_colored_or_not
        and
        print_one_constr ({%constr}), abort ("No \"$string_etc_key\" key in a parent unit or unacceptable design of the above construction,");
        
        $pu_value = $constr{$form_or_meaning_key}{$pu[0]}{$pu_key_colored_or_not};
        
        $pu_value = trim_spaces ( $pu_value, ['beginning_and_end', 'shrink_to_one'] );
        
    }
    else {
        
        my $string_etc_key_colored_or_not = hash_key_colored_or_not ($constr{$form_or_meaning_key}, $string_etc_key);
        
        !$string_etc_key_colored_or_not
        and
        print_one_constr ({%constr}), abort ("In the above construction failed to find \"$string_etc_key\" (no spaces allowed in this string),");
        
        $string_etc_key_colored_or_not and $constr{$form_or_meaning_key}{$string_etc_key_colored_or_not}
        and
        $another_string = $constr{$form_or_meaning_key}{$string_etc_key_colored_or_not};
    }
    
    $pu_value || $another_string;
}



sub hash_key_colored_or_not {
    
    # Receives an uncolored key (or a regex) and returns that key colored or not as found in a hash.
    
    my %hash = %{$_[0]};
    my $key_no_color = $_[1];
    
    my @key_colored_or_not = grep {
        
        /^(\e\[\d*?;\d\dm)*?$key_no_color(\e\[m)*?$/i
        
    } keys %hash;
    
    scalar @key_colored_or_not >= 2
    and
    abort ("Two or more keys:\n\n@key_colored_or_not\n\nwere unexpectedly found, this was used for finding:\n\n$key_no_color\n");
    
    $key_colored_or_not[0];
}



sub inner_hashes {
    
    # Returns, e.g., a sent. constr. unit and phr. constr. parent unit if $sl_member_counter matches the sent. constr.
    # unit name part (a number, etc.); or if $unit_name_regex has a regex for a database unit name, returns that unit.
    
    my %database_hash = %{$_[0]} if $_[0];
    my %slice_hash = %{$_[1]} if $_[1];
    my @tags_one_set = @{$_[2]} if $_[2];   # holds, e.g., 'SEM_POLE', 'sem_ID'
    my $unit_name_regex = $_[3] if $_[3];
    my $sl_member_counter = $_[4] if $_[4];
    
    
    #_If $unit_name_regex is specified, returns here (if not specified returns at the end):
    
    $unit_name_regex and return ( get_unit_by_name ( $unit_name_regex, $database_hash{$tags_one_set[0]} ) );
    
    
    my @slice_pu_name = grep /.*?_pu_.*/i, keys %{$slice_hash{$tags_one_set[0]}};
    abort ('Two or more parent units in a construction') if scalar @slice_pu_name >= 2;
    
    my %slice_hash_part;
    
    @slice_pu_name
    ?
    ( %slice_hash_part = %{ $slice_hash{$tags_one_set[0]}{$slice_pu_name[0]} } )
    :
    ( %slice_hash_part = %{ $slice_hash{$tags_one_set[0]} } );
    
    my %database_hash_part;
    
    for my $unit_name ( sort num_or_alph keys %{ $database_hash{$tags_one_set[0]} } ) {
        
        if ($unit_name =~ /^${sl_member_counter}_/) {
            
            my %form_mean_etc_hash = %{ $database_hash{$tags_one_set[0]} };
            %database_hash_part = %{ $form_mean_etc_hash{$unit_name} };
            
            last;
        }
    }
    
    ( {%database_hash_part}, {%slice_hash_part} );
}



sub input_filter {
    
    # Reads instructions (if any) after the name of this program, puts them in a hash, returns a reference to that
    # hash; for the input text: inserts spaces, removes characters, returns a reference to an array with the text.
    
    my %options_to_execute;
    my @valid_options = qw(--benchmark --show_word_parses);
    
    for my $arg (@ARGV) {
        
        grep (/^$arg$/, @valid_options) ? $options_to_execute{$arg} = 1 : abort ("Wrong option: $arg");
    }
    
    #my $input_text = "The man couldn't lift his son because he was so heavy. Who was heavy?";
    #my $input_text = "The man couldn't lift his son because he was so weak. Who was weak?";
    #my $input_text = "The trophy doesn't fit into the brown suitcase because it's too small. What is too small?";
    #my $input_text = "The trophy doesn't fit into the brown suitcase because it's too large. What is too large?";
    #my $input_text = "Jim yelled at Kevin because he was so upset. Who was upset?";
    #my $input_text = "Jim comforted Kevin because he was so upset. Who was upset?";
    #my $input_text = "John couldn't see the stage with Billy in front of him because he is so short. Who is so short?";
    #my $input_text = "John couldn't see the stage with Billy in front of him because he is so tall. Who is so tall?";
    my $input_text = "The city councilmen refused the demonstrators a permit because they feared violence. Who feared violence?";
    #my $input_text = "The city councilmen refused the demonstrators a permit because they advocated violence. Who advocated violence?";
    #my $input_text = "Joan made sure to thank Susan for all the help she had given. Who had given help?";
    #my $input_text = "Joan made sure to thank Susan for all the help she had received. Who had received help?";
    #my $input_text = "Paul tried to call George on the phone, but he wasn't successful. Who was not successful?";
    #my $input_text = "Paul tried to call George on the phone, but he wasn't available. Who was not available?";
    
    $input_text = $_[0] if $_[0];
    
    for ($input_text) {
        
        s/('s|'d)/ $1/g;
        
        s/
            [,:;\?!\(\)]
        / /xg;
        
        s/\.*\s+/ /g;
    }
    
    return( [split (" ", $input_text)], {%options_to_execute} );
}



sub insert_by_id {
    
    # Inserts, e.g., non-parent units into form and meaning parts of a sent. constr., the parts are inserted if
    # $hashes_to_insert_counter matches the sent. constr. unit name fragment. Returns the modified construction.
    
    my @hash_parts_to_insert = @{$_[0]} if $_[0];
    my @tags = @{$_[1]} if $_[1];                   # holds, e.g., ['SEM_POLE', 'sem_ID'], ['SYN_POLE', 'syn_ID']
    my %construction = %{$_[2]} if $_[2];
    
    my %construction_out = %construction;
    
    my $plicing_offset = scalar @hash_parts_to_insert / scalar @tags;
    my @form_mean_slices_to_insert = map { [splice @hash_parts_to_insert, 0, $plicing_offset] } 1 .. scalar @tags;
    
    my $sets_to_insert_counter = 0;
    
    for (@form_mean_slices_to_insert) {
        
        my $form_or_meaning_tag = $tags[$sets_to_insert_counter++][0];
        
        my @to_insert = @$_;
        my %units = %{ $construction_out{$form_or_meaning_tag} };
        my %units_out = %units; 
        
        for my $unit_name (sort num_or_alph keys %units) {
            
            my $hashes_to_insert_counter = 0;
            
            for my $hash_to_insert (@to_insert) {
                
                $hashes_to_insert_counter++;
                
                if ($unit_name =~ /^${hashes_to_insert_counter}_/) {
                    
                    $units_out{$unit_name} = $hash_to_insert;
                    $construction_out{$form_or_meaning_tag} = {%units_out};
                    
                    last;
                }
            }
        }
    }
    
    %construction_out;
}



sub insert_by_index {
    
    # Inserts, e.g., form and meaning parts into a construction with no PU (parent unit) or form
    # and meaning parts PUs into a construction with a PU. Parts that have indexes the same as
    # the position of the construction in the slice (of children constructions) are inserted.
    # Returns the construction with the parts inserted (or overwritten).
    
    my @hash_parts_to_insert = @{$_[0]} if $_[0];
    my @tags = @{$_[1]} if $_[1];                   # holds, e.g., ['SEM_POLE', 'sem_ID'], ['SYN_POLE', 'syn_ID']
    my %construction = %{$_[2]} if $_[2];
    my $constr_counter = $_[3];
    
    my %construction_out = %construction;
    
    my $constr_with_pu = check_for_pu ( {%construction}, [@tags] );
    
    my $slice_size = scalar @hash_parts_to_insert / scalar @tags;
    my @sliced_by_tags  = map { [splice @hash_parts_to_insert, 0, $slice_size] } @tags;
    
    my $slice_counter = 0;
    for my $tag_set_ref (@tags) {
        
        my $tag = $tag_set_ref->[0];
        
        my %inserted = %{ $sliced_by_tags[$slice_counter][$constr_counter] };
        
        if ($constr_with_pu) {
            
            my %units_out = %{ $construction_out{$tag_set_ref->[0]} };
            my $pu_name = hash_key_colored_or_not ( {%units_out}, qr(.*?_PU_.*)i );
            
            $units_out{$pu_name} = {%inserted};
            $construction_out{$tag_set_ref->[0]} = {%units_out};
            
        } else {
            
            $construction_out{$tag} = {%inserted};
        }
        
        $slice_counter++;
    }
    
    %construction_out;
}



sub insert_colored_parts {
    
    # Returns a construction with colored parts (sets of feature-value pairs) inserted into that construction. 
    
    my @hash_parts_to_insert = @{$_[0]} if $_[0];
    my @tags = @{$_[1]} if $_[1];                   # holds, e.g., ['SEM_POLE', 'sem_ID'], ['SYN_POLE', 'syn_ID']
    my %construction = %{$_[2]} if $_[2];
    my $constr_counter = $_[3] if defined $_[3];
    my $insert_by_index_switch = $_[4] if $_[4];
    
    my %construction_out;
    
    $insert_by_index_switch
    ?
    ( %construction_out = insert_by_index ( [@hash_parts_to_insert], [@tags], {%construction}, $constr_counter ) )
    :
    ( %construction_out = insert_by_id ( [@hash_parts_to_insert], [@tags], {%construction} ) );
}



sub insert_colored_parts_loop {
    
    #_A loop used to insert parts (units with matched or copied feature-value pairs) into multiple constructions.
    
    my @insert_into_these = @{$_[0]} if $_[0];
    my @to_be_inserted = @{$_[1]} if $_[1];
    my @tags = @{$_[2]} if $_[2];
    my $insert_by_index_switch = $_[3] if $_[3];
    
    my @inserted;
    
    my $constr_counter = 0;
    
    for my $insert_into_this_ref (@insert_into_these) {
        
        my %slice_one_constr_out =
        insert_colored_parts ( [@to_be_inserted], [@tags], $insert_into_this_ref, $constr_counter, $insert_by_index_switch);
        
        push @inserted, {%slice_one_constr_out};
        
        $constr_counter++;
    }
    
    @inserted;
}



sub match_ids {
    
    # Returns an array slice in which construction ID values match non-parent
    # unit ID values of one database construction, undef otherwise.
    
    my @one_parse = @{$_[0]} if $_[0];
    my $database_constr_ref = $_[1] if $_[1];
    my @tags = @{$_[2]} if $_[2];              # holds, e.g., ['SEM_POLE', 'sem_ID'], ['SYN_POLE', 'syn_ID']
    my $start_index = $_[3];
    
    my $ids_matches = 0;
    my $datab_non_parent_ids_num;
    
    for my $two_tags_ref (@tags) {
        
        # Extracting database construction unit IDs:
        
        my @datab_unit_ids;
        
        for ( sort num_or_alph keys %{$database_constr_ref->{$two_tags_ref->[0]}} ) {
            
            /_pu_/i and next;
            
            my $datab_unit_id_key_colored_or_not = hash_key_colored_or_not ( $database_constr_ref->{$two_tags_ref->[0]}{$_}, $two_tags_ref->[1] );
            
            !$datab_unit_id_key_colored_or_not and print_one_constr ($database_constr_ref),
            abort ("In the above construction failed to find a \"$two_tags_ref->[1]\" (no spaces allowed in this string),");
            
            push @datab_unit_ids, $database_constr_ref->{$two_tags_ref->[0]}{$_}{$datab_unit_id_key_colored_or_not};
        }
        
        my @datab_ids_decolored = coloring ( 'decolor', [@datab_unit_ids] );
        
        # Preparing variant ID sequences from the database construction for matching:
        
        my @datab_ids_to_match;
        
        for my $id_set (@datab_ids_decolored) {
            
            $id_set =~ /\|/ and my @altern = split /\|/, $id_set;
            
            if (!@datab_ids_to_match) {                     #_If the container for IDs to be matched is empty:
                
                if (!@altern) { push @datab_ids_to_match, [$id_set]; } else { push @datab_ids_to_match, [$_] for @altern; } 
            }
            
            elsif (scalar @datab_ids_to_match == 1) {       #_If the container for IDs to be matched has 1 item:
                
                if (!@altern) { push @{$datab_ids_to_match[0]}, $id_set; }
                else { my @temp; push @temp, [ @{$datab_ids_to_match[0]}, $_ ] for @altern; @datab_ids_to_match = @temp; }
            }
            
            elsif (scalar @datab_ids_to_match >= 2) {       #_If the container for IDs to be matched has 2 or more items:
                
                if (!@altern) { push @$_, $id_set for @datab_ids_to_match; }
                elsif (scalar @altern == scalar @datab_ids_to_match) { my $alt_count = 0; push @$_, $altern[$alt_count++] for @datab_ids_to_match; }
                else {
                    
                    abort ( (caller(0))[1], ', ', (caller(0))[3], ":\nin $database_constr_ref->{CONSTRUCTION} ".
                    "not the same number of IDs in the set \"@altern\" as in other more-than-one-ID sets," );
                }
            }
        }
        
        # Extracting input parse construction unit IDs:
        
        my @parse_ids;
        
        for (@one_parse) {
            
            my $id;
            
            if (ref $_ eq 'HASH') {
                
                #_If, e.g., a word construction:
                
                $id = get_value ($_, $two_tags_ref->[0], $two_tags_ref->[1]);
                
            } elsif (ref $_ eq 'ARRAY' && ref $_->[0] eq 'HASH') {
                
                #_If, e.g., a phrase construction (that previously matched one or more word constructions):
                
                2 <= check_for_pu ($_->[0], [@tags])
                and
                $id = get_value ($_->[0], $two_tags_ref->[0], $two_tags_ref->[1]);
                
            } else {
                
                my ($filename, $sub) = ( caller(0) )[1,3]; abort ( "$filename, $sub: wrong data structure supplied for ID extraction," );
            }
            
            push @parse_ids, $id;
        }
        
        # Preparing input parse construction IDs for matching:
        
        $datab_non_parent_ids_num = scalar @datab_unit_ids;
        my @slice_ids = @parse_ids[$start_index .. $start_index + $datab_non_parent_ids_num - 1] if $start_index + $datab_non_parent_ids_num - 1 <= $#parse_ids;
        my $ids_slice = join ' ', @slice_ids;
        
        my ($ids_slice_no_color) = coloring ( 'decolor', [$ids_slice] );
        
        # Matching database ID variants with input parse IDs:
        
        for my $datab_id_set_ref (@datab_ids_to_match) {
            
            my $datab_id_set = join ' ', @$datab_id_set_ref;
            
            #_! Matching all as strings or as Regex:
            
            if ($datab_id_set eq $ids_slice_no_color or $datab_id_set =~ /^$ids_slice_no_color$/i or $ids_slice_no_color =~ /^$datab_id_set$/i) {
                
                $ids_matches++;
            }
        }
    }
    
    $ids_matches == scalar (@tags) and my @matching_slice = @one_parse[$start_index .. $start_index + $datab_non_parent_ids_num - 1];
    
    @matching_slice;
}



sub match_input_words {
    
    # If a word etc. matches values of "string" etc. (in constructions),
    # returns a reference to an array filled with those constructions;
    # or a reference to an empty array if no matches.
    
    my $word_etc = $_[0] if defined $_[0];
    my @constr = @{$_[1]} if @{$_[1]};
    
    my @matches;
    
    for my $constr_ref (@constr) {
        
        my $value = get_value ($constr_ref, 'SYN_POLE', 'string');
        my ($value_no_color) = coloring ('decolor', [$value]);
        
        if ($word_etc =~ /^$value_no_color$/i) {
            
            push @matches, $constr_ref;
        }
    }
    
    [@matches];
}



sub match_or_copy {
    
    # Matching: returns arrays with matching parts or empty arrays if no matches;
    # copying: returns arrays with copied parts or arrays with unchanged parts if
    # nothing copied, returns a flag showing whether something has been copied.
    
    my $match_or_copy_switch = $_[0];
    my @tags = @{$_[1]} if $_[1];       # holds, e.g., ['SEM_POLE', 'sem_ID'], ['SYN_POLE', 'syn_ID']
    my %database = %{$_[2]} if $_[2];
    my @slice = @{$_[3]} if $_[3];
    
    $match_or_copy_switch !~ /^(match|copy)$/ and abort ('Wrong option for feature-value matching or copying'); 
    
    my @datab_hash_parts_matched;
    my @sl_hash_parts_matched;
    
    my $something_is_copied_flag = 0;
    
    for my $two_tags_ref (@tags) {
        
        #_! COPYING FROM CHILDREN (i.e., SLICE CONSTRUCTIONS) INTO THE DATABASE CONSTR. PARENT UNIT (PU) MAY NOT
        # BE A GOOD IDEA: e.g., one child may have "implies => A" another ch. "implies => B" and the database PU
        # "implies => undef", then ONLY "implies => A" will be copied.
        
        #_%d_pu_hash_updated is for copying into the database constr. parent unit from multiple children.
        my %d_pu_hash_updated;
        
        my $sl_member_counter = 0;
        
        for my $slice_ref (@slice) {
            
            ++$sl_member_counter;
            
            if ($match_or_copy_switch eq 'match') {
                
                my ($database_hash_part_ref, $slice_hash_part_ref) = inner_hashes ({%database}, $slice_ref, $two_tags_ref, '', $sl_member_counter);
                
                if ( my ($d_h_p_matched_ref, $s_h_p_matched_ref) = do_units ($database_hash_part_ref, $slice_hash_part_ref, $match_or_copy_switch) ) {
                    
                    push @datab_hash_parts_matched, $d_h_p_matched_ref;
                    push @sl_hash_parts_matched, $s_h_p_matched_ref;
                }
            }
            
            if ($match_or_copy_switch eq 'copy') {
                
                my ($d_h_part_same_id_ref, $slice_hash_part_ref) = inner_hashes ({%database}, $slice_ref, $two_tags_ref, '', $sl_member_counter);
                
                my ($copied_d_h_p_same_id_ref, $copied_sl_h_p_ref, $copying_flag_1) =
                do_units ($d_h_part_same_id_ref, $slice_hash_part_ref, $match_or_copy_switch);
                
                $something_is_copied_flag += $copying_flag_1;
                
                my ($copied_d_pu_hash_ref, $twice_copied_sl_h_p_ref, $copying_flag_2);
                
                if (%d_pu_hash_updated) {
                    
                    ($copied_d_pu_hash_ref, $twice_copied_sl_h_p_ref, $copying_flag_2) =
                    do_units ({%d_pu_hash_updated}, $copied_sl_h_p_ref, $match_or_copy_switch);
                    
                } else {
                    
                    my %d_pu_hash = %{ inner_hashes ( {%database}, '', $two_tags_ref, qr(.*?_PU_.*)i ) };
                    
                    ($copied_d_pu_hash_ref, $twice_copied_sl_h_p_ref, $copying_flag_2) =
                    do_units ({%d_pu_hash}, $copied_sl_h_p_ref, $match_or_copy_switch);
                }
                
                %d_pu_hash_updated = %{$copied_d_pu_hash_ref};
                
                $something_is_copied_flag += $copying_flag_2;
                
                push @datab_hash_parts_matched, ($copied_d_h_p_same_id_ref);
                push @sl_hash_parts_matched, $twice_copied_sl_h_p_ref;
            }
        }
        
        %d_pu_hash_updated and push @datab_hash_parts_matched, ( {%d_pu_hash_updated} );
    }
    
    $match_or_copy_switch eq 'copy'
    ?
    ( [@datab_hash_parts_matched], [@sl_hash_parts_matched], $something_is_copied_flag )
    :
    ( [@datab_hash_parts_matched], [@sl_hash_parts_matched] );
}



sub num_or_alph {
    
    # Returns strings sorted by number if they start with a number, if one
    # doesn't start with a number, returns strings sorted alphabetically.
    
    my ($na, $nb);
    
    if ( ( ($na) = $a =~ /^(\d+)/ ) && ( ($nb) = $b =~ /^(\d+)/ ) ) {return $na <=> $nb}
    if ($a !~ /^\d+/ || $b !~ /^\d+/) {return $a cmp $b}
}


sub possible_phr_or_sent_parses {
    
    # Receives a list of matched constructions and recursively finds all possible
    # phrase or sentence parses for that list, outputs the found parses. Among
    # the output parses those matching the input are marked.
    
    my $one_parse_ref = $_[0] if $_[0];
    my @database = @{$_[1]} if $_[1];
    my $tags_ref = $_[2] if $_[2];       # holds, e.g., ['SEM_POLE', 'sem_ID'], ['SYN_POLE', 'syn_ID']
    my @processed = @{$_[3]} if $_[3];
    
    my @temp;
    
    if (@processed) {
        
        #_Processing for the second time and on:
        
        for my $one_processed_part_ref (@processed) {
            
            my @at_one_start_index = possible_phr_or_sent_parses_dat_loop (
                
                $one_processed_part_ref->[$#$one_processed_part_ref], $one_parse_ref, [@database], $tags_ref
            );
            
            if (@at_one_start_index) {
                
                #_If there are matches at the current position in the input (i.e. at the current "start index"):
                
                for my $at_one_start_index_part_ref (@at_one_start_index) {
                    
                    my @connector = @$one_processed_part_ref[0..$#$one_processed_part_ref-1];
                    
                    #_Marking each parse that has matches:
                    $one_processed_part_ref->[0] ne 'MATCHED' and unshift @connector, 'MATCHED';
                    
                    push @connector, @$at_one_start_index_part_ref;
                    
                    push @temp, [@connector];
                }
            }
            else {
                
                #_If there are NO matches at the current position in the input (i.e. at the current "start index"):
                
                if ($one_processed_part_ref->[$#$one_processed_part_ref] <= scalar @$one_parse_ref - 1) {
                    
                    #_If the end of the input is NOT reached for the parse:
                    
                    my @connector = @$one_processed_part_ref[0..$#$one_processed_part_ref-1];
                    
                    my $next_start_index = $one_processed_part_ref->[$#$one_processed_part_ref] + 1;
                    
                    push @connector, $one_parse_ref->[ $one_processed_part_ref->[$#$one_processed_part_ref] ], $next_start_index;
                    
                    push @temp, [@connector];
                }
                else {
                    
                    #_If the end of the input is reached for the parse:
                    
                    push @temp, $one_processed_part_ref;
                }
            }
        }
        
    } else {
        
        #_Processing for the very first time:
        
        @temp = possible_phr_or_sent_parses_dat_loop (0, $one_parse_ref, [@database], $tags_ref);
        
        #_Marking each parse that has matches:
        if (@temp) { unshift  @$_, 'MATCHED' for  @temp; }
        
        #_If no matches, putting into @temp the construction (from $one_parse_ref) at position 0 and the start index 1:
        
        !@temp and push @temp, [$one_parse_ref->[0], 1];
    }
    
    #_Stopping and outputting parses if the end of the input is reached for all parses:
    
    my $parse_end_counter = 0;
    
    for (@temp) {
        
        my $start_index = $_->[$#$_];
        
        if ($start_index !~ /^\d+$/) { my ($filename, $sub) = ( caller(0) )[1,3]; abort ( "$filename, $sub: parse index error," ); }
        
        $start_index == scalar @$one_parse_ref and $parse_end_counter++;
    }
    
    $parse_end_counter ==  scalar @temp and return ( [@temp] );
    
    #_Recursion:
    possible_phr_or_sent_parses ( $one_parse_ref, [@database], $tags_ref, [@temp] );
}



sub possible_phr_or_sent_parses_dat_loop {
    
    # Loops through the database, returns (colored) database and slice constructions
    # matching at a position in $one_parse_ref; if no matches returns an empty array;
    # also returns $next_start_index.
    
    my $start_index = $_[0];
    my $one_parse_ref = $_[1] if $_[1];
    my @database = @{$_[2]} if $_[2];
    my $tags_ref = $_[3] if $_[3];
    
    my @at_one_start_index;
    
    for my $database_constr_ref (@database) {
        
        my @slice_with_matching_ids = match_ids (
            
            $one_parse_ref, $database_constr_ref, $tags_ref, $start_index
        );
        
        @slice_with_matching_ids and my @done_database_and_slice = do_one_constr_and_slice (
            
            $database_constr_ref, [@slice_with_matching_ids], $tags_ref
        );
        
        if (@done_database_and_slice) {
            
            my $next_start_index = $start_index + scalar @slice_with_matching_ids;
            
            push @at_one_start_index, [ [@done_database_and_slice], $next_start_index ];
        }
    }
    
    @at_one_start_index;
}



sub possible_word_parses {
    
    # Receives and returns a reference to an array inside which there are references to other arrays.
    # Each of the other (inner) arrays that are received holds one or more constructions matching
    # each input word. Each of the other (inner) arrays that are returned holds a parse (a list of 
    # constructions matching all words). Should recursively generate all possible parses.
    
    my @pull_from_here = @{$_[0]};
    my $current_position = $_[1];
    my @processed = @{$_[2]} if $_[2];
    
    my @temp;
    
    !@pull_from_here and abort ('Empty list submitted for finding possible parses');
    
    my $next_position = $current_position + 1;
    $next_position == scalar(@pull_from_here) and return( [@processed] );
    
    if (@processed) {
        
        for my $attach_to (@processed) {
            
            for my $next ( @{$pull_from_here[$next_position]} ) {
                
                my @pushed = (@$attach_to, $next);
                push @temp, [@pushed];
            }
        }
        
    } else {
        
        for my $current ( @{$pull_from_here[$current_position]} ) {
            
            for my $next ( @{$pull_from_here[$next_position]} ) {
                
                push @temp, [$current, $next];
            }
        }
    }
    
    possible_word_parses( [@pull_from_here], $next_position, [@temp] );
}



sub prettified_benchmarking {
    
    # Prettifies and prints out benchmarking (execution time measurement) output.
    
    my $starttime = $_[0] if $_[0];
    
    my $finishtime = Benchmark->new;
	my $timespent = timediff ($finishtime, $starttime);
    
    #_cutting down benchmarking output to wall-clock only
    ( my $cut_timestr = timestr($timespent) ) =~ s/\s\(.*\)//;
    
    print "\n\e[1;33m___ TIME SPENT:\e[m $cut_timestr\n\n";
}



sub print_one_constr {
    
    # Should "recursively" (going down into hashes inside a hash) print a construction.
    
    if (ref ($_[0]) eq 'HASH') {
        
        for my $key (sort keys %{$_[0]}) {
            
            ref ($_[0]{$key}) eq 'HASH'
            ?
            print "___$key\n"
            :
            $key =~ /^construction$/i ? print "\n\e[1;33m$key\e[m" : print "$key"; 
            
            print_one_constr ($_[0]{$key});
        }
        
    } else {
        
        $_[0] ? print " => $_[0]\n" : print " => UNDEF\n";
    }
}



sub print_constr_network {
    
    # Recursively accesses each member of a construction network and prints network member constructions.
    
    if (ref ($_[0]) eq 'ARRAY') {
        
        #_Prints names of containers for constructions:
        print "\n$_[0]\n";
        
        print_constr_network ($_) for @{$_[0]};
        
    } else {
        
        ref ($_[0]) eq 'HASH' and print "\n$_[0]\n";
        
        ref ($_[0]) eq 'HASH' and print_one_constr ($_[0]);
    }
}



sub rule_iterator {
    
    # Recursively traverses a network of constructions and applies condition or action rule parts.
    
    my $rule_part = $_[0] if $_[0];
    my $sentence_parses_ref = $_[1] if $_[1];   #_! May contain all parses or just one construction.
    
    if (ref $sentence_parses_ref eq 'ARRAY') { rule_iterator ($rule_part, $_) for @$sentence_parses_ref; }
    
    if (ref $sentence_parses_ref eq 'HASH') {
        
        my @rule_part = split " ", $rule_part;
        
        #_! In the if statements below $_ has a part (like "CONSTRUCTION=>_s") of a rule part; $sentence_parses_ref
        # has just one construction; $rule_part[0] has "c" or "a" (to tell apart conditions and actions):
        
        # If conditions:
        
        if ($rule_part[0] =~ /^c$/i) { find_rule_part_in_constr ($sentence_parses_ref, $_, $rule_part[0]) for @rule_part[1..$#rule_part]; }
        
        # If actions:
        
        if ($rule_part[0] =~ /^a$/i) { find_rule_part_in_constr ($sentence_parses_ref, $_, $rule_part[0]) for @rule_part[2..$#rule_part]; }
    }
}



sub show_word_parses {
    
    # Prints the ttl. number of word parses (lists of matched word constructions)
    # and each of those lists (consisting of word construction names, if any).
    
    my $word_parses_ref = shift;
    
    print "\n___ word parses count: ", scalar @$word_parses_ref, "\n\n";

    my $c = 0;
    
    for (@$word_parses_ref) {
        
        print '___ word parse ', ++$c, ":\n";
        
        print "$_->{CONSTRUCTION} " for @$_;
        
        print "\n\n";
    }
}



sub trim_spaces {
    
    # According to options passed to this function, removes spaces.
    
    my $string  = $_[0] if $_[0];
    my @options = @{$_[1]} if $_[1];
    
    for (@options) {
        
        /^beginning_and_end$/   and $string =~ s/^\s*(.*?)\s*$/$1/;
        /^shrink_to_one$/       and $string =~ s/\s{2,}/ /g;
    }
    
    $string;
}

#___ ___ ___ AUXILIARY FUNCTIONS END



#___ ___ ___ POD DOCUMENTATION

=encoding UTF-8

=head1 NAME

ACG (Another Construction Grammar or Associative Construction Grammar)

=head1 SYNOPSIS

B<Implementation Date:>  Aug. 17, 2018

B<Version:> 1

"Associative" is used in the name above because the implementation is aimed at associating knowledge from as many sources as needed for a practical task. To associate means to combine various parts of knowledge and establish the relation among those parts. The knowledge is used to understand text by means of AI. The task can be, for instance, disambiguating a sentence and answering questions on it. This software tries to understand text by using constructions, i.e. data structures that describe text form and the meaning corresponding to that form. The knowledge can be put into the constructions from various sources such as publicly available human knowledge bases (WordNet, etc.) or the construction designer's imagination.

This implementation has knowledge (construction database) enough to output what ambiguous pronouns refer to (e.g., C<< refers_to => george_n #10 >>) in seven Winograd Schemas, i.e. fourteen statement-question sets. Can match the same input word with constructions for different parts of speech, e.g., "'s" (apostrophe s) can be matched with the possessive ending---as in "John's book"---construction or with the verb "is" construction. For this example, and alike, will make two sentence parses: one for the sentence with the possessive, the other for the sentence with "is". For the final output will chose only one sentence parse which "makes sense" i.e. the parse that has matched more phrase constructions. The "sentence parse" means word input that has matched constructions that hold various knowledge and, as a result of that matching, has been "understood". How the input is understood is detailed in the paper below for a similar implementation.

Denis Kiselev. A Construction-Grammar Approach to Computationally Solving the Winograd Schema: Implementation and Evaluation. In AAAI Spring Symposium Series (AAAI SSS), pages 185-192, Stanford University, USA, 2017.

B<The text understanding gist, a quick illustration:> Suppose a database has a piece of knowledge (a construction) that says (in a machine-understandable way) "a red apple is ripe". The input has the phrase "a red apple". The machine finds an exact match of that input phrase and the same phrase in the construction. Because of the exact match the machine now knows that the input is talking about not only a red but also a ripe apple. Technically speaking, constructions are multidimensional associative arrays of syntactic, semantic and pragmatic data. This data format has proven versatile enough to make high-accuracy conclusions about the text of a major test for AI, the Winograd Schema.

The present implementation allows what is to be matched in constructions to be not only words but also Perl-flavor Regex, a tool for matching character strings.

=head1 USAGE

B<Should run on contemporary Linux, Mac and alike where Perl is usually a system component. Additional installations, etc. needed on Windows 10, for instructions see the file using_acg_on_windows10.pdf in the same folder as this documentation file. NOT tested on Windows prior to Windows 10, may work if the command prompt window supports utf8 and text coloring.>

=head2 Installation

Just download/copy the folder containing the implementation into a directory (e.g., Desktop).

=head2 To run

C<perl acg.pl --benchmark --show_word_parses>

Open the terminal or bash on Windows program in the folder bin of this implementation, type the above, press enter. Can be run with or without the options. The files mentioned below can be found in the folders bin and lib.

=head2 Options

C<--benchmark>

Appends the time it took to run the program to the end of the output.

C<--show_word_parses>

Appends variant word parses for the input (sentence, etc.) to the beginning of the output.

=head2 Choosing the input

Comment out one statement-question set (looks like C<#my $input_text = "...";>) in the file acg.pl (below C<sub input_filter>, should be lines 993-1006) or put your own set between the commas instead of a current set. The commented out set will be input.

=head2 Understanding the output

Prettified output in development. Currently, delimiters like C<ARRAY(0x1075e30)> or C<HASH(0x1076598)> are output between sentence and phrase components. In the output, whatever has matched in constructions is marked green, whatever has been automatically inserted into a construction (e.g., has been copied from another construction) is marked blue. The parse structure (e.g., what phrases are components of what phrases or sentences) can be understood by carefully looking through the output from top to bottom. Reading the above paper helps.

=head2 Adding knowledge to the database

Perl skills and reading the above paper needed.

=head3 Adding constructions

To understand more words and phrase or sentence structures, more constructions are needed. The paper describes word, phrase and sentence constructions. The constructions can be added to the file WS_Constructions.pm. The file has comments like C<#___WORD CONSTRUCTIONS> above lists for constructions of each of the three types. To add, say, a word construction for "guy" find any noun construction such as one for the word "man" (the construction that has C<< 'string' => 'man', >>) then copy, paste the construction and change the construction in a way that should be clear after reading the paper. Phrase and sentence constructions can be treated similarly.

For the main script to see newly made constructions they must be exported i.e. added to one of the three lists that should be found in lines 3438-3464 of the file WS_Constructions.pm. The lists are for the three construction types, the word construction list starts from C<our @w_constr = (>, phrase construction one from C<our @phr_constr = (>, sentence construction one from C<our @s_constr = (>. The lists have construction names so the construction name for the above "guy" example can be added in the format C<{%man_w},> to the C<our @w_constr = (> list.

=head3 Adding rules

Rules are needed for anaphora resolution, which means for computationally figuring out, e.g. what/who "they" refers to in "The city councilmen refused the demonstrators a permit because they feared violence.", a famous Winograd Schema sentence. Below is a simplified (but working) rule for this sentence. Thirteen rules are needed to disambiguate the fourteen statement-question sets mentioned in B<SYNOPSIS>. Those rules should be found in the file WS_Constructions.pm, lines 3397-3434.

C<< my @rule_8 = ( 'c CONSTRUCTION=>compl_s implies=>concern', 'a refers_to pronoun_type=>personal+:case=>nominative INSERT_IF:nominal=>yes+:used_as_agent=>yes' ); >>

All rules follow this format. The spacing and (and no spacing) as in the example B<must> be strictly followed. A rule has two parts: the first starting with C<'c> and ending with C<',> (a single quotation mark and comma) and the second with C<'a> and C<'> (a single quotation mark) respectively. C<c> means the condition to be met, C<a> means the action to be taken if the condition is met, the action part can have its own conditions inside it. The condition and action parts for the above example are detailed below.

B<In the condition part> C<< 'c CONSTRUCTION=>compl_s implies=>concern', >> and onwards notice the separating spaces.

C<< CONSTRUCTION=>compl_s >>

means the sentence for which this rule is supposed to work must be a complex sentence. Or, speaking technically, the parse construction feature C<CONSTRUCTION> must have the value that includes C<compl_s> and that feature-value pair must match the above pair in the rule, partial matches being allowed.

C<< implies=>concern >>

is another feature-value pair that must match in the sentence construction or its component i.e. "concern" must be implied. (It is implied by "feared" in the above Winograd Schema sentence.)

B<In the action part> i.e. in C<< 'a refers_to pronoun_type=>personal+:case=>nominative INSERT_IF:nominal=>yes+:used_as_agent=>yes' >> the component

C<< 'a refers_to pronoun_type=>personal+:case=>nominative' >>

is used to find the pronoun i.e. a construction representing the pronoun into which the feature-value saying what this pronoun refers to will be inserted. C<refers_to> will be inserted as the feature, the value will be found using the C<INSERT_IF> component explained later. C<< pronoun_type=>personal+:case=>nominative' >> is a double condition to be met by the pronoun for the insertion to happen. These two feature-value pairs must match in the rule and the pronoun construction. (Conditions can be triple and so on, notice the non-spaced C<+:> separator for condition parts.)

C<< 'INSERT_IF:nominal=>yes+:used_as_agent=>yes' >>

is used to find the sentence part to which the pronoun refers. C<INSERT_IF:> is followed by

C<< nominal=>yes+:used_as_agent=>yes >>

which is a double condition to be met by (i.e. to match in) a construction for a part of the sentence. Reference to that part will be inserted into the pronoun construction. C<< refers_to => det_adj_n_phr #3 >> (refers to "The city councilmen") is the actual feature-value pair inserted into the construction for "he" in the above Winograd Schema example. The C<< nominal=>yes+:used_as_agent=>yes >> condition means "if the sentence part has features like those of a noun, and if that part expresses the doer of the action".

For the above sentence example, some features and values were manually coded when the database was made, some were manipulated automatically when parsed. How exactly that happened can be understood by reading the paper and comparing the output with constructions in WS_Constructions.pm.

The above rule can be glossed using the human language as follows: In a complex sentence that implies concern (has a part like "feared"), into a part that is a nominative case personal pronoun, insert C<< refers_to => >> pointing to a part if that part has noun (or entity) features and means the doer of the action. This is just one possible solution of the anaphora problem, other feature-value pairs can be freely used in various constructions.

Newly made rules can be added below line 3434 of WS_Constructions.pm. Rules must be also exported similarly to the way explained in B<Adding constructions>. The exporting list for rule names like C<[@rule_8],> should be found in lines 3468-3471.

=head1 LIMITATIONS

Although the current rules can be effectively used for the Winograd Schemas test set mentioned in B<SYNOPSIS>, the rules are rather simplistic and may not reflect some linguistic phenomena. Rule scalability (i.e. how many different Schemas can a single rule be effective for) is to be determined by testing on more Schemas. Work on automatic acquisition of constructions is now in progress.

=head1 DISCLAIMER AND FEEDBACK

This implementation is used at one's own risk. For use involving any commercial and/or military activity a formal permission must be obtained from the author. Feedback, such as bug reports, can be sent to the email address in the above paper.

=cut