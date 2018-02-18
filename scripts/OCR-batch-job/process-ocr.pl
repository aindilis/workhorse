#!/usr/bin/perl -w

# take an ocr tar gz from game and move it into the input, being
# careful to remove the files for which we've already seen

use BOSS::Config;

use Data::Dumper;

$specification = q(
	-p <xaa>		Process OCR Input
);

my $config =
  BOSS::Config->new
  (Spec => $specification);
my $conf = $config->CLIConfig;
# $UNIVERSAL::systemdir = "/var/lib/myfrdcsa/codebases/minor/system";

if ($conf->{'-p'}) {
  my $input = $conf->{'-p'};
  if ($input =~ /^x[a-z]+$/) {
    ProcessOCRTarGz(Input => $input);
  } else {
    die "Input misformed: $input\n";
  }
}


sub ProcessOCRTarGz {
  my (%args) = @_;
  # check to see if there is already input and output for this item
  if (-d "/vagrant/data/workhorse/ocr/outgoing/".$args{Input}) {
    # check that there is no more queued or unfinished input or output for this
    
  } else {
    
  }

  if (! -f "/var/lib/myfrdcsa/codebases/minor/workhorse/data/1/ocr-queue/to-ocr-".$args{Input}.".tgz") {
    # scp it over
    my $command = "scp andrewdo@<REDACTED>:/var/lib/myfrdcsa/codebases/internal/digilib/data/pdfs/split/to-ocr-".$args{Input}.".tgz /var/lib/myfrdcsa/codebases/minor/workhorse/data/1/ocr-queue/";
    print $command."\n";
    system $command;
  }
  if (! -f "/var/lib/myfrdcsa/codebases/minor/workhorse/data/1/ocr-queue/to-ocr-".$args{Input}.".tgz") {
    die "No input available\n";
  }

  # now extract the input if it hasn't already been extracted
  

  "/vagrant/data/workhorse/ocr/"

my $dir = "/vagrant/data/workhorse/1/ocr-queue/";
  
   # cd /var/lib/myfrdcsa/codebases/minor/workhorse/data/ocr/ && tar xzf /var/lib/myfrdcsa/codebases/minor/workhorse/data/1/ocr-queue/to-ocr.tgz
  "/vagrant/data/workhorse/ocr/staging";
  "/vagrant/data/workhorse/1/ocr-queue/to-ocr-xaa.tgz"
}


# when omnipage dies, extract the files from the output, put them in
# matched pairings with the input, and then remove the finished output
# items and reseed the remaining input items intot the input dir




#!/usr/bin/perl -w

use String::ShellQuote;
use File::Basename;

my $ocrdir = '/home/andrewdo/VirtualBox\ VMs/shared/ocr-batch-job-3/input/';

my $c = `cat /var/lib/myfrdcsa/codebases/minor/workhorse/data/NO.txt`;

foreach my $line (split /\n/, $c) {
    if ($line =~ /^NO: (.+?)$/) {
	my $file = $1;
	my $dirname = dirname($fullname);
	my $basename = basename($file);
    }
}
