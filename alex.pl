#!/usr/bin/perl -w

# ver 0.1b

use Modern::Perl;
use CGI qw ( -utf8 );
use HTML::Entities;
use LWP::UserAgent;
use HTTP::Request;
use JSON;
use XML::Simple;
use strict;
use warnings;

my $query = CGI->new();


#my $password = $query->param('password');
my $password = 'XXXXXXXXX'; #add key

my $writer = $query->param('writer');

#my $title = $query->param('title');
my $title = '';

#$librarycard = $query->param('librarycard');
my $librarycard = 'XXXXXXXXXXXX'; #add librarycard

my $ua = new LWP::UserAgent;
$ua->agent("Perl API Client/1.0");

# Setup variables
my $string="partnerintegration/Writer";
my $host="www.alex.se";
my $protocol="https";

#build the url
my $url = "$protocol://$host/$string/" .  "?Password=$password&Writer=$writer&Title=%title&LibraryCard=%librarycard";

#Fetch the actual data from the query
my $request = HTTP::Request->new("GET" => $url);
$request->content_type('application/json');

my $response = $ua->request($request);

#Print header
my $cgi = CGI->new;
print $cgi->header(-type => "application/json", -charset => "utf-8");

#print $response->content;

# Create the object of XML Simple
my $xmlSimple = new XML::Simple(KeepRoot   => 1);

# Load the xml file in object
my $dataXML = $xmlSimple->XMLin($response->content);

# use encode json function to convert xml object in json.
my $jsonString = encode_json($dataXML);

# finally print json
print $jsonString;
