public with sharing class MergePDFCallout implements Queueable, Database.AllowsCallouts{
    String url1;
    String url2;
    public MergePDFCallout(String url1, String url2) {
        this.url1 = url1;
        this.url2 = url2;
    }

    public void execute(QueueableContext context) {
        
        String accessToken = 'df695c5a-fb19-41de-8ec3-4e3e12c281a8';
        String baseURL = 'https://api.dryadreceipting.com/mergePDFFromSF';
        String[] pdfUrls = new String[]{this.url1, this.url2};
        CreateMergePDFRequest mergePdfRequest = new CreateMergePDFRequest();
        mergePdfRequest.salesforceOrgId = '123456789123456789';
        mergePdfRequest.pdfURLS = pdfUrls;


        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();
        
        req.setMethod('POST');
        req.setEndPoint(baseURL);
        req.setHeader('Content-Type' , 'application/json');
        req.setHeader('Accept' , 'application/json');
        req.setHeader('authorizationToken' , accessToken);
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
