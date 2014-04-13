package Query::Builder::Select;

use strict;
use warnings;
use utf8;

use base 'Exporter';

our @EXPORT = qw/select from order_by limit/;

sub select {
    my ($self, $columns) = @_;
    $self->{columns} = $columns;
    $self->append_query("SELECT");   

    my $query = $self->join_params($columns);
    $self->append_query($query);
}

sub from {
    my ($self, $table) = @_;

    # 配列のリファレンスで渡されて来た場合は結合する
    $table = $self->join_params($table) if ref $table eq 'ARRAY';

    $self->append_query("FROM");
    $self->append_query($table);
}

sub order_by {
    my ($self, $column, $direction) = @_;
    $self->{order}->{$column} = $direction;
    $self->append_query("ORDER BY $column $direction");
}

sub limit {
    my ($self, $limit) = @_;
    $self->{limit} = $limit;
    $self->append_query("LIMIT $limit");
}

1;
