# unpack security constraint
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-25 refactored error and warning messaging
# 	Stan Smith 2016-10-15 refactored for mdJson 2.0
#  Stan Smith 2015-07-14 refactored to remove global namespace constants
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
# 	Stan Smith 2013-11-27 modified to process a single security constraint
# 	Stan Smith 2013-11-15 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module SecurityConstraint

               def self.unpack(hSecurityCon, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hSecurityCon.empty?
                     @MessagePath.issueWarning(750, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intSecCon = intMetadataClass.newSecurityConstraint

                  # security constraint - classification (required)
                  if hSecurityCon.has_key?('classification')
                     intSecCon[:classCode] = hSecurityCon['classification']
                  end
                  if intSecCon[:classCode].nil? || intSecCon[:classCode] == ''
                     @MessagePath.issueError(751, responseObj, inContext)
                  end

                  # security constraint - user note
                  if hSecurityCon.has_key?('userNote')
                     unless hSecurityCon['userNote'] == ''
                        intSecCon[:userNote] = hSecurityCon['userNote']
                     end
                  end

                  # security constraint - classification system
                  if hSecurityCon.has_key?('classificationSystem')
                     unless hSecurityCon['classificationSystem'] == ''
                        intSecCon[:classSystem] = hSecurityCon['classificationSystem']
                     end
                  end

                  # security constraint - handling description
                  if hSecurityCon.has_key?('handlingDescription')
                     unless hSecurityCon['handlingDescription'] == ''
                        intSecCon[:handling] = hSecurityCon['handlingDescription']
                     end
                  end

                  return intSecCon

               end

            end

         end
      end
   end
end
