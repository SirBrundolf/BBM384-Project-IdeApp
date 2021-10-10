package com.ideapp.ideappservice.controller;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.ideapp.ideappservice.firebase.FirebaseInit;
import com.ideapp.ideappservice.model.*;
import com.ideapp.ideappservice.model.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import javax.mail.*;
import javax.mail.internet.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.*;
import java.util.concurrent.ExecutionException;

@RestController
@CrossOrigin(origins = "*")
public class IdeAppController {
    @Autowired
    FirebaseInit firebaseInit;

    @PostMapping("/signup")
    public Object[] signUp(@RequestBody UserRequest userRequest) throws ExecutionException, InterruptedException, NoSuchAlgorithmException {
        User user = userRequest.getUser();
        String password = userRequest.getPassword();
        if(user == null){
            return new Object[]{0,"user not found"};
        }
        ApiFuture<DocumentSnapshot> fut = firebaseInit.getFirestore().collection("emails").document(user.getMailAddress()).get();
        ApiFuture<DocumentSnapshot> fut2 = firebaseInit.getFirestore().collection("usernames").document(user.getUsername()).get();
        DocumentSnapshot documentSnapshot = fut.get();
        DocumentSnapshot documentSnapshot2 = fut2.get();
        if(documentSnapshot.exists() || documentSnapshot2.exists()){
            return new Object[]{1,null};
        }
        else{
            HashMap<String,Object> data = new HashMap<>();
            HashMap<String,Object> username = new HashMap<>();
            HashMap<String,Object> mail = new HashMap<>();
            data.put("isAdmin",0);
            data.put("username",user.getUsername());
            data.put("password",hashPasswd(password,user.getMailAddress()));
            data.put("name",user.getName());
            data.put("surname",user.getSurname());
            data.put("mailAddress",user.getMailAddress());
            data.put("imageUrl",user.getImageUrl());
            user.setSignStatus(1);
            data.put("signStatus",user.getSignStatus());
            mail.put("mailAddress",user.getMailAddress());
            username.put("username",user.getUsername());
            long id = System.currentTimeMillis();
            user.setId(id);
            Firestore firestoreClient = firebaseInit.getFirestore();
            DocumentReference documentReference = firestoreClient.collection("members").document((String)data.get("username"));
            documentReference.set(data);
            username.put("Ref",documentReference);
            mail.put("Ref",documentReference);
            firestoreClient.collection("usernames").document((String)username.get("username")).set(username);
            firestoreClient.collection("emails").document((String)mail.get("mailAddress")).set(mail);
            HashMap<String,Object> index = new HashMap<>();
            index.put("type","username");
            index.put("name",user.getUsername());
            firestoreClient.collection("index").document("data").collection("indexusernames").document(user.getUsername()).set(index);
            return new Object[]{0,user};
        }
    }

    @PostMapping("/signout")
    public Object[] signOut(@RequestBody User user){
        firebaseInit.getFirestore().collection("members").document(String.valueOf(user.getUsername())).update("signStatus",0);
        user.setSignStatus(0);
        return new Object[]{0,null};
    }

    @PostMapping("/signin")
    public Object[] signIn(@RequestBody UserRequest userRequest) throws ExecutionException, InterruptedException, NoSuchAlgorithmException {
        User user = userRequest.getUser();
        String password = userRequest.getPassword();
        if(user.getUsername() != null){
            ApiFuture<DocumentSnapshot> fut2 = firebaseInit.getFirestore().collection("usernames").document(user.getUsername()).get();
            DocumentSnapshot documentSnapshot = fut2.get();
            if(!documentSnapshot.exists()){
                return new Object[]{3,null};
            }
            DocumentReference username = (DocumentReference) documentSnapshot.get("Ref");
            ApiFuture<DocumentSnapshot> fut3 = username.get();
            DocumentSnapshot documentSnapshot1 = fut3.get();
            if(documentSnapshot1.get("password").equals(hashPasswd(password,(String)documentSnapshot1.get("mailAddress")))){
                username.update("signStatus",1);
                user = documentSnapshot1.toObject(User.class);
                user.setSignStatus(1);
                return new Object[]{0,user};
            }
            return new Object[]{2,null};
        }
        else if(user.getMailAddress()!= null){
            ApiFuture<DocumentSnapshot> fut2 = firebaseInit.getFirestore().collection("emails").document(user.getMailAddress()).get();
            DocumentSnapshot documentSnapshot = fut2.get();
            if(!documentSnapshot.exists()){
                return new Object[]{3,null};
            }
            DocumentReference username = (DocumentReference) documentSnapshot.get("Ref");
            ApiFuture<DocumentSnapshot> fut3 = username.get();
            DocumentSnapshot documentSnapshot1 = fut3.get();
            if(documentSnapshot1.get("password").equals(hashPasswd(password,(String)documentSnapshot1.get("mailAddress")))){
                username.update("signStatus",1);
                user = documentSnapshot1.toObject(User.class);
                user.setSignStatus(1);
                return new Object[]{0,user};
            }
            return new Object[]{2,null};
        }
        else return new Object[]{1,null};
    }

