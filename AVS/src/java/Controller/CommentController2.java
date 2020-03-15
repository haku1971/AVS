/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Entity.Comment;
import Entity.News;
import Model.CommentModel;
import Model.NewModel;
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
public class CommentController2 extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            int newsid = 0;
            //get user đang ở session hoặc cookies này
            int commentid = Integer.parseInt(request.getParameter("commentid"));
            if (request.getParameter("newsid") != null) {
                try {
                    //ep kieu no ve int da
                    newsid = Integer.parseInt(request.getParameter("newsid"));
                } catch (NumberFormatException ex) {
                    //neu fail thi vut ve trang thong bao la ko co id nao nhu the nay   
                }
            } else {
                newsid = 1;
            }
            NewModel newmodeldao = new NewModel();
            CommentModel commentmodel = new CommentModel();

            News news = newmodeldao.getNewByNewsID(newsid);
            ArrayList<Comment> listallcommentbynewid = commentmodel.getAllCommentByNewsID(newsid);
            
            request.setAttribute("news", news);
            request.setAttribute("commentid", commentid);
            request.setAttribute("newsid", newsid);
            request.setAttribute("listallcommentbynewid", listallcommentbynewid);
            request.getRequestDispatcher("jsp/newsdetail2.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(CommentController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
