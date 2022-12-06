public with sharing class MergePDFController {
    
    @AuraEnabled
    public static string[] getPublicUrlForContentDocuments(List<String> docIds){
        try {
            List<ContentDistribution> contentDistributionList = new List<ContentDistribution>();
            for(ContentVersion cv : MergeApiQueries.QueryContentVersionFromDocumentIds(docIds)){
                ContentDistribution cd = new ContentDistribution();
                cd.Name = 'Test';
                cd.ContentVersionId = cv.id;
                cd.PreferencesAllowViewInBrowser= true;
                cd.PreferencesLinkLatestVersion=true;
                cd.PreferencesNotifyOnVisit=false;
                cd.PreferencesPasswordRequired=false;
                cd.PreferencesAllowOriginalDownload= true;
                contentDistributionList.add(cd);
            }
            //inserting ContentDistribution to make public Urls available for these objects
            insert contentDistributionList;    

            List<ContentDistribution> contentDistributionPublicItems = MergeApiQueries.QueryContentDistributionFromDocumentIds(docIds);
            String[] publicUrls = new String[]{};
            for(ContentDistribution cdPublic : contentDistributionPublicItems){
                publicUrls.add(cdPublic.ContentDownloadUrl);
            }
            return publicUrls;

        } catch (Exception e) {
            system.debug('excepion : '+ e);
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string getMergedPdfUrl(String[] urlsList){
        CreateMergePDFRequest mergePdfRequest = new CreateMergePDFRequest(MergeAPIConstants.SalesforceOrgId, urlsList);
        return sendRequestMergeAPI(JSON.serialize(mergePdfRequest));
    }

    public static String sendRequestMergeAPI(String requestBody ){
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();

        req.setMethod('POST');
        req.setEndPoint(MergeAPIConstants.BaseURL);
        req.setHeader('Content-Type' , 'application/json');
        req.setHeader('Accept' , 'application/json');
        req.setHeader('authorizationToken' , MergeAPIConstants.AccessToken);
        req.setBody(requestBody);

        try {
            res = http.send(req);
            system.debug('Status code: ' + res.getStatusCode());
            system.debug(res.getBody());
            return res.getBody();

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
