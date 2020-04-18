/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author quang
 */
public class AddAlgorithmControllerTest {

    public AddAlgorithmControllerTest() {
    }
    protected int nullroleid;
    protected int firstroleid;
    protected int secondroleid;

    @Before
    public void setUp() {
        firstroleid = 1;
        secondroleid = 2;
    }

    @Test
    public void roleIdIsNull() {
        assertTrue("Only admin can access this page, redirecting to homepage",nullroleid != firstroleid && nullroleid != secondroleid);
    }
   
     @Test
    public void roleIdIsTwo() {
       int expectedroleid= 2;       
        assertEquals("Only admin can access this page, redirecting to homepage", expectedroleid,secondroleid);
    }
     @Test
    public void roleIdIsOne() {
       int expectedroleid= 1;       
        assertEquals("Success", expectedroleid,firstroleid);
    }
}
