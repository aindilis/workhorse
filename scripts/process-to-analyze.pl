#!/usr/bin/perl -w

use BOSS::Config;
use PerlLib::SwissArmyKnife;

# Create a pause here in process-to-analyze that ask's if we're ready, or
# have it back up what it makes, to avoid having it analyze and mess
# up data which it has converted, if the analysis stuff isn't working
# quite right.

$specification = q(
	-q			Pause between preprocess and process
	-b			Backup a copy of the newly created files after preprocess

	--skip <processes>...	Skip listed processes (Formalize, Cyc, etc)
);

my $config =
  BOSS::Config->new
  (Spec => $specification);
my $conf = $config->CLIConfig;
# $UNIVERSAL::systemdir = "/var/lib/myfrdcsa/codebases/minor/system";

See({SkipA => $conf->{'--skip'}});
my $extra = "";
if (exists $conf->{'--skip'}) {
  $extra .= "--skip ".join(' ',@{$conf->{'--skip'}});
}

my $command1 = "/var/lib/myfrdcsa/codebases/minor/workhorse/scripts/preprocess-to-analyze.pl -a -d /var/lib/myfrdcsa/codebases/minor/workhorse/data/1/to-analyze/";
print $command1."\n";
system $command1;

if ($conf->{'-b'}) {
  # copy everything in to-analyze to an appropriate subdir in to-to-analyze
  # FIXME: this
  NotYetImplemented();
}
if ($conf->{'-q'}) {
  GetSignalFromUserToProceed();
}

my $command2 = "/var/lib/myfrdcsa/codebases/minor/free-knext/scripts/process-directories-with-knext.pl -d /var/lib/myfrdcsa/codebases/minor/workhorse/data/1/ $extra";
print $command2."\n";
system $command2;
