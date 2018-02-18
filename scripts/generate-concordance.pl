#!/usr/bin/perl -w

# foreach document in the corpus

# skip for now
# run the document through KBFS to extract features of the document

# iterate over documents, catting them, and processing them with the
# FRDCSA tools


use BOSS::Config;
use Capability::TextAnalysis;
use CorpusManager;
use PerlLib::SwissArmyKnife;

use Lingua::EN::Sentence qw(get_sentences);

$specification = q(
	-c <word>	Do a concordance for word
);

my @matches;

my $config =
  BOSS::Config->new
  (Spec => $specification);
my $conf = $config->CLIConfig;
# $UNIVERSAL::systemdir = "/var/lib/myfrdcsa/codebases/minor/system";

my $manager = CorpusManager->new();
$manager->Execute
  (
   Corpora => ["Gutenberg"],
  );

my $docs = $manager->MyCorporaManager->GetDocuments;

foreach my $doc (@$docs) {
  my $text = $doc->Contents;
  ComputeConcordance
    (
     Text => $text,
     Word => $conf->{'-c'},
    );
  # GetSignalFromUserToProceed();
}

sub ComputeConcordance {
  my (%args) = @_;
  my $w = $args{Word};
  # my @matches = $args{Text} =~ /(.{50})($w)(.{50})/sig;
  foreach my $line (split /[\r\n]/, $args{Text}) {
    if ($line =~ /\b$w\b/i) {
      push @matches, $line;
    }
  }
  print Dumper(\@matches);
}
