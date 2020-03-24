/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Entity.User;
import Model.AlgorithmModel;
import Model.HistoryModel;
import Model.UserModel;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Ukah
 */
@WebServlet(name = "ManageDatabase", urlPatterns = {"/manage"})
public class ManageDatabaseController extends HttpServlet {

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
        try {
            UserModel userdao = new UserModel();
            HistoryModel historydao = new HistoryModel();
            //hien thi trang home neu nguoi dung khong phai admin
            Cookie cookie[] = request.getCookies();
            String roleid = "";
            String adminid = "";
            for (Cookie ck : cookie) {
                if (ck.getName().equals("roleid")) {
                    roleid = ck.getValue();
                }
                if (ck.getName().equals("userid")) {
                    adminid = ck.getValue();
//                    System.out.println("adminid: " + adminid);
                }
            }
            int adminrolenumber = 1;
            if (roleid == null || Integer.parseInt(roleid) != adminrolenumber) {
                response.sendRedirect("home");
                return;
            }
            //ket thuc kiem tra            
            String managetype = request.getParameter("managetype");
            switch (managetype) {
                case "manageaccount": {
                    String userid = request.getParameter("userid");
                    String ban = request.getParameter("ban");
                    String currenttime = java.time.LocalDate.now().toString() + " " + java.time.LocalTime.now().toString() ;

                    if (ban.equals("ban")) {
//                System.out.println(ban + " success");
                        userdao.banUserID(Integer.parseInt(userid));
                        historydao.insertUserHistory(Integer.parseInt(userid), Integer.parseInt(adminid), currenttime, 1);

                    } else if (ban.equals("unban")) {
//                System.out.println(ban + " success");
                        userdao.unbanUserID(Integer.parseInt(userid));
                        historydao.insertUserHistory(Integer.parseInt(userid), Integer.parseInt(adminid), currenttime, 0);
                    }
                    User user = userdao.getUserByUserID(userid);
                    String category = "account";
                    request.setAttribute("category", category);
                    request.setAttribute("user", user);
                    response.sendRedirect("admin?category=account");
                    break;
                }
                case "addalgo": {
                    String algoname = request.getParameter("algoname");
                    String codejava = request.getParameter("codejava");
                    String codecpp = request.getParameter("codecpp");
                    String codejs = request.getParameter("codejs");
                    String codevisual = request.getParameter("codevisual");
                    String description = request.getParameter("description");
                    String categoryid = request.getParameter("category");
                    String currenttime = java.time.LocalDate.now().toString() + " " + java.time.LocalTime.now().toString() ;
                    String resource = request.getParameter("resource");
                    
                    
                    AlgorithmModel algodao = new AlgorithmModel();
                    algodao.insertAlgo(algoname, codejava, codecpp, codejs, codevisual, description, categoryid, currenttime, resource, "null");
//                    System.out.println("add");
                    int lastalgoid = algodao.getLastRecord().getAlgoID();
                    historydao.insertAlgoHistory(Integer.parseInt(adminid), lastalgoid, currenttime, "Add");
                    
                    response.sendRedirect("admin?category=algorithm");
                    break;
                }
                case "editalgo": {
                    String algoid = request.getParameter("algoid");
                    String algoname = request.getParameter("algoname");
                    String codejava = request.getParameter("codejava");
                    String codecpp = request.getParameter("codecpp");
                    String codejs = request.getParameter("codejs");
                    String codevisual = request.getParameter("codevisual");
                    String description = request.getParameter("description");
                    String categoryid = request.getParameter("category");
                    String currenttime = java.time.LocalDate.now().toString() + " " + java.time.LocalTime.now().toString() ;
                    String resource = request.getParameter("resource");
                    
                    codejava = codejava.replaceAll("â", "&emsp;");
                    codecpp = codecpp.replaceAll("â", "&emsp;");
                    codejs = codejs.replaceAll("â", "&emsp;");
                    codevisual = codevisual.replaceAll("â", "&emsp;");
                    
                    AlgorithmModel algodao = new AlgorithmModel();
                    algodao.updateAlgo(algoname, codejava, codecpp, codejs, codevisual, description, categoryid, currenttime, resource, Integer.parseInt(algoid));
                    historydao.insertAlgoHistory(Integer.parseInt(adminid), Integer.parseInt(algoid), currenttime, "Edit");
                    
                    response.sendRedirect("viewalgo?id=" + algoid);
                    break;
                }
                case "deletealgo": {
                    String algoid = request.getParameter("algoid");
                    String currenttime = java.time.LocalDate.now().toString() + " " + java.time.LocalTime.now().toString() ;
                    System.out.println(algoid);
                    
                    AlgorithmModel algodao = new AlgorithmModel();
                    algodao.deleteAlgo(Integer.parseInt(algoid));
                    
                    historydao.insertAlgoHistory(Integer.parseInt(adminid), Integer.parseInt(algoid), currenttime, "Delete");
                    response.sendRedirect("admin?category=algorithm");
                    break;
                }
                case "restorealgo": {
                    String algoid = request.getParameter("algoid");
                    String currenttime = java.time.LocalDate.now().toString() + " " + java.time.LocalTime.now().toString() ;
                    System.out.println(algoid);
                    
                    AlgorithmModel algodao = new AlgorithmModel();
                    algodao.restoreAlgo(Integer.parseInt(algoid));
                    
                    historydao.insertAlgoHistory(Integer.parseInt(adminid), Integer.parseInt(algoid), currenttime, "Restore");
                    response.sendRedirect("admin?category=algorithm");
                    break;
                }
                case "addnews": {
                    
                    break;
                }
                case "editnews": {
                    
                    break;
                }
                case "deletenews": {
                    
                    break;
                }
            }

        } catch (Exception ex) {
            response.sendRedirect("error");
        }
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
        processRequest(request, response);
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
