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
public class AdminControllerTest {

    public AdminControllerTest() {
    }
    protected int nullroleid;
    protected int firstroleid;
    protected int secondroleid;
    protected String category;

    protected String actualcategory;

    @Before
    public void setUp() {
        firstroleid = 1;
        secondroleid = 2;
        category= "";

    }

    @Test
    public void isNotAdminWithSecondRoleID() {
       int expectedroleid= 2; 
        boolean isnotadminwithsecondroleid = false;
        if ((expectedroleid == secondroleid)) {
            isnotadminwithsecondroleid = true;
        }
        assertTrue("Only admin can access this page, redirecting to homepage", isnotadminwithsecondroleid);
    }
    @Test
    public void isNotAdminWithNullRoleID() {
       
        boolean isnotadminwithnullroleid = false;
        if ((nullroleid != firstroleid || nullroleid != secondroleid)) {
            isnotadminwithnullroleid = true;
        }
        assertTrue("Only admin can access this page, redirecting to homepage", isnotadminwithnullroleid);
    }
    @Test
    public void testPageNotExist() {
        actualcategory = "abcabc";
        category= "abcabc";
        boolean ispagenotexist = false;
        if ((1 == firstroleid) && (category.equals(actualcategory))) {
            ispagenotexist = true;
        }
        assertTrue("This Page Does not exist", ispagenotexist);
    }

    @Test
    public void testAccessWithRoleIdAndCategoryIsAlgorithm() {
        actualcategory = "algorithm";
         category= "algorithm";
        int expectedroleid = 1;
        boolean is_firstroleid_and_category_is_algorithm = false;
        if ((expectedroleid == firstroleid) && category.equals(actualcategory)) {
            is_firstroleid_and_category_is_algorithm = true;
        }
        assertTrue("Not Success", is_firstroleid_and_category_is_algorithm);
    }
  
    @Test
    public void testAccessWithRoleIdAndCategoryIsNews() {
        actualcategory = "news";
         category= "news";
        int expectedroleid = 1;
        boolean is_firstroleid_and_category_is_news = false;
        if ((expectedroleid == firstroleid) && category.equals(actualcategory)) {
            is_firstroleid_and_category_is_news = true;
        }
        assertTrue("Not Success", is_firstroleid_and_category_is_news);
    }

    @Test
    public void testAccessWithRoleIdAndCategoryIsUserHistory() {
        actualcategory = "user_history";
         category= "user_history";
        int expectedroleid = 1;
        boolean is_firstroleid_and_category_is_user_history = false;
        if ((expectedroleid == firstroleid) && category.equals(actualcategory)) {
            is_firstroleid_and_category_is_user_history = true;
        }
        assertTrue("Not Success", is_firstroleid_and_category_is_user_history);
    }

    @Test
    public void testAccessWithRoleIdAndCategoryIsAlgoHistory() {
        actualcategory = "algo_history";
        category= "algo_history";
        int expectedroleid = 1;
        boolean is_firstroleid_and_category_is_algo_history = false;
        if ((expectedroleid == firstroleid) && category.equals(actualcategory)) {
            is_firstroleid_and_category_is_algo_history = true;
        }
        assertTrue("Not Success", is_firstroleid_and_category_is_algo_history);
    }

    @Test
    public void testAccessWithRoleIdAndCategoryIsNewsHistory() {
        actualcategory = "news_history";
        category = "news_history";
        int expectedroleid = 1;
        boolean is_firstroleid_and_category_is_news_history = false;
        if ((expectedroleid == firstroleid) && category.equals(actualcategory)) {
            is_firstroleid_and_category_is_news_history = true;
        }
        assertTrue("Not Success", is_firstroleid_and_category_is_news_history);
    }
    
    @Test
    public void testAccessWithRoleIdAndCategoryIsTracking() {
        actualcategory = "tracking";
        category = "tracking";
        int expectedroleid = 1;
        boolean is_firstroleid_and_category_is_tracking = false;
        if ((expectedroleid == firstroleid) && category.equals(actualcategory)) {
            is_firstroleid_and_category_is_tracking = true;
        }
        assertTrue("Not Success", is_firstroleid_and_category_is_tracking);
    }
    
    @Test
    public void testAccessWithRoleIdAndCategoryIsNull() {
        actualcategory = "";
          category = "";
        int expectedroleid = 1;
        boolean is_firstroleid_and_category_is_null = false;
        if ((expectedroleid == firstroleid) && category.equals(actualcategory)) {
            is_firstroleid_and_category_is_null = true;
        }
        assertTrue("Not Success", is_firstroleid_and_category_is_null);
    }
    
     @Test
    public void testAccessWithRoleIdAndCategoryIsAccount() {
        actualcategory = "account";
        category = "account";
        int expectedroleid = 1;
        boolean is_firstroleid_and_category_is_account = false;
        if ((expectedroleid == firstroleid) && category.equals(actualcategory)) {
            is_firstroleid_and_category_is_account = true;
        }
        assertTrue("Not Success", is_firstroleid_and_category_is_account);
    }
}