    @PostMapping("/getlast")
    public ArrayList<Message> getLastMessage(@RequestBody LastMessageRequest lastMessageRequest) throws ExecutionException, InterruptedException {
        String timestamp = lastMessageRequest.getTimestamp();
        ArrayList<Message> messages = new ArrayList<>();
        DocumentReference documentReference = firebaseInit.getFirestore().collection("dm").document(lastMessageRequest.getReceiver() + "_" + lastMessageRequest.getSender());
        ApiFuture<DocumentSnapshot> documentSnapshotApiFuture = documentReference.get();
        DocumentSnapshot documentSnapshot = documentSnapshotApiFuture.get();
        if(!documentSnapshot.exists()){
            documentReference = firebaseInit.getFirestore().collection("dm").document(lastMessageRequest.getSender() + "_" + lastMessageRequest.getReceiver());
            documentSnapshotApiFuture = documentReference.get();
            documentSnapshot = documentSnapshotApiFuture.get();
        }
        CollectionReference collectionReference= documentReference.collection("messages");
        Query query = collectionReference.whereGreaterThan("timestamp",timestamp);
        ApiFuture<QuerySnapshot> querySnapshotApiFuture = query.get();
        QuerySnapshot queryDocumentSnapshots = querySnapshotApiFuture.get();
        for(QueryDocumentSnapshot q:queryDocumentSnapshots.getDocuments()){
            messages.add(q.toObject(Message.class));
        }
        return messages;
    }

    @PostMapping("/getmessage")
    public ArrayList<Message> getMessages(@RequestBody LastMessageRequest messageRequest) throws ExecutionException, InterruptedException {
        String timestamp = messageRequest.getTimestamp();
        ArrayList<Message> messages = new ArrayList<>();
        DocumentReference documentReference = firebaseInit.getFirestore().collection("dm").document(messageRequest.getReceiver() + "_" + messageRequest.getSender());
        ApiFuture<DocumentSnapshot> documentSnapshotApiFuture = documentReference.get();
        DocumentSnapshot documentSnapshot = documentSnapshotApiFuture.get();
        if(!documentSnapshot.exists()){
            documentReference = firebaseInit.getFirestore().collection("dm").document(messageRequest.getSender() + "_" + messageRequest.getReceiver());
            documentSnapshotApiFuture = documentReference.get();
            documentSnapshot = documentSnapshotApiFuture.get();
        }
        CollectionReference collectionReference= documentReference.collection("messages");
        Query query = collectionReference.whereGreaterThan("timestamp",timestamp);
        ApiFuture<QuerySnapshot> querySnapshotApiFuture = query.get();
        QuerySnapshot queryDocumentSnapshots = querySnapshotApiFuture.get();
        for(QueryDocumentSnapshot q:queryDocumentSnapshots.getDocuments()){
            Message message =q.toObject(Message.class);
            Map<String,Boolean> visibility = message.getVisibility();
            message.setTimestamp(q.getId());
            if(visibility.get("visibility_"+messageRequest.getSender()))
            messages.add(message);
        }
        return messages;
    }

    @PostMapping("/getmoremessages")
    public ArrayList<Message> getMoreMessages(@RequestBody LastMessageRequest lastMessageRequest) throws ExecutionException, InterruptedException {
        String timestamp = lastMessageRequest.getTimestamp();
        ArrayList<Message> messages = new ArrayList<>();
        DocumentReference documentReference = firebaseInit.getFirestore().collection("dm").document(lastMessageRequest.getReceiver() + "_" + lastMessageRequest.getSender());
        ApiFuture<DocumentSnapshot> documentSnapshotApiFuture = documentReference.get();
        DocumentSnapshot documentSnapshot = documentSnapshotApiFuture.get();
        if(!documentSnapshot.exists()){
            documentReference = firebaseInit.getFirestore().collection("dm").document(lastMessageRequest.getSender() + "_" + lastMessageRequest.getReceiver());
            documentSnapshotApiFuture = documentReference.get();
            documentSnapshot = documentSnapshotApiFuture.get();
        }
        CollectionReference collectionReference= documentReference.collection("messages");
        Query query = collectionReference.whereLessThan("timestamp",timestamp).limit(20);
        ApiFuture<QuerySnapshot> querySnapshotApiFuture = query.get();
        QuerySnapshot queryDocumentSnapshots = querySnapshotApiFuture.get();
        for(QueryDocumentSnapshot q:queryDocumentSnapshots.getDocuments()){
            messages.add(q.toObject(Message.class));
        }
        return messages;
    }

    @PostMapping("/getallclubs")
    public ArrayList<Club> getAllClubs() throws ExecutionException, InterruptedException {
        ArrayList<Club> clubs = new ArrayList<>();
        CollectionReference collectionReference = firebaseInit.getFirestore().collection("clubs");
        ApiFuture<QuerySnapshot> snapshotApiFuture = collectionReference.get();
        QuerySnapshot queryDocuments = snapshotApiFuture.get();
        for(DocumentSnapshot d:queryDocuments.getDocuments()){
            Club club = d.toObject(Club.class);
            clubs.add(club);
        }
        return clubs;
    }

    @PostMapping("/addclub")
    public long addClub(@RequestBody AddClubRequest addClubRequest) throws ExecutionException, InterruptedException {
        String clubName = addClubRequest.getName();
        String imageUrl = addClubRequest.getImageUrl();
        HashMap<String,Object> data = new HashMap<>();
        data.put("name",clubName);
        data.put("imageUrl",imageUrl);
        data.put("vote",0);
        data.put("description",addClubRequest.getDescription());
        DocumentReference documentReference = firebaseInit.getFirestore().collection("clubs").document(clubName);
        data.put("reference",documentReference);//
        ApiFuture<DocumentSnapshot> doc = documentReference.get();
        DocumentSnapshot documentSnapshot = doc.get();
        if(!documentSnapshot.exists()){
        documentReference.set(data);
        HashMap<String,Object> index = new HashMap<>();
        index.put("type","club");
        index.put("name",clubName);
        firebaseInit.getFirestore().collection("index").document("data").collection("indexclubs").document(clubName).set(index);
        return 0; // successfully added;
        }
        else{
            return 1; // club exists
        }
    }

