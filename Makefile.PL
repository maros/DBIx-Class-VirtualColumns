# Load the Module::Install bundled in ./inc/
use strict;
use inc::Module::Install;

# Define metadata
name            'DBIx-Class-VirtualColumns';
all_from        'lib/DBIx/Class/VirtualColumns.pm';

perl_version    '5.000';

# Specific dependencies
requires        'DBIx::Class'           => 0;

build_requires  'DBD::SQLite'           => 0;
build_requires  'Test::Pod'             => 0;
build_requires  'Test::Pod::Coverage'   => 0;


WriteAll;