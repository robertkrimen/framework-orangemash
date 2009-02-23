package Framework::Orangemash::PathDispatch;

use strict;
use warnings;

use Moose;

use Framework::Orangemash::PathDispatch::Manifest;
use Framework::Orangemash::PathDispatch::Finder;

sub BUILD {
    my $self = shift;
    my $given = shift;

    if (ref $given->{manifest} eq 'HASH') {
        $self->{manifest} = Framework::Orangemash::PathDispatch::Manifest->new( %{ $given->{manifest} } );
    }

    if (ref $given->{finder} eq 'HASH') {
        $self->{finder} = Framework::Orangemash::PathDispatch::Finder->new( %{ $given->{finder} } );
    }
}

has manifest => qw/is ro isa Framework::Orangemash::PathDispatch::Manifest lazy_build 1/, handles => [qw/ entry entry_list add each include /];
sub _build_manifest {
    my $self = shift;
    return Framework::Orangemash::PathDispatch::Manifest->new;
}

has finder => qw/is ro isa Framework::Orangemash::PathDispatch::Finder lazy_build 1/, handles => [qw/ target find /];
sub _build_finder {
    my $self = shift;
    return Framework::Orangemash::PathDispatch::Finder->new;
}

1;
