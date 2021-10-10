package com.ideapp.ideappservice.firebase;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.firestore.Firestore;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.io.FileInputStream;


@Service
public class FirebaseInit  {
        @PostConstruct
        public void initApp() throws Exception{
                FileInputStream serviceAccount =
                        new FileInputStream("ideapp-4efc7-firebase-adminsdk-m6yzf-9caf59de36.json");

                FirebaseOptions options = new FirebaseOptions.Builder()
                        .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                        .build();

                FirebaseApp.initializeApp(options);}
        public FirebaseAuth getAuth(){
                return FirebaseAuth.getInstance();
        }
        public Firestore getFirestore(){
                return FirestoreClient.getFirestore();
        }
}
