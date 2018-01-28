# FGDC <<Class>> MetadataInformation
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-01-26 original script

require_relative '../fgdc_writer'
require_relative 'class_contact'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class MetadataInformation

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(intObj)

                  hMetadataInfo = intObj[:metadata][:metadataInfo]
                  hResourceInfo = intObj[:metadata][:resourceInfo]

                  # classes used
                  contactClass = Contact.new(@xml, @hResponseObj)

                  # metadata information 7.1 (metd) - metadata date (required)
                  # <- metadataInfo.metadataDates[] type = 'creation' (required)
                  # take first
                  haveCreation = false
                  hMetadataInfo[:metadataDates].each do |hDate|
                     unless hDate.empty?
                        unless hDate[:dateType].nil?
                           if hDate[:dateType] == 'creation'
                              createDate = AdiwgDateTimeFun.stringDateFromDateTime(hDate[:date], hDate[:dateResolution])
                              createDate.gsub!(/[-]/,'')
                              unless createDate == 'ERROR'
                                 @xml.tag!('metd', createDate)
                                 haveCreation = true
                              end
                              break
                           end
                        end
                     end
                  end
                  unless haveCreation
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Metadata Information section is missing creation date'
                  end

                  # metadata information 7.2 (metrd) - metadata review date
                  # <- metadataInfo.metadataDates[] type = 'review'
                  # take first
                  haveReview = false
                  hMetadataInfo[:metadataDates].each do |hDate|
                     unless hDate.empty?
                        unless hDate[:dateType].nil?
                           if hDate[:dateType] == 'review'
                              reviewDate = AdiwgDateTimeFun.stringDateFromDateTime(hDate[:date], hDate[:dateResolution])
                              reviewDate.gsub!(/[-]/,'')
                              unless reviewDate == 'ERROR'
                                 @xml.tag!('metrd', reviewDate)
                                 haveReview = true
                              end
                              break
                           end
                        end
                     end
                  end
                  if !haveReview && @hResponseObj[:writerShowTags]
                     @xml.tag!('metrd')
                  end

                  # metadata information 7.3 (metfrd) - metadata future review date
                  # <- metadataInfo.metadataDates[] type = 'nextReview'
                  # take first
                  haveNext = false
                  hMetadataInfo[:metadataDates].each do |hDate|
                     unless hDate.empty?
                        unless hDate[:dateType].nil?
                           if hDate[:dateType] == 'nextReview'
                              nextDate = AdiwgDateTimeFun.stringDateFromDateTime(hDate[:date], hDate[:dateResolution])
                              nextDate.gsub!(/[-]/,'')
                              unless nextDate == 'ERROR'
                                 @xml.tag!('metfrd', nextDate)
                                 haveNext = true
                              end
                              break
                           end
                        end
                     end
                  end
                  if !haveNext && @hResponseObj[:writerShowTags]
                     @xml.tag!('metfrd')
                  end

                  # metadata information 7.4 (metc) - metadata contact {contact}
                  # <- metadataInfo.metadataContacts[] role = 'pointOfContact'
                  unless hMetadataInfo[:metadataContacts].empty?
                     aRParties = hMetadataInfo[:metadataContacts]
                     aParties = ADIWG::Mdtranslator::Writers::Fgdc.find_responsibility(aRParties, 'pointOfContact')
                     unless aParties.empty?
                        hContact = ADIWG::Mdtranslator::Writers::Fgdc.get_contact(aParties[0])
                        unless hContact.empty?
                           @xml.tag!('metc') do
                              contactClass.writeXML(hContact)
                           end
                        end
                     end
                  end
                  if hMetadataInfo[:metadataContacts].empty?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Metadata Information section is missing metadata contact'
                  end

                  # metadata information 7.5 (metstdn) - metadata standard name (required)
                  @xml.tag!('metstdn', 'Content Standard for Digital Geospatial Metadata with with Biological Data Profile')

                  # metadata information 7.6 (metstdv) - metadata standard version (required)
                  @xml.tag!('metstdv', 'FGDC-STD-001.1-1999')

                  # metadata information 7.7 (mettc) - metadata time conversion (required)
                  # required if time elements are present in metadata
                  # don't know how to handle this, leaving it out

                  # metadata information 7.8 (metac) - metadata access constraint
                  # <- resourceInfo.constraints.type=legal.accessCode
                  hResourceInfo[:constraints].each do |hConstraint|
                     if hConstraint[:type] == 'legal'
                        a=1
                     end
                  end

               end # writeXML
            end # MetadataInformation

         end
      end
   end
end
