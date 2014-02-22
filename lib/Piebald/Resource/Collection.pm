package Piebald::Resource::Collection;
use Moose;
extends "Magpie::Resource::Kioku";

use Moose::Util::TypeConstraints;
use Eval::Closure;
use Magpie::Constants;
use Try::Tiny;

before [HTTP_METHODS] => sub {
    my $self = shift;
    my $ctxt = shift;
    $self->data( $ctxt->{data} ) if exists $ctxt->{data};
};

subtype __PACKAGE__ . '::Type::CodeRef' => as 'CodeRef';
coerce __PACKAGE__
  . '::Type::CodeRef' => from Str => via { eval_closure( source => $_ ) };

has generator => (
    isa     => __PACKAGE__ . '::Type::CodeRef',
    traits  => ['Code'],
    handles => { fetch => 'execute_method' },
    builder => 'default_generator',
    coerce  => 1,
);

sub default_generator {
    my $self = shift;
    my $check_wrapper_class = sub { shift->isa( $self->wrapper_class ) };
    sub { scalar $self->data_source->grep($check_wrapper_class); }
}

has filter => (
    isa     => __PACKAGE__ . '::Type::CodeRef',
    traits  => ['Code'],
    handles => { filter => 'execute_method' },
    builder => 'default_filter',
    coerce  => 1,
);

sub default_filter {
    sub { $_[1] }
}

sub GET {
    my $self = shift;
    my $ctxt = shift;

    $self->parent_handler->resource($self);

    my $req  = $self->request;
    my $path = $req->path_info;
    my $data = $self->filter( $self->fetch );

    unless ($data) {
        $self->set_error(
            { status_code => 404, reason => 'Resource not found.' } );
        return OK;
    }
    $self->data($data);
    return OK;
}

1;
__END__
