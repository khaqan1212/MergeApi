import { LightningElement, api, track } from 'lwc';
import getPublicURLs from '@salesforce/apex/MergePDFController.getPublicUrlForContentDocuments';
import sendRequestMergePDF from '@salesforce/apex/MergePDFController.getMergedPdfUrl';

const MergeAPIConstants = Object.freeze({
    FilesLimit : 2
})

export default class MergePDF extends LightningElement {

    get acceptedFormats() {
        return ['.pdf'];
    }

    async handleUploadFinished(event) {
        // Get the list of uploaded files
        const { files } = event.detail;
        if(files.length === MergeAPIConstants.FilesLimit){
            let docIds = files.map((item)=>
                item.documentId
            )
            let result = await getPublicURLs({
                docIds : docIds
            })
            let mergedURL = await sendRequestMergePDF({
                urlsList : result
            })
            window.open(JSON.parse(mergedURL)?.FileUrl, '_blank').focus();
        } else {
            alert('Attach only two pdf files')
        }
    }
}
