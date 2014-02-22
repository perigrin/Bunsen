#!/usr/bin/env perl
use strict;
use Test::More;

use DateTime::Moonpig;
use JSON::Any;
use aliased 'Bunsen::Model::Todo';

{
    ok my $todo = Todo->new(
        title => 'test',
        category    => 'test',
        description => 'a simple todo',
        importance  => rand 10,
        difficulty  => rand 10,
    );

    is $todo->created_at, DateTime::Moonpig->new(time), "created now";
    ok !$todo->is_complete, 'todo not completed';
    ok $todo->complete,     'complete todo';
    ok $todo->is_complete,  'todo is completed';
    is $todo->completed_at, DateTime::Moonpig->new(time), 'completed now';
    ok $todo->uncomplete,   'uncomplete todo';
    ok !$todo->is_complete, 'todo not completed';
    is $todo->completed_at, undef, 'completed_at undef';
}

{
    my $todo = Todo->new(
        title => 'test',
        created_at  => DateTime::Moonpig->new( time - 7 * 24 * 3600 ),
        category    => 'test',
        description => '',
        importance  => rand 10,
        difficulty  => rand 10,
    );

    is $todo->age_in_days,  7, "todo is 7 days old";
    is $todo->age_in_weeks, 1, "and 1 week old";
}
{
    my $todo = Todo->new(
        title => 'test',
        created_at  => DateTime::Moonpig->new( time - 7 * 24 * 3600 ),
        category    => 'test',
        description => '',
        importance  => rand 10,
        difficulty  => rand 10,
    );

    isnt( JSON::Any->new(convert_blessed => 1)->encode( $todo), 'null', 'converted');
    note( JSON::Any->new(convert_blessed => 1)->encode($todo) );
}
done_testing;
