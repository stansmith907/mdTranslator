# Reader - fgdc to internal data structure
# unpack fgdc distribution

# History:
#  Stan Smith 2017-08-15 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_contact'
require_relative 'module_orderProcess'
require_relative 'module_timePeriod'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Distribution

               def self.unpack(xDistribution, hResourceInfo, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hDistribution = intMetadataClass.newDistribution
                  hDistributor = intMetadataClass.newDistributor

                  # distribution 6.1 (distrib) - distributor {contact}
                  # -> distribution.distributor.contact.responsibility(distributor)
                  xContact = xDistribution.xpath('./distrib')
                  unless xContact.empty?
                     hResponsibility = Contact.unpack(xContact, hResponseObj)
                     unless hResponsibility.nil?
                        hResponsibility[:roleName] = 'distributor'
                        hDistributor[:contact] = hResponsibility
                     end
                  end

                  # distribution 6.2 (resdesc) - resource description
                  # -> distribution.description
                  description = xDistribution.xpath('./resdesc').text
                  unless description.empty?
                     hDistribution[:description] = description
                  end

                  # distribution 6.3 (distliab) - distribution liability
                  # -> resourceInfo.constraints.legal.otherConstraint
                  constraint = xDistribution.xpath('./distliab').text
                  unless constraint.empty?
                     hConstraint = intMetadataClass.newConstraint
                     hConstraint[:type] = 'legal'
                     hLegal = intMetadataClass.newLegalConstraint
                     hLegal[:otherCons] << constraint
                     hConstraint[:legalConstraint] = hLegal
                     hResourceInfo[:constraints] << hConstraint
                  end

                  # distribution 6.4 (stdorder) - standard order process []
                  axOrders = xDistribution.xpath('./stdorder')
                  unless axOrders.empty?
                     axOrders.each do |xOrder|
                        OrderProcess.unpack(xOrder, hDistributor, hResponseObj)
                     end
                  end

                  # distribution 6.5 (custom) - custom order process
                  # -> distribution.distributor.orderProcess.orderingInstructions
                  custom = xDistribution.xpath('./custom').text
                  unless custom.empty?
                     hOrder = intMetadataClass.newOrderProcess
                     hOrder[:orderingInstructions] = custom
                     hDistributor[:orderProcess] << hOrder
                  end

                  # distribution 6.6 (techpreq) - technical prerequisites
                  # -> distribution.description {+=}
                  techPre = xDistribution.xpath('./techpreq').text
                  unless techPre.empty?
                     hDistribution[:description] += '\n\n Technical Prerequisites: ' + techPre
                  end

                  # distribution 6.7 (availabl) - available time period {time period}
                  # -> distribution.distributor.orderProcess.plannedAvailability
                  xTimePeriod = xDistribution.xpath('./availabl')
                  unless xTimePeriod.empty?
                     hTimePeriod = TimePeriod.unpack(xTimePeriod, hResponseObj)
                     unless hTimePeriod.nil?
                        if hTimePeriod[:startDateTime].empty?
                           hDateTime = hTimePeriod[:endDateTime]
                        else
                           hDateTime = hTimePeriod[:startDateTime]
                        end
                        hDistributor[:orderProcess].each do |hOrder|
                           hOrder[:plannedAvailability] = hDateTime
                        end
                     end
                  end

                  hDistribution[:distributor] << hDistributor

                  return hDistribution

               end

            end

         end
      end
   end
end
