# unpack resource information
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-24 refactored error and warning messaging
#  Stan Smith 2018-02-19 refactored error and warning messaging
#  Stan Smith 2017-05-16 deprecated topic category
#  ... topic category is now handled as keyword list
#  Stan Smith 2016-11-01 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_resourceType'
require_relative 'module_citation'
require_relative 'module_timePeriod'
require_relative 'module_responsibleParty'
require_relative 'module_spatialReference'
require_relative 'module_spatialRepresentation'
require_relative 'module_spatialResolution'
require_relative 'module_duration'
require_relative 'module_extent'
require_relative 'module_coverageDescription'
require_relative 'module_taxonomy'
require_relative 'module_graphic'
require_relative 'module_format'
require_relative 'module_keyword'
require_relative 'module_resourceUsage'
require_relative 'module_constraint'
require_relative 'module_locale'
require_relative 'module_maintenance'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module ResourceInfo

               def self.unpack(hResInfo, responseObj)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hResInfo.empty?
                     @MessagePath.issueError(680, responseObj)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intResInfo = intMetadataClass.newResourceInfo

                  outContext = 'resource information'

                  # resource information - resource type [] (required) {resourceType}
                  if hResInfo.has_key?('resourceType')
                     hResInfo['resourceType'].each do |item|
                        unless item.empty?
                           hReturn = ResourceType.unpack(item, responseObj, outContext)
                           unless hReturn.nil?
                              intResInfo[:resourceTypes] << hReturn
                           end
                        end
                     end
                  end
                  if intResInfo[:resourceTypes].empty?
                     @MessagePath.issueError(681, responseObj, outContext)
                  end

                  # resource information - citation {citation} (required)
                  if hResInfo.has_key?('citation')
                     hObject = hResInfo['citation']
                     unless hObject.empty?
                        hReturn = Citation.unpack(hObject, responseObj, outContext)
                        unless hReturn.nil?
                           intResInfo[:citation] = hReturn
                        end
                     end
                  end
                  if intResInfo[:citation].empty?
                     @MessagePath.issueError(682, responseObj, outContext)
                  end

                  # resource information - abstract (required)
                  if hResInfo.has_key?('abstract')
                     intResInfo[:abstract] = hResInfo['abstract']
                  end
                  if intResInfo[:abstract].nil? || intResInfo[:abstract] == ''
                     @MessagePath.issueError(683, responseObj, outContext)
                  end

                  # resource information - short abstract
                  if hResInfo.has_key?('shortAbstract')
                     unless hResInfo['shortAbstract'] == ''
                        intResInfo[:shortAbstract] = hResInfo['shortAbstract']
                     end
                  end

                  # resource information - purpose
                  if hResInfo.has_key?('purpose')
                     unless hResInfo['purpose'] == ''
                        intResInfo[:purpose] = hResInfo['purpose']
                     end
                  end

                  # resource information - resource time period {timePeriod}
                  if hResInfo.has_key?('timePeriod')
                     hObject = hResInfo['timePeriod']
                     unless hObject.empty?
                        hObject[:description] = 'resource time period' if hObject[:description].nil?
                        hReturn = TimePeriod.unpack(hObject, responseObj, outContext)
                        unless hReturn.nil?
                           intResInfo[:timePeriod] = hReturn
                        end
                     end
                  end

                  # resource information - credits []
                  if hResInfo.has_key?('credit')
                     hResInfo['credit'].each do |item|
                        unless item == ''
                           intResInfo[:credits] << item
                        end
                     end
                  end

                  # resource information - status [] (required)
                  if hResInfo.has_key?('status')
                     hResInfo['status'].each do |item|
                        unless item == ''
                           intResInfo[:status] << item
                        end
                     end
                  end
                  if intResInfo[:status].empty?
                     @MessagePath.issueError(684, responseObj, outContext)
                  end

                  # resource information - topic category (deprecated)
                  if hResInfo.has_key?('topicCategory')
                     unless hResInfo['topicCategory'].empty?
                        # move topicCategories to keywordObject
                        hKeyword = {}
                        hKeyword['keyword'] = []
                        hKeyword['keywordType'] = 'isoTopicCategory'
                        hResInfo['topicCategory'].each do |keyword|
                           hKeywordObj = {}
                           hKeywordObj['keyword'] = keyword
                           hKeyword['keyword'] << hKeywordObj
                        end
                        hReturn = Keyword.unpack(hKeyword, responseObj)
                        unless hReturn.nil?
                           intResInfo[:keywords] << hReturn
                        end
                        @MessagePath.issueNotice(685, responseObj, outContext)
                     end
                  end

                  # resource information - point of contact [] {responsibleParty} (required)
                  if hResInfo.has_key?('pointOfContact')
                     aItems = hResInfo['pointOfContact']
                     aItems.each do |item|
                        hReturn = ResponsibleParty.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intResInfo[:pointOfContacts] << hReturn
                        end
                     end
                  end
                  if intResInfo[:pointOfContacts].empty?
                     @MessagePath.issueError(686, responseObj, outContext)
                  end

                  # resource information - spatial reference system [] {spatialReference}
                  if hResInfo.has_key?('spatialReferenceSystem')
                     aItems = hResInfo['spatialReferenceSystem']
                     aItems.each do |item|
                        hReturn = SpatialReferenceSystem.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intResInfo[:spatialReferenceSystems] << hReturn
                        end
                     end
                  end

                  # resource information - spatial representation type []
                  if hResInfo.has_key?('spatialRepresentationType')
                     hResInfo['spatialRepresentationType'].each do |item|
                        unless item == ''
                           intResInfo[:spatialRepresentationTypes] << item
                        end
                     end
                  end

                  # resource information - spatial representation [] {spatialRepresentation}
                  if hResInfo.has_key?('spatialRepresentation')
                     aItems = hResInfo['spatialRepresentation']
                     aItems.each do |item|
                        hReturn = SpatialRepresentation.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intResInfo[:spatialRepresentations] << hReturn
                        end
                     end
                  end

                  # resource information - spatial resolution [] {spatialResolution}
                  if hResInfo.has_key?('spatialResolution')
                     aItems = hResInfo['spatialResolution']
                     aItems.each do |item|
                        hReturn = SpatialResolution.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intResInfo[:spatialResolutions] << hReturn
                        end
                     end
                  end

                  # resource information - temporal resolution [] {duration}
                  if hResInfo.has_key?('temporalResolution')
                     aItems = hResInfo['temporalResolution']
                     aItems.each do |item|
                        hReturn = Duration.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intResInfo[:temporalResolutions] << hReturn
                        end
                     end
                  end

                  # resource information - extent [] {extent}
                  if hResInfo.has_key?('extent')
                     aItems = hResInfo['extent']
                     aItems.each do |item|
                        hReturn = Extent.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intResInfo[:extents] << hReturn
                        end
                     end
                  end

                  # resource information - content information [] {contentInformation}
                  if hResInfo.has_key?('coverageDescription')
                     aItems = hResInfo['coverageDescription']
                     aItems.each do |item|
                        hReturn = CoverageDescription.unpack(item, responseObj)
                        unless hReturn.nil?
                           intResInfo[:coverageDescriptions] << hReturn
                        end
                     end
                  end

                  # resource information - taxonomy [] {taxonomy}
                  # support deprecated taxonomy{}
                  if hResInfo.has_key?('taxonomy')
                     aTaxonomy = hResInfo['taxonomy']
                     if aTaxonomy.is_a?(Array)
                        aTaxonomy.each do |hTaxonomy|
                           hReturn = Taxonomy.unpack(hTaxonomy, responseObj)
                           unless hReturn.nil?
                              intResInfo[:taxonomy] << hReturn
                           end
                        end
                     else
                        hReturn = Taxonomy.unpack(aTaxonomy, responseObj)
                        unless hReturn.nil?
                           intResInfo[:taxonomy] << hReturn
                        end
                        @MessagePath.issueNotice(687, responseObj, outContext)
                     end
                  end

                  # resource information - graphic overview [] {graphicOverview}
                  if hResInfo.has_key?('graphicOverview')
                     aItems = hResInfo['graphicOverview']
                     aItems.each do |item|
                        hReturn = Graphic.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intResInfo[:graphicOverviews] << hReturn
                        end
                     end
                  end

                  # resource information - resource format [] {format}
                  if hResInfo.has_key?('resourceFormat')
                     aItems = hResInfo['resourceFormat']
                     aItems.each do |item|
                        hReturn = Format.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intResInfo[:resourceFormats] << hReturn
                        end
                     end
                  end

                  # resource information - keyword [] {keyword}
                  if hResInfo.has_key?('keyword')
                     aItems = hResInfo['keyword']
                     aItems.each do |item|
                        hReturn = Keyword.unpack(item, responseObj)
                        unless hReturn.nil?
                           intResInfo[:keywords] << hReturn
                        end
                     end
                  end

                  # resource information - resource usage [] {resourceUsage}
                  if hResInfo.has_key?('resourceUsage')
                     aItems = hResInfo['resourceUsage']
                     aItems.each do |item|
                        hReturn = ResourceUsage.unpack(item, responseObj)
                        unless hReturn.nil?
                           intResInfo[:resourceUsages] << hReturn
                        end
                     end
                  end

                  # resource information - constraint [] {constraint}
                  if hResInfo.has_key?('constraint')
                     aCons = hResInfo['constraint']
                     aCons.each do |hItem|
                        hReturn = Constraint.unpack(hItem, responseObj, outContext)
                        unless hReturn.nil?
                           intResInfo[:constraints] << hReturn
                        end
                     end
                  end

                  # resource information - default resource locale {locale} (required)
                  if hResInfo.has_key?('defaultResourceLocale')
                     hObject = hResInfo['defaultResourceLocale']
                     unless hObject.empty?
                        hReturn = Locale.unpack(hObject, responseObj, outContext)
                        unless hReturn.nil?
                           intResInfo[:defaultResourceLocale] = hReturn
                        end
                     end
                  end
                  if intResInfo[:defaultResourceLocale].empty?
                     @MessagePath.issueError(688, responseObj, outContext)
                  end

                  # resource information - other resource locale [] {locale}
                  if hResInfo.has_key?('otherResourceLocale')
                     aItems = hResInfo['otherResourceLocale']
                     aItems.each do |item|
                        hReturn = Locale.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intResInfo[:otherResourceLocales] << hReturn
                        end
                     end
                  end

                  # resource information - resource maintenance [] {maintenance}
                  if hResInfo.has_key?('resourceMaintenance')
                     aItems = hResInfo['resourceMaintenance']
                     aItems.each do |item|
                        hReturn = Maintenance.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intResInfo[:resourceMaintenance] << hReturn
                        end
                     end
                  end

                  # resource information - environment description
                  if hResInfo.has_key?('environmentDescription')
                     unless hResInfo['environmentDescription'] == ''
                        intResInfo[:environmentDescription] = hResInfo['environmentDescription']
                     end
                  end

                  # resource information - supplemental information
                  if hResInfo.has_key?('supplementalInfo')
                     unless hResInfo['supplementalInfo'] == ''
                        intResInfo[:supplementalInfo] = hResInfo['supplementalInfo']
                     end
                  end

                  return intResInfo

               end

            end

         end
      end
   end
end
