public with sharing class MergePDFCallout implements Queueable, Database.AllowsCallouts{
    String[] pdfUrls;
    public MergePDFCallout(String[] pdfURLs) {
        this.pdfUrls = pdfURLs;
    }

    public void execute(QueueableContext context) {
        
        CreateMergePDFRequest mergePdfRequest = new CreateMergePDFRequest(MergeAPIConstants.SalesforceOrgId, this.pdfUrls);

        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();
        
        req.setMethod('POST');
        req.setEndPoint(MergeAPIConstants.BaseURL);
        req.setHeader('Content-Type' , 'application/json');
        req.setHeader('Accept' , 'application/json');
        req.setHeader('authorizationToken' , MergeAPIConstants.AccessToken);
        system.debug('mergePdfRequest: ' + mergePdfRequest);
        req.setBody(JSON.serialize(mergePdfRequest));

        try {
            res = http.send(req);
            system.debug('Status code: ' + res.getStatusCode());
            system.debug(res.getBody());
            // We can do something on the backend later with result response.

        }
        catch(Exception e){
            system.debug(e);
        }
    }
}
