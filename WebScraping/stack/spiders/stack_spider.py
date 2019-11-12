from scrapy import Spider
from scrapy.selector import Selector

from stack.items import StackItem

class StackSpider(Spider):
    name = "ulta"
    allowed_domains = ["ulta.com"]
    start_urls = ["https://www.ulta.com/skin-care?N=2707"]
    custom_settings = {
        'ITEM_PIPELINES': {
            'stack.pipelines.JsonUltaPipeline': 200
        }
    }

    def parse(self, response):
        for a in response.css('li.cat-sub-nav ul a::attr(href)'):
            yield response.follow(a, callback=self.parse_page)
    
    def parse_page(self,response):
        i = 0
        for product in response.css('ul#foo16 li'):
            yield response.follow(product.xpath('//p[@class="prod-desc"]/a/@href').extract()[i], callback=self.parse_product)
            i += 1
        for a in response.css('a.next'):
            yield response.follow(a, callback=self.parse_page)

    def parse_product(self, response):
        def extract_with_css(query):
            return response.css(query).get(default='').strip()
        product = StackItem()
        product['brand'] = extract_with_css('p.Text.Text--body-1.Text--left.Text--bold.Text--small.Text--\$magenta-50::text')
        product['name'] = extract_with_css('span.Text.Text--subtitle-1.Text--left.Text--small.Text--text-20::text')
        product['price'] = extract_with_css('span.Text.Text--title-6.Text--left.Text--bold.Text--small.Text--neutral-80::text')
        product['details'] = "".join(response.css('div.ProductDetail__ProductRow div#productDetails.ProductDetail__productDetails div.ProductDetail__productContent *::text').extract())
        product['how_to_use'] = extract_with_css('div.ProductDetail__howToUse div.Collapsible div.Collapsible__contentOuter div.Collapsible__contentInner div.ProductDetail__productContent *::text')
        ingreds = extract_with_css('div.ProductDetail__ingredients div.Collapsible div.Collapsible__contentOuter div.Collapsible__contentInner div.ProductDetail__productContent *::text').split(',')
        product['ingredients'] = [ing.strip(' ') for ing in ingreds]
        product['image_url'] = response.css('img::attr(src)')
        product['product_url'] = response.request.url

        yield product
    