public with sharing class MergePDFController {
    
    @AuraEnabled
    public static string[] getPublicUrlForContentDocuments(List<String> docIds){
        try {
            List<ContentVersion> cvList = [select id from contentversion where contentdocumentid IN:docIds];
            List<ContentDistribution> contentDistributionList = new List<ContentDistribution>();
            for(ContentVersion cv : cvList){
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
            insert contentDistributionList;     
            List<ContentDistribution> contentDistributionPublicItems = [SELECT DistributionPublicUrl, ContentDownloadUrl FROM ContentDistribution WHERE ContentDocumentId=:docIds];
            system.debug('ulrs: '+contentDistributionPublicItems);
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
        try {
            MergePDFCallout mergePDFsRequest = new MergePDFCallout(urlsList[0], urlsList[1]);
            //UpdateCustomerQueueable updateCust = new UpdateCustomerQueueable(recordId, n);
            Id jobId = System.enqueueJob(mergePDFsRequest);
            system.debug(jobId);
            return 'abc';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
