#!/usr/bin/perl -w

use KBS2::Util qw(DumperQuote2);
use PerlLib::SwissArmyKnife;
use KBS2::ImportExport;

my $importexport = KBS2::ImportExport->new();

foreach my $file (split /\n/, `find .`) {
  if ($file =~ /\.knext\.dat$/) {
    print "<$file>\n";
    my @value = read_file_dedumper($file);
    foreach my $entry0 (@value) {
      foreach my $entry1 (@$entry0) {
	print $entry1->{Sentence}."\n";
	foreach my $entry2 (@{$entry1->{ExtractedKnowledge}}) {
	  print "  ".$entry2->{Sentence}."\n";
	  foreach my $entry3 (@{$entry2->{Formalism}{Results}}) {
	    my $res = $importexport->Convert
	      (
	       Input => $entry3->{Output},
	       InputType => 'Interlingua',
	       OutputType => 'CycL String',
	       Quiet => 1,
	      );
	    # print DumperQuote2($res);
	    if ($res->{Success}) {
	      my $output = $res->{Output};
	      print $output."\n\n\n";
	    } else {

	    }
	  }
	}
      }
    }
    # WriteFile(File => "$file.cleaned", Contents => '$VAR1 = '.DumperQuote2(@value));
  }
}
