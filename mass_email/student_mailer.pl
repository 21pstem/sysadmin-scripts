#!/usr/bin/perl

use strict;
use warnings;

my $from = 'somebody@domain.org';
my $subject = 'Subject';

open(INPUT,"student_list.txt") or die "Cant open student_list";

while(<INPUT>){
	open(MAIL,"|/usr/sbin/sendmail -t");
	chomp;
	my ($firstname, $lastname, $email, $username, $password) = split ",";
	my $body = <<"END_BODY";
Hello $firstname $lastname,

	
Your username is : $username

Your temporary password is : $password  (you will be asked to change it to your own personal secure password when you first log in)


Sincerely,	

END_BODY
	
	print MAIL "To: $email\n";
	print MAIL "From: $from\n";
	print MAIL "Subject: $subject\n";
	print MAIL $body;
	close(MAIL);
}
close(INPUT);

