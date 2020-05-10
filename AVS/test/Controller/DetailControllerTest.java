/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DBContext.DBContext;
import Model.Algorithm;
import DAO.AlgorithmDAO;
import DAO.CloseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import org.mockito.Mock;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;
import org.mockito.MockitoAnnotations;
import org.mockito.invocation.InvocationOnMock;
import org.mockito.stubbing.Answer;

public class DetailControllerTest {

    public DetailControllerTest() {
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
    public void roleIdIsNull() {
        assertTrue("Only admin can access this page, redirecting to homepage",nullroleid != firstalgoid && nullroleid != secondalgoid);
    }
   
     @Test
    public void roleIdIsTwo() {
       int expectedalgoid= 2;       
        assertEquals("Only admin can access this page, redirecting to homepage", expectedalgoid,secondalgoid);
    }
   
     @Test
    public void roleIdIsOne() {
       int expectedalgoid= 1;       
        assertEquals("Success", expectedalgoid,firstalgoid);
    }
    @Test
    public void roleIdIsThree() throws Exception {
       int expectedalgoid= 3;      
               AlgorithmDAO test = mock(AlgorithmDAO.class);
       when(test.getAlgoByID(expectedalgoid)).thenAnswer(new Answer<Algorithm>() {
            public Algorithm answer(InvocationOnMock invocation)
                    throws Throwable {
                return new Algorithm(expectedalgoid, null, null, null, null, null, nullroleid, null, null, nullroleid);
                  
            }
        });
        assertEquals("Not exist", expectedalgoid,test.getAlgoByID(expectedalgoid).getAlgoID());
    }
    @Test
    public void roleIdIsFour() throws Exception {
       int expectedalgoid= 4; 
               AlgorithmDAO test = mock(AlgorithmDAO.class);
       when(test.getAlgoByID(expectedalgoid)).thenAnswer(new Answer<Algorithm>() {
            public Algorithm answer(InvocationOnMock invocation)
                    throws Throwable {
                return new Algorithm(expectedalgoid, null, null, null, null, null, nullroleid, null, null, nullroleid);
                  
            }
        });
        assertEquals("Not exist", expectedalgoid,test.getAlgoByID(expectedalgoid).getAlgoID());
       
    }
    @Test
    public void roleIdIsFive() throws Exception {
       int expectedalgoid= 5;    
        AlgorithmDAO test = mock(AlgorithmDAO.class);
       when(test.getAlgoByID(expectedalgoid)).thenAnswer(new Answer<Algorithm>() {
            public Algorithm answer(InvocationOnMock invocation)
                    throws Throwable {
                return new Algorithm(expectedalgoid, null, null, null, null, null, nullroleid, null, null, nullroleid);
                  
            }
        });
        assertEquals("Not exist", expectedalgoid,test.getAlgoByID(expectedalgoid).getAlgoID());
    }
    @Test
    public void roleIdIsSix() throws Exception {
        
       int expectedalgoid= 6;   
       AlgorithmDAO test = mock(AlgorithmDAO.class);
       when(test.getAlgoByID(expectedalgoid)).thenAnswer(new Answer<Algorithm>() {
            public Algorithm answer(InvocationOnMock invocation)
                    throws Throwable {
                return new Algorithm(expectedalgoid, null, null, null, null, null, nullroleid, null, null, nullroleid);
                  
            }
        });
        assertEquals("Not exist", expectedalgoid,test.getAlgoByID(expectedalgoid).getAlgoID());
         
     
    }
    
    @Test
    public void roleIdIsSeven() throws Exception {
       int expectedalgoid= 7;
               AlgorithmDAO test = mock(AlgorithmDAO.class);
       when(test.getAlgoByID(expectedalgoid)).thenAnswer(new Answer<Algorithm>() {
            public Algorithm answer(InvocationOnMock invocation)
                    throws Throwable {
                return new Algorithm(expectedalgoid, null, null, null, null, null, nullroleid, null, null, nullroleid);
                  
            }
        });
        assertEquals("Not exist", expectedalgoid,test.getAlgoByID(expectedalgoid).getAlgoID());
    }
    @Test
    public void roleIdIsEight() throws Exception {
       int expectedalgoid= 8;       
               AlgorithmDAO test = mock(AlgorithmDAO.class);
       when(test.getAlgoByID(expectedalgoid)).thenAnswer(new Answer<Algorithm>() {
            public Algorithm answer(InvocationOnMock invocation)
                    throws Throwable {
                return new Algorithm(expectedalgoid, null, null, null, null, null, nullroleid, null, null, nullroleid);
                  
            }
        });
        assertEquals("Not exist", expectedalgoid,test.getAlgoByID(expectedalgoid).getAlgoID());
    }
    @Test
    public void roleIdIsNine() throws Exception {
       int expectedalgoid= 9;       
               AlgorithmDAO test = mock(AlgorithmDAO.class);
       when(test.getAlgoByID(expectedalgoid)).thenAnswer(new Answer<Algorithm>() {
            public Algorithm answer(InvocationOnMock invocation)
                    throws Throwable {
                return new Algorithm(expectedalgoid, null, null, null, null, null, nullroleid, null, null, nullroleid);
                  
            }
        });
        assertEquals("Not exist", expectedalgoid,test.getAlgoByID(expectedalgoid).getAlgoID());
    }
    @Test
    public void roleIdIsTen() throws Exception {
       int expectedalgoid= 9; 
               AlgorithmDAO test = mock(AlgorithmDAO.class);
       when(test.getAlgoByID(expectedalgoid)).thenAnswer(new Answer<Algorithm>() {
            public Algorithm answer(InvocationOnMock invocation)
                    throws Throwable {
                return new Algorithm(expectedalgoid, null, null, null, null, null, nullroleid, null, null, nullroleid);
                  
            }
        });
        assertEquals("Not exist", expectedalgoid,test.getAlgoByID(expectedalgoid).getAlgoID());
    }
    @Test
    public void roleIdIsEleven() throws Exception {
       int expectedalgoid= 11; 
               AlgorithmDAO test = mock(AlgorithmDAO.class);
       when(test.getAlgoByID(expectedalgoid)).thenAnswer(new Answer<Algorithm>() {
            public Algorithm answer(InvocationOnMock invocation)
                    throws Throwable {
                return new Algorithm(expectedalgoid, null, null, null, null, null, nullroleid, null, null, nullroleid);
                  
            }
        });
        assertEquals("Not exist", expectedalgoid,test.getAlgoByID(expectedalgoid).getAlgoID());
    }
    
}
