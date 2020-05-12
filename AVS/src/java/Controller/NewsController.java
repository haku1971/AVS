/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.News;
import DAO.NewsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author quang
 */
public class NewsController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String username = "";
        if (request.getCookies() != null) {
            Cookie cookie[] = request.getCookies();
            int agecookie = cookie[0].getMaxAge();
            int cookienum = 0;
            while (cookienum < cookie.length) {

                if (cookie[cookienum].getName().equals("username")) {
                    username = cookie[cookienum].getValue();
                }
                cookienum++;
            }

        }
        if (username.equals("anon")) {

            response.sendRedirect("/AVS/inputusername");
        } else {
            try {
                NewsDAO newsmodeldao = new NewsDAO();
                ArrayList<News> listallnews = null;

                int recordPerPage = 10;
                int page = 1;
                int numberOfPage = 0;

                if (request.getParameter("page") != null) {
                    page = Integer.parseInt(request.getParameter("page").trim());
                }

                listallnews = newsmodeldao.getNewsFromTo((page * recordPerPage) - recordPerPage + 1, page * recordPerPage);
                int numberoffnews = newsmodeldao.countDB();
                double dataSize = (double) numberoffnews;
                numberOfPage = (int) Math.ceil(dataSize / recordPerPage);
                
                //neu ma nguoi dung muon truy cap trang khong co
                if ((request.getParameter("page") != null) && (page <= 0 || page > numberOfPage)) {
                    request.setAttribute("errorstring", "this page is not exist");
                    request.getRequestDispatcher("view/error.jsp").forward(request, response);
                    return;
                    //chuyen qua trang error luon
                    //  response.sendRedirect("error");
                }
                request.setAttribute("numberOfPage", numberOfPage);
                request.setAttribute("currentPage", page);
                request.setAttribute("listallnews", listallnews);
                request.getRequestDispatcher("view/newslist.jsp").forward(request, response);
            } catch (Exception ex) {
                request.setAttribute("errorstring", "this page is not exist");
                request.getRequestDispatcher("view/error.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String username = "";
        if (request.getCookies() != null) {
            Cookie cookie[] = request.getCookies();
            int agecookie = cookie[0].getMaxAge();
            int cookienum = 0;
            while (cookienum < cookie.length) {

                if (cookie[cookienum].getName().equals("username")) {
                    username = cookie[cookienum].getValue();
                }
                cookienum++;
            }
        }
        if (username.equals("anon")) {

            response.sendRedirect("/AVS/inputusername");
        } else {
            try {
                NewsDAO newsmodeldao = new NewsDAO();
                ArrayList<News> listallnews = null;
                int recordPerPage = 10;
                int page = 1;
                int numberOfPage = 0;
                if (request.getParameter("page") != null) {
                    page = Integer.parseInt(request.getParameter("page").trim());
                }
                if (request.getParameter("search") != null) {
                    String search = request.getParameter("search").trim().replaceAll("\\s+", " ");
                    System.out.println("search: " + search);
                    if (!search.equals("")) {
                        request.setAttribute("SearchValue", search);
                        listallnews = newsmodeldao.searchNews((page * recordPerPage) - recordPerPage + 1, page * recordPerPage, search);
                        int numberoffnews = newsmodeldao.countDBresultsearch(search);
                        String numberofsearchresult = "Found " + numberoffnews + " result contain \"" + search + "\"";
                        request.setAttribute("numberofsearchresult", numberofsearchresult);
                        double dataSize = (double) numberoffnews;
                        numberOfPage = (int) Math.ceil(dataSize / recordPerPage);
                    } else {
                        request.setAttribute("searchnoti", "You need to input valid search content!");
                    }
                }
                //neu ma nguoi dung muon truy cap trang khong co
                if ((request.getParameter("page") != null) && (page <= 0 || page > numberOfPage)) {
                    request.setAttribute("errorstring", "Don't have this page");
                    request.getRequestDispatcher("view/error.jsp").forward(request, response);
                    return;
                    //chuyen qua trang error luon
                    //  response.sendRedirect("error");
                }
                request.setAttribute("numberOfPage", numberOfPage);
                request.setAttribute("currentPage", page);
                request.setAttribute("listallnews", listallnews);
                request.getRequestDispatcher("view/newslist.jsp").forward(request, response);              
            } catch (Exception ex) {
                request.setAttribute("errorstring", "Don't have this page");
                request.getRequestDispatcher("view/error.jsp").forward(request, response);
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
