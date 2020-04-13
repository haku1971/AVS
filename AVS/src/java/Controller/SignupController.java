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
@WebServlet(name = "SignupController", urlPatterns = {"/SignupController"})
public class SignupController extends HttpServlet {

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
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/jsp/signup.jsp");
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
        processRequest(request, response);
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String mail = request.getParameter("email");
        String birthday = request.getParameter("birthday");
        String phone = request.getParameter("phone");
        String workplace = request.getParameter("workplace");
        String fullname = request.getParameter("fullname");
        int job = Integer.parseInt(request.getParameter("job"));
        int gender = Integer.parseInt(request.getParameter("gender"));
        String repassword = request.getParameter("repassword");
        UserModel userDao;
        int id = 0;
        int rolenumber = 0;
        AuthenticateManagement authenticateManagement = new AuthenticateManagement();
        AuthenticateManagement.CheckResult result = authenticateManagement.checkUserSignUp(username);
        AuthenticateManagement.CheckResult passresult = authenticateManagement.checkPassword(password, repassword);
        AuthenticateManagement.CheckResult phoneresult = authenticateManagement.checkNumber(phone);
        AuthenticateManagement.CheckResult mailresult = authenticateManagement.checkMail(mail);
        int success = 1;
        if (result == AuthenticateManagement.CheckResult.USERNAME_LENGTH) {
            request.setAttribute("errorUsername", "Username length is from 6 to 15 characters");
            success = 0;

        } else if (result == AuthenticateManagement.CheckResult.INVALID_CHARACTER) {
            request.setAttribute("errorUsername", "Contain invalid character(Valid character:a-z,0-9,(-),(_)");
            success = 0;

        } else if (result == AuthenticateManagement.CheckResult.EXIST_USERNAME) {
            request.setAttribute("errorUsername", "Username exist");
            success = 0;
        }
        if (passresult == AuthenticateManagement.CheckResult.PASSWORD_SHORT) {
            request.setAttribute("errorPass", "Password need at least 6 character");
            success = 0;
        }
        if (passresult == AuthenticateManagement.CheckResult.NOT_MATCH) {
            request.setAttribute("errorRepass", "Repassword is not correct ");
            success = 0;

        }

        if (mailresult == AuthenticateManagement.CheckResult.WRONG_FORMAT) {
            request.setAttribute("errorMail", "E-mail format is xyz@qwe.abc.com");
            success = 0;
        }else if(mailresult == AuthenticateManagement.CheckResult.EXIST_MAIL){
            request.setAttribute("errorMail", "E-mail is used ");
            success = 0;
        }
        
        if (phoneresult == AuthenticateManagement.CheckResult.NOT_NUMBER && !phone.equals("")) {
            request.setAttribute("errorPhone", "Phone must be numbers ");
            success = 0;
        }else if (phone.length()>10) {
            request.setAttribute("errorPhone", "Phone must less than 11 digits");
            success = 0;
        }else if (!phone.equals("")) {
            if (phone.charAt(0)!='0') {
                request.setAttribute("errorPhone", "Phone must start with 0");
            success = 0;
            }
            
        }
        if (success == 0) {
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/jsp/signup.jsp");
            dispatcher.forward(request, response);
        } else if (success == 1) {
            
            try {
                UserModel usermod = new UserModel();
                usermod.insertUser(username, password, fullname, birthday, job,
                        workplace, gender, mail, phone);
                try {
                    userDao = new UserModel();
                    User user = userDao.getUserByUsername(username);
                    rolenumber = user.getRolenum();
                    id = user.getId();
                } catch (Exception ex) {
                    Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
                }
                String roleid = Integer.toString(rolenumber);
                String userid = Integer.toString(id);
                Cookie cookieusername = new Cookie("username", username);
                Cookie cookieroleid = new Cookie("roleid", roleid);
                Cookie cookieuserid = new Cookie("userid", userid);
                cookieusername.setMaxAge(Integer.MAX_VALUE);
                cookieroleid.setMaxAge(Integer.MAX_VALUE);
                cookieuserid.setMaxAge(Integer.MAX_VALUE);
                response.addCookie(cookieusername);
                response.addCookie(cookieroleid);
                response.addCookie(cookieuserid);
                response.sendRedirect("/AVS/HomeController");
            } catch (Exception ex) {
                Logger.getLogger(SignupController.class.getName()).log(Level.SEVERE, null, ex);
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
