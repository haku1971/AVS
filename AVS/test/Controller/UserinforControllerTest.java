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
public class UserinforControllerTest {
    
    public UserinforControllerTest() {
    }
    protected String cookies[]= {"duongph"};
    @Before
    public void setUp() {
     
    }
    @Test
    public void testCookiesIsNull() {
        cookies= null;
        assertArrayEquals("user loged out, returning to homepage..",null, cookies);
    }
    @Test
    public void testCookiesIsNotNull() {   
        assertTrue(cookies!= null);
    }

}