    @PostMapping("/addsubclub")
    public long addSubClub(@RequestBody SubClubRequest subClubRequest) throws ExecutionException, InterruptedException {
        String subClubName = subClubRequest.getName();
        String clubName = subClubRequest.getClubName();
        String imageUrl = subClubRequest.getImageUrl();
        HashMap<String,Object> data = new HashMap<>();
        data.put("clubName",clubName);
        data.put("name",subClubName);
        data.put("imageUrl",imageUrl);
        data.put("subClubAdmin",subClubRequest.getSubClubAdmin());
        data.put("description",subClubRequest.getDescription());
        data.put("vote",0);
        DocumentReference documentReference = firebaseInit.getFirestore().collection("clubs").document(clubName).collection("Sub-Clubs").document(subClubName);
        data.put("reference",documentReference);
        ApiFuture<DocumentSnapshot> doc = documentReference.get();
        DocumentSnapshot documentSnapshot = doc.get();
        if(!documentSnapshot.exists()){
            documentReference.set(data);
            HashMap<String,Object> index = new HashMap<>();
            index.put("type","subclub");
            index.put("name",subClubName);
            index.put("clubName",clubName);
            firebaseInit.getFirestore().collection("index").document("data").collection("indexsubclubs").document(subClubName).set(index);
            return 0; // successfully added;
        }
        else{
            return 1; // subclub exists
        }


    }
    @PostMapping("/getallsubclubs")
    public ArrayList<SubClub> getAllSubClubs(@RequestBody String clubName) throws ExecutionException, InterruptedException {
        ArrayList<SubClub> subclubs = new ArrayList<>();
        clubName = clubName.replace('"',' ').trim();
        CollectionReference collectionReference = firebaseInit.getFirestore().collection("clubs").document(clubName).collection("Sub-Clubs");
        ApiFuture<QuerySnapshot> snapshotApiFuture = collectionReference.get();
        QuerySnapshot queryDocuments = snapshotApiFuture.get();
        for(DocumentSnapshot d:queryDocuments.getDocuments()){
            SubClub club = d.toObject(SubClub.class);
            subclubs.add(club);
        }
        return subclubs;
    }

    @PostMapping("/getsubclub")
    public SubClub getSubClub(@RequestBody SubClubPostRequest subClubPostRequest) throws ExecutionException, InterruptedException {
        DocumentReference documentReference = firebaseInit.getFirestore().collection("clubs").document(subClubPostRequest.getClubName()).collection("Sub-Clubs").document(subClubPostRequest.getSubClubName());
        ApiFuture<DocumentSnapshot> documentSnapshotApiFuture = documentReference.get();
        DocumentSnapshot documentSnapshot = documentSnapshotApiFuture.get();
        SubClub subClub = documentSnapshot.toObject(SubClub.class);
        return subClub;
    }

    @PostMapping("/getevents")
    public ArrayList<Event> getSubClubEvents(@RequestBody GetEventRequest eventRequest) throws ExecutionException, InterruptedException {
        ArrayList<Event> events = new ArrayList<>();
        String clubName = eventRequest.getClubName();
        String subClubName = eventRequest.getSubClubName();
        DocumentReference subClubReference = firebaseInit.getFirestore().collection("clubs").document(clubName).collection("Sub-Clubs").document(subClubName);
        CollectionReference collectionReference = subClubReference.collection("Events");
        ApiFuture<QuerySnapshot> snapshotApiFuture = collectionReference.get();
        QuerySnapshot queryDocuments = snapshotApiFuture.get();
        for(DocumentSnapshot d:queryDocuments.getDocuments()){
            Event event = d.toObject(Event.class);
            events.add(event);
        }
        return events;
    }

    @PostMapping("/addevent")
    public long addEvent(@RequestBody EventRequest eventRequest){
        Event event = eventRequest.getEvent();
        String clubName = eventRequest.getClubName();
        String subClubName = eventRequest.getSubClubName();
        HashMap<String,Object> data = new HashMap<>();
        data.put("name",event.getName());
        data.put("timestamp",event.getTimestamp());
        data.put("date",event.getDate());
        DocumentReference documentReference = firebaseInit.getFirestore().collection("clubs").document(clubName).collection("Sub-Clubs").document(subClubName).collection("Events").document(String.valueOf(System.currentTimeMillis()));
        data.put("reference",documentReference);
        documentReference.set(data);
        return 0;
    }

    @PostMapping("/getposts")
    public ArrayList<Post> getSubClubPosts(@RequestBody SubClubPostRequest subClubPostRequest) throws ExecutionException, InterruptedException {
        ArrayList<Post> posts = new ArrayList<>();
        String clubName = subClubPostRequest.getClubName();
        String subClubName = subClubPostRequest.getSubClubName();
        DocumentReference subClubReference = firebaseInit.getFirestore().collection("clubs").document(clubName).collection("Sub-Clubs").document(subClubName);
        CollectionReference collectionReference = subClubReference.collection("Posts");
        ApiFuture<QuerySnapshot> snapshotApiFuture = collectionReference.get();
        QuerySnapshot queryDocuments = snapshotApiFuture.get();
        for(DocumentSnapshot d:queryDocuments.getDocuments()){
            Post post = d.toObject(Post.class);
            posts.add(post);
        }
        return posts;
    }

