# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

from scrapy.item import Item, Field


class StackItem(Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    category = Field()
    brand = Field()
    name = Field()
    price = Field()
    details = Field()
    how_to_use = Field()
    ingredients = Field()
    image_url = Field()
    product_url = Field()
