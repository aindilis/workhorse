#!/usr/bin/perl -w

use BOSS::Config;
use PerlLib::SwissArmyKnife;
use PerlLib::ToText;

$specification = q(
	-d <dir>		to-analyze dir
	-a			auto-approve
);

my $config =
  BOSS::Config->new
  (Spec => $specification);
my $conf = $config->CLIConfig;
# $UNIVERSAL::systemdir = "/var/lib/myfrdcsa/codebases/minor/system";

my $toanalyzedir = $conf->{'-d'} || "/var/lib/myfrdcsa/codebases/minor/workhorse/data/1/to-analyze/";
die "No $toanalyzedir\n" unless -d $toanalyzedir;

my $warning = $toanalyzedir;
$warning =~ s/\/$//;

my $totext = PerlLib::ToText->new;

foreach my $origfile (split /\n/, `find $toanalyzedir -follow`) {
  if ($origfile =~ /\.preprocess(\/|$)/) {
    print "skipping $origfile\n";
    next;
  }
  if (-f $origfile) {
    my $file;
    print "<$origfile>\n";
    my $res = $totext->ToText
      (
       File => $origfile,
      );
    $file = "$origfile.preprocess";
    if ($res->{Success}) {
      my $fh = IO::File->new();
      $fh->open(">$file");
      print $fh $res->{Text};
      $fh->close();
    } else {
      system 'echo COULD_NOT_CONVERT_TO_TEXT > '.shell_quote($file);
    }
    system 'mv '.shell_quote($origfile).' /tmp';
    my $basename = basename($file);
    my $dirname  = dirname($file);
    my $dir = $dirname;
    my $regex = $toanalyzedir;
    $regex =~ s/([^a-zA-Z0-9])/\\$1/sg;
    $dir =~ s/^$regex//sg;
    my $tmpdir;
    my $targetdir;
    if ($dir eq $warning) {
      $tmpdir = "/tmp/workhorse/";
      $targetdir = ConcatDir($toanalyzedir,$basename);
    } else {
      $tmpdir = "/tmp/workhorse/".$dir;
      $targetdir = ConcatDir($toanalyzedir,$dir,$basename);
    }
    print "<FILE: $file>\n";
    ApproveCommands
      (
       AutoApprove => $conf->{'-a'},
       Method => 'parallel',
       Commands => [
		    "mkdir -p ".shell_quote($tmpdir),
		    # "cd ".shell_quote($dirname)." && split -l 500 ".shell_quote($file),
		    "cd ".shell_quote($dirname)." && split-by-number-of-sentences -s 250 ".shell_quote($file),
		    "mv ".shell_quote($file)." ".shell_quote($tmpdir),
		    "cd ".shell_quote($dirname)." && mkdir -p ".shell_quote($targetdir),
		    "cd ".shell_quote($dirname)." && mv x* ".shell_quote($targetdir),
		   ],


      );
  }
}
