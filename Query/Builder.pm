package Query::Builder;

use strict;
use warnings;
use utf8;

use Query::Builder::Condition;
use Query::Builder::Insert;
use Query::Builder::Select;

sub new {
    my ($class) = @_;
    bless +{
        query   => "",
        table   => "",
        columns => [],
        binds   => [],
        order   => +{},
        limit   => undef
    }, $class;
}

# queryに結合
sub append_query {
    my ($self, $query) = @_;
    $self->{query} .= " $query";
    $self;
}

# ()で囲む
sub wrap {
    my ($self, $query) = @_;
    "($query)";
}

# パラメータを , で結合する
sub join_params {
    my ($self, $params) = @_;
    join ", ", @$params;
}

# 結合して囲む
sub join_and_wrap {
    my ($self, $params) = @_;
    my $query = $self->join_params($params);
    $query = $self->wrap($query);
}

1;
