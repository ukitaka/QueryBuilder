package Query::Builder::Condition;

use strict;
use warnings;
use utf8;

use base 'Exporter';

our @EXPORT = qw/join_cond where cond equal like and or/;

sub where {
    my ($self, $cond) = @_;
    $self->append_query("WHERE");
}

sub join_cond {
    my ($self, $join, $cond) = @_;
    join " $join ", @$cond;
}

sub cond {
    my ($self, $comp, $cond, $wrap) = @_;
    my @conds;
    while (my ($key, $value) = each %$cond) {
        push @conds ,"$key $comp ?";
        push @{$self->{binds}}, $value;
    }
    my $query = $self->join_cond("AND", \@conds);
    $query = $self->wrap($query) if $wrap;
    $self->append_query($query);
}

sub equal {
    my ($self, $cond, $wrap) = @_;
    $self->cond("=", $cond, $wrap);
}

sub like {
    my ($self, $cond, $wrap) = @_;
    $self->cond("LIKE", $cond, $wrap);
}

sub and {
    my ($self) = @_;
    $self->append_query("AND");
}

sub or {
    my ($self, $table) = @_;
    $self->append_query("OR");
}

1;
