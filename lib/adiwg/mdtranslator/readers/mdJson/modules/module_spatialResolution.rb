# unpack spatial resolution
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-25 refactored error and warning messaging
#  Stan Smith 2017-10-19 add geographic resolution
#  Stan Smith 2017-10-19 add bearingDistance resolution
#  Stan Smith 2017-10-19 add coordinate resolution
#  Stan Smith 2016-10-17 refactored for mdJson 2.0
#  Stan Smith 2015-07-14 refactored to remove global namespace constants
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
# 	Stan Smith 2013-11-26 original script

require_relative 'module_measure'
require_relative 'module_coordinateResolution'
require_relative 'module_bearingDistanceResolution'
require_relative 'module_geographicResolution'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module SpatialResolution

               def self.unpack(hResolution, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hResolution.empty?
                     @MessagePath.issueWarning(800, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intResolution = intMetadataClass.newSpatialResolution

                  outContext = 'spatial resolution'
                  outContext = inContext + ' > ' + outContext unless inContext.nil?

                  haveOne = false

                  # spatial resolution - scale factor (required if not others)
                  if hResolution.has_key?('scaleFactor')
                     unless hResolution['scaleFactor'] == ''
                        intResolution[:scaleFactor] = hResolution['scaleFactor']
                        haveOne = true
                     end
                  end

                  # spatial resolution - measure (required if not others)
                  if hResolution.has_key?('measure')
                     hMeasure = hResolution['measure']
                     unless hMeasure.empty?
                        hObject = Measure.unpack(hMeasure, responseObj, outContext)
                        unless hObject.nil?
                           intResolution[:measure] = hObject
                           haveOne = true
                        end
                     end
                  end

                  # spatial resolution - coordinate resolution (required if not others)
                  if hResolution.has_key?('coordinateResolution')
                     hCoordRes = hResolution['coordinateResolution']
                     unless hCoordRes.empty?
                        hReturn = CoordinateResolution.unpack(hCoordRes, responseObj, outContext)
                        unless hReturn.nil?
                           intResolution[:coordinateResolution] = hReturn
                           haveOne = true
                        end
                     end
                  end

                  # spatial resolution - bearing distance resolution (required if not others)
                  if hResolution.has_key?('bearingDistanceResolution')
                     hBearRes = hResolution['bearingDistanceResolution']
                     unless hBearRes.empty?
                        hReturn = BearingDistanceResolution.unpack(hBearRes, responseObj, outContext)
                        unless hReturn.nil?
                           intResolution[:bearingDistanceResolution] = hReturn
                           haveOne = true
                        end
                     end
                  end

                  # spatial resolution - geographic resolution (required if not others)
                  if hResolution.has_key?('geographicResolution')
                     hGeoRes = hResolution['geographicResolution']
                     unless hGeoRes.empty?
                        hReturn = GeographicResolution.unpack(hGeoRes, responseObj, outContext)
                        unless hReturn.nil?
                           intResolution[:geographicResolution] = hReturn
                           haveOne = true
                        end
                     end
                  end

                  # spatial resolution - level of detail (required if not others)
                  if hResolution.has_key?('levelOfDetail')
                     unless hResolution['levelOfDetail'] == ''
                        intResolution[:levelOfDetail] = hResolution['levelOfDetail']
                        haveOne = true
                     end
                  end

                  # error messages
                  unless haveOne
                     @MessagePath.issueError(801, responseObj, inContext)
                  end

                  return intResolution

               end

            end

         end
      end
   end
end
