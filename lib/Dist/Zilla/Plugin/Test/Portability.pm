use 5.008;
use strict;
use warnings;

package Dist::Zilla::Plugin::Test::Portability;
# ABSTRACT: Release tests for portability
# VERSION
use Moose;
with qw/
    Dist::Zilla::Role::FileGatherer
    Dist::Zilla::Role::FileInjector
    Dist::Zilla::Role::TextTemplate
/;
use Dist::Zilla::File::InMemory;
use Data::Section -setup;

=head1 SYNOPSIS

In C<dist.ini>:

    [Test::Portability]
    ; you can optionally specify test options
    options = test_dos_length = 1, use_file_find = 0

=for test_synopsis
1;
__END__

=cut

=head1 DESCRIPTION

This is an extension of L<Dist::Zilla::Plugin::InlineFiles>, providing the
following file:

  xt/release/portability.t - a standard Test::Portability::Files test

You can set options for the tests in the 'options' attribute:
Specify C<< name = value >> separated by commas.

See L<Test::Portability::Files/options> for possible options.

=cut

has options => (
  is      => 'ro',
  isa     => 'Str',
  default => '',
);

=head2 munge_file

Inserts the given options into the generated test file.

=for Pod::Coverage gather_files

=cut

sub gather_files {
    my $self = shift;

    # 'name => val, name=val'
    my %options = split(/\W+/, $self->options);

    my $opts = '';
    if (%options) {
        $opts = join ', ', map { "$_ => $options{$_}" } sort keys %options;
        $opts = "options($opts);";
    }

    my $filename = 'xt/release/portability.t';
    my $content  = $self->section_data($filename);
    my $filled_content = $self->fill_in_string( $$content, { opts => $opts } );
    $self->add_file(
        Dist::Zilla::File::InMemory->new({
            name => $filename,
            content => $filled_content,
        })
    );

    return;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__DATA__
___[ xt/release/portability.t ]___
#!perl

use strict;
use warnings;

use Test::More;

eval 'use Test::Portability::Files';
plan skip_all => 'Test::Portability::Files required for testing portability'
    if $@;
{{$opts}}
run_tests();
