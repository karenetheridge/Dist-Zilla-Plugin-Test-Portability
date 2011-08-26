use 5.008;
use strict;
use warnings;

package Dist::Zilla::Plugin::PortabilityTests;
# ABSTRACT: (DEPRECATED) Release tests for portability
# VERSION
use Moose;
extends 'Dist::Zilla::Plugin::Test::Portability';

before register_component => sub {
    warn '!!! [PortabilityTests] is deprecated and will be removed in a future release; please use [Test::Portability].';
};

=head1 SYNOPSIS

Please use L<Dist::Zilla::Plugin::Test::Portability> instead.

In C<dist.ini>:

    [Test::Portability]

=for test_synopsis
1;
__END__

=cut

1;
