package Classes::Lancom::Component::EnvironmentalSubsystem;
our @ISA = qw(Monitoring::GLPlugin::SNMP::Item);
use strict;

sub init {
  my $self = shift;
  $self->get_snmp_objects('LCOS-MIB', (qw(
      lcsStatusHardwareInfoTemperatureDegrees)));
}

sub check {
  my $self = shift;
  $self->add_info('checking temperature');
  $self->add_info(sprintf 'temperature is is %.2f',
      $self->{lcsStatusHardwareInfoTemperatureDegrees});
  $self->set_thresholds(
      metric => 'temperature',
      warning => 80,
      critical => 90,
  );
  $self->add_message($self->check_thresholds(
      metric => 'temperature',
      value => $self->{lcsStatusHardwareInfoTemperatureDegrees},
  ));
  $self->add_perfdata(
      label => 'temperature',
      value => $self->{lcsStatusHardwareInfoTemperatureDegrees},
  );
}

