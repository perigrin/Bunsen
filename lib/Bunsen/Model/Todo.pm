package Bunsen::Model::Todo;
use Moose;
use DateTime::Tiny;
use namespace::autoclean;

has description => (
    isa      => 'Str',
    is       => 'ro',
    required => 1
);

has category => (
    isa      => 'Str',
    is       => 'ro',
    required => 1,
);

has [qw(importance difficulty)] => (
    isa      => 'Num',
    is       => 'ro',
    required => 1,
);

has created_at => (
    isa     => 'DateTime::Tiny',
    is      => 'ro',
    default => sub { DateTime::Tiny->now },
);

has completed_at => (
    isa       => 'DateTime::Tiny',
    is        => 'ro',
    predicate => 'is_complete',
    clearer   => 'uncomplete',
    writer    => '_completed_at',
);

sub complete { shift->_completed_at(DateTime::Tiny->now); }

sub priority { }

__PACKAGE__->meta->make_immutable;
1;
__END__
