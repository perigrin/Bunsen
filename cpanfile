requires 'AI::FuzzyEngine';
requires "DateTime::Moonpig";
requires 'JSON::Any';
requires 'KiokuDB';
requires 'KiokuDB::Backend::DBI';
requires 'Magpie';
requires 'Moose';
requires 'namespace::autoclean';
requires 'Plack::Middleware::MethodOverride';
requires 'Plack::Middleware::Session';
requires 'Template';
requires 'XML::LibXML';
requires 'Pithub';
requires 'DateTime::Format::ISO8601';

on 'test' => sub {
    requires => 'aliased';
};
