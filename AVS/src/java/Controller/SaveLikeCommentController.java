/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.CommentModel;
import Model.NewsModel;
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

            CommentModel commentmodel = new CommentModel();
            //check ajax cho save like comment
            if (usid != null && request.getParameter("commentid") != null) {
                int commentid = Integer.parseInt(request.getParameter("commentid"));
                System.out.println("userid" + userid + "commentid" + commentid);
                commentmodel.saveLikeComment(userid, commentid);
            }
            //News like

            NewsModel newsmodel = new NewsModel();
            //check ajax cho xoa like cua 1 news
            if (usid != null && request.getParameter("newsid") != null) {
                int newsid = Integer.parseInt(request.getParameter("newsid"));
                System.out.println("newsid: " + newsid);
                newsmodel.saveLikeNews(userid, newsid);
            }
        } catch (Exception ex) {
            Logger.getLogger(SaveLikeCommentController.class.getName()).log(Level.SEVERE, null, ex);
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
