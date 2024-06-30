# netcraft-web-scraper-pdf-report
Web-scraping [sitereport.netcraft.com](https://sitereport.netcraft.com) into PDF format (see [result sample for Wikipedia](https://github.com/user-attachments/files/16042909/wikipedia.org.pdf)). Based on my [cloudflare-bypass-headless-web-scraper](https://github.com/faraui/cloudflare-bypass-headless-web-scraper).

## Structure
```diff
[ 1.1M] netcraft-web-scraper-pdf-report
!! [  754] LICENSE.txt
~~ [  841] README.md
~~ [ 1.1M] extlib.tar.bz2
++ [ 5.0K] main.sh
~~ [ 1.1K] scraper.pl

5 files, 1 directory
```

## Installation
```bash
git clone -q https://github.com/faraui/netcraft-web-scraper-pdf-report.git && \
cd netcraft-web-scraper-pdf-report && \
chmod ugo+x main.sh
```

## Usage
**./main.sh** [**http://**|**https://**]**example.org**[*]
> If no protocol is specified, **https** will be used.
