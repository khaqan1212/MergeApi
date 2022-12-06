public with sharing class MergeApiQueries {
    public static final string QueryContentVersion = 'select id from contentversion where contentdocumentid IN:docIds';

    public static List<ContentVersion> QueryContentVersionFromDocumentIds(String[] docIds) {
        return [SELECT Id FROM ContentVersion WHERE ContentDocumentId IN:docIds];
    }

    public static List<ContentDistribution> QueryContentDistributionFromDocumentIds(String[] docIds) {
        return [SELECT DistributionPublicUrl, ContentDownloadUrl FROM ContentDistribution WHERE ContentDocumentId=:docIds];
    }
}
