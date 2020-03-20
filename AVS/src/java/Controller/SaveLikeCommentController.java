/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.CommentModel;
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
            String usid= request.getParameter("userid");
            String cmtid= request.getParameter("commentid");
            double userid = Double.parseDouble(usid);
            int id= (int)userid;
            int commentid = Integer.parseInt(cmtid);
            System.out.println("userid"+ id + "commentid" + commentid);
            CommentModel commentmodel= new CommentModel();
            commentmodel.saveLikeComment(id, commentid);
            
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
