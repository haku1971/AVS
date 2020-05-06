 /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Jobs;
import Model.User;
import DAO.AuthenticateManagement;
import DAO.JobsDAO;
import DAO.UserDAO;
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
@WebServlet(name = "SignupGoogleController", urlPatterns = {"/inputusername"})
public class SignupGoogleController extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String mail = "";
        String fullname = "";
        String userid = "";
        String username = "";
        if (request.getCookies() != null) {
            Cookie cookie[] = request.getCookies();
            int agecookie = cookie[0].getMaxAge();
            int cookienum = 0;
            while (cookienum < cookie.length) {
                if (cookie[cookienum].getName().equals("userid")) {
                    userid = cookie[cookienum].getValue();
                }
                if (cookie[cookienum].getName().equals("username")) {
                    username = cookie[cookienum].getValue();
                }
                cookienum++;
            }
            if (agecookie == 0) {
                userid = "";
            }
        }
        if (username.equals("anon")) {
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/view/googlesignup.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("/AVS/home");
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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String dob = request.getParameter("birthday");
        String phone = request.getParameter("phone");
        String workplace = request.getParameter("workplace");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        int job = Integer.parseInt(request.getParameter("job"));
        int gender = Integer.parseInt(request.getParameter("gender"));
        AuthenticateManagement authenticateManagement = new AuthenticateManagement();
        AuthenticateManagement.CheckResult result = authenticateManagement.checkUserSignUp(username);
        int success = 1;
        HttpSession session = request.getSession();
        if (result == AuthenticateManagement.CheckResult.USERNAME_LENGTH) {
            session.setAttribute("errorUsername", "Username length is from 6 to 15 characters");
            success = 0;
            

        } else if (result == AuthenticateManagement.CheckResult.INVALID_CHARACTER) {
            session.setAttribute("errorUsername", "Contain invalid character(Valid character:a-z,0-9,(-),(_)");
            success = 0;
            

        } else if (result == AuthenticateManagement.CheckResult.EXIST_USERNAME) {
            session.setAttribute("errorUsername", "Username exist");
            success = 0;
            
        }
        if (!phone.equals("")) {
            if (phone.length() != 10) {
                session.setAttribute("errorPhone", "Phone must be 10 digits");
                success = 0;
                
            } else if (phone.charAt(0) != '0') {
                session.setAttribute("errorPhone", "Phone must start with 0");
                success = 0;
               
            }

        }
        if (success == 0) {
            request.setAttribute("error", "true");
             request.getRequestDispatcher("/view/googlesignup.jsp").forward(request, response);
        } else if (success == 1) {
            try {
                username=username.toLowerCase();
                UserDAO usermod = new UserDAO();
                usermod.insertUser(username, "null", fullname, dob, job, workplace, gender, email, phone);
                User user = usermod.getUserByUsername(username);
                int useridnum=user.getId();
                String userid=Integer.toString(useridnum);
                usermod.setUserRole(useridnum);
                Cookie cookieusername = new Cookie("username", user.getUsername());
                int rolenumber = usermod.getUserRole(user.getId());
                String roleid = Integer.toString(rolenumber);
                Cookie cookieroleid = new Cookie("roleid", roleid);
                Cookie cookieuserid = new Cookie("userid", userid);
                cookieusername.setMaxAge(Integer.MAX_VALUE);
                cookieroleid.setMaxAge(Integer.MAX_VALUE);
                cookieuserid.setMaxAge(Integer.MAX_VALUE);
                response.addCookie(cookieusername);
                response.addCookie(cookieroleid);
                response.addCookie(cookieuserid);
                response.sendRedirect("/AVS/home");

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
