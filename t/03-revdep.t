#!/usr/bin/perl
use strict;
use warnings;

use CPAN::ReverseDependencies;
use Test::More;

my $crd = CPAN::ReverseDependencies->new();
my @deps;

ok(defined($crd), "create instance of CPAN::ReverseDependencies");

SKIP: {
    eval { @deps = $crd->revdeps('Module-Path'); };
    skip("looks like you and/or MetaCPAN are offline", 1) if $@;
    ok(grep({ $_ eq 'App-PrereqGrapher' } @deps),
       "check we got some dependents and App-PrereqGrapher was one of them");
};

SKIP: {
    eval { @deps = $crd->revdeps('Module::Path'); };
    skip("looks like you and/or MetaCPAN are offline", 1) if $@;
    ok(grep({ $_ eq 'App-PrereqGrapher' } @deps),
       "App::PrereqGrapher is included when module has ::");
};
done_testing();

