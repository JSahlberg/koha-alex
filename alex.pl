#!/usr/bin/perl -w

#test
# Search string example:
# ./alex-test.pl password=zryyn05wNN writer=Guillou,%20Jan title= librarycard=900559914987A

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

# Fetch some information using the client API
#my $analyze = $query->param('analyze');

#my $password = $query->param('password');
my $password = 'zryyn05wNN';

my $writer = $query->param('writer');
#my $title = $query->param('title');
my $title = '';

#$librarycard = $query->param('librarycard');
my $librarycard = '90055991498A7';

my $ua = new LWP::UserAgent;
$ua->agent("Perl API Client/1.0");

# Setup variables
my $string="partnerintegration/Writer";
my $host="www.alex.se";
my $protocol="https";

#build the url
my $url = "$protocol://$host/$string/" .  "?Password=$password&Writer=$writer&Title=%title&LibraryCard=%librarycard";
#my $url = "https://www.alex.se/partnerintegration/Writer/?Password=zryyn05wNN&Writer=Guillou,%20Jan&Title=&LibraryCard=900559914987A";

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
