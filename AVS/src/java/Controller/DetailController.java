/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Entity.Algorithm;
import Model.AlgorithmModel;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Asus
 */
@WebServlet(name = "Detail", urlPatterns = {"/Detail"})
public class DetailController extends HttpServlet {

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
        String usernametmp = "";
        if (request.getCookies() != null) {
            Cookie cookie[] = request.getCookies();
            int agecookie = cookie[0].getMaxAge();
            int cookienum = 0;
            while (cookienum < cookie.length) {
                
                if (cookie[cookienum].getName().equals("username")) {
                    usernametmp = cookie[cookienum].getValue();
                }
                cookienum++;
            }
           
        }
            if (usernametmp.equals("anon")) {
                response.sendRedirect("/AVS/inputusername");
            }else{
        try {
                
            HttpSession session = request.getSession();
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            AlgorithmModel dao = new AlgorithmModel();
             ArrayList<Entity.Algorithm> data = dao.getAlgoNameAndCategory();
            request.setAttribute("AllAlgorithm", data);

            ArrayList<Algorithm> list = dao.getAlgoIDList();
            String i = request.getParameter("AlgoID");
            int n = Integer.parseInt(i);
            if (i.equalsIgnoreCase("")) {
                response.sendRedirect("error");
                System.out.println("Empty");
            } else {
                boolean IDExist = false;
                for (Algorithm ID : list) {
                    if (ID.getAlgoID() == n) {
                        IDExist = true;
                    }

                }

                if (!IDExist) {
                    response.sendRedirect("error");
                    System.out.println("NOT ID");
                } else {
                    Algorithm algorithm = dao.getAlgoByID(Integer.parseInt(i));
                    ArrayList<Entity.Algorithm> algorithmbycategory = dao.getAlgoByCategory(algorithm.getCategoryID());
                  
                    request.setAttribute("algorithm", algorithm);
                    request.setAttribute("algorithmbycategory", algorithmbycategory);
                    request.getRequestDispatcher("jsp/Detail.jsp").forward(request, response);
                    //   response.sendRedirect("jsp/Detail.jsp?algorithms="+algobyid+"&AllAlgorithm="+listalgo+"");

                }
            }
        } catch (Exception ex) {
            response.sendRedirect("error");
        }
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
