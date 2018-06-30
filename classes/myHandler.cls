global class myHandler implements Messaging.InboundEmailHandler 
{
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,
    Messaging.InboundEnvelope envelope) 
    {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        String subToCompare = 'Create Contact';

        if(email.subject.equalsIgnoreCase(subToCompare))
        {
            Contact c = new Contact();
            c.LastName = email.plainTextBody;
            insert c;
            
            if(email.textAttachments != null)
            {
                system.debug('Inside text Attachment:::');
                for (Messaging.Inboundemail.TextAttachment tAttachment : email.textAttachments) 
                {
                    Attachment attachment = new Attachment();
                    system.debug('Inside forLoop text Attachment:::');
                    attachment.Name = tAttachment.fileName;
                    attachment.Body = Blob.valueOf(tAttachment.body);
                    attachment.ParentId = c.Id;
                    insert attachment;
                }
            }
            
            if(email.binaryAttachments != null)
            {
                system.debug('Inside binaryAttachments:::');
                for (Messaging.Inboundemail.BinaryAttachment bAttachment : email.binaryAttachments) 
                {
                    Attachment attachment = new Attachment();
                    system.debug('Inside forLoop binaryAttachments:::');
                    attachment.Name = bAttachment.fileName;
                    attachment.Body = bAttachment.body;
                    attachment.ParentId = c.Id;
                    insert attachment;
                }
            }
        }

        result.success = true;
        return result;
    }
}