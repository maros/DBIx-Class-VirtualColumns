package # hide from PAUSE 
    VCTest;

use strict;
use warnings;
use VCTest::Schema;

sub init_schema {
    my $self = shift;
    my %args = @_;

    my $schema;

    if ($args{compose_connection}) {
        $schema = VCTest::Schema->compose_connection(
            'VCTest', "dbi:SQLite:t/var/vctest.db","","", { AutoCommit => 1 }
        );
    } else {
        $schema = VCTest::Schema->compose_namespace('VCTest');
    }
    if ( !$args{no_connect} ) {
        $schema = $schema->connect("dbi:SQLite:t/var/vctest.db","","", { AutoCommit => 1 });
        $schema->storage->on_connect_do(['PRAGMA synchronous = OFF']);
    }
    if ( !$args{no_deploy} ) {
        __PACKAGE__->deploy_schema( $schema );
    }
    return $schema;
}

sub deploy_schema {
    my $self = shift;
    my $schema = shift;

    if ($ENV{"VCTEST_SQLT_DEPLOY"}) {
        return $schema->deploy();
    } else {
        open IN, "t/var/vctest.sql";
        my $sql;
        { local $/ = undef; $sql = <IN>; }
        close IN;
        ($schema->storage->dbh->do($_) || print "Error on SQL: $_\n") for split(/;\n/, $sql);
    }
}

1;