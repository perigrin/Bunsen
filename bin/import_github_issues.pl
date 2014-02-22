#!/usr/bin/env perl
use 5.12.1;

use lib qw(lib);

use Magpie::ConfigReader::XML;
use Magpie::Breadboard;
use Pithub;
use Getopt::Long;
use DateTime::Format::ISO8601;
use Data::Dumper;
use aliased 'Bunsen::Model::Todo';

GetOptions( my $args = {}, 'config_file|c=s', 'user|u=s', 'token|t=s' )
  or die "$!";

my $config = Magpie::ConfigReader::XML->new;
$config->process( $args->{config_file} );
my $assets = Magpie::Breadboard->new;
$assets->add_asset($_) for @{ $config->assets };

my $kioku = $assets->resolve_asset( service => 'kioku_dir' );
my $scope = $kioku->new_scope;

my $gh = Pithub->new(
    user            => $args->{user},
    token           => $args->{token},
    auto_pagination => 1,
);

my $repos = $gh->issues->list( params => { filter => 'all' } );

while ( my $issue = $repos->next ) {
    my $created_at =
      DateTime::Format::ISO8601->parse_datetime( $issue->{created_at} )->epoch;

    my $todo = Todo->new(
        created_at  => DateTime::Moonpig->new($created_at),
        title       => $issue->{title},
        description => $issue->{body},
        origin      => $issue->{url},
        category    => $issue->{repository}{name},
        difficulty => rand 10,
        importance => rand 10,
    );
    $kioku->store($todo);
}

