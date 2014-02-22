package Bunsen::Model::Todo;
use Moose;
use namespace::autoclean;

has description => (
    is       => 'ro',
    isa      => 'Str',
    required => 1
);

__PACKAGE__->meta->make_immutable;
1;
__END__