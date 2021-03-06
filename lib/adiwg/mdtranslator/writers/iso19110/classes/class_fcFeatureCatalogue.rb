# ISO 19110 <<Class>> FC_FeatureCatalogue
# writer output in XML

# History:
#  Stan Smith 2019-09-17 handle namespace setup for dictionary embedded in 19115
#  Stan Smith 2018-05-03 add variable for changing XSD location
#  Stan Smith 2018-04-03 refactored error and warning messaging
#  Stan Smith 2017-01-20 refactored for mdJson/mdTranslator 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2014-12-29 set builder object '@xml' into string 'metadata'
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
# 	Stan Smith 2013-12-01 original script

require_relative '../iso19110_writer'
require_relative 'class_locale'
require_relative 'class_responsibleParty'
require_relative 'class_featureType'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19110

            class FC_FeatureCatalogue

               def initialize(xml, responseObj)
                  @xml = xml
                  @hResponseObj = responseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19110
               end

               def writeXML(hDictionary, embed)

                  # classes used
                  localeClass = PT_Locale.new(@xml, @hResponseObj)
                  rPartyClass = CI_ResponsibleParty.new(@xml, @hResponseObj)
                  featureClass = FC_FeatureType.new(@xml, @hResponseObj)

                  hCitation = hDictionary[:citation]
                  aEntities = hDictionary[:entities]
                  version = @hResponseObj[:translatorVersion]

                  # document head
                  metadata = @xml.instruct! :xml, encoding: 'UTF-8'
                  @xml.comment!('ISO 19110 METADATA')
                  @xml.comment!('The following metadata file was constructed using the ADIwg mdTranslator, http://mdtranslator.adiwg.org')
                  @xml.comment!('mdTranslator software is an open-source project of the Alaska Data Integration working group (ADIwg)')
                  @xml.comment!('mdTranslator and other metadata tools are available at https://github.com/adiwg')
                  @xml.comment!('ADIwg is not responsible for the content of this metadata record')
                  @xml.comment!('This metadata record was generated by mdTranslator ' + version + ' at ' + Time.now.to_s)

                  # schema locations
                  # set to 'remoteSchema' before publishing
                  localSchema = 'C:\Users\StanSmith\Projects\ISO\19115\NOAA\schema\gfc\gfc.xsd'
                  remoteSchema = 'ftp://ftp.ncddc.noaa.gov/pub/Metadata/Online_ISO_Training/Intro_to_ISO/schemas/ISObio/gfc/gfc.xsd'

                  # FC_FeatureCatalogue
                  if embed
                     attributes = {}
                  else
                     attributes = {'xmlns:gmi' => 'http://www.isotc211.org/2005/gmi',
                                   'xmlns:gmd' => 'http://www.isotc211.org/2005/gmd',
                                   'xmlns:gco' => 'http://www.isotc211.org/2005/gco',
                                   'xmlns:gml' => 'http://www.opengis.net/gml/3.2',
                                   'xmlns:gsr' => 'http://www.isotc211.org/2005/gsr',
                                   'xmlns:gss' => 'http://www.isotc211.org/2005/gss',
                                   'xmlns:gst' => 'http://www.isotc211.org/2005/gst',
                                   'xmlns:gmx' => 'http://www.isotc211.org/2005/gmx',
                                   'xmlns:gfc' => 'http://www.isotc211.org/2005/gfc',
                                   'xmlns:xlink' => 'http://www.w3.org/1999/xlink',
                                   'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
                                   'xsi:schemaLocation' => "http://www.isotc211.org/2005/gfc #{remoteSchema}"}
                  end

                  @xml.tag!('gfc:FC_FeatureCatalogue', attributes) do

                     # feature catalogue - name, version, version date are
                     # are taken from citation
                     name = hCitation[:title]
                     version = hCitation[:edition]
                     hDate = {}
                     aDates = hCitation[:dates]
                     unless aDates.empty?
                        hDate = aDates[0]
                     end

                     # feature catalogue - name (required)
                     unless name.nil?
                        @xml.tag!('gmx:name') do
                           @xml.tag!('gco:CharacterString', name)
                        end
                     end
                     if name.nil?
                        @NameSpace.issueWarning(40, 'gmx:name')
                     end

                     # feature catalogue - scope (required) []
                     aScopes = hDictionary[:subjects]
                     aScopes.each do |scope|
                        @xml.tag!('gmx:scope') do
                           @xml.tag!('gco:CharacterString', scope)
                        end
                     end
                     if aScopes.empty?
                        @NameSpace.issueWarning(41, 'gmx:scope')
                     end

                     # feature catalogue - field of application []
                     aUses = hDictionary[:recommendedUses]
                     aUses.each do |use|
                        @xml.tag!('gmx:fieldOfApplication') do
                           @xml.tag!('gco:CharacterString', use)
                        end
                     end
                     if aUses.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmx:fieldOfApplication')
                     end

                     # feature catalogue - version number (required)
                     unless version.nil?
                        @xml.tag!('gmx:versionNumber') do
                           @xml.tag!('gco:CharacterString', version)
                        end
                     end
                     if version.nil?
                        @NameSpace.issueWarning(42, 'gmx:versionNumber')
                     end

                     # feature catalogue - version date (required)
                     sDate = nil
                     unless hDate.empty?
                        dateTime = hDate[:date]
                        dateRes = hDate[:dateResolution]
                        unless dateTime.nil?
                           sDate = AdiwgDateTimeFun.stringDateFromDateTime(dateTime, dateRes)
                        end
                     end
                     unless sDate.nil?
                        @xml.tag!('gmx:versionDate') do
                           @xml.tag!('gco:Date', sDate)
                        end
                     end
                     if sDate.nil?
                        @NameSpace.issueWarning(43, 'gmx:versionDate')
                     end

                     # feature catalogue - locale []
                     aLocales = hDictionary[:locales]
                     aLocales.each do |hLocale|
                        unless hLocale.empty?
                           @xml.tag!('gmx:locale') do
                              localeClass.writeXML(hLocale)
                           end
                        end
                     end
                     if aLocales.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmx:locale')
                     end

                     # feature catalogue - producer (required) {CI_ResponsibleParty}
                     hParty = hDictionary[:responsibleParty]
                     unless hParty.empty?
                        role = hParty[:roleName]
                        aParties = hParty[:parties]
                        unless aParties.empty?
                           party = aParties[0]
                           @xml.tag!('gfc:producer') do
                              rPartyClass.writeXML(role, party)
                           end
                        end
                     end
                     if hParty.empty?
                        @NameSpace.issueWarning(44, 'gfc:producer')
                     end

                     # feature catalogue - functional language
                     s = hDictionary[:dictionaryFunctionalLanguage]
                     unless s.nil?
                        @xml.tag!('gfc:functionalLanguage') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gfc:functionalLanguage')
                     end

                     # feature catalogue - feature type [] (required)
                     # use feature type to represent date entities
                     unless aEntities.empty?
                        aEntities.each do |hEntity|
                           @xml.tag!('gfc:featureType') do
                              featureClass.writeXML(hEntity)
                           end
                        end
                     end
                     if aEntities.empty?
                        @NameSpace.issueWarning(45, 'gfc:featureType')
                     end

                     return metadata
                  end

               end

            end

         end
      end
   end
end
