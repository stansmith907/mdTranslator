# MdTranslator - minitest of
# readers / fgdc / module_horizontalPlanar / projection parameters

# History:
#  Stan Smith 2018-10-03 refactor mdJson projection object
#  Stan Smith 2017-10-18 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcProjectionParameters < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('spatialReferencePlanar.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::PlanarReference

   def test_planar_projectionParameters

      intMetadataClass = InternalMetadata.new
      hResourceInfo = intMetadataClass.newResourceInfo

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/spref/horizsys/planar[25]')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hPlanar = @@NameSpace.unpack(xIn, hResourceInfo, hResponse)

      refute_empty hPlanar
      assert_equal 1, hPlanar[:spatialReferenceSystems].length

      hReferenceSystem = hPlanar[:spatialReferenceSystems][0]
      assert_nil hReferenceSystem[:systemType]
      assert_empty hReferenceSystem[:systemIdentifier]
      assert_nil hReferenceSystem[:systemWKT]
      refute_empty hReferenceSystem[:systemParameterSet]

      hParameterSet = hReferenceSystem[:systemParameterSet]
      refute_empty hParameterSet[:projection]
      assert_empty hParameterSet[:geodetic]
      assert_empty hParameterSet[:verticalDatum]

      hProjection = hParameterSet[:projection]
      refute_empty hProjection[:projectionIdentifier]
      assert_empty hProjection[:gridIdentifier]
      assert_equal 1.0, hProjection[:standardParallel1]
      assert_equal 2.0, hProjection[:standardParallel2]
      assert_equal 3.0, hProjection[:longitudeOfCentralMeridian]
      assert_equal 4.0, hProjection[:latitudeOfProjectionOrigin]
      assert_equal 5.0, hProjection[:falseEasting]
      assert_equal 6.0, hProjection[:falseNorthing]
      assert_equal 'meters', hProjection[:falseEastingNorthingUnits]
      assert_equal 7.0, hProjection[:scaleFactorAtEquator]
      assert_equal 8.0, hProjection[:heightOfProspectivePointAboveSurface]
      assert_equal 9.0, hProjection[:longitudeOfProjectionCenter]
      assert_equal 10.0, hProjection[:latitudeOfProjectionCenter]
      assert_equal 11.0, hProjection[:scaleFactorAtCenterLine]
      assert_equal 12.0, hProjection[:azimuthAngle]
      assert_equal 13.0, hProjection[:azimuthMeasurePointLongitude]
      assert_equal 2, hProjection[:obliqueLinePoints].length
      assert_equal 14.0, hProjection[:obliqueLinePoints][0][:obliqueLineLatitude]
      assert_equal 15.0, hProjection[:obliqueLinePoints][0][:obliqueLineLongitude]
      assert_equal 16.0, hProjection[:obliqueLinePoints][1][:obliqueLineLatitude]
      assert_equal 17.0, hProjection[:obliqueLinePoints][1][:obliqueLineLongitude]
      assert_equal 18.0, hProjection[:straightVerticalLongitudeFromPole]
      assert_equal 19.0, hProjection[:scaleFactorAtProjectionOrigin]
      assert_equal 20, hProjection[:landsatNumber]
      assert_equal 21, hProjection[:landsatPath]
      assert_equal 22.0, hProjection[:scaleFactorAtCentralMeridian]

      hProjectionId = hProjection[:projectionIdentifier]
      assert_equal 'parameters', hProjectionId[:identifier]
      assert_equal 'Projection Parameters', hProjectionId[:name]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

      # missing projection name
      xIn.search('mapprojn').remove
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hPlanar = @@NameSpace.unpack(xIn, hResourceInfo, hResponse)

      hReferenceSystem = hPlanar[:spatialReferenceSystems][1]
      hParameterSet = hReferenceSystem[:systemParameterSet]
      hProjection = hParameterSet[:projection]
      hProjectionId = hProjection[:projectionIdentifier]
      assert_equal 'Projection Parameters', hProjectionId[:name]

      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: FGDC reader: map projection name is missing'

   end

end
