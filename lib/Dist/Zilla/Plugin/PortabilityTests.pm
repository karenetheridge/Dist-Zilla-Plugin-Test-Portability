use strict;
use warnings;

package Dist::Zilla::Plugin::PortabilityTests;
# ABSTRACT: (DEPRECATED) Release tests for portability

our $VERSION = '2.001000';

use Moose;
extends 'Dist::Zilla::Plugin::Test::Portability';

before register_component => sub {
    warnings::warnif('deprecated',
        "!!! [PortabilityTests] is deprecated and will be removed in a future release; please use [Test::Portability].\n",
    );
};

=head1 SYNOPSIS

Please use L<Dist::Zilla::Plugin::Test::Portability> instead.

In C<dist.ini>:

    [Test::Portability]

=begin :prelude

=for test_synopsis BEGIN { die "SKIP: synopsis isn't perl code" }

=end :prelude

=cut

1;
