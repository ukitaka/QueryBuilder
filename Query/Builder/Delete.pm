package Query::Builder::Delete;

use strict;
use warnings;
use utf8;

use base 'Exporter';

our @EXPORT = qw/delete_from columns values/;

sub delete_from {
    my ($self, $table) = @_;
    $self->{table} = $table;
    $self->append_query("DELETE FROM $table");
}

1;
