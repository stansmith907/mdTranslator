# ISO <<Class>> attribute group
# 19115-1 writer output in XML

# History:
#  Stan Smith 2019-04-05 original script.

require_relative '../iso19115_1_writer'
require_relative 'class_codelist'
require_relative 'class_attribute'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class MD_AttributeGroup

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_1
               end

               def writeXML(hGroup, inContext = nil)

                  outContext = 'attribute group'
                  outContext = inContext + ' attribute group' unless inContext.nil?

                  unless hGroup.empty?

                  end

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  attributeClass = Attribute.new(@xml, @hResponseObj)

                  unless hGroup.empty?

                     # attribute group - content type [] {MD_CoverageContentTypeCode} (required)
                     aContentTypes = hGroup[:attributeContentTypes]
                     aContentTypes.each do |item|
                        @xml.tag!('mrc:contentType') do
                           codelistClass.writeXML('mrc', 'iso_coverageContentType', item)
                        end
                     end
                     if aContentTypes.empty?
                        @NameSpace.issueWarning(41, 'mrc:contentType', outContext)
                     end

                     # attribute group - attribute [] (abstract)
                     aAttributes = hGroup[:attributes]
                     aAttributes.each do |hAttribute|
                        unless hAttribute.empty?
                           @xml.tag!('mrc:attribute') do
                              attributeClass.writeXML(hAttribute, outContext)
                           end
                        end
                     end

                  end

               end # writeXML
            end # AttributeGroup class

         end
      end
   end
end
