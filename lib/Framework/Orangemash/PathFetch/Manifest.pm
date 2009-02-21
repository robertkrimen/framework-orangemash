package Framework::Orangemash::PathFetch::Manifest;

use Moose;

has _entry_list => qw/is ro required 1/, default => sub { {} };

# TODO:
# has parser => ...
# has parse_by_line => ...
# has parse_ignore => ...

sub _entry {
    my $self = shift;
    return $_[0] if @_ == 1 && blessed $_[0];
    return Framework::Orangemash::PatchFetch::Manifest::Entry->new(@_);
}

sub entry_list {
    return shift->_entry_list;
}

sub entry {
    my $self = shift;
    return $self->_entry_list unless @_;
    my $path = shift;
    return $self->_entry_list->{$path};
}

sub add {
    my $self = shift;
    my $entry = $self->_entry(@_);
    $self->_entry_list->{$entry->path} = $entry;
}

sub each {
    my $self = shift;
    my $code = shift;

    for (sort keys %{ $self->_entry_list }) {
        $code->($self->entry->{$_})
    }
}

sub include {
    my $self = shift;

    while (@_) {
        local $_ = shift;
        if ($_ =~ m/\n/) {
            $self->_include_list($_);
        }
        else {
            my $path = $_;
            my %entry;
            %entry = %{ shift() } if ref $_[0] eq 'HASH';
            $self->add(path => $_ => %entry);
        }
    }
}

sub _include_list {
    my $self = shift;
    my $list = shift;

    for (split m/\n/, $list) {
        chomp;
        next if m/^\s*$/ || m/^\s*#/;
        my ($path, $data, $comment) = m/^\s*([^#\s]+)(?:\s*([^#]+))?(?:\s*#\s*(.*))?$/;
        s/^\s*//, s/\s*$// for $path;
        if (defined $data) {
            s/^\s*//, s/\s*$// for $data;
        }
        $self->add(path => $path, data => $data, comment => $comment);
    }
}

#sub copy_into {
#    my $self = shift;
#    my $setup_manifest = shift;
#    $self->each(sub {
#        $setup_manifest->add(shift->copy);
#    });
#}

package Framework::Orangemash::PatchFetch::Manifest::Entry;

use Moose;

has path => qw/is ro required 1/;
has comment => qw/is ro isa Maybe[Str]/;
has data => qw/is ro isa Maybe[Str]/;

#sub copy {
#    my $self = shift;
#    return (ref $self)->new(map { $_ => $self->$_ } qw/path comment data/);
#}

1;

