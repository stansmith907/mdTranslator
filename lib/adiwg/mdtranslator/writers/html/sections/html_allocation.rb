# HTML writer
# allocation

# History:
#  Stan Smith 2017-04-04 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_Allocation

               def initialize(html)
                  @html = html
               end

               def writeHtml(hAllocation)

                  # allocation - amount
                  unless hAllocation[:amount].nil?
                     @html.em('Amount: ')
                     @html.text!(hAllocation[:amount].to_s)
                     @html.br
                  end

                  # allocation - currency
                  unless hAllocation[:currency].nil?
                     @html.em('Currency: ')
                     @html.text!(hAllocation[:currency])
                     @html.br
                  end

                  # allocation - sourceId
                  unless hAllocation[:sourceId].nil?
                     hContact = Html_Document.getContact(hAllocation[:sourceId])
                     @html.em('Source Contact: ')
                     @html.a(hContact[:contactId], 'href' => '#CID_'+hContact[:contactId])
                     @html.br
                  end

                  # allocation - recipientId
                  unless hAllocation[:recipientId].nil?
                     hContact = Html_Document.getContact(hAllocation[:recipientId])
                     @html.em('Recipient Contact: ')
                     @html.a(hContact[:contactId], 'href' => '#CID_'+hContact[:contactId])
                     @html.br
                  end

                  # allocation - matching {Boolean}
                  unless hAllocation[:matching].nil?
                     @html.em('Matching Funds Provided: ')
                     @html.text!(hAllocation[:matching].to_s)
                     @html.br
                  end

                  # allocation - comment
                  unless hAllocation[:comment].nil?
                     @html.em('Comment: ')
                     @html.section(:class => 'block') do
                        @html.text!(hAllocation[:comment])
                     end
                  end

               end # writeHtml
            end # Html_Allocation

         end
      end
   end
end