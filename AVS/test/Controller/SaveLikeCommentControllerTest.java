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
public class SaveLikeCommentControllerTest {

    public SaveLikeCommentControllerTest() {
    }
    protected String actualuserid;
    protected String actualcommentid;
    protected String actualnewsid;

    //userid is null or empty; => userid is not an integer
    @Test
    public void testUserIdIsNullOrEmpty() {
        assertTrue("userid is not an integer", actualuserid == null || actualuserid.isEmpty());
    }

    //userid= 0; userid is not exsist
    @Test
    public void testUserIdIsEqualZero() {
        actualuserid = "0";
        int expecteduserid = 0;
        int actual_userid = Integer.parseInt(actualuserid);
        assertEquals("Userid is not exist", expecteduserid, actual_userid);
    }

    //userid >= 1;commentid =null=> Is not an integer
    @Test
    public void testUserIdIsGreaterThanZeroAndCommentIdIsNull() {
        actualuserid = "1";
        int expecteduserid = 1;
        int actual_userid = Integer.parseInt(actualuserid);

        assertTrue("Is not an integer", (actual_userid >= expecteduserid) && (actualcommentid == null || actualcommentid.isEmpty()));
    }

    //userid >= 1; commentid is Zero
    @Test
    public void testUserIdIsGreaterThanZeroAndCommentIdIsZero() {
        actualuserid = "1";
        int actual_userid = Integer.parseInt(actualuserid);
        int expecteduserid = 1;
        actualcommentid = "0";
        int expectedcommentid = 0;
        int actual_commentid = Integer.parseInt(actualcommentid);
        assertTrue("Not exist", (actual_userid >= expecteduserid) && (actual_commentid == expectedcommentid));
    }

    //userid >= 1; commentid >=1 => success
    @Test
    public void testUserIdIsGreaterThanZeroAndCommentIdIsGreaterThanZero() {

        actualuserid = "1";
        int actual_userid = Integer.parseInt(actualuserid);
        int expecteduserid = 1;
        actualcommentid = "1";
        int expectedcommentid = 1;
        int actual_commentid = Integer.parseInt(actualcommentid);
        assertTrue("Success", (actual_userid >= expecteduserid) && (actual_commentid == expectedcommentid));
        //   assertTrue("comment id is null",(actual_userid>= expecteduserid) && (actualcommentid==null || actualcommentid.isEmpty()));
    }

    //userid >= 1, newsid = null= > is not an integer
    @Test
    public void testUserIdIsGreaterThanZeroAndNewsIdIsNull() {
        actualuserid = "1";
        int actual_userid = Integer.parseInt(actualuserid);
        int expecteduserid = 1;
        assertTrue("is not an integer", (actual_userid >= expecteduserid) && (actualnewsid == null || actualnewsid.isEmpty()));
    }

    //userid >= 1, newsid = 0 = > Not exist
    @Test
    public void testUserIdIsGreaterThanZeroAndNewsIdIsZero() {
        actualuserid = "1";
        int actual_userid = Integer.parseInt(actualuserid);
        int expecteduserid = 1;
        actualnewsid = "0";
        int expectactualnewsid = 0;
        int actual_newsid = Integer.parseInt(actualnewsid);
        assertTrue("is not an integer", (actual_userid >= expecteduserid) && (actual_newsid == expectactualnewsid));
    }

    //userid >= 1; newsid >=1 => success

    @Test
    public void testUserIdIsGreaterThanZeroAndNewsIdIsGreaterThanZero() {
        actualuserid = "1";
        int actual_userid = Integer.parseInt(actualuserid);
        actualnewsid = "1";
        int actual_newsid = Integer.parseInt(actualnewsid);
        assertTrue("Success", (actual_userid >= 1) && (actual_newsid == 1));
    }
}