    @PostMapping("/addpost")
    public long addPost(@RequestBody PostRequest postRequest){
        Post post = postRequest.getPost();
        String clubName = postRequest.getClubName();
        String subClubName = postRequest.getSubClubName();
        HashMap<String,Object> data = new HashMap<>();
        data.put("title",post.getTitle());
        String time = String.valueOf(System.currentTimeMillis());
        data.put("timestamp",time); //
        data.put("author",post.getAuthor());
        data.put("vote",0);
        data.put("content",post.getContent());
        DocumentReference documentReference = firebaseInit.getFirestore().collection("clubs").document(clubName).collection("Sub-Clubs").document(subClubName).collection("Posts").document(time);
        data.put("reference",documentReference);
        documentReference.set(data);
        return 0;
    }

    @PostMapping("/getcomments")
    public ArrayList<Comment> getSubClubPostComments(@RequestBody GetCommentRequest getCommentRequest) throws ExecutionException, InterruptedException {
        ArrayList<Comment> comments = new ArrayList<>();
        String clubName = getCommentRequest.getClubName();
        String subClubName = getCommentRequest.getSubClubName();
        String timestamp = getCommentRequest.getTimestamp();
        CollectionReference collectionReference = firebaseInit.getFirestore().collection("clubs").document(clubName).collection("Sub-Clubs").document(subClubName).collection("Posts").document(timestamp).collection("comments");
        ApiFuture<QuerySnapshot> snapshotApiFuture = collectionReference.get();
        QuerySnapshot queryDocuments = snapshotApiFuture.get();
        for(DocumentSnapshot d:queryDocuments.getDocuments()){
            Comment comment= d.toObject(Comment.class); // reference eklenebilir belki
            comments.add(comment);
        }
        return comments;
    }

    @PostMapping("/addcomment")
    public long addComment(@RequestBody CommentRequest commentRequest){
        Comment comment = commentRequest.getComment();
        String clubName = commentRequest.getClubName();
        String subClubName = commentRequest.getSubClubName();
        String timestamp = commentRequest.getTimestamp();
        String time = String.valueOf(System.currentTimeMillis());
        DocumentReference documentReference = firebaseInit.getFirestore().collection("clubs").document(clubName).collection("Sub-Clubs").document(subClubName).collection("Posts").document(timestamp).collection("comments").document(time);
        HashMap<String,Object> data = new HashMap<>();
        data.put("timestamp",time);
        data.put("author",comment.getAuthor());
        data.put("content",comment.getContent());
        documentReference.set(data);
        return 0;
    }

    @PostMapping("/sendmessage")
    public long sendMessage(@RequestBody MessageSendRequest messageSendRequest) throws ExecutionException, InterruptedException {
        ApiFuture<DocumentSnapshot> fut2 = firebaseInit.getFirestore().collection("usernames").document(messageSendRequest.getReceiver()).get();
        DocumentSnapshot documentSnapshot = fut2.get();
        if(!documentSnapshot.exists()){
            return -1;
        }
        else{
            Message message = messageSendRequest.getMessage();
            HashMap<String,Object> data = new HashMap<>();
            data.put("text",message.getText());
            data.put("timestamp",message.getTimestamp());
            HashMap<String,Boolean> visibility = new HashMap<>();
            visibility.put("visibility_"+messageSendRequest.getReceiver(),true);
            visibility.put("visibility_"+messageSendRequest.getSender(),true);
            data.put("visibility",visibility);
            data.put("whoSent",messageSendRequest.getSender());
            DocumentReference documentReference = firebaseInit.getFirestore().collection("dm").document(messageSendRequest.getReceiver() + "_" + messageSendRequest.getSender());
            ApiFuture<DocumentSnapshot> documentSnapshotApiFuture = documentReference.get();
            documentSnapshot = documentSnapshotApiFuture.get();
            if(!documentSnapshot.exists()){
                documentReference = firebaseInit.getFirestore().collection("dm").document(messageSendRequest.getSender() + "_" + messageSendRequest.getReceiver());
                documentSnapshotApiFuture = documentReference.get();
                documentSnapshot = documentSnapshotApiFuture.get();
                HashMap<String,Object> data2 = new HashMap<>();
                if(!documentSnapshot.exists()){
                    HashMap<String,Object> dataSender = new HashMap<>();
                    HashMap<String,Object> dataReceiver = new HashMap<>();
                    dataSender.put("receiver", messageSendRequest.getReceiver());
                    dataSender.put("sender", messageSendRequest.getSender());
                    dataReceiver.put("receiver" , messageSendRequest.getSender());
                    dataReceiver.put("sender", messageSendRequest.getReceiver());
                    firebaseInit.getFirestore().collection("members").document(messageSendRequest.getSender()).collection("conversations").document(messageSendRequest.getReceiver()).set(dataSender);
                    firebaseInit.getFirestore().collection("members").document(messageSendRequest.getReceiver()).collection("conversations").document(messageSendRequest.getSender()).set(dataReceiver);
                    documentSnapshotApiFuture = documentReference.get();
                }
                data2.put("id", messageSendRequest.getSender() +"_"+ messageSendRequest.getReceiver());
                documentReference.set(data2);
            }
            documentReference.collection("messages").document(String.valueOf(System.currentTimeMillis())).set(data);
            return 0;
        }
    }

    @PostMapping  ("/getquestions")
    public ArrayList<Question> getQuestion(@RequestBody QuestionsRequest questionsRequest) throws ExecutionException, InterruptedException {
        CollectionReference collectionReference =firebaseInit.getFirestore().collection("clubs").document(questionsRequest.getClubName()).collection("Sub-Clubs").document(questionsRequest.getSubClubName()).collection("Questions");
        ApiFuture<QuerySnapshot> snapshotApiFuture = collectionReference.get();
        ArrayList<Question> questions = new ArrayList<>();
        QuerySnapshot queryDocuments = snapshotApiFuture.get();
        for(DocumentSnapshot d:queryDocuments.getDocuments()){
            Question question= d.toObject(Question.class);
            questions.add(question);
        }
        return questions;
    }

