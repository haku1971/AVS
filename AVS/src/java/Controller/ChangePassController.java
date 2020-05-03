/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.User;
import DAO.AuthenticateManagement;
import DAO.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Base64;
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
        HttpSession session = request.getSession();
        String username = "";
        String userid = "";
        if (request.getCookies() != null) {
            Cookie cookie[] = request.getCookies();
            int agecookie = cookie[0].getMaxAge();
            int cookienum = 0;
            while (cookienum < cookie.length) {
                if (cookie[cookienum].getName().equals("username")) {
                    username = cookie[cookienum].getValue();
                }
                if (cookie[cookienum].getName().equals("userid")) {
                    userid = cookie[cookienum].getValue();
                }
                cookienum++;
            }
            if (agecookie == 0) {
                username = "";
            }
            if (username.equals("")) {
                PrintWriter out = response.getWriter();
                response.setContentType("text/html");
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Account was logged out');");
                out.println("</script>");
                response.setHeader("Refresh", "1;url=/AVS/home");
            } else if (username.equals("anon")) {
                response.sendRedirect("/AVS/inputusername");
            } else {
                User user = new User();
                UserDAO usermod;
                try {

                    usermod = new UserDAO();
                    user = usermod.getUserByUserID(userid);

                } catch (Exception ex) {
                }
                if (user.getPassword().equals("null")) {
                    session.setAttribute("googleacc", "true");
                    response.sendRedirect("/AVS/userinfo");
                }else{
                session.setAttribute("userid", userid);
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/view/changepass.jsp");
                dispatcher.forward(request, response);}

            }
        }
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
        HttpSession session = request.getSession();
        String username = "";
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
        if (username.equals("anon")) {
            PrintWriter out = response.getWriter();
            response.setContentType("text/html");
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Another Account was logged in');");
            out.println("</script>");
            response.setHeader("Refresh", "1;url=/AVS/inputusername");
        } else {
            User user = new User();
            UserDAO usermod;
            int useridnum = 0;
            String currentuserid = (String) session.getAttribute("userid");
            if (currentuserid.equals(userid)) {
                try {

                    usermod = new UserDAO();
                    user = usermod.getUserByUserID(userid);
                } catch (Exception ex) {
                }
                AuthenticateManagement authenticateManagement = new AuthenticateManagement();
                AuthenticateManagement.CheckResult checkpass = authenticateManagement.checkPassword(oldpassword, newpassword);
                AuthenticateManagement.CheckResult passresult = authenticateManagement.checkPassword(newpassword, repassword);
                int success = 1;
                String oldpasswordencode = Base64.getEncoder().encodeToString(oldpassword.getBytes());
                if (!oldpasswordencode.equals(user.getPassword())) {
                    request.setAttribute("errorOldPass", "Password is not correct");
                    success = 0;

                } else if (checkpass == AuthenticateManagement.CheckResult.SUCCESS) {
                    request.setAttribute("errorNewPass", "OldPassword and NewPassword must different");
                    success = 0;
                } else if (passresult == AuthenticateManagement.CheckResult.PASSWORD_SHORT) {
                    request.setAttribute("errorNewPass", "Password need at least 6 character");
                    success = 0;
                } else if (passresult == AuthenticateManagement.CheckResult.NOT_MATCH) {
                    request.setAttribute("errorRePass", "Repassword is not correct ");
                    success = 0;

                }
                if (success == 0) {
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/view/changepass.jsp");
                    dispatcher.forward(request, response);
                } else if (success == 1) {
                    try {
                        usermod = new UserDAO();
                        useridnum = Integer.parseInt(userid);
                        newpassword = Base64.getEncoder().encodeToString(newpassword.getBytes());
                        usermod.UpdatePassword(useridnum, newpassword);
                        request.setAttribute("success", "Change password successfullly ");
                        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/view/changepass.jsp");
                        dispatcher.forward(request, response);
                    } catch (Exception ex) {
                        Logger.getLogger(ChangePassController.class.getName()).log(Level.SEVERE, null, ex);
                    }

                }
            } else {
                PrintWriter out = response.getWriter();
                response.setContentType("text/html");
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Account was logged out');");
                out.println("</script>");
                response.setHeader("Refresh", "1;url=/AVS/home");
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
