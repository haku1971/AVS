/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Entity.User;
import Model.AuthenticateManagement;
import Model.UserModel;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author BinhNT
 */
@WebServlet(name = "ChangePassController", urlPatterns = {"/changepass"})
public class ChangePassController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/jsp/changepass.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String oldpassword = request.getParameter("oldpassword");
        String newpassword = request.getParameter("newpassword");
        String repassword = request.getParameter("repassword");
        String userid = "";
        Cookie cookie[] = request.getCookies();
        int cookienum = 0;
        while (cookienum < cookie.length) {
            if (cookie[cookienum].getName().equals("userid")) {
                userid = cookie[cookienum].getValue();
            }

            cookienum++;
        }
        User user = new User();
        UserModel usermod;
        int useridnum=0;
        try {
            usermod = new UserModel();
            user = usermod.getUserByUserID(userid);
        } catch (Exception ex) {
        }
        AuthenticateManagement authenticateManagement = new AuthenticateManagement();
        AuthenticateManagement.CheckResult checkpass = authenticateManagement.checkPassword(oldpassword, newpassword);
        AuthenticateManagement.CheckResult passresult = authenticateManagement.checkPassword(newpassword, repassword);
        int success = 1;
        if (!oldpassword.equals(user.getPassword())) {
            request.setAttribute("errorOldPass", "Password is not correct");
            success = 0;

        }else if (checkpass==AuthenticateManagement.CheckResult.SUCCESS) {
            request.setAttribute("errorNewPass", "OldPassword and NewPassword must different");
            success = 0;
        }else if (passresult == AuthenticateManagement.CheckResult.PASSWORD_SHORT) {
            request.setAttribute("errorNewPass", "Password need at least 6 character");
            success = 0;
        }else if (passresult == AuthenticateManagement.CheckResult.NOT_MATCH) {
            request.setAttribute("errorRePass", "Repassword is not correct ");
            success = 0;

        }
        if (success == 0) {
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/jsp/changepass.jsp");
            dispatcher.forward(request, response);
        }else if (success==1) {
            try {
                usermod = new UserModel();
                useridnum = Integer.parseInt(userid);
                usermod.UpdatePassword(useridnum, newpassword);
                request.setAttribute("success", "Change password successfullly ");
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/jsp/changepass.jsp");
            dispatcher.forward(request, response);
            } catch (Exception ex) {
                Logger.getLogger(ChangePassController.class.getName()).log(Level.SEVERE, null, ex);
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
