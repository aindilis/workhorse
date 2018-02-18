#!/usr/bin/perl -w

foreach my $line (split /\n/, `tac sorted-n.txt`) {
  if ($line =~ /^\s*(\d+)\s+\;\;\s+(.+?)\.?$/) {
    my $count = $1;
    my $content = $2;
    Add
      (
       Count => $count,
       Content => $content,
      );
  } else {
    # print $line."\n";
  }
}

sub Add {
  my (%args) = @_;
  my $c = $args{Content};
  if ($c =~ /A (.+?) (MAY .+?) A (.+?)$/) {
    print "<$1><$2><$3>\n";
  }
}
