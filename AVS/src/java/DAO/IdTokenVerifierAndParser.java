/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;

/**
 *
 * @author BinhNT
 */
public class IdTokenVerifierAndParser {
//deploy sever
//    private static final String GOOGLE_CLIENT_ID = "912620741556-58chb0o18k50h03oblr4gr5t8vrqi139.apps.googleusercontent.com";
    
    //localhost
    private static final String GOOGLE_CLIENT_ID = "912620741556-hcmv2c3g46fti4psnqsjduu2hqcjo0qj.apps.googleusercontent.com";
    

    public static GoogleIdToken.Payload getPayload(String tokenString) throws Exception {

        JacksonFactory jacksonFactory = new JacksonFactory();
        GoogleIdTokenVerifier googleIdTokenVerifier = new GoogleIdTokenVerifier(new NetHttpTransport(), jacksonFactory);
        GoogleIdToken token = GoogleIdToken.parse(jacksonFactory, tokenString);
        if (googleIdTokenVerifier.verify(token)) {
            GoogleIdToken.Payload payload = token.getPayload();
            if (!GOOGLE_CLIENT_ID.equals(payload.getAudience())) {
                throw new IllegalArgumentException("Audience mismatch");
            } else if (!GOOGLE_CLIENT_ID.equals(payload.getAuthorizedParty())) {
                throw new IllegalArgumentException("Client ID mismatch");
            }
            return payload;
        } else {
            throw new IllegalArgumentException("id token cannot be verified");
        }
    }
}
