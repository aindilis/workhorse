#!/usr/bin/perl -w

use PerlLib::SwissArmyKnife;

use Archive::Zip qw( :ERROR_CODES :CONSTANTS );

my $zipfilename = "/var/lib/myfrdcsa/codebases/minor-data/corpus-manager/corpora/gutenberg/1/6/4/8/16481/16481_8.zip";
print ExtractTextContents(Zip => $zipfilename);

sub ExtractTextContents {
  my %args = @_;
  my $somezip = Archive::Zip->new();
  unless ( $somezip->read( $args{Zip} ) == AZ_OK ) {
    print 'read error';
    return;
  }
  foreach my $file ($somezip->memberNames()) {
    print "<$file>\n";
    if ($file =~ /\.txt$/i) {
      return $somezip->contents($file);
    }
  }
}
