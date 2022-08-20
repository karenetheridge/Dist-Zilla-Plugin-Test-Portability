use strict;
use warnings;

package Dist::Zilla::Plugin::Test::Portability;
# ABSTRACT: Author tests for portability

our $VERSION = '2.001001';

use Moose;
with qw/
    Dist::Zilla::Role::FileGatherer
    Dist::Zilla::Role::FileInjector
    Dist::Zilla::Role::PrereqSource
    Dist::Zilla::Role::TextTemplate
/;
use Dist::Zilla::File::InMemory;
use Sub::Exporter::ForMethods 'method_installer';
use Data::Section 0.004 { installer => method_installer }, '-setup';
use namespace::autoclean;

has options => (
  is      => 'ro',
  isa     => 'Str',
  default => '',
);

around dump_config => sub
{
    my ($orig, $self) = @_;
    my $config = $self->$orig;

    $config->{+__PACKAGE__} = {
        options => $self->options,
        blessed($self) ne __PACKAGE__ ? ( version => $VERSION ) : (),
    };
    return $config;
};

sub register_prereqs {
    my ($self) = @_;

    $self->zilla->register_prereqs({
            phase => 'develop',
            type  => 'requires',
        },
        'Test::More' => 0,
        'Test::Portability::Files' => '0',
    );

    return;
}

sub gather_files {
    my $self = shift;

    # 'name => val, name=val'
    my %options = split(/\W+/, $self->options);

    my $opts = '';
    if (%options) {
        $opts = join ', ', map "$_ => $options{$_}", sort keys %options;
        $opts = "options($opts);";
    }

    my $filename = 'xt/author/portability.t';
    my $filled_content = $self->fill_in_string(
        ${ $self->section_data($filename) },
        { opts => $opts },
    );
    $self->add_file(
        Dist::Zilla::File::InMemory->new({
            name => $filename,
            content => $filled_content,
        })
    );

    return;
}

__PACKAGE__->meta->make_immutable;
1;

=pod

=begin :prelude

=for test_synopsis BEGIN { die "SKIP: synopsis isn't perl code" }

=end :prelude

=head1 SYNOPSIS

In your F<dist.ini>:

    [Test::Portability]
    ; you can optionally specify test options
    options = test_dos_length = 1, use_file_find = 0

=cut

=head1 DESCRIPTION

This is an extension of L<Dist::Zilla::Plugin::InlineFiles>, providing the
following file:

  xt/author/portability.t - a standard Test::Portability::Files test

You can set options for the tests in the 'options' attribute:
Specify C<< name = value >> separated by commas.

See L<Test::Portability::Files/options> for possible options.

=cut

=for Pod::Coverage register_prereqs

=cut

=head2 munge_file

Inserts the given options into the generated test file.

=for Pod::Coverage gather_files

=cut

__DATA__
___[ xt/author/portability.t ]___
use strict;
use warnings;

use Test::More;

use Test::Portability::Files;
{{$opts}}
run_tests();
