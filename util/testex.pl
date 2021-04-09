use strict;
use warnings;
use v5.16;
use autodie qw(:all);
use File::Temp qw/ tempdir /;
use File::Basename;

die "Incorrect number of arguments." unless (@ARGV == 1);

my $handout = $ARGV[0];
$ENV{'CLASSPATH'}=$handout; # so the java commands work

my $dir = File::Temp->newdir();

say("Temp file: $dir");

foreach my $bm (glob("$handout/*.dat")){
    my $base = basename($bm);
    next if ($base eq "data.dat");
    say("Testing file: $base");
    system("java vehicle < $bm > $dir/$base.vehicle.out");
    # run sats
    system("java satellite < $dir/$base.vehicle.out > $dir/$base.satellite.ref.out");
    system("julia --project=@. scr/satellite.jl < $dir/$base.vehicle.out > $dir/$base.satellite.tst.out");
    # test satellite
    system("julia --project=@. util/satdiffer.jl $dir/$base.satellite.ref.out $dir/$base.satellite.tst.out");
    # run receiver
    system("julia --project=@. scr/receiver.jl < $dir/$base.satellite.tst.out > $dir/$base.receiver.tst.out");
    system("julia --project=@. scr/receiver.jl < $dir/$base.satellite.ref.out > $dir/$base.receiver.ref.out");
    # test receiver
    system("julia --project=@. util/recdiffer.jl $dir/$base.vehicle.out $dir/$base.receiver.tst.out");
    system("julia --project=@. util/recdiffer.jl $dir/$base.vehicle.out $dir/$base.receiver.ref.out");
}

