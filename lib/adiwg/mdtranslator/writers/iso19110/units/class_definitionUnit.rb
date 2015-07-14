# ISO <<Class>> UnitDefinition
# writer output in XML

# History:
# 	Stan Smith 2014-12-03 original script
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class UnitDefinition

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(unit)

                        # create and identity for the unit
                        @responseObj[:missingIdCount] = @responseObj[:missingIdCount].succ
                        unitID = 'unit' + @responseObj[:missingIdCount]
                        @xml.tag!('gml:UnitDefinition', {'gml:id' => unitID}) do
                            @xml.tag!('gml:identifier', {'codeSpace' => ''}, unit)
                        end

                    end

                end

            end
        end
    end
end