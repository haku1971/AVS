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
import Model.UserModel;
import java.io.IOException;
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
public class CommentController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            int newsid = Integer.parseInt(request.getParameter("newsid"));

            NewModel newmodeldao = new NewModel();
            CommentModel commentmodel = new CommentModel();
            News news = newmodeldao.getNewByNewsID(newsid);
            ArrayList<Comment> listallcommentbynewid = commentmodel.getAllCommentByNewsID(newsid);
            request.setAttribute("news", news);
            request.setAttribute("listallcommentbynewid", listallcommentbynewid);
            request.getRequestDispatcher("jsp/newsdetail.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(CommentController.class.getName()).log(Level.SEVERE, null, ex);
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
        try {
            response.setContentType("text/html;charset=UTF-8");
            CommentModel commentmodel = new CommentModel();
            String id = request.getParameter("newsid");

            double newid = Double.parseDouble(id);
            int newsid = (int) newid;
            String commentcontentedit = request.getParameter("commentcontentedit");

            String comment = "";
            String strdate = "";

            //tao ra comment
            String posttodb = request.getParameter("postodb");
            if (posttodb != null) {
                comment = request.getParameter("commentcontent");
                strdate = request.getParameter("strdate");
                commentmodel.saveCommenttoDB(comment, strdate, 1, newsid);
               response.sendRedirect("CommentController?newsid=" + newsid);

            }
            String btndelete = request.getParameter("Delete");
            String btnedit = request.getParameter("save");
            String btncancel = request.getParameter("cancel");

            int commentid = 0;
            if (btndelete != null) {
                commentid = Integer.parseInt(request.getParameter("commentid"));
                commentmodel.deleteCommentById(commentid);
                response.sendRedirect("CommentController?newsid=" + newsid);
            } else if (btnedit != null) {
                //code update db
                commentid = Integer.parseInt(request.getParameter("commentid"));
                commentmodel.editCommentById(commentcontentedit, commentid);
                response.sendRedirect("CommentController?newsid=" + newsid);
            } else if (btncancel != null) {
                response.sendRedirect("CommentController?newsid=" + newsid);
            }

        } catch (Exception ex) {
            Logger.getLogger(CommentController.class.getName()).log(Level.SEVERE, null, ex);
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
