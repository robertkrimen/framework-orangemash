#!/usr/bin/perl -w

use strict;
use warnings;

my $factory = undef;

sub register {
    
    $factory->setup_at( 'yui.css' )->use( 'yui/all.css' )
    $factory->setup_at( 'yui.js' )->use( 'yui/all.js' )
    $factory->setup_at( '$identifier.css' )->use( 'starter/base.css' )
    $factory->setup_at( '$identifier.js' )->use( 'starter/base.js' )

    $factory->manifest->setup( 'location' => 'handler' )
    $factory->manifest->render( 'location' => 'handler' )
    $factory->manifest->render( 'location' )

    $factory->handler( 'location' )->around( '...' )
    $factory->handler( 'location' )->set( '...' )
    $factory->handler( 'location' )->replace( '...' )
    $factory->handler( 'location' )->before( '...' )
    $factory->handler( 'location' )->after( '...' )

    $factory->handler( 'location' )->set( sub { 
        my ($path, $part) = @_;
    } );

    $factory->manifest( 'location' )->setup( '...' )
    $factory->manifest( 'location' )->render( '...' )
    $factory->manifest( 'location' )->render

    $factory->prepare_setup( 'path' => '...' )
    $factory->prepare_render( 'path' => '...' )
    $factory->prepare_render( 'path' )
    $factory->install_setup_handler( 'path' => '...'  )
    $factory->install_render_handler( 'path' => '...'  )

    # An action is more generic than setup/render

    $factory->setup_path( 'path' => '...' )
    $factory->render_path( 'path' => '...' )
    $factory->render_path( 'path' )
    $factory->setup_action( 'path' => '...' )
    $factory->render_action( 'path' => '...' )

    
}

1;
