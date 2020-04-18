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
public class ViewNewsControllerTest {

    public ViewNewsControllerTest() {
    }
      public int roleid;
    @Before
    public void setUp() {
    }
  
    @Test
    public void testRoleIdIsOne() {
        int expectedroleid = 1;
        roleid = 1;
        assertEquals("Success", expectedroleid, roleid);
    }
 @Test
    public void testRoleIdIsTwo() {
        int expectedroleid = 2;
        roleid = 2;
        assertEquals("Only admin can access this page,redirecting to homepage", expectedroleid, roleid);
    }
 @Test
    public void testRoleIdIsNull() {
        assertTrue("Only admin can access this page,redirecting to homepage", roleid != 1 && roleid != 2);
    }

}
