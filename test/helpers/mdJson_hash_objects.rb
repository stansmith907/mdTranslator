class FgdcWriterTD

   def base
      {
         schema: {
            name: 'mdJson',
            version: '2.3.0'
         },
         contact: [
            {
               contactId: 'CID001',
               isOrganization: false,
               name: 'person name',
               positionName: 'position name',
               phone: [
                  {
                     phoneName: 'phone name',
                     phoneNumber: '111-111-1111',
                     service: ['voice']
                  }
               ],
               address: [
                  {
                     addressType: [
                        'mailing'
                     ],
                     description: 'address description',
                     deliveryPoint: [
                        'address line 1',
                        'address line 2'
                     ],
                     city: 'city',
                     administrativeArea: 'administrative area',
                     postalCode: 'postal code',
                     country: 'country'
                  }
               ]
            }
         ],
         metadata: {
            metadataInfo: {
               metadataContact: [
                  {
                     role: 'metadataContact',
                     party: [
                        {
                           contactId: 'CID001'
                        }
                     ]
                  }
               ]
            },
            resourceInfo: {
               resourceType: [
                  {
                     type: 'resource type',
                     name: 'resource name'
                  }
               ],
               citation: {
                  title: 'citation title',
                  date: [
                     {
                        'date': '2017-11-22',
                        'dateType': 'publication'
                     }
                  ],
                  responsibleParty: [
                     {
                        role: 'originator',
                        party: [
                           {
                              contactId: 'CID001'
                           }
                        ]
                     }
                  ]
               },
               abstract: 'abstract',
               purpose: 'purpose',
               timePeriod: {
                  description: 'time info currentness',
                  startDateTime: '2017-12-01'
               },
               status: [
                  'status 1'
               ],
               extent: [
                  geographicExtent: [
                     description: 'FGDC spatial domain',
                     boundingBox: {
                        westLongitude: -166.0,
                        eastLongitude: -74.0,
                        southLatitude: 24.0,
                        northLatitude: 71.0
                     }
                  ]
               ],
               pointOfContact: [
                  {
                     role: 'pointOfContact',
                     party: [
                        {
                           contactId: 'CID001'
                        }
                     ]
                  }
               ],
               keyword: [
                  {
                     keyword: [
                        {
                           keyword: 'biota',
                           keywordId: 'ISO004'
                        },
                        {
                           keyword: 'farming'
                        }
                     ],
                     'keywordType': 'isoTopicCategory',
                     'thesaurus': {
                        'title': 'ISO 19115 Topic Category'
                     }
                  }
               ],
               constraint: [
                  {
                     type: 'legal',
                     legal: {
                        'accessConstraint': ['access constraint'],
                        'useConstraint': ['use constraint'],
                        'otherConstraint': ['other constraint']
                     }
                  }
               ],
               defaultResourceLocale: {
                  language: 'eng',
                  country: 'USA',
                  characterSet: 'UTF-8'
               },
               'resourceMaintenance': [
                  {
                     'frequency': 'resource maintenance frequency'
                  }
               ]
            }
         }
      }
   end

   def person
      {
         contactId: nil,
         isOrganization: false,
         name: 'person name',
         positionName: 'position name',
         phone: [],
         address: []
      }
   end

   def organization
      {
         contactId: nil,
         isOrganization: true,
         name: 'organization name',
         phone: [],
         address: []
      }
   end

   def address
      {
         addressType: [],
         description: 'address description',
         deliveryPoint: [
            'address line 1',
            'address line 2'
         ],
         city: 'city',
         administrativeArea: 'administrative area',
         postalCode: 'postal code',
         country: 'country'
      }
   end

   def phone
      {
         phoneName: 'phone name',
         phoneNumber: nil,
         service: []
      }
   end

   def date
      {
         date: nil,
         dateType: nil
      }
   end

   def responsibleParty
      {
         role: nil,
         roleExtent: [],
         party: []
      }
   end

   def party
      {
         contactId: nil
      }
   end

   def series
      {
         seriesName: 'series name',
         seriesIssue: 'series issue',
         issuePage: 'issue page'
      }
   end

   def citation
      {
         title: 'citation title',
         date: [
            {
               'date': '2017-11-22',
               'dateType': 'publication'
            }
         ],
         responsibleParty: [
            {
               role: 'originator',
               party: [
                  {
                     contactId: 'CID001'
                  }
               ]
            }
         ]
      }
   end

   def citation_full
      {
         title: 'citation title',
         alternateTitle: [
            'alt title one',
            'alt title two'
         ],
         date: [
            {
               'date': '2017-12-02T13:41:13',
               'dateType': 'publication'
            }
         ],
         edition: 'edition',
         responsibleParty: [],
         presentationForm: [
            'form one',
            'form two'
         ],
         identifier: [],
         series: {
            seriesName: 'series name',
            seriesIssue: 'series issue',
            issuePage: 'issue page'
         },
         otherCitationDetails: [
            'other detail one',
            'other detail two'
         ],
         onlineResource: [
            {
               'uri': 'https://adiwg.mdtranslator/1'
            },
            {
               'uri': 'https://adiwg.mdtranslator/2'
            }
         ],
         browseGraphic: []
      }
   end

   def associatedResource
      {
         resourceType: [
            {
               type: 'resource type',
               name: 'resource name'
            }
         ],
         associationType: 'association type',
         initiativeType: 'initiative type',
         resourceCitation: {
            title: 'citation title',
            date: [
               {
                  'date': '2017-11-22',
                  'dateType': 'publication'
               }
            ],
            responsibleParty: [
               {
                  role: 'originator',
                  party: [
                     {
                        contactId: 'CID001'
                     }
                  ]
               }
            ]
         }
      }
   end

   def onlineResource
      {
         uri: nil,
         name: 'online resource name',
         protocol: 'protocol',
         description: 'online resource description',
         function: 'online description function'
      }
   end

   def geologicAge
      {
         ageTimeScale: 'geologic age time scale',
         ageEstimate: 'geologic age estimate',
         ageUncertainty: 'geologic age uncertainty',
         ageExplanation: 'geologic age explanation',
         ageReference: []

      }
   end

   def keywords
      {
         keyword: [],
         keywordType: 'theme',
         thesaurus: citation
      }
   end

   def keyword
      {
         keyword: nil,
         keywordId: nil
      }
   end

   def featureCollection
      {
         type: 'FeatureCollection',
         features: []
      }
   end

   def feature
      {
         type: 'Feature',
         id: nil,
         geometry: {},
         properties: {}
      }
   end

   def polygon
      {
         type: 'Polygon',
         coordinates: [
            [
               [100.0, 10.0],
               [101.0, 10.0],
               [101.0, 11.0],
               [100.0, 11.0],
               [100.0, 10.0]
            ],
            [
               [110.8, 10.8],
               [110.8, 10.2],
               [110.2, 10.2],
               [110.2, 10.8],
               [110.8, 10.8]
            ],
            [
               [120.8, 10.8],
               [120.8, 10.2],
               [120.2, 10.2],
               [120.2, 10.8],
               [120.8, 10.8]
            ]
         ]
      }
   end

   def identifier
      {
         identifier: 'identifier',
         namespace: 'namespace',
         version: 'version',
         description: 'description',
         authority: citation
      }
   end

   def taxonomy
      {
         taxonomicSystem: [
            taxonSystem
         ],
         generalScope: 'general scope',
         identificationReference: [
            identifier
         ],
         observer: [],
         identificationProcedure: 'procedures',
         identificationCompleteness: 'completeness',
         voucher: [],
         taxonomicClassification: taxonClass
      }
   end

   def taxonSystem
      {
         citation: citation,
         modifications: 'modifications'
      }
   end

   def taxonClass
      {
         taxonomicSystemId: 'taxon id',
         taxonomicRank: 'taxon rank',
         latinName: 'latin name',
         commonName: [],
         subClassification: []
      }
   end

   def taxonVoucher
      {
         specimen: 'specimen',
         repository: responsibleParty
      }
   end

   def constraint
      {
         type: nil,
         useLimitation: [],
         responsibleParty: []
      }
   end

   def graphic
      {
         fileName: nil,
         fileDescription: 'graphic description',
         fileType: 'graphic type',
         fileConstraint: [],
         fileUri: []
      }
   end

   def lineage
      {
         statement: 'statement',
         citation: [],
         processStep: [],
         source: []
      }
   end

   def source
      {
         sourceId: nil,
         description: 'description',
         sourceProcessStep: []
      }
   end

   def processStep
      {
         stepId: nil,
         description: 'description',
         rationale: 'rationale',
         processor: [],
         stepSource: [],
         stepProduct: [],
         reference: []
      }
   end

   def  timePeriod
      {
         id: nil,
         description: 'description',
         periodName: [],
         startDateTime: nil,
         endDateTime: nil,
      }
   end

   def scope
      {
         scopeCode: 'code',
         scopeDescription: [],
         scopeExtent: []
      }
   end

   def extent
      {
         description: 'description',
         geographicExtent: [],
         verticalExtent: [],
         temporalExtent: []
      }
   end

   def spatialReference
      {
         referenceSystemType: nil,
         referenceSystemIdentifier: {},
         systemParameterSet: {}
      }
   end

   def vectorRepresentation
      {
         topologyLevel: 'topology level',
         vectorObject: []
      }
   end

   def gridRepresentation
      {
         numberOfDimensions: 9,
         dimension: [],
         cellGeometry: 'point',
         transformationParameterAvailable: false
      }
   end

   def vectorObject
      {
         objectType: 'object type code',
         objectCount: 9
      }
   end

   def dimension
      {
         dimensionType: 'dimension type',
         dimensionSize: 9,
         resolution: {},
         dimensionTitle: 'dimension title',
         dimensionDescription: 'dimension description'
      }
   end
   
   def verticalDatum
      {
         datumIdentifier: {},
         datumName: 'datum name',
         encodingMethod: 'encoding method',
         isDepthSystem: false,
         verticalResolution: 9.99,
         unitOfMeasure: 'unit of measure'
      }
   end
   
   def geographicResolution
      {
         latitudeResolution: 99.9,
         longitudeResolution: 9.9,
         unitOfMeasure: 'unit'
      }
   end
   
   def bearingDistanceResolution
      {
         destanceResolution: 99.9,
         distanceUnitOfMeasure: 'distance unit',
         bearingResolution: 9.9,
         bearingUnitOfMeasure: 'bearing unit',
         bearingReferenceDirection: 'north',
         bearingReferenceMeridian: 'magnetic'
      }
   end
   
   def coordinateResolution
      {
         abscissaResolutionX: 999.9,
         ordinateResolutionY: 99.9,
         unitOfMeasure: 'units'
      }
   end
   
   def geodetic
      {
         datumIdentifier: {},
         datumName: 'datum name',
         ellipsoidIdentifier: {},
         ellipsoidName: 'ellipsoid name',
         semiMajorAxis: 9999.9,
         axisUnits: 'axis units',
         denominatorOfFlatteningRatio: 999.9
      }
   end
   
   def obliqueLinePoint 
      {
         azimuthLineLatitude: 99.9,
         azimuthLineLongitude: 99.9
      }
   end

   def spatialReferenceSystem
      {
         referenceSystemType: 'reference system type'
      }
   end

end