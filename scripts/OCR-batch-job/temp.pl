#!/usr/bin/perl -w

use PerlLib::SwissArmyKnife;

sub Process {
  my $output = `find /var/lib/myfrdcsa/codebases/minor/workhorse/data/ocr/output`;

  my $results = {};
  foreach my $file (split /\n/, `find /var/lib/myfrdcsa/codebases/minor/workhorse/data/ocr/input`) {
    if (-f $file) {
      # print "<$file>\n";
      my $dirname = lc(dirname($file));
      my $basename = lc(basename($file));
      $dirname =~ s/^\/var\/lib\/myfrdcsa\/codebases\/minor\/workhorse\/data\/ocr\/input\//\/var\/lib\/myfrdcsa\/codebases\/minor\/workhorse\/data\/ocr\/output\//;
      my $approx = $dirname;
      $dirname =~ s/(\W)/\\$1/sg;
      $basename =~ s/(\W)/\\$1/sg;
      my $regex = '^('.$dirname.'\/(\d{1,2}\.\d{1,2}.\d{4}_\d{2}.\d{2}.\d{2})\/'.$basename.')$';
      # print "\t<$regex>\n";
      $res =
	{
	 File => $file,
	 Regex => $regex,
	 DirName => $approx,
	};
      if ($output =~ qr/$regex/sm) {
	$res->{OutputFile} = $1;
      }
      $results->{$file} = $res;
    }
  }
  return {
	  Results => $results,
	 };
}



# make a list of files which still need to be processed
sub StillNeedToBeProcessed {
  my (%args) = @_;
  my $res = $args{Results}{Results};
  my (@list1,@list2);
  foreach my $inputfile (keys %$res) {
    if (exists $res->{$inputfile}{OutputFile}) {
      push @list2, $inputfile;
    } else {
      push @list1, $inputfile;
    }
  }
  return {
	  StillNeedToBe => [sort @list1],
	  AlreadyHaveBeen => [sort @list2],
	 };
}

# remove the files from the input for which we have the output, but make a mapping from the input file to the output and save that mapping
my $res = Process();
# print Dumper($res);
my $res2 = StillNeedToBeProcessed(Results => $res);
my $inputdir = "/var/lib/myfrdcsa/codebases/minor/workhorse/data/ocr/input/"."xaa";
my $outputdir = "/var/lib/myfrdcsa/codebases/minor/workhorse/data/ocr/output/"."xaa";
my $outgoingdir = "/var/lib/myfrdcsa/codebases/minor/workhorse/data/ocr/outgoing/"."xaa";
mkdir($outgoingdir);
my $mappingsdir = $outgoingdir."/.mappings";
mkdir($mappingsdir);
foreach my $filename (@{$res2->{AlreadyHaveBeen}}) {
  my $destfile = $filename;
  my $regexinput = $inputdir;
  $regexinput =~ s/(\W)/\\$1/sg;
  my $regexoutput = $outputdir;
  $regexoutput =~ s/(\W)/\\$1/sg;
  $destfile =~ s/^$regexinput\/?//;
  my $dest = $destfile;
  $dest =~ s/\W/_/sg;
  $dest .= '.txt';
  my $outfile = ConcatDir($mappingsdir,$dest);
  my $fh = IO::File->new;
  $fh->open(">$outfile") or die "cannot\n";
  my $targetfile = $res->{Results}{$filename}{OutputFile};
  $targetfile =~ s/^$regexoutput\/?//;
  print $fh Dumper({$destfile => $targetfile});
  $fh->close();

  # now we wish to move the files as needed to the proper locations
  
}

# mv the output files to the outgoing destination

# when all files have been processed, tar up and scp over the finished file, including the mappings
