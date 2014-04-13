package Query::Builder::Insert;

use strict;
use warnings;
use utf8;

use base 'Exporter';

our @EXPORT = qw/insert_into columns values/;

sub insert_into {
    my ($self, $table) = @_;
    $self->{table} = $table;
    $self->append_query("INSERT INTO $table");
}

sub columns {
    my ($self, $columns) = @_;
    $self->{columns} = $columns;
    my $query = $self->join_and_wrap($columns);
    $self->append_query($query);
}

sub values {
    my ($self, $values) = @_;
    @{$self->{binds}} = map { $values->{$_} } @{$self->{columns}};
    $self->append_query("VALUES");
    my $query = $self->join_and_wrap([("?") x @{$self->{columns}}]);
    $self->append_query($query);
    $self;
}

1;
