use Modern::Perl;
use lib 'lib';
use MarsPlateau;

die "Please provide a input file" if ( !$ARGV[0] );

my $file = $ARGV[0];

open( my $fh, "<", $file ) or die "Can't open < $file: $!";

my ( $upper_x, $upper_y, $rover_id ) = 0;
my $rovers;

while ( my $line = <$fh> ) {
    if ( $. == 1 ) {
        ( $upper_x, $upper_y ) = split " ", $line;
    }

    if ( $line =~ /^\d\s\d\s\w/ ) {
        $rover_id += 1;
        my ( $x, $y, $o ) = split " ", $line;
        $rovers->{$rover_id}->{'x'}           = $x;
        $rovers->{$rover_id}->{'y'}           = $y;
        $rovers->{$rover_id}->{'orientation'} = $o;
    }

    if ( $line =~ /^[a-zA-Z]/ ) {
        my @commands = split " ", $line;
        $rovers->{$rover_id}->{'commands'} = \@commands;
    }
}

my $plateau = MarsPlateau->new( upper_x => $upper_x, upper_y => $upper_y );

foreach my $rover_id ( sort keys %{$rovers} ) {
    $plateau->add_rover(
        {
            x           => $rovers->{$rover_id}->{'x'},
            y           => $rovers->{$rover_id}->{'y'},
            orientation => $rovers->{$rover_id}->{'orientation'}
        }
    );

    foreach my $command ( @{ $rovers->{$rover_id}->{'commands'} } ) {
        $plateau->execute_command($command);
    }

    say $plateau->current_rover->get_position;
}