    @PostMapping ("/editpost")
    public void editPost(@RequestBody PostEditRequest postEditRequest){
        String timestamp = postEditRequest.getTimestamp();
        String clubName = postEditRequest.getClubName();
        String subClubName = postEditRequest.getSubClubName();
        firebaseInit.getFirestore().collection("clubs").document(clubName).
                collection("Sub-Clubs").document(subClubName).collection("Posts").
                document(timestamp).update("content",postEditRequest.getContent());
    }

    @PostMapping ("/editcomment")
    public void editPost(@RequestBody CommentEditRequest commentEditRequest){
        String timestamp = commentEditRequest.getTimestamp();
        String postTimestamp = commentEditRequest.getPostTimestamp();
        String clubName = commentEditRequest.getClubName();
        String subClubName = commentEditRequest.getSubClubName();
        firebaseInit.getFirestore().collection("clubs").document(clubName).
                collection("Sub-Clubs").document(subClubName).collection("Posts").
                document(postTimestamp).collection("comments").document(timestamp).update("content",commentEditRequest.getContent());
    }

    @PostMapping("/editprofile")
    public void editProfile(@RequestBody ProfileEditRequest profileEditRequest) throws ExecutionException, InterruptedException, NoSuchAlgorithmException {
        String username = profileEditRequest.getUsername();
        String updatedField = profileEditRequest.getUpdatedField();
        String updatedData = profileEditRequest.getUpdatedData();
        DocumentReference documentReference = firebaseInit.getFirestore().collection("members").document(username);
        if(updatedField.equals("password")){
            String[] splitted = updatedData.split(" ");
            ApiFuture<DocumentSnapshot> documentSnapshotApiFuture = documentReference.get();
            DocumentSnapshot documentSnapshot = documentSnapshotApiFuture.get();
            String mail = (String)documentSnapshot.get("mailAddress");
            if(!documentSnapshot.get("password").equals(hashPasswd(splitted[0],mail))){
                return;
            }
            String password = hashPasswd(splitted[1],mail);
            documentReference.update(updatedField,password);
        }
        else if(updatedField.equals("mailAddress")){
            ApiFuture<DocumentSnapshot> documentSnapshotApiFuture = documentReference.get();
            DocumentSnapshot documentSnapshot = documentSnapshotApiFuture.get();
            String mail = (String)documentSnapshot.get("mailAddress");
            HashMap<String,Object> mailMap = new HashMap<>();
            mailMap.put("mailAddress",updatedData);
            mailMap.put("Ref",documentReference);
            firebaseInit.getFirestore().collection("emails").document(mail).delete();
            firebaseInit.getFirestore().collection("emails").document(updatedData).set(mailMap);
            documentReference.update(updatedField,updatedData);
        }
        else{
        documentReference.update(updatedField,updatedData);}
    }

    @PostMapping("/addquestion")
    public void addQuestion(@RequestBody QuestionsRequest questionsRequest){
        Question[] questions = questionsRequest.getQuestions();
        CollectionReference collectionReference = firebaseInit.getFirestore().collection("clubs").document(questionsRequest.getClubName()).collection("Sub-Clubs").document(questionsRequest.getSubClubName()).collection("Questions");
        WriteBatch writeBatch = firebaseInit.getFirestore().batch();
        for(Question q:questions){
            DocumentReference documentReference = collectionReference.document(String.valueOf((int)(Math.random()*999999)));
            writeBatch.set(documentReference,q);
        }
        writeBatch.commit();
    }

