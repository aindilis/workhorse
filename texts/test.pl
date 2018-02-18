#!/usr/bin/perl -w

use PerlLib::SwissArmyKnife;
use KBS2::Util qw(DumperQuote2);

my @array = (1,2);
my $arrayref = [1,2];

print "\n".('-'x75)."\n";
print DumperQuote2((@array));
print "\n".('-'x75)."\n";
print DumperQuote2($arrayref);
print "\n".('-'x75)."\n";
print DumperQuote2($arrayref->[0]);
print "\n".('-'x75)."\n";

print "\n".('-'x75)."\n";
print ClearDumper((@array));
print "\n".('-'x75)."\n";
print ClearDumper($arrayref);
print "\n".('-'x75)."\n";
print ClearDumper($arrayref->[0]);
print "\n".('-'x75)."\n";

my $item = "\$VAR1 = 1;
\$VAR2 = 2;
";

my $arrayrefresult = DeDumper($item);
my @arrayresult = DeDumper($item);

print Dumper([$arrayrefresult]);
print Dumper(\@arrayrefresult);
