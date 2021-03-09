package Rover;
use Modern::Perl;
use Moose;
use Moose::Util::TypeConstraints;

enum OrientationValues => [qw/N S E W/];

has [ 'x', 'y' ]  => ( is => 'rw', isa => 'Int',               default => 0 );
has 'orientation' => ( is => 'rw', isa => 'OrientationValues', default => 'N' );

sub get_position {
    my $self = shift;

    return $self->x, " ", $self->y, " ", $self->orientation;
}

sub execute_command {
    my $self    = shift;
    my $command = shift;
    if ( $command eq 'L' or $command eq 'R' ) {
        $self->_set_orientation($command);
    }
    elsif ( $command eq 'M' ) {

        $self->_move;
    }
    else {

        say "Invalid command: $command";
    }
}

sub _set_orientation {
    my $self      = shift;
    my $direction = shift;

    my $current_orientation = $self->orientation;

    if ( $direction eq 'L' ) {
        $self->orientation('W') if $current_orientation eq 'N';
        $self->orientation('S') if $current_orientation eq 'W';
        $self->orientation('E') if $current_orientation eq 'S';
        $self->orientation('N') if $current_orientation eq 'E';
    }

    if ( $direction eq 'R' ) {
        $self->orientation('E') if $current_orientation eq 'N';
        $self->orientation('S') if $current_orientation eq 'E';
        $self->orientation('W') if $current_orientation eq 'S';
        $self->orientation('N') if $current_orientation eq 'W';
    }

}

sub _move {
    my $self = shift;
    $self->y( $self->y + 1 ) if $self->orientation eq "N";
    $self->x( $self->x + 1 ) if $self->orientation eq "E";
    $self->y( $self->y - 1 ) if $self->orientation eq "S";
    $self->x( $self->x - 1 ) if $self->orientation eq "W";
}

1;
