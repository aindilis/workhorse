#!/usr/bin/perl -w

use PerlLib::SwissArmyKnife;

my $dir = "/var/lib/myfrdcsa/codebases/minor/workhorse/data/to-analyze";
foreach my $file (split /\n/, `find $dir`) {
  print $file."\n";
  if (-f $file) {
    my $c = read_file($file);
    $c =~ s/Ø/0/sg;
    WriteFile(File => $file, Contents => $c);
  }
}
