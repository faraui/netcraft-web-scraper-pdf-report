use strict;
use warnings;
use Log::Log4perl qw(:easy);
Log::Log4perl->easy_init($ERROR);
use WWW::Mechanize::Chrome;

my ($protocol, $domain);
if ($ARGV[0] =~ m{^(https?)://([^/]+)}) {
  $protocol = $1;
  $domain = $2;
} else {
  $protocol = "https";
  if ($ARGV[0] =~ m{^([^/]+)}) {
    $domain = $1;
  }
}

my $mech = WWW::Mechanize::Chrome->new(
   host => '127.0.0.1',
   port => 9222,
   start_url => "https://sitereport.netcraft.com/?url=$protocol://$domain",
   autoclose => 0,
   separate_session => 1,
   startup_timeout => 10,
   autodie => 0,
   headless => 0,
   mute_audio => 1,
   cleanup_signal => 'TERM'
); $mech->sleep(10);

my $html = $mech->content();
   $html =~ s/<section class="banner center dark-gray">.*//s;
   $html =~ s/<span class="section_links.*?span>//sg;
   $html =~ s/ip_geolocation_section.*?section>//s;
   $html =~ s/site_report_share.*?div>//s;
   $html =~ s/page-header.*header>//s;
   $html =~ s/wrapper.*?header class=//s;
   $html =~ s/<tr((?:(?!<tr).)*?)(not present|unknown).*?tr>//sig;
$mech->update_html($html);
$mech->content_as_pdf(filename => "$domain.pdf");
