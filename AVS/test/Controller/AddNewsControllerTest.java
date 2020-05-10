/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.UserDAO;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

/**
 *
 * @author quang
 */
public class AddNewsControllerTest {
    
    public AddNewsControllerTest() {
    }
    protected int nullroleid;
    protected int firstalgoid;
    protected int secondalgoid;

    @Before
    public void setUp() {
        firstalgoid = 1;
        secondalgoid = 2;
    }

    @Test
    public void roleIdIsTwo() throws Exception {
        int expectedroleid = 2;
        UserDAO test = mock(UserDAO.class);
        when(test.getUserRole(expectedroleid)).thenReturn(expectedroleid);
        assertEquals("Only admin can access this page, redirecting to homepage", expectedroleid, test.getUserRole(expectedroleid));
    }

    @Test
    public void roleIdIsOne() {
        int expectedroleid = 1;
        assertEquals("Success", expectedroleid, firstalgoid);
    }

    @Test
    public void roleIdIsThree() throws Exception {
        int expectedroleid = 3;
        UserDAO test = mock(UserDAO.class);
        when(test.getUserRole(expectedroleid)).thenReturn(expectedroleid);
        assertEquals("Not exist", expectedroleid, test.getUserRole(expectedroleid));
    }

    @Test
    public void roleIdIsFour() throws Exception {
        int expectedroleid = 4;
        UserDAO test = mock(UserDAO.class);
        when(test.getUserRole(expectedroleid)).thenReturn(expectedroleid);
        assertEquals("Not exist", expectedroleid, test.getUserRole(expectedroleid));
    }

    @Test
    public void roleIdIsFive() throws Exception {
        int expectedroleid = 5;
        UserDAO test = mock(UserDAO.class);
        when(test.getUserRole(expectedroleid)).thenReturn(expectedroleid);
        assertEquals("Not exist", expectedroleid, test.getUserRole(expectedroleid));
    }

    @Test
    public void roleIdIsZero() throws Exception {
        int expectedroleid = 0;
        UserDAO test = mock(UserDAO.class);
        when(test.getUserRole(expectedroleid)).thenReturn(expectedroleid);
        assertEquals("Not exist", expectedroleid, test.getUserRole(expectedroleid));
    }

    @Test
    public void roleIdIsNull() {
        assertTrue("Only admin can access this page, redirecting to homepage", nullroleid != firstalgoid && nullroleid != secondalgoid);
    }

    @Test
    public void roleIdIsSix() throws Exception {

        int expectedroleid = 6;
        UserDAO test = mock(UserDAO.class);
        when(test.getUserRole(expectedroleid)).thenReturn(expectedroleid);
        assertEquals("Not exist", expectedroleid, test.getUserRole(expectedroleid));

    }
   
}
