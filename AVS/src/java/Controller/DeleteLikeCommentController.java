/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.CommentModel;
import Model.NewsModel;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "DeleteLikeCommentController", urlPatterns = {"/DeleteLikeCommentController"})
public class DeleteLikeCommentController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       try {

            CommentModel commentmodel = new CommentModel();
            //check ajax cho xoa like cua 1 comment
            if (request.getParameter("commentid") != null&& request.getParameter("userid") != null) {
                int userid= Integer.parseInt(request.getParameter("userid"));
                int commentid = Integer.parseInt(request.getParameter("commentid"));
                System.out.println("commentid" + commentid);
                commentmodel.deleteLikeComment(commentid,userid);
            }

            NewsModel newsmodel = new NewsModel();
            //check ajax cho xoa like cua 1 news
            if (request.getParameter("newsid") != null && request.getParameter("userid") != null) {
                int userid= Integer.parseInt(request.getParameter("userid"));
                int newsid = Integer.parseInt(request.getParameter("newsid"));
                System.out.println("newsid " + newsid +"and userid: "+ userid);
                newsmodel.deleteLikeNewsByNewsId(newsid,userid);
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
