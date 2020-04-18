/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author quang
 */
public class DeleteLikeCommentControllerTest {
    
    public DeleteLikeCommentControllerTest() {
    }
    protected String userid;
    protected String commentid;
    protected String newsid;
    @Before
    public void setUp() {
        userid = "";
        commentid= "";
        newsid= "";
    }
    @Test// userid= null => userid not an integer
    public void testUserIdIsNotNumberOrEmpty() {
        assertTrue("userid is not an integer",userid== null || userid.isEmpty());
    }
    @Test // userid= 0 = >userid not exist
    public void testUserIdIsNotExist() {
        userid= "0";
        int user_id= Integer.parseInt(userid);
        assertTrue("userid is not exist",user_id== 0);
    }
    
    @Test // userid >=1, commentid= null = > commentid is not an integer
    public void testCommentIdIsNotAnInteger() {
        userid = "1";
        int user_id= Integer.parseInt(userid);
        boolean checkcommenidisnotexist_and_useridgreaterthanzero = false;
        if((commentid== null || commentid.isEmpty())&&(user_id>= 1 )) {
            checkcommenidisnotexist_and_useridgreaterthanzero= true;
        }
        assertTrue("userid is not an integer",checkcommenidisnotexist_and_useridgreaterthanzero);
    }
    @Test //commentid= 0,userid >=1  comment is not exist
    public void testCommentIdIsNotExist() {
        userid = "1";
        commentid= "0";
        int user_id= Integer.parseInt(userid);
        int comment_id= Integer.parseInt(commentid);
        boolean checkcommenidisequalzero_and_useridgreaterthanzero = false;
        if((comment_id==0 )&&(user_id>=1 )) {
            checkcommenidisequalzero_and_useridgreaterthanzero= true;
        }
        assertTrue("commentid is not exist",checkcommenidisequalzero_and_useridgreaterthanzero);
    }
    @Test //success userid= 1,commentid= 1
    public void testCommentIdIsGreaterThanZeroAndUserIdGreaterThanZero() {
        userid = "1";
        commentid= "1";
        int user_id= Integer.parseInt(userid);
        int comment_id= Integer.parseInt(commentid);
        boolean checkcommentid_is_greaterthanzero_and_userid_greaterthanzero = false;
        if((comment_id>= 1)&&(user_id>= 1 )) {
            checkcommentid_is_greaterthanzero_and_userid_greaterthanzero= true;
        }
        assertTrue("success",checkcommentid_is_greaterthanzero_and_userid_greaterthanzero);
    }
    //userid>= 1, newid =null   => newsid is not an integer
    @Test
    public void testNewsIdIsNotInteger() {
        userid= "1";
        int user_id= Integer.parseInt(userid);
        boolean checkuseridis_greaterthan_one_and_newsid_isempty = false;
        if((newsid== null || newsid.isEmpty())&&(user_id>=1)) {
            checkuseridis_greaterthan_one_and_newsid_isempty = true;
        }
         assertTrue("Newsid is not an integer",checkuseridis_greaterthan_one_and_newsid_isempty);
    }
    //newid is not exist, newsid= 0, userid>= 1 
    @Test
    public void testNewsIdIsNotExist() {
        userid= "1";
        newsid= "0";
        int news_id= Integer.parseInt(newsid);
        int user_id= Integer.parseInt(userid);
        boolean checkuseridis_greaterthan_one_and_newsid_isequalzero = false;
        if((news_id== 0)&&(user_id >= 1)) {
            checkuseridis_greaterthan_one_and_newsid_isequalzero = true;
        }
         assertTrue("Newsid is not an integer",checkuseridis_greaterthan_one_and_newsid_isequalzero);
    }
    //newsid>=1, userid>= 1 => Success
    @Test
    public void testSuccessNewsIdGreaterThanOneAndUserIdGreaterThanOne() {
        userid= "1";
        newsid= "1";
        int news_id= Integer.parseInt(newsid);
        int user_id= Integer.parseInt(userid);
        boolean checksuccess_newsid_greaterthanone_and_userid_greaterthanOne = false;
        if((news_id>= 1)&&(user_id >= 1)) {
            checksuccess_newsid_greaterthanone_and_userid_greaterthanOne = true;
        }
         assertTrue("Success",checksuccess_newsid_greaterthanone_and_userid_greaterthanOne);
    }
}
