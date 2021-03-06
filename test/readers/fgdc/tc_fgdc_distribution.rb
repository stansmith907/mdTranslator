# MdTranslator - minitest of
# readers / fgdc / module_distribution

# History:
#   Stan Smith 2017-09-10 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcDistribution < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('distribution.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Distribution

   def test_distribution_complete

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/distinfo[1]')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hDistribution = @@NameSpace.unpack(xIn, hResponse)

      refute_empty hDistribution
      assert_equal 'distribution description', hDistribution[:description]
      assert_equal 'distribution liability statement', hDistribution[:liabilityStatement]
      assert_equal 1, hDistribution[:distributor].length

      hDistributor = hDistribution[:distributor][0]
      refute_empty hDistributor[:contact]
      assert_equal 3, hDistributor[:orderProcess].length
      assert_equal 3, hDistributor[:transferOptions].length

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
