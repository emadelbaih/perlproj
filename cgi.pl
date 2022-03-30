#!/usr/bin/perl

use CGI qw(:standard);
use DBI;

### Declaring database variables
my $host = "localhost";
my $database = "mysqldb";
my $user = "root";
my $password = "elbieh74";
my $driver = "mysql";

my $dbh = DBI->connect("DBI:$driver:$database;host=$host",
                       $user, $password, { RaiseError => 1 } ) or
   die ( "Couldn't connect to database: " . DBI->errstr );

### MySQL query.
my $query1 = "SELECT * FROM Employees";

### Prepare SQL statement
my $sth = $dbh->prepare($query1);

### Execute the statement
$sth->execute() or die $DBI::errstr;

### Print result 
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

