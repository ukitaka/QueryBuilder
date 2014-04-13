package Query::Builder::Update;

use strict;
use warnings;
use utf8;

use base 'Exporter';

our @EXPORT = qw/update set/;

sub update {
    my ($self, $table) = @_;
    $self->{table} = $table;
    $self->append_query("UPDATE $table");
}

sub set {
    my ($self, $values) = @_;
    @{$self->{binds}} = map { $values->{$_} } @{$self->{columns}};
    $self->append_query("SET");
    my $query = $self->join_and_wrap([("?") x @{$self->{columns}}]);
    $self->append_query($query);
    $self;
}

1;
