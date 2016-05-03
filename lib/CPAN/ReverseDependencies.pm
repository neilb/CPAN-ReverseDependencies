package CPAN::ReverseDependencies;
# ABSTRACT: given a CPAN dist name, find other CPAN dists that use it

use 5.006;
use strict;
use warnings;
use MetaCPAN::Client;

sub new {
    return bless {}, shift;
}
sub get_reverse_dependencies
{
    my $self     = shift;
    my $distname = shift;

    my $mcpan = MetaCPAN::Client->new;
    my $rs = $mcpan->reverse_dependencies($distname);

    my @dists;

    while (my $release = $rs->next){
        push @dists, $release->distribution;
    }
    return @dists;
}

*revdeps = \&get_reverse_dependencies;

1;

=head1 NAME

CPAN::ReverseDependencies - given a CPAN dist name, find other CPAN dists that use it

=head1 SYNOPSIS

 use CPAN::ReverseDependencies;

 my $crd = CPAN::ReverseDependencies->new();

 my $module = 'Module-Path'; # or 'Module::Path'

 my @revdeps  = $crd->get_reverse_dependencies($module);

 # short-form alias

 my @revdeps = $crd->revdeps($module);

=head1 DESCRIPTION

B<CPAN::ReverseDependencies> takes the name of a CPAN distribution and
returns a list containing names of other CPAN distributions that have declared
a dependence on the specified distribution.

It uses the L<MetaCPAN|https://www.cpan.org>
L<API|https://github.com/CPAN-API/cpan-api/wiki/API-docs>
to look up the reverse dependencies, so obviously you have to be online
for this module to work.

This module will C<croak> in a number of situations:

=over 4

=item * If you request reverse dependencies for a non-existent distribution;

=item * If you're not online;

=item * If there's a problem with MetaCPAN itself.

=back

=head1 REPOSITORY

L<https://github.com/neilbowers/CPAN-ReverseDependencies>

=head1 AUTHOR

Neil Bowers E<lt>neilb@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Neil Bowers <neilb@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

