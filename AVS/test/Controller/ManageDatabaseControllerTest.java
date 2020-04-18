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
public class ManageDatabaseControllerTest {
    
    public ManageDatabaseControllerTest() {
    }
    protected int nullroleid;
    protected int firstroleid;
    protected int secondroleid;
    protected String managetype;
    @Before
    public void setUp() {
        firstroleid= 1;
        secondroleid= 2;       
       managetype = ""; 
    }
    //only admin can access this page roleid =null; 
    @Test
    public void testRoleIdIsNull() {
        assertTrue("Only admin can access this page,redirect to home page", 
                nullroleid != firstroleid && nullroleid != secondroleid);
    }
    //only admin can access this page, roleid = 2
   @Test
    public void testRoleIdIsTwo() {
        int expectedroleid= 2;
        assertTrue("Only admin can access this page,redirect to home page", 
                expectedroleid == secondroleid);
    }
    //success, roleid= 1, managetype= "manageaccount"
    @Test
    public void testRoleIdIsOneAndManageTypeIsMangeAccount() {
        int expectedroleid= 1;
        managetype= "manageaccount";
        String expectedmangetype= "manageaccount";
        assertTrue("Only admin can access this page,redirect to home page",expectedroleid==firstroleid
                &&expectedmangetype.equals(managetype) );
    }
    //success, roleid= 1, managetype= "addalgo";
       @Test
    public void testRoleIdIsOneAndManageTypeIsAddalgo() {
        int expectedroleid= 1;
        managetype= "addalgo";
        String expectedmangetype= "addalgo";
        assertTrue("Success",expectedroleid==firstroleid
                &&expectedmangetype.equals(managetype) );
    }
    //success , roleid= 1, managetype= "editalgo"
      @Test
    public void testRoleIdIsOneAndManageTypeIsEditalgo() {
        int expectedroleid= 1;
        managetype= "editalgo";
        String expectedmangetype= "editalgo";
        assertTrue("Success",expectedroleid==firstroleid
                &&expectedmangetype.equals(managetype) );
    }
    //success , roleid= 1, managetype= "deletealgo"
      @Test
    public void testRoleIdIsOneAndManageTypeIsDeletealgo() {
        int expectedroleid= 1;
        managetype= "deletealgo";
        String expectedmangetype= "deletealgo";
        assertTrue("Success",expectedroleid==firstroleid
                &&expectedmangetype.equals(managetype) );
    }
    //success , roleid= 1,managetype= "restorealgo";
      @Test
    public void testRoleIdIsOneAndManageTypeIsRestorealgo() {
        int expectedroleid= 1;
        managetype= "restorealgo";
        String expectedmangetype= "restorealgo";
        assertTrue("Success",expectedroleid==firstroleid
                &&expectedmangetype.equals(managetype) );
    }
   // success , roleid= 1,managetype = "addnews"
      @Test
    public void testRoleIdIsOneAndManageTypeIsAddnews() {
        int expectedroleid= 1;
        managetype= "addnews";
        String expectedmangetype= "addnews";
        assertTrue("Success",expectedroleid==firstroleid
                &&expectedmangetype.equals(managetype) );
    }
    //success , roleid= 1,managetype= "editnews"
     @Test
    public void testRoleIdIsOneAndManageTypeIsEditnews() {
        int expectedroleid= 1;
        managetype= "editnews";
        String expectedmangetype= "editnews";
        assertTrue("Success",expectedroleid==firstroleid
                &&expectedmangetype.equals(managetype) );
    }
    //success , roleid= 1,, managetype= "deletenews"
    @Test
    public void testRoleIdIsOneAndManageTypeIsDeletenews() {
        int expectedroleid= 1;
        managetype= "deletenews";
        String expectedmangetype= "deletenews";
        assertTrue("Success",expectedroleid==firstroleid
                &&expectedmangetype.equals(managetype) );
    }
    //success , roleid= 1,managetype= "restorenews"
    @Test
    public void testRoleIdIsOneAndManageTypeIsRestorenews() {
        int expectedroleid= 1;
        managetype= "restorenews";
        String expectedmangetype= "restorenews";
        assertTrue("Success",expectedroleid==firstroleid
                &&expectedmangetype.equals(managetype) );
    }
}
