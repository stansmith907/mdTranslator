# unpack transfer option
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-27 refactored error and warning messaging
#  Stan Smith 2016-10-21 original script

require_relative 'module_medium'
require_relative 'module_format'
require_relative 'module_onlineResource'
require_relative 'module_duration'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module TransferOption

               def self.unpack(hTransOp, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hTransOp.empty?
                     @MessagePath.issueWarning(880, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intTransOpt = intMetadataClass.newTransferOption

                  outContext = 'transfer option'
                  outContext = inContext + ' > ' + outContext unless inContext.nil?

                  # transfer option - units of distribution
                  if hTransOp.has_key?('unitsOfDistribution')
                     unless hTransOp['unitsOfDistribution'] == ''
                        intTransOpt[:unitsOfDistribution] = hTransOp['unitsOfDistribution']
                     end
                  end

                  # transfer option - transfer size
                  if hTransOp.has_key?('transferSize')
                     unless hTransOp['transferSize'] == ''
                        intTransOpt[:transferSize] = hTransOp['transferSize']
                     end
                  end

                  haveOption = false
                  # transfer option - online option [onlineResource]
                  if hTransOp.has_key?('onlineOption')
                     hTransOp['onlineOption'].each do |item|
                        hReturn = OnlineResource.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intTransOpt[:onlineOptions] << hReturn
                           haveOption = true
                        end
                     end
                  end

                  # transfer option - offline option [medium]
                  if hTransOp.has_key?('offlineOption')
                     hTransOp['offlineOption'].each do |item|
                        hReturn = Medium.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intTransOpt[:offlineOptions] << hReturn
                           haveOption = true
                        end
                     end
                  end

                  # transfer option - transferFrequency {duration}
                  if hTransOp.has_key?('transferFrequency')
                     hObject = hTransOp['transferFrequency']
                     unless hObject.empty?
                        hReturn = Duration.unpack(hObject, responseObj, outContext)
                        unless hReturn.nil?
                           intTransOpt[:transferFrequency] = hReturn
                        end
                     end
                  end

                  # transfer option - distribution format [format]
                  if hTransOp.has_key?('distributionFormat')
                     hTransOp['distributionFormat'].each do |item|
                        hReturn = Format.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intTransOpt[:distributionFormats] << hReturn
                        end
                     end
                  end

                  # error messages
                  unless haveOption
                     @MessagePath.issueWarning(881, responseObj, inContext)
                  end

                  return intTransOpt
               end

            end

         end
      end
   end
end
