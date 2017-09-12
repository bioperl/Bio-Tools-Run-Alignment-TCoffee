package Bio::Installer::TCoffee;

use vars qw(@ISA %DEFAULTS);
use strict;

use Bio::Root::Root;
use Bio::Installer::Generic;

@ISA = qw(Bio::Installer::Generic );

# ABSTRACT: DESCRIPTION of Object
# AUTHOR: Albert Vilella <avilella@gmail.com>
# OWNER: Albert Vilella <avilella@gmail.com>
# LICENSE: Perl_5

=head1 SYNOPSIS

Give standard usage here

=head1 DESCRIPTION

Describe the object here

=cut

BEGIN {
    %DEFAULTS = ( 'ORIGIN_DOWNLOAD_DIR' => 'http://www.tcoffee.org/Packages/',
                  'BIN_FOLDER' => 'bin',
                  'DESTINATION_DOWNLOAD_DIR' => '/tmp',
                  'DESTINATION_INSTALL_DIR' => "$ENV{'HOME'}",
#                  'PACKAGE_NAME' => 'T-COFFEE_distribution_Version_4.45.tar.gz',
                  'PACKAGE_NAME' => 'T-COFFEE_distribution_Version_5.37.tar.gz',
#                  'DIRECTORY_NAME' => 'T-COFFEE_distribution_Version_4.45',
                  'DIRECTORY_NAME' => 'T-COFFEE_distribution_Version_5.37',
                  'ENV_NAME' => 'TCOFFEEDIR',
                );
}


=method get_default

 Title   : get_default
 Usage   :
 Function:
 Example :
 Returns :
 Args    :


=cut

sub get_default {
    my $self = shift;
    my $param = shift;
    return $DEFAULTS{$param};
}


=method install

 Title   : install
 Usage   : $installer->install();
 Function:
 Example :
 Returns :
 Args    :


=cut

sub install{
   my ($self,@args) = @_;
   my $dir;
   $self->_decompress;
   $self->_execute_tcoffee_install_script;
   $dir = $self->destination_install_dir;
   $self->_remember_env;
}


=internal _execute_tcoffee_install_script

 Title   : _execute_tcoffee_install_script
 Usage   :
 Function:
 Example :
 Returns :
 Args    :


=cut

sub _execute_tcoffee_install_script{
   my ($self,@args) = @_;
   my $call;

   my $destination = $self->destination_install_dir;
   $destination =~ s|/$||;
   $destination .= "/" . $self->directory_name;

   chdir $destination or die "Cant cd to $destination $!\n";
   print "\n\nCompiling now... (this might take a while)\n\n";
   $call = "sh install";
   system("$call") == 0 or die "Error when trying to run install script $?\n";


}


1;
