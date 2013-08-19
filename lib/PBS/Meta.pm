package PBS::Meta;

# ABSTRACT: discover, collect all the meta-information about a project

## By design, no other PBS deps, we want this module to be as standalone
## as possible. Also trying to make it coremodules only
use strict;
use warnings;
use feature 'state';
use File::Spec;
use Cwd 'realpath';

sub root_dir {
  shift;
  state $root_dir = do {
    my $path = realpath($INC{'PBS/Meta.pm'});
    my $dir  = (File::Spec->splitpath($path))[1];
    my @dir  = File::Spec->splitdir($dir);

    while (@dir and !-e File::Spec->catfile(@dir, '.pbs_project')) { pop @dir }

    confess("FATAL: failed to determine project root, no .pbs_project file found") unless @dir;

    \@dir;
  };

  return File::Spec->catdir(@$root_dir, @_);
}

1;
