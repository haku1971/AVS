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
public class CommentControllerTest {

    public CommentControllerTest() {
    }

    protected String newsid = "";

    @Before
    public void setUp() {
    }

    @Test
    public void testNewsIdIsEmptyOrNull() {
        assertTrue("new id is not an integer", newsid == null || newsid.isEmpty());
    }

    @Test
    public void testNewsIdIsEqualZero() {
        newsid = "0";
        assertTrue("new not exist ", Integer.parseInt(newsid) == 0);
    }

    @Test
    public void testNewsIdIsBiggerThanZero() {
        newsid = "1";
        assertTrue("Success ", Integer.parseInt(newsid) >= 1);
    }
}
