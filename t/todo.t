#!/usr/bin/env perl
use strict;
use Test::More;

use DateTime::Tiny;
use aliased 'Bunsen::Model::Todo';

ok my $todo = Todo->new(
    category    => 'test',
    description => 'a simple todo',
    importance  => rand 10,
    difficulty  => rand 10,
);

is $todo->created_at, DateTime::Tiny->now, "created now";
ok ! $todo->is_complete, 'todo not completed';
ok $todo->complete, 'complete todo';
ok $todo->is_complete, 'todo is completed';
is $todo->completed_at, DateTime::Tiny->now, 'completed now';
ok $todo->uncomplete, 'uncomplete todo';
ok ! $todo->is_complete, 'todo not completed';
is $todo->completed_at, undef, 'completed_at undef';
done_testing;
