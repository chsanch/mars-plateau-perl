package MarsPlateau;
use Modern::Perl;

use Moose;
use Moose::Util::TypeConstraints;
use Plateau;
use Rover;

has 'plateau' => ( isa => 'Plateau', is => 'rw' );
has 'rovers'  => (
    is      => 'rw',
    isa     => 'ArrayRef[Rover]',
    default => sub { [] },
);

sub BUILD {
    my ( $self, $params ) = @_;
    die "Need upper limits"
      unless $params->{'upper_x'} and $params->{'upper_y'};
    $self->plateau(
        Plateau->new(
            upper_x => $params->{upper_x},
            upper_y => $params->{upper_y}
        )
    );
}

sub add_rover {
    my ( $self, $params ) = @_;
    my $rover = Rover->new(
        x           => $params->{x},
        y           => $params->{y},
        orientation => $params->{orientation}
    );

    push @{ $self->rovers }, $rover;
    return 1;
}

sub current_rover {
    my $self = shift;
    return @{ $self->rovers }[-1];
}

sub execute_command {
    my $self    = shift;
    my $command = shift;
    if ( $command eq "M" ) {
        my $next_move = $self->_check_next_move;
        if (   $next_move > $self->plateau->upper_x
            or $next_move > $self->plateau->upper_y
            or $next_move < $self->plateau->lower_x
            or $next_move < $self->plateau->lower_y )
        {
            say "Out of boundaries";
        }
        else {
            $self->current_rover->_move;
        }
    }
    else {
        $self->current_rover->execute_command($command);
    }
}

sub _check_next_move {
    my $self = shift;
    return $self->current_rover->y + 1
      if $self->current_rover->orientation eq "N";
    return $self->current_rover->x + 1
      if $self->current_rover->orientation eq "E";
    return $self->current_rover->y - 1
      if $self->current_rover->orientation eq "S";
    return $self->current_rover->x - 1
      if $self->current_rover->orientation eq "W";
}

return 1;
