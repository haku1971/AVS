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
public class DeleteCommentServletTest {
    
    public DeleteCommentServletTest() {
    }
    
    protected String commentid = "";

    @Before
    public void setUp() {
    }

    @Test
    public void testNewsIdIsEmptyOrNull() {
        assertTrue("Comment id is not an integer", commentid == null || commentid.isEmpty());
    }

    @Test
    public void testNewsIdIsEqualZero() {
        commentid = "0";
        assertTrue("Comment not exist ", Integer.parseInt(commentid) == 0);
    }

    @Test
    public void testNewsIdIsBiggerThanZero() {
        commentid = "1";
        assertTrue("Success ", Integer.parseInt(commentid) >= 1);
    }
    
}
