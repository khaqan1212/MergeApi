@isTest
public with sharing class MergePDFControllerTest {
    @testSetup
    public static void testSetup(){
        ContentVersion[] contentList = new ContentVersion[]{};
        ContentVersion contentVersion = new ContentVersion(
        Title          = 'a picture',
        PathOnClient   = 'Pic.jpg',
        VersionData    = Blob.valueOf('Test Content'),
        IsMajorVersion = true);
        contentList.add(contentVersion);

        contentVersion = new ContentVersion(
        Title          = 'b picture',
        PathOnClient   = 'Pic.jpg',
        VersionData    = Blob.valueOf('Test Content'),
        IsMajorVersion = true);
        contentList.add(contentVersion);

        insert contentList;
    }
    @isTest
    public static void getMergedPdfUrlTest() {
        Test.setMock(HttpCalloutMock.class, new MergePDFCalloutMock());
        Test.startTest();
        MergePDFController.getMergedPdfUrl(new String[]{'url1', 'url2'});
        Test.stopTest();
    }

    @isTest
    public static void getPublicUrlForContentDocumentsTest(){
        ContentDocument[] cdList = [SELECT Id FROM ContentDocument LIMIT 2];
        String[] publicUrls = MergePDFController.getPublicUrlForContentDocuments(new String[]{cdList[0].Id, cdList[1].Id});
        system.assertEquals(publicUrls.size() , 2);
    }
}