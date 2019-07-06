public class HttpCalloutMailChimp
{
    public static String createList(String EndpointURL, String username , String password)
    {
        HttpRequest req = new HttpRequest();
        
        EndpointURL = 'https://us18.api.mailchimp.com/3.0/lists';
        username = 'anystring';
        password = '16903c72dc7cd12ba6ac225bbb37d41f-us18';
        
        req.setEndpoint(EndpointURL);
        req.setMethod('POST');
        req.setTimeout(120000);
        
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        system.debug('EncodingUtil.base64Encode(headerValue):::'+EncodingUtil.base64Encode(headerValue));
        req.setHeader('Authorization', authorizationHeader);
        req.setHeader('Content-Type', 'application/json');
        
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
            gen.writeStringField('name', 'List Testing from Salesforce');
            gen.writeFieldName('contact');
            gen.writeStartObject();
                gen.writeStringField('company', 'MailChimp');
                gen.writeStringField('address1', '675 Ponce De Leon Ave NE');
                gen.writeStringField('address2', 'Suite 5000');
                gen.writeStringField('city', 'Atlanta');
                gen.writeStringField('state', 'GA');
                gen.writeStringField('zip', '30308');
                gen.writeStringField('country', 'US');
                gen.writeStringField('phone', '');
            gen.writeEndObject();
            gen.writeStringField('permission_reminder', 'You are receiving this email because you signed up for updates about Freddie newest hats.');
            gen.writeFieldName('campaign_defaults');
            gen.writeStartObject();
                gen.writeStringField('from_name', 'Freddie');
                gen.writeStringField('from_email', 'freddie@freddiehats.com');
                gen.writeStringField('subject', '');
                gen.writeStringField('language', 'en');
            gen.writeEndObject();
            gen.writeBooleanField('email_type_option', true);
        gen.writeEndObject();
        
        String jsonString = gen.getAsString();
        
        System.debug('jsonString:::'+jsonString);
        
        req.setBody(jsonString);
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        if(res.getStatusCode() == 200 && res.getBody() != null)
        {
            System.debug('Response:::'+res.getBody());
            return null;
        }else
        {
            System.debug('Inside else:::');
            System.debug('res.getBody():::'+res.getBody());
            return null;
        }
    }
    
    public static String createMembersInBatch(String EndpointURL, String username , String password, String MailChimpListId)
    {
        HttpRequest req = new HttpRequest();
        
        EndpointURL = 'https://us18.api.mailchimp.com/3.0/batches';
        username = 'anystring';
        password = '16903c72dc7cd12ba6ac225bbb37d41f-us18';
        
        MailChimpListId = '856f4000dc';
        
        req.setEndpoint(EndpointURL);
        req.setMethod('POST');
        req.setTimeout(120000);
        
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        system.debug('EncodingUtil.base64Encode(headerValue):::'+EncodingUtil.base64Encode(headerValue));
        req.setHeader('Authorization', authorizationHeader);
        req.setHeader('Content-Type', 'application/json');
        
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
            gen.writeFieldName('operations');
            gen.writeStartArray();
            //In for Loop (Contacts)
                gen.writeStartObject();
                    gen.writeStringField('method', 'POST');
                    gen.writeStringField('path', 'lists/'+ MailChimpListId +'/members');
                    gen.writeStringField('body', '{\"email_address\":\"'+ 'testApi@mailchimp.com' + '\", \"status\":\"subscribed\"}');
                gen.writeEndObject();
            //Till here
            gen.writeEndArray();
        gen.writeEndObject();
        
        String jsonString = gen.getAsString();
        
        System.debug('jsonString:::'+jsonString);
        
        req.setBody(jsonString);
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        if(res.getStatusCode() == 200 && res.getBody() != null)
        {
            System.debug('Response Batch members:::'+res.getBody());
            return null;
        }else
        {
            System.debug('Inside else:::');
            System.debug('res.getBody() Batch members:::'+res.getBody());
            return null;
        }
    }
    
    public static String getBatchStatus(String EndpointURL, String username , String password, String batchId)
    {
        HttpRequest req = new HttpRequest();
        
        batchId = '7de374cfeb';
        
        EndpointURL = 'https://us18.api.mailchimp.com/3.0/batches/' + batchId;
        username = 'anystring';
        password = '16903c72dc7cd12ba6ac225bbb37d41f-us18';
        
        req.setEndpoint(EndpointURL);
        req.setMethod('GET');
        req.setTimeout(120000);
        
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        system.debug('EncodingUtil.base64Encode(headerValue):::'+EncodingUtil.base64Encode(headerValue));
        req.setHeader('Authorization', authorizationHeader);
        req.setHeader('Content-Type', 'application/json');
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        if(res.getStatusCode() == 200 && res.getBody() != null)
        {
            System.debug('Response Batch Status:::'+res.getBody());
            return null;
        }else
        {
            System.debug('Inside else:::');
            System.debug('res.getBody() Batch Status:::'+res.getBody());
            return null;
        }
    }
    
    public static String createCampaign(String EndpointURL, String username , String password, String listId)
    {
        HttpRequest req = new HttpRequest();
        
        listId = '7bd5a83a91';
        
        EndpointURL = 'https://us18.api.mailchimp.com/3.0/campaigns';
        username = 'anystring';
        password = '16903c72dc7cd12ba6ac225bbb37d41f-us18';
        
        req.setEndpoint(EndpointURL);
        req.setMethod('POST');
        req.setTimeout(120000);
        
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        system.debug('EncodingUtil.base64Encode(headerValue):::'+EncodingUtil.base64Encode(headerValue));
        req.setHeader('Authorization', authorizationHeader);
        req.setHeader('Content-Type', 'template');
        
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
            gen.writeFieldName('recipients');
                gen.writeStartObject();
                    gen.writeStringField('list_id', listId);
                gen.writeEndObject();
            gen.writeStringField('type', 'regular');
            gen.writeFieldName('settings');
            gen.writeStartObject();
                gen.writeStringField('subject_line', 'Your Purchase Receipt Rest API');
                gen.writeStringField('reply_to', 'suhas.n@mindlinkssolution.com');
                gen.writeStringField('from_name', 'Suhas Service Rest API');
                gen.writeNumberField('template_id', 417);
            gen.writeEndObject();
        gen.writeEndObject();
        
        String jsonString = gen.getAsString();      
        
        System.debug('jsonString:::'+jsonString);
        
        req.setBody(jsonString);
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        if(res.getStatusCode() == 200 && res.getBody() != null)
        {
            System.debug('Response Batch Status:::'+res.getBody());
            return null;
        }else
        {
            System.debug('Inside else:::');
            System.debug('res.getBody() Batch Status:::'+res.getBody());
            return null;
        }
    }
    
    public static String invokeCampaignToSend(String EndpointURL, String username , String password, String campaignId)
    {
        HttpRequest req = new HttpRequest();
        
        campaignId = '12da5d62d2';
        
        EndpointURL = 'https://us18.api.mailchimp.com/3.0/campaigns/' + campaignId + '/actions/send';
        username = 'anystring';
        password = '16903c72dc7cd12ba6ac225bbb37d41f-us18';
        
        req.setEndpoint(EndpointURL);
        req.setMethod('POST');
        req.setTimeout(120000);
        
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        system.debug('EncodingUtil.base64Encode(headerValue):::'+EncodingUtil.base64Encode(headerValue));
        req.setHeader('Authorization', authorizationHeader);
        req.setHeader('Content-Type', 'template');
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        if(res.getBody() == null)
        {
            System.debug('Response Batch Status:::');
            return null;
        }else
        {
            System.debug('Inside else:::');
            System.debug('res.getBody() Batch Status:::'+res.getBody());
            return null;
        }
    }
    
    public static String getAllCampaignDetails(String EndpointURL, String username , String password)
    {
        HttpRequest req = new HttpRequest();
        
        EndpointURL = 'https://us18.api.mailchimp.com/3.0/campaigns';
        username = 'anystring';
        password = '16903c72dc7cd12ba6ac225bbb37d41f-us18';
        
        req.setEndpoint(EndpointURL);
        req.setMethod('GET');
        req.setTimeout(120000);
        
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        system.debug('EncodingUtil.base64Encode(headerValue):::'+EncodingUtil.base64Encode(headerValue));
        req.setHeader('Authorization', authorizationHeader);
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        if(res.getStatusCode() == 200 && res.getBody() != null)
        {
            System.debug('Campaign Details:::'+res.getBody());
            return null;
        }else
        {
            System.debug('Inside else:::');
            System.debug('res.getBody() Batch Status:::'+res.getBody());
            return null;
        }
    }
    
    public static String getOneCampaignDetails(String EndpointURL, String username , String password, String campaignId)
    {
        HttpRequest req = new HttpRequest();
        
        campaignId = '12da5d62d2';
        
        EndpointURL = 'https://us18.api.mailchimp.com/3.0/campaigns/' + campaignId;
        username = 'anystring';
        password = '16903c72dc7cd12ba6ac225bbb37d41f-us18';
        
        req.setEndpoint(EndpointURL);
        req.setMethod('GET');
        req.setTimeout(120000);
        
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        system.debug('EncodingUtil.base64Encode(headerValue):::'+EncodingUtil.base64Encode(headerValue));
        req.setHeader('Authorization', authorizationHeader);
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        if(res.getStatusCode() == 200 && res.getBody() != null)
        {
            System.debug('One Campaign Details:::'+res.getBody());
            return null;
        }else
        {
            System.debug('Inside else:::');
            System.debug('res.getBody() Batch Status:::'+res.getBody());
            return null;
        }
    }
    
    public static String deleteList(String EndpointURL, String username , String password, String listId)
    {
        HttpRequest req = new HttpRequest();
        
        listId = '98c9fd7e9a';
        
        EndpointURL = 'https://us18.api.mailchimp.com/3.0/lists/' + listId;
        username = 'anystring';
        password = '16903c72dc7cd12ba6ac225bbb37d41f-us18';
        
        req.setEndpoint(EndpointURL);
        req.setMethod('DELETE');
        req.setTimeout(120000);
        
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        system.debug('EncodingUtil.base64Encode(headerValue):::'+EncodingUtil.base64Encode(headerValue));
        req.setHeader('Authorization', authorizationHeader);
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        if(res.getBody() == null)
        {
            System.debug('deleteList Inside:::');
            return null;
        }else
        {
            System.debug('Inside else:::');
            System.debug('res.getBody() Batch Status:::'+res.getBody());
            return null;
        }
    }
}