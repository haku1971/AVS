/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.CommentDAO;
import DAO.NewsDAO;
import Model.News;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author quang
 */
@WebServlet(name = "SaveLikeCommentController", urlPatterns = {"/SaveLikeCommentController"})
public class SaveLikeCommentController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            //Comment like
            String usid = request.getParameter("userid");
            double user_id = Double.parseDouble(usid);
            int userid = (int) user_id;

            CommentDAO commentmodel = new CommentDAO();
            NewsDAO newmodeldao = new NewsDAO();
            int newsid = Integer.parseInt(request.getParameter("newsid"));
            News news = newmodeldao.getNewsByID(newsid);
            

            if (news == null || news.getDeleted() == 1) {
                request.setAttribute("errorstring", "This page is no longer available!");
                request.getRequestDispatcher("view/error.jsp").forward(request, response);
                return;
            }
            //check ajax cho save like comment
            if (usid != null && request.getParameter("commentid") != null) {
                int commentid = Integer.parseInt(request.getParameter("commentid"));
                System.out.println("userid" + userid + "commentid" + commentid);
                commentmodel.saveLikeComment(userid, commentid);
            }
            //News like

            NewsDAO newsmodel = new NewsDAO();
            //check ajax cho xoa like cua 1 news
            if (usid != null && request.getParameter("newsid") != null) {
                System.out.println("newsid: " + newsid);
                newsmodel.saveLikeNews(userid, newsid);
            }
        } catch (Exception ex) {
            request.setAttribute("errorstring", "This page is no longer available!");
            request.getRequestDispatcher("view/error.jsp").forward(request, response);
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
