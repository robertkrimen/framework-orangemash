use strict;
use warnings;

use Test::Most;

plan qw/no_plan/;

use Framework::Orangemash::PathDispatch;

my $pf = Framework::Orangemash::PathDispatch->new;
ok( $pf, "PathDispatch object is okay...");
ok( $pf->manifest, "...as well as ->manifest" );
ok( $pf->finder, "...as well as ->finder"  );

{
    $pf->include(<<_END_);
    # Skip this line
/

    /this.html

# Previous line should be skipped
/this     # This is a comment for /this
/that/#Comment with no gap

/comment-and-data comment-and-data.tt.html # This is the comment
/just-data just-data.tt.html
_END_

    for (qw(
        /
        /this.html
        /this
        /that/
        /comment-and-data
        /just-data
    )) {
        ok( $pf->entry->{$_} );
        is( $pf->entry->{$_}->path, $_ );
    }

    is( $pf->entry->{'/this'}->comment, 'This is a comment for /this' );
    is( $pf->entry->{'/that/'}->comment, 'Comment with no gap' );
    is( $pf->entry->{'/comment-and-data'}->comment, 'This is the comment' );

    is( $pf->entry->{'/comment-and-data'}->data, 'comment-and-data.tt.html' );
    is( $pf->entry->{'/just-data'}->data, 'just-data.tt.html' );
}

{
    $pf->target( path => 'a' );
    $pf->target( path => 'a/b/c', rank => 1 );

    my $match;
    ok( $match = $pf->find( 'a' ) );
    is( $match->found, 1 );
}

