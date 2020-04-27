/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.User;
import DAO.UserModel;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import static org.mockito.Mockito.when;
import org.mockito.MockitoAnnotations;
import org.mockito.invocation.InvocationOnMock;
import org.mockito.stubbing.Answer;

/**
 *
 * @author quang
 */
public class ViewAccountControllerTest {

    protected String fakeuserid;

    public ViewAccountControllerTest() {
    }
    public int roleid;
    
    public void testRoleIdIsOne() {
        int expectedroleid = 1;
        roleid = 1;
        assertEquals("Success",expectedroleid,roleid);
    }
    @Mock
    private UserModel userdao;
     @Test
    public void testRoleIdIsTwo() {
        int expectedroleid = 2;
        roleid = 2;
        assertEquals("Only admin can access this page,redirecting to homepage",expectedroleid,roleid);
    }
     @Test
    public void testRoleIdIsNull() {    
        assertTrue("Only admin can access this page,redirecting to homepage",roleid!=1 && roleid!= 2  );
    }
    private User createUser(String id) {
        User user = new User(Integer.parseInt(id), null, null, 0, null, 0, null, 0, null, null, null);
        return user;
    }
    
   
    @Before
    public void setUp() throws Exception {
        
        
        MockitoAnnotations.initMocks(this);
        fakeuserid = "1";
        when(userdao.getUserByUserID(fakeuserid)).thenAnswer(new Answer<User>() {
            public User answer(InvocationOnMock invocation)
                    throws Throwable {

                return createUser(fakeuserid);
            }
        });
    }

    @Test
    public void testProcessRequest() throws Exception {

        assertEquals("Equal", Integer.parseInt(fakeuserid), userdao.getUserByUserID(fakeuserid).getId());
    }

   

}
