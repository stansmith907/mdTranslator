# mdJson 2.0 writer - metadataInfo

# History:
#   Stan Smith 2017-03-11 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_identifier'
require_relative 'mdJson_citation'
require_relative 'mdJson_locale'
require_relative 'mdJson_date'
require_relative 'mdJson_responsibleParty'
require_relative 'mdJson_onlineResource'
require_relative 'mdJson_constraint'
require_relative 'mdJson_maintenance'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module MetadataInfo

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hMetaInfo)

                  Jbuilder.new do |json|
                     json.metadataIdentifier Identifier.build(hMetaInfo[:metadataIdentifier]) unless hMetaInfo[:metadataIdentifier].empty?
                     json.parentMetadata Citation.build(hMetaInfo[:parentMetadata])
                     json.defaultMetadataLocale Locale.build(hMetaInfo[:defaultMetadataLocale]) unless hMetaInfo[:defaultMetadataLocale].empty?
                     json.otherMetadataLocale @Namespace.json_map(hMetaInfo[:otherMetadataLocales], Locale)
                     json.metadataContact @Namespace.json_map(hMetaInfo[:metadataContacts], ResponsibleParty)
                     json.metadataDate @Namespace.json_map(hMetaInfo[:metadataDates], Date)
                     json.metadataOnlineResource @Namespace.json_map(hMetaInfo[:metadataLinkages], OnlineResource)
                     json.metadataConstraint @Namespace.json_map(hMetaInfo[:metadataConstraints], Constraint)
                     json.metadataMaintenance Maintenance.build(hMetaInfo[:metadataMaintenance]) unless hMetaInfo[:metadataMaintenance].empty?
                     json.alternateMetadataReference @Namespace.json_map(hMetaInfo[:alternateMetadataReferences], Citation)
                     json.metadataStatus hMetaInfo[:metadataStatus]
                  end

               end # build
            end # MetadataInfo

         end
      end
   end
end
