package Piebald::Resource::Object;
use Moose;
extends "Magpie::Resource::Kioku";

use Magpie::Constants;

before [HTTP_METHODS] => sub {
    my $self = shift;
    my $ctxt = shift;
    $self->data( $ctxt->{data} ) if exists $ctxt->{data};
};


1;
__END__
