# unpack geoJson
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-19 refactored error and warning messaging
#  Stan Smith 2016-10-25 original script

require_relative 'module_geometryObject'
require_relative 'module_geometryCollection'
require_relative 'module_geometryFeature'
require_relative 'module_featureCollection'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module GeoJson

               def self.unpack(hGeoJson, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hGeoJson.empty?
                     @MessagePath.issueWarning(340, responseObj, inContext)
                     return nil
                  end

                  intGeoEle = {}

                  if hGeoJson.has_key?('type')
                     if hGeoJson['type'] != ''
                        type = hGeoJson['type']
                        if %w{ Point LineString Polygon MultiPoint MultiLineString MultiPolygon }.one? {|word| word == type}
                           hReturn = GeometryObject.unpack(hGeoJson, responseObj)
                           unless hReturn.nil?
                              intGeoEle = hReturn
                           end
                        end
                        if type == 'GeometryCollection'
                           hReturn = GeometryCollection.unpack(hGeoJson, responseObj)
                           unless hReturn.nil?
                              intGeoEle = hReturn
                           end
                        end
                        if type == 'Feature'
                           hReturn = GeometryFeature.unpack(hGeoJson, responseObj)
                           unless hReturn.nil?
                              intGeoEle = hReturn
                           end
                        end
                        if type == 'FeatureCollection'
                           hReturn = FeatureCollection.unpack(hGeoJson, responseObj)
                           unless hReturn.nil?
                              intGeoEle = hReturn
                           end
                        end
                        if intGeoEle.empty?
                           @MessagePath.issueError(341, responseObj, inContext)
                        end

                     end
                  end

                  return intGeoEle

               end

            end

         end
      end
   end
end
