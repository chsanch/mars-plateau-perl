package Plateau;
use Modern::Perl;
use Moose;

has [ 'upper_x', 'upper_y' ] => ( is => 'rw', isa => 'Int', default => 8 );
has [ 'lower_x', 'lower_y' ] => ( is => 'rw', isa => 'Int', default => 0 );

return 1;
