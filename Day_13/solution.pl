#!/opt/perl/bin/perl

use 5.028;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';
use Math::ModInt qw [mod];
use Math::ModInt::ChineseRemainder qw [cr_combine];

my $input = shift // "input";
open my $fh, "<", $input or die "open: $!";

chomp (my ($timestamp, $busses) = <$fh>);

my @ids = split /,/ => $busses;
my @min = (1 << 63, 0);
my @mods;

foreach my $index (keys @ids) {
    my $id = $ids [$index];
    next if $id eq 'x';
    my $waittime = $id - ($timestamp % $id);
    @min = ($waittime, $id) if $waittime < $min [0];
    push @mods => mod ($index + 1, $id);
}
my $m = cr_combine (@mods);

say "Solution 1: ", $min [0] * $min [1];
say "Solution 2: ", $m -> modulus - $m -> residue + 1;


__END__
