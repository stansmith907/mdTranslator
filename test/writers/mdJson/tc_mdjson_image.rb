# mdJson 2.0 writer tests - image description

# History:
#  Stan Smith 2018-06-05 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-16 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonImageDescription < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hCoverage = TDClass.build_coverageDescription
   TDClass.add_imageDescription(hCoverage)
   mdHash[:metadata][:resourceInfo][:coverageDescription] = []
   mdHash[:metadata][:resourceInfo][:coverageDescription] << hCoverage

   @@mdHash = mdHash

   def test_schema_image

      hTest = @@mdHash[:metadata][:resourceInfo][:coverageDescription][0][:imageDescription]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'imageDescription.json')
      assert_empty errors

   end

   def test_complete_image

      TDClass.removeEmptyObjects(@@mdHash)

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceInfo']['coverageDescription'][0]
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['coverageDescription'][0]

      assert metadata[:writerPass]
      assert metadata[:readerStructurePass]
      assert metadata[:readerValidationPass]
      assert metadata[:readerExecutionPass]
      assert_empty metadata[:writerMessages]
      assert_empty metadata[:readerStructureMessages]
      assert_empty metadata[:readerValidationMessages]
      assert_empty metadata[:readerExecutionMessages]
      assert_equal expect, got

   end

end
