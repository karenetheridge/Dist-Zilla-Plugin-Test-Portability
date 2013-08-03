
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.3601"
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "Release tests for portability",
  "dist_author" => [
    "Marcel Gruenauer <marcel\@cpan.org>",
    "Randy Stauner <rwstauner\@cpan.org>",
    "Mike Doherty <doherty\@cpan.org>"
  ],
  "dist_name" => "Dist-Zilla-Plugin-Test-Portability",
  "dist_version" => "2.000005",
  "license" => "perl",
  "module_name" => "Dist::Zilla::Plugin::Test::Portability",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Dist::Zilla::Plugin::InlineFiles" => 0,
    "Dist::Zilla::Role::FileMunger" => 0,
    "Moose" => 0,
    "Test::Portability::Files" => 0,
    "perl" => "5.008",
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => [],
  "test_requires" => {
    "Capture::Tiny" => 0,
    "Moose::Autobox" => 0,
    "Test::DZil" => 0,
    "Test::More" => "0.96",
    "Test::Output" => 0,
    "autodie" => 0
  }
);


unless ( eval { Module::Build->VERSION(0.4004) } ) {
  my $tr = delete $module_build_args{test_requires};
  my $br = $module_build_args{build_requires};
  for my $mod ( keys %$tr ) {
    if ( exists $br->{$mod} ) {
      $br->{$mod} = $tr->{$mod} if $tr->{$mod} > $br->{$mod};
    }
    else {
      $br->{$mod} = $tr->{$mod};
    }
  }
}

my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
