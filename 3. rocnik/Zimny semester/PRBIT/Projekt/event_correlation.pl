use strict;
use warnings;
use Text::CSV;
use Date::Parse;

# Cesta k CSV súboru
my $file = 'events.csv';

# Inicializácia CSV parsera
my $csv = Text::CSV->new({ binary => 1, auto_diag => 1 });

# Vytvorenie hash pre koreláciu
my %correlated_events;

# Otvorenie súboru a čítanie udalostí
open my $fh, '<', $file or die "Could not open '$file' $!";
# Preskočenie hlavičky
$csv->getline($fh);

while (my $row = $csv->getline($fh)) {
    my ($timestamp, $message, $severity) = @$row;
    my $time = str2time($timestamp);

    # Uloženie udalosti do hashu podľa závažnosti
    push @{ $correlated_events{$severity} }, { time => $time, message => $message };
}

close $fh;

# Zobrazenie korelovaných udalostí
foreach my $severity (sort keys %correlated_events) {
    print "Severity: $severity\n";
    foreach my $event (sort { $a->{time} <=> $b->{time} } @{ $correlated_events{$severity} }) {
        print "  Time: " . localtime($event->{time}) . " - " . $event->{message} . "\n";
    }
    print "\n";  # Prázdny riadok pre oddelenie závažností
}