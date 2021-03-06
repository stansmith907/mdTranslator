# unpack scope
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-25 refactored error and warning messaging
# 	Stan Smith 2016-10-14 original script

require_relative 'module_scopeDescription'
require_relative 'module_timePeriod'
require_relative 'module_extent'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Scope

               def self.unpack(hScope, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hScope.empty?
                     @MessagePath.issueWarning(730, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intScope = intMetadataClass.newScope

                  outContext = 'scope'
                  outContext = inContext + ' > ' + outContext unless inContext.nil?

                  # scope - scope code (required)
                  if hScope.has_key?('scopeCode')
                     intScope[:scopeCode] = hScope['scopeCode']
                  end
                  if intScope[:scopeCode].nil? || intScope[:scopeCode] == ''
                     @MessagePath.issueError(731, responseObj, inContext)
                  end

                  # scope - scope description [] {MD_ScopeDescription}
                  if hScope.has_key?('scopeDescription')
                     aScopeDes = hScope['scopeDescription']
                     aScopeDes.each do |item|
                        hScopeDes = ScopeDescription.unpack(item, responseObj, outContext)
                        unless hScopeDes.nil?
                           intScope[:scopeDescriptions] << hScopeDes
                        end
                     end
                  end

                  # scope - extent [] {EX_Extent}
                  if hScope.has_key?('scopeExtent')
                     aExtents = hScope['scopeExtent']
                     aExtents.each do |item|
                        hExtent = Extent.unpack(item, responseObj, outContext)
                        unless hExtent.nil?
                           intScope[:extents] << hExtent
                        end
                     end
                  end

                  return intScope

               end

            end

         end
      end
   end
end
