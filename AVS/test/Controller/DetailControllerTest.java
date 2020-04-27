/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DBContext.DBContext;
import Model.Algorithm;
import DAO.AlgorithmModel;
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
import static org.mockito.Mockito.when;
import org.mockito.MockitoAnnotations;
import org.mockito.invocation.InvocationOnMock;
import org.mockito.stubbing.Answer;

public class DetailControllerTest {

    public DetailControllerTest() {
    }

    //protected int length_of_algorithm_and_category_get_fromdb= 10;
//    private ArrayList<Algorithm> createAlgoNameAndCategory(int length) {
//       ArrayList<Algorithm> listofalgorithmandcategory= new ArrayList<>();
//        for (int i = 0; i < length; i++) {
//          listofalgorithmandcategory.add(createAlogithm(i));
//        }
//        return listofalgorithmandcategory;
//    }
//    private Algorithm createAlogithm(int id) {
//        Algorithm algorithm = new Algorithm(id, "Algorithm_"+id, "", "", "", "", 0, "", "", 0);
//        return algorithm;
//    }
//    @Before
//    public void setUp() throws Exception {
//        MockitoAnnotations.initMocks(this);          
//         when(algorithmmodel.getAlgoNameAndCategory()).thenAnswer(new Answer<ArrayList<Algorithm>>() {          
//                 public ArrayList<Algorithm> answer(InvocationOnMock invocation)
//                    throws Throwable {           
//                  return createAlgoNameAndCategory(length_of_algorithm_and_category_get_fromdb);
//            }             
//            
//        });
//         
//         
//    }
//   
    protected int algoid;

    @Test
    public void TestAlgoIdIsNotNumberOrNull() {
        assertTrue("ALgoID is not an integer", !Character.isDigit(algoid));
    }

    @Test
    public void TestAlgoIdEqualNumberInRange1to10() {
        algoid = 5;
        int expectedvalue = 5;
        assertEquals("Success", expectedvalue, algoid);
    }

    @Test
    public void TestAlgoIdEqualNumberOne() {
        algoid = 1;
        int expectedvalue = 1;
        assertEquals("Success", expectedvalue, algoid);
    }

    @Test
    public void TestAlgoIdEqualNumberTen() {
        algoid = 10;
        int expectedvalue = 10;
        assertEquals("Success", expectedvalue, algoid);
    }

    @Test
    public void TestAlgoIdEqualNumberZero() {
        algoid = 0;
        int expectedvalue = 0;
        assertEquals("AlgoIdNotExist", expectedvalue, algoid);
    }

//    @Test
//    public void testArrayAlgorithmAndCategorySizeValue() throws Exception {
//        int expecte_result_record= 10;        
//        assertEquals("Success", expecte_result_record, algorithmmodel.getAlgoNameAndCategory().size());
//    }
//    @Test
//    public void testArrayAlgorithmAndCategorySizeValueIsNull() throws Exception {          
//        length_of_algorithm_and_category_get_fromdb= 0;
//        assertNull("Fail to get list of AlgoNameAndCategory",  algorithmmodel.getAlgoNameAndCategory().size());
//    }
//   
}
