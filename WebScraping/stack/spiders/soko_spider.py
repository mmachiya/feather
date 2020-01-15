from scrapy import Spider
from scrapy.selector import Selector

from stack.items import StackItem

class SokoSpider(Spider):
    name = "soko"
    allowed_domains = ["sokoglam.com"]
    start_urls = ["https://sokoglam.com/collections/skincare"]
    custom_settings = {
        'ITEM_PIPELINES': {
            'stack.pipelines.JsonSokoPipeline': 100
        }
    }

    def parse(self, response):
        i = 0
        for product in response.css('div.mixitup-container.products.collection-grid div'):
            yield response.follow(product.xpath('//div[@class="product-grid-item__overlay"]/a/@href').extract()[i], callback=self.parse_product)
            i += 1
        

    def parse_product(self, response):
        def extract_with_css(query):
            return response.css(query).get(default='').strip()
        product = StackItem()
        product['brand'] = extract_with_css('h3.pdp__product-vendor a::text')
        product['name'] = extract_with_css('h1.pdp__product-title::text')
        product['price'] = extract_with_css('span.pdp-product__price--sale.ProductPrice::text')
        product['details'] = "".join(response.css('div.pdp__product-description section#content1 div.pdp-tab-content *::text').extract()).strip()
        use = extract_with_css('div.pdp__product-description section#content3 div.pdp-tab-content div.tab-content p span *::text')
        if not use:
            use = extract_with_css('div.pdp__product-description section#content3 div.pdp-tab-content div.tab-content p *::text')
        product['how_to_use'] = use
        ingreds = extract_with_css('div.pdp__product-description section#content2 div.pdp-tab-content div.tab-content--full p *::text').strip().split(',')
        if ingreds  == [""]:
            ingreds = extract_with_css('div.pdp__product-description section#content2 div.pdp-tab-content div.tab-content--full p span *::text').strip().split(',')
        #css not grabbing all text in a tag
        product['ingredients'] = [ing.strip(' ') for ing in ingreds]
        product['image_url'] = response.css('div.pdp-main__slider.slick-initialized.slick-slider.slick-dotted div.slick-listdraggable div.slick-track img::attr(src)')
        product['product_url'] = response.request.url


        yield product
    