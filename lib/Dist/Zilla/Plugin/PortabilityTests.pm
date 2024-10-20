use strict;
use warnings;

package Dist::Zilla::Plugin::PortabilityTests;
# ABSTRACT: (DEPRECATED) Release tests for portability

our $VERSION = '2.001003';

use Moose;
use namespace::autoclean;

extends 'Dist::Zilla::Plugin::Test::Portability';

before register_component => sub {
    warnings::warnif('deprecated',
        "!!! [PortabilityTests] is deprecated and will be removed in a future release; replace it with [Test::Portability].\n",
    );
};

__PACKAGE__->meta->make_immutable;
__END__

=pod

=head1 SYNOPSIS

In your F<dist.ini>:

    [Test::Portability]

=begin :prelude

=for test_synopsis BEGIN { die "SKIP: synopsis isn't perl code" }

=end :prelude

=head1 DESCRIPTION

THIS MODULE IS DEPRECATED. Please use
L<Dist::Zilla::Plugin::Test::Portability> instead. It may be removed at a
later time (but not before February 2017).

=cut
