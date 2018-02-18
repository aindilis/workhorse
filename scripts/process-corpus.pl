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


$specification = q{
	-W [<delay>]		Exit as soon as possible (with optional delay)
};

my $config =
  BOSS::Config->new
  (Spec => $specification);
my $conf = $config->CLIConfig;
# $UNIVERSAL::systemdir = "/var/lib/myfrdcsa/codebases/minor/system";

my $manager = CorpusManager->new();
$manager->Execute
  (
   Corpora => [
	       "Gutenberg",
	       # "OpenLibrary",
	      ],
  );

my $docs = $manager->MyCorporaManager->GetDocuments;

if (exists $conf->{'-W'}) {
  exit(0);
}

foreach my $doc (@$docs) {
  # print $doc->Contents."\n\n\n";
  # extract contexts
  GetContexts(Contents => $doc->Contents);

  # get the innards of this: /var/lib/myfrdcsa/codebases/minor/nlu/systems/annotation/process-2.pl

  # process this with the NLU stuff

  # GetSignalFromUserToProceed();
  # see if the document has already been processed, if not, process it.
  # how to break up the document best?
  # we need document formatting/style/structure/etc extraction
  # use that fragment for now
}

sub GetContexts {
  my (%args) = @_;
  my $c = $args{Contents};
  # what we have to do here is this - we must extract out each
  # sentence, each paragraph, each chapter, each section, etc hrm
  # context is tough, isn't it, maybe have a method for getting the
  # previous contexts

  # what do we have to work with

  my $sentences = get_sentences($c);
  foreach my $sentence (@$sentences) {
    # if ($sentence =~ /\bif\b.+\bthen\b/si) {
    if ($sentence =~ /\bshould\b/si) {
      $sentence =~ s/\s+/ /g;
      print $sentence."\n";
    }
  }
  # different NLP functions have different context requirements

  # I suppose we must annotate like semtag all of the aspects of the
  # text

}
