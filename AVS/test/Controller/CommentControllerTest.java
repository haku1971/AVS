/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.NewsDAO;
import DAO.UserDAO;
import Model.Algorithm;
import Model.News;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;
import org.mockito.invocation.InvocationOnMock;
import org.mockito.stubbing.Answer;

/**
 *
 * @author quang
 */
public class CommentControllerTest {

    public CommentControllerTest() {
    }

    protected int newsid;

    @Before
    public void setUp() {
        newsid = 1;
    }

    @Test
    public void newsIdIsTwo() throws Exception {
        int expectednewsid = 2;
        NewsDAO test = mock(NewsDAO.class);
        when(test.getNewsByID(expectednewsid)).thenAnswer(new Answer<News>() {
            public News answer(InvocationOnMock invocation)
                    throws Throwable {
                return new News(expectednewsid, null, null, null, null, null, null, newsid);

            }
        });
        assertEquals("Only admin can access this page, redirecting to homepage", expectednewsid, test.getNewsByID(expectednewsid).getNewsID());
    }

    @Test
    public void newsIdIsOne() throws Exception {
        int expectednewsid = 1;
        NewsDAO test = mock(NewsDAO.class);
        when(test.getNewsByID(expectednewsid)).thenAnswer(new Answer<News>() {
            public News answer(InvocationOnMock invocation)
                    throws Throwable {
                return new News(expectednewsid, null, null, null, null, null, null, newsid);

            }
        });
        assertEquals("Success", expectednewsid, test.getNewsByID(expectednewsid).getNewsID());
    }

    @Test
    public void newsIdIsThree() throws Exception {
        int expectednewsid = 3;

        NewsDAO test = mock(NewsDAO.class);
        when(test.getNewsByID(expectednewsid)).thenAnswer(new Answer<News>() {
            public News answer(InvocationOnMock invocation)
                    throws Throwable {
                return new News(expectednewsid, null, null, null, null, null, null, newsid);

            }
        });
        assertEquals("Not exist", expectednewsid, test.getNewsByID(expectednewsid).getNewsID());

    }

    @Test
    public void newsIdIsFour() throws Exception {
        int expectednewsid = 4;
        NewsDAO test = mock(NewsDAO.class);
        when(test.getNewsByID(expectednewsid)).thenAnswer(new Answer<News>() {
            public News answer(InvocationOnMock invocation)
                    throws Throwable {
                return new News(expectednewsid, null, null, null, null, null, null, newsid);

            }
        });
        assertEquals("Not exist", expectednewsid, test.getNewsByID(expectednewsid).getNewsID());

    }

    @Test
    public void newsIdIsFive() throws Exception {
        int expectednewsid = 5;
        NewsDAO test = mock(NewsDAO.class);
        when(test.getNewsByID(expectednewsid)).thenAnswer(new Answer<News>() {
            public News answer(InvocationOnMock invocation)
                    throws Throwable {
                return new News(expectednewsid, null, null, null, null, null, null, newsid);

            }
        });
        assertEquals("Not exist", expectednewsid, test.getNewsByID(expectednewsid).getNewsID());

    }

    @Test
    public void newsIdIsZero() throws Exception {
        int expectednewsid = 0;
        NewsDAO test = mock(NewsDAO.class);
        when(test.getNewsByID(expectednewsid)).thenAnswer(new Answer<News>() {
            public News answer(InvocationOnMock invocation)
                    throws Throwable {
                return new News(expectednewsid, null, null, null, null, null, null, newsid);

            }
        });
        assertEquals("Not exist", expectednewsid, test.getNewsByID(expectednewsid).getNewsID());

    }

    @Test
    public void newsIdIsNull() throws Exception {
        int expectednewsid = 0;
        NewsDAO test = mock(NewsDAO.class);
        when(test.getNewsByID(expectednewsid)).thenAnswer(new Answer<News>() {
            public News answer(InvocationOnMock invocation)
                    throws Throwable {
                return new News(expectednewsid, null, null, null, null, null, null, newsid);

            }
        });
        assertEquals("Not exist", expectednewsid, test.getNewsByID(expectednewsid).getNewsID());

    }

    @Test
    public void newsIdIsSix() throws Exception {
        int expectednewsid = 6;
        NewsDAO test = mock(NewsDAO.class);
        when(test.getNewsByID(expectednewsid)).thenAnswer(new Answer<News>() {
            public News answer(InvocationOnMock invocation)
                    throws Throwable {
                return new News(expectednewsid, null, null, null, null, null, null, newsid);

            }
        });
        assertEquals("Not exist", expectednewsid, test.getNewsByID(expectednewsid).getNewsID());

    }
}
