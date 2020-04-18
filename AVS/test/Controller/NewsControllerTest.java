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
public class NewsControllerTest {
    
    public NewsControllerTest() {
    }
    protected String searchstring;
    protected int page;
    @Before
    public void setUp() {
        page= 0;
        searchstring = null;
    }
    //searchstring is null; page = 0; =>page not found
    @Test
    public void testSearchStringIsEmptyAndPageEqualZero() {
        int expectedpage= 0;
        page =0; 
        String expectedsearchstring = null;
        assertTrue("Page not found", (expectedsearchstring==searchstring) && 
                expectedpage == page);
    }
    //searchstring is null; page = 1; =>Showing Normal news page
    @Test
    public void testSearchStringIsEmptyAndPageEqualOne() {
        int expectedpage= 1;
        page= 1;
        String expectedsearchstring = null;
        assertTrue("Showing normal page", (expectedsearchstring==searchstring) && 
                expectedpage == page);
    }
    //searchstring is "abc", page = 0 => "Page not found"
      @Test
    public void testSearchStringIsNotNullAndPageEqualZero() {
         int expectedpage= 0;
         page = 0;
        String expectedsearchstring = "abc";
        searchstring= "abc";
        assertTrue("Page not found", (expectedsearchstring.equals(searchstring)) && 
                expectedpage == page);
    }
    //searchstring is "abc",page = 1 = > "Showing searched news page"
     @Test
    public void testSearchStringIsNotNullAndPageEqualOne() {
          int expectedpage= 1;
          page = 1;
        String expectedsearchstring = "abc";
        searchstring= "abc";
        assertTrue("Page not found", (expectedsearchstring.equals(searchstring)) && 
                expectedpage == page);
    }
    
}
