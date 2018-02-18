#!/usr/bin/perl -w

foreach my $line (split /\n/, `tac sorted-n.txt`) {
  if ($line =~ /^\s*(\d+)\s+\;\;\s+([^\(].+?)\.?$/) {
    print $1.' ('.uc($2).')'."\n";
  }
}
