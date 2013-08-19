#!perl

use strict;
use warnings;
use Test::More;
use PBS::Meta;

my $curdir = `pwd`;
chomp($curdir);
is(PBS::Meta->root_dir, $curdir, 'Meta root_dir() is the same as our current working directory');
is(PBS::Meta->root_dir('etc'), File::Spec->catdir($curdir, 'etc'), '... appends any parameter as subdir');
is(PBS::Meta->root_dir('dev', 'bin'), File::Spec->catdir($curdir, 'dev', 'bin'), '... even multiple levels');

done_testing();
