#!/usr/bin/perl -w

use String::ShellQuote;

foreach my $file (split /\n/, `find pentagon-papers`) {
  if (-f $file and $file =~ /\.kbs$/) {
    # print "<$file>\n";
    my $command = 'grep ";;" '.shell_quote($file);
    my $res = `$command`;
    print $res."\n";
  }
}
