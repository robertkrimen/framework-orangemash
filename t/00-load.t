#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Framework::Orangemash' );
}

diag( "Testing Framework::Orangemash $Framework::Orangemash::VERSION, Perl $], $^X" );
