/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Entity.News;
import Model.NewsModel;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
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
        try {
            NewsModel newsmodeldao = new NewsModel();
            ArrayList<News> listallnews = null;
            String s = request.getParameter("search");
            int recordPerPage = 2;
            int page = 1;
            int numberOfPage = 0;

            if (request.getParameter("page") != null) {             
                page = Integer.parseInt(request.getParameter("page"));
            }
            if (request.getParameter("search") != null) {
                String search= request.getParameter("search");
                request.setAttribute("SearchValue", search);
                listallnews = newsmodeldao.searchNews((page * recordPerPage) - recordPerPage + 1, page * recordPerPage, search);
                int numberoffnews = newsmodeldao.countDBresultsearch(search);
                String numberofsearchresult = "Found "+ numberoffnews + " result contain \"" + search + "\"" ;
                request.setAttribute("search", search);
                request.setAttribute("numberofsearchresult", numberofsearchresult);
                double dataSize = (double) numberoffnews;
                numberOfPage = (int) Math.ceil(dataSize / recordPerPage);
            } else {
                listallnews = newsmodeldao.getNewsFromTo((page * recordPerPage) - recordPerPage + 1, page * recordPerPage);
                int numberoffnews = newsmodeldao.countDB();
                double dataSize = (double) numberoffnews;
                numberOfPage = (int) Math.ceil(dataSize / recordPerPage);
            }
            //neu ma nguoi dung muon truy cap trang khong co
            if( page < 0 || page > numberOfPage * recordPerPage ) {
                //chuyen qua trang error luon
            }
            request.setAttribute("numberOfPage", numberOfPage);
            request.setAttribute("currentPage", page);
            request.setAttribute("listallnews", listallnews);
            request.getRequestDispatcher("jsp/newslist.jsp").forward(request, response);
        } catch (Exception ex) {
            System.out.println(ex);
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
        processRequest(request, response);
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
