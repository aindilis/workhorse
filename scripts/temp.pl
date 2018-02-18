#!/usr/bin/perl -w

my $item = "dksjf;lksd fsdlkjfdlskjf";

$item =~ s/(d)/$1/sg;

print $item."\n";
