use strict;
use warnings;

use Test::Most;

use Framework::Orangemash::PathDispatch::Manifest;

plan qw/no_plan/;

{
    my $manifest = Framework::Orangemash::PathDispatch::Manifest->new;
    $manifest->include(<<_END_);
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
        ok( $manifest->entry->{$_} );
        is( $manifest->entry->{$_}->path, $_ );
    }

    is( $manifest->entry->{'/this'}->comment, 'This is a comment for /this' );
    is( $manifest->entry->{'/that/'}->comment, 'Comment with no gap' );
    is( $manifest->entry->{'/comment-and-data'}->comment, 'This is the comment' );

    is( $manifest->entry->{'/comment-and-data'}->data, 'comment-and-data.tt.html' );
    is( $manifest->entry->{'/just-data'}->data, 'just-data.tt.html' );

}
