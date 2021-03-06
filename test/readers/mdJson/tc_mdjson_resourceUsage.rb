# MdTranslator - minitest of
# reader / mdJson / module_resourceUsage

# History:
#  Stan Smith 2018-06-24 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-11 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_resourceUsage'

class TestReaderMdJsonResourceUsage < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::ResourceUsage

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.build_resourceUsage_full

   @@mdHash = mdHash

   def test_resourceUsage_schema

      errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'usage.json')
      assert_empty errors

   end

   def test_complete_resourceUsage_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'specific usage', metadata[:specificUsage]
      assert_equal 2, metadata[:temporalExtents].length
      assert_equal 'user determined limitation', metadata[:userLimitation]
      assert_equal 2, metadata[:limitationResponses].length
      assert_equal 'response one', metadata[:limitationResponses][0]
      assert_equal 'response two', metadata[:limitationResponses][1]
      refute_empty metadata[:identifiedIssue]
      assert_equal 2, metadata[:additionalDocumentation].length
      assert_equal 2, metadata[:userContacts].length
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_resourceUsage_empty_specificUsage

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['specificUsage'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: resource specific usage is missing'

   end

   def test_resourceUsage_missing_specificUsage

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('specificUsage')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'ERROR: mdJson reader: resource specific usage is missing'

   end

   def test_resourceUsage_empty_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['temporalExtent'] = []
      hIn['userDeterminedLimitation'] = ''
      hIn['limitationResponse'] = []
      hIn['documentedIssue'] = {}
      hIn['additionalDocumentation'] = []
      hIn['userContactInfo'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'specific usage', metadata[:specificUsage]
      assert_empty metadata[:temporalExtents]
      assert_nil metadata[:userLimitation]
      assert_empty metadata[:limitationResponses]
      assert_empty metadata[:identifiedIssue]
      assert_empty metadata[:additionalDocumentation]
      assert_empty metadata[:userContacts]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_resourceUsage_missing_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('temporalExtent')
      hIn.delete('userDeterminedLimitation')
      hIn.delete('limitationResponse')
      hIn.delete('documentedIssue')
      hIn.delete('additionalDocumentation')
      hIn.delete('userContactInfo')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'specific usage', metadata[:specificUsage]
      assert_empty metadata[:temporalExtents]
      assert_nil metadata[:userLimitation]
      assert_empty metadata[:limitationResponses]
      assert_empty metadata[:identifiedIssue]
      assert_empty metadata[:additionalDocumentation]
      assert_empty metadata[:userContacts]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_resourceUsage_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: resource usage object is empty'

   end

end
