package com.ideapp.ideappservice.model;

import com.google.cloud.firestore.DocumentReference;

public class DocumentRequest {
    DocumentReference documentReference;

    public DocumentReference getDocumentReference() {
        return documentReference;
    }

    public void setDocumentReference(DocumentReference documentReference) {
        this.documentReference = documentReference;
    }
    public DocumentRequest(){}
}
