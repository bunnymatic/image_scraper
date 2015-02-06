# Scrape images from URLs

## Prep

Clone the repo and bundle.

## Examples

#### Pull images from bunnymatic's td elements
   
    bundle exec ./image_scraper.rb -c 'table td' http://bunnymatic.com

#### Grab images from fffound and bunnymatic that have images with explicit widths

    bundle exec ./image_scraper.rb -C 'img[width]' http://bunnymatic.com http://ffffound.com




