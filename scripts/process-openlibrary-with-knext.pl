#!/usr/bin/perl -w

use PerlLib::SwissArmyKnife;

my $filenames = read_file('/var/lib/myfrdcsa/codebases/minor/workhorse/data/files.txt');

foreach my $filename (split /\n/, $filenames) {
  $filename =~ s/^\.\///;
  my $largerfilename = '/var/lib/myfrdcsa/datasets/openlibrary.org/www.archive.org/download/'.$filename;
  print "<$largerfilename>\n";
  my $command = '/var/lib/myfrdcsa/codebases/minor/free-knext/scripts/knext.pl -s "every few sentences" -f '.shell_quote($largerfilename);
  print $command."\n";
  my $res = `$command`;
  print $res."\n";
}
