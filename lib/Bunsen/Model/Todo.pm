package Bunsen::Model::Todo;
use Moose;
use DateTime::Moonpig;
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
    isa     => 'DateTime::Moonpig',
    is      => 'ro',
    default => sub { DateTime::Moonpig->new(time) },
);

sub age_in_days {
   my $self = shift;
   my $delta =  DateTime::Moonpig->new(time) - $self->created_at;
   $delta / (60 * 60 * 24);
}

sub age_in_weeks { 
    my $self = shift;
    return $self->age_in_days / 7;
}

has completed_at => (
    isa       => 'DateTime::Moonpig',
    is        => 'ro',
    predicate => 'is_complete',
    clearer   => 'uncomplete',
    writer    => '_completed_at',
);

sub complete { shift->_completed_at(DateTime::Moonpig->new(time)); }

sub priority { }

__PACKAGE__->meta->make_immutable;
1;
__END__
