package Bunsen;
use Moose;

# ABSTRACT: A Honey-Do manager

use FindBin;
use Plack::Builder;

sub app {
    my $self = shift;
    builder {
        enable 'MethodOverride';
        enable 'Session';
        enable 'AccessLog';
        enable "Static",
            path => qr{(?:^/(?:images|js|css)/|\.(?:txt|html|xml|ico)$)},
            root => 'root/static';
        enable "Magpie",
            conf   => 'conf/magpie.xml';
    };
}

1;
__END__
