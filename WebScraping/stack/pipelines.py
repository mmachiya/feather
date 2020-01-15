# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html


from scrapy.exporters import JsonLinesItemExporter
import json

class JsonUltaPipeline(object):
    
    def __init__(self):
        self.file = open('ulta.json', 'w')
        self.exporter = JsonLinesItemExporter(self.file, encoding='utf-8', ensure_ascii=False)
        self.exporter.start_exporting()


    def close_spider(self, spider):
        self.exporter.finish_exporting()
        self.file.close()

    def process_item(self, item, spider):
        self.exporter.export_item(item)
        return item

class JsonSokoPipeline(object):
    
    def __init__(self):
        self.file = open('soko.json', 'w')
        self.exporter = JsonLinesItemExporter(self.file, encoding='utf-8', ensure_ascii=False)
        self.exporter.start_exporting()


    def close_spider(self, spider):
        self.exporter.finish_exporting()
        self.file.close()

    def process_item(self, item, spider):
        self.exporter.export_item(item)
        return item
#
#class MongoDBPipeline(object):

#    collection_name = 'ulta'

#    def __init__(self, mongo_uri, mongo_db):
#        self.mongo_uri = mongo_uri
#        self.mongo_db = mongo_db

#    @classmethod
#    def from_crawlers(cls, crawler):
 #       return cls(
 #           mongo_uri=crawler.settings.get('MONGO_URI'),
#            mongo_db=crawler.settings.get('MONGO_DATABASE', 'ulta')
 #       )

 #   def open_spider(self, spider):
 #       self.client = pymongo.MongoClient(self.mongo_uri)
  #      self.db = self.client[self.mongo_db]

 #   def close_spider(self, spider):
 #       self.client.close()

  #  def process_item(self, item, spider):
  #      self.db[self.collection_name].insert_one(dict(item))
  #      return item

