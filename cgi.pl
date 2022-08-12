#!/usr/bin/perl
###
###

use CGI qw(:standard); #Include CGI Module
use DBI;

my $host = "localhost";
my $database = "mysqldb";
my $user = "root";
my $password = "elbieh74";
my $driver = "mysql";

my $dbh = DBI->connect("DBI:$driver:$database;host=$host",
                       $user, $password, { RaiseError => 1 } ) or
   die ( "Couldn't connect to database: " . DBI->errstr );


my $query1 = "SELECT * FROM Employees";

my $sth = $dbh->prepare($query1);

$sth->execute() or die $DBI::errstr;


print header;
print start_html;
print "<table border=all cells=all>\n";
print "<tr>\n";
print "<td>ID</td><td>FirstName</td><td>LastName</td><td>Department</td>\n";
print "</tr>\n";
my $color;

while (my @row = $sth->fetchrow_array()) {
        my ($id, $first_name, $last_name, $dept ) = @row;
        print "<tr>\n";
        print "<td bgcolor=$color>$id</td><td>$first_name</td><td>$last_name</td><td>$dept</td>\n";
        print "</tr>\n";
}
print "</table>\n";
print end_html;

$sth->finish();

$dbh->disconnect;