    @PostMapping("/mailverification")
    public String mailVerification(@RequestBody String mail) throws MessagingException {
        String code = String.valueOf((int)(Math.random()*999999));
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("ideappproject@gmail.com", "baembuzenu" );
            }
        });
        MimeMessage msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress("ideappproject@gmail.com", false));
        msg.setRecipients(MimeMessage.RecipientType.TO, InternetAddress.parse(mail));
        msg.setSubject("IdeApp Email Verification Code");
        msg.setContent("Your IdeApp Code is : " + code, "text/html");
        msg.setSentDate(new Date());
        Transport.send(msg);
        return code;
    }
    
    @PostMapping("/deletecomment")
    public void deleteComment(@RequestBody CommentEditRequest commentEditRequest){
        firebaseInit.getFirestore().collection("clubs").document(commentEditRequest.getClubName()).
                collection("Sub-Clubs").document(commentEditRequest.getSubClubName()).
                collection("Posts").document(commentEditRequest.getPostTimestamp()).
                collection("comments").document(commentEditRequest.getTimestamp()).delete();
    }

    @SuppressWarnings("unchecked")
    @PostMapping("/deletemessage")
    public void deleteMessage(@RequestBody MessageDeleteRequest messageDeleteRequest) throws ExecutionException, InterruptedException {
        String timestamp = messageDeleteRequest.getTimestamp();
        String sender = messageDeleteRequest.getSender();
        String receiver = messageDeleteRequest.getReceiver();
        DocumentReference documentReference = firebaseInit.getFirestore().collection("dm").document(receiver + "_" + sender).collection("messages").document(timestamp);
        ApiFuture<DocumentSnapshot> documentSnapshotApiFuture = documentReference.get();
        DocumentSnapshot documentSnapshot = documentSnapshotApiFuture.get();
        if(!documentSnapshot.exists()){
            documentReference = firebaseInit.getFirestore().collection("dm").document(sender + "_" + receiver).collection("messages").document(timestamp);
            documentSnapshotApiFuture = documentReference.get();
            documentSnapshot = documentSnapshotApiFuture.get();
        }
        HashMap<String,Boolean> oldData = (HashMap<String, Boolean>) documentSnapshot.get("visibility");
        HashMap<String,Boolean> newData = new HashMap<>();
        newData.put("visibility_" + sender, false);
        newData.put("visibility_" + receiver, oldData.get("visibility_" + receiver));
        documentReference.update("visibility", newData);
    }

    @PostMapping("/refreshpasswordstage2")
    public void refreshPassword(@RequestBody RefreshPasswordVerificationRequest refreshPasswordVerificationRequest)  throws ExecutionException, InterruptedException, NoSuchAlgorithmException {
        String mail = refreshPasswordVerificationRequest.getMail();
        String newPassword = refreshPasswordVerificationRequest.getPassword();
        String newPasswordHashed = hashPasswd(newPassword, mail);
        CollectionReference collectionReference = firebaseInit.getFirestore().collection("emails");
        ApiFuture<DocumentSnapshot> documentSnapshotApiFuture = collectionReference.document(mail).get();
        DocumentSnapshot documentSnapshot = documentSnapshotApiFuture.get();
        DocumentReference documentReference = (DocumentReference) documentSnapshot.get("Ref");
        documentReference.update("password", newPasswordHashed);
    }

    @PostMapping("/getclubrequests")
    public ArrayList<UserRequestClub> getClubRequests() throws ExecutionException, InterruptedException {
        ArrayList<UserRequestClub> userRequestClubs = new ArrayList<>();
        CollectionReference collectionReference = firebaseInit.getFirestore().collection("clubrequests");
        ApiFuture<QuerySnapshot> snapshotApiFuture = collectionReference.get();
        QuerySnapshot queryDocumentSnapshots = snapshotApiFuture.get();
        for(DocumentSnapshot d:queryDocumentSnapshots.getDocuments()){
            UserRequestClub userRequestClub = d.toObject(UserRequestClub.class);
            userRequestClubs.add(userRequestClub);
        }
        return userRequestClubs;
    }

    @PostMapping ("/addcandidate")
    public void addCandidate(@RequestBody Candidate candidate){
        CollectionReference collectionReference = firebaseInit.getFirestore().collection("candidates");
        collectionReference.document(String.valueOf(System.currentTimeMillis())).set(candidate);
    }

    @PostMapping ("/getcandidates")
    public ArrayList<Candidate> getCandidates() throws ExecutionException, InterruptedException {
        ArrayList<Candidate> candidates = new ArrayList<>();
        CollectionReference collectionReference = firebaseInit.getFirestore().collection("candidates");
        QuerySnapshot queryDocumentSnapshots = collectionReference.get().get();
        for(DocumentSnapshot d: queryDocumentSnapshots.getDocuments()){
            candidates.add(d.toObject(Candidate.class));
        }
        return candidates;
    }

    @PostMapping("/getsubclubrequests")
    public ArrayList<UserRequestSubClub> getSubClubRequests() throws ExecutionException, InterruptedException {
        ArrayList<UserRequestSubClub> userRequestSubClubs = new ArrayList<>();
        CollectionReference collectionReference = firebaseInit.getFirestore().collection("subclubrequests");
        ApiFuture<QuerySnapshot> snapshotApiFuture = collectionReference.get();
        QuerySnapshot queryDocumentSnapshots = snapshotApiFuture.get();
        for(DocumentSnapshot d:queryDocumentSnapshots.getDocuments()){
            UserRequestSubClub userRequestSubClub = d.toObject(UserRequestSubClub.class);
            userRequestSubClubs.add(userRequestSubClub);
        }
        return userRequestSubClubs;
    }

    @PostMapping ("/addsubclubrequest")
    public void addSubClubRequest(@RequestBody UserRequestSubClub userRequestSubClub){
        firebaseInit.getFirestore().collection("subclubrequests").document(String.valueOf(System.currentTimeMillis())).set(userRequestSubClub); // hashmaple de olur bu arada
    }

    @PostMapping ("/addclubrequest")
    public void addClubRequest(@RequestBody UserRequestClub userRequestClub){
        firebaseInit.getFirestore().collection("clubrequests").document(String.valueOf(System.currentTimeMillis())).set(userRequestClub); // hashmaple de olur bu arada
    }

    @PostMapping ("/deleteprofile")
    public void deleteUser(@RequestBody User user) throws ExecutionException, InterruptedException {
        DocumentReference documentReference = firebaseInit.getFirestore().collection("members").document(user.getUsername());
        JoinedClub joinedClub;
        CollectionReference collectionReference = documentReference.collection("joinedclubs");
        QuerySnapshot snapshot = collectionReference.get().get();
        for(DocumentSnapshot d:snapshot.getDocuments()){
            joinedClub = d.toObject(JoinedClub.class);
            DocumentReference d1 = firebaseInit.getFirestore().collection("clubs").document(joinedClub.getParentClub()).collection("Sub-Clubs").document(joinedClub.getClubName()).collection("Users").document(user.getUsername());
            d1.delete();
            d.getReference().delete();
        }
        documentReference.delete();
        firebaseInit.getFirestore().collection("emails").document(user.getMailAddress()).delete();
        firebaseInit.getFirestore().collection("usernames").document(user.getUsername()).delete();
        firebaseInit.getFirestore().collection("index").document("data").collection("indexusernames").document(user.getUsername()).delete();
    }

    @PostMapping ("/banuser")
    public void removeFromClub(@RequestBody Report report) throws ExecutionException, InterruptedException {
        DocumentReference documentReference = firebaseInit.getFirestore().collection("clubs").
                document(report.getClubName()).collection("Sub-Clubs").
                document(report.getSubClubName()).collection("Users").
                document(report.getUsername());
        documentReference.delete();
        DocumentReference documentReference2 = firebaseInit.getFirestore().collection("members").
                document(report.getUsername()).collection("joinedclubs").
                document(report.getSubClubName());
        documentReference2.delete();
    }

    @PostMapping ("/getconversations")
    public ArrayList<Conversation> getConversations(@RequestBody String username) throws ExecutionException, InterruptedException {
        username = username.replace('"',' ').trim();
        CollectionReference collectionReference = firebaseInit.getFirestore().collection("members").document(username).collection("conversations");
        ApiFuture<QuerySnapshot> snapshotApiFuture = collectionReference.get();
        QuerySnapshot queryDocumentSnapshots = snapshotApiFuture.get();
        ArrayList<Conversation> conversations = new ArrayList<>();
        for(DocumentSnapshot d: queryDocumentSnapshots.getDocuments()){
            conversations.add(d.toObject(Conversation.class));
        }
        return conversations;
    }

    @PostMapping ("/getjoinedclubs")
    public ArrayList<JoinedClub> getJoinedClubs(@RequestBody String username) throws ExecutionException, InterruptedException {
        username = username.replace('"',' ').trim();
        CollectionReference collectionReference = firebaseInit.getFirestore().collection("members").document(username).collection("joinedclubs");
        ArrayList<JoinedClub> joinedClubs = new ArrayList<>();
        for(DocumentReference d: collectionReference.listDocuments()){
            DocumentSnapshot documentSnapshot = d.get().get();
            joinedClubs.add(documentSnapshot.toObject(JoinedClub.class));
        }
        return joinedClubs;
    }

    @PostMapping ("/addjoinedclub")
    public void addJoinedClub(@RequestBody JoinedClubRequest joinedClubRequest) throws ExecutionException, InterruptedException {
        JoinedClub joinedClub = joinedClubRequest.getJoinedClub();
        String username = joinedClubRequest.getUsername();
        HashMap<String,Object> data = new HashMap<>();
        data.put("clubName",joinedClub.getClubName());
        data.put("parentClub",joinedClub.getParentClub());
        data.put("imageUrl",joinedClub.getImageUrl());
        data.put("description", joinedClub.getDescription());
        firebaseInit.getFirestore().collection("members").document(username).collection("joinedclubs").document(joinedClub.getClubName()).set(data);
        CollectionReference collectionReference = firebaseInit.getFirestore().collection("clubs").
                document(joinedClub.getParentClub()).collection("Sub-Clubs").
                document(joinedClub.getClubName()).collection("Users");
        HashMap<String,Object> joined = new HashMap<>();
        joined.put("username",joinedClubRequest.getUsername());
        collectionReference.document(joinedClubRequest.getUsername()).set(joined);
    }

    @PostMapping ("/index")
    public ArrayList<Index> getIndex() throws ExecutionException, InterruptedException {
        CollectionReference collectionReferenceClub = firebaseInit.getFirestore().collection("index").document("data").collection("indexclubs");
        CollectionReference collectionReferenceSubClub = firebaseInit.getFirestore().collection("index").document("data").collection("indexsubclubs");
        CollectionReference collectionReferenceUsername = firebaseInit.getFirestore().collection("index").document("data").collection("indexusernames");
        ArrayList<Index> indexes = new ArrayList<>();
        for(DocumentReference d: collectionReferenceClub.listDocuments()){
            DocumentSnapshot documentSnapshot = d.get().get();
            indexes.add(documentSnapshot.toObject(Index.class));
        }
        for(DocumentReference d: collectionReferenceSubClub.listDocuments()){
            DocumentSnapshot documentSnapshot = d.get().get();
            indexes.add(documentSnapshot.toObject(Index.class));
        }
        for(DocumentReference d: collectionReferenceUsername.listDocuments()){
            DocumentSnapshot documentSnapshot = d.get().get();
            indexes.add(documentSnapshot.toObject(Index.class));
        }
        return indexes;
    }

    @PostMapping("/updatevote")
    public void setVote(@RequestBody VoteRequest voteRequest){
        String timestamp = voteRequest.getTimestamp();
        int vote = voteRequest.getVote();
        String clubName = voteRequest.getClubName();
        String subClubName = voteRequest.getSubClubName();
        firebaseInit.getFirestore().collection("clubs").document(clubName).
                collection("Sub-Clubs").document(subClubName).
                collection("Posts").document(timestamp).update("vote",vote);

    }

    @PostMapping("/updateclubvote")
    public void setClubVote(@RequestBody VoteRequest voteRequest){
        int vote = voteRequest.getVote();
        String clubName = voteRequest.getClubName();
        firebaseInit.getFirestore().collection("clubs").document(clubName).update("vote",vote);
    }

    @PostMapping("/updatesubclubvote")
    public void setSubClubVote(@RequestBody VoteRequest voteRequest){
        int vote = voteRequest.getVote();
        String clubName = voteRequest.getClubName();
        String subClubName = voteRequest.getSubClubName();
        firebaseInit.getFirestore().collection("clubs").document(clubName).
                collection("Sub-Clubs").document(subClubName).update("vote",vote);
    }

    @PostMapping("/updatecommentvote")
    public void setCommentVote(@RequestBody VoteCommentRequest voteCommentRequest){
        String timestamp = voteCommentRequest.getTimestamp();
        String postTimestamp = voteCommentRequest.getPostTimestamp();
        int vote = voteCommentRequest.getVote();
        String clubName = voteCommentRequest.getClubName();
        String subClubName = voteCommentRequest.getSubClubName();
        firebaseInit.getFirestore().collection("clubs").document(clubName).
                collection("Sub-Clubs").document(subClubName).
                collection("Posts").document(postTimestamp).collection("comments").document(timestamp).update("vote",vote);
    }

    @PostMapping("/getregisteredusers")
    public ArrayList<String> getRegisteredUsers(@RequestBody RegisteredUsersRequest registeredUsersRequest) throws ExecutionException, InterruptedException {
        ArrayList<String> usernames = new ArrayList<>();
        CollectionReference collectionReference = firebaseInit.getFirestore().collection("clubs").
                document(registeredUsersRequest.getClubName()).collection("Sub-Clubs").
                document(registeredUsersRequest.getSubClubName()).collection("Users");
        ApiFuture<QuerySnapshot> apiFuture = collectionReference.get();
        QuerySnapshot queryDocumentSnapshots = apiFuture.get();
        for(QueryDocumentSnapshot d:queryDocumentSnapshots.getDocuments()){
            usernames.add((String)d.get("username"));
        }
        return usernames;
    }

    @PostMapping ("/getreports")
    public ArrayList<Report> getReports() throws ExecutionException, InterruptedException {
        CollectionReference collectionReference = firebaseInit.getFirestore().collection("reports");
        ArrayList<Report> reports = new ArrayList<>();
        ApiFuture<QuerySnapshot> querySnapshotApiFuture = collectionReference.get();
        QuerySnapshot queryDocumentSnapshots = querySnapshotApiFuture.get();
        for(DocumentSnapshot d:queryDocumentSnapshots.getDocuments()){
            reports.add(d.toObject(Report.class));
        }
        return reports;
    }
    
    @PostMapping("/password")
    public int passwordCompare(@RequestBody PasswordRequest passwordRequest) throws ExecutionException, InterruptedException, NoSuchAlgorithmException {
        String username = passwordRequest.getUsername();
        DocumentReference documentReference = firebaseInit.getFirestore().collection("members").document(username);
        DocumentSnapshot documentSnapshot = documentReference.get().get();
        String email = (String)documentSnapshot.get("mailAddress");
        String hashed = hashPasswd(passwordRequest.getPassword(),email);
        String hashedpassword = (String)documentSnapshot.get("password");
        if(!hashedpassword.equals(hashed)) return -1;
        return 0;
    }
    
    @PostMapping ("/addreports")
    public int addReport(@RequestBody Report report) throws ExecutionException, InterruptedException {
        CollectionReference collectionReference = firebaseInit.getFirestore().collection("reports");
        collectionReference.document(String.valueOf(System.currentTimeMillis())).set(report);
        return 0;
    }

    @PostMapping("/setsubclubadmin")
    public int setSubClubAdmin(@RequestBody Candidate candidate) throws ExecutionException, InterruptedException {
        DocumentReference documentReference = firebaseInit.getFirestore().collection("clubs").document(candidate.getClubName()).collection("Sub-Clubs").document(candidate.getSubClubName());
        DocumentSnapshot documentSnapshot = documentReference.get().get();
        if((documentSnapshot.get("subClubAdmin")) !=null){
            if(!((String)documentSnapshot.get("subClubAdmin")).equals("")){
                return -1;
            }
            else{
                documentReference.update("subClubAdmin",candidate.getUsername());
                return 0;
            }
        }
        else{
            documentReference.update("subClubAdmin",candidate.getUsername());
        }
        return 0;
    }

    @PostMapping("/setimage")
    public void setImage(@RequestBody ImageRequest imageRequest){
        String username = imageRequest.getUsername();
        String imageUrl = imageRequest.getImageUrl();
        HashMap<String,Object> image= new HashMap<>();
        image.put("imageUrl",imageUrl);
        SetOptions setOptions = SetOptions.merge();
        firebaseInit.getFirestore().collection("members").document(username).set(image,setOptions);
    }

    @PostMapping("/getmailaddress")
    public String getMailAddress(@RequestBody String username) throws InterruptedException, ExecutionException{
        DocumentReference documentReference = firebaseInit.getFirestore().collection("members").document(username);
        ApiFuture<DocumentSnapshot> documentSnapshotApiFuture = documentReference.get();
        DocumentSnapshot documentSnapshot = documentSnapshotApiFuture.get();
        User user = documentSnapshot.toObject(User.class);
        return user.getMailAddress();
    }

    @PostMapping("/getuser")
    public User getUser(@RequestBody String username) throws InterruptedException, ExecutionException{
        DocumentReference documentReference = firebaseInit.getFirestore().collection("members").document(username);
        ApiFuture<DocumentSnapshot> documentSnapshotApiFuture = documentReference.get();
        DocumentSnapshot documentSnapshot = documentSnapshotApiFuture.get();
        User user = documentSnapshot.toObject(User.class);
        return user;
    }

    @PostMapping("/resetpassword")
    public void resetPassword(@RequestBody PasswordRequest passwordRequest) throws NoSuchAlgorithmException, InterruptedException, ExecutionException {
        String username = passwordRequest.getUsername();
        String password = passwordRequest.getPassword();
        DocumentReference documentReference = firebaseInit.getFirestore().collection("members").document(username);
        ApiFuture<DocumentSnapshot> documentSnapshotApiFuture = documentReference.get();
        DocumentSnapshot documentSnapshot = documentSnapshotApiFuture.get();
        User user = documentSnapshot.toObject(User.class);
        documentReference.update("password", hashPasswd(password, user.getMailAddress()));
    }
    
    public String hashPasswd(String password,String mail) throws NoSuchAlgorithmException {
        String newString = password.concat(mail);
        byte[] convert = newString.getBytes();
        MessageDigest md = MessageDigest.getInstance("SHA-1");
        return Base64.getEncoder().encodeToString(md.digest(convert));
    }
}