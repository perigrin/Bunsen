requires 'AI::FuzzyInference';
requires "DateTime::Tiny";
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

on 'test' => sub {
    requires => 'aliased';
};
