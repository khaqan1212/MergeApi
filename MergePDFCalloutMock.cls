@isTest
global class MergePDFCalloutMock implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        String[] pdfUrls = new String[]{'url1', 'url2'};
        CreateMergePDFRequest mergePdfRequest = new CreateMergePDFRequest();
        mergePdfRequest.salesforceOrgId = '123456789123456789';
        mergePdfRequest.pdfURLS = pdfUrls;
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody(JSON.serialize(mergePdfRequest));
        response.setStatusCode(200);
        return response; 
    }
}