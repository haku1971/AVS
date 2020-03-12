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
import javax.servlet.http.HttpSession;

/**
 *
 * @author BinhNT
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

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
//        HttpSession session = request.getSession();
//            session.removeAttribute("username");
      RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/jsp/login.jsp");
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
         String username = request.getParameter("username");
        String password = request.getParameter("password");
        UserModel userDao;
        int id=0;
            
//        String result1 = request.getParameter("myField");
//        HashMap<String,String> hm=new HashMap<>();
//        hm=(HashMap)request.getParameter("myField");
//        if (result1!=null) {
//            session.setAttribute("username", result1);
//                response.sendRedirect("/AVS/HomeController");
//        }
        AuthenticateManagement authenticateManagement = new AuthenticateManagement();
        AuthenticateManagement.CheckResult result = authenticateManagement.checkUserAccount(username, password);
        if (result == AuthenticateManagement.CheckResult.USERNAME_LENGTH) {
//                session.setAttribute("username", username);
            request.setAttribute("errorMessage", "Username length if from 6 to 15 chacraters");
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/jsp/login.jsp");
            dispatcher.forward(request, response);

        }else if (result == AuthenticateManagement.CheckResult.INVALID_CHARACTER) {
//                session.setAttribute("username", username);
            request.setAttribute("errorMessage", "Contain invalid character(Valid character:a-z,0-9, underscore, hyphen)");
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/jsp/login.jsp");
            dispatcher.forward(request, response);

        } else if (result == AuthenticateManagement.CheckResult.PASSWORD_SHORT) {
//                session.setAttribute("username", username);
            request.setAttribute("errorMessage", "Password need at least 6 character");
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/jsp/login.jsp");
            dispatcher.forward(request, response);

        } else if (result == AuthenticateManagement.CheckResult.NO_USERNAME) {
            request.setAttribute("errorMessage", "Username is incorrect");
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/jsp/login.jsp");
            dispatcher.forward(request, response);

        } else if (result == AuthenticateManagement.CheckResult.WRONG_PASSWORD) {
            request.setAttribute("errorMessage", "Password is incorrect");
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/jsp/login.jsp");
            dispatcher.forward(request, response);
        } else {
//                session.setAttribute("username", username);
//                Cookie cookie = new Cookie("JSESSIONID", session.getId());
//                response.addCookie(cookie);
            try {
            userDao = new UserModel();
            User user = userDao.getUserByUsername(username);
            id=user.getRolenum();
        } catch (Exception ex) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
        }
            String userid=Integer.toString(id);
            Cookie ck = new Cookie("username", username);
            Cookie ck1 = new Cookie("roleid",userid);
            ck.setMaxAge(Integer.MAX_VALUE);
            response.addCookie(ck);
            response.addCookie(ck1);
            response.sendRedirect("/AVS/HomeController");
        }

//        }
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
