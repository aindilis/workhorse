#!/usr/bin/perl -w

use KBS2::Util qw(DumperQuote2);
use PerlLib::SwissArmyKnife;

foreach my $file (split /\n/, `find .`) {
  if ($file =~ /\.knext\.dat$/) {
    print "<$file>\n";
    my @value = read_file_dedumper($file);
    WriteFile(File => "$file.cleaned", Contents => '$VAR1 = '.DumperQuote2(@value));
  }
}
