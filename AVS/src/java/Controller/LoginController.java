/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Entity.User;
import Model.AuthenticateManagement;
import Model.IdTokenVerifierAndParser;
import Model.UserModel;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
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
@WebServlet(name = "LoginController", urlPatterns = {"/login"})
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
           response.sendRedirect("/AVS/inputusername");
            } else if (!userid.equals("")) {
                response.sendRedirect("/AVS/HomeController");
            } else {
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/jsp/login.jsp");
                dispatcher.forward(request, response);
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
String username = request.getParameter("username");
        String password = request.getParameter("password"); //ví dụ đây là mật khẩu ô get về từ người dùng nhập
        UserModel userDao;
        int rolenumber = 0;
        int id = 0;
        //trc khi lưu vào db thì gọi câu bên dưới
        
        if (request.getParameter("login") != null) {

            AuthenticateManagement authenticateManagement = new AuthenticateManagement();
            AuthenticateManagement.CheckResult result = authenticateManagement.checkUserAccount(username, password);
            if (result == AuthenticateManagement.CheckResult.USERNAME_LENGTH) {
                request.setAttribute("errorMessage", "Username length if from 6 to 15 chacraters");
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/jsp/login.jsp");
                dispatcher.forward(request, response);

            } else if (result == AuthenticateManagement.CheckResult.INVALID_CHARACTER) {
                request.setAttribute("errorMessage", "Contain invalid character(Valid character:a-z,0-9, underscore, hyphen)");
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/jsp/login.jsp");
                dispatcher.forward(request, response);

            } else if (result == AuthenticateManagement.CheckResult.PASSWORD_SHORT) {
                request.setAttribute("errorMessage", "Password need at least 6 character");
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/jsp/login.jsp");
                dispatcher.forward(request, response);

            } else if (result == AuthenticateManagement.CheckResult.NO_USERNAME) {
                request.setAttribute("errorMessage", "Username is not exist");
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/jsp/login.jsp");
                dispatcher.forward(request, response);

            } else if (result == AuthenticateManagement.CheckResult.WRONG_PASSWORD) {
                request.setAttribute("errorMessage", "Password is incorrect");
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/jsp/login.jsp");
                dispatcher.forward(request, response);
            } else {

                try {
                    userDao = new UserModel();
                    User user = userDao.getUserByUsername(username);
                    rolenumber = userDao.getUserRole(user.getId());
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
            }
        } else {
            try {

                String idToken = request.getParameter("id_token");
                GoogleIdToken.Payload payLoad = IdTokenVerifierAndParser.getPayload(idToken);
                String name = (String) payLoad.get("name");
                String email = payLoad.getEmail();
                response.setContentType("text/html;charset=UTF-8");
//        try (PrintWriter out = response.getWriter()) {
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet NewServlet</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet NewServlet at " + idToken+name + email+ "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }

                AuthenticateManagement authenticateManagement = new AuthenticateManagement();
                AuthenticateManagement.CheckResult mailresult = authenticateManagement.checkMail(email);
                userDao = new UserModel();
                if (mailresult == AuthenticateManagement.CheckResult.EXIST_MAIL) {
                    User user = userDao.getUserByMail(email);

                    Cookie cookieusername = new Cookie("username", user.getUsername());
                    rolenumber = user.getRolenum();
                    id = user.getId();
                    String roleid = Integer.toString(rolenumber);
                    String userid = Integer.toString(id);
                    Cookie cookieroleid = new Cookie("roleid", roleid);
                    Cookie cookieuserid = new Cookie("userid", userid);
                    cookieusername.setMaxAge(Integer.MAX_VALUE);
                    cookieroleid.setMaxAge(Integer.MAX_VALUE);
                    cookieuserid.setMaxAge(Integer.MAX_VALUE);
                    response.addCookie(cookieusername);
                    response.addCookie(cookieroleid);
                    response.addCookie(cookieuserid);
                    if (user.getUsername().equals("anon")) {
                        response.sendRedirect("/AVS/inputusername");
                    } else {
                        response.sendRedirect("/AVS/HomeController");
                    }
                } else {
                    Cookie cookieusername = new Cookie("username", "anon");
                    Cookie cookieemail = new Cookie("email", email);
//                    name.replaceAll("\\s+","");
//                    Cookie cookiefullname = new Cookie("fullname", name);
                    cookieusername.setMaxAge(Integer.MAX_VALUE);
                    cookieemail.setMaxAge(Integer.MAX_VALUE);
//                    cookiefullname.setMaxAge(Integer.MAX_VALUE);
                    response.addCookie(cookieusername);
                    response.addCookie(cookieemail);
//                    response.addCookie(cookiefullname);
                    response.sendRedirect("/AVS/inputusername");
//                    response.sendRedirect("/AVS/HomeController");
                }

            } catch (Exception e) {
                throw new RuntimeException(e);
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
