# sbJson 1 writer tests - identifier

# History:
#  Stan Smith 2017-11-09 add metadata identifier test
#  Stan Smith 2017-05-17 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'sbjson_test_parent'

class TestWriterSbJsonIdentifier < TestWriterSbJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterSbJsonParent.getJson('identifier.json')

   def test_identifier

      hJsonIn = JSON.parse(@@jsonIn)
      hIn = hJsonIn.to_json

      metadata = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      expect = [
         {
            'key' => 'myIdentifier0',
            'scheme' => 'mySchema0',
            'type' => 'myDescription0'
         },
         { 'key' => 'myIdentifier1',
           'scheme' => 'mySchema1',
           'type' => 'myDescription1'
         }
      ]

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['identifiers']

      assert_equal expect, got

   end

   def test_identifier_include_metadataIdentifier

      hJsonIn = JSON.parse(@@jsonIn)
      hJsonIn['metadata']['metadataInfo']['metadataIdentifier']['namespace'] = 'ABC'
      hIn = hJsonIn.to_json

      metadata = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      expect = [
         {
            'key' => 'myMetadataIdentifierID',
            'scheme' => 'ABC',
            'type' => 'metadata identifier'
         },
         {
            'key' => 'myIdentifier0',
            'scheme' => 'mySchema0',
            'type' => 'myDescription0'
         },
         { 'key' => 'myIdentifier1',
           'scheme' => 'mySchema1',
           'type' => 'myDescription1'
         }
      ]

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['identifiers']

      assert_equal expect, got

   end

end


