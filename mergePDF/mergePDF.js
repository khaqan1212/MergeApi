import { LightningElement, api, track } from 'lwc';
import getPublicURLs from '@salesforce/apex/MergePDFController.getPublicUrlForContentDocuments';
import sendRequestMergePDF from '@salesforce/apex/MergePDFController.getMergedPdfUrl';

export default class MergePDF extends LightningElement {

    get acceptedFormats() {
        return ['.pdf'];
    }

    handleUploadFinished(event) {
        // Get the list of uploaded files
        const uploadedFiles = event.detail.files;
        if(uploadedFiles.length === 2){
            let docIds = [];
            uploadedFiles.forEach((item)=>{
                docIds.push(item.documentId);
            })
            getPublicURLs({
                docIds : docIds
            })
            .then(result=>{
                sendRequestMergePDF({
                    urlsList : result
                })
                .then(result => {
                    console.log('generated url: ', result);
                })
            })
        } else {
            alert('Attach only two pdf files')
        }
    }
}