#!/usr/bin/perl -w

use BOSS::Config;
use PerlLib::SwissArmyKnife;

use Data::Dumper;

$specification = q(
	-d <dir>	Directory to clean
);

my $config =
  BOSS::Config->new
  (Spec => $specification);
my $conf = $config->CLIConfig;

die "No directory given\n" unless -d $conf->{'-d'};

my $dir = $conf->{'-d'};

# my $command = 'find '.shell_quote($dir).' | grep -E "knext\.(dat|kbs)$$"';
my $command = 'find '.shell_quote($dir).' | grep workhorse';
my @files_to_remove = split /\n/, `$command`;
while (@files_to_remove) {
  my @section = splice(@files_to_remove,0,25);
  my $rmcommand = 'rm '.join(' ',map {shell_quote($_)} @section);
  print $rmcommand."\n";
  `$rmcommand`;
}

